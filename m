Return-Path: <linux-pci+bounces-35358-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D27BB415FF
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 09:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57FDD1BA026D
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 07:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAC82DCBEC;
	Wed,  3 Sep 2025 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGePKTdd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647DC2DAFA7;
	Wed,  3 Sep 2025 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756883614; cv=none; b=cklVAN4bID6qhFNzf0wWg6gzhDPlKeQ1+ZJZNaSBF2rloAPkUa2fh4yvbkfGaa5CyprvC901rrpqHmaug82UVYJJkD/mHXTDEx8kfmnh5Io938jXr41s8sK9eChvELR4jwa/9Qdrv0591TY0yz+TEhXMTRdgUbQ9EwOjXcGxz0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756883614; c=relaxed/simple;
	bh=SEiEmAY+lH8Mf391yVOd+WIcOj17/HO94xc8TJDgA8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uscwqpeYnJmah+h3j24/nBQD8OvRC4IPljPzOmkca0b2/gSYxmPKPpHz5uDP+v4QgbSdCpFdIwmbnGMrdfDES0cbnJLu+iU1PKH1V8LpUaQ01FZCdgwr5Oyv2KH7TDHiUU/pCbiJs5E9IZeCfmgQEHpEpNTzqu1klXCdjUKRPhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGePKTdd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D43FEC116C6;
	Wed,  3 Sep 2025 07:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756883613;
	bh=SEiEmAY+lH8Mf391yVOd+WIcOj17/HO94xc8TJDgA8U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oGePKTdd9YjwGLUj4uhbLoine6v5vhIFy3485IDWy/ebzcGmcAJ0Q9UHen9QVTXps
	 5hmim1NuBFSCIsiUfZGcyePJZzmxnm3McGno4NcAj0P1NQYTtrVC41PNETh18IPMp7
	 i69hWtoYMkOs9Wdgj3S7/xVpDcUjDyDy8HRugvP9Z5PVm9tjcvLserOg0YqiXp1RD1
	 gBgQ7njZY7AqyF8RmpTrXoLty1Sp67uDYWaXhSChdGakLj7mr259HPpjU+V4ZxcRIS
	 FhLhwkTiJaKqJH8yYxePApaZkdzXFln4U/GpqE5Sno4u60neUV+DBoLaMCsz4aXJ0D
	 y/dDiaXWh3YfA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73D4CA1011;
	Wed,  3 Sep 2025 07:13:33 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Wed, 03 Sep 2025 12:43:27 +0530
Subject: [PATCH v2 5/5] PCI: qcom: Allow pwrctrl core to toggle PERST# for
 new DT binding
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-pci-pwrctrl-perst-v2-5-2d461ed0e061@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6596;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=jE6WYZa4c9ydpNf35QrLmvbRouO2QM2tzBO/q32DEJQ=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBot+qbrxLuzhIzbFJu6Ak/dMgK/aqGgbOTZbDrX
 G5u68sXRS2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaLfqmwAKCRBVnxHm/pHO
 9ZcFB/9yBkxFGLHK5AWr+zXcKlifi+99vBPZBRrUD0HFdcJnwnEu+7SSpp1HYpDchst7DV4Mnri
 CiPFFkjkOiEmePyT9KK0bbj/gt+tr6k93kOqD8HK0UV9X08LkvR3F0ZvtJ3jHADCKDJSvqTaLwz
 YTh1x1F7yD+4ok8PFwNDIS1V3c4CdaYWqFBCG8FjdUuIkDSpgPbTd1emMZQNASkAX2n0y+G14/9
 gADrQgL3xPEUp4C7a7Uo0csD867v9OIuueOLd8qB3gXYGSEqvyPYpKZr4+1gz3sk+c5xHXMQs/6
 2iuSliSEzJ3oo8oLh1pOcEe4IsdxjJQUWJ8zMmW7lapCioV2
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

If the platform is using the new DT binding, let the pwrctrl core toggle
PERST# for the device. This is achieved by populating the
'pci_host_bridge::toggle_perst' callback with qcom_pcie_toggle_perst().

qcom_pcie_toggle_perst() will find the PERST# GPIO descriptor associated
with the supplied 'device_node' and toggles PERST#. If PERST# is not found
in the supplied node, the function will look for PERST# in the parent node
as a fallback. This is needed since PERST# won't be available in the
endpoint node as per the DT binding.

