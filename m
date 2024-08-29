Return-Path: <linux-pci+bounces-12450-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7679296490B
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 16:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B85C1C23235
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 14:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C34193085;
	Thu, 29 Aug 2024 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WiRacs8L"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81291B14FC
	for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2024 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943004; cv=none; b=c4WYDCfaqnUoVplYFv+0CpgMw8lNKyhPV8Ni9HBZZQomUqj1k6xfbVo0K3KouDoAfFCG5TLbIRPCxBlV6KnihJvXKvzUsbXj/MLm3KOElJdTpro/o+jjpjhKmPX5RlxqUhuUQ9Kl1ouNV8c+0zqzEoAhawhz7RjnbxmP1eMBd6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943004; c=relaxed/simple;
	bh=S2sT6L9UUzta00cejZJS50RWMrLlQc0scK9J+l0UXXw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nPAAbGrFLqUdPJMwc+2OFvqL8YE4q7vQw/XuhY0fu0uXO/Mz9n2kZoWJ1uHW02iC5uciPD0thu8zufgPd1h+zofxJmJJBUhoo2Hh7H5ha3sx3b71ZHm02+NqZ3SnHnZNkJqxh3HarcauCMZ+1V5nxbCddORd2ShP5s4NA+Mi0fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WiRacs8L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724943001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S2sT6L9UUzta00cejZJS50RWMrLlQc0scK9J+l0UXXw=;
	b=WiRacs8LaH3DA+P4o8QYz373aQKm0dnd9UG0888L12I8fIVf0bNp6gQACjZxU90d96dvht
	iSzdN+AASq5Ik4qxcI4o9gcuFRxkS1Nk4x0TKjiISTTB4vxa1hdgKm0g2CzvxhuWulqHic
	GPwniy9skGFxiYdEzRUonyXU+Txp3Lo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-oFhe3J5MNO2ufu-VYgQ0sQ-1; Thu, 29 Aug 2024 10:49:55 -0400
X-MC-Unique: oFhe3J5MNO2ufu-VYgQ0sQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37193ed09b2so1103997f8f.1
        for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2024 07:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724942994; x=1725547794;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S2sT6L9UUzta00cejZJS50RWMrLlQc0scK9J+l0UXXw=;
        b=QtQbmFt4Rl4wBdzRuYJyPm1/WhG1UNcEhk4OQ7sUBOQh/aEQyWwTje4NZPsl/BaQcH
         8+DIKDd8eRU9oPUjMOFyYy2T3REiAyI8kYPgllqSzLEa6hJVlsq8Gw9mz5v3/MLdNnJX
         9ONF9DC48+hsC/DyayjujGDGQ/4QHAacatGO2IlPI9A+xOiYhggppj5zmrCzuoQLJs/j
         kSW2uLFAO5KzawzkdT4cb+iVTS/uZwdCqJ7uNEIn7gfXtwvchvrF+WtFHZOmBYPC043x
         lxWmGIb23gZZWisd+ccIoeaPsX4G8lJoMziphz97yhrkWn/ylk0y9i1Ke+01uj+m44AV
         Dd5A==
X-Forwarded-Encrypted: i=1; AJvYcCXLfGnOmk06JDTIg7hAGs8lphxuxczRO92kFTlcZb2uwb8cuWIFZUqYwabQfw3RRO27TJWnLOB022o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwuvy3c+lHmwtBIF8GzIJQc9S4LFOE8dlb397nBnZJfyezhJrL
	Kfz4PiLYiZVjls6RVqz6/bV4tpxsDqWMIVuvlBNGoRDqgbRKcwNZZrbaB/ANrOhRGstc5wdRn6L
	QCcPX6sMg7Gr1c8H/MFZp8arAalD5QrOdk20jKhIKpMp5TeZXXAeYinGtmg==
