<template>
  <v-app>
    <v-main>
      <CountFiles/>
    </v-main>
  </v-app>
</template>

<script>
import CountFiles from './components/CountFiles';

export default {
  name: 'App',

  components: {
    CountFiles,
  },

  data: () => ({}),
};
</script>
