Return-Path: <linux-pci+bounces-11042-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C49F942C75
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 12:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F72D1C20B34
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 10:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867651AE87B;
	Wed, 31 Jul 2024 10:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzLK+2k+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146551AD9C1;
	Wed, 31 Jul 2024 10:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722423019; cv=none; b=FbWI2Ufsr57y4Y3msfwLp8ajPvp9MskU4SxASIgO+zkrS4qLj5WbsU1vcfJbZSfuBDvno6gTxffz+X0uV/eTafxdPDFqKX3qlgPVbsDhNSKV8lK413nhcyUdotfYCBrrw1oPEDDIVqpoV7iBpuBcXJUlZAK7Hs935tpMs2wGVgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722423019; c=relaxed/simple;
	bh=lIyv6LgxjhhdpiPs0NXcDdGvthbS9GpMj5V3qbmIu9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cb/a+qx+RYF2RTnemD3BVKSkXm6ha7BCKmTpV1oHa9l3M5GGU0Y2uyjuAx59d8I1BuGpioEn3hQvvKXsIopV8dabsV6SElwJASrbsQ748uOs2Cox+FtyU1Jo/c2oRvXYjRZ0OmMqYOcl18tbcpqDG4RIMxrkze5jOKhqjzG2c6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzLK+2k+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D573AC4DE0B;
	Wed, 31 Jul 2024 10:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722423018;
	bh=lIyv6LgxjhhdpiPs0NXcDdGvthbS9GpMj5V3qbmIu9c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TzLK+2k+6W5NDPMWtmybMxenGvTwpHw2JPvNP6/9UdOiIrOGxqgw/5hnVZORHXwW9
	 WYe268cORm7oPpNP+abI16Ud2CbfdnFNVopE6B4xm7nXOk27S+rXlmMQZDs1TmoM0N
	 4pSiUh4EWqKDaw7is6Qeu4wcD41Bp2FtbAIAXnTvRadW4IQg0uzRzaWd9+BXcbpRLz
	 X+MeHdPEuFnrvADfD+2VMRm8/UoFHI75/gmJxBIHsGeOjCanlTQctKqkMf3c9iaC/9
	 gmWzDgpLKmA1sE0OyBBKpOPY2G7pCCwvShGNNAtXE4n83A3bKurmAQ5idcjVv1zHvz
	 B6R0YNPBqu93Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA45CC52D6F;
	Wed, 31 Jul 2024 10:50:18 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 31 Jul 2024 16:20:15 +0530
Subject: [PATCH v3 12/13] PCI: qcom: Enumerate endpoints based on Link up
 event in 'global_irq' interrupt
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-pci-qcom-hotplug-v3-12-a1426afdee3b@linaro.org>
References: <20240731-pci-qcom-hotplug-v3-0-a1426afdee3b@linaro.org>
In-Reply-To: <20240731-pci-qcom-hotplug-v3-0-a1426afdee3b@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4505;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=rrwYXBkV1hJCf8Vji/wBdBUFZOTu6YfGKfdoZ3owUQ0=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmqhbkReygRn/p2uDcQG1HzkywBXSXv30bcCccD
 oaOZNmA5keJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZqoW5AAKCRBVnxHm/pHO
 9bhrCACI29SAnOLtxLxWWVL8j80mGZVCbgslq9UHUXvgfm7ugC8obni8/WITptobsysnLhqmrfG
 NitRxdc8yWegl4GBuPTuGnMoLIyhvW5+mKURSkwHeMkouF3Xhxj+TC10ndPG8cNYisdRx+Dclqp
 hTEWTw22H2VGVvGgGjQTkJ5ig1kA2V7zlsa8slQDsVhCrahNqcxNUF3UbVImEh1lRrKd+69TFci
 ZLDav8k1DjIh1SkV3he28WQQSymqm7sS7AsvCSy1Gf6X+CmVNqYBc4k4a7Mtf7X4p8t7c4V+JKS
 A3esGtlXrV7+CwpBeQgSLeAu8AdKMJCUjMWngE5aXDm/yWRs
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Historically, Qcom PCIe RC controllers lacked standard hotplug support. So
when an endpoint is attached to the SoC, users have to rescan the bus
manually to enumerate the device. But this can be avoided by using the Link
up event exposed by the Qcom specific 'global_irq' interrupt.

