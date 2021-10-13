Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28BE042B250
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 03:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbhJMBnl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 21:43:41 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:34631 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbhJMBnl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Oct 2021 21:43:41 -0400
Received: by mail-wr1-f42.google.com with SMTP id y3so2906018wrl.1
        for <linux-pci@vger.kernel.org>; Tue, 12 Oct 2021 18:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=32NenQIB+2j0abI1APn0XF0e5kmc+onGeNxxdWPCVtc=;
        b=n/SqVOxY2Ynhco7g9M11YXsIHjjuqTicF0F7MxahaA4Dn+ZyKKiNXLLP+CfP0AlanO
         UFegzrVN6nvZCVv7KyXqgsTvFFw3+O0X7vlTkgfeppaXNaEHKJGb63WTvrYLuDDg0XnT
         wA6r0QLr5sHoeJ+3wuzbJe8AkQfdrNj+HI+kFHz8fBCRZ+gXQkhJ9c2SBFdrkpSym5dk
         KSIkIActj+faXu/xahya4d/WQ4en0x6m+dhhyIt/yhhjfFc1KcQ4sYat+DlgiTLMNiXS
         ndI+PWO39h1h1AvtUCJiYXkGZXoCopBbuV0bIo1FRMk76Pg/vDxdI9qRNHYrsqyk3GX+
         CzRQ==
X-Gm-Message-State: AOAM5325lpL7xCPuvEnjEpoa2SgE1R5orrKZ6GJsqQ774fMKspE7Aeh/
        SAQn59grpkrG2mqgmweXvkxFgxL1MW0=
X-Google-Smtp-Source: ABdhPJxFBcfT+6aRMY7nyeHxHBee/IMfJ2TPlTaAMZXQU5idA7Iu7i/DITVUWal/MDVcwx1ZFMhU1w==
X-Received: by 2002:a05:600c:1909:: with SMTP id j9mr9634638wmq.138.1634089297859;
        Tue, 12 Oct 2021 18:41:37 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id t14sm10423701wrr.75.2021.10.12.18.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 18:41:37 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI: Use unsigned int type explicitly when declaring variables
Date:   Wed, 13 Oct 2021 01:41:36 +0000
Message-Id: <20211013014136.1117543-1-kw@linux.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The bare "unsigned" type implicitly means "unsigned int", but as per the
preferred coding style the preference is to spell the completely type
name explicitly to remove any possible ambiguity from the code.

Thus, update the bare use of "unsigned" to the preferred "unsigned int"
to keep the style consistent throughout the kernel code base.

 No change to functionality intended.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/pci-thunder-ecam.c |  4 ++--
 drivers/pci/msi.c                         |  3 ++-
 drivers/pci/pci.c                         |  5 +++--
 drivers/pci/probe.c                       |  7 ++++---
 drivers/pci/quirks.c                      | 12 ++++++------
 drivers/pci/rom.c                         |  2 +-
 drivers/pci/setup-bus.c                   |  2 +-
 7 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/pci-thunder-ecam.c b/drivers/pci/controller/pci-thunder-ecam.c
