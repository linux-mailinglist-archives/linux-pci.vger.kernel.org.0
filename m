Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A021C584BA
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2019 16:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfF0OpQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jun 2019 10:45:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51340 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726441AbfF0OpP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Jun 2019 10:45:15 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 670639CE968B651FE224;
        Thu, 27 Jun 2019 22:45:05 +0800 (CST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Thu, 27 Jun 2019 22:44:59 +0800
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-pci@vger.kernel.org>,
        =?UTF-8?q?Martin=20Mare=C5=A1?= <mj@ucw.cz>
CC:     <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <jcm@redhat.com>, <nariman.poushin@linaro.org>,
        <linuxarm@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 1/2] lspci: CCIX DVSEC initial support
Date:   Thu, 27 Jun 2019 22:43:54 +0800
Message-ID: <20190627144355.27913-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627144355.27913-1-Jonathan.Cameron@huawei.com>
References: <20190627144355.27913-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The CCIX Base Specification 1.0, www.ccixconsortium.org
describes the PCI DVSEC based configuration space for
CCIX elements and topology.

This patch:
1. Introduces into ls-ecap the ability to call parsers for
   the Designated Vendor-Specific Extended Capablity (DVSEC)
   elements. These may be defined by a particular vendor, or
   as in this case, a consoritium with appropriate unique ID
   issued by the PCI SIG.
2. Parsing of CCIX Transport Layer DVSEC.  This is straight
   forward for devices supporting only PCI defined speeds,
   with a lot more information on devices that also support the
   20GT/s and 25GT/s extended speeds defined in the CCIX spec.
3. Parsing of CCIX Protocol Layer DVSEC. This defines the system
   topology along with agent specific elements.
   * Common Device Capabilities and Control
   * Address and ID routing tables.
   * Protocol Agent Capabilities and Controls.
   * CCIX Protocol Layer Port Capabilities and Controls.
   * CCIX Protocol Layer Link Capabilities and Controls.
   * Protocol Error Controls and Records as needed for RAS
     handling.

The support is fairly complete but for this initial version some
minor elements are not yet reported.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Makefile     |    2 +-
 lib/header.h |    2 +
 ls-ccix.c    | 1364 ++++++++++++++++++++++++++++++++++++++++++++++++++
 ls-ecaps.c   |   28 +-
 lspci.h      |    4 +
 5 files changed, 1398 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index ff51be1..17c9cb2 100644
--- a/Makefile
+++ b/Makefile
@@ -69,7 +69,7 @@ force:
 lib/config.h lib/config.mk:
 	cd lib && ./configure
 
-lspci: lspci.o ls-vpd.o ls-caps.o ls-caps-vendor.o ls-ecaps.o ls-kernel.o ls-tree.o ls-map.o common.o lib/$(PCILIB)
+lspci: lspci.o ls-vpd.o ls-caps.o ls-caps-vendor.o ls-ecaps.o ls-ccix.o ls-kernel.o ls-tree.o ls-map.o common.o lib/$(PCILIB)
 setpci: setpci.o common.o lib/$(PCILIB)
 
 LSPCIINC=lspci.h pciutils.h $(PCIINC)
diff --git a/lib/header.h b/lib/header.h
index bfdcc80..c790821 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -1354,6 +1354,8 @@
 
 #define PCI_VENDOR_ID_INTEL		0x8086
 #define PCI_VENDOR_ID_COMPAQ		0x0e11
+/* Note that this is a PCISIG Issued Unique Value rather than a Vendor ID */
+#define PCI_VENDOR_ID_CCIX              0x1e2c
 
 /* I/O resource flags, compatible with <include/linux/ioport.h> */
 
