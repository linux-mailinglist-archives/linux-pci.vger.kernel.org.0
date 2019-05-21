Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0707325727
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2019 20:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbfEUSBL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 May 2019 14:01:11 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7455 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbfEUSBL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 May 2019 14:01:11 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce43ce40003>; Tue, 21 May 2019 11:01:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 21 May 2019 11:01:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 21 May 2019 11:01:08 -0700
Received: from [10.25.72.115] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 May
 2019 18:00:59 +0000
Subject: Re: [PATCH V7 09/15] dt-bindings: PCI: tegra: Add device tree support
 for Tegra194
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190517123846.3708-1-vidyas@nvidia.com>
 <20190517123846.3708-10-vidyas@nvidia.com> <20190521105155.GI29166@ulmo>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <685e2d5e-e89a-6ebe-16d8-7866a7b3b877@nvidia.com>
Date:   Tue, 21 May 2019 23:30:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521105155.GI29166@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558461668; bh=Diq89/qQO4m9nwaaQMPCoztM6NXrKjoxUvNHoWtzgBg=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=J0vHYpz3PBl3BYskr7kmIK0yoCgOyN4ctH8M3PDOy5FWyysSMEa7euhXdTsatAKS1
         jpxk6cQA+3hNl476S8VZNqgPFrd9LYLIoZgYTEor9MddZb9r21FNfBQv/KfSDK9aAY
         +udZ4rz2OaiKulwlgcRk3jnwT5cKrr1dBpC9TzjBrnW2vcRD2VCferkXsVdIbKqKAG
         lklNWQnIW917m+BohBZn/rxA6oFHOBUbTBzDE43/Hu23iOGVRH7S4YZ5QfeIDuv8+h
         l5b/g43uQ6m2Lo7d1sInscvZWvC8HFfnTTzxwch71ZTc7gk/t0su5/gAdipLfim/RG
         xeuTiCM7ipKSA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/21/2019 4:21 PM, Thierry Reding wrote:
