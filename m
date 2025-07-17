Return-Path: <linux-pci+bounces-32446-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E70B09499
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 21:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4FB0567933
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 19:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CD82F7CEC;
	Thu, 17 Jul 2025 19:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lX4LSuxQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80442153FB;
	Thu, 17 Jul 2025 19:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752779461; cv=none; b=beDmHXhCLOiyBxSAmUcL8DmvPe1vMFddd/h0NSzJYdOg/ri8HQ+DkmYdSvQ2zpTsJcblnJSIjLqvoFxQUwYvX1Cr7ctazI2ire24VwbyL/UCCssX0sP7sRTnDJgyvDZpnHveXE7U/GOABAjp4oakPv5Oq4XnxKouea3f0Qm5pv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752779461; c=relaxed/simple;
	bh=X2QTX7soCtQoFbN1OcRPWW6+MAHVqg1KHTXwB1p8eZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eAlnmRZPzkBBez6unuPLFBmsGlwj6wFL6y0wF64IjzIeIvT2bcU+knXTrdG4Hblx4McrPo49B9GQy5ost7pnVCoHLw/I2PxDEXS04zA0QaEVyQ9wz56mISVD2ZFWhCFoQPC93zymRn3ZEe4dvd4YMdzFeo+bXaO6JeZKkfU/Xys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lX4LSuxQ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b3f2f8469b7so7470a12.3;
        Thu, 17 Jul 2025 12:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752779459; x=1753384259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whHHXq9ZKdXTAW705B1rQtAiW8MTVvGsjlJTeXv7yyA=;
        b=lX4LSuxQC8DuWRsrH78UyuLiD1jAAHFGQB62AnI6Yc3WFMFMQfCqyECxB2Zp1wx/yM
         VvJf+I0w4/4K/iPF6Js2xlfZzTulg3T1eAB/J4KmXtBNfw6ynn9x5Q9hB6FVoBHBKgIx
         1l/hELRj41cFGxgRZyVXvbyjc+1d5SJej2kDll/5XtweBiI7Wq8gXypz7Ju3NbowDMqF
         jJG2Wo2483v0eUHggpXMCrwS/fgqK7YnyyyALHW8CFZ45vu5+h27UWhNW4YKvF1+mkQh
         kUZH0owDHpoxjnKFMRvNrZ/JzxMCJsTAvfy+8YUjlduD1/Yzc3R9JsaTsHg/tkGHp0G0
         pRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752779459; x=1753384259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whHHXq9ZKdXTAW705B1rQtAiW8MTVvGsjlJTeXv7yyA=;
        b=lfBvqebaYVuQ55eDJPRzuR5NyehIirhCN41qP7ULw29tx1XFhrDFWjw05iOdVaNeYc
         sqnIXzxNU7HHUTiIoc8bi3vIBYQlUf2kUhrtDeoei11200V1Gque1eyCNvh4kBgwDMgy
         uTBjdzK1Px31RVQqL4EVP4I4qJ6XA1SUWl2HzGT/Rg1vq/cOctHd6eTMEgmDWvMEVs6/
         zPYsl+hYKZxigfOr4syIepOyjMhK95xUJBtpMCDBdtBb03TsJgcBzh+bqdL1kirT5zNz
         qNK35sSe0qBnp4DcIwQyYK0Ruq1oNX5wYFi/iQYu/KFRoYW9DgR7dQQdI2/Ml1VXQdS0
         60iw==
X-Forwarded-Encrypted: i=1; AJvYcCUYilkWA9eqX2mmbKZtinNIuoB542NWtdgBvMpxUy7FntFiFuf6SzXDFEP/r7DQvZoTfVfj4jLEgymEyGU=@vger.kernel.org, AJvYcCVJ8X+9IiOkQGvyODqqLV4lv7TmDYt/YuPGieK8DsD8CDNOJyTKo/VfrOFg4thNw4gwgMLX3ux6WPVmcA==@vger.kernel.org, AJvYcCVKCTaUUdIVvffOEcWgc8oOdhlpSKDXBTdjrmcXn0IjQXcOR6NdI97z+LQMu2HSwuYTIbrfYN6VcvI=@vger.kernel.org, AJvYcCWELDfFQR8oz8bDaJfAuBgA7qzELVY5ZxBlzg2vyqa7t8y/mr5FsZEM4BOBa52gE893psVuLkivT/pq@vger.kernel.org, AJvYcCX/BGB+fG3WnWiR4PR/WU7UrvKHsa2ZQC/55fScU4iUro1uJbUW1P/x1hZ3g3bgbsKQmWTYXb1R8uCW@vger.kernel.org
X-Gm-Message-State: AOJu0YxWt+qFvgIuA9oku95+0dvJvX2ccrhi77mx3v+nOdXoGuIJNesJ
	4XlNu6VR+zZCk21hQAIVE2zGySsSaYEDRV+VqHC/G24KQdYR1Z/SeLupae9Mu2oI5zIxoSxf1lD
	tX6+Iu0ATXmop9JyOPTm7e7Dd66Fhg7o=
