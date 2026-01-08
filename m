Return-Path: <linux-pci+bounces-44260-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB70D01568
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 08:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 545E33002D2C
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 07:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173C6239E80;
	Thu,  8 Jan 2026 07:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nD5C5Rz6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0F61E1C02
	for <linux-pci@vger.kernel.org>; Thu,  8 Jan 2026 07:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767855886; cv=none; b=ny873oXdwHpuoQ7zadmorKblWHpgRzKytYl8jPNy7lFXWPXc1RqiBvh4g8joAxI3JdkuJUXUwyOpatMdusCJLx0NeuMDpqlsKGpkDw5LB92Y8FPHqpc72LUrb3h/UPZYa6y9MoR+V8dZFCsUP4tDk+B9BgIbEavsV5Gu2OqIiWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767855886; c=relaxed/simple;
	bh=75OyDe5enpFd3HBDlzK7ykTvJP5yOuCu7A1wPvUGn+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hVuLnwMO6f4/fxGMrNBu3Ac9iEm338kXNkk+W+0H3Mp2sRLExiCQTMrlYdKV0a/7ptWroqGEUn/9lMAosjc1S+dmA59HfcHSd87dJBnYr0OfmvmDA+owKOnhkKWQZQI8RwqY07UKhBmasjJjp1zS1kA7xMHpHVd42NRau/dQkcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nD5C5Rz6; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64ba74e6892so4669172a12.2
        for <linux-pci@vger.kernel.org>; Wed, 07 Jan 2026 23:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767855883; x=1768460683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAN8+Ciqh5L4w3kAbltziKsgSCvOxXNi49H+2aGyv4Y=;
        b=nD5C5Rz6c/ieTxdoLtY3g9r6aB2cuGn4qcl7dE0uETBIOOu0lw1Dy9Vqd+HHUNz3mm
         NrUQiDjLtDjuorwUGdQHgdSca5fgyYKfx42ZTKEzLbD+MIvyQsuno4nstgoLlAruz7dG
         uxIFPAuKk2FW2UFvoCfJuq+DwAVQ8O0Alm4Tie4dwYDu2j+YQ4b7EqR2KiJmymwG6aWe
         8q/31vVTJlXeN0oBpg3cM4rFO2tA0BuiHaUoSfM2bJmQiGsJL3Vd9EVhIjJFt0Zz3FYb
         BJt/X9wnmed54K8mfKBat619TvQNYWcHyGhSABKJXYrydMhyKgDu8Rzavo4tcPwgblFV
         nsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767855883; x=1768460683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EAN8+Ciqh5L4w3kAbltziKsgSCvOxXNi49H+2aGyv4Y=;
        b=wfRWgzqplzxWrnNjSxO4mPLzxvyaS8Ppn0S76/QStMsMsYfPOoZxODw6w9aieUZAtx
         gCXykRabcn0mM1oElwDZYUBFXQwQDurbifHQxo7uosmqjt5cm7Pu5yq3oaaSTmFtrS48
         eq2fFvef+lfpfWkHlF6msHv8McQfinTpfRYJAJ24K56GIXhkfJAkuErBKFsV1vQhea0q
         JS/4iadfzJ7gvr8DDWofxaNT2TmxZMOJjPYr5XsYnl74plMULg0PFilLZSWn/JiPpNEK
         YQkG/L3HE7LjaAonkxY/aISs0BVKz3jBdYCLJcOEQA2fTtKX1zAiLwTQz9W+7Sevq0uH
         wJnA==
X-Forwarded-Encrypted: i=1; AJvYcCX3ztwSJddaYwaMWQnwAPvjv31fcdBcpaUUnmPKq1DI/mqUw9BYEkeY+0SgLis7290+Qer0WfOcx40=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEXsTvfyhMDoDHNvoXZL2gvDk64Z0sFgy+FQ9+AqCQrTSnP7Y1
	4zndeHn1akSiT9FCqzhno35Qe1E+MbgNHt1PDTSJ5rd2OlIOyPZ1u/HrikrbfWiJ8ZdnXAF7h25
	U6pcPU7fM1C8qQFSf0Os60CM6sWc4RI8=
