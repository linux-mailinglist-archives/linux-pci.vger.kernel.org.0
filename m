Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78EE496030
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 14:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350807AbiAUN6S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 08:58:18 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48388 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350819AbiAUN6R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 08:58:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FE47616EF
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 13:58:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA31C340E1;
        Fri, 21 Jan 2022 13:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642773496;
        bh=4eFw+xbE0ci8Liopx+oxuiae+HjMtMQKDb79VueiBWk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hrwWjQggv5fl3suY8vCvHi+as+k7qhI8Sl7YIY2Cc5aMAr/O/rvlUWR8kBheN5TR5
         UWi2eHfx5bnMikb9jOBt2vcEtZM/fpA+wmwuVTjWEODYEXm86QmP0tQa23F27R2D9v
         lAWULkRitwktB87f4lLzpm5ONUfLmqZkeKzOk0vPMzAKdsueljgnEIsF0CyvGvhUa+
         NS0jpnpl2MO2L+REcP8kLuQbEEHsaM2zog1Dg5J4F/F4KYoPJGPWQIxtQiWNl5xjIL
         NPFSBw9PphQG5tHj7pkYP4C4w58iuacYTMjaKKGGMADagbDY8+JkNkSQeUBGTWHVyp
         eOW5pWNKb73Tg==
Received: by pali.im (Postfix)
        id 42AB2857; Fri, 21 Jan 2022 14:58:16 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: [PATCH pciutils 5/5] lspci: Retrieve prog if, subsystem ids and revision id via libpci
Date:   Fri, 21 Jan 2022 14:57:18 +0100
Message-Id: <20220121135718.27172-6-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220121135718.27172-1-pali@kernel.org>
References: <20220121135718.27172-1-pali@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use pci_fill_info with PROGIF, REVID and SUBSYS to fill this information.

lspci in some places reads class from what libpci provider fills in
dev->device_class and in some other places it reads directly from config
space. In dev->device_class is stored class possible different class as in
config space (e.g. if kernel is fixing class because device has bogus
information stored in config space).

With this change is class always read from dev->device_class which reflects
and respects lspci -b option (Bus-centric view). Same applies for subsystem
ids and revision id (note that prog if is part of class).
---
 ls-kernel.c |  8 +++---
 lspci.c     | 70 ++++++++++++++++++-----------------------------------
 lspci.h     |  2 --
 3 files changed, 27 insertions(+), 53 deletions(-)

diff --git a/ls-kernel.c b/ls-kernel.c
index ecacd0e65dce..2284b4625b12 100644
--- a/ls-kernel.c
+++ b/ls-kernel.c
@@ -174,16 +174,14 @@ static int
 match_pcimap(struct device *d, struct pcimap_entry *e)
 {
   struct pci_dev *dev = d->dev;
-  unsigned int class = get_conf_long(d, PCI_REVISION_ID) >> 8;
-  word subv, subd;
+  unsigned int class = (((unsigned int)dev->device_class << 8) | dev->prog_if);
 
 #define MATCH(x, y) ((y) > 0xffff || (x) == (y))
-  get_subid(d, &subv, &subd);
   return
     MATCH(dev->vendor_id, e->vendor) &&
     MATCH(dev->device_id, e->device) &&
-    MATCH(subv, e->subvendor) &&
-    MATCH(subd, e->subdevice) &&
+    MATCH(dev->subsys_vendor_id, e->subvendor) &&
+    MATCH(dev->subsys_id, e->subdevice) &&
     (class & e->class_mask) == e->class;
 #undef MATCH
 }
diff --git a/lspci.c b/lspci.c
index d14d1b9185d6..c4e6c93bc67a 100644
--- a/lspci.c
+++ b/lspci.c
@@ -143,7 +143,7 @@ scan_device(struct pci_dev *p)
 	d->config_cached += 64;
     }
   pci_setup_cache(p, d->config, d->config_cached);
-  pci_fill_info(p, PCI_FILL_IDENT | PCI_FILL_CLASS);
+  pci_fill_info(p, PCI_FILL_IDENT | PCI_FILL_CLASS | PCI_FILL_PROGIF | PCI_FILL_REVID | PCI_FILL_SUBSYS);
   return d;
 }
 
@@ -285,25 +285,6 @@ show_slot_name(struct device *d)
   show_slot_path(d);
 }
 
