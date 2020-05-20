Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5A51DBCF4
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 20:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgETSeR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 14:34:17 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:40905 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgETSeR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 14:34:17 -0400
Received: by mail-ej1-f67.google.com with SMTP id d7so5282213eja.7
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2020 11:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xBjDvMKT6sV5ohdoMZD0VOkKjhMnUEO1xbEuEfWEVqs=;
        b=sf83aQgLZ/3ri/Wd9HfMN9NWA3R6wTMbUcvtAT6+b53ohiDbpsgvuun9Vxmdq/UT4Z
         fc6lnp9yYLG2U4e703GYitUOtpFj5XlHKuH4iew5gAYxqeQCR3+tZfVZNfrc6tuNWhE8
         BGimzzcdTeSTPSp9S/ubVAeT7qlke82+kpXO7Z4+4lBhfHIizyFFWwlFG7JSN1Kr4bZ/
         yzINylPvMbaKj2xUtwCK811RAgWwP7kVDPx01IHgCJnOYFb/FjqlytqHaii0MtdcRb6A
         voT1Z4pvwa4vdp/Q71EdhR3N8XWf391K/wLCL3n9uCFsbmQJThS+5Axs/+naw9m5IZ6y
         eBaA==
X-Gm-Message-State: AOAM531fasCRCOPqPTLAP1hdZTCIsG4SaEccmCZDMCBIqVy7oczSugp2
        ASd3viy3NEfxCA6WFiIbzgU=
X-Google-Smtp-Source: ABdhPJxx3lULyf/olAiRhmVDJhxTu8Gd8i/KqbnEkU08W10iztNYNQxDqXvMq/9l1qtDrFWUkTLfaw==
X-Received: by 2002:a17:906:f06:: with SMTP id z6mr364042eji.105.1589999654386;
        Wed, 20 May 2020 11:34:14 -0700 (PDT)
Received: from localhost.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id z3sm2739855ejl.38.2020.05.20.11.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 11:34:13 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Chuhong Yuan <hslester96@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org
Subject: [PATCH v3 1/2] PCI: Move from using PCI_BRIDGE_RESOURCES to bridge resource definitions
Date:   Wed, 20 May 2020 18:34:10 +0000
Message-Id: <20200520183411.1534621-2-kw@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520183411.1534621-1-kw@linux.com>
References: <20200520170609.GA1102503@bjorn-Precision-5520>
 <20200520183411.1534621-1-kw@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move to use bridge resource definitions instead of using the
PCI_BRIDGE_RESOURCES constant with an integer offeset.

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
 drivers/pci/quirks.c          |  34 +++++-----
 drivers/pci/setup-bus.c       | 114 ++++++++++++++++++----------------
 drivers/pcmcia/yenta_socket.c |  22 ++++---
 include/linux/pci.h           |  14 ++++-
 4 files changed, 104 insertions(+), 80 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ca9ed5774eb1..08a94a0534de 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -653,8 +653,8 @@ DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_SYNOPSYS, PCI_ANY_ID,
  */
 static void quirk_ali7101_acpi(struct pci_dev *dev)
 {
-	quirk_io_region(dev, 0xE0, 64, PCI_BRIDGE_RESOURCES, "ali7101 ACPI");
-	quirk_io_region(dev, 0xE2, 32, PCI_BRIDGE_RESOURCES+1, "ali7101 SMB");
+	quirk_io_region(dev, 0xE0, 64, PCI_BRIDGE_IO_WINDOW, "ali7101 ACPI");
+	quirk_io_region(dev, 0xE2, 32, PCI_BRIDGE_MEM_WINDOW, "ali7101 SMB");
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL,	PCI_DEVICE_ID_AL_M7101,		quirk_ali7101_acpi);
 
