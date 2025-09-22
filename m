Return-Path: <linux-pci+bounces-36645-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB9AB8FF16
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 12:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC651888633
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 10:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D3E28A73A;
	Mon, 22 Sep 2025 10:10:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EA327F749
	for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2025 10:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758535842; cv=none; b=JgmXPZk4TrNGEpXTTozL95QSLXjZWPq1+IK91g0+GnV5W6KYJ1lo9RNNM+iWtAlQ12Gv43Du8j5T+ug44ANj47GAf7jrksh/XaIgOjqXMxS5GG8krJXVUHmaUSvOzhb0NIanslD4xYFTSK/230P9BlmLPANFEmZDUeyO9zTXlA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758535842; c=relaxed/simple;
	bh=FspzrHLrky+4lkt2kF+UuolK3snNnMgs7joBzDT6NC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j0jOyelyALqmzfDU6zbXE/AbVWJT1Cet2yTtK0PBxmAaV0m0HKGCcHE7Q2HVkHLEingfwqbk9S0IjI34LPkYgzSJjdLr+eJP2+T4GTQYYu1iHyWVgBYPapvsRk1TilC3udSwt1jbm9eAGDL7nVUj0AF0ggvuctoHvSRtgMuAJ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-54bbe260539so193877e0c.0
        for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2025 03:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758535839; x=1759140639;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lN/2AFdJRlCaGBjH8pLDCVNNR5NE43uZY5yxD6ZVYpI=;
        b=sOuh1xETFAGFPklWYS1dXOkrIQ5v+8HTFeIWeC9XCN3d0Fj0pbYaKHOrZUOQRDFvGR
         Pgajlnf3pVq1GHP4IZyLgdv/+gnKcqcnwfeSFcAiLNa61ThFEvPcor0KR0vyDLLTtjIF
         1F22zuQGL+xq7e2NZeRN3TFNCzGTNLqPSCUMsswV2TDnLGS7+uEuErQf2jTkAZZ2TEgK
         5zhPwj1Kz318KXhl7gvfjveaOQ6ceRSZY+t7zg1ckxrE0oI+A0vkwoN8xvGkQWyvgtRM
         e3CRUeXZrkjFQ/U1RBkixM0IuqZHiFB8wX5rnJ3+swJN/U4rvMkKRRKvLCctPY426/XB
         a5gg==
X-Gm-Message-State: AOJu0YzHSeO5NF7yk1dFghgEq7uAJyUiKnmvV4/2wLpjpg1/Z9qZ4z/w
	mYfToBqjrdenicDtHCZOgt+JRPK9yKZInT5S9sXXGX6fVPJZq7wsZy2k4KbrM+H3
X-Gm-Gg: ASbGncvAXpwVeffVNzQq8rEacraAcqOnAG2Apu2KAToKxxSBcU0MmdPuibvvhgKNYvF
	ts4eO949UUIvyF7rBqNUpm0PNPLr7Cal0adbXTUF41TSGwv2HGQ+DFGlYZ9tKebxHW4YESZzN/C
	OSLJ8Nrhz/Up4I25DrP02/xJ/Q/l5LNXxOtW3CSIlbRc60ylDw3CwZLE0L/OMcHX8Fx0E7IMQ5A
	OP6dHD8FMoq/V+faVPW0TCS46ps3OxMEYIYtzfUyrjn+deMzcA5y14YLnCKZuOmni4GvxXOld7h
	vxqA+5YDAb+/Mbri1MLCN0OrjdotO9Cz/w7GFcF6koEIwmLsbBY0xh4QXl5zMVBXeJJvPhdJ7pP
	dp1nKfvrSeNBwkgouNl/oyMRlh4NkhVy0E5OQrIJ202uY6mjpkQI58Sp7GZI5
X-Google-Smtp-Source: AGHT+IHscNI7ChqMHZTlFhnZiCz2IH094iENJuzxSW9uK6WLeLdiMD3MdCbXEBwg3SM5d+MK4uA1MQ==
X-Received: by 2002:a05:6122:3c50:b0:54b:be27:b541 with SMTP id 71dfb90a1353d-54bbe27bacbmr290051e0c.8.1758535839085;
        Mon, 22 Sep 2025 03:10:39 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54a91edb1f0sm1419143e0c.10.2025.09.22.03.10.38
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 03:10:38 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-574d36a8c11so1197304137.1
        for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2025 03:10:38 -0700 (PDT)
