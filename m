Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD04A5FBF13
	for <lists+linux-pci@lfdr.de>; Wed, 12 Oct 2022 04:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiJLCNg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Oct 2022 22:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJLCNe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Oct 2022 22:13:34 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA8BA5707
        for <linux-pci@vger.kernel.org>; Tue, 11 Oct 2022 19:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665540813; x=1697076813;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E/8H4r4yIXggwOul5fsHP+CzePXJ3FIwS9C4XXBa2Vw=;
  b=me1GPg6pNRNDQqc+C2Z1au/VF5pq6g4TJOGg9HVemQS6O56Pf0bQB8BR
   bDFQ0XXFr8IR4mulEy8yYSm/s9CrUXjIDcqcfqgJ23PBlJR2eEkFESH8z
   kL8gsm4QGAfjb7VXd6MbeLPQ9t31H94PE+cJ8s9GuBArRjAgEsuMoW8co
   wa0DOgvWQ7QadAMTypSphYxXfyWeOAjhJsVW25fGnWdQI+keI5HAsrl6z
   1BwSjUM4BEime6jTeiruChdR8LrMp4kl2KvuvyueHMNUca4JqhRjJI3jo
   Jvsopz8MthOPb4sP296ct70jLRrxX27E7wbz7IO6ZZSKX2MEFJwOxqM0M
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="287941291"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="287941291"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 19:13:32 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="604374929"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="604374929"
Received: from jbrandeb-coyote30.jf.intel.com ([10.166.29.19])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 19:13:32 -0700
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
To:     mj@ucw.cz, linux-pci@vger.kernel.org
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>, helgaas@kernel.org
Subject: [PATCH pciutils v2] pciutils: add new readpci utility
Date:   Tue, 11 Oct 2022 19:13:25 -0700
Message-Id: <20221012021325.50085-1-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the new utility 'readpci' in order to allow users to read and write the
register address space located in the BAR designator + offset.

The reason that this app is better than what is generally available on the
internet (there are several) is that this app integrates with the libpci
and further benefits from pciutils-like arguments and device
specifications.

help output:

$ sudo ./readpci -h
./readpci: invalid option -- 'h'
Usage: ./readpci [options] [device]   (/usr/local/share/pci.ids.gz)

Options:
-w <value>              Value to write to the address
-W <value>              Value to write to the address (no read)
-a <value>              Register address
-b <value>              BAR to access other than BAR 0
-m                      Access MSI-X BAR instead of BAR 0
-D                      PCI debugging
-q                      Quiet mode, no banner
-v                      Enable more verbose output
Device:
-d [<vendor>]:[<device>]                        Show selected devices
-s [[[[<domain>]:]<bus>]:][<slot>][.[<func>]]   Show devices in selected slots

basic usage to read a register:

$ sudo ./readpci -s 17:0.0 -a 0xb8000
17:00.0 (8086:1592) - Device 8086:1592
0xb8000 == 0x00000001

This program was originally written by Shannon Nelson, and extended
by me.

Limitations
===========
Currently the utility only allows reading or writing one 32 bit value at
a time, on one device only.

Future options
==============
- Implement machine readable output
- Implement multiple register reads (ranges)
- Implement multiple device match (same register multiple devices of a
  match)

This change also contains a tiny Makefile optimization to allow
overriding the compiler at build time on the command line, which made it
easier to test with multiple compilers.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

---

v2: addressed comments from Bjorn Helgaas, enhanced the man page, and
extended verbose mode printing to output the final address, and a 32
bit value for the address value printing. I left the renaming discussion
to another patch, as the readpci name may not be final.
---
 .gitignore  |   1 +
 Makefile    |  19 +--
 readpci.c   | 345 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 readpci.man |  96 +++++++++++++++
 4 files changed, 454 insertions(+), 7 deletions(-)

diff --git a/.gitignore b/.gitignore
index 4a25863a1504..d2b57902900e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -6,5 +6,6 @@
 lspci
 setpci
 example
+readpci
 update-pciids
 pci.ids.gz
diff --git a/Makefile b/Makefile
index 9319bb495b21..549457c47229 100644
--- a/Makefile
+++ b/Makefile
@@ -47,9 +47,9 @@ INSTALL=install
 DIRINSTALL=install -d
 STRIP=-s
 ifdef CROSS_COMPILE
