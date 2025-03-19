Return-Path: <linux-pci+bounces-24125-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1513A68EA7
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 15:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90658427879
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 14:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34ED1A9B5B;
	Wed, 19 Mar 2025 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1cOA3+L"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76C717A30D;
	Wed, 19 Mar 2025 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393334; cv=none; b=mWH0f+ma2QaQ3KfqxRiZg7Q5OgIjz5KqjvR3aDHtBotGBd/I9sSx5fnWSXXVdQ+mwyciNLlDRsQxCvXPFSMdAdrP78hrMsMoglIJODHYDUpQPXY2E5Wlk2iMFxHjCYkCFLF49CuMuHGx1yrQBbxkFLGYzE7TvwpeupGly2hLZjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393334; c=relaxed/simple;
	bh=LlAkLD1dio/nKpQIdNOz/ALlg+KpmPdToguR0IZvsAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfhY2OeldSlFmrw2sXD6qq62pcCMP4sGzza5ICBdzUs2iRqCG1xS+bkqYsdACRTrASI0eHgDDZkaYksuljF7L87hMckKcG67pq+p0Vc7K2man/nAzU7ZjT+II6WED6InjGtbV9aKQB1o7WN3Af/KWhXcvoAszj8wPjVmGD2f7qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1cOA3+L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C343C4CEE4;
	Wed, 19 Mar 2025 14:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742393334;
	bh=LlAkLD1dio/nKpQIdNOz/ALlg+KpmPdToguR0IZvsAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O1cOA3+LupLFrasNCeQ6NYpiyPnj1ZD7aj88ccKh6lmCgHMJJk6tiRi/851BnpdUm
	 5bPHZrP3bqJneLIrtm8nUugEeZGoBfPvVYiVJBW3zaHT4Hxr2altEVW2BX75Vz5Obx
	 zHQNlzKge8rM1zX6LsUhbcrIMA/Qn/u8E+Dmhnxnf8aIOsetax/uIOpVXEyHlgLQt+
	 t7v6ujnc64TI5tBJqJJTaVJTpCFL61UCgmdNcA72RqsELWvtxOcu4hW3LC6dgnpoWg
	 UrnqtsbT6ggA4tEaahbAsBda0LRkutPyDZew3Rtqhu8BY/LBGKagt0ydJ4ew6vbUJX
	 iGKRs3fvLR+yw==
Date: Wed, 19 Mar 2025 15:08:48 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: bhelgaas@google.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, tmgross@umich.edu, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: pci: impl Send + Sync for pci::Device
Message-ID: <Z9rP8BO1rAYI7UBK@cassiopeiae>
References: <20250318212940.137577-1-dakr@kernel.org>
 <Z9qy-UNJjazZZnQw@google.com>
 <Z9q8xcsAYhQjIpe4@cassiopeiae>
 <Z9rDxOJ2V2bPjj5i@google.com>
 <Z9rG8QFRv_lQlXV4@cassiopeiae>
 <Z9rLs9jY1h7IdImw@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9rLs9jY1h7IdImw@cassiopeiae>

On Wed, Mar 19, 2025 at 02:50:49PM +0100, Danilo Krummrich wrote:
> On Wed, Mar 19, 2025 at 02:30:31PM +0100, Danilo Krummrich wrote:
> > On Wed, Mar 19, 2025 at 01:16:52PM +0000, Alice Ryhl wrote:
> > > On Wed, Mar 19, 2025 at 01:47:01PM +0100, Danilo Krummrich wrote:
> > > > On Wed, Mar 19, 2025 at 12:05:13PM +0000, Alice Ryhl wrote:
> > > > > On Tue, Mar 18, 2025 at 10:29:21PM +0100, Danilo Krummrich wrote:
> > > > > > Commit 7b948a2af6b5 ("rust: pci: fix unrestricted &mut pci::Device")
> > > > > > changed the definition of pci::Device and discarded the implicitly
> > > > > > derived Send and Sync traits.
> > > > > > 
> > > > > > This isn't required by upstream code yet, and hence did not cause any
> > > > > > issues. However, it is relied on by upcoming drivers, hence add it back
> > > > > > in.
> > > > > > 
> > > > > > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > > > > 
> > > > > I have a question related to this ... does the Driver trait need to
> > > > > require T: Send?
> > > > 
> > > > The driver trait does not have a generic, it doesn't need one. But I think I
> > > > still get what you're asking.
> > 
> > Turns out I did not. :)
> > 
> > > Right I mean, should it be:
> > > 
> > > trait Driver: Send + Sync {
> > >     ...
> > > }
> > 
> > Yes, you're absolutely right with this, thanks for pointing this out.
> 
> Just to clarify, the reason we need Sync is that we want to be able to access
> the driver's private data from an IRQ handler. Otherwise, we can only ever
> safely access the driver's private data from bus callbacks, which should be
> synchronized by the device' mutex.

On the other hand, that's up to the IRQ handler abstraction. So, we really
should be good with only requiring Send.

> 
> > 
> > > 
> > > > The driver trait never owns a shared reference of the device, it only ever gives
> > > > out a reference that the driver core guarantees to be valid.
> > > > 
> > > > > The change itself LGTM, so:
> > > > > 
> > > > > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > > > > 
> > > > > Alice

