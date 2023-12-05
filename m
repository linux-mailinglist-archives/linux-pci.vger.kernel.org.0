Return-Path: <linux-pci+bounces-524-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1233805AE3
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 18:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EC7D1C21591
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 17:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311F66928A;
	Tue,  5 Dec 2023 17:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWd+Vuli"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123A469288
	for <linux-pci@vger.kernel.org>; Tue,  5 Dec 2023 17:11:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC000C433CB;
	Tue,  5 Dec 2023 17:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701796297;
	bh=jnAj2HzSS5vLJibcc4v+uRFESuzSPOByS1GHsvUTy9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XWd+Vuliw7I30Xv/FEB3vpVrtgjnAAJqCo+K0uWqQpL2ZAh4AmxEuhAzXml++pzjU
	 1K4J94zasO03kdfCU14uoVtE/yKiG6tyZ9UYLDS9DzLlh4/hZsPjiol1cIPDwTr/uC
	 tzEEy71R9oRND3JJiGV0rQqX39BHBTrLUtJfNErcubRE09HUre1p6q62t9bM1WvUZ6
	 S+B36WavgqyR2xH14BtJ87K51CE8UNyaiE8bB0EjAKrg5a6P4MjJkBWcLVbaUI+rVh
	 SfyZOZl1zqE1v/+W94y0lbrWShDLU41rde61RxTgdtwR+UyepBOvzpx4mBT1LuWS2V
	 hoMRGyRpZY+xA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 7/7] PCI: Log bridge info when first enumerating bridge
Date: Tue,  5 Dec 2023 11:11:19 -0600
Message-Id: <20231205171119.680358-8-helgaas@kernel.org>
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

Log bridge secondary/subordinate bus and window information at the same
time we log the bridge BARs, just after discovering the bridge and before
scanning the bridge's secondary bus.  This logs the bridge and downstream
devices in a more logical order:

  - pci 0000:00:01.0: [8086:1901] type 01 class 0x060400
  - pci 0000:01:00.0: [10de:13b6] type 00 class 0x030200
  - pci 0000:01:00.0: reg 0x10: [mem 0xec000000-0xecffffff]
  - pci 0000:00:01.0: PCI bridge to [bus 01]
  - pci 0000:00:01.0:   bridge window [io  0xe000-0xefff]

  + pci 0000:00:01.0: [8086:1901] type 01 class 0x060400
  + pci 0000:00:01.0: PCI bridge to [bus 01]
  + pci 0000:00:01.0:   bridge window [io  0xe000-0xefff]
  + pci 0000:01:00.0: [10de:13b6] type 00 class 0x030200
  + pci 0000:01:00.0: reg 0x10: [mem 0xec000000-0xecffffff]

Note that we read the windows into a temporary struct resource that is
thrown away, not into the resources in the struct pci_bus.

The windows may be adjusted after we know what downstream devices require,
and those adjustments are logged as they are made.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 485d8c7aae04..7a4b500bffa1 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -458,8 +458,17 @@ static void pci_read_bridge_mmio_pref(struct pci_dev *dev, struct resource *res,
 
 static void pci_read_bridge_windows(struct pci_dev *bridge)
 {
+	u32 buses;
 	u16 io;
 	u32 pmem, tmp;
+	struct resource res;
+
+	pci_read_config_dword(bridge, PCI_PRIMARY_BUS, &buses);
+	res.flags = IORESOURCE_BUS;
+	res.start = (buses >> 8) & 0xff;
+	res.end = (buses >> 16) & 0xff;
+	pci_info(bridge, "PCI bridge to %pR%s\n", &res,
+		 bridge->transparent ? " (subtractive decode)" : "");
 
 	pci_read_config_word(bridge, PCI_IO_BASE, &io);
 	if (!io) {
@@ -467,8 +476,12 @@ static void pci_read_bridge_windows(struct pci_dev *bridge)
 		pci_read_config_word(bridge, PCI_IO_BASE, &io);
 		pci_write_config_word(bridge, PCI_IO_BASE, 0x0);
 	}
-	if (io)
+	if (io) {
 		bridge->io_window = 1;
+		pci_read_bridge_io(bridge, &res, true);
+	}
+
+	pci_read_bridge_mmio(bridge, &res, true);
 
 	/*
 	 * DECchip 21050 pass 2 errata: the bridge may miss an address
@@ -505,6 +518,8 @@ static void pci_read_bridge_windows(struct pci_dev *bridge)
 		if (tmp)
 			bridge->pref_64_window = 1;
 	}
+
+	pci_read_bridge_mmio_pref(bridge, &res, true);
 }
 
 void pci_read_bridge_bases(struct pci_bus *child)
@@ -524,9 +539,9 @@ void pci_read_bridge_bases(struct pci_bus *child)
 	for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++)
 		child->resource[i] = &dev->resource[PCI_BRIDGE_RESOURCES+i];
 
-	pci_read_bridge_io(child->self, child->resource[0], true);
-	pci_read_bridge_mmio(child->self, child->resource[1], true);
-	pci_read_bridge_mmio_pref(child->self, child->resource[2], true);
+	pci_read_bridge_io(child->self, child->resource[0], false);
+	pci_read_bridge_mmio(child->self, child->resource[1], false);
+	pci_read_bridge_mmio_pref(child->self, child->resource[2], false);
 
 	if (dev->transparent) {
 		pci_bus_for_each_resource(child->parent, res) {
-- 
2.34.1


