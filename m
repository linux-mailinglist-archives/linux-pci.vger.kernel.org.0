Return-Path: <linux-pci+bounces-19921-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B018DA12A56
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 18:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AFD21884F68
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 17:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1830191F75;
	Wed, 15 Jan 2025 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PP1l71W/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7F85223
	for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736963935; cv=none; b=gp211MrEB7lZXPhXgWcR6KfOrnDM7xmcOap/jSvnOSAcQr9Peqz4OZN4RaOSggnLT3QCf0JVk3A37Xq/D4WRQr5Kz8pBIVAuJoHMiZxCqmmCnFqmoWVLbgcK3tF57cLAgXuLF2cdDFOGW6SAoAnF0/UjxGYMWniiNKmMPRyrqBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736963935; c=relaxed/simple;
	bh=gZKYktDOO8kDP3psA1BVFTEyIt8B5t7fHIsUu2BTE+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=O1nvHTcACnwGjJ2g4NTRXV9k+5mREQEe7hm/aooyszYe5gVhII6a783Y3+RaMgDrCP/InJGZ4Psnf51h1yBRn0vKUKRs34LZDwIjCdQ+rlqzG68it26Oddlrk1zqeWl/lsBvkRc8NrdApllbRu2PHVjc310pVYklaZzj9or8IJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PP1l71W/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD11C4CED1;
	Wed, 15 Jan 2025 17:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736963935;
	bh=gZKYktDOO8kDP3psA1BVFTEyIt8B5t7fHIsUu2BTE+M=;
	h=From:Date:Subject:To:Cc:From;
	b=PP1l71W/lWn5a/5Wo8IGE+lxTF2vZAXcnb7GTVXUWvpuMjAKJNlyVD2tYQyKxAHVS
	 RZRL7kxLOJzNqFetUCJLu8glLoVmXnJH1miFKcVAyKCwaUzFTe/mIzWyp3KOhS4akl
	 GiJF0ByINvfr7QLNSROo7ZDW+mD1IZQ6t82vQ6/2gO5SW58JLYHN3OqtY/YPoFOtm2
	 hXU9xbZgSKKN8NFgNKPBBR9vfJo3mcWZGolV1qCjZmeSA3T9HOBFzHoQ3oS7N1Y8ng
	 okBwOdlkg/k+KMYBo3GTcxbNWeBW/bwAWoFKfYUrm6PGEOjs8JqWz6bbfg7e1WBOJN
	 4jiGjzWjfi0Rw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 15 Jan 2025 18:58:34 +0100
Subject: [PATCH] PCI: mediatek-gen3: Remove leftover mac_reset assert for
 Airoha EN7581 SoC.
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-pcie-en7581-remove-mac_reset-v1-1-61c2652e189f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEn3h2cC/x3MQQqDMBAF0KvIrDvgCMG0VylSQvK1szDKREQQ7
 25w+TbvpAJTFPo0Jxl2LbrkCnk1FP8hT2BN1dS1nWtFHK9Rwci988KGednBc4g/Q8HGyQWP9yg
 +RaFarIZRj6f/Dtd1A3zIoVFuAAAA
X-Change-ID: 20250115-pcie-en7581-remove-mac_reset-d5a8e9f18dc1
To: Ryder Lee <ryder.lee@mediatek.com>, 
 Jianjun Wang <jianjun.wang@mediatek.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Remove a leftover assert for mac_reset line in mtk_pcie_en7581_power_up().
This is not armful since EN7581 does not requires mac_reset and
mac_reset is not defined in EN7581 device tree.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index aa24ac9aaecc749b53cfc4faf6399913d20cdbf2..0f64e76e2111468e6a453889ead7fbc75804faf7 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -940,7 +940,6 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
 	 */
 	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets,
 				  pcie->phy_resets);
-	reset_control_assert(pcie->mac_reset);
 
 	/* Wait for the time needed to complete the reset lines assert. */
 	msleep(PCIE_EN7581_RESET_TIME_MS);

---
base-commit: d02e16e4e05d5d2530a4836ca92318c6a6b21b01
change-id: 20250115-pcie-en7581-remove-mac_reset-d5a8e9f18dc1

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


