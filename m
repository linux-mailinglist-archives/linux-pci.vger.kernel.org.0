Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E327160BE
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2019 11:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfEGJU4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 May 2019 05:20:56 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16756 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfEGJUz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 May 2019 05:20:55 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd14df10000>; Tue, 07 May 2019 02:20:49 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 07 May 2019 02:20:53 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 07 May 2019 02:20:53 -0700
Received: from [10.25.73.250] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 May
 2019 09:20:45 +0000
Subject: Re: [PATCH V5 10/16] dt-bindings: PCI: tegra: Add device tree support
 for T194
To:     Rob Herring <robh@kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190424052004.6270-1-vidyas@nvidia.com>
 <20190424052004.6270-11-vidyas@nvidia.com> <20190426154306.GA16455@bogus>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <504abd8f-9eb3-1089-953c-a6372c34b346@nvidia.com>
Date:   Tue, 7 May 2019 14:50:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190426154306.GA16455@bogus>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557220850; bh=e+UcDuWIG0bxBvBPCQxSZUcgS0CRcKaYSMxCIONcBq8=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=bRmKa/8oE1tGDnwY7X1RdEhEPSUy/jcHmKluNSKd/Q5LSkhqmU5kHISEA53Jh3I1H
         uvqTG1w0m/onhYUsxynYcgr5yVO5YM6MCwY74Esdomu6nvAtbghZLuUpg1N8dWgOnK
         r3xwsS/QeGnrbFMoBtpjR1AozWJ8HyJJKITWCcK1j4NGaotb+BKF4QG8x/mEoM590f
         jOhe3NY7Nj99iHyyT5aMC/me945vKx6r9cOrmVWpLWgztV6W8HuRL9MZiuesygquYJ
         PU0BGYRsN9X8r3NdBX7n615MfTBghI7kCnwS43Vk1CezRJh6k9TtImYwHVJfTDpTyN
         Td+p+TVltJemA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/26/2019 9:13 PM, Rob Herring wrote:
> On Wed, Apr 24, 2019 at 10:49:58AM +0530, Vidya Sagar wrote:
>> Add support for Tegra194 PCIe controllers. These controllers are based
>> on Synopsys DesignWare core IP.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
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
>>   .../bindings/pci/nvidia,tegra194-pcie.txt     | 187 ++++++++++++++++++
>>   1 file changed, 187 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
>> new file mode 100644
>> index 000000000000..208dff126108
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
>> @@ -0,0 +1,187 @@
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
>> +- reg: A list of physical base address and length for each set of controller
>> +  registers. Must contain an entry for each entry in the reg-names property.
>> +- reg-names: Must include the following entries:
>> +  "appl": Controller's application logic registers
>> +  "config": As per the definition in designware-pcie.txt
>> +  "atu_dma": iATU and DMA registers. This is where the iATU (internal Address
>> +             Translation Unit) registers of the PCIe core are made available
>> +             fow SW access.
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
>> +  - core
>> +- phys: Must contain a phandle to P2U PHY for each entry in phy-names.
>> +- phy-names: Must include an entry for each active lane.
>> +  "p2u-N": where N ranges from 0 to one less than the total number of lanes
>> +- nvidia,bpmp: Must contain a phandle to BPMP controller node.
>> +- nvidia,controller-id : Controller specific ID
>> +    0: C0
>> +    1: C1
>> +    2: C2
>> +    3: C3
>> +    4: C4
>> +    5: C5
> 
> We don't normal put device indexes into DT. Why do you need this.
> Perhaps for accessing the BPMP? If so, make nvidia,bpmp a phandle+cell.
BPMP needs to know the controller number to enable it hence it needs to be
passed to BPMP. Just for accessing BPMP, I already added 'nvidia,bpmp' property.

> 
>> +- vddio-pex-ctl-supply: Regulator supply for PCIe side band signals
>> +
>> +Optional properties:
>> +- max-link-speed: Limits controllers max speed to this value. For more info,
>> +    please refer to Documentation/devicetree/bindings/pci/pci.txt file.
> 
> No need to define the property again. Just reference the definition and
> define any constraints not in the base def. For example, what's the max
> value?
Ok.

> 
>> +- nvidia,init-link-speed: Limits controllers init speed to this value. It means
>> +    that link is brought up to the speed specified by this property initially by
>> +    hardware (provided connected end point also supports that). Since the
>> +    controller continues to advertise maximum supported link speed set up
>> +    through max-link-speed property (Gen-4 if max-link-speed is not present) in
>> +    its configuration space, software can take link the desired speed at a later
>> +    point of time by spec defined speed change mechanism.
>> +    1: Gen-1 (2.5 GT/s)
>> +    2: Gen-2 (5 GT/s)
>> +    3: Gen-3 (8 GT/s)
>> +    4: Gen-4 (16 GT/s)
> 
> Why not just set things to the max? Power savingss? If so, you're going
> to want to change speeds at run-time and I don't see how boot-time
> setting really matters.
> 
> If we do need this, then I think it should be common.
This is added mostly for debugging purposes where link is brought up at a lower speed (ex:- Gen-1)
and then by means of SW initiated speed change, it is taken to a higher speed.
I'll remove it from the next patch as I'm not sure if it deserves to go as a common entry.

