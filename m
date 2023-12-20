Return-Path: <linux-pci+bounces-1205-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3965E81982B
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 06:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4A81F2659B
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 05:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2D4FBE3;
	Wed, 20 Dec 2023 05:32:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C3B10A36;
	Wed, 20 Dec 2023 05:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="123425850"
X-IronPort-AV: E=Sophos;i="6.04,290,1695654000"; 
   d="scan'208";a="123425850"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 14:32:29 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id AABEAD64A7;
	Wed, 20 Dec 2023 14:32:26 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id D2B8813FA2;
	Wed, 20 Dec 2023 14:32:25 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.237.107])
	by m3004.s.css.fujitsu.com (Postfix) with ESMTP id A6D5D2005352;
	Wed, 20 Dec 2023 14:32:25 +0900 (JST)
From: KobayashiDaisuke <kobayashi.da-06@fujitsu.com>
To: linux-pci@vger.kernel.org
Cc: linux-cxl@vger.kernel.org,
	y-goto@fujitsu.com,
	KobayashiDaisuke <kobayashi.da-06@fujitsu.com>
Subject: [RFC PATCH 1/3] Add function to display cxl1.1 device link status
Date: Wed, 20 Dec 2023 14:07:36 +0900
Message-ID: <20231220050738.178481-2-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220050738.178481-1-kobayashi.da-06@fujitsu.com>
References: <20231220050738.178481-1-kobayashi.da-06@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00

This patch adds a function to output the link status of the CXL1.1 device
when it is connected.

In CXL1.1, the link status of the device is included in the RCRB mapped to
the memory mapped register area. This function accesses the address where
the device's RCRB is mapped and outputs the link status.


Signed-off-by: KobayashiDaisuke <kobayashi.da-06@fujitsu.com>
---
 ls-caps.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 lspci.h   |  35 ++++++++++++++++
 2 files changed, 158 insertions(+)

diff --git a/ls-caps.c b/ls-caps.c
index 1b63262..be81bb9 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -10,6 +10,9 @@
 
 #include <stdio.h>
 #include <string.h>
+#include <fcntl.h>
+#include <sys/mman.h>
+#include <stdlib.h>
 
 #include "lspci.h"
 
@@ -1381,6 +1384,121 @@ static void cap_express_slot2(struct device *d UNUSED, int where UNUSED)
   /* No capabilities that require this field in PCIe rev2.0 spec. */
 }
 
