Return-Path: <linux-pci+bounces-34251-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA363B2BA6F
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 09:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC3627B66F0
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 07:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED44A303C8E;
	Tue, 19 Aug 2025 07:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpA9o58W"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A8329993F;
	Tue, 19 Aug 2025 07:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755587700; cv=none; b=F0lxqyTd7n2Nmi0vEcpGiq1YTJ4cCpWzUPRB4fzhfkHgpl1JLZItOblSHAo4xmwCUmOZl3d/xx79+OGHB1+i3yxlPX72uHPt1PXEGCnmFf2vbC0VzLnPDDRuYls2WqDnDJUFPE79+gwDg5lzb7AiObD6vKVE09sZJI77Vw8MGNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755587700; c=relaxed/simple;
	bh=7NbpESnQ2u7NNAjbxIFdMUu5LDo5OaWvwLyAf7gRB6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pL/i6hKetqxmJCR0S7bvgp3bYEpiwP2UUEjpeiB6W9veYG7jDd36axcYUsgSr7kFV+93oG/bIMrmib/5JO+QKEfNhRllWOpSq7m8yHOubvgKpTmjm81hflKHMxrC/2SmG4Hr4uxjG1MlpGlsMBpLg8bonlxxa2SbJaq6wj5njdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpA9o58W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08370C19425;
	Tue, 19 Aug 2025 07:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755587700;
	bh=7NbpESnQ2u7NNAjbxIFdMUu5LDo5OaWvwLyAf7gRB6M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bpA9o58WTVdqIqCuHVH/xR+V0bU+Dtfh2k8c4Un/iKPC6XYqZ6pbVgcIJrloOnv0z
	 ub3ludXDmB/LAxZ6/pu8W2K38lqHM8Gxyjo36dl9cDd8S6KeF/fdzozGXIABUGvH9c
	 P5bQPHovXPqUL9MRlk0SFpXet7Ge5xXF2GNqUUG/pO68dAm5loUoWPwAHmxE+S2eBq
	 yMaRduRlpxGPe5CCIH8uJ3G0/0x6SJ3UZL5+9KMMBRg0uTsjfjqxmvYrpA5wYRSJ/0
	 m1hCdLuQP1t2+24sivqz7yCGUpB7JAbX1kibsOCWpg/n0Xa4/vuvJZS0jKA0RfH53w
	 FddIV5XoORlzQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1AACA0EF8;
	Tue, 19 Aug 2025 07:14:59 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 19 Aug 2025 12:44:54 +0530
Subject: [PATCH 5/6] PCI: qcom: Parse PERST# from all PCIe bridge nodes
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-pci-pwrctrl-perst-v1-5-4b74978d2007@oss.qualcomm.com>
References: <20250819-pci-pwrctrl-perst-v1-0-4b74978d2007@oss.qualcomm.com>
In-Reply-To: <20250819-pci-pwrctrl-perst-v1-0-4b74978d2007@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6648;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=X45KjujaSGuGwn7RVLO1grKV6I/nnsAGXa9LOjUKNK4=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBopCRwLr8Oh28sKmgyljsdBYZmg4skpyMXWLtb3
 +0eOsAjP/uJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaKQkcAAKCRBVnxHm/pHO
 9XrnB/wNIrrhtB3mQhhPCfbhWa5mX/OB6jbAP3QteBZLDrFarfJHo/vFdgNSUXeNcFZ4ZBMB5iG
 ynWnDPTpxL3usiXZ8BUorQCP7JbrPSibpUxx+cabjNJA2wD3z1wmyEbVT+8G57WmQLjJc4pzlP8
 c5U16newpwHiUiY5lpvX+2Wke/VUHs04ZZaNFhPTr1P5RD1mBW9Xd+wePdPgW1PXiWz+dKK3zTw
 BzDOqiSHYIct4LR3TuMh+Q26nmClTnDGLq/mLZ2MrE+9kBXs/r5AYbeZv+HrM0ImszlZ4II37vL
 WCNsgirBgNszImpwm4KQyFLuHN/ogtp+tdCdfhPwXBhh7x4V
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
GPIO descriptor will be stored in IDR structure with node BDF as the ID.

It should be noted that if more than one bridge node has the same GPIO for
PERST# (shared PERST#), the driver will error out. This is due to the
limitation in the GPIOLIB subsystem that allows only exclusive (non-shared)
access to GPIOs from consumers. But this is soon going to get fixed. Once
that happens, it will get incorporated in this driver.

