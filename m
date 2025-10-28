Return-Path: <linux-pci+bounces-39506-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D826C13DD6
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 10:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3D19587320
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 09:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FB3302CDF;
	Tue, 28 Oct 2025 09:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lw8nDcBv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4391530506B
	for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 09:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761644101; cv=none; b=XM1c0lUXsfTy0uwcDY9KIVENYXC30brdZATqCtlZfDIilIUNgA+gxcubUMwLgJHfEvZm47PariQC+gn45thTiqT/L8Z5EqEHTpqrDLVlhJf/xyndh+ei59nDwMeTwa000r2mAY9vRKFi9iHo6YNB9mTzjGnTgM5TeetsRO4o2Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761644101; c=relaxed/simple;
	bh=Tgmsx1JScyxxj2M/daynBulpTMwkwcqhLj7ma+AO0SQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bc9AZyne8BNa2zKxQ/Pqj78++QpEPnjgy8nxDNLRvAV2kVdtkWDxtNyhNIvW8a3wZbfNjk+K22nedU6rhUleN2M+pws1BOe0J46urwbOBhhGS3gsFiYXlODNItE+zHYZqB4pwlynhKQsTWAgJi9t2/xiyMueOfXAT85qNrYikNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lw8nDcBv; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63bea08a326so8076204a12.3
        for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 02:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761644097; x=1762248897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KqhCSWD1Q42FEiIO/7VeHXIAsO8MdqNCvIdMk2S6qk=;
        b=lw8nDcBv0WLF3jpxa78ZbGoYF4sYERwWQp8r5xvzCKv5sAwK1OtI92sb3HIrC7uVXo
         AVaQzcfzGK+9e2kEHa/ml3Z1yPJMRtm0oAcTrLuLiF0MM/ItO2NmDcMEUdDvrvfZ3N6+
         qxaHALr6XLInfagItRdv5p3XQ1X/8BQHQogMeM08iZSgIkH015olB8lTp5wf1PouXDVr
         yCnKuZr05BJsz3Zbq91JzUFLLTp6R5wzhqZR7U7yE/ngJ3JL8K9nkRrFWFCdx/9Vv5yb
         Hhj0XE3F/9NK1mupYIBpuVaaRIp/0vrgB5NMMG22NSXH90EDi9NExzkciHZRmhceAjRe
         C+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761644097; x=1762248897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KqhCSWD1Q42FEiIO/7VeHXIAsO8MdqNCvIdMk2S6qk=;
        b=onXfLpCvEc0uErw/d1hCLFo7fpziGUU3Y50ZV5hYBBBaEY6FfEcZTWcAaHgb0YWDUB
         3jN97vkrf4qIQTi4T2cZDCqPeO5hHyoNsZWlc697dYXR1NwqwqerWpJLGSKrL1n1ZoiB
         xup80K7xgpSM6j4FfUpatKddliTEDsjWuk4+xAxTKdQmCwzBI6PWU9GHQG6UvpWkbHsc
         XymBgEgCyfs1mYulicCoyIZT2RZvX6aPNjlyK54Fpydd1cBsu6fHycJ1/qGUVK0ECZYK
         sd9nIJ8h1KcetTGb5t2Q34BJvj3AKrx71J6TGLl3VDfRnXHsrqYjC5NOCq3+f+hnb1o8
         ywNQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8/gS2NXU5r1hLe6v43yyd3/0wv7RybXxVfGZGg5aMDpMzdwkZmkR/coSOxRl2a1O7JQcrzplTUjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSRkhsiTtrW5QEIAmOzHgtszusuI2w79wyKUTB29mfPD1eEum6
	9M0TRhFOT+vXZhdEuqTlb3rZhx8h37nk2jPKXpF/TZ4sEzK42Aix+076GmBkkF1Sk4pAquLgPFn
	G/euYqfXFoJ+AHguPWlvCQySqp4duqAA=
