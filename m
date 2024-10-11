Return-Path: <linux-pci+bounces-14292-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA3799A363
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 14:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6DAD1F25809
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 12:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20122141C6;
	Fri, 11 Oct 2024 12:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Prh5z9Ch"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3644721790C
	for <linux-pci@vger.kernel.org>; Fri, 11 Oct 2024 12:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648476; cv=none; b=riKk29Sj6C6QDd6j1jNA/u3XvhavHCpVDjLybV9pm4qphBzodK82LUvnur1JLJJlsZDoqv0x4+LWyklwXCtliUm+9N49QwatFTx5KciWwFP+Hic9audd28VX0oLDhcIdl6/PjMnZJlbcPi5LhTVh3H+eq4rHvHpnahaDnf3/zLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648476; c=relaxed/simple;
	bh=MwKBr4MW13REKEdZEAqTL7D+rRGFsGjM7n9xGoHUCEw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PQuwDTr8Cg088WiAk4Oyp3LLz4MyzrTfIMYSBzEdaLHTdANiFXwPrEs9r3DJ9tZmzv8rnZDesr3RPmbc93vTuRtCZ2c64PdUbki3XNXxPVf0/XqWX/MuVx1GREk6IXmhLJV67bjmWQW67Q1T6fBKRA5yMErHbOnDhcRTkNMYqyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Prh5z9Ch; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728648474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MwKBr4MW13REKEdZEAqTL7D+rRGFsGjM7n9xGoHUCEw=;
	b=Prh5z9Ch4Obg+vN9I0GUDr9uLmOGW5i1k9JsPMtpIOOEVIC8RHQAeNTH44HLR4LtC0lxKa
	CAWpDlWvHpa6C+/1JDeBO5ISRvIbK5a/AySAO8siZdJVhFjDZA7QtU9swzHoHdkLURlnDD
	dLfysmvU2ftmf6Q4Nso3HR1IWWhl4Qc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-OCnZ848ePPizmZD--fBxCA-1; Fri, 11 Oct 2024 08:07:53 -0400
X-MC-Unique: OCnZ848ePPizmZD--fBxCA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb0b0514bso12204255e9.1
        for <linux-pci@vger.kernel.org>; Fri, 11 Oct 2024 05:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728648472; x=1729253272;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MwKBr4MW13REKEdZEAqTL7D+rRGFsGjM7n9xGoHUCEw=;
        b=Xhbu75J/sFvkFyxYVPgJTNWYGfxwFGnmoooRAcrM/e61RsMiGCTLOAZiTkpblhQHiU
         o1gPts5YM5i8qtxC1thBTYYvGMWj1vdjLoNhQOwxkwk8PQK+jSQaVUUtIAoKGud3eZAW
         /yPGAo8oUtxr2UdLaRM+CgUUPUElQXgGQTQ68vMmkXdQHyK/1W6mZU3PmpxrbPfpSaaj
         1+UCoOOdCEm5Bjz8Fwfz3vKFhLnJc+BRvasus+1RpWvN7mqcABqjbwPLWqblfEPDxA6i
         rF6gXBLHBiasxFlayC4aDgXCVhyvUkibgx3NgLQmzQg/mZJpvwzaqHgRj8TOgKa0hRxZ
         UhxA==
X-Forwarded-Encrypted: i=1; AJvYcCV7jK9DIa0lx15geZYJdice0arH+/hAlfDjCkFtmoRbBCHibiEVrKMcnccRNAQAlE6jSHh0pHOuaI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkKHonkY893e02nwipVz1Eo3gM/M8wMPXOU5BEMg9BzFY9bG7f
	v52SOwUW118jQCqy16nDRr/LouNciN8E6xrQDaZLtYKlAe+BTTxktLkBxv/scR5LF24FBpprXx+
	YUNo20CQ68M5EWYr5dgoKQAsRURjanpuqgiklwDim5QP2tBHODXGtMHJxrw==
X-Received: by 2002:a05:600c:1d26:b0:42f:75cd:2566 with SMTP id 5b1f17b1804b1-4311deaea05mr17632025e9.2.1728648472014;
        Fri, 11 Oct 2024 05:07:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfafWJbYY7XgafIoUBODjA0mqAG0Im27BYfV9oETn5/NEqgGUi/qx3b+BLDWe06kqudkM50g==
X-Received: by 2002:a05:600c:1d26:b0:42f:75cd:2566 with SMTP id 5b1f17b1804b1-4311deaea05mr17631395e9.2.1728648471511;
        Fri, 11 Oct 2024 05:07:51 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3d05:4700:3e59:7d70:cabd:144b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182d7929sm40692135e9.4.2024.10.11.05.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 05:07:50 -0700 (PDT)
