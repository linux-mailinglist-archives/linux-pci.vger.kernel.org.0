Return-Path: <linux-pci+bounces-28706-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 389D0AC8CD4
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 13:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71F29A27AE2
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 11:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8501122D9E6;
	Fri, 30 May 2025 11:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="mJNmTFZ1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B0622D4FF
	for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 11:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748603998; cv=none; b=T2tEImQxcDpxktJRfkXJB0Qvka+Vyj+ZGXwuyDNIoYmpwRNL0QEK+9mkSSK4KgiZvnoNMxExfmF4UOLabcCj5r0mWNx2Ba74qFc6A+nDvRIoU9F1GkjRT/PSnxwVP/UO1MVltkX0Y1g4yMmUWfm4JOGR/yTX0MagGXGn20PP/jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748603998; c=relaxed/simple;
	bh=X7hDuCiTVWY384OgAlrGLr/jCTONBQsk3r94ENDyK3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HnzApovzMttijluXVgzVfiIS1qHljgii8pQ5jA8+EnTwE513miBVgSQO52Sdn4B/7+1NQffIdJ8eBC0UqxOFWT2mEOTGNoluhSB8LcyMY4xYN5FumWvBIWfNXk0RV7gnmL2Usk6DOsbH3at9xUIzzbJvGvwgYqrrwjdfLxyyWSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=mJNmTFZ1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-442f4a3a4d6so12139915e9.0
        for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 04:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748603994; x=1749208794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpG/I/+BWWmS26h5n6JKq19fnTLhLa0YbFAXx8ak2yk=;
        b=mJNmTFZ1xtp1hPDAQD0Nf/Xqe+nrwHACGsuTYOCBrTmIv2txwv2zwjHZj4UEWyPcSt
         HnhxL2u6Se9pNKSGM20AmliBhJ9xDEdxge+KLGe4RNPT8VZZXVffEfT9ZYbxJg98guTt
         QMto7zY8dtX/DWsV0HndOKu3XrZZffkXnI8VzZs9NGvmrX1DsKf8HTfGY/zbRy/dMALQ
         77bGvR74ctizJM/KUyye7R6Jf+xG/N7XRfWJ+o9zXxxjfNJu4D6ep3uWR+XcPni2tCGR
         wa72+mWiTILq4Z8ueHUivA9hxqxOR8VkTB6pV0sbuTWJuOGMS37OVkvrFp4YoWUc8LtT
         XCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748603994; x=1749208794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpG/I/+BWWmS26h5n6JKq19fnTLhLa0YbFAXx8ak2yk=;
        b=L+zqypCcvIDhfL6o80OB+h+3wiDWt17oqeF1jxqab4OMfI0ywXc24HEI0bAmTQaRcp
         M/8lqaZfpsoNTcQ76YfWJO3N02ZUlY0oOjEBvDjFR9+E0INEQyDd/IjiWJlviiPXwvYQ
         L1iNM6M4cbKdD5m2shOzRFFxK0VRFjL68A9mz05z6QLc8ngmhvPeGOsLIdQWelJgRkiD
         9jYp8rqMNC1hTWWmiaqZJXMNkbsKYtB+ab0UCN5dkFyf1mLVM/wudzcNocEDwTgv9CfL
         G42tFURY2vd/fzgktx8SNBmVAoMtx0R+4gEscDRxCpnj+SmRCgLB5dPbPqpY0kYayQRz
         9bAw==
X-Forwarded-Encrypted: i=1; AJvYcCW6u3XKdn9nhA4P5TGh5OeTd948DbO/ebcnv4maBSuGYdyva9VQRBt53+KXWxV78oD86GVDnwixCBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6PPmgmjU5c7fsDHFsqs1g3BmMX+Tyf2OBEBKap9wM3FwxUd1Q
	M6qyc2bFMpin93xf6S2XsbcTsmFv695VxLoNUno60p9Ecdu7SKqmBkmkx2k5d2uy+5w=
