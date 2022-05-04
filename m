Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1239251ADE1
	for <lists+linux-pci@lfdr.de>; Wed,  4 May 2022 21:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377550AbiEDTjN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 May 2022 15:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238694AbiEDTjL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 May 2022 15:39:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB42E1C13D;
        Wed,  4 May 2022 12:35:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2C1361BE3;
        Wed,  4 May 2022 19:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B762DC385A4;
        Wed,  4 May 2022 19:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651692931;
        bh=wifdIng5C5+zvFOVkWllKXbxxVMnCc1cn//B0XhEpek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lzMbrpl1X0/Izn8Dbd/Pgv0Yx4q/r1wmVr7Ln6lHotMVWggcGUiZhSP413k9Y9zMt
         dwhdbICf8SZ+qiA+cdQy+g/Jyq2to0UQSy36giJfE0cLWlKUiQPNijxiHfEgtQipxB
         NJkqWR0PjkuOThf5WqfkhkGX1KQKn3IbjZeVd7/Um+iMZvihmnAQTKSer0jwmGJC6+
         qYdyywA0pFQpyg7E4HwE2Nf161ijabc5PIfgwm5BzMtyXJ7cKcD9jQyWe1IqbC82Za
         wRJohgmPQp1nIeAsGZBuq/x3p+c7xAFkx4sw6IpcWSKJz2y/PuubWJRr08wWbKQVs1
         RPu3wb9+BxLcg==
Date:   Wed, 4 May 2022 12:35:28 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3 4/9] PCI/PM: Rework changing power states of PCI
 devices
Message-ID: <YnLVgOqGOPaSrC7G@dev-arch.thelio-3990X>
References: <4419002.LvFx2qVVIh@kreacher>
 <CAJZ5v0i1Ynt54yb7aMJorkYUvqkxhxOqvQJb8AdA7Ps1aBO5tg@mail.gmail.com>
 <YnKrcFSjLr+W+myL@dev-arch.thelio-3990X>
 <2650302.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2650302.mvXUDI8C0e@kreacher>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 04, 2022 at 08:00:33PM +0200, Rafael J. Wysocki wrote:
