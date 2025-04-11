Return-Path: <linux-pci+bounces-25678-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAA0A85FD3
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 15:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2FBC3BB5D0
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 13:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE96B18FC89;
	Fri, 11 Apr 2025 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6regj8R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0AE2367B7;
	Fri, 11 Apr 2025 13:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744379829; cv=none; b=ARvE/hLdnrqd/cMoZ7lS/mWVqAqZ7UDMKpLNPZh7S8qztYfPWCeVGN5+di5AhqemHhzHyEtVhWh+lWTctzJViuJD4DB1/N7Aj1TG5qWsWn7D9mQM88QsgRcwb49Fji6PlHW8jlOxvmUtzs3/QowZbk4tYIg79xrtVX1vSQMjTMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744379829; c=relaxed/simple;
	bh=EHr3sP17GP2rT9bubWQ05YlLLA63mOf++HaX/JCjz2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ypim+9o9m8NWm5DFw+FE/J91TEyZcjLGbXSvX8RJ14nseVwLCpDlZDMvTddTtPm1RZ/Rkdoi9NCRx3sK3Ocwx1+uZn0FkYMgrA54rLL6R4SdWXQ/G1YC7EclPG+EY4pJZYBdC5TwfIAK8J2GrGC7qq7AthaKJNqa7JDl3sLtRuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6regj8R; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30bf5d7d107so16535431fa.2;
        Fri, 11 Apr 2025 06:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744379826; x=1744984626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0ok80ZSRCyKju0uCz08exJzHvXoR6NaXt2Z+ekMppI=;
        b=C6regj8R4uVoeTHievhfWvAjCjWRjhryRf3yN1MpDN22vyGH6gGPgK7/WlF/D+1Xrf
         A0xoYa57wUehuQtpEPpBN7uwPIc2TIieq90FbQC5yFlkCvfIzLifqXR6Tfc8Wb3ieA7Y
         lPEzT7yP4tczaBXjGowvrU0yZ1MtmIole+iJGyjny+EhOjDbCMaanuuBGqqZd4k874dP
         pSpVd3jvMXwKzk8aOmjYNN1FUUWHJ2OBYuLGIBUQIK/lqJt/ZHhSoSMK9Pu5ksLby+Wz
         COXWPxLZmxBfqyH8AGS3zrhYxn1qqFKqRfYXDIaaHjR/8PKsmJ1yBxICeteKAsRMBph2
         wkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744379826; x=1744984626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0ok80ZSRCyKju0uCz08exJzHvXoR6NaXt2Z+ekMppI=;
        b=qQbE6P1q6taYH4hCn8G7MAmPu/W+Oq1tl/WhAiFuA8HcXD7GvQwpnD/KpgHnjMAwi5
         HR67onIYkYKiWPxrokdM3Rk44B2+Ha9zMXW/ugWsC6GBf2WM6EhYKLlvshMN1mh/0SgA
         lqIfhue5BwHOVlSbuooPYSBgI1qRY2eSL94dQ1pRJpIRmhSneOHcKHjyz3X6c4em6gR5
         EKoHFj9nIvtlxL+Ux4oRcd0Ogs996kZHdlz4ZU3N/xJJOWNKiSdpYQU7KYORX3ZQSH/D
         YzwY6zTpRTuH92wcQO+P4VWLoRxKGS0ShZW+IOsybDMoesIHvcWEXP3mobEMgYEYFztG
         6arg==
X-Forwarded-Encrypted: i=1; AJvYcCVpPesI9DhzGUxmyESV7z5zK/u0zG5BOxGIFDqrsjVXeFi90OMmKoXCa3DzjU9cW1YPffWSTei2jM3dawY=@vger.kernel.org, AJvYcCW9yvjCsJXTRF/JdAQPbnK3dN+dzHFSj1aBP0knxbfVNKF0PJVvOretImM6sWSPS6J6i034IdGXhjkiCJP6DgE=@vger.kernel.org, AJvYcCXqah9Uiwmtd09lfRWs+kIhnp4XvQMAtljVhTgdpohG0+/ARWnhu3vo4oTnDxqzgjJTUsUkwI4wtUp3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4VftjNGRqoeBe45VM+Hc5qaW3v41U4nW0XB9WpC9IJw/HRCtJ
	684J79lrCmdiBLQL1Q2msKgl5FHSYm/AyPG41tzMTv0COKULNR1TMC5HiYvCCLgLzTlVpAIplHS
	OpyeWRhVeU6ls08cSJrubwn+mtk8=
