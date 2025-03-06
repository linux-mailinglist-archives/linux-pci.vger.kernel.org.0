Return-Path: <linux-pci+bounces-23044-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B51A544B1
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 09:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECB843A992B
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 08:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20A8206F1D;
	Thu,  6 Mar 2025 08:22:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A423E1FC119;
	Thu,  6 Mar 2025 08:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249371; cv=none; b=FbzSJp8/3IEpZYxZGbIDoRIQp0tfzZsPQyXgllR07/g6Pd3/98zwPJaLA0mvPl9WY4jwxwFhXd6k/4KpgYUgWkzp2Hnqa5oe+bSV+si7LaHBh32oRICVPZ7HoGn16Q7NX4OhbbHXyvq8P9weBNEvwpKpO64/cYf7x5WF+WSP4dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249371; c=relaxed/simple;
	bh=pukdi8UtngLWSTK0RiOB7GIFMpGrGcHkmXsaY8bzxNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lZJVX/ug/O8se+b4kjo+35gQvKGkqz8qFZd+oi3Ry71qQrINSj8ISwgJthvDf1ngme2yvoyq/g5io9AfTjKf9blew2GrGMThmycrD9DH4xUV8QehwHpEEsi5HAk9oXyHdmjlK6v1admkoO1IcL6NM4f0k/s8WUcbBCL3ku1Ch90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-523bf140eccso510520e0c.0;
        Thu, 06 Mar 2025 00:22:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741249368; x=1741854168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRrVZ0Qb4mFOKQncQdIGVomsgNpOi0dxaE9w627ruA0=;
        b=eGanvIMXSJWnPiFV4dC92Nw+PWCua4AcTfk4ndQNEUGS3LUvWQ1vQOsdSMZjxupD7N
         UY10WWViE0FWGkAiRcTgch+zOw3a7p4oW+ciNOMum8QJsgSJQKwcVelKWvjFew8qSjtY
         TDTyA+XVhjcXJ+MKtX8/FWelm76I1z39OSEKQmr8nJGJIdDLr16V1LHK9duQaXunTTIz
         KF2g7p3r20E/776NKCHEQMI7mQwC4hY/5QbZN8ezHAWI4DuhfaCN0DQLjSuhbur6DrzR
         ygfRSrp+GAjrA0m6F9dV6LZ9z6iUm99r1V/F0bSdaJkN0WKZeIiz9t7DUTpm5ctlM+hH
         Yhrw==
X-Forwarded-Encrypted: i=1; AJvYcCUwIuKa7Cn7f8tEE5lmjOKktiCQDBKZrioj1tXZiymQMpsKeFoQ/UVIkaWa8xjivxEo7ZQP5UteKHcVE0briVuqFg==@vger.kernel.org, AJvYcCVTo9Tsxvz2Q1fi/KpMhw42Xpg58MYGcaTgbJVWwQxlyE1PG76xcPO88hRVnjQeHZTfMm4ZsEPeaG8I@vger.kernel.org, AJvYcCVsOUXveQoQFzFPppUY5EuGNiZfsXGBd8oytbRA6gDl8BOg9kIf1oYrR0ropwERXeqTDNgM7I2scq7vyO0=@vger.kernel.org, AJvYcCWayD2tqK+rG5bxaTr7B1/nH6G2fyeI/6oA38Mu1z6wq+srOv9nrae2eTDa85RVfyuKahlVEIRVsmHAaz06UfHsYaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqp/Lq5g7Y0fZxR39dJKkYoE09UVENgKv6uTn6Oe3SUIF32XlM
	EAWK2VgUKhUw8/YnDk2J/gMj/6c+CNal9PlYkniyPaNk6lJtQxiD9t+IoXbC
X-Gm-Gg: ASbGncuSBKBmIPnNmvW2ZNKFBz72ZTMQN8eQ+JBi40/7MBfHB2WvG5o/tlO3klHbVGm
	ABF1Z4kMr6PJy1Xiu5L0chW66kt8sZ1tvOnIVH0WPrL9OR3eA6yPSJNfmjU21HbPYYWbsn3/UR8
	9SmOgWFa03Brk41+hPXXmk7y7V4sU+G1g/2AZfRbf8EMD0r3PPdFMZHNIBYwyO2rYql95+Jq3xo
	SMC8AQ7AlBH6E56py0FfB1y774jvxiPG5vK/rktPSX9U8onRbc+DAFQYFo557xI5zWTuDsQQFmh
	Sqeg5VPDf+773QZnXKf7zREjJewIQs3N1sb/2uk8FYut3UImwasj68VkYsM9y5VF4ra2qisg+EK
	qRAMkHgg=
X-Google-Smtp-Source: AGHT+IEF7Bk+YzM0FJVs21ZthTCQsIgAALWxRqcwaxTWxnJ87UxJKa7kaDN1WW94AZpty8Xphy+TTA==
X-Received: by 2002:a05:6122:4d19:b0:50d:39aa:7881 with SMTP id 71dfb90a1353d-523d4f005f9mr1580065e0c.0.1741249367680;
        Thu, 06 Mar 2025 00:22:47 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-523d8a85320sm119527e0c.8.2025.03.06.00.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 00:22:46 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-860f0e91121so1761709241.0;
        Thu, 06 Mar 2025 00:22:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVAfut96joLXAyWozfcykF+WpHhLbQtoDpjHrCD60tzyXlwCX8SrZhxm9JO9MNhYeuKbOPIi7gotObBmX7a0qbtyvc=@vger.kernel.org, AJvYcCVdAK6Q7KYjQy9b2qw6HAFQOfv/lb7fk3CSsnftfhhNGn1KTYqicbbk+KUKc8DQXFg1ef/yUbu4H85OC/4kCrf8LQ==@vger.kernel.org, AJvYcCWj79hA4cxkZIRy8OQv92gN/vrtipYascz63x5WHO6oLMdvWRFMsJ+POg3Xotv8XWcps8y4Tok3U0keNpg=@vger.kernel.org, AJvYcCXWMIzzShLJJ38t/LAzL7Ww7kdkRyPNb0PR3pWMlK7uF0dDYlOhv+pZHuw9d4n4bW3z3GjdOW2DMGeG@vger.kernel.org
