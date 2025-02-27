Return-Path: <linux-pci+bounces-22568-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6851AA48088
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 15:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EC2F7A52B2
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 14:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA26E232395;
	Thu, 27 Feb 2025 14:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gdTmA1Yd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C4A232386;
	Thu, 27 Feb 2025 14:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665052; cv=none; b=JSqNtD+KcjFb5AhkXDinQX/aIc+mqsJe+MrgLtMjyGtN5o8VCnwJq47GAue6M5g0N2sgQct9vbcZupqfKnORmlO5ovuzOuzPCvXsZ8KQjqiBUFA6yVouDe2utXBtOa86MUEjg13u6l5tN/TmWL4+07gxwiVyq/BpnIu8TX2eug0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665052; c=relaxed/simple;
	bh=x3EH1dzuRBajur9OoQyJceNpHCd35poZLxfrn1dV8aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcFjdhcN7kFOmZCCl7fMyjR5ISkI2eScxEQuTNxiOX9FmoEone3fCwMVmikpJtiFREPI/96VsIFjOhPOWJFsybLdj6p7UHkLOXqH9PEAutIaQcMPFX7hCIm73kRcsK7hmo45UpJD8McAosDlG9W0LP0ignFfoORT/uPU0loFv8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gdTmA1Yd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FFDC4CEDD;
	Thu, 27 Feb 2025 14:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740665052;
	bh=x3EH1dzuRBajur9OoQyJceNpHCd35poZLxfrn1dV8aI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gdTmA1YdBBfW6wo4+94dziVIHwE/P/95bRXfGAVJ01djQ6txE3jcUpLEmlIMdwGOF
	 hgM7TgzqQvo+twf+pX9a3c08xDtQZZcsGtA8y+CTssAg/EalG6Oi2XdqOq1KeufcIX
	 vhvx30CeBu71nUa+lv9/SjK7/HVmJTXmNCRENJ4o=
Date: Thu, 27 Feb 2025 06:03:02 -0800
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
Message-ID: <2025022741-handwoven-game-df08@gregkh>
References: <20250227030952.2319050-1-alistair@alistair23.me>
 <20250227030952.2319050-10-alistair@alistair23.me>
 <2025022717-dictate-cortex-5c05@gregkh>
 <CAH5fLgiQAdZMUEBsWS0v1M4xX+1Y5mzE3nBHduzzk+rG0ueskg@mail.gmail.com>
 <2025022752-pureblood-renovator-84a8@gregkh>
 <CAH5fLghbScOTBnLLRDMdhE4RBhaPfhaqPr=Xivh8VL09wd5XGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLghbScOTBnLLRDMdhE4RBhaPfhaqPr=Xivh8VL09wd5XGQ@mail.gmail.com>

On Thu, Feb 27, 2025 at 01:11:01PM +0100, Alice Ryhl wrote:
> On Thu, Feb 27, 2025 at 1:01 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Feb 27, 2025 at 12:52:02PM +0100, Alice Ryhl wrote:
> > > On Thu, Feb 27, 2025 at 12:17 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Thu, Feb 27, 2025 at 01:09:41PM +1000, Alistair Francis wrote:
> > > > > +     return rust_authenticated_show(spdm_state, buf);
> > > >
> > > > Here you have C code calling into Rust code.  I'm not complaining about
> > > > it, but I think it will be the first use of this, and I didn't think
> > > > that the rust maintainers were willing to do that just yet.
> > > >
> > > > Has that policy changed?
> > > >
> > > > The issue here is that the C signature for this is not being
> > > > auto-generated, you have to manually keep it in sync (as you did above),
> > > > with the Rust side.  That's not going to scale over time at all, you
> > > > MUST have a .h file somewhere for C to know how to call into this and
> > > > for the compiler to check that all is sane on both sides.
> > > >
> > > > And you are passing a random void * into the Rust side, what could go
> > > > wrong?  I think this needs more thought as this is fragile-as-f***.
> > >
> > > I don't think we have a policy against it? I'm pretty sure the QR code
> > > thing does it.
> >
> > Sorry, you are right, it does, and of course it happens (otherwise how
> > would bindings work), but for small functions like this, how is the C
> > code kept in sync with the rust side?  Where is the .h file that C
> > should include?
> 
> I don't think there is tooling for it today. We need the opposite of
> bindgen, which does exist in a tool called cbindgen. Unfortunately,
> cbindgen is written to only work in cargo-based build systems, so we
> cannot use it.
> 
> One trick you could do is write the signature in a header file, and
> then compare what bindgen generates to the real signature like this:
> 
> const _: () = {
>     if true {
>         bindings::my_function
>     } else {
>         my_function
>     };
> };
> 
> This would only compile if the two function pointers have the same signature.

That feels just wrong :(

As this seems like it's going to be a longer-term issue, has anyone
thought of how it's going to be handled?  Build time errors when
functions change is the key here, no one remembers to manually verify
each caller to verify the variables are correct anymore, that would be a
big step backwards.

thanks,

greg k-h

