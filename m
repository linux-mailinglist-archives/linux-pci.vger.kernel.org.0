Return-Path: <linux-pci+bounces-35989-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 926F9B5459A
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 10:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C1363AE2DA
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 08:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F67B2D5946;
	Fri, 12 Sep 2025 08:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anhO7Tf2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142BE272E7C;
	Fri, 12 Sep 2025 08:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757666122; cv=none; b=lCbAUsWVEnJoNOxrCbxcosZlbaIGZhFarNYVjJHBNw2c+kz5v+JFPPpXAyT928SClNB2w+L701UwiNfXS/Tz+fsSSTiQTcRAnLyIH6EBjzUJmQ1f9rZwR+PGCach2pIiD6PuMP9ecv+VkcCzjf1FJdwXftrg9SWliyqVEXF5UQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757666122; c=relaxed/simple;
	bh=1BTnQcS0PWwb4QjaWMF5p9KA1L76JzP/XpMvIv4ZNs8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VLJ7xumnAJ3TRgscCwcoEV6jyHwCL2TbQVkDaCJcStkbDaOGfiPpikWCmR5J+9HMY22YUp3bXAm34WNoZN8BGyyzwbRWtr90HNHoi3a9yl7eoN6hor/nWMR6qjo24qVBLHm/W5QYaelzQNfhuglzZ9DUol7DG8IBUsktWxraGZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anhO7Tf2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5AA3C4CEFE;
	Fri, 12 Sep 2025 08:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757666121;
	bh=1BTnQcS0PWwb4QjaWMF5p9KA1L76JzP/XpMvIv4ZNs8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=anhO7Tf2AI5DffcZZh61WH9p7WR5PI3qlnWguxE5N4D1q8GslYcYtUB1492oSDdeW
	 UBdR85dmUMsxIWdJnHxHG4bmE2pLEu5AuOP95iNvI0G6E98Dbk6w1CImn7m6YyOZIB
	 ja9xyaE+R++TIOH9gNbAB8bQTyTjGxhHM5QF8vayBYyO9UeU+nlPc15I55bB9V/6eR
	 E/1E5nhUzqBAWJKB0YENWkbulILA9zcxYuWAlk0SPB3qwwkSGR1Nl6BLk8WT56kM0c
	 KsrtkYvnlpoFsJPhZj2idfkdP2R3OGKsfKPdJ/lf+1SH0+RRAySIypHddwQJwFKrj1
	 Gk9DBfeYzADDQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAABCAC597;
	Fri, 12 Sep 2025 08:35:21 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Fri, 12 Sep 2025 14:05:04 +0530
Subject: [PATCH v3 4/4] PCI: qcom: Allow pwrctrl core to control PERST# if
 'reset-gpios' property is available
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-pci-pwrctrl-perst-v3-4-3c0ac62b032c@oss.qualcomm.com>
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
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8784;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=jUiH8ofsOtVd73Yic4FmsZWJD7S+z6vhnX9M4Wlf+90=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBow9tH+At81n57kx2aXYHxHecTmrVvgsmFAxEgl
 cDyTBhZSX+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaMPbRwAKCRBVnxHm/pHO
 9eJdCACQwOjXFTNJB91mqFNksQ8I944ZGZa+nhHqJblWwtHJ/n9vzmk6yoyd7OPe0VDuI7VyVFH
 OfLiHOHwL5HxRHZTYu3EVL8MhW11yxsmAGqH2PXgHCop1WRheY/nj/2IaC9SUyNyhfssZvhrjBx
 YbWgDRo0pgsfQY0AZFTBK9wRt77xl5Q/c5aJA/XWcUSWhCbe8vAsQ/PmDXSONHtmw9yWoqL3eSI
 /LTxiI1UcC/pogEE22NsDk8AD/WiLjafjpT/f4EYlzZj0WWrGXkfFz3JM5KfpbEnopmpPHvNxbt
 Icd1trZ6WUgPlMJp8Ebe9yJ9MRz2Zf89VGyNsz6V6pBGAh6q
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

For historic reasons, the pcie-qcom driver was controlling the power supply
and PERST# GPIO of the PCIe slot. This turned out to be an issue as the
power supply requirements differ between components. For instance, some of
the WLAN chipsets used in Qualcomm systems were connected to the Root Port
in a non-standard way using their own connectors. This requires specific
power sequencing mechanisms for controlling the WLAN chipsets. So the
pwrctrl framework (CONFIG_PWRCTRL) was introduced to handle these custom
and complex power supply requirements for components.

