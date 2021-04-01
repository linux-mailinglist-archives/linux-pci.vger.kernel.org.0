Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C17350EBC
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 08:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbhDAGBv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 02:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbhDAGBZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Apr 2021 02:01:25 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFDEC061788
        for <linux-pci@vger.kernel.org>; Wed, 31 Mar 2021 23:01:25 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id c204so665638pfc.4
        for <linux-pci@vger.kernel.org>; Wed, 31 Mar 2021 23:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bJDxiGn0zb+AtBhh3GrH3c02J/dSNj0T0Os6e9JU2HI=;
        b=fADFrw70kQ6R9GVUIqdKks1e5hHtR47gSn2Ei7hYKbBt0gKF8Uk2eLlfFRlEMYW3Rg
         NS2s5c+CnMsJcIUytKnOsifC4Ycy3o1qIPAaSN9vuopXuPr7jhL8WzWNTYX4PTYjLdz9
         8Lm9b++bZYs77iQ1TZO0C/QeTxhUuwZCJe42bOZbYTb2yTyw3jw+F1gvCTwnJbpr2Tq+
         MLsDvkEvqFI1nJlOyuZS0DhDo6t8BLOGwHcMluY47uYrfvKkvVBkXC/qNiA7vD7tLgZY
         UpwNq8Nez8+FbI9uXByFHPPZmdPzq8+YpX7d+0jNS49ok9S63UtuLTuB/7pll8cSY/PH
         jEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bJDxiGn0zb+AtBhh3GrH3c02J/dSNj0T0Os6e9JU2HI=;
        b=If1IJ6thUimTQJ27TVSmJodIgWW5ocah+0YlwbPZYhlSli293vqREQb+Q7CKgW/3Gm
         f5WaYM47Cj7Yu/Pd2MxKBzTy2JFfmp9GTE4PIHQLN0kIdI3sUf8XbdULyeW7e4T1H9QS
         Ae6NU0D381d0kzqYFlxeJUkSyo5+5tsW37isUqITPJQKqlQwxNgk4QEfz4ctaUJ0N09Y
         cxRrsT1WQ6AASQy7f+RW4Y1mAPxUzUKt5Gb/OCnNRsmqmVwWxKcQX3to0/KnrkkEETW3
         8hrUNGu3/MxCy4uDhIl0nFzyo4fjX0sS9kX7BWcjZaptC07O9DJjlCXoXnzFV2EXuIMl
         emaA==
X-Gm-Message-State: AOAM533Fawz0joeP3BLx5HM8Qi89NQ/I4rQFb2lpGH1yyp5uudtIQGMw
        wCgnLXVYGHaoZrCyNl8Gktfw5A==
X-Google-Smtp-Source: ABdhPJyQi+hmIS6NcVuS5ZNb8DrPEY3M/Gs8RhNMfXIYA91WfDdO0PRAMZBlYQ8QD6rU6+FOVZG/Ug==
X-Received: by 2002:a62:4e57:0:b029:203:93bc:3cb with SMTP id c84-20020a624e570000b029020393bc03cbmr6022563pfb.56.1617256884685;
        Wed, 31 Mar 2021 23:01:24 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id a6sm4037328pfc.61.2021.03.31.23.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 23:01:24 -0700 (PDT)
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
Subject: [PATCH v4 6/6] riscv: dts: Add PCIe support for the SiFive FU740-C000 SoC
Date:   Thu,  1 Apr 2021 14:00:54 +0800
Message-Id: <20210401060054.40788-7-greentime.hu@sifive.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210401060054.40788-1-greentime.hu@sifive.com>
References: <20210401060054.40788-1-greentime.hu@sifive.com>
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
index d1bb22b11920..b2317c8e3a80 100644
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
@@ -288,5 +289,37 @@ gpio: gpio@10060000 {
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
2.30.2

