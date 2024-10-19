Return-Path: <linux-pci+bounces-14903-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 825D89A4CF8
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 13:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12E051F2288D
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 11:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A92B1DEFE8;
	Sat, 19 Oct 2024 11:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CMniy5LP"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A483818FC67;
	Sat, 19 Oct 2024 11:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729336575; cv=none; b=M+G0Pk0qfLJe8x1abj3fSqK56UuhsVuHBq3XP8S7to13bR4F9z46eurYvZmLr7h+OfPhHiXUjwHLfU42hFtGQ/suLgvayJnWQaSls8cO3Q4iH1SBaHFjHESapMaXTB9M3cVYl0i9Zq1TCDTKJPId6aPhZn68E07a69QH3667OEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729336575; c=relaxed/simple;
	bh=zy6eBkC6mTD47sGFuSu/kE6O5nq6hr0S/KoQYOZztNY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SPkwe222esR3OHcfLhefl+uno4tWjCyZfmoQ7/SgnNYn6IxGCV+gfMZttxCfdfZtzcS8J/FR1ICDX66xkonHMPPEoE1hnYIbBlSz2seD8Jd7GO40zOpagTs6a3z12H+EKI4aYJTjKO/Nb3S2uCBsMXQWfS/xp0iyLOb4rCHLCUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CMniy5LP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729336571;
	bh=zy6eBkC6mTD47sGFuSu/kE6O5nq6hr0S/KoQYOZztNY=;
	h=From:Subject:Date:To:Cc:From;
	b=CMniy5LPAE6Nbv0OawIzhTrrk1jWeUuKok05gfHqs0dlVLRnXnvjL7ULDSbVN85a2
	 xHY748AECrXlSiAVNigckaZ65BnGbRWKrseZk8niPdtXa5fn2m7mpZLZGvta8V0pDN
	 JCASHZ4p/D2QQYE6amkBGYjnH2NQqBNSt3g05P/jbmUg2rI7Iq5B+4caCZlSaCQLbt
	 crQ3TZ8Sk7XWlcxWy7bWniVXeOjXaavy6/dyqHa0Jxvipz23Cm4HdqTguHu1EjnGqS
	 4aFK+STqx4Z1GF4HQM5yVePXAm0D9l+sCTuQefSSxWC8GOuuCw5+gmHx+f6HH/OgdF
	 rhRJ4jgiIyXXg==
Received: from localhost (unknown [188.24.146.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9058217E1574;
	Sat, 19 Oct 2024 13:16:11 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v4 0/4] Provide devm_clk_bulk_get_all_enabled() helper
Date: Sat, 19 Oct 2024 14:15:59 +0300
Message-Id: <20241019-clk_bulk_ena_fix-v4-0-57f108f64e70@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO+UE2cC/23NSwrCMBQF0K2UjI3k03zqyH2IlCRNbbA2kmhQS
 vduWlBEO3lwL9zzRhBtcDaCXTGCYJOLzg85lJsCmE4NJwtdkzMgiJSowgSa/lzrez52UHXrHhB
 zrYSgTDZNC/LsGmyuF/JwzLlz8ebDc/mQ8Ny+sfIfSxgiaCxlVDDJDOJ74/teaR/U1vgLmMFEv
 hDCVxCSkcoILhhGrdZsDaEfBCMsVxCaESas1FqSkiPzi0zT9AI46PHGPgEAAA==
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
Cristian Ciocaltea (4):
      clk: Provide devm_clk_bulk_get_all_enabled() helper
      soc: mediatek: pwrap: Switch to devm_clk_bulk_get_all_enabled()
      PCI: exynos: Switch to devm_clk_bulk_get_all_enabled()
      clk: Drop obsolete devm_clk_bulk_get_all_enable() helper

 drivers/clk/clk-devres.c                | 23 ++++++++++++-----------
 drivers/pci/controller/dwc/pci-exynos.c |  2 +-
 drivers/soc/mediatek/mtk-pmic-wrap.c    |  4 ++--
 include/linux/clk.h                     | 12 +++++++-----
 4 files changed, 22 insertions(+), 19 deletions(-)
---
base-commit: f2493655d2d3d5c6958ed996b043c821c23ae8d3
change-id: 20240912-clk_bulk_ena_fix-16ba77358ddf


