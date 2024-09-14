Return-Path: <linux-pci+bounces-13214-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCD49792CB
	for <lists+linux-pci@lfdr.de>; Sat, 14 Sep 2024 20:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F0691C20E59
	for <lists+linux-pci@lfdr.de>; Sat, 14 Sep 2024 18:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3761D1304;
	Sat, 14 Sep 2024 18:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QaAZ5WQa"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F391CF2A7;
	Sat, 14 Sep 2024 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726337134; cv=none; b=oVttEY4zWY81X9GmG7x05H5TZ460Elc6D8Ci/cTu2YvosmaMf89LNvlx3tNWdoDu22vTOMXYpH93DzocvQhUaIDqGBX4auc9TEPOp8a5jAt45Flyd3ScqQ+w/CXQWSZW+VYSOLdqGVVNx1TUA6lIHp9aeKU6FTEpy1OVgQwiffc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726337134; c=relaxed/simple;
	bh=kQivVsyi2YlK67afNcK79cSiM+Ffg1dHW0BzqsTjx8k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nZi3cmvN8MeFRGaDZr2NZr7fSPxmuyDIEwjQqrXh529Gq878yPojEdxF3Wegz5yQcMy3bDhjMfq8BizhhNq403NzYGEs3NKR8kfsCZ8kd61/lOsu2BYGENCCppzHwrIys8j39Tsgstg4Xv6/aNfBx4YfLVCyWD2IBDmAdnomAdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QaAZ5WQa; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726337130;
	bh=kQivVsyi2YlK67afNcK79cSiM+Ffg1dHW0BzqsTjx8k=;
	h=From:Subject:Date:To:Cc:From;
	b=QaAZ5WQafNNj1cfv14YvHb8U/KAgVqINKInYWQekhy4GTqUbK4pwB1jY7MAkSzVUE
	 tV8INcZ1lcZiQ6uPywKWEHNq9nrvQ2rWoyGxiGAoeu0aekEN+Q44eHb8XjzsGf3dio
	 I7Vyb43JJ3q7sZOBWuCuZbDcuOL6qHpcnh26F81Be2go39kXPPy9Av5R5hOmrDn9Te
	 X9BhzP6x8OECuL6Oyjs28wXuhQkDy4EadY74y0MmYxQHXfLLsGnJqdea9TKek1tz76
	 ptNGyVco4XVmfSDqaG7hgsJI4YFJv0kJDVuxROzza2TKH5SuNxggoR4JzBss+fpMHB
	 SLTK+5SLoKRjQ==
Received: from localhost (unknown [188.27.55.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4810617E3606;
	Sat, 14 Sep 2024 20:05:30 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH 0/4] Provide devm_clk_bulk_get_all_enabled() helper
Date: Sat, 14 Sep 2024 21:04:53 +0300
Message-Id: <20240914-clk_bulk_ena_fix-v1-0-ce3537585c06@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEXQ5WYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDS0Mj3eSc7PikUiCRmpcYn5ZZoWtolpRobm5sapGSkqYE1FZQlAoUBhs
 ZHVtbCwBEpezdYgAAAA==
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org
X-Mailer: b4 0.14.1

Commit 265b07df758a ("clk: Provide managed helper to get and enable bulk
clocks") added devm_clk_bulk_get_all_enable() function, but missed to
return the number of clocks stored in the clk_bulk_data table referenced
by the clks argument.

That is required in case there is a need to iterate these clocks later,
therefore I couldn't see any use case of this parameter and should have
been simply removed from the function declaration.

The first patch in the series provides devm_clk_bulk_get_all_enabled()
variant, which is consistent with devm_clk_bulk_get_all() in terms of
the returned value:

 > 0 if one or more clocks have been stored
 = 0 if there are no clocks
 < 0 if an error occurred

Moreover, the naming is consistent with devm_clk_get_enabled(), i.e. use
the past form of 'enable'.

The next two patches switch existing users of devm_clk_get_enable() to
the new helper - there were only two, as of next-20240913.

The last patch drops the now obsolete devm_clk_bulk_get_all_enable()
helper.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Cristian Ciocaltea (4):
      clk: Provide devm_clk_bulk_get_all_enabled() helper
      soc: mediatek: pwrap: Switch to devm_clk_bulk_get_all_enabled()
      PCI: exynos: Switch to devm_clk_bulk_get_all_enabled()
      clk: Drop obsolete devm_clk_bulk_get_all_enable() helper

 drivers/clk/clk-devres.c                | 30 ++++++++++++++++--------------
 drivers/pci/controller/dwc/pci-exynos.c |  2 +-
 drivers/soc/mediatek/mtk-pmic-wrap.c    |  4 ++--
 include/linux/clk.h                     | 12 +++++++-----
 4 files changed, 26 insertions(+), 22 deletions(-)
---
base-commit: 5acd9952f95fb4b7da6d09a3be39195a80845eb6
change-id: 20240912-clk_bulk_ena_fix-16ba77358ddf


