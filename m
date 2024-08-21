Return-Path: <linux-pci+bounces-11929-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A74739596E7
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 10:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 101D21F2551E
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 08:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50AE1B1D66;
	Wed, 21 Aug 2024 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLBy9yPb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C4D199FA3;
	Wed, 21 Aug 2024 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228409; cv=none; b=BJT/jD4k75GpUn9EuYwuZREJJBFkAZaslZnoQAbGupxTjJBfu4Hz2a0WyYsXInsNId27awssQdKbBh8gtMrOJd+6kFKFjUn4CncgCw8K7MAIAKxRPzYe3Kahh8U3SrGgZAvhJArMmEuFjO0sxn5nD1FWWgtQPn6U2NVf9ihg9QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228409; c=relaxed/simple;
	bh=LMgYW2l8J8PfBaP56tNWVU26fU07THjrd9Mbd01ueEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dwfh82gt4iqSfD/KGtTZ1kPlthu74hMCja5Z0aZEUuTE8ZJflnQFwcSt0yRsp+/FCFbBg/9yV+bJC0opXKqZysVsCDasEBsfrtCyxQVYXr7DKaFmVRuahvkopMpncRNMchJpAApG8DOMmDX4uwRz17ZEWvfhN/qdbW6ZZpiW8/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLBy9yPb; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f3bfcc2727so43517241fa.0;
        Wed, 21 Aug 2024 01:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724228406; x=1724833206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdhYZISuTETd5XZ8LEV8qzxmVjQjEonrE8b5iyMQ2ws=;
        b=kLBy9yPbN4zBARKMAOub9r/1YACP5fWkzY43Z9jbDb4AJTInQcEewVZaxq5F0Pb/GK
         XkWJwwjAxaH/r3b9hJ6GkdqtcveblrwxlMHYyeOKBzAoV5kNPhgeQ3QjLNPt4chE/t8u
         JhDp7Ymk9yYRVNm809MPiaHnjBkRdl0CgYLlH14X/lilrHVk2R7w13D8OPkigO5Xoy/Q
         35UOaBCW0grFpsJOc0Pw+WND2sWY5uXpF63IfaqQvXSmduBWB7hMTgN4PJ5jNNwRlSsw
         yijQUEQJqqtIKmstooeJIJmcxUV+MBg/hJrVk+vg+LxBdw8yGx3a0ybptMao/3ESmHfu
         meww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724228406; x=1724833206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WdhYZISuTETd5XZ8LEV8qzxmVjQjEonrE8b5iyMQ2ws=;
        b=qpbCWPe+ahdXkfzZAsDkpgAGf+SHBvUPQpW1Q7wpYBXAkLtWkb/BUbuaZWuMDdBfYC
         UCXizXHVNPCRYN4S9Unk7ydG6BzYzFQwZ6nh+nmZk3grKzYdQO18qZruDONCSMzsoWy2
         o9C6fAKAQ5C6xG/3Rluyi2vez5+/J3C6PPA3Mto154CIo3ctXPyUBX64Rh9Or5aM9lCT
         PniPMZrDTOZq1L99TVcatRDevjXcElOcrIf8P5YSZmErCJeJUhujnZKa6Al5SYxgSMpp
         1LRwMiyFHkiV0DmVibtcFb6By+K6Mmoe26IqORabmX/JgVNxyV4IQlVWI6Ywru24D9/5
         vTZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2NsDhUk8gXdUpOSchaSutZ2ucqYRi0NNTNMY3Z9fAY7QLquc3k9pthwyeRF8PD+8uMgXLgEIfO9wO@vger.kernel.org, AJvYcCUARzWYIeHM6oyai33hyqxgxupvcHqczCBXeZhoIO+ef2Tdx7dhiOES4sR40zOS80Hk/UDbz5LS6gpe@vger.kernel.org, AJvYcCVC9Kx0PXaAYyzf47q/nIFZAldcIOiX+xgF6l74w9gaCRQpdtJiRGsUqGO/snKUm/HWVrQ2DFVm@vger.kernel.org, AJvYcCWCI85u2twV2WAIxiLruo3CZkiRbfke56ugXK3Af68a7IFDqTKM5XUCgLCmZVK2SsR8CxzK5vg1fBfbtg==@vger.kernel.org, AJvYcCWc1bx5nvyYn11pCaMVNfpLoynxjBTJURP8iH3Uvk3Cv5ICnPyO5iBpL++W4NL0p61tZxoOJ4h1+lfRDg==@vger.kernel.org, AJvYcCWojgsaXjfmqbGsHtOshH4niLEdSVMPHFvUQjGRl/rNHW+pub1f3DOyVymSj1C/jt8SSX8s3t3gDDSG1KWn@vger.kernel.org, AJvYcCXmyOU1Faeg3GVVHL2vmUE0botNGOWzDXjucBkqPkea0lb/XfpTU8uKoUL6UoEX7OpcqO0INz0HY7b6mQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YylEWLS6m/llhzqRAwDMvcxdVEPTkMUNu4OqHwFB83cVzrozCL7
	TiIdpPTdYZgLsQjOC/8RsVCPywV0PzGSkBBx+kvzw1TCu0TSmWIGENBmwxqdMyJXJ9uTfSm1dVA
	NuTh9yuzbTztaHV/o/mJFKfx3qxo=
