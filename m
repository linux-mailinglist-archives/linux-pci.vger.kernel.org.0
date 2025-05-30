Return-Path: <linux-pci+bounces-28708-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A02AC8CE2
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 13:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15AC81C00930
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 11:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFA422D781;
	Fri, 30 May 2025 11:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="c1qOAHoZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE6E22D9F9
	for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 11:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748604003; cv=none; b=MNSCoQbcwfMeL/Xkc0q/h9RtWgL45/C3wxWYXnV9+Vw5/U7OJoWk1mrBj4r+pElSCAgyuZHJYQkciRn06OoT5iZhpXyP04wSxVGcSZOcR02LvWnDeNEMoL6M+tn/H6mH9m5VdX/1AeYMThRt22LFBIksEDpoUXWNLHZcQtLBkWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748604003; c=relaxed/simple;
	bh=cJm/K+5ybBRW7zIlcZTsIL5CDJmvxF4XRCkMKcNx2xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7pytM2S8RdpJw7GEH9WexbBWJ8WtOdxpVUiQrSXt8DbNZEPXGjXc32dTpbqvUpMl8x+JngDUXuyk3CcdjXoqtdoahVnxd1WJVv8fSCSmIChyaqN2+GcBtRChs//E6mR2UgXGwVIGF9lL73uSQmnge7fWi5SecRHe1HbpBrBlM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=c1qOAHoZ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfe574976so15302725e9.1
        for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 04:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748603998; x=1749208798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvGP/3CRa2t4gXiy9Fv9ps8S84kk+BXASAtnC9F87rA=;
        b=c1qOAHoZOali2+86hu4/HQqGYiUOBvUVfixgoNaMCPswQA1v/JRhBa6S5OcrnWAOnk
         sReqUrPuC/e/CJg/i7YmqrkSrA5EbILVgatmfypS2pop+Ei2vVrj7Jm5lGqD69V21iVR
         oBwaMNDMUOa+6aiaW2eJhdNj6X6DMzkeAe/zkJO0FWGu0tWGvK0WMitc+ELducFYHjDw
         +l73YQwXHH15JKDMbpE99E9XpRAvT83YyjDTByycnt8L02fUrstuvxs+RXuTZnh9OPIJ
         iEP3MXMgDzwgp95W3waajw9LtPSVUdeShAbuo6K7yetj0E/vwaky40S1Mo5BPtJQVrCw
         GryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748603998; x=1749208798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvGP/3CRa2t4gXiy9Fv9ps8S84kk+BXASAtnC9F87rA=;
        b=QnbwlGiHQKmOX4NnVrxaZL6qNvnhOsQ9Kun7ZuIrMwQDUMsni7l7U281oSIOlBMTku
         AwXsbsJdAgws6L40hUXmnHpiRGKwF4Bji70WqWyNB/2pfKO/4BOAeyDATQ2gYEvjAxao
         1QX0rGdz+rFHJ0J6xpYO2yE+dMRq3mlXUFv2JWwG0GCf7osrfYmUmokZsD07OvwsS1GJ
         6/Tr05Qs+d2qXc7AU1KJrUNmGLeUA7e1n3V/qucwaby6RSCWog14C9m1rKAhVuQhexlX
         oyzgL9xbIP5VY7aFPbV6QFwZbF5kWTrHZbTpRHH45QVafDoa+Vfs63moyNr80wcI5bOq
         7buA==
X-Forwarded-Encrypted: i=1; AJvYcCV2/PaO6VhknUzKj308Fx8v6M0oKEXFTc7tYvHQc7CKguT23OX12P0DwFyZPq9Vnc7Rc38H9O7CFG0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp5VpAvGUgI/ZXtesZpHCthL8PjWZkhIOGLj5XJ5lknV1NQG6K
	bIwkwJXhzzkONHMQSGng5R6YHUzcgNboh55zOtPmLbeF0jWDgFYzw/7l1CX/OfwqX1c=
X-Gm-Gg: ASbGncsIKIDIfZ3n+j9LChuH6MclOuumPBQPlDI8GEgQOcD0AQwjUGRwlL39uk3uZ13
	261N0o4Z3Q7NvsULo8uo55CLROgQnr4hJdnvGivaxIOpkct2/ShhvYXwjl5veHqdF8WqiLgpFRR
	1Dwt48DT3MyeM89REwfbAJUZEdOXpW2DKebHA3pEIy4CO5KzzWPNLuihBL1lG6dzzf8tGGqf/J+
	zQnkw5tTH74FPIy5sOvKfoMOhCccouaXSGJpv2o27PThLuU6r7lQX8347moPna/biUcGtYUmOKR
	nBE1nBm9bvvTaMJHIRgyHbkN/yeD/ZFzOHeqq19KOwinR7FmP8lNCUwde1yBT3OoEPAnKNRkXDS
	zTtuqtQ==
X-Google-Smtp-Source: AGHT+IGxApXe/sZJcFH1MLc5rJG+X9SmRJKeviScP7B6tRgI49wzs/sJ62PD40lFB7+X06xl6Ik4Pg==
X-Received: by 2002:a05:600c:3582:b0:43c:fbba:41ba with SMTP id 5b1f17b1804b1-450d655b02amr21460665e9.28.1748603998156;
        Fri, 30 May 2025 04:19:58 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450dc818f27sm3986435e9.18.2025.05.30.04.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 04:19:57 -0700 (PDT)
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
Subject: [PATCH v2 7/8] arm64: dts: renesas: rzg3s-smarc: Enable PCIe
Date: Fri, 30 May 2025 14:19:16 +0300
Message-ID: <20250530111917.1495023-8-claudiu.beznea.uj@bp.renesas.com>
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

The RZ Smarc Carrier-II board has PCIe headers mounted on it. Enable PCIe
support.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

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


