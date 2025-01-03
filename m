Return-Path: <linux-pci+bounces-19232-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E244A00B28
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 16:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E7BC7A1208
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 15:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF8C1FA140;
	Fri,  3 Jan 2025 15:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFqv9iGG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616901FA24D;
	Fri,  3 Jan 2025 15:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735916800; cv=none; b=t+TeXhfQeFbb2cIK5JL8hk2vZKJVYWZsW/TPiFUyU5AqAhZcFLhHZHRgfLdv7k3jwGyVvp19f2q/FsTiXpDBR0zZhzc7v2lnCi42ANH/AFOrrPR9h807Only4juuy5Tc4EnPC6rPpl4Gy7cpWmvbFjcr6BBOfQNmTB3xbC8RRQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735916800; c=relaxed/simple;
	bh=yXglbPGb9C6MIAjoR3rdlsuhmeM8DLLc/3DAkc0exoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NTss9h509k9J4PH3Dxu0Qb/sr9Fjw/YwAL+ojIiMON6ahzL6872Bnd47zuT0GjRAXeQHxR7hklkx8AvPW5siP3eR1gQeKdaRZfTQ5oYEqUJnzkLTEUzBimLreRXJUjNnsnpvh/DK6ukGpoZDsJX/8YD3bNABWlDBfb611R+4P4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFqv9iGG; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso338713566b.3;
        Fri, 03 Jan 2025 07:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735916796; x=1736521596; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yXglbPGb9C6MIAjoR3rdlsuhmeM8DLLc/3DAkc0exoU=;
        b=FFqv9iGGiXg6BdHwulmbHvrlJRxsCoI3FLptxOgCDI9B1EqSgig3c6nV7+Jh1iKlMj
         npZl6r4OeHs8XgCkJk58DIfU8vrMg/Zhb3o77d3tz6s5nAU9e+W7topEY5/HHWAQah7+
         /DedMfyFsfQIu07wiyMeh03FK/YDdhV6YS2Z6icjQhFCgVdY3R2m/yPPIZAORWKFMETB
         edEpewl+YfsIk8/RyogEc5odcCODnU411zetGlyMpPeo1q+4wKdCEtqP+ESHEsmd+kOJ
         7REiqAQ9qX5dl7Q5+PzamuA+q01YazSXc3vdRqGXzDfOycvN6khxxb/iWQolbc0rYpmZ
         Bs7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735916796; x=1736521596;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yXglbPGb9C6MIAjoR3rdlsuhmeM8DLLc/3DAkc0exoU=;
        b=knkqDeaHJvD0PisdiJCd+4tTsDDFWPtADgnWGLM4bORU94UV1CYIctPr+MOry3Cify
         Sm8lgTCDhi6+tUVkd+fCLrml/xeFC58ztqq406zjJz2u0h1XL6F9eLoL0Hz0znnHSe0E
         adzzI0yvI7q14CEdUxqxM4V2FnXHcH4EpRgJmcmrrdclMBalCmUbY0xREILBD/dIZT2W
         WGkaPytX3Ka4c3z5lf/vpMSvdo4drCM3TaQMbE1QzrA63eVCVNgrjgRkXTSX7QMrgT2J
         zxCkczde7X31OJM6cBNfENGqAyWloYpyFTtn+1DqJ7kAFKXo1/ng5bXhfzAvQZmPez57
         MagA==
X-Forwarded-Encrypted: i=1; AJvYcCXX1NkwEljEIaJ/6mBQyLDg12UKw2AqleTUFFP5DdooRICJlXyx1MPq6d5s5LWYG/eYiddNEhmeiUN+NzY=@vger.kernel.org, AJvYcCXXNST9FZd7/QuJCMcW2Zzixu0ka93HSEtJuzuJvhMOQeLis+dMAjTUZo6dVQyX0BEdMWPKYXQ0n4Ks@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+7SFYfQhChnWFIxaVffkyemjuB2a5mbiP8KLKoPgCQz0JIwRs
	aBxMGtXHE5ESnqfVTG2HZzdLynIh4OPanRSCs8JP258E7ssf6UH4ysjjSb5+0mMUPDZixM+m3f7
	V/SrlD2T9o51jYCx3zPkLbkFZsbQ=
X-Gm-Gg: ASbGncvgA3aw9G1qHR1llaoDei0k89OUaCpJpgYYWc6+8qVu1/Bq7SKHCA+zOa18f5T
	3gE33lukbsNxFy69gpv2yn7qutUmw+JXG66mS+g==
