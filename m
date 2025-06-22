Return-Path: <linux-pci+bounces-30328-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B2FAE3241
	for <lists+linux-pci@lfdr.de>; Sun, 22 Jun 2025 23:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8E967A3226
	for <lists+linux-pci@lfdr.de>; Sun, 22 Jun 2025 21:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536681F560B;
	Sun, 22 Jun 2025 21:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7w/cvyr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F071862BB;
	Sun, 22 Jun 2025 21:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750626749; cv=none; b=dXSMK1dIboDuoZPTTF53P+Z36ZNAuVKrFkYO/S1BIfI4acvk6b5ttgp4mmLI0wM+XoyXnsO5TfY2y3bs5dVyDnTGdzN/Bg4zjAYqCAIUY8GG7sy3K+XkphGJ5vFsQwHR1/9PtGMNtPECRAOZNGAjwPudnu/Xv+iBILeAaxitXlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750626749; c=relaxed/simple;
	bh=nf4QNxu9+7e32t9vqmN6XBXTO2OjsCnkp2AenuRI88Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQKwgYMUU50+Kl/AxAndYLldlsn+R4s8oCkNSPtbQ9UINDChvvPrQJS6VmL2dIiBlXODy8KIwSESCV1jOuzurqhE7DQt3EnJkLW1/UaIUqBdRC+9jJ9NC/18htUCjGGazrnMrgzA/gXeqPzqNu8GmEz8dCS2F7NnbGKrZicxk3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7w/cvyr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDEAEC4CEE3;
	Sun, 22 Jun 2025 21:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750626748;
	bh=nf4QNxu9+7e32t9vqmN6XBXTO2OjsCnkp2AenuRI88Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U7w/cvyrnorC4A6HXQBwqGDHr6XT1Y9ANimPQQsjdkFYqslrmBaWbICHxYI255DjB
	 rOPA6/VQV5qM9UlNOOukOHm4IjSQCHHzuBFisEz9eupFNp1SKHMx7vVwlLRBx2/Qab
	 wAxFEsREh55nilV9SxyciAUXPpmzPV/Nu9eKn/1DbThIKx141mRMsI/fCOuAuFrlQp
	 t7bNw8bvmgOOi3mUHh3eMSwFYRZPgDvLPB+of9dJy49au2bd3t2XFxj3HwX4emizbt
	 5qyS2nryHOWE7hcZTTxKiNXuHeEgjGb7mGy+Vd42N2RNyKvGMzNli3z3fqYszhSlYg
	 2qORT7Kr4UPpA==
Date: Sun, 22 Jun 2025 23:12:22 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <lossin@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, david.m.ertman@intel.com,
	ira.weiny@intel.com, leon@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 4/4] rust: devres: implement register_release()
Message-ID: <aFhxtv5tOavHP0N-@pollux>
References: <20250622164050.20358-1-dakr@kernel.org>
 <20250622164050.20358-5-dakr@kernel.org>
 <DATCV8XFK7TO.2MYZKKA28JEQV@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DATCV8XFK7TO.2MYZKKA28JEQV@kernel.org>

On Sun, Jun 22, 2025 at 10:47:55PM +0200, Benno Lossin wrote:
> On Sun Jun 22, 2025 at 6:40 PM CEST, Danilo Krummrich wrote:
> > +impl<T: Release> Release for crate::sync::ArcBorrow<'_, T> {
> > +    fn release(&self) {
> > +        self.deref().release();
> > +    }
> > +}
> > +
> > +impl<T: Release> Release for Pin<&'_ T> {
> 
> You don't need the `'_` here.
> 
> > +    fn release(&self) {
> > +        self.deref().release();
> > +    }
> > +}
> 
> I still think we're missing a `impl<T: Release> Release for &T`.

Yeah, I really thought the compile can figure this one out.

> And maybe a closure design is better, depending on how much code is
> usually run in `release`, if it's a lot, then we should use the trait
> design. If it's only 1-5 lines, then a closure would also be fine. I
> don't have a strong preference, but if it's mostly one liners, then
> closures would be better.

It should usually be rather short, so probably makes sense.

> If you keep the trait design & we resolve the `&T: Release` question:
> 
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> 
> ---
> Cheers,
> Benno

