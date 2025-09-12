Return-Path: <linux-pci+bounces-36018-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23519B54DAF
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 14:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92DCF3B3B69
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 12:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BED30CDA1;
	Fri, 12 Sep 2025 12:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="aH87gXJF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA2A30AD0F
	for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 12:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757679902; cv=none; b=rQck3qOyCGSqNZimRk5CtZQTuMoGeTQGUzCWoO2rsVFanjJDFb9VckI+cm+6/2VxLCyxkA2cDoxHAT7xlXLRT71+ca4jinfKB8MRrWTBXetJUvJZo3uQZokRFjfxBzdKl1m9qmVaNZbSg/djW5+oj8tqTQzFsQ8njmvHIXu4Erg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757679902; c=relaxed/simple;
	bh=i6Ot3jDw1L8DR17nkHbO7WVOceauyHOBMPobzpRlxUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=upOJ/eHyuME3v++ocTHE06hwLYg/iKSoslUB4qYmLlusLYKq0XikklvleBeRpPoRpkldiv1TkGUh82BhxvSjLyJHsQD9Y4xKlrbTXyitgmKOszENG7/AW0LIOdR8fmel++O7ZRJkhj3iKBbh1FqFsh7ZYpP5bqwBh7yZwvAjLa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=aH87gXJF; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3d3ff4a4d6fso1458088f8f.0
        for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 05:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1757679898; x=1758284698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avL90xLT3GgbgtC/IjtA6tdWsXd91EIgkF2HC8fxIi4=;
        b=aH87gXJFxVuF+DTvDTUuuO5xPw/841aAxVxi+MZFn7PpFnlIe8Y9LmBideL5hk9aSz
         Ij5Ot8GOXXj2yTmbi7lKZZX6W7ggoeA+GJyb2epH7WvP9fQspSQltau0d2ye2X9BCDaa
         f7i72BH7Mro2+d1M1wSkbbVGdXDRKvlapW629reyobEy/Xjvtl+TFX+sVUl0cySti3Br
         BKBqdlTiyjvvAUjOkJg1ZAh2kL2kqUVCZCOOP7sPbAoiUlznD5K/WMnZ5r/ruwylQSil
         ww9PrsdIX29iPOeuPWSVcI8Rp7NjEZufJNWyOsK8OyxEBW6g8FWmFIcd01uqXNlbZNfX
         t+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757679898; x=1758284698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avL90xLT3GgbgtC/IjtA6tdWsXd91EIgkF2HC8fxIi4=;
        b=l8P5JS+Tkc2DclGMsc3H1CqzYz4A28bHrprdaFlQrf9hIOFJxvSmFWg2LFkgftFFYy
         NZTXLYH9nvrNDqElSqOaOiFvHW9uayBujVDrxGFxR5cuLOBG67fGvFZui9I9fT00O6nZ
         k3AclO1VAgGfgKDQEF6hgCP2xcRGQXaqvQGcWrFCxzDjIZ/xkwzTurqFFyRrI14mxTrI
         hmdmTErlQYrik+MnI1syRFY74jrPvPh5Zyk+Y32OHuI1geYl909NcVwKRaT5UEiPKN2j
         7n9kcacioaD9B9cN46/CkSF7Fvdbahu2KodZwmMLs8kFiNg7IZn1r34Ol6VWByMEsH1X
         Zrew==
X-Forwarded-Encrypted: i=1; AJvYcCWbsWkTuACzV5QsfvcSQz0yuSH7SEUG2/J2rkCLt7UOaAkB6vhtnu8jWzd4NxELy6e1D/BtFsDCvDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO0H4Bp4yorVj6NmFW1Kffk3jE++vNMWPfVg6pFb1j5GlPjguS
	b2smebYj0qSNlozN5ojls8LxssayyyKXsFLKqu3PRDE/WiCyihr5Ksc/KHEv9BjPoDI=
X-Gm-Gg: ASbGnct5XqpkwsB9R4oO0WMjxGkz35NXv9XdmzEaKbzOYI6eBcS9vowXx3pNZfzKAnc
	bwhJDY6WzT8/+W3cI288MAqAXxLSWuaLISOzSlXytmOsfq6gk0RR6P3n/O4ySqyp1wzLsbmGdt9
	Jk3fFPtgPvIuNz0vn7Dtwb9NOV0UPYaJoWw8o6FDOEzQaivHVPCmBev+N+7EtQjHdgIwXvwHcwg
	3GhOXlrxz+RieGzd6H6kF3LsyAnxEbdfQwZxCI3LVfnwddnoyR5+qQjWim5wqSCXwoug7FWU3D7
	ubUw5iaVQTJdPmkspfLJ0xZ9BxDjKwkXnQmTNdWWObAWu7SiUQG/DqFRDw1zcTOdaUvWaJW5GP7
	8783RIiiE3uLbTY/2ZU6u6qinwkG2/qnGvfAOtsexEXnpuqkgaTQR0mcWFRBzqoy0sIVja+Hg7A
	==
X-Google-Smtp-Source: AGHT+IFZ2HQn1VMUOUkCZ958fnWk75/NfdzSXgcuOqPzgMCFK5vrPSZLKhjqjU2vU8HEUNdayX/ynA==
X-Received: by 2002:a05:6000:186a:b0:3d1:721:31de with SMTP id ffacd0b85a97d-3e7658bc621mr2735063f8f.7.1757679897904;
        Fri, 12 Sep 2025 05:24:57 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607770c2sm6320091f8f.8.2025.09.12.05.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 05:24:57 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v4 5/6] arm64: dts: renesas: rzg3s-smarc: Enable PCIe
Date: Fri, 12 Sep 2025 15:24:43 +0300
Message-ID: <20250912122444.3870284-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912122444.3870284-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250912122444.3870284-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The RZ Smarc Carrier-II board has PCIe headers mounted on it. Enable PCIe
support.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- none

Changes in v3:
- collected tags

Changes in v2:
- none

 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
index 5e044a4d0234..6e9e78aca0b0 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -132,6 +132,12 @@ power-monitor@44 {
 	};
 };
 
+&pcie {
+	pinctrl-0 = <&pcie_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &pinctrl {
 	audio_clock_pins: audio-clock {
 		pins = "AUDIO_CLK1", "AUDIO_CLK2";
@@ -159,6 +165,11 @@ key-3-gpio-hog {
 		line-name = "key-3-gpio-irq";
 	};
 
+	pcie_pins: pcie {
+		pinmux = <RZG2L_PORT_PINMUX(13, 2, 2)>, /* PCIE_RST_OUT_B */
+			 <RZG2L_PORT_PINMUX(13, 3, 2)>; /* PCIE_CLKREQ_B */
+	};
+
 	scif0_pins: scif0 {
 		pinmux = <RZG2L_PORT_PINMUX(6, 3, 1)>, /* RXD */
 			 <RZG2L_PORT_PINMUX(6, 4, 1)>; /* TXD */
-- 
2.43.0


