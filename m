Return-Path: <linux-pci+bounces-31152-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8DBAEF551
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 12:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299081BC5EC6
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 10:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2E526FDAC;
	Tue,  1 Jul 2025 10:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gR0PjKI4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED5726F477;
	Tue,  1 Jul 2025 10:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751366514; cv=none; b=HDBoOP+HvirysibqtdAGbrlKrFfjPg+TZ4IVvy5vDszrzcQP2gLAgEwtEQcZUbtEYQi+ThRYNuVopT2fR+ZUpyKmNY8LfR2GQ2EPSr80LoWn0JkVxAwn7v1HWYRim+WZ44FztwBcRVNHqlzXM1Kyg3bIXC6NPOvrd730NU68u4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751366514; c=relaxed/simple;
	bh=p+sLsYrp1/kW+gP4g5Sus/5DByCfL77pDZLwI0GEoK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nL/I168ZFRP6/VDXqvCKrrbDL2h119cfuIjqvwJ0IIN1JGwbXknVulHA+QuhKmkwGaDbtKrgP6JZb+SCpFdwzowHElQqK2x3CH7C555a31c5Vhj5ZHfWt0GuckfVYTWss58I+GnosNacAQJTJsL0XA26KLFK7ghWtuc7ZTCpmSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gR0PjKI4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA23C4CEEB;
	Tue,  1 Jul 2025 10:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751366513;
	bh=p+sLsYrp1/kW+gP4g5Sus/5DByCfL77pDZLwI0GEoK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gR0PjKI4YE8er749TNmVMus1bUexu/66sVFJpcVCDwLt16luBs6Eoo23Fi00muwfW
	 P/vVjBNKhQxPgpgq8GdjZyCEi76BTWJHw7bGUGlU2e86KQx+N250t0K7g6HF/3dF+C
	 nRF/Xi6qVbX182gAryYtA+MBzdIvnKJ8K7tn4gNc8QDq45MCSzwZOu9gQIEQfudWtJ
	 K5e2bHkPxdEHGWLY7O0Y9Kwd+m+I0SDlbJTvWesz1Sh4hIJkLSn1zEbDkZ4QTx8tvo
	 GDvzdSuPa3TulhI+to0gw3hgKTwFkHDxNXipYa7aiPR9Zl+0iTCJEzsjLRqih8JsAL
	 42VIfg/ACYAMg==
Date: Tue, 1 Jul 2025 12:41:47 +0200
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
Message-ID: <aGO7a3dsRdcjdBnb@pollux>
References: <20250621195118.124245-1-dakr@kernel.org>
 <20250621195118.124245-2-dakr@kernel.org>
 <2025070110-renounce-blinks-b28f@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025070110-renounce-blinks-b28f@gregkh>

On Tue, Jul 01, 2025 at 11:26:47AM +0200, Greg KH wrote:
> On Sat, Jun 21, 2025 at 09:43:27PM +0200, Danilo Krummrich wrote:
> > Introduce an internal device context, which is semantically equivalent
> > to the Core device context, but reserved for bus abstractions.
> > 
> > This allows implementing methods for the Device type, which are limited
> > to be used within the core context of bus abstractions, i.e. restrict
> > the availability for drivers.
> > 
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  rust/kernel/device.rs | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> > index 665f5ceadecc..e9094d8322d5 100644
> > --- a/rust/kernel/device.rs
> > +++ b/rust/kernel/device.rs
> > @@ -261,6 +261,10 @@ pub trait DeviceContext: private::Sealed {}
> >  /// any of the bus callbacks, such as `probe()`.
> >  pub struct Core;
> >  
> > +/// Semantically the same as [`Core`] but reserved for internal usage of the corresponding bus
> > +/// abstraction.
> > +pub struct Internal;
> 
> Naming is hard :)
> 
> As this is ONLY for the bus code to touch, why not call it Bus_Internal?

BusInternal is better indeed!

> And can a driver touch this, or only the bus owner?

It is to prevent drivers from getting access to functions implemented for
&Device<BusInternal>.

