Return-Path: <linux-pci+bounces-3547-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FA2856E15
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 20:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB2411F22D5E
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 19:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A73139594;
	Thu, 15 Feb 2024 19:56:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48DB13A86E;
	Thu, 15 Feb 2024 19:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708026985; cv=none; b=mEt+b+6dguVxr5KelFAgRI/rDAt/VhR23qIiP5zoYd5O7FnrKxasSFZQ3mAyi9FgyHoe3eo0vhZQv85jxlEaMrPNcFKPGRMmWM1cnt+/iFZNLX+tZGXiy/6GzSD/5nEhjzRhsNAg+WBhmbVEWSD76ZYmNCD/It1ABbt/yPuhDmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708026985; c=relaxed/simple;
	bh=j0HU7geUkuuZNbKZgc9Jlq1IrLbRb6xyZxDPoMDSeqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k0icaro2GxE/fqrSllZ7AMc/s8p2O2UfQmk8feG6JVfIGoUQ4X2cpi1P95kQIKE3iQ5FrH8wdBTjO0vptEjualWk1xinsupvqd2YAUidFvn9kPQSTGcDT4byntzXGDHlec4v9kobhgg5p0jgLqSH+lqtQxdzMtxJLVBY1t3pt4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5958d3f2d8aso483408eaf.1;
        Thu, 15 Feb 2024 11:56:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708026983; x=1708631783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAtPDKmTzGRId64lpa3XjNUc5dMGliVmcVwJI97qP24=;
        b=ayju33FBMjLGRvyc2YHjEIEI7E06DoLoDb9F/pJp/4+KOOoUs2kfKAqCwDnetbtgYd
         sssDRX4Yvf0cSWDej37n9xSqlwEfANAyVZ3rAujnLITvm65ZzDznfZYU82agQOvA3wxw
         BGnQVWwStiuPu6Fw65fjQu4RfbXRIPFwbttTdObRqlqxA4gXKEzxDCtJRCNQzh1tmb0v
         lhYDmHGn7JkDA/q1N/NQanCt2xHK92bbxlvfvY3UcnTAcwEXugE1/oPnMaJfLom4AKY+
         OT/4f1JwkCR+3v8vDY9UTFJCRFehZ0L+8HnSvQHANlFkng8QxcN05lT32d6soI52gzct
         0SOg==
X-Forwarded-Encrypted: i=1; AJvYcCW3rMKctrR8aWC2I4rvwUTFlZxzvLZw9WFqXQ7oJUu6bmtazVZS1OVR8eSUC/x5L7KKfSXJTzgiQbJZrRNIsxFWsCm3J/XCnLKgbDLNxcYJiflAD4UWio4xP/UQOFHyiwnqNUQWAvtbjDoIb8yAHmjusCU9L8hb3VUam3xpveSZQtGhKKSSLHkmfPMG6S7uAK5y8uOuKAR62wA2qbpF
X-Gm-Message-State: AOJu0Yz9xbv0A5+jfa4nkl4O26nAKCJLHyLnPu44CBaceDoFoLP9O7tw
	5z7HXDPFD5KIDDuKSumW7rlrFM7AOXNlVSXm17oi8gOp2OVK/RA/u0Dsc3c9Juy6nToXdMYGhRU
	bGLxkit2eaPok59L5WOd3TA+myOc=
X-Google-Smtp-Source: AGHT+IGZ5eG7ayb/IhiuqHpoyNC1Gfso7S+jX1oqV6bPJ1aWCQQEOSugs7MR7ESgQCGIWaJYgoZ4J6cZqkGsfu1Dj60=
X-Received: by 2002:a4a:e749:0:b0:59f:8e0f:8a34 with SMTP id
 n9-20020a4ae749000000b0059f8e0f8a34mr221591oov.1.1708026982879; Thu, 15 Feb
 2024 11:56:22 -0800 (PST)
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
Date: Thu, 15 Feb 2024 20:56:11 +0100
Message-ID: <CAJZ5v0gBrc0FctEswQj_JMcZRqoswRgXvBRzT++tseUWBgYJWA@mail.gmail.com>
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

What exactly is the role of this S-o-b?  Has the person helped you to
develop the patch or something else?

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

