Return-Path: <linux-pci+bounces-30877-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E04AEAAB5
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 01:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 127E03BB739
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 23:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9353221FB8;
	Thu, 26 Jun 2025 23:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZ5sWG0+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF6A12DDA1;
	Thu, 26 Jun 2025 23:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750980967; cv=none; b=BoKVx572nFXu7BxytNCl8aq99DKzN7uYkMniwNpodpP18oZx0PrvIkhN3hy1vyxqYnFFuV1vVi+gRUSTk0M3AXi3SPUEpXXnee9dK0ChF/Y+w0Ad3+KUUrGkJZqnYqNLKib9yHkGkoFaLBhBXVHTiKanfZRaDls0JonmLbPRTK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750980967; c=relaxed/simple;
	bh=+DyotkMmG7vyU41Fsk1aHPCNbjBgLMIp52gMTNppAaQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=W+vK6wNpuYL4tIl3uRk3zUSHB1UZfFYcqjDP3cBKpaa8pmcvOm/RUOvUDjXTNAL4FzDjgRrarWMRwZTrsHY4Mofi/Z811BJAx6HxRL+db4HqeKVpUuZYomrB3wcDNi9rM35JxRICWXVl1m+tDdpZeezacrzZOBXzgkvidS5oZpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZ5sWG0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB74C4CEEB;
	Thu, 26 Jun 2025 23:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750980966;
	bh=+DyotkMmG7vyU41Fsk1aHPCNbjBgLMIp52gMTNppAaQ=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=KZ5sWG0+kprpy1SlzQUgSOoF9MGnF6wmWs6GFnP0ruEuBPWjYrDEV/2vd4YoapZ4a
	 3WOKes5Vy3g85UinFiUzcHDgAlor3tOwDEyHmeacGVdD5cvwVX0aEySl//zA23gqm9
	 Lt4rgC+0wdyw5EJD0Z0LVa3g5QV/0NLx6pC7tpWdcG6Tz8tMC/JUj/OjYSyLKpViZp
	 GF150UTN0BbivoBasck/5xHfVV0deTHNpcyiIw26XorR3sQXPgaTR0qaWibqnBwm1n
	 N6jrE4O+duOQcGUrFUW+p7OV24QnTzsyzY38VQKjJpjcRqDlumfcZHSqpUPVLJ0Sce
	 7eYvsPP/gNZlg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Jun 2025 01:36:01 +0200
Message-Id: <DAWUY4YH6XP9.TWAP6N95L5BR@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>, "Danilo Krummrich"
 <dakr@kernel.org>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, <alex.gaynor@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, "Andreas Hindborg"
 <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor
 Gross" <tmgross@umich.edu>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <kwilczynski@kernel.org>,
 <bhelgaas@google.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 4/5] rust: types: ForeignOwnable: Add type Target
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250626200054.243480-1-dakr@kernel.org>
 <20250626200054.243480-5-dakr@kernel.org> <aF2rpzSccqgoVvn0@tardis.local>
 <DAWUKB7PAZG1.2K2W9VCATZ3O0@kernel.org>
 <45a2bd65-ec77-4ce7-bd8e-553880d85bdf@app.fastmail.com>
In-Reply-To: <45a2bd65-ec77-4ce7-bd8e-553880d85bdf@app.fastmail.com>

On Fri Jun 27, 2025 at 1:21 AM CEST, Boqun Feng wrote:
> On Thu, Jun 26, 2025, at 4:17 PM, Benno Lossin wrote:
>> On Thu Jun 26, 2025 at 10:20 PM CEST, Boqun Feng wrote:
>>> On Thu, Jun 26, 2025 at 10:00:42PM +0200, Danilo Krummrich wrote:
>>>> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
>>>> index 3958a5f44d56..74c787b352a9 100644
>>>> --- a/rust/kernel/types.rs
>>>> +++ b/rust/kernel/types.rs
>>>> @@ -27,6 +27,9 @@
>>>>  /// [`into_foreign`]: Self::into_foreign
>>>>  /// [`PointedTo`]: Self::PointedTo
>>>>  pub unsafe trait ForeignOwnable: Sized {
>>>> +    /// The payload type of the foreign-owned value.
>>>> +    type Target;
>>>
>>> I think `ForeignOwnable` also implies a `T` maybe get dropped via a
>>> pointer from `into_foreign()`. Not sure it's worth mentioning though.
>>
>> What? How would that happen?
>
> The owner of the pointer can do from_foreign() and eventually drop
> the ForeignOwnable, hence dropping T.

I'm confused, you said `into_foreign` above. I don't think any sensible
ForeignOwnable implementation will drop a T in any of its functions.

---
Cheers,
Benno

