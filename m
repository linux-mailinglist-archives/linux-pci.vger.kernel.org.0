Return-Path: <linux-pci+bounces-12542-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA03966F1D
	for <lists+linux-pci@lfdr.de>; Sat, 31 Aug 2024 05:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 718BCB226F1
	for <lists+linux-pci@lfdr.de>; Sat, 31 Aug 2024 03:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A12F39FC6;
	Sat, 31 Aug 2024 03:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORj5wdRA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F562F2E;
	Sat, 31 Aug 2024 03:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725075459; cv=none; b=M811QEuMp5FwXKt4QbOeNtOPQlJzimPOAOghV3lVv4RNu8/yyAkq1FgGxJm9iicb1ZpRgIcNhyCXTMb4TsLSF4caqqQNauRO9peUm/Ah0GOfHtHgsM33H0E6nGlG4Pvl2ybMCEwWW1crOlCR/NyyLrIXRhrs+upv6FpzZxrK0Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725075459; c=relaxed/simple;
	bh=FbEEkxyVFC+vN4cnO6y1h99nG2B8uUxT4FGMey7sRnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ix+w23KeRQODKY/Aha52ACAi0hp42MqdwgIPDSH4xPP4AJL5iHkXLGEQAM4Hq8cACHiMqrbxNppARGsPgLgTMCV2ltSIUZsYjGsy57oP6Vx3IqJeBzSxgxE8pLrnQbR0eIXzucaWiOImN7LPbM2ap7JqhUTZtkSeEbdEVVHlalk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORj5wdRA; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5de8ca99d15so1469407eaf.0;
        Fri, 30 Aug 2024 20:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725075456; x=1725680256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbEGsVu4tcNNBxnYhX8f/QKpdqK7jP+IwoEJVSMeyqw=;
        b=ORj5wdRA4vVxGRLFAsX8Ua4hWVEISOsUY/PKHKceqZcX27herEGcbPEbpGEccdvGFJ
         +p0z69UwQeAiJ02WLgng6o3vWDbNKNuYKyGAvFd3Niml/SxJFuYqh5u+jb5JTOzAegVO
         4tnFtUA1ORCUrNznTCVmpdX4ezVOechC+6OnLc90MKo2jEk8X7n9Xc4En1Wm/nI6bx79
         XoyLFVfn6WXEQxj5vrCCMyPsTqEWDXmJircyGeD0Q9W71WZBtHabWSb+9rLqjijjUFBh
         /gaunnTYyBosITvf/QjAOnCS1gK+IC9hAvscFr2jcs4iP3HWllSWZgwprDPNh3SOaOzT
         ryVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725075456; x=1725680256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KbEGsVu4tcNNBxnYhX8f/QKpdqK7jP+IwoEJVSMeyqw=;
        b=DPIYzm5Gt934k6gUMYZvITWF5hLWs/b+IjE99VEGdckXa9ns1rhR3cejF4y4HsPta6
         MQBf38DERFAL7Ih2aXmDgyVU2rEhMANUlLwHGoPME0lpDd7vXUE5d3WzcrF+0nwXX+r+
         fBT4P8BufI8Vjjf4w3JVLZrgFdYyaAUJBI8KLOoV3FnjHYsm3GMXZmq3RGfGGOmdlFSc
         tgMsaoiYSsOf8lTEo/0zKJjzxFSzOqDCEYH2NI28eTVFZ7cUpGvyL22v8Du0epq9MT8p
         6Guq6HQhi1mb1ZajPYLRYP05H3BsmXqOexs8IH6dCEfYHDMoeoYJ0B0CXM3FliL9eBab
         xO6g==
X-Forwarded-Encrypted: i=1; AJvYcCUOLGhxo4NXejqtSYh5DgmSX3ttvrXMSzk4rkGh8YkY+9bM7miOWlCiXjRrtdVD+EDJGawOoqeVmUIonh0=@vger.kernel.org, AJvYcCXS8sm2cveWJSh+xVxV7A0kdsiP7XJVUi/AvENlpMBzDQRnKCaeMSJ80HKv8Nsuhj4RcioDjqmNoyU2@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp7o3myOeO0azncNUFJiwzBvhD9rHsq1oVmM/LibbTHB0URd/2
	sTX1mZWcg7DoLKJN7+4tR7VVkp87oOGKO2BD6pMgZH264IjI8DhVwJZeOkf4apc7J5bFeFIZLDv
	MfdeLBTtdc+Ijwxc3SjPglxmnskc=
X-Google-Smtp-Source: AGHT+IF7x7zd7mZOfTY6/C8kA5WeCVRghn+Yr3ix9nhgy9yydmmE5ol1+OUlwdHe6iCca4SvgEBmLwgAEps/bC6qleg=
X-Received: by 2002:a05:6820:1609:b0:5c6:9320:53a3 with SMTP id
 006d021491bc7-5dfacef8a5bmr4556279eaf.4.1725075456216; Fri, 30 Aug 2024
 20:37:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827023914.2255103-1-bo.wu@vivo.com> <CANAwSgQpu9NYugu_=PCVQGXiXCptxLT2Q1xQ5KqbwvkU0kfWDQ@mail.gmail.com>
 <ebff7e4c-a561-4c61-a40d-f1905ac3d42a@gmail.com>
