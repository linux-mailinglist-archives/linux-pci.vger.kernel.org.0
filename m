Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69F9821CA7
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2019 19:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfEQRkb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 May 2019 13:40:31 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9040 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfEQRkb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 May 2019 13:40:31 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cdef19f0000>; Fri, 17 May 2019 10:38:39 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 17 May 2019 10:38:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 17 May 2019 10:38:37 -0700
Received: from [10.25.74.217] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 17 May
 2019 17:38:30 +0000
Subject: Re: [PATCH V7 11/15] arm64: tegra: Add P2U and PCIe controller nodes
 to Tegra194 DT
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>, Kishon <kishon@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        <mmaddireddy@nvidia.com>, <kthota@nvidia.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <mperttunen@nvidia.com>, <linux-tegra@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <sagar.tv@gmail.com>
References: <20190517123846.3708-1-vidyas@nvidia.com>
 <20190517123846.3708-12-vidyas@nvidia.com>
 <CAKv+Gu909VM9o9AP4CfO_w6V9u=dgjONrjKhtWDCxZUE-zNwAA@mail.gmail.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <13fdf62e-a976-9fcc-8f65-172f1892d526@nvidia.com>
Date:   Fri, 17 May 2019 23:08:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu909VM9o9AP4CfO_w6V9u=dgjONrjKhtWDCxZUE-zNwAA@mail.gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558114719; bh=6llQ+KBtfsWchSlTca8t/rXpgoXUe+HvoL40JB3rZQA=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=DwFfVJrTR9fWvL3g4oOSU7LPx+Ir8qtfi0C9UUFTwUl0HiZKOIcDHSjFnfg8vOZcj
         LQ9mGMkg6gIeHo3SL/Rhucxmg2NLUKqkgFUGtAa9LTi7s9llgBUfn6F92iYQ8uZ/+n
         dJdw5uIAVWF1h8oxein619sImPQQ/gyD7AHRqQXPhnkPwJEVlcN+IncPGzJ3uQO33c
         EpPjA1NW9RDcgt7LoAzlOYRS4MlmAxiwpgoyMl8cvsBS5p7OUKkiMTgQ2F6AAfsgNl
         hdlMGL6QNR8JaF21l4ober+DVIuMciWumfF2fmRvlTeLipGq+J/bnH4gEJiYfpcrQR
         ZPSuy0Ubdfd1w==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/17/2019 6:33 PM, Ard Biesheuvel wrote:
