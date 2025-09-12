Return-Path: <linux-pci+bounces-35986-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC002B54590
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 10:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53CE83AC2B2
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 08:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433D32D0614;
	Fri, 12 Sep 2025 08:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umYDpvcP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1409C253355;
	Fri, 12 Sep 2025 08:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757666122; cv=none; b=dC3mxVczcXXV21khWDimrjWqLbgumxhoXLqB/b+hIQinStxM2dUCXGjCtlIajTdscBH8lXAJwSt3SaLtpycJ0c7wnDEmeowdAVmbio9zG/iSPjductr6mKlG3hYzPV7F02VOs5Psi7m39mxLJ4ta4gg0t89jtCTiewGerkQRiso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757666122; c=relaxed/simple;
	bh=FiyFCpJ0GFm7SsXs/IRm5ZXJOee0SMylXr70LVM4zbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fZLDFmzgsz3lGIP+z2i6K1m8joBVA1cGq0/Neu9SCZdJ5UFFoFV8b+I/BJ8bIX3qQvP96QQXE0Jmzco7T0IkKmc/jv/opZGcvU1f79MZXHNL5/R+HfBLlgPK+blL1xbhxLHo5YTKx03RAyMnhCfnGknfOQ/fhhkmYPwh3X4Vf0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umYDpvcP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ACE02C4CEF7;
	Fri, 12 Sep 2025 08:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757666121;
	bh=FiyFCpJ0GFm7SsXs/IRm5ZXJOee0SMylXr70LVM4zbc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=umYDpvcPLwsOCsY3cFCDLwD7d2W4aJK8Ktmx7aDFCGY6PZxTvc+jYAocbluPpjE5w
	 TsGGzjeDKa1IilexDNrEVj1rz+hxFR/W4h+wdFKNARIN1svcIomdfHaWQarppweR6m
	 1D3+Cfkp2rm+k6pTKWHsKuNMXnJW75dpTFgdBaAgzSn2x1reqA082+rULrY/kjdCiZ
	 awY2pE7895eMPke3TGjgOEs+AFFHeb8zOqL2HcPUAG8AnPfwFtJxApQRtSM8ZHypFs
	 0km10TzdXFjH2wmfb2WxlEYwjQy9j6eUjKgw7jOkVib6aPcH9wkEqBWXveqyA4XPbp
	 CrKUPpZWRaHpw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E890CA101F;
	Fri, 12 Sep 2025 08:35:21 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Fri, 12 Sep 2025 14:05:02 +0530
Subject: [PATCH v3 2/4] PCI: qcom: Move host bridge 'phy' and 'reset'
 pointers to struct qcom_pcie_port
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-pci-pwrctrl-perst-v3-2-3c0ac62b032c@oss.qualcomm.com>
References: <20250912-pci-pwrctrl-perst-v3-0-3c0ac62b032c@oss.qualcomm.com>
In-Reply-To: <20250912-pci-pwrctrl-perst-v3-0-3c0ac62b032c@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Saravana Kannan <saravanak@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Brian Norris <briannorris@chromium.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5606;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=ilMHp9ACJpgKD/1mza53pL/FtXeYmnYLmD/AOSCLn64=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBow9tHlBV2ozXmZ6TcjJDPHdZiNQOTQ00RKlaJF
 sHK9ehx10GJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaMPbRwAKCRBVnxHm/pHO
 9V1iCACAudhIJ/fiXFFRAGifKsnk4g1c/W/IrhCfCqem/LRcwLkUitvhpk4zmwx9M9AJqJnraLS
 ZvjesBeeNaiyrZ4FWumDQ7ZcBIMsqjqNufSNqDdfW7ZexOWC/OEvao44/mhxH7s6k9KbOkBfUeD
 BEB/5tjyh8l+pgZg5uCbBuT/TOkiGxez5OcrkNrbNRrg+6q+6pKUCd7RRhdOvSCY8BOmQC4lOyt
 Pap3jdElUfWWADIwekhNA8Sma+b8dYj6m+GFl+dGC9MA7+wxeujJ7Hk6CxiO6djQE/GFjiyD0pj
 XDWLLBwjJ4h6mZ4OmZMabd93nQvozvz2VNVxSwl9Y2VNyG3q
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

DT binding allows specifying 'phy' and 'reset' properties in both host
bridge and Root Port nodes, though specifying in the host bridge node is
marked as deprecated. Still, the pcie-qcom driver should support both
combinations for maintaining the DT backwards compatibility. For this
purpose, the driver is holding the relevant pointers of these properties in
two structs: struct qcom_pcie_port and struct qcom_pcie.

