Return-Path: <linux-pci+bounces-24123-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FFDA68E39
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 14:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE90017B199
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 13:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2285C537F8;
	Wed, 19 Mar 2025 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzh3Gqkm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7402744E;
	Wed, 19 Mar 2025 13:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742392250; cv=none; b=gMyhoGxWyQkSjyNFD3/YhOAX5UvtsbRvwTP+PDoNnjxQKp+lCewK8/04cHFskrShueukMLbi/ni2FjhSsG6OY39nuZfFa57JJDzzk4aAuutzAD+wk4ZIIN/o9DLDB27yuFuKdyS/TrqCal64/gRpJwhD4QjV9ZvHW68Xo8vI+h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742392250; c=relaxed/simple;
	bh=6nS6/AYW1GHhT1dfaTBG7mfQ9JZhlHMqZBge6DkvVQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXXU5kwUyj/YngftZHNHNajpilSGba//DqWNwrChwKWLGbSDdUmic9N2kVjBrkuKsEXLv8gjnx8z8rlK60s+bsNUqRdrvXBy8AFq+WGAI9i2UcWWJOCWYUg2MMVdlseX1/+CfRG1lfH76JG5omUY+0vDdir3JC8bIHFyzsno/F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pzh3Gqkm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8BAC4CEE4;
	Wed, 19 Mar 2025 13:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742392249;
	bh=6nS6/AYW1GHhT1dfaTBG7mfQ9JZhlHMqZBge6DkvVQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pzh3GqkmyN1pfDuO0NDTQ7Os5CTdeYc3r5Ua1VlCm+UB4x73CvZqxJMAcCrngeDP1
	 OI6OjoXytg5uLqnxxCXMn5cM9sRgMQ0HpCLSRO4K6Sd9czWmDG0MA9YPHDlxjhAYey
	 KAlEXblnbSHARJTm3FSBKAn0TM6EXyiiSEGOlZGMp1YsHXSwwDvgh7Qvv6iLq325d5
	 IPzhrJ/q+mAx5q/4jJ6BlCnJ8zh7OeW00dFYszKRipzKRKc0zddFItlL96RwR8QXBf
	 s/5rkmUvtjNVxojVLBAyQUMHJCOtI6Vo/xl1H1Uo5qlb6Ni9acZG1enzHaCcZNCIOi
	 QbsbGM9iFaHDA==
Date: Wed, 19 Mar 2025 14:50:43 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: bhelgaas@google.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, tmgross@umich.edu, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: pci: impl Send + Sync for pci::Device
Message-ID: <Z9rLs9jY1h7IdImw@cassiopeiae>
References: <20250318212940.137577-1-dakr@kernel.org>
 <Z9qy-UNJjazZZnQw@google.com>
 <Z9q8xcsAYhQjIpe4@cassiopeiae>
 <Z9rDxOJ2V2bPjj5i@google.com>
 <Z9rG8QFRv_lQlXV4@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9rG8QFRv_lQlXV4@cassiopeiae>

On Wed, Mar 19, 2025 at 02:30:31PM +0100, Danilo Krummrich wrote:
> On Wed, Mar 19, 2025 at 01:16:52PM +0000, Alice Ryhl wrote:
> > On Wed, Mar 19, 2025 at 01:47:01PM +0100, Danilo Krummrich wrote:
> > > On Wed, Mar 19, 2025 at 12:05:13PM +0000, Alice Ryhl wrote:
> > > > On Tue, Mar 18, 2025 at 10:29:21PM +0100, Danilo Krummrich wrote:
> > > > > Commit 7b948a2af6b5 ("rust: pci: fix unrestricted &mut pci::Device")
> > > > > changed the definition of pci::Device and discarded the implicitly
> > > > > derived Send and Sync traits.
> > > > > 
> > > > > This isn't required by upstream code yet, and hence did not cause any
> > > > > issues. However, it is relied on by upcoming drivers, hence add it back
> > > > > in.
> > > > > 
> > > > > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > > > 
> > > > I have a question related to this ... does the Driver trait need to
> > > > require T: Send?
> > > 
> > > The driver trait does not have a generic, it doesn't need one. But I think I
> > > still get what you're asking.
> 
> Turns out I did not. :)
> 
> > Right I mean, should it be:
> > 
> > trait Driver: Send + Sync {
> >     ...
> > }
> 
> Yes, you're absolutely right with this, thanks for pointing this out.

Just to clarify, the reason we need Sync is that we want to be able to access
the driver's private data from an IRQ handler. Otherwise, we can only ever
safely access the driver's private data from bus callbacks, which should be
synchronized by the device' mutex.

> 
> > 
> > > The driver trait never owns a shared reference of the device, it only ever gives
> > > out a reference that the driver core guarantees to be valid.
> > > 
> > > > The change itself LGTM, so:
> > > > 
> > > > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > > > 
> > > > Alice

