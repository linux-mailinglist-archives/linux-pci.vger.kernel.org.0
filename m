Return-Path: <linux-pci+bounces-5756-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA94899334
	for <lists+linux-pci@lfdr.de>; Fri,  5 Apr 2024 04:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D6981C21521
	for <lists+linux-pci@lfdr.de>; Fri,  5 Apr 2024 02:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3746E134A8;
	Fri,  5 Apr 2024 02:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixxun8zA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3A712E68;
	Fri,  5 Apr 2024 02:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712284699; cv=none; b=FAaNpvfeg33iOpp1ONQRXaSA9HDYwZRkQUfpDg/xXVyWWj9T/fT9ehf4eH4ZL0Xgj1v2J62jG4A6BCpXcParnJGXWzRTx5ml6FPS7lyB3bgw/itGHrbxnWiKp8jxX6UntaJSKBXsw7LXtkugZY8+BvcFzcdKzqNWDuCl27qm6js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712284699; c=relaxed/simple;
	bh=q8KT3VdkpWtyrZPZsIOOaau0ZTOm3ekdX9hDpVw20T4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jq1PYAVi/zbM/bpI5KDsuFKMIiHeMEnwItoG7oT7VR9uV3eNc9TQsev1RiOP1AVLddYx5oCtl7KljOwASqRHCNM3Ewmnw/zC+zdNR2hHU/0kKx5zTjqXV3VE5jobHEVefDzPp5jxEn2jrU+xdVTZ2eo4TZGT7PSfq6N8Z5mzleE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixxun8zA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BECBC433C7;
	Fri,  5 Apr 2024 02:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712284698;
	bh=q8KT3VdkpWtyrZPZsIOOaau0ZTOm3ekdX9hDpVw20T4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ixxun8zAXGLvGzjL8wg3l+dl5V68I1B8lZOJWX6XemIImybjz2rybNuq7ztDegxeY
	 Hwx2X3ZgC6Vlkt5sNkz8j97XPZH0YdnHGNel78mmIf9K4vKlJMn9Twqw5rkE2x5WzM
	 VAV98/j4v1oFSy1LR71z8xE9M2w4bCcTuUQeAsMDeTWY941m1ua+mkQBoNgVf/P/F0
	 fslXE9U27eXRRbfw7oinGzt9RTDwyrUEmMbJuVUV4267QacFo/fYHeF/D2OwZuweZn
	 /bFzui8hw5dCehjRh4RtWVhZKM//y8Oitle7rEEm3Z8IFlIdIbXtzLWIyeuUmmz/Db
	 NPW4J43xRqXPg==
Date: Thu, 4 Apr 2024 19:38:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, netdev@vger.kernel.org, bhelgaas@google.com,
 linux-pci@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
 davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <20240404193817.500523aa@kernel.org>
In-Reply-To: <CAKgT0UcmE_cr2F0drUtUjd+RY-==s-Veu_kWLKw8yrds1ACgnw@mail.gmail.com>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
	<Zg6Q8Re0TlkDkrkr@nanopsycho>
	<CAKgT0Uf8sJK-x2nZqVBqMkDLvgM2P=UHZRfXBtfy=hv7T_B=TA@mail.gmail.com>
	<Zg7JDL2WOaIf3dxI@nanopsycho>
	<CAKgT0Ufgm9-znbnxg3M3wQ-A13W5JDaJJL0yXy3_QaEacw9ykQ@mail.gmail.com>
	<20240404132548.3229f6c8@kernel.org>
	<660f22c56a0a2_442282088b@john.notmuch>
	<20240404165000.47ce17e6@kernel.org>
	<CAKgT0UcmE_cr2F0drUtUjd+RY-==s-Veu_kWLKw8yrds1ACgnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Apr 2024 17:11:47 -0700 Alexander Duyck wrote:
> > Opensourcing is just one push to github.
> > There are guarantees we give to upstream drivers.  
> 
> Are there? Do we have them documented somewhere?

I think they are somewhere in Documentation/
To some extent this question in itself supports my point that written
down rules, as out of date as they may be, seem to carry more respect
than what a maintainer says :S

