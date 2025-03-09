Return-Path: <linux-pci+bounces-23259-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83329A588EC
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 23:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC01188B3FC
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 22:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0712206B6;
	Sun,  9 Mar 2025 22:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eq8dfpLf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA68442A93;
	Sun,  9 Mar 2025 22:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741561093; cv=none; b=hKND+l0DNctUr0bdHxFqjIwaweXj5uP7pasqS+RjyTVG+TJwufKXItshVw2KpW/QyU0EhlstT0C1ftvQgCsuG9Qa5qGGQcn3K2g4foZ7yNQVwjWYSlrjperQqp97c+A5C8UGtWkiOkOj1ULosO1VDHuTOse3PoBFS/gHqxaGaI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741561093; c=relaxed/simple;
	bh=wvkUc42hPFWxQzCi87XYn+FmEj0IYv93TWp91k1aAjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUKhyERZLalqbUnn/RVzn9qxwUGob5gXwjjCeKXjnmdgqUVMbF6GRlKl9mV1/3B8ssGNKj+IFS2QPHBnCun3uq/NdCP/jyrZylh4O1unwJAdTYFZMyrorfa8ysRAttjtscI7kVQGjONlXXyxiQ63TeQJ8KPOLamnoMPHvJqtDKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eq8dfpLf; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-523f670ca99so479546e0c.1;
        Sun, 09 Mar 2025 15:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741561090; x=1742165890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CV2gOKsKlbj4j9gbHkJuaQwCeDFrffbEAAVvwDimsKo=;
        b=eq8dfpLfkpunLeMA/DWWv46fjl6IevGkBSe20Xik+nLkMXMnpSbhqurnk45qfMqWsM
         CyyHk74mGLoTTzHD7Pvg7aIZt0H2pXYyzducHnr33FLceK44ZewqlswVeQyKhSA6nvzc
         7ZLl8PSzsX2RUAwt0BoHUw8w/pRC/t9LzEhjk68yJIvS/ynGJ8pGGsA7PXYYlCJoFW6y
         C7Y6o68I/kp9Mh4qMG/P3B7CGh32sLeru47WDIXbEdaZ4xiaEa/4lOjAF/14mHkeR4E7
         bJscFVxPXOZAg3lT4fqWCZ/q+94kj/xTD3IObVXWSlIkve0/IKfAOfQ12Nlm6bakfUX2
         Mudg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741561090; x=1742165890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CV2gOKsKlbj4j9gbHkJuaQwCeDFrffbEAAVvwDimsKo=;
        b=pKi/+yWYilNYc7keEN4Ak/3VagLWYIwxW2Hp0xL5hEqjbOxrKoH/mOGvrSETXAvQnL
         /veZLcNWM3qIzJUgQ29Y/ys/EZohP3Hn25C5IaITAy+B4PDwKcRhVLLQY52jKgDD3uCb
         9IIwZoG8E84Nm2o0iAj70X32I65avOOJkghIhrgNkMjQC+a9tFm+6zaQvuK7n5SctSt1
         RrBv5IprfEk6tEmsX621VfVNdCBO4pkatyrYtY84u+0o9YizKoUmv6IcG9ATQpWNE20M
         Tc/buk+0rUMs7ESqYom4NPjbElXNJ8anBvV1KnaXtNHWp9ZCGWAyMHfV9LVx3tlRnK8I
         VP1w==
X-Forwarded-Encrypted: i=1; AJvYcCVUOvdtJ5qk8Od+dFWHFf1nlmzjPkJ2WCWMLlOdaGY6q9xXD54t8UgCwvLG4gKcf+VMzifk46d1mCY=@vger.kernel.org, AJvYcCWTdyW7tCzO9xikadcAHttdLd03Bbo3Om+tXrnLeuJpafWki/1oD5pKfBqwZZNEzaSAwjrzGTFEDfGp8PuV3PM=@vger.kernel.org, AJvYcCXOrucR0xxkkdYc0SA7Rss4jplZt0yAvZ1lFRMlVDJ3/bnZtsYqGUlle6Wqae4nBpADOC1mnQlJp833@vger.kernel.org, AJvYcCXeLSCSf7t6Ie6RQV9++4uWygz+34VG9YF07NaqBOJoQpNh5TQh6OJ10nxI1Qgx4nQNk7SQBS2YyinZJnKJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxhYsK8P2L7m1MP4jSA1XxW0GYAKh2Iq6GINJjsklmkiP735SlO
	uDKgSPiiWi1WI4Ph6pU6DUMGwiistrNVqVUgygAeGaqEUI4QKiyJFb4mpvIzp9/DsxaQG4MAtj6
	VNh7fhO2fuLDGmwvfSkyp2gidWpw=
