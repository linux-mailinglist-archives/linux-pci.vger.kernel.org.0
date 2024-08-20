Return-Path: <linux-pci+bounces-11859-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9637C957F91
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 09:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1998E283ED6
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 07:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8507F17B4ED;
	Tue, 20 Aug 2024 07:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YTMBITkc"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFED412FB34
	for <linux-pci@vger.kernel.org>; Tue, 20 Aug 2024 07:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724139001; cv=none; b=ininlxpP9AZpT0CL6/XSrH6zmrni0mfuvXpIgsPvD0GuUn16I3QA1lmqAALxMgSsyv06XZPcOkGJvELu+PeVll2M4q43UKLufyPhxusxMSXbKPAHm6ANR9VO8WKh8xfByxKu82ThgISUazehLm9k8VPyRDDSr8z9RgKMv55aWuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724139001; c=relaxed/simple;
	bh=XRWQQfF9fp4z+5+KZcBYEDuYz5gb8cHaJLDO6UaJEoo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jSupI6YFrqdU55/PyW3Z2nPhMa2t4gEZqkGRlY/Eke4h+u5MxtTJl/bAavOvgwEBKiXdwuVxGL1+an5oSX08/imCH26NWiex6WQAADj9TC3RZbhhYptyykPxi+8CwV5NqRX2ZbriX0o+IqVEN+U26luSLeoXEH6VdIitl9E54G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YTMBITkc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724138998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1KpD0+PO3KEd8vqUb0exw949el+ZQlXzH10gWUK9kY=;
	b=YTMBITkc2hhZBql5z1ET4kq3sjVPnmgjZKJfAgsi8HhKf5/f9Uqdi3RAT73JDCDBb3UdK1
	LWnpds7tCwp0eVf/+7S0uQ8yMJgDpwS3PRIf5/qJGk7vg5psG5I2JWaQ+Kp4xA/dylLco9
	Z6VwZdxhCyE7MGH7jt4bHrkCneo/fkg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-985JkhzHPaCzUoBtdSTzjw-1; Tue, 20 Aug 2024 03:29:57 -0400
X-MC-Unique: 985JkhzHPaCzUoBtdSTzjw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2efb2c3f288so9842991fa.1
        for <linux-pci@vger.kernel.org>; Tue, 20 Aug 2024 00:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724138996; x=1724743796;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v1KpD0+PO3KEd8vqUb0exw949el+ZQlXzH10gWUK9kY=;
        b=b94WML4vrMNNUbS6c4HRqRs7arimaflm9TRK/XQWxBypSK87zQhczuSqLFyqd0Y6WP
         02CKERyoXLlgVh3JnxM2Xp91O2n0qO4LRVC9P4qT9XxKS5ChagvBb0HA23tvfCpeGb/s
         M1EGeo6xijyGv90KPvlrh4Mx4yir4fiu3gbt/7G5k++l4JE73aKc9+U2Kj0j/0WKz53R
         Mduw2O1bhJhOcMLa14MDWU5dSWUuLctY0m4afpme+IwZllIZ90kr1emU5oiKgD9Lo+SI
         bNlbI1TQ2VqbSO52ez+jnlH19YLVhh2eO+jqvs2Ji1xmk22gtKTzeYBBQReAXrV100BC
         lymQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMbnJow5eqG1mdXCPpYBPJ3x54BSJAnPf1hEE6mrdlKJmJ8OFFdT6MxhlDKK3lUiCKEt5p1lvt6BY=@vger.kernel.org
X-Gm-Message-State: AOJu0YysC5legK0FnbVhPoxW3ZdopoEQfuRvriWT+q9MxPSRiG9YHpIa
	KL6v7rnqgWI2R9v6ApPuUNkdK/FPFSZ5XUfxPPmiiSNl6zv0iJTUcDw6lXQA+Wve2z5ixCeA+5H
	z0thUtdpHvjSiB78nIP6BYHTiqhtGpba1FXc1tqSQqFJyAMVa6ICCpdMgLA==
