Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB59650A6A7
	for <lists+linux-pci@lfdr.de>; Thu, 21 Apr 2022 19:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377860AbiDURMO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Apr 2022 13:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiDURMN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Apr 2022 13:12:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAE949939;
        Thu, 21 Apr 2022 10:09:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9806E61DCE;
        Thu, 21 Apr 2022 17:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B918FC385A1;
        Thu, 21 Apr 2022 17:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650560962;
        bh=pYBbiCwID5HXC7VcTJHey58ZSh0xVcdu7E2mj9buXWw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cDJyYQ0v2tnR8LzIaaaQzNc1xuViaoNMmBwsnG3PrguoYK9USwzbUne1bQK6aIzLE
         gi2dIHEEdBxIV2btKilLgJKRLI4cnlBgfRbYZpqzMMNhJzsiIoaNhd7mpQfCN5aMDU
         bLA+KqKPglT4iaeHijewcskTGyHf+kAwTt1rLgArjxOErXeAkPKyzoJ3iweeW1/tFG
         dBgcvB4JBPDUq4YklSxBD1YcGxWji3fTmvUl0TFo7bcS8wXlYyOhZr1iqfpZlojspk
         Esq5HJn+zA8s/sB2HbAp3B1BoDJ2VEXhNoppvmR6qhDo5zbtNwVjljCToAL1eG28sa
         vtlOZhSn0ZdcA==
