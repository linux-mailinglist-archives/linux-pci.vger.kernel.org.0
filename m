Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8759F5768C2
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 23:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiGOVOv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 17:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiGOVOv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 17:14:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0B02B186;
        Fri, 15 Jul 2022 14:14:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40FBFB82D13;
        Fri, 15 Jul 2022 21:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACDF2C3411E;
        Fri, 15 Jul 2022 21:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657919687;
        bh=YSgkRb4vMkYLetcxBlCkbkjcEzWxtfkj06mzwX8x114=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tae7N5oks312ap0xF4Tlj6qaOGkTzzIig/LF/ZLRny3wUzxs0gSS1PNnmBgcnWsQN
         IRewBP0qMvM/LXOy2sP+D3kpuXs6oo2zW86t34aoV5ffTDc1RvmgmOy4zxO/FsExB6
         nEWJTTdTcU3j1JO6j+FK/GfpnUAf4A1dRbpVKZcCkXP94aA+OTJKZe6yUs7vQu0pLq
         zxDTTDjsWTeyCHvKh9exs0IdQFJ031Nli8kNzJsbbnCeflMXhCkRUDVkWp+qAgWGwp
         P77fPSerrnviqO6mw0c3eIDq558d+lMGvFw2trhPCOMyutJGUYLk4lf6VHEuWhx66d
         VnkJr/X3BgjoQ==
Date:   Fri, 15 Jul 2022 16:14:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     maz@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com,
        kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev
Subject: Re: [PATCH v2 0/4] PCI EP driver support MSI doorbell from host
Message-ID: <20220715211445.GA1191496@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220715192219.1489403-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 15, 2022 at 02:22:15PM -0500, Frank Li wrote:
> 
>                   ┌───────┐          ┌──────────┐
>                   │       │          │          │
> ┌─────────────┐   │       │          │ PCI Host │
> │ MSI         │◄┐ │       │          │          │
> │ Controller  │ │ │       │          │          │
> └─────────────┘ └─┼───────┼──────────┼─Bar0     │
>                   │ PCI   │          │ Bar1     │
>                   │ Func  │          │ Bar2     │
>                   │       │          │ Bar3     │
>                   │       │          │ Bar4     │
>                   │       ├─────────►│          │
>                   └───────┘          └──────────┘

Nice diagram and explanation.  I suggest rewrapping to fit in 75
columns and including in one of the patches, probably the
pci-epf-vntb.c one.  Then it will be more likely to make it to the git
history where it will be useful.

> Many PCI controllers provided Endpoint functions.
> Generally PCI endpoint is hardware, which is not running a rich OS, like linux.
> 
> But Linux also supports endpoint functions.  PCI Host write bar<n> space like
> write to memory. The EP side can't know memory changed by the Host driver. 
>
> PCI Spec has not defined a standard method to do that.  Only define MSI(x) to let
> EP notified RC status change. 
> 
> The basic idea is to trigger an irq when PCI RC writes to a memory address.  That's
> what MSI controller provided.  EP drivers just need to request a platform MSI interrupt, 
> struct msi_msg *msg will pass down a memory address and data.  EP driver will
> map such memory address to one of PCI bar<n>.  Host just writes such an address to
> trigger EP side irq.
> 
> If system have gic-its, only need update PCI EP side driver. But i.MX have not chip
> support gic-ites yet. So we have to use MU to simulate a MSI controller. Although
> only 4 MSI irqs are simulated, it matched vntd network requirmenent.
> 
> After enable MSI, ping delay reduce < 1ms from ~8ms
> 
> irqchip: imx mu worked as msi controller: 
>      let imx mu worked as MSI controllers. Although IP is not design as MSI controller,
> we still can use it if limiated irq number to 4.
> 
> pcie: endpoint: pci-epf-vntb: add endpoint msi support
> 	 Based on ntb-next branch. https://github.com/jonmason/ntb/commits/ntb-next
> 	 Using MSI as door bell registers
> 
> i.MX EP function driver is upstreaming by Richard Zhu.
> Some dts change missed at this patches. below is reference dts change

s/bar/BAR/ (several)
s/irq/IRQ/ (several)
s/irqs/IRQs/
s/msi/MSI/
s/gic-ites/?  (capitalize if it's an acronym)
s/requirmenent/requirement/
s/limiated/limited/

You use both "gic-its" and "gic-ites".  I assume they should be the
same.

Not sure what "vntd" refers to.  Capitalize if it's an acronym.

> --- a/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
> @@ -160,5 +160,6 @@ pcieb_ep: pcie_ep@5f010000 {
>                 num-ib-windows = <6>;
>                 num-ob-windows = <6>;
>                 status = "disabled";
> +               msi-parent = <&lsio_mu12>;
>         };
> 
> --- a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
> @@ -172,6 +172,19 @@ lsio_mu6: mailbox@5d210000 {
>                 status = "disabled";
>         };
> 
> +       lsio_mu12: mailbox@5d270000 {
> +               compatible = "fsl,imx6sx-mu-msi";
> +               msi-controller;
> +               interrupt-controller;
> +               reg = <0x5d270000 0x10000>,     /* A side */
> +                     <0x5d300000 0x10000>;     /* B side */
> +               reg-names = "a", "b";
> +               interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
> +               power-domains = <&pd IMX_SC_R_MU_12A>,
> +                               <&pd IMX_SC_R_MU_12B>;
> +               power-domain-names = "a", "b";
> +       };
> +
> 
> Change Log
> - from V1 to V2
>   Fixed fsl,mu-msi.yaml's problem
>   Fixed irq-imx-mu-msi.c problem according Marc Zyngier's feeback 
>   Added a new patch to allow pass down .pm by IRQCHIP_PLATFORM_DRIVER_END
> 
> -- 
> 2.35.1
> 
