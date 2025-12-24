Return-Path: <linux-pci+bounces-43638-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D8CCDB60F
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 06:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A4673016DCC
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 05:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703DB2D63F8;
	Wed, 24 Dec 2025 05:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzFuzYHw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1992BD01B
	for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2025 05:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766553521; cv=none; b=n2Vy2Bo5EAV5qpOVzlc+Rg/YM+9zi2vZLqOK6M5CvONMxhDkRBMPROeY6RMB/OOWxuhleLNr6ht1wX8EemVefgZG8CcRG8u31pWVuiNkQpd96BBll6RGz+Ayn54HYcpLJ89OBpuIRijNKyG5zmBuhABhnIUGJxRAZFbczCmmDGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766553521; c=relaxed/simple;
	bh=WlMzKhHNURjonYFkyLxZRPQ9wOYejuTDM97ssfOBVV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGLz1hYVZFs1npXfnD16s3wp90472ZvAZRYFjIxmidS87Nkkg0HO31J95KTHOpHRJdi9JpW4L4kw7vGH/OGru17DAYtDB2A1p7PqYGuD3BzDszVni43+HST2VBAFoUSvBI6lrF/YUlhtwo3myjqm81jdqhFyQzoTncvZfof8v80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzFuzYHw; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64951939e1eso8493755a12.1
        for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 21:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766553518; x=1767158318; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u6LC33FrBHnFwijckLFQe8PlcMlhWZbaNpDq7Z3k5U4=;
        b=mzFuzYHwhgbk09IBp4BlJpB3AWOXHtgMHmpboFJ6vYXUdnvzgUQdNhT3ToNqoXb4/O
         bgGgH1XnZtUy2zyE4K4XwaToLYHjtnscf89RHXLM2OaYQPy023us35ZBjsiWcZEXAjTK
         8Go+dy7TR1MSo1nuLCluELuMreTYO2Q2lKZpN+m/nAonPvyBpFI2MwpCbc9K8rV7xeC8
         tzD6CgYoLjfwXPbDySWeiqRyyi11BKRlcVcDll6qpOPzYFbFkIUA1PDdxD52Iic6SVme
         V9Kij6J4lwkseK09SMaZHOhF6Q85VtLVfe1KbaDdEt5eNySsztm3A7nde+aB899vQNuH
         ocUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766553518; x=1767158318;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6LC33FrBHnFwijckLFQe8PlcMlhWZbaNpDq7Z3k5U4=;
        b=CeAv3VVUG9N2hw5ZaWvpGESHQDqu112qhT2CC0hGKVvffJwy/j3LljTQhbfp7VDLKW
         IaKCLj02GkoheQxEbCmBiPqS9ykltCIj+kFlf+J9lwxoqzdexs3NsItBZxbOLThEaWXM
         NzzUBv0w+k5/fYH7NCodGNg83Wkh64ap/35yfy8ZBjTUfssc2zkAAUHdytEMmXEVubdb
         GsZZgL40OEcwC3I1rvB/fSALapEs//ou8tL5vOPrk/y+0TnNcs/9bE0KEgLCqpODoKqf
         f987CmrE+gA/NDi/jWReEMaZbjSsMECfktHOgVSbMV1UemHEmr+Y2fpjKkIw08ocDDd5
         x4UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzAtlctmdg050xy1HETXjbH/C02Re27IaKlrzBy1wTGRLQPy+s+0MAsMsiYcLiXZ4ldzyGmfLqAWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwicmFgOTO5SA9CbWs2nUGHkAEmI0kspnH+H00ZoCzRlhWdMW7u
	vaLPZhivB1SafMwMX6TCLTFf07/f4DwUcnCv2ALwzQJeka/fnjc1rrtw7HPLha2mAqMerSqxO1X
	0qR6BAPIpkfBUF6EfDlszGLUh7yVWbUQ=
X-Gm-Gg: AY/fxX7zstEgeZf+vM3hWrW3HTSrs3dE5TORIxdaCLyfCGdM8EgJkbetfYd5R+tBkRO
	R4ZHyoXvNJy1z7AJEwpsTyOOoTIyI/Odi9sb50LFa9Ez1MhdK9BOIIhNmNQB2g4kYxrPn2yz9aW
	eHevu872yMkNfxPiDiPK45Wgsm0BP6KxpGNKu2c1X8XkmCBovtT95vgLlk0rEGkBveVeCKiZ97o
	b5LBwaTEGeGL4gOjD48+wkVv3bWuHFnLw33SsCO+2tffDhpzWAZRMAXGztmup4xF64=
