Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC101C5711
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 15:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgEENf6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 09:35:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:52568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728954AbgEENf6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 May 2020 09:35:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4E62206A5;
        Tue,  5 May 2020 13:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588685758;
        bh=27eegcfN4OCPFz8Eg3QszwZbxwkuazdL8Z4GFlVGgsc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vqtExeeaUnSviGJmZkNmbJ6Gn/s2RKKtdHtQdFsbPTHdXw+HyZ9OVK5RAdxltmRQG
         jVJjsOGMfvCI/WGbVQ5zHdvfKgTgaX2fnfB2z5y9vZhl75mVcFbfArkyRk0aowa72w
         jhu7JDiZmh5qT097JYnQM5NPjFPBnbFY2zULRZrc=
Date:   Tue, 5 May 2020 15:35:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Aman Sharma <amanharitsh123@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 1/2] driver core: platform: Clarify that IRQ 0 is
 invalid
Message-ID: <20200505133555.GA529259@kroah.com>
References: <20200504190721.GA2810934@kroah.com>
 <20200504222659.GA296947@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504222659.GA296947@bjorn-Precision-5520>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 04, 2020 at 05:26:59PM -0500, Bjorn Helgaas wrote:
> On Mon, May 04, 2020 at 09:07:21PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, May 04, 2020 at 01:08:22PM -0500, Bjorn Helgaas wrote:
> > > On Sat, May 02, 2020 at 08:15:37AM +0200, Greg Kroah-Hartman wrote:
> > > > On Fri, May 01, 2020 at 05:40:41PM -0500, Bjorn Helgaas wrote:
> > > > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > > > 
> > > > > These interfaces return a negative error number or an IRQ:
> > > > > 
> > > > >   platform_get_irq()
> > > > >   platform_get_irq_optional()
> > > > >   platform_get_irq_byname()
> > > > >   platform_get_irq_byname_optional()
> > > > > 
> > > > > The function comments suggest checking for error like this:
> > > > > 
> > > > >   irq = platform_get_irq(...);
> > > > >   if (irq < 0)
> > > > >     return irq;
> > > > > 
> > > > > which is what most callers (~900 of 1400) do, so it's implicit
> > > > > that IRQ 0 is invalid.  But some callers check for "irq <= 0",
> > > > > and it's not obvious from the source that we never return an
> > > > > IRQ 0.
> > > > > 
> > > > > Make this more explicit by updating the comments to say that
> > > > > an IRQ number is always non-zero and adding a WARN() if we
> > > > > ever do return zero.  If we do return IRQ 0, it likely
> > > > > indicates a bug in the arch-specific parts of
> > > > > platform_get_irq().
> > > > 
> > > > I worry about adding WARN() as there are systems that do
> > > > panic_on_warn() and syzbot trips over this as well.  I don't
> > > > think that for this issue it would be a problem, but what really
> > > > is this warning about that someone could do anything with?
> > > > 
> > > > Other than that minor thing, this looks good to me, thanks for
> > > > finally clearing this up.
> > > 
> > > What I'm concerned about is an arch that returns 0.  Most drivers
> > > don't check for 0 so they'll just try to use it, and things will
> > > fail in some obscure way.  My assumption is that if there really
> > > is no IRQ, we should return -ENOENT or similar instead of 0.
> > > 
> > > I could be convinced that it's not worth warning about at all, or
> > > we could do something like the following:
> > > 
> > > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > > index 084cf1d23d3f..4afa5875e14d 100644
> > > --- a/drivers/base/platform.c
> > > +++ b/drivers/base/platform.c
> > > @@ -220,7 +220,11 @@ int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
> > >  	ret = -ENXIO;
> > >  #endif
> > >  out:
> > > -	WARN(ret == 0, "0 is an invalid IRQ number\n");
> > > +	/* Returning zero here is likely a bug in the arch IRQ code */
> > > +	if (ret == 0) {
> > > +		pr_warn("0 is an invalid IRQ number\n");
> > > +		dump_stack();
> > > +	}
> > >  	return ret;
> > >  }
> > > ...
> 
> > I like that, but you said this is something that the platform people
> > should only see when bringing up a new system, so maybe the WARN() is
> > fine.  It's not user-triggerable, so your original is ok.
> 
> Is that an ack?  Thomas, any thoughts?

Sorry, yes:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
