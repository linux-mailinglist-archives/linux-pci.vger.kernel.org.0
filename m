Return-Path: <linux-pci+bounces-30757-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F580AE9E58
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 15:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1F771C428F3
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 13:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1280D2E540F;
	Thu, 26 Jun 2025 13:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyFvx/SC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98EB2E540B;
	Thu, 26 Jun 2025 13:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750943592; cv=none; b=rLLDT/GT+5BRJyzBwC+h92xDGwRUJEwd+AO0VgRYKxy7/nxIgCPsmhlLJh0mf6YqmSuHZ8DhA8045D8mdejE0bRB60Eev/HOt2a+mDAPFrgL+ISn8CyzArVWXkaRUDiawcezT9hEitmzR2lidbsFJyT0qn7cKPyvlKBdnNOBf/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750943592; c=relaxed/simple;
	bh=PreKZtSoyeCQQgE0MXWcjP/5/bBwOnNbclzp2Oj3YyU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=NOE/IQHmuapzYQUyrPcTDg/1GUxAI//0E+7llRJGZfl9hE5T0knyECfWwSCcBG7IKjVIlconIObjRibetXCiwu/cIspKYvemTOKWwAWuJ5efpXFtQ1Ez5a2AlH06BgauEO1mtQHVPGiDvHaJodUv/SiwcOTdbLOCkURwVLXMAXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyFvx/SC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96CAC4CEEB;
	Thu, 26 Jun 2025 13:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750943591;
	bh=PreKZtSoyeCQQgE0MXWcjP/5/bBwOnNbclzp2Oj3YyU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=UyFvx/SCp+HbuN3e7GecTnhWCE7ctRhui/g5helDTlWYPRD4bG+aPKUeDeXOx8Ka+
	 WV2yxI0wSQq6FLkQpp6ixke8+Iev9J/1RCKzdZvd0a+jRbC4MXMe8qKF5lFxwyTxGt
	 eWrpN4MpEuJL24yBQywXDis+xgOOe3QXAOwlMpRSoW3JawpmD6N1+iWtdPx+krUsc7
	 2RQJ3UPWVNjVmt8IHrIgT7sFwPdMP1lXrpOCA+6AJfMhGGm491cB2TTF9D+cfh8yX2
	 G66cRqz8q46jtptaNrp3gJkNi+AOAi1Gjmweq4jkAe8r5sFg5tjVH04aAA81GNurxW
	 62E/6LlKRB4Gg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Jun 2025 15:13:06 +0200
Message-Id: <DAWHP7292ZGD.2SQDBIZOUA4AB@kernel.org>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <kwilczynski@kernel.org>,
 <bhelgaas@google.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] rust: devres: implement register_release()
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250624215600.221167-1-dakr@kernel.org>
 <20250624215600.221167-5-dakr@kernel.org>
 <DAWED7BIC32G.338MXRHK4NSJG@kernel.org> <aF0rzzlKgwopOVHV@pollux>
In-Reply-To: <aF0rzzlKgwopOVHV@pollux>

On Thu Jun 26, 2025 at 1:15 PM CEST, Danilo Krummrich wrote:
> On Thu, Jun 26, 2025 at 12:36:23PM +0200, Benno Lossin wrote:
>> Or, we could change `Release` to be:
>>=20
>>     pub trait Release {
>>         type Ptr: ForeignOwnable;
>>=20
>>         fn release(this: Self::Ptr);
>>     }
>>=20
>> and then `register_release` is:
>>=20
>>     pub fn register_release<T: Release>(dev: &Device<Bound>, data: T::Pt=
r) -> Result
>>=20
>> This way, one can store a `Box<T>` and get access to the `T` at the end.
>
> I think this was also the case before? Well, it was P::Borrowed instead.

Well you had access to a `&T`, but not the `T` directly.

>> Related questions:
>>=20
>> * should we implement `ForeignOwnable` for `&'static T`?
>
> There's already a patch on the list doing this in the context of DebugFS =
[1].
>
> [1] https://lore.kernel.org/lkml/20250624-debugfs-rust-v7-3-9c8835a7a20f@=
google.com/

Ah, I'm not following that series at the moment.

---
Cheers,
Benno