X-Received: by 2002:a67:f948:0:b0:4c1:b01f:8c7 with SMTP id
 ada2fe7eead31-4c2f66d367bmr1172152137.8.1741249365980; Thu, 06 Mar 2025
 00:22:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304171154.njoygsvfd567pb66@thinkpad> <20250305173826.GA303920@bhelgaas>
 <20250305182833.cgrwbrcwzjscxmku@thinkpad> <20250305190955.GK847772@rocinante>
In-Reply-To: <20250305190955.GK847772@rocinante>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Mar 2025 09:22:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVRSjkss3gPnocXpfPQ=mEo4AevpaU=fdGvm=kb3RTmcQ@mail.gmail.com>
X-Gm-Features: AQ5f1JrhQM2yc1IEyYpQi2IEGHYpY6yhiE8-bZMdZwiJJ0QwJlNhyHxfSkZ8qMU
Message-ID: <CAMuHMdVRSjkss3gPnocXpfPQ=mEo4AevpaU=fdGvm=kb3RTmcQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] Add debugfs based silicon debug support in DWC
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	Fan Ni <nifan.cxl@gmail.com>, Shradha Todi <shradha.t@samsung.com>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	jingoohan1@gmail.com, Jonathan.Cameron@huawei.com, a.manzanares@samsung.com, 
	pankaj.dubey@samsung.com, cassel@kernel.org, 18255117159@163.com, 
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com, will@kernel.org, 
	mark.rutland@arm.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Wed, 5 Mar 2025 at 20:10, Krzysztof Wilczy=C5=84ski <kw@linux.com> wrote=
:
> [...]
> > > > Even though debugfs_init() failure is not supposed to fail the prob=
e(),
> > > > dwc_pcie_rasdes_debugfs_init() has a devm_kzalloc() and propagating=
 that
> > > > failure would be canolically correct IMO.
> > >
> > > I'm not sure about this.  What's the requirement to propagate
> > > devm_kzalloc() failures?  I think devres will free any allocs that
> > > were successful regardless.
> > >
> > > IIUC, we resolved the Gray Hawk Single issue by changing
> > > dwc_pcie_rasdes_debugfs_init() to return success without doing
> > > anything when there's no RAS DES Capability.
> > >
> > > But dwc_pcie_debugfs_init() can still return failure, and that still
> > > causes dw_pcie_ep_init_registers() to fail, which breaks the "don't
> > > propagate debugfs issues upstream" rule:
> > >
> > >   int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
> > >   {
> > >           ...
> > >           ret =3D dwc_pcie_debugfs_init(pci);
> > >           if (ret)
> > >                   goto err_remove_edma;
> > >
> > >           return 0;
> > >
> > >   err_remove_edma:
> > >           dw_pcie_edma_remove(pci);
> > >
> > >           return ret;
> > >   }
> > >
> > > We can say that kzalloc() failure should "never" happen, and therefor=
e
> > > it's OK to fail the driver probe if it happens, but that doesn't seem
> > > like a strong argument for breaking the "don't propagate debugfs
> > > issues" rule.  And someday there may be other kinds of failures from
> > > dwc_pcie_debugfs_init().

pcie-designware-debugfs.c only does small allocations.  If any of
these fail, you have much bigger problems, and the system will die soon,
irrespective of propagating the -ENOMEM or not...

Another issue is that the caller does not handle failures correctly,
given (A) the irqdomain WARNING I got, and (B) the half-registered
PCI bus, oopsing on "lspci"...

> > Fine with me. I was not too sure about propagating failure either.
>
> What if we do this?
>
> diff --git i/drivers/pci/controller/dwc/pcie-designware-debugfs.c w/drive=
rs/pci/controller/dwc/pcie-designware-debugfs.c
> index 586a9d107434..fddf71f014c4 100644
> --- i/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> +++ w/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> @@ -162,7 +162,7 @@ void dwc_pcie_debugfs_deinit(struct dw_pcie *pci)
>         debugfs_remove_recursive(pci->debugfs->debug_dir);
>  }
>
> -int dwc_pcie_debugfs_init(struct dw_pcie *pci)
> +void dwc_pcie_debugfs_init(struct dw_pcie *pci)
>  {
>         char dirname[DWC_DEBUGFS_BUF_MAX];
>         struct device *dev =3D pci->dev;
> @@ -174,17 +174,15 @@ int dwc_pcie_debugfs_init(struct dw_pcie *pci)
>         snprintf(dirname, DWC_DEBUGFS_BUF_MAX, "dwc_pcie_%s", dev_name(de=
v));
>         dir =3D debugfs_create_dir(dirname, NULL);
>         debugfs =3D devm_kzalloc(dev, sizeof(*debugfs), GFP_KERNEL);
> -       if (!debugfs)
> -               return -ENOMEM;
> +       if (!debugfs) {
> +               dev_err(dev, "failed to allocate memory for debugfs\n");

There is no need to print an error message when a memory allocation
fails, as the memory allocation core already takes care of that.
So please drop the dev_err() call.

> +               return;
> +       }
>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

