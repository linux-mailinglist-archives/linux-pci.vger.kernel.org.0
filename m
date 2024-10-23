Return-Path: <linux-pci+bounces-15122-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0089ACEC3
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 17:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2779A285662
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 15:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124471C9DF9;
	Wed, 23 Oct 2024 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvXrV4fo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE271C9DFE;
	Wed, 23 Oct 2024 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697257; cv=none; b=HwjUpeTB6eKq7lBqXecnQ0QHbqXnIqmQPJDjpdwCcK5GZPNDAqe47keTnLnZxZnwBwHHA1QCVfWzY0ac92YVkaFxRnj6l7bab9kLEpmJ5WEZGmnDRmNEWwnnmd6AjqQ3GbXgfCgPYckpBj/0uGSmRkqKhIOT8mNVbY3qFHi/3uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697257; c=relaxed/simple;
	bh=i5zW47oWQ1zjUDyGnHaSmskOj1n5LuiK33aGO8bUccI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MO+LbupOLlZrTsPH3pwSuvXKrCASmdJGKWcvQomM1cQdXB7W5PNRMUpvHfceLeUWhF4iWyFJxUcJfR6cI+xOCxxSn48u0UHCu9Evd1E48mZtCIyNkVfQGAEbtCi4P1T4XhVCUySMwJUdvULfy7hLowAr6MicHDIvbifcEPxr0Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvXrV4fo; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7e9f377a3c9so763671a12.3;
        Wed, 23 Oct 2024 08:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729697254; x=1730302054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgIQoq6KNaLLN/YAbOHNwmlTZJmPg/4UDeUr0HAYKcA=;
        b=ZvXrV4fo7dlSDSGNAO1jFffeKxWeTfm/Cryjd2Di337oQFLrri748J/OALcD9YCxU/
         CT+Knr+7naFs6hC0NMb28xGvISvAnP3EFh34NjKI3AhEgYvmSBTc5Jc7uSJGwWcfVRhM
         Dr7S7AVn8Bx9Xm3Hv44/7sDpMpJ00g5XJWdBbq3rloJLI3RccsO5MLFk61bjkzqnfWXd
         OyU9ndAmSv3J0OwikZn2sTy+V2xu3DmvSGn/vgsL0TE8MSBGW5kUN+NS7QIHv+J1bZwC
         3eOWSmOo//awBlvGyyKcUTkxTzkuQR7DG/b/9JBikwhFo3nrFr1BpVO5g0OfJ2EZRfNl
         yJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729697254; x=1730302054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dgIQoq6KNaLLN/YAbOHNwmlTZJmPg/4UDeUr0HAYKcA=;
        b=XxmpEvc4M/OHmKg69IO98DZj9XkKTSVvr4Bp1j4ZyiGk6gTzDgazNi108cyviLxVsU
         zRzjuylcniWiTJee6D6+vvFZCXnUqSmbZOk4X+ODarFIayZLM8U78gSS4QV9Rv63WrEG
         7lzU/drBs0mTQAK1Rl4D9t5xlY32q0KQ+U2NaVoQekNVqS1RNmt9koyo9gKiq9Fg1WO2
         n0H5YRy0Dd/Z/OacReRbLh5gUZZeumeAO24WHji/KEe9/FtZUwJsvjuJPoLJTAWe85f3
         dgeHQUcGlrJt80G/tQ0qJuspYjLl+IIGB+YrqPnWqQ+UEkcpaDxR+kgkO0tLvuPmdRc1
         FZBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBTShi97N3dOEi5MsL6mXLcwWs+fWEFaOqc2PuZwqy/k30Hz4n8sF8//S6rPbdiUm0ON0TgQq1GWVKdNw=@vger.kernel.org, AJvYcCWnJOiD1w2zACmXKMRrfdsQrl/VVLyfDqoNMFIdzHohzzPAJ6RYFb045ygWaxBBE0Fackm1I5495h8v@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs/OZ/Yf5KhSOMrnrW58BB4rPakV8V1Y8jdPFdf1yziCerfP+t
	JUCS75KbmCMEy9IuY9AVIVdS5X167quxC8JfPtMWU5YI/dbiQuUJdeBORO2CXal1nFkAiXzydNI
	SAA9git2dO+byDiEKWiCRqzeg6/A=
X-Google-Smtp-Source: AGHT+IHx8hn46XoyrIBSavBR29Txf0wclGSq28wvr+ELnHXP69lVjDWT3I5vfqfFUQPcQOdabS6idpRapRcqFXeAxws=
X-Received: by 2002:a05:6a20:6a0e:b0:1cf:34a9:63d2 with SMTP id
 adf61e73a8af0-1d978b96069mr2009125637.9.1729697254464; Wed, 23 Oct 2024
 08:27:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014152502.1477809-1-superm1@kernel.org> <20b48c6f-7ea9-4571-a39c-f20a9cf62319@app.fastmail.com>
 <f56c555f-7313-43ff-abe4-28fb246e31cc@nvidia.com> <CADnq5_OjfJzcOqa=NbWVw5ENvi+nmvNAZX0u_0hOvk3EVoh0bw@mail.gmail.com>
 <fd7cae9a-5ee1-4e18-915d-4115f0a6a156@nvidia.com>
