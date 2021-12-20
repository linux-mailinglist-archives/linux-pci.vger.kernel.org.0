Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B56647B0BE
	for <lists+linux-pci@lfdr.de>; Mon, 20 Dec 2021 16:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237536AbhLTPzW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Dec 2021 10:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237526AbhLTPzV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Dec 2021 10:55:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0FFC061574
        for <linux-pci@vger.kernel.org>; Mon, 20 Dec 2021 07:55:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DBF2FB80ED8
        for <linux-pci@vger.kernel.org>; Mon, 20 Dec 2021 15:55:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F89C36AEC;
        Mon, 20 Dec 2021 15:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640015718;
        bh=Oo9PjbLKtu4clAaya9aDZlITnMBZcc+oKWjQcMGljuQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nkuky35Oxr4fY0WtjqqhQ4PUihDZOp2MMS7utbPI1WmYKeg7XjA5d0Oojv/nXRphS
         VcXAEpQ3BAywBw+3krGEhoDYrHEWMEbezjXDJaW4Uy3pL1TbagPNIbCD6os9ifBxta
         8fgu4nEQ0JUorB+lje4YvZVTjs77UCqChZDbOgP2ThyEAf7zacwdrfnaEuURwxJREC
         orAgVUDMGXozbDGLPI8+W6Rh7TZrJSFF8AunyHjAQlHp9qZp36M66OsQ+75YLrsCpB
         VX7G4oe5wTX+Kf+NIIZg1l546g2IvQ9f7jAMyBEaTNawPwPZJIFkew4+BRsYN8qeF1
         OlfkOdfLtXCEw==
Received: by pali.im (Postfix)
        id F20E7286C; Mon, 20 Dec 2021 16:55:15 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: [PATCH pciutils 3/4] libpci: Add support for filling bridge resources
Date:   Mon, 20 Dec 2021 16:54:47 +0100
Message-Id: <20211220155448.1233-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211220155448.1233-1-pali@kernel.org>
References: <20211220155448.1233-1-pali@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Extend libpci API and ABI to fill bridge resources from sysfs.
---
 lib/access.c   | 20 +++++++++++---------
 lib/caps.c     |  2 +-
 lib/filter.c   |  2 +-
 lib/internal.h |  1 +
 lib/libpci.ver |  5 +++++
 lib/pci.h      |  4 ++++
 lib/sysfs.c    | 48 ++++++++++++++++++++++++++++++++++++++++++------
 7 files changed, 65 insertions(+), 17 deletions(-)

diff --git a/lib/access.c b/lib/access.c
index b257849a685e..a33e067e2389 100644
--- a/lib/access.c
+++ b/lib/access.c
@@ -189,7 +189,7 @@ pci_reset_properties(struct pci_dev *d)
 }
 
 int
-pci_fill_info_v35(struct pci_dev *d, int flags)
+pci_fill_info_v38(struct pci_dev *d, int flags)
 {
   unsigned int uflags = flags;
   if (uflags & PCI_FILL_RESCAN)
@@ -203,19 +203,21 @@ pci_fill_info_v35(struct pci_dev *d, int flags)
 }
 
 /* In version 3.1, pci_fill_info got new flags => versioned alias */
-/* In versions 3.2, 3.3, 3.4 and 3.5, the same has happened */
-STATIC_ALIAS(int pci_fill_info(struct pci_dev *d, int flags), pci_fill_info_v35(d, flags));
-DEFINE_ALIAS(int pci_fill_info_v30(struct pci_dev *d, int flags), pci_fill_info_v35);
-DEFINE_ALIAS(int pci_fill_info_v31(struct pci_dev *d, int flags), pci_fill_info_v35);
-DEFINE_ALIAS(int pci_fill_info_v32(struct pci_dev *d, int flags), pci_fill_info_v35);
-DEFINE_ALIAS(int pci_fill_info_v33(struct pci_dev *d, int flags), pci_fill_info_v35);
-DEFINE_ALIAS(int pci_fill_info_v34(struct pci_dev *d, int flags), pci_fill_info_v35);
+/* In versions 3.2, 3.3, 3.4, 3.5 and 3.8, the same has happened */
+STATIC_ALIAS(int pci_fill_info(struct pci_dev *d, int flags), pci_fill_info_v38(d, flags));
+DEFINE_ALIAS(int pci_fill_info_v30(struct pci_dev *d, int flags), pci_fill_info_v38);
+DEFINE_ALIAS(int pci_fill_info_v31(struct pci_dev *d, int flags), pci_fill_info_v38);
+DEFINE_ALIAS(int pci_fill_info_v32(struct pci_dev *d, int flags), pci_fill_info_v38);
+DEFINE_ALIAS(int pci_fill_info_v33(struct pci_dev *d, int flags), pci_fill_info_v38);
+DEFINE_ALIAS(int pci_fill_info_v34(struct pci_dev *d, int flags), pci_fill_info_v38);
+DEFINE_ALIAS(int pci_fill_info_v35(struct pci_dev *d, int flags), pci_fill_info_v38);
 SYMBOL_VERSION(pci_fill_info_v30, pci_fill_info@LIBPCI_3.0);
 SYMBOL_VERSION(pci_fill_info_v31, pci_fill_info@LIBPCI_3.1);
 SYMBOL_VERSION(pci_fill_info_v32, pci_fill_info@LIBPCI_3.2);
 SYMBOL_VERSION(pci_fill_info_v33, pci_fill_info@LIBPCI_3.3);
 SYMBOL_VERSION(pci_fill_info_v34, pci_fill_info@LIBPCI_3.4);
