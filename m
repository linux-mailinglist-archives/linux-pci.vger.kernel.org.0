Return-Path: <linux-pci+bounces-12491-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 670AA965965
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 10:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AAC51C2163E
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 08:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE1516726E;
	Fri, 30 Aug 2024 08:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXMurrdJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDA715099A
	for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2024 08:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725005190; cv=none; b=cFOAYK0FoJV3TNNa71F9DpJ9NxeZFRU80oOOrnLYPX5mX1c5ja0Z6NZooe+CuzaDo7mzBCC0FCUIjPztn19AEiJYVby3oVs06jOwI1vhqDdlGBEsmtrjwdYUL5zU5oQ+ntnR1QvD/OVNNB3boO+piNHlY+iLQAc1Fff3jHzotIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725005190; c=relaxed/simple;
	bh=71gPXzApkUJkbbo3sc3sJH3nklCpJRWVUVpfiyyleDM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K9eqgNAM7GMtcliwVCJE1Az9vFpzmTF/Ev8p4tJ5ponH0aKA7zTpNGKK8zw4gxSIiOnnqAiPAvYLl1RerMyEIEXfQxxcTp/F0vMKfBvl7aI1FgnocNsHxSsC1zrbNn40n+21dGS3fwbqU8zfBIjmZKmsT5PzYBc1vje5ShCgX+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KXMurrdJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725005187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=71gPXzApkUJkbbo3sc3sJH3nklCpJRWVUVpfiyyleDM=;
	b=KXMurrdJSWi/NjM0k0S7xW0yLSH8wUpRXZDKD0zETzSpwA5Ze3rxY2Plp1CCtHqJD/IG6t
	gSPai8A6cevo2/PivW2T0y43BmUo1g9To0FRX5lYJkyS5EUphW/ugf3c50ctDqCAgLWnO3
	db0zIYPmxZKZEz7ebBFEArJsXD0gBfA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-Nfsv_KAlP4e84EmeuiVDCw-1; Fri, 30 Aug 2024 04:05:17 -0400
X-MC-Unique: Nfsv_KAlP4e84EmeuiVDCw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-428e0d30911so14396925e9.2
        for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2024 01:05:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725005116; x=1725609916;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=71gPXzApkUJkbbo3sc3sJH3nklCpJRWVUVpfiyyleDM=;
        b=kpVmjYPq7lRg09DTmKW07Jh0X9YtoZEJ3KXVGBeKGDympARWyf1mou6+TMy6UPFfqG
         wzO+F5OOsWG8o7AqI++DaaYdjMGlutOqiPt/YE87gDrSGybHvoZT7KuVhtXqKJaUE6Vv
         wpOA87tzeTDL2pEGuFlRt4yVi3qKkmr1wbyQfntLiJxrU5dxZCpyUJ7DvYDwpCXeKGeQ
         oaha8SLrlQayD6WeH4ALZkETNM7MUr4l5lSazottc1acaBV6+naKonHQVppMhb3svqXG
         O9f0yOV2Okax+LY0292wMLMXVQvrtoTP3rkMZnq09QWecwW62YHjI2pHKB3STDHebKXd
         ES1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVrpMYxxEmFB81SEEYYnrpcPrg/6vvkC0O7030HZC2S56uI5cjn0PtLDCfCQ1jDeApyHt/iW20xxi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNDe+jR9DF66rGmP3c42DdpCivXx8C3+PIBPN0wXfMXDIV5Fgx
	qBipVnrTrO6yCICnnrmFbfKJRd4vF9i4mppECH6XAPuybgHzpXdlRGsYvSz1nGYrKKWz3/QTvyX
	wOOP0eq0sherpjQFeon/KOMaftjFoVnoKhHxga21Ha9I+FtLuVeTkJXj8KA==
X-Received: by 2002:a05:600c:1914:b0:42b:afbb:1704 with SMTP id 5b1f17b1804b1-42bb0281326mr42324595e9.6.1725005115856;
        Fri, 30 Aug 2024 01:05:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElMHHa1ss0AjuIdZRhm4Z2kioy67ZZmuCCx+UBXe8jQVj10UPNfr/s1tjKN2uvyTW+vaIl2g==