X-Received: by 2002:a05:6512:b26:b0:52e:9b87:2340 with SMTP id 2adb3069b0e04-5331c6e45bdmr4732129e87.6.1724138995623;
        Tue, 20 Aug 2024 00:29:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkOoAmJQBqRwOrXRXs1aVQSYuEizZw5AiMeBmrPImJpZCWeJexcEAw/Dy4dkV+vYq52Tea8Q==
X-Received: by 2002:a05:6512:b26:b0:52e:9b87:2340 with SMTP id 2adb3069b0e04-5331c6e45bdmr4732103e87.6.1724138995010;
        Tue, 20 Aug 2024 00:29:55 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dcc:1f00:bec1:681e:45eb:77e2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83839471b4sm725856366b.164.2024.08.20.00.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 00:29:54 -0700 (PDT)
Message-ID: <e406ba06180571564b47872f090623b19e4ad87e.camel@redhat.com>
Subject: Re: [PATCH 4/9] block: mtip32xx: Replace deprecated PCI functions
From: Philipp Stanner <pstanner@redhat.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: onathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, Wu Hao
 <hao.wu@intel.com>, Tom Rix <trix@redhat.com>, Moritz Fischer
 <mdf@kernel.org>,  Xu Yilun <yilun.xu@intel.com>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>,  Eugenio =?ISO-8859-1?Q?P=E9rez?=
 <eperezma@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Mark
 Brown <broonie@kernel.org>, David Lechner <dlechner@baylibre.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>,  Hannes Reinecke <hare@suse.de>,
 Damien Le Moal <dlemoal@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-fpga@vger.kernel.org, 
 linux-gpio@vger.kernel.org, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,  linux-pci@vger.kernel.org,
 virtualization@lists.linux.dev
Date: Tue, 20 Aug 2024 09:29:52 +0200
In-Reply-To: <ZsOJONEA2x93bSpO@smile.fi.intel.com>
References: <20240819165148.58201-2-pstanner@redhat.com>
	 <20240819165148.58201-6-pstanner@redhat.com>
	 <ZsOJONEA2x93bSpO@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-08-19 at 21:04 +0300, Andy Shevchenko wrote:
> On Mon, Aug 19, 2024 at 06:51:44PM +0200, Philipp Stanner wrote:
> > pcim_iomap_regions() and pcim_iomap_table() have been deprecated by
> > the
> > PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> > pcim_iomap_table(), pcim_iomap_regions_request_all()").
> >=20
> > In mtip32xx, these functions can easily be replaced by their
> > respective
> > successors, pcim_request_region() and pcim_iomap(). Moreover, the
> > driver's call to pcim_iounmap_regions() is not necessary, because
> > it's
> > invoked in the remove() function. Cleanup can, hence, be performed
> > by
> > PCI devres automatically.
> >=20
> > Replace pcim_iomap_regions() and pcim_iomap_table().
> >=20
> > Remove the call to pcim_iounmap_regions().
>=20
> ...
>=20
> int mtip_pci_probe()
>=20
> > =C2=A0setmask_err:
> > -	pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);
> > +	pcim_release_region(pdev, MTIP_ABAR);
>=20
> But why?

EMOREINFOREQUIRED
Why I replace it or why I don't remove it completely?

>=20
> ...
>=20
> mtip_pci_remove()
>=20
> > =C2=A0	pci_disable_msi(pdev);
> > =C2=A0
> > -	pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);
>=20
> This is okay.

Removing it is okay, you mean.

>=20
> ...
>=20
> > =C2=A0	pci_set_drvdata(pdev, NULL);
>=20
> Side note: This is done by driver core for the last 10+ years=E2=80=A6

Ah you know Andy, kernel programmers be like: "When you're hunting you
better make sure the wild sow is really dead before you load it in your
trunk" ;p

P.

>=20


