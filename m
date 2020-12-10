Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994962D5A1D
	for <lists+linux-pci@lfdr.de>; Thu, 10 Dec 2020 13:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387578AbgLJMNn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Dec 2020 07:13:43 -0500
Received: from foss.arm.com ([217.140.110.172]:38332 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727921AbgLJMNn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Dec 2020 07:13:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11CB21FB;
        Thu, 10 Dec 2020 04:12:57 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E923F3F718;
        Thu, 10 Dec 2020 04:12:55 -0800 (PST)
Date:   Thu, 10 Dec 2020 12:12:50 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Marek Vasut <marek.vasut@gmail.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V4] PCI: rcar: Add L1 link state fix into data abort hook
Message-ID: <20201210121250.GA31998@e121166-lin.cambridge.arm.com>
References: <a65139b9-3b06-0562-7b6e-9a438aecff66@gmail.com>
 <20201208184627.GA2393103@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208184627.GA2393103@bjorn-Precision-5520>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 08, 2020 at 12:46:27PM -0600, Bjorn Helgaas wrote:
> On Tue, Dec 08, 2020 at 07:05:09PM +0100, Marek Vasut wrote:
> > On 12/8/20 5:40 PM, Bjorn Helgaas wrote:
> 
> > > > +static const struct of_device_id rcar_pcie_abort_handler_of_match[] __initconst = {
> > > > +	{ .compatible = "renesas,pcie-r8a7779" },
> > > > +	{ .compatible = "renesas,pcie-r8a7790" },
> > > > +	{ .compatible = "renesas,pcie-r8a7791" },
> > > > +	{ .compatible = "renesas,pcie-rcar-gen2" },
> > > > +	{},
> > > > +};
> > > 
> > > Why do we need another copy of these, as opposed to doing something
> > > with of_device_get_match_data(), e.g., like brcm_pcie_probe() does?
> > 
> > This is not a copy, but as subset of SoCs which are affected by this
> > problem.
> 
> I know it's not a complete copy.  Many systems include flags like
> "broken_l1" in their match_data.  Something like this:
> 
>   struct rcar_pcie_drvdata {
>     int            (*phy_init_fn)(struct rcar_pcie_host *host);
>     unsigned int   broken_l1:1;
>   };
> 
>   static const struct rcar_pcie_drvdata rcar_init_h1_drvdata = {
>     .phy_init_fn = rcar_pcie_phy_init_h1,
>     .broken_l1 = 1,
>   };
> 
>   static const struct rcar_pcie_drvdata rcar_init_gen2_drvdata = {
>     .phy_init_fn = rcar_pcie_phy_init_gen2,
>     .broken_l1 = 1,
>   };
> 
>   static const struct rcar_pcie_drvdata rcar_init_gen3_drvdata = {
>     .phy_init_fn = rcar_pcie_phy_init_gen3,
>   };
> 
>   static const struct of_device_id rcar_pcie_of_match[] = {
>     { .compatible = "renesas,pcie-r8a7779", .data = rcar_init_h1_drvdata },
>     { .compatible = "renesas,pcie-r8a7790", .data = rcar_init_gen2_drvdata },
>     { .compatible = "renesas,pcie-r8a7791", .data = rcar_init_gen2_drvdata },
>     ...

+1

> > > > +static int __init rcar_pcie_init(void)
> > > > +{
> > > > +	if (of_find_matching_node(NULL, rcar_pcie_abort_handler_of_match)) {
> > > > +#ifdef CONFIG_ARM_LPAE
> > > > +		hook_fault_code(17, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
> > > > +				"asynchronous external abort");
> > > > +#else
> > > > +		hook_fault_code(22, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
> > > > +				"imprecise external abort");
> > > > +#endif
> > > > +	}
> > > > +
> > > > +	return platform_driver_register(&rcar_pcie_driver);
> > > > +}
> > > > +device_initcall(rcar_pcie_init);
> > > > +#else
> > > >   builtin_platform_driver(rcar_pcie_driver);
> > > > +#endif
> > > 
> > > Is the device_initcall() vs builtin_platform_driver() something
> > > related to the hook_fault_code()?  What would break if this were
> > > always builtin_platform_driver()?
> > 
> > rcar_pcie_init() would not be called before probe.
> 
> Sorry to be slow, but why does it need to be called before probe?
> Obviously software isn't putting the controller in D3 or enabling ASPM
> before probe.

I don't understand it either so it would be good to clarify.

Also, some of these platforms are SMP systems, I don't understand
what prevents multiple cores to fault at once given that the faults
can happen for config/io/mem accesses alike.

I understand that the immediate fix is for S2R, that is single
threaded but I would like to understand how comprehensive this fix
is.

Thanks,
Lorenzo
