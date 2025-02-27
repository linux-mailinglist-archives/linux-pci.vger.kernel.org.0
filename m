Return-Path: <linux-pci+bounces-22539-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E91A47CC2
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 13:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F01188FC4D
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 12:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CD727005C;
	Thu, 27 Feb 2025 12:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kH8h9nZw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FBB270020;
	Thu, 27 Feb 2025 12:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740657698; cv=none; b=G/7vLY5dSmRf6iaXaC3vkYkdRh14MjZkBsFxqdMYyu/gAVGrpKKGQd9rbuGHjrtyeNuwehSkXlN+0YLK0DNbg6qscd5mkr3D+Y2GHSeegy2mWMY8caB+COOrfoc41RasoS+gGH4XBkIpdzzkB8fNwLIdkxOVPaPK+oEqHUlZaBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740657698; c=relaxed/simple;
	bh=xUzfOdsfoPAyrGZzqH6LEvJu9U1fppCstf/mr9hCqu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/CqDRqTzkS4zq8LuKnELLXPEeCYTL7ct0RCZizqWyTXahGdV3/LwbzBgMCmKjByytulblYoFhR3hkqUJxVL+IM5c6uDsTQyjlxt8Ygb4tICU4sbi5lRmA2Bmseoyu6ehrTd9IqL0JyvADQZ1VkynkTUIfFGxkTlwz+Rwk8uTg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kH8h9nZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B45C4CEDD;
	Thu, 27 Feb 2025 12:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740657697;
	bh=xUzfOdsfoPAyrGZzqH6LEvJu9U1fppCstf/mr9hCqu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kH8h9nZwxBi4UyXu/WcZZ6dBk+0qND3m2wYpURUHFBpa62tFtQd4kAwxxj2KYm03r
	 EtiJ9WU+D67wYwY1dS3tsI3VuNUfZ0rPe3IwxNeJYXGJp4BuNeQTKbgnKW3CKl8f/x
	 eRdZhfJsa6jx5Z0pTtMVMKzRwXuZ686FW2gwAAgQ=
Date: Thu, 27 Feb 2025 04:00:28 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Alistair Francis <alistair@alistair23.me>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, lukas@wunner.de,
	linux-pci@vger.kernel.org, bhelgaas@google.com,
	Jonathan.Cameron@huawei.com, rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org, boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com, wilfred.mallawa@wdc.com, ojeda@kernel.org,
	alistair23@gmail.com, a.hindborg@kernel.org, tmgross@umich.edu,
	gary@garyguo.net, alex.gaynor@gmail.com, benno.lossin@proton.me,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [RFC v2 09/20] PCI/CMA: Expose in sysfs whether devices are
 authenticated
Message-ID: <2025022752-pureblood-renovator-84a8@gregkh>
References: <20250227030952.2319050-1-alistair@alistair23.me>
 <20250227030952.2319050-10-alistair@alistair23.me>
 <2025022717-dictate-cortex-5c05@gregkh>
 <CAH5fLgiQAdZMUEBsWS0v1M4xX+1Y5mzE3nBHduzzk+rG0ueskg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgiQAdZMUEBsWS0v1M4xX+1Y5mzE3nBHduzzk+rG0ueskg@mail.gmail.com>

On Thu, Feb 27, 2025 at 12:52:02PM +0100, Alice Ryhl wrote:
> On Thu, Feb 27, 2025 at 12:17 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Feb 27, 2025 at 01:09:41PM +1000, Alistair Francis wrote:
> > > +     return rust_authenticated_show(spdm_state, buf);
> >
> > Here you have C code calling into Rust code.  I'm not complaining about
> > it, but I think it will be the first use of this, and I didn't think
> > that the rust maintainers were willing to do that just yet.
> >
> > Has that policy changed?
> >
> > The issue here is that the C signature for this is not being
> > auto-generated, you have to manually keep it in sync (as you did above),
> > with the Rust side.  That's not going to scale over time at all, you
> > MUST have a .h file somewhere for C to know how to call into this and
> > for the compiler to check that all is sane on both sides.
> >
> > And you are passing a random void * into the Rust side, what could go
> > wrong?  I think this needs more thought as this is fragile-as-f***.
> 
> I don't think we have a policy against it? I'm pretty sure the QR code
> thing does it.

Sorry, you are right, it does, and of course it happens (otherwise how
would bindings work), but for small functions like this, how is the C
code kept in sync with the rust side?  Where is the .h file that C
should include?

thanks,

greg "I need more coffee" k-h

