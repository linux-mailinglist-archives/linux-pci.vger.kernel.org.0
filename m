Return-Path: <linux-pci+bounces-15929-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83639BAF9D
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 10:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7916A281277
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 09:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3080D1AD3F6;
	Mon,  4 Nov 2024 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P4oTpQDT"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875DA1AD3E1
	for <linux-pci@vger.kernel.org>; Mon,  4 Nov 2024 09:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730712430; cv=none; b=JL2ZEZJQBll4GzBTGjDKlwKTsp7TzYPB1ox7v7mfYQ+mb7cQWgHGDW1nFIpA/bi4Uky83m9OLCnrDoI92DiGkpWy5J9vfmCZJDAV94NGovKB9KmXNe+478MMdv1QAHYvR5UOGTYnvNSmSsAwBXZ0gl4oLCZyFCjwJzNrAzsbLMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730712430; c=relaxed/simple;
	bh=M7ueN/LQ529FLGouL/3BXVgrjx8tY87847WIrlhrom4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aj2VFHgtEfBbzXiKn31HxG805Qm38JjvCT8pZUc0x+UNw5P2Ct+3+H8tOHKRqUBYNEktXJt692iuOOTAfUJRewt46e3AzaePL602Su67KK+1MnYFWdnZYEntkEJ4advfqUffeqaWReCVwVYWrFLt811u7QrI3fAnKL1xkDsmybg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P4oTpQDT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730712427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M7ueN/LQ529FLGouL/3BXVgrjx8tY87847WIrlhrom4=;
	b=P4oTpQDT3SUDo7PLT3J+OqKSEdeXl1oHmENBGzFs7E2+l9ujudNdadnwEd57RX2AVAVVqL
	rRA77ZsIVR3oqyJuvY3dpmItA+Bm0auhyqzRShm/rfBACh5k15p49CspwMayaEdEDZmoPN
	mV+slHht4hl+pLtsRcvg+g6BCHbCcjk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-d2lW0AI2Ok6Hl5pWyCQV_A-1; Mon, 04 Nov 2024 04:27:06 -0500
X-MC-Unique: d2lW0AI2Ok6Hl5pWyCQV_A-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d5a3afa84so1946332f8f.3
        for <linux-pci@vger.kernel.org>; Mon, 04 Nov 2024 01:27:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730712425; x=1731317225;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M7ueN/LQ529FLGouL/3BXVgrjx8tY87847WIrlhrom4=;
        b=ifOAMpwD+ZwasM6fwRxUsgosnj5WuCKe4ZexbQSqu8RxXG1SPpsf3PmUN/3B8HU9DL
         YVd0yKqaSXPFxXaHbakFqaZLEIZwpekxhpUiJQOjyAcVIAolbOyRleNmxDxBThJUYP/v
         D+kmbTpwtZtt8Cvy4Ynem6JbR6uuFZgbpDxRefJuzNTrSGDsAx10MI0zKeG2epsEc4wz
         lD0zlyklzQPXVDKPvX5ex8L77gH2V56DrJBF7R5UTwwHw3SMHaZigo2GJFku/hE/UOq1
         Pwoipa+Gn2DIfPxYSViJrTWnY5pOCFzLzllONYQfRBFTmWLyeBrxcF5kdDGwW6J9zdTi
         HM5w==
X-Forwarded-Encrypted: i=1; AJvYcCV3JCy1SjMXKZmdWP2lcS5tB3RbkRnG7So8nKYtToDqHxZyQ9Krrb73kXNvS7kKEXtWne98ti+25VY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSAW4zlYSGhiQOIEEi6ToAPcO6Aig1pepSSdzcnmnY/8iaLPop
	dSnXyu5zyAlTpMWhZ5SmUDWpdUilwPyMH4EegWwyabmycc+rde9hMHyhnV+/UgudHC/iUGx2lSN
	gyMHLJtbXgqgCU0TpldTVdF3EG0hdQioehiv6LxqXcpT6nXF8VwwKCox9YQ==
X-Received: by 2002:a5d:5f54:0:b0:37d:373c:ed24 with SMTP id ffacd0b85a97d-381c7a3a49cmr8192681f8f.4.1730712414711;
        Mon, 04 Nov 2024 01:26:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUG4i3r4RT/0mDz+U1cY7m40dZcu2ijC6eEouX1uNQBldOHTZd5hoduIq2TUsnjYO3wLrnew==
