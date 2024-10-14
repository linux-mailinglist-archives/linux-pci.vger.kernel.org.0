Return-Path: <linux-pci+bounces-14436-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8151D99C556
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 11:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10A721F23FE5
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 09:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BC71527BB;
	Mon, 14 Oct 2024 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HUTyjlge"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE5E15667B
	for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728897133; cv=none; b=aOx5k9hzGFSj49qKLvIk0Rpz4enhTGJIORyNvIawcfF61Dtb3hPRUnGFBygUIMDfePyY332y5t11G4q7JKHXgSz/Xg9nK8ir6lMohUavbvkThIdVON28fmyVMiivUKjcesE+YcHZl7w2dBTannjmMJNolgOsUOZylH1Tel54PE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728897133; c=relaxed/simple;
	bh=X6kY1iJ7DeXV7dzOM/Quy8TkeUIc2RgmP57BuSAG348=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LHUhNRHC3mXr3aSED0u2ep5KU9lerpaNdT8E9GVXcJ0UbKpMkxrhnOh7r4ZkGwqqkEVZi4POwZ7ggui35Ht7bv4Iw+MLhNM6+0KSV5e4yShADuvQqDxblUwPUC5vrDFRizLrgjpQbiu7UqwYX7dTREA5e2mQeVCI2ofo7GlBogE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HUTyjlge; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728897130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=efYEDzJoXvnSDmPZhcwgS+G1MqF2s5kTREhSaGYut/4=;
	b=HUTyjlgeFceJqihqg6Rgr5eSgMTf4AyWsRiI+28eO8PlwmGPZze0TaiUxI/okLbYFID8nE
	XRTLYtedaGGVce8vfS5sVC5Wb6ExB4hblwv51M+wg9+DOsaYc9EpCrrO2QWmgP5IWWEMWD
	RmJzg9WhgGt6THrNZFH4N6W/DIbSMdA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-WcShtZyrMBOLN2qo2r9DgQ-1; Mon, 14 Oct 2024 05:12:09 -0400
X-MC-Unique: WcShtZyrMBOLN2qo2r9DgQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a9a1be34c68so10707766b.1
        for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 02:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728897128; x=1729501928;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=efYEDzJoXvnSDmPZhcwgS+G1MqF2s5kTREhSaGYut/4=;
        b=OZA02gF0hIO14JlmKsKP/zfyzx4t9+ar2UaKw+oPiV+vEGux1+gmZ+N8kUIfonbZas
         BYS61gz7s2V06dJnvUEe6KE8S3ESCgCdXGUw8DftGGm3CVf11VaKweUYxg5HJ0+j4Y6V
         dGkiWqrbzWsDcioamN7GLdL9PjrhBi+rWQWvkJ/pwYud8kfhyZug/wQHkraNQteW9nCv
         i1+DodHhMdT3FGYhHqeMJLZH91NkCnNHM8Emtk3zoKekqjH8sIQ6bjkGBuMcRepmY+73
         IzVJd2Ard8LeihwHzzqkPqoYsnh3Np1KzUOWaE210+nRbOuDojTkoe/28QxKLaIbMYm+
         LAnQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4M2k0LiXfjBlyyMmnV/b2656GlO5m7GCF/Oodcd+k1PeOjVGs3gnr4QAcfNbzPWxYosS6VIA3rYM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx69qQdTkswRIACG6/erCU07X+Pi5ZBXCqE4GnFfTLYcfSmJbB/
	lGuB0mgNufvZHi4HHjilCBy/fZYSqZnd44qBjX8NE/sG4Keo+2QC3wBxDmL7xDjqHQfddjQO5YF
	9BxNsLd9VOIR90xLpz+oxE2Ps8flh8udacShJiDOiw6eleGxXFRa0A6yG4g==
X-Received: by 2002:a17:907:9611:b0:a99:36ab:d843 with SMTP id a640c23a62f3a-a99b940ff26mr1050660966b.38.1728897127775;
        Mon, 14 Oct 2024 02:12:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnnCmW/otcj2gQQZVhAW9woFCE4udOO76Y7RHXvuu8hpYM4Kp8213Cwui9o9/A0ZQF2FNuJw==
X-Received: by 2002:a17:907:9611:b0:a99:36ab:d843 with SMTP id a640c23a62f3a-a99b940ff26mr1050652366b.38.1728897127228;
        Mon, 14 Oct 2024 02:12:07 -0700 (PDT)
