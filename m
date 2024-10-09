Return-Path: <linux-pci+bounces-14083-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8182F9967A5
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 12:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5212281B51
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 10:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD822190470;
	Wed,  9 Oct 2024 10:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aD17HEW2"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7882190045
	for <linux-pci@vger.kernel.org>; Wed,  9 Oct 2024 10:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728471023; cv=none; b=QBHMqU1ehDoT1t4HC12wOajFsIAfaoKDnt6lc04c8ToZTCadzz96fvq8t9xVKa5m5SFUHkY/ueAKn7PaBHnIg7u+r5DYsFs8A84uExOOcB3EonxWApPURCjizWQIL2QE7WSL9NjSmrMYzH3AU/lGphr3lUcl583lmzV6c7gHes4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728471023; c=relaxed/simple;
	bh=DSgm22aJFfiNtDR5PH9COXLN1T3/sjP+t9mUNwfGUwc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pd0xuynAk0ez/4b5BYdJ2+ILdv7KWUTniyFg7szdtMsAk/0OyzX1rMVWvawVbD3U7KEwIaEY6qrCKTczIlDvpVylGwOBLIch8dpZbYnj2FLvyA413JEbSSf3yfh54SsGvrSL2lb/iREjYmbxElMOWD9UyG7LFEe485/xjL6INPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aD17HEW2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728471021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DSgm22aJFfiNtDR5PH9COXLN1T3/sjP+t9mUNwfGUwc=;
	b=aD17HEW292abkeVr6K/27cxhGRHtEYgOoCbfpawI/fxMAFpxr22H8uXOLEEKV6m9aTOdML
	fVolMHzdYN+9aqGWalGEuVDdlTxkmQd1Dwxpe9c1h9tJzbGNdXSLvSvDquvh9Lz4buMKp2
	Hevq/JUeyiUHItaqJ2kHx1qvxFAHPhU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-KOOjv1C2OYy05RlxmrcvfA-1; Wed, 09 Oct 2024 06:50:19 -0400
X-MC-Unique: KOOjv1C2OYy05RlxmrcvfA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb6dc3365so57184325e9.2
        for <linux-pci@vger.kernel.org>; Wed, 09 Oct 2024 03:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728471019; x=1729075819;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DSgm22aJFfiNtDR5PH9COXLN1T3/sjP+t9mUNwfGUwc=;
        b=ZBAkIsc2eiHPs4VEUvClZacMkz6ufhpdAOoeykMrz18DY6PHLTbMLzYLQcZseKBWaP
         GzJg2q0ZdrZbu8rqKsg8+T7WHNTog6V0xpQpVwu+upuzZ+h+u3ZMpRgNlNybHXy2sVW5
         ZLqyO4fnsRq+LPi1Ho77hAD4ncfmGnoN3qyePxqfkR6Hg3bK8WO3jww1UTbG+zLISzcP
         2zQoeeFLN/eKdztU2NxTKjFbJUl/wdq2lblbL8hIL3KoW9OTcMdEpG8u9N3RjL8vxNlN
         Fl9ldNgqRj2QwA7rnIV2uuefHgRguknRNXUawR/lk/RvFNWw3xsBioaY650UaskY6/IM
         gmNg==
X-Forwarded-Encrypted: i=1; AJvYcCWTVhIjz4blThT9j4nlvKjcFzJw3rQTflP9HcgVtnoHE3jPknASp4DirU/mKa1vv3gH3N+JYjE25Eg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6bw2byTYRWFMFblipt1lBhvNpnbskwBLfkwp+56sVl8NkJGdQ
	nxDSUcuHQu6UwvvKXlabaJLud9O8F1gUjOHFsLF8XxqXgnJ8SVV/ch5682wxpOrY5RPuBayh1cr
	MuGg7wqWC6uk7I2VLPFz2g3b4OPrLa9ugdIf7rgYPepY6g7X1sKVaq/HrEg==
X-Received: by 2002:a05:600c:154e:b0:42c:bf94:f9ad with SMTP id 5b1f17b1804b1-430d748c5demr14384085e9.34.1728471018516;
        Wed, 09 Oct 2024 03:50:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHApNTrtsbft1V7n10B4IIxH4JucbHmoQkQ4Jkaz+as7iAf1Sn6WqJVUcb29pY2MStHfTeBSg==
