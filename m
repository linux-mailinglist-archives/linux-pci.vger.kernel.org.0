Return-Path: <linux-pci+bounces-12359-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02166962CD7
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 17:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC0691F22522
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 15:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9861A4F35;
	Wed, 28 Aug 2024 15:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pn6VBCOZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49511A38FA;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859984; cv=none; b=cAEDCpTu0hI660DmmPKf9latfe9rlo9VHySz55cDnqJ7ejoFC7ns7EdxD4SGTN/aDlcs0Ef2+Ow4cbSVwWUfWmRxP34U02eQQqnZn/PNQPfEPkePnAzEEtv33isYw+jcoqRDzi1Lt+j5eZw5sPX8UBZrar/ymmuG6yZ00IoFvpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859984; c=relaxed/simple;
	bh=Q0K9d834m1CQs7L6nrAh8i7+sVcfqEywtcVG4UQJkH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ih42AoXTVV+z20ABzdJRyVs+U1Dx+NVqj9R38zme0DJ3ljUoDnUVwJZ5vuLBel0c1JsOHG9KsYNWmS6JoboA8cL4wzvlkcvDJ5IuJg1oIZan02keV4uRDirdKfXNKRqWxaA71bOFOYKpvxL24FKtgd4T7LWVYpYRw7wO8+JMxJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pn6VBCOZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7EA0BC4CEE2;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724859984;
	bh=Q0K9d834m1CQs7L6nrAh8i7+sVcfqEywtcVG4UQJkH8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pn6VBCOZbu5cvk64b9UxCl77GJUpXrd5dXmyg25JH+vole0CDMrFBTr4MxfyoOTo1
	 FxsiFXr4V9QzVlSlGZkJXNWtNLt8esspRkEE/EcZm8FFQTRYKJw+oVJ69yMqbE1CCR
	 L5DSHotG4lp0X8BsG7ghBkEEr+NvPbIr0JuwbKo2xPZ+QDsBoEH0ojzR7yE5Cpg0N/
	 CZfVcNngJgJSQ6zv0295v8wysEFC5DmxmdoZkbZPEQj9BN3iXSm+DqWGXx+QiFmHLU
	 6gSyxnZ+Dj4TVR7vNFUnCc3I/qikGtZJHI811N0ty63lcDdYMrzH6JNBbk/mYwsPV5
	 fkNgH08J2xCkQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EB2C61DB8;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 28 Aug 2024 21:16:16 +0530
Subject: [PATCH v4 06/12] PCI: qcom-ep: Modify 'global_irq' and 'perst_irq'
 IRQ device names
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-pci-qcom-hotplug-v4-6-263a385fbbcb@linaro.org>
References: <20240828-pci-qcom-hotplug-v4-0-263a385fbbcb@linaro.org>
In-Reply-To: <20240828-pci-qcom-hotplug-v4-0-263a385fbbcb@linaro.org>
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
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2506;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=XIcVOnjgniiauSeztC2lx8OOqKBgQWPfU4mlz79I8zw=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmz0ZMJeRwBKZl9ti5NFbMzFzxx2sLFKYLKVjgX
 KFkM1P+Yw2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZs9GTAAKCRBVnxHm/pHO
 9REAB/sEt58nq25RLnw0HfIv6PjsjV3e48I2L8y+h1KA3Exi5n4IWe+dT2UpnzEYRXAD2ElAAJm
 /GLyqMRvavA3M+hMAJN+K16Kn2lg2Br5Xa528Kghp51WZIe9nbasUwkQwSGXWyVjlQFFVzitb4M
 H3c3CbAvSC1ooH7fhhVuu0LLaKXZ+0DwD4f2gHmayoqcGXIGVpgdrNpMQ91llb1NbtCzlsNzoQx
 i4NLLnDWo53+8rG5LkFRJjTOLrQKGXGi9m7mQz68cnkgXE6EbaLNOXhb5sDRzHn5F4a1R9dU5lE
 Nfc0uRJt3LI21V+XFwDEtKuylGQMvUIFznOMbv0dLB8QBhe2
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

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 0bb0a056dd8f..d0a27fa6fdc8 100644
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