X-Received: by 2002:a05:600c:1914:b0:42b:afbb:1704 with SMTP id 5b1f17b1804b1-42bb0281326mr42324235e9.6.1725005115323;
        Fri, 30 Aug 2024 01:05:15 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82d2f1b0080ee39dcd7d81ce9.dip.versatel-1u1.de. [2001:16b8:2d2f:1b00:80ee:39dc:d7d8:1ce9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ef7f329sm3287195f8f.70.2024.08.30.01.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 01:05:14 -0700 (PDT)
Message-ID: <ff637570c16c6a15be414839ec4878e49ecd2350.camel@redhat.com>
Subject: Re: [PATCH v5 6/7] vdpa: solidrun: Fix UB bug with devres
From: Philipp Stanner <pstanner@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Jens Axboe
 <axboe@kernel.dk>,  Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
 Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Andy
 Shevchenko <andy@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>, Jason
 Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, Damien Le Moal <dlemoal@kernel.org>, Hannes
 Reinecke <hare@suse.de>, John Garry <john.g.garry@oracle.com>,
 linux-block@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org,  linux-gpio@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
 virtualization@lists.linux.dev, stable@vger.kernel.org, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>
Date: Fri, 30 Aug 2024 10:05:12 +0200
In-Reply-To: <20240829110902-mutt-send-email-mst@kernel.org>
References: <20240829141844.39064-1-pstanner@redhat.com>
	 <20240829141844.39064-7-pstanner@redhat.com>
	 <20240829102320-mutt-send-email-mst@kernel.org>
	 <CAHp75Ve7O6eAiNx0+v_SNR2vuYgnkeWrPD1Umb1afS3pf7m8MQ@mail.gmail.com>
	 <20240829104124-mutt-send-email-mst@kernel.org>
	 <2cc5984b65beb6805f8d60ffd9627897b65b7700.camel@redhat.com>
	 <20240829110902-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-29 at 11:10 -0400, Michael S. Tsirkin wrote:
> On Thu, Aug 29, 2024 at 04:49:50PM +0200, Philipp Stanner wrote:
> > On Thu, 2024-08-29 at 10:41 -0400, Michael S. Tsirkin wrote:
> > > On Thu, Aug 29, 2024 at 05:26:39PM +0300, Andy Shevchenko wrote:
> > > > On Thu, Aug 29, 2024 at 5:23=E2=80=AFPM Michael S. Tsirkin
> > > > <mst@redhat.com>
> > > > wrote:
> > > > >=20
> > > > > On Thu, Aug 29, 2024 at 04:16:25PM +0200, Philipp Stanner
> > > > > wrote:
> > > > > > In psnet_open_pf_bar() and snet_open_vf_bar() a string
> > > > > > later
> > > > > > passed to
> > > > > > pcim_iomap_regions() is placed on the stack. Neither
> > > > > > pcim_iomap_regions() nor the functions it calls copy that
> > > > > > string.
> > > > > >=20
> > > > > > Should the string later ever be used, this, consequently,
> > > > > > causes
> > > > > > undefined behavior since the stack frame will by then have
> > > > > > disappeared.
> > > > > >=20
> > > > > > Fix the bug by allocating the strings on the heap through
> > > > > > devm_kasprintf().
> > > > > >=20
> > > > > > Cc: stable@vger.kernel.org=C2=A0=C2=A0=C2=A0 # v6.3
> > > > > > Fixes: 51a8f9d7f587 ("virtio: vdpa: new SolidNET DPU
> > > > > > driver.")
> > > > > > Reported-by: Christophe JAILLET
> > > > > > <christophe.jaillet@wanadoo.fr>
> > > > > > Closes:
> > > > > > https://lore.kernel.org/all/74e9109a-ac59-49e2-9b1d-d825c9c9f89=
1@wanadoo.fr/
> > > > > > Suggested-by: Andy Shevchenko <andy@kernel.org>
> > > > > > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > > > >=20
> > > > > Post this separately, so I can apply?
> > > >=20
> > > > Don't you use `b4`? With it it as simple as
> > > >=20
> > > > =C2=A0 b4 am -P 6 $MSG_ID_OF_THIS_SERIES
> > > >=20
> > > > --=20
> > > > With Best Regards,
> > > > Andy Shevchenko
> > >=20
> > > I can do all kind of things, but if it's posted as part of a
> > > patchset,
> > > it is not clear to me this has been tested outside of the
> > > patchset.
> > >=20
> >=20
> > Separating it from the series would lead to merge conflicts,
> > because
> > patch 7 depends on it.
> >=20
> > If you're responsible for vdpa in general I could send patches 6
> > and 7
> > separately to you.
> >=20
> > But number 7 depends on number 1, because pcim_iounmap_region()
> > needs
> > to be public. So if patches 1-5 enter through a different tree than
> > yours, that could be a problem.
> >=20
> >=20
> > P.
>=20
> Defer 1/7 until after the merge window, this is what is normally
> done.

1 cannot be deferred. Take a look what 1 does.

Your message is not comprehensible. Be so kind and write some more
sentences.
*What* is normally done? Sending patches? It's up to subsystem
maintainers to queue them for the right cycle.

> Adding new warnings is not nice, anyway.

What?



>=20