-CC=$(CROSS_COMPILE)gcc
+CC:=$(CROSS_COMPILE)gcc
 else
-CC=cc
+CC:=cc
 endif
 AR=$(CROSS_COMPILE)ar
 RANLIB=$(CROSS_COMPILE)ranlib
@@ -64,7 +64,7 @@ PCIINC_INS=lib/config.h lib/header.h lib/pci.h lib/types.h
 
 export
 
-all: lib/$(PCILIB) lspci$(EXEEXT) setpci$(EXEEXT) example$(EXEEXT) lspci.8 setpci.8 pcilib.7 pci.ids.5 update-pciids update-pciids.8 $(PCI_IDS)
+all: lib/$(PCILIB) lspci$(EXEEXT) setpci$(EXEEXT) readpci$(EXEEXT) example$(EXEEXT) lspci.8 setpci.8 readpci.8  pcilib.7 pci.ids.5 update-pciids update-pciids.8 $(PCI_IDS)
 
 lib/$(PCILIB): $(PCIINC) force
 	$(MAKE) -C lib all
@@ -103,6 +103,10 @@ update-pciids: update-pciids.sh
 	sed <$< >$@ "s@^DEST=.*@DEST=$(IDSDIR)/$(PCI_IDS)@;s@^PCI_COMPRESSED_IDS=.*@PCI_COMPRESSED_IDS=$(PCI_COMPRESSED_IDS)@"
 	chmod +x $@
 
+# add the readpci executable
+readpci$(EXEEXT): readpci.o lib/$(PCILIB)
+readpci.o: readpci.c pciutils.h $(PCIINC)
+
 # The example of use of libpci
 example$(EXEEXT): example.o lib/$(PCILIB)
 example.o: example.c $(PCIINC)
@@ -123,7 +127,7 @@ TAGS:
 
 clean:
 	rm -f `find . -name "*~" -o -name "*.[oa]" -o -name "\#*\#" -o -name TAGS -o -name core -o -name "*.orig"`
