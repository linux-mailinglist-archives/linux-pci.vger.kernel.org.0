Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2101E12F86B
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2020 13:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgACMop (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jan 2020 07:44:45 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10607 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbgACMoo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jan 2020 07:44:44 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e0f370f0000>; Fri, 03 Jan 2020 04:43:59 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 03 Jan 2020 04:44:43 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 03 Jan 2020 04:44:43 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 3 Jan
 2020 12:44:42 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 3 Jan 2020 12:44:42 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.48]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e0f37360001>; Fri, 03 Jan 2020 04:44:42 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <andrew.murray@arm.com>
CC:     <kishon@ti.com>, <gustavo.pimentel@synopsys.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V2 4/5] arm64: tegra: Add PCIe endpoint controllers nodes for Tegra194
Date:   Fri, 3 Jan 2020 18:14:03 +0530
Message-ID: <20200103124404.20662-5-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103124404.20662-1-vidyas@nvidia.com>
References: <20200103124404.20662-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578055439; bh=xac6BIPCiBABuBWDcEKD6s1v473lfSFZmrKck0LoWXg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=YirXFPrBlbU+RDp7fP6br1X9dVL94iMT+wo2w+JrcZ8/YEa81PNLbuuLx/5tOuh8P
         stIFT4qFxE2/sUrQzsC6DGuoO9adbOYs7iwnN+Qcp12t8bqhfypGqw8nmk+WPWOj8/
         ouG+Ua+0Z6dwUDpufO0kmh6u9qe1dM4SkSaMuH3yg7n1ziKhPQg2kSErJwyKYrtWWC
         AtHg26emxJIKUwLaCoSUwejejir/UAyf8u6h3Jj4E6JZqFbHnlT8Z5Xv3ZlkapelRw
         DKqJ1GdR9Q1HgqSnXrfUYO6uyFp7TKRd92wmeNbd83pWa7vRveuuDQzFIeOlSEDyV5
         oT419jptPd4Zw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add endpoint mode controllers nodes for the dual mode PCIe controllers
present in Tegra194 SoC.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* None

 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 99 ++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 11220d97adb8..2c8fae854a23 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -1425,6 +1425,105 @@
 			  0x82000000 0x0  0x40000000 0x1f 0x40000000 0x0 0xc0000000>; /* non-prefetchable memory (3GB) */
 	};
 
+	pcie_ep@14160000 {
+		compatible = "nvidia,tegra194-pcie-ep", "snps,dw-pcie-ep";
+		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX4A>;
+		reg = <0x00 0x14160000 0x0 0x00020000   /* appl registers (128K)      */
+		       0x00 0x36040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  */
+		       0x00 0x36080000 0x0 0x00040000   /* DBI reg space (256K)       */
+		       0x14 0x00000000 0x4 0x00000000>; /* Address Space (16G)        */
+		reg-names = "appl", "atu_dma", "dbi", "addr_space";
+
+		status = "disabled";
+
+		num-lanes = <4>;
+		num-ib-windows = <2>;
+		num-ob-windows = <8>;
+
+		clocks = <&bpmp TEGRA194_CLK_PEX0_CORE_4>;
+		clock-names = "core";
+
+		resets = <&bpmp TEGRA194_RESET_PEX0_CORE_4_APB>,
+			 <&bpmp TEGRA194_RESET_PEX0_CORE_4>;
+		reset-names = "apb", "core";
+
+		interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;	/* controller interrupt */
+		interrupt-names = "intr";
+
+		nvidia,bpmp = <&bpmp 4>;
+
+		nvidia,aspm-cmrt-us = <60>;
+		nvidia,aspm-pwr-on-t-us = <20>;
+		nvidia,aspm-l0s-entrance-latency-us = <3>;
+	};
+
+	pcie_ep@14180000 {
+		compatible = "nvidia,tegra194-pcie-ep", "snps,dw-pcie-ep";
+		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8B>;
+		reg = <0x00 0x14180000 0x0 0x00020000   /* appl registers (128K)      */
+		       0x00 0x38040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  */
+		       0x00 0x38080000 0x0 0x00040000   /* DBI reg space (256K)       */
+		       0x18 0x00000000 0x4 0x00000000>; /* Address Space (16G)        */
+		reg-names = "appl", "atu_dma", "dbi", "addr_space";
+
+		status = "disabled";
+
+		num-lanes = <8>;
+		num-ib-windows = <2>;
+		num-ob-windows = <8>;
+
+		clocks = <&bpmp TEGRA194_CLK_PEX0_CORE_0>;
+		clock-names = "core";
+
+		resets = <&bpmp TEGRA194_RESET_PEX0_CORE_0_APB>,
+			 <&bpmp TEGRA194_RESET_PEX0_CORE_0>;
+		reset-names = "apb", "core";
+
+		interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;	/* controller interrupt */
+		interrupt-names = "intr";
+
+		nvidia,bpmp = <&bpmp 0>;
+
+		nvidia,aspm-cmrt-us = <60>;
+		nvidia,aspm-pwr-on-t-us = <20>;
+		nvidia,aspm-l0s-entrance-latency-us = <3>;
+	};
+
+	pcie_ep@141a0000 {
+		compatible = "nvidia,tegra194-pcie-ep", "snps,dw-pcie-ep";
+		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8A>;
+		reg = <0x00 0x141a0000 0x0 0x00020000   /* appl registers (128K)      */
+		       0x00 0x3a040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  */
+		       0x00 0x3a080000 0x0 0x00040000   /* DBI reg space (256K)       */
+		       0x1c 0x00000000 0x4 0x00000000>; /* Address Space (16G)        */
+		reg-names = "appl", "atu_dma", "dbi", "addr_space";
+
+		status = "disabled";
+
+		num-lanes = <8>;
+		num-ib-windows = <2>;
+		num-ob-windows = <8>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&clkreq_c5_bi_dir_state>;
+
+		clocks = <&bpmp TEGRA194_CLK_PEX1_CORE_5>;
+		clock-names = "core";
+
+		resets = <&bpmp TEGRA194_RESET_PEX1_CORE_5_APB>,
+			 <&bpmp TEGRA194_RESET_PEX1_CORE_5>;
+		reset-names = "apb", "core";
+
+		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;	/* controller interrupt */
+		interrupt-names = "intr";
+
+		nvidia,bpmp = <&bpmp 5>;
+
+		nvidia,aspm-cmrt-us = <60>;
+		nvidia,aspm-pwr-on-t-us = <20>;
+		nvidia,aspm-l0s-entrance-latency-us = <3>;
+	};
+
 	sysram@40000000 {
 		compatible = "nvidia,tegra194-sysram", "mmio-sram";
 		reg = <0x0 0x40000000 0x0 0x50000>;
-- 
2.17.1

