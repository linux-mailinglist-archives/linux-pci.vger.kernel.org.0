Return-Path: <linux-pci+bounces-39650-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA2CC1B176
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 15:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 952D3566012
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 13:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4275343D6C;
	Wed, 29 Oct 2025 13:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="cK6TkHzN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FEC34B1A0
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745055; cv=none; b=QeaOTGu4semQnNM2EO/rDXyEOELJLhfUthg8HkRCv0xTZ+vhUokQit9Ny6vvi6S12d6hTy8kPWmUdTQ5HmHHDAUySBdcFX5ExNB0CBg/N9TvDgStn9yOwV+hoJ4RPMknXuRIxExHAdB74MhoWvHvR00PUtkZTkiu0UYtubtv5wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745055; c=relaxed/simple;
	bh=4qpWxnL0DqNz+EstVskb0cPtElHFijuDgl2X0otea40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QoE77szxnU+aF1MgXngj+SZZRjAGiFF5Iusq2gZVVZddmSAU4Wb7jFrrN8FQFlprL0hc5BPEWOaFwrwiKcSD4MoYyHULo0PJX0GNlA9Si2TXBWq2NkU3PscYJqL4ayLgzc2SOR1FA35mEejgAHFcaYzV9TKbhCK9DvSFIGQuRAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=cK6TkHzN; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47112a73785so46408365e9.3
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 06:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1761745050; x=1762349850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZucVisGfZT3YO6Pp1pOYJeX0AZmBkMe3rP14GIY7Fmo=;
        b=cK6TkHzNCfgg6ofabXiMiY5bCJ/o4t4m3QV7NCO7CSSIYXA7u6P/EuX/ugjH9HDbK8
         lY3kGP59GNKoEE06XGvl3dCSMOcDZSYR7elZZelcq5Fd99OsiBy17jlZv8CneCaRs6cF
         S+VsFq8ok86uM8JdpUiotW53H5fbsTQowKwn1XDfsar3jl0aI1zqO4jkofPK3+daH9W6
         j6IA1C1ihgA7oEq7p2r7vmVa35K8Fvqic3zrqiP6jAoxXFv3sIWtbW6J4sXFM13LewI8
         YTLUZWmze7B4fhfdIiT270WQH42VgBHZWjifK/XullPMMxmbRWzuT0FMRQ0k+6MjwiVI
         vehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761745050; x=1762349850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZucVisGfZT3YO6Pp1pOYJeX0AZmBkMe3rP14GIY7Fmo=;
        b=vhUpYecAMDGRl6Woyw5b3bkVYZvdPIkdnM5u1yaYciRHOhpMWNzJufQ/SneIvMMmi0
         F5fkCGb7lpS7JppdSIyrorHTNyAjR9YIP/ejIJKFlfs6/97Tb61RKpjffPqHhrsayie8
         g1/GIPWGtTIloHDS7QzyUOufx9RLtgWhRmWZgCjv0XG3E7APpdgagrQ6HpHcIGX6m1AZ
         +giOjDhrUIrCWa5foM1uuk6pOdhPdqVtiwJN0jn9TKymixQgZGKNB2WEXsQdAwpmvH2r
         3Y0MaUMONLcsxVMD9Oye96TEUgPPZ5NM3CueVQFvWcpESa9U+zw5oCk06IwaIZR0AnxS
         gRgw==
X-Forwarded-Encrypted: i=1; AJvYcCW9OPH17KLcCfipa51ub/+VdPQtOPPpY24xs8+n4A2WOQ9HkejiAB6EmU8jjS7tM2jlaaN7xM4ZBUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwetC7JJLI2lkmTVrgylRN1WYCUc2Ofz6rD2btyXMYcnGymwrUK
	mtw541Gq7G8BGOUu5WMyLA7/7Fb6Fmeo9Q4Xk3cLtd26F2ZvBOUp3TFtvdwi2l9xQ04=
X-Gm-Gg: ASbGnctA9hbOBpoAWnc9hg886aEZNecr6R/QzcKY2Z/9Dpg8c74XOwMzEMHTdfUlW6R
	C2cLWItKeMgxi0RSFzbjOxUojiW5i5ProCwr4/Zd+csi1yBeEglUErppyyo1akV7ZNS3iB8WIrV
	viBugQOOSpJFQqaDieiYTrXPOsbwMGNIDrSA3OiRkvH+8MebIfDjAACob3ODNtn2clDogDwBCrC
	xOxEMPL6KEd+wjusMKSac3VSgpkuhIh8gSgmajh4hqhrHBosLqFKrDSgG0mg+/zHzvf69sdKAxL
	BlNIN3ELt4ErWC7M/3jvmspWByqnXb78g5JD7V/HIuPZpGNqICweycNGBVYgI3g3VW2XuISszYT
	QR9h7VoinCMM1mLfZhRft/OyuAHkSfKWclFqWgrSR9dEvVQyaa2yYB1RWcSmPiEEV7OzXqVUdRL
	zG20evoVmNRz1IhJmOwOL1jm8N4PosOb06aKO1tYMV99V/fk5UoLlxf30P7jx0
X-Google-Smtp-Source: AGHT+IH82LP23eHV2Q/dmls/on8JCS7YDUNQByFGpr5xcqcKOc3wDkP1J/vGZ2LxnzV3ZCk9iEZMCw==
X-Received: by 2002:a05:600c:45c5:b0:46e:376c:b1f0 with SMTP id 5b1f17b1804b1-4771e316cf4mr27747135e9.7.1761745050061;
        Wed, 29 Oct 2025 06:37:30 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6302:7900:aafe:5712:6974:4a42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e22280fsm49774795e9.14.2025.10.29.06.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 06:37:29 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
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
Subject: [PATCH v6 5/6] arm64: dts: renesas: rzg3s-smarc: Enable PCIe
Date: Wed, 29 Oct 2025 15:36:52 +0200
Message-ID: <20251029133653.2437024-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029133653.2437024-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251029133653.2437024-1-claudiu.beznea.uj@bp.renesas.com>
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


