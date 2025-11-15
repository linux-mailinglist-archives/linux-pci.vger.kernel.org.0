Return-Path: <linux-pci+bounces-41294-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C69C602A9
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 10:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8859D348C0F
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 09:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AD327F19F;
	Sat, 15 Nov 2025 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6i4zfta"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D93C2749E6
	for <linux-pci@vger.kernel.org>; Sat, 15 Nov 2025 09:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763200183; cv=none; b=ROzyF6chb9ChfloHdE8B6DAezVAi9Spc2ZKYISos0fsdZuG/nuJ9Hsh6g5F1HWWJ1ewqgoOXKo/VAZ7C9tyN3gXB4ekvbz9cfDhWYh2g2CNwq7qJbNqCdPXWYAW52atIJq+T70zluCAYvqGB/0Q5tASAC9fEhdQD7AELezubk58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763200183; c=relaxed/simple;
	bh=pzql7SHdC4gyXabGm1aAvDmdKPa3cQ9FY4OzZp2mAac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aN96OcxqwTOf63Q+FREHtu8ck5OU3yQFrXaY5/EVQHqKX3fKsigc4DR9mqO/AftsKNT7/ov/3NWWad9Bte88kEie67BJoqd1YnqXGw5UXPhVhPMo5GPSW1iatGLd9ixGWmyYnRzY4tSnBqHJU4Mpz2hQiM616cyU5Z8f5714Nkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6i4zfta; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso2652794b3a.2
        for <linux-pci@vger.kernel.org>; Sat, 15 Nov 2025 01:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763200181; x=1763804981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wE07oQibqqeqSQy9mXIzB1NU0J0tg0hcvxGPotz1NFE=;
        b=a6i4zftaTyuecD3ZKhqMneWz3+8+Kfdpvdqmpfp3dwUrUMJNBYLv6iCWBgLkuRQURp
         DYsxLWY0HL6D156HQLjFCwD7BJnBVMiYrW7ZdJvdmHoV3XULK6pTK+B8AAQyevxGVKns
         pYg1Mlh5iE9PM3JGbZpJThZ0g5wDodyYbgizDnoZjdVnLXif42dwtUL0WKKleDqBRoTE
         fn1hyVE8myU/ALLX2QRCm0wOvapWNEV5ZXqkllIypHoOxNsNgrwC2ozHxJhsVgJHpg28
         Yp4sTnHKXg+ghnAg4xVzXsRwVlDr3LoxHGARigByeiRq9J35XkWo0TJTgklyGCfgthfI
         JKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763200181; x=1763804981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wE07oQibqqeqSQy9mXIzB1NU0J0tg0hcvxGPotz1NFE=;
        b=T2FZIMCViBrHfnGptrGXxb61lE1AaXP4VyFIHpjvwoQG2ie3qXCSCQpfBTOVbismjH
         82cXC950OP0dNj6OVjNvLL/Cm6v1yX2DMF4qs4VZokYVBlRrDt23rh7luSF1M21i70As
         eELzh3MUMbxx/rP2HS+2cWVUCNE4I8P9+UgmGUMiDnM03cKm7h++h89OeEC3W3pvXSl7
         Yz8LLe2hVnLytnhgL1aDPH1T2h9gHUscdjbMB+MiTVgRo67/YOwomf32KZvaWLGGBxOD
         158D0o8hOF1y0GASu61wwoWemlobRfV1MIyGogcjEtOllT0invjlYRrJ3KPZZj4CMLWJ
         n5Kw==
X-Forwarded-Encrypted: i=1; AJvYcCV3uUN3U8ix3oqvWprQ+Mwj3R2tH4AMxGLHze4YDeOM+O4yq3FTgt/kEMO7Usy2995SLkZO+Cq1m64=@vger.kernel.org
X-Gm-Message-State: AOJu0YyycCafWnL+YHHo5zscPlV6fxgG7elGhbomd1j7GNvlpqSa2FYT
	yEGDfJ94bh1vwEvkje8ZRI5IfH2Wu31uUfNEXsgYlnMKYXsSN/HuOaqE
