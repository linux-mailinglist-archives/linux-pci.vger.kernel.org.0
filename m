Return-Path: <linux-pci+bounces-14162-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B172B99801A
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 10:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2BF1C2039A
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 08:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFC81BCA1C;
	Thu, 10 Oct 2024 08:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKorcZtY"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7411BC9ED
	for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2024 08:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728547762; cv=none; b=kAPaYZjasEQq96HQJuqRT7ZT82Ibk+RVNM3JDPfUq9GAtLhuYEgDFhNLxS/SCnIdKwI3G/PC2uo1sTS3pihKLHTmljoz1O15fxITRT/7gLf8ZsarcfS2WIqnoHjDWOvUFHhGRWEretH4IkSP9crE/PT5StMKJ52OT1zzwqsVSdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728547762; c=relaxed/simple;
	bh=pw8KOQX2sQzFlQlPbqII5/R8X0bzkOW8a5wxz7PnGKI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UdhhIDpSyHRTuc+WfL25TEzi3kNAKfnndkHrv5GuiN9i6xdZdEIuA16Cpe3nHpL6099+uYSmlKgbBEka163azAUH63exlEnfVSKjNfXqs2TzEDYWVJCudPG+9f1yyN8ZQp51clYHVRdFRNDAW+kIT1146WsBbaCzW0bo0+WxhA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MKorcZtY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728547760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pw8KOQX2sQzFlQlPbqII5/R8X0bzkOW8a5wxz7PnGKI=;
	b=MKorcZtYqPVyu9qFNW0PPlu++U9wCyP/7B8XwBPfdWG7stS1a9grtp3lWE7V6SOhtsRDdv
	oJCjGsvpXTbNR3bEYBG2w5Wm1IqALxK3QlC9oDO2YaagBmwzDDUeEk61ZawQJBnCuP9g88
	Nq4GQwiQv/LTWxeEk6MPVhwtLDd/ABo=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-FwafXMU5PvO8wYbigmxfEg-1; Thu, 10 Oct 2024 04:09:18 -0400
X-MC-Unique: FwafXMU5PvO8wYbigmxfEg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-539ada1e190so401493e87.2
        for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2024 01:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728547757; x=1729152557;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pw8KOQX2sQzFlQlPbqII5/R8X0bzkOW8a5wxz7PnGKI=;
        b=emTPMFs0sop4goavJBjrJEia984K7FxwTc/lIVghPQvQd0BFQ5xzBH4R5Zvp82Mg/v
         xh9B+p+CF1PakUmFXN5WMSSoUjIVd25frqRyPxt6VC3GfmMAm7Q937te5gvTw1YLepc+
         wxiN3cuXBa3osCxBXT1k56utfvbChCvgL/+rBV69i+wcXXJbUBdX+ccWMWMgSVy9T/dG
         Uyyl2VRz74Q+bxZ1qSgs6Dlf9o1uhzAXWYUiBC/vMSM03icKXyZJbJvxSfs5sVhXEedF
         Pqw6a64M+FGRxGNOJdBxt3f5yUEQAqarpsaHFzwBukYA3vW8S8z+Dhu7lFd3dhGhsrxh
         vatA==
X-Forwarded-Encrypted: i=1; AJvYcCXI3UZvBw2duwCsf0lnwWPoS4GnlSpXjSfZECZFj8kcUx+Mo83MuNiCtOeDGj+ltB+h2ZZ84EfKCmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPAJAKxvPqGyctFU8rFdoAZA7mBtVocFGMMLkHcptQSwOKZvjL
	I2bT1c+tUQUXsPaQAbqTWGWTY9m6ektJyoUDEzNg6xfmv/B3RHOyiKQbjgw/gFlXf4Hm+AkRH0+
	hFwknJBMF5KKRbhOxA1zf9yxNVLecSKNmX8FvrIBIQTb58mYOKJeMAAX9Bg==
X-Received: by 2002:a05:6512:39c5:b0:539:8e9a:7a5d with SMTP id 2adb3069b0e04-539c496d11bmr3575128e87.59.1728547757146;
        Thu, 10 Oct 2024 01:09:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYx/LKt+QTCY84iQbturhiv4PGMfz8gf1TEkJnFJaO0GasD2CA7x+ACPT7d09hd8mpWAI6Rw==
X-Received: by 2002:a05:6512:39c5:b0:539:8e9a:7a5d with SMTP id 2adb3069b0e04-539c496d11bmr3575082e87.59.1728547756510;
        Thu, 10 Oct 2024 01:09:16 -0700 (PDT)
