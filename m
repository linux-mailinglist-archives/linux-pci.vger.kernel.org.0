Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534E5304456
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 18:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbhAZRAj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 12:00:39 -0500
Received: from muru.com ([72.249.23.125]:52952 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390009AbhAZI2D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 03:28:03 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id C430C814C;
        Tue, 26 Jan 2021 08:27:25 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Balaji T K <balajitk@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 01/27] PCI: pci-dra7xx: Prepare for deferred probe with module_platform_driver
Date:   Tue, 26 Jan 2021 10:26:50 +0200
Message-Id: <20210126082716.54358-2-tony@atomide.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126082716.54358-1-tony@atomide.com>
References: <20210126082716.54358-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

After updating pci-dra7xx driver to probe with ti-sysc and genpd, I
noticed that dra7xx_pcie_probe() would not run if a power-domains property
was configured for the interconnect target module.

Turns out that module_platform_driver_probe uses platform_driver_probe(),
while module_platform_driver_probe uses platform_driver_register().

Only platform_driver_register() works for deferred probe as noted in the
comments for __platform_driver_probe() in drivers/base/platform.c with a
line saying "Note that this is incompatible with deferred probing".

With module_platform_driver_probe, we have platform_driver_probe() produce
-ENODEV error at device_initcall() level, and no further attempts are done.
Let's fix this by using module_platform_driver instead.

Note this is not an issue currently as we probe devices with simple-bus,
and only is needed as we start probing the device with ti-sysc, or when
probed with simple-pm-bus.

Note that we must now also remove __init for probe related functions to
avoid a section mismatch warning.

Cc: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Can you guys please review test and ack if this looks OK? I'd like to
apply this together with the series to drop dra7 platform data as it's
not needed earlier.

---
 drivers/pci/controller/dwc/pci-dra7xx.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -443,8 +443,8 @@ static const struct dw_pcie_ep_ops pcie_ep_ops = {
 	.get_features = dra7xx_pcie_get_features,
 };
 
-static int __init dra7xx_add_pcie_ep(struct dra7xx_pcie *dra7xx,
-				     struct platform_device *pdev)
+static int dra7xx_add_pcie_ep(struct dra7xx_pcie *dra7xx,
+			      struct platform_device *pdev)
 {
 	int ret;
 	struct dw_pcie_ep *ep;
@@ -472,8 +472,8 @@ static int __init dra7xx_add_pcie_ep(struct dra7xx_pcie *dra7xx,
 	return 0;
 }
 
-static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
-				       struct platform_device *pdev)
+static int dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
+				struct platform_device *pdev)
 {
 	int ret;
 	struct dw_pcie *pci = dra7xx->pci;
@@ -682,7 +682,7 @@ static int dra7xx_pcie_configure_two_lane(struct device *dev,
 	return 0;
 }
 
-static int __init dra7xx_pcie_probe(struct platform_device *pdev)
+static int dra7xx_pcie_probe(struct platform_device *pdev)
 {
 	u32 reg;
 	int ret;
@@ -938,6 +938,7 @@ static const struct dev_pm_ops dra7xx_pcie_pm_ops = {
 };
 
 static struct platform_driver dra7xx_pcie_driver = {
+	.probe = dra7xx_pcie_probe,
 	.driver = {
 		.name	= "dra7-pcie",
 		.of_match_table = of_dra7xx_pcie_match,
@@ -946,4 +947,4 @@ static struct platform_driver dra7xx_pcie_driver = {
 	},
 	.shutdown = dra7xx_pcie_shutdown,
 };
-builtin_platform_driver_probe(dra7xx_pcie_driver, dra7xx_pcie_probe);
+builtin_platform_driver(dra7xx_pcie_driver);
-- 
2.30.0
