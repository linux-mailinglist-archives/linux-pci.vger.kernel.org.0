Return-Path: <linux-pci+bounces-13552-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E75C9871D5
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 12:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9F9FB269BA
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 10:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30561AD9CF;
	Thu, 26 Sep 2024 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iU7qsenh"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0E61ACE12;
	Thu, 26 Sep 2024 10:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727347436; cv=none; b=mxLki87TvM+45kq4J3/iRFL5YIeVdZPFtWj43K9r0RnBkeKvnsbp94f+hWUSycKG1ZDuo4g3EuRVVI5itxvVwVNnKCF1BWgl+i9BSIEZkIAs1xIw5XQwEx4PEyJJugYXYcH6x3t/+OAxgTO2hFF4do3jr3aJbIwVOFc8hLhnUeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727347436; c=relaxed/simple;
	bh=4m2OXplHfxIq+GC25lbDBxaJd+vMADGPxeGrykpTKOA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mvuAjLowHwiRa39lMdB/nCFE3fTCZK10EnbS/9/uhmSLM0kblOEiuHacCxRE+wXW6Q7K1Z+3H4UUy7oLK4WJj43/9e4urKxzaGt/rWlIcuIusIdFyhJBzFLn2V3WpXSsyczTCq2CZwZnZmIQxzBCFthj7WbguZ2w1mwxXDG2cM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iU7qsenh; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727347433;
	bh=4m2OXplHfxIq+GC25lbDBxaJd+vMADGPxeGrykpTKOA=;
	h=From:Subject:Date:To:Cc:From;
	b=iU7qsenh4tXIkR0yvVb6YKXedRnlnTbUI0l93efQBDcikiB7CU+XnPsQn5aN0mIne
	 ZumR272isg24Hrd+3QrUmbRYlq+dBNVeJTHI30rhqgJx1WYAgJ/w1Bum7NDwDY7g8F
	 eVEnXGH3mHr+QwALBhGp5d8buLX+QpffwjBw4D2Of+4lKJexNIoZM1d3yi0qn6g3ZR
	 Ckiuam8AQFSj8clRGD7veWgW396ClyunBLtaeHL8S8FVKUoXPAMN5EADD9mzuRMMUA
	 r95X38ncegP1jtOdWYM5xCBYuu0tASZ7ZHLXBFuVyU3ogRRJLQzhwy+7MT0jYIwNBS
	 VWkltm4qyvarg==
Received: from localhost (unknown [IPv6:2a01:e0a:d1a:1250:792b:136f:2a18:fd70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 00CAF17E11E2;
	Thu, 26 Sep 2024 12:43:52 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v2 0/4] Provide devm_clk_bulk_get_all_enabled() helper
Date: Thu, 26 Sep 2024 13:43:19 +0300
Message-Id: <20240926-clk_bulk_ena_fix-v2-0-9c767510fbb5@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMc69WYC/2WNywrCMBREf6XctZEkbZrqyv+QUvK4tcHaSKJBK
 fl3Y8GVm4EzMGdWiBgcRjhWKwRMLjq/FOC7CsyklgsSZwsDp7yhB8aJma+DfpbARQ2jexHWaiV
 lLTprRyize8BSb8pzX3hy8eHDe3tI7Nv+ZM2/LDFCicFa1FJ0wtD2ZPw8K+2D2ht/gz7n/AEjP
 KnRtAAAAA==
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
Changes in v2:
- Dropped references to 'broken' API in commit descriptions, per Mani's
  suggestion
- Added R-b tags from Angelo and Mani
- Link to v1:
  https://lore.kernel.org/r/20240914-clk_bulk_ena_fix-v1-0-ce3537585c06@collabora.com

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


