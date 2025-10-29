Return-Path: <linux-pci+bounces-39654-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0E7C1C01E
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 17:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5375D46482A
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 15:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B27732C941;
	Wed, 29 Oct 2025 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdfjfiNw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3208D2D879A;
	Wed, 29 Oct 2025 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751817; cv=none; b=e+Wbhlgj8cu2o8jaTA/4Qc5oJNJYNrFY5GPadK2x3O7ropgxom3YsA2EibR2j5bouErrB1JaRaOJLp4IH1son83NZW3AUJO1GG7iB/YSimNiA/Sa1+/vZ94nsrgDFCUxIRceeT3GDcO+lyACDh2YRmXstXcag66lkfZsZ8v+o2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751817; c=relaxed/simple;
	bh=U9mGeEcrHqinq3HxjVPLJq14ZfqhrhMXcqrSU/F4H50=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=PRZaCx7EbmeZx9Apgr1rf2twLSqElHvZZ6MumDVfN7Yv5cNdAjFlXQTfT06vU3q0crVQalMD6ky48CmfiEq6Q04zZiov0WLPXSWom5n8mVfII64UnOr8IUZVxXeUo8C5LOJQOe1PmAuNV6ANxUBVvbbd7WuL6E4vWClcoLWknJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdfjfiNw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B7EC4CEF7;
	Wed, 29 Oct 2025 15:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761751816;
	bh=U9mGeEcrHqinq3HxjVPLJq14ZfqhrhMXcqrSU/F4H50=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=WdfjfiNw+1jh+N9+Eg8fRC4v1MwTmrzU4Zis7KzPrwjpee/pB461hVtmuDoQU+S0R
	 J2OWERNJft+bd2JSZJe6h+AjXZ3eOa/Tf3j0bXYCBFfx1N2PdGERUiVZ6PQN3+N8LI
	 pqHRJB7+ncXIw/Hb6pZfhW5zypvjUYMlgs9BgTCxF+WWUY4Qa8FZs68XsRc5C/EI5U
	 W6sC5NL8JirxIxmOD8zJw7VTFluocMK0K7tjvmLrHywp8jN69AILYQXTvIR9Cir9pJ
	 DFmMD7x3JmOQFg21TI1xF+6ZBGjWdTqpqsNAmxJv+slivZKDYYnJVTRKs5XhbCh0f1
	 c3ladtwNtSZ0Q==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Oct 2025 16:30:11 +0100
Message-Id: <DDUWW90NZIDY.2TVA8S0RDSXZJ@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 2/8] rust: device: introduce Device::drvdata()
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <acourbot@nvidia.com>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <pcolberg@redhat.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20251020223516.241050-1-dakr@kernel.org>
 <20251020223516.241050-3-dakr@kernel.org> <aQIPvaFJIXySV-Q5@google.com>
In-Reply-To: <aQIPvaFJIXySV-Q5@google.com>

On Wed Oct 29, 2025 at 1:59 PM CET, Alice Ryhl wrote:
> Are you going to open that docs PR to the Rust compiler about the size
> of TypeID that we talked about? :)

Yes, I will -- thanks for the reminder.

> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>
>> +// Compile-time checks.
>> +const _: () =3D {
>> +    // Assert that we can `read()` / `write()` a `TypeId` instance from=
 / into `struct driver_type`.
>> +    static_assert!(core::mem::size_of::<bindings::driver_type>() =3D=3D=
 core::mem::size_of::<TypeId>());
>> +};
>
> You don't need the "const _: ()" part. See the definition of
> static_assert! to see why.

Indeed, good catch -- same for the suggestions below.

> Also, I would not require equality. The Rust team did not think that it
> would ever increase in size, but it may decrease.
>
>>  /// The core representation of a device in the kernel's driver model.
>>  ///
>>  /// This structure represents the Rust abstraction for a C `struct devi=
ce`. A [`Device`] can either
>> @@ -198,12 +204,29 @@ pub unsafe fn as_bound(&self) -> &Device<Bound> {
>>  }
>> =20
>>  impl Device<CoreInternal> {
>> +    fn type_id_store<T: 'static>(&self) {
>
> This name isn't great. How about "set_type_id()" instead?
>
> Alice=20


