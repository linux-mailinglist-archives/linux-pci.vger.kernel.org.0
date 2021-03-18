Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED9733FF58
	for <lists+linux-pci@lfdr.de>; Thu, 18 Mar 2021 07:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhCRGJK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Mar 2021 02:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhCRGIw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Mar 2021 02:08:52 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18410C06174A
        for <linux-pci@vger.kernel.org>; Wed, 17 Mar 2021 23:08:52 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so4462299pjc.2
        for <linux-pci@vger.kernel.org>; Wed, 17 Mar 2021 23:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=H4O8Pz9t8/99FT90e18/xfiNTrUM7XDwRwcWmzhNsZ0=;
        b=C1CilY+TIsLUfNiPWi+Gp28S0ZCZuAlTIyNcYPmntFgRJpD8pRA/q9FVezUwJdWnkr
         IIR5kgKJTi1WYk0OmrZXrrennrBJW8Evbp0+FToBwqILhxGxsMAG5uTZwB+WpQBBLjp9
         gHxV9lV/TKP19fEd8wfN7cdbJ9uQLW55eqpBm/2ZTN09eLD96WgwJBvAs0ZVFv+sTMgJ
         fDUx7S4u4ABXOuYGBZoIV3DaM6jertw5GIwyGNlXfpZ+QDlWwajN3GmYzPzogVhm9z5z
         dBWMYdXOGIAeKRQHeD1d4JG8d+y0pRQZdPeyDQymK+PPflbb2Qilqo04jFRZxx/ONDUq
         WkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H4O8Pz9t8/99FT90e18/xfiNTrUM7XDwRwcWmzhNsZ0=;
        b=BRNWvU4WQGp60B8lVXriejrOXbsTJWFp7i5k3ggRirrEikGRUTEkW8Cvkb1fuG1yBX
         tUIFISFfccXMPJFd0Uugl+VMlPBCdPOVbbzSlfeJhLjSgEvgibkGYtP7o2LE7C+zkMw+
         HlmUcL4hLNjf5rb4x1QynSll0kvjitIPztJZYPAOujMDUEpqx1IdWmtWV1WpMD4E+Vtp
         WlaFujpcKltwZWbmjGe5h4tfr7cX5I9VdNd6GVaRZM0t0NqzVzseHMUyLCmrAFIktj2A
         LZWVhIEVigfUIpG2t1a/rOK+vD4dkC864++wrkg3/bFdJbLDf6OOjbEplmZ8R4VRspRI
         JAiw==
X-Gm-Message-State: AOAM532Jgr6qlu15SxjYAHfMfbrmGoFv5zs5fEa6pOOLoOKrHMy4IXEo
        Dfm484PQ+/RRzLzi3lDej7wy5w==
X-Google-Smtp-Source: ABdhPJyl35YIgn5TvN5MNKZ1TPt5+h5j5mZkq8LUsV5fL4Ysw4zzLFVIjBUzx+FmMc3kdIZujmU8Mw==
X-Received: by 2002:a17:90a:5d10:: with SMTP id s16mr2621850pji.126.1616047731651;
        Wed, 17 Mar 2021 23:08:51 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id 68sm967353pfd.75.2021.03.17.23.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 23:08:51 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, paul.walmsley@sifive.com, hes@sifive.com,
        erik.danie@sifive.com, zong.li@sifive.com, bhelgaas@google.com,
        robh+dt@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
        mturquette@baylibre.com, sboyd@kernel.org,
        lorenzo.pieralisi@arm.com, p.zabel@pengutronix.de,
        alex.dewar90@gmail.com, khilman@baylibre.com,
        hayashi.kunihiko@socionext.com, vidyas@nvidia.com,
        jh80.chung@samsung.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        helgaas@kernel.org
Subject: [PATCH v2 6/6] riscv: dts: Add PCIe support for the SiFive FU740-C000 SoC
Date:   Thu, 18 Mar 2021 14:08:13 +0800
Message-Id: <17994571deaf703e65ece7e44c742f82c988cf39.1615954046.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1615954045.git.greentime.hu@sifive.com>
References: <cover.1615954045.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/boot/dts/sifive/fu740-c000.dtsi | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
index d1bb22b11920..d0839739b425 100644
--- a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
@@ -158,6 +158,7 @@ prci: clock-controller@10000000 {
 			reg = <0x0 0x10000000 0x0 0x1000>;
 			clocks = <&hfclk>, <&rtcclk>;
 			#clock-cells = <1>;
+			#reset-cells = <1>;
 		};
 		uart0: serial@10010000 {
 			compatible = "sifive,fu740-c000-uart", "sifive,uart0";
@@ -288,5 +289,38 @@ gpio: gpio@10060000 {
 			clocks = <&prci PRCI_CLK_PCLK>;
 			status = "disabled";
 		};
+		pcie@e00000000 {
+			#address-cells = <3>;
+			#interrupt-cells = <1>;
+			#num-lanes = <8>;
+			#size-cells = <2>;
+			compatible = "sifive,fu740-pcie";
+			reg = <0xe 0x00000000 0x1 0x0
+			       0xd 0xf0000000 0x0 0x10000000
+			       0x0 0x100d0000 0x0 0x1000>;
+			reg-names = "dbi", "config", "mgmt";
+			device_type = "pci";
+			dma-coherent;
+			bus-range = <0x0 0xff>;
+			ranges = <0x81000000  0x0 0x60080000  0x0 0x60080000 0x0 0x10000        /* I/O */
+				  0x82000000  0x0 0x60090000  0x0 0x60090000 0x0 0xff70000      /* mem */
+				  0x82000000  0x0 0x70000000  0x0 0x70000000 0x0 0x1000000      /* mem */
+				  0xc3000000 0x20 0x00000000 0x20 0x00000000 0x20 0x00000000>;  /* mem prefetchable */
+			num-lanes = <0x8>;
+			interrupts = <56 57 58 59 60 61 62 63 64>;
+			interrupt-names = "msi", "inta", "intb", "intc", "intd";
+			interrupt-parent = <&plic0>;
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+			interrupt-map = <0x0 0x0 0x0 0x1 &plic0 57>,
+					<0x0 0x0 0x0 0x2 &plic0 58>,
+					<0x0 0x0 0x0 0x3 &plic0 59>,
+					<0x0 0x0 0x0 0x4 &plic0 60>;
+			clock-names = "pcie_aux";
+			clocks = <&prci PRCI_CLK_PCIE_AUX>;
+			pwren-gpios = <&gpio 5 0>;
+			perstn-gpios = <&gpio 8 0>;
+			resets = <&prci 4>;
+			status = "okay";
+		};
 	};
 };
-- 
2.30.2