Date:   Thu, 21 Apr 2022 12:09:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/4] PCI: Clean up pci_scan_slot()
Message-ID: <20220421170920.GA1408189@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8225cf74d6d81c3ce149d677b5bf47689d8e3fd2.camel@linux.ibm.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 21, 2022 at 11:27:42AM +0200, Niklas Schnelle wrote:
> On Wed, 2022-04-20 at 21:14 -0500, Bjorn Helgaas wrote:
> > On Tue, Apr 19, 2022 at 12:28:00PM +0200, Niklas Schnelle wrote:
> > > While determining the next PCI function is factored out of
> > > pci_scan_slot() into next_fn() the former still handles the first
> > > function as a special case duplicating the code from the scan loop and
> > > splitting the condition that the first function exits from it being
> > > multifunction which is tested in next_fn().
> > > 
> > > Furthermore the non ARI branch of next_fn() mixes the case that
> > > multifunction devices may have non-contiguous function ranges and dev
> > > may thus be NULL with the multifunction requirement. It also signals
> > > that no further functions need to be scanned by returning 0 which is
> > > a valid function number.
> > > 
> > > Improve upon this by moving all conditions for having to scan for more
> > > functions into next_fn() and make them obvious and commented.
> > > 
> > > By changing next_fn() to return -ENODEV instead of 0 when there is no
> > > next function we can then handle the initial function inside the loop
> > > and deduplicate the shared handling.
> > > 
> > > No functional change is intended.
> > > 
> > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > ---
> > >  drivers/pci/probe.c | 41 +++++++++++++++++++----------------------
> > >  1 file changed, 19 insertions(+), 22 deletions(-)
> > > 
> > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > index 17a969942d37..389aa1f9cb2c 100644
> > > --- a/drivers/pci/probe.c
> > > +++ b/drivers/pci/probe.c
> > > @@ -2579,33 +2579,35 @@ struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
> > >  }
> > >  EXPORT_SYMBOL(pci_scan_single_device);
> > >  
> > > -static unsigned int next_fn(struct pci_bus *bus, struct pci_dev *dev,
> > > -			    unsigned int fn)
> > > +static int next_fn(struct pci_bus *bus, struct pci_dev *dev, int fn)
> > >  {
> > >  	int pos;
> > >  	u16 cap = 0;
> > >  	unsigned int next_fn;
> > >  
> > > -	if (pci_ari_enabled(bus)) {
> > > -		if (!dev)
> > > -			return 0;
> > > +	if (dev && pci_ari_enabled(bus)) {
> > 
> > I think this would be easier to verify if we kept the explicit error
> > return, e.g.,
> > 
> >   if (pci_ari_enabled(bus)) {
> >     if (!dev)
> >       return -ENODEV;
> >     pos = pci_find_ext_capability(...);
> > 
> > Otherwise we have to sort through the !dev cases below.  I guess
> > -ENODEV would come from either the "!fn && !dev" case or the "fn > 6"
> > case, but it's not obvious to me that those are equivalent to the
> > previous code.
> 
> We could keep this the same for this patch but I think for jailhouse
> (patch 2) we need the "!dev" case not to fail here such that we can
> handle the missing function 0 below even if ARI is enabled. For s390
> this doesn't currently matter because pci_ari_enabled(bus) is always
> false but I assumed that this isn't necessarily so for jailhouse. I
> sent a follow up mail on a slight behavior change I can think of for
> this case for v2 but forgot to send it also for v3. Quoted below:

I think it would be good to make the first patch change as little as
possible to make it easier to analyze, then possibly test for
hypervisor when changing this behavior.

> > > -	/* dev may be NULL for non-contiguous multifunction devices */
> > > -	if (!dev || dev->multifunction)
> > > -		return (fn + 1) % 8;
> > > -
> > > -	return 0;
> > > +	/* only multifunction devices may have more functions */
> > > +	if (dev && !dev->multifunction)
> > > +		return -ENODEV;
> > 
> > I don't understand why the "!dev || dev->multifunction" test needs to
> > change.  Isn't that valid even in the hypervisor case?  IIUC, you want
> > to return success in some cases that currently return failure, so this
> > case that was already success should be fine as it was.
> 
> This isn't a change to the test. It's the negation of the logical
> condition *and* a switch of the branches i.e. keeps the overall
> behavior exactly the same. The equivalence is !(!A || B) == (A && !B).

I see the Boolean equivalence, but it's difficult to verify that the
consequences are equivalent because the new code has the extra "!fn &&
!dev" test in the middle.

> There are two reasons I did this.
> 
> 1. I find (!dev || dev->multifunction) to be much harder to grasp than
> (dev && !dev->multifunction).
> 
> 2. The whole next_fn() in my opinion becomes easier to read if it bails
> for all bad cases early and the "this is the next fn" is the final
> return if we didn't bail. This becomes even more true as another
> condition is added in patch 2.

Fair enough, and I agree that "this is the next fn" is a nice final
return.  In general I think it's good to return either an error or the
next fn as soon as it is known.  It makes it harder to analyze if the
return value has already been determined but we have to mentally pass
over subsequent tests that don't affect it.

> > Is this because "(fn + 1) % 8" may be zero, which previously
> > terminated the loop, but now it doesn't because "fn == 0" is the
> > *first* execution of the loop?
> 
> Yes with function 0 handled in the loop we can't use 0 as the
> termination indication. Also I find it generally weird to use a wrap
> around for this.

Yes, I agree that's weird.  Usually I prefer "for" loops over
"do ...  while", but this might be a case where it makes sense --
we *always* want to call pci_scan_single_device() once, and
"do ... while" would accomplish that without any fuss.  It might even
allow us to keep the 0 return value as the termination condition,
which would be nice because fn could stay unsigned and it would reduce
the size of this patch.

I'm hoping we can end up with something like this:

  unsigned int next_fn(bus, dev, fn, mf)
  {
    if (ari(bus)) {
      if (!dev)
	return 0;
      return PCI_ARI_CAP_NFN();
    }

    if (fn >= 7)
      return 0;

    if (mf)
      return fn + 1;

    if (hypervisor())
      return fn + 1;

    return 0;
  }

  int pci_scan_slot(...)
  {
    unsigned int fn = 0, mf = 0;

    do {
      dev = pci_scan_single_device(bus, devfn + fn);
      if (dev && dev->multifunction)
	mf = 1;
      fn = next_fn(dev, fn, mf);
    } while (fn);
  }

This would be minimal change to next_fn(): just add the "mf"
parameter, which removes a lot of the confusing "dev" and "!dev"
testing, and add the "fn >= 7" to remove the implicit "% 8 == 0"
failure case.

Then the jailhouse/s390 patch would trivially add the new hypervisor
case, which is clearly separated from everything else.

> > If so, I wonder if we could avoid that case by adding:
> > 
> >   if (fn >= 7)
> >     return -ENODEV;
> > 
> > at the very beginning.  Maybe that would allow a more trivial patch
> > that just changed the error return from 0 to -ENODEV, i.e., leaving
> > all the logic in next_fn() unchanged?
> 
> I think this is equivalent to the ternary at the return. Both return
> -ENODEV for fn >= 7. I do like your idea better though as it keeps with
> the scheme of my point 2 above and ternaries are ever so slightly
> harder to read.

Oops, I don't think we can do this directly because in the ARI case,
fn is basically 8 bits wide so can be 0-255.

Bjorn
