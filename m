Return-Path: <linux-pci+bounces-37668-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59528BC1857
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 15:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5614919A31B4
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 13:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BCD2E1EE2;
	Tue,  7 Oct 2025 13:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Qy9+iF6r"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9562E1C54
	for <linux-pci@vger.kernel.org>; Tue,  7 Oct 2025 13:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759844243; cv=none; b=o85jttSCDA3oMWoUIqt7xqrYGGKXs0hzBgKDJxwA8Vl5KPLDppr57RB+gUS9W9atVvOBwgMNY7DtmJkpz12scTlozYqrc4rKlwX0WWAUqCXYPMFjywuXb5Ci8ZKiOyNa+0HG3bq5vo3os2taXGJ293M3upnk+3M/8cDKfG/otic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759844243; c=relaxed/simple;
	bh=RpdnNbrVn0b7dBlRv383Ehwxmz1LT5B4dkZCILAk05c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UKIb9MrpX5Mvm5+f/uamfTR1d0jZAJwF6EZX1s0q234b9Ph7w0vDJACXTP32AeN2gprVTzU/8Ez/qEW8ucAAqASAF5YagNrWOkHYoCEYz2Hf9o93fV2EzccsWpPNzzTXru/nZub0Vn3DDQLs27V+x/EED5QVmnJch9gy5CxNrFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Qy9+iF6r; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ee130237a8so4391595f8f.0
        for <linux-pci@vger.kernel.org>; Tue, 07 Oct 2025 06:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1759844240; x=1760449040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LT0gXBq+U1AMvRGkpBaatl/Xv/PMYwxUcE4kDcPfFVA=;
        b=Qy9+iF6rnVeqfl3IFQz6rz88zeGFtPezdp/pd/4EDoar2sDhSwueLOcFmfGtFwzzOd
         trkkZgqT6frfaqnLQmyq/BoAUkvzrHWWjZgrS8uV77WtBdemPwqZOM52ECiilZpOejJ/
         uLKJR1mG7CGdh7k07Q0uzG4ZJwoj5q3oMrSE7W7gbq1dv+u9i8xiEHP4A+HcEaYWGfW+
         Q2MVZ4szWzWX67eDasP1zYBvIOwtm/nNuOH9M16vFebYpb5/fhBVGKMGBh4rfNq/kIXV
         KJrFWE8XeJiD3Wu2myEnmE21mMkehsL6OLq9bNhCx8n05Nln9Ar6dp46f4oEJU15rHxB
         BN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759844240; x=1760449040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LT0gXBq+U1AMvRGkpBaatl/Xv/PMYwxUcE4kDcPfFVA=;
        b=eQ5SlZWYMtJRk1h1x4+bIhLzePBU7CFspYK1cWWb34fXC+JHCZ7fhJa6UXH0aNlPUX
         fJuL54EHEGX6kcf+aFTybCT4c+qhgpgPyRy3RVOqZi4tZDI2x9jL2DehD1utLUODF50b
         RruG+oHOXWLSLYDUZATXKVTpfKoqZqAA4Cwahw9tpDrZSq5ne6jxYyXw/oE91OBCDkP9
         raDNrH/dW3mOCZPIgUJkBZ6UsWtOReebazruWuZT5nn4tthdWP5jiy8iyNHw+c6sZRYR
         0B05UGc+yytvd2pWr+fR5SlsPz9DCFidUKQkXHdbsejq03qnE/W49UqA6GUHn2uSJQhe
         iSkw==
X-Forwarded-Encrypted: i=1; AJvYcCVEvCfDCGYYu40Gx8Qw1FF0BznNWUfMwsL0atJZe8WDe/PXSHvfwiKihPpQwU39wLjCCqsJguDcceQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4lOaPBXQIi08hbZc1w8kZmA6gXdCjPPFuV51iNk6byIEIHqAa
	QF8uqYbqsaiWYSnxY9D9wPTeFS/iTSU0B/wFu54DzULm/OpwR7SIVTxy8ARddOPB2LQ=
X-Gm-Gg: ASbGnctlgZcKE1QV4mmZgHpE2cCveP3Tpmz2q8JBWIiertzN8+DsDVugeV/P/53HZRS
	7nZK7wlR0NdExAEDLoKivxsYKiR5+3sILlvys1V5lRZIO0GuHKQ1FAfDZbnWV5JVz4kU4Jf0RGN
	zaIWC49NAlSk0QolvCScepM1DGBkrK8+JQJ3b+yXeSN4jsFkpp99X6nvS1tqe9VfpBWydAcftaN
	KSCLmqL5DGLDImPhfCk+WCrw7H2RM/jrKkjfVNmh90H8o4jBbhOwFt2/10qO7bMwd2mWVRBZCcM
	uB5adPzoOOjW6bFmL+myoR4om2VFoR31p4WbnQhyqsL9gXJeWULvgJkt3rHJ//E9lfnLCRJQsbO
	nWuxzENIhORP83yftVZUMZNlXDjfVYaG4
