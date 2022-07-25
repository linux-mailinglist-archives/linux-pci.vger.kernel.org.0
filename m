Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61AAD5802E0
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jul 2022 18:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbiGYQjW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jul 2022 12:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236338AbiGYQjQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jul 2022 12:39:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2B7F1CFFB;
        Mon, 25 Jul 2022 09:39:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CD1D152B;
        Mon, 25 Jul 2022 09:39:15 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 63D843F73D;
        Mon, 25 Jul 2022 09:39:14 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-pci@vger.kernel.org
Cc:     will@kernel.org, bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lpieralisi@kernel.org,
        kw@linux.com, mark.rutland@arm.com, sudeep.holla@arm.com,
        boqun.feng@gmail.com, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 3/4] PCI: host-generic: Add firmware managed config ops
Date:   Mon, 25 Jul 2022 11:39:04 -0500
Message-Id: <20220725163905.2024437-4-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220725163905.2024437-1-jeremy.linton@arm.com>
References: <20220725163905.2024437-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The generic PCI host driver leaves the configuration and mgmt of the
clock/phy/etc on PCI root ports to the firmware and PCIe defined
mechanisms as is done on UEFI/ACPI systems. If the PCIe config
operations were abstracted as well then a number of the resulting
Linux PCie drivers would no longer be needed.

Given that Arm has standardized a generic SMC conduit for reading and
writing the PCIe config space. Using it on DT based systems seems a
natural way to reduce some of the driver diversity on DT based systems
as well.

This patch adds a compatible type "pci-host-smc-generic" which expects
that the 'reg' property of the root port is missing, and the PCI SMCCC
exists. When that happens it binds the SMC to the pci_ecam_ops.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/pci/controller/pci-host-common.c  | 34 ++++++++++++++++-------
 drivers/pci/controller/pci-host-generic.c |  6 ++++
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index d3924a44db02..2673fd81d3e0 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -20,22 +20,41 @@ static void gen_pci_unmap_cfg(void *ptr)
 	pci_ecam_free((struct pci_config_window *)ptr);
 }
 
+__weak int pcie_has_fw_conduit(void)
+{
+	return -EOPNOTSUPP;
+}
+
+__weak struct pci_config_window *pci_setup_fw_mapping(struct device *dev,
+		u16 seg, struct resource *bus_res)
+{
+	return NULL;
+}
+
 static struct pci_config_window *gen_pci_init(struct device *dev,
-		struct pci_host_bridge *bridge, const struct pci_ecam_ops *ops)
+		struct pci_host_bridge *bridge)
 {
 	int err;
 	struct resource cfgres;
 	struct resource_entry *bus;
 	struct pci_config_window *cfg;
+	const struct pci_ecam_ops *ops;
+
+	bus = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
+	if (!bus)
+		return ERR_PTR(-ENODEV);
 
 	err = of_address_to_resource(dev->of_node, 0, &cfgres);
 	if (err) {
+		if (!pcie_has_fw_conduit())
+			return pci_setup_fw_mapping(dev, bridge->busnr, bus->res);
+
 		dev_err(dev, "missing \"reg\" property\n");
 		return ERR_PTR(err);
 	}
 
-	bus = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
-	if (!bus)
+	ops = of_device_get_match_data(dev);
+	if (!ops)
 		return ERR_PTR(-ENODEV);
 
 	cfg = pci_ecam_create(dev, &cfgres, bus->res, ops);
@@ -54,11 +73,6 @@ int pci_host_common_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct pci_host_bridge *bridge;
 	struct pci_config_window *cfg;
-	const struct pci_ecam_ops *ops;
-
-	ops = of_device_get_match_data(&pdev->dev);
-	if (!ops)
-		return -ENODEV;
 
 	bridge = devm_pci_alloc_host_bridge(dev, 0);
 	if (!bridge)
@@ -69,7 +83,7 @@ int pci_host_common_probe(struct platform_device *pdev)
 	of_pci_check_probe_only();
 
 	/* Parse and map our Configuration Space windows */
-	cfg = gen_pci_init(dev, bridge, ops);
+	cfg = gen_pci_init(dev, bridge);
 	if (IS_ERR(cfg))
 		return PTR_ERR(cfg);
 
@@ -78,7 +92,7 @@ int pci_host_common_probe(struct platform_device *pdev)
 		pci_add_flags(PCI_REASSIGN_ALL_BUS);
 
 	bridge->sysdata = cfg;
-	bridge->ops = (struct pci_ops *)&ops->pci_ops;
+	bridge->ops = (struct pci_ops *)&cfg->ops->pci_ops;
 	bridge->msi_domain = true;
 
 	return pci_host_probe(bridge);
diff --git a/drivers/pci/controller/pci-host-generic.c b/drivers/pci/controller/pci-host-generic.c
index 63865aeb636b..d20d33b3c689 100644
--- a/drivers/pci/controller/pci-host-generic.c
+++ b/drivers/pci/controller/pci-host-generic.c
@@ -56,6 +56,9 @@ static const struct pci_ecam_ops pci_dw_ecam_bus_ops = {
 	}
 };
 
+static const struct pci_ecam_ops pci_generic_smc_ops = {
+};
+
 static const struct of_device_id gen_pci_of_match[] = {
 	{ .compatible = "pci-host-cam-generic",
 	  .data = &gen_pci_cfg_cam_bus_ops },
@@ -63,6 +66,9 @@ static const struct of_device_id gen_pci_of_match[] = {
 	{ .compatible = "pci-host-ecam-generic",
 	  .data = &pci_generic_ecam_ops },
 
+	{ .compatible = "pci-host-smc-generic",
+	  .data = &pci_generic_smc_ops },
+
 	{ .compatible = "marvell,armada8k-pcie-ecam",
 	  .data = &pci_dw_ecam_bus_ops },
 
-- 
2.37.1

