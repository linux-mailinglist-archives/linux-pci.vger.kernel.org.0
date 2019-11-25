Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEF9F108917
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2019 08:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbfKYHXx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Nov 2019 02:23:53 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17224 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfKYHXx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Nov 2019 02:23:53 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ddb81870000>; Sun, 24 Nov 2019 23:23:51 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 24 Nov 2019 23:23:49 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 24 Nov 2019 23:23:49 -0800
Received: from [10.25.75.126] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 25 Nov
 2019 07:23:45 +0000
Subject: Re: [PATCH 2/6] dt-bindings: PCI: tegra: Add DT support for PCIe EP
 nodes in Tegra194
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <jonathanh@nvidia.com>, <andrew.murray@arm.com>, <kishon@ti.com>,
        <gustavo.pimentel@synopsys.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20191122104505.8986-1-vidyas@nvidia.com>
 <20191122104505.8986-3-vidyas@nvidia.com> <20191122131931.GB1315704@ulmo>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <8fbdda8e-84af-576c-e240-61c381c85a8f@nvidia.com>
Date:   Mon, 25 Nov 2019 12:53:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191122131931.GB1315704@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574666631; bh=SD5J0Bwrm6CXThVpYdmwQY+mTyslM3LaSGkh0HuWN2E=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=DncNDhuLknaSmmi8yj0sNUd7sAoMhgMEu3cd4o5VP/1GGhQqQpl3HugO6pAluIUzn
         QqPTZr0OGfrqEXSRvnm60Lio5cZKuy2nZNx8sElIREL3l1wXjfnFvtjgUMZn75l8l7
         9YfAaTsTpOfJfGGu0Rhv4mmcZ55+sc31ESnZrnqaLDV7DaZxENt4VNFq9JouqrmHx0
         1oBA+wjXE9DEhdnoMjN2ymxcMzxAYLJxzM0EK/Ep0rXPj8YN5FXp0xekLVDZ9Hqw4S
         t8hkkAsF1mB5pGi0KegqrMCxC/AVOYqV5G4b+P/0UBDmO9kcw6EGp2zLqMv7M86h6u
         z6/IKy/YmdvXA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/22/2019 6:49 PM, Thierry Reding wrote:
> On Fri, Nov 22, 2019 at 04:15:01PM +0530, Vidya Sagar wrote:
>> Add support for PCIe controllers that can operate in endpoint mode
>> in Tegra194.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>>   .../bindings/pci/nvidia,tegra194-pcie-ep.txt  | 138 ++++++++++++++++++
>>   1 file changed, 138 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.txt
> 
> The vast majority of this is a duplication of the host mode device tree
> bindings. I think it'd be best to combine both and only highlight where
> both modes differ.
> 
> The designware-pcie.txt binding does something similar.
Ok. I'll merge this into the host mode bindings file and in that differentiate between
root mode and endpoint mode.

> 
>> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.txt
>> new file mode 100644
>> index 000000000000..4676ccf7dfa5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.txt
>> @@ -0,0 +1,138 @@
>> +NVIDIA Tegra PCIe Endpoint mode controller (Synopsys DesignWare Core based)
>> +
>> +Some of the PCIe controllers which are based on Synopsys DesignWare PCIe IP
>> +are dual mode i.e. they can work in root port mode or endpoint mode but one
>> + at a time. Since they are based on DesignWare IP, they inherit all the common
>> +properties defined in designware-pcie.txt.
>> +
>> +Required properties:
>> +- compatible: For Tegra19x, must contain "nvidia,tegra194-pcie".
> 
> The device tree snippets that you added have "nvidia,tegra194-pcie-ep"
> for EP mode controllers. So either this is wrong or the DTS files are
> wrong.
DTS file are correct. This is a mistake in this file. I'll correct this.

> 
> This device tree binding describes the exact same hardware, so I don't
> think we necessarily need two different compatible strings. It's fairly
> easy to distinguish between which mode to run in by looking at which
> properties exist. EP mode for example is the only one that uses the
> "addr_space" reg entry.
> 
> Rob, do you know why a different compatible string was chosen for the EP
> mode? Looking at the driver, there are only a handful of differences in
> the programming, but most of the driver remains identical. An extra DT
> compatible string seems a bit exaggerated since it suggests that this is
> actually different hardware, where it clearly isn't.
Since all other implementations have done it this way, I just followed to be in sync
with them. Even I would also like to hear from Rob on the rationale behind this.

