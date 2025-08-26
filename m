Return-Path: <linux-pci+bounces-34791-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B28EBB37405
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 22:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1DFF1B27188
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 20:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F76230BF6;
	Tue, 26 Aug 2025 20:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rs/wbgOk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251AC1DC9B3;
	Tue, 26 Aug 2025 20:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756241158; cv=none; b=jYsPcdNtIzXp1FqjqK+euEg4OuTS8uya+WKpuWn4AHRVppAjYYWWUok2V1QOY8rLIz+So7ZIupe+QgzL1sJ6RaBDczbQ9IVEXB4NzJz9GbRXnPJ3z4rYmqPq9jZzMQmf2M6rbgHNOpciY2eFBuMiyFEqOyY+UxCPWijWryBC764=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756241158; c=relaxed/simple;
	bh=LPYcNdjWMT5gtus+yEjlqVcxtuCErQDBe3KmbDjEKpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tuCxG3qS1TCCC5qbn5zD8B4kXxnNHlpVcwER0BWQcleIt95XVpFaMNzVpfAjUA7ijm1aGFKnuwSvqGkLr89nYyW6FRzccCggoMP9EzdFm261rHU+IHUqq4A0xOvg3umT6vULa8nyP1qACiFUxOgaT5sfJp20416Huz8QgtUmh9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rs/wbgOk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8602C4CEF1;
	Tue, 26 Aug 2025 20:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756241157;
	bh=LPYcNdjWMT5gtus+yEjlqVcxtuCErQDBe3KmbDjEKpo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Rs/wbgOk/M9U4khTkYQrkEcZAAJZPJKgPLyHGVhjpnV3M9gisMAtbAqUd5GImyNY8
	 nHBrNJcoQEnvmuYFWAlWYukBJ5kHX/OjqCl4XJGfsLWCRB2UNmA5OM940s90utYg6X
	 iyyl/mCudCgQTQ3b8vv80lksFNaNCjF4ZuPx9IoPC5F4zDAq61m6mnbfuZlKCuKciM
	 ceVQeQHagtuk5ErmC25DfRFji/YaTDk/jmMyWWMx4mqvUMcABzDN21aCQqJ2CaengG
	 hDz/q0JuKDd1ycP6euZj7ScVuBMKAT94bCohxTVcFHqB3EK4YBvGggAj9Piyo6qb9w
	 vIHjU6uNbTiWg==
Message-ID: <54b19bdc-5d88-4f71-ad8e-886847ccee8a@kernel.org>
Date: Tue, 26 Aug 2025 22:45:52 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/5] rust: pci: provide access to PCI Vendor values
To: John Hubbard <jhubbard@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
 rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Elle Rhumsaa <elle@weathered-steel.dev>
References: <20250822020354.357406-1-jhubbard@nvidia.com>
 <20250822020354.357406-3-jhubbard@nvidia.com>
 <DCBIF83RP6G8.1B97Z24RQ0T24@nvidia.com>
 <DCBIPY9UJTT4.ETBXLTRGJWHO@kernel.org>
 <b1cbdc99-317e-454c-bf03-d6793be5b13c@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <b1cbdc99-317e-454c-bf03-d6793be5b13c@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/25 10:38 PM, John Hubbard wrote:
> On 8/25/25 5:47 AM, Danilo Krummrich wrote:
>> On Mon Aug 25, 2025 at 2:33 PM CEST, Alexandre Courbot wrote:
> ...
>>> Naive question from someone with a device tree background and almost no
>>> PCI experience: one consequence of using `From` here is that if I create
>>> an non-registered Vendor value (e.g. `let vendor =
>>> Vendor::from(0xf0f0)`), then do `vendor.as_raw()`, I won't get the value
>>> passed initially but the one for `UNKNOWN`, e.g. `0xffff`. Are we ok
>>> with this?
>>
>> I think that's fine, since we shouldn't actually hit this. Drivers should only
>> ever use the pre-defined constants of Vendor; consequently the
>> Device::vendor_id() can't return UNKNOWN either.
>>
>> So, I think the From impl is not ideal, since we can't limit its visibility. In
>> order to improve this, I suggest to use Vendor::new() directly in the macro, and
>> make Vendor::new() private. The same goes for Class, I guess.
> 
> Correction: when I went to implement this, I discovered that there is a better
> way, which addresses both Alex's and your concerns.
> 
> The incremental diff below shows how. It provides:
> 
> a) .from_raw(), which in this case matches conventions slightly better
>     than new(). (I'm still learning that the Rust way is a bit different
>     that the C++ way! haha).
> 
> b) Only the parent module (in this case, that's pci:: ) can call
>     Class::from_raw(). This is exactly what we need. Fully private methods
>     wouldn't work, but leaving it open for any caller to construct a
>     Class item is also a problem.

Sorry, that's on me being not precise. When I said private I meant private to
the parent module.

The diff looks good, thanks!

Please also make sure to add #[inline] where appropriate and rebase onto
driver-core-next.

