Return-Path: <linux-pci+bounces-22591-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB2CA48912
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 20:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA78188FDB7
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 19:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48CB26F463;
	Thu, 27 Feb 2025 19:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ldshSNwf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AC626F448;
	Thu, 27 Feb 2025 19:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740684827; cv=none; b=E8ySeF/HrYE0pBWFQxR84Yc3gefecY4Z7rvfQul060aLdQB83yvNuEMw8uIunG0NkKxt6a5whK7jcuXpwSSDKUkl4YQXla7eQrzpwHGC2mDEdj7KlTcXAWxTwGUZa0LHTokPmsBe6ha38dd4/TrJGfmzRNGqdEQDCpZKBy8rVDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740684827; c=relaxed/simple;
	bh=/ljZxjG2whEh4fT7nvdzIQVW5daPqCdHPfKg8ixwA3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MaJZe9T4Qns1XKR7RcfhxJquloJsNctIxV20fGG3iYHl+aS3pkt8dRDXgLlGymCktaqCioFYYfTmFNp1KxxRU5jF09Gby+9XeBOGoKVWW3QcrJrG067a0LKz11FHxrJlE78ivC8j72WRgia87JqERdL4NyTTUvEJ9TcERSLrKws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ldshSNwf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC109C4CEDD;
	Thu, 27 Feb 2025 19:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740684827;
	bh=/ljZxjG2whEh4fT7nvdzIQVW5daPqCdHPfKg8ixwA3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ldshSNwfGfulPgB+3OfwHkhf5JN4u+pf8A2b58dLJDgRQBXutbzvePRuUXwOuO51y
	 ZlAXfnC0xzHL6qnETlkZDqCnwidaBxXEO7nJz2rXBrg++n3rlTRnV9CBJ2G0xG5SGQ
	 3YtbfwCk1DH/NaicUER4uPOwpT1VoS46pgagM1z8=
Date: Thu, 27 Feb 2025 11:32:37 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Alistair Francis <alistair@alistair23.me>,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	lukas@wunner.de, linux-pci@vger.kernel.org, bhelgaas@google.com,
	Jonathan.Cameron@huawei.com, rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org, boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com, wilfred.mallawa@wdc.com, ojeda@kernel.org,
	alistair23@gmail.com, a.hindborg@kernel.org, tmgross@umich.edu,
	gary@garyguo.net, alex.gaynor@gmail.com, benno.lossin@proton.me,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [RFC v2 09/20] PCI/CMA: Expose in sysfs whether devices are
 authenticated
Message-ID: <2025022749-gummy-survivor-c03a@gregkh>
References: <20250227030952.2319050-1-alistair@alistair23.me>
 <20250227030952.2319050-10-alistair@alistair23.me>
 <2025022717-dictate-cortex-5c05@gregkh>
 <CAH5fLgiQAdZMUEBsWS0v1M4xX+1Y5mzE3nBHduzzk+rG0ueskg@mail.gmail.com>
 <2025022752-pureblood-renovator-84a8@gregkh>
 <CANiq72kS8=1R-0yoGP5wwNT2XKSwofjfvXMk2qLZkO9z_QQzXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kS8=1R-0yoGP5wwNT2XKSwofjfvXMk2qLZkO9z_QQzXg@mail.gmail.com>

On Thu, Feb 27, 2025 at 05:45:02PM +0100, Miguel Ojeda wrote:
> On Thu, Feb 27, 2025 at 1:01 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > Sorry, you are right, it does, and of course it happens (otherwise how
> > would bindings work), but for small functions like this, how is the C
> > code kept in sync with the rust side?  Where is the .h file that C
> > should include?
> 
> What you were probably remembering is that it still needs to be
> justified, i.e. we don't want to generally/freely start replacing
> "individual functions" and doing FFI both ways everywhere, i.e. the
> goal is to build safe abstractions wherever possible.

Ah, ok, that's what I was remembering.

Anyway, the "pass a void blob from C into rust" that this patch is doing
feels really odd to me, and hard to verify it is "safe" at a simple
glance.

thanks,

greg k-h

