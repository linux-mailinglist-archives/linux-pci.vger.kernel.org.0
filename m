Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D846F2D9D66
	for <lists+linux-pci@lfdr.de>; Mon, 14 Dec 2020 18:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732829AbgLNRPf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Dec 2020 12:15:35 -0500
Received: from foss.arm.com ([217.140.110.172]:50070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729635AbgLNROr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Dec 2020 12:14:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 067901FB;
        Mon, 14 Dec 2020 09:13:56 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0ABF3F66E;
        Mon, 14 Dec 2020 09:13:54 -0800 (PST)
Date:   Mon, 14 Dec 2020 17:13:14 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V4] PCI: rcar: Add L1 link state fix into data abort hook
Message-ID: <20201214171314.GA4278@e121166-lin.cambridge.arm.com>
References: <a65139b9-3b06-0562-7b6e-9a438aecff66@gmail.com>
 <20201208184627.GA2393103@bjorn-Precision-5520>
 <20201210121250.GA31998@e121166-lin.cambridge.arm.com>
 <b569d614-2548-5ce1-32f0-dc923a508710@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b569d614-2548-5ce1-32f0-dc923a508710@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Dec 12, 2020 at 08:12:16PM +0100, Marek Vasut wrote:
> On 12/10/20 1:12 PM, Lorenzo Pieralisi wrote:
> 
> [...]
> 
> > > > > > +static int __init rcar_pcie_init(void)
> > > > > > +{
> > > > > > +	if (of_find_matching_node(NULL, rcar_pcie_abort_handler_of_match)) {
> > > > > > +#ifdef CONFIG_ARM_LPAE
> > > > > > +		hook_fault_code(17, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
> > > > > > +				"asynchronous external abort");
> > > > > > +#else
> > > > > > +		hook_fault_code(22, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
> > > > > > +				"imprecise external abort");
> > > > > > +#endif
> > > > > > +	}
> > > > > > +
> > > > > > +	return platform_driver_register(&rcar_pcie_driver);
> > > > > > +}
> > > > > > +device_initcall(rcar_pcie_init);
> > > > > > +#else
> > > > > >    builtin_platform_driver(rcar_pcie_driver);
> > > > > > +#endif
> > > > > 
> > > > > Is the device_initcall() vs builtin_platform_driver() something
> > > > > related to the hook_fault_code()?  What would break if this were
> > > > > always builtin_platform_driver()?
> > > > 
> > > > rcar_pcie_init() would not be called before probe.
> > > 
> > > Sorry to be slow, but why does it need to be called before probe?
> > > Obviously software isn't putting the controller in D3 or enabling ASPM
> > > before probe.
> > 
> > I don't understand it either so it would be good to clarify.
> 
> The hook_fault_code() is marked __init, so if probe() was deferred and the
> kernel __init memory was free'd, attempt to call hook_fault_code() from
> probe would lead to a crash.

Understood - I don't think there is a point though in keeping
the builtin_platform_driver() call then, something like:

#ifdef CONFIG_ARM
...
static __init void init_platform_hook_fault(void) {
	if (of_find_matching_node(NULL, rcar_pcie_abort_handler_of_match)) {
		#ifdef CONFIG_ARM_LPAE
			hook_fault_code(17, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
					"asynchronous external abort");
		#else
			hook_fault_code(22, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
					"imprecise external abort");
		#endif
	}
}
#else
static inline void init_platform_hook_fault(void)
{}
#endif

static int __init rcar_pcie_init(void)
{
	init_platform_hook_fault();
	return platform_driver_register(&rcar_pcie_driver);
}
device_initcall(rcar_pcie_init);

Or we remove the __init marker from hook_fault_code().

> > Also, some of these platforms are SMP systems, I don't understand
> > what prevents multiple cores to fault at once given that the faults
> > can happen for config/io/mem accesses alike.
> > 
> > I understand that the immediate fix is for S2R, that is single
> > threaded but I would like to understand how comprehensive this fix
> > is.
> 
> Are you suggesting to add some sort of locking ?

If we merge a fix the fix has to work, by reading the code if multiple
cores fault at once this fix seems to have an issue that's why I asked,
you may still end up with an unhandled fault by reading the code.

Lorenzo