> 
>> +- nvidia,disable-aspm-states: Controls advertisement of ASPM states
>> +    bit-0 to '1': Disables advertisement of ASPM-L0s
>> +    bit-1 to '1': Disables advertisement of ASPM-L1. This also disables
>> +                   advertisement of ASPM-L1.1 and ASPM-L1.2
>> +    bit-2 to '1': Disables advertisement of ASPM-L1.1
>> +    bit-3 to '1': Disables advertisement of ASPM-L1.2
> 
> Can't this cover what 'supports-clkreq' does?
Well, they are related partially. i.e. if a platform doesn't have 'supports-clkreq' set,
then, by definition, it can't advertise support for ASPM L1.1 and L1.2 states. But, ASPM-L0s
and ASPM-L1 states don't depend on 'supports-clkreq' property.
Having this property gives more granularity as to support for which particular ASPM state
shouldn't be advertised by the root port.

> 
> I think this should be common property. We already have a Rockchip
> property to disable L0s.
I'm afraid it can't be a common property as not all implementations allow programming capabilty
registers before PCIe link up (as capability registers in a root port's configurations space are
otherwise read-only registers). Since this is more like a feature of Tegra194's PCIe root port,
I added it here.

> 
> Also, just use 0x1, 0x2, 0x4 instead of "bit-N to '1'"
Ok. I'll change this.

> 
>> +- supports-clkreq: Refer to Documentation/devicetree/bindings/pci/pci.txt
>> +- nvidia,update-fc-fixup: This is a boolean property and needs to be present to
>> +    improve perf when a platform is designed in such a way that it satisfies at
>> +    least one of the following conditions thereby enabling root port to
>> +    exchange optimum number of FC (Flow Control) credits with downstream devices
>> +    1. If C0/C4/C5 run at x1/x2 link widths (irrespective of speed and MPS)
>> +    2. If C0/C1/C2/C3/C4/C5 operate at their respective max link widths and
>> +       a) speed is Gen-2 and MPS is 256B
>> +       b) speed is >= Gen-3 with any MPS
>> +- "nvidia,wake-gpios": Add PEX_WAKE GPIO pin. It contains phandle to GPIO
>> +    controller followed by GPIO specifier.
> 
> Seems like the same issue as this discussion:
> 
> https://lkml.org/lkml/2019/2/24/69
> 
> I'd drop this until this is solved in a common way.
I'm fine with it. I'll drop this for now and push patches to support WAKE at a
later point of time.

> 
>> +    Refer ../gpio/nvidia,tegra186-gpio.txt for more info.
>> +- "nvidia,aspm-cmrt-us": Common Mode Restore time for proper operation of ASPM
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
>> +
>> +	pcie@14180000 {
>> +		compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
>> +		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8B>;
>> +		reg = <0x00 0x14180000 0x0 0x00020000   /* appl registers (128K)      */
>> +		       0x00 0x38000000 0x0 0x00040000   /* configuration space (256K) */
>> +		       0x00 0x38040000 0x0 0x00040000>; /* iATU_DMA reg space (256K)  */
>> +		reg-names = "appl", "config", "atu_dma";
>> +
>> +		status = "disabled";
> 
> Don't show status in examples.
Ok.

> 
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
>> +
>> +		nvidia,bpmp = <&bpmp>;
>> +
>> +		supports-clkreq;
>> +		nvidia,disable-aspm-states = <0xf>;
>> +		nvidia,controller-id = <0>;
>> +		nvidia,aspm-cmrt-us = <60>;
>> +		nvidia,aspm-pwr-on-t-us = <20>;
>> +		nvidia,aspm-l0s-entrance-latency-us = <3>;
>> +
>> +		bus-range = <0x0 0xff>;
>> +		ranges = <0x81000000 0x0 0x38100000 0x0 0x38100000 0x0 0x00100000      /* downstream I/O (1MB) */
>> +			  0x82000000 0x0 0x38200000 0x0 0x38200000 0x0 0x01E00000      /* non-prefetchable memory (30MB) */
>> +			  0xc2000000 0x18 0x00000000 0x18 0x00000000 0x4 0x00000000>;  /* prefetchable memory (16GB) */
>> +	};
>> +
>> +Board DTS:
> 
> Just make the example a single node. This split is convention, but not
> part of the binding definition.
Ok.

> 
>> +
>> +	pcie@14180000 {
>> +		status = "okay";
>> +
>> +		vddio-pex-ctl-supply = <&vdd_1v8ao>;
>> +
>> +		phys = <&p2u_hsio_2>, <&p2u_hsio_3>, <&p2u_hsio_4>,
>> +		       <&p2u_hsio_5>;
>> +		phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3";
>> +	};
>> -- 
>> 2.17.1
>>