-	rm -f update-pciids lspci$(EXEEXT) setpci$(EXEEXT) example$(EXEEXT) lib/config.* *.[578] pci.ids.gz lib/*.pc lib/*.so lib/*.so.* tags
+	rm -f update-pciids lspci$(EXEEXT) setpci$(EXEEXT) readpci$(EXEEXT) example$(EXEEXT) lib/config.* *.[578] pci.ids.gz lib/*.pc lib/*.so lib/*.so.* tags
 	rm -rf maint/dist
 
 distclean: clean
@@ -133,9 +137,10 @@ install: all
 	$(DIRINSTALL) -m 755 $(DESTDIR)$(BINDIR) $(DESTDIR)$(SBINDIR) $(DESTDIR)$(IDSDIR) $(DESTDIR)$(MANDIR)/man8 $(DESTDIR)$(MANDIR)/man7 $(DESTDIR)/$(MANDIR)/man5
 	$(INSTALL) -c -m 755 $(STRIP) lspci$(EXEEXT) $(DESTDIR)$(LSPCIDIR)
 	$(INSTALL) -c -m 755 $(STRIP) setpci$(EXEEXT) $(DESTDIR)$(SBINDIR)
+	$(INSTALL) -c -m 755 $(STRIP) readpci$(EXEEXT) $(DESTDIR)$(SBINDIR)
 	$(INSTALL) -c -m 755 update-pciids $(DESTDIR)$(SBINDIR)
 	$(INSTALL) -c -m 644 $(PCI_IDS) $(DESTDIR)$(IDSDIR)
-	$(INSTALL) -c -m 644 lspci.8 setpci.8 update-pciids.8 $(DESTDIR)$(MANDIR)/man8
+	$(INSTALL) -c -m 644 lspci.8 setpci.8 readpci.8 update-pciids.8 $(DESTDIR)$(MANDIR)/man8
 	$(INSTALL) -c -m 644 pcilib.7 $(DESTDIR)$(MANDIR)/man7
 	$(INSTALL) -c -m 644 pci.ids.5 $(DESTDIR)$(MANDIR)/man5
 ifeq ($(SHARED),yes)
@@ -169,9 +174,9 @@ endif
 endif
 
 uninstall: all
-	rm -f $(DESTDIR)$(SBINDIR)/lspci$(EXEEXT) $(DESTDIR)$(SBINDIR)/setpci$(EXEEXT) $(DESTDIR)$(SBINDIR)/update-pciids
+	rm -f $(DESTDIR)$(SBINDIR)/lspci$(EXEEXT) $(DESTDIR)$(SBINDIR)/setpci$(EXEEXT) $(DESTDIR)$(SBINDIR)/readpci$(EXEEXT) $(DESTDIR)$(SBINDIR)/update-pciids
 	rm -f $(DESTDIR)$(IDSDIR)/$(PCI_IDS)
-	rm -f $(DESTDIR)$(MANDIR)/man8/lspci.8 $(DESTDIR)$(MANDIR)/man8/setpci.8 $(DESTDIR)$(MANDIR)/man8/update-pciids.8
+	rm -f $(DESTDIR)$(MANDIR)/man8/lspci.8 $(DESTDIR)$(MANDIR)/man8/setpci.8 $(DESTDIR)$(MANDIR)/man8/readpci.8 $(DESTDIR)$(MANDIR)/man8/update-pciids.8
 	rm -f $(DESTDIR)$(MANDIR)/man7/pcilib.7
 	rm -f $(DESTDIR)$(MANDIR)/man5/pci.ids.5
 	rm -f $(DESTDIR)$(LIBDIR)/$(PCILIB)
diff --git a/readpci.c b/readpci.c
new file mode 100644
index 000000000000..a976c5a74a13
--- /dev/null
+++ b/readpci.c
@@ -0,0 +1,345 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *	The PCI Utilities -- read and write PCI registers
+ *
+ *	Copyright(c) 2022 Intel Corporation. All rights reserved.
+ *
+ *	Originally authored by: Shannon Nelson <shannon.nelson@intel.com>
+ *	Changes and published by: Jesse Brandeburg <jesse.brandeburg@intel.com>
+ */
+
+#include <stdio.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include "pciutils.h"
+
+#include <fcntl.h>
+#include <getopt.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <linux/types.h>
+#include "lib/types.h"
+
+static struct pci_filter filter;    /* Device filter */
+
+static struct option opts[] = {
+	{"write", 1, NULL, 'w' },
+	{"address", 1, NULL, 'a' },
+	{"debug", 0, NULL, 'D' },
+	{"verbose", 0, NULL, 'v' },
+	{"device", 1, NULL, 'd' },
+	{"slot", 1, NULL, 's' },
+	{ 0, 0, NULL, '0' }
+};
+
+static char help_msg[] = {
+"Usage: %s [options] [device]   (%s)\n\n"
+"Options:\n"
+"-w <value>\t\tValue to write to the address\n"
+"-W <value>\t\tValue to write to the address (no read)\n"
+"-a <value>\t\tRegister address\n"
+"-b <value>\t\tBAR to access other than BAR 0\n"
+"-m\t\t\tAccess MSI-X BAR instead of BAR 0\n"
+"-D\t\t\tPCI debugging\n"
+"-q \t\t\tQuiet mode, no banner\n"
+"-v \t\t\tEnable more verbose output\n"
+"Device:\n"
+"-d [<vendor>]:[<device>]\t\t\tShow selected devices\n"
+"-s [[[[<domain>]:]<bus>]:][<slot>][.[<func>]]"
+"\tShow devices in selected slots\n\n"
+};
+
+static void usage(char *progname, char *idfile)
+{
+	printf(help_msg, progname, idfile);
+}
+
+static int find_msix(struct pci_dev *dev, u8 *bir)
+{
+	struct pci_cap *msix_cap;
+
+	msix_cap = pci_find_cap(dev, PCI_CAP_ID_MSIX, PCI_CAP_NORMAL);
+
+	/* no MSI-X capabilities found, just exit without error */
+	if (!msix_cap) {
+		printf("Cannot find MSI-X capability!\n");
+		return -1;
+	}
+
+	/* determine which BAR contains MSI-X data */
+	*bir = pci_read_long(dev, msix_cap->addr + 4) & 0x7;
+	if (!*bir) {
+		printf("Cannot find MSI-X BAR!\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+static int print_register(struct pci_dev *dev, u8 bir, u32 address)
+{
+	volatile void *mem;
+	int dev_mem_fd;
+
+	dev_mem_fd = open("/dev/mem", O_RDONLY);
+	if (dev_mem_fd < 0) {
+		perror("open");
+		return -1;
+	}
+
+	mem = (u8 *)mmap(NULL, dev->size[bir], PROT_READ, MAP_SHARED, dev_mem_fd, (dev->base_addr[bir] & PCI_ADDR_MEM_MASK));
+	if (mem == MAP_FAILED) {
+		perror("mmap/readable - try rebooting with iomem=relaxed");
+		close(dev_mem_fd);
+		return -1;
+	}
+
+	printf("0x%x == 0x%08x\n", address, *((u32 *)(mem + address)));
+
+	close(dev_mem_fd);
+	munmap((void *)mem, dev->size[bir]);
+
+	return 0;
+}
+
+static int write_register(struct pci_dev *dev, u8 bir, u32 address, u32 value)
+{
+	volatile void *mem;
+	int dev_mem_fd;
+
+	dev_mem_fd = open("/dev/mem", O_RDWR);
+	if (dev_mem_fd < 0) {
+		perror("open");
+		return -1;
+	}
+
+	mem = mmap(NULL, dev->size[bir], PROT_WRITE, MAP_SHARED, dev_mem_fd, (dev->base_addr[bir] & PCI_ADDR_MEM_MASK));
+	if (mem == MAP_FAILED) {
+		perror("mmap/writable - try rebooting with iomem=relaxed");
+		close(dev_mem_fd);
+		return -1;
+	}
+
+	*((u32 *)(mem + address)) = value;
+
+	close(dev_mem_fd);
+	munmap((void *)mem, dev->size[bir]);
+
+	return 0;
+}
+
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(a) (sizeof(a)/sizeof((a)[0]))
+#endif
+
+/* cribbed from lspci.c */
+static void
+show_size(u64 x)
+{
+	static const char suffix[][2] = { "", "K", "M", "G", "T" };
+	unsigned i;
+	if (!x)
+		return;
+	for (i = 0; i < (sizeof(suffix) / sizeof(*suffix) - 1); i++) {
+		if (x % 1024)
+			break;
+		x /= 1024;
+	}
+	printf(" [size=%u%s]", (unsigned)x, suffix[i]);
+}
+
+int main(int argc, char **argv)
+{
+	int ch, debug = 0, quiet = 0;
+	struct pci_access *pacc;
+	struct pci_dev *dev;
+	char *errmsg;
+	char buf[128];
+	u32 address = 0;
+	u32 value = 0;
+	u64 lvalue = 0;
+	int device_specified = 0;
+	int do_write = 0;
+	int do_writeonly = 0;
+	int got_address = 0;
+	int ret = 0;
+	int msix = 0;
+	u8 bir = 0;
+
+	if (getuid() != 0) {
+		printf("%s: must be run as root\n", argv[0]);
+		exit(1);
+	}
+
+	pacc = pci_alloc();		/* Get the pci_access structure */
+	if (pacc == NULL) {
+		perror("pci_alloc");
+		exit(1);
+	}
+	pci_filter_init(pacc, &filter);
+
+	while ((ch = getopt_long(argc, argv, "W:w:Da:mb:d:s:qv", opts, NULL)) != -1) {
+		switch (ch) {
+		case 'w':
+			lvalue = strtoll(optarg, NULL, 0);
+			value = (u32)lvalue;
+			do_write++;
+			break;
+		case 'W':
+			lvalue = strtoll(optarg, NULL, 0);
+			value = (u32)lvalue;
+			do_write++;
+			do_writeonly++;
+			break;
+		case 'D':
+			pacc->debugging++;
+			break;
+		case 'a':
+			address = strtol(optarg, NULL, 0);
+			got_address++;
+			break;
+		case 'm':
+			msix++;
+			break;
+		case 'b':
+			lvalue = strtoll(optarg, NULL, 0);
+			if (lvalue >= ARRAY_SIZE(dev->base_addr)) {
+				printf("Invalid BAR requested!\n");
+				exit(1);
+			}
+			bir = (u8)lvalue;
+			break;
+		case 'd':
+			/* Show only selected devices */
+			if ((errmsg = pci_filter_parse_id(&filter, optarg))) {
+				printf("%s\n", errmsg);
+				exit(1);
+			}
+			device_specified++;
+			break;
+		case 's':
+			/* Show only devices in selected slots */
+			if ((errmsg = pci_filter_parse_slot(&filter, optarg))) {
+				printf("%s\n", errmsg);
+				exit(1);
+			}
+			device_specified++;
+			break;
+		case 'q':
+			/* don't print the banner */
+			quiet = 1;
+			break;
+		case 'v':
+			/* turn on extra debug prints */
+			debug = 1;
+			break;
+		case '?':
+		default:
+			usage(argv[0], pacc->id_file_name);
+			exit(1);
+			break;
+		}
+	}
+
+	if (!device_specified) {
+		printf("No device given\n");
+		usage(argv[0], pacc->id_file_name);
+		exit(1);
+	}
+
+	if (!got_address) {
+		printf("No address given\n");
+		usage(argv[0], pacc->id_file_name);
+		exit(1);
+	}
+
+	pci_init(pacc);			/* Initialize the PCI library */
+	pci_scan_bus(pacc);		/* Get the list of devices */
+
+	if (pacc->debugging)
+		printf(	"filter: "
+#ifdef HAVE_DOMAIN_SUPPORT
+			"domain=0x%x "
+#endif
+			"bus=0x%x slot=0x%x func=0x%x\n"
+			"\tvendor=0x%x device=0x%x\n\n",
+#ifdef HAVE_DOMAIN_SUPPORT
+			filter.domain,
+#endif
+			filter.bus, filter.slot, filter.func,
+			filter.vendor, filter.device);
+
+	/* Iterate over all devices to find the single one we want */
+	for (dev = pacc->devices; dev; dev = dev->next) {
+
+		if (!pci_filter_match(&filter, dev))
+			continue;
+
+		/* Fill in header info we need */
+		pci_fill_info(dev, PCI_FILL_IDENT | PCI_FILL_BASES | PCI_FILL_SIZES);
+
+#ifdef HAVE_DOMAIN_SUPPORT
+		if (dev->domain) {
+			if (!quiet)
+				printf("%04x:", dev->domain);
+		}
+#endif
+		if (!quiet) {
+			printf("%02x:%02x.%d (%04x:%04x) - %s\n", dev->bus,
+			       dev->dev, dev->func, dev->vendor_id,
+			       dev->device_id, pci_lookup_name(pacc, buf,
+							       sizeof(buf),
+					PCI_LOOKUP_VENDOR|PCI_LOOKUP_DEVICE,
+					dev->vendor_id, dev->device_id, 0, 0));
+		}
+
+		/* overwrite bir with offset of MSI-X BAR */
+		if (msix) {
+			ret = find_msix(dev, &bir);
+			if (ret)
+				break;
+		}
+
+		/* verify that the BAR requested is valid */
+		if (!dev->base_addr[bir]) {
+			printf("Invalid BAR requested!\n");
+			break;
+		}
+
+		if (debug) {
+			u64 baseaddr;
+			u32 flag = pci_read_long(dev, PCI_BASE_ADDRESS_0 + 4*bir);
+			int t = flag & PCI_BASE_ADDRESS_MEM_TYPE_MASK;
+
+			baseaddr = dev->base_addr[bir] & PCI_ADDR_MEM_MASK;
+			printf("BAR%d: Memory at ", bir);
+			printf(PCIADDR_T_FMT, baseaddr);
+			printf(" (%s, %sprefetchable)",
+				(t == PCI_BASE_ADDRESS_MEM_TYPE_32) ? "32-bit" :
+				(t == PCI_BASE_ADDRESS_MEM_TYPE_64) ? "64-bit" :
+				(t == PCI_BASE_ADDRESS_MEM_TYPE_1M) ? "low-1M" : "type 3",
+				(flag & PCI_BASE_ADDRESS_MEM_PREFETCH) ? "" : "non-");
+			show_size(dev->size[bir]);
+			printf("\n");
+			printf("ADDR:           " PCIADDR_T_FMT "\n", baseaddr + address);
+		}
+
+		if (do_write) {
+			ret = write_register(dev, bir, address, value);
+			if (ret || do_writeonly)
+				break;
+		}
+		ret = print_register(dev, bir, address);
+
+		/* we're done, we only write/print one device */
+		break;
+	}
+
+	if (!dev)
+		printf("no device found\n");
+
+	pci_cleanup(pacc);		/* Close everything */
+	return ret;
+}
+
diff --git a/readpci.man b/readpci.man
new file mode 100644
index 000000000000..a2b888affe18
--- /dev/null
+++ b/readpci.man
@@ -0,0 +1,96 @@
+.TH readpci 8 "@TODAY@" "@VERSION@" "The PCI Utilities"
+.SH NAME
+readpci \- read or write PCI registers
+.SH SYNOPSIS
+.B readpci
+.RB [ options ]
+.SH DESCRIPTION
+.B readpci
+is a utility for reading and writing PCI registers in a memory
+mapped range.
+
+If you are going to report bugs in PCI device drivers or in
+.I readpci
+itself, please include output of "lspci -vvx" or even better "lspci -vvxxx"
+(however, see below for possible caveats).
+
+Access to read and write registers in /dev/mem is restricted to root,
+So,
+.I readpci
+exits with an error code if run by non-root users.
+
+.SH OPTIONS
+
+.SS Program options
+.TP
+.B -v
+Be verbose and display detailed information about the actions of readpci.
+.TP
+.B -w [<value>]
+The value to write to the address, usually specified like 0x0123abcd. Using
+this argument causes a read after write to the register to report the value
+read back after write. This parameter is optional but requires -a.
+.TP
+.B -W [<value>]
+The value to write to the address, usually specified like 0x0123abcd. Using
+this argument AVOIDS a read after write to the register and DOES NOT report the
+value read back after write. This parameter is optional, but cannot be used
+with -w and requires -a.
+.TP
+.B -a [<address>]
+The address to read or write from (or both), as an offset from the start of the
+BAR. Typically specified like 0x0123abcd.
+.TP
+.B -b [<value>]
+BAR number to access if other than BAR0. Optional parameter, defaults to 0 if
+not specified.
+.TP
+.B -m
+Read from MSI-X BAR.
+.TP
+.B -D
+Add more PCI library debugging.
+.TP
+.B -q
+Don't print the banner during each read or write.
+
+.SS Options for selection of devices
+.TP
+.B -s [[[[<domain>]:]<bus>]:][<device>][.[<func>]]
+Specify which device (only one) to read via the specified domain (in case your machine has several host bridges,
+they can either share a common bus number space or each of them can address a PCI domain
+of its own; domains are numbered from 0 to ffff), bus (0 to ff), device (0 to 1f) and function (0 to 7).
+.TP
+.B -d [<vendor>]:[<device>][:<class>[:<prog-if>]]
+Show only the (first) device with specified vendor, device, class ID, and programming interface.
+The ID's are given in hexadecimal and may be omitted or given as "*", both meaning
+"any value". The class ID can contain "x" characters which stand for "any digit".
+
+.P
+The relative order of positional arguments and options is undefined.
+New options can be added in future versions, but they will always
+have a single argument not separated from the option by any spaces,
+so they can be easily ignored if not recognized.
+
+.SH FILES
+.TP
+.B @IDSDIR@/pci.ids
+A list of all known PCI ID's (vendors, devices, classes and subclasses).
+
+.SH BUGS
+
+There might be some, but none known at this time. If you find one please
+let the list
+.I <linux-pci@vger.kernel.org>
+know.
+
+.SH SEE ALSO
+.BR lspci (8),
+.BR setpci (8),
+.BR pci.ids (5),
+.BR update-pciids (8),
+.BR pcilib (7)
+
+.SH AUTHOR
+The PCI Utilities are maintained by Martin Mares <mj@ucw.cz>.
+The readpci utility was written by Intel.

base-commit: 0478e1f3928bfaa34eb910ba2cbaf1dda8f84aab
-- 
2.31.1

