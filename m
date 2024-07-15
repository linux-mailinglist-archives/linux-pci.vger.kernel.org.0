Return-Path: <linux-pci+bounces-10283-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB19931995
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 19:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CA841F235D0
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 17:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D609130E4A;
	Mon, 15 Jul 2024 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHtEuJvM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025EA5FBB7;
	Mon, 15 Jul 2024 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064830; cv=none; b=OXlmBl9ql6RaQgbF6p60QpGSWXz5nHhVj1qLb+lscokHDIxuiqc+Rm7hOSv8G4fRdv7L1Kfby49C2DBO9nZqwT9trL8LrynXi1Mn2lekpi9wijhvHHndgocd88Xb7GOJCzNXYb8ZNWU/DXJglQqfbPuBNm7YDW0KWI2DkAIhEyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064830; c=relaxed/simple;
	bh=2j+p5wcDKlIyA4JNDCNvkka91QTIIAvg9IeI2KWEpj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tLChB+tTk0LRubbBnbpNHw1VqcP6pW7rdOKixcQ5Jgx5POjfkBnXKxEoAIWNxAZmIpoXuKw1ljd7WMCKArrGNt7r1KPaU8AufrpNi+H5QVIQf5pMaXAFVvfdHWpTEqmYWfwtZBcwnpGig+3hBlVA2CtI+ZW3J9jyzLDLcdM05do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHtEuJvM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE4D8C4AF0E;
	Mon, 15 Jul 2024 17:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721064829;
	bh=2j+p5wcDKlIyA4JNDCNvkka91QTIIAvg9IeI2KWEpj8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fHtEuJvMOb6PGi1Ep/cP81tvkKx6W7lVSMZSbgbzm5TbZDyHERjSOV+EZNp6TO8L2
	 +Z5e4A/IReqdBXqUgzRBu9v8H4HN2HjTe4RD30q9WMbqaacGEwFkuy4lknStA/4pdQ
	 P1147Nc8giz+g21cXtlavVDkSgrtXbZWtyTXHC1LvDlrKC7DHQPmAte/7P4TwTDIKL
	 ZwDp3K6vFbNAx2cLM+wFeDlq/rKe9FJ8NTetVQAMjbS2yjhX8/OK5axL8R7yZBF4dS
	 HtL7DvCkGY6/8N3R5DPifc9qDODtZpiK41EegwIfCE0NFuUiMqhng5/Nui27pQdmNO
	 DPzh89i7Rm7BQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C23C3DA60;
	Mon, 15 Jul 2024 17:33:49 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Mon, 15 Jul 2024 23:03:49 +0530
Subject: [PATCH 07/14] PCI: qcom-ep: Modify 'global_irq' and 'perst_irq'
 IRQ device names
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-pci-qcom-hotplug-v1-7-5f3765cc873a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2451;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=33LLyDEX80bmAN/A+qSdjtZSe4gPt17zqqO4Z1H5mmE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmlV15EQrMNyKxALsdRNoBTY/z/AVzKkjRrHma4
 3xjEDgshSmJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZpVdeQAKCRBVnxHm/pHO
 9eODB/wPgHyueppr1K0JAMEG3CfhRu6n14xNTdRybozcACX+zyEjiheQUSMARuL/wOxmbv5povU
 rNPA6Ld41t3MBuBfdCPRi8/38Cqn/svXM4noQl8QemvoKIQZiARt0AI7w26BR5TNxiiwGekDkcH
 jWCuzfYXUl7Y21ynbaYgszb/GRChQ0KrxnvUm8wqxvGtsFZNTlwJk+ZMssA+EYdEeOkiis+z1f9
 R9BQy24XdLweWpQf39xzkAi4uO/k3UG2w8ih4PYVTFUeIBzd8PS0dhucRIfE0mZUUJSfcz6zBin
 kR3/ziEOzJRDud5wUkWt9ltpLo/loEJy8MOBk+CuDM8UnWQw
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Currently, the IRQ device name for both of these IRQs doesn't have Qcom
specific prefix and PCIe domain number. This causes 2 issues:

1. Pollutes the global IRQ namespace since 'global' is a common name.
2. When more than one EP controller instance is present in the SoC, naming
conflict will occur.

Hence, add 'qcom_pcie_ep_' prefix and PCIe domain number suffix to the IRQ
names to uniquely identify the IRQs and also to fix the above mentioned
issues.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index cda5d8fdc03b..a0847eef0645 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -711,8 +711,15 @@ static irqreturn_t qcom_pcie_ep_perst_irq_thread(int irq, void *data)
 static int qcom_pcie_ep_enable_irq_resources(struct platform_device *pdev,
 					     struct qcom_pcie_ep *pcie_ep)
 {
+	struct device *dev = pcie_ep->pci.dev;
+	char *name;
 	int ret;
 
+	name = devm_kasprintf(dev, GFP_KERNEL, "qcom_pcie_ep_global_irq%d",
+			      pcie_ep->pci.ep.epc->domain_nr);
+	if (!name)
+		return -ENOMEM;
+
 	pcie_ep->global_irq = platform_get_irq_byname(pdev, "global");
 	if (pcie_ep->global_irq < 0)
 		return pcie_ep->global_irq;
@@ -720,18 +727,23 @@ static int qcom_pcie_ep_enable_irq_resources(struct platform_device *pdev,
 	ret = devm_request_threaded_irq(&pdev->dev, pcie_ep->global_irq, NULL,
 					qcom_pcie_ep_global_irq_thread,
 					IRQF_ONESHOT,
-					"global_irq", pcie_ep);
+					name, pcie_ep);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request Global IRQ\n");
 		return ret;
 	}
 
+	name = devm_kasprintf(dev, GFP_KERNEL, "qcom_pcie_ep_perst_irq%d",
+			      pcie_ep->pci.ep.epc->domain_nr);
+	if (!name)
+		return -ENOMEM;
+
 	pcie_ep->perst_irq = gpiod_to_irq(pcie_ep->reset);
 	irq_set_status_flags(pcie_ep->perst_irq, IRQ_NOAUTOEN);
 	ret = devm_request_threaded_irq(&pdev->dev, pcie_ep->perst_irq, NULL,
 					qcom_pcie_ep_perst_irq_thread,
 					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
-					"perst_irq", pcie_ep);
+					name, pcie_ep);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request PERST IRQ\n");
 		disable_irq(pcie_ep->global_irq);

-- 
2.25.1



