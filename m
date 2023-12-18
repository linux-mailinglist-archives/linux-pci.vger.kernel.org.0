Return-Path: <linux-pci+bounces-1138-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D64A781656F
	for <lists+linux-pci@lfdr.de>; Mon, 18 Dec 2023 04:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD2B1F2190F
	for <lists+linux-pci@lfdr.de>; Mon, 18 Dec 2023 03:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048865225;
	Mon, 18 Dec 2023 03:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="HhnRaBKP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4E7442C
	for <linux-pci@vger.kernel.org>; Mon, 18 Dec 2023 03:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 540E53F2B4
	for <linux-pci@vger.kernel.org>; Mon, 18 Dec 2023 03:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1702870908;
	bh=KKS6meN//ZgCj3y7u8vW7HbHEKKQ4gFu/bLYJNM4M9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=HhnRaBKPimYJ14GYJ6XY2d9iWdcy8V+XQrAsjDFiZCm18km0xYRAjmGiR8sLa7TYZ
	 BCOweAIJSDxxjnQzRYdkgzHFFXjQg9TTf/giv7T3oVlnUhXdUAVoarl44kuh/bU24f
	 11nw2jhJAWTLQcv5/LHxgnWR+J8wpVJ27yJDGfcq9BXQ/dNZ3ZSsjzqrjV+qMmM9YW
	 u4BeOICL9C0rCUFT5FQgJKbEQnbd3BeHrlG1EG5ODfiXoEBCX2P6AeWRVCkrZcgKgQ
	 0cu6Hn0aNASayzoMg+Pq6FGBpjZT+bcsQ+ywiuYkEkayUQNsQy50NAU+X4SfD5E/ys
	 7nPRA6eBccFEA==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-28b62ae0737so794097a91.0
        for <linux-pci@vger.kernel.org>; Sun, 17 Dec 2023 19:41:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702870905; x=1703475705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKS6meN//ZgCj3y7u8vW7HbHEKKQ4gFu/bLYJNM4M9M=;
        b=P6map+s+mUM3w1adECSWmbp7b6hZ3UHmE7cpEQYNhE5qe//T9ZE7y06Mhpf/HKbgrK
         ye4idy+WtlYQ8RB9Wg5EbPA0H8MhliwzOI6m11IS0AOVL7RlineRPhqv9JE49iE1+FYg
         bQJhgtvTL4Rd3m5ScGf2qbgUvslTEtDUMNGlRGiGrHGptwxyexH1hb2Hl6J1v//XUBTK
         A2EejRsO1KOCK1AFjI9HCaC3mOfNDyLYdEESv+eQdPtppYOnlsYNfRkUPWb6GYN+QqGS
         lvJwZB9Z90kxwmQd+UzlHc5siHVk2gAk14VwAoyh5UcTI5RcGDPFnVdtJWEJCVFQa8Tn
         RJFA==
X-Gm-Message-State: AOJu0YytFGCUuj/2tr5jdKEDELGVica7LJsXJHTT/Uq3oecXQP8Q2VLW
	5M34JsIZkl4T1BFFD2bQLbiu6D3Ct3Zig5cmDrHVX/+NRuvu4oYiPRPQKIVUEE2do0xY8hu07mm
	JbIa/lfjxU4F9pQmcZ8NDo0D2HEw5Mg6ifjOitfUh6Hf6X0HSns473Q==
X-Received: by 2002:a17:90a:590e:b0:285:8cb6:6153 with SMTP id k14-20020a17090a590e00b002858cb66153mr19578307pji.17.1702870905208;
        Sun, 17 Dec 2023 19:41:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKO+I/YNOACKTPCW4l4TIRyKWuz9qqKpOMciHBbcvu0V5jYlJR1UvSzaGEbecrHxy4CJrBPGPg3ATi2RtmFxA=
X-Received: by 2002:a17:90a:590e:b0:285:8cb6:6153 with SMTP id
 k14-20020a17090a590e00b002858cb66153mr19578289pji.17.1702870904840; Sun, 17
 Dec 2023 19:41:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213182656.6165-1-mario.limonciello@amd.com>
 <20231213182656.6165-3-mario.limonciello@amd.com> <CAJZ5v0gDjwEpx-WNSY0=qchoSGxizsD3XM7Bgq=i0xufBm=Cag@mail.gmail.com>
 <766d621c-695d-4ae7-87cf-690cb8d066df@amd.com> <CAJZ5v0i95EeS40pzkBH=jgB1wbMP6SNO_s=pNZ8FPOtcMywgAA@mail.gmail.com>
 <CAAd53p6XynUJimepnXDzcVa4Dps4-F0BNEXxGZh_O38LvSdkkg@mail.gmail.com>
 <CAJZ5v0ijf9-faD-bDaGi9U0JR4iQ68DECyPM8c-AeECOfhQ=Bg@mail.gmail.com> <3ed302e4-4287-49be-838b-932ecbdc8d12@amd.com>
