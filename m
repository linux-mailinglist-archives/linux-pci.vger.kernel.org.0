Return-Path: <linux-pci+bounces-17030-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C5E9D0A91
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 09:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A0D7B21CE0
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 08:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EA313DDDF;
	Mon, 18 Nov 2024 08:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5Mcfxiw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C413405FB;
	Mon, 18 Nov 2024 08:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731917120; cv=none; b=cYkmUc2t6bwtdQOppXnhjWHUsasDTDThy/t67XwH+Qo1Gyz9phkqaovBZZQ77ieouLR4+VWYMpFEMMdu0ZkQMtTZ0PkTxovs00rGCytSnz2WhNIZc9gaVicJGby5ceaXuY53rtEs+rv7WAFpFLkHS3f7rVpbieCa1oski9qvfts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731917120; c=relaxed/simple;
	bh=spc3BCehefvXljejaMy5S4i/Hscl4iY4xnBC2Qdg15c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YtTQvgl5YC8PTIyT2MyvlVpx2vY5PqH16AyKVusxpncgJ9IB4J+BD4FqpfIHZ6SwQRhfcYRXBjkr390nEk1Ag7FbMMWPm5DMyDfKH1zhFu+xcAiwJ+66ZO0hL2rjm67h2jHweAlBQWgdF3sOJu5HgVNEElMRKbiq5lzi7xjospY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5Mcfxiw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C4FC4CECF;
	Mon, 18 Nov 2024 08:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731917119;
	bh=spc3BCehefvXljejaMy5S4i/Hscl4iY4xnBC2Qdg15c=;
	h=From:Subject:Date:To:Cc:From;
	b=R5McfxiwncmtwJFZJqpiAZSKCwY5xQdooOFsayfh93oAjStTekaQAnN8d/fTGN7I5
	 droBPbTp9y4oQyKuOO3/7/HP3OaXF2Q/0fc9zm3p1ToRXR5AzKBjymxf6K0Fk4MVL4
	 f9mb+uUbRS837jZ0SF5lc2F2EroFt/w0RQcFDwZOh1NRtCSOAPvAEKwQyqTmoaOrVF
	 yYiLzIQbQ/8Wls+brL71qATyY/8lPjOOTNX4/FrXHa0vOgAs3mYVT8rceU/TADJCLd
	 xFElGNNVJgGVYoU2zFHDrMrrEYNas/zo4cHA816IR9GmX0oegMaq9knSlNfRM6yPZo
	 DNOkpves5rnjA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH v4 0/6] PCI: mediatek-gen3: mtk_pcie_en7581_power_up() code
 refactoring
Date: Mon, 18 Nov 2024 09:04:52 +0100
Message-Id: <20241118-pcie-en7581-fixes-v4-0-24bb61703ad7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACT1OmcC/33NQQ7CIBAF0Ks0rMXAAKW48h7GBaFDSzS0AdNom
 t5d2lWNxuX/k/9mJhlTwExO1UwSTiGHIZYgDxVxvY0d0tCWTICB5JxpOrqAFKNWDac+PDFTMLV
 iyrcglCBlNybcDmV2uZbch/wY0mt7MfG1/adNnDJqPXONBgHC6fMNU8T7cUgdWbkJ9oT5RUAhG
 FphpfXGSP9FiB3B61+EKITXtm2F9Q40fhDLsrwBzQUyGTkBAAA=
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
 drivers/pci/controller/pcie-mediatek-gen3.c | 60 +++++++++++++++++++----------
 2 files changed, 39 insertions(+), 22 deletions(-)
---
base-commit: ac9626f643ea9cde795811d924388fa49f2c4c0c
change-id: 20241107-pcie-en7581-fixes-296505fd2353

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


