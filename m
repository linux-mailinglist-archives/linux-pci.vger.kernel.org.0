Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6C2473362
	for <lists+linux-pci@lfdr.de>; Mon, 13 Dec 2021 18:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241472AbhLMR7b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Dec 2021 12:59:31 -0500
Received: from mga06.intel.com ([134.134.136.31]:33554 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241395AbhLMR72 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Dec 2021 12:59:28 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="299571862"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="299571862"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 09:59:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="464731996"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 13 Dec 2021 09:59:26 -0800
Received: from debox1-desk4.intel.com (unknown [10.212.243.203])
        by linux.intel.com (Postfix) with ESMTP id 2ED74580C95;
        Mon, 13 Dec 2021 09:59:26 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     lee.jones@linaro.org, hdegoede@redhat.com,
        david.e.box@linux.intel.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V3 5/6] tools arch x86: Add Intel SDSi provisioning tool
Date:   Mon, 13 Dec 2021 09:59:20 -0800
Message-Id: <20211213175921.1897860-6-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213175921.1897860-1-david.e.box@linux.intel.com>
References: <20211213175921.1897860-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add tool for key certificate and activation payload provisioning on
Intel CPUs supporting Software Defined Silicon (SDSi).

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
V3
  - Move from samples to tools.
  - Fix bit fields in availability structure
  - Check provisioning availability before issuing command

V2
  - New patch
 MAINTAINERS                        |   1 +
 tools/arch/x86/intel_sdsi/Makefile |   9 +
 tools/arch/x86/intel_sdsi/sdsi.c   | 540 +++++++++++++++++++++++++++++
 3 files changed, 550 insertions(+)
 create mode 100644 tools/arch/x86/intel_sdsi/Makefile
 create mode 100644 tools/arch/x86/intel_sdsi/sdsi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index af7f17e7400f..500b49e6958a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9787,6 +9787,7 @@ INTEL SDSI DRIVER
 M:	David E. Box <david.e.box@linux.intel.com>
 S:	Supported
 F:	drivers/platform/x86/intel/sdsi.c
+F:	tools/arch/x86/intel_sdsi/
 
 INTEL SKYLAKE INT3472 ACPI DEVICE DRIVER
 M:	Daniel Scally <djrscally@gmail.com>
