Return-Path: <linux-pci+bounces-10442-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 959929340F4
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 19:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403EC1F23FE3
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 17:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90228183069;
	Wed, 17 Jul 2024 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7jyZa+w"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC69181BBD;
	Wed, 17 Jul 2024 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721235795; cv=none; b=n+hvSc1nPJzpbAc7VrQLMexi3IWki/ZIif09uRe6kJTgKw/sKCh+bBWeR+aG+G95ySNUkzFOc0qu3Ckw4qIHtu42X41QbfOkSZe0eMKPB+6UIB0jb/kjnSmKKuHYO+ucaWEHtvY+AUT9ogQ3k/RExRNCStd82DaVREacvARbhjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721235795; c=relaxed/simple;
	bh=wkgVf0vCUGHv6W2n+sOka0AmnpoDk4tVlRsVgJuMb+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=evFgs4kLdaF/LNItO0+gi9PVYQpfbb7qEPdc1llL0kv9vsyr2i/PtGcs+L9pqOeLkt/9C9SqPcckdsdI741UqUSguG/MkRcbeARfZYIJTYNdMNEXVsUWw/19tdIrbIb9pCtB20LhQIfespsctTsn9NUgcnlgEYyjUKgC4JDD5mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7jyZa+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D045DC4AF0B;
	Wed, 17 Jul 2024 17:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721235794;
	bh=wkgVf0vCUGHv6W2n+sOka0AmnpoDk4tVlRsVgJuMb+Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=r7jyZa+wEaM5dgZsSrg9LTvDVxNojSyFtXugKwGUjrFvSKnCCQt6FkXFcdwIVj085
	 1nI5mMCvpQ3QO5bImJhZyqeLGdSrku0RZ/oi1w/ItgUEzuMZMe8b+EvacNrKcpzm2Q
	 QO46KD0BuDDNVZ8GkqqQ/d6wK1RsxxXWdg5hkoGfHe3KdwgQbj33/P1qXd/bmkspxY
	 hsUGx6RXSCOK2OaXrA95BmCqQcuRLGUkPu7ZCoEbVRB3AinAA6Iar4wlUmema9Ui4v
	 I/n44jAdZfoo9bEVB6y37HP2goX3fw99bhyTT2T0ZlxDMZXDtj24NrywgykVU3VAiX
	 n8MGzEr4VtOyg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD070C3DA62;
	Wed, 17 Jul 2024 17:03:14 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 17 Jul 2024 22:33:06 +0530
Subject: [PATCH v2 01/13] PCI: qcom-ep: Drop the redundant masking of
 global IRQ events
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-pci-qcom-hotplug-v2-1-71d304b817f8@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1288;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=dIwxxT9MwJPav4RVeIZrg0i1F93yyMgBj6gEWSQjRyU=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBml/lMS8IeKnGvWYtg6R8/GQUOZIVLE+i/Y22Yi
 EtANDfadNiJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZpf5TAAKCRBVnxHm/pHO
 9Yy8CACM6ADfPk4VnUNZr4POA/dfxFciV3UUIFeQ9LBdFrZ6N8IJUY4nw1RLiCErYbcq6xbYNw1
 lpfhuGQQwXNuhIyipHx3eJOsp9B+22AMN1+m6j8GueXmP3sPFYkCWYE23cJkoXvO0FHKV1pIX95
 hA5FILdSh0KqP43CevDN9K/q93Ro/AdDGYypsjKIBFQBJf+TVc4VaAVoM/Qm8Cg8Vz9R1xuMRaO
 PogwsRu5wPaJDmOy/FaH6V5NqetdmaUm/MQ0bXrkGdEzjth9RnOyYC3ZyfB9hfqXdtzsgvhZN6E
 1ZYf9LpMyMGkOM3w+xzwoq7OQiJ3F2SH8mmjyE6d4kEhxrfW
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



