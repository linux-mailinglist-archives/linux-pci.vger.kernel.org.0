Return-Path: <linux-pci+bounces-6382-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EA08A8D3C
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 22:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8AB01F22B87
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 20:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0426F45C18;
	Wed, 17 Apr 2024 20:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROod1YNp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469C137714;
	Wed, 17 Apr 2024 20:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713386886; cv=none; b=O+FQurfpOV+FswoLtNoAh2Ab0xAblXjgCUwOlZn+aJuglxwc92cQA+a/cdFAV4pYATBlzqSwI/2UyYmDtu5wC1ifO1nnfqlTEhMH4s0+zsPBHkwQREnTnXBrBhbIx8ED62Mcr4voIwViXkMYs5599CRXHf5TXM8Cr1WfruZzIi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713386886; c=relaxed/simple;
	bh=itT3Xbx1cVEBvsmTptNUis8l1Fg79TZadC4YOyQtcB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AHnyJ4zviC3f6K1MTjm0Ok3Mg5hHrNi5aG3Z+Vxi1WfKVPhihVm4YZw7lS33kGDgYiyoMXpqMGMJL25TkGM+MXCrt4v0MfrrcSkQFJ7TOWhYiV21iV1NzML4xnReg+QWkZckUE7EKnqXsXNSE08rvl6Eai6N9T017b790EyzT8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROod1YNp; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a554afec54eso5565066b.1;
        Wed, 17 Apr 2024 13:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713386883; x=1713991683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkmSOGpuvFSDaqy8aZNbec5Ti86QPJM57/OjON54+0c=;
        b=ROod1YNpCH3CPOoSN0yOSU4dg4TZyCcT8AdNyHhpZk+njiDZqx/xxED92i8udilhWC
         K1MtDeP41t2/MXDGNGlBs8P9Dz38uMvTfNFz4UeXSEbK4B3PAvGpMxvD1OyeOtCsWyTM
         j/od15U1ESbU3PlJJk3MtzQ8r6D4xrXXIURFFWnQpWrWqJUBA+vjIJAp1xb1EfWqLPv9
         xCTIoZmOLAzoupNSArmfZi0dR3SR7ll8OnkqUzxI+DQeJOTfzUklz3d/JF+Dj+TXSbFP
         kLm5/cM2CkU5tCil6rMy2CM6p8Q0/BEUHUMq93WSzTV0vnOhH5Io5KuQsjYPjaoMids+
         tXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713386883; x=1713991683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkmSOGpuvFSDaqy8aZNbec5Ti86QPJM57/OjON54+0c=;
        b=jmgAXuTAtr5v5mgl5+rP3ifcj22vLA8J+ngPJa8UNy+ldsJTLvSf6oC18Ifk0Udn1m
         bzOHw6qrdz2IUJ2pAi7V9bVXzS6ZMYJBbRDQ77b3XfdEdrDYCkcHUQF4imW/BoJL+BoQ
         l3KYsawRMhof39Wh4dqsvLXqybzD+ehNvJzZ7WEna8ndZvvhlnlWgnpEhWuJYqpGjKL2
         gacvEZJMQOxr3codCjvBRlNL3Uck34KstKYkR7QI1JVitliwWL2T4SiQ1a+93QuAkxgY
         K8H59OxDGrgT1MaHJTX97150PKgPc8Fjr+4Oguow03ywpD6bw3vXZuwihn3nkdKIU42Y
         HJXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGrpO84j2hdgYGfVDCP84fToj5n7b+aH7WrEvuFaAEIYRi5gIE7WanRUxOWym+n9oQJ3mPrvDIcC14LJkTTOYwsXxYfLF5UvuZubnjHChmPT4kUdTv4iqlNLJ8A3OIZ45D9U3p
X-Gm-Message-State: AOJu0YzBXvTlXSh1jQFECnY/4AmEoV3Za7p2vYlemNgHOmrihV/aGAiF
	C40clPj75PEUREW8OK/g0o9KSOLZo55d8tK1WUd8ZDgwxfSPg0+sahEeVC1lCfr32YNC9gPDlCK
	f6zo2WT07UVTWZgC+5wUrcELzwCs=
X-Google-Smtp-Source: AGHT+IFWKy6Z2tnzpTx0I9+3+muzLVTdowcM1WgduksZJ3zssj1ODGEy5yRtQBnaF1uJcqRm741WkmcZxva4alRbh2I=
X-Received: by 2002:a17:906:ae46:b0:a55:5ddd:ec0f with SMTP id
 lf6-20020a170906ae4600b00a555dddec0fmr406480ejb.12.1713386883381; Wed, 17 Apr
 2024 13:48:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417204012.215030-1-helgaas@kernel.org> <20240417204012.215030-2-helgaas@kernel.org>
