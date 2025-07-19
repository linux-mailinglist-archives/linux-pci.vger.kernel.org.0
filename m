Return-Path: <linux-pci+bounces-32593-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B88FB0B1EC
	for <lists+linux-pci@lfdr.de>; Sat, 19 Jul 2025 23:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2F33BED6B
	for <lists+linux-pci@lfdr.de>; Sat, 19 Jul 2025 21:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2BE20E704;
	Sat, 19 Jul 2025 21:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSjRnFtD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CE720FAAB;
	Sat, 19 Jul 2025 21:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752959865; cv=none; b=oJh/DUHNvYKbZUGID30n0tKU88cAzXLVok6iviDHKllhe+a0Z5uDvoK5CTr4ymG69a1kRpGA61oyEqotETALTw6WTKgysmXJjYJzgiMPsTUS78P0HSpNk+9mI2F2+K2cyJ6vobaiFkhHIb/8hvXjXfKVDAMLcA5ng3K1SF1W3l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752959865; c=relaxed/simple;
	bh=MEp7Wf0O2C0g0O3vR40ys088xNOv/DqBtlHXQfu9wYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wqc4erUoItk6YN8UbW0d2w4IN73tNgxuvBKjBGFtS+s4+l1FMLzJL0CctZZ+XPHvIX28+7ESVY6iTe3T9vxQI6Mj+uDeLizUARgtdPb6/utAUguqBI+s5ZDZSHwUm0rDioX9X6jlhe2qP1ilK8r21GC1KKdHdMriR2ovID2S9u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSjRnFtD; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-32b595891d2so24833761fa.2;
        Sat, 19 Jul 2025 14:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752959861; x=1753564661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEp7Wf0O2C0g0O3vR40ys088xNOv/DqBtlHXQfu9wYc=;
        b=BSjRnFtDeBZatDWIDE3z2nXUrd+SYiG5vUvRTciMZo7W/UwiwZGZEX+B81eO3VaI4y
         mIG8tj2Qe3aNjOrgNdVuNUhB5SdUHqk0QJI2Tq1gUUDEgz7xB/F0/D8ngEuj5DEvxelU
         NwnuRXgAbC3EZte32S9exZv5ccg4JoxT+4HM9pwfdOUZ0ueN291DckoBrW17nU9NagoK
         bi5iROT/hjrlLibzqUUbnHPqxfVu7CAgzOp9EnQNPgcJEvMyBIw+q4id2nDC0Tj19Uz5
         OjLbb3qr8Y1zEFELeQjxov6zFdXdnQHPF3j6ZaY3NqDFFNsmWocRsFnlxKeRqQJrrd2L
         WLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752959861; x=1753564661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MEp7Wf0O2C0g0O3vR40ys088xNOv/DqBtlHXQfu9wYc=;
        b=mbwYCbaEsR9VtWw+Nq73+4w64rSjJ0rlc5P+UtU1ZfOjmruNWNV8Bqq189ReuOrwCl
         jnSE3KUNwpO6QZ4wQNfDR+6Yv4Y1FTyw7lvanbVXlackw8U/gpItwoROmvCsrB7BDn3W
         xRFvHqjaxTXgvIZw7jFKrosrzm6rIotxeeDXixbyHXqyTY1+Nv7szF1lqhxq5PTMM6IQ
         Z8m9NhPcKCciLe9jyin8oRKwAAPOWG2hsnSgifIseSxTH6H1zSTvKLZUtrB1xxsfpnVy
         uzg3ySRMVEdLaSw/UE2WVCkl2B0IA5NPXtVRc8II3+VkCEtiNabmvh3uojNE/V28m1li
         0nkw==
