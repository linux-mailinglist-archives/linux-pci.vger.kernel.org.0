Return-Path: <linux-pci+bounces-28703-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C65A7AC8CC5
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 13:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07FFF4E5BD2
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 11:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3580D22B5AC;
	Fri, 30 May 2025 11:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="DjpVjCES"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C1F22A4EF
	for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 11:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748603992; cv=none; b=rfhvMQ5WN7LtLDBeMmvUwZSwJ7CWiFLXtmCNhX1+avt44lBVhPpEHXZ5Rgl5R0KE3USQVlv77bgUyZTYCXdlkT/91rs17WW+EwjmQG7H9lJHy7ybvYNtePnF8rq+/hkEF5GieNNsGH0Et1SlT7dGCOddmZ1z9f0OT76AeZWoErU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748603992; c=relaxed/simple;
	bh=Ah7Z+DsWBX06w3bVvtMO0K5BDNvk6TjZ7R8qbml2dpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGwBnibUqNXDNoFNEgVHBxLxdbbLRT5G8YTE2WF+kCIrZsBq+AFT4qqm8j9HKR02+X4m7A1DG4bk1wyxRtH2P4rOMfKRLnPngLMxOXCRKK1jQrYH5PSA7Qr38AWY6M7a4h6MNadJ5dJPTpzPzwkA7K53ThTn/ZybcMZuR10pEfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=DjpVjCES; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a4c9024117so1367378f8f.0
        for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 04:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748603988; x=1749208788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJ/+G+AC3goiMLAvY8TZZVygk03XZkoKHyxtdwV9Bko=;
        b=DjpVjCESWVc0Bd1YTeQkSuYLD6nXwsQyhHj0r20Nam4ljGqxhIFc/xaH3O4lnlEgTI
         eWLS7i+0uGEnmpQFva5kbbmlnGXt+WB4ktVk3s/Xq190MupoyXKkWBQNposG8m6xfId+
         ggHGPu1iK1SxLp5KvSCcjHhpLoR6C340WgEsek4oxWJTnUP5lP8IeNQ7EHsfx8w81x2a
         3eB+aGjk6rD/zOQzk9Wpse1wu5lxlwyBAfC5NJ1RdQyGp2NK+oyZ7jeEfY6BpGR4CXWb
         eXgtuYxaAai4JHU0Zn4H2LjHBx55aZelEZF+i1nXotaHW9TvOZb+69UKSWf3OH32JTqQ
         aJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748603988; x=1749208788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJ/+G+AC3goiMLAvY8TZZVygk03XZkoKHyxtdwV9Bko=;
        b=bX34gt2E5JlfAPB564T7pQm0vonqTET2ksCtFL+kA4UzVenrGNIO7UlkWVxhghm2oG
         jmUfV5CN7FVCMXIw9NO3ZGEuu1yXc0mEIvkWWM8Bp/H5c7+WhxfWWsQIeuPlBesIWw1g
         ckGhQCVk6c2RrHuwsreLAoXFOftj/yu9Vld1hpDuIxNICCGwWpPRRBlLMafuGGOXBfX2
         rcAsaIhW772Ps2zChc+LZYxbF6g/DRwNNvPJVa/e94iUEV5PuaPx7f3b43lGaVXCrHQl
         Ky/HGzHVH6hMKvXCzawTwQfzJ+EUq8rgfagKlUIBzS2d4XKR/WxBlTN6ROPrt8P8jKTb
         thkw==
X-Forwarded-Encrypted: i=1; AJvYcCXvMPIGSPrGI1QQssU3YZjinGtSwNA6IUeOAT5zS0ox7UxEya3hY/u61f1wDZGSg7MdAmRR3jmsMs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVN1xkIQs0Mte36K+pv3aACUNp72z77y2+Hw4y5Enbi4O0lT8j
	KyHcm92/DHj7NnX5VxdaOHeMaOLpL2oqqlfFjCVNTU6+eYJBc/6ZYd4544fDne2G9+Q=
X-Gm-Gg: ASbGncsGnJTD5tx9xujuWiY5ShL/iXdhx55v14eCfbkUpn0ys6SKJ6emJEILUn0azJ9
	gnZ145kUCBbow9hQpiU6RVBUbXkYDBHSbbEAWRDtV3g293G+/0xEgu8pfRkjqRvVkye9wSKvAKN
	GsiBBOKvTeaHiD++LT1P0Z38hY05qiRrxpo9TIAuVS99BekxFvueIyfhXAWlo8KwAhUvrXGhtrY
	U2HUw5K+AoAYPTla1hfdSvOLGSGPv3kHJXWHhdyX5iLSP2CLu2EX8quVTHSpFLtt1rx7F0Y4pFJ
	Z4+OHQarD+pBKKDBEfFhqdv/Cc4CGPKcj5wnHRVRCg3DKEihQXteq4Eb+pXgovN+4uo6K6BjAIo
	YHfrRlw==
