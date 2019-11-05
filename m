Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD067F068B
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2019 21:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfKEUBI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Nov 2019 15:01:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:60980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbfKEUBI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Nov 2019 15:01:08 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 738D6217F5;
        Tue,  5 Nov 2019 20:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572984067;
        bh=a5LN7NuMdOkHQh+h++8Cg/SsMhKTo2CCP+g8v63uk7w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aKYJfLjcj/QY2WciTrgEYmAGYtqC3rar3SN93SG5N0ZS/p3wnt+TJOKieOVTnqavB
         mpUhos9pAawaF82R4up5ho6qg4eTmrjI0lUM8jlwSbPrFCimBIfKFHHsFT4FI5cJDD
         GYi2/x4C03F0CLSGyN/6UEKND7XE1LJeXSUwlyak=
Date:   Tue, 5 Nov 2019 14:01:05 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: Add missing link delays required by the PCIe
 spec
Message-ID: <20191105200105.GA239884@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105125818.GW2552@lahna.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 05, 2019 at 02:58:18PM +0200, Mika Westerberg wrote:
> On Tue, Nov 05, 2019 at 11:54:33AM +0200, Mika Westerberg wrote:
> > > For understandability, I think the wait needs to go in some function
> > > that contains "PCI_D0", e.g., platform_pci_set_power_state() or
> > > pci_power_up(), so it's connected with the transition from D3cold to
> > > D0.
> > > 
> > > Since pci_pm_default_resume_early() is the only caller of
> > > pci_power_up(), maybe we should just inline pci_power_up(), e.g.,
> > > something like this:
> > > 
> > >   static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
> > >   {
> > >     pci_power_state_t prev_state = pci_dev->current_state;
> > > 
> > >     if (platform_pci_power_manageable(pci_dev))
> > >       platform_pci_set_power_state(pci_dev, PCI_D0);
> > > 
> > >     pci_raw_set_power_state(pci_dev, PCI_D0);
> > >     pci_update_current_state(pci_dev, PCI_D0);
> > > 
> > >     pci_restore_state(pci_dev);
> > >     pci_pme_restore(pci_dev);
> > > 
> > >     if (prev_state == PCI_D3cold)
> > >       pci_bridge_wait_for_secondary_bus(dev);
> > >   }
> > 
> > OK, I'll see if this works.
> 
> Well, I think we want to execute pci_fixup_resume_early before we delay
> for the downstream component (same for runtime resume path). Currently
> nobody is using that for root/downstream ports but in theory at least
> some port may need it before it works properly. Also probably good idea
> to disable wake as soon as possible to avoid possible extra PME messages
> coming from the port.

OK, I wish we could connect it more closely with the actual power-on,
but I guess that makes sense.

> I feel that the following is the right place to perform the delay but if
> you think we can ignore the above, I will just do what you say and do it
> in pci_pm_default_resume_early() (and pci_restore_standard_config() for
> runtime path).
> 
> [The below diff does not have check for pci_dev->skip_bus_pm because I
>  was planning to move it inside pci_bridge_wait_for_secondary_bus() itself.]

What do you gain by moving it?  IIUC we want them to be the same
condition, and if one is in pci_pm_resume_noirq() and another is
inside pci_bridge_wait_for_secondary_bus(), it's hard to see that
they're connected.  I'd rather have pci_pm_resume_noirq() check it
once, save the result, and test that result before calling
pci_pm_default_resume_early() and pci_bridge_wait_for_secondary_bus().

> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 08d3bdbc8c04..3c0e52aaef79 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -890,6 +890,7 @@ static int pci_pm_resume_noirq(struct device *dev)
>  {
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
>  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> +	pci_power_t prev_state = pci_dev->current_state;
>  
>  	if (dev_pm_may_skip_resume(dev))
>  		return 0;
> @@ -914,6 +915,9 @@ static int pci_pm_resume_noirq(struct device *dev)
>  	pci_fixup_device(pci_fixup_resume_early, pci_dev);
>  	pcie_pme_root_status_cleanup(pci_dev);
>  
> +	if (prev_state == PCI_D3cold)
> +		pci_bridge_wait_for_secondary_bus(pci_dev);
> +
>  	if (pci_has_legacy_pm_support(pci_dev))
>  		return 0;
>  
> @@ -1299,6 +1303,7 @@ static int pci_pm_runtime_resume(struct device *dev)
>  {
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
>  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> +	pci_power_t prev_state = pci_dev->current_state;
>  	int error = 0;
>  
>  	/*
> @@ -1314,6 +1319,9 @@ static int pci_pm_runtime_resume(struct device *dev)
>  	pci_fixup_device(pci_fixup_resume_early, pci_dev);
>  	pci_pm_default_resume(pci_dev);
>  
> +	if (prev_state == PCI_D3cold)
> +		pci_bridge_wait_for_secondary_bus(pci_dev);
> +
>  	if (pm && pm->runtime_resume)
>  		error = pm->runtime_resume(dev);
>  