Received: from dhcp-64-16.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43096601152sm42136595e9.0.2024.10.10.01.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 01:09:16 -0700 (PDT)
Message-ID: <6468cf3e4a06c008644c98a7a79f81a1c04752b8.camel@redhat.com>
Subject: Re: [RFC PATCH 00/13] Remove implicit devres from pci_intx()
From: Philipp Stanner <pstanner@redhat.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, Damien Le Moal
 <dlemoal@kernel.org>,  Niklas Cassel <cassel@kernel.org>, Sergey Shtylyov
 <s.shtylyov@omp.ru>, Basavaraj Natikar <basavaraj.natikar@amd.com>, Jiri
 Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alex Dubov <oakad@yahoo.com>, Sudarsana Kalluru <skalluru@marvell.com>,
 Manish Chopra <manishc@marvell.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rasesh Mody
 <rmody@marvell.com>, GR-Linux-NIC-Dev@marvell.com, Igor Mitsyanko
 <imitsyanko@quantenna.com>, Sergey Matyukevich <geomatsi@gmail.com>, Kalle
 Valo <kvalo@kernel.org>, Sanjay R Mehta <sanju.mehta@amd.com>, Shyam Sundar
 S K <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang
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
 Marc Zyngier <maz@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, netdev@vger.kernel.org, 
 linux-wireless@vger.kernel.org, ntb@lists.linux.dev,
 linux-pci@vger.kernel.org,  linux-staging@lists.linux.dev,
 kvm@vger.kernel.org,  xen-devel@lists.xenproject.org,
 linux-sound@vger.kernel.org
Date: Thu, 10 Oct 2024 10:09:12 +0200
In-Reply-To: <8643a212-884c-48de-a2d0-0f068fc49ca2@gmail.com>
References: <20241009083519.10088-1-pstanner@redhat.com>
	 <8643a212-884c-48de-a2d0-0f068fc49ca2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-09 at 20:32 +0200, Heiner Kallweit wrote:
> On 09.10.2024 10:35, Philipp Stanner wrote:
> > Hi all,
> >=20
> > this series removes a problematic feature from pci_intx(). That
> > function
> > sometimes implicitly uses devres for automatic cleanup. We should
> > get
> > rid of this implicit behavior.
> >=20
> > To do so, a pci_intx() version that is always-managed, and one that
> > is
> > never-managed are provided. Then, all pci_intx() users are ported
> > to the
> > version they need. Afterwards, pci_intx() can be cleaned up and the
> > users of the never-managed version be ported back to pci_intx().
> >=20
> > This way we'd get this PCI API consistent again.
> >=20
> AFAICS pci_intx() is used only by drivers which haven't been
> converted
> to the pci_alloc_irq_vectors() API yet. Wouldn't it be better to do
> this
> instead of trying to improve pci_intx()?

This would be the cr=C3=A9me-de-la-cr=C3=A9me-solution, yes.

But such a portation would require more detailed knowledge of the old
drivers.

In this discussion, Alex points out that at least in some drivers, you
can't replace pci_intx() without further ado:
https://lore.kernel.org/all/20240904151020.486f599e.alex.williamson@redhat.=
com/


What we could do is mark pci_intx() and pcim_intx() as deprecated and
point everyone to pci_alloc_irq_vectors(). Then someone can look into
porting the old drivers at some point in the future.


P.


> Eventually pci_intx() would have to be used in PCI core only.
>=20
> > The last patch obviously reverts the previous patches that made
> > drivers
> > use pci_intx_unmanaged(). But this way it's easier to review and
> > approve. It also makes sure that each checked out commit should
> > provide
> > correct behavior, not just the entire series as a whole.
> >=20
> > Merge plan for this would be to enter through the PCI tree.
> >=20
> > Please say so if you've got concerns with the general idea behind
> > the
> > RFC.
> >=20
> > Regards,
> > P.
> >=20
> > Philipp Stanner (13):
> > =C2=A0 PCI: Prepare removing devres from pci_intx()
> > =C2=A0 ALSA: hda: hda_intel: Use always-managed version of pcim_intx()
> > =C2=A0 drivers/xen: Use never-managed version of pci_intx()
> > =C2=A0 net/ethernet: Use never-managed version of pci_intx()
> > =C2=A0 net/ntb: Use never-managed version of pci_intx()
> > =C2=A0 misc: Use never-managed version of pci_intx()
> > =C2=A0 vfio/pci: Use never-managed version of pci_intx()
> > =C2=A0 PCI: MSI: Use never-managed version of pci_intx()
> > =C2=A0 ata: Use always-managed version of pci_intx()
> > =C2=A0 staging: rts5280: Use always-managed version of pci_intx()
> > =C2=A0 wifi: qtnfmac: use always-managed version of pcim_intx()
> > =C2=A0 HID: amd_sfh: Use always-managed version of pcim_intx()
> > =C2=A0 Remove devres from pci_intx()
> >=20
> > =C2=A0drivers/ata/ahci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > =C2=A0drivers/ata/ata_piix.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > =C2=A0drivers/ata/pata_rdc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > =C2=A0drivers/ata/sata_sil24.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 2 +-
> > =C2=A0drivers/ata/sata_sis.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > =C2=A0drivers/ata/sata_uli.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > =C2=A0drivers/ata/sata_vsc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > =C2=A0drivers/hid/amd-sfh-hid/amd_sfh_pcie.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
> > =C2=A0drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c |=C2=A0 2 +-
> > =C2=A0.../wireless/quantenna/qtnfmac/pcie/pcie.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0 2 +-
> > =C2=A0drivers/pci/devres.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 24 +++------------
> > ----
> > =C2=A0drivers/pci/pci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 14 +----------
> > =C2=A0drivers/staging/rts5208/rtsx.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > =C2=A0include/linux/pci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > =C2=A0sound/pci/hda/hda_intel.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 2 +-
> > =C2=A015 files changed, 18 insertions(+), 47 deletions(-)
> >=20
>=20


