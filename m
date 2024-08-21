Return-Path: <linux-pci+bounces-11947-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64A4959BC0
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 14:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0A081C20D92
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 12:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EF01898F5;
	Wed, 21 Aug 2024 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jCwK6FmL"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFEE16BE03
	for <linux-pci@vger.kernel.org>; Wed, 21 Aug 2024 12:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724243168; cv=none; b=qGqRou7WaVGLYwpeGSxPFLc0nsMmgCVp8l/MPKkYYL9yiSiNVc+DeTiiV5sPDdVWKesrAktfTDqNlCNpQbBfTik8Sk6m/BC9TfEFveRIbdDMSLxFGk1Aewmy8HYsEOzYcKTn8NqRanfJKQd2uGkCr6nO/3s//uGjBn3oiEwdu18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724243168; c=relaxed/simple;
	bh=uuRCWDxDb6ZlmmrDflEcqKb34QjG6BdOf9n0HKg89DY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NLKyf/hfTi4g02zPJWDtuR5vkXw2AEh1RV03aVHhffYnlvHoDvoN6fzrSSyfi00hpERtzD2xICDGjlwl/ZgrV/FYBCkBbMMfJ4dcDf68pQsmokYPL467fp7COR5+Usd39Y5sh3Y7OVpy7PwDpEy/nLgZK57eL6cYFGqar7WSCQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jCwK6FmL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724243165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F+8Zd9p9xEaFFxq9bSwT6CVTjqvDBBcELEezra/NBmQ=;
	b=jCwK6FmLFbchFIo6pYAoaDlK2NYeGNMLwRyRjGg9Bx4wUjfRaR88vmH6sRH2B/pTkxKPLc
	InCKTW5ZTfcy2mXpqgR2oX3QpxPVhcA6i+VQpC3bI84zPOL3/IoAn6infnrCMJaoFvDukn
	wpzrhu4BZg8xhJP2s1WjU0CH0XlM2C4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-f-efd_uhPziXIG2n7Qt1wg-1; Wed, 21 Aug 2024 08:26:04 -0400
X-MC-Unique: f-efd_uhPziXIG2n7Qt1wg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6bb84f0652eso68098426d6.0
        for <linux-pci@vger.kernel.org>; Wed, 21 Aug 2024 05:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724243164; x=1724847964;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F+8Zd9p9xEaFFxq9bSwT6CVTjqvDBBcELEezra/NBmQ=;
        b=hqqYaG0K37U0lTop80z70xRL/s0tkKPiI6TlpaNoCEgGwi3ogpuzDN0mm7jF2w64Ig
         3S+TaS4qN8q8xbly9lr5WbKPLapBtl4PHlIIlsb0dw+4FZrQ6eSR8E9FHKInTm+BqjVa
         d4v9EOe0QFeCo+MyX5de17sM0htEbkIWSRC0RaIh4s+3YJS+Ar9CXVrhTzk7VuVGFtmb
         7jUBqyeLHlQXYl7UDz3Ow65dAltPynYwUqLtAMHcpzFMoV/oGplqJHwRqYS37uuTWgXv
         r9CFgQtKvzXY87bpl87vcOXnzf1TstfrFUJGECLHqO+0/DM11Zshv7tLy3kKaimMXnaV
         TC7g==
X-Forwarded-Encrypted: i=1; AJvYcCUfIMvHuO+xRJDdekkQGK/TrVqBauGngMayXoIr4Dc2oGGQpN530SnnhVGOK2ml5vXD6y38+YPbM/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz90M8o/i5zTyEgV6w8YzwTCt2PbnL+wpIr8i67ViwQggF8VeJn
	j8SzM4q2lMeizRAHXWgsjzVo1ttviCrPoARrxgoCkloRJ6N561ny85LJRgjub7eEkAIMqrzKwDi
	8ddRDhDTuak6ebr3Yb936EhGm7tKDy6CvKYNHAYALQwfB8ABn/z+71L1Lsg==
X-Received: by 2002:a05:6214:4881:b0:6bf:a721:9945 with SMTP id 6a1803df08f44-6c1567fabf5mr30554926d6.24.1724243163964;
        Wed, 21 Aug 2024 05:26:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0sBOMGGLa2XcF/yRLMaOTYNrH07fkAWiC1e2c/uh8oASqBZoK+O1goCyf57ZnaX9oaF0YiA==
X-Received: by 2002:a05:6214:4881:b0:6bf:a721:9945 with SMTP id 6a1803df08f44-6c1567fabf5mr30554416d6.24.1724243163535;
        Wed, 21 Aug 2024 05:26:03 -0700 (PDT)
