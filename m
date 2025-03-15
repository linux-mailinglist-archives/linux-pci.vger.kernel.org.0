Return-Path: <linux-pci+bounces-23850-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C30A63154
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 19:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9EF18924A1
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 18:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF20B204F8C;
	Sat, 15 Mar 2025 18:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJeNttz5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08701FECAD;
	Sat, 15 Mar 2025 18:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742062408; cv=none; b=KCBTNkis2iHORf2z9tp0yO67onX5lMDyvHNO8c1DM2gicjF2M+ITfIPskX3Vcnt0gdCDJSd3A2+4HAOfVn3b+Hbttk5Jb0FWQ70biPw1Td1Zli9w46/a96sZ2ecNpoEnVIi9brFS8thycSQhd8cchdfypXiThcMGcQtPD5RZ5XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742062408; c=relaxed/simple;
	bh=j3l0CwRAA7jzKYQesrIbEeXl2+YGefTcqALSuRxhtJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g0Q5tf0HlqTytRZEZZJaXhVprLxBpbLvbI2SK+zNEIUTB9KDK6UVaBb5EFdWb1KnkKa/QOYosx5F368ggdX70+UkCoJ8PBgXbKMWf2knZDRr0+xZDjvcWynh72NQ9q0dHF6Mvx05g04pYpBPsgJIdkoVCSg7lRuRAimhOc4QDp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJeNttz5; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-307c13298eeso36054631fa.0;
        Sat, 15 Mar 2025 11:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742062405; x=1742667205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fw7G1r38bDsOV/Hp+FePWmAtnNh1LoMrSS/+4/QiIfA=;
        b=kJeNttz5/Az//QSyIn1onLfEzNw7Z6ajsRfBtX1KYGFySqF3p8+nYyL01pcyKWNmIU
         KqbG5ZZYTnntc9iYOaCzGy2X+/p5MMS/r16YImeYOZh7Zm+IXNvPfO2+IrHbWLF2VyhR
         kvJUJ76N5MzH1zdOMY2WyI6KZKdlRTdHFmzzmAaOvNKRwm1F4VOLau03AMBNnFu+PAbI
         QUNlisPBtSRi8eweO4zW9EdoWRfaNb3JoxiL7+LamU7uOgcYlSbYXrZ/9k0sSdpDBbyr
         q7Gj8I4JUNcrpwJElvjDRjaLuerp8gYG6+QDRWLI28OzPhT68ab9Z3Dul/IkMpMB+gO0
         tACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742062405; x=1742667205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fw7G1r38bDsOV/Hp+FePWmAtnNh1LoMrSS/+4/QiIfA=;
        b=etQFM2W8bUEf+jZi1xtjivkV9omYjxgyatq35AGKJ9PYYsSLiOWF/joR5fzCC+M3FS
         u1ORa1D3HCJnhQRBVeAxJAwNJ6sO0TlI7ux/X46DCwSfg+DaWVZ//0vXasOtmhh+ueI+
         Zcqd5M57Nb15w5tkIzCNTf4HGy4vY/bFro8xE4nbwNPrV88pjKw6DAqhlBjccv8sjYEH
         99xBHbbYcP3vvNDWA1bjcavwbqNC2rslg6BtAMPTI/N1BvUC90zv9EO1b+d3W/ZPlZKh
         vFzjJB6BKvFarv1vJZl6gCxdHzGAmurH2KdayfmV4QnSYmtRETclvGtlbT9Vb6S/7A9m
         P3ow==
X-Forwarded-Encrypted: i=1; AJvYcCUEas5RSaatlburOehfNU9bqw/XoI0Z0Lj+x0+INpeIj5SqX2jIo+hss8ci++MHFdwDhoQgk5vAGqWndbyU3SU=@vger.kernel.org, AJvYcCUkPfRKF+cEXla2WaCfglCpTq+udQSWuQupV2tK4n1gTG0aiEdcfGFY+8L/SmSWqWOabMaC7qFYYq4o@vger.kernel.org, AJvYcCVz3LEkLG97tNNp44w7leVU636rIFa68p+t6xGilppq3hMW2yDKHd/iv5E2TpnVIPoBgYvYJ/RqirTE7jY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWZU+Q4v/H5Ae+nxRUXTYlOUwYeHyWiUdYSC8XaAwO6YpEFFGi
	QVRjEwtcDrvIPe22RfkU/q8vo9vuLV6TvEwFuvfcV6fdGZrZF6mmkqhp2FgUD4Gj41RVS+vh85H
	B0kCZ+R3Ij5ePV4vEvKzbFyML7Ps=
