Return-Path: <linux-pci+bounces-30375-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B5CAE3F1C
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 14:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A939C17704C
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 12:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD572475C3;
	Mon, 23 Jun 2025 12:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DDknmJwh"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E188D2459D5;
	Mon, 23 Jun 2025 12:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680068; cv=none; b=IhVma2vrdF3OmTWkGsR4OO2uHyE8AP+VYmeCOKLacU7Edi5dCEGws5KsH7syDMj9GOBbSCgmahTyA5jOLdslAKr2RE08L5Lt99kyuOtQhM1Up4xPNo3vEdlPHl55toKXf8e0sFaUWWBB+BK98YqTYbkdAerOHNWzJ8jhzkLT7ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680068; c=relaxed/simple;
	bh=uyxGJ86xnKrIwF7mL8C2j+/YYGNG0EkD6tb5xhkwxoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nQQhw942oebFa49zj3339CFGVx2MEwkSB8J8X4sX2zoMMqD401DQoBGNib6WQ6PQoIhSDFcVddMWRa6W4BcuXDtCNFmmCAlJ/2jabcW9irq+bn7MhRgexeFXif9OM2z8gDNgARMrZ7pnbwMrDWKaYIpmhg8sjD8VTbfDnFdQH34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DDknmJwh; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750680065;
	bh=uyxGJ86xnKrIwF7mL8C2j+/YYGNG0EkD6tb5xhkwxoQ=;
	h=From:To:Cc:Subject:Date:From;
	b=DDknmJwhqFXhqysH7Akq9OflP9CRiXHFN6wZrgjG7h+RGO/ZMncB+dzJQi/+cLLCD
	 3mPyEl7anqpRGqnVJCy4Cu7yshGGt9btPE3lgZ/nBUzYxol6DseoFli5FxBEbQXE2K
	 mCduWnubROoSHnA3aebwNy/HCJIKBLrRP34fNN+uRXfuPBlRbhzifsH6onxqv4vvP2
	 UMb/EVBSmOyPPCzvXgTB+QP9ViJnbh2KvKhVxOk1MqUW6/4ZZw9xbjSDnCpapVHhiV
	 h6w87+pFekxKXWwnG9b/TD9C01ZvrgahEQsYFTET5Q6rkH8C7ir4LNYoPUqoxk+vQv
	 +4NB+L/BiD/WA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9B4BD17E090E;
	Mon, 23 Jun 2025 14:01:04 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: jianjun.wang@mediatek.com
Cc: ryder.lee@mediatek.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v1 0/3] mediatek-gen3: Add support for MT8196/MT6991
Date: Mon, 23 Jun 2025 14:00:55 +0200
Message-ID: <20250623120058.109036-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds (at least partial) support for the MediaTek MT8196
Chromebook SoC and for the MT6991 Dimensity 9400 Smartphone SoC's
PCI-Express controller.

Some strange PEXTP settings were omitted, as the intention is to find
a way to set those bits *outside* of the PCI-Express driver itself as
the downstream implementation is using ugly syscons to make the PCIe
controller driver to change bits inside of a clock controller.

In the meanwhile, this is a set of clean changes that are required for
the controller inside those SoCs in *any* case; further development
will occur, with high hopes to find a solution outside of this driver.

AngeloGioacchino Del Regno (3):
  PCI: mediatek-gen3: Implement sys clock ready time setting
  dt-bindings: PCI: mediatek-gen3: Add support for MT6991/MT8196
  PCI: mediatek-gen3: Add support for MediaTek MT8196 SoC

 .../bindings/pci/mediatek-pcie-gen3.yaml      | 35 +++++++++++++++++++
 drivers/pci/controller/pcie-mediatek-gen3.c   | 24 +++++++++++++
 2 files changed, 59 insertions(+)

-- 
2.49.0