> 
>> +  Tegra194: Only C0, C4 & C5 controllers are dual mode controllers.
>> +- power-domains: A phandle to the node that controls power to the respective
>> +  PCIe controller and a specifier name for the PCIe controller. Following are
>> +  the specifiers for the different PCIe controllers
>> +    TEGRA194_POWER_DOMAIN_PCIEX8B: C0
>> +    TEGRA194_POWER_DOMAIN_PCIEX4A: C4
>> +    TEGRA194_POWER_DOMAIN_PCIEX8A: C5
>> +  these specifiers are defined in
>> +  "include/dt-bindings/power/tegra194-powergate.h" file.
>> +- reg: A list of physical base address and length pairs for each set of
>> +  controller registers. Must contain an entry for each entry in the reg-names
>> +  property.
>> +- reg-names: Must include the following entries:
>> +  "appl": Controller's application logic registers
>> +  "atu_dma": iATU and DMA registers. This is where the iATU (internal Address
>> +             Translation Unit) registers of the PCIe core are made available
>> +             for SW access.
>> +  "dbi": The aperture where root port's own configuration registers are
>> +         available
>> +  "addr_space": Used to map remote RC address space
>> +- interrupts: A list of interrupt outputs of the controller. Must contain an
>> +  entry for each entry in the interrupt-names property.
>> +- interrupt-names: Must include the following entry:
>> +  "intr": The Tegra interrupt that is asserted for controller interrupts
>> +- clocks: Must contain an entry for each entry in clock-names.
>> +  See ../clocks/clock-bindings.txt for details.
>> +- clock-names: Must include the following entries:
>> +  - core
>> +- resets: Must contain an entry for each entry in reset-names.
>> +  See ../reset/reset.txt for details.
>> +- reset-names: Must include the following entries:
>> +  - apb
>> +  - core
>> +- phys: Must contain a phandle to P2U PHY for each entry in phy-names.
>> +- phy-names: Must include an entry for each active lane.
>> +  "p2u-N": where N ranges from 0 to one less than the total number of lanes
>> +- nvidia,bpmp: Must contain a pair of phandle to BPMP controller node followed
>> +  by controller-id. Following are the controller ids for each controller.
>> +    0: C0
>> +    4: C4
>> +    5: C5
>> +- vddio-pex-ctl-supply: Regulator supply for PCIe side band signals
>> +- nvidia,pex-rst-gpio: Must contain a phandle to a GPIO controller followed by
>> +  GPIO that is being used as PERST signal
> 
> Why is this NVIDIA specific? Do other instantiations of the DW IP not
> also need a means to define which GPIO is the reset?
I'm not sure. At least I didn't find anything like this in other implementations.
My understanding is that, controller handles assert/de-assert on the PERST line
automatically without SW intervention. I think it is for the same reason that other
implementations don't wait for the REFCLK to flow in from host to configure the IP.
I think they just use some internal clock for the configuration and switch to
running the core based on REFCLK as and when it is available
(i.e. whenever a de-assert is perceived on PERST line by the controller)