X-Gm-Gg: ASbGnctgRYrTiNuXTIOoci8fi/3Ek0GpINWauNNjafznun6F+DciAyk6gFwa8Rkba1a
	lyWUoCVntRZQYzlf2/Njz5z/13f1thr8zKujB7A0tfpit5WbRyl07WcsN0blCrDNOJnh7042QdC
	T6S7vzqxgwm4PBmO04TrFI30Vd3wkjIxYpGsfarBMtyTFFGgOoyYEJE3GsL+l8OeqpomZx4UUf+
	4Bw8gwK7JtB4AK8y5gW9ixT7TSP2827l13otHS4k9wR0GdxtniJWbBqCyzk9icFAmWixpNGrDJ7
	YJ2o0n+Tx/UeuXScnFZQX8s8n+8nCv10K9SAK1poGRhjg87Oikik8CPCOcOOhAAfhvW+LPyy8Qj
	WDMR7APFL/AF+X/dk
X-Google-Smtp-Source: AGHT+IGUJg33COSzG5y9e9bhXP7pOmJUOM67MeQYRzNHWMgUFeu2KrzZLuJQfaLbp9n6mkOJwkwhzA==
X-Received: by 2002:a05:600c:9a3:b0:441:bbe5:f562 with SMTP id 5b1f17b1804b1-450ce897d17mr44809275e9.16.1748603994306;
        Fri, 30 May 2025 04:19:54 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450dc818f27sm3986435e9.18.2025.05.30.04.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 04:19:53 -0700 (PDT)
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
Subject: [PATCH v2 5/8] arm64: dts: renesas: r9a08g045s33: Add PCIe node
Date: Fri, 30 May 2025 14:19:14 +0300
Message-ID: <20250530111917.1495023-6-claudiu.beznea.uj@bp.renesas.com>
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

The RZ/G3S SoC has a variant (R9A08G045S33) which support PCIe. Add the
PCIe node.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- updated the dma-ranges to reflect the SoC capability; added a
  comment about it.
- updated clock-names, interrupt names
- dropped legacy-interrupt-controller node
- added interrupt-controller property
- moved renesas,sysc at the end of the node to comply with
  DT coding style

 arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi
index 3351f26c7a2a..f1d642c70436 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi
@@ -12,3 +12,63 @@
 / {
 	compatible = "renesas,r9a08g045s33", "renesas,r9a08g045";
 };
+
+&soc {
+	pcie: pcie@11e40000 {
+		compatible = "renesas,r9a08g045s33-pcie";
+		reg = <0 0x11e40000 0 0x10000>;
+		ranges = <0x03000000 0 0x30000000 0 0x30000000 0 0x8000000>;
+		/* Map all possible DRAM ranges (4 GB). */
+		dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0x1 0x0>;
+		bus-range = <0x0 0xff>;
+		clocks = <&cpg CPG_MOD R9A08G045_PCI_ACLK>,
+			 <&cpg CPG_MOD R9A08G045_PCI_CLKL1PM>;
+		clock-names = "aclk", "pm";
+		resets = <&cpg R9A08G045_PCI_ARESETN>,
+			 <&cpg R9A08G045_PCI_RST_B>,
+			 <&cpg R9A08G045_PCI_RST_GP_B>,
+			 <&cpg R9A08G045_PCI_RST_PS_B>,
+			 <&cpg R9A08G045_PCI_RST_RSM_B>,
+			 <&cpg R9A08G045_PCI_RST_CFG_B>,
+			 <&cpg R9A08G045_PCI_RST_LOAD_B>;
+		reset-names = "aresetn", "rst_b", "rst_gp_b", "rst_ps_b",
+			      "rst_rsm_b", "rst_cfg_b", "rst_load_b";
+		interrupts = <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "serr", "serr_cor", "serr_nonfatal",
+				  "serr_fatal", "axi_err", "inta",
+				  "intb", "intc", "intd", "msi",
+				  "link_bandwidth", "pm_pme", "dma",
+				  "pcie_evt", "msg", "all";
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie 0 0 0 0>, /* INT A */
+				<0 0 0 2 &pcie 0 0 0 1>, /* INT B */
+				<0 0 0 3 &pcie 0 0 0 2>, /* INT C */
+				<0 0 0 4 &pcie 0 0 0 3>; /* INT D */
+		device_type = "pci";
+		num-lanes = <1>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		power-domains = <&cpg>;
+		vendor-id = <0x1912>;
+		device-id = <0x0033>;
+		renesas,sysc = <&sysc>;
+		status = "disabled";
+	};
+};
-- 
2.43.0


