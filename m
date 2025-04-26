Return-Path: <linux-pci+bounces-26823-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFCBA9DC73
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 19:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A21E1BA036F
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 17:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448A125D906;
	Sat, 26 Apr 2025 17:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUB7TG7e"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B9E25D8FF;
	Sat, 26 Apr 2025 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745687702; cv=none; b=UBcvVVl/vwPF2UOuQFpkmMszr4i+chBfI1rZORUOwe2pDryv+D9Gp7qXZLfWWTEKsJfh5+GKBXn4//ZFvBn++KYFq2Xfam6L3Pg+S2VAdZoDpqgxr7kxMEbgacow+r06AsaE3cTjg2PDe++Bs/x836EkrfuG4TxHZTdJc9LqrxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745687702; c=relaxed/simple;
	bh=gkOkV1pfWN8+ewoTbo5qLZhRbtMIV3CydSLGRhqoYKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMpRijTCVRTDcmh48F1LXsqiLueEBPuRDjbWvmbVRmXa2kVHhdQZSwxYdP2eeAHkhTO4TS0IrbYSa5O9Csk3VskezmIFMQawNPoWTsQJg330/GO2igRnBO0cHkBUPHFkgO4iVwr2cGltb9dSwcrb1z4DBD+0xqxHaKalAaIdoWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUB7TG7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC2EC4CEE2;
	Sat, 26 Apr 2025 17:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745687701;
	bh=gkOkV1pfWN8+ewoTbo5qLZhRbtMIV3CydSLGRhqoYKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uUB7TG7ee1wWEFmFO2Dq5tqpARg4urb0dRFG9KbFCljU7z/Qm47p4gGPCQgaOB/WW
	 O7IouNUhSbXlJbL3hm610KtmfuzjSoIsrCR+ZnPcobp5wF45HsMH/wAadmV5Gkrq6e
	 eD2Qf/eHK+yTcEOSd4opfV9tNSjkyWtMTkYavB5zTSl7vp1qL7sqm7z36PmqPa2ioF
	 YNIRAmLA+osG3YfJOdR7foYIH6uuzxe2B46zxhox44EPqzAPq3QOC6x9uLInIzKVfZ
	 mLlzquS9ySB2Xc9iY/EvMjxptwJSJ8S14DzBBvM6JJ98G8APRPINUn8gZerfWJw+5Q
	 5jD3rc7ESKIQw==
Date: Sat, 26 Apr 2025 19:14:54 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	kwilczynski@kernel.org, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com,
	joelagnelf@nvidia.com, ttabi@nvidia.com, acourbot@nvidia.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Devres optimization with bound devices
Message-ID: <aA0UjvxV7_VfbR1a@pollux>
References: <20250426133254.61383-1-dakr@kernel.org>
 <aA0TU1Abvm3YxMgS@Mac.home>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aA0TU1Abvm3YxMgS@Mac.home>

On Sat, Apr 26, 2025 at 10:09:39AM -0700, Boqun Feng wrote:
> On Sat, Apr 26, 2025 at 03:30:38PM +0200, Danilo Krummrich wrote:
> > This patch series implements a direct accessor for the data stored within
> > a Devres container for cases where we can proof that we own a reference
> > to a Device<Bound> (i.e. a bound device) of the same device that was used
> > to create the corresponding Devres container.
> > 
> > Usually, when accessing the data stored within a Devres container, it is
> > not clear whether the data has been revoked already due to the device
> > being unbound and, hence, we have to try whether the access is possible
> > and subsequently keep holding the RCU read lock for the duration of the
> > access.
> > 
> > However, when we can proof that we hold a reference to Device<Bound>
> > matching the device the Devres container has been created with, we can
> > guarantee that the device is not unbound for the duration of the
> > lifetime of the Device<Bound> reference and, hence, it is not possible
> > for the data within the Devres container to be revoked.
> > 
> > Therefore, in this case, we can bypass the atomic check and the RCU read
> > lock, which is a great optimization and simplification for drivers.
> > 
> 
> Nice! However, IIUC, if the users use Devres::new() to create a `Devres`
> , they will have a `Devres` they can revoke anytime, which means you can
> still revoke the `Devres` even if the device is bound.

No, a user of Devres can't revoke the inner Revocable itself. A user can only
drop the Devres instance, in which case the user also wouldn't be able to call
access_with() anymore.

> Also if a `Devres` belongs to device A, but someone passes device B's
> bound reference to `access_with()`, the compiler won't check for that,
> and the `Devres` can be being revoked as the same, no? If so the
> function is not safe.

Devres::access_with() compares the Device<Bound> parameter with its inner
ARef<Device>, and just fails if they don't match.

