Return-Path: <linux-pci+bounces-5919-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0859389D407
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 10:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31AD1F2295A
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 08:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1365F7E792;
	Tue,  9 Apr 2024 08:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgEoe7En"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EF77E77B;
	Tue,  9 Apr 2024 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712650741; cv=none; b=ljPspaX++Pz1NH7zNoYZQTT5+U3T8I1Vf4wruazWdPV2BGbOuW1pzZgasM8VZ4A9mYKEnjbwXz4Y5bkHaJVIhf6Yv9beGCap5YZQB7oyV2PiIDYCA8m1CNHRVR1EXS31i9h6mWwomJp1xRhbOfMNhM0hZUyVnYGque1iwW8z8p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712650741; c=relaxed/simple;
	bh=Q3XIy7GKrH3hBQ7X0khzJAv0hJN0tBosWvY47yskPCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIJIFQzcqd0/5mI2IgYloUy1UpbpSwJQhVukFVIGSV/48V1As/N8b3bpk/sRH3pMDDq2aBr2Dwtf8dDC5MdV9lF6GQRq4n7ykwSpRK7ak2HTwA48fC10lv/SZS6pexxq/qayLoJ7Ul7ys2v4pNflPbQNbDyPuDV/hDZ4jFXqa+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgEoe7En; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B6CC433F1;
	Tue,  9 Apr 2024 08:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712650741;
	bh=Q3XIy7GKrH3hBQ7X0khzJAv0hJN0tBosWvY47yskPCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FgEoe7EnyqYvOdFKQgcmu+ZTQ6OECLlFfpPmcl40xwH9936kdrho2yu5S5hyXOO9i
	 S6Om9zTbmsIs2XsKWVWvGu+/6Vjy17UAtkIFCun3acPIrs87hOisFvNOPWH0fhbYu1
	 zKMRTQfj8vrJrnh7DqinCQMwjd3gllYDBvL+Apcldon34pm6tdH2ip5NFuS7xktKWb
	 rMDbKB1vE8PcGww3IFram/6fqGj2Aixo/egio5cVUlnBKZZF9Y+sm4GDpvp2EAwZ95
	 Fbq0z2DyMRZtAUBHU3UB6mP4LBMAlf32ypb9DUUh+qjcuA4pHQp9dIXfQ+pWqlW5ZY
	 8nc6du6zCmQhw==
Date: Tue, 9 Apr 2024 11:18:56 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net,
	pabeni@redhat.com
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <20240409081856.GC4195@unreal>
References: <20240404132548.3229f6c8@kernel.org>
 <660f22c56a0a2_442282088b@john.notmuch>
 <20240404165000.47ce17e6@kernel.org>
 <CAKgT0UcmE_cr2F0drUtUjd+RY-==s-Veu_kWLKw8yrds1ACgnw@mail.gmail.com>
 <20240404193817.500523aa@kernel.org>
 <CAKgT0UdAz1mb48kFEngY5sCvHwYM2vYtEK81VceKj-xo6roFyA@mail.gmail.com>
 <20240408061846.GA8764@unreal>
 <CAKgT0UcE5cOKO4JgR-PBstP3e9r02+NyG3YrNQe8p2_25Xpf8g@mail.gmail.com>
 <20240408184102.GA4195@unreal>
 <CAKgT0UcLWEP5GOqFEDeyGFpJre+g2_AbmBOSXJsoXZuCprGH0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0UcLWEP5GOqFEDeyGFpJre+g2_AbmBOSXJsoXZuCprGH0Q@mail.gmail.com>

On Mon, Apr 08, 2024 at 01:43:28PM -0700, Alexander Duyck wrote:
> On Mon, Apr 8, 2024 at 11:41 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Mon, Apr 08, 2024 at 08:26:33AM -0700, Alexander Duyck wrote:
> > > On Sun, Apr 7, 2024 at 11:18 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > >
> > > > On Fri, Apr 05, 2024 at 08:41:11AM -0700, Alexander Duyck wrote:
> > > > > On Thu, Apr 4, 2024 at 7:38 PM Jakub Kicinski <kuba@kernel.org> wrote:
> > > >
> > > > <...>
> > > >
> > > > > > > > Technical solution? Maybe if it's not a public device regression rules
> > > > > > > > don't apply? Seems fairly reasonable.
> > > > > > >
> > > > > > > This is a hypothetical. This driver currently isn't changing anything
> > > > > > > outside of itself. At this point the driver would only be build tested
> > > > > > > by everyone else. They could just not include it in their Kconfig and
> > > > > > > then out-of-sight, out-of-mind.
> > > > > >
> > > > > > Not changing does not mean not depending on existing behavior.
> > > > > > Investigating and fixing properly even the hardest regressions in
> > > > > > the stack is a bar that Meta can so easily clear. I don't understand
> > > > > > why you are arguing.
> > > > >
> > > > > I wasn't saying the driver wouldn't be dependent on existing behavior.
> > > > > I was saying that it was a hypothetical that Meta would be a "less
> > > > > than cooperative user" and demand a revert.  It is also a hypothetical
> > > > > that Linus wouldn't just propose a revert of the fbnic driver instead
> > > > > of the API for the crime of being a "less than cooperative maintainer"
> > > > > and  then give Meta the Nvidia treatment.
> > > >
> > > > It is very easy to be "less than cooperative maintainer" in netdev world.
> > > > 1. Be vendor.
> > > > 2. Propose ideas which are different.
> > > > 3. Report for user-visible regression.
> > > > 4. Ask for a fix from the patch author or demand a revert according to netdev rules/practice.
> > > >
> > > > And voilà, you are "less than cooperative maintainer".
> > > >
> > > > So in reality, the "hypothetical" is very close to the reality, unless
> > > > Meta contribution will be treated as a special case.
> > > >
> > > > Thanks
> > >
> > > How many cases of that have we had in the past? I'm honestly curious
> > > as I don't actually have any reference.
> >
> > And this is the problem, you don't have "any reference" and accurate
> > knowledge what happened, but you are saying "less than cooperative
> > maintainer".

<...>

> Any more info on this? Without context it is hard to say one way or the other.

<...>

> I didn't say you couldn't. Without context I cannot say if it was
> deserved or not. 

Florian gave links to the context, so I'll skip this part.

In this thread, Jakub tried to revive the discussion about it.
https://lore.kernel.org/netdev/20240326133412.47cf6d99@kernel.org/

<...>

> The point I was trying to make is that if you are the only owner of
> something, and not willing to work with the community as a maintainer

Like Jakub, I don't understand why you are talking about regressions in
the driver, while you brought the label of "less than cooperative maintainer"
and asked for "then give Meta the Nvidia treatment".

I don't want to get into the discussion about if this driver should be
accepted or not.

I'm just asking to stop label people and companies based on descriptions
from other people, but rely on facts.

Thanks

