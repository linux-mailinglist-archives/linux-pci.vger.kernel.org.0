Return-Path: <linux-pci+bounces-41958-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE44C81870
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 17:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7FC14E3ADB
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 16:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2A62FC897;
	Mon, 24 Nov 2025 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPGLSOGi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78249314A99;
	Mon, 24 Nov 2025 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001264; cv=none; b=HhL47vRk6WSxVzyhPQgxlogxvFSdlwF47g8W/NHpxajIg3Ey8m3BW6uLYf30zjkOvXZ5irHPzP2ABXNpIDtN5mwkcw01kTmelPfUxaGovHeOmVcAB4KcHyW+ePRkMBHIeuNer5W+qA0P/MBpT6JAn/QjdM1pOBbe9fBAUZoP3U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001264; c=relaxed/simple;
	bh=iVE1obRMnciMq20+t0E0Wgd8Gf0+fcO2/7lj1bhky3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OCl/4TyqKeG7kJqaHipIEtrzUGM1+xekgEwOp8vJ4xCf5Jj6RXrsatfCPIuEpK+d1Vd1U478TFGe2t3Ih8wq1K6YXpc2iBEgUA/qkeTp9BGE+7qHJvP1Z8CSZl/tE3lCumN9OK0asIgBdlr9DVzKRPcU/j2xIhAtnQhM5DEUXJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPGLSOGi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E08DDC116C6;
	Mon, 24 Nov 2025 16:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764001264;
	bh=iVE1obRMnciMq20+t0E0Wgd8Gf0+fcO2/7lj1bhky3Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HPGLSOGiOYUsgaQWkQmj06b+f2vBryJMJNG5VNG5/c8U76UwvLjNF/AAahqhh1IYo
	 ZyFZzRpAP1eYh88Njvb99vcdbzhJuv9DGvnayocYqJn8uERakCSNvhsADmhIkzTnsX
	 t8EXqJviNhhMdzEsXcW59evaWW+7AYXH+kXixqpffGaPhoDX6r4JhvBZVIdyMRacVg
	 UVG6gTHmQPVRX7SLcNyZ1QOtbvjYUGM+70ToeDUZ33pq8XpRn9cmuJLNrk8xHtbtXm
	 UNQrll/O3TDCOTwRoFPnonTJCEsBU4KYbjkpoC5K0tLQnv2zW8+fHbF+wrxGXGsyYP
	 90SKxO7LT0uMw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5E0CFD313;
	Mon, 24 Nov 2025 16:21:03 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Mon, 24 Nov 2025 21:50:44 +0530
Subject: [PATCH 1/5] PCI: qcom: Parse PERST# from all PCIe bridge nodes
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-pci-pwrctrl-rework-v1-1-78a72627683d@oss.qualcomm.com>
References: <20251124-pci-pwrctrl-rework-v1-0-78a72627683d@oss.qualcomm.com>
In-Reply-To: <20251124-pci-pwrctrl-rework-v1-0-78a72627683d@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
 Brian Norris <briannorris@chromium.org>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7456;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=MCSBhbbg9vGMpjTEI8+dqcv0csxSz0v3Na25Cc4NhqQ=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpJIXr9wE/ax/MgVsttiO9zRmORDEiQFQ7sdJLR
 8msynOU2a6JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaSSF6wAKCRBVnxHm/pHO
 9cYYB/99atS90AZH4KZDkPaL0aUWjyDucZSceInRXLoTp4vI7nFPdr9yHTJ+pg25bPACyaS78gY
 AWu+wM0FAaMZnl2cLToHhM224T3/UnTh9Fy5aRDsYdxagyxo2oJGx7soaqmJHvfnaz0tAVgF+ev
 dWljCMEoKRkZCmH7RCPBPgSQa3AddMR+Bjjj620kMnrETpEVLEkqDA2vlBGt4Am+93wH1fMaWrb
 NichJXuGZz5dORUL6QdMMCIPDFFxfOkhwm1F3YRCDSxk7OXlXGMJOcJG1kLT+kM3sEDXN9D2cAb
 Rg0yZ6t8g2eVROzvjv6wKj9XWjKjFZPMlzE47JoEQOenoKbh
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Devicetree schema allows the PERST# GPIO to be present in all PCIe bridge
nodes, not just in Root Port node. But the current logic parses PERST# only
from the Root Port nodes. Though it is not causing any issue on the current
platforms, the upcoming platforms will have PERST# in PCIe switch
downstream ports also. So this requires parsing all the PCIe bridge nodes
for the PERST# GPIO.

