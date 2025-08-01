Return-Path: <linux-pci+bounces-33269-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C1CB17DD0
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 09:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD43C563E85
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 07:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04BA1F4297;
	Fri,  1 Aug 2025 07:53:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C491273FD;
	Fri,  1 Aug 2025 07:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754034794; cv=none; b=ORuHGUx1Uqr5WPlN5c5uMbce2gwhhFjFDT/YkznnTBQcZQxhcEGbGmvDIKIYSvR/0ADh/GSo0U78gmJLsGsEcrByca0MJkM6biCdIExFSGoQUR207YnY7gqrdrAmADUmNI6ACXxuHXD/Fz69fDhDRKC3MVEG1++htDUzpIZXrsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754034794; c=relaxed/simple;
	bh=oLgt1/cGb6EuE5nSEM0TtuVrL7A1aY7RnNmfEhjf0n8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g0PLYgi3Wz066GhZoNd1bApQ0e59gkDKByZLZW3Oyub6ljNo7nKqpJr722aEeRxYaGXhNvV2exK/igvYWqUd7Q8wN/bCD9UxoYash+1W9cbT6m1d+kVnwJbocbaPRc/BVxLqlLHgS+y1NKcQwWHRIaiPASl6UE/k+0ocBpaiVWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4efbfe9c7a5so1911453137.0;
        Fri, 01 Aug 2025 00:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754034792; x=1754639592;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DzFKrk5qEr4Es0kahjlnt5GIGR4PQyQRZQNgTseC61A=;
        b=vryZUWSRRCI44yxBAjBHKelBomnZ2acDL5oLyJJLahRklYO9wm64G/aFFasYdw51iT
         CsN+sQa/uoWaskdNW649GlTtL+sTE1YDL7Ay6Zrik4zkJZqvknprEYRG61mopv7nTOvs
         8JAKoWschVh4TIJNza3r81LVluw/G01wVcRz4RX5Kd7YukW7QTCZ7SC/3G4r0AXipOvJ
         Cx03fVc38btJGz9vJN7IJryArUazkvomH0PFixEAwh/6MFSw4u/V8aAIfXZU0fOFR/RT
         D99cXbjfleHysMyI68NxN/vNG5K/M0CYdSostkvfII4NOnY9hKQZj32noD8OG5qSXifk
         a/EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCUb4Zq8eidVQYYMIFjMc63FOwciGEAzqIr3IDedI3b061NSEpiBwuos87GQ1tx5XdQ+TjFoSJVo/TZg==@vger.kernel.org, AJvYcCUdNNGXbwfi2/I/q0fSBwPfznZk5qIbICBJjwvtyb9Z701nP92QhCCzLjwl9uCpSaFvPbZjovMO8i7oqQw=@vger.kernel.org, AJvYcCUvqv2ySP5whsoIpXyPL23jFX1mxlEKFp2YgzamqlYVs6COqP9ZXIt4nYK8QCf3DwfJHGjELDRw02Iu@vger.kernel.org, AJvYcCXHiZC4T8AVbT/5N2d968rOZtLv/G+njlby6/sNsfsErAi9p/qWF8fUvrPeR+2Gxnh7ay4e+qMAP2W+Og==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs/icqbCPrUZTO1jhxuoKChFX3/0EoxhFqbxtWl/cLOFWnocYB
	OenYADsmSafiu1iwHzk8MyI1ZUY6oKpKVOHFIQv0iY2MVUe9XpK6OEqRvI+XXbXV
X-Gm-Gg: ASbGncvDbXoMGbaJEJPNa9cUEYzxfiXjAqmTobfrcZZYvd8UsF8eM2GTUcMfoeqVDib
	UGiIoIl/lje80WiJkiqStMi3IbhGKH+GE/FHLwtRUMEqNe8FnQzvGvjJbZ9jYXdPY0jXSConZkn
	pzlZlQRxXLEqJbPxd7oqxqMMoEENVgkZsnwat8Bi3NhM4hW+PsbFZ5far+litpRGZ9W4KBR1MKf
	OBo6wm3DKN1FTXAinkBElYpz0jkBEHQ+FtJ3TRqjUDFQoJSGWvwC9UAOEX4KK5r+BSi2CBn9KAb
	0NJiWOcJmHyvWEQCFi/RBPpk9pXofLTkgJ2srJQjEtw80gv3lpCIM9jBYqSlc/tVQK9UnUk7/C1
	djCghDjTdIOSgAK7Mb3z71vjgHYBy6J6BCacIc+zBHkOQh85C1JfKH199kvPM
