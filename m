Return-Path: <linux-pci+bounces-23081-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9315A55C9A
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 02:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1015A16725A
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 01:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA99F40C03;
	Fri,  7 Mar 2025 01:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sv3S7TzU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3095B28FF;
	Fri,  7 Mar 2025 01:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309492; cv=none; b=f4/0rBMk4PX4xev9b2jdc+oB2DSbUpmh4F7BwdrOJwGa+i7jblr1NVDw+VBHbG42ZxOP70BbGJOCVpXjVrVt6ElJHYronf84KgDeJYe22bnGBxEUdfVLAQcT1AdLH+55fmnjssbGbZUC4aM8gVBBR9cryyEHsmXanYpqJVL2V40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309492; c=relaxed/simple;
	bh=oDrfQqiYXqiLn0JVeuGrsRgK5P6HmYH2KIyp8Qky3l8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cHNTmahksGO40wc4iEY7oN5Nuh4GeIoJue7XxX5aKhU4mqO5FSC2s6klgFxMitY65Dpg0l8hgG69M865hBUEmVAYSbGbOF+3V8+7z1iwPvgOjEZBlHy/3vvqR6qqO9Wq2orIhwgj5GH0Q/IhHrQUY352ErnbOw4KGJHJGqHT9jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sv3S7TzU; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-523dc3649edso384670e0c.0;
        Thu, 06 Mar 2025 17:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741309490; x=1741914290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpgNsP0RsTTpLOpERJI2CJLUOC16l+9Hasgl+r3eevc=;
        b=Sv3S7TzUlpMolCGk33QawcMxtKNbctN5ntahHoTZupguBRmyKStq7LoZt2QxG1WEZA
         NGJaiqQh1MKp0x+U3F4m9H1klNathg/GU87K1+V2h+lDOzmRabfFiMoZg7ZcQo2hyW4b
         a+ifR8SauPKW+g4FiuqNFCMUMmojZklMw4edDwWFyhoAapScO4OUw2u1ADS6KV7FHG0Y
         I0jDTiDqIluyfjW+4dH86UAYdfeZAj+bLSJvJy4+25BRq6UYvMeUul3jltd+8s/oaGLS
         K5JRIkhFeQCFPmJAttLDA0LBXmMVq+4jTvORlOXWXJiKJTRMvKlde2DSwo3KA1Vzgl3n
         l8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741309490; x=1741914290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FpgNsP0RsTTpLOpERJI2CJLUOC16l+9Hasgl+r3eevc=;
        b=F4J2APvnxDvSyYhMX3xITMYmz1cjh911J0ZDMV/1NKqicactEOr7/J2hcdCh4LVKVH
         iI4hudq7TKlbEG2EI4GnFAZQmV8zA5ANNbQ6/a/6UjC4Qsn+ZevXf+BDF1840bOYH/N/
         EiEh3ntJE5gjBV6dRjMsHaf7FnmtD2FU8gYM6SAWUHvEvdq154DLQqVa4NWeSLyiIa8l
         HpbWbNlqzCJNbgvZU9361Nqe7PG1I7cvJb7GuIVLKfwQ93M/z4czv8MAOeStJOGKVxoR
         3eiVKKYhFTWCdf4Y5Os9HQmjuW4Okg1SV+E7pHNZeGPmHuXZN33MLKK/8O6XDexSxBG+
         ecWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjy5NiK5L1+GU5rR9LcgfUuI3O4RrvPe/DrRfu57wlzhIjAA4I42QonR40y6yye9qnNvPI+WxFx342+Q8lmBY=@vger.kernel.org, AJvYcCWHKZjFHCU8NpzAJX5o5SU/l2ipoMn+GKHBKHSaHa7Iu6pkx6HCjT+qvMFmCIHahdGgoK9oSxhxr5s=@vger.kernel.org, AJvYcCWpA/gxY1lwtlvkg2ip3hBjUJoM9kYs+Xtkhgu+jgOH5DKiUGcxsBetcFnFPRubIO1oepoCgOcesdvU@vger.kernel.org, AJvYcCXUW3ZC70C60UtKOCgrRtK2fBrIVWhDN4Gub7/ad4lWNOk9kI3IVguXcPYy9Mp7vDMN8i+u4bxDer68P2mB@vger.kernel.org
X-Gm-Message-State: AOJu0YzNTKgKKdUg5IxP/sm4mhXq3lOkMWUPpRGtMYjgiXrM0qkktRkR
	hUo0z46vPWIUJ4anDcLuGeei7i1zrVtbdtXSFGoRRxHy3i+H2Y0CUJlHAGuhd05Qzd7QLmjKL1Z
	/tYUgIzAy6E9hcTktp44eDP9K2es=
X-Gm-Gg: ASbGncvWtN2BiuzHsGqFzYKKfYklVna+AJ5oT1oUOhHLoNSihWV2+1tuR+tfd8TubQB
	C0RcSgBClojC521uWTmMGHYzT3md+3D2fkdD6B6H2AlWoJ1A0YTqJsd3c6rMDSM+nuUzW6MjsLD
	kRQSjlu478ZZaMpTyD+bxgloA9FODQs5BugmYLWHwFFoX62kMq9lW6JCeJ
