Return-Path: <linux-pci+bounces-37670-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F025EBC1861
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 15:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1C794F6352
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 13:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A052E283A;
	Tue,  7 Oct 2025 13:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="pNuHoK4E"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB352E1F0A
	for <linux-pci@vger.kernel.org>; Tue,  7 Oct 2025 13:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759844246; cv=none; b=M9d7nLNmx5pmxaohF49Z2i7rT+sCGkQUvbHQ96MwRxDzLRp+HUEkjwQ8F9MII38xhF1x6aeXWykQowW4GSDeOy6RaghKWJO8Y25WGyG6iScYIpghOSlJkCOmDQ+mHvU6uk0nIn16W3V0XANFm45azQ4KcpPzvkcT1YUuiqkJunI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759844246; c=relaxed/simple;
	bh=cUxUchjJqZ9HGjKYpIlmaz36YSiv2DD5GuVZNfeSgh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QBZApPHJv3CiwQpGau0vM30eaNVmxYNS6tV79SgNLiJv7ERFp9WmvfC9n1jvjKTmDzyhWYXLViP/SQHnqPis7du5p43dtVnavMkmaw1V6PKycZeTYlFQKX6qz5QuN9iNrRLHAGzGmyZy/EOtHjHsNXVQRIwCi5pvHEy6u3kwip4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=pNuHoK4E; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e542196c7so40806885e9.0
        for <linux-pci@vger.kernel.org>; Tue, 07 Oct 2025 06:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1759844243; x=1760449043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4Id5q3wpF7LlskwSU/49ZXvfSykXZK8zUhTZu5WHtk=;
        b=pNuHoK4EaRV/YIqIh7eTgA0XjwgLnjhO/k6vNEEa+VqBj8DFUEo7zNeAfttkXOLbkR
         p+lS0zlaf0OE54dyUXn7D9B4Ze16kfDzUUg8x+sJheR9ZNrbOdEQbiOPyGEusHzReToB
         Pu3Y5k6HYn6sbOuKKynRdvW+WKjdwlOPlG1ryz1sjoX+asLgWh+1hWrd5U3zRvCR5wCc
         BD7Wy0PCgmmeS12YLWr5qucb0Spy8eLEdvAYKjWdS+WcjpRUMGEk/tjsMvJxmSYMmugp
         2KdEhhE18pEWqVhYfRn7WrBgNs/MymrvNT4iYnEsBInuwL/MUpHtVErR+OMoug51B+7J
         cprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759844243; x=1760449043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4Id5q3wpF7LlskwSU/49ZXvfSykXZK8zUhTZu5WHtk=;
        b=kCkwCzuBWb9g0hSnGkY7kOiDBX6y9UrU8RzWiKUeqB9RuedlYX+HzjOtvE2AMTjHUc
         6g1xfUPGHzABiXz1xo/+9OyyUnZtLmVBLwrCDaNIKkmAEKT0tOAEC7CWz3CeffJCxNv5
         DQDeUP9/afQK23QjR1baMXLXPGXJK9zHvDw4hAX2RTH8bHKQS1VrEfAclq/+sjBdPl3V
         AdSUiPQPjXaxyt9STbIICt40JFtVtjDp/9bKIbnkvL+YjVJXOoTi5a2Avw36qcb969SH
         Hbj8qw+c3Y5DWHDq5zirBMvtPHhlbM9jdXFt1yewUCewHtHI0VR+MUjVUY0M/ne+81c5
         oxdA==
X-Forwarded-Encrypted: i=1; AJvYcCXxTqeMWSTKLE6Jv7ay7YUMVad+6yRD1+FjQVDJy2csu/wyy9fMTuc9Ej86/+JfPHHkW3D7piYL6UI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXxfqc8d/GxhMduH5O4BWbf3d7NM8kYEnkQBB6IVOF43OTBMVq
	9k/csmO2201kgPDzy7yPlWOB/2HppVWyPnGutPMbutNSRA14uzrsEml9vWz+4oHZfFI=
X-Gm-Gg: ASbGncvD6gnM6EXRDgCT+/OMPgc4LiNWSMkkwA+8yWEemUpzrzMoElnulpFR3Od1/0x
	/YNNZdActNHvKp6sfodQ4nu1DTRSdjE/UYsPD7et8EpWLLF//gKC8VbHG0BJEEq38jkFwBJtin1
	3IhzR1FTUcdLwdTLA021xk+R9gjcdsgfIzax4DuT3eAX14lzsgw74AGJDntM04cmaWnQeMbzxhI
	Ne3IaUf6UgvP+JqH4X9u8E+kq840cSPHYsr9s+KYrS3DPmAnF09SEl9UTrbDL5VWx39a/GPlm/Q
	az9V8L4GT6eEyo36w3soTyN7r9F1aBlVZxmo6/cn2o6NWXqxqWD0YFC4MCDn1pj5/ACr3DxC5eI
	H0G/6YjtWW4MYv3JVdrwrjIzu2/UkcPPD
X-Google-Smtp-Source: AGHT+IF5cwjJHPiY/TZQqHJWoOYv2ZL9F/8mleO3QYxLBh5SCar5Iq8CK5vEUS5ZcoQX2NAXmukRMA==
X-Received: by 2002:a7b:cc06:0:b0:46e:7dbf:6cc2 with SMTP id 5b1f17b1804b1-46fa296e763mr15549145e9.8.1759844243119;
        Tue, 07 Oct 2025 06:37:23 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e674b6591sm272189625e9.4.2025.10.07.06.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 06:37:22 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
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
Subject: [PATCH v5 5/6] arm64: dts: renesas: rzg3s-smarc: Enable PCIe
Date: Tue,  7 Oct 2025 16:36:56 +0300
Message-ID: <20251007133657.390523-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007133657.390523-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251007133657.390523-1-claudiu.beznea.uj@bp.renesas.com>
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


