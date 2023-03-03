Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8A86AA561
	for <lists+linux-pci@lfdr.de>; Sat,  4 Mar 2023 00:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjCCXI2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Mar 2023 18:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjCCXI1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Mar 2023 18:08:27 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837DA83C8;
        Fri,  3 Mar 2023 15:08:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BA607CE2297;
        Fri,  3 Mar 2023 21:46:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6A3C4339B;
        Fri,  3 Mar 2023 21:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677879974;
        bh=GIaYMnxTt3xtUH9CSMkECHels4+Db6rNimjFnVdSyMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VAny9cL3suiA2RdOdafLz6iduSqHMkbs7CMqIbIFvBtdfCp21apRfu4QQQBqeslp3
         37BB82KYg0lmkFmDmq3/Nx3PC53UXbzQRG22npHF401O+KEqa84UvSIuVrQPqeEsS+
         kwr+Q35mSkOcI6tM26GCucanQnXHaVWFGs/vqUk3Hdv2bpN6IFVgQvEebGwP+PYUmR
         AXEGNI39SfWODSN5KmiD++pppDMW02LrbwLLBCCIVBstyn7rwKumtIE2qLeB2NNsCC
         wRDYGdtTyWMMHtgc5iLuU6BbwnNvdhDGzNSZ6oKYnXBFpWc2WukSFZDfZBeaPtVAn6
         tfDjefBOheGtg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>, lpieralisi@kernel.org,
        kw@linux.com, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 20/50] PCI: loongson: Prevent LS7A MRRS increases
Date:   Fri,  3 Mar 2023 16:45:01 -0500
Message-Id: <20230303214531.1450154-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303214531.1450154-1-sashal@kernel.org>
References: <20230303214531.1450154-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Huacai Chen <chenhuacai@loongson.cn>

[ Upstream commit 8b3517f88ff2983f52698893519227c10aac90b2 ]

Except for isochronous-configured devices, software may set
Max_Read_Request_Size (MRRS) to any value up to 4096.  If a device issues a
read request with size greater than the completer's Max_Payload_Size (MPS),
the completer is required to break the response into multiple completions.

Instead of correctly responding with multiple completions to a large read
request, some LS7A Root Ports respond with a Completer Abort.  To prevent
this, the MRRS must be limited to an implementation-specific value.

The OS cannot detect that value, so rely on BIOS to configure MRRS before
booting, and quirk the Root Ports so we never set an MRRS larger than that
BIOS value for any downstream device.

N.B. Hot-added devices are not configured by BIOS, and they power up with
MRRS = 512 bytes, so these devices will be limited to 512 bytes.  If the
LS7A limit is smaller, those hot-added devices may not work correctly, but
per [1], hotplug is not supported with this chipset revision.

[1] https://lore.kernel.org/r/073638a7-ae68-2847-ac3d-29e5e760d6af@loongson.cn

[bhelgaas: commit log]
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216884
Link: https://lore.kernel.org/r/20230201043018.778499-3-chenhuacai@loongson.cn
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pci-loongson.c | 44 +++++++++------------------
 drivers/pci/pci.c                     | 10 ++++++
 include/linux/pci.h                   |  1 +
 3 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index 48169b1e38171..dc7b4e4293ced 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -60,37 +60,23 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 			DEV_LS7A_LPC, system_bus_quirk);
 
-static void loongson_mrrs_quirk(struct pci_dev *dev)
+static void loongson_mrrs_quirk(struct pci_dev *pdev)
 {
-	struct pci_bus *bus = dev->bus;
-	struct pci_dev *bridge;
-	static const struct pci_device_id bridge_devids[] = {
-		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_0) },
-		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_1) },
-		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_2) },
-		{ 0, },
-	};
-
-	/* look for the matching bridge */
-	while (!pci_is_root_bus(bus)) {
-		bridge = bus->self;
-		bus = bus->parent;
-		/*
-		 * Some Loongson PCIe ports have a h/w limitation of
-		 * 256 bytes maximum read request size. They can't handle
-		 * anything larger than this. So force this limit on
-		 * any devices attached under these ports.
-		 */
-		if (pci_match_id(bridge_devids, bridge)) {
-			if (pcie_get_readrq(dev) > 256) {
-				pci_info(dev, "limiting MRRS to 256\n");
-				pcie_set_readrq(dev, 256);
-			}
-			break;
-		}
-	}
+	/*
+	 * Some Loongson PCIe ports have h/w limitations of maximum read
+	 * request size. They can't handle anything larger than this. So
+	 * force this limit on any devices attached under these ports.
+	 */
+	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
+
+	bridge->no_inc_mrrs = 1;
 }
-DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
+			DEV_PCIE_PORT_0, loongson_mrrs_quirk);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
+			DEV_PCIE_PORT_1, loongson_mrrs_quirk);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
+			DEV_PCIE_PORT_2, loongson_mrrs_quirk);
 
 static void __iomem *cfg1_map(struct loongson_pci *priv, int bus,
 				unsigned int devfn, int where)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a0c6a9eeb7c6d..d0d27c3ead69a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5970,6 +5970,7 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
 {
 	u16 v;
 	int ret;
+	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
 
 	if (rq < 128 || rq > 4096 || !is_power_of_2(rq))
 		return -EINVAL;
@@ -5988,6 +5989,15 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
 
 	v = (ffs(rq) - 8) << 12;
 
+	if (bridge->no_inc_mrrs) {
+		int max_mrrs = pcie_get_readrq(dev);
+
+		if (rq > max_mrrs) {
+			pci_info(dev, "can't set Max_Read_Request_Size to %d; max is %d\n", rq, max_mrrs);
+			return -EINVAL;
+		}
+	}
+
 	ret = pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
 						  PCI_EXP_DEVCTL_READRQ, v);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9d6e75222868f..34dd24c991804 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -557,6 +557,7 @@ struct pci_host_bridge {
 	void		*release_data;
 	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
 	unsigned int	no_ext_tags:1;		/* No Extended Tags */
+	unsigned int	no_inc_mrrs:1;		/* No Increase MRRS */
 	unsigned int	native_aer:1;		/* OS may use PCIe AER */
 	unsigned int	native_pcie_hotplug:1;	/* OS may use PCIe hotplug */
 	unsigned int	native_shpc_hotplug:1;	/* OS may use SHPC hotplug */
-- 
2.39.2

