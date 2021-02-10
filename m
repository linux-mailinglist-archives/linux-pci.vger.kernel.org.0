Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFE43174D3
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 00:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbhBJX6d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Feb 2021 18:58:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:34466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231564AbhBJX6c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Feb 2021 18:58:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D48364E0D;
        Wed, 10 Feb 2021 23:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613001471;
        bh=SaNe+4sznhzVt1n/wb+asu4cuOT8/tQOnU+IeBWSNMs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SyN5Xw1/hpGtpAu4oJeB/BI/zY383zQINolzxZMio+oUgbRR0sEXKB1dzN15fmN+G
         e1FMjskAmEO2PHoO3Nty8+8XpFTseFtbR5lwlcQC8NnGAmjg1VM5EljfcZOfwFH1Pn
         30TR88axOSHO1aXXyU55cYPLwE9PjLAMvQfO0dAzTcK1yfjg1JTc2Dq9iK0hs5yrZP
         dVYYLj1AyR+hlFiZ56TaVGsqgjojrb3gabU/egRcxZT5M64KIM8JLgTKpObvfxX2ws
         QP0p8s6TgvUXBadaJJTyBeZc+JujxgY2wdCoIZp1ID23BNv0v53NO1hgbksJu4tZTM
         4J4iX4IMdDtGw==
Date:   Wed, 10 Feb 2021 17:57:49 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] PCI: Run platform power transition on initial D0 entry
Message-ID: <20210210235749.GA617942@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204220640.1548532-1-luzmaximilian@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rafael, linux-pm]

On Thu, Feb 04, 2021 at 11:06:40PM +0100, Maximilian Luz wrote:
> On some devices and platforms, the initial platform power state is not
> in sync with the power state of the PCI device.
> 
> pci_enable_device_flags() updates the state of a PCI device by reading
> from the PCI_PM_CTRL register. This may change the stored power state of
> the device without running the appropriate platform power transition.

At this point in the code, setting dev->current_state based on the
value of PCI_PM_CTRL seems reasonable.  We're making the pci_dev state
match the PCI device hardware state.  This paragraph sort of implies
we're missing an "appropriate platform power transition" here, but I
don't think that's the case.

But it would be nice if we could combine this bit from
pci_enable_device_flags() with the pci_set_power_state() in
do_pci_enable_device().

> Due to the stored power-state being changed, the later call to
> pci_set_power_state(..., PCI_D0) in do_pci_enable_device() can evaluate
> to a no-op if the stored state has been changed to D0 via that. This
> will then prevent the appropriate platform power transition to be run,
> which can on some devices and platforms lead to platform and PCI power
> state being entirely different, i.e. out-of-sync. On ACPI platforms,
> this can lead to power resources not being turned on, even though they
> are marked as required for D0.
> 
> Specifically, on the Microsoft Surface Book 2 and 3, some ACPI power
> regions that should be "on" for the D0 state (and others) are
> initialized as "off" in ACPI, whereas the PCI device is in D0.

So some ACPI power regions are in fact "on" (because the PCI device
that requires them is in D0), but the ACPI core believes them to be
"off" (or probably "unknown, treated as 'off'")?

> As the
> state is updated in pci_enable_device_flags() without ensuring that the
> platform state is also updated, the power resource will never be
> properly turned on. Instead, it lives in a sort of on-but-marked-as-off
> zombie-state, which confuses things down the line when attempting to
> transition the device into D3cold: As the resource is already marked as
> off, it won't be turned off and the device does not fully enter D3cold,
> causing increased power consumption during (runtime-)suspend.
> 
> By replacing pci_set_power_state() in do_pci_enable_device() with
> pci_power_up(), we can force pci_platform_power_transition() to be
> called, which will then check if the platform power state needs updating
> and appropriate actions need to be taken.
> 
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

I added Rafael & linux-pm because he should chime in here.

> ---
> 
> I'm not entirely sure if this is the best way to do this, so I'm open to
> alternatives. In a previous version of this, I've tried to run the
> platform/ACPI transition directly after the pci_read_config_word() in
> pci_enable_device_flags(), however, that caused some regression in
> intel-lpss-pci, specifically that then had trouble accessing its config
> space for initial setup.
> 
> This version has been tested for a while now on [1/2] without any
> complaints. As this essentially only drops the initial are-we-already-
> in-that-state-check, I don't expect any issues to be caused by that.
> 
> [1]: https://github.com/linux-surface/linux-surface
> [2]: https://github.com/linux-surface/kernel
> 
> ---
>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b9fecc25d213..eb778e80d8cf 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1802,7 +1802,7 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
>  	u16 cmd;
>  	u8 pin;
>  
> -	err = pci_set_power_state(dev, PCI_D0);
> +	err = pci_power_up(dev);
>  	if (err < 0 && err != -EIO)
>  		return err;
>  
> -- 
> 2.30.0
> 