diff --git a/ls-ccix.c b/ls-ccix.c
new file mode 100644
index 0000000..c9f156e
--- /dev/null
+++ b/ls-ccix.c
@@ -0,0 +1,1364 @@
+/*
+ *	The PCI Utilities -- Show CCIX Capabilities
+ *
+ *	Copyright (c) 2018 Jonathan Cameron <Jonathan.Cameron@huawei.com>
+ *
+ *	Can be freely distributed and used under the terms of the GNU GPL.
+ */
+
+#include <stdio.h>
+#include <string.h>
+
+#include "lspci.h"
+
+#define ARRAY_SIZE(x) sizeof(x)/sizeof(*(x))
+
+struct ccix_state {
+  int portagg_capable:1;
+  int sw_portal_capable:1;
+  int forwarding:1;
+  u32 dev_error_log_offset;
+  u32 idm_table_offset;
+  u32 sr_table_offset;
+  u32 hsam_table_offset;
+  u32 hsam_table_size;
+  u32 rsam_table_offset;
+  u32 rsam_table_size;
+  u32 links;
+  int ra_found, ra_ctl_found;
+  u32 ha_num_ids[64];
+  u32 ha_num_pools[64];
+  int ha_found, ha_ctl_found;
+  u32 sa_num_pools[64];
+  int sa_found, sa_ctl_found;
+  u32 psamnum;
+  u32 port_error_offset;
+  u32 link_error_offset;
+  u32 sa_error_offset[64];
+  u32 ra_error_offset[64];
+  u32 ha_error_offset[64];
+};
+
+/* Where is not always aligned, hence use byte reads */
+static void
+ccix_vendor_error(struct device *d, int where)
+{
+  u8 buff, buff2;
+  u16 len;
+
+  buff = get_conf_byte(d, where);
+  buff2 = get_conf_byte(d, where + 1);
+  len = (u16)buff2 << 8 | buff;
+  printf("\t\t\t\t\t\tVenSpecLen:\t%u\n", len);
+}
+
+/*
+ * Note used both for mem pool definition in which it
+ * is only 3 bits and for memory errors in which it is
+ * a byte with vendor defined upper half.
+ */
+static const char * ccix_sub_mem_types[8] = {
+  "NotSpecified", "SRAM", "DDR", "NVDIMM-F",
+  "NVDIMM-N", "HBM", "FLASH", "Unknown"
+};
+
+static const char * ccix_operation_type[11] = {
+  "GenericUndetermined", "GenericRead", "GenericWrite",
+  "DataRead", "DataWrite", "InstructionFetch", "Prefetch",
+  "Eviction", "Snooping", "Snooped", "Management",
+};
+
+static void
+ccix_memory_error(struct device *d, int where)
+{
+  static const char * memory_type[] = {
+    "Other/NonSpec", "ROM", "Volatile", "NonVolatile", "Device",
+  };
+  static const char * memory_error_type[] = {
+    "Unknown", "NoError", "SingleBitECC", "MultiBitECC",
+    "SingleSymbolChipKillECC", "MultiSymbolChipKillECC",
+    "MasterAbort", "TargetAbort", "ParityError", "WatchDog",
+    "InvalidAddr", "MirrorBroken", "MemorySparing", "Scrub",
+    "PhysicalMemMapOutEvent",
+  };
+  static const char * memory_operation[] = {
+    "Generic", "Read", "Write", NULL, "Scrub",
+  };
+  u32 buff, valbits;
+  u8 value;
+
+  valbits = get_conf_long(d, where);
+  buff = get_conf_long(d, where + 0x4);
+
+  printf("\t\t\t\t\tMemErr:\t");
+  if ((buff & 0xff) == 255)
+    printf("Internal\n");
+  else
+    printf("FRU:\t\t%u\n", buff & 0xff);
+
+  /*
+   * Note we ignore the error message length as it provides no
+   * useful information not conveyed in other ways.
+   */
+  printf("\t\t\t\t\t\tMemType:\t");
+  buff = get_conf_long(d, where + 0x8);
+  if (valbits & 0x01) {
+    value = buff & 0xff;
+    if (value >= 0x80)
+      printf("Vendor 0x%x\n", value);
+    else
+      printf("%s\n", value >= ARRAY_SIZE(memory_type) ?
+	     "Unknown": memory_type[value]);
+  } else
+    printf("Unspecifcied\n");
+
+  printf("\t\t\t\t\t\tOperation:\t");
+  if (valbits & 0x02) {
+    value = (buff >> 8) & 0xff;
+    switch (value) {
+    case 0 ... 2:
+    case 4:
+      printf("%s\n", memory_operation[value]);
+      break;
+    default: printf("Unknown\n"); break;
+    }
+  } else
+    printf("Unspecified\n");
+
+  printf("\t\t\t\t\t\tErrorType:\t");
+  if (valbits & 0x04) {
+    value = (buff >> 16) & 0xff;
+    printf("%s\n", value >= ARRAY_SIZE(memory_error_type) ?
+	   "Unknown" : memory_error_type[value]);
+  } else
+    printf("Unspecified\n");
+
+  printf("\t\t\t\t\t\tChan:\t\t");
+  if (valbits & 0x08)
+    printf("%u\n", (buff >> 24) & 0xff);
+  else
+    printf("Unspecified\n");
+
+  buff = get_conf_long(d, where + 0xc);
+  printf("\t\t\t\t\t\tModule:\t\t");
+  if (valbits & 0x1000)
+    printf("%u\n", buff & 0xffff);
+  else
+    printf("Unspecified\n");
+
+  printf("\t\t\t\t\t\tBank:\t\t");
+  if (valbits & 0x10)
+    printf("%u\n", (buff >> 16) & 0xffff);
+  else
+    printf("Unspecified\n");
+
+  printf("\t\t\t\t\t\tDevice:\t\t");
+  if (valbits & 0x20)
+    printf("%u\n", get_conf_long(d, where + 0x10));
+  else
+    printf("Unspecified\n");
+
+  printf("\t\t\t\t\t\tRow:\t\t");
+  if (valbits & 0x40)
+    printf("%u\n", get_conf_long(d, where + 0x14));
+  else
+    printf("Unspecified\n");
+
+  printf("\t\t\t\t\t\tColumn:\t\t");
+  if (valbits & 0x80)
+    printf("%u\n", get_conf_long(d, where + 0x18));
+  else
+    printf("Unspecified\n");
+
+  printf("\t\t\t\t\t\tRank:\t\t");
+  if (valbits & 0x100)
+    printf("%u\n", get_conf_long(d, where + 0x1c));
+  else
+    printf("Unspecified\n");
+
+  buff = get_conf_long(d, where + 0x20);
+  printf("\t\t\t\t\t\tBitPos:\t\t");
+  if (valbits & 0x200)
+    printf("%u\n", buff & 0xff);
+  else
+    printf("Unspecified\n");
+
+  printf("\t\t\t\t\t\tChipID:\t\t");
+  if (valbits & 0x400)
+    printf("%u\n", (buff >> 8) & 0xff);
+  else
+    printf("Unspecified\n");
+
+  printf("\t\t\t\t\t\tMemPoolType:\t");
+  if (valbits & 0x2000) {
+    value = (buff >> 16) & 0xff;
+    if (value >= 0x80)
+      printf("Vendor 0x%x\n", value);
+    else {
+      printf("%s\n", value >= ARRAY_SIZE(ccix_sub_mem_types) ?
+	     "Unknown": ccix_sub_mem_types[value]);
+    }
+  } else
+    printf("Unspecified\n");
+
+  if (valbits & 0x800)
+    ccix_vendor_error(d, where + 0x23);
+}
+
+static void
+ccix_cache_error(struct device *d, int where)
+{
+  u32 buff, buff2, valbits;
+  u8 value;
+  static const char * ccix_cache_type[4] = {
+    "Instruction", "Data", "Unified", "SnoopFilterDirectory"
+  };
+  static const char * ccix_cache_error_type[6] = {
+    "Data", "Tag", "Timeout", "Hang", "DataLost", "InvalidAddr",
+  };
+
+  valbits = get_conf_long(d, where);
+  buff = get_conf_long(d, where + 0x4);
+  printf("\t\t\t\t\tCacheErr:\n");
+  printf("\t\t\t\t\t\tCacheType:\t");
+  if (valbits & 0x01) {
+    value = (buff >> 16) & 0xff;
+    printf("%s\n", value >= ARRAY_SIZE(ccix_cache_type) ?
+	   "Unknown": ccix_cache_type[value]);
+  } else
+    printf("Unspecified\n");
+
+  printf("\t\t\t\t\t\tOperationType:\t");
+  if (valbits & 0x2) {
+    value = (buff >> 24) & 0xff;
+    printf("%s\n", value >= ARRAY_SIZE(ccix_operation_type) ?
+	   "Unknown" : ccix_operation_type[value]);
+  } else
+    printf("Unspecified\n");
+  buff = get_conf_long(d, where + 0x8);
+  printf("\t\t\t\t\t\tCacheError:\t");
+  if (valbits & 0x4) {
+    value = buff & 0xff;
+    printf("%s\n", value >= ARRAY_SIZE(ccix_cache_error_type) ?
+	   "Unknown" : ccix_cache_error_type[value]);
+  } else 
+    printf("Unspecified\n");
+
+  printf("\t\t\t\t\t\tLevel:\t\t");
+  if (valbits & 0x8)
+    printf("%u\n", (buff >> 8) & 0xff);
+  else
+    printf("Unspecified\n");
+
+  buff2 = get_conf_long(d, where + 0xc);
+  printf("\t\t\t\t\t\tSet:\t\t");
+  if (valbits & 0x10)
+    printf("%u\n", (buff >> 16) & 0xffff | ((buff2 & 0xffff) << 16));
+  else
+    printf("Unspecified\n");
+
+  buff = buff2;
+  buff2 = get_conf_long(d, where + 0x10);
+  printf("\t\t\t\t\t\tWay:\t\t");
+  if (valbits & 0x20)
+    printf("%u\n", (buff >> 16) & 0xffff | ((buff2 & 0xffff) << 16));
+  else
+    printf("Unspecified\n");
+
+  buff = buff2;
+  printf("\t\t\t\t\t\tInstanceID:\t");
+  if (valbits & 0x40)
+    printf("%u\n", (buff >> 16) & 0xff);
+  else
+    printf("Unspecified\n");
+
+  if (valbits & 0x80)
+    ccix_vendor_error(d, where + 0x14);
+}
+static void
+ccix_atc_error(struct device *d, int where)
+{
+  u32 buff, valbits;
+  u8 value;
+
+  valbits = get_conf_long(d, where);
+  buff = get_conf_long(d, where + 0x4);
+  printf("\t\t\t\t\tATCErr:\n");
+  printf("\t\t\t\t\t\tOperationType:\t");
+  if (valbits & 0x1) {
+    value = (buff >> 16) & 0xff;
+    switch (value) {
+    case 0 ... 10:
+      printf("%s\n", ccix_operation_type[value]);
+      break;
+    default:
+      printf("Unknown\n");
+      break;
+    }
+  } else
+    printf("Unspecified\n");
+
+  printf("\t\t\t\t\t\tInstanceID:\t");
+  if (valbits & 0x02)
+    printf("%u\n", buff >> 24);
+  else
+    printf("Unspecified\n");
+
+  if (valbits & 0x04)
+    ccix_vendor_error(d, where + 0x0c);
+}
+
+static void
+ccix_port_error(struct device *d, int where)
+{
+  static const char * port_op_type[] = {
+    "Command", "Read", "Write"
+  };
+  static const char * port_error_type[8] = {
+    "Generic", "BusParrity", "NoBDF", "AddrInval",
+    "IDInval", "Timeout", "Hang", "EgressBlk"
+  };
+  u32 buff, valbits;
+  u8 value;
+
+  buff = get_conf_long(d, where);
+  valbits = buff & 0xf;
+  buff = get_conf_long(d, where + 0x4);
+  printf("\t\t\t\t\tPortErr:\n");
+  printf("\t\t\t\t\t\tOperation:\t");
+  if (valbits & 0x1) {
+    value = (buff >> 16) & 0xff;
+    printf("%s\n", value >= ARRAY_SIZE(port_op_type) ?
+	   "Unknown" : port_op_type[value]);
+  } else {
+    printf("Unspecified\n");
+  }
+
+  printf("\t\t\t\t\t\tPortErrType:\t");
+  if (valbits & 0x2) {
+    value = (buff >> 24) & 0xff;
+    printf("%s\n", value >= ARRAY_SIZE(port_error_type) ?
+	   "Unknown" : port_error_type[value]);
+  } else {
+    printf("Unspecified\n");
+  }
+
+  /* We could report the raw CCIX message header if present */
+  printf("\t\t\t\t\t\tCCIX Message:\t"); 
+  if (valbits & 0x04)
+    printf("Present\n");
+  else
+    printf("Unspecified\n");
+
+  if (valbits & 0x08)
+    ccix_vendor_error(d, where + 0x28);
+}
+
+static void
+ccix_link_error(struct device *d, int where)
+{
+  u32 buff, valbits;
+  u8 value;
+  const char * link_op_types[3] = {
+    "Command", "Read", "Write",
+  };
+  const char * link_error_types[5] = {
+    "Generic", "CreditUnderflow", "CreditOverflow",
+    "UnusableCreditReceived", "CreditTimeout"
+  };
+
+  valbits = get_conf_long(d, where);
+  buff = get_conf_long(d, where + 0x4);
+  printf("\t\t\t\t\tLinkErr:\n");
+  printf("\t\t\t\t\t\tOperationType:\t");
+  if (valbits & 0x1) {
+    value = (buff >> 16) & 0xff;
+    printf("%s\n", value >= ARRAY_SIZE(link_op_types) ?
+	   "Unknown" : link_op_types[value]);
+  } else
+    printf("Unspecified\n");
+
+  printf("\t\t\t\t\t\tErrorType:\t");
+  if (valbits & 0x02) {
+    value = buff >> 24;
+    printf("%s\n", value >= ARRAY_SIZE(link_error_types) ?
+	   "Unknown" : link_error_types[value]);
+  } else
+    printf("Unspecified\n");
+
+  buff = get_conf_long(d, where + 0x8);
+  printf("\t\t\t\t\t\tLinkID:\t\t");
+  if (valbits & 0x04)
+    printf("%u\n", buff & 0xff);
+  else
+    printf("Unspecified\n");
+
+  printf("\t\t\t\t\t\tLinkCreditType:\t");
+  if (valbits & 0x08)
+    printf("%u\n", (buff >> 8) & 0xff);
+  else
+    printf("Unspecified\n");
+
+  printf("\t\t\t\t\t\tCCIX Message:\t");
+  if (valbits & 0x10)
+    printf("Present\n");
+  else
+    printf("Unspecified\n");
+
+  if (valbits & 0x20)
+    ccix_vendor_error(d, where + 0x2c);
+}
+
+static void
+ccix_agent_error(struct device *d, int where)
+{
+  u32 valbits;
+
+  valbits = get_conf_long(d, where);
+  printf("\t\t\t\t\tInterErr:\n");
+  if (valbits & 0x01)
+    ccix_vendor_error(d, where + 0x8);
+}
+
+/* Does it make sense to do these in lspci? */
+static void
+ccix_error_log(struct device *d, int where)
+{
+  u32 buff, buff2;
+  u8 value;
+  u8 error_type;
+  int vendor_specific;
+
+  static const char * ccix_element[5] = {
+    "RA", "HA", "SA", "Port", "Link"
+  };
+
+  buff = get_conf_long(d, where);
+
+  printf("\t\t\t\tPER [%03x]:\tLogVersion: %u, ME%c ",
+	 where, buff & 0xff, FLAG(buff, 0x8000));
+  buff = get_conf_long(d, where + 0x4);
+  printf("SevUE%c SevNoComm%c SevDegraded%c SevDeferred%c\n",
+	 FLAG(buff, 0x10000), FLAG(buff, 0x20000),
+	 FLAG(buff, 0x40000), FLAG(buff, 0x80000));
+  printf("\t\t\t\t\tComponent:\t");
+  value = (buff >> 12) & 0xf;
+  printf("%s\n", value >= ARRAY_SIZE(ccix_element) ?
+	 "Unknown" : ccix_element[value]);
+  error_type = (buff >> 24) & 0x7;
+  vendor_specific = (buff >> 31) & 0x1;
+  printf("\t\t\t\t\tAddress:\t");
+  if ((buff >> 30) & 0x1) {
+    buff = get_conf_long(d, where + 0x8);
+    buff2 = get_conf_long(d, where + 0xc);
+    printf("[0x%016lx], ", (u64)buff2 << 32 | (buff & 0xfffffffc));
+    buff = get_conf_long(d, where + 0x10);
+    printf("MaskLen: %u\n", buff & 0x3f);
+  } else
+    printf("NotValid\n");
+
+  if (!vendor_specific) {
+    switch(error_type) {
+    case 0:
+      ccix_memory_error(d, where + 0x14);
+      break;
+    case 1:
+      ccix_cache_error(d, where + 0x14);
+      break;
+    case 2:
+      ccix_atc_error(d, where + 0x14);
+      break;
+    case 3:
+      ccix_port_error(d, where + 0x14);
+      break;
+    case 4:
+      ccix_link_error(d, where + 0x14);
+      break;
+    case 5:
+      ccix_agent_error(d, where + 0x14);
+      break;
+    default:
+      printf("\t\t\t\t\tUnknownErr:\n");
+      break;
+    }
+  } else {
+    printf("\t\t\t\t\tVendorSpecific\n");
+  }
+}
+
+static void
+ccix_mem_pool(struct device *d, int where, int i)
+{
+  u32 buff, buff2;
+  u64 pool_size;
+  static const char * ccix_mem_types[8] = {
+    "Other", "Expansion", "Hole", "ROM",
+    "Volatile", "Non-Volatile", "Device", "Unknown"
+  };
+  static const char * ccix_mem_attr[8] = {
+    "Device", "Unknown", "Unknown", "Unknown",
+    "Non-Cacheable", "Cacheable", "Unknown", "Unknown"
+  };
+  static const char * ccix_mem_ext_attr[8] = {
+    "System", "Private", "Unknown", "Unknown",
+    "Unknown", "Unknown", "Unknown", "Unknown"
+  };
+
+  buff = get_conf_long(d, where);
+  printf("\t\t\t\tPool #%u:\tReady%c ", i, FLAG(buff, 0x1));
+  printf("%s/%s/%s/%s\n",
+	 ccix_mem_types[(buff >> 1) & 0x7],
+	 ccix_sub_mem_types[(buff >> 4) & 0x7],
+	 ccix_mem_attr[(buff >> 8) & 0x7],
+	 ccix_mem_ext_attr[(buff >> 11) & 0x7]);
+  printf("\t\t\t\t\t\tNon4GBAligned%c\n", FLAG(buff, 0x80));
+
+  buff2 = get_conf_long(d, where + 0x4);
+  pool_size = (((u64)buff2 << 16 | ((buff >> 16) & 0xffff)) + 1) * 65536;
+  printf("\t\t\t\t\t\tSize: ");
+  if (pool_size & 0x3ff == 0)
+    printf("%lu B", pool_size);
+  else {
+    if (pool_size & 0xfffff)
+      printf("%lu kB", pool_size >> 10);
+    else {
+      if (pool_size & 0x3fffffff)
+	printf("%lu MB", pool_size >> 20);
+      else {
+	if (pool_size & 0xffffffffff)
+	  printf("%lu GB", pool_size >> 30);
+	else
+	  printf("%lu TB", pool_size >> 40);
+      }
+    }
+  }
+  printf("\n");
+}
+
+static void
+ccix_bat(struct device *d, int where, int i)
+{
+  u32 buff;
+
+  buff = get_conf_long(d, where);
+  printf("\t\t\t\tPool #%u:\tValid%c ", i, FLAG(buff, 0x1));
+  buff = get_conf_long(d, where + 0x4);
+  printf("BaseAddr: [0x%016lx]\n", (u64)buff << 32);
+}
+
+static void
+ccix_error_ctl_stat(struct device *d, int where, int *error)
+{
+  u32 buff;
+
+  buff = get_conf_long(d, where);
+  printf("\t\t\t\tErrCtlSta1:\tCurrent: ");
+  switch (buff & 0x3) {
+  case 0:
+    printf("No error, ");
+    *error = 0;
+    break;
+  case 1:
+    printf("Error pending, ");
+    *error = 1;
+    break;
+  case 2:
+    printf("Invalid, ");
+    *error = 0;
+    break;
+  case 3:
+    printf("Error pending / PER Sent, ");
+    *error = 1;
+    break;
+  }
+  printf("LogDisable%c PERMsgDisable%c\n", FLAG(buff, 0x2), FLAG(buff, 0x4));
+  buff = get_conf_long(d, where + 0x4);
+  printf("\t\t\t\tErrCtlSta2:\tSevLogMask: 0x%02x, SevPERMsgMask: 0x%02x\n",
+	 buff & 0x3f, (buff >> 8) & 0x3f);
+  printf("\t\t\t\tTypeMaskR/L:\tMem%c/%c Cache%c/%c ATC%c/%c Port%c/%c Agent%c/%c\n",
+	 FLAG(buff, 0x0010000), FLAG(buff, 0x0020000),
+	 FLAG(buff, 0x0040000), FLAG(buff, 0x0080000),
+	 FLAG(buff, 0x0100000), FLAG(buff, 0x0200000),
+	 FLAG(buff, 0x0400000), FLAG(buff, 0x0800000),
+	 FLAG(buff, 0x1000000), FLAG(buff, 0x2000000));
+}
+
+static void
+ccix_sa_cap(struct device *d, int where, struct ccix_state *state)
+{
+  u32 buff;
+  unsigned i;
+
+  buff = get_conf_long(d, where + 0x4);
+  state->sa_num_pools[state->sa_found] = (buff >> 4) & 0x3f;
+  printf("\t\t\t\tSACapStat:\tDiscRdyStat%c MemPoolRdy%c NumMemPool: %u\n",
+	 FLAG(buff, 0x1), FLAG(buff, 0x80000000), (buff >> 4) & 0x3f);
+  state->sa_error_offset[state->sa_found] = get_conf_long(d, where + 0x8) >> 20;
+  for (i = 0; i < state->sa_num_pools[state->sa_found]; i++)
+    ccix_mem_pool(d, where + 0x0c + i * 8, i);
+
+  state->sa_found++;
+}
+
+static void
+ccix_sa_ctl(struct device *d, int where, struct ccix_state *state)
+{
+  u32 buff;
+  unsigned i;
+  int num_sbat, error;
+
+  buff = get_conf_long(d, where + 0x4);
+  num_sbat = (buff >> 4) & 0x3f;
+  printf("\t\t\t\tSACtl:\tEnable%c SAID: %02u, NumSBATEnable: %02u\n",
+	 FLAG(buff, 0x1), (buff >> 26) & 0x3f, num_sbat);
+
+  ccix_error_ctl_stat(d, where + 0x8, &error);
+  if (error && state->sa_error_offset[state->sa_ctl_found])
+    ccix_error_log(d, state->sa_error_offset[state->sa_ctl_found]);
+
+  for (i = 0; i < state->sa_num_pools[state->sa_ctl_found]; i++)
+    ccix_bat(d, where + 0x10 + 8 * i, i);
+  state->sa_ctl_found++;
+}
+
+static void
+ccix_ra_cap(struct device *d, int where, struct ccix_state *state)
+{
+  u32 buff;
+
+  buff = get_conf_long(d, where + 0x4);
+  printf("\t\t\t\tRACapStat:\tDiscRdyStat%c CacheFlushStat%c\n",
+	 FLAG(buff, 0x1), FLAG(buff, 0x80000000));
+  state->ra_error_offset[state->ra_found] = get_conf_long(d, where + 0x8) >> 20;
+
+  state->ra_found++;
+}
+
+static void
+ccix_ra_ctl(struct device *d, int where, struct ccix_state *state UNUSED)
+{
+  u32 buff;
+  int error;
+
+  buff = get_conf_long(d, where + 0x4);
+  printf("\t\t\t\tRACtl:\tID: %02u, Enable%c SnpRespEnable%c CacheFlush%c CacheEnable%c\n",
+	 (buff >> 26) & 0x3f, FLAG(buff, 0x1), FLAG(buff, 0x2),
+	 FLAG(buff, 0x4000), FLAG(buff, 0x8000));
+
+  ccix_error_ctl_stat(d, where + 0x8, &error);
+  if (error && state->ra_error_offset[state->ra_ctl_found])
+    ccix_error_log(d, state->ra_error_offset[state->ra_ctl_found]);
+
+  state->ra_ctl_found++;
+}
+
+static void
+ccix_ha_cap(struct device *d, int where, struct ccix_state *state)
+{
+  u32 buff;
+  unsigned i;
+
+  buff = get_conf_long(d, where + 0x4);
+  state->ha_num_ids[state->ha_found] = ((buff >> 1) & 0x3f) + 1;
+
+  printf("\t\t\t\tHACapStat:\tDiscRdyStat%c MemPoolRdy%c MemExp%c NumHAID: %u, NumMemPool: %u\n",
+	 FLAG(buff, 0x1), FLAG(buff, 0x80000000), FLAG(buff, 0x10000),
+	 ((buff >> 1) & 0x3f) + 1, (buff >> 8) & 0x3f);
+  state->ha_num_pools[state->ha_found] = (buff >> 8) & 0x3f;
+
+  state->ha_error_offset[state->ha_found] = get_conf_long(d, where + 0x8) >> 20;
+
+  for (i = 0; i < state->ha_num_pools[state->ha_found]; i++)
+    ccix_mem_pool(d, where + 0xc + i * 8, i);
+
+  state->ha_found++;
+}
+
+static void
+ccix_ha_ctl(struct device *d, int where, struct ccix_state *state)
+{
+  u32 buff, buff2;
+  int error;
+  unsigned i, j;
+  unsigned hbat_start = 0x18 + ((state->ha_num_ids[state->ha_ctl_found] - 1) / 4 + 1) * 4;
+
+  buff = get_conf_long(d, where + 0x4);
+  printf("\t\t\t\tHACtl:\tEnable%c MemExpEnable%c HBatEnabled: %u\n", FLAG(buff, 0x1),
+	 FLAG(buff, 0x10000), (buff >> 8) & 0x3f);
+
+  buff = get_conf_long(d, where + 0x8);
+  buff2 = get_conf_long(d, where + 0xc);
+  printf("\t\t\t\tRAIDV:\t0x%016lx\n", ((u64)buff2 << 32) | buff);
+  ccix_error_ctl_stat(d, where + 0x10, &error);
+
+  if (error && state->ha_error_offset[state->ha_ctl_found])
+    ccix_error_log(d, state->ha_error_offset[state->ha_ctl_found]);
+
+  for (i = 0; i <= (state->ha_num_ids[state->ha_ctl_found] - 1) / 4; i++) {
+    buff = get_conf_long(d, where + 0x18 + i * 4);
+    for(j = 0; j < 4; j++) {
+      if (i * 4 + j < state->ha_num_ids[state->ha_ctl_found])
+	printf("\t\t\t\tHA #%02u:\tID: %02u\n", i * 4 + j,
+	       (buff >> (8 * j) & 0x3f));
+    }
+  }
+
+  for (i = 0; i < state->ha_num_pools[state->ha_ctl_found]; i++)
+    ccix_bat(d, where + hbat_start + 8 * i, i);
+
+  state->ha_ctl_found++;
+}
+
+static void
+ccix_link_cap(struct device *d, int where,
+	      struct ccix_state *state UNUSED)
+{
+  u32 buff;
+
+  buff = get_conf_long(d, where + 0x4);
+  printf("\t\t\t\tLinkCap:\tRdy%c SharedCredits%c MsgPack%c NoCompAck%c ",
+	 FLAG(buff, 0x1), FLAG(buff, 0x2), FLAG(buff, 0x4), FLAG(buff, 0x8));
+  printf("MaxPktSize: ");
+  switch (buff >> 7 & 0x7) {
+  case 0: printf("128B "); break;
+  case 1: printf("256B "); break;
+  case 2: printf("512B "); break;
+  default: printf("Unknown "); break;
+  };
+  printf("\n");
+
+  buff = get_conf_long(d, where + 0x8);
+  printf("\t\t\t\tLinkSendCap:\tMaxMemReq: %u, MaxSnpReq: %u, MaxDatReq: %u\n",
+	 buff & 0x3f, (buff >> 10) & 0x3f, (buff >> 20) & 0x3f);
+
+  buff = get_conf_long(d, where + 0xc);
+  printf("\t\t\t\tLinkRcvCap:\tMaxMemReq: %u, MaxSnpReq: %u, MaxDatReq: %u\n",
+	 buff & 0x3f, (buff >> 10) & 0x3f, (buff >> 20) & 0x3f);
+
+  buff = get_conf_long(d, where + 0x10);
+  printf("\t\t\t\tMiscCap:\tMaxMiscReqSend: %u, MaxMiscReqRcv %u\n",
+	 buff & 0x3f, (buff >> 10) & 0x3f);
+  state->link_error_offset = get_conf_long(d, where + 0x14) >> 20;
+}
+
+static void
+ccix_link_ctl(struct device *d, int where, struct ccix_state *state)
+{
+  u32 buff, buff2;
+  unsigned int i;
+  int error;
+  u16 BDF;
+  int link_len = state->forwarding ? 8 * 4 : 6 * 4;
+
+  for (i = 0; i < state->links; i++) {
+    printf("\t\t\t\tLink#%02u [%x]\n", i, where + i * link_len + 0x4);
+
+    buff = get_conf_long(d, where + i * link_len + 0x4);
+    printf("\t\t\t\tLinkCtl:\tEnable%c CreditSnd%c MsgPack%c NoCmpAck%c ",
+	   FLAG(buff, 0x1), FLAG(buff, 0x2), FLAG(buff, 0x4), FLAG(buff, 0x40));
+    printf("MaxPktSize: ");
+    switch (buff >> 7 & 0x7) {
+    case 0: printf("128B "); break;
+    case 1: printf("256B "); break;
+    case 2: printf("512B "); break;
+    default: printf("Unknown "); break;
+    };
+    printf("\n");
+    printf("\t\t\t\t\t\t");
+    if ((buff >> 10) & 0x1)
+      printf("HA-to-SA\n");
+    else
+      printf("RA-to-HA\n");
+
+    buff = get_conf_long(d, where + i * link_len + 0x8);
+    /* Print misc credits along with others */
+    buff2 = get_conf_long(d, where + i * link_len + 0x10);
+    printf("\t\t\t\tMaxCredit:\tMem: %04u, Snoop: %04u, Data %04u, Misc %04u\n",
+	   buff & 0x3ff, (buff >> 10) & 0x3ff, (buff >> 20) & 0x3ff,
+	   buff2 & 0x3ff);
+
+    buff = get_conf_long(d, where + i * link_len + 0xc);
+    printf("\t\t\t\tMinCredit:\tMem: %04u, Snoop: %04u, Data %04u, Misc %04u\n",
+	   buff & 0x3ff, (buff >> 10) & 0x3ff, (buff >> 20) & 0x3ff,
+	   (buff2 >> 10) & 0x3ff);
+
+    if (state->forwarding) {
+      buff = get_conf_long(d, where + i * link_len + 0x20);
+      buff2 = get_conf_long(d, where + i * link_len + 0x24);
+      printf("\t\t\t\tBcastFwd:\t0x%016lx\n", (u64)buff2 << 32 | buff);
+    }
+
+    /*
+     * Transport ID map - comes after the control block, but eiaer to follow here
+     * where it is associated with the link's other information
+     */
+    buff = get_conf_long(d, where + state->links * link_len + 0x4 + 4 * i);
+    BDF = buff & 0xffff;
+    printf("\t\t\t\tDestBDF:\t%02x:%02x.%d\n",
+	   BDF >> 8, (BDF >> 3) & 0x1f, BDF & 0x7);
+
+    ccix_error_ctl_stat(d, where + i * link_len + 0x14, &error);
+    if (error && state->link_error_offset)
+      ccix_error_log(d, state->link_error_offset);
+  }
+}
+
+static void
+ccix_port_cap(struct device *d, int where, struct ccix_state *state)
+{
+  u32 buff;
+
+  buff = get_conf_long(d, where + 0x4);
+  printf("\t\t\t\tPortCap:\t");
+  printf("Port #%u Rdy%c OptTLP%c P2PForward%c ", buff >> 27,
+	 FLAG(buff, 0x1), FLAG(buff, 0x2), FLAG(buff, 0x10));
+  state->links = (buff >> 7) & 0x3f;
+  state->forwarding = (buff >> 4);
+  printf("Links: %u ", state->links);
+  state->psamnum = (buff >> 13) & 0x3f;
+  printf("PSAMNum: %u ", state->psamnum);
+  printf("\n");
+
+  buff = get_conf_long(d, where + 0x8);
+  printf("\t\t\t\tPortCap2:\tAgg Mask 0x%x\n", buff & 0xff);
+
+  buff = get_conf_long(d, where + 0xc);
+  printf("\t\t\t\tPortCap3:\tFW Mask 0x%x\n", buff & 0xff);
+
+  buff = get_conf_long(d, where + 0x10);
+  state->port_error_offset = buff >> 20;
+}
+
+static void
+ccix_port_ctl(struct device *d, int where,
+	      struct ccix_state *state UNUSED)
+{
+  u32 buff;
+  u32 psamnum;
+  u32 i;
+  int error = 0;
+  u16 BDF;
+
+  buff = get_conf_long(d, where + 0x4);
+  psamnum =  (buff >> 13) & 0x3f;
+  printf("\t\t\t\tPortCntrl:\tEnable%c OptTLP%c LinksEnabled: %u, PSAMNum: %u\n",
+	 FLAG(buff, 0x1), FLAG(buff, 0x2), (buff >> 7) & 0x3f, psamnum);
+
+  ccix_error_ctl_stat(d, where + 0x8, &error);
+  buff = get_conf_long(d, where + 0x10);
+  BDF = buff & 0xffff;
+  printf("\t\t\t\tSourceTransportID: %02x:%02x.%d\n",
+	 BDF >> 8, (BDF >> 3) & 0x1f, BDF & 0x7);
+
+  for (i = 0; i < state->psamnum; i++) {
+    buff = get_conf_long(d, where + 0x14 + 12 * i);
+    printf("\t\t\t\tPSamEntry%02u: Valid%c Link%02u ", i,
+	   FLAG(buff, 0x1), (buff >> 9) & 0x3f);
+    if (buff & (1 << 15))
+      printf("HA-to-SA ");
+    else
+      printf("RA-to-HA ");
+    printf("[0x%016lx-0x%016lx]\n",
+	   (uint64_t)get_conf_long(d, where + 0x14 + 12 * i + 4) << 32,
+	   (uint64_t)get_conf_long(d, where + 0x14 + 12 * i + 8) << 32);
+  }
+  if (error && state->port_error_offset)
+    ccix_error_log(d, state->port_error_offset);
+}
+
+static void
+ccix_common_cap(struct device *d, int where, struct ccix_state *state)
+{
+  u32 buff;
+  int mesh_capable = 0;
+  u64 sw_portal_size;
+
+  buff = get_conf_long(d, where + 0x4);
+  printf("\t\t\t\tCommonCap:\t");
+  printf("DevID: %u ", (buff >> 24) & 0xff);
+  printf("StructVer: %u ", (buff >> 22) & 0x3);
+  if (buff & 0x1) {
+    printf("MultiPort+ ");
+    if (buff & 0x4) {
+      printf("Mesh+ ");
+      mesh_capable = 1;
+    }
+    else
+      printf("Mesh- ");
+  } else
+    printf("DevMultiPort- ");
+  if (buff & 0x2) {
+    printf("PrimaryPort\n");
+
+    buff = get_conf_long(d, where + 0x8);
+    printf("\t\t\t\tCommonCap2:\tRdy%c PartialCache%c PortAgg%c 128B%c MultiHop%c SamAlign%c ",
+	   FLAG(buff, 0x1), FLAG(buff, 0x2), FLAG(buff, 0x4),
+	   FLAG(buff, 0x8), FLAG(buff, 0x80), FLAG(buff, 0x200));
+    state->portagg_capable = (buff >> 3) & 0x1;
+    if (buff & (1 << 8)) {
+      printf("SWPort+ ");
+      state->sw_portal_capable = 1;
+    }
+    else
+      printf("SWPort- ");
+    printf("\n");
+
+    printf("\t\t\t\t\t\tAddrWidth: ");
+    switch ((buff >> 4) & 0x7) {
+    case 0x0: printf("48 bit, "); break;
+    case 0x1: printf("52 bit, "); break;
+    case 0x2: printf("56 bit, "); break;
+    case 0x3: printf("60 bit, "); break;
+    case 0x4: printf("64 bit, "); break;
+    default: printf("unknown, "); break;
+    }
+    printf("DataRdyTime: %u * 32^%u\n",
+	   (buff >> 19) & 0x3f, (buff >> 28) & 0x7);
+    if (state->sw_portal_capable) {
+      buff = get_conf_long(d, where + 0x20 + mesh_capable ? 4 : 0);
+      sw_portal_size = (u64)buff * 65636;;
+      printf("\t\t\t\t\t\tSWPortalSize: ");
+      if (sw_portal_size & 0x3ff)
+	printf("%lu B", sw_portal_size);
+      else {
+	if (sw_portal_size & 0xfffff)
+	  printf("%lu kB", sw_portal_size >> 10);
+	else {
+	  if (sw_portal_size & 0x3fffffff)
+	    printf("%lu MB", sw_portal_size >> 20);
+	  else {
+	    if (sw_portal_size & 0xffffffffff)
+	      printf("%lu GB", sw_portal_size >> 30);
+	    else
+	      printf("%lu TB", sw_portal_size >> 40);
+	  }
+	}
+      }
+      printf("\n");
+    }
+    state->dev_error_log_offset = get_conf_long(d, where + 0x10) >> 20;
+    state->idm_table_offset = get_conf_long(d, where + 0x14) >> 20;
+    buff = get_conf_long(d, where + 0x18);
+    state->rsam_table_offset = buff >> 20;
+    state->rsam_table_size = buff & 0xfff;
+    buff = get_conf_long(d, where + 0x1c);
+    state->hsam_table_offset = buff >> 20;
+    state->hsam_table_size = buff & 0xfff;
+    if (mesh_capable)
+      state->sr_table_offset = get_conf_long(d, where + 0x20) >> 20;
+  }
+  else
+    printf("SecondaryPort\n");
+
+  if (state->dev_error_log_offset)
+   ccix_error_log(d, state->dev_error_log_offset);
+}
+
+static void
+ccix_common_ctl(struct device *d, int where, struct ccix_state *state)
+{
+  u32 buff, buff2;
+  int offset = 0;
+
+  buff = get_conf_long(d, where + 0x4);
+  printf("\t\t\t\tCommCtl1:\tDeviceEnable%c PrimaryPortEnable%c Mesh%c PortAgg%c\n",
+	 FLAG(buff, 0x1), FLAG(buff, 0x2), FLAG(buff, 0x4), FLAG(buff, 0x10));
+  printf("\t\t\t\t\t\tIDMTableValid%c RSAMTableValid%c HSAMTableValid%c SWPort%c\n",
+	 FLAG(buff, 0x20), FLAG(buff, 0x40),
+	 FLAG(buff, 0x80), FLAG(buff, 0x100));
+  printf("\t\t\t\t\t\tErrorAgent: %u, DevID: %u\n",
+	 (buff >> 16) & 0x3f, (buff >> 24) & 0xff);
+
+  buff = get_conf_long(d, where + 0x8);
+  printf("\t\t\t\tCommCtl2:\tPartialCache%c 128B%c ",
+	 FLAG(buff, 0x2), FLAG(buff, 0x8));
+  printf("AddrWidth: ");
+  switch ((buff >> 4) & 0x7) {
+  case 0x0: printf("48 bit\n"); break;
+  case 0x1: printf("52 bit\n"); break;
+  case 0x2: printf("56 bit\n"); break;
+  case 0x3: printf("60 bit\n"); break;
+  case 0x4: printf("64 bit\n"); break;
+  default: printf("unknown\n "); break;
+  }
+
+  buff = get_conf_long(d, where + 0xc);
+  printf("\t\t\t\tDevErrCtl:\tEnable%c\n", FLAG(buff, 0x1));
+  if ((state->forwarding && !state->ha_found &&
+       !state->ra_found && state->portagg_capable) ||
+      (!state->forwarding && state->portagg_capable &&
+       state->ha_found && !state->ra_found)) {
+    buff = get_conf_long(d, where + 0x10);
+    buff2 = get_conf_long(d, where + 0x14);
+    printf("\t\t\t\tSnpRqHM:\tHashMask: 0x%016lx\n",
+	   ((u64)buff2 << 32) | (buff & 0xffffffc0));
+
+    offset += 8;
+  }
+  if (state->sw_portal_capable) {
+    buff = get_conf_long(d, where + 0x10 + offset);
+    printf("\t\t\t\tSWPortal:\tBaseAddress = [0x%016lx]\n",
+	   (u64)buff << 32);
+  }
+}
+
+static void
+ccix_sam_entry(struct device *d, unsigned int index, int where)
+{
+  u32 buff, buff2;
+  buff = get_conf_long(d, where);
+  printf("\t\t\t\t#%02u: Enable%c ", index, FLAG(buff, 0x1));
+  if (buff & 0x2) {
+    printf("Port#%02u ", (buff >> 4) & 0xf);
+    printf("NumAgg: %02u\t", ((buff >> 10) & 0xf) + 1);
+  } else
+    printf("Local\t\t");
+
+  buff = get_conf_long(d, where + 0x4);
+  buff2 = get_conf_long(d, where + 0x8);
+  printf("[0x%016lx:0x%016lx]\n", ((u64)buff) << 32, ((u64)buff2) << 32);
+}
+
+static void
+ccix_protocol_dvsec(struct device *d, int where, int len)
+{
+  struct ccix_handler {
+    const char * name;
+    void (*cap_handler)(struct device *d, int where, struct ccix_state *state);
+    void (*ctl_handler)(struct device *d, int where, struct ccix_state *state);
+  };
+  static const struct ccix_handler ccix_handlers[11] = {
+    [0x0] = { "General", NULL, NULL, },
+    [0x1] = { "Unexpcted TL DVSEC", NULL, NULL, },
+    [0x2] = { "Unexpected PRL DVSEC", NULL, NULL, },
+    [0x3] = { "Common", ccix_common_cap, ccix_common_ctl, },
+    [0x4] = { "Port", ccix_port_cap, ccix_port_ctl, },
+    [0x5] = { "Link", ccix_link_cap, ccix_link_ctl, },
+    [0x6] = { "Home Agent", ccix_ha_cap, ccix_ha_ctl, },
+    [0x7] = { "Unknown", NULL, NULL, },
+    [0x8] = { "Request Agent", ccix_ra_cap, ccix_ra_ctl, },
+    [0x9] = { "Unknown", NULL, NULL, },
+    [0xa] = { "Slave Agent", ccix_sa_cap, ccix_sa_ctl, },
+  };
+
+  int i;
+  u32 buff, buff2;
+  u32 guid[4];
+  u32 cap_stat_offset;
+  u32 cnt_offset;
+  u32 sam_entry_offset;
+  u16 element;
+  u16 guid_offset;
+  struct ccix_state state = {};
+
+  printf("Protocol %x %x>\n", where, len);
+
+  buff = get_conf_long(d, where + 0x8);
+  guid_offset = buff >> 20;
+  if (!config_fetch(d, where + 0xc, len - 0xc))
+    return;
+
+  buff = get_conf_long(d, where + 0xc);
+  cap_stat_offset = (buff >> 20) & 0xfff;
+
+  buff = get_conf_long(d, where + 16);
+  cnt_offset = (buff >> 20) & 0xfff;
+
+  while (cap_stat_offset) {
+    buff = get_conf_long(d, cap_stat_offset);
+    element = buff & 0xffff;
+    printf("\t\t\tCCIX Cap [%x v%u] ", cap_stat_offset, (buff >> 16) & 0xf);
+    if (element >= sizeof(ccix_handlers) / sizeof(ccix_handlers[0])) {
+      printf("Unknown\n");
+    } else {
+      printf("%s\n", ccix_handlers[buff & 0xffff].name);
+      if (ccix_handlers[buff & 0xffff].cap_handler)
+	ccix_handlers[buff & 0xffff].cap_handler(d, cap_stat_offset, &state);
+      cap_stat_offset = buff >> 20;
+    }
+  }
+
+  while (cnt_offset) {
+    buff = get_conf_long(d, cnt_offset);
+    printf("\t\t\tCCIX Ctl [%x] ", cnt_offset);
+    element = buff & 0xfff;
+    if (element >= sizeof(ccix_handlers) / sizeof(ccix_handlers[0])) {
+      printf("Unknown\n");
+    } else {
+      printf("%s\n", ccix_handlers[buff & 0xffff].name);
+      if (ccix_handlers[buff & 0xffff].ctl_handler)
+	ccix_handlers[buff & 0xffff].ctl_handler(d, cnt_offset, &state);
+    }
+    cnt_offset = buff >> 20;
+  }
+
+  if (guid_offset) {
+    buff = get_conf_long(d, guid_offset + 16);
+    printf("\t\t\tCCIX CCID OVERRIDE [%x v%d]\n", guid_offset, buff & 0xf);
+    guid[0] = get_conf_long(d, guid_offset);
+    guid[1] = get_conf_long(d, guid_offset + 4);
+    guid[2] = get_conf_long(d, guid_offset + 8);
+    guid[3] = get_conf_long(d, guid_offset + 12);
+    
+    if ((guid[0] != 0xc3cb993b) ||
+	(guid[1] != 0x02c4436f) ||
+	(guid[2] != 0x9b68d271) ||
+	(guid[3] != 0xf2e8ca31)) {
+      printf("\t\t\t\t Invalid GUID\n");
+    } else {
+      printf("\t\t\t\t OverrideCCID:\t%04x\n", buff >> 16);
+    }
+  }
+
+  if (state.idm_table_offset) {
+    printf("\t\t\tCCIX IDM Table [%x]\n", state.idm_table_offset);
+    /* Only print valid entries */
+    for (i = 0; i < 64; i++) {
+      buff = get_conf_long(d, state.idm_table_offset + i * 4);
+      if ((buff & 0x1) == 0)
+	continue;
+      printf("\t\t\t\t#%02u: ", i);
+      if (buff & 0x02) {
+	printf("Port#%02u ", (buff >> 4) & 0xf);
+	if ((buff >> 10) & 0xf)
+	  printf("NumAgg: %02u, ", ((buff >> 10) & 0xf) + 1);
+	printf("Link#%02u", (buff >> 15) & 0x3f);
+      } else {
+	printf("Local");
+      }
+      printf("\n");
+    }
+  }
+  if (state.sr_table_offset) {
+    printf("\t\t\tCCIX SR Table [%x]\n", state.sr_table_offset);
+    /* Only print valid entries */
+    for (i = 0; i < 64; i++) {
+      buff = get_conf_long(d, state.sr_table_offset + i * 4);
+      if ((buff & 0x1) == 0)
+	continue;
+      printf("\t\t\t\t#%02u: ", i);
+      if (buff & 0x02) {
+	printf("Port#%02u ", (buff >> 4) & 0xf);
+	if ((buff >> 10) & 0xf)
+	  printf("NumAgg: %02u, ", ((buff >> 10) & 0xf) + 1);
+	printf("Link#%02u", (buff >> 15) & 0x3f);
+      } else {
+	printf("Local");
+      }
+      printf("\n");
+    }
+  }
+
+  if (state.rsam_table_offset) {
+    printf("\t\t\tCCIX RSAM Table [%x]\n", state.rsam_table_offset);
+    /* relies on the hash mask only have 2 DW if present*/
+    for (sam_entry_offset = 0; sam_entry_offset < state.rsam_table_size;
+	 sam_entry_offset += 0xc)
+      ccix_sam_entry(d, sam_entry_offset / 12,
+		     state.rsam_table_offset + sam_entry_offset);
+    /* Potential Hash mask here */
+    if (state.portagg_capable) {
+      buff = get_conf_long(d, state.rsam_table_offset + state.rsam_table_size - 0x8);
+      buff2 = get_conf_long(d, state.rsam_table_offset + state.rsam_table_size - 0x4);
+      printf("\t\t\t\tHashMask: 0x%016lx\n",
+	     ((u64)buff2 << 32) | (buff & 0xffffffc0));
+    }
+  }
+
+  if (state.hsam_table_offset) {
+    printf("\t\t\tCCIX HSAM Table [%x]\n", state.hsam_table_offset);
+    for (sam_entry_offset = 0; sam_entry_offset < state.hsam_table_size;
+	 sam_entry_offset += 0xc)
+      ccix_sam_entry(d, sam_entry_offset / 12,
+		     state.hsam_table_offset + sam_entry_offset);
+    /* Potential Hash mask here */
+    if (state.portagg_capable) {
+      buff = get_conf_long(d, state.hsam_table_offset + state.hsam_table_size - 0x8);
+      buff2 = get_conf_long(d, state.hsam_table_offset + state.hsam_table_size - 0x4);
+      printf("\t\t\t\tHashMask: 0x%016lx\n",
+	     ((u64)buff2 << 32) | (buff & 0xffffffc0));
+    }
+  }
+}
+
+static void
+ccix_transport_dvsec(struct device *d, int where, int len)
+{
+  u32 buff;
+  int i, j;
+
+  static const char *cal_times[8] = {
+    "10us", "50us", "100us", "500us",
+    "1ms", "5ms", "10ms", "50ms"};
+
+  static const char *quick_eq_times[] = {
+    "<NotSupp>",
+    "8ms/16ms",
+    "24ms/32ms",
+    "50ms/58ms",
+    "100ms/108ms",
+    "200ms/208ms",
+  };
+
+  static const char *ext_eq_phase_timeout[] = {
+    "24 ms / 32 ms ",
+    "50 ms / 58 ms ",
+    "100 ms / 108 ms ",
+    "200 ms / 208 ms ",
+    "400 ms / 408 ms ",
+    "600 ms / 608 ms ",
+  };
+
+  static const char *reach[4] = {
+    "SR", "LR", "SR/LR", "Unknown",
+  };
+
+  printf("Transport %x>\n", where);
+  /* CCIX v1.0 specification has a fixed length Transport DVSEC with 17DW */
+  if (len < 17 * 4) {
+    printf("\t\t\t\t<incomplete>\n");
+    return;
+  }
+  if (!config_fetch(d, where + 0xc, len - 0xc)) {
+    printf("\t\t\t<ureadable>\n");
+    return;
+  }
+  buff = get_conf_long(d, where + 0x8) >> 16;
+  printf("\t\t\tTranCap:\t");
+  if (buff & 1) {
+    printf("ESM+ %s RecalOnrC%c CalTime: %s QuickEqTime: %s\n",
+	   reach[(buff >> 1) & 0x3], FLAG(buff, 0x8),
+	   cal_times[(buff >> 4) & 0x7],
+	   ((buff >> 8) & 0x7) >= ARRAY_SIZE(quick_eq_times) ?
+	   "Unknown" : quick_eq_times[(buff >> 8) & 0x7]);
+
+    buff = get_conf_long(d, where + 0xc);
+    printf("\t\t\tESMRateCap:\t");
+    if (buff & (1 << 0))
+      printf("2.5 GT/s ");
+    if (buff & (1 << 1))
+      printf("5 GT/s ");
+    if (buff & (1 << 2))
+      printf("8 GT/s ");
+    if (buff & (1 << 5))
+      printf("16 GT/s ");
+    if (buff & (1 << 9))
+      printf("20 GT/s ");
+    if (buff & (1 << 14))
+      printf("25 GT/s ");
+    printf("\n");
+
+    buff = get_conf_long(d, where + 0x14);
+    printf("\t\t\tESMStatus:\t");
+    switch(buff & 0x7f) {
+    case 0: printf("Inactive "); break;
+    case 1: printf("2.5 GT/s "); break;
+    case 2: printf("5 GT/s "); break;
+    case 3: printf("8 GT/s "); break;
+    case 6: printf("16 GT/s "); break;
+    case 10: printf("20 GT/s "); break;
+    case 15: printf("25 GT/s "); break;
+    default:
+      printf("Unknown ");
+      break;
+    }
+    printf("Cal%c\n", FLAG(buff, 0x80));
+
+    buff = get_conf_long(d, where + 0x18);
+    printf("\t\t\tESMCtl:\t\tESM0: ");
+    switch(buff & 0x7f) {
+    case 0: printf("No speed "); break;
+    case 3: printf("8 GT/s "); break;
+    case 6: printf("16 GT/s "); break;
+    default:
+      printf("Unknown ");
+      break;
+    }
+    printf("ESM1: ");
+    switch((buff >> 8) & 0x7f) {
+    case 0: printf("No speed "); break;
+    case 6: printf("16 GT/s "); break;
+    case 10: printf("20 GT/s "); break;
+    case 15: printf("25 GT/s "); break;
+    default:
+      printf("Unknown ");
+      break;
+    }
+    printf("ESM%c ESMCompliance%c ", FLAG(buff, 0x8000), FLAG(buff, 0x80000));
+    if (buff & (1 << 24))
+      printf("LR\n");
+    else
+      printf("SR\n");
+    printf("\t\t\t\t\tExtEqPhase2TimeOut: %s ExtEqPhase3TimeOut: %s\n",
+	   ext_eq_phase_timeout[(buff >> 16) & 0x7],
+	   ext_eq_phase_timeout[(buff >> 20) & 0x7]);
+    printf("\t\t\t\t\tQuickEqTimeout: %s",
+	   (buff >> 26) & 0x7 > ARRAY_SIZE(quick_eq_times) ?
+	   "Unknown" : quick_eq_times[(buff >> 26) & 0x7]);
+
+    /* Equivalent values in Secondary PCI Express Ext Cap */
+    printf("\n\t\t\tESMEqCtl 20GT/s:\t");
+    for (i = 0; i < 4; i++) {
+      buff = get_conf_long(d, where + 0x1c + i * 4);
+      for (j = 0; j < 4; j++) {
+	      if (i | j)
+		printf("\t\t\t\t\t\t");
+	      printf("Lane #%02u: ", i * 4 + j);
+	      printf("Trans Presets US: 0x%x DS: 0x%x\n",
+		     (buff >> (8 * j)) & 0x7,
+		     (buff >> (8 *j + 4)) & 0x7);
+      }
+    }
+    printf("\n\t\t\tESMEqCtl 25GT/s:\t");
+    for (i = 0; i < 4; i++) {
+      buff = get_conf_long(d, where + 0x2c + i * 4);
+      for (j = 0; j < 4; j++) {
+	      if (i | j)
+		printf("\t\t\t\t\t\t");
+	      printf("Lane #%02u: Trans Presets US: 0x%x DS: 0x%x\n",
+		     i * 4 + j, (buff >> (8 * j)) & 0x7,
+		     (buff >> (8 *j + 4)) & 0x7);
+      }
+    }
+  }
+  else
+    printf("ESM- \n");
+
+  buff = get_conf_long(d, where + 0x3c);
+  printf("\t\t\tTLCap:\t\tOptTLP%c VCResCapInd: %u\n",
+	 FLAG(buff, 0x1), (buff >> 8) & 0x7);
+
+  buff = get_conf_long(d, where + 0x40);
+  printf("\t\t\tTLCtl:\t\tOptTLP%c LengthCheck%c\n",
+	 FLAG(buff, 0x1), FLAG(buff, 0x2));
+}
+
+void
+cap_ccix(struct device *d, int where)
+{
+  u32 buff;
+  u32 len;
+
+  /* First two DW have already been fetched to identify the DVSEC VID */
+  if (!config_fetch(d, where + 0x8, 4)) {
+    printf("\t\t<unreadable>\n");
+    return;
+  }
+
+  printf("\t\t<CCIX ");
+  buff = get_conf_long(d, where + 0x4);
+  len = buff >> 20;
+
+  buff = get_conf_long(d, where + 0x8);
+  switch(buff & 0xFF) {
+  case 1:
+    ccix_transport_dvsec(d, where, len);
+    break;
+  case 2:
+    ccix_protocol_dvsec(d, where, len);
+    break;
+  default:
+    printf("\t\t\t<UNKNOWN>\n");
+    break;
+  }
+}
diff --git a/ls-ecaps.c b/ls-ecaps.c
index 4417cd9..85c6084 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -797,6 +797,32 @@ cap_ptm(struct device *d, int where)
     }
 }
 