X-Received: by 2002:a05:6102:ccf:b0:5a3:acb7:55c7 with SMTP id
 ada2fe7eead31-5a3acb762dcmr223298137.18.1758535838265; Mon, 22 Sep 2025
 03:10:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915235910.47768-1-marek.vasut+renesas@mailbox.org>
 <CAMuHMdXAK6EhxPoNoqwqWSjGtwM24gL4qjSf6_n+NMCcpDf1HA@mail.gmail.com>
 <6fdc7d1e-8eaa-4244-a6b4-4a07e719dd73@mailbox.org> <CAMuHMdVrw1Mr_hKvgve03DQwvpqSPNaN5XUnYRJPXMeX1wvv0A@mail.gmail.com>
 <de4e4003-214f-4260-854c-d15efc81bb74@mailbox.org> <CAMuHMdVgFNb-3TgL7a+AJMYE6tqOiMpGYFDhXnQoz9R5gLz=-A@mail.gmail.com>
 <12b54030-5505-416b-9e4e-2338263c5c7a@mailbox.org>
In-Reply-To: <12b54030-5505-416b-9e4e-2338263c5c7a@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Sep 2025 12:10:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUnKqHQpaTkiuYUmR1kQ2GwVvj0SeML-9x3Rc+srtXW+w@mail.gmail.com>
X-Gm-Features: AS18NWBaRS0smuwIc1ctMzRWIC0440X1MQ0sF3CnTNk-8MKFaF6GpgdLzrsfJnQ
Message-ID: <CAMuHMdUnKqHQpaTkiuYUmR1kQ2GwVvj0SeML-9x3Rc+srtXW+w@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar-gen4: Fix inverted break condition in PHY initialization
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: linux-pci@vger.kernel.org, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

