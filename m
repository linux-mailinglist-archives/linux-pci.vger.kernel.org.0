Return-Path: <linux-pci+bounces-29424-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A946EAD529A
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 12:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DED71762FF
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 10:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D10329AB1E;
	Wed, 11 Jun 2025 10:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4gbnX7r"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504B729AAE9;
	Wed, 11 Jun 2025 10:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749638766; cv=none; b=qZ6ebN+tC1CzILlul4gQwj8XrMmHk90WWVf0SZc6GiO5V9IBSQFcYGaop/3IE7hEGRbPfFohmVXuAED/1evWCoJKI92JvcRbfB7fcj7aLi59hcXAfsruu0OjXMnI5TXbjjYCXGGoOSgM7rYvursr2vGuq91UaitiL0wOd+GsnM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749638766; c=relaxed/simple;
	bh=6QoKf0lmmjNKe0xDrEyKNJ41Q0pTRuoon4Ktt98BOuc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rFc1yC9ikseoGHY0wdJbSu2xSNfFH0fcKEnjyPyYpqt/HK9+rJ0JsuSpqvun6fDtEwO9nInplCa5M+eiFAwUDKY1dDjwlBYxT+ED1gw026NJStELuPxk+IQ+/pxF9eUVF4gBFw1wNhATgvQm5GL9TP7YUwWaJ697XEFv4WFGxUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4gbnX7r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55289C4CEEE;
	Wed, 11 Jun 2025 10:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749638766;
	bh=6QoKf0lmmjNKe0xDrEyKNJ41Q0pTRuoon4Ktt98BOuc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=m4gbnX7ruzKsKcS2MWpzymt+phd27ddDKuz1Ditp5z/ay0q4BJ3VVP7s6wQcCAHVD
	 mYShWebNAGWrtg2zlPjizJy5r0wPgxi+QsWpVGCCvIACFGnT69gDyh+bk9I+fvNOyw
	 yifZQoKAo2wV6zafmTaWpSCkRT+oXfwfbfGQn1w9BAnspj/1vhhqNwlUMpzWWYKDRB
	 vHRKq6jJXgjJ1rGTG5nb1+YN1ErJwRm1wY9YjCJT8hkcCiunPSmKy4nDNJ4ivTkdK8
	 oeaIgW4etNzYt7MxXoJB0NcBe/Kuia9Rp5wV2tSSOcITXgYXP3EI7fIJkF4wrNIwPG
	 A8Vaxo1T2QApA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <lossin@kernel.org>,  "Trevor
 Gross" <tmgross@umich.edu>,  "Bjorn Helgaas" <bhelgaas@google.com>,
  Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,  "Greg
 Kroah-Hartman"
 <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki" <rafael@kernel.org>,
  "Tamir Duberstein" <tamird@gmail.com>,  "Viresh Kumar"
 <viresh.kumar@linaro.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-pci@vger.kernel.org>,
  =?utf-8?Q?Ma=C3=ADra?=
 Canal <mcanal@igalia.com>
Subject: Re: [PATCH] rust: types: add FOREIGN_ALIGN to ForeignOwnable
In-Reply-To: <CAH5fLggzYQcMhcscuODR7cu__LLKAXhZ0A-tsBGc7gGyAA6Ofg@mail.gmail.com>
 (Alice
	Ryhl's message of "Tue, 10 Jun 2025 17:19:28 +0200")
References: <20250605-pointed-to-v1-1-ee1e262912cc@kernel.org>
	<Was3UIiWcTBx58JEfoXMB908QEUOWeRMrekA9TD0VWTsA5KU20VwFE9Vo_xefwi_U4UOa5BggjbBby92lP96pg==@protonmail.internalid>
	<CAH5fLggzYQcMhcscuODR7cu__LLKAXhZ0A-tsBGc7gGyAA6Ofg@mail.gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 11 Jun 2025 12:45:56 +0200
Message-ID: <87ecvqzhcr.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Thu, Jun 5, 2025 at 10:00=E2=80=AFPM Andreas Hindborg <a.hindborg@kern=
el.org> wrote:
>>
>> The current implementation of `ForeignOwnable` is leaking the type of the
>> opaque pointer to consumers of the API. This allows consumers of the opa=
que
>> pointer to rely on the information that can be extracted from the pointer
>> type.
>>
>> To prevent this, change the API to the version suggested by Maira
>> Canal (link below): Remove `ForeignOwnable::PointedTo` in favor of a
>> constant, which specifies the alignment of the pointers returned by
>> `into_foreign`.
>>
>> Suggested-by: Alice Ryhl <aliceryhl@google.com>
>> Suggested-by: Ma=C3=ADra Canal <mcanal@igalia.com>
>> Link: https://lore.kernel.org/r/20240309235927.168915-3-mcanal@igalia.com
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>
> One nit below. With that and things other folks mentioned fixed, you may =
add:
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>
>> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
>> index 22985b6f6982..025c619a2195 100644
>> --- a/rust/kernel/types.rs
>> +++ b/rust/kernel/types.rs
>> @@ -21,15 +21,11 @@
>>  ///
>>  /// # Safety
>>  ///
>> -/// Implementers must ensure that [`into_foreign`] returns a pointer wh=
ich meets the alignment
>> -/// requirements of [`PointedTo`].
>> -///
>> -/// [`into_foreign`]: Self::into_foreign
>> -/// [`PointedTo`]: Self::PointedTo
>> +/// Implementers must ensure that [`Self::into_foreign`] return pointer=
s with alignment that is an
>> +/// integer multiple of [`Self::FOREIGN_ALIGN`].
>
> We should require non-null:

What is your rationale for this?


Best regards,
Andreas Hindborg