+static void
+cap_dvsec(struct device *d, int where)
+{
+  u32 buff;
+
+  printf("Designated Vendor-Specific <>\n");
+
+  if (verbose < 2)
+    return;
+
+  if (!config_fetch(d, where + 4, 4)) {
+      printf("\t\t<unreadable>\n");
+      return;
+    }
+    buff = get_conf_long(d, where + 4);
+    printf("\t\tVendor:%4x Version:%u\n", buff & 0xFFFF, (buff >> 16) & 0xF);
+    switch (buff & 0xffff) {
+    case PCI_VENDOR_ID_CCIX:
+      cap_ccix(d, where);
+      break;
+    default:
+      printf("\t\t<UNKNOWN VENDOR %4x %4x>\n", buff & 0xFFFF, PCI_VENDOR_ID_CCIX );
+      break;
+    }
+}
+
 void
 show_ext_caps(struct device *d, int type)
 {
@@ -924,7 +950,7 @@ show_ext_caps(struct device *d, int type)
 	    printf("Readiness Time Reporting <?>\n");
 	    break;
 	  case PCI_EXT_CAP_ID_DVSEC:
-	    printf("Designated Vendor-Specific <?>\n");
+	    cap_dvsec(d, where);
 	    break;
 	  case PCI_EXT_CAP_ID_VF_REBAR:
 	    printf("VF Resizable BAR <?>\n");
diff --git a/lspci.h b/lspci.h
index fefee52..94efebd 100644
--- a/lspci.h
+++ b/lspci.h
@@ -75,6 +75,10 @@ void show_caps(struct device *d, int where);
 
 void show_ext_caps(struct device *d, int type);
 
+/* ls-ccix.c */
+
+void cap_ccix(struct device *d, int where);
+
 /* ls-caps-vendor.c */
 
 void show_vendor_caps(struct device *d, int where, int cap);
-- 
2.20.1