Qcom PCIe RC controllers are capable of generating the 'global' SPI
interrupt to the host CPUs. The device driver can use this interrupt to
identify events such as PCIe link specific events, safety events etc...

One such event is the PCIe Link up event generated when an endpoint is
detected on the bus and the Link is 'up'. This event can be used to
enumerate the PCIe endpoint devices without user intervention.

So add support for capturing the PCIe Link up event using the 'global'
interrupt in the driver. Once the Link up event is received, the bus
underneath the host bridge is scanned to enumerate PCIe endpoint devices.

All of the Qcom SoCs have only one rootport per controller instance. So
only a single 'Link up' event is generated for the PCIe controller.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 55 +++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 0180edf3310e..a1d678fe7fa5 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -50,6 +50,9 @@
 #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
 #define PARF_Q2A_FLUSH				0x1ac
 #define PARF_LTSSM				0x1b0
+#define PARF_INT_ALL_STATUS			0x224
+#define PARF_INT_ALL_CLEAR			0x228
+#define PARF_INT_ALL_MASK			0x22c
 #define PARF_SID_OFFSET				0x234
 #define PARF_BDF_TRANSLATE_CFG			0x24c
 #define PARF_SLV_ADDR_SPACE_SIZE		0x358
@@ -121,6 +124,9 @@
 /* PARF_LTSSM register fields */
 #define LTSSM_EN				BIT(8)
 
+/* PARF_INT_ALL_{STATUS/CLEAR/MASK} register fields */
+#define PARF_INT_ALL_LINK_UP			BIT(13)
+
 /* PARF_NO_SNOOP_OVERIDE register fields */
 #define WR_NO_SNOOP_OVERIDE_EN			BIT(1)
 #define RD_NO_SNOOP_OVERIDE_EN			BIT(3)
@@ -1488,6 +1494,29 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
 				    qcom_pcie_link_transition_count);
 }
 
+static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
+{
+	struct qcom_pcie *pcie = data;
+	struct dw_pcie_rp *pp = &pcie->pci->pp;
+	struct device *dev = pcie->pci->dev;
+	u32 status = readl_relaxed(pcie->parf + PARF_INT_ALL_STATUS);
+
+	writel_relaxed(status, pcie->parf + PARF_INT_ALL_CLEAR);
+
+	if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
+		dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
+		/* Rescan the bus to enumerate endpoint devices */
+		pci_lock_rescan_remove();
+		pci_rescan_bus(pp->bridge->bus);
+		pci_unlock_rescan_remove();
+	} else {
+		dev_WARN_ONCE(dev, 1, "Received unknown event. INT_STATUS: 0x%08x\n",
+			      status);
+	}
+
+	return IRQ_HANDLED;
+}
+
 static int qcom_pcie_probe(struct platform_device *pdev)
 {
 	const struct qcom_pcie_cfg *pcie_cfg;
@@ -1498,7 +1527,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	struct dw_pcie_rp *pp;
 	struct resource *res;
 	struct dw_pcie *pci;
-	int ret;
+	int ret, irq;
+	char *name;
 
 	pcie_cfg = of_device_get_match_data(dev);
 	if (!pcie_cfg || !pcie_cfg->ops) {
@@ -1617,6 +1647,27 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_phy_exit;
 	}
 
+	name = devm_kasprintf(dev, GFP_KERNEL, "qcom_pcie_global_irq%d",
+			      pci_domain_nr(pp->bridge->bus));
+	if (!name) {
+		ret = -ENOMEM;
+		goto err_host_deinit;
+	}
+
+	irq = platform_get_irq_byname_optional(pdev, "global");
+	if (irq > 0) {
+		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+						qcom_pcie_global_irq_thread,
+						IRQF_ONESHOT, name, pcie);
+		if (ret) {
+			dev_err_probe(&pdev->dev, ret,
+				      "Failed to request Global IRQ\n");
+			goto err_host_deinit;
+		}
+
+		writel_relaxed(PARF_INT_ALL_LINK_UP, pcie->parf + PARF_INT_ALL_MASK);
+	}
+
 	qcom_pcie_icc_opp_update(pcie);
 
 	if (pcie->mhi)
@@ -1624,6 +1675,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_host_deinit:
+	dw_pcie_host_deinit(pp);
 err_phy_exit:
 	phy_exit(pcie->phy);
 err_pm_runtime_put:

-- 
2.25.1