X-Gm-Gg: ASbGncu5sWROkGkBgaa2z2rq6KZRME7IQPFyi2wIFc7zC6aATOe2n8ynAg8d3Zl8UJJ
	LyRUK4pbfmthMN3xVjv38XjOfvmzFHjo7jCznLa3UsYAQ1p1/UwX7e1Yv921YoGvMAhdX1g6YdJ
	JLja6TOS+7a5jyXxL1I8VpYIggnv4j3vtdDDqSWYJq7BP+zGuL+Yi6DBcZd9fu/lCNqA==
X-Google-Smtp-Source: AGHT+IGBOEIfPQcBcLGNI8B8t2buG2qyCkl07e+bDZ36eFeM5osRdU689Rog2YK5/bwFMtkYKvRRli/CrIyQ9ywcGXg=
X-Received: by 2002:a05:651c:1448:b0:30c:5190:b264 with SMTP id
 38308e7fff4ca-310499fb271mr10915891fa.20.1744379825590; Fri, 11 Apr 2025
 06:57:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409-no-offset-v2-0-dda8e141a909@gmail.com>
 <20250409-no-offset-v2-2-dda8e141a909@gmail.com> <Z_eMe7y0ixrBrHaz@google.com>
 <CAJ-ks9kms_jFEAHX9MnW1pUOyTeuFuyWwXk-A+qhCPQQNfJdAw@mail.gmail.com> <Z_jcjEtKZRpRi9Yn@google.com>
In-Reply-To: <Z_jcjEtKZRpRi9Yn@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 11 Apr 2025 09:56:28 -0400
X-Gm-Features: ATxdqUEDaQovMhot23oFo1TVInzFS-l1gpC5B1ahhOMK6wGAFHaYLD4oU7r3LQQ
Message-ID: <CAJ-ks9ka0sASqBdhFSv6Ftbd7p1KCBuy6v-2jNd98gDpyAgQGA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: workqueue: remove HasWork::OFFSET
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 5:10=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Thu, Apr 10, 2025 at 10:15:53AM -0400, Tamir Duberstein wrote:
> > On Thu, Apr 10, 2025 at 5:16=E2=80=AFAM Alice Ryhl <aliceryhl@google.co=
m> wrote:
> > >
> > > On Wed, Apr 09, 2025 at 06:03:22AM -0400, Tamir Duberstein wrote:
> > > > Implement `HasWork::work_container_of` in `impl_has_work!`, narrowi=
ng
> > > > the interface of `HasWork` and replacing pointer arithmetic with
> > > > `container_of!`. Remove the provided implementation of
> > > > `HasWork::get_work_offset` without replacement; an implementation i=
s
> > > > already generated in `impl_has_work!`. Remove the `Self: Sized` bou=
nd on
> > > > `HasWork::work_container_of` which was apparently necessary to acce=
ss
> > > > `OFFSET` as `OFFSET` no longer exists.
> > > >
> > > > A similar API change was discussed on the hrtimer series[1].
> > > >
> > > > Link: https://lore.kernel.org/all/20250224-hrtimer-v3-v6-12-rc2-v9-=
1-5bd3bf0ce6cc@kernel.org/ [1]
> > > > Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> > > > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > > > Tested-by: Alice Ryhl <aliceryhl@google.com>
> > > > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > > > ---
> > > >  rust/kernel/workqueue.rs | 45 ++++++++++++------------------------=
---------
> > > >  1 file changed, 12 insertions(+), 33 deletions(-)
> > > >
> > > > diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> > > > index f98bd02b838f..1d640dbdc6ad 100644
> > > > --- a/rust/kernel/workqueue.rs
> > > > +++ b/rust/kernel/workqueue.rs
> > > > @@ -429,51 +429,23 @@ pub unsafe fn raw_get(ptr: *const Self) -> *m=
ut bindings::work_struct {
> > > >  ///
> > > >  /// # Safety
> > > >  ///
> > > > -/// The [`OFFSET`] constant must be the offset of a field in `Self=
` of type [`Work<T, ID>`]. The
> > > > -/// methods on this trait must have exactly the behavior that the =
definitions given below have.
> > > > +/// The methods on this trait must have exactly the behavior that =
the definitions given below have.
> > >
> > > This wording probably needs to be rephrased. You got rid of the
> > > definitions that sentence refers to.
> >
> > I don't follow. What definitions was it referring to? I interpreted it
> > as having referred to all the items: constants *and* methods.
>
> I meant for it to refer to the default implementations of the methods.
>
> > Could you propose an alternate phrasing?
>
> I guess the requirements are something along the lines of raw_get_work
> must return a value pointer, and it must roundtrip with
> raw_container_of.

What is a value pointer?