X-Received: by 2002:a05:600c:154e:b0:42c:bf94:f9ad with SMTP id 5b1f17b1804b1-430d748c5demr14383375e9.34.1728471017985;
        Wed, 09 Oct 2024 03:50:17 -0700 (PDT)
Received: from dhcp-64-16.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1695e62bsm10108645f8f.81.2024.10.09.03.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 03:50:17 -0700 (PDT)
Message-ID: <6f54425072b008481a0511fc140bab2590cd1c06.camel@redhat.com>
Subject: Re: [RFC PATCH 03/13] drivers/xen: Use never-managed version of
 pci_intx()
From: Philipp Stanner <pstanner@redhat.com>
To: Juergen Gross <jgross@suse.com>, Damien Le Moal <dlemoal@kernel.org>, 
 Niklas Cassel <cassel@kernel.org>, Sergey Shtylyov <s.shtylyov@omp.ru>,
 Basavaraj Natikar <basavaraj.natikar@amd.com>, Jiri Kosina
 <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alex
 Dubov <oakad@yahoo.com>, Sudarsana Kalluru <skalluru@marvell.com>, Manish
 Chopra <manishc@marvell.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rasesh Mody <rmody@marvell.com>,
 GR-Linux-NIC-Dev@marvell.com, Igor Mitsyanko <imitsyanko@quantenna.com>,
 Sergey Matyukevich <geomatsi@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Sanjay R Mehta <sanju.mehta@amd.com>, Shyam Sundar S K
 <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang
 <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>, Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>, Mario Limonciello <mario.limonciello@amd.com>, Chen
 Ni <nichen@iscas.ac.cn>, Ricky Wu <ricky_wu@realtek.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Breno Leitao <leitao@debian.org>, Kevin Tian
 <kevin.tian@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Mostafa Saleh
 <smostafa@google.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hannes Reinecke <hare@suse.de>, John Garry <john.g.garry@oracle.com>,
 Soumya Negi <soumya.negi97@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, Yi
 Liu <yi.l.liu@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
 Christian Brauner <brauner@kernel.org>, Ankit Agrawal <ankita@nvidia.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Eric Auger
 <eric.auger@redhat.com>, Ye Bin <yebin10@huawei.com>, Marek
 =?ISO-8859-1?Q?Marczykowski-G=F3recki?= <marmarek@invisiblethingslab.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Kai Vehmanen
 <kai.vehmanen@linux.intel.com>,  Peter Ujfalusi
 <peter.ujfalusi@linux.intel.com>, Rui Salvaterra <rsalvaterra@gmail.com>,
 Marc Zyngier <maz@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, netdev@vger.kernel.org, 
 linux-wireless@vger.kernel.org, ntb@lists.linux.dev,
 linux-pci@vger.kernel.org,  linux-staging@lists.linux.dev,
 kvm@vger.kernel.org,  xen-devel@lists.xenproject.org,
 linux-sound@vger.kernel.org
Date: Wed, 09 Oct 2024 12:50:14 +0200
In-Reply-To: <3874c932-71c4-4253-9dcf-a9c302e6bc7e@suse.com>
References: <20241009083519.10088-1-pstanner@redhat.com>
	 <20241009083519.10088-4-pstanner@redhat.com>
	 <3874c932-71c4-4253-9dcf-a9c302e6bc7e@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-09 at 10:51 +0200, Juergen Gross wrote:
> On 09.10.24 10:35, Philipp Stanner wrote:
> > pci_intx() is a hybrid function which can sometimes be managed
> > through
> > devres. To remove this hybrid nature from pci_intx(), it is
> > necessary to
> > port users to either an always-managed or a never-managed version.
> >=20
> > xen enables its PCI-Device with pci_enable_device(). Thus, it
> > needs the never-managed version.
> >=20
> > Replace pci_intx() with pci_intx_unmanaged().
> >=20
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
>=20
> Acked-by: Juergen Gross <jgross@suse.com>
>=20
> BTW, the diffstat in the [PATCH 00/13] mail is missing some files,
> e.g. the changes of this patch.

Ooops, probably something exploded when I copied the backed-up cover-
letter after regenerating the patches. Will fix.

But good to see that someone actually reads cover letters :p

P.

>=20
>=20
> Juergen
>=20


