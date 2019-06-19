Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 543B74C358
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 23:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfFSVxv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jun 2019 17:53:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:32970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbfFSVxv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Jun 2019 17:53:51 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49B282085A;
        Wed, 19 Jun 2019 21:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560981230;
        bh=fqbjUKDf252x6dORKxx9iyw7JhKFDlRpbQAR3eEwAm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=me45NDdLH6UxgXQgwNUnfnzAGM30ku4BsTVaOkuF0Y3KVkLEtREsXHNDftBgJR6MY
         xWLeNtcFTDnLcbabHMD9TTAiRUP9tF6mZD9fsGnbviO9vsrJb0vzAbtjD38WcOCUF6
         lBZ4ua2nS6fMEjmjE5VJdbEH+MBaI3kKK1Ugup3o=
Date:   Wed, 19 Jun 2019 16:53:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: Re: [PATCH v6 1/4] PCI: Consider alignment of hot-added bridges when
 distributing available resources
Message-ID: <20190619215347.GF143205@google.com>
References: <20190522222928.2964-1-nicholas.johnson-opensource@outlook.com.au>
 <PS2P216MB0642C7A485649D2D787A1C6F80000@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
 <20190615195636.GX13533@google.com>
 <SL2P216MB0187A21C5F51B7F924A832CC80E50@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SL2P216MB0187A21C5F51B7F924A832CC80E50@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 19, 2019 at 01:40:50PM +0000, Nicholas Johnson wrote:
> At least I have found out that git send-email uses terrible 
> encoding and adds the patch as an attachment

This must be configurable somehow because many people use git
send-email to send plain-text patches.

> On Sat, Jun 15, 2019 at 02:56:36PM -0500, Bjorn Helgaas wrote:
> > On Wed, May 22, 2019 at 02:30:44PM +0000, Nicholas Johnson wrote:

> > > +	 * The alignment of this bridge is yet to be considered, hence it must
> > > +	 * be done now before extending its bridge window. A single bridge
> > > +	 * might not be able to occupy the whole parent region if the alignment
> > > +	 * differs - for example, an external GPU at the end of a Thunderbolt
> > > +	 * daisy chain.
> > 
> > The example seems needlessly specific.  There isn't anything GPU- or
> > Thunderbolt-specific about this, is there?
> > 
> > Bridge windows can be aligned to any multiple of 1MB.  But a device
> > BAR must be aligned on its size, so any BAR larger than 1MB should be
> > able to cause this, e.g.,
> > 
> >   [mem 0x100000-0x3fffff] (bridge A 3MB window)
> >     [mem 0x200000-0x3fffff] (bridge B 2MB window)
> >       [mem 0x200000-0x3fffff] (device 2MB BAR)
> > 
> > Bridge B *could* occupy the the entire 3MB parent region, but it
> > doesn't need to.  But you say it "might not be *able* to", so maybe
> > you're thinking of something different?
>
> Under some circumstances it may be possible to occupy the entire region, 
> but not always. If the start address of the entire parent region is not 
> aligned to the boundary required by the child then the start address of 
> the child needs to be bumped up to the next boundary, leaving some 
> unused space. In Mika's take on this, he suggested that I just remove 
> this comment. I agreed. Does this solve the issue in your mind?

"The alignment of this bridge ..." sentence might be useful.  But I
don't think the "A single bridge ..." sentence makes sense.  Even if
the parent region isn't sufficiently aligned for descendents of the
child, the child's window *could* start at the parent's start address.
Then some space routed to the child's secondary would be unused.

Maybe when you said the bridge "might not be able to occupy" you meant
that not all the space would be usable by descendants of the child.  I
certainly agree with that.  I read it as "the child's window might not
be able to consume the whole parent window", which is not true.

> > > -	 * are on this bus.  We will distribute the additional available
> > > +	 * are on this bus. We will distribute the additional available
> > 
> > This whitespace change is pointless and distracting.
>
> Okay. I will read this as "remove it".

Yes, please.  We always try to minimize the size of a patch, so it's
worthwhile to read the patch before sending it.

> > Moving this "single bridge" case up makes sense, and I think it could
> > be done by a separate patch preceding this one.  Mika, I remember some
> > discussion about this case, but I can't remember if there's some
> > reason you didn't do this initially.
> > 
> > The current code is:
> > 
> >   for_each_pci_bridge(dev, bus)
> >     # compute hotplug_bridges, normal_bridges
> > 
> >   for_each_pci_bridge(dev, bus)
> >     # compute remaining_io, etc
> > 
> >   if (hotplug_bridges + normal_bridges == 1)
> >     # handle single bridge case
> > 
> >   for_each_pci_bridge(dev, bus)
> >     # use remaining_io, etc here
> > 
> > AFAICT the single bridge case has no dependency on the remaining_io
> > computation.
>
> If you want another patch then please explicitly request it with how you 
> want it to be done.

Yes, please make it a separate patch.  The advantages are:

  - each patch becomes smaller
  - each patch is easier to review by itself
  - if the series causes a problem, bisection gives a more specific
    result
  - if we need to revert a patch, we may be able to keep the other
    patches

> > > +	if (!hotplug_bridges)
> > >  		return;
> > 
> > I like the addition of this early return when there are no hotplug
> > bridges.  The following loop is a no-op if there are no hotplug
> > bridges, so it doesn't *fix* anything, but it does make it more
> > obvious that we don't even have to bother with the loop at all, and
> > it makes the "Here hotplug_bridges is always != 0" comment
> > unnecessary.
>
> It fixes the division by zero on the next line of code, but I love to 
> shoot two birds with one stone. Moving the div64_ul calls out of the 
> loop is the price for the simplification of the loop.
> 
> > I think this could be done in a separate patch before this one, too.
> > Anything we can do to simplify these patches is a win because the code
> > is so complicated.
>
> Again, please provide guidance on what exactly you wish to be separated, 
> and whether the patch should be before or after the other preliminary 
> patch to move the loop up by one.
> 
> My initial interpretation is that you want me to add the following in 
> Mika's code before his equivalent loop as a two line patch:
> 
> if (!hotplug_bridges)
> 	return;
> 
> Should I take out the following comment at the same time?
> "Here hotplug_bridges is always != 0."

Yes, please make this a separate patch that adds the
"if (!hotplug_bridges)" and removes the comment.  It doesn't really
matter whether this is before or after the other preliminary patch,
since they are unrelated.

Bjorn
