Return-Path: <linux-pci+bounces-837-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C18981094A
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 05:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D4FB1F21800
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 04:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2CEBA28;
	Wed, 13 Dec 2023 04:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fpxab/q5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFC79A
	for <linux-pci@vger.kernel.org>; Tue, 12 Dec 2023 20:57:49 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6d9ac148ca3so4573705a34.0
        for <linux-pci@vger.kernel.org>; Tue, 12 Dec 2023 20:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702443468; x=1703048268; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2CFswj44piMe/Aah52F/el5cJFspdjcWvZhI9SuRHiA=;
        b=Fpxab/q5Bocn0cPBxIPt+/ApljSiX7plScOa1/8uaVlgJ5XxEg2KuqFdUdqeF6uA/3
         0i77GNSersMLHZVWL5zDZjB80sNwkheA5aDtDt6ob3RJuxFIFha9W/vk46O/iIECuD4f
         4tA02YoGIuOmH2ALtMCbydy4J3QwLR9PVVDOZUGqPLZ3vPTVEIfSCkcBsgZ3VbDJHWYL
         oI+1u/UFt6fMQ3ylV1l9HgJGU6havgYStUwWpEpFZf03QYPDMBCR7exQCmRNe9mxGKRC
         YPTFPvbEzw2YfqFG3E/1xdJAN+/GO86/VdNkkWZcVvtkswErhJASJoRqkjv7z97mGjVq
         qRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702443468; x=1703048268;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2CFswj44piMe/Aah52F/el5cJFspdjcWvZhI9SuRHiA=;
        b=kLXmjzyASut+WzE+xLMkVdCWLGiq0M4fk4PugHJnqywj03DIhcYQGmbvHsh+UxD90n
         xh2qTMRJ4onuBWzdFF1cT+4Ccc41bEN1C1uNvf4Lr6yihr5nmOd9DGcx85nkeffMbHMd
         Bg7/X1Z36J19C7g9X5/ReAZUw3PuAX89UVpiKcnVOS654e5cE+AZ88Me+GtiDvv9v5+5
         B48Tm4CZWAvFVjDb0XjDgbxW4Cy7JgfrEC17EyTcxrchok14BW2q+sHlyXk8s9jHOUAM
         XNHrWt9kkRX04bWY7/wP6p6VwSTMte6IfolCgahJ7ANrsXQL9tcXj5CUlXq2k8hoHXGp
         jYsA==
X-Gm-Message-State: AOJu0YwpQgEOoSvk8Nue6uSkm/dXIa0QpW9seUyLExW7mLnslRUzOZtz
	5C1DwLpCleKEpl4/KOChqHgxwUJHG2Fx5/Hrr8g=
X-Google-Smtp-Source: AGHT+IH6hOYrMO7IXXMGlmWNaVJwQJWv/pbi03wAUnO9MfrulZ6ISS7C3uh9DL9wv4ueuwRD0WvTFTgLpK8MJ63rdO8=
X-Received: by 2002:a05:6808:140c:b0:3b9:ff46:fa9b with SMTP id
 w12-20020a056808140c00b003b9ff46fa9bmr8759351oiv.43.1702443468448; Tue, 12
 Dec 2023 20:57:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADOvten7jG7KjW6W1MRd7i8_E18L0xCCaCzmZOY_vvgJhdfOSw@mail.gmail.com>
 <20231212105934.GA15015@wunner.de> <CADOvte=k6JJbj=CqjLQqYu1Hp+Cu891KNkn-BDkOKPTdfdVQvw@mail.gmail.com>
 <5d880d78-ee3b-4c3d-a0bb-4e278c3d7b29@amd.com> <20231212120733.7b62f92c.alex.williamson@redhat.com>
In-Reply-To: <20231212120733.7b62f92c.alex.williamson@redhat.com>
From: Ashutosh Sharma <ashutosh.dandora4@gmail.com>
Date: Wed, 13 Dec 2023 10:27:37 +0530
Message-ID: <CADOvtekCEkqkNw40VhJsyiU7ZWrL+2WjChm3os_BaqKrvJbaxw@mail.gmail.com>
Subject: Re: PCI device hot insert is not detected
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Lukas Wunner <lukas@wunner.de>, 
	linux-pci@vger.kernel.org, helgaas@kernel.org, dwmw2@infradead.org, 
	yi.l.liu@intel.com, majosaheb@gmail.com, cohuck@redhat.com, 
	zhenzhong.duan@gmail.com, 
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, 
	Yazen Ghannam <yazen.ghannam@amd.com>
Content-Type: text/plain; charset="UTF-8"

> > Was the removal a "surprise" removal?  Or you mean it was by using
> > 'remove' sysfs file?
> >
> > IIRC surprise removal will need platform firmware support to handle it
> > properly.

Yes, it was a surprise removal.