X-Google-Smtp-Source: AGHT+IGy365Pc9TKJF5GAK0armKU9Hpgj1dovYSvRFuHJ1yV+fMbVBAOtQzki539dYAOujtFA/EPC2D0nPczB6xkNv0=
X-Received: by 2002:a2e:854f:0:b0:2f1:67de:b536 with SMTP id
 38308e7fff4ca-2f3f8890618mr10493191fa.24.1724228406003; Wed, 21 Aug 2024
 01:20:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821071842.8591-2-pstanner@redhat.com> <20240821071842.8591-10-pstanner@redhat.com>
In-Reply-To: <20240821071842.8591-10-pstanner@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 21 Aug 2024 11:19:30 +0300
Message-ID: <CAHp75Ve13TpA+OdUbiehZORjbNEi9qjJK3bg=C5CscoC=G=f4Q@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] vdap: solidrun: Replace deprecated PCI functions
To: Philipp Stanner <pstanner@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>, 
	Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Alvaro Karsz <alvaro.karsz@solid-run.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Mark Brown <broonie@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fpga@vger.kernel.org, 
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 10:19=E2=80=AFAM Philipp Stanner <pstanner@redhat.c=
om> wrote:
>
> solidrun utilizes pcim_iomap_regions(), which has been deprecated by the
> PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()"), among other
> things because it forces usage of quite a complicated bitmask mechanism.
> The bitmask handling code can entirely be removed by replacing
> pcim_iomap_regions() and pcim_iomap_table().
>
> Replace pcim_iomap_regions() and pcim_iomap_table() with
> pci_iomap_region().

...

>  static int snet_open_vf_bar(struct pci_dev *pdev, struct snet *snet)
>  {
>         char name[50];
> -       int ret;
>
>         snprintf(name, sizeof(name), "snet[%s]-bar", pci_name(pdev));

Shouldn't this be also devm_kasprintf()?

>         /* Request and map BAR */
> -       ret =3D pcim_iomap_regions(pdev, BIT(snet->psnet->cfg.vf_bar), na=
me);
> -       if (ret) {
> +       snet->bar =3D pcim_iomap_region(pdev, snet->psnet->cfg.vf_bar, na=
me);
> +       if (IS_ERR(snet->bar)) {
>                 SNET_ERR(pdev, "Failed to request and map PCI BAR for a V=
F\n");
> -               return ret;
> +               return PTR_ERR(snet->bar);
>         }
>
> -       snet->bar =3D pcim_iomap_table(pdev)[snet->psnet->cfg.vf_bar];
> -
>         return 0;
>  }

--=20
With Best Regards,
Andy Shevchenko

