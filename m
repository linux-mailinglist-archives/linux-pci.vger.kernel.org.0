Return-Path: <linux-pci+bounces-41371-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F81C63180
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 10:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 148CF366A63
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 09:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B54328B51;
	Mon, 17 Nov 2025 09:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="H+qG/l22"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AED1328271
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 09:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763370576; cv=none; b=Tvjg7SsUOxHzfrAQbYXyWHq6WxdpoE81KWp98RhYXLvVYfE5wF5GCv6/t9wtxjoNieLhhWy/Sgo6AsXpqNxqydLqhWoMN7oWwTkotWo3GN4AP8viEu8fbQixwY0XdvEP2DRyGTjPJuBCVhQdI+M7cCCREo4vy0b7WN6i06ENiAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763370576; c=relaxed/simple;
	bh=pBI9Hfqe5p9fGS68LNRQ7CQSWjqbWO5yp00qUZ+NqIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O447mcM46m684R9dATb6YX5jo4WhYuPQV8qd9QSFAXkDnObFQW5g3pJgUM3QUZA1V3yz2OtJhcAqX5giC3Lasxd3HmcY3k3FEWhjFHJj+B3KfW6c52FjD+4ggCKOTZ72sm68V541FyiBg41u5zOKgV8tfW89Ej02OUJwes561uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=H+qG/l22; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-429c4c65485so3354419f8f.0
        for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 01:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1763370573; x=1763975373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfjHCPFht8CT2aoSmw57+NansBy7QzrkmQb7BflVv6I=;
        b=H+qG/l22b4JZbkL7oxSdtqIh3JpNPts6blHilsTw1zyrY07PPtSZGG1hj40JmMqt5h
         z8+aObXIUaGrPisd7rT9baIMttaff1ddW8hYf5hbVuzAMf0jZI8KXK7yB3WNS62+iySS
         HWUcIZ3XPnyWnDSdTZA1kW0QOiOwoJ1uhgpjWDj5CpYDpSE3P/U3S7osyTMgwjm7bKdc
         q/Fz1M6Cvu5VtfSxFq+VgGSWfmSThioi/fzdMstVihNDPg31SIdoEFVvm7CxogaMfLKB
         P3aFJghRHEMV4iLI6mwhK34VjFVQNKAUXwCCN8iAnq2nrHzL618CpQUhbcbAQ6H/i65m
         p11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763370573; x=1763975373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nfjHCPFht8CT2aoSmw57+NansBy7QzrkmQb7BflVv6I=;
        b=t3hLhJupaOep0xhBwOWo8zrJav3p0+SHEza5LplOkHiO22tNKX+wbj+ibbyBrunzU0
         9Rt7qLPt/ETo248QmUyveIB5lJX9qfQit3qi2jypR1bclsNHeVBp3u3z8DnND3P55c/L
         4/sTgTOo0yfPC+UECcYEncHPsKeejGQHv2bpLHfP8kZTBcL92vphbTG8DzVrWPICNNFz
         yq8EHlQ0X/b2R6CeAsOU1dvU0L+16YRG4ZgaWPOxEYvFqAA+CPIhBgx4FpSQUtJGk1Or
         4C7hOJ/W1fxM6zcAu8DHOaKxZN49qz2qXtyHf5BGPCcn/6FMPhhx1luKlx/3oICtMJHC
         xFMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm2pCWHjlqgYZB/HCJdJxt6EZe9WIUjqs2L27QuyAzUUuD3FzkWI5pFgylya0MUtnD6g3CWVXewj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwObvrbGx1d6JyIEXg4g2HvGqibosZ+HLYlAdfjmxGvoeDyWWih
	xwjVNsGRrLfY8stiEUhjDirHkp/0FEnKEeSoRM8vZugMOn+biZBZD3C25i/LjVeDeCg=
X-Gm-Gg: ASbGncuvZrsAepcC67VElJCL0NTM7vkYA2DUFJ5jmk4zi2xD0O95ULqsQUBEQGcfr9A
	DMmBcA1qpPdpncKWROeCZfbeETWi1LD9e031S6HU7EhOFUw/BZxR6prYbKhMKy+px+4wTX2bMii
	TVbi93RvaNBw5ipGlaUJk2pvaVRIeJkXSe3+BfZvzTU6a3GkN/UwHqBOVEIJ1iPZwu99T1o2Pyw
	piCMiFn43QlRrl2E20y5Zu/kbitgumfFTGkDf1f7TyGRtfBzP4WJn3movdxRoHxbyL6BheG4dwZ
	AjOQt6lhBZMEkIVW10gcNsvlroEzDOiJH5uxcfokKX3DRhEYxhyi0YtDfU1vgpS78LgoEZZF+1H
	Or1iyohrE+f9INK7IGmuLZgqaibdCGJtq0ebNxlPVGxt1x4tjUJ8mlxQlPpjnecuhy+YATtv850
	YvaIeKCqYK0dnCfteC775OaG+Em+ozVg==
X-Google-Smtp-Source: AGHT+IEC4CylV+boIHz5904t89ij/HQn2PhhtSEsjDe3u4uLcYNbMPFPmrQ47kjyJqYS0P2YXwlN9w==
X-Received: by 2002:a05:6000:2509:b0:42b:4081:ccb8 with SMTP id ffacd0b85a97d-42b5934253amr11041513f8f.23.1763370572750;
        Mon, 17 Nov 2025 01:09:32 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b894sm25703786f8f.26.2025.11.17.01.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 01:09:32 -0800 (PST)
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
Subject: [PATCH v7 5/6] arm64: dts: renesas: rzg3s-smarc: Enable PCIe
Date: Mon, 17 Nov 2025 11:08:57 +0200
Message-ID: <20251117090859.3840888-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251117090859.3840888-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251117090859.3840888-1-claudiu.beznea.uj@bp.renesas.com>
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


