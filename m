Return-Path: <linux-pci+bounces-35261-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6650B3DE74
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 11:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF86D1A80D2D
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 09:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF3030DEB4;
	Mon,  1 Sep 2025 09:25:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1370A30DD08;
	Mon,  1 Sep 2025 09:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718747; cv=none; b=RMZ20SvivNOTKLNOKJhuxQ4wzm/WC5hgtOrkf/OD7RrKUMYx2vJgs6G0/1Qy52So2AHjlJo1eiYZWL+U60+MD3mgAb6cZnje+ZpwK4XXHyTT2fM4pLpC0XAT5SbKsp83S8bvI85BCxCXq0yKONimrfxjW9tfv+CtS90Pj56jpQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718747; c=relaxed/simple;
	bh=FtS6/YGhG772uhtJjhh1cI6qQRFds88d9VVWLUCe/LU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZTuCxbUbWgK5PWZ7/n1wlTrhhYPhcsWVYaHPeRRxe1wbgYzsR6+fBZbwbAVKtWhACk6wNqdPnaUbaeTWXD+rgJpMx4v+fNfCeiSlf4Lvc1ytbZCgCst3O2YB4/ng4zzH0KjstTnqr89E58dCj9McJbInUAUbK/ArR7bvzrkv3YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-890190c7912so792272241.2;
        Mon, 01 Sep 2025 02:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756718743; x=1757323543;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=srcQe2QCCiAwB7DGCqKHSCUVph+K4Lh5idtVMweUwUM=;
        b=TdokbKKrYamwXTcDb6r/+LvRc6XC7hbHenl5949FejxF7rBKD6ap4kE/V9x+ePe1Ao
         LIW4oqOSjEexrFZc2fO10WIb5hdZu5Q7PUR4JrNQ/0jKnHhidGZhwQoPH+a2QA3kRaql
         2AkBRnd/Mv/YWd9EbInOzwfUWnqZoqcuv7F2BlM9mTLwJCmKVJrCLM7YeOuTP+r4BenF
         fc10hnC/WuzK59dw43/xgWVvP+86gBRyw+NleOeSt4cEDDFKXLvcXBA28NCBaTxTtamh
         moKdJzyjf9Iyfzxn0tyjM+KQwh1gThIdQb5VNnyl+kMeXrMnzT973LkDqa86RMs0CnRZ
         x0XA==
X-Forwarded-Encrypted: i=1; AJvYcCUHcvlXyVqzcKsAAJvFfyWwnEdD/KTJg/M2HHiKRQz2dIh3jYv0rsbMNwNhY2EY7qS2n1nlreK9YZpLfH4w@vger.kernel.org, AJvYcCUTiq+vRCpods4J/0bB4jzeh5GjDdDSYq1PJnlKXKGWq1Bft1XYa3mQhpYwEnlJBvIIOosQy9fN080Q@vger.kernel.org, AJvYcCVs4Fcm/JpYN2JiLhVCBTNTjIXfzbQ6KhXbfyVvyPV+WEElnB7nwTBN/+MNFViugXENL9Wg1+IPJrIC@vger.kernel.org, AJvYcCWktEZ8KgkuBn9+X1sr/jAQMamxQ7VmCdCHkWLx3wFlmpHYTSDGkpMPzfVsWIe+nOpYqZ2k6tf3WG+y@vger.kernel.org, AJvYcCXNpyaFAfcfbTkSo6FBMtsQgx+DFsnvu9hTjAsQ1p54xfwqrQ5mdoH2tNT2EvanEl6xXGQEY+ayE0iGCbIhAscSzmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP2tDEMuhZzD/nIsRwtqSyyzJmTbnd4aJrWqaH8bHnNnWXIAvz
	H3rduQ7JxKcVRcBubM2f1nnXXfmcvjYdP1EHCxJ0aQbhz5x7Ax8nZOZR+zL0cn4f