In-Reply-To: <20240417204012.215030-2-helgaas@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 17 Apr 2024 23:47:27 +0300
Message-ID: <CAHp75Vd58Z1X05YMa_03eZi48h2kY9q+0v8ymscQ2-HdU33tHw@mail.gmail.com>
Subject: Re: [PATCH 1/1] x86/pci: Skip early E820 check for ECAM region
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Mateusz Kaduk <mateusz.kaduk@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Tj <linux@iam.tj>, 
	Hans de Goede <hdegoede@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 11:40=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Arul, Mateusz, Imcarneiro91, and Aman reported a regression caused by
> 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map").  On the
> Lenovo Legion 9i laptop, that commit removes the area containing ECAM fro=
m
> E820, which means the early E820 validation started failing, which meant =
we
> didn't enable ECAM in the "early MCFG" path
>
> The lack of ECAM caused many ACPI methods to fail, resulting in the
> embedded controller, PS/2, audio, trackpad, and battery devices not being
> detected.  The _OSC method also failed, so Linux could not take control o=
f
> the PCIe hotplug, PME, and AER features:
>
>   # pci_mmcfg_early_init()
>
>   PCI: ECAM [mem 0xc0000000-0xce0fffff] (base 0xc0000000) for domain 0000=
 [bus 00-e0]
>   PCI: not using ECAM ([mem 0xc0000000-0xce0fffff] not reserved)
>
>   ACPI Error: AE_ERROR, Returned by Handler for [PCI_Config] (20230628/ev=
region-300)
>   ACPI: Interpreter enabled
>   ACPI: Ignoring error and continuing table load
>   ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PC00.RP01._SB.PC0=
0], AE_NOT_FOUND (20230628/dswload2-162)
>   ACPI Error: AE_NOT_FOUND, During name lookup/catalog (20230628/psobject=
-220)
>   ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0010)
>   ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PC00.RP01._SB.PC0=
0], AE_NOT_FOUND (20230628/dswload2-162)
>   ACPI Error: AE_NOT_FOUND, During name lookup/catalog (20230628/psobject=
-220)
>   ...
>   ACPI Error: Aborting method \_SB.PC00._OSC due to previous error (AE_NO=
T_FOUND) (20230628/psparse-529)
>   acpi PNP0A08:00: _OSC: platform retains control of PCIe features (AE_NO=
T_FOUND)
>
>   # pci_mmcfg_late_init()
>
>   PCI: ECAM [mem 0xc0000000-0xce0fffff] (base 0xc0000000) for domain 0000=
 [bus 00-e0]
>   PCI: [Firmware Info]: ECAM [mem 0xc0000000-0xce0fffff] not reserved in =
ACPI motherboard resources
>   PCI: ECAM [mem 0xc0000000-0xce0fffff] is EfiMemoryMappedIO; assuming va=
lid
>   PCI: ECAM [mem 0xc0000000-0xce0fffff] reserved to work around lack of A=
CPI motherboard _CRS
>
> Per PCI Firmware r3.3, sec 4.1.2, ECAM space must be reserved by a PNP0C0=
2
> resource, but it need not be mentioned in E820, so we shouldn't look at
> E820 to validate the ECAM space described by MCFG.
>
> 946f2ee5c731 ("[PATCH] i386/x86-64: Check that MCFG points to an e820
> reserved area") added a sanity check of E820 to work around buggy MCFG
> tables, but that over-aggressive validation causes failures like this one=
.
>
> Keep the E820 validation check only for older BIOSes (pre-2016) so the
> buggy 2006-era machines don't break.  Skip the early E820 check for 2016
> and newer BIOSes.

> Fixes: 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map")
> Reported-by: Mateusz Kaduk <mateusz.kaduk@gmail.com>

> Reported-by: Arul <...>
> Reported-by: Imcarneiro91 <...>
> Reported-by: Aman <...>

Isn't bugzilla public enough? You may take emails from there, no?

...

> +               /*
> +                * 946f2ee5c731 ("Check that MCFG points to an e820
> +                * reserved area") added this E820 check in 2006 to work
> +                * around BIOS defects.
> +                *
> +                * Per PCI Firmware r3.3, sec 4.1.2, ECAM space must be
> +                * reserved by a PNP0C02 resource, but it need not be
> +                * mentioned in E820.  Before the ACPI interpreter is
> +                * available, we can't check for PNP0C02 resources, so
> +                * there's no reliable way to verify the region in this
> +                * early check.  Keep it only for the old machines that
> +                * motivated 946f2ee5c731.
> +                */

> +               if (dmi_get_bios_year() < 2016 && raw_pci_ops)

I probably missed something, but where does 2016 come from?
(I've been following the bz discussion)

> +                       return is_mmconf_reserved(e820__mapped_all, cfg, =
dev,
> +                                                 "E820 entry");
> +
> +               return true;
> +       }

...

>         if (pci_mmcfg_running_state)
>                 return true;
>
> -       /* Don't try to do this check unless configuration
> -          type 1 is available. how about type 2 ?*/
> -       if (raw_pci_ops)
> -               return is_mmconf_reserved(e820__mapped_all, cfg, dev,
> -                                         "E820 entry");
> -
>         return false;

Not strictly related to this patch, but now it can simply

  return pci_mmcfg_running_state;


In any case, LGTM,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

