Return-Path: <linux-pci+bounces-41644-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40051C6F719
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 15:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E8254F3077
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 14:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACE43A9C00;
	Wed, 19 Nov 2025 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Pk6IkX/N"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4B5365A12
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763562955; cv=none; b=iYOrVqu/83DDSqyOsg5TY4Gtko0yi0xgwUGUS4qehjAJopld5vBdr2yh2flTQ7r1H9JoLJquMxuauBb04XWqZGDtltwS7+wt4Oe9q5ltNhTeMam2rnSO5geTY/O7XKpdMCkfTyhX7rTE7ksigP2Lb/y0JffXBm84KKEtO4ikdr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763562955; c=relaxed/simple;
	bh=chd+bQesJb2L3x0eNh9hGNo1sfJ6ukKT0DUAGIoBLX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ed3WXzRnWaN76w+2+dQQbSQzpW70E1C3iZf4ppaEX1rus99ffiKYm8x6anlj+gWA0pDr8Gh2c5XxEcQW6szI1Fi3A8pP3biWZ+oF2vas+Ml6CiJX7n5LvOw/SrEYpFJRLYpmrtZSzmpZ0qpa4LyRAXxlCAgBzG7Yv4fTF2NL8zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Pk6IkX/N; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so47371265e9.3
        for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 06:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1763562952; x=1764167752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1SxqpFp7EveK0lxmcv0OJIyPAs1tqhEaS0Hczva7EE=;
        b=Pk6IkX/NNOHD+z3yRwHcEzI6d02PeTV7t8k79ZT2HPE/enOPDDSqU4L/AtSSHTV/e/
         bweDHo9SgNjEqUR5tH0IHOSw/JbpVUsep4+iKHz8hF0MyW1Sxc0YP3eQD8A223NwdARx
         xykiP0ET8n4x3HmhIKlpi2vwmztqH9rVY9DxXMYp1+u7cDFx8zQWFrWOEIUDEo0BcikC
         xb+i/aFgwwUYyObWxJ1BLwIu0I+VSDpMm1/9Cre08eti/YvtA9DWqtlDMpL87uBke0x2
         ++5uTzxOwf4jZx4LMYIX3qZ7zbfaDFXQLyhrHCFzfY0VTPzhWVPSawE8n+5neu3wDkDs
         pyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763562952; x=1764167752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+1SxqpFp7EveK0lxmcv0OJIyPAs1tqhEaS0Hczva7EE=;
        b=oCnV5AziV1iGAIwOSlOyUDuP71W0gyvrXQlQfzHlQnG+YOu2xLZs1mYELW6hGD2ZOp
         45siyAAAXHrtfuDRx++SbDsB8SQA+hhxgLzaQF9UrpI/fNosfIMcCAb7OM6Fuazwb3/e
         L1TKLfCGN1WwzxkFghxFMYWhGoOlQpYetYlYtroGSbNR45DuMwiY51RoqlFbFK2xgpuq
         wYNkdpyogJYi9LHFppw6YZeHnIED2uCREsIvjcSGMkQinos55YGJ/NQadCLDsPR1cvl3
         loiKdIfrpKGB8qr4WW026oinaz7COP/9hnEGreoePaLCCE4jzXH6HOs4962zbBNa8dC5
         X1xg==
X-Forwarded-Encrypted: i=1; AJvYcCVHsBJvEXXh3yfig2qwVCVsam7pFpFu7eaNMASrv/mWX2MqK8TcsA4fy+bYOUwgM6UFd9dhVN+mOuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOV7BKSQEmyLJoGP6GCnGTVqLYiyfGVIP+RcgB+SzIIBY7vsTa
	PWc9zvW50NW3RlbnmpLp178x0i0dv9BeX6KhJNhnhtdiAD5oJuiQNvBXNNdbWUCoKMM=
X-Gm-Gg: ASbGncuJsj1EDhKu+uOTB3IENMC6100j7+UBArRN0UM15lKoHKGuTAfJM8dX7NgpS/l
	zA4bi8QS6GLIaL+/ivZEX/36IFkEBMyY40zgFgGMYBtehZFLCj5DwYpmAxondo2lfTN1Tyug1Oe
	qgmZUjxO/WY7KNbYtpcBDExEpC0bdlagToIyVJtlTlZ6zJbPXtWNMJQXWajUClgQfkmK3dxpzel
	fxQP/7IfKJtiYvUAJ0pce1HSC/VaKyq9FwWpny+dD7AfIPqLgZy69kNo8qWB5yUZmT75pA3yWmS
	8ypCUQxQttTFUdbyT79WdwM3WbhlbZn6Am0eb+9o6UAC0b5ztNHJHWTzlyroBOIRxsG4YQVO40z
	14EJrbfWKXpt8ZkLVjcWzNfEyG0vigHvs6d2+kLMcqpcfdI3fRc3lR0D8xsy1Pn1uoNcYc42/LR
	T6YMwzuj89Sny/gPb9l/5bIAD0XODApGmEe9eXvLpl
X-Google-Smtp-Source: AGHT+IF0e9B3ky1biES/Rv32imPBPNDCYeycJDEm/fa0WjGwv1dIJ3oB+znuXn9yZSJoHfPlbXgr6Q==
X-Received: by 2002:a05:6000:22c2:b0:42b:2eb3:c90f with SMTP id ffacd0b85a97d-42b5935df10mr17441813f8f.10.1763562952459;
        Wed, 19 Nov 2025 06:35:52 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b894sm39973399f8f.26.2025.11.19.06.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 06:35:51 -0800 (PST)
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
Subject: [PATCH v8 5/6] arm64: dts: renesas: rzg3s-smarc: Enable PCIe
Date: Wed, 19 Nov 2025 16:35:22 +0200
Message-ID: <20251119143523.977085-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119143523.977085-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251119143523.977085-1-claudiu.beznea.uj@bp.renesas.com>
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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v8:
- none

Changes in v7:
- none

Changes in v6:
- none

Changes in v5:
- collected tags

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


