Return-Path: <linux-pci+bounces-19915-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73029A129E8
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 18:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C75BF7A0511
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 17:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC9C24A7ED;
	Wed, 15 Jan 2025 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiJvsP/S"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9405F1990C5;
	Wed, 15 Jan 2025 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736962410; cv=none; b=PThKkFZHpF8wDG1qy7e1kFms6N2r0BZuBuBdb9IG8Gd225Q7Fec9nTxbQTvKMVe4y7zYJPp0sdPycZauMeWdJFClLpHApRsmWV3/5g7W98//8gECmg6C/VYmuZrwLvmunMpjNpmJ1htTfHj00uhuWKcCdi5wcT3kX3FQW8DCUbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736962410; c=relaxed/simple;
	bh=7o8Q6dw5w7ZBaDF+qxgJBh5no1oSt0L9ljwV3ZpUqew=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mEIiZF/HmeNNtycQ1lysEgAlU27bqbD7HOFjn9IPokHkijQVunYVFXawZ5kjt7SWizdzM2/Tc43OORJsDi7OXlyUrIqYsi2wuqeg2zJ0TGKITHqYp+QNXMbQACZiKxqz8Sly1n8Te3J9c7TemqDlNMgmG5rp7jIRvdtNPCAkxr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TiJvsP/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0AE0C4CED1;
	Wed, 15 Jan 2025 17:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736962410;
	bh=7o8Q6dw5w7ZBaDF+qxgJBh5no1oSt0L9ljwV3ZpUqew=;
	h=From:Subject:Date:To:Cc:From;
	b=TiJvsP/SCavBl8s8KUcFxPUl/NySxta50CP3CEfdcThFqc4C4zc0TvhXwsxSds9Rk
	 +fdtQ8YuIPND0vnkRQhBBSe8vplH0FYNVPEtrFHP2J1q866FzxU/8EiFftTzoyUNEG
	 KthxmvubHta38gO6ALVt+dM0x3JTPAIx2/nFeizq6odj37TwFUriR0ZJWNKvlEC02B
	 0BDgDH503jaGXtiUafHjPXcBnPNFoGF3Ogc6brNei4l66M4myDsFbx4Z7auWpy3CBP
	 0L2HAxiTz7HJXH5yyHkMus9Q54OJkp3Zu+LHvn7Me/mhpGHtMVCrrbjdYBMCqzBZzB
	 5JG/T1s885sHg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH 0/2] PCI: mediatek-gen3: Set PBUS_CSR regs for Airoha
 EN7581 SoC.
Date: Wed, 15 Jan 2025 18:32:29 +0100
Message-Id: <20250115-en7581-pcie-pbus-csr-v1-0-40d8fcb9360f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC3xh2cC/x3MQQqAIBBA0avErBvQSMyuEi3MppqNiUMRSHdPW
 r7F/wWEMpPA2BTIdLPwGSt020A4fNwJea2GTnVGaW2QojWDxhSYMC2XYJCMzvV+McoN/Wqhpin
 Txs+/neb3/QBOmdYaZgAAAA==
X-Change-ID: 20250115-en7581-pcie-pbus-csr-994ab50984d7
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
 Jianjun Wang <jianjun.wang@mediatek.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Configure PBus base address and address mask in order to allow the hw
detecting if a given address is on PCIE0, PCIE1 or PCIE2.
Introduce binding for PBUS_CSR node available on EN7581 SoC.

---
Lorenzo Bianconi (2):
      dt-bindings: arm: airoha: Add the pbus-csr node for EN7581 SoC
      PCI: mediatek-gen3: Configure PBUS_CSR registers for EN7581 SoC

 .../bindings/arm/airoha,en7581-pbus-csr.yaml       | 41 ++++++++++++++++++++++
 drivers/pci/controller/pcie-mediatek-gen3.c        | 29 ++++++++++++++-
 2 files changed, 69 insertions(+), 1 deletion(-)
---
base-commit: d02e16e4e05d5d2530a4836ca92318c6a6b21b01
change-id: 20250115-en7581-pcie-pbus-csr-994ab50984d7

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