-void
-get_subid(struct device *d, word *subvp, word *subdp)
-{
-  byte htype = get_conf_byte(d, PCI_HEADER_TYPE) & 0x7f;
-
-  if (htype == PCI_HEADER_TYPE_NORMAL)
-    {
-      *subvp = get_conf_word(d, PCI_SUBSYSTEM_VENDOR_ID);
-      *subdp = get_conf_word(d, PCI_SUBSYSTEM_ID);
-    }
-  else if (htype == PCI_HEADER_TYPE_CARDBUS && d->config_cached >= 128)
-    {
-      *subvp = get_conf_word(d, PCI_CB_SUBSYSTEM_VENDOR_ID);
-      *subdp = get_conf_word(d, PCI_CB_SUBSYSTEM_ID);
-    }
-  else
-    *subvp = *subdp = 0xffff;
-}
-
 static void
 show_terse(struct device *d)
 {
@@ -319,12 +300,12 @@ show_terse(struct device *d)
 	 pci_lookup_name(pacc, devbuf, sizeof(devbuf),
 			 PCI_LOOKUP_VENDOR | PCI_LOOKUP_DEVICE,
 			 p->vendor_id, p->device_id));
-  if (c = get_conf_byte(d, PCI_REVISION_ID))
-    printf(" (rev %02x)", c);
+  if ((p->known_fields & PCI_FILL_REVID) && p->rev_id)
+    printf(" (rev %02x)", p->rev_id);
   if (verbose)
     {
       char *x;
-      c = get_conf_byte(d, PCI_CLASS_PROG);
+      c = (p->known_fields & PCI_FILL_PROGIF) ? p->prog_if : 0;
       x = pci_lookup_name(pacc, devbuf, sizeof(devbuf),
 			  PCI_LOOKUP_PROGIF | PCI_LOOKUP_NO_NUMBERS,
 			  p->device_class, c);
@@ -340,19 +321,18 @@ show_terse(struct device *d)
 
   if (verbose || opt_kernel)
     {
-      word subsys_v, subsys_d;
       char ssnamebuf[256];
 
       pci_fill_info(p, PCI_FILL_LABEL);
 
       if (p->label)
         printf("\tDeviceName: %s", p->label);
-      get_subid(d, &subsys_v, &subsys_d);
-      if (subsys_v && subsys_v != 0xffff)
+      if ((p->known_fields & PCI_FILL_SUBSYS) &&
+	  p->subsys_vendor_id && p->subsys_vendor_id != 0xffff)
 	printf("\tSubsystem: %s\n",
 		pci_lookup_name(pacc, ssnamebuf, sizeof(ssnamebuf),
 			PCI_LOOKUP_SUBSYSTEM | PCI_LOOKUP_VENDOR | PCI_LOOKUP_DEVICE,
-			p->vendor_id, p->device_id, subsys_v, subsys_d));
+			p->vendor_id, p->device_id, p->subsys_vendor_id, p->subsys_id));
     }
 }
 
@@ -766,7 +746,7 @@ show_verbose(struct device *d)
 
   pci_fill_info(p, PCI_FILL_IRQ | PCI_FILL_BASES | PCI_FILL_ROM_BASE | PCI_FILL_SIZES |
     PCI_FILL_PHYS_SLOT | PCI_FILL_NUMA_NODE | PCI_FILL_DT_NODE | PCI_FILL_IOMMU_GROUP |
-    PCI_FILL_BRIDGE_BASES);
+    PCI_FILL_BRIDGE_BASES | PCI_FILL_PROGIF | PCI_FILL_REVID | PCI_FILL_SUBSYS);
   irq = p->irq;
 
   switch (htype)
@@ -947,13 +927,9 @@ static void
 show_machine(struct device *d)
 {
   struct pci_dev *p = d->dev;
-  int c;
-  word sv_id, sd_id;
   char classbuf[128], vendbuf[128], devbuf[128], svbuf[128], sdbuf[128];
   char *dt_node, *iommu_group;
 
-  get_subid(d, &sv_id, &sd_id);
-
   if (verbose)
     {
       pci_fill_info(p, PCI_FILL_PHYS_SLOT | PCI_FILL_NUMA_NODE | PCI_FILL_DT_NODE | PCI_FILL_IOMMU_GROUP);
@@ -966,19 +942,20 @@ show_machine(struct device *d)
 	     pci_lookup_name(pacc, vendbuf, sizeof(vendbuf), PCI_LOOKUP_VENDOR, p->vendor_id, p->device_id));
       printf("Device:\t%s\n",
 	     pci_lookup_name(pacc, devbuf, sizeof(devbuf), PCI_LOOKUP_DEVICE, p->vendor_id, p->device_id));
-      if (sv_id && sv_id != 0xffff)
+      if ((p->known_fields & PCI_FILL_SUBSYS) &&
+	  p->subsys_vendor_id && p->subsys_vendor_id != 0xffff)
 	{
 	  printf("SVendor:\t%s\n",
-		 pci_lookup_name(pacc, svbuf, sizeof(svbuf), PCI_LOOKUP_SUBSYSTEM | PCI_LOOKUP_VENDOR, sv_id));
+		 pci_lookup_name(pacc, svbuf, sizeof(svbuf), PCI_LOOKUP_SUBSYSTEM | PCI_LOOKUP_VENDOR, p->subsys_vendor_id));
 	  printf("SDevice:\t%s\n",
-		 pci_lookup_name(pacc, sdbuf, sizeof(sdbuf), PCI_LOOKUP_SUBSYSTEM | PCI_LOOKUP_DEVICE, p->vendor_id, p->device_id, sv_id, sd_id));
+		 pci_lookup_name(pacc, sdbuf, sizeof(sdbuf), PCI_LOOKUP_SUBSYSTEM | PCI_LOOKUP_DEVICE, p->vendor_id, p->device_id, p->subsys_vendor_id, p->subsys_id));
 	}
       if (p->phy_slot)
 	printf("PhySlot:\t%s\n", p->phy_slot);
