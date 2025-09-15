Return-Path: <linux-pci+bounces-36216-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F46B588AF
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 01:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F93B4E1FEE
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 23:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185A22DC339;
	Mon, 15 Sep 2025 23:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gK1RcYf3";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="OVV4iufm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC9A5C96;
	Mon, 15 Sep 2025 23:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757980779; cv=none; b=Yy5lXnTp8jau/03Zcb3y/NQFq/2h0GRp31qYiCS4utg8f+jqyrvkhdegGLACJHGrd4CaTelpeDmqMGGb8Ga3hgv3w/iybWBrlQmAFbSKRSKgzDSQVjWUMSI0O67cVhe3iSDM2u0Zzyog12K9UWw4HntYq0LPb9njQeX4IgkrsdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757980779; c=relaxed/simple;
	bh=lPo+MmAbaJ4RcImUPunqiSi0tkxuuXdNZTRsr7RBkKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PCU6xhhGXrLGewjChG1zBqN9H9xW1RuWX47G1ph2BzK8evbpQgb3Zavv1efU52ZZrdifc1ZHmi/SD0EuLVfNzcujCfO4sozqdBX86lLtroJombZlnso8aiAsBMKjdh1cbWweTfBm5ZNqTD4ronGn2i1bAzr4eHEfIUDqvxyWdBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=gK1RcYf3; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=OVV4iufm; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cQhpZ2GDXz9tgb;
	Tue, 16 Sep 2025 01:59:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757980774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VIXJv+Tk+btOXvpNbOOVKpDaA7mhVnLO1HpnIo+0uLo=;
	b=gK1RcYf3PblzEzcKtP5ndYzdjwJaKGK/YTUSfklh/WSLcKqoCub4gekSvteYzv3tDKz5OW
	7ho/1qhgnwUGQ5OnWioHzMmL5zz4z45ffCiQE2KUMdUfakX5KU+Lpit0BrzV0xboMHkHSw
	NvzqdZlTMZk8Oc5sflm0dnxD4BU3WG17g0TQLrpgddDiuuSTTg7n/59bEEqpiigI6hub0L
	eachXIxAerovc4+Aj6szg13Ob/YI2xq5oShRcCAd/KqoJcBzxoiujNJFVhcjez9sWmqn9H
	Xe38XvZ+Ng/YoZA+cKyN2GyxPs6UT4CBncXNzvmukY0xwT/Yr3k9vSdEbjitKg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757980772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VIXJv+Tk+btOXvpNbOOVKpDaA7mhVnLO1HpnIo+0uLo=;
	b=OVV4iufmn5SuB1etNRBorLkPTTU4yS3ga5FnRpy8K5pZDBJ+pItvlnGhk2NWQFEYwRVtpe
	6UgBQ8a0yFg5x5EiQMTmTP0w/iW++Oe5saXoyNDZ8S4RkCQfU5oU6F90n198jf6ihvZgbt
	iDk/3OplS3dGcUr4x+7GsxRF1dJ6hMHUHLjZoWHmXzdK25gTUVdARNY/IEJ6OXfC/KEBCO
	aHj+8pQLGGlVi9vD+Qw0T1Svc2kEd93+6e56IigYFcjR0uBpQJG8NDTJeASjC3o6yCuXRN
	mgrITBG95aSxYNW1pPQ6y2D9ALy95SW7QbO+zQMsfGhed7wez8oCa8isLTszLw==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH] PCI: rcar-gen4: Fix inverted break condition in PHY initialization
Date: Tue, 16 Sep 2025 01:58:40 +0200
Message-ID: <20250915235910.47768-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: duezxbbpsott3rqapy8king1yarmgdp5
X-MBO-RS-ID: 05e32af31a68a73225b

R-Car V4H Reference Manual R19UH0186EJ0130 Rev.1.30 Apr. 21, 2025 page 4581
Figure 104.3b Initial Setting of PCIEC(example), third quarter of the figure
indicates that register 0xf8 should be polled until bit 18 becomes set to 1.

Register 0xf8 bit 18 is 0 immediately after write to PCIERSTCTRL1 and is set
to 1 in less than 1 ms afterward. The current readl_poll_timeout() break
condition is inverted and returns when register 0xf8 bit 18 is set to 0,
which in most cases means immediately. In case CONFIG_DEBUG_LOCK_ALLOC=y ,
the timing changes just enough for the first readl_poll_timeout() poll to
already read register 0xf8 bit 18 as 1 and afterward never read register
0xf8 bit 18 as 0, which leads to timeout and failure to start the PCIe
controller.

Fix this by inverting the poll condition to match the reference manual
initialization sequence.

Fixes: faf5a975ee3b ("PCI: rcar-gen4: Add support for R-Car V4H")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 5932f83996f0..dafec70837fe 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -711,7 +711,7 @@ static int rcar_gen4_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable
 	val &= ~APP_HOLD_PHY_RST;
 	writel(val, rcar->base + PCIERSTCTRL1);
 
-	ret = readl_poll_timeout(rcar->phy_base + 0x0f8, val, !(val & BIT(18)), 100, 10000);
+	ret = readl_poll_timeout(rcar->phy_base + 0x0f8, val, val & BIT(18), 100, 10000);
 	if (ret < 0)
 		return ret;
 
-- 
2.51.0


