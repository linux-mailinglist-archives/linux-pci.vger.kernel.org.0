Return-Path: <linux-pci+bounces-15006-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B059AA2B9
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 15:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F3D728148E
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 13:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3149D19D080;
	Tue, 22 Oct 2024 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EF5yIK1c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD58194ADB;
	Tue, 22 Oct 2024 13:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729602285; cv=none; b=dJpcjzHl5C+xoNv+eY3X1LCXPrDCvc4GeQxAVld1fM1+lL8/4S/Edvc0NT8W3/73q9u5Brc+g6SvjT42wO27JRDAeEqcvEceowALBxpu6cMS4Xg3yZQbVG9CFKRvnoJTGB1JbQ0bB0rCeYbruhdJbFS1gOfQKlWczDApRdlhb6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729602285; c=relaxed/simple;
	bh=cbH0B8zscu4imBTHxG+Lvc8tuZdEhL0wvzGmBSkhDRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5aRkwilMoSNewW2r81HMNOt7jgEg9jEuyzXjLZVY25KMiH+uRRtA8zCpBIY1iDlKqKqmRE0Y+TUOtqwOCfXsQf7UDraBnWnCXD1bEBAOU/wgRrgwNqHfDXYDtwLIcZDeIJAlgLSsQ2xXaUsnH0TZrGHA8bGPuFk+YdtBj0A0+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EF5yIK1c; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e2ee0a47fdso1094934a91.2;
        Tue, 22 Oct 2024 06:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729602282; x=1730207082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWDeRgm8AjTmhY393T7IKu9ZeB7eJOW+Adot/DNWsok=;
        b=EF5yIK1cxKpcCdaFY9vdGXPUSsoTAdMbO/piR5a3PRRBGhkXH2R4hrsO2+48fOq/I+
         q9GJeFG1Ox8NyrRC6yuSyxeLoNkDZ9ixgucb1LhYPHk2ivvhp4vuS5+Y3E/nzaXvSddo
         d69RY0Q+UTqQlagrzNNmW135l7CxjWCTUyHAZrHeH1ihYmrgl6TwzU1MYsvnHqpYW5Nw
         ThtRcG8dpgZPK3PLbO8tby/mayYPg5676CBWZWyRg7sEMQvSKsD+c1hZzmp43QVYGEgT
         WILVOv9Vw1IlII93UdMHVPh3qHqv9NvP15WgJlv7gCXYt3MMQ8G/RjN237RaprKTb0Lf
         oU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729602282; x=1730207082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWDeRgm8AjTmhY393T7IKu9ZeB7eJOW+Adot/DNWsok=;
        b=CVdYEqBVtgE/PHRwdF+N660VNdbsgRQCpC2JghC0dkvr8sC/MKAlyQM87Itjp+C5+g
         4ii/dogI+4rddwQV+DNx/M3Caw5xt/b8eVFZw4fffQNAjaXZBzBnIe2Sa93qdr7FFBzW
         9/IXsnl2FZd9Dr2Gf9QZziJh1AUY1fMkf6hv2xOxCsEO0FLTXctW/jqkoVyzO/oZ9VDA
         spRpOfV6P6O4DdId1sWJeT/hGyHtjSa7y6v1t8yYdsRVSmkNPoscTmx8aihy9r10gkr/
         QpxfFbzGg2Uzw5dQCo4KnLFiM1wg7IzDeTKUubbrS1jsfJ93puPHJJ+hK2eFPa9W5JIR
         3REw==
X-Forwarded-Encrypted: i=1; AJvYcCVsfpsUdYkXp5tYTA/deiSl4exq/FiLEV8Z37rryD3BPhkD/5GMpDjyW893ScW5iZS+8uQIaO4XQWrRbes=@vger.kernel.org, AJvYcCWlbK5r8lxUgvlEepBDt6cyFvDpiFu9WjDsZGPoI5a1cP+j3E1AONq+CQAVrbOWxJd2apTUQbBxcyYb@vger.kernel.org
X-Gm-Message-State: AOJu0Yw18JFZDHtqZTFKoDVE8hB8n559h7Xf/GDEsFR5CY5b4aiXA0ug
	QDHjBHymqYpVW9demUWhLtktSOhczpjV5Sg1I1KBcfcjwoAK/O/OX/5G6qM/jZt9Sli5H1ihAZb
	LSscmMkdiPlPZuM1zZZgYVSFBQkh3FQ==