> > > Eventually they need some kernel changes and than we block those too
> > > because we didn't allow the driver that was the use case? This seems
> > > wrong to me.  
> >
> > The flip side of the argument is, what if we allow some device we don't
> > have access to to make changes to the core for its benefit. Owner
> > reports that some changes broke the kernel for them. Kernel rules,
> > regression, we have to revert. This is not a hypothetical, "less than
> > cooperative users" demanding reverts, and "reporting us to Linus"
> > is a reality :(
> >
> > Technical solution? Maybe if it's not a public device regression rules
> > don't apply? Seems fairly reasonable.  
> 
> This is a hypothetical. This driver currently isn't changing anything
> outside of itself. At this point the driver would only be build tested
> by everyone else. They could just not include it in their Kconfig and
> then out-of-sight, out-of-mind.

Not changing does not mean not depending on existing behavior.
Investigating and fixing properly even the hardest regressions in 
the stack is a bar that Meta can so easily clear. I don't understand
why you are arguing.

> > > Anyways we have zero ways to enforce such a policy. Have vendors
> > > ship a NIC to somebody with the v0 of the patch set? Attach a picture?  
> >
> > GenAI world, pictures mean nothing :) We do have a CI in netdev, which
> > is all ready to ingest external results, and a (currently tiny amount?)
> > of test for NICs. Prove that you care about the device by running the
> > upstream tests and reporting results? Seems fairly reasonable.  
> 
> That seems like an opportunity to be exploited through. Are the
> results going to be verified in any way? Maybe cryptographically
> signed? Seems like it would be easy enough to fake the results.

I think it's much easier to just run the tests than write a system
which will competently lie. But even if we completely suspend trust,
someone lying is of no cost to the community in this case.

> > > Even if vendor X claims they will have a product in N months and
> > > than only sells it to qualified customers what to do we do then.
> > > Driver author could even believe the hardware will be available
> > > when they post the driver, but business may change out of hands
> > > of the developer.
> > >
> > > I'm 100% on letting this through assuming Alex is on top of feedback
> > > and the code is good.  
> >
> > I'd strongly prefer if we detach our trust and respect for Alex
> > from whatever precedent we make here. I can't stress this enough.
> > IDK if I'm exaggerating or it's hard to appreciate the challenges
> > of maintainership without living it, but I really don't like being
> > accused of playing favorites or big companies buying their way in :(  
> 
> Again, I would say we look at the blast radius. That is how we should
> be measuring any change. At this point the driver is self contained
> into /drivers/net/ethernet/meta/fbnic/. It isn't exporting anything
> outside that directory, and it can be switched off via Kconfig.

It is not practical to ponder every change case by case. Maintainers
are overworked. How long until we send the uAPI patch for RSS on the
flow label? I'd rather not re-litigate this every time someone posts
a slightly different feature. Let's cover the obvious points from 
the beginning while everyone is paying attention. We can amend later
as need be.

> When the time comes to start adding new features we can probably start
> by looking at how to add either generic offloads like was done for
> GSO, CSO, ect or how it can also be implemented on another vendor's
> NIC.
> 
> At this point the only risk the driver presents is that it is yet
> another driver, done in the same style I did the other Intel drivers,
> and so any kernel API changes will end up needing to be applied to it
> just like the other drivers.

The risk is we'll have a fight every time there is a disagreement about
the expectations.

> > > I think any other policy would be very ugly to enforce, prove, and
> > > even understand. Obviously code and architecture debates I'm all for.
> > > Ensuring we have a trusted, experienced person signed up to review
> > > code, address feedback, fix whatever syzbot finds and so on is also a
> > > must I think. I'm sure Alex will take care of it.  
> >
> > "Whatever syzbot finds" may be slightly moot for a private device ;)
> > but otherwise 100%! These are exactly the kind of points I think we
> > should enumerate. I started writing a list of expectations a while back:
> >
> > Documentation/maintainer/feature-and-driver-maintainers.rst
> >
> > I think we just need something like this, maybe just a step up, for
> > non-public devices..  
> 
> I honestly think we are getting the cart ahead of the horse. When we
> start talking about kernel API changes then we can probably get into
> the whole "private" versus "publicly available" argument. A good
> example of the kind of thing I am thinking of is GSO partial where I
> ended up with Mellanox and Intel sending me 40G and 100G NICs and
> cables to implement it on their devices as all I had was essentially
> igb and ixgbe based NICs.

That'd be great. Maybe even more than I'd expect. So why not write
it down? In case the person doing the coding is not Alex Duyck, and
just wants to get it done for their narrow use case, get a promo,
go work on something else?

> Odds are when we start getting to those kind of things maybe we need
> to look at having a few systems available for developer use, but until
> then I am not sure it makes sense to focus on if the device is
> publicly available or not.

Developer access would be huge.
A mirage of developer access? immaterial :)

