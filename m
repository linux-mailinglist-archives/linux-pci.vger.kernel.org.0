Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253C147B0BD
	for <lists+linux-pci@lfdr.de>; Mon, 20 Dec 2021 16:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237493AbhLTPzU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Dec 2021 10:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237485AbhLTPzU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Dec 2021 10:55:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADE7C061574
        for <linux-pci@vger.kernel.org>; Mon, 20 Dec 2021 07:55:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDD4F611F9
        for <linux-pci@vger.kernel.org>; Mon, 20 Dec 2021 15:55:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06DDC36AEA;
        Mon, 20 Dec 2021 15:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640015719;
        bh=T05/YNjPFDghICfDXkICo0Bm+dd7+FNtzHl70nXgzvY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=cWIjyk8bgKzxm+UmeyXR3NtxHgaGxmdlGKKWs+nUjwTvGboPNQKtec3l+c/yPAEF3
         aGo8aSn5Iyqg0rWSGpWI5r2Kiy+fxvsVXxAlo001EAc/a4PveJF2oo2OKQo2nrFzP4
         o82irEZOeQ0Db/P7IsUWmKqSvGj7ADTDrYUDNIyVt1BFT4Rp9M/roZq40XArKLpi5E
         dIrTEinlKnYyU70Taq75V+wOaOkl96akd2o+hOjZ7h0xzxq7W51vcKbj1LQuXM9CUe
         XloIAoEBIr/XMmf2i/33DNx/XOAqHsa1h/r6BWF3CPbbhxjnNpbh8y8uc8EsAxc4D8
         n/mLTAbXKDZOQ==
Received: by pali.im (Postfix)
        id 85FF92879; Mon, 20 Dec 2021 16:55:16 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: [PATCH pciutils 4/4] lspci: Use PCI_FILL_BRIDGE_BASES to detect if range behind bridge is disabled or unsupported
Date:   Mon, 20 Dec 2021 16:54:48 +0100
Message-Id: <20211220155448.1233-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211220155448.1233-1-pali@kernel.org>
References: <20211220155448.1233-1-pali@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Show resources behind bridge as reported by PCI_FILL_BRIDGE_BASES.

I/O or Prefetchable memory behind bridge is unsupported by bridge if both
base and limit bridge registers are read-only and returns zero. So if base
and limit registers returns zero (which is valid enabled range) and kernel
reports that particular resource is disabled it means that resource is
unsupported. Both I/O or Prefetchable memory resources are only optional.
---
 lspci.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 9 deletions(-)

diff --git a/lspci.c b/lspci.c
index 67ac19b61a29..d14d1b9185d6 100644
--- a/lspci.c
+++ b/lspci.c
@@ -374,12 +374,12 @@ show_size(u64 x)
 }
 
 static void
