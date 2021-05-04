Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCED637295B
	for <lists+linux-pci@lfdr.de>; Tue,  4 May 2021 13:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhEDLBp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 May 2021 07:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhEDLBg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 May 2021 07:01:36 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24F8C06138A
        for <linux-pci@vger.kernel.org>; Tue,  4 May 2021 04:00:37 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id d10so6469609pgf.12
        for <linux-pci@vger.kernel.org>; Tue, 04 May 2021 04:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bd4fUtUUCN/HpB11MmfQQGuVzm8gcsXHLL3mbp/tsMI=;
        b=gxf7CzRhIEg7zRxAYGfW3O9gQpoV2/SC9xkdYvQf3t+rCcVcsEqdhkegYCDClL06IQ
         nNCvHtQnt2tAtCMP/3gx3r/XxbYswP6vnXZO7suvBW7X1mwBvhXuau0m/XuWNLv38/9N
         eN2AN9ttEI4gDJ29x+0pSaSXv9wc6K3vB9XcRHoBhtLXHIvV0LRs8BVDfsScBrgeZPeM
         UkHPGcCTozEn+KaHV4WeUqZ/IVdH4zhep8U4PtnPDLCrTNih8FfDVVXd4Olpfl6YQIZg
         1rKIEmXBw6aeSdAIgAfCF2wCnbsGLCur1hSjinLYVbLNDDxRlcn86lav+MEPJfQknkDK
         hbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bd4fUtUUCN/HpB11MmfQQGuVzm8gcsXHLL3mbp/tsMI=;
        b=PDAsCAZ3XQ23qJfKPSZqpnkIBxpaQ6juzJP7JM1gCf7GRE/MrLcaAvmBCZV/gEG2vg
         oduVySrdVcD8GeDMbsTZQwGQPinRHA8khExskD/72HRixiXki6Ws2EV5r+CzfJxiWFfK
         0MKFwr6t4rp9vmZHaq+cfqN9AMry0pzJn/PR9oErAwPtaVVVneToWFQBWezc5j7uqyZq
         HVV7WLZcauISCOg243HrNYkNsWl6EtuJ1nt5keP3WHRJFS0CTKcZF93KTMD3ik+LmYEa
         R9l1b+DEcLV7G1GH9GXj/HDE8o8ctGEoxwLyMXQZhLel4GrzHlR/SePgHNQ+fJjb9soT
         ynJw==
X-Gm-Message-State: AOAM530UG13gdxCtc4RFclMndTj+D61GSk7VgEjz5ul5UlkU9nCcsQPK
        0hI+H6m+g5zKK3EGQnWab8yoBA==
X-Google-Smtp-Source: ABdhPJz46MtHcSpwQA7kaeKNf5SD74WureuuZMKtrRm8c5ReJSIREFjLSWxpGsBIBtCzVJDkaWsUTg==
X-Received: by 2002:a63:1d19:: with SMTP id d25mr22535208pgd.169.1620126037434;
        Tue, 04 May 2021 04:00:37 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id k17sm11762529pfa.68.2021.05.04.04.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 04:00:37 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, paul.walmsley@sifive.com, hes@sifive.com,
        erik.danie@sifive.com, zong.li@sifive.com, bhelgaas@google.com,
        robh+dt@kernel.org, aou@eecs.berkeley.edu, mturquette@baylibre.com,
        sboyd@kernel.org, lorenzo.pieralisi@arm.com,
        p.zabel@pengutronix.de, alex.dewar90@gmail.com,
        khilman@baylibre.com, hayashi.kunihiko@socionext.com,
        vidyas@nvidia.com, jh80.chung@samsung.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, helgaas@kernel.org
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v6 6/6] riscv: dts: Add PCIe support for the SiFive FU740-C000 SoC
Date:   Tue,  4 May 2021 18:59:40 +0800
Message-Id: <20210504105940.100004-7-greentime.hu@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210504105940.100004-1-greentime.hu@sifive.com>
References: <20210504105940.100004-1-greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/boot/dts/sifive/fu740-c000.dtsi | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
index eeb4f8c3e0e7..8eef82e4199f 100644
--- a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
@@ -159,6 +159,7 @@ prci: clock-controller@10000000 {
 			reg = <0x0 0x10000000 0x0 0x1000>;
 			clocks = <&hfclk>, <&rtcclk>;
 			#clock-cells = <1>;
+			#reset-cells = <1>;
 		};
 		uart0: serial@10010000 {
 			compatible = "sifive,fu740-c000-uart", "sifive,uart0";
@@ -289,5 +290,37 @@ gpio: gpio@10060000 {
 			clocks = <&prci PRCI_CLK_PCLK>;
 			status = "disabled";
 		};
+		pcie@e00000000 {
+			compatible = "sifive,fu740-pcie";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			reg = <0xe 0x00000000 0x0 0x80000000>,
+			      <0xd 0xf0000000 0x0 0x10000000>,
+			      <0x0 0x100d0000 0x0 0x1000>;
+			reg-names = "dbi", "config", "mgmt";
+			device_type = "pci";
+			dma-coherent;
+			bus-range = <0x0 0xff>;
+			ranges = <0x81000000  0x0 0x60080000  0x0 0x60080000 0x0 0x10000>,      /* I/O */
+				 <0x82000000  0x0 0x60090000  0x0 0x60090000 0x0 0xff70000>,    /* mem */
+				 <0x82000000  0x0 0x70000000  0x0 0x70000000 0x0 0x1000000>,    /* mem */
+				 <0xc3000000 0x20 0x00000000 0x20 0x00000000 0x20 0x00000000>;  /* mem prefetchable */
+			num-lanes = <0x8>;
+			interrupts = <56>, <57>, <58>, <59>, <60>, <61>, <62>, <63>, <64>;
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
+			reset-gpios = <&gpio 8 0>;
+			resets = <&prci 4>;
+			status = "okay";
+		};
 	};
 };
-- 
2.31.1

