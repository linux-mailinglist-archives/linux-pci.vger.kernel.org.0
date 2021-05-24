Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECEC638E7F0
	for <lists+linux-pci@lfdr.de>; Mon, 24 May 2021 15:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbhEXNom (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 May 2021 09:44:42 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3930 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbhEXNol (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 May 2021 09:44:41 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fpdcz33jTzBv41;
        Mon, 24 May 2021 21:40:19 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 21:43:09 +0800
Received: from localhost.localdomain (10.123.41.22) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 14:43:07 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, <ira.weiny@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        <linux-acpi@vger.kernel.org>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, Fangjian <f.fangjian@huawei.com>,
        <linuxarm@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 5/5] DONOTMERGE: PCI/DOE: Add userspace example program to tools/pci
Date:   Mon, 24 May 2021 21:39:38 +0800
Message-ID: <20210524133938.2815206-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210524133938.2815206-1-Jonathan.Cameron@huawei.com>
References: <20210524133938.2815206-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The example uses the Discovery Protocol to illustrate the
use of the IOCTL interface to access the DOE mailboxes form
userspace.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 tools/pci/Build     |   1 +
 tools/pci/Makefile  |   9 ++-
 tools/pci/doetest.c | 131 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 140 insertions(+), 1 deletion(-)

diff --git a/tools/pci/Build b/tools/pci/Build
index c375aea21790..af4521bebf93 100644
--- a/tools/pci/Build
+++ b/tools/pci/Build
@@ -1 +1,2 @@
 pcitest-y += pcitest.o
+doetest-y += doetest.o
diff --git a/tools/pci/Makefile b/tools/pci/Makefile
index 4b95a5176355..b2e54afe583c 100644
--- a/tools/pci/Makefile
+++ b/tools/pci/Makefile
@@ -14,7 +14,7 @@ MAKEFLAGS += -r
 
 CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
 
-ALL_TARGETS := pcitest
+ALL_TARGETS := pcitest doetest
 ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
 
 SCRIPTS := pcitest.sh
@@ -30,6 +30,7 @@ include $(srctree)/tools/build/Makefile.include
 $(OUTPUT)include/linux/: ../../include/uapi/linux/
 	mkdir -p $(OUTPUT)include/linux/ 2>&1 || true
 	ln -sf $(CURDIR)/../../include/uapi/linux/pcitest.h $@
+	ln -sf $(CURDIR)/../../include/uapi/linux/pci_doe.h $@
 
 prepare: $(OUTPUT)include/linux/
 
@@ -39,6 +40,12 @@ $(PCITEST_IN): prepare FORCE
 $(OUTPUT)pcitest: $(PCITEST_IN)
 	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
 
+DOETEST_IN := $(OUTPUT)doetest-in.o
+$(DOETEST_IN): prepare FORCE
+	$(Q)$(MAKE) $(build)=doetest
+$(OUTPUT)doetest: $(DOETEST_IN)
+	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
+
 clean:
 	rm -f $(ALL_PROGRAMS)
 	rm -rf $(OUTPUT)include/
diff --git a/tools/pci/doetest.c b/tools/pci/doetest.c
new file mode 100644
index 000000000000..b2db847b1503
--- /dev/null
+++ b/tools/pci/doetest.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Example user of the DOE userspace interface.
+ *
+ * Jonathan Cameron <Jonathan.Cameron@huawei.com>
+ */
+
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <fcntl.h>
+#include <linux/types.h>
+#include <stdio.h>
+#include <sys/ioctl.h>
+#include <getopt.h>
+#include <string.h>
+
+struct pci_doe_uexchange {
+	__u16 vid;
+	__u8 protocol;
+	__u8 rsvd;
+	__u32 retval;
+	struct {
+		__s32 size;
+		__u32 rsvd;
+		__u64 payload;
+	} in;
+	struct {
+		__s32 size;
+		__u32 rsvd;
+		__u64 payload;
+	} out;
+};
+
+#define PCI_DOE_EXCHANGE _IOWR(0xDA, 1, struct pci_doe_uexchange)
+
+int doe_list_protocols(int fd)
+{
+	__u32 outbuf = 0;
+	__u32 inbuf; /* Start with index 0 */
+	struct pci_doe_uexchange ex = {
+		.vid = 33,
+		.protocol = 1,
+		.in.size = sizeof(inbuf),
+		.in.payload = (__u64)&inbuf,
+		.out.size = sizeof(outbuf),
+		.out.payload = (__u64)&outbuf,
+		.vid = 0x01, /* PCI SIG */
+		.protocol = 0x00,
+	};
+	int rc;
+	uint8_t index = 0;
+
+	do {
+		inbuf = index;
+		rc = ioctl(fd, PCI_DOE_EXCHANGE, &ex);
+		if (rc) {
+			printf("IOCTL error: %d\n", rc);
+			return rc;
+		}
+		if (ex.retval) {
+			printf("DOE return value indicates failure: %d\n", ex.retval);
+			return ex.retval;
+		}
+		index = outbuf >> 24;
+
+		printf("VID: %#x, Protocol: %#x\n", outbuf & 0xffff, (outbuf >> 16) & 0xff);
+	} while (index);
+
+	return 0;
+}
+
+static const struct option longopts[] = {
+	{ "filename",		1, 0, 'f' },
+	{ }
+};
+
+static void print_usage(void)
+{
+	fprintf(stderr, "Usage: doe [options]...\n"
+		"Example userspace access to a PCI DOE mailbox\n"
+		"  -f <filename>	Path to chardev /dev/pcidoe/...\n"
+		"  -l			List supported protocols\n");
+}
+
+int main(int argc, char **argv)
+{
+	char *filename = NULL;
+	bool run_discovery = false;
+	int fd, c;
+	int rc = 0;
+
+	while ((c = getopt_long(argc, argv, "?f:l", longopts, NULL)) != -1) {
+		switch (c) {
+		case 'f':
+			filename = strdup(optarg);
+			break;
+		case 'l':
+			run_discovery = true;
+			break;
+		case '?':
+			print_usage();
+			goto free_filename;
+		}
+	}
+	if (!filename) {
+		fprintf(stderr, "Filename must be supplied using -f FILENAME\n");
+		rc = -1;
+		/* No need to actually free the filename, but keep exit path simple */
+		goto free_filename;
+	}
+
+	fd = open(filename, 0);
+	if (fd == -1) {
+		fprintf(stderr, "Could not open file %s\n", filename);
+		rc = -1;
+		goto free_filename;
+	}
+	if (run_discovery) {
+		rc = doe_list_protocols(fd);
+		if (rc)
+			goto close_fd;
+	}
+close_fd:
+	close(fd);
+free_filename:
+	free(filename);
+
+	return rc;
+}
-- 
2.19.1

