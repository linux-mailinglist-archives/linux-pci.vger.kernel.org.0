Return-Path: <linux-pci+bounces-31167-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E5EAEF89B
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 14:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACF421637B9
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 12:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A1678F34;
	Tue,  1 Jul 2025 12:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnbYkatI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0027260D;
	Tue,  1 Jul 2025 12:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751373175; cv=none; b=OdKNX4zy19n1v47goTZWtq92STVUiUI/EGVbsyj77vx+vIPyKKbSgEa+FG8bsIPysge+Wxx8UJ85/CWyvflyCJtEuvtex2IEhLqiQMfcPFSFGW0tZ1CNf7IoGYEfscVtf1RSMQD38CueWLDjLbdXr49LehQC4GTGUkU6tbtb7c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751373175; c=relaxed/simple;
	bh=EgnjTsHP1Vq2quIe/8Ig5Z5WM3e7RASn4K2qkIPVXAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuDUR9+as1aDvnJw/D+a64MF0epqdCGSaKfAlJroK/MI7auvo16Wa5KEGHUDJPt+FsOsKe+uzTZYBhf5QlSt4Igm2CXTwtz+VKjnl2oh4Oy6AbD7GV9gRZzAORPD6ZfKek3Rxo5xy5Z3qTqiOqBydHBUFIZY+c1j8NEi4gKFngk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnbYkatI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40019C4CEEB;
	Tue,  1 Jul 2025 12:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751373175;
	bh=EgnjTsHP1Vq2quIe/8Ig5Z5WM3e7RASn4K2qkIPVXAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FnbYkatIc63nSAWXHGRcXLrHa4F6oBFA1gtKZ9NqVjantusF2fdNUDhDCNMHNcFNI
	 XArdWkwuHAFvmeVSRo06rDuya1LA4Koq1gobY6acoXvvEr5HBl+F758553kUCPE7OZ
	 P+GNY6vqUEQnEp//ptZcoahdiu0F7occNE+dEYbkqhqfHNpl2YhVKtBYfyW+TaeUH1
	 WYb6/2kguLB5bzAqhtLSqHL2yADHyMwCqMoHmi68zA3AxQVovDXVYJ5dHnle0Eia3o
	 RfhTIkgaKD/gphdRHzbppgWC3DyTLL3xPP30/jH+txiuLxfawdOpGa9j5VjS3doatZ
	 hunmZD8MVlTaw==
Date: Tue, 1 Jul 2025 14:32:48 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, david.m.ertman@intel.com, ira.weiny@intel.com,
	leon@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/8] rust: device: introduce device::Internal
Message-ID: <aGPVcMEOImBA8RLB@pollux>
References: <20250621195118.124245-1-dakr@kernel.org>
 <20250621195118.124245-2-dakr@kernel.org>
 <2025070110-renounce-blinks-b28f@gregkh>
 <aGO7a3dsRdcjdBnb@pollux>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGO7a3dsRdcjdBnb@pollux>

On Tue, Jul 01, 2025 at 12:41:53PM +0200, Danilo Krummrich wrote:
> On Tue, Jul 01, 2025 at 11:26:47AM +0200, Greg KH wrote:
> > On Sat, Jun 21, 2025 at 09:43:27PM +0200, Danilo Krummrich wrote:
> > > Introduce an internal device context, which is semantically equivalent
> > > to the Core device context, but reserved for bus abstractions.
> > > 
> > > This allows implementing methods for the Device type, which are limited
> > > to be used within the core context of bus abstractions, i.e. restrict
> > > the availability for drivers.
> > > 
> > > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > > ---
> > >  rust/kernel/device.rs | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > > 
> > > diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> > > index 665f5ceadecc..e9094d8322d5 100644
> > > --- a/rust/kernel/device.rs
> > > +++ b/rust/kernel/device.rs
> > > @@ -261,6 +261,10 @@ pub trait DeviceContext: private::Sealed {}
> > >  /// any of the bus callbacks, such as `probe()`.
> > >  pub struct Core;
> > >  
> > > +/// Semantically the same as [`Core`] but reserved for internal usage of the corresponding bus
> > > +/// abstraction.
> > > +pub struct Internal;
> > 
> > Naming is hard :)
> > 
> > As this is ONLY for the bus code to touch, why not call it Bus_Internal?
> 
> BusInternal is better indeed!

I now remember that I first wanted to go for CoreInternal, but then went for
just Internal, since it thought it was unnecessary to be more specific. But I
now think CoreInternal would have been the correct pick.

> > And can a driver touch this, or only the bus owner?
> 
> It is to prevent drivers from getting access to functions implemented for
> &Device<BusInternal>.

