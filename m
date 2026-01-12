Return-Path: <linux-pci+bounces-44548-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AF7D14E28
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 20:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C3A030082E8
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 19:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37577182D2;
	Mon, 12 Jan 2026 19:17:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275DBBA3F
	for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2026 19:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768245439; cv=none; b=JJc/Km8nhmdBAZpJXRaiCadvOg/87FWZ4gdm1Ib8iGPjwPgYkRXDsIR/9W3pLA9Dc6kPhlZHWwEiONV52hlKfB1zmkAuGwDrDL0hafOwR2vspIXqmsJSzUqL/ghiw9rY1yggzaA1Jxagos0uPYAQ1qoCBOTrZpAh6yZt9p0SxH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768245439; c=relaxed/simple;
	bh=1Pxj4oCluiKLepBu8sfazi6rV6kMCAcMHnjVLHROAlM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mwxsLVSzcr/SrsolttU95eZaXa0ZaDi0JAJZg1cnouisqY/6AX4dcWgUM3ndxtR8wGNkAfraJnad4iuWkhuHo6YNvRApjo7yxFz53qKhbaLFgUwvH6sm0kqpiLFSBWjskKxgfefMEX0PLCCiPq+udJSV247RMmgIwK4qOC69lIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1vfNPd-0003nP-0Y; Mon, 12 Jan 2026 20:17:13 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Mon, 12 Jan 2026 20:17:11 +0100
Subject: [PATCH] PCI: layerscape: Allow to compile as module
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-v6-19-topic-layerscape-pcie-v1-1-1cd863fce50e@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIALZIZWkC/x3MQQqAIBAAwK/EnltwrQT7SnQw22ohSjSiiP6ed
 JzLPJA4Cidoiwcin5Jk3zKoLMAvbpsZZcwGrbRRRBpPg2Tx2IN4XN3NMXkXGIMXRjuSGkxTa6o
 s5CFEnuT6965/3w/uII1AbQAAAA==
X-Change-ID: 20260112-v6-19-topic-layerscape-pcie-9d10b6542139
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Minghuan Lian <minghuan.Lian@nxp.com>, 
 Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>, 
 Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Sascha Hauer <s.hauer@pengutronix.de>, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
X-Mailer: b4 0.14.3
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org

From: Sascha Hauer <s.hauer@pengutronix.de>

The layerscape pcie host controller could also be compiled as module.
Add the necessary infrastructure to allow building as module instead of
only as builtin driver.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/pci/controller/dwc/Kconfig          |  2 +-
 drivers/pci/controller/dwc/pci-layerscape.c | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 519b59422b479..abfa4a6e62c25 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -121,7 +121,7 @@ config PCI_IMX6_EP
 	  DesignWare core functions to implement the driver.
 
 config PCI_LAYERSCAPE
-	bool "Freescale Layerscape PCIe controller (host mode)"
+	tristate "Freescale Layerscape PCIe controller (host mode)"
 	depends on OF && (ARM || ARCH_LAYERSCAPE || COMPILE_TEST)
 	depends on PCI_MSI
 	select PCIE_DW_HOST
diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index a44b5c256d6e2..14d6ac4fc53fd 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -13,6 +13,7 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/iopoll.h>
+#include <linux/module.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 #include <linux/of_address.h>
@@ -403,8 +404,16 @@ static const struct dev_pm_ops ls_pcie_pm_ops = {
 	NOIRQ_SYSTEM_SLEEP_PM_OPS(ls_pcie_suspend_noirq, ls_pcie_resume_noirq)
 };
 
+static void ls_pcie_remove(struct platform_device *pdev)
+{
+	struct ls_pcie *pcie = platform_get_drvdata(pdev);
+
+	dw_pcie_host_deinit(&pcie->pci->pp);
+}
+
 static struct platform_driver ls_pcie_driver = {
 	.probe = ls_pcie_probe,
+	.remove = ls_pcie_remove,
 	.driver = {
 		.name = "layerscape-pcie",
 		.of_match_table = ls_pcie_of_match,
@@ -412,4 +421,9 @@ static struct platform_driver ls_pcie_driver = {
 		.pm = &ls_pcie_pm_ops,
 	},
 };
-builtin_platform_driver(ls_pcie_driver);
+module_platform_driver(ls_pcie_driver);
+
+MODULE_AUTHOR("Minghuan Lian <Minghuan.Lian@freescale.com>");
+MODULE_DESCRIPTION("Layerscape PCIe host controller driver");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(of, ls_pcie_of_match);

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20260112-v6-19-topic-layerscape-pcie-9d10b6542139

Best regards,
-- 
Steffen Trumtrar <s.trumtrar@pengutronix.de>


