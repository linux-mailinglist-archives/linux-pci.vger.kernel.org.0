Return-Path: <linux-pci+bounces-36261-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 052CEB59863
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 15:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D86C188C375
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 13:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC868FC1D;
	Tue, 16 Sep 2025 13:58:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F5927EFE3
	for <linux-pci@vger.kernel.org>; Tue, 16 Sep 2025 13:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031094; cv=none; b=WoKMgUH5xGWyh+3zhXEZpnvJTaf5hgiiPgi3FNLIMtAQGnvCT6jyAyZjzM/rd1lMhfiuWjerEjU2bVh/GYm1+hSnJjwTKeDdSv6TAC8le3k+gOP56stP9JekMBnk16sULLm/T00KHHrdUcTNDCE/+RblqtY4RFmEy4qYeZDGGuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031094; c=relaxed/simple;
	bh=TO0GbE2bVo/GWTnDGeqYGpPKC6A5SvXW4spJ1hjM68o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BBtC32t4q8pG6kBI/g4YeYv3e4IgsDAguekf3AVf7O8OkAWiKW+ckBKBNzlowVVvz26WKNwdmWj04eZMwM4MDakxDKRlWv5XDiLRhbKF625sf4yPDoIcPhoSqJgbB+U0e5u3F5R5guLkjnE8DQxhOTi60b3KWPvwzGO1qZhDTng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5449432a9d7so3762756e0c.3
        for <linux-pci@vger.kernel.org>; Tue, 16 Sep 2025 06:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758031092; x=1758635892;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=032VqsLJWz3CTwfvFjs4mzlF8D/mUS+pHD6KNITdGeI=;
        b=mX712tbdGseVfkikcbWjsyHQdNOebPIc+e8YhnhmXedrYr8nml9UXYPpVd/hkfysRJ
         hwGAFEVByeiX72eR9Mw4dlsCIY7ymOrFrskj2vUdp65iRyLCzP6/4CKMYA8ime6Oy+j+
         UXyujH4MRRQogqO4KbhFK2KDu+1fQWnIwMfzjErK6xJ+cEzltUdwe7qd3ckjkz/egOoB
         0/BwhhDCROvq/53ku/JApzqZ0zZ+00Tqa84cQHYjEhJYuh3TQk9GZjaEcJ3y6Y/f9J2R
         zgf9rqmgqteq4xjQ1uSg3hXabu9kteVE9N36zAY7uB5kpKSsDN/Dvs33qQaLTlRBUyxR
         uOuQ==
X-Gm-Message-State: AOJu0Yzy0d9CSwKMlRe0LJIQlz9DwMEYKJ3VkvEKEGtIiYqZy1Jua8u9
	H4vDXq+5NjpAH5x2NVNM5+9fSLRPFm0Pq/eK6GLqyc9RkcagTk/xLWYOZgCbWtYQ
X-Gm-Gg: ASbGnctnP0zx/8lD9p1AWT9qGVA9E6j4NVnqpyxRp5s5xe1+hZCmFR3nuLUzeSgAyeI
	yaYeZl0WGX9aruqRrFH8/mVbjXjf7s0p+iCc7Gql9wl9m2Rktj7aBbatNrbUYqWM1oar7xstZVe
	EAlJ58q4VYiREOjtKx84Xy2tASq0DEyIpUjKKpkWyspH14j1kxFKCjf6N3FOBfcXFlfm6f3pbUU
	XF6YTvQ4kuhlVyvPvIUo2Fu6Jn9UEUrrZ17OCfTutrsIg09+pMuxau6nck9FIeAm76j3gzBAe3o
	U1BkwHu198+q6x94cL9VlnrqBSFcg+3NjsmZJ2rFG/O/IVcYRFyl7gTjxBKUYYLV8E+RsByl602
	PoNm//Bfe5nzsxDp/cgjzlPgrgD4/WmcgZb8VpnUZVQ0U5/P1M0yuD0TuM5Qq
X-Google-Smtp-Source: AGHT+IEzsGbHutzJdrtOprZb/+41yPp12CwQnVqPz5FTeZ2Esxi/Ft8jAj74hgwumy6AxpxZfIowmw==
X-Received: by 2002:a05:6102:510f:b0:4fb:dda2:10f3 with SMTP id ada2fe7eead31-5560946ccaamr4702912137.6.1758031091330;
        Tue, 16 Sep 2025 06:58:11 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-55375d5bd54sm3586383137.14.2025.09.16.06.58.09
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 06:58:09 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-8972e215df9so1034973241.1
        for <linux-pci@vger.kernel.org>; Tue, 16 Sep 2025 06:58:09 -0700 (PDT)