Sooner, we realized that it would be best to let the pwrctrl driver control
the supplies to the PCIe slots also. As it will allow us to consolidate all
the power supply handling in one place instead of doing it in two. So the
CONFIG_PWRCTRL_SLOT driver was introduced, that just parses the Root Port
nodes representing slots and controls the standard power supplies like
3.3v, 3.3VAux etc...

However, the control of the PERST# GPIOs was still within the controller
drivers like pcie-qcom. So the controller drivers continued to assert/
deassert PERST# GPIOs independent of the power supplies to the components.
This mostly went unnoticed as the components tolerated this non-standard
PERST# assertion/deassertion. But this behavior completely goes against the
PCIe Electromechanical specs like CEM, M.2, as these specs enforce strict
control of PERST# signal together with the power supplies.

So conform to these specs, allow the pwrctrl core to control PERST# for the
slots if the 'reset-gpios' property is specified in the DT bridge nodes.
This is achieved by populating the 'pci_host_bridge::perst_assert' callback
with qcom_pcie_perst_assert() function, so that the pwrctrl core can
control PERST# through this callback.

qcom_pcie_perst_assert() will find the PERST# GPIO descriptor associated
with the supplied 'device_node' of the component and asserts/deasserts
PERST# as requested by the 'assert' parameter. If PERST# is not found in
the supplied node of the component, the function will look for PERST# in
the parent node as a fallback. This is needed since PERST# won't be
available in the endpoint node as per the DT binding.

Note that the driver still asserts PERST# during the controller
initialization as it is needed as per the hardware documentation.

