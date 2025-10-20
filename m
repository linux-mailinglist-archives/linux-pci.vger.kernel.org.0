Return-Path: <linux-pci+bounces-38756-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCA8BF1A00
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 15:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CDEF4F824B
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 13:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29FF32AADE;
	Mon, 20 Oct 2025 13:42:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B055432AAD8
	for <linux-pci@vger.kernel.org>; Mon, 20 Oct 2025 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967767; cv=none; b=WMDseSIf6XdijxPMRu0vKkH8l29SjQIeNW1ik1OfnWj6achC1zjm2pafk0qP7YfpXrMHwCz4pBNNJer26m130KzSD4gmuBhz3Fb762Q1kcR3I+Fve6T0AOUkpAmoUBpKrwh14UMHNLqmoCJaoMdZ+faRy8pL8n17ktNVUElfvVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967767; c=relaxed/simple;
	bh=OBcex5OTPX795T0RzQ28tSO2c+mInHsmWctTSaRbFL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pt3HA3PtOWOAjkOP4z/YRuP/GmBORWb2JWzCnU+pYKtmoJ75BCkB/syTsxZIvWbSehz/vk92LmTWUOfUR3e//vl58ugBEaAC/zzRb2OqpQ8CTKxdHg4B+6egNJMi6aHZPjCKxVuoy4D+UbV2Q5D+Z+JqOkHg3I9iVDNFsiYi5fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-54aa0792200so3328742e0c.3
        for <linux-pci@vger.kernel.org>; Mon, 20 Oct 2025 06:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760967764; x=1761572564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VaoJvkckgwvI7BiUEGUU/6/pih+zeGwr4mjBxmqvp+k=;
        b=opqd/x7awv2HZUXXbGvnymqe/a7pPaQoQss2a60SLASpDjvcVfgbED/QQnggmcUxLx
         GpZkGAs23mDLvr1+7+7K0k8jV0k6LqT9y0XuN5RCcEfJWnsofNbj/jTDdC3otvtgS3fK
         T21B7X6cY+JAjGrOmDAVbhkDMPUZhm6yGkeGgBsPEImKxNykgIC9otnd4JK8qOLYOtWd
         +r6VqcoOr2uC07qmNV/+hVcde8CvOhHhN5cREPLvi6hxHLyOp5b4LV/XXd5jMP1vRV5I
         Y8Y76kse3kZifzTUFVsJkGij5IbT/hlzX6NEG49ip8xuNL7xMtGUxABJqOhsDFXx8ncg
         nqBQ==
X-Gm-Message-State: AOJu0Yxbvpwgq2BP5t740lbDboxwMDUWqgqHOvq4kRp/MMjwiN+CETRA
	II45Ec+LFJNGbbA0mBjk4+MYTSSxqxNeMUaxPEqx0QYk6ULQi5RMT5oiaPjCXOYi
X-Gm-Gg: ASbGncvgSz687Kb3d7f9l+Ubu/wJvLC+4e997Dlq4RKSbmSCbGOMSOKkwca/V4QmH9p
	qv4LB9F37WFbHDs+a91t3kIhx015dQXilf/ISaczEzg+JW5jGBRxddemkS71AaAlGOOZYhvO0EA
	YPtPE/dgYDxcOAGO9F4Ro9FHBIZk8U/ba8KcDq1e/IXExungQBhG8kYID1sR095me3ez6PW84bu
	0UBHwxiRqQJsSJ0NwYjY7Vo6ssp0bFR9MWvdx6Gp1uJH9Nq1tRAaypt32ia3kudaMpJD8NXLIeb
	/bFwrBH1d8SsldN5M9KS3pxxkbglO4PigorN7lKEuvYUNrQDn1dYaGZz3D4xLX4DS48w3CbbuIm
	dbbRrCjCzD0uhhzCqhHptpZFLY4O6fWjsQAMS4hmdKDQO9qSEobc9GTezuHS5r5kzbeDWtuozQA
	NXkOoNBug7zXZIvYllD5TTtbWRfbHdAP38dUfwXQ==
X-Google-Smtp-Source: AGHT+IHHzimHaBS/8M8C9kQefE+2DrGK6vqf/j/8X72yeDif1mBdScugzLs5gR4YUxYoj/DKkSSQaA==
X-Received: by 2002:a05:6122:8c0b:b0:54a:70d3:66b0 with SMTP id 71dfb90a1353d-5564ef4fc9cmr4010564e0c.12.1760967764378;
        Mon, 20 Oct 2025 06:42:44 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5566211708bsm2294976e0c.22.2025.10.20.06.42.43
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 06:42:43 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5d3fb34ba53so3735427137.1
        for <linux-pci@vger.kernel.org>; Mon, 20 Oct 2025 06:42:43 -0700 (PDT)
