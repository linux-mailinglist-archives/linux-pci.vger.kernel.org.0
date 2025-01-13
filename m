Return-Path: <linux-pci+bounces-19686-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82903A0C1B4
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 20:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A44C188150F
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 19:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB861C760D;
	Mon, 13 Jan 2025 19:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="JSvGp5FV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64581C5F39
	for <linux-pci@vger.kernel.org>; Mon, 13 Jan 2025 19:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736797426; cv=none; b=UN/Z5y5sQUhKEc++C7h+HspRNatWemF7um86QxBMw20vlYOEb4h7S1ioig21ieD61+Tug1hFYu88EfOKEpVcInzwHsOP7LiSwekOVIrcGLSZc6nxsHkJ+Yo2Fohk5z188I7Euy5TBBBxSKCEH6YG+ZEPfug3FY2skr4e6iVHTVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736797426; c=relaxed/simple;
	bh=4QHDz4LbVcPnlso4eZvPexhd6g11M8rbT2XBHj4Dbzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYxRSreTIiSBnLZOTnAssp6U4Bz7gAA12WaFb9LfDpAizyiPVDiSOgPMM4m86qf49ZK0t68PrUWKWu5vzCbfBUqDue/QlfLNV6tm+/m0Vv6+bgA3uaAb8R56XiCoNxP97P3lnmZFWRKwNVJ2saLNFIfSH43z8s/zJNoSfsd/nrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=JSvGp5FV; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A7BE83F118
	for <linux-pci@vger.kernel.org>; Mon, 13 Jan 2025 19:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1736797422;
	bh=Qnf0uzWqaurO828FH0JnZK208/uAn6s6rmFWWeOsbs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=JSvGp5FV1nms4Sr72oR031+5OtmI/4EELxtPRG7wFXLXT4R4dLnquXNyS2hNvACof
	 ULY+8Q7tLr7CUNG2JgNr3bBWpczOi0jrP7wYVCoBv0XcxaprTz/6n4vxZOEXsiL+Vm
	 whgPLQbYO9irlgEB2BUH/VqLqt/pDk27WVKUwLtwpOwP4SeaFyOk2j6F8N+s+lgcSr
	 OYmMIsnGPEuMbBLMGH6+QCUqOQUe5dUsh1zfkW8nNpZykPrE2HdbU2v7EDx1S7F9ZW
	 ejz8hf/wD7NEaMuj+vvI1rQeW9zuKILZaiTtrfvgmdw1Yb8wcYRXhy1iTMR4KtzRiC
	 8A1eqGHnY0wmA==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aaf8396f65fso467918466b.0
        for <linux-pci@vger.kernel.org>; Mon, 13 Jan 2025 11:43:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736797422; x=1737402222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qnf0uzWqaurO828FH0JnZK208/uAn6s6rmFWWeOsbs4=;
        b=du3GR5/cQG3V0/Cr4P7+v8R+Za6z3DYefj4Z8Z13oivx4I3Mwn+OZwllEGbHFBQEWi
         22KjFA/JA+4xQJ6lynL2zrESh7EXQyRoMbg3QXfBIKC2Awuq8Y7DFg1vqhGclu9XhA2n
         y7PKPM3RNPzmsHqizoKabVro+oN3/sbXBxmpjej7+/N5ULTF/Hnvo/XEvXl7eaA6x+P3
         8KqHKwMR4+Z4yIw5QZhpghK/7xnRPmw18XlkeNmhyxJ25spqzjfkOGDKtUryRoqkX5SW
         mk1ZiN+fpze5GtFh0zHwtMqo3DLdWEC3QMs8YNGrhTwyvsCSf2RqOgSdKi1kuhD6rcQW
         jPyw==
X-Gm-Message-State: AOJu0YzOvj+vvNdW9Dir/ksTHXWuG8hEgdSbjW8NBmUX+5MfEttyL9g0
	XkMzNoPwWNFm8lQryfw8GVG17pW4MFe1lsqhiNMrC4JCQPbqV/hYxJuYmz7QDQZaZ/2Yu56HSIX
	zo1hc9SCEMYnbcAEKIJi+bgpeadXqfgeeqoE9CINwGfn8NusslhiADWdLFbGoJhgXsnqHqXigyf
	ZawQX9+mA1dPAjIIUWZL+YYrlcQls1lUYKYOD9J5t1OXU5R+cD
X-Gm-Gg: ASbGncveEa84DhHyGI8s3+r2vCi04QJKL0STpiCTM6NYT60VhkH3jGxprRWFZoVkkV4
	cf16zAIWCs6e1xaMdKe29QugylwIfc/3KBRDy
X-Received: by 2002:a17:907:60cf:b0:aa6:88f5:5fef with SMTP id a640c23a62f3a-ab2ab6fb426mr2108878266b.32.1736797422035;
        Mon, 13 Jan 2025 11:43:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzZdqFVuQvvGC9yfqHnNpnNoqq95zsu4wvYDPNf8aL9YmAGjJAZ0Yrz7R4wl+cXR/dfhBldb7sqRyvajlCFfQ=
