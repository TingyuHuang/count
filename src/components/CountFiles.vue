<template>
  <v-container>
    <v-file-input
      show-size
      counter
      multiple
      @change="handleFileChange"
      accept=".tst"
      v-model="files"
      label="Choose .tst files"
    ></v-file-input>

    <v-data-table
      :headers="headers"
      :items="patterns"
      item-key="name"
      :loading="loading"
      :sort-by="['count']"
      :sort-desc="[true]"
      hide-default-footer
    >
    </v-data-table>
  </v-container>
</template>

<script>
  export default {
    name: 'CountFiles',

    data: () => ({
      loading: false,
      headers: [{
        text: 'Name',
        align: 'start',
        sortable: false,
        value: 'name',
      }, {
        text: 'Count',
        align: 'start',
        sortable: true,
        value: 'count',
      }],
      files: [],
      patterns: [],
    }),

    methods: {
      handleFileChange(files) {
        let countOf = {}
        let re = /.*-([^-]*)\.tst/

        this.loading = true
        this.patterns = []

        for (let file of files) {
          let m = re.exec(file.name)

          if (m.length != 2) {
            console.log('Unable to handle file:', file.name)
            continue
          }

          let pattern = m[1]
          if (countOf[pattern] === undefined) {
            countOf[pattern] = 0
          }
          countOf[pattern] += 1
        }

        for (let pattern of Object.keys(countOf)) {
          this.patterns.push({name: pattern, count: countOf[pattern]})
        }

        this.loading = false
      },
    },
  }
</script>
