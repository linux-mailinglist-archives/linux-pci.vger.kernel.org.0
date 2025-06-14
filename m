Return-Path: <linux-pci+bounces-29819-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBFCAD9EF3
	for <lists+linux-pci@lfdr.de>; Sat, 14 Jun 2025 20:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF36F18989D9
	for <lists+linux-pci@lfdr.de>; Sat, 14 Jun 2025 18:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E101C3314;
	Sat, 14 Jun 2025 18:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWTcy8dj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A9E1D52B;
	Sat, 14 Jun 2025 18:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749925068; cv=none; b=BmPKXDssgVkHMZvXAbXFAAtigbTeaZ8F0mxZ2zCaHiiBKXU3JCM07A0cSelRgzQMNEmhrr5NTD4GANeg2E9RfCtfr54afo78l2w2vBtwgt+9Bkh/YFvHlQ4zfH0jQXNm30CyfGEW0MgP119zyvnUd3x2X1hMgx3IMiWZczHTjY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749925068; c=relaxed/simple;
	bh=kYjMKtc7MklFMBiGIsBwUdz/Ui61mcF79jR156Q6WLE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=j2i8kyTzqPyrNX3aogP3+ThOL+vNcEYp9J/dtPTL9EjA8FYtGaaCOptHqOqKrdd4C6Di1VizOh0o0Xp1Waydkz3ByYPl4R+1+4qkVXXICmbyDsK0Ml/RbePkDw2TSbIh7pxLL3p8BgmN4hClE2EXzLSoe6AUsiaNE0Aefbj5W9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWTcy8dj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEFCC4CEEB;
	Sat, 14 Jun 2025 18:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749925067;
	bh=kYjMKtc7MklFMBiGIsBwUdz/Ui61mcF79jR156Q6WLE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=iWTcy8djg9eMkM73JF3/T5fhhrX0PUH2QYiAkDv3oO6yuylXcmk3CnxrcNCjgLuMK
	 rGpZLqirzW6xYLgJe4FHVLWvvxwVGiUMkxX8iiGAnUAGv42qWa7UVF/+SZ+SADuUDM
	 27pB30y4E0AJZQ2Lc7Wz265vVegVDzUeEICh4F9M/RN+8y7wjWVeZCugN8fPYUl/Ye
	 PyYvNrXq1VT3lo3W5xAppa7Tg5dPiqkFFxA5XzdUHILJnmuBuDaSDk8LujP/TNFSKV
	 /F9E1FaX1wxtYu1U4vvcY3mnwp5lQsOvOo2zi8alf3BmzoYsFz8gFvAoXZqv2OrVrs
	 sjf7n3PVhwvdQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Jun 2025 20:17:42 +0200
Message-Id: <DAMGNVWE7HAH.ZIUK8D3A3VEM@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor Gross"
 <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Bjorn Helgaas"
 <bhelgaas@google.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 0/6] rust: list: remove HasListLinks::OFFSET
From: "Benno Lossin" <lossin@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>, "Alice Ryhl"
 <aliceryhl@google.com>
X-Mailer: aerc 0.20.1
References: <20250423-list-no-offset-v3-0-9d0c2b89340e@gmail.com>
 <aAkoVfiZDAXdYxrr@google.com>
 <CAJ-ks9=vPJJ9H0+vCb9=5MwQavcYqvQQ3D+heFhE+xHW+kq=MA@mail.gmail.com>
In-Reply-To: <CAJ-ks9=vPJJ9H0+vCb9=5MwQavcYqvQQ3D+heFhE+xHW+kq=MA@mail.gmail.com>

On Fri Jun 13, 2025 at 6:45 PM CEST, Tamir Duberstein wrote:
> On Wed, Apr 23, 2025 at 1:50=E2=80=AFPM Alice Ryhl <aliceryhl@google.com>=
 wrote:
>>
>> On Wed, Apr 23, 2025 at 12:30:01PM -0400, Tamir Duberstein wrote:
>> > The bulk of this change occurs in the last commit, please its commit
>> > messages for details.
>> >
>> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>>
>> This works with Rust Binder and Ashmem.
>>
>> Tested-by: Alice Ryhl <aliceryhl@google.com>
>
> Thanks Alice. Could you also review? I guess this still needs some
> RBs. @Benno Lossin could you perhaps have a look as well? You both
> reviewed my other series[0] which was quite similar.
>
> [0] https://lore.kernel.org/all/20250411-no-offset-v3-1-c0b174640ec3@gmai=
l.com/

I probably won't have time for this one.

---
Cheers,
Benno