X-Google-Smtp-Source: AGHT+IH52G7hhVJzsWn9Mn7Q9OsulLJoDWAxP7UAnkiQV5yHiISOtioTuU80uizG3qQb9Fr754ZF0erA82kY5KLwkoo=
X-Received: by 2002:a17:90a:e296:b0:2e2:de92:2d52 with SMTP id
 98e67ed59e1d1-2e561a58096mr7189173a91.9.1729602282458; Tue, 22 Oct 2024
 06:04:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014152502.1477809-1-superm1@kernel.org> <20b48c6f-7ea9-4571-a39c-f20a9cf62319@app.fastmail.com>
 <f56c555f-7313-43ff-abe4-28fb246e31cc@nvidia.com>
In-Reply-To: <f56c555f-7313-43ff-abe4-28fb246e31cc@nvidia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Oct 2024 09:04:30 -0400
Message-ID: <CADnq5_OjfJzcOqa=NbWVw5ENvi+nmvNAZX0u_0hOvk3EVoh0bw@mail.gmail.com>
Subject: Re: [PATCH] PCI/VGA: Don't assume only VGA device found is the boot
 VGA device
To: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: Luke Jones <luke@ljones.dev>, Mario Limonciello <superm1@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, 
	Mario Limonciello <mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 2:31=E2=80=AFAM Kai-Heng Feng <kaihengf@nvidia.com>=
 wrote:
>
> Hi Luke,
>
> On 2024/10/15 4:04 PM, Luke Jones wrote:
> > On Mon, 14 Oct 2024, at 5:25 PM, Mario Limonciello wrote:
> >> From: Mario Limonciello <mario.limonciello@amd.com>
> >>
> >> The ASUS GA605W has a NVIDIA PCI VGA device and an AMD PCI display dev=
ice.
> >>
> >> ```
> >> 65:00.0 VGA compatible controller: NVIDIA Corporation AD106M [GeForce
> >> RTX 4070 Max-Q / Mobile] (rev a1)
> >> 66:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI]
> >> Strix [Radeon 880M / 890M] (rev c1)
> >> ```
> >>
> >> The fallback logic in vga_is_boot_device() flags the NVIDIA dGPU as th=
e
> >> boot VGA device, but really the eDP is connected to the AMD PCI displa=
y
> >> device.
> >>
> >> Drop this case to avoid marking the NVIDIA dGPU as the boot VGA device=
.
> >>
> >> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> >> Reported-by: Luke D. Jones <luke@ljones.dev>
> >> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3673
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >>   drivers/pci/vgaarb.c | 7 -------
> >>   1 file changed, 7 deletions(-)
> >>
> >> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> >> index 78748e8d2dba..05ac2b672d4b 100644
> >> --- a/drivers/pci/vgaarb.c
> >> +++ b/drivers/pci/vgaarb.c
> >> @@ -675,13 +675,6 @@ static bool vga_is_boot_device(struct vga_device =
*vgadev)
> >>              return true;
> >>      }
> >>
> >> -    /*
> >> -     * Vgadev has neither IO nor MEM enabled.  If we haven't found an=
y
> >> -     * other VGA devices, it is the best candidate so far.
> >> -     */
> >> -    if (!boot_vga)
> >> -            return true;
> >> -
> >>      return false;
> >>   }
> >>
> >> --
> >> 2.43.0
> >
> > Hi Mario,
> >
> > I can verify that this does leave the `boot_vga` attribute set as 0 for=
 the NVIDIA device.
>
> Does the following diff work for you?
> This variant should be less risky for most systems.
>
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index 78748e8d2dba..3fb734cb9c1b 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -675,6 +675,9 @@ static bool vga_is_boot_device(struct vga_device *vga=
dev)
>                  return true;
>          }
>
> +       if (vga_arb_integrated_gpu(&pdev->dev))
> +               return true;
> +

The problem is that the integrated graphics does not support VGA.

Alex

>          /*
>           * Vgadev has neither IO nor MEM enabled.  If we haven't found a=
ny
>           * other VGA devices, it is the best candidate so far.
>
>
> Kai-Heng
>
> >
> > Tested-by: Luke D. Jones <luke@ljones.dev>
>