On Thu, 18 Sept 2025 at 05:16, Marek Vasut <marek.vasut@mailbox.org> wrote:
> On 9/17/25 9:23 AM, Geert Uytterhoeven wrote:
> > On Tue, 16 Sept 2025 at 18:31, Marek Vasut <marek.vasut@mailbox.org> wrote:
> >> On 9/16/25 3:57 PM, Geert Uytterhoeven wrote:
> >>> On Tue, 16 Sept 2025 at 15:39, Marek Vasut <marek.vasut@mailbox.org> wrote:
> >>>> On 9/16/25 11:59 AM, Geert Uytterhoeven wrote:
> >>>>> On Tue, 16 Sept 2025 at 01:59, Marek Vasut
> >>>>> <marek.vasut+renesas@mailbox.org> wrote:
> >>>>>> R-Car V4H Reference Manual R19UH0186EJ0130 Rev.1.30 Apr. 21, 2025 page 4581
> >>>>>> Figure 104.3b Initial Setting of PCIEC(example), third quarter of the figure
> >>>>>> indicates that register 0xf8 should be polled until bit 18 becomes set to 1.
> >>>>>>
> >>>>>> Register 0xf8 bit 18 is 0 immediately after write to PCIERSTCTRL1 and is set
> >>>>>> to 1 in less than 1 ms afterward. The current readl_poll_timeout() break
> >>>>>> condition is inverted and returns when register 0xf8 bit 18 is set to 0,
> >>>>>> which in most cases means immediately. In case CONFIG_DEBUG_LOCK_ALLOC=y ,
> >>>>>> the timing changes just enough for the first readl_poll_timeout() poll to
> >>>>>> already read register 0xf8 bit 18 as 1 and afterward never read register
> >>>>>> 0xf8 bit 18 as 0, which leads to timeout and failure to start the PCIe
> >>>>>> controller.
> >>>>>>
> >>>>>> Fix this by inverting the poll condition to match the reference manual
> >>>>>> initialization sequence.
> >>>>>>
> >>>>>> Fixes: faf5a975ee3b ("PCI: rcar-gen4: Add support for R-Car V4H")
> >>>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >>>>>
> >>>>> Thanks for your patch!
> >>>>>
> >>>>>> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> >>>>>> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> >>>>>> @@ -711,7 +711,7 @@ static int rcar_gen4_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable
> >>>>>>            val &= ~APP_HOLD_PHY_RST;
> >>>>>>            writel(val, rcar->base + PCIERSTCTRL1);
> >>>>>>
> >>>>>> -       ret = readl_poll_timeout(rcar->phy_base + 0x0f8, val, !(val & BIT(18)), 100, 10000);
> >>>>>> +       ret = readl_poll_timeout(rcar->phy_base + 0x0f8, val, val & BIT(18), 100, 10000);
> >>>>>>            if (ret < 0)
> >>>>>>                    return ret;
> >>>>>>
> >>>>>
> >>>>> This change looks correct, and fixes the timeout seen on White Hawk
> >>>>> with CONFIG_DEBUG_LOCK_ALLOC=y.
> >>>>> However, it causes a crash when CONFIG_DEBUG_LOCK_ALLOC=n:
> >>>>>
> >>>>>        SError Interrupt on CPU0, code 0x00000000be000011 -- SError
> >>>>
> >>>> ...
> >>>>
> >>>>>         el1h_64_error_handler+0x2c/0x40
> >>>>>         el1h_64_error+0x70/0x74
> >>>>>         dw_pcie_read+0x20/0x74 (P)
> >>>>>         rcar_gen4_pcie_additional_common_init+0x1c/0x6c
> >>>>
> >>>> SError in rcar_gen4_pcie_additional_common_init , this is unrelated to
> >>>> this fix.
> >>>>
> >>>> Does the following patch make this SError go away ?
> >>>
> >>>> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> >>>> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> >>>> @@ -204,6 +204,8 @@ static int rcar_gen4_pcie_common_init(struct
> >>>> rcar_gen4_pcie *rcar)
> >>>>            if (ret)
> >>>>                    goto err_unprepare;
> >>>>
> >>>> +mdelay(1);
> >>>> +
> >>>>            if (rcar->drvdata->additional_common_init)
> >>>>                    rcar->drvdata->additional_common_init(rcar);
> >>>>
> >>>
> >>> Yes it does, thanks!
> >> So with this one extra mdelay(1), the PCIe is fully good on your side,
> >> or is there still anything weird/flaky/malfunctioning ?
> >>
> >> If you could give me a RB/TB on this fix, it would be nice.
> >
> > You can have my
> > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > but only for the combination of both (A) "[PATCH] PCI: rcar-gen4: Fix
> > inverted break condition in PHY initialization" and (B) the addition
> > of the mdelay.
> >
> >    - (A) without (B) causes an SError if CONFIG_DEBUG_LOCK_ALLOC=n,
> >
> >    - (B) without (A) causes a timeout if CONFIG_DEBUG_LOCK_ALLOC=n
> >      (i.e. same behavior as with CONFIG_DEBUG_LOCK_ALLOC=y).
> I have instead posted what I think are proper fixes for that SError:
>
> PCI: rcar-gen4: Add missing 1ms delay after PWR reset assertion
> https://patchwork.kernel.org/project/linux-pci/patch/20250918030058.330960-1-marek.vasut+renesas@mailbox.org/

I used v3 instead.
While that patch seems to fix the SError after a hard reset (hardware
reset), it is not sufficient after a soft reset (typing "reboot").

> clk: renesas: cpg-mssr: Add missing 1ms delay into reset toggle callback
> https://patchwork.kernel.org/project/linux-clk/patch/20250918030552.331389-1-marek.vasut+renesas@mailbox.org/

This does not fix the SError, as expected (pcie-rcar-gen4.c does not
call reset_control_reset(), but reset_control_{,de}assert()).

> clk: renesas: cpg-mssr: Read back reset registers to assure values latched
> https://patchwork.kernel.org/project/linux-clk/patch/20250918030723.331634-1-marek.vasut+renesas@mailbox.org/

I used v2 instead, which seems to fix the SError.

> I hope those help. Can you please let me know if they do help ?

See above.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

