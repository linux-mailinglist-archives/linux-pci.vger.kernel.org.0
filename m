Return-Path: <linux-pci+bounces-35354-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EB5B415F4
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 09:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4343D1BA018E
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 07:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456162DA743;
	Wed,  3 Sep 2025 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoCmYfrA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7112D8DC2;
	Wed,  3 Sep 2025 07:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756883614; cv=none; b=b/EHA0/lR0wj9W0MOJWmtM646deGGhqjqe25SSo9tP1C16xrwts3MVXFMycRKmsYJrDAfD1pzzRGIH2hm8DwlacyDsEVLlhL7vUFBMdHerUvmfRPGwKD1hXhWugIbW08lIhD3UIDf48ExHM3U+ad4ZuNfiCZmpM7JyHH4tlKHnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756883614; c=relaxed/simple;
	bh=ryRtSUjZbTvYBcAKAbXA9dsM0lcTwtnSo+zNNpcuk7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ju+fTBRex6ZTNQN94UIxGHzXTNbB4kGvKr497IXXUk/eMIAiR4CcGc6dXUxhX+Y1kAzvTPFN1xxzJWFxLKLfvxGUdhwi5tKSLXwBUpwijpA6zi6AzjMuhoj+5mL+kZamIC5jRKasFg+fkhVarUSEIErdhMHDzgsI3ksSY58NYfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoCmYfrA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF3D7C4CEFD;
	Wed,  3 Sep 2025 07:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756883613;
	bh=ryRtSUjZbTvYBcAKAbXA9dsM0lcTwtnSo+zNNpcuk7c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AoCmYfrA5mHcGW3AynQiznoVuGeMjpOd0qomcMT9ARPph7tmP4KzaaVQATjFjZPMl
	 UgJTCvllvCO7+B6znFmRDCFAsqCtV9ldOIlMtZ0rJWTa9cJB0CYJj+A1JpNjNXMTen
	 MjCTSk1E4YlgF7ZYjJQfvkde1NaKoPKnxwUWIvKaTJA2rzwexA3bTLBG4hh5StdfVx
	 /UqLE37Ss1iSyoQLUl3SWiMfbFYgdnn+4UcpiXoAYEYTy1i1NtqfbTATyBe9JMycNa
	 tcyqk2AmUFYyy5fLZTTuHQAJ1rxwiLljXFfzol10dBD91obPNogXYiiAul7pXndhkL
	 BgdOzB//+0N1Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7900CA100C;
	Wed,  3 Sep 2025 07:13:33 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Wed, 03 Sep 2025 12:43:26 +0530
Subject: [PATCH v2 4/5] PCI: qcom: Parse PERST# from all PCIe bridge nodes
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-pci-pwrctrl-perst-v2-4-2d461ed0e061@oss.qualcomm.com>
References: <20250903-pci-pwrctrl-perst-v2-0-2d461ed0e061@oss.qualcomm.com>
In-Reply-To: <20250903-pci-pwrctrl-perst-v2-0-2d461ed0e061@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Saravana Kannan <saravanak@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Brian Norris <briannorris@chromium.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7146;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=7C92JPcjtkyNOs7TgJky3UafrbHkSLG9ZHW4enf6l14=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBot+qbIM1j3nEbr74l9EOMdPDEtz+Ft4cZWWimL
 DletiDdmFuJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaLfqmwAKCRBVnxHm/pHO
 9UsiB/9krTVWCBwfjHxNEkg4dSJ+Bp14Dec2iEemD9P6L1W4nMsZeIk/8vSRmjoyoERKvs+r8ng
 4uHCRj/VYqvlyLldyamM4OGSyxI2asAOcKAMtHSZcDMKz3JB0SRihsUbohg32cLzBBBF8bIwag4
 qGH+niU/LNuMH8/4dHjwq/O91n90xZ8suM9ks+aCTsxT/rZgLwtZUh+flkD7oODC83gDhutU96z
 CEoPWTiwxcK2261FHGsIHVHLhqcLT+ai9Tq7OtW6Gzae+mhyZCB3LUuIwoygghbgpWdP02w3TAG
 dz4t/NmAE7sP5gJqU0Yds3JyGH3RM5x0CIrUsXEOHW9kXOhK
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Devicetree schema allows the PERST# GPIO to be present in all PCIe bridge
nodes, not just in Root Port node. But the current logic parses PERST# only
from the Root Port node. Though it is not causing any issue on the current
platforms, the upcoming platforms will have PERST# in PCIe switch
downstream ports also. So this requires parsing all the PCIe bridge nodes
for the PERST# GPIO.

Hence, rework the parsing logic to extend to all PCIe bridge nodes starting
from Root Port node. If the 'reset-gpios' property is found for a node, the
GPIO descriptor will be stored in a list.

It should be noted that if more than one bridge node has the same GPIO for
PERST# (shared PERST#), the driver will error out. This is due to the
limitation in the GPIOLIB subsystem that allows only exclusive (non-shared)
access to GPIOs from consumers. But this is soon going to get fixed. Once
that happens, it will get incorporated in this driver.

