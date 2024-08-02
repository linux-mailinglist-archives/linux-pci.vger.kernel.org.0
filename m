Return-Path: <linux-pci+bounces-11176-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0501C945911
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 09:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B043B282C2C
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 07:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004A91BF325;
	Fri,  2 Aug 2024 07:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BedV4qwT"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F1215B13D
	for <linux-pci@vger.kernel.org>; Fri,  2 Aug 2024 07:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722584360; cv=none; b=tmLFj2TTpCNxUKldet36YefDlN4PLbEZWMO86/ixED/cyWABiCMU1fjsvgWDudmWtJ5pslfQIQlBLFKpehTrmx/H0N4ec0ZzB/uBMWn+UCSSZKvxmo8DFccVI4KDBSJYictode/j7gdQuJ5InWeJKK7X1xxGxzHDxBZ8zA1Bfvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722584360; c=relaxed/simple;
	bh=XyoAsjYXR6vlNnAFOtS7SDp80nop+IcyYDiUz8xV5lU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tdu5RwsysxXIVIriYTzvhorKpE7AXAGFVLsQU1Fg/Z3Uq0cWnCbB1BXewPOW7Uwg/ImacL56kMOHxy9LSzaia9mOo4tqzBRtKGr8n8R3T6nAJV8BDPjHCCfn9GZF3R1s448RYMiKRjhq4q0t27KCNRK6D5Cu5z94TPBX/9acWOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BedV4qwT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722584357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XyoAsjYXR6vlNnAFOtS7SDp80nop+IcyYDiUz8xV5lU=;
	b=BedV4qwT1Ebraxcmp08denCVQ5m+jWUwcyROQZ5hVOA8aTv8UJrD9tqIzUg++bIls79sHt
	IkwT+hh8NDWmrBz9G+C8YGEyxWwzDCQWTkcrc1rOXlF6juFnyqjmNVOgqKZVKE0cNUSgI7
	/OyrLT/VYCWdqTrwc2w4bu7fPUJbLxI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-9zkpsCk6P3-9yIeBFcncHA-1; Fri, 02 Aug 2024 03:39:15 -0400
X-MC-Unique: 9zkpsCk6P3-9yIeBFcncHA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5a2b8c44b48so2124291a12.0
        for <linux-pci@vger.kernel.org>; Fri, 02 Aug 2024 00:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722584354; x=1723189154;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XyoAsjYXR6vlNnAFOtS7SDp80nop+IcyYDiUz8xV5lU=;
        b=ACADkTWMzGkJingUlyOhblFev6qdWXaVoPI8JSJADw0h9VrKAirYcHeRg84f+J7PIm
         7RjHRe6ubcKSDIslhAJ3VVmiLSAkt9dEYbWqdWlCF/NkEh+7BA7aMQK13GjssqDuYF8Y
         KHkxTDRspoqJINRvH76qkxL0bCkQ4m2mV7Q0hZUnRZYHxrGwNNyur+kQeTxOcMF8dpR+
         t2jIkoFTIVNo3xFk9bvA0BTtuvWuNm+F4C5TXEswdoBm8v1e6/vlvX4GjFs8l94lkvBG
         rdXbBw4tYPGg9bFZPupBF1l6EzTqKDkAGCqIh4g/1mq3Uj77gdinUeHbmC00O67adhoT
         farg==
X-Forwarded-Encrypted: i=1; AJvYcCX7UBMKcdbZQFHVGVnq7sFhjFHBM/hqzjc/sRKhpI22El/g3nDNzoIuFZzd/hezXvFVxVj/vWlAXippz3ynfbS0nJAXsU/o5cZt
X-Gm-Message-State: AOJu0YxzkXGUzLiKdBtptcxgKZ363m+aZNhQgVUZp6zjVmYNCccTCV4D
	4thCynrn6iiBhvzaxPFu4VDAO5Fy3ELhxG5bi6Nr9Uv+NzFEn6ZxNqYk+VvrdPO1WIS36cCabSx
	UDRNM5UdTmSwU7baiJgi9OcsjyYXJ1kvXjPH6oAnoXGck7exBLOmAiNUipw==