> On Fri, May 17, 2019 at 06:08:40PM +0530, Vidya Sagar wrote:
>> Add support for Tegra194 PCIe controllers. These controllers are based
>> on Synopsys DesignWare core IP.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> Changes since [v6]:
>> * Changed description of the property "nvidia,bpmp".
>> * Removed property "nvidia,disable-aspm-states".
>>
>> Changes since [v5]:
>> * Removed 'max-link-speed' as it is going to be a common sub-system property
>> * Removed 'nvidia,init-link-speed' as there isn't much value addition
>> * Removed 'nvidia,wake-gpios' for now
>> * Addressed review comments from Thierry and Rob in general
>>
>> Changes since [v4]:
>> * None
>>
>> Changes since [v3]:
>> * None
>>
>> Changes since [v2]:
>> * Using only 'Cx' (x-being controller number) format to represent a controller
>> * Changed to 'value: description' format where applicable
>> * Changed 'nvidia,init-speed' to 'nvidia,init-link-speed'
>> * Provided more documentation for 'nvidia,init-link-speed' property
>> * Changed 'nvidia,pex-wake' to 'nvidia,wake-gpios'
>>
>> Changes since [v1]:
>> * Added documentation for 'power-domains' property
>> * Removed 'window1' and 'window2' properties
>> * Removed '_clk' and '_rst' from clock and reset names
>> * Dropped 'pcie' from phy-names
>> * Added entry for BPMP-FW handle
>> * Removed offsets for some of the registers and added them in code and would be pickedup based on
>>    controller ID
>> * Changed 'nvidia,max-speed' to 'max-link-speed' and is made as an optional
>> * Changed 'nvidia,disable-clock-request' to 'supports-clkreq' with inverted operation
>> * Added more documentation for 'nvidia,update-fc-fixup' property
>> * Removed 'nvidia,enable-power-down' and 'nvidia,plat-gpios' properties
>> * Added '-us' to all properties that represent time in microseconds
>> * Moved P2U documentation to a separate file
>>
>>   .../bindings/pci/nvidia,tegra194-pcie.txt     | 158 ++++++++++++++++++
>>   1 file changed, 158 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
>> new file mode 100644
>> index 000000000000..0119f40bbd11
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
>> @@ -0,0 +1,158 @@
>> +NVIDIA Tegra PCIe controller (Synopsys DesignWare Core based)
>> +
>> +This PCIe host controller is based on the Synopsis Designware PCIe IP
>> +and thus inherits all the common properties defined in designware-pcie.txt.
>> +
>> +Required properties:
>> +- compatible: For Tegra19x, must contain "nvidia,tegra194-pcie".
>> +- device_type: Must be "pci"
>> +- power-domains: A phandle to the node that controls power to the respective
>> +  PCIe controller and a specifier name for the PCIe controller. Following are
>> +  the specifiers for the different PCIe controllers
>> +    TEGRA194_POWER_DOMAIN_PCIEX8B: C0
>> +    TEGRA194_POWER_DOMAIN_PCIEX1A: C1
>> +    TEGRA194_POWER_DOMAIN_PCIEX1A: C2
>> +    TEGRA194_POWER_DOMAIN_PCIEX1A: C3
>> +    TEGRA194_POWER_DOMAIN_PCIEX4A: C4
>> +    TEGRA194_POWER_DOMAIN_PCIEX8A: C5
>> +  these specifiers are defined in
>> +  "include/dt-bindings/power/tegra194-powergate.h" file.
>> +- reg: A list of physical base address and length pairs for each set of
>> +  controller registers. Must contain an entry for each entry in the reg-names
>> +  property.
>> +- reg-names: Must include the following entries:
>> +  "appl": Controller's application logic registers
>> +  "config": As per the definition in designware-pcie.txt
>> +  "atu_dma": iATU and DMA registers. This is where the iATU (internal Address
>> +             Translation Unit) registers of the PCIe core are made available
>> +             for SW access.
>> +  "dbi": The aperture where root port's own configuration registers are
>> +         available
>> +- interrupts: A list of interrupt outputs of the controller. Must contain an
>> +  entry for each entry in the interrupt-names property.
>> +- interrupt-names: Must include the following entries:
>> +  "intr": The Tegra interrupt that is asserted for controller interrupts
>> +  "msi": The Tegra interrupt that is asserted when an MSI is received
>> +- bus-range: Range of bus numbers associated with this controller
>> +- #address-cells: Address representation for root ports (must be 3)
>> +  - cell 0 specifies the bus and device numbers of the root port:
>> +    [23:16]: bus number
>> +    [15:11]: device number
>> +  - cell 1 denotes the upper 32 address bits and should be 0
>> +  - cell 2 contains the lower 32 address bits and is used to translate to the
>> +    CPU address space
>> +- #size-cells: Size representation for root ports (must be 2)
>> +- ranges: Describes the translation of addresses for root ports and standard
>> +  PCI regions. The entries must be 7 cells each, where the first three cells
>> +  correspond to the address as described for the #address-cells property
>> +  above, the fourth and fifth cells are for the physical CPU address to
>> +  translate to and the sixth and seventh cells are as described for the
>> +  #size-cells property above.
>> +  - Entries setup the mapping for the standard I/O, memory and
>> +    prefetchable PCI regions. The first cell determines the type of region
>> +    that is setup:
>> +    - 0x81000000: I/O memory region
>> +    - 0x82000000: non-prefetchable memory region
>> +    - 0xc2000000: prefetchable memory region
>> +  Please refer to the standard PCI bus binding document for a more detailed
>> +  explanation.
>> +- #interrupt-cells: Size representation for interrupts (must be 1)
>> +- interrupt-map-mask and interrupt-map: Standard PCI IRQ mapping properties
>> +  Please refer to the standard PCI bus binding document for a more detailed
>> +  explanation.
>> +- clocks: Must contain an entry for each entry in clock-names.
>> +  See ../clocks/clock-bindings.txt for details.
>> +- clock-names: Must include the following entries:
>> +  - core
>> +- resets: Must contain an entry for each entry in reset-names.
>> +  See ../reset/reset.txt for details.
>> +- reset-names: Must include the following entries:
>> +  - core_apb
> 
> Perhaps leave away the "core_" prefix here and simply call this "apb"?
Ok.
  
> 
>> +  - core
>> +- phys: Must contain a phandle to P2U PHY for each entry in phy-names.
>> +- phy-names: Must include an entry for each active lane.
>> +  "p2u-N": where N ranges from 0 to one less than the total number of lanes
>> +- nvidia,bpmp: Must contain a pair of phandle to BPMP controller node followed
>> +  by controller-id. Following are the controller ids for each controller.
>> +    0: C0
>> +    1: C1
>> +    2: C2
>> +    3: C3
>> +    4: C4
>> +    5: C5
>> +- vddio-pex-ctl-supply: Regulator supply for PCIe side band signals
>> +
>> +Optional properties:
>> +- supports-clkreq: Refer to Documentation/devicetree/bindings/pci/pci.txt
>> +- nvidia,update-fc-fixup: This is a boolean property and needs to be present to
>> +    improve perf when a platform is designed in such a way that it satisfies at
> 
> This is a descriptive text, so it makes sense to spell out "performance"
> for better readability.
Done.

