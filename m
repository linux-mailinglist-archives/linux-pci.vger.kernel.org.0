Return-Path: <linux-pci+bounces-10289-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 475CC931987
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 19:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F19BA283429
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 17:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25DC139584;
	Mon, 15 Jul 2024 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mf8IEHpF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679027D401;
	Mon, 15 Jul 2024 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064830; cv=none; b=d9BI6sQ5okP2gNbPyTDpHWZgvkYdMIolBEoDHNHtb/QQHmAoliO0fz0unhpsLg1IwO2XUEBUNS80S4u01ngMCWgJa9TAlbfHqgEcTd0RmLxbNncENo/WI/+8z9mSJjFGrDj29I//9UssYXb/6bX57z/JcWC2EQ1Z0YiWkKNuBD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064830; c=relaxed/simple;
	bh=JLvqfGjSOE0VBigRu447+JxT0fMWPMy9nEkbcRCLmqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JTd09WCromn/aEJqODoMPXT69Z8NCy+kYtaB3VfQsHdeIQv3uAt4+W34Nc8NPSFnOJH/j3BD8FZnPA2+WkdIxdOAF0nUmsj4WRD5whw60fhXyucboouczw4cFdxkMH6Rc1xAzrxAKkrgwM1lrJjx2oCkADuwCxcHz4D9bQyfz4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mf8IEHpF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42A23C4AF1D;
	Mon, 15 Jul 2024 17:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721064830;
	bh=JLvqfGjSOE0VBigRu447+JxT0fMWPMy9nEkbcRCLmqk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mf8IEHpF4SOPjfhF3OdV0EgMBdAI7BqHw4PHQuFTWBEN8vqQ69NB/Cm4VYUAyhCKt
	 cU8vuWEZXNnaan6CBPfrRo7xIIdZhe4ThTW1UWkl58ZuvbNp3nT/CD2//QeWl7JzNv
	 Xj6Q5NNvItM0cBsgQmjl1MRFJOjb80Dr7BhIFnCjNtBsEDL7tLh2XAv1SOn0tOMmFc
	 dOT5rMxAE/fOL7ilADL1wORPeBjArvNp0l2XaVzPrPmP0bTNd566O7cO5TSNy1FUYH
	 K838f4o6BtQf+9IK6ONohzBbJjaDACIOjgqktmYFhca7jbUnrEtPuVGtJe00h9rXF+
	 OluX4Tubr6+JQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A3AC3DA4A;
	Mon, 15 Jul 2024 17:33:50 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Mon, 15 Jul 2024 23:03:55 +0530
Subject: [PATCH 13/14] PCI: qcom: Simulate PCIe hotplug using 'global'
 interrupt
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-pci-qcom-hotplug-v1-13-5f3765cc873a@linaro.org>
References: <20240715-pci-qcom-hotplug-v1-0-5f3765cc873a@linaro.org>
In-Reply-To: <20240715-pci-qcom-hotplug-v1-0-5f3765cc873a@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4567;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=o8WhRcxGYOawJmT3AHJAEZSe6RDzxJBnpZP5nJdS3jk=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmlV16KXUez/Y6REXxxZ2QVEtlgOIhrCL3DAARg
 AAimVpeafuJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZpVdegAKCRBVnxHm/pHO
 9dbTB/9fd9OOqcFYE/hVgvwBMWSaKBe0/P0lNauKerArAmnlzBRonlDDGp9cWJQgN2xrJ0p7nQ7
 whJJMGVR567QcBR+T3KjrfhKrGwUPwyZULOnaDUlrk7CY1Wh8NfUq4aOqbMNbzw+3eoJNGXMAUb
 erDMQ+efln+bwngiuFnm0tskDCrZqUHAOytLHXtn3+cuGiQtCHNW61BmUhIb79YEkMwdaLCNkGN
 FhfVtDgHVel+vIFtDj1ajw8WN5h0S3W8adtU0IVxqWhwyv82ni6DGy3hMG4Ey1yLI2/RYmJ5+cm
 Wmnl2odbl5daqsjdAmwomYfNUSsYvuXcYKb9xcpeo7tILHvr
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Historically, Qcom PCIe RC controllers lack standard hotplug support. So
when an endpoint is attached to the SoC, users have to rescan the bus
manually to enumerate the device. But this can be avoided by simulating the
PCIe hotplug using Qcom specific way.

Qcom PCIe RC controllers are capable of generating the 'global' SPI
interrupt to the host CPUs. The device driver can use this event to
identify events such as PCIe link specific events, safety events etc...

One such event is the PCIe Link up event generated when an endpoint is
detected on the bus and the Link is 'up'. This event can be used to
simulate the PCIe hotplug in the Qcom SoCs.

So add support for capturing the PCIe Link up event using the 'global'
interrupt in the driver. Once the Link up event is received, the bus
underneath the host bridge is scanned to enumerate PCIe endpoint devices,
thus simulating hotplug.

All of the Qcom SoCs have only one rootport per controller instance. So
only a single 'Link up' event is generated for the PCIe controller.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 55 ++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 0180edf3310e..38ed411d2052 100644
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
@@ -260,6 +266,7 @@ struct qcom_pcie {
 	struct icc_path *icc_cpu;
 	const struct qcom_pcie_cfg *cfg;
 	struct dentry *debugfs;
+	int global_irq;
 	bool suspended;
 };
 
@@ -1488,6 +1495,29 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
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
+		dev_err(dev, "Received unknown event. INT_STATUS: 0x%08x\n",
+			status);
+	}
+
+	return IRQ_HANDLED;
+}
+
 static int qcom_pcie_probe(struct platform_device *pdev)
 {
 	const struct qcom_pcie_cfg *pcie_cfg;
@@ -1498,6 +1528,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	struct dw_pcie_rp *pp;
 	struct resource *res;
 	struct dw_pcie *pci;
+	char *name;
 	int ret;
 
 	pcie_cfg = of_device_get_match_data(dev);
@@ -1617,6 +1648,28 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_phy_exit;
 	}
 
+	name = devm_kasprintf(dev, GFP_KERNEL, "qcom_pcie_global_irq%d",
+			      pci_domain_nr(pp->bridge->bus));
+	if (!name) {
+		ret = -ENOMEM;
+		goto err_host_deinit;
+	}
+
+	pcie->global_irq = platform_get_irq_byname_optional(pdev, "global");
+	if (pcie->global_irq > 0) {
+		ret = devm_request_threaded_irq(&pdev->dev, pcie->global_irq,
+						NULL,
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
@@ -1624,6 +1677,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_host_deinit:
+	dw_pcie_host_deinit(pp);
 err_phy_exit:
 	phy_exit(pcie->phy);
 err_pm_runtime_put:

-- 
2.25.1