X-Gm-Gg: ASbGncsH2E1pWr1cv/v3l2yQdwaaG2aCoMABQK6r1dap00VkqueGrp0G0QkGGPkYjQ3
	O1OQpTkbfpvRe7BliTbGoM9GMLTLqTCSIKq78280DzuDO/wqJvKlMAk5Vd2e4mmbXc/97mVq5Cm
	RHbjBk55aMLQUUxo5QzWnrXLp59eyJ+SpOYYZvnnvBDvvGULKAnUIwb0A=
X-Google-Smtp-Source: AGHT+IEwOoOMmFUjNxHNrfepI418l5Ifkn4uw4xRbHYTbtlLmbbH2E57rd0IT5s8haY8kJDHDKUPM8o5mbc5p45iZ0A=
X-Received: by 2002:a05:6122:2011:b0:518:965c:34a with SMTP id
 71dfb90a1353d-523e40c8aa6mr7396671e0c.2.1741561090461; Sun, 09 Mar 2025
 15:58:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227030952.2319050-1-alistair@alistair23.me>
 <20250227030952.2319050-10-alistair@alistair23.me> <2025022717-dictate-cortex-5c05@gregkh>
 <CAH5fLgiQAdZMUEBsWS0v1M4xX+1Y5mzE3nBHduzzk+rG0ueskg@mail.gmail.com>
 <2025022752-pureblood-renovator-84a8@gregkh> <CANiq72kS8=1R-0yoGP5wwNT2XKSwofjfvXMk2qLZkO9z_QQzXg@mail.gmail.com>
 <2025022749-gummy-survivor-c03a@gregkh> <CAKmqyKNei==TWCFASFvBC48g_DsFwncmO=KYH_i9JrpFmeRu+w@mail.gmail.com>
 <67c8abffd2deb_1a7f294d5@dwillia2-xfh.jf.intel.com.notmuch>
 <CAKmqyKORk5n_b2DUDfCVmttE4T+S-LQvcp0NoQD_O7D-csdEvA@mail.gmail.com> <67cb834117c15_24b6429474@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <67cb834117c15_24b6429474@dwillia2-xfh.jf.intel.com.notmuch>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 10 Mar 2025 08:57:44 +1000
X-Gm-Features: AQ5f1Jraag0X8uqn6eZ4prR62wfKovqGEuVYhObyXbvcIwNrW--XWB8Ar9rnjL0
Message-ID: <CAKmqyKMryu=u8KUCYEVBwcbrmND8OFipMMwwDohXZUZg9qOqaQ@mail.gmail.com>
Subject: Re: [RFC v2 09/20] PCI/CMA: Expose in sysfs whether devices are authenticated
To: Dan Williams <dan.j.williams@intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Alistair Francis <alistair@alistair23.me>, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lukas@wunner.de, linux-pci@vger.kernel.org, 
	bhelgaas@google.com, Jonathan.Cameron@huawei.com, 
	rust-for-linux@vger.kernel.org, akpm@linux-foundation.org, 
	boqun.feng@gmail.com, bjorn3_gh@protonmail.com, wilfred.mallawa@wdc.com, 
	ojeda@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, gary@garyguo.net, 
	alex.gaynor@gmail.com, benno.lossin@proton.me, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 8, 2025 at 9:38=E2=80=AFAM Dan Williams <dan.j.williams@intel.c=
om> wrote:
>
> Alistair Francis wrote:
> > On Thu, Mar 6, 2025 at 5:55=E2=80=AFAM Dan Williams <dan.j.williams@int=
el.com> wrote:
> > >
> > > Alistair Francis wrote:
> > > > On Fri, Feb 28, 2025 at 5:33=E2=80=AFAM Greg KH <gregkh@linuxfounda=
tion.org> wrote:
> > > > >
> > > > > On Thu, Feb 27, 2025 at 05:45:02PM +0100, Miguel Ojeda wrote:
> > > > > > On Thu, Feb 27, 2025 at 1:01=E2=80=AFPM Greg KH <gregkh@linuxfo=
undation.org> wrote:
> > > > > > >
> > > > > > > Sorry, you are right, it does, and of course it happens (othe=
rwise how
> > > > > > > would bindings work), but for small functions like this, how =
is the C
> > > > > > > code kept in sync with the rust side?  Where is the .h file t=
hat C
> > > > > > > should include?
> > > >
> > > > This I can address with something like Alice mentioned earlier to
> > > > ensure the C and Rust functions stay in sync.
> > > >
> > > > > >
> > > > > > What you were probably remembering is that it still needs to be
> > > > > > justified, i.e. we don't want to generally/freely start replaci=
ng
> > > > > > "individual functions" and doing FFI both ways everywhere, i.e.=
 the