X-Received: by 2002:a5d:5f54:0:b0:37d:373c:ed24 with SMTP id ffacd0b85a97d-381c7a3a49cmr8192628f8f.4.1730712414212;
        Mon, 04 Nov 2024 01:26:54 -0800 (PST)
Received: from ?IPv6:2001:16b8:2d7f:e400:7f8:722c:bb2e:bb7f? (200116b82d7fe40007f8722cbb2ebb7f.dip.versatel-1u1.de. [2001:16b8:2d7f:e400:7f8:722c:bb2e:bb7f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7d20sm12817150f8f.7.2024.11.04.01.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 01:26:53 -0800 (PST)
Message-ID: <a8d9f32f60f55c58d79943c4409b8b94535ff853.camel@redhat.com>
Subject: Re: [PATCH 01/13] PCI: Prepare removing devres from pci_intx()
From: Philipp Stanner <pstanner@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>, Damien Le Moal
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
 Iwai <tiwai@suse.com>, Chen Ni <nichen@iscas.ac.cn>, Mario Limonciello
 <mario.limonciello@amd.com>, Ricky Wu <ricky_wu@realtek.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Breno Leitao <leitao@debian.org>, Kevin Tian
 <kevin.tian@intel.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Mostafa Saleh <smostafa@google.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Yi Liu <yi.l.liu@intel.com>, Christian
 Brauner <brauner@kernel.org>, Ankit Agrawal <ankita@nvidia.com>, Eric Auger
 <eric.auger@redhat.com>, Reinette Chatre <reinette.chatre@intel.com>, Ye
 Bin <yebin10@huawei.com>, Marek =?ISO-8859-1?Q?Marczykowski-G=F3recki?=
 <marmarek@invisiblethingslab.com>, Pierre-Louis Bossart
 <pierre-louis.bossart@linux.dev>, Peter Ujfalusi
 <peter.ujfalusi@linux.intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Kai Vehmanen
 <kai.vehmanen@linux.intel.com>,  Rui Salvaterra <rsalvaterra@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, netdev@vger.kernel.org, 
 linux-wireless@vger.kernel.org, ntb@lists.linux.dev,
 linux-pci@vger.kernel.org,  kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-sound@vger.kernel.org
Date: Mon, 04 Nov 2024 10:26:51 +0100
In-Reply-To: <87cyjgwfmo.ffs@tglx>
References: <20241015185124.64726-1-pstanner@redhat.com>
	 <20241015185124.64726-2-pstanner@redhat.com> <87cyjgwfmo.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-31 at 14:45 +0100, Thomas Gleixner wrote:
> On Tue, Oct 15 2024 at 20:51, Philipp Stanner wrote:
> > +/**
> > + * pci_intx - enables/disables PCI INTx for device dev, unmanaged
> > version
>=20
> mismatch vs. actual function name.

ACK, will fix

>=20
> > + * @pdev: the PCI device to operate on
> > + * @enable: boolean: whether to enable or disable PCI INTx
> > + *
> > + * Enables/disables PCI INTx for device @pdev
> > + *
> > + * This function behavios identically to pci_intx(), but is never
> > managed with
> > + * devres.
> > + */
> > +void pci_intx_unmanaged(struct pci_dev *pdev, int enable)
>=20
> This is a misnomer. The function controls the INTX_DISABLE bit of a
> PCI device. Something like this:
>=20
> void __pci_intx_control()
> {
> }
>=20
> static inline void pci_intx_enable(d)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __pci_intx_control(d, true);
> }
>=20
> .....
>=20
> makes it entirely clear what this is about.

Well, I would agree if it were about writing a 'real' new function. But
this is actually about creating a _temporary_ function which is added
here and removed again in patch 12 of this same series.

It wouldn't even be needed; the only reason why it exists is to make it
easy for the driver maintainers concerned by patches 2-11 to review the
change and understand what's going on. Hence it is
"pci_intx_unmanaged()" =3D=3D "Attention, we take automatic management away
from your driver"

pci_intx() is then fully restored after patch 12 and it keeps its old
name.

Gr=C3=BC=C3=9Fe,
Philipp


>=20
> Hmm?
>=20
> Thanks,
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tglx
>=20


