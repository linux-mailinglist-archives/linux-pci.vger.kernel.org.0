Return-Path: <linux-pci+bounces-31543-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEDAAF97E4
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 18:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29CD74A271F
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 16:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D042E0928;
	Fri,  4 Jul 2025 16:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="kNsxm4aQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B572DC358
	for <linux-pci@vger.kernel.org>; Fri,  4 Jul 2025 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751645695; cv=none; b=J0BR850dVx5l4ZL66eTBDvV1TNGjEvAB5zCdkGR77HgxlQjZdMmftEShhsdvS8Y/GHUlXPFQMKBXenAmb0YWtIpa2Fg37mATz5TncEEzKFrrjpHFOpLGC7E8WZ0xKQvzdgrPMmhGEPH1feObwzsk0cZ7NDO+n5SVWfbp+2ucOLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751645695; c=relaxed/simple;
	bh=WguPuQh3/mnSf62tuhpCluxDoAVKFv7lhwgnIqAg2mA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XCCjgO1lyJYOQEhkfuYanXICWom0Plt8WSRi7+UYmIy6nmmCSwlew3uziuHNPv0iCrz+7GDUZ88QKV9RVP/hgRZjt3dKNvRuWOIIoAQ1BCbJlp8Z3cvAAfftybzLlAYMK5GcSXri1P04Rih7abAxSvZsAw1ugr6309QEAT60C88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=kNsxm4aQ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae36dc91dc7so187486066b.2
        for <linux-pci@vger.kernel.org>; Fri, 04 Jul 2025 09:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1751645691; x=1752250491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDg1DpjdtfK3/pj3Ed0aWvzIW/qZbuuI4Dyv55kxUjI=;
        b=kNsxm4aQzR7UeO/Sg2pPhSVSa/aBvxxcStZmcjSqc6NnX6y3RNzAaB4a45xbKHnCl6
         OjURboHgmHjDqY0UcT2awnFZGMJTtMLgk4gziU9qQ1TbNb1ouWGsB0xtNEBHanWq6CCF
         q/Y79U/XX6PK15ZK8mFb2I8UBmyDe5kH9xPMaYfoTl4Efw+y1mwOm8Q7wIfxYRT3fq/E
         E7AGP/eBjdDMmFSw8+yuMCJWyTbqmGIoBpk47m6t+rDEJKGFXtngaFACVEuEICuXj/rC
         bEI4NbTz+Aq672q6ZUiVP3nJCUIDvcghA1Ta/+BjifYq48r7l2WRJq0HWJWH+SJ4QjYo
         4GzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751645691; x=1752250491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDg1DpjdtfK3/pj3Ed0aWvzIW/qZbuuI4Dyv55kxUjI=;
        b=mc2EGPJRX7Nzz5epdCJHwCeFFOFEyonWWSi9G/XdBzWN6TWjlL7mE7WFbjHLJNq65h
         a4O8nbcBAOjX3eXFseJeT9MVOhBUSdqUzefYbcoUdxpA0tF5afKkQGaBDHg543jtEnwG
         C5Xb2JD+VfDYNdvSNdfeiCxDyOopzEV5+D8qodlAOJUHAEQGfUpOU/MK+yp+DOqcjiOB
         P/behi5QRt0oQFe8HB4sYQnCxPEX2MJCfB98FF7rDu1n5kaD5zBSDD5LZqqA6BXpl2yu
         ihyM170NqXw8Xb9OrCWWWQHmJL6Rti9TN10BExbU2xNBcjcKxMHn5zjIiPqZZh1RYwKe
         WOPw==
X-Forwarded-Encrypted: i=1; AJvYcCWxgm0kjhPN/Qc4Dhk5QyM7n8lAoF5fI6RQ/jzHXxf2rhGYR5sEBQdPN7YroaWtX8Oh6mC3oK4gH0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0sP+kv1lGoSoUjdMD67D+1TRp7ckOJ1sk/JAucjSlZriQcUxa
	4aPC1GBbculvemoLDZgZNxRKdpWwcSGPpDIm2bq2qw/hqCbkyiLIcrIp2HsdSv3uwnk=
X-Gm-Gg: ASbGnctLnTdA5zlV3fPgj8El0pdjLDt+qpdfsmJYlj2octxb4rVz5kD/+UrsBMW5xf8
	ewZrvCwIakE/YlosOo/Mu2dSlow5UFmpKFxQa3/ZD7sSwaa3nZKP2OZMm+Rejh1btORqPvN2d+i
	ZQCPdg6NklN7npdZv0vJ3CPd77OKtMX35I20eVTUGFXwmkmHSTySe9HBUWsz0EHR0wvnky4TvZ2
	tlOqBa5OJANo+huLWl6nbKqmPBi1x8zdCBuxtu/Jp9+KZZdnI/maMQOPMK8piokTDrHw1FYlDTS
	aQYGfWPloaW5Uptzokb93ns2fqUy3fOiomKKp+vFO2fTYGXog2ejd7oTnZuDHxu9ygk7j4X/Q1s
	Qn9m4ckCgCkCKNDg=
X-Google-Smtp-Source: AGHT+IEZfr0ji4LDK9KAfq64DmhYMTWRTB1pQDXq1rT0Tuj0QwG5y9ROAnPBq8wcVt6C4csWmuVLvQ==
X-Received: by 2002:a17:907:9621:b0:ae3:a717:e90c with SMTP id a640c23a62f3a-ae3fe695451mr259268966b.23.1751645691353;
        Fri, 04 Jul 2025 09:14:51 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.83])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f66d9215sm194703766b.2.2025.07.04.09.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 09:14:50 -0700 (PDT)
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
	catalin.marinas@arm.com,
	will@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de,
	lizhi.hou@amd.com
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v3 8/9] arm64: dts: renesas: rzg3s-smarc: Enable PCIe
Date: Fri,  4 Jul 2025 19:14:08 +0300
Message-ID: <20250704161410.3931884-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704161410.3931884-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250704161410.3931884-1-claudiu.beznea.uj@bp.renesas.com>
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


