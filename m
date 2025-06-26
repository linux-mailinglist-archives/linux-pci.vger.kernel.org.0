Return-Path: <linux-pci+bounces-30868-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F39AEAA6E
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 01:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51DE51C26F04
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 23:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A058217F35;
	Thu, 26 Jun 2025 23:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqLHAZd2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A862153F1;
	Thu, 26 Jun 2025 23:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750979887; cv=none; b=X1oltr9sWt48f3M/cm1qE/RoalA+G9hkG5dz9EA5GDNC1+l6XzM6mYqIMCuPBFXDUzP0MXww3/Ig2QB0tRyDF0PL1FKVMTUSXup8m48HvCILqnq166VKZHpk0XSTczc07sQe4GzT4ofsX6ftmNWebAOy1wzO1eXvtQnc5mzPcgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750979887; c=relaxed/simple;
	bh=wACCooU3kTXmAs8fvGImWMYMeVFPHKRKypC8RJP5gug=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=WpZ42kUZmZbdjMwa5gp128UPvNNYREoQVLcAS4pe+t7qMb1oC1xfbT+JiUHW+zdYjqf0m8c7bLTsWNDi/Cav2wVKCrked4O9/E+d/VqWeG8kaktSL9Ldvt9sQnI7EHPgVPHeWdUXLLwqkLvYCseIek5P+FGQPWDBuvgL9pXSQr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqLHAZd2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD11C4CEEB;
	Thu, 26 Jun 2025 23:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750979886;
	bh=wACCooU3kTXmAs8fvGImWMYMeVFPHKRKypC8RJP5gug=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=kqLHAZd2AEJrftXibIZ9BDpH4N2cggLi54wr56qAZMbvtJQCskjcndpV77TTfWhw1
	 fjuaBwGs/Aa0MVNAHi3Wq0O+hz44u7JJBwcw/xljUb6qNhTKD8zSPQU6bo3j2NkThg
	 AcCbz9SibKvWho1ecqoDQ37bG9mVKm0rQEb/dCBp2Req6WpPBLnSEFcjqfp4GFTfWR
	 xklbhmdpUKMWvCZ0qPCGxJ7TkrRYzoZVYcZeUdDsOwS1hu2uRluUOCqTTQ+PDhEP3n
	 +WhE1NDQiuwXTznvqsGH2n+hlnyHD/KWewJoSGCi87kYxcCPx8P9095DaCwp4WadaR
	 5RzrKy2Pj/cHg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Jun 2025 01:17:57 +0200
Message-Id: <DAWUKB7PAZG1.2K2W9VCATZ3O0@kernel.org>
Subject: Re: [PATCH v4 4/5] rust: types: ForeignOwnable: Add type Target
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>, "Danilo Krummrich"
 <dakr@kernel.org>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <kwilczynski@kernel.org>, <bhelgaas@google.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250626200054.243480-1-dakr@kernel.org>
 <20250626200054.243480-5-dakr@kernel.org> <aF2rpzSccqgoVvn0@tardis.local>
In-Reply-To: <aF2rpzSccqgoVvn0@tardis.local>

On Thu Jun 26, 2025 at 10:20 PM CEST, Boqun Feng wrote:
> On Thu, Jun 26, 2025 at 10:00:42PM +0200, Danilo Krummrich wrote:
>> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
>> index 3958a5f44d56..74c787b352a9 100644
>> --- a/rust/kernel/types.rs
>> +++ b/rust/kernel/types.rs
>> @@ -27,6 +27,9 @@
>>  /// [`into_foreign`]: Self::into_foreign
>>  /// [`PointedTo`]: Self::PointedTo
>>  pub unsafe trait ForeignOwnable: Sized {
>> +    /// The payload type of the foreign-owned value.
>> +    type Target;
>
> I think `ForeignOwnable` also implies a `T` maybe get dropped via a
> pointer from `into_foreign()`. Not sure it's worth mentioning though.

What? How would that happen?

---
Cheers,
Benno