X-Received: by 2002:a67:e8d9:0:b0:55b:dee9:da2d with SMTP id
 ada2fe7eead31-55bdee9e269mr2974985137.11.1758031088450; Tue, 16 Sep 2025
 06:58:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915235910.47768-1-marek.vasut+renesas@mailbox.org>
 <CAMuHMdXAK6EhxPoNoqwqWSjGtwM24gL4qjSf6_n+NMCcpDf1HA@mail.gmail.com> <6fdc7d1e-8eaa-4244-a6b4-4a07e719dd73@mailbox.org>
In-Reply-To: <6fdc7d1e-8eaa-4244-a6b4-4a07e719dd73@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 16 Sep 2025 15:57:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVrw1Mr_hKvgve03DQwvpqSPNaN5XUnYRJPXMeX1wvv0A@mail.gmail.com>
X-Gm-Features: AS18NWB5CxLNgKbSLJ4uVdU9riSMIZHCgBvx_MB94zGl_MU2qT5j_1S-E1X9r3Y
Message-ID: <CAMuHMdVrw1Mr_hKvgve03DQwvpqSPNaN5XUnYRJPXMeX1wvv0A@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar-gen4: Fix inverted break condition in PHY initialization
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: linux-pci@vger.kernel.org, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

On Tue, 16 Sept 2025 at 15:39, Marek Vasut <marek.vasut@mailbox.org> wrote:
> On 9/16/25 11:59 AM, Geert Uytterhoeven wrote:
> > On Tue, 16 Sept 2025 at 01:59, Marek Vasut
> > <marek.vasut+renesas@mailbox.org> wrote:
> >> R-Car V4H Reference Manual R19UH0186EJ0130 Rev.1.30 Apr. 21, 2025 page 4581
> >> Figure 104.3b Initial Setting of PCIEC(example), third quarter of the figure
> >> indicates that register 0xf8 should be polled until bit 18 becomes set to 1.
> >>
> >> Register 0xf8 bit 18 is 0 immediately after write to PCIERSTCTRL1 and is set
> >> to 1 in less than 1 ms afterward. The current readl_poll_timeout() break
> >> condition is inverted and returns when register 0xf8 bit 18 is set to 0,
> >> which in most cases means immediately. In case CONFIG_DEBUG_LOCK_ALLOC=y ,
> >> the timing changes just enough for the first readl_poll_timeout() poll to
> >> already read register 0xf8 bit 18 as 1 and afterward never read register
> >> 0xf8 bit 18 as 0, which leads to timeout and failure to start the PCIe
> >> controller.
> >>
> >> Fix this by inverting the poll condition to match the reference manual
> >> initialization sequence.
> >>
> >> Fixes: faf5a975ee3b ("PCI: rcar-gen4: Add support for R-Car V4H")
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >
> > Thanks for your patch!
> >
> >> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> >> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> >> @@ -711,7 +711,7 @@ static int rcar_gen4_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable
> >>          val &= ~APP_HOLD_PHY_RST;
> >>          writel(val, rcar->base + PCIERSTCTRL1);
> >>
> >> -       ret = readl_poll_timeout(rcar->phy_base + 0x0f8, val, !(val & BIT(18)), 100, 10000);
> >> +       ret = readl_poll_timeout(rcar->phy_base + 0x0f8, val, val & BIT(18), 100, 10000);
> >>          if (ret < 0)
> >>                  return ret;
> >>
> >
> > This change looks correct, and fixes the timeout seen on White Hawk
> > with CONFIG_DEBUG_LOCK_ALLOC=y.
> > However, it causes a crash when CONFIG_DEBUG_LOCK_ALLOC=n:
> >
> >      SError Interrupt on CPU0, code 0x00000000be000011 -- SError
>
> ...
>
> >       el1h_64_error_handler+0x2c/0x40
> >       el1h_64_error+0x70/0x74
> >       dw_pcie_read+0x20/0x74 (P)
> >       rcar_gen4_pcie_additional_common_init+0x1c/0x6c
>
> SError in rcar_gen4_pcie_additional_common_init , this is unrelated to
> this fix.
>
> Does the following patch make this SError go away ?

> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -204,6 +204,8 @@ static int rcar_gen4_pcie_common_init(struct
> rcar_gen4_pcie *rcar)
>          if (ret)
>                  goto err_unprepare;
>
> +mdelay(1);
> +
>          if (rcar->drvdata->additional_common_init)
>                  rcar->drvdata->additional_common_init(rcar);
>

Yes it does, thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

