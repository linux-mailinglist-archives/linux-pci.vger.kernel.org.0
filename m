Return-Path: <linux-pci+bounces-14482-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EDF99D3CB
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 17:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84ABC1F21523
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 15:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C703EA98;
	Mon, 14 Oct 2024 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B05UN3kA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6E1175B1;
	Mon, 14 Oct 2024 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920748; cv=none; b=k9ODE5zTKKwY39bL1ghTu+7Vz0voM5QI+kz5Oma3OsdwHVu2iX2rv44Ytx1LB9dt6yIW4w/EBswcCO9zrqfUjC4pVcn6WV/A4oelRYzZl+XPnSMcGt418Eww3hBNk9QTbra1X2BhRsQ8YlUoOiasc86hVdaPV6LL4swUsVw1MFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920748; c=relaxed/simple;
	bh=NV3daSXdDYmEG8Lr0Ex4MIWgg+SUR7cPY5VoPueLcsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOwUdkIr+MvjPpbVPjjVcxDqlbtVfbrTKSX23yTFs0a/mdIDGNmLdwuojKKPMDUkMC+glnrUPxsEwWlK30AB8IRoAptB2lmMCLTgr8At86RxL6KAqwWjBT8iDHnUUqHzBiJeGBTbcdvajfwKN4sPWX58BYiQRNBajvl/zL5QVw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B05UN3kA; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2ab5bbc01so788831a91.2;
        Mon, 14 Oct 2024 08:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728920746; x=1729525546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urBdkgegMF7XQRvU3yEsW/lOkG2RPkpWnSJ5/Oj21Uo=;
        b=B05UN3kAceDozoC3vqveVXXo0kK0Xr8ImEpBc0+amPq8odFWp4auAPfD5owqa0b34W
         diShDtnXOEMqhyCbtSmdzDqpyB/smTScPqDz7OyAKkyh/6WVeUKqw1MNBg0MGZOB+SpQ
         vy0qYghYA1AWUjxu6htJk5n/QWLIsAQDj7opJlSOkHKYtQZFs9gD0ds1TyxzjXNJPd5z
         s0M7wkIwGVfNQnxwAr6TsZ6lGxqKIwa91ygEIwo5k4eeoDTSQCosUrsI1mZAY3ruLagR
         tc13CQInx1/pBvU3brSNB1NvWpwp79i3FfaW75xq709e8J+l1hJ9kaqOukgxujz+BJkE
         lKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728920746; x=1729525546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=urBdkgegMF7XQRvU3yEsW/lOkG2RPkpWnSJ5/Oj21Uo=;
        b=Aozyzaw2uFqTQl9hYNIjHB63ZtNn9VJ25Mel/Hdc438aZsgI0xUxQU/v/NH7N1+LwV
         750m0j5dgEIJ/eKH7sV0dIwHlX9dTpZrDAZJNGWcYF2YncEGZ2mpxAVDcB8PwW2X7scA
         oHXK7pNuRiLHe0s213vcMPM9rSlf7o4dvxuXI15PTdQECWVh3HH3GZqsssjDeklMohBq
         9qjx+IKNsQPgsgiq2Mjvs/hKQv3owtjwhBbxQQMHWocCXF6etKI8JahnNGfsLzoPnfNi
         cjURbrMOt/m8EvGSIp/8xZDHbVknVfZCoZuRfBbu4IdaTd1Xk4tayDE83hyDBABUCuCK
         n99Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMTR7t3MGNrvTaIGqkez7zuiFHZbmVEDOhZyaorQ+URq7K+NX0xtbQfkieQlkOZaFBoLvgCJcbSvKJsGg=@vger.kernel.org, AJvYcCWo4BA5CsIIM+4gs2ZIi6XQenS/rGxjvkJ5VZgrG/wTEalnBA8AbTvsAintrg3v+hvjsWORaqylC3vC@vger.kernel.org
X-Gm-Message-State: AOJu0YztbF/VQV7J6JlFKCdnmzg25WsuSmRvk4Ac4DJdSR6xGXdd8r4/
	LIVnBdcRqGXbBf/76D4vvRc1zH0MwGxQKLthYLZP9rOqpHN6wpOGKZciDc2voa7rbZVr3gRDygc
	ZANEJVKmUD5hgrC6m8WSRW7DSKCM=
X-Google-Smtp-Source: AGHT+IFsBRoPEXbTXS5Ff46RFH5X1jTMu4OeBPJkvDso2hrabHpmHawU+KMeOBCQH9atwTLfKwg8xP9P9VMxCT5ReGE=
X-Received: by 2002:a17:90a:474f:b0:2e1:682b:361e with SMTP id
 98e67ed59e1d1-2e2f0c3b7e4mr5933462a91.4.1728920746330; Mon, 14 Oct 2024
 08:45:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014152502.1477809-1-superm1@kernel.org>
In-Reply-To: <20241014152502.1477809-1-superm1@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 14 Oct 2024 11:45:34 -0400
Message-ID: <CADnq5_PCHZtmGN4Frknz+10xVMypwpDuW7_kYbTmvihcayCPew@mail.gmail.com>
Subject: Re: [PATCH] PCI/VGA: Don't assume only VGA device found is the boot
 VGA device
To: Mario Limonciello <superm1@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	dri-devel@lists.freedesktop.org, 
	Mario Limonciello <mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	"Luke D . Jones" <luke@ljones.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 11:25=E2=80=AFAM Mario Limonciello <superm1@kernel.=
org> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> The ASUS GA605W has a NVIDIA PCI VGA device and an AMD PCI display device=
.
>
> ```
> 65:00.0 VGA compatible controller: NVIDIA Corporation AD106M [GeForce RTX=
 4070 Max-Q / Mobile] (rev a1)
> 66:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Strix =
[Radeon 880M / 890M] (rev c1)
> ```

For clarity, the iGPU is not a VGA class device.  The "primary" should
not have any dependency on the VGA PCI class, but I'm not sure how
exactly the kernel handles this case.  In this case, the primary
should be the iGPU which is not a VGA PCI class device.

Alex

>
> The fallback logic in vga_is_boot_device() flags the NVIDIA dGPU as the
> boot VGA device, but really the eDP is connected to the AMD PCI display
> device.
>
> Drop this case to avoid marking the NVIDIA dGPU as the boot VGA device.
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Reported-by: Luke D. Jones <luke@ljones.dev>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3673
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/vgaarb.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index 78748e8d2dba..05ac2b672d4b 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -675,13 +675,6 @@ static bool vga_is_boot_device(struct vga_device *vg=
adev)
>                 return true;
>         }
>
> -       /*
> -        * Vgadev has neither IO nor MEM enabled.  If we haven't found an=
y
> -        * other VGA devices, it is the best candidate so far.
> -        */
> -       if (!boot_vga)
> -               return true;
> -
>         return false;
>  }
>
> --
> 2.43.0
>

