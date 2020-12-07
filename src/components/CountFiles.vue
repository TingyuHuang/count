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

    <v-simple-table>
      <template v-slot:default>
      <thead>
        <tr>
          <th class="text-left">
            Name
          </th>
          <th class="text-left">
            Count
          </th>
        </tr>
      </thead>
      <tbody>
        <tr
          v-for="(count, pattern) in patterns"
          :key="pattern"
        >
          <td>{{ pattern }}</td>
          <td>{{ count }}</td>
        </tr>
      </tbody>
    </template>
    </v-simple-table>
  </v-container>
</template>

<script>
  export default {
    name: 'CountFiles',

    data: () => ({
      files: [],
      patterns: {},
    }),

    methods: {
      handleFileChange(files) {
        this.patterns = {}

        let re = /.*-([\w]*)\.tst/
        for (let file of files) {
          let m = re.exec(file.name)

          if (m.length != 2) {
            console.log('Unable to handle file:', file.name)
            return
          }

          let pattern = m[1]
          if (this.patterns[pattern] === undefined) {
            this.patterns[pattern] = 0
          }
          this.patterns[pattern] += 1
        }
      },
    },
  }
</script>
