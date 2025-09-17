Return-Path: <linux-pci+bounces-36326-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F45B7E6E5
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 14:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DCB8462ED9
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 08:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A6A29C33C;
	Wed, 17 Sep 2025 08:00:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30073278E71
	for <linux-pci@vger.kernel.org>; Wed, 17 Sep 2025 08:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758096044; cv=none; b=XHySkEhV8/3oQmZkOAYGC5aa/UmMwaiIjSbKV/7OnEYNJENR0Eu2jO8cop0JlCPTRl/ce1+mxOSJ3Z/ud0Fb1KNlJDKTvJ8xqs7KjogFMbCXkGOQyLzoEJApUOdckjE6m9bs7VxFKbG9wQLaT9yfJGPj4YGSubJ3ET9URNEeAac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758096044; c=relaxed/simple;
	bh=dNdNpY8vxZqBKUJnRMC8RJRgX0+3Qjhu6NrnHi+SVxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TUITd4fHOaYZd/kz2NwrOI8j3eOBHmnYjEkv3iBPMnEVhte0hae88nALkNnpN18CLc196CWObHqIO+UB80e1RcuH2t61v5FvK2gkI+Ugs7u1FJlocJeeXLv5/OLTor5NcFtZ14rNZUEGdWOiHPDZ9APUM1BOhXbUAu/832kZ+p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b0787fc3008so900283366b.3
        for <linux-pci@vger.kernel.org>; Wed, 17 Sep 2025 01:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758096039; x=1758700839;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aFmJDbGVxEflnnf5D9PC38BFy/blsYbi7EpR0gy5+kE=;
        b=H67PQXceF8r97hFJpiaaheneCgOxruXycmhUxNGarA1NQH/TkJBdiCGJ5Qok23Cyuj
         LPDNI0Wj7DtfYbZUErDVVNTLgAioAAu0ZuhA0M9iT6HXTpwdWjAXEFKm6QDRNGCpt8pl
         E+c3YaEdFpxFJj55O90k3UBmv7jwGaB02zs/op134iuMs447UQ5SD3eQWgGTpMrZXQCF
         ZY6fG4OntuzzjYufkGPenukJgUAAPCq6spmhRno7y52HtFFGForcEsUCcxr9SIyho/vm
         t49chZAgW3TsCKm3XjZbhwqgV0CebqDz3qQsO0XdM8THabjdqZSJSSFvFMRThl6rr804
         bu4w==
X-Forwarded-Encrypted: i=1; AJvYcCUCWZoxLOdQ1tqXfkn11+KCcvdZeHf0DRNReplmk1rEdcS5woZkTrXRWnbKdfOl2vR+Cq1REPUKH8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0vwTtkTemiUkUfYelS/amyxYIujd/NXtQZyF5QJF2h3RpSER/
	fi95DvuhoV1OYAZFfcuU2SqZPg+a74gog9sqbKr7L5js0NtLhlHMjtJ5eG5wo+Su/Vk=
X-Gm-Gg: ASbGncvm9b+xIIk7tHFjnMfJX05qbqEeGpSSTrMdR4viYeJZEmc/BPJLxuwGj71ru0f
	Mtu/Nrb181F7uTCSr5mNAC6k2rSEc9x/AKooSjzzGW40WZLYMSWteawKxUvKxxKml9p2vmmFBBL
	eO9PTHUqOExprlqm7ZGgTw3HNXNIXbFsIijEF1WGWegFm0qfMlK6aGqQLzLfXit8OB2M3c4xinC
	u5NcXriJxPd4wse20S0Vaw94CEfIqCtS9Urm8BKXo9tFFUtG/ALAGTNdq6HXjH1Ax7tdBMbOMth
	aU0rB6hFqv+vBgGSPJ8F6VKey9BWwCkLnWKvYNJZMjQujBlCbG2a2hUdMbvH4XalMTV5c3HH2it
	dbSDEU3ehZ9O4Dx7NOjy2ZhWg9cSxEPX/WuDoXWPK2vVb/qwBwYneVf/25HYU