X-Gm-Gg: AY/fxX5MRy2VlOJrgEG5EFwNuHCk2hWrktgmnqdRaLZmenwhoZTwLAcfKWwbQXC9hXp
	cuzmVhcMUMTokDldELd9wN5saiwGLe7l/E/NnKwBqsv7WC+f0yLDZbrStpNtuxkXKnnG9KOLp+f
	mBjOiPYTKH4pLoKtaXwGzHc8OKSeJFuaF6qc0vwm79nTyl99hFuyAGkUtTy+N9Z8bJ+4FBkx8sJ
	o8vrf2zpaf0ntFIvTPv/jRkkXTVLMWp+ilqt+U6Z55E/oqCOfA+o0lzrlKnxYYtHXBW74IASQbS
	dg==
X-Google-Smtp-Source: AGHT+IGBP1Y/NBrrCMuhwkVQ6AO2ojqKOG+H99YGlpDe1e8ewtDuvZGEnWtYEQt6lSgwqc5HalftMS2UQQytGVd5v6I=
X-Received: by 2002:a05:6402:3593:b0:64c:69e6:ad3e with SMTP id
 4fb4d7f45d1cf-65097e8e43fmr4488123a12.33.1767855882738; Wed, 07 Jan 2026
 23:04:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260102131819.123745-1-linux.amoon@gmail.com> <ald3sxdzggbhqvpc7ra7x5nkf36xoamgwfumz5r4jwgirdzyes@nwvka2h256f6>
In-Reply-To: <ald3sxdzggbhqvpc7ra7x5nkf36xoamgwfumz5r4jwgirdzyes@nwvka2h256f6>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 8 Jan 2026 12:34:25 +0530
X-Gm-Features: AQt7F2rxp4OBghS7YFRzpcNM61eouESYIn1a5kIjLPye8P3AweeGw4bjR-rsO54
Message-ID: <CANAwSgTAHUXkZXxe_Y0KTssqqvKZAiOe2ZwiFV4EJ8k9sj00Ng@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: dw-rockchip: Add runtime PM support to Rockchip PCIe
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Niklas Cassel <cassel@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Hans Zhang <18255117159@163.com>, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, 
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Manivannan,

Thanks for your review comments.

On Tue, 6 Jan 2026 at 19:06, Manivannan Sadhasivam <mani@kernel.org> wrote:
>
> On Fri, Jan 02, 2026 at 06:47:50PM +0530, Anand Moon wrote:
> > Add runtime powwe manageement functionality into the Rockchip DesignWar=
e
> > PCIe controller driver. Calling devm_pm_runtime_enable() during device
> > probing allows the controller to report its runtime PM status, enabling
> > power management controls to be applied consistently across the entire
> > connected PCIe hierarchy.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > v2:
> >    improve the commit message
> >    Drop the .remove patch
> >    Drop the disable_pm_runtime
> > v1:
> >  https://lore.kernel.org/all/20251027145602.199154-3-linux.amoon@gmail.=
com/
> > ---
> >  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pc=
i/controller/dwc/pcie-dw-rockchip.c
> > index f8605fe61a415..2498ff5146a5a 100644
> > --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/of_irq.h>
> >  #include <linux/phy/phy.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> >  #include <linux/regmap.h>
> >  #include <linux/reset.h>
> >
> > @@ -709,6 +710,20 @@ static int rockchip_pcie_probe(struct platform_dev=
ice *pdev)
> >       if (ret)
> >               goto deinit_phy;
> >
> > +     ret =3D pm_runtime_set_suspended(dev);
> > +     if (ret)
> > +             goto deinit_clk;
>
> Seriously? Why do you need this? Default PM status is 'suspended'.
These changes were part of my work on suspend/resume capabilities
>
> > +
> > +     ret =3D devm_pm_runtime_enable(dev);
> > +     if (ret) {
> > +             ret =3D dev_err_probe(dev, ret, "Failed to enable runtime=
 PM\n");
> > +             goto deinit_clk;
> > +     }
> > +
> > +     ret =3D pm_runtime_resume_and_get(dev);
> > +     if (ret)
> > +             goto deinit_clk;
> > +
> >       switch (data->mode) {
> >       case DW_PCIE_RC_TYPE:
> >               ret =3D rockchip_pcie_configure_rc(pdev, rockchip);
> > @@ -730,6 +745,8 @@ static int rockchip_pcie_probe(struct platform_devi=
ce *pdev)
> >
> >  deinit_clk:
> >       clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
> > +     pm_runtime_disable(dev);
>
> You used devm_ for enable.
>
> > +     pm_runtime_no_callbacks(dev);
>
> Why? Where is pm_runtime_put()? Please read Documentation/power/runtime_p=
m.rst.
>
Ok, I will study and update the changes.
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

Thanks
-Anand

