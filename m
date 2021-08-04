Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6AD3E0391
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 16:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238235AbhHDOmv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 10:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238251AbhHDOmv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Aug 2021 10:42:51 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DF1C061798;
        Wed,  4 Aug 2021 07:42:37 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id a192-20020a1c7fc90000b0290253b32e8796so3832753wmd.0;
        Wed, 04 Aug 2021 07:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MpnIO2xBgCnTl7I7dsMGSjvMiUewawNjaHLlAJOkwUU=;
        b=Z6jCJ0Zit4gn7HMvPE5iTZmpIMDQquOHkh/r/e07nEPbVb4u8awq/Z5xj+J4zKyE+z
         lbCI1uD4I7dGKd3HyuAKs/uE6r3+mnVhX5ERSlJj+Wk3JJUOvLseoP89IwXoo7LXYOCT
         thlSNEThVYAJO70MItTFqsZoaT+34YekXIOYW+gmu6ZGCvBZyAbTj92Vmusk+iEszTES
         oMrswtqG74y175WYStmQYqzJUKu0Atda2iWgmv91KkTcj0VoYywFVHKvOnuBaUtbgHB7
         VcUTmYCYFIzO6GUFRKM3TY9O82RI7KzPdfOlJLMtTS/Q1QMZ+fmiWdOJe/XYRqae6cQB
         gSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MpnIO2xBgCnTl7I7dsMGSjvMiUewawNjaHLlAJOkwUU=;
        b=pdDbyDimhM4O7N4a3NqBdKbNzFqbh4j1OKLaNUlg4iCUmJrpDSVIVfKTA1R9Ik12nr
         fDH/U3AGz1rtENXowsiUVT9zTI46nKwbOIb+Ly6p2XUR+v56YJlymg+8PWLI9KQ5EjM6
         BI6Z5aR9dIocxo57Hrl54bW85mN5NWQX/tdkC5yvb+nsn+lpLpeFgAJyOpTg7YxbN3/9
         un5qN90ia2bEgiupNxmz97zv0xVMXnQwDlqy84D/726ZuRPWqbtBrtIlJ8L8ZqtUlUua
         CXAEoAO7cfegcXLv71ZSu3+kIfCF+NcXf2IKrn93Q/3fOlmDMixsneFZOLC7Gh9l2fwj
         DlFg==
X-Gm-Message-State: AOAM5324p1pn+I3QH/Vs26XmXUgamLz9tdx1mFjcoTFztgMOGEktvE+K
        dGa1vsYlvNh3Zydp5hsYR/s=
X-Google-Smtp-Source: ABdhPJxfE5A15GCVD4iC26pUOfrWxxRzlZ0KNaz0unuBSPC1DdgOD4qLdA4sRQoAhl/kZBJvVEH0Jg==
X-Received: by 2002:a1c:c91a:: with SMTP id f26mr28092345wmb.162.1628088155448;
        Wed, 04 Aug 2021 07:42:35 -0700 (PDT)
Received: from icebear.localdomain ([170.253.11.129])
        by smtp.gmail.com with ESMTPSA id h4sm2988684wru.2.2021.08.04.07.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 07:42:35 -0700 (PDT)
From:   "=?UTF-8?q?Sergio=20Migu=C3=A9ns=20Iglesias?=" <lonyelon@gmail.com>
X-Google-Original-From: =?UTF-8?q?Sergio=20Migu=C3=A9ns=20Iglesias?= <sergio@lony.xyz>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Sergio=20Migu=C3=A9ns=20Iglesias?= <sergio@lony.xyz>
Subject: [PATCH] pci: probe: Fixed code style
Date:   Wed,  4 Aug 2021 16:42:19 +0200
Message-Id: <20210804144219.791004-1-sergio@lony.xyz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fixed the code style for "drivers/pci/probe.c".

