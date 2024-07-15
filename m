Return-Path: <linux-pci+bounces-10279-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7C4931970
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 19:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D902832EA
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 17:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA1F61FD4;
	Mon, 15 Jul 2024 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9aZXFw8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDB55589A;
	Mon, 15 Jul 2024 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064829; cv=none; b=QsYUHDOLbKKVhQ/kI64wcxmukJNBLHtr3qjizTYNSv9mcO4nUhMCyWG5oRMEX6Wq2q/hWw6qJRCDYMMmFO8SL7ZX35OYMIRnHQdIvNU4gN6a7A3c00vC+3dRaKNQJD6uv3HosswyAzID202wfb2rUf79e3PkZmvv2bZg388Cnlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064829; c=relaxed/simple;
	bh=YrQ8WsJOqwj1JkFZkHzhDi8IflXYH48WlLSKQE4D1GU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cH3jwoukosRVKq4XcibEzKTd6Zczo1ATuQu6kMmeXW7XGalSae/4w7IYRBSZZsdClBwPoCpPIvfJ1z2CsW1aBOjvKPWby1U3x6Y+qUoFDSMI2qMmWKtknBb6HYmm6XGBhT1ZLhTcTqPx1cJFRYzWOV+y5aYY48zpnIJpFMo4HkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9aZXFw8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68D68C32782;
	Mon, 15 Jul 2024 17:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721064829;
	bh=YrQ8WsJOqwj1JkFZkHzhDi8IflXYH48WlLSKQE4D1GU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=s9aZXFw8wctgOvDBJaqKS0m1ORY6HA+Ylnh3xgcmak6o/vjVbR7hYySdfv+ZyVgsr
	 IU0VlmW0uEcNQ9URECyvJVhVdooWuWURevEAVj/0gfNaLJhLKGis0DCrM1ncwReX1F
	 LlOhfR/pgKJ+5vsIPBTUwh68VQG+PZCG90nYLKL8LVqttl9DYefe+X7YrxjjNbp92g
	 ywzXn2KG3rULRd1oS6wxEchZ8rAi5wjPQzinq8i4AxTtvvaLjuRTVZHX/AT46F27SV
	 car1XNcekFs8PBW/U0pBvc33c2oV9Adzp11l4B7pdfzV4f6t+OtkUFPeE+dLdtPLLx
	 gQfjyK+kwkQTA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5603BC3DA4A;
	Mon, 15 Jul 2024 17:33:49 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Mon, 15 Jul 2024 23:03:43 +0530
Subject: [PATCH 01/14] PCI: qcom-ep: Drop the redundant masking of global
 IRQ events
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-pci-qcom-hotplug-v1-1-5f3765cc873a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1233;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=JFszVo8UdO0gHsfqleLS4i4GCE2Usu+8CNRMErdZNjA=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmlV13rItBTh0MhfAGXPppt1+l62bg/bl8ERcsO
 VjhnvUm+kSJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZpVddwAKCRBVnxHm/pHO
 9SHjB/0e8TptwYDehqnWgRDkRzJphvAZdfwE2hOVtC0royHz/PfPulIXhcGq4MF3RwKOapgTpYz
 9i6j9QSlGwFUWACSbhk+dUq0JUicGsDfHBminrfzhTw++hp9lfrcfk6qXwVJWR3eDgw7DrcC5TM
 li/MLxTXGxCOsk49iE/N1ZbF3BmPgdNN9i/UqkA0Geu1HIItnvDFUe1igXC3OmThfLZ+0luFeER
 15yxARvD1+hU37iBQQcppMLRgLIyq8fn6ncavNqxGDMKpDV+CisR3j0GeVaATDtG5XOAyA1cBjK
 etXlhicihF/z2kRUp8NqGrLFom8F+U2zk+jqMYICoeweseQR
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Once the events are disabled in PARF_INT_ALL_MASK register, only the
enabled events will generate global IRQ. So there is no need to do the
masking again in the IRQ handler, drop it.

If there are any spurious IRQs getting generated, they will be reported
using the existing dev_err() in the handler.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 236229f66c80..972a90eba494 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -647,11 +647,9 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 	struct dw_pcie *pci = &pcie_ep->pci;
 	struct device *dev = pci->dev;
 	u32 status = readl_relaxed(pcie_ep->parf + PARF_INT_ALL_STATUS);
-	u32 mask = readl_relaxed(pcie_ep->parf + PARF_INT_ALL_MASK);
 	u32 dstate, val;
 
 	writel_relaxed(status, pcie_ep->parf + PARF_INT_ALL_CLEAR);
-	status &= mask;
 
 	if (FIELD_GET(PARF_INT_ALL_LINK_DOWN, status)) {
 		dev_dbg(dev, "Received Linkdown event\n");

-- 
2.25.1



