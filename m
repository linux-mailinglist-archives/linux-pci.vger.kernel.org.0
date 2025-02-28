Return-Path: <linux-pci+bounces-22610-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771B2A48E95
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 03:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BECC7A849C
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 02:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CAA12CD8B;
	Fri, 28 Feb 2025 02:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8swovPk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B15925757;
	Fri, 28 Feb 2025 02:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740709685; cv=none; b=DPiw4sbd97v0G4mjtIiSds4YimkIOrBB/NRiR6s2qBej6WHTeReuSLhxVGIJ6MUhXu2IpjALSQ9VxoCFVCKGtTg53xCfSZwUQNiIYQxTFAM8446DvBO8HW86kHaQ06nTMMwBw5wO/RanjWmz4cv2N/OXDMBUegN0qS3gU2k4kto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740709685; c=relaxed/simple;
	bh=aDVkzuDCBgq4xYPepBaFXsSK789trfyEWC75waTnaFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cT8gg69cXjSrLujx0gGfZuEVyj5rhq9SyDgRpfxg+yqZ+ZACkLfL74WvAFwsuJCs0Uu0xJQy6yZRQ7LxzJ7Lrh3aQwHZkseAp1F2vhvGn13iEMOEiy9bQxSPmT7fwgRBuMwge5WDfHI5l2pVnHu3X3mK33z8C27MMHTe5b1IVW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8swovPk; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-86911fd168dso655235241.1;
        Thu, 27 Feb 2025 18:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740709683; x=1741314483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6CtTLnUlZkpeEsnmmvTInGqChea3z0s5g1Y+wiPVGI=;
        b=I8swovPkcGi60M3D10k1EixTXkLlkLQfm+3MgLQGCfwoQ1U6v/+kAPm8eHMcs4WBjt
         MX4OPnKkhD3HbDw69O7DeNPsMLBaoOTrYc/3ESsG33fv5T5NytEVc5puth3+wG7w1g/v
         klDEpvlKVOcRZBuA/uwZ5lrLCr1q+hA7AXK59AM5o1NSF1vNsCxdYdJHbhyHEDMFXuai
         FPLzaVs9ySfjoei0WbsOP97nx36xd0Q9YGdM3H6rG4cAcBw4wPXuRV+jyq/+MttQvQQI
         +gkG0H32j+btwYelggvNxCM25SzetWKRrxRJbzna9UvmKxzuhEAHyWjlHECGfNayO+dL
         FxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740709683; x=1741314483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6CtTLnUlZkpeEsnmmvTInGqChea3z0s5g1Y+wiPVGI=;
        b=eBf/ZrafjKWsr0uPpnZGH6L9xTX0wRyoOZfK83vF+YVld4U9umTVVTj1IvaVM/GSXS
         XLDpkl7g38R+n0i0p2pwXSTHGrtLXv0jmaKcBczW9U9rpibfdN4kEe5e4fP+YPIhCHmj
         1zl6ty8QbRXVZ0GGZSDmQijo0FeOwYlWdwVVkosxNZ8vRClkWka9iZbjkwwvCNkHCdp/
         1Z79DhAoGEFHj8PwWSRyPLbrMAyWdae8UZJOBhA+C73q6iOWqVYH5sckgO+UrEmCachP
         3t813EHji78RpgQB8YbIftUSJXBkifihoB/6fCbF8vwMIqVn82U5fSKb296zahf0EL+7
         5OYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUVJMn4psZbrytNML4aWfJNudqRGBpHIqeMvATyxzmgUZCFIv5LflxWla9csh+OjIf+iR7osOmQvsMHpks@vger.kernel.org, AJvYcCUzbazAz7Z+IpXIWyEHN7IeoVM9E86fWpNjsh/TB40RqBT9z+E6F3SZgWcNZZlHaP2b4qj20o65zzJn@vger.kernel.org, AJvYcCWBuBC10hjK2TN0uqx/3PjuPxBLvTbvyW1P1umvsrBe3I6ZyAx5CHY3mICVqQ7l34xTIKfJ3/8NMhY=@vger.kernel.org, AJvYcCXHVQ2+lzvu8LzjJrxP6qP5m3KXYRUMP2X1So6/SPv3D6ekjqz8MkQn9Q5mCM5K1rEBk0FgD5GHJwt9sQuS+bI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwjuFZV2KXyvx2SU27CQEQ7LM/qs3lqynD0hxEZCeCRom/5G8+
	pfH6MUFAaB7Y0NYdnhtHjg0eVb1XiBYMhkyfpY3ofVoneNvI0CcSscrJGpLXJPHUGha/78l+C2D
	B9QZiL+KbNRu9ZcoQ0p04W+zEOY8=
