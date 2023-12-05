Return-Path: <linux-pci+bounces-522-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9A2805AE0
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 18:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575572821ED
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 17:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC3E6929B;
	Tue,  5 Dec 2023 17:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cc47frs6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6EE69288
	for <linux-pci@vger.kernel.org>; Tue,  5 Dec 2023 17:11:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14575C433C7;
	Tue,  5 Dec 2023 17:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701796294;
	bh=FiSPAvyirIPaDAA683jIvAenpsrIJHbqwJy3YwLfHjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cc47frs6jF+zRJ3YzgTYW4w2Usb3IFVTtjezSuDNa1GVq4KBrCdNSfSeNh59H6mEX
	 5IBuw1RsRQUMcjcex37wnmrROjge/d3e1/qURhkkFxnhOmw+iNskUWqMISEzMTI9Az
	 X6Pco/fu2sS7Ah4QNe13E0z1SVbuva1UwLWmdYkeQGR0WtImFYws44XO7Y+T6Lok6G
	 bwPg+mO2Rx/Hmr/rquMxrkHRoIJc/UA371tUnH39KVDQYrMqBqLXqTY1U7lKHRTtXx
	 JkwhFYNjmQlvQnKoqNh+8opnYSdoJoGgA9NQf6JSv3ze457jfn06Ynhewu/2zm/ELE
	 8g1z88lmtSb0A==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 5/7] PCI: Supply bridge device, not secondary bus, to read window details
Date: Tue,  5 Dec 2023 11:11:17 -0600
Message-Id: <20231205171119.680358-6-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205171119.680358-1-helgaas@kernel.org>
References: <20231205171119.680358-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Previously we logged information about devices *below* the bridge before
logging information about the bridge itself, e.g.,

  pci 0000:00:01.0: [8086:1901] type 01 class 0x060400
  pci 0000:01:00.0: [10de:13b6] type 00 class 0x030200
  pci 0000:01:00.0: reg 0x10: [mem 0xec000000-0xecffffff]
  pci 0000:00:01.0: PCI bridge to [bus 01]
  pci 0000:00:01.0:   bridge window [io  0xe000-0xefff]

This is partly because the bridge windows are read in this path:

  pci_scan_child_bus_extend
    for (devfn = 0; devfn < 256; devfn += 8)
      pci_scan_slot(bus, devfn)       # scan below bridge
    pcibios_fixup_bus(bus)
      pci_read_bridge_bases(bus)      # read bridge windows
        pci_read_bridge_io(bus)

Remove the assumption that the secondary (child) pci_bus already exists by
passing in the bridge device (instead of the pci_bus) and a resource
pointer when reading bridge windows.  A future change can use this to log
the bridge details before we enumerate the devices below the bridge.

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9ada89c2b8cd..5ac9c150e68b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -344,13 +344,11 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
 	}
 }
 
-static void pci_read_bridge_io(struct pci_bus *child)
+static void pci_read_bridge_io(struct pci_dev *dev, struct resource *res)
 {
-	struct pci_dev *dev = child->self;
 	u8 io_base_lo, io_limit_lo;
 	unsigned long io_mask, io_granularity, base, limit;
 	struct pci_bus_region region;
-	struct resource *res;
 
 	io_mask = PCI_IO_RANGE_MASK;
 	io_granularity = 0x1000;
@@ -360,7 +358,6 @@ static void pci_read_bridge_io(struct pci_bus *child)
 		io_granularity = 0x400;
 	}
 
-	res = child->resource[0];
 	pci_read_config_byte(dev, PCI_IO_BASE, &io_base_lo);
 	pci_read_config_byte(dev, PCI_IO_LIMIT, &io_limit_lo);
 	base = (io_base_lo & io_mask) << 8;
@@ -384,15 +381,12 @@ static void pci_read_bridge_io(struct pci_bus *child)
 	}
 }
 
-static void pci_read_bridge_mmio(struct pci_bus *child)
+static void pci_read_bridge_mmio(struct pci_dev *dev, struct resource *res)
 {
-	struct pci_dev *dev = child->self;
 	u16 mem_base_lo, mem_limit_lo;
 	unsigned long base, limit;
 	struct pci_bus_region region;
-	struct resource *res;
 
-	res = child->resource[1];
 	pci_read_config_word(dev, PCI_MEMORY_BASE, &mem_base_lo);
 	pci_read_config_word(dev, PCI_MEMORY_LIMIT, &mem_limit_lo);
 	base = ((unsigned long) mem_base_lo & PCI_MEMORY_RANGE_MASK) << 16;
@@ -406,16 +400,13 @@ static void pci_read_bridge_mmio(struct pci_bus *child)
 	}
 }
 
-static void pci_read_bridge_mmio_pref(struct pci_bus *child)
+static void pci_read_bridge_mmio_pref(struct pci_dev *dev, struct resource *res)
 {
-	struct pci_dev *dev = child->self;
 	u16 mem_base_lo, mem_limit_lo;
 	u64 base64, limit64;
 	pci_bus_addr_t base, limit;
 	struct pci_bus_region region;
-	struct resource *res;
 
-	res = child->resource[2];
 	pci_read_config_word(dev, PCI_PREF_MEMORY_BASE, &mem_base_lo);
 	pci_read_config_word(dev, PCI_PREF_MEMORY_LIMIT, &mem_limit_lo);
 	base64 = (mem_base_lo & PCI_PREF_RANGE_MASK) << 16;
@@ -527,9 +518,9 @@ void pci_read_bridge_bases(struct pci_bus *child)
 	for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++)
 		child->resource[i] = &dev->resource[PCI_BRIDGE_RESOURCES+i];
 
-	pci_read_bridge_io(child);
-	pci_read_bridge_mmio(child);
-	pci_read_bridge_mmio_pref(child);
+	pci_read_bridge_io(child->self, child->resource[0]);
+	pci_read_bridge_mmio(child->self, child->resource[1]);
+	pci_read_bridge_mmio_pref(child->self, child->resource[2]);
 
 	if (dev->transparent) {
 		pci_bus_for_each_resource(child->parent, res) {
-- 
2.34.1


