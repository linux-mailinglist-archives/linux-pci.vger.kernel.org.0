Return-Path: <linux-pci+bounces-4089-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79227868ACB
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 09:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FC97B2285E
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 08:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A567B3C0;
	Tue, 27 Feb 2024 08:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="jWPV1Hsg"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852DD7AE63;
	Tue, 27 Feb 2024 08:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709022724; cv=none; b=U/JXJ/RO4xKcNYq0PXogUYxtqhnXhqEk162ePMGVlJxgXybbzNLaMhAyzzGLSooeAAcIXNNVuIpLYh6Pj62SFFypjkjAJVtjFdR4RgDDUULj7XT4/TOSc3mLsmqtN7wb8KQssY8hFkhrIzmfqWWIFCWQlDR1QV7XCuZOmaJyKnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709022724; c=relaxed/simple;
	bh=zPEJAftUnJywsTWFXG9H+ANBuz9ByKBrf21PEmeG1vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4DeVrPbJ3QeTSADbjbzgXrHaQO1/lIencS+WaZrli7aReRNO7U1orj1NKGB+TKXuPowIYsL9CXAMCo8nHxIxzn/LpIXArfwAToaNqQDAKwvpeYvoivpcXAlMKBqL0GoUbyCQE89r6Go3aJgXEu/7+6hnoBRDGrOsM1w1m2wwYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=jWPV1Hsg; arc=none smtp.client-ip=139.138.36.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1709022722; x=1740558722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zPEJAftUnJywsTWFXG9H+ANBuz9ByKBrf21PEmeG1vk=;
  b=jWPV1Hsg5w3T72BfHFeQrgzpuPdnGAqvIr2iR5ekP6yNQLbI9ubmN5JC
   atZ1KzIG5xZ+mLxhOVfkqP90dIeO2sqUGDnbp5dp35TxYHoxBsl2PT32v
   5CuBu1ywG/hLp9XO8Jdj0SiH/NI1Zo2u3PT1ZyFB5b5psFtuM2n9X+aHi
   2UhfVwaKhBjxT/Sz/KCmcI/vi9SA1fD0Vc7vbdkyqFx6+RNh94s6RWEAG
   PNhMLLIHpl4y+KJN0hpi6cfE1rC08MHBLc63oeLSw5o4N0pcq5xGKqg7e
   C0q9uUytf2FTCX0zLkjzkGne+o40zIOv3TIhLJ8PNj9P4E+YpY3Ho5eUA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="139007771"
X-IronPort-AV: E=Sophos;i="6.06,187,1705330800"; 
   d="scan'208";a="139007771"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 17:30:50 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 4CB6A5DDE7;
	Tue, 27 Feb 2024 17:30:48 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 8B199D65D9;
	Tue, 27 Feb 2024 17:30:47 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3002.s.css.fujitsu.com (Postfix) with ESMTP id 60E612020A50;
	Tue, 27 Feb 2024 17:30:47 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com,
	linux-pci@vger.kernel.org,
	mj@ucw.cz,
	dan.j.williams@intel.com,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [RFC PATCH v2 3/3] lspci: Add function to display cxl1.1 device link status
Date: Tue, 27 Feb 2024 17:33:13 +0900
Message-ID: <20240227083313.87699-4-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227083313.87699-1-kobayashi.da-06@fujitsu.com>
References: <20240227083313.87699-1-kobayashi.da-06@fujitsu.com>
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
the memory mapped register area. The value of that register is outputted
to sysfs, and based on that, displays the link status information.


Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
---
 ls-caps.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/ls-caps.c b/ls-caps.c
index 1b63262..5c60321 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -10,6 +10,8 @@
 
 #include <stdio.h>
 #include <string.h>
+#include <fcntl.h>
+#include <stdlib.h>
 
 #include "lspci.h"
 
@@ -1381,6 +1383,97 @@ static void cap_express_slot2(struct device *d UNUSED, int where UNUSED)
   /* No capabilities that require this field in PCIe rev2.0 spec. */
 }
 
