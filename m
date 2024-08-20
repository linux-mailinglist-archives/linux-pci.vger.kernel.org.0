Return-Path: <linux-pci+bounces-11858-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74414957F4A
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 09:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE9BEB21896
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 07:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A424618E36D;
	Tue, 20 Aug 2024 07:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2q70F6C"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAE1188CBB
	for <linux-pci@vger.kernel.org>; Tue, 20 Aug 2024 07:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724138529; cv=none; b=I9QCf60kXfN8zxtD7HGmDBA0jl45ik9dpTtemFdA9+xywof+B/kPfvs70JWqejuO2rdNfbqToE2B9xGoT/wW71nt5UPcv7n3vEFQiwjiKoGYQIrOlPKEcAZFH8+01Gme6Yj0xi7s5te0JfinB/m+k7/KAXy20NcELxZlauI7KWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724138529; c=relaxed/simple;
	bh=CwAJcF6bJ+g48Ud2pzdceQkOvdF0s36dJmUP+WwsYDg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gtHUNCE8OpZxHqWXv/QgeJnW2eiMogk9i5gdZAzWTyunUrBjHEMkiIW1r71arlgiZgs31l58+vJII+UXnx5Z4wTrRp2JcCScAUJJxr5jatSjZii3u3/F60gYrg1V5nSpeleCk9pIZ/nCNFrGTpVDApbtbhho39jcVgTT37EAL9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F2q70F6C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724138527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ASIEWrzHXogS2+yni6jFmR1o/WYm2ANcxSxU4DhoyQc=;
	b=F2q70F6C6i4n2LFBptboSqzVFALyoTAy9csRmXhdSSn6o46l1t446t4axzzVjswKXLxAVn
	wddazw23VQL2/fyuBqWC8gtZSMHhkE/GrQGruUaGLqhpwQgdQznFQV9t8afYWSNfcT/VK8
	w/AUoDlvjS0G6DTMzHAPkzkjJwDELAQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-67UQld_VNe6n-CeyySWqAQ-1; Tue, 20 Aug 2024 03:22:04 -0400
X-MC-Unique: 67UQld_VNe6n-CeyySWqAQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42808f5d32aso9509635e9.2
        for <linux-pci@vger.kernel.org>; Tue, 20 Aug 2024 00:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724138523; x=1724743323;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ASIEWrzHXogS2+yni6jFmR1o/WYm2ANcxSxU4DhoyQc=;
        b=BP8M7bYmQs+Kw5iprYKAILjCm1JwD2DphqDW1GQCJT83USWI16wbVDOKERGke+5qeQ
         5kvrUiP7+Ue5lZaV6HBJbDrE+frcTVIhGfONvwu+xwL+VqDMuQaJ4IrjPWllJeNyfpIS
         4jM1HoFo0RofnAETRhCtXxvL+ahG92mqi5csQ/PAplSfyA+/NtceCGRJdnkj3WiN52TZ
         w9FogjbvtBHJvW/H4arLyMSzD/Z2YqAIicC/cChiwmx1M67pGRxb9Md3Q5lWllGfifo2
         D4LhPSluPntzOf3qTPNJoX01AATHhNkBXAGC4TD9bVO7FLBKwGPHzo7GxPNF1R+RKpB/
         NHjg==
X-Forwarded-Encrypted: i=1; AJvYcCWROSZLTA+162gNkk1FDEKPyOCkezKPZI9eLIcpaL/Qz6kl8IMjGFoKr6vHcUVUEbIPlWwDHW117lsFsoTtQoiOhb5WluW+y5l2
X-Gm-Message-State: AOJu0Yz3aaDTAA8vODMaFsIBFMYl2//ofzMGwrbQHaTLr7zsvRFJ04zU
	LHzxt5DQCFRkur5JH9bacLlmAFF6VrNWZx193V1YOB9lVWvPOhEu9PMfCP5LX0SAqAqsqjk7b3L
	Tpzq9foxjG2lftju/FX7P0G728OShzTYYwyoZp3bWytI8MiYLuXR6ov9yiQ==
X-Received: by 2002:a05:600c:1ca9:b0:425:65b1:abb4 with SMTP id 5b1f17b1804b1-429ed62f54cmr55368115e9.0.1724138522953;
        Tue, 20 Aug 2024 00:22:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtu6sXluOG26PWy70qwsbDcaM81TTK+UTUTvyjs1U84scjqTgJELEGk3SrTeSIfdGLnjJpqA==
X-Received: by 2002:a05:600c:1ca9:b0:425:65b1:abb4 with SMTP id 5b1f17b1804b1-429ed62f54cmr55367605e9.0.1724138522431;
        Tue, 20 Aug 2024 00:22:02 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dcc:1f00:bec1:681e:45eb:77e2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429eeadfafbsm130634445e9.47.2024.08.20.00.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 00:22:02 -0700 (PDT)