However, this causes confusion and increases the driver complexity. Hence,
move the pointers from struct qcom_pcie to struct qcom_pcie_port. As a
result, even if these properties are specified in the host bridge node,
the pointers will be stored in struct qcom_pcie_port as if the properties
are specified in a single Root Port node. This logic simplifies the driver
a lot.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 87 ++++++++++++++--------------------
 1 file changed, 36 insertions(+), 51 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 294babe1816e4d0c2b2343fe22d89af72afcd6cd..6170c86f465f43f980f5b2f88bd8799c3c152e68 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -279,8 +279,6 @@ struct qcom_pcie {
 	void __iomem *elbi;			/* DT elbi */
 	void __iomem *mhi;
 	union qcom_pcie_resources res;
-	struct phy *phy;
-	struct gpio_desc *reset;
 	struct icc_path *icc_mem;
 	struct icc_path *icc_cpu;
 	const struct qcom_pcie_cfg *cfg;
@@ -297,11 +295,8 @@ static void qcom_perst_assert(struct qcom_pcie *pcie, bool assert)
 	struct qcom_pcie_port *port;
 	int val = assert ? 1 : 0;
 
-	if (list_empty(&pcie->ports))
-		gpiod_set_value_cansleep(pcie->reset, val);
-	else
-		list_for_each_entry(port, &pcie->ports, list)
-			gpiod_set_value_cansleep(port->reset, val);
+	list_for_each_entry(port, &pcie->ports, list)
+		gpiod_set_value_cansleep(port->reset, val);
 
 	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
 }
@@ -1253,57 +1248,32 @@ static bool qcom_pcie_link_up(struct dw_pcie *pci)
 	return val & PCI_EXP_LNKSTA_DLLLA;
 }
 
-static void qcom_pcie_phy_exit(struct qcom_pcie *pcie)
-{
-	struct qcom_pcie_port *port;
-
-	if (list_empty(&pcie->ports))
-		phy_exit(pcie->phy);
-	else
-		list_for_each_entry(port, &pcie->ports, list)
-			phy_exit(port->phy);
-}
-
 static void qcom_pcie_phy_power_off(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_port *port;
 
-	if (list_empty(&pcie->ports)) {
-		phy_power_off(pcie->phy);
-	} else {
-		list_for_each_entry(port, &pcie->ports, list)
-			phy_power_off(port->phy);
-	}
+	list_for_each_entry(port, &pcie->ports, list)
+		phy_power_off(port->phy);
 }
 
 static int qcom_pcie_phy_power_on(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_port *port;
-	int ret = 0;
+	int ret;
 
-	if (list_empty(&pcie->ports)) {
-		ret = phy_set_mode_ext(pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
+	list_for_each_entry(port, &pcie->ports, list) {
+		ret = phy_set_mode_ext(port->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
 		if (ret)
 			return ret;
 
-		ret = phy_power_on(pcie->phy);
-		if (ret)
+		ret = phy_power_on(port->phy);
+		if (ret) {
+			qcom_pcie_phy_power_off(pcie);
 			return ret;
-	} else {
-		list_for_each_entry(port, &pcie->ports, list) {
-			ret = phy_set_mode_ext(port->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
-			if (ret)
-				return ret;
-
-			ret = phy_power_on(port->phy);
-			if (ret) {
-				qcom_pcie_phy_power_off(pcie);
-				return ret;
-			}
 		}
 	}
 
-	return ret;
+	return 0;
 }
 
 static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
@@ -1748,8 +1718,10 @@ static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
 	return ret;
 
 err_port_del:
-	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
+		phy_exit(port->phy);
 		list_del(&port->list);
+	}
 
 	return ret;
 }
@@ -1757,20 +1729,32 @@ static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
 static int qcom_pcie_parse_legacy_binding(struct qcom_pcie *pcie)
 {
 	struct device *dev = pcie->pci->dev;
+	struct qcom_pcie_port *port;
+	struct gpio_desc *reset;
+	struct phy *phy;
 	int ret;
 
-	pcie->phy = devm_phy_optional_get(dev, "pciephy");
-	if (IS_ERR(pcie->phy))
-		return PTR_ERR(pcie->phy);
+	phy = devm_phy_optional_get(dev, "pciephy");
+	if (IS_ERR(phy))
+		return PTR_ERR(phy);
 
-	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
-	if (IS_ERR(pcie->reset))
-		return PTR_ERR(pcie->reset);
+	reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset))
+		return PTR_ERR(reset);
 
-	ret = phy_init(pcie->phy);
+	ret = phy_init(phy);
 	if (ret)
 		return ret;
 
+	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	port->reset = reset;
+	port->phy = phy;
+	INIT_LIST_HEAD(&port->list);
+	list_add_tail(&port->list, &pcie->ports);
+
 	return 0;
 }
 
@@ -1984,9 +1968,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 err_host_deinit:
 	dw_pcie_host_deinit(pp);
 err_phy_exit:
-	qcom_pcie_phy_exit(pcie);
-	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
+		phy_exit(port->phy);
 		list_del(&port->list);
+	}
 err_pm_runtime_put:
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);

-- 
2.45.2