X-Google-Smtp-Source: AGHT+IHmpme3ASdZjXhpIgvfrfPC8BzS2kR2b9/W6J51HT2LhURSK9ofZ+2PJlI42CY77vECWpRGwg==
X-Received: by 2002:a05:6000:4029:b0:3a4:da0e:517a with SMTP id ffacd0b85a97d-3a4eedb8a81mr6645254f8f.23.1748603987781;
        Fri, 30 May 2025 04:19:47 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450dc818f27sm3986435e9.18.2025.05.30.04.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 04:19:47 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	john.madieu.xa@bp.renesas.com,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 2/8] clk: renesas: r9a08g045: Add clocks, resets and power domain support for the PCIe
Date: Fri, 30 May 2025 14:19:11 +0300
Message-ID: <20250530111917.1495023-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250530111917.1495023-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250530111917.1495023-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add clocks, resets and power domains for the PCIe IP available on the
Renesas RZ/G3S SoC. The clkl1pm clock is required for PCIe link power
management (PM) control and should be enabled based on the state of the
CLKREQ# pin. Therefore, mark it as a no_pm clock to allow the PCIe driver
to manage it during link PM transitions.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none

 drivers/clk/renesas/r9a08g045-cpg.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index 4035f3443598..33219164a19a 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -243,6 +243,8 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 	DEF_MOD("adc_adclk",		R9A08G045_ADC_ADCLK, R9A08G045_CLK_TSU, 0x5a8, 0),
 	DEF_MOD("adc_pclk",		R9A08G045_ADC_PCLK, R9A08G045_CLK_TSU, 0x5a8, 1),
 	DEF_MOD("tsu_pclk",		R9A08G045_TSU_PCLK, R9A08G045_CLK_TSU, 0x5ac, 0),
+	DEF_MOD("pci_aclk",		R9A08G045_PCI_ACLK, R9A08G045_CLK_M0, 0x608, 0),
+	DEF_MOD("pci_clk1pm",		R9A08G045_PCI_CLKL1PM, R9A08G045_CLK_ZT, 0x608, 1),
 	DEF_MOD("vbat_bclk",		R9A08G045_VBAT_BCLK, R9A08G045_OSCCLK, 0x614, 0),
 };
 
@@ -282,6 +284,13 @@ static const struct rzg2l_reset r9a08g045_resets[] = {
 	DEF_RST(R9A08G045_ADC_PRESETN, 0x8a8, 0),
 	DEF_RST(R9A08G045_ADC_ADRST_N, 0x8a8, 1),
 	DEF_RST(R9A08G045_TSU_PRESETN, 0x8ac, 0),
+	DEF_RST(R9A08G045_PCI_ARESETN, 0x908, 0),
+	DEF_RST(R9A08G045_PCI_RST_B, 0x908, 1),
+	DEF_RST(R9A08G045_PCI_RST_GP_B, 0x908, 2),
+	DEF_RST(R9A08G045_PCI_RST_PS_B, 0x908, 3),
+	DEF_RST(R9A08G045_PCI_RST_RSM_B, 0x908, 4),
+	DEF_RST(R9A08G045_PCI_RST_CFG_B, 0x908, 5),
+	DEF_RST(R9A08G045_PCI_RST_LOAD_B, 0x908, 6),
 	DEF_RST(R9A08G045_VBAT_BRESETN, 0x914, 0),
 };
 
@@ -358,6 +367,8 @@ static const struct rzg2l_cpg_pm_domain_init_data r9a08g045_pm_domains[] = {
 				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(14)), 0),
 	DEF_PD("tsu",		R9A08G045_PD_TSU,
 				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(15)), 0),
+	DEF_PD("pci",		R9A08G045_PD_PCI,
+				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, BIT(10)), 0),
 	DEF_PD("vbat",		R9A08G045_PD_VBAT,
 				DEF_REG_CONF(CPG_BUS_MCPU3_MSTOP, BIT(8)),
 				GENPD_FLAG_ALWAYS_ON),
@@ -365,6 +376,10 @@ static const struct rzg2l_cpg_pm_domain_init_data r9a08g045_pm_domains[] = {
 				DEF_REG_CONF(CPG_BUS_MCPU3_MSTOP, BIT(7)), 0),
 };
 
+static const unsigned int r9a08g045_no_pm_mod_clks[] = {
+	MOD_CLK_BASE + R9A08G045_PCI_CLKL1PM,
+};
+
 const struct rzg2l_cpg_info r9a08g045_cpg_info = {
 	/* Core Clocks */
 	.core_clks = r9a08g045_core_clks,
@@ -381,6 +396,10 @@ const struct rzg2l_cpg_info r9a08g045_cpg_info = {
 	.num_mod_clks = ARRAY_SIZE(r9a08g045_mod_clks),
 	.num_hw_mod_clks = R9A08G045_VBAT_BCLK + 1,
 
+	/* No PM modules Clocks */
+	.no_pm_mod_clks = r9a08g045_no_pm_mod_clks,
+	.num_no_pm_mod_clks = ARRAY_SIZE(r9a08g045_no_pm_mod_clks),
+
 	/* Resets */
 	.resets = r9a08g045_resets,
 	.num_resets = R9A08G045_VBAT_BRESETN + 1, /* Last reset ID + 1 */
-- 
2.43.0