> 
>> +    least one of the following conditions thereby enabling root port to
>> +    exchange optimum number of FC (Flow Control) credits with downstream devices
>> +    1. If C0/C4/C5 run at x1/x2 link widths (irrespective of speed and MPS)
>> +    2. If C0/C1/C2/C3/C4/C5 operate at their respective max link widths and
>> +       a) speed is Gen-2 and MPS is 256B
>> +       b) speed is >= Gen-3 with any MPS
> 
> I'm not sure if I asked this before, but can we not determine that the
> configuration matches one of these conditions and select FC fixup mode
> at runtime in that case?
Yes. This was answered before. The thing is, this programming should take place before
link up and these parameters can't be found out until after link up. Hence, this
configuration info needs to be passed through device tree.

> 
>> +- "nvidia,aspm-cmrt-us": Common Mode Restore time for proper operation of ASPM
> 
> You can drop the quotes around the property names. Also, perhaps also
> capitalize "Time" since it's part of the acronym expansion for CMRT.
Done.

> 
>> +   to be specified in microseconds
>> +- "nvidia,aspm-pwr-on-t-us": Power On time for proper operation of ASPM to be
>> +   specified in microseconds
>> +- "nvidia,aspm-l0s-entrance-latency-us": ASPM L0s entrance latency to be
>> +   specified in microseconds
>> +
>> +Examples:
>> +=========
>> +
>> +Tegra194:
>> +--------
>> +
>> +SoC DTSI:
> 
> The example below looks like it's got board specific bits in it, so
> perhaps just drop the "SoC DTSI:" caption.
Done.

> 
>> +
>> +	pcie@14180000 {
>> +		compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
>> +		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8B>;
>> +		reg = <0x00 0x14180000 0x0 0x00020000   /* appl registers (128K)      */
>> +		       0x00 0x38000000 0x0 0x00040000   /* configuration space (256K) */
>> +		       0x00 0x38040000 0x0 0x00040000>; /* iATU_DMA reg space (256K)  */
>> +		reg-names = "appl", "config", "atu_dma";
>> +
>> +		#address-cells = <3>;
>> +		#size-cells = <2>;
>> +		device_type = "pci";
>> +		num-lanes = <8>;
>> +		linux,pci-domain = <0>;
>> +
>> +		clocks = <&bpmp TEGRA194_CLK_PEX0_CORE_0>;
>> +		clock-names = "core";
>> +
>> +		resets = <&bpmp TEGRA194_RESET_PEX0_CORE_0_APB>,
>> +			 <&bpmp TEGRA194_RESET_PEX0_CORE_0>;
>> +		reset-names = "core_apb", "core";
>> +
>> +		interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,	/* controller interrupt */
>> +			     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;	/* MSI interrupt */
>> +		interrupt-names = "intr", "msi";
>> +
>> +		#interrupt-cells = <1>;
>> +		interrupt-map-mask = <0 0 0 0>;
>> +		interrupt-map = <0 0 0 0 &gic 0 72 0x04>;
> 
> Use the symbolic definitions GIC_SPI and IRQ_TYPE_LEVEL_HIGH here as
> well.
Done.

> 
>> +
>> +		nvidia,bpmp = <&bpmp>;
> 
> This should contain a controller ID according to the bindings.
> 
>> +
>> +		supports-clkreq;
>> +		nvidia,disable-aspm-states = <0xf>;
> 
> This is no longer documented above.
Removed.

> 
>> +		nvidia,controller-id = <0>;
> 
> This is no longer documented above.
Removed.

> 
>> +		nvidia,aspm-cmrt-us = <60>;
>> +		nvidia,aspm-pwr-on-t-us = <20>;
>> +		nvidia,aspm-l0s-entrance-latency-us = <3>;
>> +
>> +		bus-range = <0x0 0xff>;
>> +		ranges = <0x81000000 0x0 0x38100000 0x0 0x38100000 0x0 0x00100000      /* downstream I/O (1MB) */
>> +			  0x82000000 0x0 0x38200000 0x0 0x38200000 0x0 0x01E00000      /* non-prefetchable memory (30MB) */
>> +			  0xc2000000 0x18 0x00000000 0x18 0x00000000 0x4 0x00000000>;  /* prefetchable memory (16GB) */
> 
> Perhaps align the individual cells to make this more readable?
Done. Extended the same to dtsi file as well.

> 
>> +
>> +		vddio-pex-ctl-supply = <&vdd_1v8ao>;
>> +
>> +		phys = <&p2u_hsio_2>, <&p2u_hsio_3>, <&p2u_hsio_4>,
>> +		       <&p2u_hsio_5>;
>> +		phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3";
>> +	};
> 
> Thanks,
> Thierry
> 

