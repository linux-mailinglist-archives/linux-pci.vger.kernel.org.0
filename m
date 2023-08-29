Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509C678C9F2
	for <lists+linux-pci@lfdr.de>; Tue, 29 Aug 2023 18:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbjH2Qwt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Aug 2023 12:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236421AbjH2QwY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Aug 2023 12:52:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62579B8;
        Tue, 29 Aug 2023 09:52:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAE0E61F70;
        Tue, 29 Aug 2023 16:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDA0C433C7;
        Tue, 29 Aug 2023 16:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693327940;
        bh=aqFRMs1P/H+2rPpMG6oGqF0hU+r7fe/L4/+8jO+Ok6E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nFq7ceo3mVSLLp3DjkTyDkiiZXeidCM9l8laQ3apUcACtzwUmGgKLtAjhOZ4YnM6V
         y4ONhZmIA9zWqfeZLBc6NdODs2wOmiLqYZ7pbDbOXanegjfnFekY7MwEVR1+H+wEJY
         L+itOXYvodaO8lfwxknmEST4tNY5/GQEKoOJ1B/t3eZdG6OrggGrQNhgDoPRejWwvx
         fk3vMkuI6doCZKL4Xx1588wA/iYqLSEgJXM1ij1Ao+zpSn+6gET925gOeb3S2hmlUI
         h1RX1vBmJ+CWcXZHk34hV4+chBworp8YfCGvGGhslH85MPA2QgNwveA3KT/x9pTNJJ
         e/N2ao0RIMZcA==
Date:   Tue, 29 Aug 2023 11:52:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Feiyang Chen <chris.chenfeiyang@gmail.com>
Cc:     Feiyang Chen <chenfeiyang@loongson.cn>, bhelgaas@google.com,
        rafael.j.wysocki@intel.com, mika.westerberg@linux.intel.com,
        anders.roxell@linaro.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, guyinggang@loongson.cn,
        siyanteng@loongson.cn, chenhuacai@loongson.cn,
        loongson-kernel@lists.loongnix.cn,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3] PCI/PM: Only read PCI_PM_CTRL register when available
Message-ID: <20230829165218.GA800705@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230825212507.GA627427@bhelgaas>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 25, 2023 at 04:25:07PM -0500, Bjorn Helgaas wrote:
> On Fri, Aug 25, 2023 at 11:57:00AM +0800, Feiyang Chen wrote:
> > On Fri, Aug 25, 2023 at 5:59 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Thu, Aug 24, 2023 at 09:37:38AM +0800, Feiyang Chen wrote:
> > > > When the current state is already PCI_D0, pci_power_up() will return
> > > > 0 even though dev->pm_cap is not set. In that case, we should not
> > > > read the PCI_PM_CTRL register in pci_set_full_power_state().
> > > >
> > > > There is nothing more needs to be done below in that case.
> > > > Additionally, pci_power_up() has two callers only and the other one
> > > > ignores the return value, so we can safely move the current state
> > > > check from pci_power_up() to pci_set_full_power_state().
> > >
> > > Does this fix a bug?  I guess it does, because previously
> > > pci_set_full_power_state() did a config read at 0 + PCI_PM_CTRL, i.e.,
> > > offset 4, which is actually PCI_COMMAND, and set dev->current_state
> > > based on that.  So dev->current_state is now junk, right?
> > 
> > Yes.
> > 
> > > This might account for some "Refused to change power state from %s to D0"
> > > messages.
> > >
> > > How did you find this?  It's nice if we can mention a symptom so
> > > people can connect the problem with this fix.
> > 
> > We are attempting to add MSI support for our stmmac driver, but the
> > pci_alloc_irq_vectors() function always fails.
> > After looking into it more, we came across the message "Refused to
> > change power state from D3hot to D0" :)
> 
> So I guess this device doesn't have a PM Capability at all?  Can you
> collect the "sudo lspci -vv" output?  The PM Capability is required
> for all PCIe devices, so maybe this is a conventional PCI device?
> 
> > > This sounds like something that probably should have a stable tag?
> > 
> > Do I need to include the symptom and Cc in the commit message and
> > then send v4?
> 
> > > > Fixes: e200904b275c ("PCI/PM: Split pci_power_up()")
> > > > Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> > > > Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
> > > > ---
> > > >  drivers/pci/pci.c | 9 +++++----
> > > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > index 60230da957e0..7e90ab7b47a1 100644
> > > > --- a/drivers/pci/pci.c
> > > > +++ b/drivers/pci/pci.c
> > > > @@ -1242,9 +1242,6 @@ int pci_power_up(struct pci_dev *dev)
> > > >               else
> > > >                       dev->current_state = state;
> > > >
> > > > -             if (state == PCI_D0)
> > > > -                     return 0;
> > > > -
> > > >               return -EIO;
> > > >       }
> > > >
> > > > @@ -1302,8 +1299,12 @@ static int pci_set_full_power_state(struct pci_dev *dev)
> > > >       int ret;
> > > >
> > > >       ret = pci_power_up(dev);
> > > > -     if (ret < 0)
> > > > +     if (ret < 0) {
> > > > +             if (dev->current_state == PCI_D0)
> > > > +                     return 0;
> > > > +
> > > >               return ret;
> > > > +     }
> > > >       pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> > > >       dev->current_state = pmcsr & PCI_PM_CTRL_STATE_MASK;
> 
> One thing that makes me hesitate a little bit is that we rely on the
> failure return from pci_power_up() to guard the dev->pm_cap usage.
> That's slightly obscure, and I liked the way the v1 patch made it
> explicit.
> 
> And it seems slightly weird that when there's no PM cap,
> pci_power_up() always returns failure even if the platform was able to
> put the device in D0.
> 
> Anyway, here's a proposal for commit log and updated comment for
> pci_power_up():