X-Gm-Gg: ASbGnctpyFOhXXAj0exEJl9WoasPA6dBYDNTILx2EHxZif2yO2ogY0BnEvWwE615eYC
	qXonnuT6/UnqfwRXT4U3kUdvbzz9ztbNzeBrlgZ6pZ4r4GSWmjVReN76IBL0QhVofYdFuwd0GOc
	HyUrrMb5Dh8VYwXj9jZmiHEB+2kr2PUx8AlcKR
X-Google-Smtp-Source: AGHT+IHYxnsFG3B8+nagcRcL/Ba9q8piG9tBUzdtcgwFD+X0mUW7p1c/rKHvh5LhmTEiiTQ4vIZpmlSGKwXsalm1f48=
X-Received: by 2002:a05:6102:1512:b0:4b2:c391:7d16 with SMTP id
 ada2fe7eead31-4c0448b9b00mr1397468137.7.1740709682893; Thu, 27 Feb 2025
 18:28:02 -0800 (PST)
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
 <2025022749-gummy-survivor-c03a@gregkh>
In-Reply-To: <2025022749-gummy-survivor-c03a@gregkh>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Feb 2025 12:27:36 +1000
X-Gm-Features: AQ5f1JomfSVKBqp82WCWYnRIwxFU_ExnTkp6XsHs-orkc52LW_GeuvuLpBHWN7k
Message-ID: <CAKmqyKNei==TWCFASFvBC48g_DsFwncmO=KYH_i9JrpFmeRu+w@mail.gmail.com>
Subject: Re: [RFC v2 09/20] PCI/CMA: Expose in sysfs whether devices are authenticated
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Alice Ryhl <aliceryhl@google.com>, 
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

On Fri, Feb 28, 2025 at 5:33=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Feb 27, 2025 at 05:45:02PM +0100, Miguel Ojeda wrote:
> > On Thu, Feb 27, 2025 at 1:01=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > Sorry, you are right, it does, and of course it happens (otherwise ho=
w
> > > would bindings work), but for small functions like this, how is the C
> > > code kept in sync with the rust side?  Where is the .h file that C
> > > should include?

This I can address with something like Alice mentioned earlier to
ensure the C and Rust functions stay in sync.

> >
> > What you were probably remembering is that it still needs to be
> > justified, i.e. we don't want to generally/freely start replacing
> > "individual functions" and doing FFI both ways everywhere, i.e. the
> > goal is to build safe abstractions wherever possible.
>
> Ah, ok, that's what I was remembering.
>
> Anyway, the "pass a void blob from C into rust" that this patch is doing
> feels really odd to me, and hard to verify it is "safe" at a simple
> glance.

I agree, it's a bit odd. Ideally I would like to use a sysfs binding,
but there isn't one today.

I had a quick look and a Rust sysfs binding implementation seems like
a lot of work, which I wasn't convinced I wanted to invest in for this
series. This is only a single sysfs attribute and I didn't want to
slow down this series on a whole sysfs Rust implementation.

If this approach isn't ok for now, I will just drop the sysfs changes
from the series so the SPDM implementation doesn't stall on sysfs
changes. Then come back to the sysfs attributes in the future.

So the high level question, is "pass[ing] a void blob from C into
rust" ok or should I defer for a future safer implementation?

Alistair

>
> thanks,
>
> greg k-h