X-Gm-Gg: ASbGnct8/+CseH58EGh1mKVt9Rj8UCobaR9volS9N1WFnfat5lDLOc5oXqxCf+sCx9g
	L7MU2Izf6CFtx7xcm35+NNvdtJJzasM0Rs/NYHSCWzVlr4qKQtZsQghZ/v5exW06p8Os0d2+zDD
	huaOt7vB+I9xEYeaFkPFFRPKdAyr2gkW0EY//bxjkhJ/mlML2pRV0w13VA2yM/OIKiAU5uDk/Jz
	l/JdiWcWJcfkH4Pu2XqiDajWjYZ+kXNjjeIC64/3T/Ym6ZWnv7qc67394o=
X-Google-Smtp-Source: AGHT+IFjt6ENLv3OgjeY1ld5nYFGuXlQevcjQGJSv4QAuB6EROb4RDtvfEjBykX6USiKiG6f7/s9p1mYGBj6/RmxU1k=
X-Received: by 2002:a05:6402:1d53:b0:634:ab34:ed40 with SMTP id
 4fb4d7f45d1cf-63ed76dda03mr2637221a12.0.1761644097392; Tue, 28 Oct 2025
 02:34:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027145602.199154-1-linux.amoon@gmail.com>
 <20251027145602.199154-3-linux.amoon@gmail.com> <cfaa4824-a59a-4106-b2c1-befce2af0324@rock-chips.com>
In-Reply-To: <cfaa4824-a59a-4106-b2c1-befce2af0324@rock-chips.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 28 Oct 2025 15:04:40 +0530
X-Gm-Features: AWmQ_bmnYVQ5MIlrxdaMUdyWQ-V-ciIMUJiy8e-9y11-5OlEwSkXW-sMhSd3m04
Message-ID: <CANAwSgRHhN5nZpKojKamTmZoY9qruwD0HJvEYFs_bqapoeRsoA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] PCI: dw-rockchip: Add runtime PM support to
 Rockchip PCIe driver
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Niklas Cassel <cassel@kernel.org>, Hans Zhang <18255117159@163.com>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, 
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

Thanks for your review comments.

On Tue, 28 Oct 2025 at 06:14, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> =E5=9C=A8 2025/10/27 =E6=98=9F=E6=9C=9F=E4=B8=80 22:55, Anand Moon =E5=86=
=99=E9=81=93:
> > Add runtime power management support to the Rockchip DesignWare PCIe
> > controller driver by enabling devm_pm_runtime() in the probe function.
> > These changes allow the PCIe controller to suspend and resume dynamical=
ly,
> > improving power efficiency on supported platforms.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 21 ++++++++++++++++++=
+
> >   1 file changed, 21 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pc=
i/controller/dwc/pcie-dw-rockchip.c
> > index b878ae8e2b3e..5026598d09f8 100644
> > --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > @@ -20,6 +20,7 @@
> >   #include <linux/of_irq.h>
> >   #include <linux/phy/phy.h>
> >   #include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> >   #include <linux/regmap.h>
> >   #include <linux/reset.h>
> >
> > @@ -690,6 +691,20 @@ static int rockchip_pcie_probe(struct platform_dev=
ice *pdev)
> >       if (ret)
> >               goto deinit_phy;
> >
> > +     ret =3D pm_runtime_set_suspended(dev);
> > +     if (ret)
> > +             goto disable_pm_runtime;
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
> > +             goto disable_pm_runtime;
> > +
> >       switch (data->mode) {
> >       case DW_PCIE_RC_TYPE:
> >               ret =3D rockchip_pcie_configure_rc(pdev, rockchip);
> > @@ -709,7 +724,10 @@ static int rockchip_pcie_probe(struct platform_dev=
ice *pdev)
> >
> >       return 0;
> >
> > +disable_pm_runtime:
>
> We need to call reset_control_assert(rockchip->rst) before releasing the
> the pm refcount. The problem we faced on vendor kernel is there might be
> still on-going transaction from IP to the AXI which blocks genpd to be
> powered down.

Thanks, I will try to fix this in the next version.

Thanks
-Anand

