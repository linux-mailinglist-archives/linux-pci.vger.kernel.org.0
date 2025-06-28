Return-Path: <linux-pci+bounces-30997-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 485D4AEC71D
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 14:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B87817E295
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 12:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5443B23ED75;
	Sat, 28 Jun 2025 12:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRM7yvWo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E062F1FE6;
	Sat, 28 Jun 2025 12:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751113948; cv=none; b=NE3M4xk24nt1lv/Y3PnYlAS/GpVjwdu9o2NUM47XTNr4jvxBlNphNa8Ye0Ub2yfM9CV/S1IiMYrDSkHA3c0Z/rqDV+ftHtc9LHXl2iKkElfFIneknR2GMOfBQpvCoNbFQ0B2t+ZctMq13ph1QoAt95rjeFtmEtcvW8f09DiDe3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751113948; c=relaxed/simple;
	bh=JYYNrGkl597kbFUKM8+TWyiKPVf8sMl4omwZhKosOLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UX7Vd+SBHcZr2D/nUmmsgI+FBUwtZjRA6SqU2zxuMiBtGyvTGm/n/yBfazFS4hdy2gu/GecBsZ9kJiSn60MYjc9OPoNTCGjgrg3Y+WWVa//jGGSSS5DMYMhiLHNe4m72SzO//Hal1qLdiL2kjAWCNZ49k05bdIHBtWlGJ6FDkNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRM7yvWo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB50BC4CEEA;
	Sat, 28 Jun 2025 12:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751113947;
	bh=JYYNrGkl597kbFUKM8+TWyiKPVf8sMl4omwZhKosOLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LRM7yvWoKVVgAdZzbiMnI6SA0xl0+cfpjnBscAumROSINobJerFxB8qDESqS5ihC/
	 PK/O4AyrQBQyz80GNYOJaI87vjMCoNG7CJuzhnFNiW/0s5OjX4ii6lfCJqoPngnYgp
	 6n3vFoTUyDkIAo1MTGZt1KNBb+c90H1MaiPvLqe3kHWvAIjHSf0zMmXH+vOfd5IsOp
	 Gd+s2T7P7/wo3LLtIolR10+i3iC67qy46SiZDDOx/SpttzFS5aU/wkn/6m6I4RwimG
	 qMnf1wtI9qD8eJ1f6Qqjm/8dv7RYYiO8eBEnZnPnfSbi+Ae2YxDuNImt/jqcupl09z
	 ptDd5FdHGgXuQ==
Date: Sat, 28 Jun 2025 14:32:21 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <lossin@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, gregkh@linuxfoundation.org,
	rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, david.m.ertman@intel.com,
	ira.weiny@intel.com, leon@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 5/5] rust: devres: implement register_release()
Message-ID: <aF_g1aspI_6GVRLC@pollux>
References: <20250626200054.243480-6-dakr@kernel.org>
 <aF2vgthQlNA3BsCD@tardis.local>
 <aF2yA9TbeIrTg-XG@cassiopeiae>
 <DAWULS8SIOXS.1O4PLL2WCLX74@kernel.org>
 <aF8V8hqUzjdZMZNe@tardis.local>
 <DAXXVXNTRLYH.1B8O2LKBF4EW1@kernel.org>
 <aF-N-luMxFTurl91@Mac.home>
 <DAY059Y669BX.2GVKH6RBG80B6@kernel.org>
 <aF-83Tb4-Sxz_KFk@pollux>
 <DAY5ODJ7ZPWY.24OXGYED4EAK9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DAY5ODJ7ZPWY.24OXGYED4EAK9@kernel.org>

On Sat, Jun 28, 2025 at 02:13:08PM +0200, Benno Lossin wrote:
> On Sat Jun 28, 2025 at 11:58 AM CEST, Danilo Krummrich wrote:
> > On Sat, Jun 28, 2025 at 09:53:06AM +0200, Benno Lossin wrote:
> >> Hmm @Danilo, do you have any use-cases in mind or already done?
> >
> > There may be other use-cases, but the one that I could forsee is very specific:
> >
> > A Registration type that carries additional reference-counted data, where the
> > Registration should be released exactly when the device is unbound, independent
> > of the lifetime of the data.
> >
> > Obviously, this implies that the ForeignOwnable is an Arc.
> >
> > With KBox, Release and Drop are pretty much identical, so using
> > devres::release() instead, is much simpler and hence what we do for all simple
> > class device registrations.
> >
> > Besides that, the use-case described above can also be covered by Devres with
> > the pin-init rework, by having the Registration  embed a Devres<Inner>, which
> > is what irq::Registration does and I also do in the MiscDeviceRegistration
> > patches.
> >
> > Hence, I already considered dropping this patch -- and I think we should do this
> > for now.
> 
> Sounds good! We can always pick it up again when needed.

Exactly -- thanks Benno and Boqun! The discussion of the design of the Release
trait seems also relevant for other use-cases with ForeignOwnable types where we
require trait bounds for their target types.