X-Forwarded-Encrypted: i=1; AJvYcCUW3CE7I5BZIqHRoYyRU9jCPNWgtTdKHFGW3Z1YMOB6SFXzo6IJILamLmALx610+RNIOUjQGetJQZGP@vger.kernel.org, AJvYcCVK5ir1E0uPZmsQ16kbOpBp3E6FKVOSx0dN46dKAllx+Bl8AcpwfkIFUQRgcrLOyHhd9Y+Inu5kikn62Ho=@vger.kernel.org, AJvYcCWhvVzuar4kJnjV1h5Rcl7vgt8p7NC7/cgITGs4QlTvQKrAUjCfq1/zcIoSyE4ZFDiLOCjnhO+XCpsuLj5n+NY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkBc7spWp2OaT8oazDp3MZhfe0AIRq5ul/qjtG41zMpDi0nVwS
	Wh5rF7moDX8ciAhgY2U4AMqLgzt8wa6r3cSO6EIG24W89fv9VdBAzswwxVtLbamihbvF5IdfIX3
	iArIibBtZM5tm8USsfCrVKFeoSRGZjlw=
X-Gm-Gg: ASbGncs9E6fZcazQ7th7O38phs9HNvYWss8fD/yJsY6g66+J77seU67d8scjtw+mD8c
	YeEFFYSldhEh2OItQzCzpm5Lm4BpktBgy54p2Exb5mnpUv0d5YCiRprE8MSt1i0rd0cdzrvuj9J
	zf0BtxgzpGmG87OyQ9UAcIUlCmAH7n4NEJwwZ0Ko04/yzrmjJZrJ8x9YqDufR/Ssq2KkEzQSmLr
	CxbxKvWFR+DH1Erq0Q7EkXq6Uz05CCAejomFAUdCA==
X-Google-Smtp-Source: AGHT+IHXFphFe4euLN0ElLcp51Vb1Dg+FL1aRzGfRRPh7ThHYIqOXCUduLpaQKiyURhCFoKowSc4+0/F+DutBNFLH8A=
X-Received: by 2002:a05:651c:b0e:b0:32c:bc69:e921 with SMTP id
 38308e7fff4ca-330a7b12523mr22220551fa.9.1752959860488; Sat, 19 Jul 2025
 14:17:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-list-no-offset-v4-0-a429e75840a9@gmail.com>
 <20250709-list-no-offset-v4-6-a429e75840a9@gmail.com> <CANiq72kvYuoSSOruDQiEo5ppSDvtxSzQ4R6rxdN9RBkucBRuew@mail.gmail.com>
In-Reply-To: <CANiq72kvYuoSSOruDQiEo5ppSDvtxSzQ4R6rxdN9RBkucBRuew@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 19 Jul 2025 17:17:04 -0400
X-Gm-Features: Ac12FXzLIC8GWNX3bHP_PQS6NeSoHlnrb73ILutus--5bbT5RNqMTwdClHIjArk
Message-ID: <CAJ-ks9mJN37GZOr=fAN18yV+X4q+8Ah0qSQkOa23dRqg79_AOQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] rust: list: remove OFFSET constants
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 19, 2025 at 5:09=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Wed, Jul 9, 2025 at 9:31=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
> >
> > -/// Declares that this type has a `ListLinks<ID>` field at a fixed off=
set.
> > +/// Declares that this type has a [`ListLinks<ID>`] field.
>
> I was applying this series the other day, and I noticed these
> doc-related changes in the patch, which are appreciated (I think you
> did it to make it consistent with the other lines you were adding with
> intra-doc links), but I think in general it is better to clean those
> separately in a patch first.
>
> I am mentioning it because the docs do not build due to those --
> please check the `rustdoc` target for patches, especially if it is a
> non-trivial change.
>
> I also did another change to make the examples (in the other patch)
> build with the minimum Rust version. It is good to test that too,
> since sometimes that can slip, especially as the window of versions
> grow.
>
> Anyway, the examples/series here caught another issue with a previous
> patch, so that is good news :)
>
> Thanks!
>
> Cheers,
> Miguel

Thanks Miguel, will do in the future!
Tamir

