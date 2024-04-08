Return-Path: <linux-pci+bounces-5894-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5BA89CBD7
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 20:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C301282119
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 18:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9221B145348;
	Mon,  8 Apr 2024 18:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwyL7jGb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CEC145332;
	Mon,  8 Apr 2024 18:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712601667; cv=none; b=GRCNkRIYj6jDi3yCLOt6I2h6SO8ynzLa4bT/ckAM+8NSHDXDJEm+NyzdgriGTwq0mMoKGDKgJQexabgZMzcRGLJQ8gr+Mkz4PwY1srf3efiRof2XHVtkhjd3HtTIbPehPGDTBTrgfT2eyCU/j8Y75WnKCSzeMFtIFtXy08avUEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712601667; c=relaxed/simple;
	bh=KtXXAXnBn5KIEtFlzU8t7PHjMTnEpKskhs72pTDveFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jv36/PHE7czg7TE6feXR+qwjsyVQj/aLnW/I75LDRSbI6+rJI6yzjECIa/RNCcGplcqny9ZTzUttAaDnC+BBCyWFPQwfZuZyisTCYHMq47j3GSzik1fnGAWecf5N3pHLVJmT0hgTJIAMqta2UP5lU92Cx3FbHCnFpllgZUEpIz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwyL7jGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE75C433F1;
	Mon,  8 Apr 2024 18:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712601667;
	bh=KtXXAXnBn5KIEtFlzU8t7PHjMTnEpKskhs72pTDveFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EwyL7jGbbh+ZS28JFFcybu8s01F6Cvz6rvzgDsWc7+HIR3LI68Zk0KdJRpQDz2f7A
	 yPdutPMCS3KgNyhM4dXA/fFPX/jOJspMtKD9GuEKx2MFme5V3bDSLxR64L4wBEpBJZ
	 otQCJT9hFvNcU9c0Oop60Q/CD80s8D2u8TBrM6coykBSTTV7EnAzqkvv9FG8soyEuS
	 3VA3O46eqebxPTu3pRyFzHz1Ul1ngCYqqP4ApsXUr0S4hb49UvX1h4bxeGjpk36Pm8
	 +M7jDfe9fj0IErFvkcIS4Vhf3lQthPc2yzsTdFvBDsfZM0SNdzNu4Z/gRECP3J59QN
	 S0scRL3O5L9hw==
Date: Mon, 8 Apr 2024 21:41:02 +0300
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
Message-ID: <20240408184102.GA4195@unreal>
References: <Zg7JDL2WOaIf3dxI@nanopsycho>
 <CAKgT0Ufgm9-znbnxg3M3wQ-A13W5JDaJJL0yXy3_QaEacw9ykQ@mail.gmail.com>
 <20240404132548.3229f6c8@kernel.org>
 <660f22c56a0a2_442282088b@john.notmuch>
 <20240404165000.47ce17e6@kernel.org>
 <CAKgT0UcmE_cr2F0drUtUjd+RY-==s-Veu_kWLKw8yrds1ACgnw@mail.gmail.com>
 <20240404193817.500523aa@kernel.org>
 <CAKgT0UdAz1mb48kFEngY5sCvHwYM2vYtEK81VceKj-xo6roFyA@mail.gmail.com>
 <20240408061846.GA8764@unreal>
 <CAKgT0UcE5cOKO4JgR-PBstP3e9r02+NyG3YrNQe8p2_25Xpf8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0UcE5cOKO4JgR-PBstP3e9r02+NyG3YrNQe8p2_25Xpf8g@mail.gmail.com>

On Mon, Apr 08, 2024 at 08:26:33AM -0700, Alexander Duyck wrote:
> On Sun, Apr 7, 2024 at 11:18 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Fri, Apr 05, 2024 at 08:41:11AM -0700, Alexander Duyck wrote:
> > > On Thu, Apr 4, 2024 at 7:38 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > <...>
> >
> > > > > > Technical solution? Maybe if it's not a public device regression rules
> > > > > > don't apply? Seems fairly reasonable.
> > > > >
> > > > > This is a hypothetical. This driver currently isn't changing anything
> > > > > outside of itself. At this point the driver would only be build tested
> > > > > by everyone else. They could just not include it in their Kconfig and
> > > > > then out-of-sight, out-of-mind.
> > > >
> > > > Not changing does not mean not depending on existing behavior.
> > > > Investigating and fixing properly even the hardest regressions in
> > > > the stack is a bar that Meta can so easily clear. I don't understand
> > > > why you are arguing.
> > >
> > > I wasn't saying the driver wouldn't be dependent on existing behavior.
> > > I was saying that it was a hypothetical that Meta would be a "less
> > > than cooperative user" and demand a revert.  It is also a hypothetical
> > > that Linus wouldn't just propose a revert of the fbnic driver instead
> > > of the API for the crime of being a "less than cooperative maintainer"
> > > and  then give Meta the Nvidia treatment.
> >
> > It is very easy to be "less than cooperative maintainer" in netdev world.
> > 1. Be vendor.
> > 2. Propose ideas which are different.
> > 3. Report for user-visible regression.
> > 4. Ask for a fix from the patch author or demand a revert according to netdev rules/practice.
> >
> > And voilà, you are "less than cooperative maintainer".
> >
> > So in reality, the "hypothetical" is very close to the reality, unless
> > Meta contribution will be treated as a special case.
> >
> > Thanks
> 
> How many cases of that have we had in the past? I'm honestly curious
> as I don't actually have any reference.

And this is the problem, you don't have "any reference" and accurate
knowledge what happened, but you are saying "less than cooperative
maintainer".

> 
> Also as far as item 3 isn't hard for it to be a "user-visible"
> regression if there are no users outside of the vendor that is
> maintaining the driver to report it? 

This wasn't the case. It was change in core code, which broke specific
version of vagrant. Vendor caught it simply by luck.

> Again I am assuming that the same rules wouldn't necessarily apply
> in the vendor/consumer being one entity case.
> 
> Also from my past experience the community doesn't give a damn about
> 1. It is only if 3 is being reported by actual users that somebody
> would care. The fact is if vendors held that much power they would
> have run roughshod over the community long ago as I know there are
> vendors who love to provide one-off projects outside of the kernel and
> usually have to work to get things into the upstream later and no
> amount of complaining about "the users" will get their code accepted.
> The users may complain but it is the vendors fault for that so the
> community doesn't have to take action.

You are taking it to completely wrong direction with your assumptions.
The reality is that regression was reported by real user without any
vendor code involved. This is why the end result was so bad for all parties.

So no, you can get "less than cooperative maintainer" label really easy in
current environment.

Thanks