-      if (c = get_conf_byte(d, PCI_REVISION_ID))
-	printf("Rev:\t%02x\n", c);
-      if (c = get_conf_byte(d, PCI_CLASS_PROG))
-	printf("ProgIf:\t%02x\n", c);
+      if ((p->known_fields & PCI_FILL_REVID) && p->rev_id)
+	printf("Rev:\t%02x\n", p->rev_id);
+      if (p->known_fields & PCI_FILL_PROGIF)
+	printf("ProgIf:\t%02x\n", p->prog_if);
       if (opt_kernel)
 	show_kernel_machine(d);
       if (p->numa_node != -1)
@@ -994,14 +971,15 @@ show_machine(struct device *d)
       print_shell_escaped(pci_lookup_name(pacc, classbuf, sizeof(classbuf), PCI_LOOKUP_CLASS, p->device_class));
       print_shell_escaped(pci_lookup_name(pacc, vendbuf, sizeof(vendbuf), PCI_LOOKUP_VENDOR, p->vendor_id, p->device_id));
       print_shell_escaped(pci_lookup_name(pacc, devbuf, sizeof(devbuf), PCI_LOOKUP_DEVICE, p->vendor_id, p->device_id));
-      if (c = get_conf_byte(d, PCI_REVISION_ID))
-	printf(" -r%02x", c);
-      if (c = get_conf_byte(d, PCI_CLASS_PROG))
-	printf(" -p%02x", c);
-      if (sv_id && sv_id != 0xffff)
+      if ((p->known_fields & PCI_FILL_REVID) && p->rev_id)
+	printf(" -r%02x", p->rev_id);
+      if (p->known_fields & PCI_FILL_PROGIF)
+	printf(" -p%02x", p->prog_if);
+      if ((p->known_fields & PCI_FILL_SUBSYS) &&
+	  p->subsys_vendor_id && p->subsys_vendor_id != 0xffff)
 	{
-	  print_shell_escaped(pci_lookup_name(pacc, svbuf, sizeof(svbuf), PCI_LOOKUP_SUBSYSTEM | PCI_LOOKUP_VENDOR, sv_id));
-	  print_shell_escaped(pci_lookup_name(pacc, sdbuf, sizeof(sdbuf), PCI_LOOKUP_SUBSYSTEM | PCI_LOOKUP_DEVICE, p->vendor_id, p->device_id, sv_id, sd_id));
+	  print_shell_escaped(pci_lookup_name(pacc, svbuf, sizeof(svbuf), PCI_LOOKUP_SUBSYSTEM | PCI_LOOKUP_VENDOR, p->subsys_vendor_id));
+	  print_shell_escaped(pci_lookup_name(pacc, sdbuf, sizeof(sdbuf), PCI_LOOKUP_SUBSYSTEM | PCI_LOOKUP_DEVICE, p->vendor_id, p->device_id, p->subsys_vendor_id, p->subsys_id));
 	}
       else
 	printf(" \"\" \"\"");
diff --git a/lspci.h b/lspci.h
index 352177fcce7b..6e0bb2492fd5 100644
--- a/lspci.h
+++ b/lspci.h
@@ -55,8 +55,6 @@ u32 get_conf_long(struct device *d, unsigned int pos);
 word get_conf_word(struct device *d, unsigned int pos);
 byte get_conf_byte(struct device *d, unsigned int pos);
 
-void get_subid(struct device *d, word *subvp, word *subdp);
-
 /* Useful macros for decoding of bits and bit fields */
 
 #define FLAG(x,y) ((x & y) ? '+' : '-')
-- 
2.20.1

