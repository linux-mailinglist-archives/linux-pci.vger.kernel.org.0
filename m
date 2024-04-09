Return-Path: <linux-pci+bounces-5969-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8655A89E324
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 21:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7CEB1C20CB5
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 19:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34578156C43;
	Tue,  9 Apr 2024 19:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEn1bDFu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BEA130A72;
	Tue,  9 Apr 2024 19:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712690151; cv=none; b=cE2fB2jTSDRk9AESbk1GfhbmHlZdKGHn+1bwSNLNSJNhY2A4M+udV3LDL0Iso7eH/89EqLlf2XdB35VAE/Cjq/MAMibxM56e7IQcxecvaCLCwtDMd84Qfgs5OxZlSh2HwQH5pEgho+yZlT0R6FKAneExDm5LKVvz93hO7x0j1g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712690151; c=relaxed/simple;
	bh=Fi6Dm51HnSpoA/lFX3RdvNX2WUP4OdXxt7yt8AtCDow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cirb2mmLwogt86QDQDBE79Ra5keFXoyoIm2OTsDyPwjEf6tJ15Y3R5NQSXv1KkfMb6ZNMPI8/j47hosjIVcLMfmSJ8DSN1q/cYJHJ6XeATSoMcRcTnhFZDQaCzEyqX9qHeksUt946zDq+5pSlRuS8BqQsYe5/lAOJiLqfHcU9rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEn1bDFu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B428DC433C7;
	Tue,  9 Apr 2024 19:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712690150;
	bh=Fi6Dm51HnSpoA/lFX3RdvNX2WUP4OdXxt7yt8AtCDow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FEn1bDFuSK5AL6JNR/iromo5QHbWpRMO7p80DmnWCRfNqikb/L64BtNSsjRdUbHIj
	 D0EKHegMmu8t6f1f9sJDKZ05VQ97yNnS4SBYrT+phiaE4FlQWKLX13gAZ60Qslc0aN
	 3R70SZbdXfIDAmcuTGsaRfAoGQnBKmVdaoZVlhM+IKHjrxNlfs63JewmIyp6Y2W9/M
	 XbqpXapbq7eQzd9Sfe5lRxHiaHEm8CtTDEoIKYI2tT7aXkJxpKRWDEbZRpaXAzeZPs
	 EtpiOgJPqQrTi3OFBOUbMxzrkRw5Eh8LUVWyD7VbKb7iqeR/LHsHq/87dxXU1x89WL
	 IK8TOvhBhvvQQ==
Date: Tue, 9 Apr 2024 22:15:45 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net,
	pabeni@redhat.com
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <20240409191545.GI4195@unreal>
References: <20240408061846.GA8764@unreal>
 <CAKgT0UcE5cOKO4JgR-PBstP3e9r02+NyG3YrNQe8p2_25Xpf8g@mail.gmail.com>
 <20240408184102.GA4195@unreal>
 <CAKgT0UcLWEP5GOqFEDeyGFpJre+g2_AbmBOSXJsoXZuCprGH0Q@mail.gmail.com>
 <20240409081856.GC4195@unreal>
 <CAKgT0UewAZSqU6JF4-cPf7hZM41n_QMuiF_K8SY8hyoROQLgfQ@mail.gmail.com>
 <20240409153932.GY5383@nvidia.com>
 <CAKgT0UeSNxbq3JYe8oNaoWYWSn9+vd1c+AfjvUsietUtS09r0g@mail.gmail.com>
 <20240409171235.GZ5383@nvidia.com>
 <CAKgT0Ufc0Zx6-UwCNbwtEahdbCv=eVqJKoDuoQdz6QMD2tv-ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0Ufc0Zx6-UwCNbwtEahdbCv=eVqJKoDuoQdz6QMD2tv-ww@mail.gmail.com>

On Tue, Apr 09, 2024 at 11:38:59AM -0700, Alexander Duyck wrote:
> On Tue, Apr 9, 2024 at 10:12 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Tue, Apr 09, 2024 at 09:31:06AM -0700, Alexander Duyck wrote:
> >
> > > > expectation is generally things like:
> > > >
> > > >  - The bug is fixed immediately because the issue is obvious to the
> > > >    author
> > > >  - Iteration and rapid progress is seen toward enlightening the author
> > > >  - The patch is reverted, often rapidly, try again later with a good
> > > >    patch
> > >
> > > When working on a development branch that shouldn't be the
> > > expectation. I suspect that is why the revert was pushed back on
> > > initially. The developer wanted a chance to try to debug and resolve
> > > the issue with root cause.
> >
> > Even mm-unstable drops patches on a hair trigger, as an example.
> >
> > You can't have an orderly development process if your development tree
> > is broken in your CI.. Personally I'm grateful for the people who test
> > linux-next (or the various constituent sub trees), it really helps.
> >
> > > Well much of it has to do with the fact that this is supposed to be a
> > > community. Generally I help you, you help me and together we both make
> > > progress. So within the community people tend to build up what we
> > > could call karma. Generally I think some of the messages sent seemed
> > > to make it come across that the Mellanox/Nvidia folks felt it "wasn't
> > > their problem" so they elicited a bit of frustration from the other
> > > maintainers and built up some negative karma.
> >
> > How could it be NVIDIA folks problem? They are not experts in TCP and
> > can't debug it. The engineer running the CI systems did what he was
> > asked by Eric from what I can tell.
> 
> No, I get your message. I wasn't saying it was your problem. All that
> can be asked for is such cooperation. Like I said I think some of the
> problem was the messaging more than the process.

Patch with revert came month+ after we reported the issue and were ready
to do anything to find the root cause, so it is not the messaging issue,
it was the exclusion from process issue.

I tried to avoid to write the below, but because Jason brought it
already, I'll write my feelings.

Current netdev has very toxic environment, with binary separation to
vendors and not-vendors.

Vendors are bad guys who day and night try to cheat and sneak their
dirty hacks into the kernel. Their contributions are negligible and
can't be trusted by definition.

Luckily enough, there are some "not-vendors" and they are the good
guys who know what is the best for the community and all other world.

Thanks

