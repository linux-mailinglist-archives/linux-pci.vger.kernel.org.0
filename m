Return-Path: <linux-pci+bounces-29693-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 379FCAD8C94
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 14:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB7B1E26A5
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 12:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDFE1BC4E;
	Fri, 13 Jun 2025 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0RVRQl8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F36A54670;
	Fri, 13 Jun 2025 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749819232; cv=none; b=azv7nqu8Xclr+NYRZIL2jlj0X5Q8JvfHlyQMc3OQ5M+qWg9BHozJR8WpCXsGbbQKEvzIbSL2GAD5PgAjZXDLkOwaIM3DXeQiAaBIFjmq5pl4T5RPX0pvDKSBDmZNLG/16lTNPTgx0C7fGEVCeDdo/A9rIk2yOP64+M3Kzg9kl7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749819232; c=relaxed/simple;
	bh=9NILGPi+IgsNtn81oQYyesjFnsHS92zOjt5H9tpm4W4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YgUV7WoJYtYn1BcSzdxpsyiIjiDAeE+cGQQUxPYTR0jAv+Jz0NJOVxEM9FIg4F22OMb8AFN6IgFnOjRh8If/GTwbePZzZnDgq2YtEZBwwynWKHOWgR3IQ2U78kByZKdDNlRZcxLWk99pOOdTo1tftLid/AEqb0XjOUI4xYQEh2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0RVRQl8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9940DC4CEE3;
	Fri, 13 Jun 2025 12:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749819231;
	bh=9NILGPi+IgsNtn81oQYyesjFnsHS92zOjt5H9tpm4W4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=m0RVRQl8cpn/vhBcA5bbs+XJt5w1gkbye0vIjR3iei/AbcVq7md2bmYkOWjXT8Ffg
	 Kuod1g3bSdyhlGPqfpmlOth0iU5bxSebpLlXyq7JhxpgVVln9n+n8cKBMCauhjPx+7
	 bAX6PX5FgWOhK4tIHzcNUQorZaXeXZ5vd5pdYeVDfXAzARVQcpLbOP71l9SD9W2ugZ
	 ZwyVP2uy9OyzMt94KQzCJ6NXQIdFUME2F/FcFJj+4ggyq1ravIXSDENoNpzG3b11yY
	 naauGWtr7HIzpOgG7cvPDSbYSUl8R0wvpWQqYBsUCPUDKiMDr9kDkdmpKlZiuUAYYm
	 KgCNLWYnWTroA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <lossin@kernel.org>
Cc: "Danilo Krummrich" <dakr@kernel.org>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  "Bjorn Helgaas" <bhelgaas@google.com>,
  Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,  "Greg
 Kroah-Hartman"
 <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki" <rafael@kernel.org>,
  "Tamir Duberstein" <tamird@gmail.com>,  "Viresh Kumar"
 <viresh.kumar@linaro.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] rust: types: require
 `ForeignOwnable::into_foreign` return non-null
In-Reply-To: <DAKN1HO7WUXY.QS098VXTDICU@kernel.org> (Benno Lossin's message of
	"Thu, 12 Jun 2025 16:52:15 +0200")
References: <20250612-pointed-to-v3-0-b009006d86a1@kernel.org>
	<20250612-pointed-to-v3-2-b009006d86a1@kernel.org>
	<ftVceLHmGCX4uHfwZ7aGMOkv5d4ALLIYrsQarySS4pU1gDD6qnxOY3rArV9Kp0tazReT-IfOQGGpK-jNthUKkA==@protonmail.internalid>
	<DAKN1HO7WUXY.QS098VXTDICU@kernel.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Fri, 13 Jun 2025 14:53:42 +0200
Message-ID: <87sek3by5l.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <lossin@kernel.org> writes:

> On Thu Jun 12, 2025 at 3:09 PM CEST, Andreas Hindborg wrote:
>> The intended implementations of `ForeignOwnable` will not return null
>> pointers from `into_foreign`, as this would render the implementation of
>> `try_from_foreign` useless. Current users of `ForeignOwnable` rely on
>> `into_foreign` returning non-null pointers. So require `into_foreign` to
>> return non-null pointers.
>>
>> Suggested-by: Benno Lossin <lossin@kernel.org>
>> Suggested-by: Alice Ryhl <aliceryhl@google.com>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>>  rust/kernel/types.rs | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
>> index c156808a78d3..63a2559a545f 100644
>> --- a/rust/kernel/types.rs
>> +++ b/rust/kernel/types.rs
>> @@ -43,6 +43,7 @@ pub unsafe trait ForeignOwnable: Sized {
>>      /// # Guarantees
>>      ///
>>      /// - Minimum alignment of returned pointer is [`Self::FOREIGN_ALIGN`].
>> +    /// - The returned pointer is not null.
>
> This also needs to be mentioned in the `Safety` section of this trait.
> Alternatively you can put "Implementers must ensure the guarantees on
> [`into_foreign`] are upheld." or similar.

Which is exactly what I did :)


Best regards,
Andreas Hindborg