> > > > > > goal is to build safe abstractions wherever possible.
> > > > >
> > > > > Ah, ok, that's what I was remembering.
> > > > >
> > > > > Anyway, the "pass a void blob from C into rust" that this patch i=
s doing
> > > > > feels really odd to me, and hard to verify it is "safe" at a simp=
le
> > > > > glance.
> > > >
> > > > I agree, it's a bit odd. Ideally I would like to use a sysfs bindin=
g,
> > > > but there isn't one today.
> > > >
> > > > I had a quick look and a Rust sysfs binding implementation seems li=
ke
> > > > a lot of work, which I wasn't convinced I wanted to invest in for t=
his
> > > > series. This is only a single sysfs attribute and I didn't want to
> > > > slow down this series on a whole sysfs Rust implementation.
> > > >
> > > > If this approach isn't ok for now, I will just drop the sysfs chang=
es
> > > > from the series so the SPDM implementation doesn't stall on sysfs
> > > > changes. Then come back to the sysfs attributes in the future.
> > >
> > > This highlights a concern I have about what this means for ongoing
> > > collaboration between this native PCI device-authentication (CMA)
> > > enabling and the platform TEE Security Manager (TSM) based
> > > device-security enabling.
> > >
> > > First, I think Rust for a security protocol like SPDM makes a lot of
> > > sense. However, I have also been anticipating overlap between the ABI=
s
> > > for conveying security collateral like measurements, transcripts, non=
ces
> > > etc between PCI CMA and PCI TSM. I.e. potential opportunities to
> > > refactor SPDM core helpers for reuse. A language barrier and an ABI
> > > barrier (missing Rust integrations for sysfs and netlink ABIs that we=
re
> > > discussed at Plumbers) limits that potential collaboration.
> >
> > I see your concern, but I'm not sure it's as bad as you think.
> >
> > We will need to expose the Rust code to C no matter what. The CMA,
> > NVMe, SATA and SAS is all C code, so the Rust library will have a nice
> > C style ABI to allow those subsystems to call the code.
>
> That indeed alleviates a significant amount of the concern. I.e.
> multiple planned C users makes it less likely that the needs of yet one
> more C user, PCI TSM, get buried deep in the Rust implementation.
>
> > The sysfs issue is mostly because I am trying to write as much of the
> > sysfs code in Rust, but there aren't bindings yet.
> >
> > So if we want to re-use code (such as measurements, transcripts or
> > nonces) we just need to expose a C style function in Rust which can
> > then can then be used.
>
> Makes sense.
>
> > > Now if you told me the C SPDM work will continue and the Rust SPDM
> > > implementation will follow in behind until this space settles down in=
 a
> > > year or so, great. I am not sure it works the other way, drop the C
> >
> > That was kind of my original plan (see the first RFC), but maintaining
> > both, with at least one being out of tree, will be a huge pain and
> > prone to breakage.
> >
> > Also I suspect the Rust implementation will struggle to keep up if the
> > C version is merged (and hence has more people looking at it) compared
> > to just me working on the Rust code.
>
> The practical questions that come to mind are:
>
>    Do we have time?:
>    I.e. How long can we continue to develop both out of tree? Presumably,
>    until the device ecosystem matures, when is that?

I guess that's a difficult question to answer. There are SPDM capable
devices on the market now ([1] and [2] for example).

While the ecosystem isn't mature, having something upstream makes it a
lot easier to build and improve on. For example MCTP/I2C/SMBus support
could be built on top of this series by someone if/when they are
interested. We are also working on SPDM storage support, which builds
on this. It is always harder to work with when the code is out of
tree.

The other big plus of having something upstream is it will encourage
vendors to test against the kernel implementation. Which might help
catch buggy devices before they ship.

Note that at the moment the C and Rust implementations are ABI
compatible and can be easily swapped out.

>
>    Are all users served by Rust SPDM?:

That's my hope

>    Once the device ecosystem matures can all architectures and
>    distributions get their needs met with a Rust dependency?

That's a good question. I don't have a complete answer. I do think all
architectures that are interested in SPDM (think servers and PC class)
support Rust, so that should be ok.

As for distributions, I also think every major distro supports Rust,
so extending that to the kernel shouldn't be too difficult if it isn't
already supported today.

The decision is really up to the kernel community if you are ready for
this. Note that this series can't be merged today as it depends on
some other patches which aren't yet upstream. So this is still a
release or two away from being actually mergable.

1: https://www.microchip.com/en-us/tools-resources/reference-designs/ocp-po=
wer-supply-spdm-solution-demonstration-application
2: https://docs.nvidia.com/networking/display/nvidiadeviceattestationandcor=
imbasedreferencemeasurementsharingv20

Alistair