X-Google-Smtp-Source: AGHT+IGbwmafUFC0g3M/wodTSstZb8EnCAH6b9gBxI+jfvUYZxWjuOY7Y5eVL2Cn7rIG2fpCOUE53vdi5hXO2D0kVEU=
X-Received: by 2002:a05:6122:c86:b0:520:6773:e5bf with SMTP id
 71dfb90a1353d-523e3ff02fcmr1565400e0c.1.1741309489887; Thu, 06 Mar 2025
 17:04:49 -0800 (PST)
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
In-Reply-To: <67c8abffd2deb_1a7f294d5@dwillia2-xfh.jf.intel.com.notmuch>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 7 Mar 2025 11:04:23 +1000
X-Gm-Features: AQ5f1JqcTJhjy1IWJHBHvzqfhRy4UX4pT0bM7wOi79bttO_uR-yCHqTUQrbxBnM
Message-ID: <CAKmqyKORk5n_b2DUDfCVmttE4T+S-LQvcp0NoQD_O7D-csdEvA@mail.gmail.com>
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

On Thu, Mar 6, 2025 at 5:55=E2=80=AFAM Dan Williams <dan.j.williams@intel.c=
om> wrote:
>
> Alistair Francis wrote:
> > On Fri, Feb 28, 2025 at 5:33=E2=80=AFAM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Thu, Feb 27, 2025 at 05:45:02PM +0100, Miguel Ojeda wrote:
> > > > On Thu, Feb 27, 2025 at 1:01=E2=80=AFPM Greg KH <gregkh@linuxfounda=
tion.org> wrote:
> > > > >
> > > > > Sorry, you are right, it does, and of course it happens (otherwis=
e how
> > > > > would bindings work), but for small functions like this, how is t=
he C
> > > > > code kept in sync with the rust side?  Where is the .h file that =
C
> > > > > should include?
> >
> > This I can address with something like Alice mentioned earlier to
> > ensure the C and Rust functions stay in sync.
> >
> > > >
> > > > What you were probably remembering is that it still needs to be
> > > > justified, i.e. we don't want to generally/freely start replacing
> > > > "individual functions" and doing FFI both ways everywhere, i.e. the
> > > > goal is to build safe abstractions wherever possible.
> > >
> > > Ah, ok, that's what I was remembering.
> > >
> > > Anyway, the "pass a void blob from C into rust" that this patch is do=
ing
> > > feels really odd to me, and hard to verify it is "safe" at a simple
> > > glance.
> >
> > I agree, it's a bit odd. Ideally I would like to use a sysfs binding,
> > but there isn't one today.
> >
> > I had a quick look and a Rust sysfs binding implementation seems like
> > a lot of work, which I wasn't convinced I wanted to invest in for this
> > series. This is only a single sysfs attribute and I didn't want to
> > slow down this series on a whole sysfs Rust implementation.
> >
> > If this approach isn't ok for now, I will just drop the sysfs changes
> > from the series so the SPDM implementation doesn't stall on sysfs
> > changes. Then come back to the sysfs attributes in the future.
>
> This highlights a concern I have about what this means for ongoing
> collaboration between this native PCI device-authentication (CMA)
> enabling and the platform TEE Security Manager (TSM) based
> device-security enabling.
>
> First, I think Rust for a security protocol like SPDM makes a lot of
> sense. However, I have also been anticipating overlap between the ABIs
> for conveying security collateral like measurements, transcripts, nonces
> etc between PCI CMA and PCI TSM. I.e. potential opportunities to
> refactor SPDM core helpers for reuse. A language barrier and an ABI
> barrier (missing Rust integrations for sysfs and netlink ABIs that were
> discussed at Plumbers) limits that potential collaboration.

I see your concern, but I'm not sure it's as bad as you think.

We will need to expose the Rust code to C no matter what. The CMA,
NVMe, SATA and SAS is all C code, so the Rust library will have a nice
C style ABI to allow those subsystems to call the code.

The sysfs issue is mostly because I am trying to write as much of the
sysfs code in Rust, but there aren't bindings yet.

So if we want to re-use code (such as measurements, transcripts or
nonces) we just need to expose a C style function in Rust which can
then can then be used.

So I don't think this really limits code re-use. Obviously there might
need to be some refactoring to share the code, but that will be true
of C or Rust code.

>
> Now if you told me the C SPDM work will continue and the Rust SPDM
> implementation will follow in behind until this space settles down in a
> year or so, great. I am not sure it works the other way, drop the C

That was kind of my original plan (see the first RFC), but maintaining
both, with at least one being out of tree, will be a huge pain and
prone to breakage.

Also I suspect the Rust implementation will struggle to keep up if the
C version is merged (and hence has more people looking at it) compared
to just me working on the Rust code.

> side, when the Rust side is not ready / able to invest in some ABI
> integrations that C consumers need.
>
> Otherwise this thread seems to be suggesting that people like me need to
> accelerate nascent cross C / Rust refactoring skills, or lean on Rust
> folks to care about that refactoring work.

I'm happy to help maintain the C / Rust code and help refactor as
required. The current ABI to this library is all "C style" Rust to
keep it simple and easily compatible with the out of tree C SPDM
implementation and callers of the code.

So hopefully it doesn't require much Rust knowledge to refactor the ABI.

This is the type of feedback that I wanted to get though. Before this
goes too far is it something that is going to be accepted upstream?

Alistair

