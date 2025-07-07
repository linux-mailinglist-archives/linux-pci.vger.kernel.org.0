Return-Path: <linux-pci+bounces-31634-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1604AFBA88
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 20:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F3B5425A49
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 18:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13D8264624;
	Mon,  7 Jul 2025 18:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJx/f1Br"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E1F263F5D;
	Mon,  7 Jul 2025 18:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751912343; cv=none; b=BvbFBCLwdHzLqSqk8ZahH8cJuh+rNmcsd6lruswaxamUzqWRajZcTOgGS6xwZ3P09za7LNjN1C1n1mMMZkECkGvyRgNMn7+pHCkIKCgd0Fe97xc/4iuKZBpwyilCBVS03/o7k8Ft0FXyAVTFne9+/PTT+cKHkL3s1M4XJIEQPtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751912343; c=relaxed/simple;
	bh=ZAX3axLXmsGPid8QjIJzF6CkgWt90mjjqRk1vUpOLFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WHpC8kDYZbm0+bihZdlMCuVLEwT4pTvEHvOunS3nXXE0T/oBcKNWn0lQsptlIYb4FhpKTijsXaqtoaaUj0CFCY/wesvMtf5CHSfrCZb50J12VzRKMjcyMS2++j1q81Vh/0R2Xl1nApbOfYm3+UZX8CxD7wgjCFJDCx1ZlNWlfxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJx/f1Br; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8263CC4CEE3;
	Mon,  7 Jul 2025 18:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751912343;
	bh=ZAX3axLXmsGPid8QjIJzF6CkgWt90mjjqRk1vUpOLFc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tJx/f1BrTDDKUauZ/7vqBZMmuARouJyZ1DqduhDtmpCE+ZGn68uYIrl5CH+rLYY76
	 euC7a7UCwMnzCswEvSDgn9t8bHqlz1uMR20U77LOieSJ5GfgL04P16b1pRhTJ5CsJe
	 PvXHz8hHQ+c7Dlrcb+1r5IaBPRLerEx/tcaSXtQoShFMkfC6FYu91x3N9DqEm5n9AT
	 sYhgj2Npv7a1K9+0GSh/S2UauUUlS6NrLBj+F0wVbFi/GjyAdnYqNcjNCBFDox4m4l
	 mMm4fSQUey0o3ZwhyC3sJFg3zsQzGqKYX/kVgbDBWYvuj18gY/6XLqpL/B2txUo6g2
	 EX0mtFBDu5qrw==
From: Manivannan Sadhasivam <mani@kernel.org>
Date: Mon, 07 Jul 2025 23:48:40 +0530
Subject: [PATCH RFC 3/3] PCI: qcom: Allow pwrctrl framework to control
 PERST#
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-pci-pwrctrl-perst-v1-3-c3c7e513e312@kernel.org>
References: <20250707-pci-pwrctrl-perst-v1-0-c3c7e513e312@kernel.org>
In-Reply-To: <20250707-pci-pwrctrl-perst-v1-0-c3c7e513e312@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Brian Norris <briannorris@chromium.org>, 
 Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4796; i=mani@kernel.org;
 h=from:subject:message-id; bh=ZAX3axLXmsGPid8QjIJzF6CkgWt90mjjqRk1vUpOLFc=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBobA+F4h5OF+pb4InqjarCEBdTUTr/zXS9VM7Lp
 8OYXc9vfk6JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaGwPhQAKCRBVnxHm/pHO
 9bgSCACZaTFJPy6WqUDGC0az5EHyD2Q4KbUCvklcaKwbZXpuz0pGxpsuHG0vcq3Ml5wlNOQp8xV
 ktiYR3J78sFHK+K1LWKPMBOx05LSY/wcjvQWj2ODAgUaotRuPekeCKsvUkX5htVjBSclKWjgFuX
 obY/z0kZ29le8ogG1XbfTxupq3tVqsXvxB0ykgzcc14b9acUHvLFdPlqI4ILXwJ+B0NQSJf6yqT
 XY7fT5nj69SyoSKRryV5C951rBlXajRtS976NYJth6abnbcUF7VPgRDRp9sjPpNBvOg/kxtTIbD
 rg9iigMwpDdqE3R30anVgx4vnvdui2Q0c/wQwtSm67V6XTy7
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Since the Qcom platforms rely on pwrctrl framework to control the power
supplies, allow it to control PERST# also. PERST# should be toggled during
the power-on and power-off scenarios.