So for now, PERST# sharing is not supported.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 95 +++++++++++++++++++++++++++-------
 1 file changed, 76 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index bcd080315d70e64eafdefd852740fe07df3dbe75..78355d12f10d263a0bb052e24c1e2d5e8f68603d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -273,6 +273,11 @@ struct qcom_pcie_port {
 	struct phy *phy;
 };
 
+struct qcom_pcie_perst {
+	struct list_head list;
+	struct gpio_desc *desc;
+};
+
 struct qcom_pcie {
 	struct dw_pcie *pci;
 	void __iomem *parf;			/* DT parf */
@@ -286,6 +291,7 @@ struct qcom_pcie {
 	const struct qcom_pcie_cfg *cfg;
 	struct dentry *debugfs;
 	struct list_head ports;
+	struct list_head perst;
 	bool suspended;
 	bool use_pm_opp;
 };
@@ -294,14 +300,14 @@ struct qcom_pcie {
 
 static void qcom_perst_assert(struct qcom_pcie *pcie, bool assert)
 {
-	struct qcom_pcie_port *port;
+	struct qcom_pcie_perst *perst;
 	int val = assert ? 1 : 0;
 
-	if (list_empty(&pcie->ports))
+	if (list_empty(&pcie->perst))
 		gpiod_set_value_cansleep(pcie->reset, val);
-	else
-		list_for_each_entry(port, &pcie->ports, list)
-			gpiod_set_value_cansleep(port->reset, val);
+
+	list_for_each_entry(perst, &pcie->perst, list)
+		gpiod_set_value_cansleep(perst->desc, val);
 }
 
 static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
@@ -1702,20 +1708,58 @@ static const struct pci_ecam_ops pci_qcom_ecam_ops = {
 	}
 };
 
-static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node)
+/* Parse PERST# from all nodes in depth first manner starting from @np */
+static int qcom_pcie_parse_perst(struct qcom_pcie *pcie,
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
+	perst->desc = reset;
+	list_add_tail(&perst->list, &pcie->perst);
 
-	phy = devm_of_phy_get(dev, node, NULL);
+parse_child_node:
+	for_each_available_child_of_node_scoped(np, child) {
+		ret = qcom_pcie_parse_perst(pcie, child);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *np)
+{
+	struct device *dev = pcie->pci->dev;
+	struct qcom_pcie_port *port;
+	struct phy *phy;
+	int ret;
+
+	phy = devm_of_phy_get(dev, np, NULL);
 	if (IS_ERR(phy))
 		return PTR_ERR(phy);
 
@@ -1727,7 +1771,10 @@ static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node
 	if (ret)
 		return ret;
 
-	port->reset = reset;
+	ret = qcom_pcie_parse_perst(pcie, np);
+	if (ret)
+		return ret;
+
 	port->phy = phy;
 	INIT_LIST_HEAD(&port->list);
 	list_add_tail(&port->list, &pcie->ports);
@@ -1738,8 +1785,9 @@ static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node
 static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
 {
 	struct device *dev = pcie->pci->dev;
-	struct qcom_pcie_port *port, *tmp;
-	int ret = -ENOENT;
+	struct qcom_pcie_port *port, *tmp_port;
+	struct qcom_pcie_perst *perst, *tmp_perst;
+	int ret = -ENODEV;
 
 	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
 		ret = qcom_pcie_parse_port(pcie, of_port);
@@ -1750,8 +1798,13 @@ static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
 	return ret;
 
 err_port_del:
-	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
+	list_for_each_entry_safe(port, tmp_port, &pcie->ports, list) {
+		phy_exit(port->phy);
 		list_del(&port->list);
+	}
+
+	list_for_each_entry_safe(perst, tmp_perst, &pcie->perst, list)
+		list_del(&perst->list);
 
 	return ret;
 }
@@ -1778,9 +1831,10 @@ static int qcom_pcie_parse_legacy_binding(struct qcom_pcie *pcie)
 
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
@@ -1848,6 +1902,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	}
 
 	INIT_LIST_HEAD(&pcie->ports);
+	INIT_LIST_HEAD(&pcie->perst);
 
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
@@ -1927,7 +1982,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	ret = qcom_pcie_parse_ports(pcie);
 	if (ret) {
-		if (ret != -ENOENT) {
+		if (ret != -ENODEV) {
 			dev_err_probe(pci->dev, ret,
 				      "Failed to parse Root Port: %d\n", ret);
 			goto err_pm_runtime_put;
@@ -1987,8 +2042,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	dw_pcie_host_deinit(pp);
 err_phy_exit:
 	qcom_pcie_phy_exit(pcie);
-	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
+	list_for_each_entry_safe(port, tmp_port, &pcie->ports, list)
 		list_del(&port->list);
+	list_for_each_entry_safe(perst, tmp_perst, &pcie->perst, list)
+		list_del(&perst->list);
 err_pm_runtime_put:
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);

-- 
2.45.2