X-Google-Smtp-Source: AGHT+IH8ZCF1y9qER27dQCY8WWuoBK9OLgaVzKvECUpp4rg+YPt02uN4bfERbxFbjgUdHD1tauAoJw==
X-Received: by 2002:a05:6102:324e:10b0:4f3:2f5f:c2e8 with SMTP id ada2fe7eead31-4fc0fe5e086mr1838199137.1.1754034791710;
        Fri, 01 Aug 2025 00:53:11 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88d8f3f0c5dsm754672241.13.2025.08.01.00.53.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 00:53:10 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4fc2132cc97so538634137.1;
        Fri, 01 Aug 2025 00:53:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWSAkB8dMewm47egHPwhelcGYuhFEE57+rhCo1mKCwGhm+7eLi7MEr2pTyLL1ZWw33UcjjdI+DeLpM/tVo=@vger.kernel.org, AJvYcCX4cQ3aArJw8nVnqS5OMX1BROBpt3Ir4KwsiR2FdgRwOxKoeQnHPUzSTeGoedOieaUKVA+qPLtLXL+d@vger.kernel.org, AJvYcCX4qh0yT+F8IrFCZMSwzuZh5h3JO/waU8jkDGvL8p3T6hUv/TQZKjtl/hEAwDwJB6bPyN88wmnfTkd9EQ==@vger.kernel.org, AJvYcCXAuoD9ZlDWx+KDhut2KvIkBMwqFhrgwjG0cM21mvK2HbcG01Hf3drkOT0GDuz1n8hV9NHkmOm3ShgDKw==@vger.kernel.org
X-Received: by 2002:a05:6102:6102:10b0:4fb:f495:43ec with SMTP id
 ada2fe7eead31-4fc1014a568mr1725889137.12.1754034790307; Fri, 01 Aug 2025
 00:53:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4e10bea3aa91ee721bb40e9388e8f72f930908fe.camel@linux.ibm.com> <20250731173858.1173442-1-gbayer@linux.ibm.com>
In-Reply-To: <20250731173858.1173442-1-gbayer@linux.ibm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 1 Aug 2025 09:52:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVwFeV46oCid_sMHjXfP+yyGTpBfs9t3uaa=wRxNcSOAQ@mail.gmail.com>
X-Gm-Features: Ac12FXxryTPC1ndd8ms1Hjwe7h8qRvkBWHnbRS0kseU5i-4Dc5zEC3g15MUQeuA
Message-ID: <CAMuHMdVwFeV46oCid_sMHjXfP+yyGTpBfs9t3uaa=wRxNcSOAQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: Fix endianness issues in pci_bus_read_config()
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: 18255117159@163.com, bhelgaas@google.com, helgaas@kernel.org, 
	agordeev@linux.ibm.com, borntraeger@linux.ibm.com, 
	ilpo.jarvinen@linux.intel.com, jingoohan1@gmail.com, kwilczynski@kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-next@vger.kernel.org, linux-pci@vger.kernel.org, lpieralisi@kernel.org, 
	mani@kernel.org, robh@kernel.org, schnelle@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hi Gerd,

On Thu, 31 Jul 2025 at 20:57, Gerd Bayer <gbayer@linux.ibm.com> wrote:
> Simple pointer-casts to map byte and word reads from PCI config space
> into dwords (i.e. u32) produce unintended results on big-endian systems.
> Add the necessary adjustments under compile-time switch
> CONFIG_CPU_BIG_ENDIAN.
>
> pci_bus_read_config() was just introduced with
> https://lore.kernel.org/all/20250716161203.83823-2-18255117159@163.com/
>
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>

Thanks for your patch!

> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -89,15 +89,24 @@ int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32 size,
>                         u32 *val)
>  {
>         struct pci_bus *bus = priv;
> +       int rc;
>
> -       if (size == 1)
> -               return pci_bus_read_config_byte(bus, devfn, where, (u8 *)val);
> -       else if (size == 2)
> -               return pci_bus_read_config_word(bus, devfn, where, (u16 *)val);
> -       else if (size == 4)
> -               return pci_bus_read_config_dword(bus, devfn, where, val);
> -       else
> -               return PCIBIOS_BAD_REGISTER_NUMBER;
> +       if (size == 1) {
> +               rc = pci_bus_read_config_byte(bus, devfn, where, (u8 *)val);
> +#if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
> +               *val = ((*val >> 24) & 0xff);
> +#endif

IMHO this looks ugly and error-prone.  In addition, it still relies
on the caller initializing the upper bits to zero on little-endian.

What about:

    u8 byte;

    rc = pci_bus_read_config_byte(bus, devfn, where, &byte);
    *val = byte;

> +       } else if (size == 2) {
> +               rc = pci_bus_read_config_word(bus, devfn, where, (u16 *)val);
> +#if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
> +               *val = ((*val >> 16) & 0xffff);
> +#endif

and:

    u16 word;

    rc = pci_bus_read_config_word(bus, devfn, where, &word);
    *val = word;

> +       } else if (size == 4) {
> +               rc = pci_bus_read_config_dword(bus, devfn, where, val);
> +       } else {
> +               rc =  PCIBIOS_BAD_REGISTER_NUMBER;
> +       }
> +       return rc;
>  }
>
>  int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