In-Reply-To: <3ed302e4-4287-49be-838b-932ecbdc8d12@amd.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Mon, 18 Dec 2023 11:41:32 +0800
Message-ID: <CAAd53p6gHy6geX9PZHOmkuN_cxzAv1RiqoGfg0-kyo5wJEHomA@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI/portdrv: Place PCIe port hierarchy into D3cold at shutdown
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mpearson-lenovo@squebb.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 12:44=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 12/14/2023 03:00, Rafael J. Wysocki wrote:
> > On Thu, Dec 14, 2023 at 4:46=E2=80=AFAM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> >>
> >> Hi Mario and Rafael,
> >>
> >> On Thu, Dec 14, 2023 at 2:46=E2=80=AFAM Rafael J. Wysocki <rafael@kern=
el.org> wrote:
> >>>
> >>> On Wed, Dec 13, 2023 at 7:42=E2=80=AFPM Mario Limonciello
> >>> <mario.limonciello@amd.com> wrote:
> >>>>
> >>>> On 12/13/2023 12:38, Rafael J. Wysocki wrote:
> >>>>> On Wed, Dec 13, 2023 at 7:27=E2=80=AFPM Mario Limonciello
> >>>>> <mario.limonciello@amd.com> wrote:
> >>>>>>
> >>>>>> When a system is being powered off it's important that PCIe ports
> >>>>>> have been put into D3cold as there is no other software to turn
> >>>>>> off the devices at S5.
> >>>>>>
> >>>>>> If PCIe ports are left in D0 then any GPIOs toggled by the ACPI
> >>>>>> power resources may be left enabled and devices may consume excess
> >>>>>> power.
> >>>>>
> >>>>> Isn't that a platform firmware issue?
> >>>>>
> >>>>> It is the responsibility of the platform firmware to properly put t=
he
> >>>>> platform into S5, including power removal from devices that are not
> >>>>> armed for power-on.
> >>>>
> >>>> The specific issues that triggered this series were tied to the PCIe
> >>>> ports for dGPUs.  There is a GPIO that is toggled by _ON or _OFF.
> >>>>
> >>>> Windows calls _OFF as part of S5..
> >>>
> >>> I see.
> >>>
> >>>>>
> >>>>>> Cc: mpearson-lenovo@squebb.ca
> >>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >>>>>> ---
> >>>>>>    drivers/pci/pcie/portdrv.c | 11 ++++++++---
> >>>>>>    1 file changed, 8 insertions(+), 3 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv=
.c
> >>>>>> index 14a4b89a3b83..08238680c481 100644
> >>>>>> --- a/drivers/pci/pcie/portdrv.c
> >>>>>> +++ b/drivers/pci/pcie/portdrv.c
> >>>>>> @@ -734,9 +734,14 @@ static void pcie_portdrv_remove(struct pci_de=
v *dev)
> >>>>>>    static void pcie_portdrv_shutdown(struct pci_dev *dev)
> >>>>>>    {
> >>>>>>           if (pci_bridge_d3_possible(dev)) {
> >>>>>> -               pm_runtime_forbid(&dev->dev);
> >>>>>> -               pm_runtime_get_noresume(&dev->dev);
> >>>>>> -               pm_runtime_dont_use_autosuspend(&dev->dev);
> >>>>>> +               /* whole hierarchy goes into a low power state for=
 S5 */
> >>>>>> +               if (system_state =3D=3D SYSTEM_POWER_OFF) {
> >>>>>> +                       pci_set_power_state(dev, PCI_D3cold);
> >>>>>> +               } else {
> >>>>>> +                       pm_runtime_forbid(&dev->dev);
> >>>>>> +                       pm_runtime_get_noresume(&dev->dev);
> >>>>>> +                       pm_runtime_dont_use_autosuspend(&dev->dev)=
;
> >>>>>> +               }
> >>>>>>           }
> >>>>>
> >>>>> Wouldn't it be better to remove power from the port after running t=
he
> >>>>> code below?
> >>>>>
> >>>>
> >>>> Yes; I think you're right.  I'll do some more testing with this.
> >>>>
> >>>>>>           pcie_port_device_remove(dev);
> >>>>>> --
> >>>
> >>> IIRC, to do this all properly, you'd need to rework the shutdown path
> >>> to look like the hibernation power-off one.  Or even use the latter
> >>> for shutdown?
> >>>
> >>> There was no reason to do that till now, so it has not been done, but
> >>> it looks like you have one.
> >>>
> >>
> >> I am working on exactly same thing but with a different approach.
> >> Because this is needed for more than just PCI devices.
> >> I haven't written a proper commit message yet, but the implementation
> >> is quite simple:
> >
> > As I said, doing this properly requires something like the hibernation
> > power-off transition to be carried out for S5.
> >
> > I think that the existing hibernation power-off code can be used as-is
> > for this purpose even.
> >
>
> I feel Rafael is right here that unifying the hibernation and shutdown
> paths is the right direction.  Our team just double checked the
> "unpatched" Linux S4 measurements on a system that otherwise had
> problems with S5 and they show the same decreases in power my patch
> series showed.

I agree this is the right approach because Windows is using S4 for its
"Fast Startup" feature.

Is there any historical reason that .power_off and .shutdown are separated?
And, should we take a step further and also unify the .remove
callback? I recall there was a discussion on consolidating .shutdown
and .remove but somehow it didn't take off.

>
> KH,
>
> I'm going to be OOO for a while with the holidays around the corner and
> some personal time.  If you end up working on some patches to unify the
> S4/S5 codepaths CC me on them and I'll look when I'm back from my leave.

Sure thing. This can take a while.

Kai-Heng

>
> Thanks,
>

