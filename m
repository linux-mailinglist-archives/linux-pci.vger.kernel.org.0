Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CE077FCC5
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 19:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjHQRNl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 13:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354006AbjHQRNc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 13:13:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEE73A81
        for <linux-pci@vger.kernel.org>; Thu, 17 Aug 2023 10:13:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50C3663CE6
        for <linux-pci@vger.kernel.org>; Thu, 17 Aug 2023 17:12:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E091C433C7;
        Thu, 17 Aug 2023 17:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692292364;
        bh=YIkkdOob7toI8tTCz5ofVw/y5QvvyzgB+SvRnu6S+Z0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TP15Y3ybbdhaVZUzR4QdTi5pO37ibq4BcYEOY2k6zDYLRWHkutBp4jvIUQczv9rz/
         Nba71kvZxaBTnDJXNXelKFolwnCvdFO7hTtPDkclwzdc7d4XTRN5fE8sWoNhZ0f5Hn
         8Rt7yImOKOsrKy36CUHsYsmUfdN4RT6nCWk0To2Wt7hzVW/luYse/XQbMrAKvsqwyd
         3bPTobYYDusP4Ltr/bpHtmNZDrFJ2az1xqR8Zh32kEHGk6FImJ5k5+LuSnpC5Jx2/X
         AZ1VQTR6GdhFCDsIEMijrCRObakEm48iv4nS1rXGE0aUZHzWCJQRdoWlHmZfVpY6yj
         AFHisVyPiU7/A==
