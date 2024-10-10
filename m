Return-Path: <linux-pci+bounces-14161-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C247997FF9
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 10:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF70E1F254C8
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 08:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4FB205E38;
	Thu, 10 Oct 2024 08:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ky3II9Pe"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFCB204F79
	for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2024 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728547421; cv=none; b=co9Jpz7B1aeERsvHPAjdmuwhS0LMHiUii8IIWZEdd87unJXenHvJZcK2rAy2GWp73+RZaUUubl+5rJYe2EgxG9+S3cCMMPbrgdrJ9TVorUsXXpC5EtLAZ14vP/nQWCiUKcGN+zl2/cudJqmNB5YT5xieAPNCGEoUYjFeb+QcX+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728547421; c=relaxed/simple;
	bh=o6Yj13wTDdGSHGjmO/sKiO7EHFlnxmZYRbSplb6dOKU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iubMRhT7aujjqdy8XmfnRAcbIlxfIDbxWB4AcPY240guLl0qD8hnQj18Lmb3tXZdUWBx62MsGLqLSm+HMunae5QEfemRk7or0TGP0N0j1RH1XE9bQt3n3EWViN4nBCm6UjHVpwo1Ef5x7fcRzGwcrF48TtOmyYnYbbDdI4Koxt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ky3II9Pe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728547418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o6Yj13wTDdGSHGjmO/sKiO7EHFlnxmZYRbSplb6dOKU=;
	b=Ky3II9Pe3t+C8sy+q5JqGqtM4N6q9hBTKb3fJQlgpGWMAjh/9cw+QGUXkpPqBg1rpTBzT8
	V4UmNt3nnLLogexCYPieKb+IRFQhRRogi+ShxZMy9j5iU2XQht2xYDAkOysu8eD3CrUejR
	B7Q/maoBGW7UXO+VSgfbhrm788fJ/ZA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-Xmx6uWyQMlqeDp84VjRtHg-1; Thu, 10 Oct 2024 04:03:37 -0400
X-MC-Unique: Xmx6uWyQMlqeDp84VjRtHg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d3986f5a4so185864f8f.3
        for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2024 01:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728547415; x=1729152215;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o6Yj13wTDdGSHGjmO/sKiO7EHFlnxmZYRbSplb6dOKU=;
        b=YKtom1pahq2JpyPEOZ8+QovgIuPSUnnupu+H1jK94rDNPVOdOGaa6t6d/YwbwIgmKl
         sYVYbgdtciuyM3c7/qTT+/ZQzCMCpYUS2xbx6szWIv/DtampscmyovlQlRCwUAzXoAfB
         RyoJkS2OlX5lHzYBfurkvjeYjc0NK4y7CA/ujB2J0Qte85qjhAP24kFUEDx00zWyTdnB
         GTYad3Ll9XPoL8OaYLcZC5D9E5CbzuEeUYUKe2Ay/7EIIkum4loUpiqmpUWgOPC5Npr2
         t2DSquIWs6vuz6UjwQ7Ern1qze46WjbM/qF5XgKwrjtRPHC9gNvVGMdxpaJZqS+alwfc
         g+oA==
X-Forwarded-Encrypted: i=1; AJvYcCUnYoqCE1QkBCWqvjGGIyN9lpZXwGk9qsi6kI+3shB7e7ws16jCvhFzjt/0wWJaZbM49v6FyrGSAOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/JqKueIndjGu1+HK1SKvnuUD+odaalg6g4+U2ua0s+dTIagtO
	Hq1Bk86IcYI/FA/d8LQfNfImh4xqdQVzhbO2tEsaEhFxRwQrVPbc/n6r86X3rS9lB1yFUHVB7GO
	PbbEhW9gdPdOJHyTYgIYC2ZsrO4osIIkWE3IUadiwM7OIJD+B1+dyAYU+8A==
