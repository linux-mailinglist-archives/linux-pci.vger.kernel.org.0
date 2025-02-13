Return-Path: <linux-pci+bounces-21372-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13145A34C8C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 18:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68B46188CCD6
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 17:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC22241682;
	Thu, 13 Feb 2025 17:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQSCv8KV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C602063E1;
	Thu, 13 Feb 2025 17:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469393; cv=none; b=j0xwBA79IopgiOLzYX3ddJiSUWlG26nJ6EOfX8yGbgNhVMwY31telahMeBEn+1ECGZ8NugBNz4+Gv1CVe/VuOSUMMCDpf99yblyMZWXYbssjZsXZnUdIVtPPOJdPSa51gy60DM9bSG/v7nLKTV15iU7X8x/kZGJ8TIw1Vbc4KN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469393; c=relaxed/simple;
	bh=zu6XwvxRWfLZhbU+NQRFBvpihnBJdGqYI23riG2Rn94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJ98NOwgqDr7LMkjKwJcBYoMvGJ1kwZr7Z7YG+RzfOESA+k5eWN9YC3hGk1izSaQik7r0/AYKy8w2PpZfYUJ07p27cTaEEZkQUnIdP9/qrnGeWwPcbB2HefzI9AtcqKNmIr3OlawSnXxYmK/uvMy/p+O8i1/4WFw+FL6yqHl2vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQSCv8KV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B50CC4CEE7;
	Thu, 13 Feb 2025 17:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739469392;
	bh=zu6XwvxRWfLZhbU+NQRFBvpihnBJdGqYI23riG2Rn94=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DQSCv8KVcTJfUl5QCqlb1aPWdpHME3qfxr2BivoYk1VpoYEyZwZG/Pk73Czq+skEu
	 oKKCCD/YJjrItngdSK0146kMNHvpo0YkaPBs2GSQF3YY6jsjbUj1Qmd70VJ6dqs9vx
	 GnfnwHfUjdQv3ruq2pVdRmm4oX3pqAjgUizmTb1TfQrk/IxgTI5462HQQ/XYudg5mb
	 VCo1ECe0H2RaG8JXOcuWkm5I9C6hXAOnFQT2ZcXtvOPnPWmZjv3wiqBa2zd6tVfEYI
	 d9oguZ7nRm0jEJEWZSDpj+xYvjAVtW1lSsY6CbbfbEt+iq73hNwrnGSNtLsgDGZlj+
	 FOUMn/2lxIQfA==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d9837f201aso4621005a12.0;
        Thu, 13 Feb 2025 09:56:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUIfLZpIQshHB/gOvxJ0PCHLzF0trXLMiqv6HOS+uL9/mbPUS0rh7eOPnZFciinGxAC9g1CjSOSauG9@vger.kernel.org, AJvYcCV3zT8XUB2FMuEjBsRFJJFArZpb7/f2LoWnCNRRv300sNjbqyMqGAMCWY2vVemfOvoObOwRHDyknsZm@vger.kernel.org, AJvYcCVu+zJUXoWtTP3teq1jQdJIYmg32b4s6+4tIjoA0V+SkmCJnbtGu2q47dQY7TcIyim7T5kJqQXctWn4HK1d@vger.kernel.org
X-Gm-Message-State: AOJu0YyB0tnBpmMLm42Vh1PaH9KBAilQQLdTD3qIMaOIBYGGREUV62Da
	/TM6XWR9GNhHrpWGyAX5l9RploI3QeKhmky4DsZww2B6Nwh6t83RWQ97ZEjfGhWdanIPAljuYkg
	lvzXF/Jfj7mRHVvB40f4RXpoh9g==
X-Google-Smtp-Source: AGHT+IHTeCe7WowntB6fs9UcxQzrutTfaoimXk6oistVCJvHwS4uUZuMCGZVr/Sa699J0jyvKNfSQ6RXSzn0q5mmsec=
X-Received: by 2002:a05:6402:2755:b0:5de:a972:8c7 with SMTP id
 4fb4d7f45d1cf-5decba4bf54mr3906685a12.5.1739469390719; Thu, 13 Feb 2025
 09:56:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211-pcie-t6-v1-0-b60e6d2501bb@rosenzweig.io> <20250211-pcie-t6-v1-7-b60e6d2501bb@rosenzweig.io>
