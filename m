Return-Path: <linux-pci+bounces-24326-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE724A6B995
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 12:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FAEE3B5021
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 11:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01D3221DBA;
	Fri, 21 Mar 2025 11:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzmskxDV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040C81F17EB
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 11:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742555303; cv=none; b=opvumGQmnVXgXVh4pysnCrvGo0N/rMoOi0LfWrEZ9CI9g7sG2f1283tqE1Nf3eGlSboiHk/aekxoB/JpDUuq76ZFetkZp97uPmH3PJExW7G+UOn3Gnaf6meyQ5/KM5VOV21PANUwTVbzDzp5bMkKLcRRYcYKNow6VWCxBnZWvQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742555303; c=relaxed/simple;
	bh=7bc628Z4PonYIE6kopilVDzsej3C/o4EesCgsahGMXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jkkATY56LEM6FHfm3nU4fpKw0eiP48t5/vw7azFWhlkDHrxcRnJ7dwfQALyZG3Iyolv5y3A2YX247kNR2NigBnKju3s1sePCCJq8ulR8V23mRdDccVQYs6lFwRT7htZ41JGFVmlzOqPlXGtWi7BNI+my+emAgMuwIscWs7wQvzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzmskxDV; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5fcd61e9bcdso838009eaf.0
        for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 04:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742555301; x=1743160101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ikECWpVR9pmsaY1bt5n4CogoNQJV/rXxHOwploessU=;
        b=OzmskxDVENci2vMuVgB4Alz9tk/zHcKXIJvZs7mLUvKaNHEHu/WDDbVyJAScyiIe6r
         cGEaQh+kg+8JcJcFFr0tJYt0YHVVajZiZWLVHY9q4VnFjq/mZq19QYcCXQiwfG/Y8yLF
         qZRiSge7N8ntG74oVzE/9oSTwIEy4QJzObay8P26nLNG+RHZhKm5galQn/tDrtxyz+ME
         Y48woDhEhJxo7sdIsdkHfIqOnba95yuohi+S1FRpqLevxFR6HmllHNXsb9lZQCCxMC2J
         NPKcuuBaZKv1IPQ2DCrJKZnwI9r1j8j2jfBNZa9fkBrwveuNZyGOnmg0IPKO/CoZ8hD4
         cd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742555301; x=1743160101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ikECWpVR9pmsaY1bt5n4CogoNQJV/rXxHOwploessU=;
        b=NWKVDRMEhm59K7uGoXmY4C5G2axPrdXQPL3VpXUHcpKYhKwLsdl0JRJpOG6WRG5X5j
         2Re2pRb42epUd1Ff8Hjk8jEcwkBKijIfZyQsxKJaVA/tY6/ftzYulzmsFuHMf66uUeon
         5eCszQnS7nj6qEwaf6HM6gRPOZTnL11pLoPG6lA1BZtpisRdEOhdf8Vf43IcwWXzeKxa
         ZYnghz+W+vaLENkg2vPM13CBm/Czqn0Y3ADdBDkz27WYQMmf6szmQQguX5Bqe1z0pfBs
         tFcM9rbtMk9FdApZOhGtOGZ2sBtoikjgqrwvOwGQcO8LLwnva0S6XHtPb2G3j6QUh89B
         /XPA==
X-Gm-Message-State: AOJu0Yypde7nS7YkB4v0rDf14MTyDXVf08MXK8nZKEfQw1SavrKeRasp
	mb7gB7QbuDs+SxY/tNfLxPdFODMRQYdqrB0EaSSy5CB8zGKZkEsOMBeQqORAkAmsrDQo0dW6Juu
	6jZM4FOFwMoUHMG4XUc3XWqnIQhLjB+Vi
X-Gm-Gg: ASbGnctUAd88qqoS3qptvA3hOi0whoSw7g5Nr/lg/+ZqJyPwkuZYV6sN31akHn0nIh1
	/yoD4OWn/y/XozYGtPkLUKEkM98V2RZ6h/AGqaBOxTqdD9I6q62kTghKa1y0GAwspfcyYYv04v4
	Bxq4AWfTHUJDgQxQ+UyPyws7m0eF0=
