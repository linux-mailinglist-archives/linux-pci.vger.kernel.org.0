Return-Path: <linux-pci+bounces-12355-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 987C0962CC2
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 17:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1D5E1C239B2
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 15:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAF11A2C22;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGx2A7iH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C241A2572;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859984; cv=none; b=UB1mMpnbm66qwejxZK0uqetg8+w4DuQZsnnAjJLeUrXqXokXeCYmXNqXBKsszu3ea3i7eIlujKzdJvVRsvC6oKOBoOunDaMtvhVQrDNZpXjn8jBBpySZY1EsmuQrOazqpU/+wml3Wz4OLkDE21oiD2/Q4CpfUMo6me8HDjGSsdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859984; c=relaxed/simple;
	bh=wkgVf0vCUGHv6W2n+sOka0AmnpoDk4tVlRsVgJuMb+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hppK+GXIutGVJzfEVvBzXW7kSJ6D44GXUNXvr29ocfEnXeXCpdH2KhCn5xtvqIlHTc1f3hV2Otg3fgLKa1aQIvo1+YZlyDmCeJhkI8Zx6BxyL0gs6z8StBBXsceKMmCcIG15XZvFBFwtFkNyS0j6WTmxWrTikht8fgKkiNVQu8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGx2A7iH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27AE5C4CECC;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724859984;
	bh=wkgVf0vCUGHv6W2n+sOka0AmnpoDk4tVlRsVgJuMb+Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TGx2A7iH7c0OnzQ0oG7vvsDvZro0UT2830+BsoOysgJef9cQFwDY+8RZCNA2e70oa
	 0BIhtmMPqc4rUvCK/bQlyBYvieirqQlZiIFp5a8VwzZvrIZcTSFw1Wq/uAcCoclvkH
	 H2Y2GWf9Vft+zo8zDGjEACOSgcHCuWZc5lfttCTZKpNUukALlgLmTqB4ks/3nmgmC+
	 566stUL/tacvtZqQQ6hG6gbb/EH/0wJPt6DGZTPF3TNm6qglIfUO+7FAknYv1eHqft
	 N1Drc3+dJf1DqyazGsm554w7QOop1j6AtJ4Zn5rxpIw86fLUWNFuBpEDcHOByGVzy9
	 nliiCPAAliJ9g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13708C5B55E;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 28 Aug 2024 21:16:11 +0530
Subject: [PATCH v4 01/12] PCI: qcom-ep: Drop the redundant masking of
 global IRQ events
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-pci-qcom-hotplug-v4-1-263a385fbbcb@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1288;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=dIwxxT9MwJPav4RVeIZrg0i1F93yyMgBj6gEWSQjRyU=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmz0ZKTql9/9UmlcG+Npy4IRg4LA68vHTpVm2b0
 w8p9An1P6mJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZs9GSgAKCRBVnxHm/pHO
 9b3mB/9sX+pg62jn7h5KxdyPMuPEU+Ut3hxhl94VOzC5toY93fuBpVtHvcMpMA5ZNa2cb19bMu7
 hu8fmadaUbbw5pZZsbcELIzNHLV43sKlxdW21EIWnVFBg1QCN2ri4S9zl+nKb7QdVyY3xPiTsHM
 Lf3K9p6wDZ+oR5Dlea+vnRrmF8tk3j0EUqYWoxMrzXNHNkw9+I/uMsuvTLQIp4W9mJoL38gR0Bq
 kSkdLDivlXUmnFhxHI+6n9qTHHuVhswjpl/+5DZe2kVcz/830JDPmL96x38aw2GE/mvdRYtHEXP
 RaPCocE5msPu6L9J+oUja0z7O2OSu2niy/ebgpRhccP3ZUJN
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

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
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