X-Google-Smtp-Source: AGHT+IESzgJSXev9qTTCbcJs2ukXGHfwlef6Oc1FCDBj1l5cyYhGiDLwa+NhPOXBGsKv1SLGnRistw==
X-Received: by 2002:a17:906:599c:b0:b07:885f:a54e with SMTP id a640c23a62f3a-b1bb73a73admr109211266b.23.1758096039226;
        Wed, 17 Sep 2025 01:00:39 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd57csm1316620666b.52.2025.09.17.01.00.36
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 01:00:37 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b07883a5feeso1093387466b.1
        for <linux-pci@vger.kernel.org>; Wed, 17 Sep 2025 01:00:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX2CmoHLn14jTvrsYUlZuMvTcjCVa8U4dsoTft3Hp36UrTq0ALx6yVOIE8isTyCX6kuG6YOCz55vlc=@vger.kernel.org
X-Received: by 2002:a17:907:da4:b0:b07:dad7:e4cd with SMTP id
 a640c23a62f3a-b1bbebb7bb3mr131885566b.53.1758096036562; Wed, 17 Sep 2025
 01:00:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916181558.GA1810654@bhelgaas> <643c9b19-dda4-43c5-bb6d-aa0705053d43@mailbox.org>
In-Reply-To: <643c9b19-dda4-43c5-bb6d-aa0705053d43@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 17 Sep 2025 10:00:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXh0rxpLXW+3yCP7hZNwacVcuc3Wp5t8CiDJ2HE=P+OiQ@mail.gmail.com>
X-Gm-Features: AS18NWCjLH4VUp9iqUWGutNCZKfyTLEzHKClaNviOMXmU6lZNI3kUP8XXzhjwtE
Message-ID: <CAMuHMdXh0rxpLXW+3yCP7hZNwacVcuc3Wp5t8CiDJ2HE=P+OiQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar-gen4: Fix inverted break condition in PHY initialization
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

On Wed, 17 Sept 2025 at 00:09, Marek Vasut <marek.vasut@mailbox.org> wrote:
> On 9/16/25 8:15 PM, Bjorn Helgaas wrote:
> > On Tue, Sep 16, 2025 at 07:39:07PM +0200, Marek Vasut wrote:
> >> On 9/16/25 7:13 PM, Bjorn Helgaas wrote:
> >>> On Tue, Sep 16, 2025 at 06:31:31PM +0200, Marek Vasut wrote:
> >>>> On 9/16/25 3:57 PM, Geert Uytterhoeven wrote:
> >>>>> On Tue, 16 Sept 2025 at 15:39, Marek Vasut <marek.vasut@mailbox.org> wrote:
> >>>>>> On 9/16/25 11:59 AM, Geert Uytterhoeven wrote:
> >>>
> >>>>>>> This change looks correct, and fixes the timeout seen on White Hawk
> >>>>>>> with CONFIG_DEBUG_LOCK_ALLOC=y.
> >>>>>>> However, it causes a crash when CONFIG_DEBUG_LOCK_ALLOC=n:
> >>>>>>>
> >>>>>>>         SError Interrupt on CPU0, code 0x00000000be000011 -- SError
> >>>>>>
> >>>>>> ...
> >>>>>>
> >>>>>>>          el1h_64_error_handler+0x2c/0x40
> >>>>>>>          el1h_64_error+0x70/0x74
> >>>>>>>          dw_pcie_read+0x20/0x74 (P)
> >>>>>>>          rcar_gen4_pcie_additional_common_init+0x1c/0x6c
> >>>>>>
> >>>>>> SError in rcar_gen4_pcie_additional_common_init , this is unrelated to
> >>>>>> this fix.
> >>>>>>
> >>>>>> Does the following patch make this SError go away ?
> >>>>>
> >>>>>> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> >>>>>> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> >>>>>> @@ -204,6 +204,8 @@ static int rcar_gen4_pcie_common_init(struct
> >>>>>> rcar_gen4_pcie *rcar)
> >>>>>>             if (ret)
> >>>>>>                     goto err_unprepare;
> >>>>>>
> >>>>>> +mdelay(1);
> >>>>>> +
> >>>>>>             if (rcar->drvdata->additional_common_init)
> >>>>>>                     rcar->drvdata->additional_common_init(rcar);
> >>>>>>
> >>>>>
> >>>>> Yes it does, thanks!
> >>>>
> >>>> So with this one extra mdelay(1), the PCIe is fully good on your side, or is
> >>>> there still anything weird/flaky/malfunctioning ?
> >>>
> >>> Do we have a theory about why this delay is needed?  I assume it's
> >>> something specific to the rcar hardware (not something required by the
> >>> PCIe base spec)?