-show_range(char *prefix, u64 base, u64 limit, int bits)
+show_range(char *prefix, u64 base, u64 limit, int bits, int disabled)
 {
   printf("%s:", prefix);
   if (base <= limit || verbose > 2)
     printf(" %0*" PCI_U64_FMT_X "-%0*" PCI_U64_FMT_X, (bits+3)/4, base, (bits+3)/4, limit);
-  if (base <= limit)
+  if (!disabled && base <= limit)
     show_size(limit - base + 1);
   else
     printf(" [disabled]");
@@ -543,6 +543,7 @@ show_htype0(struct device *d)
 static void
 show_htype1(struct device *d)
 {
+  struct pci_dev *p = d->dev;
   u32 io_base = get_conf_byte(d, PCI_IO_BASE);
   u32 io_limit = get_conf_byte(d, PCI_IO_LIMIT);
   u32 io_type = io_base & PCI_IO_RANGE_TYPE_MASK;
@@ -554,6 +555,10 @@ show_htype1(struct device *d)
   u32 pref_type = pref_base & PCI_PREF_RANGE_TYPE_MASK;
   word sec_stat = get_conf_word(d, PCI_SEC_STATUS);
   word brc = get_conf_word(d, PCI_BRIDGE_CONTROL);
+  int io_disabled = (p->known_fields & PCI_FILL_BRIDGE_BASES) && !p->bridge_size[0];
+  int mem_disabled = (p->known_fields & PCI_FILL_BRIDGE_BASES) && !p->bridge_size[1];
+  int pref_disabled = (p->known_fields & PCI_FILL_BRIDGE_BASES) && !p->bridge_size[2];
+  int io_bits, pref_bits;
 
   show_bases(d, 2);
   printf("\tBus: primary=%02x, secondary=%02x, subordinate=%02x, sec-latency=%d\n",
@@ -562,7 +567,15 @@ show_htype1(struct device *d)
 	 get_conf_byte(d, PCI_SUBORDINATE_BUS),
 	 get_conf_byte(d, PCI_SEC_LATENCY_TIMER));
 
-  if (io_type != (io_limit & PCI_IO_RANGE_TYPE_MASK) ||
+  if ((p->known_fields & PCI_FILL_BRIDGE_BASES) && !io_disabled)
+    {
+      io_base = p->bridge_base_addr[0] & PCI_IO_RANGE_MASK;
+      io_limit = io_base + p->bridge_size[0] - 1;
+      io_type = p->bridge_base_addr[0] & PCI_IO_RANGE_TYPE_MASK;
+      io_bits = (io_type == PCI_IO_RANGE_TYPE_32) ? 32 : 16;
+      show_range("\tI/O behind bridge", io_base, io_limit, io_bits, io_disabled);
+    }
+  else if (io_type != (io_limit & PCI_IO_RANGE_TYPE_MASK) ||
       (io_type != PCI_IO_RANGE_TYPE_16 && io_type != PCI_IO_RANGE_TYPE_32))
     printf("\t!!! Unknown I/O range types %x/%x\n", io_base, io_limit);
   else
@@ -574,20 +587,40 @@ show_htype1(struct device *d)
 	  io_base |= (get_conf_word(d, PCI_IO_BASE_UPPER16) << 16);
 	  io_limit |= (get_conf_word(d, PCI_IO_LIMIT_UPPER16) << 16);
 	}
-      show_range("\tI/O behind bridge", io_base, io_limit+0xfff, (io_type == PCI_IO_RANGE_TYPE_32) ? 32 : 16);
+      /* I/O is unsupported if both base and limit are zeros and resource is disabled */
+      if (!(io_base == 0x0 && io_limit == 0x0 && io_disabled))
+        {
+          io_limit += 0xfff;
+          io_bits = (io_type == PCI_IO_RANGE_TYPE_32) ? 32 : 16;
+          show_range("\tI/O behind bridge", io_base, io_limit, io_bits, io_disabled);
+        }
     }
 
-  if (mem_type != (mem_limit & PCI_MEMORY_RANGE_TYPE_MASK) ||
+  if ((p->known_fields & PCI_FILL_BRIDGE_BASES) && !mem_disabled)
+    {
+      mem_base = p->bridge_base_addr[1] & PCI_MEMORY_RANGE_MASK;
+      mem_limit = mem_base + p->bridge_size[1] - 1;
+      show_range("\tMemory behind bridge", mem_base, mem_limit, 32, mem_disabled);
+    }
+  else if (mem_type != (mem_limit & PCI_MEMORY_RANGE_TYPE_MASK) ||
       mem_type)
     printf("\t!!! Unknown memory range types %x/%x\n", mem_base, mem_limit);
   else
     {
       mem_base = (mem_base & PCI_MEMORY_RANGE_MASK) << 16;
       mem_limit = (mem_limit & PCI_MEMORY_RANGE_MASK) << 16;
-      show_range("\tMemory behind bridge", mem_base, mem_limit + 0xfffff, 32);
+      show_range("\tMemory behind bridge", mem_base, mem_limit + 0xfffff, 32, mem_disabled);
     }
 
-  if (pref_type != (pref_limit & PCI_PREF_RANGE_TYPE_MASK) ||
+  if ((p->known_fields & PCI_FILL_BRIDGE_BASES) && !pref_disabled)
+    {
+      u64 pref_base_64 = p->bridge_base_addr[2] & PCI_MEMORY_RANGE_MASK;
+      u64 pref_limit_64 = pref_base_64 + p->bridge_size[2] - 1;
+      pref_type = p->bridge_base_addr[2] & PCI_MEMORY_RANGE_TYPE_MASK;
+      pref_bits = (pref_type == PCI_PREF_RANGE_TYPE_64) ? 64 : 32;
+      show_range("\tPrefetchable memory behind bridge", pref_base_64, pref_limit_64, pref_bits, pref_disabled);
+    }
+  else if (pref_type != (pref_limit & PCI_PREF_RANGE_TYPE_MASK) ||
       (pref_type != PCI_PREF_RANGE_TYPE_32 && pref_type != PCI_PREF_RANGE_TYPE_64))
     printf("\t!!! Unknown prefetchable memory range types %x/%x\n", pref_base, pref_limit);
   else
@@ -599,7 +632,13 @@ show_htype1(struct device *d)
 	  pref_base_64 |= (u64) get_conf_long(d, PCI_PREF_BASE_UPPER32) << 32;
 	  pref_limit_64 |= (u64) get_conf_long(d, PCI_PREF_LIMIT_UPPER32) << 32;
 	}
-      show_range("\tPrefetchable memory behind bridge", pref_base_64, pref_limit_64 + 0xfffff, (pref_type == PCI_PREF_RANGE_TYPE_64) ? 64 : 32);
+      /* Prefetchable memory is unsupported if both base and limit are zeros and resource is disabled */
+      if (!(pref_base_64 == 0x0 && pref_limit_64 == 0x0 && pref_disabled))
+        {
+          pref_limit_64 += 0xfffff;
+          pref_bits = (pref_type == PCI_PREF_RANGE_TYPE_64) ? 64 : 32;
+          show_range("\tPrefetchable memory behind bridge", pref_base_64, pref_limit_64, pref_bits, pref_disabled);
+        }
     }
 
   if (verbose > 1)
@@ -726,7 +765,8 @@ show_verbose(struct device *d)
   show_terse(d);
 
   pci_fill_info(p, PCI_FILL_IRQ | PCI_FILL_BASES | PCI_FILL_ROM_BASE | PCI_FILL_SIZES |
-    PCI_FILL_PHYS_SLOT | PCI_FILL_NUMA_NODE | PCI_FILL_DT_NODE | PCI_FILL_IOMMU_GROUP);
+    PCI_FILL_PHYS_SLOT | PCI_FILL_NUMA_NODE | PCI_FILL_DT_NODE | PCI_FILL_IOMMU_GROUP |
+    PCI_FILL_BRIDGE_BASES);
   irq = p->irq;
 
   switch (htype)
-- 
2.20.1

