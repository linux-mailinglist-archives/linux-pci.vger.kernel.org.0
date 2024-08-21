Return-Path: <linux-pci+bounces-11930-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2627959712
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 11:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E01DEB210A0
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 09:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079211C32E2;
	Wed, 21 Aug 2024 08:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cC9/Wzwv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF3F1CBEAB;
	Wed, 21 Aug 2024 08:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228488; cv=none; b=GHXWSuG5/x69vpNxY+InmOGjaTynR/35sGAP2UOdc79MSo5U3WuBFIK74KyPRWAf9+ZHqnbalt4jYw9FoyZ9B0sI5avFrH6M2gcOg7p4v3/pybRi1s7YWHUFSdA2bhVrtH5tYAHwK9II+h0J8Rgwy37d4Xb9S/wAvYYSftogQDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228488; c=relaxed/simple;
	bh=waui0D5SCOdKeUgU0MnJN8TxtZ1Y7sPbMQkuwpwtiUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+yBgqw/ttYxD1draRgtldFvTiX9Vri2RYRpzWJpk9wj46Kose/UdxpilCgAkIo9kSIk+O+vUESZvbhEjwKSVamGTGB3ClXLGUHZVJxZpq8G9BSYTVa4lqAuyFk8xBU1riiH5h+qMV7y9ffUJpvPvooId3e2+2pWlN97Goq+mAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cC9/Wzwv; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5333b2fbedaso3896350e87.0;
        Wed, 21 Aug 2024 01:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724228485; x=1724833285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1mM7VOy3wYhnD2rAhzlxVmwa5gojTJ+lhe9geIJYUs=;
        b=cC9/WzwvvsVecGd/XnGD9ml/iuYVwcLFFO4UHDN5Jc3EeirEs9qzAQvgDzjZvaIHEJ
         Arl+sTS/PCVA9eclUMHA2gSz6pi3ruIBJUV6Q5xXWq+4MkgSDeVyto0emEiyFTT8avmj
         qeGvnZtem1PBPOag/gp7Yrh3Qxq6q7BtEeLiltcbUjRtdmC1dSyvvXGDo5FCGy7U9C44
         7tmIiodagfKw7wuZcM4N5dJgjj4YCWyoRQtngqZfwhAi+D4/LSCnzKg29HCEAe5+46J4
         cQRPOybi+bnkwWgVDxD7tQcqAh6gYn5qXS1KeCHKkbRI/cKs5s+DEwF0c6hFCFn1oATv
         6b8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724228485; x=1724833285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A1mM7VOy3wYhnD2rAhzlxVmwa5gojTJ+lhe9geIJYUs=;
        b=tcDOgbAB3R8/fP+c2BCg0y5VZTK5DslmFBPvTqc94q2iHwo7NVJ36pOZXwNfywfarZ
         dcYzRfPUChIzU5iJGSW7sFTZNPtmknL1CCdd6qsNQYw6BArZo3BL+yDrhSSYnuE6nIgV
         omE6x+EmQwGZNUBlJeHs6z0raN6F+Z89zuFmE7Up7thHtiEai7tOeyX5Yc1ppqotDbbw
         ydfwPxmzD/Aw1Yhn5oKqEm/zdQrtTmIlHlbkwFfX5Rke8X7/SGDMet1CFbLreYHH4Dqe
         uoPjzQQBRRUxre/L+WL3wWj9w5+v784kDy8aZg56e31mbdKwjcWZbKg6/xxgTW6u6uOs
         o6vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCJHW32ajrbBW++yTQpins7k687VZXkuxT6NvUfmMdr2tXAYjYmn9heAK51yDxOkVXMuByDe5Tde4N@vger.kernel.org, AJvYcCUluhiO+Vt0IFRoCfVTdHDubUZTVtVPDr1bdh6NZajTSsX4psa1GqrDlTi0faq2rpA4oG6xa4xA2EtI@vger.kernel.org, AJvYcCV65GRYkjF4ppPTg3oj/gAGhD1S+bUX3bxqaVR3N6AIdDO6irH4ENvJDSpYwQ2xOFSXv+yxNXj30TdXaQ==@vger.kernel.org, AJvYcCV6x8jziQMSzV/cdUGmwueCnu4c7yyvAQaYL9gNXdKz3iKRMDNvQDimS92f6rMmygxUlmQqR6w5lArzBg==@vger.kernel.org, AJvYcCVzD9LA6Ayy8cvROsGCxAv7a2pCPnLUi4iGPrjmRQHgezNmtTiaEHZ13r88N8ItPMbg0ZBBbUp7FTttp5bm@vger.kernel.org, AJvYcCWKDkAs3PXM4XBVNdmD++U7fzxtUu+yD6XP5gffTCamyTlyzYI4TQsLgIWzZ4o8dX2a1E4LYMIy6Z/Xxg==@vger.kernel.org, AJvYcCWLAcxSxwhCZiV9UUuRHVoK1TQSMsuqF5NbOI1zWm/JYSY8f5JSnsiulTiY8aplJkieoi/taW0b@vger.kernel.org
X-Gm-Message-State: AOJu0YzOYhwyrYjsOWmwOqEthmy2DTA5v4VLLG3Io/1RPRaoZwqTxRZ7
	M/dMcEqS9P6gVgl7MqrHhggCuM8Alztw+8Syn5pozy8HgOUCu1hSqc3RHSftz0z1Rk1tDW4YsOg
	HwLA9ZuHEHUuqp+LH453ANEnBKdw=
X-Google-Smtp-Source: AGHT+IE5lCR7HVY/g4hFvBV/RGv3qIBpIhbmfnMcQQ7lowungeDx3xymow/Bwb+dY3WdhUTB7lf53PrUHtbP7MuHfPo=
X-Received: by 2002:a05:6512:3512:b0:533:482f:afbe with SMTP id
 2adb3069b0e04-533485af9eamr639466e87.24.1724228484968; Wed, 21 Aug 2024
 01:21:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821071842.8591-2-pstanner@redhat.com> <20240821071842.8591-5-pstanner@redhat.com>
In-Reply-To: <20240821071842.8591-5-pstanner@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 21 Aug 2024 11:20:48 +0300
Message-ID: <CAHp75Ve02c61V7pyAhbJr15jt5nb7Sjn58HzhoY6VH0C7YKVDA@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] block: mtip32xx: Replace deprecated PCI functions
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
> pcim_iomap_regions() and pcim_iomap_table() have been deprecated by the
> PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()").
>
> In mtip32xx, these functions can easily be replaced by their respective
> successors, pcim_request_region() and pcim_iomap(). Moreover, the
> driver's calls to pcim_iounmap_regions() in probe()'s error path and in
> remove() are not necessary. Cleanup can be performed by PCI devres
> automatically.
>
> Replace pcim_iomap_regions() and pcim_iomap_table().
>
> Remove the calls to pcim_iounmap_regions().

...

>  setmask_err:
> -       pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);
> -
>  iomap_err:

Now one of the labels is redundant.

>         kfree(dd);
>         pci_set_drvdata(pdev, NULL);

--=20
With Best Regards,
Andy Shevchenko