Received: from ?IPv6:2001:16b8:2d37:9800:1d57:78cf:c1ae:b0b3? (200116b82d3798001d5778cfc1aeb0b3.dip.versatel-1u1.de. [2001:16b8:2d37:9800:1d57:78cf:c1ae:b0b3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99f07c842csm290736366b.54.2024.10.14.02.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 02:12:06 -0700 (PDT)
Message-ID: <3515493a0d0dd8f1b7df5a5677042946325ea6a8.camel@redhat.com>
Subject: Re: [RFC PATCH 01/13] PCI: Prepare removing devres from pci_intx()
From: Philipp Stanner <pstanner@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 Sergey Shtylyov <s.shtylyov@omp.ru>, Basavaraj Natikar
 <basavaraj.natikar@amd.com>, Jiri Kosina <jikos@kernel.org>,  Benjamin
 Tissoires <bentiss@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Alex Dubov <oakad@yahoo.com>,
 Sudarsana Kalluru <skalluru@marvell.com>, Manish Chopra
 <manishc@marvell.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rasesh Mody <rmody@marvell.com>,
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
 <smostafa@google.com>, Hannes Reinecke <hare@suse.de>, John Garry
 <john.g.garry@oracle.com>, Soumya Negi <soumya.negi97@gmail.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Yi Liu <yi.l.liu@intel.com>, "Dr. David Alan
 Gilbert" <linux@treblig.org>, Christian Brauner <brauner@kernel.org>, Ankit
 Agrawal <ankita@nvidia.com>, Reinette Chatre <reinette.chatre@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Ye Bin <yebin10@huawei.com>, Marek
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
Date: Mon, 14 Oct 2024 11:12:03 +0200
In-Reply-To: <ZwktO8AUmFEakhVP@smile.fi.intel.com>
References: <20241009083519.10088-1-pstanner@redhat.com>
	 <20241009083519.10088-2-pstanner@redhat.com>
	 <ZwfnULv2myACxnVb@smile.fi.intel.com>
	 <f65e9fa01a1947782fc930876e5f84174408db67.camel@redhat.com>
	 <ZwktO8AUmFEakhVP@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-10-11 at 16:50 +0300, Andy Shevchenko wrote:
> On Fri, Oct 11, 2024 at 02:16:06PM +0200, Philipp Stanner wrote:
> > On Thu, 2024-10-10 at 17:40 +0300, Andy Shevchenko wrote:
> > > On Wed, Oct 09, 2024 at 10:35:07AM +0200, Philipp Stanner wrote:
> > > > pci_intx() is a hybrid function which sometimes performs devres
> > > > operations, depending on whether pcim_enable_device() has been
> > > > used
> > > > to
> > > > enable the pci_dev. This sometimes-managed nature of the
> > > > function
> > > > is
> > > > problematic. Notably, it causes the function to allocate under
> > > > some
> > > > circumstances which makes it unusable from interrupt context.
> > > >=20
> > > > To, ultimately, remove the hybrid nature from pci_intx(), it is
> > > > first
> > > > necessary to provide an always-managed and a never-managed
> > > > version
> > > > of that function. Then, all callers of pci_intx() can be ported
> > > > to
> > > > the
> > > > version they need, depending whether they use
> > > > pci_enable_device()
> > > > or
> > > > pcim_enable_device().
>=20
> > > > An always-managed function exists, namely pcim_intx(), for
> > > > which
> > > > __pcim_intx(), a never-managed version of pci_intx() had been
> > > > implemented.
> > >=20
> > > > Make __pcim_intx() a public function under the name
> > > > pci_intx_unmanaged(). Make pcim_intx() a public function.
>=20
> It seems I got confused by these two paragraphs. Why the double
> underscored
> function is even mentioned here?

It's mentioned because it's being moved.

>=20
> > > To avoid an additional churn we can make just completely new
> > > APIs,
> > > namely:
> > > pcim_int_x()
> > > pci_int_x()
> > >=20
> > > You won't need all dirty dances with double underscored function
> > > naming and
> > > renaming.
> >=20
> > =C3=84hm.. I can't follow. The new version doesn't use double
> > underscores
> > anymore. __pcim_intx() is being removed, effectively.
> > After this series, we'd end up with a clean:
> >=20
> > 	pci_intx() <-> pcim_intx()
> >=20
> > just as in the other PCI APIs.
>=20
> ...
>=20
> > > > +	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
> > > > +
> > > > +	if (enable)
> > > > +		new =3D pci_command & ~PCI_COMMAND_INTX_DISABLE;
> > > > +	else
> > > > +		new =3D pci_command | PCI_COMMAND_INTX_DISABLE;
> > > > +
> > > > +	if (new !=3D pci_command)
> > >=20
> > > I would use positive conditionals as easy to read (yes, a couple
> > > of
> > > lines
> > > longer, but also a win is the indentation and avoiding an
> > > additional
> > > churn in
> > > the future in case we need to add something in this branch.
> >=20
> > I can't follow. You mean:
> >=20
> > if (new =3D=3D pci_command)
> > =C2=A0=C2=A0=C2=A0 return;
> >=20
> > ?
> >=20
> > That's exactly the same level of indentation.
>=20
> No, the body gets one level off.
>=20
> > Plus, I just copied the code.
> >=20
> > > > +		pci_write_config_word(pdev, PCI_COMMAND, new);
>=20
> 	if (new =3D=3D pci_command)
> 		return;
>=20
> 	pci_write_config_word(pdev, PCI_COMMAND, new);
>=20
> See the difference?
> Also, imaging adding a new code in your case:
>=20
> 	if (new !=3D pci_command)
> 		pci_write_config_word(pdev, PCI_COMMAND, new);
>=20
> =3D=3D>
>=20
> 	if (new !=3D pci_command) {
> 		...foo...
> 		pci_write_config_word(pdev, PCI_COMMAND, new);
> 		...bar...
> 	}
>=20
> And in mine:
>=20
> 	if (new =3D=3D pci_command)
> 		return;
>=20
> 	...foo...
> 	pci_write_config_word(pdev, PCI_COMMAND, new);
> 	...bar...
>=20
> I hope it's clear now what I meant.

It is clear.. I'm not necessarily convinced that it's better to review
than just copying the pre-existing code, but if you really want it we
can do it I guess.

P.


