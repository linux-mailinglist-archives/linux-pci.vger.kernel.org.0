Return-Path: <linux-pci+bounces-16373-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE4B9C2B5E
	for <lists+linux-pci@lfdr.de>; Sat,  9 Nov 2024 10:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEBB8B210BA
	for <lists+linux-pci@lfdr.de>; Sat,  9 Nov 2024 09:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D74145B27;
	Sat,  9 Nov 2024 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="offz9ekk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC53145A16
	for <linux-pci@vger.kernel.org>; Sat,  9 Nov 2024 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731144571; cv=none; b=YgkpfAuN4o27jBBrVONlRqM5EsUl9o9MDYHrcCm6kC/CXK3jD0zkTKYcu7OLMF90CHGI5P9T0twfABHhBesIh9rEVz+gu5++n9cLHFXXdS2PdtEoY+fNqhOHxvj9mRwv5XiJ6nASDZHZNnVlAtnCwt3UGOXnXNo1EKt6fBeD3aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731144571; c=relaxed/simple;
	bh=+BcPyG4I1IF3EXLrEkXmng4dCXSymF4dMJ8XpkxZI4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tpCWJbdjdmQGkQkrKsFHJS2+rCSGEf9LJAJAlujlvyD8Jr/DWxS2OXHvrooJuVcpcCgueF7y0cpX4mSSLcny2awdJ4zj5MDDlzo3X7IzT0GU5hEqYevRqOXGWNvFJdWnVrb8KfFRGj4m+zUBn8lc4hwhqVK1vv9HK+x0OHG1Cno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=offz9ekk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92281C4CECE;
	Sat,  9 Nov 2024 09:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731144570;
	bh=+BcPyG4I1IF3EXLrEkXmng4dCXSymF4dMJ8XpkxZI4k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=offz9ekkgH0jrv3N1QGwBDKkc4x9pVQe86sBYqBv2hSxhC2r+0OlPizA+i5isYMQl
	 UghLiaYW0E3ge9qfhleygJLv+tqI2VHtQ7Ro+++S4MaIiBt6/YtYLYuqZGJsIo5bls
	 yk9WZUOb0FRuexfapY9hE2I2U/WaX7S2btTeuHWWMM3nRXA02EbknbKMES2tEk62g1
	 yyO9fiTSdGve+BJYi/jZmp+tdRJuFdodY+Ef/6qd8dVjfR4j7N5kAYPBtTGkRm2R8u
	 MWaTeRxLBLZ0iQKntNGaBmuIejvlFtwnshUoITwld2xXe5f9eFROmRvr2buM3jQz82
	 0jLO9rLs1l6Ow==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 09 Nov 2024 10:28:40 +0100
Subject: [PATCH v2 4/4] PCI: mediatek-gen3: Add comment about
 initialization order in mtk_pcie_en7581_power_up()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241109-pcie-en7581-fixes-v2-4-0ea3a4af994f@kernel.org>
References: <20241109-pcie-en7581-fixes-v2-0-0ea3a4af994f@kernel.org>
In-Reply-To: <20241109-pcie-en7581-fixes-v2-0-0ea3a4af994f@kernel.org>
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

Add a comment in mtk_pcie_en7581_power_up() to clarify, unlike MediaTek
PCIe controller, the Airoha EN7581 requires PHY initialization and
power-on before PHY reset deassert.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 1ad93d2407810ba873d9a16da96208b3cc0c3011..c9981013e59d18ccd3294acdcbd536dd95a0e436 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -884,6 +884,10 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
 	 */
 	mdelay(PCIE_EN7581_RESET_TIME_MS);
 
+	/*
+	 * Unlike the MediaTek controllers, the Airoha EN7581 requires PHY
+	 * initialization and power-on before PHY reset deassert.
+	 */
 	err = phy_init(pcie->phy);
 	if (err) {
 		dev_err(dev, "failed to initialize PHY\n");

-- 
2.47.0