In-Reply-To: <ebff7e4c-a561-4c61-a40d-f1905ac3d42a@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 31 Aug 2024 09:07:20 +0530
Message-ID: <CANAwSgRi4KUoxjtNn87PRHXVJ2rxwqcxo96LCtOCgbOD+RNWQQ@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: armada8k: change to use devm_clk_get_enabled() helper
To: Wu Bo <wubo.oduw@gmail.com>
Cc: Wu Bo <bo.wu@vivo.com>, linux-kernel@vger.kernel.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wu Bo,

On Sat, 31 Aug 2024 at 05:36, Wu Bo <wubo.oduw@gmail.com> wrote:
>
> On 2024/8/27 14:44, Anand Moon wrote:
> > Hi Wu Bo,
> >
> > On Tue, 27 Aug 2024 at 07:55, Wu Bo <bo.wu@vivo.com> wrote:
> >> Use devm_clk_get_enabled() instead of devm_clk_get() to make the code
> >> cleaner and avoid calling clk_disable_unprepare()
> >>
> >> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> >> ---
> >>   drivers/pci/controller/dwc/pcie-armada8k.c | 36 ++++++++------------=
--
> >>   1 file changed, 13 insertions(+), 23 deletions(-)
> >>
> >> diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/=
controller/dwc/pcie-armada8k.c
> >> index b5c599ccaacf..e7ef6c2641b8 100644
> >> --- a/drivers/pci/controller/dwc/pcie-armada8k.c
> >> +++ b/drivers/pci/controller/dwc/pcie-armada8k.c
> >> @@ -284,23 +284,17 @@ static int armada8k_pcie_probe(struct platform_d=
evice *pdev)
> >>
> >>          pcie->pci =3D pci;
> >>
> >> -       pcie->clk =3D devm_clk_get(dev, NULL);
> >> +       pcie->clk =3D devm_clk_get_enabled(dev, NULL);
> >>          if (IS_ERR(pcie->clk))
> >> -               return PTR_ERR(pcie->clk);
> >> -
> >> -       ret =3D clk_prepare_enable(pcie->clk);
> >> -       if (ret)
> >> -               return ret;
> >> -
> >> -       pcie->clk_reg =3D devm_clk_get(dev, "reg");
> >> -       if (pcie->clk_reg =3D=3D ERR_PTR(-EPROBE_DEFER)) {
> >> -               ret =3D -EPROBE_DEFER;
> >> -               goto fail;
> >> -       }
>
> I don't know much about this device. But from the code here, its
> previous logic is that the function will only return when the error code
> is EPROBE_DEFER, and other errors will continue to execute.
>
> So I followed the previous logic, is it correct=EF=BC=9F

We probably get -EPROBE_DEFER since the clk is not getting enabled during p=
robe.
and we defer the initialization by returning the error. using
dev_err_probe function.
.
We don't need to recheck for EPROBE_DEFER, again it's handled in
dev_err_probe see below.

[1] https://elixir.bootlin.com/linux/v6.10.7/source/drivers/base/core.c#L50=
18

Thanks
-Anand
>
> >> -       if (!IS_ERR(pcie->clk_reg)) {
> >> -               ret =3D clk_prepare_enable(pcie->clk_reg);
> >> -               if (ret)
> >> -                       goto fail_clkreg;
> >> +               return dev_err_probe(dev, PTR_ERR(pcie->clk),
> >> +                               "could not enable clk\n");
> >> +
> >> +       pcie->clk_reg =3D devm_clk_get_enabled(dev, "reg");
> >> +       if (IS_ERR(pcie->clk_reg)) {
> >> +               ret =3D dev_err_probe(dev, PTR_ERR(pcie->clk_reg),
> >> +                               "could not enable reg clk\n");
> >> +               if (ret =3D=3D -EPROBE_DEFER)
> >> +                       goto out;
> > You can drop this check as dev_err_probe handle this inside
> > It will defer the enabling of clock.
> >>          }
> >>
> >>          /* Get the dw-pcie unit configuration/control registers base.=
 */
> >> @@ -308,12 +302,12 @@ static int armada8k_pcie_probe(struct platform_d=
evice *pdev)
> >>          pci->dbi_base =3D devm_pci_remap_cfg_resource(dev, base);
> >>          if (IS_ERR(pci->dbi_base)) {
> >>                  ret =3D PTR_ERR(pci->dbi_base);
> >> -               goto fail_clkreg;
> >> +               goto out;
> >>          }
> >>
> >>          ret =3D armada8k_pcie_setup_phys(pcie);
> >>          if (ret)
> >> -               goto fail_clkreg;
> >> +               goto out;
> >>
> >>          platform_set_drvdata(pdev, pcie);
> >>
> >> @@ -325,11 +319,7 @@ static int armada8k_pcie_probe(struct platform_de=
vice *pdev)
> >>
> >>   disable_phy:
> >>          armada8k_pcie_disable_phys(pcie);
> >> -fail_clkreg:
> >> -       clk_disable_unprepare(pcie->clk_reg);
> >> -fail:
> >> -       clk_disable_unprepare(pcie->clk);
> >> -
> >> +out:
> >>          return ret;
> >>   }
> >>
> > Thanks
> > -Anand
> >> --
> >> 2.25.1
> >>
> >>

