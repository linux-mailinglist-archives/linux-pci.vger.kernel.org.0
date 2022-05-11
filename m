Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63A6523EBF
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 22:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbiEKUT3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 16:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347750AbiEKUTQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 16:19:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF256EB3B
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 13:19:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0DB8B82622
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 20:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26741C34115;
        Wed, 11 May 2022 20:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652300352;
        bh=GcIFL1Zaw06z8wikJmGXyiDv5pXwICLT8GihMgPZAOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QsAuGwWRjZLg0p1K51sLj/oW3RnzG/LbWXcY7ONNKp2fsEg44rkekEjL6VlUMqlG3
         5bnClDh/ywXf0VN5OVQKTjbSR/F262VLUBTs8V5Z7gXSzBWWthhz7xoQs4A5eJIWR4
         tYc61ro0ZW8Pb/wsrRny5sVrOy4SqlTKKKPENpkZL2F0tg6zIZ5krZ2ItSucmeHh5y
         O52UULkwsR8ShdvKZePIAHp0A1vt599LhC4CTkRNI+s2p4d++6nw3aEGjT9eplTO+t
         XeMChMP2cEQno2r0/DdPavYId6Fo6IcJM+yWSB8/elhfb1rpVVFv10jH6b+JSkndEB
         2GSmRboQ1e00w==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        regressions@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 3/4] Revert "PCI: brcmstb: Add mechanism to turn on subdev regulators"
Date:   Wed, 11 May 2022 15:18:55 -0500
Message-Id: <20220511201856.808690-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511201856.808690-1-helgaas@kernel.org>
References: <20220511201856.808690-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

This reverts commit 67211aadcb4b968d0fdc57bc27240fa71500c2d4.

This is part of a revert of the following commits:

  11ed8b8624b8 ("PCI: brcmstb: Do not turn off WOL regulators on suspend")
  93e41f3fca3d ("PCI: brcmstb: Add control of subdevice voltage regulators")
  67211aadcb4b ("PCI: brcmstb: Add mechanism to turn on subdev regulators")
  830aa6f29f07 ("PCI: brcmstb: Split brcm_pcie_setup() into two funcs")

Cyril reported that 830aa6f29f07 ("PCI: brcmstb: Split brcm_pcie_setup()
into two funcs"), which appeared in v5.17-rc1, broke booting on the
Raspberry Pi Compute Module 4.  Apparently 830aa6f29f07 panics with an
Asynchronous SError Interrupt, and after further commits here is a black
screen on HDMI and no output on the serial console.

This does not seem to affect the Raspberry Pi 4 B.

Reported-by: Cyril Brulebois <kibi@debian.org>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215925
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 76 ---------------------------
 1 file changed, 76 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index fd464d38fecb..0e8346114a8d 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -24,7 +24,6 @@
 #include <linux/pci.h>
 #include <linux/pci-ecam.h>
 #include <linux/printk.h>
-#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
@@ -284,14 +283,6 @@ static const struct pcie_cfg_data bcm2711_cfg = {
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 };
 
-struct subdev_regulators {
-	unsigned int num_supplies;
-	struct regulator_bulk_data supplies[];
-};
-
-static int pci_subdev_regulators_add_bus(struct pci_bus *bus);
-static void pci_subdev_regulators_remove_bus(struct pci_bus *bus);
-
 struct brcm_msi {
 	struct device		*dev;
 	void __iomem		*base;
@@ -445,71 +436,6 @@ static int brcm_pcie_set_ssc(struct brcm_pcie *pcie)
 	return ssc && pll ? 0 : -EIO;
 }
 
-static void *alloc_subdev_regulators(struct device *dev)
-{
-	static const char * const supplies[] = {
-		"vpcie3v3",
-		"vpcie3v3aux",
-		"vpcie12v",
-	};
-	const size_t size = sizeof(struct subdev_regulators)
-		+ sizeof(struct regulator_bulk_data) * ARRAY_SIZE(supplies);
-	struct subdev_regulators *sr;
-	int i;
-
-	sr = devm_kzalloc(dev, size, GFP_KERNEL);
-	if (sr) {
-		sr->num_supplies = ARRAY_SIZE(supplies);
-		for (i = 0; i < ARRAY_SIZE(supplies); i++)
-			sr->supplies[i].supply = supplies[i];
-	}
-
-	return sr;
-}
-
-static int pci_subdev_regulators_add_bus(struct pci_bus *bus)
-{
-	struct device *dev = &bus->dev;
-	struct subdev_regulators *sr;
-	int ret;
-
-	if (!dev->of_node || !bus->parent || !pci_is_root_bus(bus->parent))
-		return 0;
-
-	if (dev->driver_data)
-		dev_err(dev, "dev.driver_data unexpectedly non-NULL\n");
-
-	sr = alloc_subdev_regulators(dev);
-	if (!sr)
-		return -ENOMEM;
-
-	dev->driver_data = sr;
-	ret = regulator_bulk_get(dev, sr->num_supplies, sr->supplies);
-	if (ret)
-		return ret;
-
-	ret = regulator_bulk_enable(sr->num_supplies, sr->supplies);
-	if (ret) {
-		dev_err(dev, "failed to enable regulators for downstream device\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-static void pci_subdev_regulators_remove_bus(struct pci_bus *bus)
-{
-	struct device *dev = &bus->dev;
-	struct subdev_regulators *sr = dev->driver_data;
-
-	if (!sr || !bus->parent || !pci_is_root_bus(bus->parent))
-		return;
-
-	if (regulator_bulk_disable(sr->num_supplies, sr->supplies))
-		dev_err(dev, "failed to disable regulators for downstream device\n");
-	dev->driver_data = NULL;
-}
-
 /* Limits operation to a specific generation (1, 2, or 3) */
 static void brcm_pcie_set_gen(struct brcm_pcie *pcie, int gen)
 {
@@ -853,8 +779,6 @@ static struct pci_ops brcm_pcie_ops = {
 	.map_bus = brcm_pcie_map_conf,
 	.read = pci_generic_config_read,
 	.write = pci_generic_config_write,
-	.add_bus = pci_subdev_regulators_add_bus,
-	.remove_bus = pci_subdev_regulators_remove_bus,
 };
 
 static struct pci_ops brcm_pcie_ops32 = {
-- 
2.25.1

