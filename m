Return-Path: <linux-pci+bounces-18668-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A279F5914
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 22:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519F81898615
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 21:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EE21FBC8D;
	Tue, 17 Dec 2024 21:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Sh6r9RnX"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C52D1FA8F0;
	Tue, 17 Dec 2024 21:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734471763; cv=none; b=RCnr7ysnyHzezC+sG7+dxccxohLy7mx/JXcCuHcDKoNL5msJPz2n5ounrE0+Rk5tfw+VyJoFlD1tXRR4hEDlEKePQXKz/OfQL8PCR12vUSB1a5WfvqoL5JagqVk567QbAIj9uViX5QSOixj+OviqLtEc7qXDdoXHrx8VFZuvSKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734471763; c=relaxed/simple;
	bh=ysF7xo/3hIsbR7jhMLjJuhC4kEcU9qe1dpoxk58hyxQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sn1XZoatBcMJuJiP7LP1+Al0WOE8LD88Yb5raQc2GvLUKwmk0/euuSBiUsXSjM//nojETKwjfTnKVeiHCOlKkJQgbq9dbYBhO6Sh7JeZJ6zv2xAiVKwXm6s5APk8wG5stDNwJu+HDreUeGuBU/DUC92pmPbK5x9nqB0g7yAViI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Sh6r9RnX; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734471759;
	bh=ysF7xo/3hIsbR7jhMLjJuhC4kEcU9qe1dpoxk58hyxQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Sh6r9RnXFtGaw3exnOgkDIXkqh9usYDZUNB5KbX8Xvd4uuyIQhEZbqfJ4KK8gmTiH
	 bWT71VNRKS0HfbkoD8GDW+B+512YfRvWXzzdBNy6hgO3MBoS4+ZcuNd+qKC6q1wJRd
	 i/ZfZZxuUR+yZXG+5wsga0sLGgRGcuH4fxxAz6bfUoSvB2//farkEJ6ZrOdffp4zLp
	 SS6pVMunKwIGFG28+63MArojj236eN+HZpp5MEL230Xu/sTfj89f8/Fph84eaK1WOT
	 /1eVKvxb6WXqhmDbNQqRt+ZsEGB3F19jQMIQlCA5T+ZgdDSRHo3Aas3YA4BhXOgPf4
	 88W5RAI4HP6Kw==
Received: from localhost (unknown [84.232.140.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6027B17E381E;
	Tue, 17 Dec 2024 22:42:39 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 17 Dec 2024 23:41:53 +0200
Subject: [PATCH v5 3/3] clk: Drop obsolete devm_clk_bulk_get_all_enable()
 helper
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-clk_bulk_ena_fix-v5-3-aafbbb245155@collabora.com>
References: <20241217-clk_bulk_ena_fix-v5-0-aafbbb245155@collabora.com>
In-Reply-To: <20241217-clk_bulk_ena_fix-v5-0-aafbbb245155@collabora.com>
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
by the clks argument.  Without knowing the number, it's not possible to
iterate these clocks when needed, hence the argument is useless and
could have been simply removed.

A new helper devm_clk_bulk_get_all_enabled() has been introduced, which
is consistent with devm_clk_bulk_get_all() in terms of the returned
value.

Drop the obsolete function since all users switched to the new helper.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 include/linux/clk.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/linux/clk.h b/include/linux/clk.h
index 1dcee6d701e439f35effd86ca3ee3b47a9839bd0..b607482ca77e987b9344c38f25ebb5c8d35c1d39 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -1138,15 +1138,6 @@ static inline void clk_restore_context(void) {}
 
 #endif
 
-/* Deprecated. Use devm_clk_bulk_get_all_enabled() */
-static inline int __must_check
-devm_clk_bulk_get_all_enable(struct device *dev, struct clk_bulk_data **clks)
-{
-	int ret = devm_clk_bulk_get_all_enabled(dev, clks);
-
-	return ret > 0 ? 0 : ret;
-}
-
 /* clk_prepare_enable helps cases using clk_enable in non-atomic context. */
 static inline int clk_prepare_enable(struct clk *clk)
 {

-- 
2.47.0