Hence, rework the parsing logic to extend to all PCIe bridge nodes starting
from the Root Port node. If the 'reset-gpios' property is found for a PCI
bridge node, the GPIO descriptor will be stored in qcom_pcie_perst::desc
and added to the qcom_pcie_port::perst list.

It should be noted that if more than one bridge node has the same GPIO for
PERST# (shared PERST#), the driver will error out. This is due to the
limitation in the GPIOLIB subsystem that allows only exclusive (non-shared)
access to GPIOs from consumers. But this is soon going to get fixed. Once
that happens, it will get incorporated in this driver.

So for now, PERST# sharing is not supported.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 102 +++++++++++++++++++++++++++------
 1 file changed, 85 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 805edbbfe7eb..7b6f4a391ce4 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -281,10 +281,15 @@ struct qcom_pcie_cfg {
 	bool no_l0s;
 };
 
+struct qcom_pcie_perst {
+	struct list_head list;
+	struct gpio_desc *desc;
+};
+
 struct qcom_pcie_port {
 	struct list_head list;
-	struct gpio_desc *reset;
 	struct phy *phy;
+	struct list_head perst;
 };
 
 struct qcom_pcie {
@@ -305,11 +310,14 @@ struct qcom_pcie {
 
 static void qcom_perst_assert(struct qcom_pcie *pcie, bool assert)
 {
+	struct qcom_pcie_perst *perst;
 	struct qcom_pcie_port *port;
 	int val = assert ? 1 : 0;
 
-	list_for_each_entry(port, &pcie->ports, list)
-		gpiod_set_value_cansleep(port->reset, val);
+	list_for_each_entry(port, &pcie->ports, list) {
+		list_for_each_entry(perst, &port->perst, list)
+			gpiod_set_value_cansleep(perst->desc, val);
+	}
 
 	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
 }
@@ -1710,18 +1718,58 @@ static const struct pci_ecam_ops pci_qcom_ecam_ops = {
 	}
 };
 
-static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node)
+/* Parse PERST# from all nodes in depth first manner starting from @np */
+static int qcom_pcie_parse_perst(struct qcom_pcie *pcie,
+				 struct qcom_pcie_port *port,
+				 struct device_node *np)
 {
 	struct device *dev = pcie->pci->dev;
-	struct qcom_pcie_port *port;
+	struct qcom_pcie_perst *perst;
 	struct gpio_desc *reset;
-	struct phy *phy;
 	int ret;
 
-	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
-				      "reset", GPIOD_OUT_HIGH, "PERST#");
-	if (IS_ERR(reset))
+	if (!of_find_property(np, "reset-gpios", NULL))
+		goto parse_child_node;
+
+	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(np), "reset",
+				      GPIOD_OUT_HIGH, "PERST#");
+	if (IS_ERR(reset)) {
+		/*
+		 * FIXME: GPIOLIB currently supports exclusive GPIO access only.
+		 * Non exclusive access is broken. But shared PERST# requires
+		 * non-exclusive access. So once GPIOLIB properly supports it,
+		 * implement it here.
+		 */
+		if (PTR_ERR(reset) == -EBUSY)
+			dev_err(dev, "Shared PERST# is not supported\n");
+
 		return PTR_ERR(reset);
+	}
+
+	perst = devm_kzalloc(dev, sizeof(*perst), GFP_KERNEL);
+	if (!perst)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&perst->list);
+	perst->desc = reset;
+	list_add_tail(&perst->list, &port->perst);
+
+parse_child_node:
+	for_each_available_child_of_node_scoped(np, child) {
+		ret = qcom_pcie_parse_perst(pcie, port, child);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node)
+{
+	struct device *dev = pcie->pci->dev;
+	struct qcom_pcie_port *port;
+	struct phy *phy;
+	int ret;
 
 	phy = devm_of_phy_get(dev, node, NULL);
 	if (IS_ERR(phy))
@@ -1735,7 +1783,12 @@ static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node
 	if (ret)
 		return ret;
 
-	port->reset = reset;
+	INIT_LIST_HEAD(&port->perst);
+
+	ret = qcom_pcie_parse_perst(pcie, port, node);
+	if (ret)
+		return ret;
+
 	port->phy = phy;
 	INIT_LIST_HEAD(&port->list);
 	list_add_tail(&port->list, &pcie->ports);
@@ -1745,9 +1798,10 @@ static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node
 
 static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
 {
+	struct qcom_pcie_perst *perst, *tmp_perst;
+	struct qcom_pcie_port *port, *tmp_port;
 	struct device *dev = pcie->pci->dev;
-	struct qcom_pcie_port *port, *tmp;
-	int ret = -ENOENT;
+	int ret = -ENODEV;
 
 	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
 		if (!of_node_is_type(of_port, "pci"))
@@ -1760,7 +1814,9 @@ static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
 	return ret;
 
 err_port_del:
-	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
+	list_for_each_entry_safe(port, tmp_port, &pcie->ports, list) {
+		list_for_each_entry_safe(perst, tmp_perst, &port->perst, list)
+			list_del(&perst->list);
 		phy_exit(port->phy);
 		list_del(&port->list);
 	}
@@ -1771,6 +1827,7 @@ static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
 static int qcom_pcie_parse_legacy_binding(struct qcom_pcie *pcie)
 {
 	struct device *dev = pcie->pci->dev;
+	struct qcom_pcie_perst *perst;
 	struct qcom_pcie_port *port;
 	struct gpio_desc *reset;
 	struct phy *phy;
@@ -1792,19 +1849,28 @@ static int qcom_pcie_parse_legacy_binding(struct qcom_pcie *pcie)
 	if (!port)
 		return -ENOMEM;
 
-	port->reset = reset;
+	perst = devm_kzalloc(dev, sizeof(*perst), GFP_KERNEL);
+	if (!perst)
+		return -ENOMEM;
+
 	port->phy = phy;
 	INIT_LIST_HEAD(&port->list);
 	list_add_tail(&port->list, &pcie->ports);
 
+	perst->desc = reset;
+	INIT_LIST_HEAD(&port->perst);
+	INIT_LIST_HEAD(&perst->list);
+	list_add_tail(&perst->list, &port->perst);
+
 	return 0;
 }
 
 static int qcom_pcie_probe(struct platform_device *pdev)
 {
+	struct qcom_pcie_perst *perst, *tmp_perst;
+	struct qcom_pcie_port *port, *tmp_port;
 	const struct qcom_pcie_cfg *pcie_cfg;
 	unsigned long max_freq = ULONG_MAX;
-	struct qcom_pcie_port *port, *tmp;
 	struct device *dev = &pdev->dev;
 	struct dev_pm_opp *opp;
 	struct qcom_pcie *pcie;
@@ -1945,7 +2011,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	ret = qcom_pcie_parse_ports(pcie);
 	if (ret) {
-		if (ret != -ENOENT) {
+		if (ret != -ENODEV) {
 			dev_err_probe(pci->dev, ret,
 				      "Failed to parse Root Port: %d\n", ret);
 			goto err_pm_runtime_put;
@@ -2004,7 +2070,9 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 err_host_deinit:
 	dw_pcie_host_deinit(pp);
 err_phy_exit:
-	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
+	list_for_each_entry_safe(port, tmp_port, &pcie->ports, list) {
+		list_for_each_entry_safe(perst, tmp_perst, &port->perst, list)
+			list_del(&perst->list);
 		phy_exit(port->phy);
 		list_del(&port->list);
 	}

-- 
2.48.1