Received: from dhcp-64-164.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6ff0dcdasm60220946d6.140.2024.08.21.05.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 05:26:03 -0700 (PDT)
Message-ID: <cf9591d720c9b25dafd46b627ff8b6ed9f417745.camel@redhat.com>
Subject: Re: [PATCH v2 7/9] vdpa: solidrun: Fix potential UB bug with devres
From: Philipp Stanner <pstanner@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, Wu Hao
 <hao.wu@intel.com>, Tom Rix <trix@redhat.com>, Moritz Fischer
 <mdf@kernel.org>,  Xu Yilun <yilun.xu@intel.com>, Andy Shevchenko
 <andy@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Alvaro
 Karsz <alvaro.karsz@solid-run.com>, Jason Wang <jasowang@redhat.com>, Xuan
 Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?ISO-8859-1?Q?P=E9rez?=
 <eperezma@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Mark
 Brown <broonie@kernel.org>, David Lechner <dlechner@baylibre.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Damien Le
 Moal <dlemoal@kernel.org>,  Hannes Reinecke <hare@suse.de>, Keith Busch
 <kbusch@kernel.org>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
 netdev@vger.kernel.org,  linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,  linux-pci@vger.kernel.org,
 virtualization@lists.linux.dev,  stable@vger.kernel.org, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>
Date: Wed, 21 Aug 2024 14:25:57 +0200
In-Reply-To: <20240821081213-mutt-send-email-mst@kernel.org>
References: <20240821071842.8591-2-pstanner@redhat.com>
	 <20240821071842.8591-9-pstanner@redhat.com>
	 <20240821081213-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-21 at 08:12 -0400, Michael S. Tsirkin wrote:
> On Wed, Aug 21, 2024 at 09:18:40AM +0200, Philipp Stanner wrote:
> > In psnet_open_pf_bar() a string later passed to
> > pcim_iomap_regions() is
> > placed on the stack. Neither pcim_iomap_regions() nor the functions
> > it
> > calls copy that string.
> >=20
> > Should the string later ever be used, this, consequently, causes
> > undefined behavior since the stack frame will by then have
> > disappeared.
> >=20
> > Fix the bug by allocating the string on the heap through
> > devm_kasprintf().
> >=20
> > Cc: stable@vger.kernel.org	# v6.3
> > Fixes: 51a8f9d7f587 ("virtio: vdpa: new SolidNET DPU driver.")
> > Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > Closes:
> > https://lore.kernel.org/all/74e9109a-ac59-49e2-9b1d-d825c9c9f891@wanado=
o.fr/
> > Suggested-by: Andy Shevchenko <andy@kernel.org>
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
>=20
> I don't get why is this a part of a cleanup series -
> looks like an unrelated bugfix?

It was discovered in the discussion of v1 of this series.

It indeed is an unrelated bugfix and could be merged separately. But my
patch #8 depends on it.

So it would be convenient to merge it into mainline through this
series, and have stable just pick patch #7.

Or should it be done differently, in your opinion?

P.

>=20
>=20
> > ---
> > =C2=A0drivers/vdpa/solidrun/snet_main.c | 7 +++++--
> > =C2=A01 file changed, 5 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/vdpa/solidrun/snet_main.c
> > b/drivers/vdpa/solidrun/snet_main.c
> > index 99428a04068d..4d42a05d70fc 100644
> > --- a/drivers/vdpa/solidrun/snet_main.c
> > +++ b/drivers/vdpa/solidrun/snet_main.c
> > @@ -555,7 +555,7 @@ static const struct vdpa_config_ops
> > snet_config_ops =3D {
> > =C2=A0
> > =C2=A0static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet
> > *psnet)
> > =C2=A0{
> > -	char name[50];
> > +	char *name;
> > =C2=A0	int ret, i, mask =3D 0;
> > =C2=A0	/* We don't know which BAR will be used to communicate..
> > =C2=A0	 * We will map every bar with len > 0.
> > @@ -573,7 +573,10 @@ static int psnet_open_pf_bar(struct pci_dev
> > *pdev, struct psnet *psnet)
> > =C2=A0		return -ENODEV;
> > =C2=A0	}
> > =C2=A0
> > -	snprintf(name, sizeof(name), "psnet[%s]-bars",
> > pci_name(pdev));
> > +	name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-
> > bars", pci_name(pdev));
> > +	if (!name)
> > +		return -ENOMEM;
> > +
> > =C2=A0	ret =3D pcim_iomap_regions(pdev, mask, name);
> > =C2=A0	if (ret) {
> > =C2=A0		SNET_ERR(pdev, "Failed to request and map PCI
> > BARs\n");
> > --=20
> > 2.46.0
>=20


