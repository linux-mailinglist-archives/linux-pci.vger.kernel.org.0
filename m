Return-Path: <linux-pci+bounces-36693-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDB8B9201C
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 17:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB613ADAEC
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 15:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7CB2E7637;
	Mon, 22 Sep 2025 15:41:53 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35D12E7BDC
	for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2025 15:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555713; cv=none; b=VY9E+BWSI+/EFnUsQbDm95uAtovVoeTzzkgba+RfXnY1gMo6q2t8dD8ocxexyvQUtTXVg2YK7iCdtWjIU0CDhptNUL35eSHnV2STsqYHqW5YFAqv6c8Ty4MlV/e4l12znnFrOa/qYYwAErigeQYsJHJwojNX0Oc6DAHsbEp0zUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555713; c=relaxed/simple;
	bh=LPaxUgjulCIZky3hRfMrs4SMdXdUnOG63nKkquHAkQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NMCItYn5mvNi3pi9A+AQLyq06O4N2FMvwowENMwOg1r/RI7by9ke13ZPqJF0K+dWv6euzzlfdgDUFgZ5gF2hjb8/sRBYu9QQ7NoU2IOtcl83SpzHLepNrxci0aYAhRUsJd/nwjtothP6SQIEjOPNmWg/+W1Qrdi5RFqaHeFPiyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-8fea25727a9so265614241.1
        for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2025 08:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758555710; x=1759160510;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lkETsZJNMYJYRULnxLtQXFZTQmJ76gdUN2IchMcg1nI=;
        b=Lc0CDWAV+V3AOKRZIvk/sNE1Ninz6TwdaOCweBSQ8e1fETa43MrPY1VIQtJXTbV2HO
         ONCexFN302U27WDQ1hi/342Vso5gzcWP/FBDgTsTRnWTyyOfj+iA/eQp8ViJhiQPpaKe
         HEYFOODjKibLnXLS95walgjYKIQwCbJLUTit5R2SLrNpmEYWFe71uBLmd17tAgaIwfRq
         jiaiE1P9M61CED7McAo/XOWPDhlswcyT66K6B0b46SxclDmm4qSqnXpC283f9xZlAVa5
         81+0mrgM9bIq+De3Cp3Gr+KcO0CcWAt3KRYzz6oaY6p6bYcSYP6Pi1YTAMlUh6+iTYaP
         bP8A==
X-Gm-Message-State: AOJu0YyO4dsh9GIUucAiZNiKt1hVZFLAPkUMwJn0S0+RzQ3RHizZpdLS
	K1fCQ4c5aChPQ1bY9BtbBOOLauW3DcxVhLuwMbBvKT/NjluFPLTuODAsIAdm1cqc
X-Gm-Gg: ASbGncuPSunGq42RCVk/U5e+RUxItdYM7cxZDmQK012opbiepCiw9oIZeNxp14WpDHE
	KqxIBZas8W8r+DOjsBU/+UF4zcLgNI6MXawsPuapaL1jWxeNKmBd7AgXXp0Ly8bRcGrAjEZzABN
	JI+rpcfKE7orWKDLdtaGJtlYtxHc4YXq7tWgslm7ZqckLP99Pv9z/U8Ah3FurB7mSzfH9I7IzRA
	HMZhWvgk+YQz1pmXQsRTqCximxOVT7zXea4Sv4rOWmuxLuplVr5h3kktnrPxjwvh7DzefFl3weh
	ZRTOwZG7/Kj8B+ebLTbvAJUc5Z3Rdi/L4vqZ+IFw+qFi3h5vUr2RwZgu6cerJXK02ckQEm3J+2X
	/3L04Zqz2UBWhA+AsZkQLM/Xe4lZdcXb4YFtbGU7RpT87VOBaD22RXpdusMhb
X-Google-Smtp-Source: AGHT+IF3oH9M9Rpy/bZJ0z64RYAA5DM6t5f6ueJtWT5yST32cJaiFnOTJYdL3Uz3EFxIuAv5M/qArA==
X-Received: by 2002:a05:6102:621a:10b0:5a2:8ace:c921 with SMTP id ada2fe7eead31-5a28acee3b4mr761714137.4.1758555710297;
        Mon, 22 Sep 2025 08:41:50 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9000129f5adsm593600241.14.2025.09.22.08.41.48
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 08:41:48 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-59c662bd660so822370137.3
        for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2025 08:41:48 -0700 (PDT)
X-Received: by 2002:a05:6102:6890:b0:534:cfe0:f83e with SMTP id
 ada2fe7eead31-588d388f544mr3285300137.3.1758555708237; Mon, 22 Sep 2025
 08:41:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922153352.99197-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250922153352.99197-1-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Sep 2025 17:41:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUG_y-gb6kGd+Bgo5AQvqv009RYwVjwN5dDC0WFOuyPcg@mail.gmail.com>
X-Gm-Features: AS18NWCFEiYkOlpoRVmaYaX7WRJp7yXl-rQ_0FdjEskYo2uwSKVFu_hC0WhJkpE
Message-ID: <CAMuHMdUG_y-gb6kGd+Bgo5AQvqv009RYwVjwN5dDC0WFOuyPcg@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar-host: Add static assertion to check !PCI_LOCKLESS_CONFIG
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, 
	Rob Herring <robh@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

On Mon, 22 Sept 2025 at 17:34, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> This driver can not function correctly without PCIe subsystem level
> config space access serialization. In case PCI_LOCKLESS_CONFIG is
> ever enabled on ARM, complain loudly so the driver can be updated
> accordingly.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks for your patch!

> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c
> @@ -35,6 +35,14 @@
>
>  #include "pcie-rcar.h"
>
> +/*
> + * This driver can not function correctly without PCIe subsystem level
> + * config space access serialization. In case PCI_LOCKLESS_CONFIG is
> + * ever enabled on ARM, complain loudly so the driver can be updated
> + * accordingly.
> + */
> +static_assert(!IS_ENABLED(CONFIG_PCI_LOCKLESS_CONFIG));
> +
>  struct rcar_msi {
>         DECLARE_BITMAP(used, INT_PCI_MSI_NR);
>         struct irq_domain *domain;

This causes a build failure when compile-testing, e.g. x86 allmodconfig.
Using "depends on !PCI_LOCKLESS_CONFIG" instead would avoid that,
but indeed has the disadvantage that it wouldn't complain loudly when
PCI_LOCKLESS_CONFIG would ever be enabled on ARM64...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