X-Gm-Gg: ASbGncvDAEV+oxRLJUYDgAytlnwmC5NjPUavScaGqYGK4RpqNMjBCme7UgguXFhTIPD
	d/VLXouFIe8W2zvO56CL5lE9RfBUW1ovSSIPbCAk6qxIkN+JcAtec0h/g+DbKwEQDwhNFDfBBAE
	SHwVIS2BgS7Stf4vDC3mPFv7JA0YvVvd73bcOFT2jp8UUA7uGrBfSAzXNyvZd0iQq/Dup2minoc
	lqxG+TRx+BlI0393EO73krBof4AwT9Ya0YY/a42fUVF1fp8Qn4v+DfMvTQVJ6z0ML8DXp26ikF/
	gWMFXAy2zAG0cPgbkGtZKewCI5xrekuQVHjX1Kl6KNUMe+u03lI82wouE+YknvkohwJOdWdmG5s
	YOVCFfiUadHSp9HJ9MSTP3qk1lpXFPGQbrxAmXHeRafRgqFCM2VSq1GTNmp7NJJZNigZ8Ogw1tg
	==
X-Google-Smtp-Source: AGHT+IH17OP8J1VVJXCEJ0MIe3g5xMSq/3p+n5rpNXju3JOpEjrQNJV81hmioCrP4BodIIfRH/nioQ==
X-Received: by 2002:a05:7022:43a6:b0:119:e56b:957b with SMTP id a92af1059eb24-11b40b29d05mr3386170c88.0.1763200181160;
        Sat, 15 Nov 2025 01:49:41 -0800 (PST)
Received: from geday ([2804:7f2:800b:a121::dead:c001])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b060885c0sm23755473c88.3.2025.11.15.01.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 01:49:40 -0800 (PST)
Date: Sat, 15 Nov 2025 06:49:33 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH 1/3] PCI: rockchip: warn of danger of 5.0 GT/s speeds
Message-ID: <aRhMrXz_RlL0WErZ@geday>
References: <cover.1763197368.git.geraldogabriel@gmail.com>
 <d6593ae4f59468f294fdddfef83791e0db100e13.1763197368.git.geraldogabriel@gmail.com>
 <a214ac9a-36d9-6505-64a8-92af2da42cf1@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a214ac9a-36d9-6505-64a8-92af2da42cf1@manjaro.org>

On Sat, Nov 15, 2025 at 10:24:49AM +0100, Dragan Simic wrote:
> Hello Geraldo,
> 
> On Saturday, November 15, 2025 10:10 CET, Geraldo Nascimento <geraldogabriel@gmail.com> wrote:
> > Shawn Lin from Rockchip has reiterated that there may be danger in using
> > their PCIe with 5.0 GT/s speeds. Warn the user if they make a DT change
> > from the default and at the same time, drive at 2.5 GT/s only, in case
> > the DT max-link-speed property is invalid or inexistent.
> > 
> > Fixes: 956cd99b35a8 ("PCI: rockchip: Separate common code from RC driver")
> > Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968b4c21b@rock-chips.com/
> > Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
> > Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> > ---
> >  drivers/pci/controller/pcie-rockchip.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> > index 0f88da378805..ed67886a6d43 100644
> > --- a/drivers/pci/controller/pcie-rockchip.c
> > +++ b/drivers/pci/controller/pcie-rockchip.c
> > @@ -66,8 +66,12 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
> >  	}
> >  
> >  	rockchip->link_gen = of_pci_get_max_link_speed(node);
> > -	if (rockchip->link_gen < 0 || rockchip->link_gen > 2)
> > -		rockchip->link_gen = 2;
> > +	if (rockchip->link_gen < 0 || rockchip->link_gen > 2) {
> > +		rockchip->link_gen = 1;
> > +		dev_warn(dev, "invalid max-link-speed, set to 2.5 GT/s\n");
> > +	}
> > +	else if (rockchip->link_gen == 2)
> > +		dev_warn(dev, "5.0 GT/s may lead to catastrophic failure\n");
> >  
> >  	for (i = 0; i < ROCKCHIP_NUM_PM_RSTS; i++)
> >  		rockchip->pm_rsts[i].id = rockchip_pci_pm_rsts[i];
> 
> Looking good to me, thanks for this patch!  People often declare
> PCIe Gen2 on RK3399-based boards as "works for me", which actually
> happens very often, but such simple evaluations cannot be taken
> as a proof of Gen2 correctness.
> 
> Furthermore, RK3399's internal interconnects limit the effective
> I/O speed of PCIe transfers already, so switching to PCIe Gen1
> actually doesn't result in some large I/O performance penalties.
> 
> With all that in mind, please feel free to include
> 
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>

Hi Dragan,

I think I'll include a Reported-By: you too, since you were the first to
warn me of unknown errata regarding Rockchip PCIe.

I told you it was a test of mine but I didn't realize the grave danger
implied by Shawn Lin declarations.

Once I realized this could end badly the only way I could retribute was
to send a few corrections :)

Thank you,
Geraldo Nascimento

