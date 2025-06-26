Return-Path: <linux-pci+bounces-30758-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F00AE9FCB
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 16:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D50E563787
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 14:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CCA28B3EE;
	Thu, 26 Jun 2025 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvrIoAxj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B928156F5E;
	Thu, 26 Jun 2025 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750946585; cv=none; b=GqsWrmkT1BNuGa9mGtLLLCvzNqLrOxSElXNq0EJYhMWRCt9KMA5Gn4w17pWRzmNPFXYOcPVAjFPpPTTqERHBMbA6x2+5coQtCjKdWg1M3HQeGQqXAi72o1cwAeTm6VQYa8ei2mBtP83wBmLwy7qFnETeBONYEdc48aMP9uidakA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750946585; c=relaxed/simple;
	bh=f86r/ImK9cC+0QrF6hoABx5UmkguYkXjzEcX3QquBFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G42vsbRYzZT2cq5ZVoVRyBe/isCHZ91sFr9s9lAuJ24bybXhAwulpw/C4Y6AK2NxT55ghBigJqpRoXmI92Ab+wkHi/wZz9hGssk942nHIFAxxa6rDjJyPqcxQ8vNv2beJG8TpL62StHEU96ci9An/85j8BpCNG86ZAqWjaEUK1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvrIoAxj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4069C4CEEB;
	Thu, 26 Jun 2025 14:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750946584;
	bh=f86r/ImK9cC+0QrF6hoABx5UmkguYkXjzEcX3QquBFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pvrIoAxj6GskbI/oF6/5SODbvIEA7uugOoMQhqh8EJDpAfGZaoZkvpSvOQo/X2M+/
	 2+EV36YgorT+QRjH2KgTFzcayds+cLUOOobUNMPrYvHqSlOyx8GV6kWVEvsRGEeXFM
	 WHydNvSFkri+vk6c47vg8pYPsF6BfsQM/YoYsg59WUXTl+CmZGzbaVk9gcVE/bfaIv
	 rpR0psv6LBgAiELRrLi1HBlJ/Vu6ymeeI5VgSYOLbiuXUJr3anl6Wpn78TnH4aPmkP
	 kBCNR8/b/k0R+CB8zAibcQ0ou9//wWlqLlIzPiVTVLCVNZ+m2i7ZBhpRJtA4+lu4Fh
	 AcFcjxn6rEgIA==
Date: Thu, 26 Jun 2025 16:02:58 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <lossin@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, david.m.ertman@intel.com,
	ira.weiny@intel.com, leon@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 4/4] rust: devres: implement register_release()
Message-ID: <aF1TEuotIIwcKODM@cassiopeiae>
References: <20250624215600.221167-1-dakr@kernel.org>
 <20250624215600.221167-5-dakr@kernel.org>
 <DAWED7BIC32G.338MXRHK4NSJG@kernel.org>
 <aF0rzzlKgwopOVHV@pollux>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF0rzzlKgwopOVHV@pollux>

On Thu, Jun 26, 2025 at 01:15:34PM +0200, Danilo Krummrich wrote:
> On Thu, Jun 26, 2025 at 12:36:23PM +0200, Benno Lossin wrote:
> > Or, we could change `Release` to be:
> > 
> >     pub trait Release {
> >         type Ptr: ForeignOwnable;
> > 
> >         fn release(this: Self::Ptr);
> >     }
> > 
> > and then `register_release` is:
> > 
> >     pub fn register_release<T: Release>(dev: &Device<Bound>, data: T::Ptr) -> Result
> > 
> > This way, one can store a `Box<T>` and get access to the `T` at the end.
> 
> I think this was also the case before? Well, it was P::Borrowed instead.
> 
> > Or if they store the value in an `Arc<T>`, they have the option to clone
> > it and give it to somewhere else.
> 
> Anyways, I really like this proposal of implementing the Release trait.

One downside seems to be that the compiler cannot infer T anymore with this
function signature.