> > Yeah, if it's some rcar-specific thing, I don't see a better
> > alternative.
> I have one more hypothesis.
>
> I noticed in V4H RM rev.1.30 page 798 that CPG (reset) and PCIe are on
> different busses. From CA76, the CPG reset is reachable via "CCI->Slave
> Access BUS->CPG" and PCIe is reachable via "CCI->Slave Access BUS->HSC".
>
> I wonder if a sequence like this:
> - writel(CPG un-reset register)
> - readl(PCI DBI register)
> can, due to bus behavior, lead to readl(PCI DBI register) taking effect
> on the PCIe IP _before_ the writel(CPG un-reset register) takes effect
> on the CPG IP, which trigger the SError (coming from PCIe IP).
>
> Or is it guaranteed that writel(some IP) followed by readl(another IP)
> are strictly ordered in this manner even on the IP end at which they
> arrive, even if the two IPs are on different busses ? Please pardon my
> ignorance.
>
> Does the attached diff also help Geert with the SError ?
>
> Same diff is also inline below:

> --- a/drivers/clk/renesas/renesas-cpg-mssr.c
> +++ b/drivers/clk/renesas/renesas-cpg-mssr.c
> @@ -688,12 +688,14 @@ static int cpg_mssr_reset(struct
> reset_controller_dev *rcdev,
>
>         /* Reset module */
>         writel(bitmask, priv->pub.base0 + priv->reset_regs[reg]);
> +       readl(priv->pub.base0 + priv->reset_regs[reg]);
>
>         /* Wait for at least one cycle of the RCLK clock (@ ca. 32 kHz) */
>         udelay(35);
>
>         /* Release module from reset state */
>         writel(bitmask, priv->pub.base0 + priv->reset_clear_regs[reg]);
> +       readl(priv->pub.base0 + priv->reset_clear_regs[reg]);
>
>         return 0;
>   }
> @@ -708,6 +710,7 @@ static int cpg_mssr_assert(struct
> reset_controller_dev *rcdev, unsigned long id)
>         dev_dbg(priv->dev, "assert %u%02u\n", reg, bit);
>
>         writel(bitmask, priv->pub.base0 + priv->reset_regs[reg]);
> +       readl(priv->pub.base0 + priv->reset_regs[reg]);
>         return 0;
>   }
>
> @@ -722,6 +725,7 @@ static int cpg_mssr_deassert(struct
> reset_controller_dev *rcdev,
>         dev_dbg(priv->dev, "deassert %u%02u\n", reg, bit);
>
>         writel(bitmask, priv->pub.base0 + priv->reset_clear_regs[reg]);
> +       readl(priv->pub.base0 + priv->reset_clear_regs[reg]);
>         return 0;
>   }
>

Yes, reading the reset registers after writing works, too.

I just noticed the module reset operation in the R-Car V4H Hardware
User's Manual has changed from R-Car Gen2/Gen3, and is now more complex,
with three different reset types, depending on the module to be reset
(see Section 9.3 "Operation" subsection (2) "Software Reset").
The most striking difference is that there is no more mention of
a single delay of 1 RCLK cycle (cfr. the udelay(35) above), but of
much longer delays of 1 ms.

As drivers/pci/controller/dwc/pcie-rcar-gen4.c does not call the
combined reset_control_reset() , but uses separate
reset_control_assert() and reset_control_deassert() calls, the PCIe
driver itself is responsible for enforcing this 1 ms delay.
Which is exactly what your introduction of mdelay(1) (just after the
out-of-context call to reset_control_deassert()) does, so I believe
we're all set?

For enhance reliability, I would also add such a delay after the
(conditional) call to reset_control_assert(), like (whitespace-damaged):

--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -184,8 +184,10 @@ static int rcar_gen4_pcie_common_init(struct
rcar_gen4_pcie *rcar)
                return ret;
        }

-       if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc))
+       if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc)) {
                reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
+               mdelay(1);
+       }

        val = readl(rcar->base + PCIEMSR0);
        if (rcar->drvdata->mode == DW_PCIE_RC_TYPE) {

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

