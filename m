Return-Path: <linux-pci+bounces-28709-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B3AAC8CE6
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 13:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53CCF4E6020
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 11:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F2F22F75F;
	Fri, 30 May 2025 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="GOVGmP3u"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B13522DFF3
	for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 11:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748604005; cv=none; b=UnXhTgvNrSBQEUMZLgs1TF/8hziacAT8/tKT3M0MOfgyyclyS56C2OVcipJhYKnSH1bRV4ReYLqQBOsv759k5MUVQEEnec7fXK7TFJTIPqaEoOXLpf2V1VHF97bQEX7D/qpT/SBXavt5Wzdiznm9tHngtErhPt5KR4zzE9HNDEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748604005; c=relaxed/simple;
	bh=PrFWTreIuoDsO+2dJtLRS+p9byMc23RZOKSzUzdjGdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bylY3z0ENkCk1b6RVZyEJ2HCS+z0dh1K5D1O21L1Ym3PtV5akS9JYbt3oiKdAnruCoZPOwdve9jq37zJgSLOPQoFcIRK3AxmjMqRj3o1ZDlLkbZQagD+pst1j6CJYP+O+Bg+5T9WZvRE/21m9Jl6ncCyMZsg/wBXbG3eRct21E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=GOVGmP3u; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-441c99459e9so12417915e9.3
        for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 04:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748604001; x=1749208801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBGOjaATHiERWGlVICubjqS+hAYT10Q+U69oOw2FjwA=;
        b=GOVGmP3uTCvTkrkGmlk9XlPB7Zcc930lljqJSrcMoFR7ic1xGAqzYavWil06zi2mGv
         1+znsfSXNcU7BJdpSyWPzNlI3zsvNGfqfG1egeCbwtHmYcUwu/fIeK31Ua4pX19r0pSt
         GzYMBTdtRApDw9syaQcsooIxlWBOkrDJbutynG5UPmggQYjozAcfe8SMm70h1BvwLXm8
         Mf59w+tm6ZvJ53Uup/gg++/9hs1t9eiq3JbqC6FB2OM8OwSQK4YQKCAgWLVwaeCbNsoV
         MYvPkFsUMMzBYUFxtkeJvqK1afXhptMDP8zwwSr1WW+9ufSbd+O+EiLGeIx0D7ayGauD
         7Gbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748604001; x=1749208801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBGOjaATHiERWGlVICubjqS+hAYT10Q+U69oOw2FjwA=;
        b=uayKdsqINe52NvxeTr3vYntHj7lgUrD9Da/g3Hwonc83q/5NwJvGHH5mFIinrXrSXe
         HI4PD2oGPy/Y/Ufk2q+gUGerUizydo6//KSGtL1rvTUKhSvqdOFWVNWu5gJg3N7jg5z2
         EhIkRjwZ9TfHYoxfH1rcBO+qIrNRWCKKcF2e+CCYg2A9W+w08786ByKULtsf8s8EEgX4
         xEv1+kH6X2LycK6eiHTnEq66fcdUg5GxDrQsDABdPsRPYkEpJ0C+NZCuDoYr7sngsRDL
         /jXRGvV2r2ZwgIA9SIqwzsy9cHScG6o8Lm1vb1SGmpvi54AmlrhPD1MJiHTY5/lqoKBn
         jyXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4/QKuqSmqVDSf7zma0Q8s6CX+w1FulZzLRDiqa184SgC5QP17KD268f0XpaobHlm5GI2UvboMtO4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9474/qhiRwvIFeoi3KeyWGs1QMf9XU7kvoQAw18+vGEShYgB4
	bYZazUFEY9k3aPLK4Ct+3upEVdl+gRq0kcRXPXLJkVHDCVim+R+ppXGjL6MbUKeqLNk=
X-Gm-Gg: ASbGncvKo+/Tw2OjZkg9CqX4z0muxzPbpacM1KGwnLGyAdhu9Ojjr8Nce8Dpt+aZ5rl
	r39sON3qDvpqLPNoOsIdHPLnjN7/KWabJyeHlBw2x9RgkJrUJTUVcyOsexo1SxaXSlMt9g7htuJ
	j9VnSQZIpUlFKsjyC1N1urVf2ZQA13hyDouCRRs3C2o04Wr80skV0u5aeVAIx2wrj1UUGuFR/ql
	IqkhS9720yvjT4m7Yrtz4o0eaAVpKk7HHRwK3BhVuAsiKrvTdfJgGzxKyF/+zpbDrdOByDqM5A8
	UR4LgbxPsncTmWFBMq2IUHTl7uRfATX4AXvfyqqWNQAdorWhB9voHGTgyc5TpVctuo2mugqFhPo
	+BCfN3g==
X-Google-Smtp-Source: AGHT+IFOnZeDzHLcJzr2XiB1V8TCQqZ4gnYI0oqjqw7IlK2qZ/Smc3vbO5ZYPTsUQejGYt+DG3ev/Q==
X-Received: by 2002:a05:600c:1d99:b0:442:d9fc:7de with SMTP id 5b1f17b1804b1-450d6546354mr24484345e9.22.1748604000826;
        Fri, 30 May 2025 04:20:00 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450dc818f27sm3986435e9.18.2025.05.30.04.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 04:19:59 -0700 (PDT)
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
Subject: [PATCH v2 8/8] arm64: defconfig: Enable PCIe for the Renesas RZ/G3S SoC
Date: Fri, 30 May 2025 14:19:17 +0300
Message-ID: <20250530111917.1495023-9-claudiu.beznea.uj@bp.renesas.com>
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

Enable PCIe for the Renesas RZ/G3S SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 897fc686e6a9..3274d14421d4 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -226,6 +226,7 @@ CONFIG_PCIE_MEDIATEK_GEN3=m
 CONFIG_PCI_TEGRA=y
 CONFIG_PCIE_RCAR_HOST=y
 CONFIG_PCIE_RCAR_EP=y
+CONFIG_PCIE_RENESAS_RZG3S_HOST=m
 CONFIG_PCIE_ROCKCHIP_HOST=m
 CONFIG_PCI_XGENE=y
 CONFIG_PCI_IMX6_HOST=y
-- 
2.43.0


