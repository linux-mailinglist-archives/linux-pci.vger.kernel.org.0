Return-Path: <linux-pci+bounces-22633-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B55A496CD
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 11:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 981441751CE
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 10:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3D825DAFE;
	Fri, 28 Feb 2025 10:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6pLw8qU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC0725BAD0;
	Fri, 28 Feb 2025 10:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737539; cv=none; b=kIGCS80sChxFsNBegY9VBiNh8fWRzG/onippuruyEJDyQSc7W4zpRyeodNjOMzOC3Ims3EUpqW7Pn+whPh4fQ0ov0YZveqYiNlCU7juaIDzxydJg4Cb+3w7ma4r3I+6emShikP84W4t05Huc0P7Rnj+pVbe0WhE6QR1ya9xw634=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737539; c=relaxed/simple;
	bh=5nmhdVmkJjvM0GzyzeQCzlweufADquCQbW0TIn6T4pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNMt7iXjUVlDft/X+Xcn3x+M1wBvX3KGCtjhfYzkClt0CUnxCUm3qR2KzgHLvPVeaJpS6msrvBJ1Y3Yra8JquPXxatjnxmjkg/DBlcffnvTxI+5BECWnBE3cbgbC0EleVu/q8TfCBE+Z5C/lYBlyIMajyoVZ5d8rWu/D99iR6O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6pLw8qU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AC6C4CEE5;
	Fri, 28 Feb 2025 10:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740737539;
	bh=5nmhdVmkJjvM0GzyzeQCzlweufADquCQbW0TIn6T4pQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h6pLw8qUfvQNslHWoxqE871PS+g//RhNm0OCSFXfJLGLoZlg2fh++rA7JwM6nK0BO
	 aK95rQ3IJwmaC+JaL1HeeYCMPozOfSUxUPD+Eb7JseclvznzxhUflHDWuq5QpDPxbI
	 zrf1UFjGnYDygGK1SXrOaqlsYJUssPK91ox5aNq7DmaLRHIbjlvtNS1rEbsus9QIg1
	 CBjDr7t9c3/Ii4uwlm/gqOqZ+oTPMLKU+QGbmwhtCRlhdvwSqNP1+6aXaY69AiWaN6
	 X7G2cuoaUSES++DWBy/V2bO2CWE4Zml3gF1aXh2aQfsyltt28Y6l0K8SYjwM1X5Qch
	 oWoVmCsICHKpw==
Date: Fri, 28 Feb 2025 11:12:10 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Alistair Popple <apopple@nvidia.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com,
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	robh@kernel.org, daniel.almeida@collabora.com, saravanak@google.com,
	dirk.behme@de.bosch.com, j@jannau.net, fabien.parent@linaro.org,
	chrisi.schrefl@gmail.com, paulmck@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH v7 07/16] rust: add `io::{Io, IoRaw}` base types
Message-ID: <Z8GL-plbtphS62hl@pollux>
References: <20241219170425.12036-1-dakr@kernel.org>
 <20241219170425.12036-8-dakr@kernel.org>
 <g63h5f3zowy375yutftautqhurflahq3o5nmujbr274c5d7u7u@j5cbqi5aba6k>
 <CANiq72=gZhG8MOCqPi8F0yp3WR1oW77V+MXdLP=RK_R2Jzg-cw@mail.gmail.com>
 <wnzq3vlgawjdchjck7nzwlzmm5qbmactwlhtj44ak7s7kefphd@m7emgjnmnkjn>
 <Z72jw3TYJHm7N242@pollux>
 <nlngenb6udempavyevw62qvdzuo7jr4m5mt4fwvznza347vicl@ynn4c5lojoub>
 <Z8A4E_AyDlSUT5Bq@pollux>
 <w2udn7qfzcvncghilcwaz4qc6rv2si3dqpjcs2wrbvits3b44k@parw3mnusbuf>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w2udn7qfzcvncghilcwaz4qc6rv2si3dqpjcs2wrbvits3b44k@parw3mnusbuf>

On Fri, Feb 28, 2025 at 04:29:04PM +1100, Alistair Popple wrote:
> On Thu, Feb 27, 2025 at 11:01:55AM +0100, Danilo Krummrich wrote:
> > On Thu, Feb 27, 2025 at 11:25:55AM +1100, Alistair Popple wrote:
> 
> > > To be honest I don't really understand the utility here because the compile-time
> > > check can't be a definitive check. You're always going to have to fallback to
> > > a run-time check because at least for PCI (and likely others) you can't know
> > > for at compile time if the IO region is big enough or matches the compile-time
> > > constraint.
> > 
> > That's not true, let me explain.
> > 
> > When you write a driver, you absolutely have to know the register layout. This
> > means that you also know what the minimum PCI bar size has to be for your driver
> > to work. If it would be smaller than what your driver expects, it can't function
> > anyways. In Rust we make use of this fact.
> > 
> > When you map  a PCI bar through `pdev.iomap_region_sized` you pass in a const
> > generic (`SIZE`) representing the *expected* PCI bar size. This can indeed fail
> > on run-time, but that's fine, as mentioned, if the bar is smaller than what your
> > driver expect, it's useless anyways.
> > 
> > If the call succeeds, it means that the actual PCI bar size is greater or equal
> > to `SIZE`. Since `SIZE` is known at compile time all subsequent I/O operations
> > can be boundary checked against `SIZE` at compile time, which additionally makes
> > the call infallible. This works for most I/O operations drivers do.
> 
> Argh! That's the piece I was missing - that this makes the IO call infallible
> and thus removes the need to write run-time error handling code. Sadly of course
> that's not actually true, because I/O operations can always fail for reasons
> other than what can be checked at compile time (eg. in particular PCI devices
> can fall off the bus and return all 0xF's). But I guess existing drivers don't
> really handle those cases either.

We handle this case too by giving out a Devres<pci::Bar> rather than just a
pci::Bar. The former gets revoked when the device falls off the bus.

