Return-Path: <linux-pci+bounces-22098-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 293AAA40931
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 15:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13C2517D43A
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 14:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF114207A;
	Sat, 22 Feb 2025 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="drFu+8Hf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BB928382;
	Sat, 22 Feb 2025 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740235518; cv=none; b=o5UkT4iC88+YFK96gIQd1c0oaVgv3Si3PvgUGoHq/n3QhSG58riMmp6BH0ccrYcdfzN0uXx0C0Fzzqq2+JNS36gL0iRStcRDUPfSwObQ/XgLrgheRLTVWFqy46ne9BEzEpUZrf67KbUp4YKayQd5TGwikrCmHhOPICmOzdOnQl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740235518; c=relaxed/simple;
	bh=pmctKd2KlpszS7gLNC2mYFG2s6mbZC9uFlgXyq77nGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzTBFilGp1ojx1JSzeAkRD5QJp4Jbxmtv7TYLVuIR5AxTBtGlKpdnUYHssSdDmqfTwAH8j+j5uaMS22G2KUx0fiaAKXgq2ECalqsSuMGOT+v/UYX7/7kOgmg17GowxY5ndiLg2+6SGuOoIge1dcMtd61HkBmsbdf/TrIi5Y5oRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=drFu+8Hf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25043C4CED1;
	Sat, 22 Feb 2025 14:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740235515;
	bh=pmctKd2KlpszS7gLNC2mYFG2s6mbZC9uFlgXyq77nGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=drFu+8HfzfqUkYN7QZNohAkzrNvKViw578AlNzMMciaGoBIERjpV0mDf7kyL5UBYm
	 xl/QpduM3QJoNYGlGkG32S0y/4FfflmFyFQ918xEGm4VvBAP/FU2ukxgJ1og22jHv9
	 Wf1ZtMxSUcETU5lpUpvhQ0B0DKsIaCT/SbR4cFW4=
Date: Sat, 22 Feb 2025 15:45:13 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Fiona Behrens <me@kloenk.dev>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] rust: io: rename `io::Io` accessors
Message-ID: <2025022203-partly-mousy-9170@gregkh>
References: <20250217-io-generic-rename-v1-1-06d97a9e3179@kloenk.dev>
 <2025021817-chirping-fencing-d991@gregkh>
 <CANiq72kTcceaCEv0ETdN_zninTwJKAoPDvzz0Eorb5udGgTkDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kTcceaCEv0ETdN_zninTwJKAoPDvzz0Eorb5udGgTkDg@mail.gmail.com>

On Sat, Feb 22, 2025 at 02:54:25PM +0100, Miguel Ojeda wrote:
> On Tue, Feb 18, 2025 at 8:57 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > Want me to take this through my tree?
> 
> Sure, as you prefer! Happy either way. Thanks!

Ok, I took it now, thanks!

greg k-h