X-Gm-Gg: ASbGncshGOnonQgJ2ChXoz0hlQ5hizS2zNPcF8M0YEXphWNKgF2kILH2faxQP/TVm91
	uIStSqOIwnY23WwTWduCMLZgFAd/xxNRY33HRAJQPvPiUrlrbS+8cjQYDXpGPGdQQ0GBz6ISWcR
	ZVLFnON1vhY4/ikS6G7fHu5eAx3mzgu3ZRAA/2hdyLBN1tXKm3rovj4IebZOvWRZphS+uLSK3Ze
	O42NHEqgguoBJGmhN7HFGFHp6Q0/luIFZt1DqeaDMqflawbx1t6Mye0fopH5roLWPUNLqKTf1yy
	AvV/2WXNnYedbv+blw254hTpijzMRg6CP2ADkuIMf+XyOGFH1rZg9TrZSAVSyGdG3Yohszri8IN
	47bd2OqxXrF5BZGkgMQldG+uSmtOxhQV353/ZVKEfasl7fz0wPb0Qa54rUuR9Z9a94fpF3u4=
X-Google-Smtp-Source: AGHT+IGqf6EtLyLcAcpjD1/RLp1f7DTHd9E5zyZ1/lm08oNAsUeVcprQH1/n7LqtiHVqxWRM4AC9Bg==
X-Received: by 2002:a05:6102:5809:b0:527:8b63:78e1 with SMTP id ada2fe7eead31-52b19532b98mr1679443137.1.1756718743326;
        Mon, 01 Sep 2025 02:25:43 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-52af1e3381asm2968389137.13.2025.09.01.02.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 02:25:42 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-52a80b778e7so615912137.1;
        Mon, 01 Sep 2025 02:25:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+8JqyQX8IeAkP4gQHH5ciJbdGbZoDvJDS6Rde5ma8x7wzvVunfFB20ksdRX5pMRd2BWLFCMfj9ZkCGOrA@vger.kernel.org, AJvYcCU+YVh72qa05ETnfQP7trxXfWAyuYx88GL0Xt3e5337gyi2EFbYSvOfk+/J/VcCFiMRERw7bkvV9x1C@vger.kernel.org, AJvYcCUom1rjLcSO0mqEX56L8FGyl4paoKG/TZp9wuPhgu3JHIiUjBIWWnrVa8URF33Ikfl7J4/OnTM/o54lcESyGwSURuA=@vger.kernel.org, AJvYcCVbcgZN0opcSdtQ07Xr2KFoZtYZwjdtiEylovrJfROpP8dg4mcGDBS1B1vdCBrWiYJf+wF0Cb6pT+Lt@vger.kernel.org, AJvYcCXrte3oOBN99iW1nxkj2pxHuBKOIIhgMMSOIxAV23Lh1UxTXztN/CbkYCDoyx1UUJ+JpDszGkY3Z/rK@vger.kernel.org
X-Received: by 2002:a05:6102:c51:b0:527:4113:6ad6 with SMTP id
 ada2fe7eead31-52b19a54877mr1662294137.9.1756718741912; Mon, 01 Sep 2025
 02:25:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704161410.3931884-1-claudiu.beznea.uj@bp.renesas.com>
 <20250704161410.3931884-6-claudiu.beznea.uj@bp.renesas.com>
 <ddxayjj5wcuuish4kvyluzrujkes5seo7zlusmomyjfjcgzcyj@xe3zzzmy2zaj>
 <8ef466aa-b470-4dcb-9024-0a9c36eb9a6a@tuxon.dev> <zsgncwvhykw4ja3bbqaxwupppjsqq4pcrdgrsduahokmt72xsm@twekpse6uzzh>
In-Reply-To: <zsgncwvhykw4ja3bbqaxwupppjsqq4pcrdgrsduahokmt72xsm@twekpse6uzzh>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 1 Sep 2025 11:25:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUu0uXBJndcwWoZp8NNyBJox5dZw4aoB8Ex50vBDDtP7g@mail.gmail.com>
X-Gm-Features: Ac12FXz8RcNX144qqXwdTyVaOdBuKNMLkMT1y2uQFu-Wa0Ecb0dTxg5TkCmB8Xs
Message-ID: <CAMuHMdUu0uXBJndcwWoZp8NNyBJox5dZw4aoB8Ex50vBDDtP7g@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] PCI: rzg3s-host: Add Initial PCIe Host Driver for
 Renesas RZ/G3S SoC
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>, bhelgaas@google.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com, 
	catalin.marinas@arm.com, will@kernel.org, mturquette@baylibre.com, 
	sboyd@kernel.org, p.zabel@pengutronix.de, lizhi.hou@amd.com, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"

