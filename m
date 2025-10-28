Return-Path: <linux-pci+bounces-39546-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB47C1594F
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 16:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C236A1AA6B03
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 15:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003713451DB;
	Tue, 28 Oct 2025 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrI2aTcl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736733451CC
	for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 15:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666174; cv=none; b=g+1G19Fxp3EWO49M9gDHp+DlBvAr9cpxG/ZO1VBbmwsTuEvdKu9k0NYn+iXJeNbEqDQ+tf0xQ5lktHyZjKnx6ndn7HZs/z75zu1jPLfqh8fNoqEdkt6eGzj7LOfbt9yeytW93DGHJW/ia8nAgAZpmHONk9n6x+ojtogVJ/RS0TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666174; c=relaxed/simple;
	bh=OI3lu8B52L8q6L1vFOQdjWWy8M0I5zST9cEyiMD60xM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qk+c64/B9IZJmS3Hxm4Kfz1s9PWYKj0qessdjZTTyrbzdVLvJmVosk00MWZiiVGx1fG9iw3I45oxL6//nCTfxFIUh7UKwvDG2x8WoaGuNwBX1MjrxENQTvmKreWrLUfIp7StaHRU1bOs+38QHftJs6guYoei1EToPwPISsARnU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrI2aTcl; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b6271ea3a6fso4190908a12.0
        for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 08:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761666171; x=1762270971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLSaa6PcadKxSJGpM5AYmWJ5bCIVBLv3q1JgPY8IHz0=;
        b=QrI2aTclbYq0rfsjN9ycJmngTtFlr0AradMDCAKvIVjxw2AaOVeBt3jmOYpq2axXxx
         K1c6uUyyXfbrQj0YWiZI/0DbD2pVpHkwGytyNb1pRGTm9SzvPViA0TMMGrdMjggGOLPz
         Y5UZNwWpHMXKRlRWz78I9CSxvIXuOi7ts/oBGhW9ue5jvJNdoFZLr5kZy+wHG+Ft6t0S
         6kHCBDATWCXXXvAaNSa+w1AKB1hjF+hoWZlD0pMYV43HkmHbrQVj1F2/UoVg1bMgIk1d
         Ep5eibff3VSADIv88mZCJ2Om9YwaR6QilSJr3yVNT7RcvRtj4jOyKU187qTQ8dRag5Mt
         0CzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761666171; x=1762270971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLSaa6PcadKxSJGpM5AYmWJ5bCIVBLv3q1JgPY8IHz0=;
        b=qlBEod9DX+9YL6qNDD4+Iq8wlJxHB7MHTSz9wAPPxgEEa3eGHqzi9YuWi3UV/9AR9c
         MmkFHiqB3a8QEJ6SD/qcFlhwEEaHsM4ufdyGE31Pp32PAOzLVS45p48hXtf3/ml7dVgc
         U+O7lBaiO11WnoQHpoCwDKBqb/L0AH/nc12n5SquNtja4l2sHUlceQQ7ZcUHO800W4Vu
         He6603Y3R3dFpwTfpigDR2GwLu8a8wD9gSO++lmaiM4IuQBwlPD7dDJ5MVbdQq0OlUnQ
         WQZYTaNGiSwKcJbA4O4zuPkkxs4pB6N8WU38R0atPkCEEQuAEzolVsqw4/ihf+xYtOc9
         inBw==
X-Forwarded-Encrypted: i=1; AJvYcCXAvN/khB5wDjVguZ4lgdN4HU7gudDQRiaDKnaoMDrhFMDJ61BvgSOW6L26tfumhU6xKs1LEgCfajw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIEIfB94tk0TpW5qGnR4pUmcWihEHtAzizyMGScQLEqZG8/x6V
	n6WA9crcyMQhaftQVjVb1R4Qt9XmCar+JL+WdNE0YJh/GlCCXqbzoyNp
X-Gm-Gg: ASbGncvHuySMykHjGdWQkBQddsxVzXwXL73KoH6USD91d999lgbZDHBtPplpP/mZ+m5
	dMCJuZncTCwAcEBbUw6k9wsh1HlsxsIASCQQ8K4wiapAwDHeM9THQfub0CKaXkoukbJ5jWKPs6s
	i8/Q2/LXfbixBUp+VNwelq0LLtlueNdI0N5a57UGl+IAyMIgl1hETo0jgIfLUTuQpDPTWEcox2U
	8obTDtoRNw+PgNlS3mJ4IbjBS1fuVsQIaBIqveffP/ogyqgI5AXAOyNSD3lEyrB3slbkiRrgtSr
	DgKqM+QXF/PPicFZleQhr0VLnN1yBI8OawTLPovQfGiDI5tFooMA0pdy0PuOogNMyyHZq7K4qn0
	HQzqG5p3LyWt6DVdw1AeMlTlXaYQeUQJgaD6LksKW3Tv7jQRGTO3aC9pH+FkvgrH596oGzk08CA
	BW+u4FGdhR
X-Google-Smtp-Source: AGHT+IFtaSkAiKKcd2pcmpO8llRHe3kknOAIp2k2H7U83BZTPQHu+FuTy+qLrHQP9UKuG8qf//3qLQ==
X-Received: by 2002:a17:902:da8f:b0:26d:353c:75cd with SMTP id d9443c01a7336-294cb381901mr58454085ad.21.1761666170702;
        Tue, 28 Oct 2025 08:42:50 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0a4d9sm119815145ad.37.2025.10.28.08.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:42:50 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-omap@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Markus Elfring <Markus.Elfring@web.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v3 2/2] PCI: j721e: Use inline reset GPIO assignment and drop local variable
Date: Tue, 28 Oct 2025 21:12:24 +0530
Message-ID: <20251028154229.6774-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251028154229.6774-1-linux.amoon@gmail.com>
References: <20251028154229.6774-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Assign the result of devm_gpiod_get_optional() directly to pcie->reset_gpio.
Thus removes a superfluous local variable, which simplifies control flow
and improves code clarity without affecting functional behavior.

Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v4: Improve the commit message
---
 drivers/pci/controller/cadence/pci-j721e.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index a88b2e52fd78..ecd1b0312400 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -477,7 +477,6 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 	struct j721e_pcie *pcie;
 	struct cdns_pcie_rc *rc = NULL;
 	struct cdns_pcie_ep *ep = NULL;
-	struct gpio_desc *gpiod;
 	void __iomem *base;
 	u32 num_lanes;
 	u32 mode;
@@ -589,12 +588,12 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 
 	switch (mode) {
 	case PCI_MODE_RC:
-		gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
-		if (IS_ERR(gpiod)) {
-			ret = dev_err_probe(dev, PTR_ERR(gpiod), "Failed to get reset GPIO\n");
+		pcie->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+		if (IS_ERR(pcie->reset_gpio)) {
+			ret = dev_err_probe(dev, PTR_ERR(pcie->reset_gpio),
+					    "Failed to get reset GPIO\n");
 			goto err_get_sync;
 		}
-		pcie->reset_gpio = gpiod;
 
 		ret = cdns_pcie_init_phy(dev, cdns_pcie);
 		if (ret) {
@@ -616,9 +615,9 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 		 * This shall ensure that the power and the reference clock
 		 * are stable.
 		 */
-		if (gpiod) {
+		if (pcie->reset_gpio) {
 			msleep(PCIE_T_PVPERL_MS);
-			gpiod_set_value_cansleep(gpiod, 1);
+			gpiod_set_value_cansleep(pcie->reset_gpio, 1);
 		}
 
 		ret = cdns_pcie_host_setup(rc);
-- 
2.50.1


