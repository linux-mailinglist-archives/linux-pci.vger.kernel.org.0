Return-Path: <linux-pci+bounces-13625-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC63989973
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 05:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 549081C20C1B
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 03:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74002EAE5;
	Mon, 30 Sep 2024 03:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Mh+jY8Fk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6353D15C3
	for <linux-pci@vger.kernel.org>; Mon, 30 Sep 2024 03:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727666870; cv=none; b=qXcaWnI5Yy/LCWtm3/cM+Ya5lE5ktXJb6KULnFgxRC2c/phPDbSnQ7YVTlkqdQs+WW78qotJdgFWXHHVlWpywfQu3d9LaQwsGc70SUrzQAsbeHRQ8YlLP9m6nioIIApzOK4FHQybHizex5ow00tRKub1ZBe9T4EDeobDLklKp9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727666870; c=relaxed/simple;
	bh=jLI9MMQQmuZUKWNU/xHCFYdL/UPbKyDkOfCbEMNlGo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCcE1KSRlKcCVVBR25Y8IDxJ1DfMEHDfXIrghmdCDdQlQVMOqZoPJqrKqPtQ0rD8Xq7ofWnxQxkGq3/MYakx8XOrhO0q0zOFNQNrdop5lQJos0hSDkTcAm5TUhN1ieA0EKuPbgQR5n+ewUj+wZLLMvV0aGXw3vI4kxMKFX3x/Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Mh+jY8Fk; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com [209.85.219.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 015B63F2D4
	for <linux-pci@vger.kernel.org>; Mon, 30 Sep 2024 03:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727666861;
	bh=IS7wA0xTn8FCZ6UozFnElcPvTZac7PO47dXlo5uaWuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=Mh+jY8FkublYKTvpbFX59/7GS1Tn7sN81bFC7c2In6llfTTTEPPFNONWGUh8sq04E
	 s1z5o6xcsKkoPudmFoczrHf0O+b/vroe3IdD14TmTcdxkrRtWSXekXCd3BiNQ4jscs
	 kQIqZWmQbvPa2FRhIjQ1AIWTYW7LHhz4gpVj4z5TOe1fOuKclxhxL92AuaFC2ZHyU3
	 eqK7HBifXqEkr/7I3YOuQRwdm8MfxrauK2CnFnDratrQvZVQEy6Rc+58v/FmuI7p0A
	 +INX+RdfiFKy4093MyDxVJ8JhCBd4B+Gnoaub/dUOEr4yBGKHo8RTBrvjEqqkIsrwp
	 pkEDZe83xdkGg==
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e25cef43f5aso4490960276.3
        for <linux-pci@vger.kernel.org>; Sun, 29 Sep 2024 20:27:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727666859; x=1728271659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IS7wA0xTn8FCZ6UozFnElcPvTZac7PO47dXlo5uaWuU=;
        b=eONBasE1fF8/Hn6JREzskNBQJLk/8PyDJzq29RS0d2YaZ5E6OU4rSbggX/yhX3POqr
         zdcZGqZVMlIXVgGx24oehWwR1r7bUJNVFA8yA+Y13FVhGeNbTEyNrGPRbt1iwbyuasX9
         fy73G7DzNsOrNRXUZvcaihZ8DhS7GzXtAMG/lLUxiTOOHD/qGDFIiqtcDEIY9wwV6GFN
         TSD3ZGJL7x+HqeSWOfNJ24D63J3h1k5iowBH5ChylXhAKqIQZXVyF1kiCvA9DOMnKHiB
         I89zxGn8vmQEBA3Qe9WfrZ+mp+pN27FuKRsnT9FTEqHE42lCw1A3twGskmlWbOJOu/40
         fozQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxZrYBZKxwZuJXpW7tYTM0xwTre/spFRSRvm6UH4kX0/TKUl3BhMzWrIHPHVKO+VUL5FdwTLWd+CY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxppsd7i3MX6Q6ORJHRiEW2ZPZmJa89BMxzNijOPDqRYIyTRdqF
	+V40cmrOC9eSh2nIqT6Hs8QEKMrXS14GoRAjb/y4SXwFu00qcDcf4A7V6o8Dm0WCZBsl0dED087
	bJC/hW3HP4A7JZ/mJhlEeiCx6CErzN8Sbup83ISiQ1Wol0LchZoRbp7LQKMv29CySDpkA3dIAYF
	SfdwHyf2bJyB74pSzxgmSFYrKkVih0TLBAwMiha2sNPwWo9sGqQQY7nxnH
X-Received: by 2002:a05:6902:2b84:b0:e20:2568:e371 with SMTP id 3f1490d57ef6-e2604c7999dmr7922783276.53.1727666859678;
        Sun, 29 Sep 2024 20:27:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5XOqqUSuKwKgB2HAvUTgCkDeBSDixhXLFmsPg1Q7TNFp4VfsxPkK/WOl6EnwJHcT53aw1DXo6+/5jH+FcFlI=
X-Received: by 2002:a05:6902:2b84:b0:e20:2568:e371 with SMTP id
 3f1490d57ef6-e2604c7999dmr7922776276.53.1727666859371; Sun, 29 Sep 2024
 20:27:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926125909.2362244-1-acelan.kao@canonical.com>
 <ZvVgTGVSco0Kg7H5@wunner.de> <CAFv23Q=5KdqDHYxf9PVO=kq=VqP0LwRaHQ-KnY2taDEkZ9Fueg@mail.gmail.com>
 <ZvZ61srt3QAca2AI@wunner.de>
In-Reply-To: <ZvZ61srt3QAca2AI@wunner.de>
From: AceLan Kao <acelan.kao@canonical.com>
Date: Mon, 30 Sep 2024 11:27:28 +0800
Message-ID: <CAFv23Q=QJ+SmpwvzLmzJeCXwYrAHVvTK96Wz7rY=df7VmGbSmw@mail.gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Fix system hang on resume after hot-unplug
 during suspend
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Lukas Wunner <lukas@wunner.de> =E6=96=BC 2024=E5=B9=B49=E6=9C=8827=E6=97=A5=
 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=885:28=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, Sep 27, 2024 at 03:33:50PM +0800, AceLan Kao wrote:
> > Lukas Wunner <lukas@wunner.de> 2024-9-26 9:23
> > > On Thu, Sep 26, 2024 at 08:59:09PM +0800, Chia-Lin Kao (AceLan) wrote=
:
> > > > Remove unnecessary pci_walk_bus() call in pciehp_resume_noirq(). Th=
is
> > > > fixes a system hang that occurs when resuming after a Thunderbolt d=
ock
> > > > with attached thunderbolt storage is unplugged during system suspen=
d.
> > > >
> > > > The PCI core already handles setting the disconnected state for dev=
ices
> > > > under a port during suspend/resume.
> > > >
> > > > The redundant bus walk was
> > > > interfering with proper hardware state detection during resume, cau=
sing
> > > > a system hang when hot-unplugging daisy-chained Thunderbolt devices=
.
> >
> > I have no good answer for you now.
> > After enabling some debugging options and debugging lock options, I
> > still didn't get any message.
>
> Have you tried "no_console_suspend" on the kernel command line?
>
>
> > ubuntu@localhost:~$ lspci -tv
> > -[0000:00]-+-00.0  Intel Corporation Device 6400
> >           +-02.0  Intel Corporation Lunar Lake [Intel Graphics]
> >           +-04.0  Intel Corporation Device 641d
> >           +-05.0  Intel Corporation Device 645d
> >           +-07.0-[01-38]--
> >           +-07.2-[39-70]----00.0-[3a-70]--+-00.0-[3b]--
> >           |                               +-01.0-[3c-4d]--
> >           |                               +-02.0-[4e-5f]----00.0-[4f-50=
]----01.0-[50]----00.0  Phison Electronics Corporation E12 NVMe Controller
> >           |                               +-03.0-[60-6f]--
> >           |                               \-04.0-[70]--
> >
> > This is Dell WD22TB dock
> > 39:00.0 PCI bridge [0604]: Intel Corporation Thunderbolt 4 Bridge [Gosh=
en Ridge 2020] [8086:0b26] (rev 03)
> >        Subsystem: Intel Corporation Thunderbolt 4 Bridge [Goshen Ridge =
2020] [8086:0000]
> >
> > This is the TBT storage connects to the dock
> > 50:00.0 Non-Volatile memory controller [0108]: Phison Electronics
> > Corporation E12 NVMe Controller [1987:5012] (rev 01)
> >        Subsystem: Phison Electronics Corporation E12 NVMe Controller [1=
987:5012]
> >        Kernel driver in use: nvme
> >        Kernel modules: nvme
>
> The lspci output shows another PCIe switch in-between the WD22TB dock and
> the NVMe drive (bus 4e and 4f).  Is that another Thunderbolt device?
> Or is the NVMe drive built into the WD22TB dock and the switch at bus
> 4e and 4f is a non-Thunderbolt PCIe switch in the dock?
>
> I realize now that commit 9d573d19547b ("PCI: pciehp: Detect device
> replacement during system sleep") is a little overzealous because it
> not only reacts to *replaced* devices but also to *unplugged* devices:
> If the device was unplugged, reading the vendor and device ID returns
> 0xffff, which is different from the cached value, so the device is
> assumed to have been replaced even though it's actually been unplugged.
>
> The device replacement check runs in the ->resume_noirq phase.  Later on
> in the ->resume phase, pciehp_resume() calls pciehp_check_presence() to
> check for unplugged devices.  Commit 9d573d19547b inadvertantly reacts
> before pciehp_check_presence() gets a chance to react.  So that's somethi=
ng
> that we should probably change.
>
> I'm not sure though why that would call a hang.  But there is a known iss=
ue
> that a deadlock may occur when hot-removing nested PCIe switches (which i=
s
> what you've got here).  Keith Busch recently re-discovered the issue.
> You may want to try if the hang goes away if you apply this patch:
>
> https://lore.kernel.org/all/20240612181625.3604512-2-kbusch@meta.com/
>
> If it does go away then at least we know what the root cause is.
Yes, the 2 patches work.

>
> The patch is a bit hackish, but there's an ongoing effort to tackle the
> problem more thoroughly:
>
> https://lore.kernel.org/all/20240722151936.1452299-1-kbusch@meta.com/
> https://lore.kernel.org/all/20240827192826.710031-1-kbusch@meta.com/
v2 can't be applied clearly, so I made some changes.
And this series doesn't work for me.

>
> Thanks,
>
> Lukas

