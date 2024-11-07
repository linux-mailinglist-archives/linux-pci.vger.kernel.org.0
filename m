Return-Path: <linux-pci+bounces-16238-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F38099C081B
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 14:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9071F23419
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 13:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D422114;
	Thu,  7 Nov 2024 13:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1OiSVUq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C8C212D22
	for <linux-pci@vger.kernel.org>; Thu,  7 Nov 2024 13:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987482; cv=none; b=Z4c21lwSECp9IgLGPr4Nzw1GH/tFdtbhlN5RUvq240TsZekxAn3MHpmd6D2sWR7MXpNgK+UeoW6OVBcH3Jnt2R5wI3B84RugEzpgGMzipl/YVTIJ8D0rGqvGV3T2ad6OJz4ursVUcL5CMS8EWQH6jbXp6eKTTpZ3AaarYaONgb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987482; c=relaxed/simple;
	bh=dLpTfBzBR4l3dk9jBKmt+I9L2IwzEPpeAgKAP5o9ehU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DsRqG8hwDRV6zsyjwFaE9fxOBxfGmvV92gZxofRjTs6jao7vA1AvfoEt2ym5uocv1PSI+MyOTWl8B6yulZj9WUHURq7xPjMSpNCzBnQFko4aQ+8gTGvM3Dah0qPjh7QDP2+wJMGf9FsD7kavJ8+Ook1kDwikOQjSC8OGGn+kcss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1OiSVUq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2D1C4CED0;
	Thu,  7 Nov 2024 13:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730987481;
	bh=dLpTfBzBR4l3dk9jBKmt+I9L2IwzEPpeAgKAP5o9ehU=;
	h=From:Subject:Date:To:Cc:From;
	b=T1OiSVUqVLAXBaN/1uR2cwpX8Y8CSgSn93azivwoF7bOH8onOWdu+1rmVKVYfXcZq
	 u8pEb8u1xDgsH0eauIFXgmyuIbPf2ErEYsQRP/DsvUC/jKoAM3+V2xkkrvgFZmDS8w
	 ZEZbJ8VHWK123nH9VvhBGcAC4hWTOSbSlWVeOqnX+S6rB0qrqziv2GhwjwMG2uCr5u
	 rY9slBGbl9/qhIf8Wcv4OGI9i0fduvlUTg1fngPI+Q50zsCYP5P6HtD4bsGGS2kIdY
	 eMb8u8GAGkYchsT5qsZfqtR17Is0hOSMcm201ahVo7HA+LBP4oVze4hKTl8afU3XVt
	 m3iTBD4GwgEnQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH 0/3] PCI: mediatek-gen3: mtk_pcie_en7581_power_up code
 refactoring
Date: Thu, 07 Nov 2024 14:50:52 +0100
Message-Id: <20241107-pcie-en7581-fixes-v1-0-af0c872323c7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALzFLGcC/x3LTQqAIBBA4avIrBtQy/6uEi3CxpqNiQMRhHdPW
 n483gtCmUlgVi9kuln4ihWmUeDPLR6EvFeD1bYzRg+YPBNSHNxoMPBDgnbqnXZht61roX4p0x/
 qtqylfD+3Q5BjAAAA
X-Change-ID: 20241107-pcie-en7581-fixes-296505fd2353
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

Minor fixes and code refactoring in mtk_pcie_en7581_power_up routine

---
Lorenzo Bianconi (3):
      PCI: mediatek-gen3: Add missing reset_control_deassert for mac_rst in mtk_pcie_en7581_power_up
      PCI: mediatek-gen3: rely on clk_bulk_prepare_enable in mtk_pcie_en7581_power_up
      PCI: mediatek-gen3: Move reset/assert callbacks in .power_up()

 drivers/pci/controller/pcie-mediatek-gen3.c | 42 ++++++++++++++++-------------
 1 file changed, 23 insertions(+), 19 deletions(-)
---
base-commit: 3102ce10f3111e4c3b8fb233dc93f29e220adaf7
change-id: 20241107-pcie-en7581-fixes-296505fd2353

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