> On Fri, 17 May 2019 at 14:41, Vidya Sagar <vidyas@nvidia.com> wrote:
>>
>> Add P2U (PIPE to UPHY) and PCIe controller nodes to device tree.
>> The Tegra194 SoC contains six PCIe controllers and twenty P2U instances
>> grouped into two different PHY bricks namely High-Speed IO (HSIO-12 P2Us)
>> and NVIDIA High Speed (NVHS-8 P2Us) respectively.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> Changes since [v6]:
>> * Removed properties "nvidia,disable-aspm-states" & "nvidia,controller-id".
>> * Modified property "nvidia,bpmp" to include controller-id as well.
>>
>> Changes since [v5]:
>> * Changes 'p2u@xxxxxxxx' to 'phy@xxxxxxxx'
>> * Arranged all PCIe nodes in the order of their addresses
>>
>> Changes since [v4]:
>> * None
>>
>> Changes since [v3]:
>> * None
>>
>> Changes since [v2]:
>> * Included 'hsio' or 'nvhs' in P2U node's label names to reflect which brick
>>    they belong to
>> * Removed leading zeros in unit address
>>
>> Changes since [v1]:
>> * Flattened all P2U nodes by removing 'hsio-p2u' and 'nvhs-p2u' super nodes
>> * Changed P2U nodes compatible string from 'nvidia,tegra194-phy-p2u' to 'nvidia,tegra194-p2u'
>> * Changed reg-name from 'base' to 'ctl'
>> * Updated all PCIe nodes according to the changes made to DT documentation file
>>
>>   arch/arm64/boot/dts/nvidia/tegra194.dtsi | 437 +++++++++++++++++++++++
>>   1 file changed, 437 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>> index c77ca211fa8f..838202150823 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>> @@ -884,6 +884,166 @@
>>                                  nvidia,interface = <3>;
>>                          };
>>                  };
>> +
>> +               p2u_hsio_0: phy@3e10000 {
>> +                       compatible = "nvidia,tegra194-p2u";
>> +                       reg = <0x03e10000 0x10000>;
>> +                       reg-names = "ctl";
>> +
>> +                       #phy-cells = <0>;
>> +               };
>> +
>> +               p2u_hsio_1: phy@3e20000 {
>> +                       compatible = "nvidia,tegra194-p2u";
>> +                       reg = <0x03e20000 0x10000>;
>> +                       reg-names = "ctl";
>> +
>> +                       #phy-cells = <0>;
>> +               };
>> +
>> +               p2u_hsio_2: phy@3e30000 {
>> +                       compatible = "nvidia,tegra194-p2u";
>> +                       reg = <0x03e30000 0x10000>;
>> +                       reg-names = "ctl";
>> +
>> +                       #phy-cells = <0>;
>> +               };
>> +
>> +               p2u_hsio_3: phy@3e40000 {
>> +                       compatible = "nvidia,tegra194-p2u";
>> +                       reg = <0x03e40000 0x10000>;
>> +                       reg-names = "ctl";
>> +
>> +                       #phy-cells = <0>;
>> +               };
>> +
>> +               p2u_hsio_4: phy@3e50000 {
>> +                       compatible = "nvidia,tegra194-p2u";
>> +                       reg = <0x03e50000 0x10000>;
>> +                       reg-names = "ctl";
>> +
>> +                       #phy-cells = <0>;
>> +               };
>> +
>> +               p2u_hsio_5: phy@3e60000 {
>> +                       compatible = "nvidia,tegra194-p2u";
>> +                       reg = <0x03e60000 0x10000>;
>> +                       reg-names = "ctl";
>> +
>> +                       #phy-cells = <0>;
>> +               };
>> +
>> +               p2u_hsio_6: phy@3e70000 {
>> +                       compatible = "nvidia,tegra194-p2u";
>> +                       reg = <0x03e70000 0x10000>;
>> +                       reg-names = "ctl";
>> +
>> +                       #phy-cells = <0>;
>> +               };
>> +
>> +               p2u_hsio_7: phy@3e80000 {
>> +                       compatible = "nvidia,tegra194-p2u";
>> +                       reg = <0x03e80000 0x10000>;
>> +                       reg-names = "ctl";
>> +
>> +                       #phy-cells = <0>;
>> +               };
>> +
>> +               p2u_hsio_8: phy@3e90000 {
>> +                       compatible = "nvidia,tegra194-p2u";
>> +                       reg = <0x03e90000 0x10000>;
>> +                       reg-names = "ctl";
>> +
>> +                       #phy-cells = <0>;
>> +               };
>> +
>> +               p2u_hsio_9: phy@3ea0000 {
>> +                       compatible = "nvidia,tegra194-p2u";
>> +                       reg = <0x03ea0000 0x10000>;
>> +                       reg-names = "ctl";
>> +
>> +                       #phy-cells = <0>;
>> +               };
>> +
>> +               p2u_nvhs_0: phy@3eb0000 {
>> +                       compatible = "nvidia,tegra194-p2u";
>> +                       reg = <0x03eb0000 0x10000>;
>> +                       reg-names = "ctl";
>> +
>> +                       #phy-cells = <0>;
>> +               };
>> +
>> +               p2u_nvhs_1: phy@3ec0000 {
>> +                       compatible = "nvidia,tegra194-p2u";
>> +                       reg = <0x03ec0000 0x10000>;
>> +                       reg-names = "ctl";
>> +
>> +                       #phy-cells = <0>;
>> +               };
>> +
>> +               p2u_nvhs_2: phy@3ed0000 {
>> +                       compatible = "nvidia,tegra194-p2u";
>> +                       reg = <0x03ed0000 0x10000>;
>> +                       reg-names = "ctl";
>> +
>> +                       #phy-cells = <0>;
>> +               };
>> +
>> +               p2u_nvhs_3: phy@3ee0000 {
>> +                       compatible = "nvidia,tegra194-p2u";
>> +                       reg = <0x03ee0000 0x10000>;
>> +                       reg-names = "ctl";
>> +
>> +                       #phy-cells = <0>;
>> +               };
>> +
>> +               p2u_nvhs_4: phy@3ef0000 {
>> +                       compatible = "nvidia,tegra194-p2u";
>> +                       reg = <0x03ef0000 0x10000>;
>> +                       reg-names = "ctl";
>> +
>> +                       #phy-cells = <0>;
>> +               };
>> +
>> +               p2u_nvhs_5: phy@3f00000 {
>> +                       compatible = "nvidia,tegra194-p2u";
>> +                       reg = <0x03f00000 0x10000>;
>> +                       reg-names = "ctl";
>> +
>> +                       #phy-cells = <0>;
>> +               };
>> +
>> +               p2u_nvhs_6: phy@3f10000 {
>> +                       compatible = "nvidia,tegra194-p2u";
>> +                       reg = <0x03f10000 0x10000>;
>> +                       reg-names = "ctl";
>> +
>> +                       #phy-cells = <0>;
>> +               };
>> +
>> +               p2u_nvhs_7: phy@3f20000 {
>> +                       compatible = "nvidia,tegra194-p2u";
>> +                       reg = <0x03f20000 0x10000>;
>> +                       reg-names = "ctl";
>> +
>> +                       #phy-cells = <0>;
>> +               };
>> +
>> +               p2u_hsio_10: phy@3f30000 {
>> +                       compatible = "nvidia,tegra194-p2u";
>> +                       reg = <0x03f30000 0x10000>;
>> +                       reg-names = "ctl";
>> +
>> +                       #phy-cells = <0>;
>> +               };
>> +
>> +               p2u_hsio_11: phy@3f40000 {
>> +                       compatible = "nvidia,tegra194-p2u";
>> +                       reg = <0x03f40000 0x10000>;
>> +                       reg-names = "ctl";
>> +
>> +                       #phy-cells = <0>;
>> +               };
>>          };
>>
>>          sysram@40000000 {
>> @@ -1054,4 +1214,281 @@
>>                                  (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>>                  interrupt-parent = <&gic>;
>>          };
>> +
>> +       pcie@14100000 {
>> +               compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
>> +               power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX1A>;
>> +               reg = <0x00 0x14100000 0x0 0x00020000   /* appl registers (128K)      */
>> +                      0x00 0x30000000 0x0 0x00040000   /* configuration space (256K) */
>> +                      0x00 0x30040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  */
>> +                      0x00 0x30080000 0x0 0x00040000>; /* DBI reg space (256K)       */
>> +               reg-names = "appl", "config", "atu_dma", "dbi";
>> +
>> +               status = "disabled";
>> +
>> +               #address-cells = <3>;
>> +               #size-cells = <2>;
>> +               device_type = "pci";
>> +               num-lanes = <1>;
>> +               num-viewport = <8>;
>> +               linux,pci-domain = <1>;
>> +
>> +               clocks = <&bpmp TEGRA194_CLK_PEX0_CORE_1>;
>> +               clock-names = "core";
>> +
>> +               resets = <&bpmp TEGRA194_RESET_PEX0_CORE_1_APB>,
>> +                        <&bpmp TEGRA194_RESET_PEX0_CORE_1>;
>> +               reset-names = "core_apb", "core";
>> +
>> +               interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,  /* controller interrupt */
>> +                            <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;  /* MSI interrupt */
>> +               interrupt-names = "intr", "msi";
>> +
>> +               #interrupt-cells = <1>;
>> +               interrupt-map-mask = <0 0 0 0>;
>> +               interrupt-map = <0 0 0 0 &gic 0 45 0x04>;
> 
> Please use the GIC_SPI and IRQ_TYPE_LEVEL_HIGH macros here as well.
I'll take care of it in the next patch series.

> 
>> +
>> +               nvidia,bpmp = <&bpmp 1>;
>> +
>> +               supports-clkreq;
>> +               nvidia,aspm-cmrt-us = <60>;
>> +               nvidia,aspm-pwr-on-t-us = <20>;
>> +               nvidia,aspm-l0s-entrance-latency-us = <3>;
>> +
>> +               bus-range = <0x0 0xff>;
>> +               ranges = <0x81000000 0x0 0x30100000 0x0 0x30100000 0x0 0x00100000    /* downstream I/O (1MB) */
>> +                         0xc2000000 0x12 0x00000000 0x12 0x00000000 0x0 0x30000000  /* prefetchable memory (768MB) */
>> +                         0x82000000 0x0 0x40000000 0x12 0x30000000 0x0 0x10000000>; /* non-prefetchable memory (256MB) */
>> +       };
>> +
>> +       pcie@14120000 {
>> +               compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
>> +               power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX1A>;
>> +               reg = <0x00 0x14120000 0x0 0x00020000   /* appl registers (128K)      */
>> +                      0x00 0x32000000 0x0 0x00040000   /* configuration space (256K) */
>> +                      0x00 0x32040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  */
>> +                      0x00 0x32080000 0x0 0x00040000>; /* DBI reg space (256K)       */
>> +               reg-names = "appl", "config", "atu_dma", "dbi";
>> +
>> +               status = "disabled";
>> +
>> +               #address-cells = <3>;
>> +               #size-cells = <2>;
>> +               device_type = "pci";
>> +               num-lanes = <1>;
>> +               num-viewport = <8>;
>> +               linux,pci-domain = <2>;
>> +
>> +               clocks = <&bpmp TEGRA194_CLK_PEX0_CORE_2>;
>> +               clock-names = "core";
>> +
>> +               resets = <&bpmp TEGRA194_RESET_PEX0_CORE_2_APB>,
>> +                        <&bpmp TEGRA194_RESET_PEX0_CORE_2>;
>> +               reset-names = "core_apb", "core";
>> +
>> +               interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,  /* controller interrupt */
>> +                            <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;  /* MSI interrupt */
>> +               interrupt-names = "intr", "msi";
>> +
>> +               #interrupt-cells = <1>;
>> +               interrupt-map-mask = <0 0 0 0>;
>> +               interrupt-map = <0 0 0 0 &gic 0 47 0x04>;
>> +
>> +               nvidia,bpmp = <&bpmp 2>;
>> +
>> +               supports-clkreq;
>> +               nvidia,aspm-cmrt-us = <60>;
>> +               nvidia,aspm-pwr-on-t-us = <20>;
>> +               nvidia,aspm-l0s-entrance-latency-us = <3>;
>> +
>> +               bus-range = <0x0 0xff>;
>> +               ranges = <0x81000000 0x0 0x32100000 0x0 0x32100000 0x0 0x00100000    /* downstream I/O (1MB) */
>> +                         0xc2000000 0x12 0x40000000 0x12 0x40000000 0x0 0x30000000  /* prefetchable memory (768MB) */
>> +                         0x82000000 0x0 0x40000000 0x12 0x70000000 0x0 0x10000000>; /* non-prefetchable memory (256MB) */
>> +       };
>> +
>> +       pcie@14140000 {
>> +               compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
>> +               power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX1A>;
>> +               reg = <0x00 0x14140000 0x0 0x00020000   /* appl registers (128K)      */
>> +                      0x00 0x34000000 0x0 0x00040000   /* configuration space (256K) */
>> +                      0x00 0x34040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  */
>> +                      0x00 0x34080000 0x0 0x00040000>; /* DBI reg space (256K)       */
>> +               reg-names = "appl", "config", "atu_dma", "dbi";
>> +
>> +               status = "disabled";
>> +
>> +               #address-cells = <3>;
>> +               #size-cells = <2>;
>> +               device_type = "pci";
>> +               num-lanes = <1>;
>> +               num-viewport = <8>;
>> +               linux,pci-domain = <3>;
>> +
>> +               clocks = <&bpmp TEGRA194_CLK_PEX0_CORE_3>;
>> +               clock-names = "core";
>> +
>> +               resets = <&bpmp TEGRA194_RESET_PEX0_CORE_3_APB>,
>> +                        <&bpmp TEGRA194_RESET_PEX0_CORE_3>;
>> +               reset-names = "core_apb", "core";
>> +
>> +               interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,  /* controller interrupt */
>> +                            <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;  /* MSI interrupt */
>> +               interrupt-names = "intr", "msi";
>> +
>> +               #interrupt-cells = <1>;
>> +               interrupt-map-mask = <0 0 0 0>;
>> +               interrupt-map = <0 0 0 0 &gic 0 49 0x04>;
>> +
>> +               nvidia,bpmp = <&bpmp 3>;
>> +
>> +               supports-clkreq;
>> +               nvidia,aspm-cmrt-us = <60>;
>> +               nvidia,aspm-pwr-on-t-us = <20>;
>> +               nvidia,aspm-l0s-entrance-latency-us = <3>;
>> +
>> +               bus-range = <0x0 0xff>;
>> +               ranges = <0x81000000 0x0 0x34100000 0x0 0x34100000 0x0 0x00100000    /* downstream I/O (1MB) */
>> +                         0xc2000000 0x12 0x80000000 0x12 0x80000000 0x0 0x30000000  /* prefetchable memory (768MB) */
>> +                         0x82000000 0x0 0x40000000 0x12 0xb0000000 0x0 0x10000000>; /* non-prefetchable memory (256MB) */
>> +       };
>> +
>> +       pcie@14160000 {
>> +               compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
>> +               power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX4A>;
>> +               reg = <0x00 0x14160000 0x0 0x00020000   /* appl registers (128K)      */
>> +                      0x00 0x36000000 0x0 0x00040000   /* configuration space (256K) */
>> +                      0x00 0x36040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  */
>> +                      0x00 0x36080000 0x0 0x00040000>; /* DBI reg space (256K)       */
>> +               reg-names = "appl", "config", "atu_dma", "dbi";
>> +
>> +               status = "disabled";
>> +
>> +               #address-cells = <3>;
>> +               #size-cells = <2>;
>> +               device_type = "pci";
>> +               num-lanes = <4>;
>> +               num-viewport = <8>;
>> +               linux,pci-domain = <4>;
>> +
>> +               clocks = <&bpmp TEGRA194_CLK_PEX0_CORE_4>;
>> +               clock-names = "core";
>> +
>> +               resets = <&bpmp TEGRA194_RESET_PEX0_CORE_4_APB>,
>> +                        <&bpmp TEGRA194_RESET_PEX0_CORE_4>;
>> +               reset-names = "core_apb", "core";
>> +
>> +               interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,  /* controller interrupt */
>> +                            <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;  /* MSI interrupt */
>> +               interrupt-names = "intr", "msi";
>> +
>> +               #interrupt-cells = <1>;
>> +               interrupt-map-mask = <0 0 0 0>;
>> +               interrupt-map = <0 0 0 0 &gic 0 51 0x04>;
>> +
>> +               nvidia,bpmp = <&bpmp 4>;
>> +
>> +               supports-clkreq;
>> +               nvidia,aspm-cmrt-us = <60>;
>> +               nvidia,aspm-pwr-on-t-us = <20>;
>> +               nvidia,aspm-l0s-entrance-latency-us = <3>;
>> +
>> +               bus-range = <0x0 0xff>;
>> +               ranges = <0x81000000 0x0 0x36100000 0x0 0x36100000 0x0 0x00100000    /* downstream I/O (1MB) */
>> +                         0xc2000000 0x14 0x00000000 0x14 0x00000000 0x3 0x40000000  /* prefetchable memory (13GB) */
>> +                         0x82000000 0x0 0x40000000 0x17 0x40000000 0x0 0xc0000000>; /* non-prefetchable memory (3GB) */
>> +       };
>> +
>> +       pcie@14180000 {
>> +               compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
>> +               power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8B>;
>> +               reg = <0x00 0x14180000 0x0 0x00020000   /* appl registers (128K)      */
>> +                      0x00 0x38000000 0x0 0x00040000   /* configuration space (256K) */
>> +                      0x00 0x38040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  */
>> +                      0x00 0x38080000 0x0 0x00040000>; /* DBI reg space (256K)       */
>> +               reg-names = "appl", "config", "atu_dma", "dbi";
>> +
>> +               status = "disabled";
>> +
>> +               #address-cells = <3>;
>> +               #size-cells = <2>;
>> +               device_type = "pci";
>> +               num-lanes = <8>;
>> +               num-viewport = <8>;
>> +               linux,pci-domain = <0>;
>> +
>> +               clocks = <&bpmp TEGRA194_CLK_PEX0_CORE_0>;
>> +               clock-names = "core";
>> +
>> +               resets = <&bpmp TEGRA194_RESET_PEX0_CORE_0_APB>,
>> +                        <&bpmp TEGRA194_RESET_PEX0_CORE_0>;
>> +               reset-names = "core_apb", "core";
>> +
>> +               interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,  /* controller interrupt */
>> +                            <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;  /* MSI interrupt */
>> +               interrupt-names = "intr", "msi";
>> +
>> +               #interrupt-cells = <1>;
>> +               interrupt-map-mask = <0 0 0 0>;
>> +               interrupt-map = <0 0 0 0 &gic 0 72 0x04>;
>> +
>> +               nvidia,bpmp = <&bpmp 0>;
>> +
>> +               supports-clkreq;
>> +               nvidia,aspm-cmrt-us = <60>;
>> +               nvidia,aspm-pwr-on-t-us = <20>;
>> +               nvidia,aspm-l0s-entrance-latency-us = <3>;
>> +
>> +               bus-range = <0x0 0xff>;
>> +               ranges = <0x81000000 0x0 0x38100000 0x0 0x38100000 0x0 0x00100000    /* downstream I/O (1MB) */
>> +                         0xc2000000 0x18 0x00000000 0x18 0x00000000 0x3 0x40000000  /* prefetchable memory (13GB) */
>> +                         0x82000000 0x0 0x40000000 0x1b 0x40000000 0x0 0xc0000000>; /* non-prefetchable memory (3GB) */
>> +       };
>> +
>> +       pcie@141a0000 {
>> +               compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
>> +               power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8A>;
>> +               reg = <0x00 0x141a0000 0x0 0x00020000   /* appl registers (128K)      */
>> +                      0x00 0x3a000000 0x0 0x00040000   /* configuration space (256K) */
>> +                      0x00 0x3a040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  */
>> +                      0x00 0x3a080000 0x0 0x00040000>; /* DBI reg space (256K)       */
>> +               reg-names = "appl", "config", "atu_dma", "dbi";
>> +
>> +               status = "disabled";
>> +
>> +               #address-cells = <3>;
>> +               #size-cells = <2>;
>> +               device_type = "pci";
>> +               num-lanes = <8>;
>> +               num-viewport = <8>;
>> +               linux,pci-domain = <5>;
>> +
>> +               clocks = <&bpmp TEGRA194_CLK_PEX1_CORE_5>,
>> +                       <&bpmp TEGRA194_CLK_PEX1_CORE_5M>;
>> +               clock-names = "core", "core_m";
>> +
>> +               resets = <&bpmp TEGRA194_RESET_PEX1_CORE_5_APB>,
>> +                        <&bpmp TEGRA194_RESET_PEX1_CORE_5>;
>> +               reset-names = "core_apb", "core";
>> +
>> +               interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,  /* controller interrupt */
>> +                            <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;  /* MSI interrupt */
>> +               interrupt-names = "intr", "msi";
>> +
>> +               nvidia,bpmp = <&bpmp 5>;
>> +
>> +               #interrupt-cells = <1>;
>> +               interrupt-map-mask = <0 0 0 0>;
>> +               interrupt-map = <0 0 0 0 &gic 0 53 0x04>;
>> +
>> +               supports-clkreq;
>> +               nvidia,aspm-cmrt-us = <60>;
>> +               nvidia,aspm-pwr-on-t-us = <20>;
>> +               nvidia,aspm-l0s-entrance-latency-us = <3>;
>> +
>> +               bus-range = <0x0 0xff>;
>> +               ranges = <0x81000000 0x0 0x3a100000 0x0 0x3a100000 0x0 0x00100000    /* downstream I/O (1MB) */
>> +                         0xc2000000 0x1c 0x00000000 0x1c 0x00000000 0x3 0x40000000  /* prefetchable memory (13GB) */
>> +                         0x82000000 0x0 0x40000000 0x1f 0x40000000 0x0 0xc0000000>; /* non-prefetchable memory (3GB) */
>> +       };
>>   };
>> --
>> 2.17.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