Message-ID: <a688a4109e292d7510ebd7206bd3296e23ca1e3b.camel@redhat.com>
Subject: Re: [RFC PATCH 13/13] Remove devres from pci_intx()
From: Philipp Stanner <pstanner@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Damien Le Moal
 <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, Sergey Shtylyov
 <s.shtylyov@omp.ru>, Basavaraj Natikar <basavaraj.natikar@amd.com>, Jiri
 Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alex Dubov <oakad@yahoo.com>, Sudarsana Kalluru <skalluru@marvell.com>,
 Manish Chopra <manishc@marvell.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rasesh Mody
 <rmody@marvell.com>,  GR-Linux-NIC-Dev@marvell.com, Igor Mitsyanko
 <imitsyanko@quantenna.com>,  Sergey Matyukevich <geomatsi@gmail.com>, Kalle
 Valo <kvalo@kernel.org>, Sanjay R Mehta <sanju.mehta@amd.com>, Shyam Sundar
 S K <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang
 <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini
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
Date: Fri, 11 Oct 2024 14:07:48 +0200
In-Reply-To: <20241010114314.296db535.alex.williamson@redhat.com>
References: <20241009083519.10088-1-pstanner@redhat.com>
	 <20241009083519.10088-14-pstanner@redhat.com>
	 <7f624c83-115b-4045-b068-0813a18c8200@stanley.mountain>
	 <f42bb5de4c9aca307a3431dd15ace4c9cade1cb9.camel@redhat.com>
	 <20241010114314.296db535.alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-10 at 11:43 -0600, Alex Williamson wrote:
> On Thu, 10 Oct 2024 11:11:36 +0200
> Philipp Stanner <pstanner@redhat.com> wrote:
>=20
> > On Thu, 2024-10-10 at 11:50 +0300, Dan Carpenter wrote:
> > > On Wed, Oct 09, 2024 at 10:35:19AM +0200, Philipp Stanner wrote:=C2=
=A0
> > > > pci_intx() is a hybrid function which can sometimes be managed
> > > > through
> > > > devres. This hybrid nature is undesirable.
> > > >=20
> > > > Since all users of pci_intx() have by now been ported either to
> > > > always-managed pcim_intx() or never-managed
> > > > pci_intx_unmanaged(),
> > > > the
> > > > devres functionality can be removed from pci_intx().
> > > >=20
> > > > Consequently, pci_intx_unmanaged() is now redundant, because
> > > > pci_intx()
> > > > itself is now unmanaged.
> > > >=20
> > > > Remove the devres functionality from pci_intx(). Remove
> > > > pci_intx_unmanaged().
> > > > Have all users of pci_intx_unmanaged() call pci_intx().
> > > >=20
> > > > Signed-off-by: Philipp Stanner <pstanner@redhat.com>=C2=A0=20
> > >=20
> > > I don't like when we change a function like this but it still
> > > compiles fine.
> > > If someone is working on a driver and hasn't pushed it yet, then
> > > it's
> > > probably
> > > supposed to be using the new pcim_intx() but they won't discover
> > > that
> > > until they
> > > detect the leaks at runtime.=C2=A0=20
> >=20
> > There wouldn't be any *leaks*, it's just that the INTx state would
> > not
> > automatically be restored. BTW the official documentation in its
> > current state does not hint at pci_intx() doing anything
> > automatically,
> > but rather actively marks it as deprecated.
> >=20
> > But you are right that a hypothetical new driver and OOT drivers
> > could
> > experience bugs through this change.
> >=20
> > >=20
> > > Why not leave the pci_intx_unmanaged() name.=C2=A0 It's ugly and that
> > > will
> > > discorage
> > > people from introducing new uses.=C2=A0=20
> >=20
> > I'd be OK with that. Then we'd have to remove pci_intx() as it has
> > new
> > users anymore.
> >=20
> > Either way should be fine and keep the behavior for existing
> > drivers
> > identical.
> >=20
> > I think Bjorn should express a preference
>=20
> FWIW, I think pcim_intx() and pci_intx() align better to our naming
> convention for devres interfaces.

Yup, also my personal preference. But we can mark those functions as
deprecated via docstring-comment. That should fullfill Damien's goal.

> =C2=A0 Would it be sufficient if pci_intx()
> triggered a WARN_ON if called for a pci_is_managed() device?

No, I don't think that's a good idea; reason being that
pci_is_managed() just checks that global boolean which we inherited
from the old implementation and which should not be necessary with
proper devres.
The boolean is used for making functions such as pci_intx() and
__pci_request_region() hybrid. So with our non-hybrid version we never
need it.

P.

> =C2=A0 Thanks,
>=20
> Alex
>=20


