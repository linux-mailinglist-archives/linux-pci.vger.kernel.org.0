Return-Path: <linux-pci+bounces-29820-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D71AD9F27
	for <lists+linux-pci@lfdr.de>; Sat, 14 Jun 2025 20:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 600D6189449B
	for <lists+linux-pci@lfdr.de>; Sat, 14 Jun 2025 18:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1321E492D;
	Sat, 14 Jun 2025 18:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBCFT29I"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6851F941;
	Sat, 14 Jun 2025 18:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749927219; cv=none; b=MN4ACfzPJkBfNgi1R8/wIZvA3+N/AW2tZDtkjXmou+RXebJIBBP2pBOHlVGZSKom+El/dSlbseIbJ6H7PfSDddsHAPj0YvwRma2rnCdwpSRtDcuDk4mnYciKi7vPchFfudvFapdJzYKFuFoThZX38n4Aho1Xp1GzD5fLEh/If+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749927219; c=relaxed/simple;
	bh=vaspYYUdyipuilwzgjC/E308IR/28hvnXzZCjErcA3o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=lK4/0bOef1celYgnJirN4GtkzayogloQKlpCAtMN6Fw2q2/n0XUZBA/YdFxbNIlcOTIPkyDUl2XBiqDOzabl3HN/7uicAuAUv4mj6XttBHA3wW6t1pCFHSB90bU/YpZy2iUp7bK8QPJ6sXeCGdKrpMvV1FsOgI6DIw+D/RrWyFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBCFT29I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3DCC4CEEB;
	Sat, 14 Jun 2025 18:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749927219;
	bh=vaspYYUdyipuilwzgjC/E308IR/28hvnXzZCjErcA3o=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=fBCFT29In6dOJhN/DyGpjDvLKzjrLuaLJ76P/0y8PrxpsZnf7jZAnAAFqtE+Vl2YB
	 ssQVqtmIXvRryo6ziSgHRRTm8T0owQn/D+VG3PZcQTPWpmSJECxlDAGWwTKXsDrCX2
	 XAKn14xuXmqNS/XgZogFbefPf17OHV/nkhKSCq38+CfnJ4eFrgLFS1AbD+QdL8QPGa
	 nbCJmhxv0r5JCt8eLpSQabPnIDOnuJudErVzOKr25wlXrAhMQFKjZrUG6v7XbGYA3O
	 1AadWRLc+QnYavOUw4SM8P2ovLpicaBx1sjugUzPu3RzwB8zGsz2G0G7qSnDXnXC9b
	 YHP7U1YsEmQlA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Jun 2025 20:53:34 +0200
Message-Id: <DAMHFC5U1496.25GQJSFU53PRD@kernel.org>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor
 Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Tamir Duberstein" <tamird@gmail.com>, "Viresh Kumar"
 <viresh.kumar@linaro.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] rust: types: require
 `ForeignOwnable::into_foreign` return non-null
From: "Benno Lossin" <lossin@kernel.org>
To: "Andreas Hindborg" <a.hindborg@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250612-pointed-to-v3-0-b009006d86a1@kernel.org>
 <20250612-pointed-to-v3-2-b009006d86a1@kernel.org>
 <ftVceLHmGCX4uHfwZ7aGMOkv5d4ALLIYrsQarySS4pU1gDD6qnxOY3rArV9Kp0tazReT-IfOQGGpK-jNthUKkA==@protonmail.internalid> <DAKN1HO7WUXY.QS098VXTDICU@kernel.org> <87sek3by5l.fsf@kernel.org>
In-Reply-To: <87sek3by5l.fsf@kernel.org>

On Fri Jun 13, 2025 at 2:53 PM CEST, Andreas Hindborg wrote:
> "Benno Lossin" <lossin@kernel.org> writes:
>
>> On Thu Jun 12, 2025 at 3:09 PM CEST, Andreas Hindborg wrote:
>>> The intended implementations of `ForeignOwnable` will not return null
>>> pointers from `into_foreign`, as this would render the implementation o=
f
>>> `try_from_foreign` useless. Current users of `ForeignOwnable` rely on
>>> `into_foreign` returning non-null pointers. So require `into_foreign` t=
o
>>> return non-null pointers.
>>>
>>> Suggested-by: Benno Lossin <lossin@kernel.org>
>>> Suggested-by: Alice Ryhl <aliceryhl@google.com>
>>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>>> ---
>>>  rust/kernel/types.rs | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
>>> index c156808a78d3..63a2559a545f 100644
>>> --- a/rust/kernel/types.rs
>>> +++ b/rust/kernel/types.rs
>>> @@ -43,6 +43,7 @@ pub unsafe trait ForeignOwnable: Sized {
>>>      /// # Guarantees
>>>      ///
>>>      /// - Minimum alignment of returned pointer is [`Self::FOREIGN_ALI=
GN`].
>>> +    /// - The returned pointer is not null.
>>
>> This also needs to be mentioned in the `Safety` section of this trait.
>> Alternatively you can put "Implementers must ensure the guarantees on
>> [`into_foreign`] are upheld." or similar.
>
> Which is exactly what I did :)

Ah didn't look at the first patch again, then it's fine :)

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