> On Wednesday, May 4, 2022 6:36:00 PM CEST Nathan Chancellor wrote:
> > On Wed, May 04, 2022 at 02:59:17PM +0200, Rafael J. Wysocki wrote:
> > > On Tue, May 3, 2022 at 7:59 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > > >
> > > > Hi Rafael,
> > > >
> > > > On Thu, Apr 14, 2022 at 03:11:21PM +0200, Rafael J. Wysocki wrote:
> > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > >
> > > > > There are some issues related to changing power states of PCI
> > > > > devices, mostly related to carrying out unnecessary actions in some
> > > > > places, and the code is generally hard to follow.
> > > > >
> > > > >  1. pci_power_up() has two callers, pci_set_power_state() and
> > > > >     pci_pm_default_resume_early().  The latter updates the current
> > > > >     power state of the device right after calling pci_power_up()
> > > > >     and it restores the entire config space of the device right
> > > > >     after that, so pci_power_up() itself need not read the
> > > > >     PCI_PM_CTRL register or restore the BARs after programming the
> > > > >     device into D0 in that case.
> > > > >
> > > > >  2. It is generally hard to get a clear view of the pci_power_up()
> > > > >     code flow, especially in some corner cases, due to all of the
> > > > >     involved PCI_PM_CTRL register reads and writes occurring in
> > > > >     pci_platform_power_transition() and in pci_raw_set_power_state(),
> > > > >     some of which are redundant.
> > > > >
> > > > >  3. The transitions from low-power states to D0 and the other way
> > > > >     around are unnecessarily tangled in pci_raw_set_power_state()
> > > > >     which causes it to use a redundant local variable and makes it
> > > > >     rather hard to follow.
> > > > >
> > > > > To address the above shortcomings, make the following changes:
> > > > >
> > > > >  a. Remove the code handling transitions into D0
> > > > >     from pci_raw_set_power_state() and rename it as
> > > > >     pci_set_low_power_state().
> > > > >
> > > > >  b. Add the code handling transitions into D0 directly
> > > > >     to pci_power_up() and to a new wrapper function
> > > > >     pci_set_full_power_state() calling it internally that is
> > > > >     only used in pci_set_power_state().
> > > > >
> > > > >  c. Make pci_power_up() avoid redundant PCI_PM_CTRL register reads
> > > > >     and make it work in the same way for transitions from any
> > > > >     low-power states (transitions from D1 and D2 are handled
> > > > >     slightly differently before the change).
> > > > >
> > > > >  d. Put the restoration of the BARs and the PCI_PM_CTRL
> > > > >     register read confirming the power state change into
> > > > >     pci_set_full_power_state() to avoid doing that in
> > > > >     pci_pm_default_resume_early() unnecessarily.
> > > > >
> > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > >
> > > > This change as commit 5bffe4c611f5 ("PCI/PM: Rework changing power
> > > > states of PCI devices") causes my AMD-based system to fail to fully
> > > > boot. As far as I can tell, this might be NVMe related, which might make
> > > > getting a full log difficult, as journalctl won't have anywhere to save
> > > > it. I see:
> > > >
> > > > nvme nvme0: I/O 8 QID 0 timeout, completion polled
> > > >
> > > > then shortly afterwards:
> > > >
> > > > nvme nvme0: I/O 24 QID 0 timeout, completion polled
> > > > nvme nvme0: missing or invalid SUBNQN field
> > > >
> > > > then I am dropped into an emergency shell.
> > > 
> > > Thanks for the report!
> > > 
> > > > This is a log from the previous commit, which may give some hints about
> > > > the configuration of this particular system.
> > > >
> > > > https://gist.github.com/nathanchance/8a56f0939410cb187896e904c72e41e7/raw/b47b2620bdd32d43c7a3b209fcfd9e3d4668f058/good-boot.log
> > > >
> > > > If there is any additional debugging information I can provide or
> > > > patches I can try, please let me know!
> > > 
> > > Please see what happens if the "if (dev->current_state == PCI_D0)"
> > > check and the following "return 0" statement in pci_power_up() are
> > > commented out.
> > 
> > If I understand you correctly, this? Unfortunately, that does not help.
> 
> Thanks for testing.
> 
> Please check if the patch below makes any difference.

Unfortunately, there is still no difference. Even worse, I thought I
might be able to get some information from the emergency shell but I
don't think the HID driver is loaded yet so my keyboard does not work. I
am not sure of how to get any further information from the problematic
kernel; if anyone has any ideas, I am happy to test them! I am more than
happy to continue to test patches or provide information, I just don't
want to be a waste of time :)

Cheers,
Nathan

> ---
>  drivers/pci/pci.c |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> Index: linux-pm/drivers/pci/pci.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci.c
> +++ linux-pm/drivers/pci/pci.c
> @@ -1245,7 +1245,7 @@ int pci_power_up(struct pci_dev *dev)
>  
>  	/* There's nothing more to do if current_state is D0 at this point. */
>  	if (dev->current_state == PCI_D0)
> -		return 0;
> +		goto done;
>  
>  	/*
>  	 * Program the device into PCI_D0 by forcing the entire word to 0 (this
> @@ -1260,6 +1260,11 @@ int pci_power_up(struct pci_dev *dev)
>  		udelay(PCI_PM_D2_DELAY);
>  
>  	dev->current_state = PCI_D0;
> +
> +done:
> +	if (dev->bus->self)
> +		pcie_aspm_pm_state_change(dev->bus->self);
> +
>  	return 1;
>  
>  fail:
> @@ -1339,9 +1344,6 @@ static int pci_set_full_power_state(stru
>  		pci_restore_bars(dev);
>  	}
>  
> -	if (dev->bus->self)
> -		pcie_aspm_pm_state_change(dev->bus->self);
> -
>  	return 0;
>  }
>  
> 
> 
> 