Hi Mani,

On Sun, 31 Aug 2025 at 06:07, Manivannan Sadhasivam <mani@kernel.org> wrote:
> On Sat, Aug 30, 2025 at 02:22:45PM GMT, Claudiu Beznea wrote:
> > On 30.08.2025 09:59, Manivannan Sadhasivam wrote:
> > > On Fri, Jul 04, 2025 at 07:14:05PM GMT, Claudiu wrote:
> > >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > >>
> > >> The Renesas RZ/G3S features a PCIe IP that complies with the PCI Express
> > >> Base Specification 4.0 and supports speeds of up to 5 GT/s. It functions
> > >> only as a root complex, with a single-lane (x1) configuration. The
> > >> controller includes Type 1 configuration registers, as well as IP
> > >> specific registers (called AXI registers) required for various adjustments.
> > >>
> > >> Hardware manual can be downloaded from the address in the "Link" section.
> > >> The following steps should be followed to access the manual:
> > >> 1/ Click the "User Manual" button
> > >> 2/ Click "Confirm"; this will start downloading an archive
> > >> 3/ Open the downloaded archive
> > >> 4/ Navigate to r01uh1014ej*-rzg3s-users-manual-hardware -> Deliverables
> > >> 5/ Open the file r01uh1014ej*-rzg3s.pdf
> > >>
> > >> Link: https://www.renesas.com/en/products/rz-g3s?queryID=695cc067c2d89e3f271d43656ede4d12
> > >> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > >> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

> > >> +  ret = pm_runtime_resume_and_get(dev);
> > >> +  if (ret)
> > >> +          return ret;
> > >> +
> > >
> > > Do you really need to do resume_and_get()? If not, you should do:
> >
> > It it's needed to enable the clock PM domain the device is part of.
> >
>
> I've replied below.
>
> > >
> > >     pm_runtime_set_active()
> > >     pm_runtime_no_callbacks()
> > >     devm_pm_runtime_enable()

> > >> +static int rzg3s_pcie_suspend_noirq(struct device *dev)
> > >> +{
> > >> +  struct rzg3s_pcie_host *host = dev_get_drvdata(dev);
> > >> +  const struct rzg3s_pcie_soc_data *data = host->data;
> > >> +  struct regmap *sysc = host->sysc;
> > >> +  int ret;
> > >> +
> > >> +  ret = pm_runtime_put_sync(dev);
> > >> +  if (ret)
> > >> +          return ret;
> > >
> > > Since there are no runtime callbacks present, managing runtime PM in the driver
> > > makes no sense.
> >
> > The PCIe device is part of a clock power domain. Dropping
> > pm_runtime_enable()/pm_runtime_put_sync() in this driver will lead to this
> > IP failing to work as its clocks will not be enabled/disabled. If you don't
> > like the pm_runtime_* approach that could be replaced with:
> >
> > devm_clk_get_enabled() in probe and clk_disable()/clk_enable() on
> > suspend/resume. W/o clocks the IP can't work.
>
> Yes, you should explicitly handle clocks in the driver. Runtime PM makes sense
> if you have a power domain attached to the IP, which you also do as I see now.
> So to conclude, you should enable/disable the clocks explicitly for managing
> clocks and use runtime PM APIs for managing the power domain associated with
> clock controller.

Why? For the past decade, we've been trying to get rid of explicit
module clock handling for all devices that are always part of a
clock domain.

The Linux PM Domain abstraction is meant for both power and clock
domains.  This is especially useful when a device is present on multiple
SoCs, on some also part of a power domain,  and the number of module
clocks that needs to be enabled for it to function is not the same on
all SoCs.  In such cases, the PM Domain abstraction takes care of many
of the integration-specific differences.

> But please add a comment above pm_runtime_resume_and_get() to make it clear as
> most of the controller drivers are calling it for no reason.

Note that any child device that uses Runtime PM depends on all
its parents in the hierarchy to call pm_runtime_enable() and
pm_runtime_resume_and_get().

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

