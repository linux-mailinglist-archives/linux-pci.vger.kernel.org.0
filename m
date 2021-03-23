Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7C8345C80
	for <lists+linux-pci@lfdr.de>; Tue, 23 Mar 2021 12:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhCWLK2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Mar 2021 07:10:28 -0400
Received: from foss.arm.com ([217.140.110.172]:44082 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230487AbhCWLKO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Mar 2021 07:10:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 034181042;
        Tue, 23 Mar 2021 04:10:14 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D47D3F719;
        Tue, 23 Mar 2021 04:10:13 -0700 (PDT)
Date:   Tue, 23 Mar 2021 11:10:10 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Fabio Estevam <festevam@gmail.com>
Cc:     helgaas@kernel.org, jingoohan1@gmail.com, robh@kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: exynos: Check the phy_power_on() return value
Message-ID: <20210323111010.GC29286@e121166-lin.cambridge.arm.com>
References: <20210208174114.615811-1-festevam@gmail.com>
 <YDVxBzH/9ePDhy4v@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YDVxBzH/9ePDhy4v@rocinante>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 23, 2021 at 10:17:59PM +0100, Krzysztof Wilczyński wrote:
> Hi Fabio,
> 
> Thank you for sending the patch over!
> 
> [...]
> > This fixes the following Coverity error:
> > 
> > 	CID 1472841:  Error handling issues  (CHECKED_RETURN)
> > 	Calling "phy_power_on" without checking return value (as is done elsewhere 40 out of 50 times).
> > 	phy_power_on(ep->phy);
> > 	phy_init(ep->phy);
> 
> This is good, however, you would need to wrap long lines, and that would
> make the message from Coverity harder to read, etc.  Thus, it might be
> better to use the "Addresses-Coverity-ID" which is becoming a de-facto
> standard for referencing Coverity defects.  Check the following for some
> examples:
> 
>    git log drivers/pci | grep 'Addresses-Coverity-ID:'
> 
> [...]         
> > +	ret = phy_power_on(ep->phy);
> > +	if (ret < 0)
> > +		return ret;
> 
> I wonder if you would also have to call phy_exit() here, even though
> eventually exynos_pcie_probe() would call it once the error propagates
> all the way up the call stack.
> 
> Additionally, exynos_pcie_resume_noirq() does not do any error checking
> after calling exynos_pcie_host_init() and does not call phy_exit()
> either, and I am not sure if it should, though.
> 
> See some comments below.
> 
> > +
> >  	phy_init(ep->phy);
> [...]
> 
> A small nit here.  You can check for any non-zero return value, as
> anything would indicate an error here.
> 
> I also have a suggestion.  Would you also be interested in addressing
> two Coverity defects that were detected in exynos_pcie_host_init()?
> 
> These would be the one you addressed here (CID 1472841) in this patch
> and the other would be:
> 
>   CID 1471267 (#1 of 1): Unchecked return value (CHECKED_RETURN)
> 
> Which is about checking return value from phy_init() that is called
> immediately after phy_power_on() in exynos_pcie_host_init().
> 
> The error propagates from exynos_pcie_host_init() as follows:
> 
>   struct exynos_pcie_host_ops{}
>     .host_init = exynos_pcie_host_init
> 
>   exynos_pcie_probe()              <-- phy_exit() called here if exynos_add_pcie_port() fails.
>     exynos_add_pcie_port()
>         dw_pcie_host_init()
>           exynos_pcie_host_init()  <-- phy_power_on() and phy_init() called here.
>             dw_pcie_host_init()
>               struct pcie_port{}
>                 struct dw_pcie_host_ops{}
>                   .host_init       <-- exynos_pcie_host_init() called via struct exynos_pcie_host_ops{}.
> 
>   struct exynos_pcie_pm_ops{}
>     .suspend_noirq = exynos_pcie_suspend_noirq
>     .resume_noirq = exynos_pcie_resume_noirq
> 
>   exynos_pcie_resume_noirq()
>     exynos_pcie_host_init()        <-- called here, but without any error checking.
> 
> Thus, we could handle propagating error from both the phy_power_on() and
> phy_init() in the same time, perhaps even in a single patch, or a small
> series.
> 
> Also, since there is no error checking and/or handling that might be
> returned from exynos_pcie_host_init() in the exynos_pcie_resume_noirq()
> callback, then perhaps adding some error messages to be printed should
> something bad happens regarding power management.  But this would
> becompletely optional as there there is also no error checking and
> handling in exynos_pcie_suspend_noirq() either.

Fabio, what's the plan with this patch ?

Lorenzo
