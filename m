Return-Path: <linux-pci+bounces-3622-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4759858552
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 19:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 711E3282F6F
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 18:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A4412FB18;
	Fri, 16 Feb 2024 18:32:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905241EB24;
	Fri, 16 Feb 2024 18:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108361; cv=none; b=nlc6tbJ06rqc60UqmEBuvBMQFMnUx2SxthUOdR3w+AMtLMHBPyLDPYTzdoW5a9LhnMRED+jVXx9hQPyo3lKCeJJACMEBxkpNZB8Cgd1DLF8jD85/cyvfHP90XtHwqcygOapKZampcRVMI466zVHkJG+a85pmSrkbs7mBAqIv5hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108361; c=relaxed/simple;
	bh=jHtIusC8u2VsKQ0wY60VTcAHVOsfPaNM70dyO1WvRaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RouXkDeRks1brhTlhgP/irKu0aZ5BAR2kITlxJF13UadMSKZShLibVRxuSi+qWwBZh4Q4vtj4y/r7uQoegt87bf8jJoKhrGMj+i979W6unnUClIhOoA8syy67tyAGQuKyMigfMqM0pe7hGcG8bWY6ja7AJHWkPldr/eGZiRBpsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e2f6c7e623so256649a34.1;
        Fri, 16 Feb 2024 10:32:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708108358; x=1708713158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3lHn76WTrbLX7hdeSbLZzSHNfz0r3+6mxZ3noqX4GjE=;
        b=bvULrn/0dcv6NP0EDsm3ZCuZLU+QHm9AeTs+qauaUK9L0muJ7Ror6E2saLzv6ePq3d
         9/gPuAaVKa9eyMScSOOtJhFM+yXi8DZfxzqo4pcIndk9sG1gyZvdXtyEZIMWrTx3flDt
         BuJq41MIJj+Qnauo+WhGBhBeI0z+MSwOYoGouk5Fg9YccVu1R8fmMPEcObZotUoVLmJE
         WLEBcmVyrxhIn0QwYWgiywCYFXdVFUY+8YijcR6DmN+UhAAc2NEKj8LDV+6q4AlJBcw2
         kzgkOiEHdisksnVqVBv9NW78jYaZoTbYIeLxkN4d2kFJdPV5mWEb4dOP/yd6qaV7V5Bd
         0LbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWna9LUUOO+6Sw1dFdI01A4UjqCazv9jiWLm2YwelRWEaJIDHkxZvXg8I1AFjZ8bhGzfRXuuN9mg2Vu+gitm4TCNsb101c38YKEL6PXx6wn+Cge9rWY/epI6bcoanQ+pOUnm9zywGeVqvy0bixbJGX8p8rsGk0svopvm7UezPSAYpuAvTRqgy/BeCl5VBPvS5woTJQ10C/09MJzJIsG
X-Gm-Message-State: AOJu0YwiwaN7oAx1DulTjNamlxi0FsKya7+x7QTC66CynJBso7opG7MZ
	GLE9swe37bazSETyTvJABeUEAoUvNOAuoHb5n/sT/WXzP/7j9hUGb1cKpyE8dau4ltMvFVMo47q
	jdWVGIdGKe3lcRUkJGCavxIhEArI=
X-Google-Smtp-Source: AGHT+IFdoQQLtZ3cQx4MmyqGlde59pY0g87onhQCSxAZLVJreS86OzI3OnIAIMwdqJ9b8pBwIrWW3E1n8X5s2FYqjw8=
X-Received: by 2002:a05:6820:1f8d:b0:59c:d8cd:ecee with SMTP id
 eq13-20020a0568201f8d00b0059cd8cdeceemr2838635oob.1.1708108358603; Fri, 16
 Feb 2024 10:32:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240213074430epcas5p4c520bf2cce121cf5fa970eed429231a8@epcas5p4.samsung.com>
 <20240213074416.2169929-1-onkarnath.1@samsung.com>
In-Reply-To: <20240213074416.2169929-1-onkarnath.1@samsung.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 16 Feb 2024 19:32:27 +0100
Message-ID: <CAJZ5v0gAaNd6dZaJ0sDTgJSAkG7+u2Fgc0C=m2RSBKM1gTHe9g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ACPI: use %pe for better readability of errors
 while printing
To: Onkarnarth <onkarnath.1@samsung.com>
Cc: rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com, 
	viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, 
	r.thapliyal@samsung.com, maninder1.s@samsung.com, helgaas@kernel.org, 
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 9:20=E2=80=AFAM Onkarnarth <onkarnath.1@samsung.com=
> wrote:
>
> From: Onkarnath <onkarnath.1@samsung.com>
>
> As %pe is already introduced, it's better to use it in place of (%ld) for
> printing errors in logs. It would enhance readability of logs.
>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
> Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> ---
> v1 -> v2: Updated subject line as per file history & corrected spellings
> in description.
> v2 -> v3: Updated Reviewed-by tag.
>
>  drivers/acpi/acpi_processor.c | 2 +-
>  drivers/acpi/acpi_watchdog.c  | 2 +-
>  drivers/acpi/pci_slot.c       | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.=
c
> index 4fe2ef54088c..2ddd36a21850 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -161,7 +161,7 @@ static void cpufreq_add_device(const char *name)
>
>         pdev =3D platform_device_register_simple(name, PLATFORM_DEVID_NON=
E, NULL, 0);
>         if (IS_ERR(pdev))
> -               pr_info("%s device creation failed: %ld\n", name, PTR_ERR=
(pdev));
> +               pr_info("%s device creation failed: %pe\n", name, pdev);
>  }
>
>  #ifdef CONFIG_X86
> diff --git a/drivers/acpi/acpi_watchdog.c b/drivers/acpi/acpi_watchdog.c
> index 8e9e001da38f..14b24157799c 100644
> --- a/drivers/acpi/acpi_watchdog.c
> +++ b/drivers/acpi/acpi_watchdog.c
> @@ -179,7 +179,7 @@ void __init acpi_watchdog_init(void)
>         pdev =3D platform_device_register_simple("wdat_wdt", PLATFORM_DEV=
ID_NONE,
>                                                resources, nresources);
>         if (IS_ERR(pdev))
> -               pr_err("Device creation failed: %ld\n", PTR_ERR(pdev));
> +               pr_err("Device creation failed: %pe\n", pdev);
>
>         kfree(resources);
>
> diff --git a/drivers/acpi/pci_slot.c b/drivers/acpi/pci_slot.c
> index d6cb2c27a23b..741bcc9d6d6a 100644
> --- a/drivers/acpi/pci_slot.c
> +++ b/drivers/acpi/pci_slot.c
> @@ -111,7 +111,7 @@ register_slot(acpi_handle handle, u32 lvl, void *cont=
ext, void **rv)
>         snprintf(name, sizeof(name), "%llu", sun);
>         pci_slot =3D pci_create_slot(pci_bus, device, name, NULL);
>         if (IS_ERR(pci_slot)) {
> -               pr_err("pci_create_slot returned %ld\n", PTR_ERR(pci_slot=
));
> +               pr_err("pci_create_slot returned %pe\n", pci_slot);
>                 kfree(slot);
>                 return AE_OK;
>         }
> --

Applied as 6.9 material, thanks!

