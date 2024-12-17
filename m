Return-Path: <linux-pci+bounces-18666-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B946B9F591C
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 22:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A041D1897E78
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 21:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFC01FA8D0;
	Tue, 17 Dec 2024 21:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="imwMHrlx"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF74C1DD0C7;
	Tue, 17 Dec 2024 21:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734471760; cv=none; b=aAabIfCNuRKVWG5Q9gU5hZnTjZrPyHVf1x07Ky5mvJTc7upNxELaqe82fJlsQk3Kzy7EcCCWRxMLbniJAkIkwRGkFWd9H/KlThujbja1EgTxJmJlm804cnrEyQGND9WZ08ARU7CBWyeCavJRJBXrIe/2y8ugXlj2Gre4KQ7YhEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734471760; c=relaxed/simple;
	bh=vDGwghnzEpyF1ucpGKn335u7FFum2H1wBrC9CvBXl88=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rX/i+b/UpXCbfKLu1ghBso5cEEWV9zXlkiWOHiFNMBYEiV/Wy/ZG7uX8elwcxIGT8sfdURfjEK5Q364/zGLLeF76r7dcQGKTG3W4e89gX+nAG3VkDHrvl4LfYorYsZ2Tso4FIpZLfbJ7h6Y7Ikg2pTP/Cm3GeocqtFPlsnDEI6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=imwMHrlx; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734471755;
	bh=vDGwghnzEpyF1ucpGKn335u7FFum2H1wBrC9CvBXl88=;
	h=From:Subject:Date:To:Cc:From;
	b=imwMHrlxu8gtp+LRsadbrq9HuHBpKmk5TvaqO2HdVd4G1HI3WxBJntjDIO0OLXTR9
	 7waYyHcsnZtNs0Mszr1Z3BtVmcm2Yd0EHL7pp8FACzgWny88j2ULxcRGHlPURpafjs
	 ibJpaeoAk3iVWtYfXvPWrFUSUUZ7zUTV1cEi/EueA3RS8tGF8CY+PDY2BuhApSkPzS
	 wnDXrofs2T6yEQudiEcATIaIDZdtcAicI4SpJsvINf1ufVk0jVbVy+wnXlL2h/N8Jq
	 VqPi0Gv3JQjVuPsqwD01kyAcI7dHu0YtRl2DydGumm3hDHjdM5SQTerFciYEGLOgjX
	 AHAuRjuYFnWkg==
Received: from localhost (unknown [84.232.140.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AA34817E3816;
	Tue, 17 Dec 2024 22:42:35 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v5 0/3] Provide devm_clk_bulk_get_all_enabled() helper
Date: Tue, 17 Dec 2024 23:41:50 +0200
Message-Id: <20241217-clk_bulk_ena_fix-v5-0-aafbbb245155@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB7wYWcC/23NTWrDMBAF4KsErasy+pe7yj1CCZI8akQdq8iJa
 TG+e2VDS2i1GXgP3jcLmbAknMjLYSEF5zSlPNagng4kXNz4hjT1NRMOXELHOA3D+9nf68HRnWP
 6pEx7Z4xQtu8jqbOPgrXeydNrzZc03XL52j/MbGt/MPkfmxkFGlAoYZRVAfQx5GFwPhf3HPKVb
 ODMHxCuGwivSBeMNopB9F61EPGLMGC2gYiKKIPWe8ulhtBC5CPSNRC5I5GBjVqigb/Iuq7fTfB
 NMYMBAAA=
X-Change-ID: 20240912-clk_bulk_ena_fix-16ba77358ddf
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
X-Mailer: b4 0.14.2

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
Changes in v5:
- Rebased series onto next-20241217
- Removed the patch introducing the new helper - merged in v6.13-rc1
- Updated last patch to fix a rebase conflict
- Link to v4: https://lore.kernel.org/r/20241019-clk_bulk_ena_fix-v4-0-57f108f64e70@collabora.com

Changes in v4:
- Dropped usage of gotos in the new helper implementation to further
  minimize the diff (Stephen)
- Link to v3: https://lore.kernel.org/r/20241018-clk_bulk_ena_fix-v3-0-57e8bb82460c@collabora.com

Changes in v3:
- Made devm_clk_bulk_get_all_enable() use the new helper, as suggested
  by Stephen to improve diff readability
- Rebased series onto next-20241017
- Link to v2: https://lore.kernel.org/r/20240926-clk_bulk_ena_fix-v2-0-9c767510fbb5@collabora.com

Changes in v2:
- Dropped references to 'broken' API in commit descriptions, per Mani's
  suggestion
- Added R-b tags from Angelo and Mani
- Link to v1: https://lore.kernel.org/r/20240914-clk_bulk_ena_fix-v1-0-ce3537585c06@collabora.com

---
Cristian Ciocaltea (3):
      soc: mediatek: pwrap: Switch to devm_clk_bulk_get_all_enabled()
      PCI: exynos: Switch to devm_clk_bulk_get_all_enabled()
      clk: Drop obsolete devm_clk_bulk_get_all_enable() helper

 drivers/pci/controller/dwc/pci-exynos.c | 2 +-
 drivers/soc/mediatek/mtk-pmic-wrap.c    | 4 ++--
 include/linux/clk.h                     | 9 ---------
 3 files changed, 3 insertions(+), 12 deletions(-)
---
base-commit: fdb298fa865b0136f7be842e6c2e6310dede421a
change-id: 20240912-clk_bulk_ena_fix-16ba77358ddf


