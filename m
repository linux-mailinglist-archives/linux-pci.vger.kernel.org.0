Return-Path: <linux-pci+bounces-29434-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF37CAD5534
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 14:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC5661BC1C98
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 12:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5CE278165;
	Wed, 11 Jun 2025 12:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAeeZByd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102DA78F34;
	Wed, 11 Jun 2025 12:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749644156; cv=none; b=sSYvqEicb3h3VNJNCyCT5XTL9g8TuvYj7OsVDTADUmCW81aDbCxY3fSurwxD1qgCjPIuDVHylGMjZ4jIU3FOf0j5KUN0hotEqVaifsetaQm5P8CSwUtsiWN0WJxV5PgeFjXsF4l8ytG/xi4GuNXtlVAK1JPfPNnw1EPnSerVVfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749644156; c=relaxed/simple;
	bh=DaJLNDS6duJPDL1/7XRX4kxEAfUHTxFottpnKgbB+pw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IQENiA97gRdT/8Er3qgmSuORZolgbUO3iYqPyfs1R4XTOspvVmPrvOUEvGZOY7u8kIZwi5hPmgvYIPcTEeHvaDCgVSM6re/DSNi2hNYDusv7xCIAHv1sU7M3iS3mx0GI0FG2GRNF14+Lbiz+Hqtf3tkaDqESWULh52VCeGXTyIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAeeZByd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDB7C4CEEE;
	Wed, 11 Jun 2025 12:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749644155;
	bh=DaJLNDS6duJPDL1/7XRX4kxEAfUHTxFottpnKgbB+pw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=mAeeZByduh5Oq1FfMNMx1NunHHeGCV7WVmVsTv+iZ/j4VzsSBE4F0x21N46/L+uj8
	 uP8NCUZOPMekP3ZUerWqALVE57lttaaQ5Iiokdt+Cgwcsaw03ekFyY2Mq5CURg8mt9
	 2u0GrxCUTgVW9bUHzDmG/bYaoJ1uutE5gwB/wfVj0r8NZmEVLPJOlLSQf+1lpUvscZ
	 pUAEVgYnPGs6qqt2z6zCDDOIdseBga2fJST/2pzwBEOktI9a6LHXPmUWfRdPOSbZpC
	 BKghIStrE4gsu7gdeZuV08S61crAtQU7UBOjkJ5asaageRGXgIEH1egL0Xmd/YOEDi
	 GxjsrL9K45YUg==
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
In-Reply-To: <CAH5fLgjRd5S4owRrZS7ONeb=-Tzq+xQDtWtqii1tCgEoqzr+bw@mail.gmail.com>
 (Alice
	Ryhl's message of "Wed, 11 Jun 2025 13:08:11 +0200")
References: <20250605-pointed-to-v1-1-ee1e262912cc@kernel.org>
	<Was3UIiWcTBx58JEfoXMB908QEUOWeRMrekA9TD0VWTsA5KU20VwFE9Vo_xefwi_U4UOa5BggjbBby92lP96pg==@protonmail.internalid>
	<CAH5fLggzYQcMhcscuODR7cu__LLKAXhZ0A-tsBGc7gGyAA6Ofg@mail.gmail.com>
	<87ecvqzhcr.fsf@kernel.org>
	<DvqC9qKKZIu1wrtlq_Jh2C9dmaGJ6-hiASiDtn4tdtpVeAI-QXgqZtYhz-b5RQi6iTyBeNbowq1MyuNff98eQA==@protonmail.internalid>
	<CAH5fLgjRd5S4owRrZS7ONeb=-Tzq+xQDtWtqii1tCgEoqzr+bw@mail.gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 11 Jun 2025 14:15:46 +0200
Message-ID: <8734c6zd71.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Wed, Jun 11, 2025 at 12:46=E2=80=AFPM Andreas Hindborg <a.hindborg@ker=
nel.org> wrote:
>>
>> "Alice Ryhl" <aliceryhl@google.com> writes:
>>
>> > On Thu, Jun 5, 2025 at 10:00=E2=80=AFPM Andreas Hindborg <a.hindborg@k=
ernel.org> wrote:
>> >>
>> >> The current implementation of `ForeignOwnable` is leaking the type of=
 the
>> >> opaque pointer to consumers of the API. This allows consumers of the =
opaque
>> >> pointer to rely on the information that can be extracted from the poi=
nter
>> >> type.
>> >>
>> >> To prevent this, change the API to the version suggested by Maira
>> >> Canal (link below): Remove `ForeignOwnable::PointedTo` in favor of a
>> >> constant, which specifies the alignment of the pointers returned by
>> >> `into_foreign`.
>> >>
>> >> Suggested-by: Alice Ryhl <aliceryhl@google.com>
>> >> Suggested-by: Ma=C3=ADra Canal <mcanal@igalia.com>
>> >> Link: https://lore.kernel.org/r/20240309235927.168915-3-mcanal@igalia=
com
>> >> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> >
>> > One nit below. With that and things other folks mentioned fixed, you m=
ay add:
>> >
>> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>> >
>> >> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
>> >> index 22985b6f6982..025c619a2195 100644
>> >> --- a/rust/kernel/types.rs
>> >> +++ b/rust/kernel/types.rs
>> >> @@ -21,15 +21,11 @@
>> >>  ///
>> >>  /// # Safety
>> >>  ///
>> >> -/// Implementers must ensure that [`into_foreign`] returns a pointer=
 which meets the alignment
>> >> -/// requirements of [`PointedTo`].
>> >> -///
>> >> -/// [`into_foreign`]: Self::into_foreign
>> >> -/// [`PointedTo`]: Self::PointedTo
>> >> +/// Implementers must ensure that [`Self::into_foreign`] return poin=
ters with alignment that is an
>> >> +/// integer multiple of [`Self::FOREIGN_ALIGN`].
>> >
>> > We should require non-null:
>>
>> What is your rationale for this?
>
> The rationale is that the implementation of XArray assumes that the
> pointers are non-null. If we allow null pointers, we will need to fix
> the XArray.

OK, thanks. Also, `try_from_foreign` as Benno highlighted.


Best regards,
Andreas Hindborg