+#define OBJNAMELEN 1024
+#define OBJBUFSIZE 64
+static int
+get_rcd_sysfs_obj_file(struct pci_dev *d, char *object, char *result)
+{
+  char namebuf[OBJNAMELEN];
+  int n = snprintf(namebuf, OBJNAMELEN, "%s/devices/%04x:%02x:%02x.%d/%s",
+		   pci_get_param(d->access, "sysfs.path"),
+       d->domain, d->bus, d->dev, d->func, object);
+  if (n < 0 || n >= OBJNAMELEN){
+    d->access->error("Failed to get filename");
+    return -1;
+    }
+  int fd = open(namebuf, O_RDONLY);
+  if(fd < 0)
+    return -1;
+  n = read(fd, result, OBJBUFSIZE);
+  if (n < 0 || n >= OBJBUFSIZE){
+    d->access->error("Failed to read the file");
+    return -1;
+  }
+  return 0;
+}
+
+static void cap_express_link_rcd(struct device *d){
+  u32 t, aspm, cap_speed, cap_width, sta_speed, sta_width;
+  u16 w;
+  struct pci_dev *pdev = d->dev;
+  char buf[OBJBUFSIZE];
+
+  if(get_rcd_sysfs_obj_file(pdev, "rcd_link_cap", buf))
+    return;
+  t = (u32)strtoul(buf, NULL, 16);
+
+  aspm = (t & PCI_EXP_LNKCAP_ASPM) >> 10;
+  cap_speed = t & PCI_EXP_LNKCAP_SPEED;
+  cap_width = (t & PCI_EXP_LNKCAP_WIDTH) >> 4;
+  printf("\t\tLnkCap:\tPort #%d, Speed %s, Width x%d, ASPM %s",
+	t >> 24,
+	link_speed(cap_speed), cap_width,
+	aspm_support(aspm));
+  if (aspm)
+    {
+      printf(", Exit Latency ");
+      if (aspm & 1)
+	printf("L0s %s", latency_l0s((t & PCI_EXP_LNKCAP_L0S) >> 12));
+      if (aspm & 2)
+	printf("%sL1 %s", (aspm & 1) ? ", " : "",
+	    latency_l1((t & PCI_EXP_LNKCAP_L1) >> 15));
+    }
+  printf("\n");
+  printf("\t\t\tClockPM%c Surprise%c LLActRep%c BwNot%c ASPMOptComp%c\n",
+	FLAG(t, PCI_EXP_LNKCAP_CLOCKPM),
+	FLAG(t, PCI_EXP_LNKCAP_SURPRISE),
+	FLAG(t, PCI_EXP_LNKCAP_DLLA),
+	FLAG(t, PCI_EXP_LNKCAP_LBNC),
+	FLAG(t, PCI_EXP_LNKCAP_AOC));
+
+  if(!get_rcd_sysfs_obj_file(pdev, "rcd_link_ctrl", buf)){
+    w = (u16)strtoul(buf, NULL, 16);    
+    printf("\t\tLnkCtl:\tASPM %s;", aspm_enabled(w & PCI_EXP_LNKCTL_ASPM));
+    printf(" Disabled%c CommClk%c\n\t\t\tExtSynch%c ClockPM%c AutWidDis%c BWInt%c AutBWInt%c\n",
+    FLAG(w, PCI_EXP_LNKCTL_DISABLE),
+    FLAG(w, PCI_EXP_LNKCTL_CLOCK),
+    FLAG(w, PCI_EXP_LNKCTL_XSYNCH),
+    FLAG(w, PCI_EXP_LNKCTL_CLOCKPM),
+    FLAG(w, PCI_EXP_LNKCTL_HWAUTWD),
+    FLAG(w, PCI_EXP_LNKCTL_BWMIE),
+    FLAG(w, PCI_EXP_LNKCTL_AUTBWIE));
+  }
+
+  if(!get_rcd_sysfs_obj_file(pdev, "rcd_link_status", buf)){
+    w = (u16)strtoul(buf, NULL, 16);    
+    sta_speed = w & PCI_EXP_LNKSTA_SPEED;
+    sta_width = (w & PCI_EXP_LNKSTA_WIDTH) >> 4;
+    printf("\t\tLnkSta:\tSpeed %s%s, Width x%d%s\n",
+    link_speed(sta_speed),
+    link_compare(PCI_EXP_TYPE_ROOT_INT_EP, sta_speed, cap_speed),
+    sta_width,
+    link_compare(PCI_EXP_TYPE_ROOT_INT_EP, sta_width, cap_width));
+    printf("\t\t\tTrErr%c Train%c SlotClk%c DLActive%c BWMgmt%c ABWMgmt%c\n",
+    FLAG(w, PCI_EXP_LNKSTA_TR_ERR),
+    FLAG(w, PCI_EXP_LNKSTA_TRAIN),
+    FLAG(w, PCI_EXP_LNKSTA_SL_CLK),
+    FLAG(w, PCI_EXP_LNKSTA_DL_ACT),
+    FLAG(w, PCI_EXP_LNKSTA_BWMGMT),
+    FLAG(w, PCI_EXP_LNKSTA_AUTBW));
+  }
+  return;
+}
+
 static int
 cap_express(struct device *d, int where, int cap)
 {
@@ -1445,6 +1538,9 @@ cap_express(struct device *d, int where, int cap)
   cap_express_dev(d, where, type);
   if (link)
     cap_express_link(d, where, type);
+  else if (type == PCI_EXP_TYPE_ROOT_INT_EP)
+    cap_express_link_rcd(d);
+   
   if (slot)
     cap_express_slot(d, where);
   if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_ROOT_EC)
-- 
2.43.0


