Return-Path: <linux-pci+bounces-11036-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0609942C64
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 12:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAAFB283F60
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 10:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A241AD3EE;
	Wed, 31 Jul 2024 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaXQ9pdO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81131AAE37;
	Wed, 31 Jul 2024 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722423018; cv=none; b=NkBzatWAqsK6xts5CW6viaP2jMS7OfW573E+6zZW8A4Oavw3yYzg9I7F/5MH2BFOxyoH3ZKNKgXgrVbZKS68kxOqH9tDx3MuiNoi8+UGBbw7+HI1Dd3s4as06yD1zx7bQwMi7vnLdswKL+VjHtSYsui6p6NdrKS1SZbi3ONssSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722423018; c=relaxed/simple;
	bh=wkgVf0vCUGHv6W2n+sOka0AmnpoDk4tVlRsVgJuMb+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=edhzqvW/V12LPUcjuHm935fVTCmuxj8WO+uJH0Om+xi1xMDOlHV4abCzbOxesFBumwymzjnJfEVnI2k/2xg8PQURooca6ga329beVoKkDsyskuILaevd86rKaV/zE9FkL8E7PwW2L+758qpSoAM97Exj3ljdUfBdCRH+u9J9oDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaXQ9pdO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D4CAC4AF09;
	Wed, 31 Jul 2024 10:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722423018;
	bh=wkgVf0vCUGHv6W2n+sOka0AmnpoDk4tVlRsVgJuMb+Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WaXQ9pdOA5dUYhf7fgC5BakRIJILVN8+72ARYAzlS0x4MsZuI8aGY889KUY/wIS0v
	 nmCbQLJkz8wwxPv1Vk0E6FDSO8dIXkRlnTqlLmJPjizGQ4ynFyJv46egnwNiKV47WE
	 oW6TojRaEWrM2P6zn0fAlNsyTjDbYoOvImWNJGbsd7TkeJ+Pto7S6a2+Kje7fdVjTz
	 hh9MNCOjJ4OaZ04649MhY+45OIEux7KeBfwIvIszIcGmSnBRB9XsHV7bksFOA6+Ahq
	 hGgRmNJIQr5buaHEVsLY4C2rmzAjreVYoNdzRIS/FZtip/cmFHxkuQiLWy9XwpeWRB
	 nrIYYa0Y9f/8g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F9DC3DA64;
	Wed, 31 Jul 2024 10:50:18 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 31 Jul 2024 16:20:04 +0530
Subject: [PATCH v3 01/13] PCI: qcom-ep: Drop the redundant masking of
 global IRQ events
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-pci-qcom-hotplug-v3-1-a1426afdee3b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1288;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=dIwxxT9MwJPav4RVeIZrg0i1F93yyMgBj6gEWSQjRyU=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmqhbisXcowvl/yG0UW4O6AGRXi2FMF4gMgakJi
 Oqhrka2mjuJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZqoW4gAKCRBVnxHm/pHO
 9TojB/9Rli4WbMlwzg/A9I87MfnXnx6Br1DPfLivGfiGV1jhEMpq76njTF0/nqTmcc/2e8Ocn1I
 GhKu7ntyec3zfuTjdHmGS85MyK7PMzaApR88hDZfcWUlK/vZn7QfnwLvN0+UoMF95+EHVChlnzW
 vGRfraBVnLgmhzNI9zSwrMkSLwpiLBXvGfRRIplPwismAf7tzM2y4cDleSPWS/RD8N5UE3MD0Kn
 cO/taDDMu3CnzhAnqRa+PdY6RDQRQ34jDgk0MK3ryFAZC6M2J1QW1Km4SlL909hrPjuxRzlnQm1
 QgRuHMFUTG3/GBiv/8p2AJ8I16Cl75v6rQPVB2YZ49WZ9JcQ
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



