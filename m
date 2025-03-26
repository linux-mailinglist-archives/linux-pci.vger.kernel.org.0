Return-Path: <linux-pci+bounces-24744-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D81F3A71226
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 09:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DAD516F9B3
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 08:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C761F1A3A8A;
	Wed, 26 Mar 2025 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8XsTaJA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8712E1A2557;
	Wed, 26 Mar 2025 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742976664; cv=none; b=uxPU+riTBSNUcuJ7N87YiavtIgSCfU2EawYU5mUrEKCY1qmJ0t5MOF5SOWfrPrJ3/aERbLsDd5WbncFercsz8bLKx09y3ANNJgdUG3dTqpqwlxfM/pzpz1OxYLok5U9x71zDE7NDKIbIlEcuwTlTBBUOHZNKpxE4OJRnPxne76M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742976664; c=relaxed/simple;
	bh=EdwmW2qM72zprO32J7oN9gsX7eRHVgABO9JcM6BsASE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZQNB0mdSfxnMWOKT5h9nSXU33LPO1TppBYqPHyokjg1EroYGV2kNytI8MirrKggborkLITrMMyrF/k/ztu8i4Rntqs75djdZN8sfMhsz2++3rCl1BIz003Xpl6bevkd1O6xPSAONoGTauusGQG+ECCgUiGSqFo36BPghIGeZ5jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8XsTaJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E44F4C4CEFA;
	Wed, 26 Mar 2025 08:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742976663;
	bh=EdwmW2qM72zprO32J7oN9gsX7eRHVgABO9JcM6BsASE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=r8XsTaJAk5X9kS+219oygnAzpwGGY+LTmLSB2V5hqXPgvOzHnzYCANvsQo9zPgWew
	 YgFuUsbJZYrvsLN8XupiMgaodwP9pHkn4eSWzLLdAE/Y4UzuqY6a/ooAVqtOHar9vj
	 uTH85Acrny//1bH3BmfM6evYpqbmBJpJlhQMO/FnqUUvMwqEdxhzurzA1gMV5txt9C
	 ex5GW3yrIsG62UNvj4gU5DSHXux2uYFYeeHfzsX+ezat8VZ/fbPjexTSETKeQ1dydl
	 qOv6oHZbjD5/VE599RouLiw9MKcaLqIAum5Z1/6A8LvPPckWQufpslc8l2Dktbzm2a
	 gbPmE7yS+oCkA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A5DC36012;
	Wed, 26 Mar 2025 08:11:03 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Wed, 26 Mar 2025 12:10:58 +0400
Subject: [PATCH v7 4/6] PCI: qcom: Add support for IPQ5018
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-ipq5018-pcie-v7-4-e1828fef06c9@outlook.com>
References: <20250326-ipq5018-pcie-v7-0-e1828fef06c9@outlook.com>
In-Reply-To: <20250326-ipq5018-pcie-v7-0-e1828fef06c9@outlook.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nitheesh Sekar <quic_nsekar@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Praveenkumar I <quic_ipkumar@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, George Moussalem <george.moussalem@outlook.com>, 
 20250317100029.881286-1-quic_varada@quicinc.com, 
 20250317100029.881286-2-quic_varada@quicinc.com, 
 Sricharan R <quic_srichara@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742976660; l=1385;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=FsXklbRpyC0apFWHqB5KrikZCLRTZbjSPVIiKdW78OE=;
 b=Zp1bIqvTXpB9oF8bNmqLmdvwXdOl5iP/n6rAOWaDSvKsmtJXozhPEk6tGVRs/PcfquGPGhiKA
 2XhKJN2NQf8DpGMww8KYvyFKnxY76JvKzPt/r7Qq01svykybuwpaLXe
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: Nitheesh Sekar <quic_nsekar@quicinc.com>

Add IPQ5018 platform with is based on Qcom IP rev. 2.9.0
and Synopsys IP rev. 5.00a.

The platform itself has two PCIe Gen2 controllers: one single-lane and
one dual-lane. So let's add the IPQ5018 compatible and re-use 2_9_0 ops.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index dc98ae63362db0422384b1879a2b9a7dc564d091..e91bbe2185692871d1727274aea50f0f0c52a94b 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1840,6 +1840,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
 	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
 	{ .compatible = "qcom,pcie-ipq4019", .data = &cfg_2_4_0 },
+	{ .compatible = "qcom,pcie-ipq5018", .data = &cfg_2_9_0 },
 	{ .compatible = "qcom,pcie-ipq6018", .data = &cfg_2_9_0 },
 	{ .compatible = "qcom,pcie-ipq8064", .data = &cfg_2_1_0 },
 	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },

-- 
2.49.0