X-Received: by 2002:adf:f3c7:0:b0:37c:d299:b5f0 with SMTP id ffacd0b85a97d-37d3ab44f04mr2752572f8f.59.1728547414833;
        Thu, 10 Oct 2024 01:03:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCPZ/N+8I6yvkHpm2WH4x1aWbcKYPe3oMumoEtWLk5b9nz8TmEseUc5OhVu0HO7+xCgvRnQw==
X-Received: by 2002:adf:f3c7:0:b0:37c:d299:b5f0 with SMTP id ffacd0b85a97d-37d3ab44f04mr2752523f8f.59.1728547414296;
        Thu, 10 Oct 2024 01:03:34 -0700 (PDT)
Received: from dhcp-64-16.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7edecasm776544f8f.97.2024.10.10.01.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 01:03:33 -0700 (PDT)
Message-ID: <b57dbf0c83125d58e4e2b488b5b5f71410fd8d6a.camel@redhat.com>
Subject: Re: [RFC PATCH 10/13] staging: rts5280: Use always-managed version
 of pci_intx()
From: Philipp Stanner <pstanner@redhat.com>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 Sergey Shtylyov <s.shtylyov@omp.ru>, Basavaraj Natikar
 <basavaraj.natikar@amd.com>, Jiri Kosina <jikos@kernel.org>,  Benjamin
 Tissoires <bentiss@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Alex Dubov
 <oakad@yahoo.com>,  Sudarsana Kalluru <skalluru@marvell.com>, Manish Chopra
 <manishc@marvell.com>, "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>,  Rasesh Mody <rmody@marvell.com>,
 GR-Linux-NIC-Dev@marvell.com, Igor Mitsyanko <imitsyanko@quantenna.com>, 
 Sergey Matyukevich <geomatsi@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Sanjay R Mehta <sanju.mehta@amd.com>, Shyam Sundar S K
 <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang
 <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Alex Williamson <alex.williamson@redhat.com>,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>, Oleksandr Tyshchenko
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
 Marc Zyngier <maz@kernel.org>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-input@vger.kernel.org,
 netdev@vger.kernel.org,  linux-wireless@vger.kernel.org,
 ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
 linux-staging@lists.linux.dev, kvm@vger.kernel.org, 
 xen-devel@lists.xenproject.org, linux-sound@vger.kernel.org
Date: Thu, 10 Oct 2024 10:03:30 +0200
In-Reply-To: <411f3c94-58b5-471e-bc58-e23d89d2078f@gmail.com>
References: <20241009083519.10088-1-pstanner@redhat.com>
	 <20241009083519.10088-11-pstanner@redhat.com>
	 <2024100936-brunette-flannels-0d82@gregkh>
	 <411f3c94-58b5-471e-bc58-e23d89d2078f@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-09 at 21:41 +0200, Philipp Hortmann wrote:
> On 10/9/24 11:38, Greg Kroah-Hartman wrote:
> > On Wed, Oct 09, 2024 at 10:35:16AM +0200, Philipp Stanner wrote:
> > > pci_intx() is a hybrid function which can sometimes be managed
> > > through
> > > devres. To remove this hybrid nature from pci_intx(), it is
> > > necessary to
> > > port users to either an always-managed or a never-managed
> > > version.
> > >=20
> > > rts5208 enables its PCI-Device with pcim_enable_device(). Thus,
> > > it needs the
> > > always-managed version.
> > >=20
> > > Replace pci_intx() with pcim_intx().
> > >=20
> > > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > > ---
> > > =C2=A0 drivers/staging/rts5208/rtsx.c | 2 +-
> > > =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >=20
>=20
> Hi Philipp,
>=20
> this driver (rts5208) will be removed soon - patch is send in.
>=20
> Discussion about removal:
> https://lore.kernel.org/linux-staging/2024100943-shank-washed-a765@gregkh=
/T/#t


Alright, thx for the heads up.

I'm not entirely how best to deal with that, though. I could drop this
patch, but then the driver would end up with an unmanaged pci_intx().

Might this be a problem for users if my series lands sooner than the
removal, say in v6.13 and your removal in v6.14?

P.

>=20
> Thanks for your support.
>=20
> Bye Philipp
>=20


