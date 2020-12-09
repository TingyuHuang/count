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
      show-expand
    >
    <template v-slot:expanded-item="{ headers, item }">
      <td :colspan="headers.length" class="pa-0">
        <v-list dense>
          <v-subheader>Same size files</v-subheader>
          <v-list-item
            v-for="(files, size) in item.sizeOf"
            :key="item.name + size"
          >
            <v-list-item-content>
              <v-list-item-title>
                {{ size }} bytes:
                <v-chip-group
                 column
                >
                  <v-chip
                    v-for="file in files"
                    :key="file"
                    class="ma-1"
                  >
                    {{ file }}
                  </v-chip>
                </v-chip-group>
              </v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </v-list>
      </td>
    </template>
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
        sortable: false,
        value: 'name',
      }, {
        text: 'Count',
        value: 'count',
      }, {
        text: 'Same Size Count',
        value: 'sameSizeCount',
      }, {
        text: '',
        value: 'data-table-expand',
      }],
      files: [],
      patterns: [],
    }),

    methods: {
      handleFileChange(files) {
        let patternOf = {'*unhandled*': {count: 0, sizeOf: {}}}
        let re = /^.*-([\w]*)(?:-[\W]+)?\.tst$/

        this.loading = true
        this.patterns = []

        for (let file of files) {
          let m = re.exec(file.name)
          let name = ''

          if (m === null || m.length != 2) {
            name = '*unhandled*'
          } else {
            name = m[1]
          }

          if (patternOf[name] === undefined) {
            patternOf[name] = {count: 1, sizeOf: {}}
          } else {
            patternOf[name].count += 1
          }
          if (patternOf[name].sizeOf[file.size] === undefined) {
            patternOf[name].sizeOf[file.size] = []
          }
          patternOf[name].sizeOf[file.size].push(file.name)
        }

        for (let name of Object.keys(patternOf)) {
          let pattern = {
            ...patternOf[name],
            name: name,
            sameSizeCount: 0,
          }

          for (let size of Object.keys(pattern.sizeOf)) {
            if (pattern.sizeOf[size].length === 1) {
              delete pattern.sizeOf[size]
            } else {
              pattern.sameSizeCount += 1
            }
          }

          this.patterns.push(pattern)
        }

        this.loading = false
      },
    },
  }
</script>