But the controller driver still need to assert PERST# during the controller
initialization. So only skip the deassert if pwrctrl usage is detected. The
pwrctrl framework will deassert PERST# after turning on the supplies.

The usage of pwrctrl framework is detected based on the new DT binding
i.e., with the presence of PERST# and PHY properties in the Root Port node
instead of the host bridge node.

When the legacy binding is used, PERST# is only controlled by the
controller driver since it is not reliable to detect whether pwrctrl is
used or not. So the legacy platforms are untouched by this commit.

Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c |  1 +
 drivers/pci/controller/dwc/pcie-designware.h      |  1 +
 drivers/pci/controller/dwc/pcie-qcom.c            | 26 ++++++++++++++++++++++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index af6c91ec7312bab6c6e5ad35b051d0f452fe7b8d..e45f53bb135a75963318666a479eb6d9582f30eb 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -492,6 +492,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 		return -ENOMEM;
 
 	pp->bridge = bridge;
+	bridge->perst = pp->perst;
 
 	ret = dw_pcie_host_get_resources(pp);
 	if (ret)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 4165c49a0a5059cab92dee3c47f8024af9d840bd..7b28f76ebf6a2de8781746eba43a8e3ad9a5cbb2 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -430,6 +430,7 @@ struct dw_pcie_rp {
 	struct resource		*msg_res;
 	bool			use_linkup_irq;
 	struct pci_eq_presets	presets;
+	struct gpio_desc	**perst;
 };
 
 struct dw_pcie_ep_ops {
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 620ac7cf09472b84c37e83ee3ce40e94a1d9d878..61e1d0d6469030c549328ab4d8c65d5377d525e3 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -313,6 +313,11 @@ static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
 
 static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
 {
+	struct dw_pcie_rp *pp = &pcie->pci->pp;
+
+	if (pp->perst)
+		return;
+
 	/* Ensure that PERST has been asserted for at least 100 ms */
 	msleep(PCIE_T_PVPERL_MS);
 	qcom_perst_assert(pcie, false);
@@ -1701,11 +1706,12 @@ static const struct pci_ecam_ops pci_qcom_ecam_ops = {
 
 static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node)
 {
+	struct dw_pcie_rp *pp = &pcie->pci->pp;
 	struct device *dev = pcie->pci->dev;
 	struct qcom_pcie_port *port;
 	struct gpio_desc *reset;
 	struct phy *phy;
-	int ret;
+	int ret, devfn;
 
 	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
 				      "reset", GPIOD_OUT_HIGH, "PERST#");
@@ -1724,6 +1730,12 @@ static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node
 	if (ret)
 		return ret;
 
+	devfn = of_pci_get_devfn(node);
+	if (devfn < 0)
+		return -ENOENT;
+
+	pp->perst[PCI_SLOT(devfn)] = reset;
+
 	port->reset = reset;
 	port->phy = phy;
 	INIT_LIST_HEAD(&port->list);
@@ -1734,10 +1746,20 @@ static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node
 
 static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
 {
+	struct dw_pcie_rp *pp = &pcie->pci->pp;
 	struct device *dev = pcie->pci->dev;
 	struct qcom_pcie_port *port, *tmp;
+	int child_cnt;
 	int ret = -ENOENT;
 
+	child_cnt = of_get_available_child_count(dev->of_node);
+	if (!child_cnt)
+		return ret;
+
+	pp->perst = kcalloc(child_cnt, sizeof(struct gpio_desc *), GFP_KERNEL);
+	if (!pp->perst)
+		return -ENOMEM;
+
 	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
 		ret = qcom_pcie_parse_port(pcie, of_port);
 		if (ret)
@@ -1747,6 +1769,7 @@ static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
 	return ret;
 
 err_port_del:
+	kfree(pp->perst);
 	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
 		list_del(&port->list);
 
@@ -1984,6 +2007,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	dw_pcie_host_deinit(pp);
 err_phy_exit:
 	qcom_pcie_phy_exit(pcie);
+	kfree(pp->perst);
 	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
 		list_del(&port->list);
 err_pm_runtime_put:

-- 
2.45.2


