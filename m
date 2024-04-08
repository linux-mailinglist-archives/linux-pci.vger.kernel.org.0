Return-Path: <linux-pci+bounces-5857-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0992889B78F
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 08:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72FFDB221D0
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 06:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE0D849C;
	Mon,  8 Apr 2024 06:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlOndreW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A36479FE;
	Mon,  8 Apr 2024 06:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712557131; cv=none; b=CXg9iTmBP2PYXlDjhQfVW5Tu60488x0+PPcs5hQ+wpeifkHubip7pJ7+aKUOiTt10/DVzV3saIPCjV1WmZf6TdDfALcmf76ypM61vX/22dtCk8wphgks/Wg5OvE55uT/FEfQNrUCiVAkQPO3xzFzoNsirbXwIUlbgAu6fY1gpbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712557131; c=relaxed/simple;
	bh=DIuA8oFwm/vpb38UIq95JDqRuLtIzxfyMX4vnoI6NeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLAFt78N5T+ABg2OYiI9cIPiWOcbip+SKtsANu42jJxx+nF+a0GYRIyuLg0OZBIea1EOya6L6XnXVobu7nVoIho9h1W8Do0om6WEGT3CjJcfBnQRpHD90F1zyX4d2QNE8+08vxfk/FHAbLAggGaX8TAYdUEMMPvZKo6WiNuErXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlOndreW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC4AC433F1;
	Mon,  8 Apr 2024 06:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712557130;
	bh=DIuA8oFwm/vpb38UIq95JDqRuLtIzxfyMX4vnoI6NeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MlOndreWiIQHypWltN1SBSVOe0uo7bN2o4w2w2hIhozWzGK/7D9L3GyKt8BGqh40n
	 XqQZeDmuyHtFLAeLQknY5Vv2tU9ibBrLM77CUPg/kmRtdGsI9OHtd53KCRJdFN6o5J
	 DFxHHuRjTD1OzaOYHaS5ia9o99el5EdwmurHqyc5rTEXbSnR8zGHdORqdO17M9H1wH
	 ePfbRVfGIUfuXKeIx6easXKTi3oE0VQzPxUfvf5R4txiUdRr93FjvaQBLfJ4015y6V
	 jKYLpkc2P+p24BKmpysS7KJ0VgUvFMCjhIUmQt+B3qkvpTyoRCwtIR4TAkiiKqi+ju
	 qJlGRVUB+J1qA==
Date: Mon, 8 Apr 2024 09:18:46 +0300
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
Message-ID: <20240408061846.GA8764@unreal>
References: <Zg6Q8Re0TlkDkrkr@nanopsycho>
 <CAKgT0Uf8sJK-x2nZqVBqMkDLvgM2P=UHZRfXBtfy=hv7T_B=TA@mail.gmail.com>
 <Zg7JDL2WOaIf3dxI@nanopsycho>
 <CAKgT0Ufgm9-znbnxg3M3wQ-A13W5JDaJJL0yXy3_QaEacw9ykQ@mail.gmail.com>
 <20240404132548.3229f6c8@kernel.org>
 <660f22c56a0a2_442282088b@john.notmuch>
 <20240404165000.47ce17e6@kernel.org>
 <CAKgT0UcmE_cr2F0drUtUjd+RY-==s-Veu_kWLKw8yrds1ACgnw@mail.gmail.com>
 <20240404193817.500523aa@kernel.org>
 <CAKgT0UdAz1mb48kFEngY5sCvHwYM2vYtEK81VceKj-xo6roFyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0UdAz1mb48kFEngY5sCvHwYM2vYtEK81VceKj-xo6roFyA@mail.gmail.com>

On Fri, Apr 05, 2024 at 08:41:11AM -0700, Alexander Duyck wrote:
> On Thu, Apr 4, 2024 at 7:38 PM Jakub Kicinski <kuba@kernel.org> wrote:

<...>

> > > > Technical solution? Maybe if it's not a public device regression rules
> > > > don't apply? Seems fairly reasonable.
> > >
> > > This is a hypothetical. This driver currently isn't changing anything
> > > outside of itself. At this point the driver would only be build tested
> > > by everyone else. They could just not include it in their Kconfig and
> > > then out-of-sight, out-of-mind.
> >
> > Not changing does not mean not depending on existing behavior.
> > Investigating and fixing properly even the hardest regressions in
> > the stack is a bar that Meta can so easily clear. I don't understand
> > why you are arguing.
> 
> I wasn't saying the driver wouldn't be dependent on existing behavior.
> I was saying that it was a hypothetical that Meta would be a "less
> than cooperative user" and demand a revert.  It is also a hypothetical
> that Linus wouldn't just propose a revert of the fbnic driver instead
> of the API for the crime of being a "less than cooperative maintainer"
> and  then give Meta the Nvidia treatment.

It is very easy to be "less than cooperative maintainer" in netdev world.
1. Be vendor.
2. Propose ideas which are different.
3. Report for user-visible regression.
4. Ask for a fix from the patch author or demand a revert according to netdev rules/practice.

And voilà, you are "less than cooperative maintainer".

So in reality, the "hypothetical" is very close to the reality, unless
Meta contribution will be treated as a special case.

Thanks

