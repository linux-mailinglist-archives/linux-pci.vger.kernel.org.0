Return-Path: <linux-pci+bounces-4745-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BE9878F65
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 09:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29FDB281C83
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 08:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816BD69D07;
	Tue, 12 Mar 2024 08:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="tkDk+RZ2"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1552469979;
	Tue, 12 Mar 2024 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710230623; cv=none; b=FARrOwLmhE0vXeEvIuKdx8/0qAduLzHGm5a6jOhNhvrbVy2bqkovNn9e7im3ducElpwgka6+LHc0OEF1SdIbYDx50cntyb81QM9rhvwUKudraDOEq2xT9ldCm9ueGC95ORFAIcix3NpR7y8Pn1vi9hrfNr1d75XZLnT7MrkBdIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710230623; c=relaxed/simple;
	bh=kPTS0Dvc5WRIHjnTbcfokp8GlXQ1+UrJOK6vkgqfHOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vn0625U238fzUx7nToDwe7Xi1W3JjnOs6+Ff/NxtLH1Ec7pdKuZLJ8cq3p10QkGET6RJH/s7DDY1/JKKhJDg6cXtFLtvk/siPHjQthwGdMCD88SAk8hpSwXo4ty+GQ2jlY7JmYckm24NYhu1CvycyEIpQsR3pFkFzOQGTToA2so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=tkDk+RZ2; arc=none smtp.client-ip=68.232.139.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710230621; x=1741766621;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kPTS0Dvc5WRIHjnTbcfokp8GlXQ1+UrJOK6vkgqfHOs=;
  b=tkDk+RZ2upxksyFMiTgwq0bhgBqELixGOraPMcrQ7X49aQ6O5iapplzc
   PFglbLlulKmerDguqloKkBRl771gNHvJKPoRcOxUMYnZ77sg8T3JINoeQ
   8TkkbKUKRoCAQfAstnJKYSSGHt+SBPbCxsBLiroMAXvWWLR6aPLqN/bim
   K5FMCR2oEUKe/YjUD+0Br6JF6i2qIxw4Rs2jsmMoEV55gzGRtrmE0x5nE
   nTH5y/iycCnK0m5Smt+bJ+F3jyHA4leynlvzRkGVDvIBTF9WUaalyp5qG
   ymc39PHMfGaSaO4UhrbJ35grFBNOunNSoKP3ec3F/TkVNOG+Jcyjbgms6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="153823864"
X-IronPort-AV: E=Sophos;i="6.07,118,1708354800"; 
   d="scan'208";a="153823864"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 17:03:31 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 58A18C21AD;
	Tue, 12 Mar 2024 17:03:28 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (sqmail-3003.b.css.fujitsu.com [10.128.233.114])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 885FED623A;
	Tue, 12 Mar 2024 17:03:27 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 4D1D320059BA;
	Tue, 12 Mar 2024 17:03:27 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com,
	linux-pci@vger.kernel.org,
	mj@ucw.cz,
	dan.j.williams@intel.com,
	KobayashiDaisuke <kobayashi.da-06@fujitsu.com>
Subject: [PATCH v3 3/3] Add function to display cxl1.1 device link status
Date: Tue, 12 Mar 2024 17:05:59 +0900
Message-ID: <20240312080559.14904-4-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240312080559.14904-1-kobayashi.da-06@fujitsu.com>
References: <20240312080559.14904-1-kobayashi.da-06@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00

From: KobayashiDaisuke <kobayashi.da-06@fujitsu.com>

This patch adds a function to output the link status of the CXL1.1 device
when it is connected.

In CXL1.1, the link status of the device is included in the RCRB mapped to
the memory mapped register area. The value of that register is outputted
to sysfs, and based on that, displays the link status information.

Signed-off-by: "KobayashiDaisuke" <kobayashi.da-06@fujitsu.com>
---
 lib/access.c | 29 +++++++++++++++++++++
 lib/pci.h    |  2 ++
 ls-caps.c    | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+)

diff --git a/lib/access.c b/lib/access.c
index 7d66123..bc75a84 100644
--- a/lib/access.c
+++ b/lib/access.c
@@ -12,6 +12,7 @@
 #include <stdlib.h>
 #include <stdarg.h>
 #include <string.h>
+#include <fcntl.h>
 
 #include "internal.h"
 
@@ -268,3 +269,31 @@ pci_get_string_property(struct pci_dev *d, u32 prop)
 
   return NULL;
 }
+
+#define OBJNAMELEN 1024
+#define OBJBUFSIZE 64
+int
+get_rcd_sysfs_obj_file(struct pci_dev *d, char *object, char *result)
+{
+#ifdef PCI_HAVE_PM_LINUX_SYSFS
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
+#else
+  return -1;
+#endif
+}
diff --git a/lib/pci.h b/lib/pci.h
index 2322bf7..fb25069 100644
--- a/lib/pci.h
+++ b/lib/pci.h
@@ -187,6 +187,8 @@ int pci_write_long(struct pci_dev *, int pos, u32 data) PCI_ABI;
 int pci_read_block(struct pci_dev *, int pos, u8 *buf, int len) PCI_ABI;
 int pci_write_block(struct pci_dev *, int pos, u8 *buf, int len) PCI_ABI;
 
+int get_rcd_sysfs_obj_file(struct pci_dev *d, char *object, char *result) PCI_ABI;
+
 /*
  * Most device properties take some effort to obtain, so libpci does not
  * initialize them during default bus scan. Instead, you have to call
diff --git a/ls-caps.c b/ls-caps.c
index 1b63262..12c9f34 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -10,6 +10,8 @@
 
 #include <stdio.h>
 #include <string.h>
+#include <fcntl.h>
+#include <stdlib.h>
 
 #include "lspci.h"
 
@@ -1381,6 +1383,74 @@ static void cap_express_slot2(struct device *d UNUSED, int where UNUSED)
   /* No capabilities that require this field in PCIe rev2.0 spec. */
 }
 
+#define OBJBUFSIZE 64
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
@@ -1445,6 +1515,9 @@ cap_express(struct device *d, int where, int cap)
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