X-Received: by 2002:a17:907:d8e:b0:a7a:a4be:2f8f with SMTP id a640c23a62f3a-a7dc4b2ed0fmr130671266b.0.1722584354327;
        Fri, 02 Aug 2024 00:39:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFONH/seRIPn55nxoXB3Ih6iDe58gzFUv6VfG3nc8IISoWvXI/jL74Kj1p+wvKOnC3k+pqpQ==
X-Received: by 2002:a17:907:d8e:b0:a7a:a4be:2f8f with SMTP id a640c23a62f3a-a7dc4b2ed0fmr130665366b.0.1722584353684;
        Fri, 02 Aug 2024 00:39:13 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3d6c:8e00:43f3:8884:76fa:d218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e80eb6sm66892066b.174.2024.08.02.00.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 00:39:13 -0700 (PDT)
Message-ID: <6eb427a501499273b39439dd6514fef399c3b55f.camel@redhat.com>
Subject: Re: [PATCH 08/10] serial: rp2: Remove deprecated PCI functions
From: Philipp Stanner <pstanner@redhat.com>
To: Jiri Slaby <jirislaby@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu
 <herbert@gondor.apana.org.au>,  "David S. Miller" <davem@davemloft.net>,
 Boris Brezillon <bbrezillon@kernel.org>, Arnaud Ebalard
 <arno@natisbad.org>,  Srujana Challa <schalla@marvell.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>, Kalle Valo <kvalo@kernel.org>, Serge
 Semin <fancer.lancer@gmail.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang
 <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Kevin Cernekee <cernekee@gmail.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Mark Brown
 <broonie@kernel.org>, David Lechner <dlechner@baylibre.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>,  Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Jie Wang <jie.wang@intel.com>, Adam
 Guerin <adam.guerin@intel.com>, Shashank Gupta <shashank.gupta@intel.com>,
 Damian Muszynski <damian.muszynski@intel.com>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, Johannes
 Berg <johannes.berg@intel.com>, Gregory Greenman
 <gregory.greenman@intel.com>, Emmanuel Grumbach
 <emmanuel.grumbach@intel.com>, Yedidya Benshimol
 <yedidya.ben.shimol@intel.com>, Breno Leitao <leitao@debian.org>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, John Ogness
 <john.ogness@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-ide@vger.kernel.org, qat-linux@intel.com,
 linux-crypto@vger.kernel.org,  linux-wireless@vger.kernel.org,
 ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-sound@vger.kernel.org
Date: Fri, 02 Aug 2024 09:39:11 +0200
In-Reply-To: <8d2e03ac-2a08-4a25-9929-dad375afb738@kernel.org>
References: <20240801174608.50592-1-pstanner@redhat.com>
	 <20240801174608.50592-9-pstanner@redhat.com>
	 <8d2e03ac-2a08-4a25-9929-dad375afb738@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-08-02 at 07:18 +0200, Jiri Slaby wrote:
> On 01. 08. 24, 19:46, Philipp Stanner wrote:
> > pcim_iomap_table() and pcim_iomap_regions_request_all() have been
> > deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI:
> > Deprecate
> > pcim_iomap_table(), pcim_iomap_regions_request_all()").
> >=20
> > Replace these functions with their successors, pcim_iomap() and
> > pcim_request_all_regions()
>=20
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

Thank you for the review.

I have to provide a v2 for a small bug in one of the other patches.
While I'm at it, I would rename the title of this patch =E2=84=968 here so =
that
it's "Replace" instead of "Remove", making it consistent with the other
ones.

I'd assume that keeping your RB then would be alright. Please tell me
if not.

Cheers,
P.

>=20
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > ---
> > =C2=A0 drivers/tty/serial/rp2.c | 12 +++++++-----
> > =C2=A0 1 file changed, 7 insertions(+), 5 deletions(-)
>=20
> thanks,