In-Reply-To: <fd7cae9a-5ee1-4e18-915d-4115f0a6a156@nvidia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 23 Oct 2024 11:27:22 -0400
Message-ID: <CADnq5_NTBXPbW+u_AxTewH-aouLNn4gxebpzUSzsyev-VxOtcg@mail.gmail.com>
Subject: Re: [PATCH] PCI/VGA: Don't assume only VGA device found is the boot
 VGA device
To: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: Luke Jones <luke@ljones.dev>, Mario Limonciello <superm1@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, 
	Mario Limonciello <mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 9:27=E2=80=AFPM Kai-Heng Feng <kaihengf@nvidia.com>=
 wrote:
>
>
>
> On 2024/10/22 9:04 PM, Alex Deucher wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Tue, Oct 22, 2024 at 2:31=E2=80=AFAM Kai-Heng Feng <kaihengf@nvidia.=
com> wrote:
> >>
> >> Hi Luke,
> >>
> >> On 2024/10/15 4:04 PM, Luke Jones wrote:
> >>> On Mon, 14 Oct 2024, at 5:25 PM, Mario Limonciello wrote:
> >>>> From: Mario Limonciello <mario.limonciello@amd.com>
> >>>>
> >>>> The ASUS GA605W has a NVIDIA PCI VGA device and an AMD PCI display d=
evice.
> >>>>
> >>>> ```
> >>>> 65:00.0 VGA compatible controller: NVIDIA Corporation AD106M [GeForc=
e
> >>>> RTX 4070 Max-Q / Mobile] (rev a1)
> >>>> 66:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI]
> >>>> Strix [Radeon 880M / 890M] (rev c1)
> >>>> ```
> >>>>
> >>>> The fallback logic in vga_is_boot_device() flags the NVIDIA dGPU as =
the
> >>>> boot VGA device, but really the eDP is connected to the AMD PCI disp=
lay
> >>>> device.
> >>>>
> >>>> Drop this case to avoid marking the NVIDIA dGPU as the boot VGA devi=
ce.
> >>>>
> >>>> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> >>>> Reported-by: Luke D. Jones <luke@ljones.dev>
> >>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3673
> >>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >>>> ---
> >>>>    drivers/pci/vgaarb.c | 7 -------
> >>>>    1 file changed, 7 deletions(-)
> >>>>
> >>>> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> >>>> index 78748e8d2dba..05ac2b672d4b 100644
> >>>> --- a/drivers/pci/vgaarb.c
> >>>> +++ b/drivers/pci/vgaarb.c
> >>>> @@ -675,13 +675,6 @@ static bool vga_is_boot_device(struct vga_devic=
e *vgadev)
> >>>>               return true;
> >>>>       }
> >>>>
> >>>> -    /*
> >>>> -     * Vgadev has neither IO nor MEM enabled.  If we haven't found =
any
> >>>> -     * other VGA devices, it is the best candidate so far.
> >>>> -     */
> >>>> -    if (!boot_vga)
> >>>> -            return true;
> >>>> -
> >>>>       return false;
> >>>>    }
> >>>>
> >>>> --
> >>>> 2.43.0
> >>>
> >>> Hi Mario,
> >>>
> >>> I can verify that this does leave the `boot_vga` attribute set as 0 f=
or the NVIDIA device.
> >>
> >> Does the following diff work for you?
> >> This variant should be less risky for most systems.
> >>
> >> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> >> index 78748e8d2dba..3fb734cb9c1b 100644
> >> --- a/drivers/pci/vgaarb.c
> >> +++ b/drivers/pci/vgaarb.c
> >> @@ -675,6 +675,9 @@ static bool vga_is_boot_device(struct vga_device *=
vgadev)
> >>                   return true;
> >>           }
> >>
> >> +       if (vga_arb_integrated_gpu(&pdev->dev))
> >> +               return true;
> >> +
> >
> > The problem is that the integrated graphics does not support VGA.
>
> Right, so the check has to be used much earlier.
>
> I wonder does the integrated GFX have _DOD/_DOS while the discrete one do=
esn't?
> If that's the case, vga_arb_integrated_gpu() can be used to differentiate=
 which
> one is the boot GFX.

I think the problem is that the boot GPU is being conflated with vga
arb.  In this case the iGPU has no VGA so has no reason to be involved
in vga arb.  Trying to mess with any vga related resources on it could
be problematic.  Do higher levels of the stack look at vga arb to
determine the "primary" GPU?

Alex

>
> Kai-Heng
>
> >
> > Alex
> >
> >>           /*
> >>            * Vgadev has neither IO nor MEM enabled.  If we haven't fou=
nd any
> >>            * other VGA devices, it is the best candidate so far.
> >>
> >>
> >> Kai-Heng
> >>
> >>>
> >>> Tested-by: Luke D. Jones <luke@ljones.dev>
> >>
>