On Wed, 13 Dec 2023 at 00:37, Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Tue, 12 Dec 2023 12:29:13 -0600
> Mario Limonciello <mario.limonciello@amd.com> wrote:
>
> > On 12/12/2023 05:32, Ashutosh Sharma wrote:
> > >> This doesn't work, try "echo 1 | sudo tee power" instead.
> > >
> > > This was not a permission issue, I already gave it read/write permission.
> > >
> > > admin@node-4:/sys/bus/pci/slots/14$ sudo echo 1 > power
> > > -bash: power: Permission denied
> > > admin@node-4:/sys/bus/pci/slots/14$ sudo chmod 0666 power
> > > admin@node-4:/sys/bus/pci/slots/14$ sudo echo 1 > power
> > > echo: write error: Operation not permitted
> > > admin@node-4:/sys/bus/pci/slots/14$
> > >
> > >> This is from a "Link up" situation (DLActive+), it would be more
> > >> interesting to get lspci output of the port in a "No link" situation.
> > >
> > > Unfortunately, I did not collect that output before system reboot.
> > >
> > > On Tue, 12 Dec 2023 at 16:29, Lukas Wunner <lukas@wunner.de> wrote:
> > >>
> > >> On Tue, Dec 12, 2023 at 04:04:41PM +0530, Ashutosh Sharma wrote:
> > >>> Removed one NVMe drive (pci address 0000:83:00.0), it got unbound
> > >>> successfully from "vfio-pci" driver but saw below error in the syslog.
> > >>>
> > >>> can't change power state from D0 to D3hot (config space inaccessible)
> > >>
> > >> This is normal, the drive's config space is inaccessible after removal.
> > >>
> >
> > Was the removal a "surprise" removal?  Or you mean it was by using
> > 'remove' sysfs file?
> >
> > IIRC surprise removal will need platform firmware support to handle it
> > properly.
>
> The vfio-pci driver also makes zero claims about supporting surprise
> removal, you'll likely end up in an inconsistent state.  Thanks,
>
> Alex
>
> > >>> Then after 2:30 min approx, re-inserted the same drive to the same PCI
> > >>> slot. But the drive was not detected.
> > >>>
> > >>> Dec 11 23:54:39 node-4 kernel: [183672.630191] pcieport 0000:80:03.2:
> > >>> pciehp: Slot(14): Attention button pressed
> > >>> Dec 11 23:54:39 node-4 kernel: [183672.630195] pcieport 0000:80:03.2:
> > >>> pciehp: Slot(14) Powering on due to button press
> > >>> Dec 11 23:54:44 node-4 kernel: [183677.671931] pcieport 0000:80:03.2:
> > >>> pciehp: Slot(14): Card present
> > >>> Dec 11 23:54:46 node-4 kernel: [183679.783922] pcieport 0000:80:03.2:
> > >>> pciehp: Slot(14): No link
> > >>
> > >> The link doesn't come up, so the kernel gives up on the slot.
> > >>
> > >> I don't know what the reason is, could be a hardware issue or
> > >> protocol incompatibility.  This doesn't look like a kernel issue.
> > >>
> > >>
> > >>>   |           +-03.0  Advanced Micro Devices, Inc. [AMD]
> > >>> Starship/Matisse PCIe Dummy Host Bridge
> > >>>   |           +-03.1-[82]----00.0  Samsung Electronics Co Ltd NVMe SSD
> > >>> Controller PM9A1/PM9A3/980PRO
> > >>>   |           +-03.2-[83]--
> > >>
> > >> Adding Mario, Smita, Yazen from AMD to cc, maybe they have an idea
> > >> what the issue is or how to get diagnostics on this Epyc platform.
> > >>
> > >> Start of thread:
> > >> https://lore.kernel.org/linux-pci/CADOvten7jG7KjW6W1MRd7i8_E18L0xCCaCzmZOY_vvgJhdfOSw@mail.gmail.com/
> > >>
> > >>
> > >>> admin@node-4:/sys/bus/pci/slots/14$ sudo echo 1 > power
> > >>> echo: write error: Operation not permitted
> > >>
> > >> This doesn't work, try "echo 1 | sudo tee power" instead.
> > >>
> > >>
> > >>> lspci output of the pci port:
> > >>> 80:03.2 PCI bridge: Advanced Micro Devices, Inc. [AMD]
> > >>> Starship/Matisse GPP Bridge (prog-if 00 [Normal decode])
> > >> [...]
> > >>>                  LnkSta: Speed 16GT/s (ok), Width x4 (ok)
> > >>>                          TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
> > >>
> > >> This is from a "Link up" situation (DLActive+), it would be more
> > >> interesting to get lspci output of the port in a "No link" situation.
> > >>
> > >> Thanks,
> > >>
> > >> Lukas
> >
>

