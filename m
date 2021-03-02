Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BFA32B1CB
	for <lists+linux-pci@lfdr.de>; Wed,  3 Mar 2021 04:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238203AbhCCB4r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Mar 2021 20:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382757AbhCBLFY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Mar 2021 06:05:24 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB21C0611C3
        for <linux-pci@vger.kernel.org>; Tue,  2 Mar 2021 02:59:51 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id i4-20020a17090a7184b02900bfb60fbc6bso1097330pjk.0
        for <linux-pci@vger.kernel.org>; Tue, 02 Mar 2021 02:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Po2WnbeRcNxbdVRWP+uTe3ZxilZPtJNj+wNjess1Fqs=;
        b=a5MyBXo6eov2ekIk8ZTfKHDNNdEoI4pKVri0SYc2F9SqYWibdQAXMjW3/w7FU/p/kg
         c51InQz0krRao9T5zPLw59TMVGitBuCGxloOW2a6N2HxyYz+5D+BaKS6EexoelT6VG/F
         cLhmS6GHKPR/R9pUBTpK+ZzLQq4r3k3u5M2k/oK8DNOa2g9pRU5In7tUGmZrN5oax8Gp
         xtafybVddL4BjJoA01DR/QEKBy55T32hKD1PoSLSqD/4iLIQMuoV5gKApwWVSxk36oMa
         7VrN6Rzarf0ceik8mxDudoNJSOkGYM6IgV9gBF765dqYhMGp5Cogl4ysmSY9NRz8K7qk
         G77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Po2WnbeRcNxbdVRWP+uTe3ZxilZPtJNj+wNjess1Fqs=;
        b=Ub6Lj7NSbYI7hfvXKSeZ5/mWyQjI0cNaNJXONWZMW08AA3FDXdIDKG/nsb90rfh29F
         SU4wBOX8BHBZn+g5pg0KWtw6ZHYO31pfFIJxGIwlwrJO8dtX4g9TTbiBpewNfARJwI6x
         HyLLBtrAr652TEC4MrGzkzNJYggkYxoCGhPKBIQfuVNbWInnrIW8RzddbNtSnVW0Ikjk
         MyOixLrsfOPue0rnEDh0Tf4ZamrVZMUaiLIdj4R9gmQLpQGeywUUEkoxBkWSqfKLQwbF
         NpJ0t8Lu0xFMw386D/hHnt9lMbYzT4RqO7xeCI+XOg9g3zPoXdJ2B3oQ0MNwpMtApuhG
         pxWw==
X-Gm-Message-State: AOAM530Awcodksdv2PSmrHpyjcbnuO8AY7FeadCnBTNz9mkcNjnr1qsy
        Gi2LJi9UhTl2rZawgePeubeSug==
X-Google-Smtp-Source: ABdhPJxJIJ3Tse6OxPoZISwk+LpR8TLSC6nbCdGBioVdI/phJeX6zkYJhK340UzKOl5FITpYzpeIZw==
X-Received: by 2002:a17:90a:9905:: with SMTP id b5mr3711228pjp.195.1614682791332;
        Tue, 02 Mar 2021 02:59:51 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id t26sm19500451pfq.208.2021.03.02.02.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 02:59:50 -0800 (PST)
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
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [RFC PATCH 6/6] riscv: dts: Add PCIe support for the SiFive FU740-C000 SoC
Date:   Tue,  2 Mar 2021 18:59:17 +0800
Message-Id: <cd88f8d29ec2050a22eb31e94f9efc1adfc4db2d.1614681831.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1614681831.git.greentime.hu@sifive.com>
References: <cover.1614681831.git.greentime.hu@sifive.com>
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
2.30.0