I applied the patch below on pci/pm for v6.6.

> commit 5694ba13b004 ("PCI/PM: Only read PCI_PM_CTRL register when available")
> Author: Feiyang Chen <chenfeiyang@loongson.cn>
> Date:   Thu Aug 24 09:37:38 2023 +0800
> 
>     PCI/PM: Only read PCI_PM_CTRL register when available
>     
>     For a device with no Power Management Capability, pci_power_up() previously
>     returned 0 (success) if the platform was able to put the device in D0,
>     which led to pci_set_full_power_state() trying to read PCI_PM_CTRL, even
>     though it doesn't exist.
>     
>     Since dev->pm_cap == 0 in this case, pci_set_full_power_state() actually
>     read the wrong register, interpreted it as PCI_PM_CTRL, and corrupted
>     dev->current_state.  This led to messages like this in some cases:
>     
>       pci 0000:01:00.0: Refused to change power state from D3hot to D0
>     
>     To prevent this, make pci_power_up() always return a negative failure code
>     if the device lacks a Power Management Capability, even if non-PCI platform
>     power management has been able to put the device in D0.  The failure will
>     prevent pci_set_full_power_state() from trying to access PCI_PM_CTRL.
>     
>     Fixes: e200904b275c ("PCI/PM: Split pci_power_up()")
>     Link: https://lore.kernel.org/r/20230824013738.1894965-1-chenfeiyang@loongson.cn
>     Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Reviewed-by: "Rafael J. Wysocki" <rafael@kernel.org>
>     Cc: stable@vger.kernel.org	# v5.19+
> 
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 60230da957e0..39728196e295 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1226,6 +1226,10 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
>   *
>   * On success, return 0 or 1, depending on whether or not it is necessary to
>   * restore the device's BARs subsequently (1 is returned in that case).
> + *
> + * On failure, return a negative error code.  Always return failure if @dev
> + * lacks a Power Management Capability, even if the platform was able to
> + * put the device in D0 via non-PCI means.
>   */
>  int pci_power_up(struct pci_dev *dev)
>  {
> @@ -1242,9 +1246,6 @@ int pci_power_up(struct pci_dev *dev)
>  		else
>  			dev->current_state = state;
>  
> -		if (state == PCI_D0)
> -			return 0;
> -
>  		return -EIO;
>  	}
>  
> @@ -1302,8 +1303,12 @@ static int pci_set_full_power_state(struct pci_dev *dev)
>  	int ret;
>  
>  	ret = pci_power_up(dev);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		if (dev->current_state == PCI_D0)
> +			return 0;
> +
>  		return ret;
> +	}
>  
>  	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>  	dev->current_state = pmcsr & PCI_PM_CTRL_STATE_MASK;