X-Gm-Gg: ASbGncvw9YYc+QO3qblTYKsHL9genC0kFmSmkhXucI1GP+p+Jn60orEhNajxI+TmcVS
	6X/gKTWVy2TAGf5HOt5114ZIN4l0Zf3fuAXPdGn/SyWbkfmxc6uhzT/MJVeDNTVK5x2/I0Nfg6m
	g6yrOZZlsh+9Lw4BD2oviebAsjIK4ifTuZKFcKJyB+TTa+zoIyo3+MeGD2c3Vb
X-Google-Smtp-Source: AGHT+IE0KAjbxCNTic2NO46G6ymGqtVgtOfyw7GNav0dyFztDRa2jv5OYpU6S/JmdNaLeStQlEXiGai7YwJdGALS1bo=
X-Received: by 2002:a2e:8310:0:b0:30b:e73e:e472 with SMTP id
 38308e7fff4ca-30c3de17df1mr38383941fa.14.1742062404658; Sat, 15 Mar 2025
 11:13:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-no-offset-v1-0-0c728f63b69c@gmail.com>
 <20250307-no-offset-v1-2-0c728f63b69c@gmail.com> <D8G8DV3PX8VX.2WHSM0TWH8JWV@proton.me>
 <CAJ-ks9m2ZHguB9N9-WM0EsO5MjaZ9yRamo_9NytAdzaDdb9aWQ@mail.gmail.com>
 <D8GQGCVTK0IL.16YO67C0IKLHA@proton.me> <CAJ-ks9mUPkP=QDGekbi1PRfpKKigXj87-_a25JBGHVRSiEe_AA@mail.gmail.com>
 <D8H1FFDMNLR3.STRVYQI7J496@proton.me>
In-Reply-To: <D8H1FFDMNLR3.STRVYQI7J496@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 15 Mar 2025 14:12:48 -0400
X-Gm-Features: AQ5f1JpCmV5HSBwmMBPR0tcNsqUNJYUMxZ9jOJqxNmNvCYCRpdj1FogTkOAVT1s
Message-ID: <CAJ-ks9m-ab9Y5RD01higxZxbowZi_0tsSmCCw2umJLxBLH4dEw@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: workqueue: remove HasWork::OFFSET
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 2:06=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On Sat Mar 15, 2025 at 4:37 PM CET, Tamir Duberstein wrote:
> > On Sat, Mar 15, 2025 at 5:30=E2=80=AFAM Benno Lossin <benno.lossin@prot=
on.me> wrote:
> >>
> >> On Fri Mar 14, 2025 at 9:44 PM CET, Tamir Duberstein wrote:
> >> > On Fri, Mar 14, 2025 at 3:20=E2=80=AFPM Benno Lossin <benno.lossin@p=
roton.me> wrote:
> >> >>
> >> >> On Fri Mar 7, 2025 at 10:58 PM CET, Tamir Duberstein wrote:
> >> >> >      /// Returns a pointer to the struct containing the [`Work<T,=
 ID>`] field.
> >> >> >      ///
> >> >> >      /// # Safety
> >> >> >      ///
> >> >> >      /// The pointer must point at a [`Work<T, ID>`] field in a s=
truct of type `Self`.
> >> >> > -    #[inline]
> >> >> > -    unsafe fn work_container_of(ptr: *mut Work<T, ID>) -> *mut S=
elf
> >> >> > -    where
> >> >> > -        Self: Sized,
> >> >>
> >> >> This bound is required in order to allow the usage of `dyn HasWork`=
 (ie
> >> >> object safety), so it should stay.
> >> >>
> >> >> Maybe add a comment explaining why it's there.
> >> >
> >> > I guess a doctest would be better, but I still don't understand why
> >> > the bound is needed. Sorry, can you cite something or explain in mor=
e
> >> > detail please?
> >>
> >> Here is a link: https://doc.rust-lang.org/reference/items/traits.html#=
dyn-compatibility
> >>
> >> But I realized that the trait wasn't object safe to begin with due to
> >> the `OFFSET` associated constant. So I'm not sure we need this. Alice,
> >> do you need `dyn HasWork`?
> >
> > I wrote a simple test:
>
> [...]
>
> > so I don't think adding the Sized bound makes sense - we'd end up
> > adding it on every item in the trait.
>
> Yeah the `Sized` bound was probably to make the cast work, so let's
> remove it.

It's already removed, right?

