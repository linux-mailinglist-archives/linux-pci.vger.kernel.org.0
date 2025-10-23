Return-Path: <linux-pci+bounces-39121-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFD4BFFBE2
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 09:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68EC03AC51F
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 07:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8352E2EF0;
	Thu, 23 Oct 2025 07:55:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA6E2E1C69
	for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 07:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761206141; cv=none; b=HtEdQO+4Iv7E89DxvQl8V4RSuOuUOcGzEhMXMVgJdg70/eGRgM8sR2PeUU+ygD5M0u9JEPmtSfVdTEo9PRT0solpzxDEGSQr2KbjWn1KTSUFY9I36otH/I4bnF+s4L0A1jPdVc06eH8cjZtYxMBxs2qTdOSMTqJXntergT/lKtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761206141; c=relaxed/simple;
	bh=+fB56hRZm4s/9A94T+9AsJSw3DZkXg6RPZ3NqE6zskM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZKTWlrJr3MPk9Nby1mo95FSjsTz77+Dl66NtldcPV2ukx7Xu8nG64c3pJ1odEM01LHHltA/3YgMC1RRp0/UPI+5v1CDngdRVVUF2by+VqrRrHFOmvZkhJK1ZjCBSUo9stxFQU4kOwt+UCqEaFdh5aPzuL3u8NLlXdtuwacG8AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-556694876eeso244298e0c.3
        for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 00:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761206138; x=1761810938;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e1VWeQnGLaqOMfwGg5f7EVJzLAyxDuT3Je9LnDxvdps=;
        b=ipve0m9C2Y9R0WFxRA3MYqx5RlH3HolblKvAD5sX+u6YuSp2FYX8TPI0b3M/JEkszL
         RAAuvO3Z7+QVWr+yZQfzhbbIHTguLHIuuKQ7CQpM8foRjd7gpowv+wz3rWHTI7lzEKh1
         S191on8nbBVhm5FS49uDmBckjKp3Pdf31O1PXqdplOMf4lmm/9M/UnGcRPHDavBUYbt3
         H6heAWR8qQLvTba4d++E3WM3cLChJ36pNsuzpmAdi0rjXCx4zqF7UAp7aLzaFjcp75pQ
         PEgMqAxhXFOv5KotkHQnyQC9msf6ze8VPAORqkjC4Vj86O+S65e9TELuDh/N9m3LJuni
         pw2w==
X-Forwarded-Encrypted: i=1; AJvYcCUEJSS6/zDHA40zvgff6JdUTwVn+4EB1EmaL9jz9aP+6i9/g+HvLH9h6zvSZ6n8i3qb16iYw9eo1sU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWhJ5dXnBGrwjPijeGLU7zD2hC0UUvt3hgtGQq0izlYwvwnBBw
	sVYOxP6yfSCk4F9xi7gRYTOQWV1d5OTG/iDq2j6G+aVTE4N0S4ZIc1CvKliUJUPy
X-Gm-Gg: ASbGncvQLfknK31/VzeQORwROtaXniZeL7spnPEpQfl/TtR9s6/KMzTAHX/rEy3bpQc
	xLbwKJj60wh/o026/q+6v7vTt+Cu8VTydju8JOcZjoUhh216ktKl3wq5hK3avXgYO7+OxpDehkS
	A4eCLOpK9+fxsrHsJtGpwkfjka9Eu/Q8iC5o0LcaJdPqQVy6gLtJj+4Le9FUjxm9oqtz6JpKVRV
	DkP9Kjyd6KOIb/TjAFVdDavRzyQRUPO5jEwi/Wqls3benYGT1+UZdhIBwl4TyuKr+3SswMvG/yu
	MDkrf90EaLKogrOU/iPY2euobQ4381dHpyzbYUT0ZOeEngmfire0Q2mLOUwXDjOe9+71DrXipKC
	JbwGkEXLfiYgQ0rgqWrkst66Kcr6g5VsPNRltumMyg5M1xKeQ1uGBzlmb+s2Y0+Vv1xwJ0DzsP4
	hZpcoEJ0znAub6JyKn2xPg5eAjAzFnWxcJ3rstEA==
X-Google-Smtp-Source: AGHT+IGnZ3VOT5GmrEDBkaHDA7TH3L9+OKtLsLQ+8dTDkDwGp6wANp5/rpT28WT193vczIOYpIDdzA==
X-Received: by 2002:a05:6122:4695:b0:542:d782:2522 with SMTP id 71dfb90a1353d-5564ef1b76dmr7854648e0c.14.1761206138077;
        Thu, 23 Oct 2025 00:55:38 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557bdbbba23sm506136e0c.13.2025.10.23.00.55.36
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 00:55:36 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5d28f9b4c8cso545104137.2
        for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 00:55:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQH1Ja2QEmNkjWvRgaY5cG6HHOaALjszw04PoBK235qGp3OpI1jvdMcaPzUY6qqdkdmWvP2Mp3vQg=@vger.kernel.org
X-Received: by 2002:a05:6102:38cb:b0:5db:337d:65c6 with SMTP id
 ada2fe7eead31-5db337d6988mr173700137.23.1761206136224; Thu, 23 Oct 2025
 00:55:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007133657.390523-3-claudiu.beznea.uj@bp.renesas.com> <20251022194939.GA1223383@bhelgaas>
In-Reply-To: <20251022194939.GA1223383@bhelgaas>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 23 Oct 2025 09:55:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVLXd-eVX0UBPYtrzVPbA6VkdD1rHBAWMKgrYKE+Aa2bw@mail.gmail.com>
X-Gm-Features: AS18NWCwdsxUw7zogPqVrxEDzYqaWGHMFOcHzYZ5pvVfO4qa6VaOrBUa-VfGcUI
Message-ID: <CAMuHMdVLXd-eVX0UBPYtrzVPbA6VkdD1rHBAWMKgrYKE+Aa2bw@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] PCI: rzg3s-host: Add Renesas RZ/G3S SoC host driver
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Claudiu <claudiu.beznea@tuxon.dev>, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	mani@kernel.org, robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, 
	conor+dt@kernel.org, magnus.damm@gmail.com, p.zabel@pengutronix.de, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"

Hi Bjorn,

On Wed, 22 Oct 2025 at 21:49, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, Oct 07, 2025 at 04:36:53PM +0300, Claudiu wrote:
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > The Renesas RZ/G3S features a PCIe IP that complies with the PCI Express
> > Base Specification 4.0 and supports speeds of up to 5 GT/s. It functions
> > only as a root complex, with a single-lane (x1) configuration. The
> > controller includes Type 1 configuration registers, as well as IP
> > specific registers (called AXI registers) required for various adjustments.

> > +++ b/drivers/pci/controller/pcie-rzg3s-host.c
>
> > +#define RZG3S_PCI_MSIRCVWMSKL                        0x108
> > +#define RZG3S_PCI_MSIRCVWMSKL_MASK           GENMASK(31, 2)
>
> Unfortunate to have to add _MASK here when none of the other GENMASKs

Actually the unused RZG3S_PCI_MSIRCVWMSKU below would
need one, too:

    #define RZG3S_PCI_MSIRCVWMSKU_MASK   GENMASK(30, 0)

> need it.  Can't think of a better name though.

MASK is a good name, as the register bits actually specify (part of) the
window mask.

>
> > +#define RZG3S_PCI_MSIRCVWMSKU                        0x10c
>
> Unused.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

