Return-Path: <linux-pci+bounces-17479-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DCA9DED8B
	for <lists+linux-pci@lfdr.de>; Sat, 30 Nov 2024 00:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3BACB215FB
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 23:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4240165F1D;
	Fri, 29 Nov 2024 23:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAH7RPpn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759FC38FAD;
	Fri, 29 Nov 2024 23:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732922492; cv=none; b=G9prKxUqh54L582eM9yoSoKpiaFQ2kdm5f8xSYf26FX2duhyoSuoOHUrAJoMPoaQNxtm6fNyPyxmDbxCilT7rb0qIU9Md6r8Sn/DpLBesP9DkkuDEg1EmXsMoPOkVP6J0OdLUHMuPqt5cd6ER8zqV8jadIl6wJMu6/P7hX6hv1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732922492; c=relaxed/simple;
	bh=98GR4l7HhkOrsjECfowwM3AlW16asMwfcWomv8Ndi/c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Cep0PTYJpQExanoqYBuISE1FBBa84P0LAl1EcZGYamS/0Ez3AO+MHnbiIeftFc6ewO4n+mO80lpk/jVxThnyOKk1uh6JimhHJhUFPJsw8TwT7MwfFyIBF4td+JL6AKGUqFElGVf0wZcTKJoHlw2mFF+kmMJf8UO3Q/OFfv8idmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAH7RPpn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A7BC4CECF;
	Fri, 29 Nov 2024 23:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732922492;
	bh=98GR4l7HhkOrsjECfowwM3AlW16asMwfcWomv8Ndi/c=;
	h=From:Subject:Date:To:Cc:From;
	b=AAH7RPpncQuVKhs/wfigtX6eNrbVR53saE8ZK7JKbCSEcC8NTYDpdrTB7tWJwNmvE
	 NvQDU/F47Xc5MiM3VFPn8ARI8Qs+q4FdrRQuH5AsrjaRN4uReggLx5mrpXJs/vE4mt
	 5U+HuoPvNzbzT6jb3ID0ZUYfMzJyA99fmNJb83DeTEulBxFrdXuOSNfasACpmgcAyS
	 6NfPrMTaYJtb9SxhKXDuf9Z6ONcY/b7VSj23GT+YTVS7Ce5NHuwHSwUIdE+WlvkHZq
	 5yhZHtSfAdiw+P4hXY0rf3d2TpbTBiSRGgzv2bbJcBwYRNKXbLbF5zyTSWRNeYpR6z
	 HLeGDaQkTHPSw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH v5 0/6] PCI: mediatek-gen3: mtk_pcie_en7581_power_up() code
 refactoring
Date: Sat, 30 Nov 2024 00:20:09 +0100
Message-Id: <20241130-pcie-en7581-fixes-v5-0-dbffe41566b3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAClMSmcC/33PwQ7CIAwG4FcxnMVAC2Pz5HsYDwhFiWZbwCwas
 3eX7TTj4vFv839N3yxTipTZfvNmiYaYY9eWoLcb5q62vRCPvmQGApSUwvDeReLUGl1LHuKTMoe
 m0kIHD6iRlV6faF6U2vFU8jXmR5de84lBTtN/2iC54DYIVxtAQGcON0ot3XddurCJG2BJNGsEF
 EKQRatsaBoVfghcELJaI7AQwVjv0QYHhn4ItSTqNUIVAtT5XEkj0PrvR8Zx/AAngwF+fAEAAA=
 =
X-Change-ID: 20241107-pcie-en7581-fixes-296505fd2353
To: Ryder Lee <ryder.lee@mediatek.com>, 
 Jianjun Wang <jianjun.wang@mediatek.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Minor fixes and code refactoring in mtk_pcie_en7581_power_up() routine

---
Changes in v5:
- fix comment in patch 3/6
- fix commit log in patch 5/6
- Link to v4: https://lore.kernel.org/r/20241118-pcie-en7581-fixes-v4-0-24bb61703ad7@kernel.org

Changes in v4:
- fix comment in patch 4/6
- Link to v3: https://lore.kernel.org/r/20241116-pcie-en7581-fixes-v3-0-f7add3afc27e@kernel.org

Changes in v3:
- add trivial patches 5/6 and 6/6 to the series
- rename err_clk_init in err_clk_prepare_enable
- fix commit log for patches 2/6 and 3/6
- Link to v2: https://lore.kernel.org/r/20241109-pcie-en7581-fixes-v2-0-0ea3a4af994f@kernel.org

Changes in v2:
- added trivial patch 4/4
- improved commit logs and comments
- introduced PCIE_MTK_RESET_TIME_US macro
- Link to v1: https://lore.kernel.org/r/20241107-pcie-en7581-fixes-v1-0-af0c872323c7@kernel.org

---
Lorenzo Bianconi (6):
      PCI: mediatek-gen3: Add missing reset_control_deassert() for mac_rst in mtk_pcie_en7581_power_up()
      PCI: mediatek-gen3: rely on clk_bulk_prepare_enable() in mtk_pcie_en7581_power_up()
      PCI: mediatek-gen3: Move reset/assert callbacks in .power_up()
      PCI: mediatek-gen3: Add comment about initialization order in mtk_pcie_en7581_power_up()
      PCI: mediatek-gen3: Add reset delay in mtk_pcie_en7581_power_up()
      PCI: mediatek-gen3: rely on msleep() in mtk_pcie_en7581_power_up()

 drivers/clk/clk-en7523.c                    |  1 -
 drivers/pci/controller/pcie-mediatek-gen3.c | 61 ++++++++++++++++++-----------
 2 files changed, 38 insertions(+), 24 deletions(-)
---
base-commit: ac9626f643ea9cde795811d924388fa49f2c4c0c
change-id: 20241107-pcie-en7581-fixes-296505fd2353

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


