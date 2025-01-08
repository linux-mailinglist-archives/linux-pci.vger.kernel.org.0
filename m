Return-Path: <linux-pci+bounces-19522-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8261A05759
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 10:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8FFE3A4ED1
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 09:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC981A2395;
	Wed,  8 Jan 2025 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJFG92gz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871CA17C20F;
	Wed,  8 Jan 2025 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736329860; cv=none; b=h+OZ4mDOptQ4gb1ycRynNofERAW8xAKCYlSjAPPVCX/Bbp2CD2IFwGuWvypszgMmums+d9j4oM3JctYeXihxcaq8lDPWDGcKCuIP5crffeLTfa/uDUdV/z5kNzjZpWgAy9h4C9AkOR6NmdChzZ4kPUQNkR+1d0m48glqSuHvJTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736329860; c=relaxed/simple;
	bh=fUoWeZRO/HpW76L68BYVrr8hfn5nR1LoYeez3wpOXUg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=J88m3QbcH/4OA0fQJn62xZ7bOrA1umyYwPZjD2hGeoV2Q+Jg2fNZPg6YhadA/L1BxE8BCgiNg0eR/y10BFAeF60NX+TsN8/2jEvg2of0oIs+y8dJ3QkWWk0r+iX6NxkMPanhS9lhJ88zqu7PdvhzMfx/MV7/XsaU27dvCpOYVRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJFG92gz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE7BC4CEE1;
	Wed,  8 Jan 2025 09:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736329860;
	bh=fUoWeZRO/HpW76L68BYVrr8hfn5nR1LoYeez3wpOXUg=;
	h=From:Subject:Date:To:Cc:From;
	b=iJFG92gz+jc4FqLGAbBNKQL3bo3cAYGD9Ol/xK1HqXkvE1NPhed37KLtNQY2GXR5q
	 lstqk+zktqh0F2H2VcMpjwJwdPwPnweQWLT0i0VA9fnrVoEtEzREDolzVyVUxHxIYV
	 ei7X2zCJfZ1/C5BwhnCFU5UseygPTlDMuzYmaUBWMEZcN1mchB07Lt9MJYbUnMpvUn
	 4xXTPl0BysZUakTTQRyZxIaX+SKb1rU5NgcgZwBKdd31o285kMU7YYndzhYg5Th4cv
	 vzDCpJydaZeTvGvMaVwDP1sfxyNrbCvdvaz+pTGIELBHVHaxGeKr44R9psZ2VloThY
	 r+frWP+b5YpLA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH v6 0/5] PCI: mediatek-gen3: mtk_pcie_en7581_power_up() code
Date: Wed, 08 Jan 2025 10:50:39 +0100
Message-Id: <20250108-pcie-en7581-fixes-v6-0-21ac939a3b9b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG9KfmcC/x3LQQqAIBBG4avIrBvQyLKuEi1E/2o2FgoRRHdPW
 n483kMFWVBoUg9lXFLkSBV9oyjsPm1gidXU6tZqox2fQcBIg3WGV7lRWHdxNA7W295Q/c6MP9R
 tXt73AwVH/KhjAAAA
X-Change-ID: 20250108-pcie-en7581-fixes-04d918e5a561
To: Ryder Lee <ryder.lee@mediatek.com>, 
 Jianjun Wang <jianjun.wang@mediatek.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Minor fixes and code refactoring in mtk_pcie_en7581_power_up() routine

Changes in v6:
- remove mac_rst support for EN7581 since it is not needed by the SoC
- fix typos
- Link to v5: https://lore.kernel.org/r/20241130-pcie-en7581-fixes-v5-0-dbffe41566b3@kernel.org

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
Lorenzo Bianconi (5):
      PCI: mediatek-gen3: rely on clk_bulk_prepare_enable() in mtk_pcie_en7581_power_up()
      PCI: mediatek-gen3: Move reset/assert callbacks in .power_up()
      PCI: mediatek-gen3: Add comment about initialization order in mtk_pcie_en7581_power_up()
      PCI: mediatek-gen3: Move reset delay in mtk_pcie_en7581_power_up()
      PCI: mediatek-gen3: rely on msleep() in mtk_pcie_en7581_power_up()

 drivers/clk/clk-en7523.c                    |  1 -
 drivers/pci/controller/pcie-mediatek-gen3.c | 57 +++++++++++++++++------------
 2 files changed, 34 insertions(+), 24 deletions(-)
---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20250108-pcie-en7581-fixes-04d918e5a561

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