X-Received: by 2002:a05:6000:d90:b0:362:69b3:8e4d with SMTP id ffacd0b85a97d-374a02323eemr1808471f8f.25.1724942993929;
        Thu, 29 Aug 2024 07:49:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrfaIGeH0p8et8OYjnOCquSTWs4QXgyhcRTReJhUV0MD6wVymReUMbJDmaEmmHD/MIBOPsJA==
X-Received: by 2002:a05:6000:d90:b0:362:69b3:8e4d with SMTP id ffacd0b85a97d-374a02323eemr1808372f8f.25.1724942993389;
        Thu, 29 Aug 2024 07:49:53 -0700 (PDT)
Received: from dhcp-64-16.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42baf7fa745sm33827915e9.31.2024.08.29.07.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 07:49:52 -0700 (PDT)
Message-ID: <2cc5984b65beb6805f8d60ffd9627897b65b7700.camel@redhat.com>
Subject: Re: [PATCH v5 6/7] vdpa: solidrun: Fix UB bug with devres
From: Philipp Stanner <pstanner@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Andy Shevchenko
	 <andy.shevchenko@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>, Tom Rix
 <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>, Xu Yilun
 <yilun.xu@intel.com>,  Andy Shevchenko <andy@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Bjorn Helgaas
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
Date: Thu, 29 Aug 2024 16:49:50 +0200
In-Reply-To: <20240829104124-mutt-send-email-mst@kernel.org>
References: <20240829141844.39064-1-pstanner@redhat.com>
	 <20240829141844.39064-7-pstanner@redhat.com>
	 <20240829102320-mutt-send-email-mst@kernel.org>
	 <CAHp75Ve7O6eAiNx0+v_SNR2vuYgnkeWrPD1Umb1afS3pf7m8MQ@mail.gmail.com>
	 <20240829104124-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-29 at 10:41 -0400, Michael S. Tsirkin wrote:
> On Thu, Aug 29, 2024 at 05:26:39PM +0300, Andy Shevchenko wrote:
> > On Thu, Aug 29, 2024 at 5:23=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com>
> > wrote:
> > >=20
> > > On Thu, Aug 29, 2024 at 04:16:25PM +0200, Philipp Stanner wrote:
> > > > In psnet_open_pf_bar() and snet_open_vf_bar() a string later
> > > > passed to
> > > > pcim_iomap_regions() is placed on the stack. Neither
> > > > pcim_iomap_regions() nor the functions it calls copy that
> > > > string.
> > > >=20
> > > > Should the string later ever be used, this, consequently,
> > > > causes
> > > > undefined behavior since the stack frame will by then have
> > > > disappeared.
> > > >=20
> > > > Fix the bug by allocating the strings on the heap through
> > > > devm_kasprintf().
> > > >=20
> > > > Cc: stable@vger.kernel.org=C2=A0=C2=A0=C2=A0 # v6.3
> > > > Fixes: 51a8f9d7f587 ("virtio: vdpa: new SolidNET DPU driver.")
> > > > Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > > Closes:
> > > > https://lore.kernel.org/all/74e9109a-ac59-49e2-9b1d-d825c9c9f891@wa=
nadoo.fr/
> > > > Suggested-by: Andy Shevchenko <andy@kernel.org>
> > > > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > >=20
> > > Post this separately, so I can apply?
> >=20
> > Don't you use `b4`? With it it as simple as
> >=20
> > =C2=A0 b4 am -P 6 $MSG_ID_OF_THIS_SERIES
> >=20
> > --=20
> > With Best Regards,
> > Andy Shevchenko
>=20
> I can do all kind of things, but if it's posted as part of a
> patchset,
> it is not clear to me this has been tested outside of the patchset.
>=20

Separating it from the series would lead to merge conflicts, because
patch 7 depends on it.

If you're responsible for vdpa in general I could send patches 6 and 7
separately to you.

But number 7 depends on number 1, because pcim_iounmap_region() needs
to be public. So if patches 1-5 enter through a different tree than
yours, that could be a problem.


P.