For preserving the backward compatibility with older DTs that still
specifies the Root Port resources in the host bridge DT node, the
controller driver still controls power supplies and PERST# for them. For
those cases, the 'qcom_pcie::legacy_binding' flag will be set and the
driver will continue to control PERST# exclusively. If this flag is not
set, then the pwrctrl driver will control PERST# through the callback.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 94 ++++++++++++++++++++++++++++++----
 1 file changed, 83 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index ccff01c31898cdbc5634221e7f8ef7e86469f5fd..f9a8908d6e5dc3e8dd9ab1c210bfbc5cca1e5be9 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -270,6 +270,7 @@ struct qcom_pcie_cfg {
 struct qcom_pcie_perst {
 	struct list_head list;
 	struct gpio_desc *desc;
+	struct device_node *np;
 };
 
 struct qcom_pcie_port {
@@ -291,34 +292,90 @@ struct qcom_pcie {
 	struct list_head ports;
 	bool suspended;
 	bool use_pm_opp;
+	bool legacy_binding;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
 
-static void qcom_perst_assert(struct qcom_pcie *pcie, bool assert)
+static struct gpio_desc *qcom_find_perst(struct qcom_pcie *pcie, struct device_node *np)
+{
+	struct qcom_pcie_perst *perst;
+	struct qcom_pcie_port *port;
+
+	list_for_each_entry(port, &pcie->ports, list) {
+		list_for_each_entry(perst, &port->perst, list)
+			if (np == perst->np)
+				return perst->desc;
+	}
+
+	return NULL;
+}
+
+static void qcom_perst_reset_per_device(struct qcom_pcie *pcie,
+					 struct device_node *np, int val)
+{
+	struct gpio_desc *perst;
+
+	perst = qcom_find_perst(pcie, np);
+	if (perst)
+		goto perst_assert;
+
+	/*
+	 * If PERST# is not available in the current node, try the parent. This
+	 * fallback is needed if the current node belongs to an endpoint or
+	 * switch upstream port.
+	 */
+	if (np->parent)
+		perst = qcom_find_perst(pcie, np->parent);
+
+perst_assert:
+	/* gpiod* APIs handle NULL gpio_desc gracefully. So no need to check. */
+	gpiod_set_value_cansleep(perst, val);
+}
+
+static void qcom_perst_reset(struct qcom_pcie *pcie, struct device_node *np,
+			      bool assert)
 {
 	struct qcom_pcie_perst *perst;
 	struct qcom_pcie_port *port;
 	int val = assert ? 1 : 0;
 
+	if (np) {
+		qcom_perst_reset_per_device(pcie, np, val);
+		goto perst_delay;
+	}
+
 	list_for_each_entry(port, &pcie->ports, list) {
 		list_for_each_entry(perst, &port->perst, list)
 			gpiod_set_value_cansleep(perst->desc, val);
 	}
 
+perst_delay:
 	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
 }
 
-static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
+static void qcom_ep_reset_assert(struct qcom_pcie *pcie, struct device_node *np)
 {
-	qcom_perst_assert(pcie, true);
+	qcom_perst_reset(pcie, np, true);
 }
 
-static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
+static void qcom_ep_reset_deassert(struct qcom_pcie *pcie,
+				   struct device_node *np)
 {
 	/* Ensure that PERST has been asserted for at least 100 ms */
 	msleep(PCIE_T_PVPERL_MS);
-	qcom_perst_assert(pcie, false);
+	qcom_perst_reset(pcie, np, false);
+}
+
+static void qcom_pcie_perst_assert(struct pci_host_bridge *bridge,
+				    struct device_node *np, bool assert)
+{
+	struct qcom_pcie *pcie = dev_get_drvdata(bridge->dev.parent);
+
+	if (assert)
+		qcom_ep_reset_assert(pcie, np);
+	else
+		qcom_ep_reset_deassert(pcie, np);
 }
 
 static int qcom_pcie_start_link(struct dw_pcie *pci)
@@ -1290,7 +1347,7 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 	int ret;
 
-	qcom_ep_reset_assert(pcie);
+	qcom_ep_reset_assert(pcie, NULL);
 
 	ret = pcie->cfg->ops->init(pcie);
 	if (ret)
@@ -1306,7 +1363,13 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_disable_phy;
 	}
 
-	qcom_ep_reset_deassert(pcie);
+	/*
+	 * Only deassert PERST# for all devices here if legacy binding is used.
+	 * For the new binding, pwrctrl driver is expected to toggle PERST# for
+	 * individual devices.
+	 */
+	if (pcie->legacy_binding)
+		qcom_ep_reset_deassert(pcie, NULL);
 
 	if (pcie->cfg->ops->config_sid) {
 		ret = pcie->cfg->ops->config_sid(pcie);
@@ -1314,10 +1377,12 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_assert_reset;
 	}
 
+	pci->pp.bridge->perst_assert = qcom_pcie_perst_assert;
+
 	return 0;
 
 err_assert_reset:
-	qcom_ep_reset_assert(pcie);
+	qcom_ep_reset_assert(pcie, NULL);
 err_disable_phy:
 	qcom_pcie_phy_power_off(pcie);
 err_deinit:
@@ -1331,7 +1396,7 @@ static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 
-	qcom_ep_reset_assert(pcie);
+	qcom_ep_reset_assert(pcie, NULL);
 	qcom_pcie_phy_power_off(pcie);
 	pcie->cfg->ops->deinit(pcie);
 }
@@ -1712,6 +1777,9 @@ static int qcom_pcie_parse_perst(struct qcom_pcie *pcie,
 
 	INIT_LIST_HEAD(&perst->list);
 	perst->desc = reset;
+	/* Increase the refcount to make sure 'np' is valid till it is stored */
+	of_node_get(np);
+	perst->np = np;
 	list_add_tail(&perst->list, &port->perst);
 
 parse_child_node:
@@ -1773,8 +1841,10 @@ static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
 
 err_port_del:
 	list_for_each_entry_safe(port, tmp_port, &pcie->ports, list) {
-		list_for_each_entry_safe(perst, tmp_perst, &port->perst, list)
+		list_for_each_entry_safe(perst, tmp_perst, &port->perst, list) {
+			of_node_put(perst->np);
 			list_del(&perst->list);
+		}
 		phy_exit(port->phy);
 		list_del(&port->list);
 	}
@@ -2035,8 +2105,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	dw_pcie_host_deinit(pp);
 err_phy_exit:
 	list_for_each_entry_safe(port, tmp_port, &pcie->ports, list) {
-		list_for_each_entry_safe(perst, tmp_perst, &port->perst, list)
+		list_for_each_entry_safe(perst, tmp_perst, &port->perst, list) {
+			of_node_put(perst->np);
 			list_del(&perst->list);
+		}
 		phy_exit(port->phy);
 		list_del(&port->list);
 	}

-- 
2.45.2



