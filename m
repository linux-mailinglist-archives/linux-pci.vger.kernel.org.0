Return-Path: <linux-pci+bounces-39449-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E86C0F689
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 17:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C4A424998
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 16:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE26314A6D;
	Mon, 27 Oct 2025 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULVYsaY6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9683128C1
	for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 16:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582705; cv=none; b=nVNRyx/KUW35DYa7HrF5Dt12kaFHJPvrWs1HRoyE4ezx5pbTyXDPuLCavlZI9gx52g4HJzViZjP0BIiRoR/HRnUQdlYHE5HAZfvh3nBiHzTvjLF5XmikzSsUem9uiaoELK9WFeFysk+uXK9T4pBAnV/FLjXOTQ9+kJfcXUnMZgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582705; c=relaxed/simple;
	bh=u0gnzZoUVwZGmc0CbqBeoDdTI2LNBosTaViTZaZ4Das=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WFdrUbZ/WoG/OW9NfM8GOuJFTVYm9hyAtYcPMg0+CESvQNqW8WS/6SzZz1qRztSKiLKOJWe+VLPA2i8u79sjiRWuZ0bLNKWotqv/AtI8aeT9GlWoFbWibXESWcWfRexf3SNd1H25NuxDiz2NSt7/Ir5pqK9sM6KgAH/g6UGcUlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULVYsaY6; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63c11011e01so7300188a12.2
        for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 09:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761582702; x=1762187502; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IgLf2SVScm95+f02HH0OAwFjGNzD1ph15QV31vmZKhE=;
        b=ULVYsaY64HxwJFkmrOm3Uwh0Dpf9MGQlMCLrihVCdXsmi6m6GT+IUVfOTJ8qiNoxeo
         7Bl2Zvz9MNg5EgXFqTkgaagFBJebYQUAha3wuaD3V1+Uopttor/rxaJXleXbocvejGdw
         jKtzb207thW9VR8aJtajRJ6cYCW5DxJVak3siBxJNIGH2es8SeL7V5Yk5W2mur0lRM8J
         G5OMtk8dW0LHJtpWgrMn6sIlOzeg7b2twTbDyJhT9+Ea6V7apPBL+tDG4mxKNS0LE9rW
         VQuwsIeopHMNpmz4Vgu/EKc4CAJat5fYDQuVNUEros/oHMcvxGDKCVIZdH9ZMOP+PcZa
         ZH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761582702; x=1762187502;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IgLf2SVScm95+f02HH0OAwFjGNzD1ph15QV31vmZKhE=;
        b=l4Snn4j3Vop2EMc+Zgivct+paDYodoSuR8Hk0Ic2hpwuHeYl6Xgab9i5N0BKo7wLaH
         8Ytu15Dy9x1tGozHPvm1bQFOZD/MeVKMwRvWs2NZHOklp3NYcJ8UrkEpU0o3oYL2w/cN
         nP1bZM1uj87lMZA6+Bl+UOCxieRnA/xsDzh5hJ+YCZrwBFyTbFcWMr73HiZHSzSSkJxB
         gBDRrPSXdsbU2j6ruElTNv/kixHEVAflpYcdtJ7LZYYqVfOHmFBeemIh8Ulj32ZeZsQT
         coTplfBaj5cmAmeA5jSFyy6m0FS1OEKtrlqp3nSq/yg6TPoctpErUtEY1a3TSUhklwr+
         v/jg==
X-Forwarded-Encrypted: i=1; AJvYcCUZqrJOkkGhNCwEsktiOgHYIzAh5z9Hw6vd+d+P5Z7PL4LqjyWs7HPcdJf+D/MhLI9YXUVfEz+BiWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfY29GVfYisp1tuoSMp9ctJv53nkQ5AD9ZviZDqR/E4SJJMrTP
	+MAfCKbDxp+ywVCj6LPLNBFUqAh2mYqwCJdv3NY2Ydaie1wTzU9+ItrDNnylbdv2cH6TNwmSITg
	sqD+DnHqkjlja2Pe2ol/yEY9qI4ZajfU=
X-Gm-Gg: ASbGncsn5G8wLAK+ZYWpRjVbZ/STbpUVyi+1S9xKbrTBqMqoPQRezNekaTV4flQlek1
	AhcwqMQRHdjXfhetfHh4a3rHokDqqnpyy74hpCTyJHoh63lT1gGSGDvOLVo1DNmIP6SD07w8NNx
	nAu2Kd8bA2g5unKByt/TSaPi7cgPucYA2i8HOmuLxTHjdo4Te6SR2/Oawf5i8KYolDeasmiYMKi
	IOM6e2Hv5J3BZAbuTh5Q9wqLkCS1IE/qkQdHxd7DYVKAFJKwcDNmxcC1KE=
X-Google-Smtp-Source: AGHT+IG/IzMgRJGe0oU595mEmHs6fWEe0QVZBG2v7Ej1G6fm9/HYSbgpPg786Jnq6SwSPlQ24dt/1V+XJmYkuCP5oq0=
X-Received: by 2002:a05:6402:280d:b0:63e:914e:5159 with SMTP id
 4fb4d7f45d1cf-63ed810957cmr526172a12.13.1761582701754; Mon, 27 Oct 2025
 09:31:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027145602.199154-1-linux.amoon@gmail.com>
 <20251027145602.199154-2-linux.amoon@gmail.com> <5235617.GXAFRqVoOG@workhorse>
In-Reply-To: <5235617.GXAFRqVoOG@workhorse>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 27 Oct 2025 22:01:23 +0530
X-Gm-Features: AWmQ_bmuEGyIyVMM2F7v93d4eNawEzucpBZ6agLVtw_PaD2oW-53hrPDNMYJwI8
Message-ID: <CANAwSgTmOvOZ35=3XjhrKu2iPCMOU8c8prK5XVAkf3cF1DHekQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] PCI: dw-rockchip: Add remove callback for resource cleanup
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Niklas Cassel <cassel@kernel.org>, 
	Shawn Lin <shawn.lin@rock-chips.com>, Hans Zhang <18255117159@163.com>, 
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, 
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Nicolas,

Thanks for your review comments.

On Mon, 27 Oct 2025 at 20:42, Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> On Monday, 27 October 2025 15:55:29 Central European Standard Time Anand Moon wrote:
> > Introduce a .remove() callback to the Rockchip DesignWare PCIe
> > controller driver to ensure proper resource deinitialization during
> > device removal. This includes disabling clocks and deinitializing the
> > PCIe PHY.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > index 87dd2dd188b4..b878ae8e2b3e 100644
> > --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > @@ -717,6 +717,16 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
> >       return ret;
> >  }
> >
> > +static void rockchip_pcie_remove(struct platform_device *pdev)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
> > +
> > +     /* Perform other cleanups as necessary */
> > +     clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
> > +     rockchip_pcie_phy_deinit(rockchip);
>
> You may want to add a
>
>     if (rockchip->vpcie3v3)
>             regulator_disable(rockchip->vpcie3v3);
>
> here, since it's enabled in the probe function if it's found.
>
> Not doing so means the regulator core will produce a warning
> splat when devres removes it I'm fairly sure.
>
I've removed the dependency on vpcie3v3 in the following commit:
 c930b10f17c0 ("PCI: dw-rockchip: Simplify regulator setup with
devm_regulator_get_enable_optional()")
Please review this commit and confirm if everything looks good.

> Kind regards,
> Nicolas Frattaroli
>
Thanks
-Anand

