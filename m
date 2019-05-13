Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A14E1AFD7
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2019 07:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfEMFIZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 May 2019 01:08:25 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5157 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbfEMFIZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 May 2019 01:08:25 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd8fb9c0000>; Sun, 12 May 2019 22:07:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 12 May 2019 22:08:19 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 12 May 2019 22:08:19 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 May
 2019 05:08:18 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 May
 2019 05:08:18 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 13 May 2019 05:08:18 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cd8fbbe0000>; Sun, 12 May 2019 22:08:18 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <kishon@ti.com>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V6 11/15] arm64: tegra: Add P2U and PCIe controller nodes to Tegra194 DT
Date:   Mon, 13 May 2019 10:36:22 +0530
Message-ID: <20190513050626.14991-12-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513050626.14991-1-vidyas@nvidia.com>
References: <20190513050626.14991-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557724060; bh=EgoI9UGK/LoDpb6MObgKHS6pFkCgIi/VTQG42OePsDk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=AIHM33i51H57k8S3Hl/jISkf9Dn0DHQgRnyi6Ny456Fr9biUXsXrbnZlhQnDHPVyw
         Bqr8g5e1GvqM2CZAWvtmL8mPr0MLC8a6+Af/XViCWuQOsUwdTnA0pR7fEqhoWpu2Xg
         tnY1XpLAVs11AMl4yKDKpTZEfoXjFiLyTY4fASnwidWhM63vrHe6aHbL6K0LDEr53f
         h1z9kHMBBwoSjqGbYbQb8lYRkN2bU0rRHX+ZHbTVt/E0TRBrexnhflpntaJpuAE4uv
         /UN3cw5XMAXwuJ4hFNhytLKkrlpGNIQir8ButYmXiUbH6l/TVK/azlGMPDLcu0DNtN
         fqnPAk4p0iBjA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add P2U (PIPE to UPHY) and PCIe controller nodes to device tree.
The Tegra194 SoC contains six PCIe controllers and twenty P2U instances
grouped into two different PHY bricks namely High-Speed IO (HSIO-12 P2Us)
and NVIDIA High Speed (NVHS-8 P2Us) respectively.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
Changes since [v5]:
* Changes 'p2u@xxxxxxxx' to 'phy@xxxxxxxx'
* Arranged all PCIe nodes in the order of their addresses

Changes since [v4]:
* None

Changes since [v3]:
* None

Changes since [v2]:
* Included 'hsio' or 'nvhs' in P2U node's label names to reflect which brick
  they belong to
* Removed leading zeros in unit address

Changes since [v1]:
* Flattened all P2U nodes by removing 'hsio-p2u' and 'nvhs-p2u' super nodes
* Changed P2U nodes compatible string from 'nvidia,tegra194-phy-p2u' to 'nvidia,tegra194-p2u'
* Changed reg-name from 'base' to 'ctl'
* Updated all PCIe nodes according to the changes made to DT documentation file

 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 449 +++++++++++++++++++++++
 1 file changed, 449 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index c77ca211fa8f..b4a47dbdf8e6 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -884,6 +884,166 @@
 				nvidia,interface = <3>;
 			};
 		};
