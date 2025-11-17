Return-Path: <linux-pci+bounces-41368-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8F1C630F3
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 10:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EAC13A5E68
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 09:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD90328249;
	Mon, 17 Nov 2025 09:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="pY9qEgNU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D81532721D
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763370573; cv=none; b=HYw+411IHH2vzN3qYZizczFg8dYvqxviSZwSuGMG5RlHagpMqxhDcr7RGfxr8mknlbIzpqKV8t2aJo06UIsss3mfRYUJG/rEll8zQOAwqkoqXcQwsufk8wp0bbfQSdJ/WLcSP/7qhSd5mhNJZa8gLMPb1JIgj09n8pWegoA+CYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763370573; c=relaxed/simple;
	bh=kz9T2KGxOEfX5UpMNTiYKQBBW63oxNnvugSyhpgKZPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbJgvQCXxQztvGpCeZDgZdI9xAab7OdluP7RyFXh3aOzWi6t4CvvY5CVCpVeNf2h3XKRuBAku4yPZhiYQEQ6mQ19c+A5mlz8madh75NC3RIozbupsDOw6FPURFupM8KsKfpeeZsNQr5pRyuXilbUqj0dtW+dZjYEyicx2uxVcZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=pY9qEgNU; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b2e9ac45aso2531315f8f.0
        for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 01:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1763370569; x=1763975369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3FR/c9MnUrs4lL5l6XQRc5YUd7UbmmEgaYQZlcLjqA=;
        b=pY9qEgNU0zxeIQkKLPiFX9AtgxTpFm7XNHioTtkJ6UpBf7KQPFgisIsbvsKKzcX3lQ
         dqpSBPODVqkWTwgh6rI7mt21IThDLiPCVITfV+5EBpO1RpdGJ7Pqfr7xVBynixbEH2Nx
         i8nGEBaYX5rfSfS9WiJaMhiiejVecyJ6MAK56Z0ZJqsJmip7RVS7EB/tNESDLjzxpcOG
         aiSF8h+U/8NIfNi6SWnzGH+AHgVPSMT3UfEXb37UBhIsDZOUmUEcTG+tlh6aJ18m4LjL
         BldXtVjtuAlAreL+yF31ZsbYqP8JszwyzHrZpIC2JRkx51rql0YbBCBH5YawhrtEhhpU
         BGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763370569; x=1763975369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X3FR/c9MnUrs4lL5l6XQRc5YUd7UbmmEgaYQZlcLjqA=;
        b=cb4+0L0hOHeqS4aZzWXfk1s7VSQa0rFQEHnB5XnzGXBCJti6zFWwiaAOS7OcxFRgjd
         VRLm2bu5an5oxVDYNtxAV4Djm7gjN0zjQJGgGwgbUZPWY9c7/EWKBqtekN9BInbs2SmJ
         fDQ0NlxiHcdQtFSuUCUbwnejDYgm4cfuqxJnsHK7oziZh6UjQmLT/YPAlh3yvqryLN5z
         1uANCxou09QX89kav/saprd+PfXTS8UDWAAe3PH1Eq8bHAqv671O4iAMTVCFvL8pHwqa
         B3oGT9vOAg/PwfqfaL9EC76YlhoL7Lu09To6LwAxn5QoDGlwPDuPv9o0IyxhP3pkOt5K
         N2mg==
X-Forwarded-Encrypted: i=1; AJvYcCXKm3+xTyv/K3WSesyP8DYH8UzQAvuRr29s90bgkefKtMq1Rs6J0c6/erL69tzI/Y4VrK1zIlP4Ths=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNIDacaC/JtiR/C/3W43k+Zq+6YB7HoKP3TH0NjN446a6pQDlR
	aY3safWnhNgj8O/jPnhq3HhY6HMqdmvstUYuEbrFKOP5qboO5x3tO/Wy/KmPor3+lI0=
X-Gm-Gg: ASbGncswVB+1RKB7QlK2HLndqgOTastUYKDBu+upCToFIcXgUlUhK9K7nuc0bRV5iUF
	mQgKomCSCgsyY/1tcqmI97RkagNXpN39tF1g64RgU6TCbDc49YPZMp3iQ79PU96KNP8oITLdrJD
	JirtLLXs06a2kI6l7yq53+aD3mmQEPqeE0uxo+JBnNctmPuj4LEuG3pdKodaww0UVq0Yh6mzXgq
	oBACOfWDfj0jEtTiAiAJe0QFcChlJ5yzQ4q5lgMDT+f2NDwhsNWbLoSpTouozEx0DaPS8M6zamc
	8MPGzjIXuCCNTzf4IPURhikHUCbk9pKYZ5eE4QyFCVByEqEosAUj0eHGEp13WkSJxhJO3/hjZWo
	2Lmu3we/l8Vc7NaimA3jR620JcG4+wheBL2exksale7bqjBaE4kgWDZHHVSy+FxrIp3+hOYzT36
	IGXPWjQw0cXORFqvBfogj3ycKnmHhCpbzrbPN6f0Uh
X-Google-Smtp-Source: AGHT+IEeMwc9bWDg+GvUI760bic3oGssOpWM18xNbJeQXMnCLI1b1s0n6BBW747gFuj9F0UWirjv3Q==
X-Received: by 2002:a05:6000:25c4:b0:42b:3806:2bb7 with SMTP id ffacd0b85a97d-42b593458c5mr10747629f8f.6.1763370569351;
        Mon, 17 Nov 2025 01:09:29 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b894sm25703786f8f.26.2025.11.17.01.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 01:09:28 -0800 (PST)
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
Subject: [PATCH v7 3/6] arm64: dts: renesas: r9a08g045: Add PCIe node
Date: Mon, 17 Nov 2025 11:08:55 +0200
Message-ID: <20251117090859.3840888-4-claudiu.beznea.uj@bp.renesas.com>
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

The RZ/G3S SoC has a variant (R9A08G045S33) which supports PCIe. Add the
PCIe node.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v7:
- none

Changes in v6:
- dropped max-link-speed

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

 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 65 ++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index 16e6ac614417..8fd3659b70fe 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -717,6 +717,71 @@ eth1: ethernet@11c40000 {
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


