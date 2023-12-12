Return-Path: <linux-pci+bounces-799-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B6A80EA6F
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 12:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D28D8281473
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 11:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47185CD1B;
	Tue, 12 Dec 2023 11:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGbuyfHI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4055D3
	for <linux-pci@vger.kernel.org>; Tue, 12 Dec 2023 03:32:17 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-286b45c5a8dso5744517a91.1
        for <linux-pci@vger.kernel.org>; Tue, 12 Dec 2023 03:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702380737; x=1702985537; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8I/HXJgC19korbpv1uJj4Nq4vBbYww+m4AiMscm/nI0=;
        b=BGbuyfHI7R19TLA397FQ9NEckJ85NV4VLTX6Mtqnh+VVfYcNeDYPIsQeRV80aOab5k
         kjIpzyJB33BmR/9wgkE0/0l5fmpxioO2a75ajCEPqVB+otq6X2DUt+VZMmLIQSht9reM
         IiR0P2qNlUEMgt2bJz4W33AexIS60ts2yfxjjYa1l5uE6/B6x5pvPUVGgCH4erPxyVLu
         DQf5OjdzIykQWCEeuCrVz81hIyHT9eBzfRXJEr+C+KWXCEHhJl1S6swFFzz2SKHBujIx
         M2lZ9+Rbf1yfSCnkfu4sAzshWwIlRV0pB7NQ5BbrMHexPMQbHR4OiBjaL0j3au+zaYuj
         4suA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702380737; x=1702985537;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8I/HXJgC19korbpv1uJj4Nq4vBbYww+m4AiMscm/nI0=;
        b=Mr0VxMxtL6Qmi6WpMat6AFrb3Hn1GWAv+/gxU+WgNsVZG8OZVQg8J+yo5Jj3TXnsss
         7aFgaC1EljisLy1YjW3kp8Lzq29Y0EueCXmCuancLkdPH8TuZU4Smdo9bllOM4Tq7UwB
         m93N1oDTdDj3Vng4KT31nbXkAyfnGJxFKAAA4zGoWpw6iWx+9OYbcNGKstPxZ9M/YwXe
         5BWXzwXZ42rRqCy/ayDTbr3V5YYGFFgtPQQeHVJOMO/TKhKvz26K7097Ha8erSjfIJN4
         bC7V5ELK0PDhytq2O5yBaBN0MQ5yJsE88dldKLjAEv/0rqhExtfoWMnqpspPhUsuWDb2
         4iQA==
X-Gm-Message-State: AOJu0YxAiL30Be6by3GDiDfboDF1uTGQR1tAv6w+LoFqCrgjCz3Im2FK
	MBctg8OT953Z1yTXGzgTwVxhvyjobxILWrkLQzs=
X-Google-Smtp-Source: AGHT+IFNatoBiFtGmbVNAfScKvZ3a13o2JOzZO8ZBuipeP9BXvyv/9lA47zjbN2o+veK5P8XnEkpRToME6Etk4xECbs=
X-Received: by 2002:a17:90a:c717:b0:28a:c1a5:b80e with SMTP id
 o23-20020a17090ac71700b0028ac1a5b80emr587699pjt.5.1702380737136; Tue, 12 Dec
 2023 03:32:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADOvten7jG7KjW6W1MRd7i8_E18L0xCCaCzmZOY_vvgJhdfOSw@mail.gmail.com>
 <20231212105934.GA15015@wunner.de>
In-Reply-To: <20231212105934.GA15015@wunner.de>
From: Ashutosh Sharma <ashutosh.dandora4@gmail.com>
Date: Tue, 12 Dec 2023 17:02:06 +0530
Message-ID: <CADOvte=k6JJbj=CqjLQqYu1Hp+Cu891KNkn-BDkOKPTdfdVQvw@mail.gmail.com>
Subject: Re: PCI device hot insert is not detected
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, alex.williamson@redhat.com, helgaas@kernel.org, 
	dwmw2@infradead.org, yi.l.liu@intel.com, majosaheb@gmail.com, 
	cohuck@redhat.com, zhenzhong.duan@gmail.com, 
	Mario Limonciello <mario.limonciello@amd.com>, 
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, 
	Yazen Ghannam <yazen.ghannam@amd.com>
