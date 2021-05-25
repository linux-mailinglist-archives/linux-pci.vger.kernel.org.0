Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B072F390CFE
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 01:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbhEYXhl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 May 2021 19:37:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:41426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229750AbhEYXhl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 May 2021 19:37:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0490613F6;
        Tue, 25 May 2021 23:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621985771;
        bh=M3f5JJ59lb7V3zAIJE/8IREkJ0yCmn0zhodIof+Mo6U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tQlHNqzOFbkI7Cm/Vt4gRT8ABZMlOPV37GRh9JvXs6V9YWL+I8uhnECYizpvi7P3L
         mn7oxplFoQ3gb+b3nXOJYJ9xZqn6u8S5hFycPa13t56e8W+GASDNm2VQ6+llX7emr8
         JEz1jBOty6nuha0aWC0VermiuesTes79sV2jbRCjl7OV8VcP7JVOkIcWm1Q2k0WNru
         Lo4h8EOr3ZWqNwCYEM753/ofoZjPsMWjtUnb2z1ibbcYnO7LiysJ7aewktBorYjaEB
         qemGsE8kebMH8ZY0kb7FK4RBTywDyyX9ccs1u4PsldguAaIGTES1Qqmx81GNRQr96L
         h1E12Gd57w1YA==
Date:   Tue, 25 May 2021 18:36:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Utkarsh H Patel <utkarsh.h.patel@intel.com>,
        Koba Ko <koba.ko@canonical.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Target PM state is D3cold if the upstream bridge
 is power manageable
Message-ID: <20210525233604.GA1236347@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510102647.40322-1-mika.westerberg@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 10, 2021 at 01:26:47PM +0300, Mika Westerberg wrote:
> ASMedia xHCI controller only supports PME from D3cold:
> 
> 11:00.0 USB controller: ASMedia Technology Inc. ASM1042A USB 3.0 Host Controller (prog-if 30 [XHCI])
>   ...
>   Capabilities: [78] Power Management version 3
>   	  Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
> 	  Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> 
> Now, if the controller is part of a Thunderbolt device for instance, it
> is connected to a PCIe switch downstream port. When the hierarchy then
> enters D3cold as a result of s2idle cycle pci_target_state() returns D0
> because the device does not support PME from the default target_state
> (D3hot). So what happens is that the whole hierarchy is left into D0
> breaking power management.
> 
> For this reason choose target_state to be D3cold if there is a upstream
> bridge that is power manageable. The reasoning here is that the upstream
> bridge will be also placed into D3 making the effective power state of
> the device in question to be D3cold.

I'm having a hard time understanding this in a generic way and
relating it to anything in the specs.  This isn't written as a quirk,
so I assume this is not specific to the ASM1042A or to Thunderbolt.

The same considerations apparently should apply to *any* device that
is below a power-manageable bridge and doesn't support PME from D3hot.
If so, let's lead off the commit log with that, and use ASM1042A
merely as an example instead of as the motivation.

"When the hierarchy enters D3cold" -- I guess you mean the bridge and
all downstream devices are in D3cold?  Does a bridge being in D3cold
actually force all downstream devices to be in D3cold as well?  I
guess not, because it seems that the bridge is in D3 but the whole
point of this is to change the target_state of the device from D0 to
D3cold, right?

Is s2idle relevant in itself?  My impression is that the important
things are the PME capabilities and the D0/D3hot/D3cold states of the
bridge and the device, and "s2idle" is just a distraction.

"Breaking power management" -- I assume this just means we don't save
as much power as we'd like?

"For this reason" -- I missed the actual reason.  Is the reason "the
whole hierarchy is in D0 and wastes more power"?  I guess we don't
really need a *reason*; saving power is good enough.  What we *do*
need is justification for why it is safe, and I can't connect the dots
yet.

You mention putting the bridge in D3.  Does that mean D3hot or D3cold?
If it can be either, say that.  If it means only one, be specific.
I'd like to eradicate "D3" from PCI because the ambiguity just makes
things hard.

What does "the effective power state of the device is D3cold" mean?
Does that mean the device is *actually* in D3cold, so it has no power
and will need complete re-initialization?  Or does it simply mean that
the device is unreachable because the bridge is not in D0, and the OS
can't directly wake it?

These are all questions I'd like to see answered in the commit log,
not just in the email thread.

> Reported-by: Utkarsh H Patel <utkarsh.h.patel@intel.com>
> Reported-by: Koba Ko <koba.ko@canonical.com>
> Tested-by: Koba Ko <koba.ko@canonical.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pci/pci.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b717680377a9..e3f3b9010762 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2578,8 +2578,19 @@ static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
>  		return target_state;
>  	}
>  
> -	if (!dev->pm_cap)
> +	if (!dev->pm_cap) {
>  		target_state = PCI_D0;
> +	} else {
> +		struct pci_dev *bridge;
> +
> +		/*
> +		 * If the upstream bridge can be put to D3 then it means
> +		 * that our target state is D3cold instead of D3hot.

Can you expand on this a bit?  Expand "D3" to be specific, and more
importantly, say something about *why* the target state is D3cold.

> +		 */
> +		bridge = pci_upstream_bridge(dev);
> +		if (bridge && pci_bridge_d3_possible(bridge))
> +			target_state = PCI_D3cold;

I guess we don't or can't do this for the
platform_pci_power_manageable() case?

> +	}
>  
>  	/*
>  	 * If the device is in D3cold even though it's not power-manageable by
> -- 
> 2.30.2
> 
