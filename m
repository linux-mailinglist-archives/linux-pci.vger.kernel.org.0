Return-Path: <linux-pci+bounces-14828-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F71E9A313D
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 01:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC62EB23FA7
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 23:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7236A2296CA;
	Thu, 17 Oct 2024 23:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="i2+isRGy"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639FF2022D8;
	Thu, 17 Oct 2024 23:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729207075; cv=none; b=dxE3uxKqhfxEcXXvpoZPqOTU4YGcHt65zijSOuX8wTG/vQcXkfYAAGZoItEQfm1FEvUmSjfsaRaGRUhmV6MIBizz6VZx4WyDF8Gh3TAj83dMLYUaf4YbDNZOQX2DFbludUmZxACrPuXFiYHF+OMQY+lTxmhlAQW3K5B8NCnJ4oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729207075; c=relaxed/simple;
	bh=PGpSy6vZ3IB7z6NIJ4YmFbrqhdsJZdi8xxzeLI5+mQc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IfP3gIl+hrmOqwdgQO500Dxy3I6EWHqEJ82CZs0UK0Kcm4sRF77+yw6G7pD8FAbhO2Sr/3Lji/ebo8QPVaG0U/jSBVTuWBHxqMWUOyL1e+z21GfMy75wj0hRaV9owxvEq7m9VYh1juSbanff/y42ZuNmuXRKPp/UhIVtMpXm1pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=i2+isRGy; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729207071;
	bh=PGpSy6vZ3IB7z6NIJ4YmFbrqhdsJZdi8xxzeLI5+mQc=;
	h=From:Subject:Date:To:Cc:From;
	b=i2+isRGy1D/Wiib4ediUql9Gj7PIxRfvI3h/hGUTB8XIG+45C853ICfv2hU6q+5/n
	 eZCvI4SvkTxQPC61SHsDGMC2gSVnMXfz5vEdO0rNHV0Dh87dB3wasuSd6yKV/cG3cp
	 CByCgUt3h0UC2blHRtFWzCuE3z8CWmXZAT816WXCBaEgjG7xiFo7YvDWpMwUr0qnBF
	 uDLTA1gM0JtaZFKmxjBkElNTPLOFRZBhmDlKkplbQMvr8xQCiRNHnnIyd1ELIJO49F
	 +ZVqX4XxK21c/hoR+lAjr+aBj9HaMUPTqmWaYT3HLBeH6G8Bqb+m/ibPxptLlP9vhH
	 CQ/HQNjKb6EuQ==
Received: from localhost (unknown [188.24.146.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 416CC17E0CED;
	Fri, 18 Oct 2024 01:17:51 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v3 0/4] Provide devm_clk_bulk_get_all_enabled() helper
Date: Fri, 18 Oct 2024 02:17:28 +0300
Message-Id: <20241018-clk_bulk_ena_fix-v3-0-57e8bb82460c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAibEWcC/23N3wrCIBQG8FcZ5zrDP1O3rnqPiKHONWnN0JJi7
 N1zgyCqmwPfB9/vTBBtcDbCrpgg2OSi82MObFOA6dV4ssi1OQPFtMQ1ocgM50bf87Gjajr3QER
 oJSXjVdt2kGfXYHO9kodjzr2LNx+e64dElvaNlb9YIggjYxlnklfcYLE3fhiU9kFtjb/AAib6g
 VDxB6EZqY0UkhPcac2/kXmeX87zACH5AAAA
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

 drivers/clk/clk-devres.c                | 30 ++++++++++++++++--------------
 drivers/pci/controller/dwc/pci-exynos.c |  2 +-
 drivers/soc/mediatek/mtk-pmic-wrap.c    |  4 ++--
 include/linux/clk.h                     | 12 +++++++-----
 4 files changed, 26 insertions(+), 22 deletions(-)
---
base-commit: 7df1e7189cecb6965ce672e820a5ec6cf499b65b
change-id: 20240912-clk_bulk_ena_fix-16ba77358ddf