X-Received: by 2002:a05:6102:30dc:10b0:5d7:e095:9398 with SMTP id
 ada2fe7eead31-5d7e095983dmr2892907137.30.1760967763055; Mon, 20 Oct 2025
 06:42:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010144231.15773-1-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20251010144231.15773-1-ilpo.jarvinen@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 20 Oct 2025 15:42:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVwAkC0XOU_SZ0HeH0+oT-j5SvKyRcFcJbbes624Yu9uQ@mail.gmail.com>
X-Gm-Features: AS18NWAs9KN2FaEXaNCdOiFdwPBQPDTNxUr11vq1wTHrkD5pV6effUucshx_MRw
Message-ID: <CAMuHMdVwAkC0XOU_SZ0HeH0+oT-j5SvKyRcFcJbbes624Yu9uQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] PCI & resource: Make coalescing host bridge windows safer
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Kai-Heng Feng <kaihengf@nvidia.com>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.or>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilpo,

On Fri, 10 Oct 2025 at 16:42, Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
> Here's a series for Geert to test if this fixes the improper coalescing
> of resources as was experienced with the pci_add_resource() change (I
> know the breaking change was pulled before 6.18 main PR but I'd want to
> retry it later once the known issues have been addressed). The expected
> result is there'll be two adjacent host bridge resources in the
> resource tree as the different name should disallow coalescing them
> together, and therefore BAR0 has a window into which it belongs to.
>
> Generic info for the series:
>
> PCI host bridge windows were coalesced in place into one of the structs
> on the resources list. The host bridge window coalescing code does not
> know who holds references and still needs the struct resource it's
> coalescing from/to so it is safer to perform coalescing into entirely
> a new struct resource instead and leave the old resource addresses as
> they were.
>
> The checks when coalescing is allowed are also made stricter so that
> only resources that have identical the metadata can be coalesced.
>
> As a bonus, there's also a bit of framework to easily create kunit
> tests for resource tree functions (beyond just resource_coalesce()).
>
> Ilpo J=C3=A4rvinen (3):
>   PCI: Refactor host bridge window coalescing loop to use prev
>   PCI: Do not coalesce host bridge resource structs in place
>   resource, kunit: add test case for resource_coalesce()

Thanks for your series!

I have applied this on top of commit 06b77d5647a4d6a7 ("PCI:
Mark resources IORESOURCE_UNSET when outside bridge windows"), and
gave it a a try on Koelsch (R-Car M2-W).

Impact on dmesg (for the first PCI/USB) instance:

     pci-rcar-gen2 ee090000.pci: host bridge /soc/pci@ee090000 ranges:
     pci-rcar-gen2 ee090000.pci:      MEM 0x00ee080000..0x00ee08ffff
-> 0x00ee080000
     pci-rcar-gen2 ee090000.pci: PCI: revision 11
     pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
     pci_bus 0000:00: root bus resource [bus 00]
     pci_bus 0000:00: root bus resource [mem 0xee080000-0xee08ffff]
     pci 0000:00:00.0: [1033:0000] type 00 class 0x060000 conventional
PCI endpoint
    -pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]: no initial
claim (no window)
     pci 0000:00:00.0: BAR 0 [mem size 0x00000400]
    -pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]: no
initial claim (no window)
     pci 0000:00:00.0: BAR 1 [mem size 0x40000000 pref]
     pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310 conventional
PCI endpoint
    -pci 0000:00:01.0: BAR 0 [mem 0x00000000-0x00000fff]: no initial
claim (no window)
     pci 0000:00:01.0: BAR 0 [mem size 0x00001000]
     pci 0000:00:01.0: supports D1 D2
     pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
     pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320 conventional
PCI endpoint
    -pci 0000:00:02.0: BAR 0 [mem 0x00000000-0x000000ff]: no initial
claim (no window)
     pci 0000:00:02.0: BAR 0 [mem size 0x00000100]
     pci 0000:00:02.0: supports D1 D2
     pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
     PCI: bus0: Fast back to back transfers disabled
     pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080fff]: assigned
     pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810ff]: assigned
     pci_bus 0000:00: resource 4 [mem 0xee080000-0xee08ffff]
     pci 0000:00:01.0: enabling device (0140 -> 0142)
     pci 0000:00:02.0: enabling device (0140 -> 0142)

I.e. the "no initial claim (no window)" messages introduced by commit
06b77d5647a4d6a7 are no longer seen.
The BARs still show "mem size <n>" instead of the "mem <start>-<end>"
before commit 06b77d5647a4d6a7, though.

This series has not impact on /proc/iomem, or on the output of
"lspci -v" (commit 06b77d5647a4d6a7 also had no impact here).
I.e. the part of /proc/iomem related to the first PCI/USB instance
still looks like:

    ee080000-ee08ffff : pci@ee090000
      ee080000-ee080fff : 0000:00:01.0
        ee080000-ee080fff : ohci_hcd
      ee081000-ee0810ff : 0000:00:02.0
        ee081000-ee0810ff : ehci_hcd
    ee090000-ee090bff : ee090000.pci pci@ee090000

I hope this matches your expectation.s

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

