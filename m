Return-Path: <linux-pci+bounces-24114-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3A2A68BAD
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 12:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C2D88324B
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 11:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4CF254AE4;
	Wed, 19 Mar 2025 11:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIay126Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F998F5A;
	Wed, 19 Mar 2025 11:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742383529; cv=none; b=jPefCDVgonV99RrED3EkVbS56+Nf0iZYR2se1fuXsqMC7LyiNsU9JU4h9vSE6ExdgJKbGuiO68uQMkVGt8P/Sif9Ip3cEeq4eEGolyfILDcrjbimDZ+hQjdHFPjRpJIFw8GbS0A/Ftw2123g/xkYRHmO3TgDE5eRKZB5zKNurwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742383529; c=relaxed/simple;
	bh=MJqM5yOhWAMZ87htLDZYjYynv/mgewh+JWoF0niIk60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AF3ZNjhppDbvZKZ1iYkqWSIr6juEovkdCXZbv4xhfb5uxzr/iyDHE5nz/wSlHq4DUgwzaz51tFxPcJr+KN3gG+mohdf2vkMWB2Lemq18HN21zG2Y/YAYzuy0mRrPgWNSKvlLm7RZqFBxXPqQSTd8q7ADUIdOfJKY6MHCuZcIVtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIay126Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F92EC4CEEE;
	Wed, 19 Mar 2025 11:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742383528;
	bh=MJqM5yOhWAMZ87htLDZYjYynv/mgewh+JWoF0niIk60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VIay126QqT6XWiOuJBVKo0wQa4qp7DobLplN0afy0i9TB5K4LT9khSARMpbN4gHmP
	 u5c7D0Ub+qZgzudpkKb+7Q2P9l1vD5Ael6uUmvRlTYa7W/LbFq4WwSUrKXqmIoZ+xV
	 RLCEQFCiaKnws+5A+HzG2APbAeH09lnl2ZN2l4fN6Mh7G0aDCaDFcmNlRUIoQ4MWEe
	 Ydo/Q/sRXzy+GdLT5UZqNsZ211GurqXfaEzSgqFUTyTcbBc+z/JhfKaXATQ/VuxhY+
	 7x24e5W9xklbmVYTZYVkUvgsIzFQkYHsQT4/WO+y0z5SlFRyOYiJ7cp05XPDD/JKUr
	 47wmORQNt+wkg==
Date: Wed, 19 Mar 2025 12:25:23 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: bhelgaas@google.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	aliceryhl@google.com, tmgross@umich.edu, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: pci: impl Send + Sync for pci::Device
Message-ID: <Z9qpo0zp1jqnh9we@pollux>
References: <ddLRqqXuFiaRVyCNUWk5k3cc0pJCteUQ5tBxGr5_7QXDeygE0d-YFc9nbJD0pNJ8RjZ3nCaWOCM56r0ZWmWdJw==@protonmail.internalid>
 <20250318212940.137577-1-dakr@kernel.org>
 <87o6xxgtf8.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o6xxgtf8.fsf@kernel.org>

On Wed, Mar 19, 2025 at 12:18:35PM +0100, Andreas Hindborg wrote:
> "Danilo Krummrich" <dakr@kernel.org> writes:
> 
> > Commit 7b948a2af6b5 ("rust: pci: fix unrestricted &mut pci::Device")
> > changed the definition of pci::Device and discarded the implicitly
> > derived Send and Sync traits.
> >
> > This isn't required by upstream code yet, and hence did not cause any
> > issues. However, it is relied on by upcoming drivers, hence add it back
> > in.
> >
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  rust/kernel/pci.rs | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> > index 0ac6cef74f81..0d09ae34a64d 100644
> > --- a/rust/kernel/pci.rs
> > +++ b/rust/kernel/pci.rs
> > @@ -465,3 +465,10 @@ fn as_ref(&self) -> &device::Device {
> >          unsafe { device::Device::as_ref(dev) }
> >      }
> >  }
> > +
> > +// SAFETY: A `Device` is always reference-counted and can be released from any thread.
> > +unsafe impl Send for Device {}
> > +
> > +// SAFETY: `Device` can be shared among threads because all methods of `Device`
> > +// (i.e. `Device<Normal>) are thread safe.
> > +unsafe impl Sync for Device {}
> >
> > base-commit: 4d320e30ee04c25c660eca2bb33e846ebb71a79a
> 
> I can't find the base-commit and the patch does not apply clean on v6.14-rc7:
> 
>   patching file rust/kernel/pci.rs
>   Hunk #1 succeeded at 432 with fuzz 1 (offset -33 lines).
> 
> Otherwise looks good. You might want to rebase?

This is intentional, the base commit is from the driver-core tree, where also
commit 7b948a2af6b5 ("rust: pci: fix unrestricted &mut pci::Device") landed.

> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> 
> 
> Best regards,
> Andreas Hindborg
> 
> 

