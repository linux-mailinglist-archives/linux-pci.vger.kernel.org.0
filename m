Return-Path: <linux-pci+bounces-38431-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17538BE7279
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 10:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09866188D25E
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 08:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44CD28469B;
	Fri, 17 Oct 2025 08:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/FOHOK/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A9E283FE5;
	Fri, 17 Oct 2025 08:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760689610; cv=none; b=Uno9t+5N4HqqbxiO/5LaZJP+H8RXgnZwR4xrmoZifWPt+hy/tbkQWitbfkQrXgLP0UQXE9pjWhOSqcwPW+vm8BQPw0ge+9X59vEoyO5vS9m0jN8RHdwhjBa5OLrjcLp9aZjcOXzTkfgywI9rFTsEYRsgfwhJNTcZCRG8hRMr0Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760689610; c=relaxed/simple;
	bh=kbYlbb2vWzoBZ20nmxTT1jLO3BgY9QweNZ2+SNF6NR8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=tduqd5ezMs13kKlO4Jl4CIi/NBGIlHL09bLPcftyvBJPejpSXmj+R/n5OHCSzosnvHXFBFhgU57CIR3WjSgir4npJ8BFNqw96bdgJNIDq9+bYBStjz3o/23IvYKKJZ0zeOOtHvUte58IHao1POatRQVauekmyTu/MbVTSWkxkj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/FOHOK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8C7C4CEF9;
	Fri, 17 Oct 2025 08:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760689610;
	bh=kbYlbb2vWzoBZ20nmxTT1jLO3BgY9QweNZ2+SNF6NR8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=r/FOHOK/KV30W9AU1CLlFZr7Uo1nt7j3bZpfAoNf7pLarQJDffIexQ+Caee9cxKAE
	 yWLtItXISda1kqRcnbW7Fq525yc0tSmY6FmHR+2l/kehCTieOvZViXTwGMODOBh0kO
	 yhT4xZ7huZ4JJloh1JFwmwKqgu9MPcGketcuNCnak+Zuq7y4tSU7leFiIcH0xjMCeN
	 66ezK0K71KhY90ckpGXCToE8maTmVN4O3KA9iqr+4nssdX6YAc1vZNVBSqjqAma1CB
	 87r5pmy5mTtOmoEEQgZBEjNpZW2lTJ6WsSTyqMxPIOr2KJ7CtfbJAHJJ+KUmUHkLaH
	 jcc1Oo3Qej4nw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Oct 2025 10:26:43 +0200
Message-Id: <DDKGDHEH4QOJ.2QCE60PQ5OJRM@kernel.org>
Cc: <viresh.kumar@linaro.org>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <daniel.almeida@collabora.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: driver: let probe() return impl PinInit<Self,
 Error>
From: "Benno Lossin" <lossin@kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>
X-Mailer: aerc 0.21.0
References: <20251016125544.15559-1-dakr@kernel.org>
 <DDK8EYINVIKJ.2ZK04J2C06GGR@nvidia.com>
In-Reply-To: <DDK8EYINVIKJ.2ZK04J2C06GGR@nvidia.com>

On Fri Oct 17, 2025 at 4:12 AM CEST, Alexandre Courbot wrote:
> On Thu Oct 16, 2025 at 9:55 PM JST, Danilo Krummrich wrote:
>> The driver model defines the lifetime of the private data stored in (and
>> owned by) a bus device to be valid from when the driver is bound to a

>> device (i.e. from successful probe()) until the driver is unbound from
>> the device.
>>
>> This is already taken care of by the Rust implementation of the driver
>> model. However, we still ask drivers to return a Result<Pin<KBox<Self>>>
>> from probe().
>>
>> Unlike in C, where we do not have the concept of initializers, but
>> rather deal with uninitialized memory, drivers can just return an
>> impl PinInit<Self, Error> instead.
>>
>> This contributed to more clarity to the fact that a driver returns it's
>
> nit: s/it's/its
>
>> device private data in probe() and the Rust driver model owns the data,
>> manages the lifetime and - considering the lifetime - provides (safe)
>> accessors for the driver.
>>
>> Hence, let probe() functions return an impl PinInit<Self, Error> instead
>> of Result<Pin<KBox<Self>>>.
>>
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>
> Short anecdote: I was curious about measuring the footprint impact of
> pin initializers, so I did a `size vmlinux` before and after this patch
> to compare the size of the `text` section. This patch removes exactly 60
> bytes of binary code, which I guess corresponds to the duplicated `KBox`
> allocations that are now gone. It's great to confirm once again how Rust
> abstractions are indeed zero-overhead! :)

Thanks for the test! If you find that at any point they aren't, let me
know, then we can fix that :)

---
Cheers,
Benno