X-Google-Smtp-Source: AGHT+IG9agDh0W9f5b7k+1NbpfNSZp3d5RrV6rTg8pztLFJvdLQgX42nyNgBSOtATY+NYxAZOYWeIP2UInaWXOwXPVE=
X-Received: by 2002:a05:6808:1aa9:b0:3fb:174f:821d with SMTP id
 5614622812f47-3febf794a4bmr1483123b6e.35.1742555300794; Fri, 21 Mar 2025
 04:08:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHhAz+ibkpwJ4vduDGC+n7Pjp=4ZbtkVmvQFoFXgZYV+TcDWXQ@mail.gmail.com>
 <20250319191542.GA1053142@bhelgaas>
In-Reply-To: <20250319191542.GA1053142@bhelgaas>
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Fri, 21 Mar 2025 16:38:09 +0530
X-Gm-Features: AQ5f1JrBy-AqqjCrt2KrWZk3t_p9044TOZzzhXaZMwnP6ZNUgqmyyjP0SkEjD24
Message-ID: <CAHhAz+j5TMvoxsSQsgsLcuYqjwjS5Hu_6KXtJigWD-noQTeE9Q@mail.gmail.com>
Subject: Re: Query Regarding PCI Configuration Space Mapping and BAR Programming
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 12:45=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> On Wed, Mar 19, 2025 at 11:27:07PM +0530, Muni Sekhar wrote:
> > Dear Linux-PCI Maintainers,
> >
> > I have a few questions regarding PCI configuration space and Base
> > Address Register (BAR) programming:
> >
> > PCI Configuration Space Mapping:
> > PCI devices have standard registers (Device ID, Vendor ID, Status,
> > Command, etc.) in their configuration space.
> > These registers are mapped to memory locations.
>
> In general, config registers are not mapped to memory locations.
>
> Some systems use the ECAM mechanism for config access, which is
> basically memory-mapped I/O that converts CPU memory accesses to PCI
> config accesses.  This mechanism is hidden inside the Linux config
> accessors (pci_read_config_word(), etc), and drivers should not use
> ECAM directly.
Thanks for the clarification.

Both pci_bus_read_config_word() and pci_user_read_config_word() eventually =
call:
res =3D bus->ops->read(bus, devfn, pos, len, &data);
ret =3D dev->bus->ops->read(dev->bus, dev->devfn, pos, sizeof(type), &data)=
;

This suggests that both kernel-space (pci_read_config_*()) and
user-space (pci_user_read_config_*()) accessors use the same
underlying function for configuration space access.
Could you confirm if my understanding is correct?

I tried locating the implementation of bus->ops->read() but could not
find its definition in the kernel source.Even using the function_graph
tracer, I was unable to capture the exact function being executed.
Could you point me to where this function is defined in the kernel?

>
> > How can we determine
> > the exact memory location where these configuration space registers
> > are mapped?
>
> Drivers use pci_read_config_word() and similar interfaces to access
> config registers.  Userspace can use the setpci utility.
>
> > Base Address Registers (BARs) Programming:
> > How are BAR registers programmed, and what ensures they do not
> > conflict with other devices mapped memory in the system?
> > If a BAR mapping clashes with another device=E2=80=99s memory range, ho=
w does
> > the system handle this?
> >
> > Does the BIOS/firmware allocate BAR addresses, or does the OS have a
> > role in reconfiguring them during device initialization?
>
> On x86 systems, the BIOS generally assigns BAR addresses.  Linux
> doesn't change these unless they are invalid.  Some firmware does not
> assign BARs, and generally firmware does not assign BARs for hot-added
> devices.  In those cases, Linux assigns them.
Once a hotplug event is detected (either via a PCIe hotplug interrupt
or an ACPI event), which kernel function is responsible for
dynamically assigning the Bus, Device, and Function (BDF) number to
the new device?
Additionally, which function in the kernel assigns Base Address
Registers (BARs) for the hotplugged device?

I appreciate your time and assistance in clarifying these points.

>
> If Linux notices a conflict, it tries to reassign BARs to avoid the
> conflict.
>
> > If you could provide any source code references from the Linux kernel
> > that handle these aspects, it would be greatly appreciated.
>
> Here's the function that reads BARs when Linux enumerates a device:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/pci/probe.c?id=3Dv6.13#n176



--=20
Thanks,
Sekhar

