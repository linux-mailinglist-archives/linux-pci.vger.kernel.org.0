Return-Path: <linux-pci+bounces-7709-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 813858CAAB3
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 11:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 397C91F2133D
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 09:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B9B47A7C;
	Tue, 21 May 2024 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PV+Azz+l"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9690174BF8;
	Tue, 21 May 2024 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716283302; cv=none; b=LOzOOnvtlmobzw6pX2ww4tSItofwbbNUABusmBkUM9Cr30pDkV18gwj8BJRPWDnQZozSBF3s8d0QtsQaKTGKU5NrU4/tcfYGnbteez+qA0lM45wmHBB2AhrMG/4TIDo6zhMEqT+VoZHwqoOscj5LMfEah/cIRSrvQX700v0XvYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716283302; c=relaxed/simple;
	bh=JG9To5Cuq6BpNkfkCV3g6Yj0GSTuoo0uGKuW/Ta8t9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quIWzY7oUd8EvQ2jaKxqOl6nABaqKEWvo/e+9XCu527/kLHin5SDZZancDzPR7Yzb7PgV16tjHA+pp1n0PP+dLaHmLnptcuMhMTtCL06TV97E4VkT01bu2n5s+HFIJ+j1ZYf+O+33sRTRnaruXdnrIxmtJkz7B3QlCZ5tGAqXog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PV+Azz+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2D9C4AF08;
	Tue, 21 May 2024 09:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716283302;
	bh=JG9To5Cuq6BpNkfkCV3g6Yj0GSTuoo0uGKuW/Ta8t9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PV+Azz+lsh8f2wXff+eHkuk6PlpjIDF5pBhQcupI4gOpmuX/umv9yjqyGt5bPJPsW
	 6huNenQnF3WKJO/Qg2tX8yYu1/q6SSxLQFkxRI/W0cU4uTtGeaprqCUPpg/cS42Jn7
	 RFq3Tcqd0gP/jzZrc3J7JTv0w8U6vNdq2mGXxXFs=
Date: Tue, 21 May 2024 11:21:39 +0200
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
Subject: Re: [RFC PATCH 00/11] [RFC] Device / Driver and PCI Rust abstractions
Message-ID: <2024052125-privatize-tingly-054f@gregkh>
References: <20240520172554.182094-1-dakr@redhat.com>
 <2024052029-unbridle-wildcard-fbf8@gregkh>
 <2024052020-basket-amuser-222f@gregkh>
 <ZkupaTM+xjCiBbb4@pollux.localdomain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkupaTM+xjCiBbb4@pollux.localdomain>

On Mon, May 20, 2024 at 09:50:01PM +0200, Danilo Krummrich wrote:
> On Mon, May 20, 2024 at 08:16:19PM +0200, Greg KH wrote:
> > On Mon, May 20, 2024 at 08:14:57PM +0200, Greg KH wrote:
> > > On Mon, May 20, 2024 at 07:25:37PM +0200, Danilo Krummrich wrote:
> > > > This patch sereis implements basic generic device / driver Rust abstractions,
> > > > as well as some basic PCI abstractions.
> > > > 
> > > > This patch series is sent in the context of [1], and the corresponding patch
> > > > series [2], which contains some basic DRM Rust abstractions and a stub
> > > > implementation of the Nova GPU driver.
> > > > 
> > > > Nova is intended to be developed upstream, starting out with just a stub driver
> > > > to lift some initial required infrastructure upstream. A more detailed
> > > > explanation can be found in [1].
> > > > 
> > > > Some patches, which implement the generic device / driver Rust abstractions have
> > > > been sent a couple of weeks ago already [3]. For those patches the following
> > > > changes have been made since then:
> > > > 
> > > > - remove RawDevice::name()
> > > > - remove rust helper for dev_name() and dev_get_drvdata()
> > > > - use AlwaysRefCounted for struct Device
> > > > - drop trait RawDevice entirely in favor of AsRef and provide
> > > >   Device::from_raw(), Device::as_raw() and Device::as_ref() instead
> > > > - implement RevocableGuard
> > > > - device::Data, remove resources and replace it with a Devres abstraction
> > > > - implement Devres abstraction for resources
> > 
> > Ah, here's the difference from the last time, sorry, it wasn't obvious.
> > 
> > Still nothing about proper handling and use of 'remove' in the context
> > of all of this, that's something you really really really need to get
> > right if you want to attempt to have a driver in rust interact with the
> > driver core properly.
> 
> We were right in the middle of discussing about the correct wording when I sent
> those patches the first time. There were some replies from my side, e.g. [1] and
> another reply from Wedson [2] about this, which you did not want to reply to any
> more.
> 
> I'm not saying I insist on not changing those comments up, but first we have to
> agree on how we want them to be rephrased, especially since from the
> discussions so far I got the impression that we might talk a bit past each
> other.
> 
> Hence, I'd propose to just continue the discussion, where we need to.

See my responses in this thread, let's continue this there.

thanks,

greg k-h