Content-Type: text/plain; charset="UTF-8"

> This doesn't work, try "echo 1 | sudo tee power" instead.

This was not a permission issue, I already gave it read/write permission.

admin@node-4:/sys/bus/pci/slots/14$ sudo echo 1 > power
-bash: power: Permission denied
admin@node-4:/sys/bus/pci/slots/14$ sudo chmod 0666 power
admin@node-4:/sys/bus/pci/slots/14$ sudo echo 1 > power
echo: write error: Operation not permitted
admin@node-4:/sys/bus/pci/slots/14$

> This is from a "Link up" situation (DLActive+), it would be more
> interesting to get lspci output of the port in a "No link" situation.

Unfortunately, I did not collect that output before system reboot.

On Tue, 12 Dec 2023 at 16:29, Lukas Wunner <lukas@wunner.de> wrote:
>
> On Tue, Dec 12, 2023 at 04:04:41PM +0530, Ashutosh Sharma wrote:
> > Removed one NVMe drive (pci address 0000:83:00.0), it got unbound
> > successfully from "vfio-pci" driver but saw below error in the syslog.
> >
> > can't change power state from D0 to D3hot (config space inaccessible)
>
> This is normal, the drive's config space is inaccessible after removal.
>
>
> > Then after 2:30 min approx, re-inserted the same drive to the same PCI
> > slot. But the drive was not detected.
> >
> > Dec 11 23:54:39 node-4 kernel: [183672.630191] pcieport 0000:80:03.2:
> > pciehp: Slot(14): Attention button pressed
> > Dec 11 23:54:39 node-4 kernel: [183672.630195] pcieport 0000:80:03.2:
> > pciehp: Slot(14) Powering on due to button press
> > Dec 11 23:54:44 node-4 kernel: [183677.671931] pcieport 0000:80:03.2:
> > pciehp: Slot(14): Card present
> > Dec 11 23:54:46 node-4 kernel: [183679.783922] pcieport 0000:80:03.2:
> > pciehp: Slot(14): No link
>
> The link doesn't come up, so the kernel gives up on the slot.
>
> I don't know what the reason is, could be a hardware issue or
> protocol incompatibility.  This doesn't look like a kernel issue.
>
>
> >  |           +-03.0  Advanced Micro Devices, Inc. [AMD]
> > Starship/Matisse PCIe Dummy Host Bridge
> >  |           +-03.1-[82]----00.0  Samsung Electronics Co Ltd NVMe SSD
> > Controller PM9A1/PM9A3/980PRO
> >  |           +-03.2-[83]--
>
> Adding Mario, Smita, Yazen from AMD to cc, maybe they have an idea
> what the issue is or how to get diagnostics on this Epyc platform.
>
> Start of thread:
> https://lore.kernel.org/linux-pci/CADOvten7jG7KjW6W1MRd7i8_E18L0xCCaCzmZOY_vvgJhdfOSw@mail.gmail.com/
>
>
> > admin@node-4:/sys/bus/pci/slots/14$ sudo echo 1 > power
> > echo: write error: Operation not permitted
>
> This doesn't work, try "echo 1 | sudo tee power" instead.
>
>
> > lspci output of the pci port:
> > 80:03.2 PCI bridge: Advanced Micro Devices, Inc. [AMD]
> > Starship/Matisse GPP Bridge (prog-if 00 [Normal decode])
> [...]
> >                 LnkSta: Speed 16GT/s (ok), Width x4 (ok)
> >                         TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
>
> This is from a "Link up" situation (DLActive+), it would be more
> interesting to get lspci output of the port in a "No link" situation.
>
> Thanks,
>
> Lukas

