Return-Path: <linux-pci+bounces-31608-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F62AFAFA7
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 11:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9318E188EDBB
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 09:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9E128D859;
	Mon,  7 Jul 2025 09:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVIoFOLV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD4E286400;
	Mon,  7 Jul 2025 09:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751880425; cv=none; b=PTWCWYpCXtCjIB42QIxmOSfjQBSZ1xUbs5NXkWKhauQexoJDUgdkBZea/Ll7yFskQA8Qae0CQrLtd+HUNSGoSrjlG4N9d3nGfsFowTYLglDs9fupFTqYSwUjZq22LEsQKNlCn1c190pSr+/MH0UGc8jltajslU+HHHVh0UBAm0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751880425; c=relaxed/simple;
	bh=w/nIczC0CHU2lOferxIYR9rPDkBASc32aog85VVzma4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ViQtoALT07pupNz5Mf5t0TWVvK81CvSJFq9mIB8vo2ZqR9zxD+uKJtEqKP4nBmqKTaf/7T1ll3pk1T8ddcbAIb1l61r1JHqNfeVF2KOm75nn+CQtWKg/oY/8ii8l1h1KlYVslFb9br0ZzCdoO2qD25ZAkuHT6iJlFW/+YMdbee4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVIoFOLV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11C8C4CEE3;
	Mon,  7 Jul 2025 09:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751880424;
	bh=w/nIczC0CHU2lOferxIYR9rPDkBASc32aog85VVzma4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kVIoFOLVbfYNR4ufJNomPZS0t9nYFn0B000dn34oEweWJPYZFeqfHex27G1EaBm4E
	 lvQGGmi511zQZVKC+IcWeLkHU8wARN5dtEe7ZChmO7DbRD+76Vvr23r/InTuwIsh07
	 elKM5ieLTwSIJ2VfWeuq0seCA5ZuEfQCBb7awllht3UxopERsUkNnGt68DWCiz3sAs
	 BGt06S41/Fk6aQbFCgo4VUOhGcUMXZCSOb941xaiF3n09vRd8cmNYqV1r1pDwotDHU
	 y+PokWmsUNpiX3fdTrEFNwpYUEhrGxq93Xj3/eFI2YDoaA2GAvNStDibRFRI1gC7Bc
	 NWfcUuJ+kIFOA==
Date: Mon, 7 Jul 2025 11:26:58 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	david.m.ertman@intel.com, ira.weiny@intel.com, leon@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/8] Device: generic accessors for drvdata +
 Driver::unbind()
Message-ID: <aGuS4k4Dp1BdAP8Q@pollux>
References: <20250621195118.124245-1-dakr@kernel.org>
 <2025070142-difficult-lucid-d949@gregkh>
 <aGO7BP1t-A_CQ700@pollux>
 <DB5N1F62UP4U.2XQ69N3FE1HWP@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB5N1F62UP4U.2XQ69N3FE1HWP@nvidia.com>

On Mon, Jul 07, 2025 at 04:18:09PM +0900, Alexandre Courbot wrote:
> On Tue Jul 1, 2025 at 7:40 PM JST, Danilo Krummrich wrote:
> >> > This makes it inefficient (but not impossible) to access device
> >> > resources, e.g. to write device registers, and impossible to call device
> >> > methods, which are only accessible under the Core device context.
> >> > 
> >> > In order to solve this, add an additional callback for (1), which we
> >> > call unbind().
> >> > 
> >> > The reason for calling it unbind() is that, unlike remove(), it is *only*
> >> > meant to be used to perform teardown operations on the device (1), but
> >> > *not* to release resources (2).
> >> 
> >> Ick.  I get the idea, but unbind() is going to get confusing fast.
> >> Determining what is, and is not, a "resource" is going to be hard over
> >> time.  In fact, how would you define it?  :)
> >
> > I think the definition is simple: All teardown operations a driver needs a
> > &Device<Core> for go into unbind().
> >
> > Whereas drop() really only is the destructor of the driver's private data.
> >
> >> Is "teardown" only allowed to write to resources, but not free them?
> >
> > "Teardown" is everything that involves interaction with the device when the
> > driver is unbound.
> >
> > However, we can't free things there, that happens in the automatically when the
> > destructor of the driver's private data is called, i.e. in drop().
> 
> Can't we somehow make a (renamed) `unbind` receive full ownership of the
> driver's private data, such that it will be freed (and its `drop`
> implementation called) before `unbind` returns? Or do we necessarily
> need to free that data later?

No, we could do that. And I thought about this as well, but I really want to
bind the lifetime of the driver's private data stored in a device to the
lifetime of this driver being bound to the device.

I don't think there is a valid use-case to allow this data as a whole to
out-live driver unbind arbitrarily.