Signed-off-by: Sergio Miguéns Iglesias <sergio@lony.xyz>
---
 drivers/pci/probe.c | 43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 79177ac37880..b584822868d1 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -110,6 +110,7 @@ postcore_initcall(pcibus_class_init);
 static u64 pci_size(u64 base, u64 maxbase, u64 mask)
 {
 	u64 size = mask & maxbase;	/* Find the significant bits */
+
 	if (!size)
 		return 0;
 
@@ -331,12 +332,14 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
 
 	for (pos = 0; pos < howmany; pos++) {
 		struct resource *res = &dev->resource[pos];
+
 		reg = PCI_BASE_ADDRESS_0 + (pos << 2);
 		pos += __pci_read_base(dev, pci_bar_unknown, res, reg);
 	}
 
 	if (rom) {
 		struct resource *res = &dev->resource[PCI_ROM_RESOURCE];
+
 		dev->rom_base_reg = rom;
 		res->flags = IORESOURCE_MEM | IORESOURCE_PREFETCH |
 				IORESOURCE_READONLY | IORESOURCE_SIZEALIGN;
@@ -1376,6 +1379,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 			 */
 			for (i = 0; i < CARDBUS_RESERVE_BUSNR; i++) {
 				struct pci_bus *parent = bus;
+
 				if (pci_find_bus(pci_domain_nr(bus),
 							max+i+1))
 					break;
@@ -1880,6 +1884,7 @@ int pci_setup_device(struct pci_dev *dev)
 		 */
 		if (class == PCI_CLASS_STORAGE_IDE) {
 			u8 progif;
+
 			pci_read_config_byte(dev, PCI_CLASS_PROG, &progif);
 			if ((progif & 1) == 0) {
 				region.start = 0x1F0;
@@ -1948,7 +1953,7 @@ int pci_setup_device(struct pci_dev *dev)
 			dev->hdr_type);
 		return -EIO;
 
-	bad:
+bad:
 		pci_err(dev, "ignoring class %#08x (doesn't match header type %02x)\n",
 			dev->class, dev->hdr_type);
 		dev->class = PCI_CLASS_NOT_DEFINED << 8;
@@ -2155,9 +2160,9 @@ static void pci_configure_ltr(struct pci_dev *dev)
 	 * Complex and all intermediate Switches indicate support for LTR.
 	 * PCIe r4.0, sec 6.18.
 	 */
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
-	    ((bridge = pci_upstream_bridge(dev)) &&
-	      bridge->ltr_path)) {
+	bridge = pci_upstream_bridge(dev);
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT || (bridge &&
+		bridge->ltr_path)) {
 		pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
 					 PCI_EXP_DEVCTL2_LTR_EN);
 		dev->ltr_path = 1;
@@ -2543,11 +2548,11 @@ struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
 }
 EXPORT_SYMBOL(pci_scan_single_device);
 
-static unsigned next_fn(struct pci_bus *bus, struct pci_dev *dev, unsigned fn)
+static unsigned int next_fn(struct pci_bus *bus, struct pci_dev *dev, unsigned int fn)
 {
 	int pos;
 	u16 cap = 0;
-	unsigned next_fn;
+	unsigned int next_fn;
 
 	if (pci_ari_enabled(bus)) {
 		if (!dev)
@@ -2606,7 +2611,7 @@ static int only_one_child(struct pci_bus *bus)
  */
 int pci_scan_slot(struct pci_bus *bus, int devfn)
 {
-	unsigned fn, nr = 0;
+	unsigned int fn, nr = 0;
 	struct pci_dev *dev;
 
 	if (only_one_child(bus) && (devfn > 0))
@@ -3190,11 +3195,11 @@ struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops,
 	pci_add_resource(&resources, &iomem_resource);
 	pci_add_resource(&resources, &busn_resource);
 	b = pci_create_root_bus(NULL, bus, ops, sysdata, &resources);
-	if (b) {
+	if (b)
 		pci_scan_child_bus(b);
-	} else {
+	else
 		pci_free_resource_list(&resources);
-	}
+
 	return b;
 }
 EXPORT_SYMBOL(pci_scan_bus);
@@ -3269,14 +3274,20 @@ static int __init pci_sort_bf_cmp(const struct device *d_a,
 	const struct pci_dev *a = to_pci_dev(d_a);
 	const struct pci_dev *b = to_pci_dev(d_b);
 
-	if      (pci_domain_nr(a->bus) < pci_domain_nr(b->bus)) return -1;
-	else if (pci_domain_nr(a->bus) > pci_domain_nr(b->bus)) return  1;
+	if (pci_domain_nr(a->bus) < pci_domain_nr(b->bus))
+		return -1;
+	else if (pci_domain_nr(a->bus) > pci_domain_nr(b->bus))
+		return  1;
 
-	if      (a->bus->number < b->bus->number) return -1;
-	else if (a->bus->number > b->bus->number) return  1;
+	if (a->bus->number < b->bus->number)
+		return -1;
+	else if (a->bus->number > b->bus->number)
+		return  1;
 
-	if      (a->devfn < b->devfn) return -1;
-	else if (a->devfn > b->devfn) return  1;
+	if (a->devfn < b->devfn)
+		return -1;
+	else if (a->devfn > b->devfn)
+		return  1;
 
 	return 0;
 }
-- 
2.32.0