In-Reply-To: <20250211-pcie-t6-v1-7-b60e6d2501bb@rosenzweig.io>
From: Rob Herring <robh@kernel.org>
Date: Thu, 13 Feb 2025 11:56:19 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ-sYsy-11_UiEKrKok49-a-VJUvm3vBGbpu9vY3TKLUw@mail.gmail.com>
X-Gm-Features: AWEUYZnNrV6AeqfriIoD2NAW7TvpHv4rdwKYJwl0y8ybKwiiM0n7mQqePyuXunc
Message-ID: <CAL_JsqJ-sYsy-11_UiEKrKok49-a-VJUvm3vBGbpu9vY3TKLUw@mail.gmail.com>
Subject: Re: [PATCH 7/7] PCI: apple: Add T602x PCIe support
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Mark Kettenis <kettenis@openbsd.org>, 
	Marc Zyngier <maz@kernel.org>, Stan Skowronek <stan@corellium.com>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 1:54=E2=80=AFPM Alyssa Rosenzweig <alyssa@rosenzwei=
g.io> wrote:
>
> From: Hector Martin <marcan@marcan.st>
>
> This version of the hardware moved around a bunch of registers, so we
> drop the old compatible for these and introduce register offset
> structures to handle the differences.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> ---
>  drivers/pci/controller/pcie-apple.c | 125 ++++++++++++++++++++++++++++++=
------
>  1 file changed, 105 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller=
/pcie-apple.c
> index 7f4839fb0a5b15a9ca87337f53c14a1ce08301fc..7c598334427cb56ca066890ac=
61143ae1d3ed744 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -26,6 +26,7 @@
>  #include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/msi.h>
> +#include <linux/of_device.h>

Drivers should not need this...

> +const struct reg_info t602x_hw =3D {
> +       .phy_lane_ctl =3D 0,
> +       .port_msiaddr =3D PORT_T602X_MSIADDR,
> +       .port_msiaddr_hi =3D PORT_T602X_MSIADDR_HI,
> +       .port_refclk =3D 0,
> +       .port_perst =3D PORT_T602X_PERST,
> +       .port_rid2sid =3D PORT_T602X_RID2SID,
> +       .port_msimap =3D PORT_T602X_MSIMAP,
> +       .max_rid2sid =3D 512, /* 16 on t602x, guess for autodetect on fut=
ure HW */
> +       .max_msimap =3D 512, /* 96 on t602x, guess for autodetect on futu=
re HW */
> +};
> +
> +static const struct of_device_id apple_pcie_of_match_hw[] =3D {
> +       { .compatible =3D "apple,t6020-pcie", .data =3D &t602x_hw },
> +       { .compatible =3D "apple,pcie", .data =3D &t8103_hw },
> +       { }
> +};

You should not have 2 match tables.

> @@ -750,13 +828,19 @@ static int apple_pcie_init(struct pci_config_window=
 *cfg)
>         struct platform_device *platform =3D to_platform_device(dev);
>         struct device_node *of_port;
>         struct apple_pcie *pcie;
> +       const struct of_device_id *match;
>         int ret;
>
> +       match =3D of_match_device(apple_pcie_of_match_hw, dev);
> +       if (!match)
> +               return -ENODEV;
> +
>         pcie =3D devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>         if (!pcie)
>                 return -ENOMEM;
>
>         pcie->dev =3D dev;
> +       pcie->hw =3D match->data;
>
>         mutex_init(&pcie->lock);
>
> @@ -795,6 +879,7 @@ static const struct pci_ecam_ops apple_pcie_cfg_ecam_=
ops =3D {
>  };
>
>  static const struct of_device_id apple_pcie_of_match[] =3D {
> +       { .compatible =3D "apple,t6020-pcie", .data =3D &apple_pcie_cfg_e=
cam_ops },
>         { .compatible =3D "apple,pcie", .data =3D &apple_pcie_cfg_ecam_op=
s },
>         { }

You are going to need to merge the data to 1 struct.

And then use (of_)?device_get_match_data() in probe().

Rob