Message-ID: <267a021781f59d6efe798dbca63f29dd25359f2d.camel@redhat.com>
Subject: Re: [PATCH 4/9] block: mtip32xx: Replace deprecated PCI functions
From: Philipp Stanner <pstanner@redhat.com>
To: onathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, Wu Hao
 <hao.wu@intel.com>, Tom Rix <trix@redhat.com>, Moritz Fischer
 <mdf@kernel.org>,  Xu Yilun <yilun.xu@intel.com>, Andy Shevchenko
 <andy@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Alvaro
 Karsz <alvaro.karsz@solid-run.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Eugenio =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, Mark Brown <broonie@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <u.kleine-koenig@pengutronix.de>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  Hannes Reinecke <hare@suse.de>, Damien Le
 Moal <dlemoal@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>, "Martin K.
 Petersen" <martin.petersen@oracle.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-fpga@vger.kernel.org, 
 linux-gpio@vger.kernel.org, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,  linux-pci@vger.kernel.org,
 virtualization@lists.linux.dev
Date: Tue, 20 Aug 2024 09:22:00 +0200
In-Reply-To: <20240819165148.58201-6-pstanner@redhat.com>
References: <20240819165148.58201-2-pstanner@redhat.com>
	 <20240819165148.58201-6-pstanner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-08-19 at 18:51 +0200, Philipp Stanner wrote:
> pcim_iomap_regions() and pcim_iomap_table() have been deprecated by
> the
> PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()").
>=20
> In mtip32xx, these functions can easily be replaced by their
> respective
> successors, pcim_request_region() and pcim_iomap(). Moreover, the
> driver's call to pcim_iounmap_regions() is not necessary, because
> it's
> invoked in the remove() function. Cleanup can, hence, be performed by
> PCI devres automatically.
>=20
> Replace pcim_iomap_regions() and pcim_iomap_table().
>=20
> Remove the call to pcim_iounmap_regions().
>=20
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
> =C2=A0drivers/block/mtip32xx/mtip32xx.c | 11 ++++++-----
> =C2=A01 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/block/mtip32xx/mtip32xx.c
> b/drivers/block/mtip32xx/mtip32xx.c
> index c6ef0546ffc9..c7da6090954e 100644
> --- a/drivers/block/mtip32xx/mtip32xx.c
> +++ b/drivers/block/mtip32xx/mtip32xx.c
> @@ -2716,7 +2716,9 @@ static int mtip_hw_init(struct driver_data *dd)
> =C2=A0	int rv;
> =C2=A0	unsigned long timeout, timetaken;
> =C2=A0
> -	dd->mmio =3D pcim_iomap_table(dd->pdev)[MTIP_ABAR];
> +	dd->mmio =3D pcim_iomap(dd->pdev, MTIP_ABAR, 0);
> +	if (!dd->mmio)
> +		return -ENOMEM;
> =C2=A0
> =C2=A0	mtip_detect_product(dd);
> =C2=A0	if (dd->product_type =3D=3D MTIP_PRODUCT_UNKNOWN) {
> @@ -3726,9 +3728,9 @@ static int mtip_pci_probe(struct pci_dev *pdev,
> =C2=A0	}
> =C2=A0
> =C2=A0	/* Map BAR5 to memory. */
> -	rv =3D pcim_iomap_regions(pdev, 1 << MTIP_ABAR,
> MTIP_DRV_NAME);
> +	rv =3D pcim_request_region(pdev, 1, MTIP_DRV_NAME);

That's a bug here, btw.
Should be MTIP_ABAR instead of 1.

Will fix in v2.

P.

> =C2=A0	if (rv < 0) {
> -		dev_err(&pdev->dev, "Unable to map regions\n");
> +		dev_err(&pdev->dev, "Unable to request regions\n");
> =C2=A0		goto iomap_err;
> =C2=A0	}
> =C2=A0
> @@ -3849,7 +3851,7 @@ static int mtip_pci_probe(struct pci_dev *pdev,
> =C2=A0		drop_cpu(dd->work[2].cpu_binding);
> =C2=A0	}
> =C2=A0setmask_err:
> -	pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);
> +	pcim_release_region(pdev, MTIP_ABAR);
> =C2=A0
> =C2=A0iomap_err:
> =C2=A0	kfree(dd);
> @@ -3925,7 +3927,6 @@ static void mtip_pci_remove(struct pci_dev
> *pdev)
> =C2=A0
> =C2=A0	pci_disable_msi(pdev);
> =C2=A0
> -	pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);
> =C2=A0	pci_set_drvdata(pdev, NULL);
> =C2=A0
> =C2=A0	put_disk(dd->disk);