+#define OBJNAMELEN 1024
+static int get_device_uid(struct device *d){
+  return -1;
+}
+
+static off_t get_rcrb_base(int device_uid){
+  return -1;
+}
+
+static uint32_t read_pci_config(uint32_t* pcie_config_space, off_t offset) {
+    return *((uint32_t*)((uint8_t*)pcie_config_space + offset));
+}
+
+static void cap_express_link_rcd(struct device *d)
+{
+  /* Check whether the device is cxl 1.1 device or not */
+  int device_uid = get_device_uid(d);
+  if (device_uid < 0)
+    return;
+
+  off_t rcrb_base = get_rcrb_base(device_uid);
+  if(rcrb_base <= 0)
+    return;
+  
+  int mem_fd = open("/dev/mem", O_RDONLY | O_SYNC);
+  if (mem_fd == -1)
+    return;
+
+  /* Set target address(RCD = RCH + 4K) */
+  off_t target_address = rcrb_base + 0x1000;
+  long page_size = sysconf(_SC_PAGESIZE);
+  void *mem_ptr = mmap(NULL, page_size, PROT_READ, MAP_SHARED, mem_fd, target_address);
+  if (mem_ptr == MAP_FAILED)
+  {
+    close(mem_fd);
+    return;
+  }
+
+  /* Search PCIe Capability */
+  volatile uint32_t value = read_pci_config(mem_ptr, PCI_CAPABILITY_LIST);
+  volatile off_t offset = value & 0xFF;
+
+  while (1)
+  {
+    value = read_pci_config(mem_ptr, offset);
+    /* If find PCIe Capability, display the link status info */
+    if ((value & 0xFF) == PCI_CAP_ID_EXP)
+    {
+      u32 t, aspm, cap_speed, cap_width, sta_speed, sta_width;
+      u16 w;
+      t = read_pci_config(mem_ptr, offset + PCI_EXP_LNKCAP);
+      aspm = (t & PCI_EXP_LNKCAP_ASPM) >> 10;
+      cap_speed = t & PCI_EXP_LNKCAP_SPEED;
+      cap_width = (t & PCI_EXP_LNKCAP_WIDTH) >> 4;
+      printf("\t\tLnkCap:\tPort #%d, Speed %s, Width x%d, ASPM %s",
+              t >> 24,
+              link_speed(cap_speed), cap_width,
+              aspm_support(aspm));
+      if (aspm)
+      {
+        printf(", Exit Latency ");
+        if (aspm & 1)
+          printf("L0s %s", latency_l0s((t & PCI_EXP_LNKCAP_L0S) >> 12));
+        if (aspm & 2)
+          printf("%sL1 %s", (aspm & 1) ? ", " : "",
+                  latency_l1((t & PCI_EXP_LNKCAP_L1) >> 15));
+      }
+      printf("\n");
+      printf("\t\t\tClockPM%c Surprise%c LLActRep%c BwNot%c ASPMOptComp%c\n",
+              FLAG(t, PCI_EXP_LNKCAP_CLOCKPM),
+              FLAG(t, PCI_EXP_LNKCAP_SURPRISE),
+              FLAG(t, PCI_EXP_LNKCAP_DLLA),
+              FLAG(t, PCI_EXP_LNKCAP_LBNC),
+              FLAG(t, PCI_EXP_LNKCAP_AOC));
+
+      t = read_pci_config(mem_ptr, offset + PCI_EXP_LNKCTL);
+      w = (uint16_t)(t & 0xffff);
+      printf("\t\tLnkCtl:\tASPM %s;", aspm_enabled(w & PCI_EXP_LNKCTL_ASPM));
+      printf(" Disabled%c CommClk%c\n\t\t\tExtSynch%c ClockPM%c AutWidDis%c BWInt%c AutBWInt%c\n",
+              FLAG(w, PCI_EXP_LNKCTL_DISABLE),
+              FLAG(w, PCI_EXP_LNKCTL_CLOCK),
+              FLAG(w, PCI_EXP_LNKCTL_XSYNCH),
+              FLAG(w, PCI_EXP_LNKCTL_CLOCKPM),
+              FLAG(w, PCI_EXP_LNKCTL_HWAUTWD),
+              FLAG(w, PCI_EXP_LNKCTL_BWMIE),
+              FLAG(w, PCI_EXP_LNKCTL_AUTBWIE));
+
+      w = (uint16_t)((t >> 16) & 0xffff);
+      sta_speed = w & PCI_EXP_LNKSTA_SPEED;
+      sta_width = (w & PCI_EXP_LNKSTA_WIDTH) >> 4;
+      printf("\t\tLnkSta:\tSpeed %s%s, Width x%d%s\n",
+              link_speed(sta_speed),
+              link_compare(PCI_EXP_TYPE_ROOT_INT_EP, sta_speed, cap_speed),
+              sta_width,
+              link_compare(PCI_EXP_TYPE_ROOT_INT_EP, sta_width, cap_width));
+      printf("\t\t\tTrErr%c Train%c SlotClk%c DLActive%c BWMgmt%c ABWMgmt%c\n",
+              FLAG(w, PCI_EXP_LNKSTA_TR_ERR),
+              FLAG(w, PCI_EXP_LNKSTA_TRAIN),
+              FLAG(w, PCI_EXP_LNKSTA_SL_CLK),
+              FLAG(w, PCI_EXP_LNKSTA_DL_ACT),
+              FLAG(w, PCI_EXP_LNKSTA_BWMGMT),
+              FLAG(w, PCI_EXP_LNKSTA_AUTBW));
+      break;
+    }else{ /* else get Next Capability Pointer, and move the pointer */
+      offset = (value >> 8) & 0xFF;
+      if (offset == 0)
+        break;
+    }
+  }
+
+  munmap(mem_ptr, page_size);
+  close(mem_fd);
+  return;
+}
+
 static int
 cap_express(struct device *d, int where, int cap)
 {
@@ -1445,6 +1563,11 @@ cap_express(struct device *d, int where, int cap)
   cap_express_dev(d, where, type);
   if (link)
     cap_express_link(d, where, type);
+  else if (type == PCI_EXP_TYPE_ROOT_INT_EP)
+  {
+    cap_express_link_rcd(d);
+  }
+    
   if (slot)
     cap_express_slot(d, where);
   if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_ROOT_EC)
diff --git a/lspci.h b/lspci.h
index c5a9ec7..eab5a77 100644
--- a/lspci.h
+++ b/lspci.h
@@ -58,6 +58,41 @@ u32 get_conf_long(struct device *d, unsigned int pos);
 word get_conf_word(struct device *d, unsigned int pos);
 byte get_conf_byte(struct device *d, unsigned int pos);
 
+/* access to CEDT structure*/
+
+#pragma pack(1)
+#define CHBS_TYPE 0
+
+// CHBS Structure
+struct CHBS_Structure {
+    uint32_t uid;                // UID (4 bytes)
+    uint32_t cxl_version;         // CXL Version (4 bytes)
+    uint32_t reserved2;          // Reserved (4 bytes)
+    uint64_t base;               // Base (8 bytes)
+    uint64_t length;             // Length (8 bytes)
+};
+
+// CEDT Structure Header
+struct CEDT_Structure {
+    uint8_t type;                  // Type (1 byte)
+    uint8_t reserved;              // Reserved (1 byte)
+    uint16_t record_length;         // Record Length (2 bytes)
+};
+
+// CEDT Header
+struct CEDT_Header {
+    uint32_t signature;          // Signature (4 bytes)
+    uint32_t length;             // Length (4 bytes)
+    uint8_t revision;            // Revision (1 byte)
+    uint8_t checksum;            // Checksum (1 byte)
+    char oem_ID[6];               // OEM ID (6 bytes)
+    char oem_tableID[8];          // OEM Table ID (8 bytes)
+    uint32_t oem_Revision;        // OEM Revision (4 bytes)
+    uint32_t creatorID;          // Creator ID (4 bytes)
+    uint32_t creator_revision;    // Creator Revision (4 bytes)
+};
+#pragma pack()
+
 /* Useful macros for decoding of bits and bit fields */
 
 #define FLAG(x,y) ((x & y) ? '+' : '-')
-- 
2.43.0