Date:   Thu, 17 Aug 2023 12:12:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     linux-pci@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: imx8mp pci hang during init
Message-ID: <20230817171242.GA320904@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+vNU0c5trG4DHY9BRtgphMAm7tAYUipaVnzyN+Cq8cEuhobw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Maciej, smells similar to a89c82249c37 ("PCI: Work around PCIe
link training failures") ]

On Wed, Aug 16, 2023 at 03:25:36PM -0700, Tim Harvey wrote:
> Greetings,
> 
> I'm experiencing a hang during pci init appx 60% of boots with an
> imx8mp board connected to a Diodes Incorporated PI7C9X2G608G Gen2
> switch. When it does not hang PCIe links at the expected gen2 (limit
> of the switch) and appears to behave correctly. The PCI clock to the
> imx8mp and the switch in this case is provided by a AB55703HCHCF 2
> output 100MHz LPHSCL clock generator (one output to the SoC, the other
> to the PI7C9X2G608G). I've found that if I set 'fsl,max-link-speed =
> <1>' to limit the link to gen1 I get the expected gen1 link and never
> hang but setting it to 2 or leaving it to the default of 3 produces
> the issue.
> 
> A previous version of the same board which does not include an
> on-board switch and instead runs the clk and pcie lane to a miniPCIe
> socket properly links and operates with a variety of gen1/gen2/gen3
> devices. Additionally with an imx8mm soc and the same switch I have
> never experienced this hang.
> 
> I've reproduced this behavior on every kernel I've tried including
> 6.1, 6.5-rc6 and NXP's downstream lf-6.1.y.
> 
> A successful link at gen2 using Linux 6.5-rc6 looks like this:
> ...
> [ 0.324855] Asymmetric key parser 'x509' registered
> [ 0.335035] clk: failed to reparent gic to sys_pll2_500m: -16
> [ 0.342998] SoC: i.MX8MP revision 1.1
> [ 0.347029] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [ 0.352678] 30890000.serial: ttymxc1 at MMIO 0x30890000 (irq = 15,
> base_baud = 1500000) is a IMX
> [ 0.359364] printk: console [ttymxc1] enabled
> [ 0.359364] printk: console [ttymxc1] enabled
> [ 0.368034] printk: bootconsole [ec_imx6q0] disabled
> [ 0.368034] printk: bootconsole [ec_imx6q0] disabled
> [ 0.380670] i2c_dev: i2c /dev entries driver
> [ 0.386079] ledtrig-cpu: registered to indicate activity on CPUs
> [ 0.392117] SMCCC: SOC_ID: ARCH_SOC_ID not implemented, skipping ....
> [ 0.399731] hw perfevents: enabled with armv8_cortex_a53 PMU driver, 7
> counters available
> [ 0.412372] Loading compiled-in X.509 certificates
> [ 0.431454] gpio gpiochip0: Static allocation of GPIO base is
> deprecated, use dynamic allocation.
> [ 0.441555] gpio gpiochip1: Static allocation of GPIO base is
> deprecated, use dynamic allocation.
> [ 0.451671] gpio gpiochip2: Static allocation of GPIO base is
> deprecated, use dynamic allocation.
> [ 0.461744] gpio gpiochip3: Static allocation of GPIO base is
> deprecated, use dynamic allocation.
> [ 0.471859] gpio gpiochip4: Static allocation of GPIO base is
> deprecated, use dynamic allocation.
> [ 0.495753] imx6q-pcie 33800000.pcie: host bridge /soc@0/pcie@33800000 ranges:
> [ 0.496382] clk: Not disabling unused clocks
> [ 0.503042] imx6q-pcie 33800000.pcie: IO 0x001ff80000..0x001ff8ffff ->
> 0x0000000000
> [ 0.515505] imx6q-pcie 33800000.pcie: MEM 0x0018000000..0x001fefffff
> -> 0x0018000000
> [ 0.739498] imx6q-pcie 33800000.pcie: iATU: unroll T, 4 ob, 4 ib,
> align 64K, limit 16G
> [ 0.847519] imx6q-pcie 33800000.pcie: PCIe Gen.1 x1 link up
> [ 0.953163] imx6q-pcie 33800000.pcie: PCIe Gen.2 x1 link up
> [ 0.958773] imx6q-pcie 33800000.pcie: Link up, Gen2
> [ 0.963663] imx6q-pcie 33800000.pcie: PCIe Gen.2 x1 link up
> [ 0.969553] imx6q-pcie 33800000.pcie: PCI host bridge to bus 0000:00
> [ 0.975928] pci_bus 0000:00: root bus resource [bus 00-ff]
> [ 0.981426] pci_bus 0000:00: root bus resource [io 0x0000-0xffff]
> [ 0.987618] pci_bus 0000:00: root bus resource [mem 0x18000000-0x1fefffff]
> [ 0.994530] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
> [ 1.000563] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
> [ 1.006847] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
> [ 1.013600] pci 0000:00:00.0: supports D1
> [ 1.017620] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
> [ 1.025843] pci 0000:01:00.0: [12d8:2608] type 01 class 0x060400
> [ 1.032244] pci 0000:01:00.0: supports D1 D2
> [ 1.036529] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [ 1.043510] pci 0000:01:00.0: bridge configuration invalid ([bus
> 00-00]), reconfiguring
> [ 1.051961] pci 0000:02:01.0: [12d8:2608] type 01 class 0x060400
> [ 1.058401] pci 0000:02:01.0: supports D1 D2
> [ 1.062695] pci 0000:02:01.0: PME# supported from D0 D1 D2 D3hot D3cold
> [ 1.069746] pci 0000:02:02.0: [12d8:2608] type 01 class 0x060400
> [ 1.076151] pci 0000:02:02.0: supports D1 D2
> [ 1.080435] pci 0000:02:02.0: PME# supported from D0 D1 D2 D3hot D3cold
> [ 1.087447] pci 0000:02:03.0: [12d8:2608] type 01 class 0x060400
> [ 1.093834] pci 0000:02:03.0: supports D1 D2
> [ 1.098111] pci 0000:02:03.0: PME# supported from D0 D1 D2 D3hot D3cold
> [ 1.105110] pci 0000:02:04.0: [12d8:2608] type 01 class 0x060400
> [ 1.111504] pci 0000:02:04.0: supports D1 D2
> [ 1.115781] pci 0000:02:04.0: PME# supported from D0 D1 D2 D3hot D3cold
> [ 1.124178] pci 0000:02:01.0: bridge configuration invalid ([bus
> 00-00]), reconfiguring
> [ 1.132218] pci 0000:02:02.0: bridge configuration invalid ([bus
> 00-00]), reconfiguring
> [ 1.140251] pci 0000:02:03.0: bridge configuration invalid ([bus
> 00-00]), reconfiguring
> [ 1.148282] pci 0000:02:04.0: bridge configuration invalid ([bus
> 00-00]), reconfiguring
> [ 1.156651] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 41
> [ 1.163569] pci_bus 0000:42: busn_res: [bus 42-ff] end is updated to 80
> [ 1.170472] pci_bus 0000:81: busn_res: [bus 81-ff] end is updated to bf
> [ 1.177356] pci_bus 0000:c0: busn_res: [bus c0-ff] end is updated to fe
> [ 1.183999] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to fe
> [ 1.190666] pci 0000:00:00.0: BAR 0: assigned [mem 0x18000000-0x180fffff]
> [ 1.197470] pci 0000:00:00.0: BAR 8: assigned [mem 0x18100000-0x188fffff]
> [ 1.204277] pci 0000:00:00.0: BAR 9: assigned [mem 0x18900000-0x190fffff pref]
> [ 1.211513] pci 0000:00:00.0: BAR 6: assigned [mem 0x19100000-0x1910ffff pref]
> [ 1.218748] pci 0000:00:00.0: BAR 7: assigned [io 0x1000-0x4fff]
> [ 1.224857] pci 0000:01:00.0: BAR 8: assigned [mem 0x18100000-0x188fffff]
> [ 1.231657] pci 0000:01:00.0: BAR 9: assigned [mem
> 0x18900000-0x190fffff 64bit pref]
> [ 1.239410] pci 0000:01:00.0: BAR 7: assigned [io 0x1000-0x4fff]
> [ 1.245524] pci 0000:02:01.0: BAR 8: assigned [mem 0x18100000-0x182fffff]
> [ 1.252322] pci 0000:02:01.0: BAR 9: assigned [mem
> 0x18900000-0x18afffff 64bit pref]
> [ 1.260077] pci 0000:02:02.0: BAR 8: assigned [mem 0x18300000-0x184fffff]
> [ 1.266874] pci 0000:02:02.0: BAR 9: assigned [mem
> 0x18b00000-0x18cfffff 64bit pref]
> [ 1.274632] pci 0000:02:03.0: BAR 8: assigned [mem 0x18500000-0x186fffff]
> [ 1.281444] pci 0000:02:03.0: BAR 9: assigned [mem
> 0x18d00000-0x18efffff 64bit pref]
> [ 1.289205] pci 0000:02:04.0: BAR 8: assigned [mem 0x18700000-0x188fffff]
> [ 1.296003] pci 0000:02:04.0: BAR 9: assigned [mem
> 0x18f00000-0x190fffff 64bit pref]
> [ 1.303757] pci 0000:02:01.0: BAR 7: assigned [io 0x1000-0x1fff]
> [ 1.309859] pci 0000:02:02.0: BAR 7: assigned [io 0x2000-0x2fff]
> [ 1.315962] pci 0000:02:03.0: BAR 7: assigned [io 0x3000-0x3fff]
> [ 1.322070] pci 0000:02:04.0: BAR 7: assigned [io 0x4000-0x4fff]
> [ 1.328183] pci 0000:02:01.0: PCI bridge to [bus 03-41]
> [ 1.333426] pci 0000:02:01.0: bridge window [io 0x1000-0x1fff]
> [ 1.339543] pci 0000:02:01.0: bridge window [mem 0x18100000-0x182fffff]
> [ 1.346347] pci 0000:02:01.0: bridge window [mem 0x18900000-0x18afffff
> 64bit pref]
> [ 1.354114] pci 0000:02:02.0: PCI bridge to [bus 42-80]
> [ 1.359352] pci 0000:02:02.0: bridge window [io 0x2000-0x2fff]
> [ 1.365464] pci 0000:02:02.0: bridge window [mem 0x18300000-0x184fffff]
> [ 1.372267] pci 0000:02:02.0: bridge window [mem 0x18b00000-0x18cfffff
> 64bit pref]
> [ 1.380039] pci 0000:02:03.0: PCI bridge to [bus 81-bf]
> [ 1.385282] pci 0000:02:03.0: bridge window [io 0x3000-0x3fff]
> [ 1.391407] pci 0000:02:03.0: bridge window [mem 0x18500000-0x186fffff]
> [ 1.398215] pci 0000:02:03.0: bridge window [mem 0x18d00000-0x18efffff
> 64bit pref]
> [ 1.405988] pci 0000:02:04.0: PCI bridge to [bus c0-fe]
> [ 1.411227] pci 0000:02:04.0: bridge window [io 0x4000-0x4fff]
> [ 1.417341] pci 0000:02:04.0: bridge window [mem 0x18700000-0x188fffff]
> [ 1.424144] pci 0000:02:04.0: bridge window [mem 0x18f00000-0x190fffff
> 64bit pref]
> ...
> 
> A hang looks like this:
> ...
> [ 0.319551] Asymmetric key parser 'x509' registered
> [ 0.329739] clk: failed to reparent gic to sys_pll2_500m: -16
> [ 0.337699] SoC: i.MX8MP revision 1.1
> [ 0.341761] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [ 0.347374] 30890000.serial: ttymxc1 at MMIO 0x30890000 (irq = 15,
> base_baud = 1500000) is a IMX
> [ 0.354071] printk: console [ttymxc1] enabled
> [ 0.354071] printk: console [ttymxc1] enabled
> [ 0.362759] printk: bootconsole [ec_imx6q0] disabled
> [ 0.362759] printk: bootconsole [ec_imx6q0] disabled
> [ 0.384699] i2c_dev: i2c /dev entries driver
> [ 0.390010] ledtrig-cpu: registered to indicate activity on CPUs
> [ 0.396043] SMCCC: SOC_ID: ARCH_SOC_ID not implemented, skipping ....
> [ 0.403648] hw perfevents: enabled with armv8_cortex_a53 PMU driver, 7
> counters available
> [ 0.416370] Loading compiled-in X.509 certificates
> [ 0.435397] gpio gpiochip0: Static allocation of GPIO base is
> deprecated, use dynamic allocation.
> [ 0.445488] gpio gpiochip1: Static allocation of GPIO base is
> deprecated, use dynamic allocation.
> [ 0.455627] gpio gpiochip2: Static allocation of GPIO base is
> deprecated, use dynamic allocation.
> [ 0.465687] gpio gpiochip3: Static allocation of GPIO base is
> deprecated, use dynamic allocation.
> [ 0.475771] gpio gpiochip4: Static allocation of GPIO base is
> deprecated, use dynamic allocation.
> [ 0.499660] imx6q-pcie 33800000.pcie: host bridge /soc@0/pcie@33800000 ranges:
> [ 0.500276] clk: Not disabling unused clocks
> [ 0.506960] imx6q-pcie 33800000.pcie: IO 0x001ff80000..0x001ff8ffff ->
> 0x0000000000
> [ 0.519401] imx6q-pcie 33800000.pcie: MEM 0x0018000000..0x001fefffff
> -> 0x0018000000
> [ 0.743554] imx6q-pcie 33800000.pcie: iATU: unroll T, 4 ob, 4 ib,
> align 64K, limit 16G
> [ 0.851578] imx6q-pcie 33800000.pcie: PCIe Gen.1 x1 link up
> ^^^ hang at this point until watchdog resets
> 
> Note the 'clk: failed to reparent gic to sys_pll2_500m: -16' message
> which I do not get on the same board with an imx8mm SoC. I'm not sure
> if that is pointing to an issue at this point or not but I see it on
> the imx8mp even when PCI init behaves normally. Also note above I have
> kept the kernel from disabling unused clocks as a precaution.
> 
> I have verified with a scope that PERST# is low until the imx6 PCIe
> driver drives it high and that the external PCI clock going to the
> imx8mp as well as the switch looks proper.
> 
> The relevant imx8mp dt looks like this:
> 
> pcie0_refclk: pcie0-refclk {
>   compatible = "fixed-clock";
>   #clock-cells = <0>;
>   clock-frequency = <100000000>;
> };
> 
> &pcie_phy {
>   fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
>   fsl,clkreq-unsupported;
>   clocks = <&pcie0_refclk>;
>   clock-names = "ref";
>   status = "okay";
> };
> 
> &pcie {
>   pinctrl-names = "default";
>   pinctrl-0 = <&pinctrl_pcie0>;
>   reset-gpio = <&gpio2 17 GPIO_ACTIVE_LOW>;
>   status = "okay";
> };
> 
> If I start adding printk's in imx8_pcie_phy_power_on I don't even make
> it to checking for link and it appears to lockup at the first dbi
> transaction making me think this is a clock or power domain issue.
> 
> I've also posted this question to IMX Community [1]
> 
> Does anyone have any ideas what I should be looking for here?
> 
> Best regards,
> 
> Tim
> [1] https://community.nxp.com/t5/i-MX-Processors/IMX8MP-hang-during-PCI-init/m-p/1706034#M210939