X-Gm-Gg: ASbGncvgMKyHvxnChnZJgC4Axv1aYEVKS71TS/knoJiWo1RbK0RQINR0acu05kxDV+8
	MhZlMYLLmo4OlOQ0pVnwUWxFltakaTPWJtT5rpnubi9SZ4E9k2p03LTjQIC0BD9uwQ5OX5HnYrX
	S65mkLXp/NN174CAwEcB9JJ2MAZ9oxZ1KGEiGr9NGOSVUbxVQs7ZUmY57rc8Qg74gUWnOZbupxh
	aTbqXBViOe2tRVd3dY=
X-Google-Smtp-Source: AGHT+IFcDXeIo6uU4fndJVvGmN/jTY47SR5imHxzk90iAiBRzhNnnJo2QL9GoDY6Xm/D5hnz57/gEipwcAYqKUg8zQw=
X-Received: by 2002:a17:90b:1cc3:b0:311:c5d9:2c8b with SMTP id
 98e67ed59e1d1-31c9e7767fbmr4619712a91.5.1752779459096; Thu, 17 Jul 2025
 12:10:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616175019.3471583-1-superm1@kernel.org> <20250616175019.3471583-4-superm1@kernel.org>
In-Reply-To: <20250616175019.3471583-4-superm1@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 17 Jul 2025 15:10:47 -0400
X-Gm-Features: Ac12FXzm6w4bvt8xXNl05VHu2uQA28FvAWVfU6YAJzv7lZsIpjWGCcVY04Bnf2I
Message-ID: <CADnq5_Pn=0nCD-CyoeJxSAn=Gtn=evkaCBUH2pr_O-=7vpw+bw@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] drm/amd: Avoid evicting resources at S5
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
	"open list:HIBERNATION (aka Software Suspend, aka swsusp)" <linux-pm@vger.kernel.org>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, 
	"open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>, 
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, 
	AceLan Kao <acelan.kao@canonical.com>, Kai-Heng Feng <kaihengf@nvidia.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, Denis Benato <benato.denis96@gmail.com>, 
	=?UTF-8?Q?Merthan_Karaka=C5=9F?= <m3rthn.k@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 1:50=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> Normally resources are evicted on dGPUs at suspend or hibernate and
> on APUs at hibernate.  These steps are unnecessary when using the S4
> callbacks to put the system into S5.
>
> Cc: AceLan Kao <acelan.kao@canonical.com>
> Cc: Kai-Heng Feng <kaihengf@nvidia.com>
> Cc: Mark Pearson <mpearson-lenovo@squebb.ca>
> Cc: Denis Benato <benato.denis96@gmail.com>
> Cc: Merthan Karaka=C5=9F <m3rthn.k@gmail.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> v3: https://lore.kernel.org/linux-pm/20250609024619.407257-1-superm1@kern=
el.org/T/#me6db0fb946e3d604a8f3d455128844ed802c82bb
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 8edd88328749b..c5d8f6d551238 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4966,6 +4966,10 @@ static int amdgpu_device_evict_resources(struct am=
dgpu_device *adev)
>         if (!adev->in_s4 && (adev->flags & AMD_IS_APU))
>                 return 0;
>
> +       /* No need to evict when going to S5 through S4 callbacks */
> +       if (system_state =3D=3D SYSTEM_HALT || system_state =3D=3D SYSTEM=
_POWER_OFF)
> +               return 0;
> +
>         ret =3D amdgpu_ttm_evict_resources(adev, TTM_PL_VRAM);
>         if (ret)
>                 DRM_WARN("evicting device resources failed\n");
> --
> 2.43.0
>