So for now, PERST# sharing is not supported.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 90 +++++++++++++++++++++++++++-------
 1 file changed, 73 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index bcd080315d70e64eafdefd852740fe07df3dbe75..5d73c46095af3219687ff77e5922f08bb41e43a9 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -19,6 +19,7 @@
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/limits.h>
+#include <linux/idr.h>
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/of_pci.h>
@@ -286,6 +287,7 @@ struct qcom_pcie {
 	const struct qcom_pcie_cfg *cfg;
 	struct dentry *debugfs;
 	struct list_head ports;
+	struct idr perst;
 	bool suspended;
 	bool use_pm_opp;
 };
@@ -294,14 +296,15 @@ struct qcom_pcie {
 
 static void qcom_perst_assert(struct qcom_pcie *pcie, bool assert)
 {
-	struct qcom_pcie_port *port;
 	int val = assert ? 1 : 0;
+	struct gpio_desc *perst;
+	int bdf;
 
-	if (list_empty(&pcie->ports))
+	if (idr_is_empty(&pcie->perst))
 		gpiod_set_value_cansleep(pcie->reset, val);
-	else
-		list_for_each_entry(port, &pcie->ports, list)
-			gpiod_set_value_cansleep(port->reset, val);
+
+	idr_for_each_entry(&pcie->perst, perst, bdf)
+		gpiod_set_value_cansleep(perst, val);
 }
 
 static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
@@ -1702,20 +1705,58 @@ static const struct pci_ecam_ops pci_qcom_ecam_ops = {
 	}
 };
 
-static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node)
+/* Parse PERST# from all nodes in depth first manner starting from @np */
+static int qcom_pcie_parse_perst(struct qcom_pcie *pcie,
+				 struct device_node *np)
 {
 	struct device *dev = pcie->pci->dev;
-	struct qcom_pcie_port *port;
 	struct gpio_desc *reset;
-	struct phy *phy;
 	int ret;
 
-	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
-				      "reset", GPIOD_OUT_HIGH, "PERST#");
-	if (IS_ERR(reset))
+	if (!of_find_property(np, "reset-gpios", NULL))
+		goto parse_child_node;
+
+	ret = of_pci_get_bdf(np);
+	if (ret < 0)
+		return ret;
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
+	ret = idr_alloc(&pcie->perst, reset, ret, 0, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+parse_child_node:
+	for_each_available_child_of_node_scoped(np, child) {
+		ret = qcom_pcie_parse_perst(pcie, child);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
 
-	phy = devm_of_phy_get(dev, node, NULL);
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
 
@@ -1727,7 +1768,10 @@ static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node
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
@@ -1739,7 +1783,11 @@ static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
 {
 	struct device *dev = pcie->pci->dev;
 	struct qcom_pcie_port *port, *tmp;
-	int ret = -ENOENT;
+	struct gpio_desc *perst;
+	int ret = -ENODEV;
+	int bdf;
+
+	idr_init(&pcie->perst);
 
 	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
 		ret = qcom_pcie_parse_port(pcie, of_port);
@@ -1750,8 +1798,13 @@ static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
 	return ret;
 
 err_port_del:
-	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
+		phy_exit(port->phy);
 		list_del(&port->list);
+	}
+
+	idr_for_each_entry(&pcie->perst, perst, bdf)
+		idr_remove(&pcie->perst, bdf);
 
 	return ret;
 }
@@ -1782,12 +1835,13 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	unsigned long max_freq = ULONG_MAX;
 	struct qcom_pcie_port *port, *tmp;
 	struct device *dev = &pdev->dev;
+	struct gpio_desc *perst;
 	struct dev_pm_opp *opp;
 	struct qcom_pcie *pcie;
 	struct dw_pcie_rp *pp;
 	struct resource *res;
 	struct dw_pcie *pci;
-	int ret, irq;
+	int ret, irq, bdf;
 	char *name;
 
 	pcie_cfg = of_device_get_match_data(dev);
@@ -1927,7 +1981,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	ret = qcom_pcie_parse_ports(pcie);
 	if (ret) {
-		if (ret != -ENOENT) {
+		if (ret != -ENODEV) {
 			dev_err_probe(pci->dev, ret,
 				      "Failed to parse Root Port: %d\n", ret);
 			goto err_pm_runtime_put;
@@ -1989,6 +2043,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	qcom_pcie_phy_exit(pcie);
 	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
 		list_del(&port->list);
+	idr_for_each_entry(&pcie->perst, perst, bdf)
+		idr_remove(&pcie->perst, bdf);
 err_pm_runtime_put:
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);

-- 
2.45.2



