Return-Path: <linux-pci+bounces-31412-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E50AF7C31
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 17:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C297F5A471D
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 15:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA97014B092;
	Thu,  3 Jul 2025 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TEuT0pQ/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8145A86348;
	Thu,  3 Jul 2025 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751556315; cv=none; b=bzMOLdITlk2W3GUlusCn3NBFY9XudjKssC+WVISuXInydOBbCEg3d4o9m+yQfSjIYHbI9AxGZIAs8PTZqNG1rVLqHSYSJSTEOShE/U/98Q3bajnlvqGNIuJOslduGCm2v9a4Ymd6lJkM+U/x4PoI7l+FyCyv79mpMTOHfl5bcPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751556315; c=relaxed/simple;
	bh=r3+Unlqo2FtzbE9Z6aBKdXpwRkXeNoUleR1F70t0b7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Abfsn1Fz28TJzV2HIfeo2HPDY6I3GlmEmqDnSv9hUMwQnxmL9a9Hooi+xTmCGz5G8OUW9FZwMl50M0D8VYPtLwl5K3/kAOBEMvVULRABdonrEeT/8x6H3vRvCk1LX/N5oKJ+RzGDWh7A0x+o83+irq1+xLyxSvWm6dhR2Bkqf+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TEuT0pQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69E4C4CEE3;
	Thu,  3 Jul 2025 15:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751556315;
	bh=r3+Unlqo2FtzbE9Z6aBKdXpwRkXeNoUleR1F70t0b7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TEuT0pQ/nkhZ5IFItc02fEx4881lwOelxh8aCbk992r235dN5Anqp5Pe7kz6Y6wcL
	 EzY8/nupp35GIB9dtm1jztrcDuSES/YrUKzMAQziOtXjrjRXPDPB8jjGpSeQYv0H5U
	 GUY+JqOIJAIWGIwNy83CipdZd8b6ZPeGXYVZ4fzI=
Date: Thu, 3 Jul 2025 17:06:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, david.m.ertman@intel.com, ira.weiny@intel.com,
	leon@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/8] rust: device: introduce device::Internal
Message-ID: <2025070329-ream-arrogance-0737@gregkh>
References: <20250621195118.124245-1-dakr@kernel.org>
 <20250621195118.124245-2-dakr@kernel.org>
 <2025070110-renounce-blinks-b28f@gregkh>
 <aGO7a3dsRdcjdBnb@pollux>
 <aGPVcMEOImBA8RLB@pollux>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGPVcMEOImBA8RLB@pollux>

On Tue, Jul 01, 2025 at 02:32:48PM +0200, Danilo Krummrich wrote:
> On Tue, Jul 01, 2025 at 12:41:53PM +0200, Danilo Krummrich wrote:
> > On Tue, Jul 01, 2025 at 11:26:47AM +0200, Greg KH wrote:
> > > On Sat, Jun 21, 2025 at 09:43:27PM +0200, Danilo Krummrich wrote:
> > > > Introduce an internal device context, which is semantically equivalent
> > > > to the Core device context, but reserved for bus abstractions.
> > > > 
> > > > This allows implementing methods for the Device type, which are limited
> > > > to be used within the core context of bus abstractions, i.e. restrict
> > > > the availability for drivers.
> > > > 
> > > > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > > > ---
> > > >  rust/kernel/device.rs | 14 ++++++++++++++
> > > >  1 file changed, 14 insertions(+)
> > > > 
> > > > diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> > > > index 665f5ceadecc..e9094d8322d5 100644
> > > > --- a/rust/kernel/device.rs
> > > > +++ b/rust/kernel/device.rs
> > > > @@ -261,6 +261,10 @@ pub trait DeviceContext: private::Sealed {}
> > > >  /// any of the bus callbacks, such as `probe()`.
> > > >  pub struct Core;
> > > >  
> > > > +/// Semantically the same as [`Core`] but reserved for internal usage of the corresponding bus
> > > > +/// abstraction.
> > > > +pub struct Internal;
> > > 
> > > Naming is hard :)
> > > 
> > > As this is ONLY for the bus code to touch, why not call it Bus_Internal?
> > 
> > BusInternal is better indeed!
> 
> I now remember that I first wanted to go for CoreInternal, but then went for
> just Internal, since it thought it was unnecessary to be more specific. But I
> now think CoreInternal would have been the correct pick.

Thanks for the long explainations that helped out a lot.  As I said on
chat earlier, I agree with you now.  Can you respin this with
CoreInternal and we can queue it up?

Worst thing that happens is the api doesn't work out and we rework it
based on real users :)

thanks,

greg k-h