index ffd84656544f..e9d5ca245f5e 100644
--- a/drivers/pci/controller/pci-thunder-ecam.c
+++ b/drivers/pci/controller/pci-thunder-ecam.c
@@ -17,7 +17,7 @@ static void set_val(u32 v, int where, int size, u32 *val)
 {
 	int shift = (where & 3) * 8;
 
-	pr_debug("set_val %04x: %08x\n", (unsigned)(where & ~3), v);
+	pr_debug("set_val %04x: %08x\n", (unsigned int)(where & ~3), v);
 	v >>= shift;
 	if (size == 1)
 		v &= 0xff;
@@ -187,7 +187,7 @@ static int thunder_ecam_config_read(struct pci_bus *bus, unsigned int devfn,
 
 	pr_debug("%04x:%04x - Fix pass#: %08x, where: %03x, devfn: %03x\n",
 		 vendor_device & 0xffff, vendor_device >> 16, class_rev,
-		 (unsigned) where, devfn);
+		 (unsigned int)where, devfn);
 
 	/* Check for non type-00 header */
 	if (cfg_type == 0) {
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 0099a00af361..bdc6ba7f39f0 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -579,7 +579,8 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 	return ret;
 }
 
-static void __iomem *msix_map_region(struct pci_dev *dev, unsigned nr_entries)
+static void __iomem *msix_map_region(struct pci_dev *dev,
+				     unsigned int nr_entries)
 {
 	resource_size_t phys_addr;
 	u32 table_offset;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ce2ab62b64cf..fa4f27f747fd 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6324,11 +6324,12 @@ EXPORT_SYMBOL_GPL(pci_pr3_present);
  * cannot be left as a userspace activity).  DMA aliases should therefore
  * be configured via quirks, such as the PCI fixup header quirk.
  */
-void pci_add_dma_alias(struct pci_dev *dev, u8 devfn_from, unsigned nr_devfns)
+void pci_add_dma_alias(struct pci_dev *dev, u8 devfn_from,
+		       unsigned int nr_devfns)
 {
 	int devfn_to;
 
-	nr_devfns = min(nr_devfns, (unsigned) MAX_NR_DEVFNS - devfn_from);
+	nr_devfns = min(nr_devfns, (unsigned int)MAX_NR_DEVFNS - devfn_from);
 	devfn_to = devfn_from + nr_devfns - 1;
 
 	if (!dev->dma_alias_mask)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index d9fc02a71baa..51c0a33640e6 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2550,11 +2550,12 @@ struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
 }
 EXPORT_SYMBOL(pci_scan_single_device);
 
-static unsigned next_fn(struct pci_bus *bus, struct pci_dev *dev, unsigned fn)
+static unsigned int next_fn(struct pci_bus *bus, struct pci_dev *dev,
+			    unsigned int fn)
 {
 	int pos;
 	u16 cap = 0;
-	unsigned next_fn;
+	unsigned int next_fn;
 
 	if (pci_ari_enabled(bus)) {
 		if (!dev)
@@ -2613,7 +2614,7 @@ static int only_one_child(struct pci_bus *bus)
  */
 int pci_scan_slot(struct pci_bus *bus, int devfn)
 {
-	unsigned fn, nr = 0;
+	unsigned int fn, nr = 0;
 	struct pci_dev *dev;
 
 	if (only_one_child(bus) && (devfn > 0))
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4537d1ea14fd..67107840ce84 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -501,7 +501,7 @@ static void quirk_s3_64M(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_868,		quirk_s3_64M);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_968,		quirk_s3_64M);
 
-static void quirk_io(struct pci_dev *dev, int pos, unsigned size,
+static void quirk_io(struct pci_dev *dev, int pos, unsigned int size,
 		     const char *name)
 {
 	u32 region;
@@ -552,7 +552,7 @@ static void quirk_cs5536_vsa(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_ISA, quirk_cs5536_vsa);
 
 static void quirk_io_region(struct pci_dev *dev, int port,
-				unsigned size, int nr, const char *name)
+			    unsigned int size, int nr, const char *name)
 {
 	u16 region;
 	struct pci_bus_region bus_region;
@@ -666,7 +666,7 @@ static void piix4_io_quirk(struct pci_dev *dev, const char *name, unsigned int p
 	base = devres & 0xffff;
 	size = 16;
 	for (;;) {
-		unsigned bit = size >> 1;
+		unsigned int bit = size >> 1;
 		if ((bit & mask) == bit)
 			break;
 		size = bit;
@@ -692,7 +692,7 @@ static void piix4_mem_quirk(struct pci_dev *dev, const char *name, unsigned int
 	mask = (devres & 0x3f) << 16;
 	size = 128 << 16;
 	for (;;) {
-		unsigned bit = size >> 1;
+		unsigned int bit = size >> 1;
 		if ((bit & mask) == bit)
 			break;
 		size = bit;
@@ -806,7 +806,7 @@ static void ich6_lpc_acpi_gpio(struct pci_dev *dev)
 				"ICH6 GPIO");
 }
 
-static void ich6_lpc_generic_decode(struct pci_dev *dev, unsigned reg,
+static void ich6_lpc_generic_decode(struct pci_dev *dev, unsigned int reg,
 				    const char *name, int dynsize)
 {
 	u32 val;
@@ -850,7 +850,7 @@ static void quirk_ich6_lpc(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_0, quirk_ich6_lpc);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1, quirk_ich6_lpc);
 
-static void ich7_lpc_generic_decode(struct pci_dev *dev, unsigned reg,
+static void ich7_lpc_generic_decode(struct pci_dev *dev, unsigned int reg,
 				    const char *name)
 {
 	u32 val;
diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
index 8fc9a4e911e3..e18d3a4383ba 100644
--- a/drivers/pci/rom.c
+++ b/drivers/pci/rom.c
@@ -85,7 +85,7 @@ static size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom,
 {
 	void __iomem *image;
 	int last_image;
-	unsigned length;
+	unsigned int length;
 
 	image = rom;
 	do {
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 2ce636937c6e..547396ec50b5 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1525,7 +1525,7 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 {
 	struct pci_dev *dev = bus->self;
 	struct resource *r;
-	unsigned old_flags = 0;
+	unsigned int old_flags = 0;
 	struct resource *b_res;
 	int idx = 1;
 
-- 
2.33.0