X-Google-Smtp-Source: AGHT+IGCd5KMQFAQzvrcouo2Ud/xiJbNIhdYf82yQR4GFtXoLT6FjxC+PsYw+V7e4lq8bAmqOaKWWNmajdpv0ZS7Brk=
X-Received: by 2002:a17:907:1b1e:b0:aae:ec9d:5fdb with SMTP id
 a640c23a62f3a-aaeec9d6191mr3759466966b.28.1735916795882; Fri, 03 Jan 2025
 07:06:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809073610.2517-1-linux.amoon@gmail.com> <Z3fKkTSFFcU9gQLg@ryzen>
 <CANAwSgS5ZWGTP+A11r_qFSrjWZH_DqsM89MLiP+1VAxhz+e+2A@mail.gmail.com>
 <Z3fzad51PIxccDGX@ryzen> <CANAwSgQEunirUf3O3FJJAUsQu9mQYD_Y40uJ_zMYDZYVy5J=wQ@mail.gmail.com>
 <Z3f4JQZ6yYV1BJ-b@ryzen>
In-Reply-To: <Z3f4JQZ6yYV1BJ-b@ryzen>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 3 Jan 2025 20:36:18 +0530
Message-ID: <CANAwSgRTcHuDNLvPJAs7ZaV-NnepeOkHj_kVc5OAJtP03hd6pQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: dw-rockchip: Enable async probe by default
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Niklas

On Fri, 3 Jan 2025 at 20:16, Niklas Cassel <cassel@kernel.org> wrote:
>
> On Fri, Jan 03, 2025 at 08:10:17PM +0530, Anand Moon wrote:
> > Hi Niklas
> >
> > On Fri, 3 Jan 2025 at 19:55, Niklas Cassel <cassel@kernel.org> wrote:
> > >
> > > Hello Anand,
> > >
> > > On Fri, Jan 03, 2025 at 07:24:07PM +0530, Anand Moon wrote:
> > > >
> > > > Thanks for testing this patch.
> > > >
> > > > This patch should have been tested on hardware that includes all the
> > > > relevant controllers,
> > > > such as PCI 2.0, PCI 3.0, and the SATA controller.
> > > > I will test this patch again on all the Radxa devices I have.
> > > >
> > > > This patch's dependency lies in deferring the probe until the PHY
> > > > controller initializes.
> > > >
> > > > CONFIG_PHY_ROCKCHIP_NANENG_COMBO_PHY=m
> > >
> > >
> > > Note that the splat, as reported in this thread, and in:
> > > https://lore.kernel.org/netdev/20250101235122.704012-1-francesco@valla.it/T/
> > >
> > > is related to the network PHY (CONFIG_REALTEK_PHY) on the RTL8125 NIC,
> > > which is connected to one of the PCIe Gen2 controllers, not the PCIe PHY
> > > on the PCIe controller (CONFIG_PHY_ROCKCHIP_NANENG_COMBO_PHY) itself.
> > >
> > > For the record, I run with all the relevant drivers as built-in:
> > > CONFIG_PCIE_ROCKCHIP_DW_HOST=y
> > > CONFIG_PHY_ROCKCHIP_NANENG_COMBO_PHY=y (for the PCIe Gen2 controllers)
> > > CONFIG_PHY_ROCKCHIP_SNPS_PCIE3=y (for the PCIe Gen3 controllers)
> > > CONFIG_R8169=y
> > > CONFIG_REALTEK_PHY=y
> > >
> > >
> > > >
> > > > To my surprise, we have not enabled mdio on Rock-5B boards.
> > > > can you check if these changes work on your end?
> > >
> > > I think these changes are wrong, at least for rock5b.
> >
> > We need to enable the GMAC PHY and reset it using the proper GPIO pin
> > (PCIE_PERST_L).
> > Please refer to the schematic for more details.
>
> The PERST# GPIO is already asserted + deasserted from the PCIe Root Complex
> (host) driver:
> https://github.com/torvalds/linux/blob/v6.13-rc5/drivers/pci/controller/dwc/pcie-dw-rockchip.c#L191-L206
>
> which will cause the endpoint device (a RTL8125 NIC in this case)
> to be reset during bootup.
>
Thanks for letting me know. It seems like a workaround.
I'll try to disable this and test it again.

My point is that we haven't enabled the GMAC PHY (device nodes)
and must properly reset the GMAC.

We're relying on the code above hack to do that job.

>
> Kind regards,
> Niklas
Thanks
-Anand