X-Google-Smtp-Source: AGHT+IE5dtPIKyU8ptUI2hkdMI7fwbMdU7esjAJmTvjiO17a7ITetL6IcJCGHQwxARRvQd0qeb1vLtgPofOSuLa2c5M=
X-Received: by 2002:a05:6402:5188:b0:64b:572e:6ba5 with SMTP id
 4fb4d7f45d1cf-64b8e93c0dbmr15294044a12.4.1766553517792; Tue, 23 Dec 2025
 21:18:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763415705.git.geraldogabriel@gmail.com> <eaa9c75ca02a53f8bcc293b8bc73d013e26ec253.1763415706.git.geraldogabriel@gmail.com>
In-Reply-To: <eaa9c75ca02a53f8bcc293b8bc73d013e26ec253.1763415706.git.geraldogabriel@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 24 Dec 2025 10:48:20 +0530
X-Gm-Features: AQt7F2pedp4R-xyN_-ijj3Fu8brq9lijlFOC48RK9mmQXfW6wy7VvzSVIN4mKhs
Message-ID: <CANAwSgQ726J_vnDKEKd94Kq62kx8ToZzUGysz4r3tNAXvfAbGA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] PCI: rockchip: limit RK3399 to 2.5 GT/s to prevent damage
To: Geraldo Nascimento <geraldogabriel@gmail.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johan Jonker <jbx6244@gmail.com>, Dragan Simic <dsimic@manjaro.org>, 
	linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Geraldo,

On Tue, 18 Nov 2025 at 03:17, Geraldo Nascimento
<geraldogabriel@gmail.com> wrote:
>
> Shawn Lin from Rockchip has reiterated that there may be danger in using
> their PCIe with 5.0 GT/s speeds. Warn the user if they make a DT change
> from the default and drive at 2.5 GT/s only, even if the DT
> max-link-speed property is invalid or inexistent.
>
> This change is corroborated by RK3399 official datasheet [1], which
> says maximum link speed for this platform is 2.5 GT/s.
>
> [1] https://opensource.rock-chips.com/images/d/d7/Rockchip_RK3399_Datasheet_V2.1-20200323.pdf
>
To accurately determine the operating speed, we can leverage the
PCIE_CLIENT_BASIC_STATUS0/1 fields.
This provides a dynamic mechanism to resolve the issue.

[1] https://github.com/torvalds/linux/blob/master/drivers/pci/controller/pcie-rockchip-ep.c#L533-L595

Thanks
-Anand

> Fixes: 956cd99b35a8 ("PCI: rockchip: Separate common code from RC driver")
> Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968b4c21b@rock-chips.com/
> Cc: stable@vger.kernel.org
> Reported-by: Dragan Simic <dsimic@manjaro.org>
> Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> ---
>  drivers/pci/controller/pcie-rockchip.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> index 0f88da378805..992ccf4b139e 100644
> --- a/drivers/pci/controller/pcie-rockchip.c
> +++ b/drivers/pci/controller/pcie-rockchip.c
> @@ -66,8 +66,14 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
>         }
>
>         rockchip->link_gen = of_pci_get_max_link_speed(node);
> -       if (rockchip->link_gen < 0 || rockchip->link_gen > 2)
> -               rockchip->link_gen = 2;
> +       if (rockchip->link_gen < 0 || rockchip->link_gen > 2) {
> +               rockchip->link_gen = 1;
> +               dev_warn(dev, "invalid max-link-speed, set to 2.5 GT/s\n");
> +       }
> +       else if (rockchip->link_gen == 2) {
> +               rockchip->link_gen = 1;
> +               dev_warn(dev, "5.0 GT/s is dangerous, set to 2.5 GT/s\n");
> +       }
>
>         for (i = 0; i < ROCKCHIP_NUM_PM_RSTS; i++)
>                 rockchip->pm_rsts[i].id = rockchip_pci_pm_rsts[i];
> --
> 2.49.0
>
>