+
+		p2u_hsio_0: phy@3e10000 {
+			compatible = "nvidia,tegra194-p2u";
+			reg = <0x03e10000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_hsio_1: phy@3e20000 {
+			compatible = "nvidia,tegra194-p2u";
+			reg = <0x03e20000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_hsio_2: phy@3e30000 {
+			compatible = "nvidia,tegra194-p2u";
+			reg = <0x03e30000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_hsio_3: phy@3e40000 {
+			compatible = "nvidia,tegra194-p2u";
+			reg = <0x03e40000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_hsio_4: phy@3e50000 {
+			compatible = "nvidia,tegra194-p2u";
+			reg = <0x03e50000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_hsio_5: phy@3e60000 {
+			compatible = "nvidia,tegra194-p2u";
+			reg = <0x03e60000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_hsio_6: phy@3e70000 {
+			compatible = "nvidia,tegra194-p2u";
+			reg = <0x03e70000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_hsio_7: phy@3e80000 {
+			compatible = "nvidia,tegra194-p2u";
+			reg = <0x03e80000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_hsio_8: phy@3e90000 {
+			compatible = "nvidia,tegra194-p2u";
+			reg = <0x03e90000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_hsio_9: phy@3ea0000 {
+			compatible = "nvidia,tegra194-p2u";
+			reg = <0x03ea0000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_nvhs_0: phy@3eb0000 {
+			compatible = "nvidia,tegra194-p2u";
+			reg = <0x03eb0000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_nvhs_1: phy@3ec0000 {
+			compatible = "nvidia,tegra194-p2u";
+			reg = <0x03ec0000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_nvhs_2: phy@3ed0000 {
+			compatible = "nvidia,tegra194-p2u";
+			reg = <0x03ed0000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_nvhs_3: phy@3ee0000 {
+			compatible = "nvidia,tegra194-p2u";
+			reg = <0x03ee0000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_nvhs_4: phy@3ef0000 {
+			compatible = "nvidia,tegra194-p2u";
+			reg = <0x03ef0000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_nvhs_5: phy@3f00000 {
+			compatible = "nvidia,tegra194-p2u";
+			reg = <0x03f00000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_nvhs_6: phy@3f10000 {
+			compatible = "nvidia,tegra194-p2u";
+			reg = <0x03f10000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_nvhs_7: phy@3f20000 {
+			compatible = "nvidia,tegra194-p2u";
+			reg = <0x03f20000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_hsio_10: phy@3f30000 {
+			compatible = "nvidia,tegra194-p2u";
+			reg = <0x03f30000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_hsio_11: phy@3f40000 {
+			compatible = "nvidia,tegra194-p2u";
+			reg = <0x03f40000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
 	};
 
 	sysram@40000000 {
@@ -1054,4 +1214,293 @@
 				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 		interrupt-parent = <&gic>;
 	};
+
+	pcie@14100000 {
+		compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
+		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX1A>;
+		reg = <0x00 0x14100000 0x0 0x00020000   /* appl registers (128K)      */
+		       0x00 0x30000000 0x0 0x00040000   /* configuration space (256K) */
+		       0x00 0x30040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  */
+		       0x00 0x30080000 0x0 0x00040000>; /* DBI reg space (256K)       */
+		reg-names = "appl", "config", "atu_dma", "dbi";
+
+		status = "disabled";
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		num-lanes = <1>;
+		num-viewport = <8>;
+		linux,pci-domain = <1>;
+
+		clocks = <&bpmp TEGRA194_CLK_PEX0_CORE_1>;
+		clock-names = "core";
+
+		resets = <&bpmp TEGRA194_RESET_PEX0_CORE_1_APB>,
+			 <&bpmp TEGRA194_RESET_PEX0_CORE_1>;
+		reset-names = "core_apb", "core";
+
+		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,	/* controller interrupt */
+			     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;	/* MSI interrupt */
+		interrupt-names = "intr", "msi";
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic 0 45 0x04>;
+
+		nvidia,bpmp = <&bpmp>;
+
+		supports-clkreq;
+		nvidia,disable-aspm-states = <0xf>;
+		nvidia,controller-id = <1>;
+		nvidia,aspm-cmrt-us = <60>;
+		nvidia,aspm-pwr-on-t-us = <20>;
+		nvidia,aspm-l0s-entrance-latency-us = <3>;
+
+		bus-range = <0x0 0xff>;
+		ranges = <0x81000000 0x0 0x30100000 0x0 0x30100000 0x0 0x00100000    /* downstream I/O (1MB) */
+			  0xc2000000 0x12 0x00000000 0x12 0x00000000 0x0 0x30000000  /* prefetchable memory (768MB) */
+			  0x82000000 0x0 0x40000000 0x12 0x30000000 0x0 0x10000000>; /* non-prefetchable memory (256MB) */
+	};
+
+	pcie@14120000 {
+		compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
+		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX1A>;
+		reg = <0x00 0x14120000 0x0 0x00020000   /* appl registers (128K)      */
+		       0x00 0x32000000 0x0 0x00040000   /* configuration space (256K) */
+		       0x00 0x32040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  */
+		       0x00 0x32080000 0x0 0x00040000>; /* DBI reg space (256K)       */
+		reg-names = "appl", "config", "atu_dma", "dbi";
+
+		status = "disabled";
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		num-lanes = <1>;
+		num-viewport = <8>;
+		linux,pci-domain = <2>;
+
+		clocks = <&bpmp TEGRA194_CLK_PEX0_CORE_2>;
+		clock-names = "core";
+
+		resets = <&bpmp TEGRA194_RESET_PEX0_CORE_2_APB>,
+			 <&bpmp TEGRA194_RESET_PEX0_CORE_2>;
+		reset-names = "core_apb", "core";
+
+		interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,	/* controller interrupt */
+			     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;	/* MSI interrupt */
+		interrupt-names = "intr", "msi";
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic 0 47 0x04>;
+
+		nvidia,bpmp = <&bpmp>;
+
+		supports-clkreq;
+		nvidia,disable-aspm-states = <0xf>;
+		nvidia,controller-id = <2>;
+		nvidia,aspm-cmrt-us = <60>;
+		nvidia,aspm-pwr-on-t-us = <20>;
+		nvidia,aspm-l0s-entrance-latency-us = <3>;
+
+		bus-range = <0x0 0xff>;
+		ranges = <0x81000000 0x0 0x32100000 0x0 0x32100000 0x0 0x00100000    /* downstream I/O (1MB) */
+			  0xc2000000 0x12 0x40000000 0x12 0x40000000 0x0 0x30000000  /* prefetchable memory (768MB) */
+			  0x82000000 0x0 0x40000000 0x12 0x70000000 0x0 0x10000000>; /* non-prefetchable memory (256MB) */
+	};
+
+	pcie@14140000 {
+		compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
+		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX1A>;
+		reg = <0x00 0x14140000 0x0 0x00020000   /* appl registers (128K)      */
+		       0x00 0x34000000 0x0 0x00040000   /* configuration space (256K) */
+		       0x00 0x34040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  */
+		       0x00 0x34080000 0x0 0x00040000>; /* DBI reg space (256K)       */
+		reg-names = "appl", "config", "atu_dma", "dbi";
+
+		status = "disabled";
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		num-lanes = <1>;
+		num-viewport = <8>;
+		linux,pci-domain = <3>;
+
+		clocks = <&bpmp TEGRA194_CLK_PEX0_CORE_3>;
+		clock-names = "core";
+
+		resets = <&bpmp TEGRA194_RESET_PEX0_CORE_3_APB>,
+			 <&bpmp TEGRA194_RESET_PEX0_CORE_3>;
+		reset-names = "core_apb", "core";
+
+		interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,	/* controller interrupt */
+			     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;	/* MSI interrupt */
+		interrupt-names = "intr", "msi";
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic 0 49 0x04>;
+
+		nvidia,bpmp = <&bpmp>;
+
+		supports-clkreq;
+		nvidia,disable-aspm-states = <0xf>;
+		nvidia,controller-id = <3>;
+		nvidia,aspm-cmrt-us = <60>;
+		nvidia,aspm-pwr-on-t-us = <20>;
+		nvidia,aspm-l0s-entrance-latency-us = <3>;
+
+		bus-range = <0x0 0xff>;
+		ranges = <0x81000000 0x0 0x34100000 0x0 0x34100000 0x0 0x00100000    /* downstream I/O (1MB) */
+			  0xc2000000 0x12 0x80000000 0x12 0x80000000 0x0 0x30000000  /* prefetchable memory (768MB) */
+			  0x82000000 0x0 0x40000000 0x12 0xb0000000 0x0 0x10000000>; /* non-prefetchable memory (256MB) */
+	};
+
+	pcie@14160000 {
+		compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
+		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX4A>;
+		reg = <0x00 0x14160000 0x0 0x00020000   /* appl registers (128K)      */
+		       0x00 0x36000000 0x0 0x00040000   /* configuration space (256K) */
+		       0x00 0x36040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  */
+		       0x00 0x36080000 0x0 0x00040000>; /* DBI reg space (256K)       */
+		reg-names = "appl", "config", "atu_dma", "dbi";
+
+		status = "disabled";
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		num-lanes = <4>;
+		num-viewport = <8>;
+		linux,pci-domain = <4>;
+
+		clocks = <&bpmp TEGRA194_CLK_PEX0_CORE_4>;
+		clock-names = "core";
+
+		resets = <&bpmp TEGRA194_RESET_PEX0_CORE_4_APB>,
+			 <&bpmp TEGRA194_RESET_PEX0_CORE_4>;
+		reset-names = "core_apb", "core";
+
+		interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,	/* controller interrupt */
+			     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;	/* MSI interrupt */
+		interrupt-names = "intr", "msi";
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic 0 51 0x04>;
+
+		nvidia,bpmp = <&bpmp>;
+
+		supports-clkreq;
+		nvidia,disable-aspm-states = <0xf>;
+		nvidia,controller-id = <4>;
+		nvidia,aspm-cmrt-us = <60>;
+		nvidia,aspm-pwr-on-t-us = <20>;
+		nvidia,aspm-l0s-entrance-latency-us = <3>;
+
+		bus-range = <0x0 0xff>;
+		ranges = <0x81000000 0x0 0x36100000 0x0 0x36100000 0x0 0x00100000    /* downstream I/O (1MB) */
+			  0xc2000000 0x14 0x00000000 0x14 0x00000000 0x3 0x40000000  /* prefetchable memory (13GB) */
+			  0x82000000 0x0 0x40000000 0x17 0x40000000 0x0 0xc0000000>; /* non-prefetchable memory (3GB) */
+	};
+
+	pcie@14180000 {
+		compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
+		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8B>;
+		reg = <0x00 0x14180000 0x0 0x00020000   /* appl registers (128K)      */
+		       0x00 0x38000000 0x0 0x00040000   /* configuration space (256K) */
+		       0x00 0x38040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  */
+		       0x00 0x38080000 0x0 0x00040000>; /* DBI reg space (256K)       */
+		reg-names = "appl", "config", "atu_dma", "dbi";
+
+		status = "disabled";
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		num-lanes = <8>;
+		num-viewport = <8>;
+		linux,pci-domain = <0>;
+
+		clocks = <&bpmp TEGRA194_CLK_PEX0_CORE_0>;
+		clock-names = "core";
+
+		resets = <&bpmp TEGRA194_RESET_PEX0_CORE_0_APB>,
+			 <&bpmp TEGRA194_RESET_PEX0_CORE_0>;
+		reset-names = "core_apb", "core";
+
+		interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,	/* controller interrupt */
+			     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;	/* MSI interrupt */
+		interrupt-names = "intr", "msi";
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic 0 72 0x04>;
+
+		nvidia,bpmp = <&bpmp>;
+
+		supports-clkreq;
+		nvidia,disable-aspm-states = <0xf>;
+		nvidia,controller-id = <0>;
+		nvidia,aspm-cmrt-us = <60>;
+		nvidia,aspm-pwr-on-t-us = <20>;
+		nvidia,aspm-l0s-entrance-latency-us = <3>;
+
+		bus-range = <0x0 0xff>;
+		ranges = <0x81000000 0x0 0x38100000 0x0 0x38100000 0x0 0x00100000    /* downstream I/O (1MB) */
+			  0xc2000000 0x18 0x00000000 0x18 0x00000000 0x3 0x40000000  /* prefetchable memory (13GB) */
+			  0x82000000 0x0 0x40000000 0x1b 0x40000000 0x0 0xc0000000>; /* non-prefetchable memory (3GB) */
+	};
+
+	pcie@141a0000 {
+		compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
+		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8A>;
+		reg = <0x00 0x141a0000 0x0 0x00020000   /* appl registers (128K)      */
+		       0x00 0x3a000000 0x0 0x00040000   /* configuration space (256K) */
+		       0x00 0x3a040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  */
+		       0x00 0x3a080000 0x0 0x00040000>; /* DBI reg space (256K)       */
+		reg-names = "appl", "config", "atu_dma", "dbi";
+
+		status = "disabled";
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		num-lanes = <8>;
+		num-viewport = <8>;
+		linux,pci-domain = <5>;
+
+		clocks = <&bpmp TEGRA194_CLK_PEX1_CORE_5>,
+			<&bpmp TEGRA194_CLK_PEX1_CORE_5M>;
+		clock-names = "core", "core_m";
+
+		resets = <&bpmp TEGRA194_RESET_PEX1_CORE_5_APB>,
+			 <&bpmp TEGRA194_RESET_PEX1_CORE_5>;
+		reset-names = "core_apb", "core";
+
+		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,	/* controller interrupt */
+			     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;	/* MSI interrupt */
+		interrupt-names = "intr", "msi";
+
+		nvidia,bpmp = <&bpmp>;
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic 0 53 0x04>;
+
+		supports-clkreq;
+		nvidia,disable-aspm-states = <0xf>;
+		nvidia,controller-id = <5>;
+		nvidia,aspm-cmrt-us = <60>;
+		nvidia,aspm-pwr-on-t-us = <20>;
+		nvidia,aspm-l0s-entrance-latency-us = <3>;
+
+		bus-range = <0x0 0xff>;
+		ranges = <0x81000000 0x0 0x3a100000 0x0 0x3a100000 0x0 0x00100000    /* downstream I/O (1MB) */
+			  0xc2000000 0x1c 0x00000000 0x1c 0x00000000 0x3 0x40000000  /* prefetchable memory (13GB) */
+			  0x82000000 0x0 0x40000000 0x1f 0x40000000 0x0 0xc0000000>; /* non-prefetchable memory (3GB) */
+	};
 };
-- 
2.17.1

