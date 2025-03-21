Return-Path: <linux-pci+bounces-24391-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4996A6C304
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 20:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 531853BC937
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 19:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589AE1E7C19;
	Fri, 21 Mar 2025 19:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaLAEti+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2214A33F6;
	Fri, 21 Mar 2025 19:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742584293; cv=none; b=Lrl/Vpr29yD9c/S8yueVTLEymssUjx28fLe4geFK5URf2m1FHgcG0OgzFgHUSstZHg9gMZJG+06UUZgtlC0SP9IawUnsZiCOZswVkvBZNnyVd6RqsUcOEvhEnVrKEWHsGxlLbk1VoPs1Oh+WQhoxgR6T2Jw6jWlD7snn5W6nhis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742584293; c=relaxed/simple;
	bh=om62yFqtTyaPvTqnRyURq8QIvc3LzSjTBlVhbsZ+dDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+pgUIX74fm7CWSKmNnVs74owZfgZMUXjaD0YvmQacS2f7Xnobq/5+pScbfyq5FIqw4ODMFgKJUFC6pTBaOrViRNqAylqTCwCB0xDYExITFOnOYFDqBVk4nczVMiu86bgGZ3rXlDUSiJce12LdKW9jBPCX+ASVy4VmvbMFsyTps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaLAEti+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3105C4CEE3;
	Fri, 21 Mar 2025 19:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742584292;
	bh=om62yFqtTyaPvTqnRyURq8QIvc3LzSjTBlVhbsZ+dDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PaLAEti+W+gMojK9uHU3RrbbH7KVHJ9vF663D+GGlDGmO26ohTtm6xIp3NO+FuQHh
	 829H8Txs3j4+MDZjfPnmwpqA4iYwmpVGvtFnK4JjbN8cRlWZIn8PNCh9oGvRbOk5/G
	 BFgaP729YWPIxRrwfjJ1fTzK4LtvDdmBIONJSZFtX1W1SCKfI4bCNjAjwqKVNS+Wx4
	 pUPHjH5Q5PYxlda8Fu0aoAb3noNRDdU6uXkOEIe+AEm/c4Zs4EJa16R5KIbqQy1wKo
	 fvEDfXY4jORVDp2IBHeZBarYBJFXSgj4hzLtAPckwSdRRM465Et9OMF2zMVznky1P/
	 7dyaej3FcicIw==
Date: Fri, 21 Mar 2025 20:11:26 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: kernel test robot <lkp@intel.com>, bhelgaas@google.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] rust: pci: impl TryFrom<&Device> for &pci::Device
Message-ID: <Z9253sEI_cRS3mtN@pollux>
References: <20250320222823.16509-4-dakr@kernel.org>
 <202503220040.TDePlxma-lkp@intel.com>
 <Z92ldvI4ihlm0HJd@cassiopeiae>
 <CANiq72=s3rQwRt-TOr0_n=EKHwJSQSGmKfu_4TtoEhSTc2Fvqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=s3rQwRt-TOr0_n=EKHwJSQSGmKfu_4TtoEhSTc2Fvqg@mail.gmail.com>

On Fri, Mar 21, 2025 at 07:59:08PM +0100, Miguel Ojeda wrote:
> On Fri, Mar 21, 2025 at 6:44 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > This requires an unsafe block for compilers < 1.82. For compilers >= 1.82 it
> > turns into a warning *if* using an unsafe block.
> >
> > *Not* requiring unsafe for this seems like the correct thing -- was this a
> > bugfix in the compiler?
> >
> > I guess to make it work for all compiler versions supported by the kernel we
> > have to use unsafe and suppress the warning?
> 
> It was a feature, but it has been fairly annoying -- it affected
> several series, e.g. the latest KUnit one as well as:

From the second link:

"Previously, the compiler's safety checks were not aware that the raw ref
operator did not actually affect the operand's place, treating it as a possible
read or write to a pointer. No unsafety is actually present, however, as it just
creates a pointer.

That sounds like it was a bug, or do I miss anything?

> 
>     https://lore.kernel.org/rust-for-linux/CANiq72kuebpOa4aPxmTXNMA0eo-SLL+Ht9u1SGHymXBF5_92eA@mail.gmail.com/
> 
> Please see:
> 
>     https://blog.rust-lang.org/2024/10/17/Rust-1.82.0.html#safely-addressing-unsafe-statics
> 
> So, yeah, we use `allow(unused_unsafe)` (no `expect`, since it depends
> on the version).
> 
> I hope that helps.

Yeah, thanks a lot. Especially for the second link, I couldn't find it even
after quite a while of searching.

I will respin right away, since otherwise the patches of v3 are reviewed.

