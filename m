Return-Path: <linux-pci+bounces-8239-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A678FB578
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 16:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 573281C23CA3
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 14:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976981448DC;
	Tue,  4 Jun 2024 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2Tl32S+f"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A0E144313;
	Tue,  4 Jun 2024 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717511577; cv=none; b=VYG7Gs0FGPwKSCvuAEtD/Ye32DmP38MuxKOBio3sw3MvS1UyZvEfGTNsotP5u7fI0r3+IfdIi/lcrF0JX7n8Dz/cAllnu5cJBRZGGggWgGOqc1REKpWn9QDIpcTcV1Wj92i/TmfQUfyn3PUN2VRkLM1skvAHYobwW28gIwKz76k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717511577; c=relaxed/simple;
	bh=o2mxzel60r7gCRivC5Z4TUDgKE+d9kjE+8mhknQD8YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nd1/l3dRy36g1Dt1Bmri3HOd6N5s/0jC3kcNgKlhg8JR1ZC2yJKDwzdh4JGTfh9k38VRuAQ3pv1onVxiBVzt6myB4wOIrjxUzOButPLYEvQerxs27bJ0dEecuq/uE+OsQmeE3Q/D0n/m3Zf62XvysWAJrXX5Frd0RYfkcV7WrgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2Tl32S+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CA5C4AF08;
	Tue,  4 Jun 2024 14:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717511577;
	bh=o2mxzel60r7gCRivC5Z4TUDgKE+d9kjE+8mhknQD8YM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2Tl32S+f0uYVyDTYPdJKeLmAq5C7wR3ltmjeG9Hk45252TkQrW6BOA02wijrNgVqu
	 1RYzMpiz6b2mKESpa4q/yLcU0j7uA5lm9D3ZfAjAHCRH1njiVH2H5vvXFm19nN4pQH
	 vrmhg48+g8pdeHO6xd0cHGkmVsarK4CZkEBT2o08=
Date: Tue, 4 Jun 2024 16:17:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@redhat.com>
Cc: rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH 01/11] rust: add abstraction for struct device
Message-ID: <2024060428-whoops-flattop-7f43@gregkh>
References: <20240520172554.182094-1-dakr@redhat.com>
 <20240520172554.182094-2-dakr@redhat.com>
 <2024052038-deviancy-criteria-e4fe@gregkh>
 <Zkuw/nOlpAe1OesV@pollux.localdomain>
 <2024052144-alibi-mourner-d463@gregkh>
 <Zk0HG5Ot-_e0o89p@pollux>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk0HG5Ot-_e0o89p@pollux>

On Tue, May 21, 2024 at 10:42:03PM +0200, Danilo Krummrich wrote:
> On Tue, May 21, 2024 at 11:24:38AM +0200, Greg KH wrote:
> > On Mon, May 20, 2024 at 10:22:22PM +0200, Danilo Krummrich wrote:
> > > > > +impl Device {
> > > > > +    /// Creates a new ref-counted instance of an existing device pointer.
> > > > > +    ///
> > > > > +    /// # Safety
> > > > > +    ///
> > > > > +    /// Callers must ensure that `ptr` is valid, non-null, and has a non-zero reference count.
> > > > 
> > > > Callers NEVER care about the reference count of a struct device, anyone
> > > > poking in that is asking for trouble.
> > > 
> > > That's confusing, if not the caller who's passing the device pointer somewhere,
> > > who else?
> > > 
> > > Who takes care that a device' reference count is non-zero when a driver's probe
> > > function is called?
> > 
> > A device's reference count will be non-zero, I'm saying that sometimes,
> > some driver core functions are called with a 'struct device' that is
> > NULL, and it can handle it just fine.  Hopefully no callbacks to the
> > rust code will happen that way, but why aren't you checking just "to be
> > sure!" otherwise you could have a bug here, and it costs nothing to
> > verify it, right?
> 
> I get your point on that one. But let me explain a bit more why I think that
> check is not overly helpful here.
> 
> In Rust we have the concept of marking functions as 'unsafe'. Unsafe functions
> need to document their safety preconsitions, i.e. the conditions the caller of
> the function must guarantee. The caller of an unsafe function needs an unsafe
> block for it to compile and every unsafe block needs an explanation why it is
> safe to call this function with the corresponding arguments.
> 
> (Ideally, we want to avoid having them in the first place, but for C abstractions
> we have to deal with raw pointers we receive from the C side and dereferencing a
> raw pointer is unsafe by definition.)
> 
> In this case we have a function that constructs the Rust `Device` structure from
> a raw (device) pointer we potentially received from the C side. Now we have to
> decide whether this function is going to be unsafe or safe.
> 
> In order for this function to be safe we would need to be able to guarantee that
> this is a valid, non-null pointer with a non-zero reference count, which
> unfortunately we can't. Hence, it's going to be an unsafe function.

But you can verify it is non-null, so why not?

> A NULL pointer check would not make it a safe function either, since the pointer
> could still be an invalid one, or a pointer to a device it's not guaranteed that
> the reference count is held up for the duration of the function call.

True, but you just took one huge swatch of "potential crashes" off the
table.  To ignore that feels odd.

> Given that, we could add the NULL check and change the safety precondition to
> "valid pointer to a device with non-zero reference count OR NULL", but I don't
> see how this improves the situation for the caller, plus we'd need to return
> `Result<Device>` instead and let the caller handle that the `Device` was not
> created.

It better be able to handle if `Device` was not created, as you could
have been out of memory and nothing would have been allocated.  To not
check feels very broken.

> > Ok, if you say so, should we bookmark this thread for when this does
> > happen?  :)
> 
> I'm just saying the caller has to validate that or provide a rationale why this
> is safe anyways, hence it'd be just a duplicate check.
> 
> > 
> > What will the rust code do if it is passed in a NULL pointer?  Will it
> > crash like C code does?  Or something else?
> 
> It mostly calls into C functions with this pointer, depends on what they do.
> 
> Checking a few random places, e.g. [1], it seems to crash in most cases.
> 
> [1] https://elixir.free-electrons.com/linux/latest/source/drivers/base/core.c#L3863

Great, then you should check :)

thanks,

greg k-h