> 
>> +
>> +Optional properties:
>> +- pinctrl-names: A list of pinctrl state names.
>> +  It is mandatory for C5 controller and optional for other controllers.
>> +  - "default": Configures PCIe I/O for proper operation.
>> +- pinctrl-0: phandle for the 'default' state of pin configuration.
>> +  It is mandatory for C5 controller and optional for other controllers.
>> +- supports-clkreq: Refer to Documentation/devicetree/bindings/pci/pci.txt
>> +- nvidia,update-fc-fixup: This is a boolean property and needs to be present to
>> +    improve performance when a platform is designed in such a way that it
>> +    satisfies at least one of the following conditions thereby enabling root
>> +    port to exchange optimum number of FC (Flow Control) credits with
>> +    downstream devices
>> +    1. If C0/C4/C5 run at x1/x2 link widths (irrespective of speed and MPS)
>> +    2. If C0/C4/C5 operate at their respective max link widths and
>> +       a) speed is Gen-2 and MPS is 256B
>> +       b) speed is >= Gen-3 with any MPS
>> +- nvidia,aspm-cmrt-us: Common Mode Restore Time for proper operation of ASPM
>> +   to be specified in microseconds
>> +- nvidia,aspm-pwr-on-t-us: Power On time for proper operation of ASPM to be
>> +   specified in microseconds
>> +- nvidia,aspm-l0s-entrance-latency-us: ASPM L0s entrance latency to be
>> +   specified in microseconds
>> +
>> +NOTE:- On Tegra194's P2972-0000 platform, only C5 controller can be enabled to
>> +operate in the endpoint mode because of the way the platform is designed.
>> +There is a mux that needs to be programmed to let the REFCLK from the host to
>> +flow into C5 controller when it operates in the endpoint mode. This mux is
>> +controlled by the GPIO (AA, 5) and it needs to be driven 'high'. For this to
>> +happen, set status of "pex-refclk-sel-high" node under "gpio@c2f0000" node to
>> +'okay'.
>> +	When any dual mode controller is made to operate in the endpoint mode,
>> +please make sure that its respective root port node's status is set to
>> +'disabled'.
> 
> This seems very brittle to me. There's no good way how we can detect
> such misconfigurations. If instead we only have one node describing the
> hardware fully, the chances of configuring things wrong (by for example
> enabling both the host and EP mode device tree nodes) can be reduced.
> 
> So I think instead of duplicating all of the device tree content to have
> both a host and an EP node for each controller, it'd be better to just
> have a single node and let the device tree bindings specify which
> changes to apply to switch into EP mode.
> 
> For example, there should be nothing wrong with specifying some of the
> EP-only properties (like num-ib-windows and num-ob-windows) all the time
> and only use them when we actually run in EP mode.
> 
> As I mentioned earlier, there are a couple of easy ways to distinguish
> the modes. The presence of the "addr_space" reg entry is one example,
> but we could also key off the nvidia,pex-rst-gpio property, since that
> (presumably) wouldn't be needed for host mode.
> 
> That way we can just add default, host mode entries to tegra194.dtsi and
> whenever somebody wants to enable EP mode, they can just override the
> node in the board-level DTS file, like so:
> 
> 	pcie@141a0000 {
> 		reg = <0x00 0x141a0000 0x0 0x00020000   /* appl registers (128K)      */
> 		       0x00 0x3a040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  */
> 		       0x00 0x3a080000 0x0 0x00040000   /* DBI reg space (256K)       */
> 		       0x1c 0x00000000 0x4 0x00000000>; /* Address Space (16G)        */
> 		reg-names = "appl", "atu_dma", "dbi", "addr_space";
> 
> 		nvidia,pex-rst-gpio = <&gpio TEGRA194_MAIN_GPIO(GG, 1) GPIO_ACTIVE_LOW>;
> 	};
> 
> Thierry
I like it and fine with making these modifications also but would like to hear from Rob
also on this.

- Vidya Sagar
> 
>> +
>> +Examples:
>> +=========
>> +
>> +Tegra194:
>> +--------
>> +
>> +	pcie_ep@141a0000 {
>> +		compatible = "nvidia,tegra194-pcie-ep", "snps,dw-pcie-ep";
>> +		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8A>;
>> +		reg = <0x00 0x141a0000 0x0 0x00020000   /* appl registers (128K)      */
>> +		       0x00 0x3a040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  */
>> +		       0x00 0x3a080000 0x0 0x00040000   /* DBI reg space (256K)       */
>> +		       0x1c 0x00000000 0x4 0x00000000>; /* Address Space (16G)        */
>> +		reg-names = "appl", "atu_dma", "dbi", "addr_space";
>> +
>> +		num-lanes = <8>;
>> +		num-ib-windows = <2>;
>> +		num-ob-windows = <8>;
>> +
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&clkreq_c5_bi_dir_state>;
>> +
>> +		clocks = <&bpmp TEGRA194_CLK_PEX1_CORE_5>;
>> +		clock-names = "core";
>> +
>> +		resets = <&bpmp TEGRA194_RESET_PEX1_CORE_5_APB>,
>> +			 <&bpmp TEGRA194_RESET_PEX1_CORE_5>;
>> +		reset-names = "apb", "core";
>> +
>> +		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;	/* controller interrupt */
>> +		interrupt-names = "intr";
>> +
>> +		nvidia,bpmp = <&bpmp 5>;
>> +
>> +		nvidia,aspm-cmrt-us = <60>;
>> +		nvidia,aspm-pwr-on-t-us = <20>;
>> +		nvidia,aspm-l0s-entrance-latency-us = <3>;
>> +
>> +		vddio-pex-ctl-supply = <&vdd_1v8ao>;
>> +
>> +		nvidia,pex-rst-gpio = <&gpio TEGRA194_MAIN_GPIO(GG, 1)
>> +					GPIO_ACTIVE_LOW>;
>> +
>> +		phys = <&p2u_nvhs_0>, <&p2u_nvhs_1>, <&p2u_nvhs_2>,
>> +		       <&p2u_nvhs_3>, <&p2u_nvhs_4>, <&p2u_nvhs_5>,
>> +		       <&p2u_nvhs_6>, <&p2u_nvhs_7>;
>> +
>> +		phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3", "p2u-4",
>> +			    "p2u-5", "p2u-6", "p2u-7";
>> +	};
>> -- 
>> 2.17.1
>>

