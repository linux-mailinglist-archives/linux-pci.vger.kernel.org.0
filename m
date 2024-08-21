Return-Path: <linux-pci+bounces-11931-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC5C959725
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 11:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B22C328356A
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 09:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903EC1ACDF5;
	Wed, 21 Aug 2024 08:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEm6wTWm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E706A199FAB;
	Wed, 21 Aug 2024 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228582; cv=none; b=EV1qKizG/Ab9oYNI62uVyBBBOQAY3nqyklnV1tp2ayYKrMtkcginjY+lQwXRZ6V/h06ih8F9/N6hOcpxZ40PlVjT4mjxIniJztOS5hkjgTnOcgtQZakzwpw0dW9tG4iqK3+4K/XWCnSwSrrpQ//zTc8WyCtfnYoDSiR/Bhipztg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228582; c=relaxed/simple;
	bh=cEHplF4jMNpHGE9hNUkCPOYDmxJtkGT5UCfOE9j7f2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eS31hjdilCSp6vgjBn9FamDIlpOqCw/uRwZWdevWpqHhpU9VbbpZYypKFylElNi+CYFaQN6hlmdlwcKRGjA0fEbWaROHtJnkulTQQHx2125ODxiZ7Bk7PiMqfhPSnTW4o94mC5ykmWC2sezCcyft/gAwEZnIY7UAAQ8dHPNpoes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEm6wTWm; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8384008482so675260566b.2;
        Wed, 21 Aug 2024 01:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724228579; x=1724833379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQJjqDz75DIjtI14ka6f6g6hkoeor8vPcSYTvVZiR7E=;
        b=eEm6wTWmpdEFVa1+7sOEYUH7pUOj9auodfV4fKOTt4ZG4oYl88E7k8p8Vpcky+Xc95
         91zbQg5PtjpvJKt/GRLedCXXYzbdu1fm9LPmbWAGcvMpVYOr1tqtaO+KK/JJ4qIYuXCC
         3m1owZf4IXS3L8QzxYryffgdipg9pFLTT+G+eieuv2QjQ8tJvEvNlS/hT1JGi39LhJNW
         hyrvF7Gb46MEUaGdA9aLl9rfz+sCtSxivotA490HqaxnuC1enleDyf/llrayxppPGDzY
         +tnRz/RnAM6zLgPrwQdUWjNQ4FdAiji44dnfuKqZTJhNYXNmH6WEdwls41tkM0bD2Fr0
         YuoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724228579; x=1724833379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQJjqDz75DIjtI14ka6f6g6hkoeor8vPcSYTvVZiR7E=;
        b=bDdS59gfH8Wfo4B/ekL4rjCbi9c4vnxgfPKDskyjIK2Ci9flpqdol/OHvltVhNWvx3
         WUoyghbSHMCn6x2sneiKDNdx41LzTXRTZjAn6pa+q/hzRAIFTTh6QthHlZEHk6jW+yxG
         fklP5d5eD9WA2EkaVyVC60J4KJYr+va7X5okHVfEEo0k15HgGV3Q6wL37UuTodLLp9fJ
         UPBDhoxaJCHPkt/8W6fRR7FCPBK3iLmGV21sLiG45vMW+LcU6snB4gy46erivMVABefL
         xtrVWoK5pAlcKNZ05hg9nFZca2D9DKyka7jHofNetUOlW+XPBVkh1HjcdBmU7euhP/bA
         v1jg==
X-Forwarded-Encrypted: i=1; AJvYcCUSC0VMPAXFtu8RQWcWA5jIkJ/fKocYm4vtpgGqhMq6Ce5eem2Ac2apfZ68F+8Yn4I9ZHLa0BB2@vger.kernel.org, AJvYcCVlgqbue+NxjWOnb7qU2TS9uAPdVeb9Nw7qHbHQ1w9nid074AwhTHqpCOTmhuZ0lYmi9Jd9u8pWHdoQHqxG@vger.kernel.org, AJvYcCWPwPeigNGay4JTcCWJ5IEXAdoXJjYTQDt39CwIFfLu0VB0qhPqpXiXNsR2UPziltcvd/4qqDKxfCQuBA==@vger.kernel.org, AJvYcCWdLEJo3UUWoeHJYByDhmXRj74eqBsKJec9bdJiC55f8pQgMYIaOAwM15XNBMNLquuSZzMicbKhF5rLww==@vger.kernel.org, AJvYcCX+1+tOMSEH2twv5kJ10Lh6TAnIu2SpUwTBk+odX1Gw7bgJjTinXwO02Y+YIEmSpsZuibefrQNd1CXOEA==@vger.kernel.org, AJvYcCXQMuddb6zHcmUQtpTOPPJu/po0UgoErfNr3iXwmA6QvARx38CF+/kKZyItP6I0urm1uoUEzkbVZyvw@vger.kernel.org, AJvYcCXaOvO+fniBkwVcdRliFDhPOSLdIbnH2gJ4e0Y2GB1sEkvb5QiZGW2Mawlt9g8PL09wFgE51cNUg547@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5cv9MS7v4SBzlZTACddW/e5emWp0XDmNO9xkNE0YB1+4hrd41
	N2Q2w5x8UktOmIi8dgnCbGCythcX1wAxojxDJ89mtGhUOSPnLRzLIUms94/9+TabKlJT9ei12FC
	sJ06O6wrySmy3gVCp0pPJc8GlfSU=
X-Google-Smtp-Source: AGHT+IFIFdj7MeWYmPsiZH+WByhUHnKbrwVECRxS82N0iKD7flWPDhWf1z7riSsL+51FW+V5a66YfnwTfRw3oCdVfqc=
X-Received: by 2002:a17:907:f784:b0:a7a:9d1e:3b25 with SMTP id
 a640c23a62f3a-a866f36312emr101512566b.30.1724228578962; Wed, 21 Aug 2024
 01:22:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821071842.8591-2-pstanner@redhat.com> <20240821071842.8591-4-pstanner@redhat.com>
In-Reply-To: <20240821071842.8591-4-pstanner@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 21 Aug 2024 11:22:22 +0300
Message-ID: <CAHp75Vey-zwZG3FrU2fr0ZiQXBO7SV4UfoeutVwVPfk6vKvuTw@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] fpga/dfl-pci.c: Replace deprecated PCI functions
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
> Port dfl-pci.c to the successor, pcim_iomap_region().
>
> Consistently, replace pcim_iounmap_regions() with pcim_iounmap_region().

>  static void __iomem *cci_pci_ioremap_bar0(struct pci_dev *pcidev)
>  {
> -       if (pcim_iomap_regions(pcidev, BIT(0), DRV_NAME))
> +       void __iomem *bar0;
> +
> +       bar0 =3D pcim_iomap_region(pcidev, 0, DRV_NAME);
> +       if (IS_ERR(bar0))
>                 return NULL;
>
> -       return pcim_iomap_table(pcidev)[0];
> +       return bar0;
>  }

Now this becomes an unneeded wrapper on pcim_ioremap_region(). Can we
kill this helper completely?

--=20
With Best Regards,
Andy Shevchenko