diff --git a/tools/arch/x86/intel_sdsi/Makefile b/tools/arch/x86/intel_sdsi/Makefile
new file mode 100644
index 000000000000..1c2d102ff8fb
--- /dev/null
+++ b/tools/arch/x86/intel_sdsi/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+
+.PHONY: sdsi
+
+sdsi: sdsi.o
+	$(CC) -Wall $^ -o $@
+
+clean:
+	rm *.o sdsi
diff --git a/tools/arch/x86/intel_sdsi/sdsi.c b/tools/arch/x86/intel_sdsi/sdsi.c
new file mode 100644
index 000000000000..fda4d3c35d1b
--- /dev/null
+++ b/tools/arch/x86/intel_sdsi/sdsi.c
@@ -0,0 +1,540 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * sdsi: Intel Software Defined Silicon tool for provisioning certificates
+ * and activation payloads on supported cpus.
+ *
+ * See https://github.com/intel/intel-sdsi/blob/master/os-interface.rst
+ * for register descriptions.
+ *
+ * Copyright (C) 2021 Intel Corporation. All rights reserved.
+ */
+
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <sys/types.h>
+
+#define SDSI_DEV		"intel_vsec.sdsi"
+#define AUX_DEV_PATH		"/sys/bus/auxiliary/devices/"
+#define SDSI_PATH		(AUX_DEV_DIR SDSI_DEV)
+#define GUID			0x6dd191
+#define REGISTERS_MIN_SIZE	72
+
+#define __round_mask(x, y) ((__typeof__(x))((y) - 1))
+#define round_up(x, y) ((((x) - 1) | __round_mask(x, y)) + 1)
+
+struct enabled_features {
+	uint64_t reserved:3;
+	uint64_t sdsi:1;
+	uint64_t reserved1:60;
+};
+
+struct auth_fail_count {
+	uint64_t key_failure_count:3;
+	uint64_t key_failure_threshold:3;
+	uint64_t auth_failure_count:3;
+	uint64_t auth_failure_threshold:3;
+	uint64_t reserved:52;
+};
+
+struct availability {
+	uint64_t reserved:48;
+	uint64_t available:3;
+	uint64_t threshold:3;
+};
+
+struct sdsi_regs {
+	uint64_t ppin;
+	uint64_t reserved;
+	struct enabled_features en_features;
+	uint64_t reserved1;
+	struct auth_fail_count auth_fail_count;
+	struct availability prov_avail;
+	uint64_t reserved2;
+	uint64_t reserved3;
+	uint64_t socket_id;
+};
+
+struct sdsi_dev {
+	struct sdsi_regs regs;
+	char *dev_name;
+	char *dev_path;
+	int guid;
+};
+
+enum command {
+	CMD_NONE,
+	CMD_LIST_DEVICES,
+	CMD_SOCKET_INFO,
+	CMD_DUMP_CERT,
+	CMD_PROV_AKC,
+	CMD_PROV_CAP,
+};
+
+static void sdsi_list_devices(void)
+{
+	struct dirent *entry;
+	DIR *aux_dir;
+	bool found = false;
+
+	aux_dir = opendir(AUX_DEV_PATH);
+	if (!aux_dir) {
+		fprintf(stderr, "Cannot open directory %s\n", AUX_DEV_PATH);
+		return;
+	}
+
+	while ((entry = readdir(aux_dir))) {
+		if (!strncmp(SDSI_DEV, entry->d_name, strlen(SDSI_DEV))) {
+			found = true;
+			printf("%s\n", entry->d_name);
+		}
+	}
+
+	if (!found)
+		fprintf(stderr, "No sdsi devices found.\n");
+}
+
+static int sdsi_update_registers(struct sdsi_dev *s)
+{
+	FILE *regs_ptr;
+	int ret;
+
+	memset(&s->regs, 0, sizeof(s->regs));
+
+	/* Open the registers file */
+	ret = chdir(s->dev_path);
+	if (ret == -1) {
+		perror("chdir");
+		return ret;
+	}
+
+	regs_ptr = fopen("registers", "r");
+	if (!regs_ptr) {
+		perror("Could not open 'registers' file");
+		return -1;
+	}
+
+	if (s->guid != GUID) {
+		fprintf(stderr, "Unrecognized guid, 0x%x\n", s->guid);
+		fclose(regs_ptr);
+		return -1;
+	}
+
+	/* Update register info for this guid */
+	ret = fread(&s->regs, sizeof(uint8_t), sizeof(s->regs), regs_ptr);
+	if (ret != sizeof(s->regs)) {
+		fprintf(stderr, "Could not read 'registers' file\n");
+		fclose(regs_ptr);
+		return -1;
+	}
+
+	fclose(regs_ptr);
+
+	return 0;
+}
+
+static int sdsi_read_reg(struct sdsi_dev *s)
+{
+	int ret;
+
+	ret = sdsi_update_registers(s);
+	if (ret)
+		return ret;
+
+	/* Print register info for this guid */
+	printf("\n");
+	printf("Socket information for device %s\n", s->dev_name);
+	printf("\n");
+	printf("PPIN:                           0x%lx\n", s->regs.ppin);
+	printf("Enabled Features\n");
+	printf("    SDSi:                       %s\n", !!s->regs.en_features.sdsi ? "Enabled" : "Disabled");
+	printf("Authorization Failure Count\n");
+	printf("    AKC Failure Count:          %d\n", s->regs.auth_fail_count.key_failure_count);
+	printf("    AKC Failure Threshold:      %d\n", s->regs.auth_fail_count.key_failure_threshold);
+	printf("    CAP Failure Count:          %d\n", s->regs.auth_fail_count.auth_failure_count);
+	printf("    CAP Failure Threshold:      %d\n", s->regs.auth_fail_count.auth_failure_threshold);
+	printf("Provisioning Availability\n");
+	printf("    Updates Available:          %d\n", s->regs.prov_avail.available);
+	printf("    Updates Threshold:          %d\n", s->regs.prov_avail.threshold);
+	printf("Socket ID:                      %ld\n", s->regs.socket_id & 0xF);
+
+	return 0;
+}
+
+static int sdsi_certificate_dump(struct sdsi_dev *s)
+{
+	uint64_t state_certificate[512] = {0};
+	bool first_instance;
+	uint64_t previous;
+	FILE *cert_ptr;
+	int i, ret, size;
+
+	ret = sdsi_update_registers(s);
+	if (ret)
+		return ret;
+
+	if (!s->regs.en_features.sdsi) {
+		fprintf(stderr, "SDSi feature is present but not enabled.");
+		fprintf(stderr, " Unable to read state certificate");
+		return -1;
+	}
+
+	ret = chdir(s->dev_path);
+	if (ret == -1) {
+		perror("chdir");
+		return ret;
+	}
+
+	cert_ptr = fopen("state_certificate", "r");
+	if (!cert_ptr) {
+		perror("Could not open 'state_certificate' file");
+		return -1;
+	}
+
+	size = fread(state_certificate, 1, sizeof(state_certificate), cert_ptr);
+	if (!size) {
+		fprintf(stderr, "Could not read 'state_certificate' file\n");
+		fclose(cert_ptr);
+		return -1;
+	}
+
+	printf("%3d: 0x%lx\n", 0, state_certificate[0]);
+	previous = state_certificate[0];
+	first_instance = true;
+
+	for (i = 1; i < (round_up(size, sizeof(uint64_t))/sizeof(uint64_t)); i++) {
+		if (state_certificate[i] == previous) {
+			if (first_instance) {
+				puts("*");
+				first_instance = false;
+			}
+			continue;
+		}
+		printf("%3d: 0x%lx\n", i, state_certificate[i]);
+		previous = state_certificate[i];
+		first_instance = true;
+	}
+	printf("%3d\n", i);
+
+	fclose(cert_ptr);
+
+	return 0;
+}
+
+static int sdsi_provision(struct sdsi_dev *s, char *bin_file, enum command command)
+{
+	int bin_fd, prov_fd, size, ret;
+	char buf[4096] = { 0 };
+	char cap[] = "provision_cap";
+	char akc[] = "provision_akc";
+	char *prov_file;
+
+	if (!bin_file) {
+		fprintf(stderr, "No binary file provided\n");
+		return -1;
+	}
+
+	/* Open the binary */
+	bin_fd = open(bin_file, O_RDONLY);
+	if (bin_fd == -1) {
+		fprintf(stderr, "Could not open file %s: %s\n", bin_file, strerror(errno));
+		return bin_fd;
+	}
+
+	prov_file = (command == CMD_PROV_AKC) ? akc : cap;
+
+	ret = chdir(s->dev_path);
+	if (ret == -1) {
+		perror("chdir");
+		close(bin_fd);
+		return ret;
+	}
+
+	/* Open the provision file */
+	prov_fd = open(prov_file, O_WRONLY);
+	if (prov_fd == -1) {
+		fprintf(stderr, "Could not open file %s: %s\n", prov_file, strerror(errno));
+		close(bin_fd);
+		return prov_fd;
+	}
+
+	/* Read the binary file into the buffer */
+	size = read(bin_fd, buf, 4096);
+	if (size == -1) {
+		close(bin_fd);
+		close(prov_fd);
+		return -1;
+	}
+
+	ret = write(prov_fd, buf, size);
+	if (ret == -1) {
+		close(bin_fd);
+		close(prov_fd);
+		perror("Provisioning failed");
+		return ret;
+	}
+
+	printf("Provisioned %s file %s successfully\n", prov_file, bin_file);
+
+	close(bin_fd);
+	close(prov_fd);
+
+	return 0;
+}
+
+static int sdsi_provision_akc(struct sdsi_dev *s, char *bin_file)
+{
+	int ret;
+
+	ret = sdsi_update_registers(s);
+	if (ret)
+		return ret;
+
+	if (!s->regs.en_features.sdsi) {
+		fprintf(stderr, "SDSi feature is present but not enabled. Unable to provision");
+		return -1;
+	}
+
+	if (!s->regs.prov_avail.available) {
+		fprintf(stderr, "Maximum number of updates (%d) has been reached.\n",
+			s->regs.prov_avail.threshold);
+		return -1;
+	}
+
+	if (s->regs.auth_fail_count.key_failure_count ==
+	    s->regs.auth_fail_count.key_failure_threshold) {
+		fprintf(stderr, "Maximum number of AKC provision failures (%d) has been reached.\n",
+			s->regs.auth_fail_count.key_failure_threshold);
+		fprintf(stderr, "Power cycle the system to reset the counter\n");
+		return -1;
+	}
+
+	return sdsi_provision(s, bin_file, CMD_PROV_AKC);
+}
+
+static int sdsi_provision_cap(struct sdsi_dev *s, char *bin_file)
+{
+	int ret;
+
+	ret = sdsi_update_registers(s);
+	if (ret)
+		return ret;
+
+	if (!s->regs.en_features.sdsi) {
+		fprintf(stderr, "SDSi feature is present but not enabled. Unable to provision");
+		return -1;
+	}
+
+	if (!s->regs.prov_avail.available) {
+		fprintf(stderr, "Maximum number of updates (%d) has been reached.\n",
+			s->regs.prov_avail.threshold);
+		return -1;
+	}
+
+	if (s->regs.auth_fail_count.auth_failure_count ==
+	    s->regs.auth_fail_count.auth_failure_threshold) {
+		fprintf(stderr, "Maximum number of CAP provision failures (%d) has been reached.\n",
+			s->regs.auth_fail_count.auth_failure_threshold);
+		fprintf(stderr, "Power cycle the system to reset the counter\n");
+		return -1;
+	}
+
+	return sdsi_provision(s, bin_file, CMD_PROV_CAP);
+}
+
+static int read_sysfs_data(const char *file, int *value)
+{
+	char buff[16];
+	FILE *fp;
+
+	fp = fopen(file, "r");
+	if (!fp) {
+		perror(file);
+		return -1;
+	}
+
+	if (!fgets(buff, 16, fp)) {
+		fprintf(stderr, "Failed to read file '%s'", file);
+		fclose(fp);
+		return -1;
+	}
+
+	fclose(fp);
+	*value = strtol(buff, NULL, 0);
+
+	return 0;
+}
+
+static struct sdsi_dev *sdsi_create_dev(char *dev_no)
+{
+	int dev_name_len = sizeof(SDSI_DEV) + strlen(dev_no) + 1;
+	struct sdsi_dev *s;
+	int guid;
+	DIR *dir;
+
+	s = (struct sdsi_dev *)malloc(sizeof(*s));
+	if (!s) {
+		perror("malloc");
+		return NULL;
+	}
+
+	s->dev_name = (char *)malloc(sizeof(SDSI_DEV) + strlen(dev_no) + 1);
+	if (!s->dev_name) {
+		perror("malloc");
+		free(s);
+		return NULL;
+	}
+
+	snprintf(s->dev_name, dev_name_len, "%s.%s", SDSI_DEV, dev_no);
+
+	s->dev_path = (char *)malloc(sizeof(AUX_DEV_PATH) + dev_name_len);
+	if (!s->dev_path) {
+		perror("malloc");
+		free(s->dev_name);
+		free(s);
+		return NULL;
+	}
+
+	snprintf(s->dev_path, sizeof(AUX_DEV_PATH) + dev_name_len, "%s%s", AUX_DEV_PATH,
+		 s->dev_name);
+	dir = opendir(s->dev_path);
+	if (!dir) {
+		fprintf(stderr, "Could not open directory '%s': %s\n", s->dev_path,
+			strerror(errno));
+		free(s->dev_path);
+		free(s->dev_name);
+		free(s);
+		return NULL;
+	}
+
+	if (chdir(s->dev_path) == -1) {
+		perror("chdir");
+		free(s->dev_path);
+		free(s->dev_name);
+		free(s);
+		return NULL;
+	}
+
+	if (read_sysfs_data("guid", &guid)) {
+		free(s->dev_path);
+		free(s->dev_name);
+		free(s);
+		return NULL;
+	}
+
+	s->guid = guid;
+
+	return s;
+}
+
+static void sdsi_free_dev(struct sdsi_dev *s)
+{
+	free(s->dev_path);
+	free(s->dev_name);
+	free(s);
+}
+
+static void print_help(char *prog)
+{
+	printf("Usage: %s [-l] [-d dev_no [-is] [-a file] [-c file]]\n", prog);
+
+	printf("\n");
+	printf("Commands:\n");
+	printf("  %-13s\t%s\n", "-l", "list available sdsi devices");
+	printf("  %-13s\t%s\n", "-d <dev_no>", "sdsi device number");
+	printf("  %-13s\t%s\n", "-i", "show socket information");
+	printf("  %-13s\t%s\n", "-s", "dump state certificate data");
+	printf("  %-13s\t%s\n", "-a <file>", "provision socket with AKC file");
+	printf("  %-13s\t%s\n", "-c <file>", "provision socket with CAP file");
+}
+
+int main(int argc, char *argv[])
+{
+	char bin_file[PATH_MAX], *dev_no = NULL;
+	enum command command = CMD_NONE;
+	struct sdsi_dev *s;
+	int ret = 0, opt;
+
+	while ((opt = getopt(argc, argv, "d:lisa:c:h")) != -1) {
+		switch (opt) {
+		case 'd':
+			dev_no = optarg;
+			break;
+		case 'l':
+			command = CMD_LIST_DEVICES;
+			break;
+		case 'i':
+			command = CMD_SOCKET_INFO;
+			break;
+		case 's':
+			command = CMD_DUMP_CERT;
+			break;
+		case 'a':
+		case 'c':
+			if (!access(optarg, F_OK) == 0) {
+				fprintf(stderr, "Could not open file '%s': %s\n", optarg,
+					strerror(errno));
+				return -1;
+			}
+
+			if (!realpath(optarg, bin_file)) {
+				perror("realpath");
+				return -1;
+			}
+
+			command = (opt == 'a') ? CMD_PROV_AKC : CMD_PROV_CAP;
+			break;
+		case 'h':
+		default:
+			print_help(argv[0]);
+			return 0;
+		}
+	}
+
+	if (!dev_no && command != CMD_LIST_DEVICES) {
+		print_help(argv[0]);
+		return -1;
+	}
+
+	if (dev_no) {
+		s = sdsi_create_dev(dev_no);
+		if (!s)
+			return -1;
+	}
+
+	/* Run the command */
+	switch (command) {
+	case CMD_NONE:
+		fprintf(stderr, "need to specify a command\n");
+		print_help(argv[0]);
+		ret = -1;
+	case CMD_LIST_DEVICES:
+		sdsi_list_devices();
+		break;
+	case CMD_SOCKET_INFO:
+		ret = sdsi_read_reg(s);
+		break;
+	case CMD_DUMP_CERT:
+		ret = sdsi_certificate_dump(s);
+		break;
+	case CMD_PROV_AKC:
+		ret = sdsi_provision_akc(s, bin_file);
+		break;
+	case CMD_PROV_CAP:
+		ret = sdsi_provision_cap(s, bin_file);
+		break;
+	}
+
+
+	if (dev_no)
+		sdsi_free_dev(s);
+
+	return ret;
+}
-- 
2.25.1

