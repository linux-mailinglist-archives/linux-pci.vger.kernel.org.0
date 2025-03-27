Return-Path: <linux-pci+bounces-24887-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B4BA73E60
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 20:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C4F3BDA3D
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 19:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A711C5496;
	Thu, 27 Mar 2025 19:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1vXCELj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7889C1E505;
	Thu, 27 Mar 2025 19:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743102558; cv=none; b=kfVEzBZTrRDq9O+Xr9dx1+/v0yPQmeQB5RuvyEXeLNBnvmkRwN4clUw2TJnV7z7e0hP4YEM1QaZkaAtDdX9LecX+MUPoikxDRPdpbqB9raDbLfT/9oImpTVtd+uEpjYOA+8YexFsB5e0qYdQqI3mFdnNE6uwHM4qO6lGbPJTVOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743102558; c=relaxed/simple;
	bh=7xNJ7z0ZgU3oH74BiWXl6Ym9NlEqMNNX5XOBW0Dd2bc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+niBr32UN9pR1YhzdcQut89BXyEoq129Lb/2rgOtnwezPuAB79IZqeLmONZWBmaxa0kVhM7Gbud3skNIGRkBQUg9J1nT00fqoE0f6wRMV632EPvqCZqtGbgmbkbLilx06skOuWyz2vD5aO8zcOssxU1xRf46pLV5y0a/8iDXwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1vXCELj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B755C4CEE8;
	Thu, 27 Mar 2025 19:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743102558;
	bh=7xNJ7z0ZgU3oH74BiWXl6Ym9NlEqMNNX5XOBW0Dd2bc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=e1vXCELj298XaWFFsV8fQULerII2krdXvsXMn4s6tsqx81RY8qqMa+h6Btuz98PCN
	 GyT+F/aO4lZCgVoOdbkYqyVvmbYmRbYG4LVRBMPoir5hjqQ8i88VttMb10mzXcdHg7
	 xFbKDJTZriRbm4RV6mK1PLouVf+oM2D+mS4Rb5i5LeewgSaQirNnAMHrHPY8bVno8b
	 MoWRZ1H+cKlhJ24Wz3wmOfbEPjSj0j5ktWaQjOX8dXiHYfP3WMODtYmHiMeMXauhMT
	 J0sZo40Ri4L2bL4tjNwONapSKpUImdlYgaa7FJrnvnC268aB+n/w3TJ7l/aSYXtuM9
	 7fPE11wd9LZvw==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-601e77a880eso178737eaf.2;
        Thu, 27 Mar 2025 12:09:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZB0je3NF+2IGx9FzJ8uafSWwgTgxBTccexRQPD00V0mtJfIyYy/E6cGunTmqZIq2NmuenNKx0mNdnkuOv@vger.kernel.org, AJvYcCUsJiatzPKi/e2x9f+be+21gvvFJu7vS0cNUA9QpQM+3d5uxxacWsXOc8euOXUeO2CTxSo6j9P7Ccc+@vger.kernel.org, AJvYcCW1KAgTyYifATOYDwlBH5DuInFen8bFB7ggDWT3JHKQYTlwNRFa8kzoXPzCGgFZJH/rhQ6W7XETYXp0@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ8kfaIOegwpHyrBLF7uiyHOv7RQZ8WIXO8tynJCpsqrxbwyfG
	8JjOiahedRF4puyP3tzaWdXi7JTzzev+e+IGiAZt9Jz/JJfqnmJsEHHBTHyLR3QdwG8Uh+JaLBs
	pw+W5SHbQTiY5q7/qxPMtWt3ArFE=
X-Google-Smtp-Source: AGHT+IHVfmp4UGQiNKRP+ftRW36JY8Cf0hCDGwBPcNlNgEx2rcVubY3CUjY7zXPpPqgbNW69e+BpCzIHmqL2Ngv6Y2g=
X-Received: by 2002:a05:6870:46a7:b0:29e:7dd8:92b1 with SMTP id
 586e51a60fabf-2c8481dba82mr2705377fac.24.1743102557643; Thu, 27 Mar 2025
 12:09:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313100658.15805-1-zhoushengqing@ttyinfo.com> <20250313100658.15805-2-zhoushengqing@ttyinfo.com>
In-Reply-To: <20250313100658.15805-2-zhoushengqing@ttyinfo.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 27 Mar 2025 20:09:06 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h1goEuX83jfKYMQJ_5wbpXpt=2XW82yWJYzzyJyGwzYQ@mail.gmail.com>
X-Gm-Features: AQ5f1JolyiSoyEA1nM3bg6xe_rkgRaceF2hrKwPUfK2fVdhMflD1D8rkKB-8ASM
Message-ID: <CAJZ5v0h1goEuX83jfKYMQJ_5wbpXpt=2XW82yWJYzzyJyGwzYQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] Add acpi_check_dsm() for PCI _DSM definitions
To: Zhou Shengqing <zhoushengqing@ttyinfo.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 11:07=E2=80=AFAM Zhou Shengqing
<zhoushengqing@ttyinfo.com> wrote:
>
> add acpi_check_dsm() for DSM_PCI_POWER_ON_RESET_DELAY,
> DSM_PCI_DEVICE_READINESS_DURATIONS.
>
> Signed-off-by: Zhou Shengqing <zhoushengqing@ttyinfo.com>
> ---
>  drivers/pci/pci-acpi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 4f9e0548c96d..47caad28a133 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1257,6 +1257,10 @@ void acpi_pci_add_bus(struct pci_bus *bus)
>         if (!pci_is_root_bus(bus))
>                 return;
>
> +       if (!acpi_check_dsm(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid,=
 3,
> +                               BIT(DSM_PCI_POWER_ON_RESET_DELAY)))
> +               return;
> +
>         obj =3D acpi_evaluate_dsm_typed(ACPI_HANDLE(bus->bridge), &pci_ac=
pi_dsm_guid, 3,
>                                       DSM_PCI_POWER_ON_RESET_DELAY, NULL,=
 ACPI_TYPE_INTEGER);
>         if (!obj)
> @@ -1418,6 +1422,10 @@ static void pci_acpi_optimize_delay(struct pci_dev=
 *pdev,
>         if (bridge->ignore_reset_delay)
>                 pdev->d3cold_delay =3D 0;
>
> +       if (!acpi_check_dsm(handle, &pci_acpi_dsm_guid, 3,
> +                               BIT(DSM_PCI_DEVICE_READINESS_DURATIONS)))
> +               return;
> +
>         obj =3D acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 3,
>                                       DSM_PCI_DEVICE_READINESS_DURATIONS,=
 NULL,
>                                       ACPI_TYPE_PACKAGE);
> --

The code changes look reasonable to me, although it would be cleaner
to use a local variable for the revision instead of repeating the
number 3 multiple times, but please add the "PCI/ACPI:" prefix to the
subject.