-SYMBOL_VERSION(pci_fill_info_v35, pci_fill_info@@LIBPCI_3.5);
+SYMBOL_VERSION(pci_fill_info_v35, pci_fill_info@LIBPCI_3.5);
+SYMBOL_VERSION(pci_fill_info_v38, pci_fill_info@@LIBPCI_3.8);
 
 void
 pci_setup_cache(struct pci_dev *d, byte *cache, int len)
diff --git a/lib/caps.c b/lib/caps.c
index c3b918059fe1..70a41b836e31 100644
--- a/lib/caps.c
+++ b/lib/caps.c
@@ -129,7 +129,7 @@ pci_find_cap_nr(struct pci_dev *d, unsigned int id, unsigned int type,
   unsigned int target = (cap_number ? *cap_number : 0);
   unsigned int index = 0;
 
-  pci_fill_info_v35(d, ((type == PCI_CAP_NORMAL) ? PCI_FILL_CAPS : PCI_FILL_EXT_CAPS));
+  pci_fill_info_v38(d, ((type == PCI_CAP_NORMAL) ? PCI_FILL_CAPS : PCI_FILL_EXT_CAPS));
 
   for (c=d->first_cap; c; c=c->next)
     {
diff --git a/lib/filter.c b/lib/filter.c
index 573fb2810363..195f813193c4 100644
--- a/lib/filter.c
+++ b/lib/filter.c
@@ -129,7 +129,7 @@ pci_filter_match_v33(struct pci_filter *f, struct pci_dev *d)
     return 0;
   if (f->device >= 0 || f->vendor >= 0)
     {
-      pci_fill_info_v35(d, PCI_FILL_IDENT);
+      pci_fill_info_v38(d, PCI_FILL_IDENT);
       if ((f->device >= 0 && f->device != d->device_id) ||
 	  (f->vendor >= 0 && f->vendor != d->vendor_id))
 	return 0;
diff --git a/lib/internal.h b/lib/internal.h
index 17c27e194a29..4df8dd70c2c6 100644
--- a/lib/internal.h
+++ b/lib/internal.h
@@ -74,6 +74,7 @@ int pci_fill_info_v32(struct pci_dev *, int flags) VERSIONED_ABI;
 int pci_fill_info_v33(struct pci_dev *, int flags) VERSIONED_ABI;
 int pci_fill_info_v34(struct pci_dev *, int flags) VERSIONED_ABI;
 int pci_fill_info_v35(struct pci_dev *, int flags) VERSIONED_ABI;
+int pci_fill_info_v38(struct pci_dev *, int flags) VERSIONED_ABI;
 
 struct pci_property {
   struct pci_property *next;
diff --git a/lib/libpci.ver b/lib/libpci.ver
index e20c3f581c71..73f7fa71e357 100644
--- a/lib/libpci.ver
+++ b/lib/libpci.ver
@@ -82,3 +82,8 @@ LIBPCI_3.7 {
 	global:
 		pci_find_cap_nr;
 };
+
+LIBPCI_3.8 {
+	global:
+		pci_fill_info;
+};
diff --git a/lib/pci.h b/lib/pci.h
index 814247691086..0ec7f211ca24 100644
--- a/lib/pci.h
+++ b/lib/pci.h
@@ -142,6 +142,9 @@ struct pci_dev {
   pciaddr_t flags[6];			/* PCI_IORESOURCE_* flags for regions */
   pciaddr_t rom_flags;			/* PCI_IORESOURCE_* flags for expansion ROM */
   int domain;				/* PCI domain (host bridge) */
+  pciaddr_t bridge_base_addr[4];	/* Bridge base addresses (without flags) */
+  pciaddr_t bridge_size[4];		/* Bridge sizes */
+  pciaddr_t bridge_flags[4];		/* PCI_IORESOURCE_* flags for bridge addresses */
 
   /* Fields used internally */
   struct pci_access *access;
@@ -205,6 +208,7 @@ char *pci_get_string_property(struct pci_dev *d, u32 prop) PCI_ABI;
 #define PCI_FILL_IO_FLAGS	0x1000
 #define PCI_FILL_DT_NODE	0x2000		/* Device tree node */
 #define PCI_FILL_IOMMU_GROUP	0x4000
+#define PCI_FILL_BRIDGE_BASES	0x8000
 #define PCI_FILL_RESCAN		0x00010000
 
 void pci_setup_cache(struct pci_dev *, u8 *cache, int len) PCI_ABI;
diff --git a/lib/sysfs.c b/lib/sysfs.c
index fb6424105e84..7c157a2688ad 100644
--- a/lib/sysfs.c
+++ b/lib/sysfs.c
@@ -148,19 +148,22 @@ sysfs_get_value(struct pci_dev *d, char *object, int mandatory)
     return -1;
 }
 
-static void
+static unsigned int
 sysfs_get_resources(struct pci_dev *d)
 {
   struct pci_access *a = d->access;
   char namebuf[OBJNAMELEN], buf[256];
+  struct { pciaddr_t flags, base_addr, size; } lines[10];
+  unsigned int done;
   FILE *file;
   int i;
 
+  done = 0;
   sysfs_obj_name(d, "resource", namebuf);
   file = fopen(namebuf, "r");
   if (!file)
     a->error("Cannot open %s: %s", namebuf, strerror(errno));
-  for (i = 0; i < 7; i++)
+  for (i = 0; i < 7+6+4+1; i++)
     {
       unsigned long long start, end, size, flags;
       if (!fgets(buf, sizeof(buf), file))
@@ -177,16 +180,50 @@ sysfs_get_resources(struct pci_dev *d)
 	  flags &= PCI_ADDR_FLAG_MASK;
 	  d->base_addr[i] = start | flags;
 	  d->size[i] = size;
+	  done |= PCI_FILL_BASES | PCI_FILL_SIZES | PCI_FILL_IO_FLAGS;
 	}
-      else
+      else if (i == 6)
 	{
 	  d->rom_flags = flags;
 	  flags &= PCI_ADDR_FLAG_MASK;
 	  d->rom_base_addr = start | flags;
 	  d->rom_size = size;
+	  done |= PCI_FILL_ROM_BASE;
 	}
+      else if (i < 7+6+4)
+        {
+          /*
+           * If kernel was compiled without CONFIG_PCI_IOV option then after
+           * the ROM line for configured bridge device (that which had set
+           * subordinary bus number to non-zero value) are four additional lines
+           * which describe resources behind bridge. For PCI-to-PCI bridges they
+           * are: IO, MEM, PREFMEM and empty. For CardBus bridges they are: IO0,
+           * IO1, MEM0 and MEM1. For unconfigured bridges and other devices
+           * there is no additional line after the ROM line. If kernel was
+           * compiled with CONFIG_PCI_IOV option then after the ROM line and
+           * before the first bridge resource line are six additional lines
+           * which describe IOV resources. Read all remaining lines in resource
+           * file and based on the number of remaining lines (0, 4, 6, 10) parse
+           * resources behind bridge.
+           */
+          lines[i-7].flags = flags;
+          lines[i-7].base_addr = start;
+          lines[i-7].size = size;
+        }
+    }
+  if (i == 7+4 || i == 7+6+4)
+    {
+      int offset = (i == 7+6+4) ? 6 : 0;
+      for (i = 0; i < 4; i++)
+        {
+          d->bridge_flags[i] = lines[offset+i].flags;
+          d->bridge_base_addr[i] = lines[offset+i].base_addr;
+          d->bridge_size[i] = lines[offset+i].size;
+        }
+      done |= PCI_FILL_BRIDGE_BASES;
     }
   fclose(file);
+  return done;
 }
 
 static void sysfs_scan(struct pci_access *a)
@@ -316,10 +353,9 @@ sysfs_fill_info(struct pci_dev *d, unsigned int flags)
 	  d->irq = sysfs_get_value(d, "irq", 1);
 	  done |= PCI_FILL_IRQ;
 	}
-      if (flags & (PCI_FILL_BASES | PCI_FILL_ROM_BASE | PCI_FILL_SIZES | PCI_FILL_IO_FLAGS))
+      if (flags & (PCI_FILL_BASES | PCI_FILL_ROM_BASE | PCI_FILL_SIZES | PCI_FILL_IO_FLAGS | PCI_FILL_BRIDGE_BASES))
 	{
-	  sysfs_get_resources(d);
-	  done |= PCI_FILL_BASES | PCI_FILL_ROM_BASE | PCI_FILL_SIZES | PCI_FILL_IO_FLAGS;
+	  done |= sysfs_get_resources(d);
 	}
     }
 
-- 
2.20.1