X-Received: by 2002:a17:907:60cf:b0:aa6:88f5:5fef with SMTP id
 a640c23a62f3a-ab2ab6fb426mr2108875566b.32.1736797421688; Mon, 13 Jan 2025
 11:43:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHTA-uYp07FgM6T1OZQKqAdSA5JrZo0ReNEyZgQZub4mDRrV5w@mail.gmail.com>
 <CAHTA-ubXiDePmfgTdPbg144tHmRZR8=2cNshcL5tMkoMXdyn_Q@mail.gmail.com>
 <20241126154145.638dba46.alex.williamson@redhat.com> <CAHTA-uZp-bk5HeE7uhsR1frtj9dU+HrXxFZTAVeAwFhPen87wA@mail.gmail.com>
 <20241126170214.5717003f.alex.williamson@redhat.com> <CAHTA-uY3pyDLH9-hy1RjOqrRR+OU=Ko6hJ4xWmMTyoLwHhgTOQ@mail.gmail.com>
 <20241127102243.57cddb78.alex.williamson@redhat.com> <CAHTA-uaGZkQ6rEMcRq6JiZn8v9nZPn80NyucuSTEXuPfy+0ccw@mail.gmail.com>
 <20241203122023.21171712.alex.williamson@redhat.com> <CAHTA-uZWGmoLr0R4L608xzvBAxnr7zQPMDbX0U4MTfN3BAsfTQ@mail.gmail.com>
 <20241203150620.15431c5c.alex.williamson@redhat.com> <CAHTA-uZD5_TAZQkxdJRt48T=aPNAKg+x1tgpadv8aDbX5f14vA@mail.gmail.com>
 <20241203163045.3e068562.alex.williamson@redhat.com> <CAHTA-ua5g2ygX_1T=YV7Nf1pRzO8TuqS==CCEpK51Gez9Q5woA@mail.gmail.com>
 <CAHTA-uZtRzFOuo7vZCjoLF3_n0CCy3+0U0r_deB3jFF0cPivnw@mail.gmail.com> <20250113132208.118f6bfc.alex.williamson@redhat.com>
In-Reply-To: <20250113132208.118f6bfc.alex.williamson@redhat.com>
From: Mitchell Augustin <mitchell.augustin@canonical.com>
Date: Mon, 13 Jan 2025 13:43:30 -0600
X-Gm-Features: AbW1kvYyxz3GCL0ZZfK5RteHXqQJ-aJea3V5LhXpZsOy5LsNGZt3fXCnT3IxAW0
Message-ID: <CAHTA-uYDffh1GkPsi-UQcMV4qskN2aT+PhqNENWpUUspPB7uaw@mail.gmail.com>
Subject: Re: drivers/pci: (and/or KVM): Slow PCI initialization during VM boot
 with passthrough of large BAR Nvidia GPUs on DGX H100
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Alex, that makes more sense now.

> Potentially the huge pfnmap support that we've introduced in v6.12 can he=
lp us here if we're faulting the mappings on PUD or PMD levels, then we sho=
uld be able to insert the same size mappings into the IOMMU.  I'm hoping we=
 can begin to make such optimizations now.

On November 26th, I did try my reproducer out with the 6.12 kernel in
my guest and host with qemu-9.2.0-rc1, and I did not see any
improvement in the PCI init time when my devices were attached during
boot. Just to make sure I understand, are you saying that there are
still some steps yet to be implemented before the huge pfnmap support
would show gains with respect to this issue, or should I have
theoretically seen that improvement with my prior test?

-Mitchell

On Mon, Jan 13, 2025 at 12:22=E2=80=AFPM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Wed, 8 Jan 2025 17:06:18 -0600
> Mitchell Augustin <mitchell.augustin@canonical.com> wrote:
>
> > Hi Alex,
> >
> > While waiting for
> > https://lore.kernel.org/all/20241218224258.2225210-1-mitchell.augustin@=
canonical.com/
> > to be reviewed, I was thinking more about the slowness of
> > pci_write_config_<size>() itself in my use case.
> >
> > You mentioned this earlier in the thread:
> >
> > > It doesn't take into account that toggling the command register bit i=
s not a trivial operation in a virtualized environment.
> >
> > The thing that I don't understand about this is why the speed for this
> > toggle (an individual pci_write_config_*() call) would be different
> > for one passed-through GPU than for another. On one of my other
> > machines with a different GPU, I didn't see any PCI config register
> > write slowness during boot with passthrough. Notably, that other GPU
> > does have much less VRAM (and is not an Nvidia GPU). While scaling
> > issues due to larger GPU memory space would make sense to me if the
> > slowdown was in some function whose number of operations was bound by
> > device memory, it is unclear to me if that is relevant here, since as
> > far as I can tell, no such relationship exists in pci_write_config_*()
> > itself since it is just writing a single value to a single
> > configuration register regardless of the underlying platform. (It
> > appears entirely atomic, and only bound by how long it takes to
> > acquire the lock around the register.)  All I can hypothesize is that
> > maybe that lock acquisition needs to wait for some
> > hardware-implemented operation whose runtime is bound by memory size,
> > but that is just my best guess.
> >
> > Is there anything you can think of that is triggered by the
> > pci_write_config_*() alone that you think might cause device-dependent
> > behavior here, or is this likely something that I will just need to
> > raise with Nvidia?
>
> The slowness is proportional to the size of the device MMIO address
> space.  In QEMU, follow the path of pci_default_write_config().  It's
> not simply the config space write, but the fact that the config space
> write needs to populate the device memory into the guest address space.
> On memory_region_transaction_commit() affected memory listeners are
> called, for vfio this is vfio_listener_region_add().  At this point the
> device MMIO space is being added to the system_memory address space.
> Without a vIOMMU, devices also operate in this same address space,
> therefore the MMIO regions of the device need to be DMA mapped through
> the IOMMU.  This is where I expect we have the bulk of the overhead as
> we iterate the pfnmaps and insert the IOMMU page tables.
>
> Potentially the huge pfnmap support that we've introduced in v6.12 can
> help us here if we're faulting the mappings on PUD or PMD levels, then
> we should be able to insert the same size mappings into the IOMMU.  I'm
> hoping we can begin to make such optimizations now.  Thanks,
>
> Alex
>


--=20
Mitchell Augustin
Software Engineer - Ubuntu Partner Engineering