@@ -720,8 +720,8 @@ static void quirk_piix4_acpi(struct pci_dev *dev)
 {
 	u32 res_a;
 
-	quirk_io_region(dev, 0x40, 64, PCI_BRIDGE_RESOURCES, "PIIX4 ACPI");
-	quirk_io_region(dev, 0x90, 16, PCI_BRIDGE_RESOURCES+1, "PIIX4 SMB");
+	quirk_io_region(dev, 0x40, 64, PCI_BRIDGE_IO_WINDOW, "PIIX4 ACPI");
+	quirk_io_region(dev, 0x90, 16, PCI_BRIDGE_MEM_WINDOW, "PIIX4 SMB");
 
 	/* Device resource A has enables for some of the other ones */
 	pci_read_config_dword(dev, 0x5c, &res_a);
@@ -776,12 +776,12 @@ static void quirk_ich4_lpc_acpi(struct pci_dev *dev)
 	 */
 	pci_read_config_byte(dev, ICH_ACPI_CNTL, &enable);
 	if (enable & ICH4_ACPI_EN)
-		quirk_io_region(dev, ICH_PMBASE, 128, PCI_BRIDGE_RESOURCES,
-				 "ICH4 ACPI/GPIO/TCO");
+		quirk_io_region(dev, ICH_PMBASE, 128, PCI_BRIDGE_IO_WINDOW,
+				"ICH4 ACPI/GPIO/TCO");
 
 	pci_read_config_byte(dev, ICH4_GPIO_CNTL, &enable);
 	if (enable & ICH4_GPIO_EN)
-		quirk_io_region(dev, ICH4_GPIOBASE, 64, PCI_BRIDGE_RESOURCES+1,
+		quirk_io_region(dev, ICH4_GPIOBASE, 64, PCI_BRIDGE_MEM_WINDOW,
 				"ICH4 GPIO");
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801AA_0,		quirk_ich4_lpc_acpi);
@@ -801,12 +801,12 @@ static void ich6_lpc_acpi_gpio(struct pci_dev *dev)
 
 	pci_read_config_byte(dev, ICH_ACPI_CNTL, &enable);
 	if (enable & ICH6_ACPI_EN)
-		quirk_io_region(dev, ICH_PMBASE, 128, PCI_BRIDGE_RESOURCES,
-				 "ICH6 ACPI/GPIO/TCO");
+		quirk_io_region(dev, ICH_PMBASE, 128, PCI_BRIDGE_IO_WINDOW,
+				"ICH6 ACPI/GPIO/TCO");
 
 	pci_read_config_byte(dev, ICH6_GPIO_CNTL, &enable);
 	if (enable & ICH6_GPIO_EN)
-		quirk_io_region(dev, ICH6_GPIOBASE, 64, PCI_BRIDGE_RESOURCES+1,
+		quirk_io_region(dev, ICH6_GPIOBASE, 64, PCI_BRIDGE_MEM_WINDOW,
 				"ICH6 GPIO");
 }
 
@@ -911,7 +911,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_ICH10_1, qui
 static void quirk_vt82c586_acpi(struct pci_dev *dev)
 {
 	if (dev->revision & 0x10)
-		quirk_io_region(dev, 0x48, 256, PCI_BRIDGE_RESOURCES,
+		quirk_io_region(dev, 0x48, 256, PCI_BRIDGE_IO_WINDOW,
 				"vt82c586 ACPI");
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_vt82c586_acpi);
@@ -926,10 +926,10 @@ static void quirk_vt82c686_acpi(struct pci_dev *dev)
 {
 	quirk_vt82c586_acpi(dev);
 
-	quirk_io_region(dev, 0x70, 128, PCI_BRIDGE_RESOURCES+1,
-				 "vt82c686 HW-mon");
-
-	quirk_io_region(dev, 0x90, 16, PCI_BRIDGE_RESOURCES+2, "vt82c686 SMB");
+	quirk_io_region(dev, 0x70, 128, PCI_BRIDGE_MEM_WINDOW,
+			"vt82c686 HW-mon");
+	quirk_io_region(dev, 0x90, 16, PCI_BRIDGE_PREF_MEM_WINDOW,
+			"vt82c686 SMB");
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_vt82c686_acpi);
 
@@ -940,8 +940,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_vt
  */
 static void quirk_vt8235_acpi(struct pci_dev *dev)
 {
-	quirk_io_region(dev, 0x88, 128, PCI_BRIDGE_RESOURCES, "vt8235 PM");
-	quirk_io_region(dev, 0xd0, 16, PCI_BRIDGE_RESOURCES+1, "vt8235 SMB");
+	quirk_io_region(dev, 0x88, 128, PCI_BRIDGE_IO_WINDOW, "vt8235 PM");
+	quirk_io_region(dev, 0xd0, 16, PCI_BRIDGE_MEM_WINDOW, "vt8235 SMB");
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8235,	quirk_vt8235_acpi);
 
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index bbcef1a053ab..4346d958bff1 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -583,7 +583,7 @@ static void pci_setup_bridge_io(struct pci_dev *bridge)
 		io_mask = PCI_IO_1K_RANGE_MASK;
 
 	/* Set up the top and bottom of the PCI I/O segment for this bus */
-	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 0];
+	res = &bridge->resource[PCI_BRIDGE_IO_WINDOW];
 	pcibios_resource_to_bus(bridge->bus, &region, res);
 	if (res->flags & IORESOURCE_IO) {
 		pci_read_config_word(bridge, PCI_IO_BASE, &l);
@@ -613,7 +613,7 @@ static void pci_setup_bridge_mmio(struct pci_dev *bridge)
 	u32 l;
 
 	/* Set up the top and bottom of the PCI Memory segment for this bus */
-	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 1];
+	res = &bridge->resource[PCI_BRIDGE_MEM_WINDOW];
 	pcibios_resource_to_bus(bridge->bus, &region, res);
 	if (res->flags & IORESOURCE_MEM) {
 		l = (region.start >> 16) & 0xfff0;
@@ -640,7 +640,7 @@ static void pci_setup_bridge_mmio_pref(struct pci_dev *bridge)
 
 	/* Set up PREF base/limit */
 	bu = lu = 0;
-	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 2];
+	res = &bridge->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
 	pcibios_resource_to_bus(bridge->bus, &region, res);
 	if (res->flags & IORESOURCE_PREFETCH) {
 		l = (region.start >> 16) & 0xfff0;
@@ -707,14 +707,14 @@ int pci_claim_bridge_resource(struct pci_dev *bridge, int i)
 	if (!pci_bus_clip_resource(bridge, i))
 		return -EINVAL;	/* Clipping didn't change anything */
 
-	switch (i - PCI_BRIDGE_RESOURCES) {
-	case 0:
+	switch (i) {
+	case PCI_BRIDGE_IO_WINDOW:
 		pci_setup_bridge_io(bridge);
 		break;
-	case 1:
+	case PCI_BRIDGE_MEM_WINDOW:
 		pci_setup_bridge_mmio(bridge);
 		break;
-	case 2:
+	case PCI_BRIDGE_PREF_MEM_WINDOW:
 		pci_setup_bridge_mmio_pref(bridge);
 		break;
 	default:
@@ -735,18 +735,22 @@ int pci_claim_bridge_resource(struct pci_dev *bridge, int i)
 static void pci_bridge_check_ranges(struct pci_bus *bus)
 {
 	struct pci_dev *bridge = bus->self;
-	struct resource *b_res = &bridge->resource[PCI_BRIDGE_RESOURCES];
+	struct resource *b_res;
 
-	b_res[1].flags |= IORESOURCE_MEM;
+	b_res = &bridge->resource[PCI_BRIDGE_MEM_WINDOW];
+	b_res->flags |= IORESOURCE_MEM;
 
-	if (bridge->io_window)
-		b_res[0].flags |= IORESOURCE_IO;
+	if (bridge->io_window) {
+		b_res = &bridge->resource[PCI_BRIDGE_IO_WINDOW];
+		b_res->flags |= IORESOURCE_IO;
+	}
 
 	if (bridge->pref_window) {
-		b_res[2].flags |= IORESOURCE_MEM | IORESOURCE_PREFETCH;
+		b_res = &bridge->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
+		b_res->flags |= IORESOURCE_MEM | IORESOURCE_PREFETCH;
 		if (bridge->pref_64_window) {
-			b_res[2].flags |= IORESOURCE_MEM_64;
-			b_res[2].flags |= PCI_PREF_RANGE_TYPE_64;
+			b_res->flags |= IORESOURCE_MEM_64 |
+					PCI_PREF_RANGE_TYPE_64;
 		}
 	}
 }
@@ -1105,35 +1109,37 @@ static void pci_bus_size_cardbus(struct pci_bus *bus,
 				 struct list_head *realloc_head)
 {
 	struct pci_dev *bridge = bus->self;
-	struct resource *b_res = &bridge->resource[PCI_BRIDGE_RESOURCES];
+	struct resource *b_res;
 	resource_size_t b_res_3_size = pci_cardbus_mem_size * 2;
 	u16 ctrl;
 
-	if (b_res[0].parent)
+	b_res = &bridge->resource[PCI_CB_BRIDGE_IO_0_WINDOW];
+	if (b_res->parent)
 		goto handle_b_res_1;
 	/*
 	 * Reserve some resources for CardBus.  We reserve a fixed amount
 	 * of bus space for CardBus bridges.
 	 */
-	b_res[0].start = pci_cardbus_io_size;
-	b_res[0].end = b_res[0].start + pci_cardbus_io_size - 1;
-	b_res[0].flags |= IORESOURCE_IO | IORESOURCE_STARTALIGN;
+	b_res->start = pci_cardbus_io_size;
+	b_res->end = b_res->start + pci_cardbus_io_size - 1;
+	b_res->flags |= IORESOURCE_IO | IORESOURCE_STARTALIGN;
 	if (realloc_head) {
-		b_res[0].end -= pci_cardbus_io_size;
+		b_res->end -= pci_cardbus_io_size;
 		add_to_list(realloc_head, bridge, b_res, pci_cardbus_io_size,
-				pci_cardbus_io_size);
+			    pci_cardbus_io_size);
 	}
 
 handle_b_res_1:
-	if (b_res[1].parent)
+	b_res = &bridge->resource[PCI_CB_BRIDGE_IO_1_WINDOW];
+	if (b_res->parent)
 		goto handle_b_res_2;
-	b_res[1].start = pci_cardbus_io_size;
-	b_res[1].end = b_res[1].start + pci_cardbus_io_size - 1;
-	b_res[1].flags |= IORESOURCE_IO | IORESOURCE_STARTALIGN;
+	b_res->start = pci_cardbus_io_size;
+	b_res->end = b_res->start + pci_cardbus_io_size - 1;
+	b_res->flags |= IORESOURCE_IO | IORESOURCE_STARTALIGN;
 	if (realloc_head) {
-		b_res[1].end -= pci_cardbus_io_size;
-		add_to_list(realloc_head, bridge, b_res+1, pci_cardbus_io_size,
-				 pci_cardbus_io_size);
+		b_res->end -= pci_cardbus_io_size;
+		add_to_list(realloc_head, bridge, b_res, pci_cardbus_io_size,
+			    pci_cardbus_io_size);
 	}
 
 handle_b_res_2:
@@ -1153,21 +1159,22 @@ static void pci_bus_size_cardbus(struct pci_bus *bus,
 		pci_read_config_word(bridge, PCI_CB_BRIDGE_CONTROL, &ctrl);
 	}
 
-	if (b_res[2].parent)
+	b_res = &bridge->resource[PCI_CB_BRIDGE_MEM_0_WINDOW];
+	if (b_res->parent)
 		goto handle_b_res_3;
 	/*
 	 * If we have prefetchable memory support, allocate two regions.
 	 * Otherwise, allocate one region of twice the size.
 	 */
 	if (ctrl & PCI_CB_BRIDGE_CTL_PREFETCH_MEM0) {
-		b_res[2].start = pci_cardbus_mem_size;
-		b_res[2].end = b_res[2].start + pci_cardbus_mem_size - 1;
-		b_res[2].flags |= IORESOURCE_MEM | IORESOURCE_PREFETCH |
-				  IORESOURCE_STARTALIGN;
+		b_res->start = pci_cardbus_mem_size;
+		b_res->end = b_res->start + pci_cardbus_mem_size - 1;
+		b_res->flags |= IORESOURCE_MEM | IORESOURCE_PREFETCH |
+				    IORESOURCE_STARTALIGN;
 		if (realloc_head) {
-			b_res[2].end -= pci_cardbus_mem_size;
-			add_to_list(realloc_head, bridge, b_res+2,
-				 pci_cardbus_mem_size, pci_cardbus_mem_size);
+			b_res->end -= pci_cardbus_mem_size;
+			add_to_list(realloc_head, bridge, b_res,
+				    pci_cardbus_mem_size, pci_cardbus_mem_size);
 		}
 
 		/* Reduce that to half */
@@ -1175,15 +1182,16 @@ static void pci_bus_size_cardbus(struct pci_bus *bus,
 	}
 
 handle_b_res_3:
-	if (b_res[3].parent)
+	b_res = &bridge->resource[PCI_CB_BRIDGE_MEM_1_WINDOW];
+	if (b_res->parent)
 		goto handle_done;
-	b_res[3].start = pci_cardbus_mem_size;
-	b_res[3].end = b_res[3].start + b_res_3_size - 1;
-	b_res[3].flags |= IORESOURCE_MEM | IORESOURCE_STARTALIGN;
+	mmio1_res->start = pci_cardbus_mem_size;
+	mmio1_res->end = b_res->start + b_res_3_size - 1;
+	mmio1_res->flags |= IORESOURCE_MEM | IORESOURCE_STARTALIGN;
 	if (realloc_head) {
-		b_res[3].end -= b_res_3_size;
-		add_to_list(realloc_head, bridge, b_res+3, b_res_3_size,
-				 pci_cardbus_mem_size);
+		b_res->end -= b_res_3_size;
+		add_to_list(realloc_head, bridge, b_res, b_res_3_size,
+			    pci_cardbus_mem_size);
 	}
 
 handle_done:
@@ -1227,7 +1235,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 				break;
 		hdr_type = -1;	/* Intentionally invalid - not a PCI device. */
 	} else {
-		pref = &bus->self->resource[PCI_BRIDGE_RESOURCES + 2];
+		pref = &bus->self->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
 		hdr_type = bus->self->hdr_type;
 	}
 
@@ -1885,9 +1893,9 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 	struct pci_dev *dev, *bridge = bus->self;
 	resource_size_t io_per_hp, mmio_per_hp, mmio_pref_per_hp, align;
 
-	io_res = &bridge->resource[PCI_BRIDGE_RESOURCES + 0];
-	mmio_res = &bridge->resource[PCI_BRIDGE_RESOURCES + 1];
-	mmio_pref_res = &bridge->resource[PCI_BRIDGE_RESOURCES + 2];
+	io_res = &bridge->resource[PCI_BRIDGE_IO_WINDOW];
+	mmio_res = &bridge->resource[PCI_BRIDGE_MEM_WINDOW];
+	mmio_pref_res = &bridge->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
 
 	/*
 	 * The alignment of this bridge is yet to be considered, hence it must
@@ -1960,21 +1968,21 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 		 * Reduce the available resource space by what the
 		 * bridge and devices below it occupy.
 		 */
-		res = &dev->resource[PCI_BRIDGE_RESOURCES + 0];
+		res = &dev->resource[PCI_BRIDGE_IO_WINDOW];
 		align = pci_resource_alignment(dev, res);
 		align = align ? ALIGN(io.start, align) - io.start : 0;
 		used_size = align + resource_size(res);
 		if (!res->parent)
 			io.start = min(io.start + used_size, io.end + 1);
 
-		res = &dev->resource[PCI_BRIDGE_RESOURCES + 1];
+		res = &dev->resource[PCI_BRIDGE_MEM_WINDOW];
 		align = pci_resource_alignment(dev, res);
 		align = align ? ALIGN(mmio.start, align) - mmio.start : 0;
 		used_size = align + resource_size(res);
 		if (!res->parent)
 			mmio.start = min(mmio.start + used_size, mmio.end + 1);
 
-		res = &dev->resource[PCI_BRIDGE_RESOURCES + 2];
+		res = &dev->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
 		align = pci_resource_alignment(dev, res);
 		align = align ? ALIGN(mmio_pref.start, align) -
 			mmio_pref.start : 0;
@@ -2027,9 +2035,9 @@ static void pci_bridge_distribute_available_resources(struct pci_dev *bridge,
 		return;
 
 	/* Take the initial extra resources from the hotplug port */
-	available_io = bridge->resource[PCI_BRIDGE_RESOURCES + 0];
-	available_mmio = bridge->resource[PCI_BRIDGE_RESOURCES + 1];
-	available_mmio_pref = bridge->resource[PCI_BRIDGE_RESOURCES + 2];
+	available_io = bridge->resource[PCI_BRIDGE_IO_WINDOW];
+	available_mmio = bridge->resource[PCI_BRIDGE_MEM_WINDOW];
+	available_mmio_pref = bridge->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
 
 	pci_bus_distribute_available_resources(bridge->subordinate,
 					       add_list, available_io,
diff --git a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
index bf6529b0b5b0..76036ccf2106 100644
--- a/drivers/pcmcia/yenta_socket.c
+++ b/drivers/pcmcia/yenta_socket.c
@@ -694,7 +694,7 @@ static int yenta_allocate_res(struct yenta_socket *socket, int nr, unsigned type
 	struct pci_bus_region region;
 	unsigned mask;
 
-	res = dev->resource + PCI_BRIDGE_RESOURCES + nr;
+	res = &dev->resource[nr];
 	/* Already allocated? */
 	if (res->parent)
 		return 0;
@@ -711,7 +711,7 @@ static int yenta_allocate_res(struct yenta_socket *socket, int nr, unsigned type
 	region.end = config_readl(socket, addr_end) | ~mask;
 	if (region.start && region.end > region.start && !override_bios) {
 		pcibios_bus_to_resource(dev->bus, res, &region);
-		if (pci_claim_resource(dev, PCI_BRIDGE_RESOURCES + nr) == 0)
+		if (pci_claim_resource(dev, nr) == 0)
 			return 0;
 		dev_info(&dev->dev,
 			 "Preassigned resource %d busy or not available, reconfiguring...\n",
@@ -751,14 +751,18 @@ static int yenta_allocate_res(struct yenta_socket *socket, int nr, unsigned type
 static void yenta_allocate_resources(struct yenta_socket *socket)
 {
 	int program = 0;
-	program += yenta_allocate_res(socket, 0, IORESOURCE_IO,
-			   PCI_CB_IO_BASE_0, PCI_CB_IO_LIMIT_0);
-	program += yenta_allocate_res(socket, 1, IORESOURCE_IO,
-			   PCI_CB_IO_BASE_1, PCI_CB_IO_LIMIT_1);
-	program += yenta_allocate_res(socket, 2, IORESOURCE_MEM|IORESOURCE_PREFETCH,
+	program += yenta_allocate_res(socket, PCI_CB_BRIDGE_IO_0_WINDOW,
+			   IORESOURCE_IO, PCI_CB_IO_BASE_0,
+			   PCI_CB_IO_LIMIT_0);
+	program += yenta_allocate_res(socket, PCI_CB_BRIDGE_IO_1_WINDOW,
+			   IORESOURCE_IO, PCI_CB_IO_BASE_1,
+			   PCI_CB_IO_LIMIT_1);
+	program += yenta_allocate_res(socket, PCI_CB_BRIDGE_MEM_0_WINDOW,
+			   IORESOURCE_MEM | IORESOURCE_PREFETCH,
 			   PCI_CB_MEMORY_BASE_0, PCI_CB_MEMORY_LIMIT_0);
-	program += yenta_allocate_res(socket, 3, IORESOURCE_MEM,
-			   PCI_CB_MEMORY_BASE_1, PCI_CB_MEMORY_LIMIT_1);
+	program += yenta_allocate_res(socket, PCI_CB_BRIDGE_MEM_1_WINDOW,
+			   IORESOURCE_MEM, PCI_CB_MEMORY_BASE_1,
+			   PCI_CB_MEMORY_LIMIT_1);
 	if (program)
 		pci_setup_cardbus(socket->dev->subordinate);
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 83ce1cdf5676..cdfb07bfdf7d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -100,9 +100,21 @@ enum {
 	PCI_IOV_RESOURCE_END = PCI_IOV_RESOURCES + PCI_SRIOV_NUM_BARS - 1,
 #endif
 
-	/* Resources assigned to buses behind the bridge */
+/* PCI-to-PCI (P2P) bridge windows */
+#define PCI_BRIDGE_IO_WINDOW		(PCI_BRIDGE_RESOURCES + 0)
+#define PCI_BRIDGE_MEM_WINDOW		(PCI_BRIDGE_RESOURCES + 1)
+#define PCI_BRIDGE_PREF_MEM_WINDOW	(PCI_BRIDGE_RESOURCES + 2)
+
+/* CardBus bridge windows */
+#define PCI_CB_BRIDGE_IO_0_WINDOW	(PCI_BRIDGE_RESOURCES + 0)
+#define PCI_CB_BRIDGE_IO_1_WINDOW	(PCI_BRIDGE_RESOURCES + 1)
+#define PCI_CB_BRIDGE_MEM_0_WINDOW	(PCI_BRIDGE_RESOURCES + 2)
+#define PCI_CB_BRIDGE_MEM_1_WINDOW	(PCI_BRIDGE_RESOURCES + 3)
+
+/* Total number of bridge resources for P2P and CardBus */
 #define PCI_BRIDGE_RESOURCE_NUM 4
 
+	/* Resources assigned to buses behind the bridge */
 	PCI_BRIDGE_RESOURCES,
 	PCI_BRIDGE_RESOURCE_END = PCI_BRIDGE_RESOURCES +
 				  PCI_BRIDGE_RESOURCE_NUM - 1,
-- 
2.26.2

