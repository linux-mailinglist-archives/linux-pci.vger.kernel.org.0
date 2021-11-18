Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B20455919
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 11:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245342AbhKRKfN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 05:35:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:34704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245262AbhKRKe7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Nov 2021 05:34:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A94D61B39;
        Thu, 18 Nov 2021 10:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637231519;
        bh=hugh9tuJyoeInv+UUWi3AGGjYzy3xYdfMbnfikTqwCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cT1j7v6wUqlZ3mkULFxwJAaAOwBIn07Yk5XVxwnocMbFPDJmw4jqBI8Oj/AbTvyp6
         cX0r1ljF/K4pir9ieeZczYoMs2fhVKknD0JxpQS5fu1Zs5GGxuhui2sJvQ20/6hjE1
         aGMtUh6W5VE92un3T2DTbJSiHtfUd7al9vURfEZjkFOkOpr2l7hoM79OJ1mtucKYPP
         1G/xjtF4FwyZqCtHh+6g/N0EOtUNXi7qL2PP/O9IIKKiCO0nsO8SFrkCp50yCwW7wN
         CvVjQxZ07tbZ7pN6f/J6kTNZZL1zcxXyLrkzAZN8PV/dz+eOhgJgdPMuWgfSCrw0A9
         5BykrIXed0S5A==
Received: by pali.im (Postfix)
        id 27AA8799; Thu, 18 Nov 2021 11:31:57 +0100 (CET)
Date:   Thu, 18 Nov 2021 11:31:56 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        kernel-team@android.com, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: apple: Reset the port for 100ms on probe
Message-ID: <20211118103156.r66aso2bklm7jnns@pali>
References: <20211117160053.232158-1-maz@kernel.org>
 <20211117201245.GA1768803@bhelgaas>
 <20211117202859.2m5sqwz6xsjgldji@pali>
 <87o86h7pex.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o86h7pex.wl-maz@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 18 November 2021 10:01:58 Marc Zyngier wrote:
> On Wed, 17 Nov 2021 20:28:59 +0000,
> Pali Rohár <pali@kernel.org> wrote:
> > 
> > Hello!
> > 
> > On Wednesday 17 November 2021 14:12:45 Bjorn Helgaas wrote:
> > > [+cc Pali]
> > > 
> > > On Wed, Nov 17, 2021 at 04:00:53PM +0000, Marc Zyngier wrote:
> > > > While the Apple PCIe driver works correctly when directly booted
> > > > from the firmware, it fails to initialise when the kernel is booted
> > > > from a bootloader using PCIe such as u-boot.
> > > > 
> > > > That's beacuse we're missing a proper reset of the port (we only
> > > > clear the reset, but never assert it).
> > > 
> > > s/beacuse/because/
> > > 
> > > > Bring the port back to life by wiggling the #PERST pin for 100ms
> > > > (as per the spec).
> > > 
> > > I cc'd Pali because I think he's interested in consolidating or
> > > somehow rationalizing delays like this.
> > > 
> > > If we have a specific spec reference here, I think it would help that
> > > effort.  I *think* it's PCIe r5.0, sec 6.6.1, which mentions the 100ms
> > > along with some additional constraints, like waiting 100ms after Link
> > > training completes for ports that support > 5.0 GT/s, whether
> > > Readiness Notifications are used, and CRS Software Visiblity.
> > 
> > This is not 100ms timeout "after link training completes".
> > 
> > Timeout in this patch is between flipping PERST# signal, so timeout
> > means how long needs to be endpoint card in reset state. And this
> > timeout cannot be controller specific. In past I have tried to find this
> > timeout in specifications, I was not able. Some summary is in my email:
> > https://lore.kernel.org/linux-pci/20210310110535.zh4pnn4vpmvzwl5q@pali/
> > 
> > So I would like to know, why was chosen 100ms for msleep() in this
> > patch?
> 
> Excellent question. I went back to my notes (and the spec), and it
> looks like I have mistakenly conflated *two* delays here:
> 
> - The post-#PERST delay, which is 100ms, and which is *not* what this
>   patch is doing while it really should be doing it. This is
>   documented in the base PCIe spec (in Rev 2.0, this is part of
>   6.6.1). The amusing part is that on this HW, it seems that only the
>   delay from the falling edge matters (which is why I didn't spot the
>   issue).
> 
> - The duration of the power-on #PERST assertion (Tpvperl), which is
>   also 100ms, and documented in the PCIe Card Electromechanical
>   Specification (Rev 1.0a, 2.2 and 2.2.1).

I think that your patch is doing also something different. It uses
PERST# signal to reset card _after_ card was fully powered on and
_maybe_ link was already established (depends on bootloader if it
initialized PCIe, etc...).

Important is that this reset is really needed for some cards (e.g. lot
of Atheros wifi cards as they can be stuck somewhere in broken state)
and I do not think it is Tpvperl delay. More controller drivers add some
delay between flipping PERST# signal. In past I wrote summary of it:
https://lore.kernel.org/linux-pci/20200424092546.25p3hdtkehohe3xw@pali/

> There is also a third delay (Tperst-clk) which represents the time
> required for the clock to ramp up before releasing #PERST. No, there
> is no value associated with this.

But there is minimal value for Tperst-clk which is 100us defined in PCIe
CEM spec (3.0) and also in M.2 CEM spec.

> Having come to my senses, and with these constraints in mind, this is
> what I currently have in my tree:
> 
> 	/* Engage #PERST */
> 	gpiod_set_value(reset, 0);
> 
> 	ret = apple_pcie_setup_refclk(pcie, port);
> 	if (ret < 0)
> 		return ret;
> 
> 	/* Hold #PERST for 100ms as per the electromechanical spec */
> 	msleep(100);
> 	rmw_set(PORT_PERST_OFF, port->base + PORT_PERST);
> 	gpiod_set_value(reset, 1);
> 	/* Wait for 100ms after #PERST deassertion before anothing else */
> 	msleep(100);
> 
> Yes, this is totally overkill, as I assume that each port has gone
> through a complete power-off and is only slowly coming back from the
> dead.

For power-on it is probably overkill, but I think that delay between
flipping PERST# should be there. IIRC Compex WLE1216 wifi card needs to
be at least 10-11ms in reset. Last year, during testing of this card I
saw that if PERST#-based reset was shorter then card was completely
undetected.

> In practice, I can completely remove the initial Tpvperl delay (we
> have been powered-on for a long time already, and the clock is stable
> when we come back from setting it up), and cut the second one by half
> without observing any ill effect (though I feel safer keeping it to
> its nominal value).

My opinion is that this patch does not power on/off card in PCIe slot.
And because card is powered-on for a long time (as you wrote), it means
that Tpvperl delay does not apply here. That is why I think that
different delay (How long should be PCIe card in Warm Reset state)
should be used _between_ flipping PERST# signal.

And of course after the releasing PERST# that 100ms post-PERST# delay is
required.

I have an idea to move PERST# handling (with all delays) from controller
drivers to pci core functions. Because basically every driver
re-implements these delays in its probe function. I wrote this idea with
some details in email. If you have a time, could you look at it? I
summarized here also details about delays (like Tpvperl, Tperstclk, ..):
https://lore.kernel.org/linux-pci/20211022183808.jdeo7vntnagqkg7g@pali/

> If nobody screams, I'll respin something shortly.
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
