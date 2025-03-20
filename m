Return-Path: <linux-pci+bounces-24279-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 691DDA6B1D3
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 00:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DE037ACE35
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 23:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA021215173;
	Thu, 20 Mar 2025 23:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgKdKZy4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9681FC7D9;
	Thu, 20 Mar 2025 23:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514515; cv=none; b=B8s5NFLiGI8m/JBA7iwcc9XvltzGOxVKp6gMOpQ+ljHIMtzs7wZBL0hE0jzD+a6pBS1wGr6XgHw1Mm73T/9BOb7lqtbOmVFgNqKMxmEwuvOBUs0SAvQWUSBvT06Ef8kQ63e2I1AUH1p6DPYchKHBgAhBilBLF0cwN1VCRVsgSbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514515; c=relaxed/simple;
	bh=B037Wxjnu+hJRlO/ztB13KMzePf0v740kkFPm/s0J4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maj74U7vgpDKYxAhouhCHAMhDfxT2kZfqH2BALkUbu1oZ5N8m1kyPPWJ9IyfDu1+4TRS08RcWiJX4qlLD/87WDZtgv7w4aPIte0qlOjlLLx+AdSbLyilJb/V8oLkSzWbnzcGQq/jrUn7qXQX5zON42IsD2ZP8CIxrWGbP41wEcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgKdKZy4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF63C4CEDD;
	Thu, 20 Mar 2025 23:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742514515;
	bh=B037Wxjnu+hJRlO/ztB13KMzePf0v740kkFPm/s0J4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pgKdKZy4q0AJex9pH8FnKL9Rx4JFT+BlEuZdKDCiwOd9i6VBvOovb9sKiGMUBW9tb
	 CVgWBsQsY3f925GZeSCIXiGayuQpSFISQqvCgqrJxX2BN5hU3eu2fNQpgN8I3KxLlL
	 s39ZhnOgVYAW0pIA27umw9HgKbQ8rotETISOQDttues/WeZOwv3SaSBxwC0Jg6hjjg
	 drPeRl6TZCrZINCkPMQrOTsMa6zKcq6oQnjb3Kz7Cz9qjj5Be7WsaV32ud7ViJo+6/
	 0nL/kE0UA7S5+dyAWXA/+7cZ4Ud1MO7kwiVtYMsE3jqk9cg0slrB3fCP7mE9jXO4fL
	 8TGzCAL9g8DJg==
Date: Fri, 21 Mar 2025 00:48:29 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: bhelgaas@google.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] rust: pci: impl TryFrom<&Device> for &pci::Device
Message-ID: <Z9ypTc7KysFx2Ykw@cassiopeiae>
References: <20250320222823.16509-1-dakr@kernel.org>
 <20250320222823.16509-4-dakr@kernel.org>
 <D8LHQSKES3SR.2EW347ONXZ22H@proton.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8LHQSKES3SR.2EW347ONXZ22H@proton.me>

On Thu, Mar 20, 2025 at 11:44:01PM +0000, Benno Lossin wrote:
> On Thu Mar 20, 2025 at 11:27 PM CET, Danilo Krummrich wrote:
> > @@ -466,6 +466,23 @@ fn as_ref(&self) -> &device::Device {
> >      }
> >  }
> >  
> > +impl TryFrom<&device::Device> for &Device {
> > +    type Error = kernel::error::Error;
> > +
> > +    fn try_from(dev: &device::Device) -> Result<Self, Self::Error> {
> > +        if dev.bus_type_raw() != addr_of!(bindings::pci_bus_type) {
> > +            return Err(EINVAL);
> > +        }
> > +
> > +        // SAFETY: We've just verified that the bus type of `dev` equals `bindings::pci_bus_type`,
> > +        // hence `dev` must be embedded in a valid `struct pci_dev`.
> 
> I think it'd be a good idea to mention that this is something guaranteed
> by the C side. Something like "... must be embedded in a valid `struct
> pci_dev` by the C side." or similar.

Sure, sounds reasonable.

> 
> With that:
> 
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> 
> ---
> Cheers,
> Benno
> 
> > +        let pdev = unsafe { container_of!(dev.as_raw(), bindings::pci_dev, dev) };
> > +
> > +        // SAFETY: `pdev` is a valid pointer to a `struct pci_dev`.
> > +        Ok(unsafe { &*pdev.cast() })
> > +    }
> > +}
> > +
> >  // SAFETY: A `Device` is always reference-counted and can be released from any thread.
> >  unsafe impl Send for Device {}
> >  
> 
> 