X-Google-Smtp-Source: AGHT+IEQEdqQV8aA6QCI1nIzRLsSitkSoMJ7gvZgt6Ow3HrwfSSg4Zlv8zHbr6vw3Ds4kAb+8sCGkw==
X-Received: by 2002:a05:6000:4029:b0:3e4:b44d:c586 with SMTP id ffacd0b85a97d-4256719e10dmr9134482f8f.34.1759844240083;
        Tue, 07 Oct 2025 06:37:20 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e674b6591sm272189625e9.4.2025.10.07.06.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 06:37:19 -0700 (PDT)
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
Subject: [PATCH v5 3/6] arm64: dts: renesas: r9a08g045: Add PCIe node
Date: Tue,  7 Oct 2025 16:36:54 +0300
Message-ID: <20251007133657.390523-4-claudiu.beznea.uj@bp.renesas.com>
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

The RZ/G3S SoC has a variant (R9A08G045S33) which supports PCIe. Add the
PCIe node.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- updated the last part of ranges and dma-ranges
- collected tags

Changes in v4:
- moved the node to r9a08g045.dtsi
- dropped the "s33" from the compatible string
- added port node
- re-ordered properties to have them grouped together

Changes in v3:
- collected tags
- changed the ranges flags

Changes in v2:
- updated the dma-ranges to reflect the SoC capability; added a
  comment about it.
- updated clock-names, interrupt names
- dropped legacy-interrupt-controller node
- added interrupt-controller property
- moved renesas,sysc at the end of the node to comply with
  DT coding style

 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index 16e6ac614417..00b43377877e 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -717,6 +717,72 @@ eth1: ethernet@11c40000 {
 			status = "disabled";
 		};
 
+		pcie: pcie@11e40000 {
+			compatible = "renesas,r9a08g045-pcie";
+			reg = <0 0x11e40000 0 0x10000>;
+			ranges = <0x02000000 0 0x30000000 0 0x30000000 0 0x08000000>;
+			/* Map all possible DRAM ranges (4 GB). */
+			dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 1 0x00000000>;
+			bus-range = <0x0 0xff>;
+			interrupts = <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "serr", "serr_cor", "serr_nonfatal",
+					  "serr_fatal", "axi_err", "inta",
+					  "intb", "intc", "intd", "msi",
+					  "link_bandwidth", "pm_pme", "dma",
+					  "pcie_evt", "msg", "all";
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie 0 0 0 0>, /* INTA */
+					<0 0 0 2 &pcie 0 0 0 1>, /* INTB */
+					<0 0 0 3 &pcie 0 0 0 2>, /* INTC */
+					<0 0 0 4 &pcie 0 0 0 3>; /* INTD */
+			clocks = <&cpg CPG_MOD R9A08G045_PCI_ACLK>,
+				 <&cpg CPG_MOD R9A08G045_PCI_CLKL1PM>;
+			clock-names = "aclk", "pm";
+			resets = <&cpg R9A08G045_PCI_ARESETN>,
+				 <&cpg R9A08G045_PCI_RST_B>,
+				 <&cpg R9A08G045_PCI_RST_GP_B>,
+				 <&cpg R9A08G045_PCI_RST_PS_B>,
+				 <&cpg R9A08G045_PCI_RST_RSM_B>,
+				 <&cpg R9A08G045_PCI_RST_CFG_B>,
+				 <&cpg R9A08G045_PCI_RST_LOAD_B>;
+			reset-names = "aresetn", "rst_b", "rst_gp_b", "rst_ps_b",
+				      "rst_rsm_b", "rst_cfg_b", "rst_load_b";
+			power-domains = <&cpg>;
+			device_type = "pci";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			max-link-speed = <2>;
+			renesas,sysc = <&sysc>;
+			status = "disabled";
+
+			pcie_port0: pcie@0,0 {
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				ranges;
+				device_type = "pci";
+				vendor-id = <0x1912>;
+				device-id = <0x0033>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+			};
+		};
+
 		gic: interrupt-controller@12400000 {
 			compatible = "arm,gic-v3";
 			#interrupt-cells = <3>;
-- 
2.43.0


