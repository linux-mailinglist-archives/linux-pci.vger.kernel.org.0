Return-Path: <linux-pci+bounces-10446-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C74B934104
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 19:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07F59284A7F
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 17:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9B2184127;
	Wed, 17 Jul 2024 17:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azMpTza3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9997218306C;
	Wed, 17 Jul 2024 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721235795; cv=none; b=ggJIlWnqrqx26OauD8uBujO0wqnk/InlUXqvlzW3/4OZdpOfbp/HCsklymzRy7Hg0Uz3+WZylQ1xtC0XR/d8Y1RsG7c6T9Ny41qgc485SgsskGOGMc7qkAzlyHpF95xiNFrPBrM69Z1vnZaoMv+QOGopkaoYD76I87bIGLAnikw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721235795; c=relaxed/simple;
	bh=YFMeGAfhyM9bHtPXFygVWmHaeqfsPIqirTRI+ZUhVcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JpzDHs3dn/rCIXsb/Ym4wHXXSVNtjFtSHcFlOELxE5If6y2dx146SySAQuwhM54HKzTOkEVNJCJG9cpfmkXHqi4tgMaZJfFNCV61h7kkDVGsxhg/WehHH0a+3pL4iMJbnSKYhkjQxsCliDdxVYDRSl5VBb+9XMlLzyb2m6byaow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azMpTza3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 292FFC4AF0C;
	Wed, 17 Jul 2024 17:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721235795;
	bh=YFMeGAfhyM9bHtPXFygVWmHaeqfsPIqirTRI+ZUhVcY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=azMpTza3Ty1tTGFDoJG4XsKQEBVFUwl2xAqtbqrAG5DF1ggqC1vg5NVFVl7Zyql0C
	 s8BDiiu+JlhTFplD+CXftTXoQ9E0ru/d48DtO+0eBknkRW0mix2MF0E0LE/LwgnUrU
	 rA6jZP9QQEb+5KHf1Pgk4m9zGF0WIQSOe3WGj29RaNFEA/e32kE/6agXy7OAxEhFtC
	 i61HFotX2oYXZocdAaLL37xcvw2d5u4yWXAc+feC1ed6qLX7FLcLqt/PCpqxMcAEyK
	 VoOk08G/QgR9U8GQZrqkC6kzasKwCv6vdkZ2qYLvdFzOsDVqs/InOwdi3URnNOsQ6V
	 ApQWZm5Zhb+9Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD72C3DA63;
	Wed, 17 Jul 2024 17:03:15 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 17 Jul 2024 22:33:11 +0530
Subject: [PATCH v2 06/13] PCI: qcom-ep: Modify 'global_irq' and 'perst_irq'
 IRQ device names
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-pci-qcom-hotplug-v2-6-71d304b817f8@linaro.org>
References: <20240717-pci-qcom-hotplug-v2-0-71d304b817f8@linaro.org>
In-Reply-To: <20240717-pci-qcom-hotplug-v2-0-71d304b817f8@linaro.org>
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
 bh=OLDTA2u7a/IhWC3MtFf6Stnx+Z4B5OLjl/uildv1v/c=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBml/lOI08j7Wv5M424aLdNTgYCTZGLtQ2VGQxDP
 0fiBGevU7OJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZpf5TgAKCRBVnxHm/pHO
 9TDNB/9vDbfXwQESIcTjCcZVnQergPptI/QsVRlGP8dFnXeKhn/nkuGPUhKAMZL81Y/c6dAbdRT
 abrX1cbyoNPdSzclS68FG7yBmUHB+qFoBOkCBwYgId8Asxi3iM9hSOyWkM+mO+SJuAsIisIkNKz
 +uBrO4RVoAUi2x+W7JL86PyqSlW9kwJGpi/aZFQTIJ4FUrtsr4fllIEf2vJjD8qghREegIdmLGp
 +alvir5UiGeWiSBR7zVvy889TAWf5nCUW2ZOGiRdlBaTb76D2l2AemIgBqRDTd96rD5KN3RURGI
 GYx+37itzRcFPJUuqNlFkHtsDAOpTGFwWl6YMFtL4vlDZKAq
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