Note that the driver still asserts PERST# during the controller
initialization as it is needed as per the hardware documentation. Apart
from that, the driver wouldn't touch PERST# for the new binding.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 89 +++++++++++++++++++++++++++++-----
 1 file changed, 78 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 78355d12f10d263a0bb052e24c1e2d5e8f68603d..3c5c65d7d97cac186e1b671f80ba7296ad226d68 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -276,6 +276,7 @@ struct qcom_pcie_port {
 struct qcom_pcie_perst {
 	struct list_head list;
 	struct gpio_desc *desc;
+	struct device_node *np;
 };
 
 struct qcom_pcie {
@@ -298,11 +299,50 @@ struct qcom_pcie {
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
 
-static void qcom_perst_assert(struct qcom_pcie *pcie, bool assert)
+static struct gpio_desc *qcom_find_perst(struct qcom_pcie *pcie, struct device_node *np)
+{
+	struct qcom_pcie_perst *perst;
+
+	list_for_each_entry(perst, &pcie->perst, list) {
+		if (np == perst->np)
+			return perst->desc;
+	}
+
+	return NULL;
+}
+
+static void qcom_toggle_perst_per_device(struct qcom_pcie *pcie,
+					 struct device_node *np, bool assert)
+{
+	int val = assert ? 1 : 0;
+	struct gpio_desc *perst;
+
+	perst = qcom_find_perst(pcie, np);
+	if (perst)
+		goto toggle_perst;
+
+	/*
+	 * If PERST# is not available in the current node, try the parent. This
+	 * fallback is needed if the current node belongs to an endpoint or
+	 * switch upstream port.
+	 */
+	if (np->parent)
+		perst = qcom_find_perst(pcie, np->parent);
+
+toggle_perst:
+	/* gpiod* APIs handle NULL gpio_desc gracefully. So no need to check. */
+	gpiod_set_value_cansleep(perst, val);
+}
+
+static void qcom_perst_reset(struct qcom_pcie *pcie, struct device_node *np,
+			      bool assert)
 {
 	struct qcom_pcie_perst *perst;
 	int val = assert ? 1 : 0;
 
+	if (np)
+		return qcom_toggle_perst_per_device(pcie, np, assert);
+
 	if (list_empty(&pcie->perst))
 		gpiod_set_value_cansleep(pcie->reset, val);
 
@@ -310,22 +350,34 @@ static void qcom_perst_assert(struct qcom_pcie *pcie, bool assert)
 		gpiod_set_value_cansleep(perst->desc, val);
 }
 
-static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
+static void qcom_ep_reset_assert(struct qcom_pcie *pcie, struct device_node *np)
 {
-	qcom_perst_assert(pcie, true);
+	qcom_perst_reset(pcie, np, true);
 	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
 }
 
-static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
+static void qcom_ep_reset_deassert(struct qcom_pcie *pcie,
+				   struct device_node *np)
 {
 	struct dw_pcie_rp *pp = &pcie->pci->pp;
 
 	msleep(PCIE_T_PVPERL_MS);
-	qcom_perst_assert(pcie, false);
+	qcom_perst_reset(pcie, np, false);
 	if (!pp->use_linkup_irq)
 		msleep(PCIE_RESET_CONFIG_WAIT_MS);
 }
 
+static void qcom_pcie_toggle_perst(struct pci_host_bridge *bridge,
+				    struct device_node *np, bool assert)
+{
+	struct qcom_pcie *pcie = dev_get_drvdata(bridge->dev.parent);
+
+	if (assert)
+		qcom_ep_reset_assert(pcie, np);
+	else
+		qcom_ep_reset_deassert(pcie, np);
+}
+
 static int qcom_pcie_start_link(struct dw_pcie *pci)
 {
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
@@ -1320,7 +1372,7 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 	int ret;
 
-	qcom_ep_reset_assert(pcie);
+	qcom_ep_reset_assert(pcie, NULL);
 
 	ret = pcie->cfg->ops->init(pcie);
 	if (ret)
@@ -1336,7 +1388,13 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_disable_phy;
 	}
 
-	qcom_ep_reset_deassert(pcie);
+	/*
+	 * Only deassert PERST# for all devices here if legacy binding is used.
+	 * For the new binding, pwrctrl driver is expected to toggle PERST# for
+	 * individual devices.
+	 */
+	if (list_empty(&pcie->perst))
+		qcom_ep_reset_deassert(pcie, NULL);
 
 	if (pcie->cfg->ops->config_sid) {
 		ret = pcie->cfg->ops->config_sid(pcie);
@@ -1344,10 +1402,12 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_assert_reset;
 	}
 
+	pci->pp.bridge->toggle_perst = qcom_pcie_toggle_perst;
+
 	return 0;
 
 err_assert_reset:
-	qcom_ep_reset_assert(pcie);
+	qcom_ep_reset_assert(pcie, NULL);
 err_disable_phy:
 	qcom_pcie_phy_power_off(pcie);
 err_deinit:
@@ -1361,7 +1421,7 @@ static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 
-	qcom_ep_reset_assert(pcie);
+	qcom_ep_reset_assert(pcie, NULL);
 	qcom_pcie_phy_power_off(pcie);
 	pcie->cfg->ops->deinit(pcie);
 }
@@ -1740,6 +1800,9 @@ static int qcom_pcie_parse_perst(struct qcom_pcie *pcie,
 		return -ENOMEM;
 
 	perst->desc = reset;
+	/* Increase the refcount to make sure 'np' is valid till it is stored */
+	of_node_get(np);
+	perst->np = np;
 	list_add_tail(&perst->list, &pcie->perst);
 
 parse_child_node:
@@ -1803,8 +1866,10 @@ static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
 		list_del(&port->list);
 	}
 
-	list_for_each_entry_safe(perst, tmp_perst, &pcie->perst, list)
+	list_for_each_entry_safe(perst, tmp_perst, &pcie->perst, list) {
+		of_node_put(perst->np);
 		list_del(&perst->list);
+	}
 
 	return ret;
 }
@@ -2044,8 +2109,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	qcom_pcie_phy_exit(pcie);
 	list_for_each_entry_safe(port, tmp_port, &pcie->ports, list)
 		list_del(&port->list);
-	list_for_each_entry_safe(perst, tmp_perst, &pcie->perst, list)
+	list_for_each_entry_safe(perst, tmp_perst, &pcie->perst, list) {
+		of_node_put(perst->np);
 		list_del(&perst->list);
+	}
 err_pm_runtime_put:
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);

-- 
2.45.2



