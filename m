Return-Path: <linux-pci+bounces-5538-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7451D8955D5
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 15:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A65EBB28D19
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 13:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BAB85260;
	Tue,  2 Apr 2024 13:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JxJJEnJt"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5631D84FCC
	for <linux-pci@vger.kernel.org>; Tue,  2 Apr 2024 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712065266; cv=none; b=WQ1y1A5EC8b4kmPf+dlXjyYISsv1z9bg6uQEOhbIB38FytX3C3w4qv0a4HY5CTxkLOLqbxw4OVtd6D3lZZsQWxwOta96hegPacR2jlQUXlF2QdPdTpQk/L2Pv0Asq4PL04TVa6Eq3b9pptk2LFd5+V0R2RuCRtL489chRE9aaYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712065266; c=relaxed/simple;
	bh=bLhC0nbwq22GNe56gDAASa+q7vHPfdzGoLdGaCOBqW4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NLYJU2hHFS/n48BIofOkG7Q9j8IrFVPGOQN9PV6uuencvAfIjw14dHV8w9fk59QhOI0VpCX0/roPlErhlg93v1qJsFYWW3YgJsk5420nmN/0QivBUfoXtxiPRJZJT/Ho6csl7IYOpz+1G/lk+QNLiIc7Yl5OlH5j//kU9Q/4lj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JxJJEnJt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712065263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bLhC0nbwq22GNe56gDAASa+q7vHPfdzGoLdGaCOBqW4=;
	b=JxJJEnJtGQyRV0ATynHp2HWGYE+V3EoMLtiM0Yiylit0IJ1W0a0FIqLdIOaZReLYfxDK84
	2Jq1FKsD8LvKd0lVM+by3smjEpRPZbetzPO9kGuKxpwxYVc9w5zm57yORu6x1qtajqq11T
	bRbMn2jIQcxiDn8yf2YPQkSIiaFn4t0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-6vZYVuXANwGcWTDZcYoNXA-1; Tue, 02 Apr 2024 09:41:01 -0400
X-MC-Unique: 6vZYVuXANwGcWTDZcYoNXA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-34370209778so126766f8f.1
        for <linux-pci@vger.kernel.org>; Tue, 02 Apr 2024 06:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712065260; x=1712670060;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bLhC0nbwq22GNe56gDAASa+q7vHPfdzGoLdGaCOBqW4=;
        b=qncLPIkIF8oLBTW73XTQAxi8q75prDyISNNrYmGTHqDLpOvqET9wnY/LfoqSGu1gQ3
         ajx0WC/n0/IFbW9U5oMaC0/Vlxhn6o5xybdzo/FvD8+6ye5CTxX3DLDrfQxqHdT60O4d
         h8Fj9MooFO3f1jQcpDqDVhQCp6JeWDaXOcWD853fBELMPGE16qubC2wbvs0xNS/+NnyX
         6ucCV+KNAbHi49sdOcLQfZiOztnM8pXqE19khEsfyIp5GipuFRbkcC/pdYiNJYQ+B4yg
         bF30AwOWGMD6daR6VBFv0+rKT+Dd9OS+nPtey6nGn5i4Ur7CgiJa2mrU7z+r6lUWu/yi
         pBaA==
X-Gm-Message-State: AOJu0Yz24YU+L3nD8JXQYn+IAYgoEmmzeOO6PddJujboKcJsPfHshrPc
	SPlNv6HWOHkPd3XWfVQeyomkvb7Stnc2Kv4GUQJ+6FtHUe2Rn4XwBVuVoqpuHat/r52N+rtKaJu
	TkhV9X4WXOxoynafz3geoAeKBrFiu0jb6o2/2OXowgHZ2ffZ+1Xr3q1bC/g==
X-Received: by 2002:adf:f810:0:b0:341:c58e:fba0 with SMTP id s16-20020adff810000000b00341c58efba0mr8694578wrp.4.1712065260599;
        Tue, 02 Apr 2024 06:41:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUZ+KFQdz5fyIiIaLpMcW2XZfx+7GjcB6NPAuyTy52H8wcP9rgqSuw4hZOdoAj2+rEnF5MOg==
X-Received: by 2002:adf:f810:0:b0:341:c58e:fba0 with SMTP id s16-20020adff810000000b00341c58efba0mr8694558wrp.4.1712065260190;
        Tue, 02 Apr 2024 06:41:00 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id p13-20020a5d48cd000000b003432d61d6b7sm14163445wrs.51.2024.04.02.06.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 06:40:59 -0700 (PDT)
Message-ID: <a893d61e125d58d8e6757c5f1a591682f6ca934c.camel@redhat.com>
Subject: Re: [PATCH 0/2] PCI: Add and use pcim_iomap_region()
From: Philipp Stanner <pstanner@redhat.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>,  Realtek linux nic maintainers
 <nic_swsd@realtek.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, David Miller
 <davem@davemloft.net>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"netdev@vger.kernel.org"
	 <netdev@vger.kernel.org>
Date: Tue, 02 Apr 2024 15:40:58 +0200
In-Reply-To: <348fa275-3922-4ad1-944e-0b5d1dd3cff5@gmail.com>
References: <982b02cb-a095-4131-84a7-24817ac68857@gmail.com>
	 <4cf0d7710a74095a14bedc68ba73612943683db4.camel@redhat.com>
	 <348fa275-3922-4ad1-944e-0b5d1dd3cff5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-03-28 at 18:35 +0100, Heiner Kallweit wrote:
> On 27.03.2024 14:20, Philipp Stanner wrote:
> > On Wed, 2024-03-27 at 12:52 +0100, Heiner Kallweit wrote:
> > > Several drivers use the following sequence for a single BAR:
> > > rc =3D pcim_iomap_regions(pdev, BIT(bar), name);
> > > if (rc)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error;
> > > addr =3D pcim_iomap_table(pdev)[bar];
> > >=20
> > > Let's create a simpler (from implementation and usage
> > > perspective)
> > > pcim_iomap_region() for this use case.
> >=20
> > I like that idea =E2=80=93 in fact, I liked it so much that I wrote tha=
t
> > myself, although it didn't make it vor v6.9 ^^
> >=20
> > You can look at the code here [1]
> >=20
> > Since my series cleans up the PCI devres API as much as possible,
> > I'd
> > argue that prefering it would be better.
> >=20
> Thanks for the hint. I'm not in a hurry, so yes: We should refactor
> the
> pcim API, and then add functionality.

Thx for the feedback so far. See my answers below:

>=20
> > But maybe you could do a review, since you're now also familiar
> > with
> > the code?
> >=20
> I'm not subscribed to linux-pci, so I missed the cover letter, but
> had a
> look at the patches in patchwork. Few remarks:
>=20
> Instead of first adding a lot of new stuff and then cleaning up, I'd
> propose to start with some cleanups. E.g. patch 7 could come first,
> this would already allow to remove member mwi from struct pci_devres.

I guess patches 5, 6, 7 and 8 could come first.
However, 9 has to be last because it kills the legacy struct pci_devres
in pci.h and can only do so once the old functions use the new API
below (patches 1, 2 and 4).
So one could say patches 5-9 form a row, aiming at blowing up that
struct, and relying on 1, 2 and 4 to do so.

>=20
> By the way, in patch 7 it may be a little simpler to have the
> following
> sequence:
>=20
> rc =3D pci_set_mwi()
> if (rc)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error
> rc =3D devm_add_action_or_reset(.., __pcim_clear_mwi, ..);
> if (rc)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error
>=20
> This would avoid the call to devm_remove_action().
>=20
> We briefly touched the point whether the proposed new function
> returns
> NULL or an ERR_PTR. I find it annoying that often the kernel doc
> function
> description doesn't mention whether a function returns NULL or an
> ERR_PTR
> in the error case.

All my functions' docstrings do explicitely name the return code. It's
indeed important to always do that except for super trivial things, I
agree

> So I have to look at the function code. It's also a
> typical bug source.
> We won't solve this in general here. But I think we should be in line
> with what related functions do.
> The iomap() functions typically return NULL in the error case.
> Therefore
> I'd say any new pcim_...iomap...() function should return NULL too.=20

Well, the thought behind it was that to be more verbose and precise is
better than absolute consistency.

I'd agree that we could go for pure NULL implementations for functions
that just ioremap(), but the more sophisticated PCI wrappers do several
things at once:
 * perform sanity (region ranges etc.) checks on user input
 * do region requests
 * iomap
 * do devres specific stuff, including allocations

Especially informing a user specifically about -EBUSY is very valuable
IMO. It certainly is for our use case (Nvidia graphics cards with
several 'competing' drivers) where several drivers could try to grab
the same BAR. A user should get the info "someone is using that thing
already". With NULL he'd just see "failed loading driver for some
reason".

So I think the bes thing would be to remain consistent *within* PCI,
since all PCI users should only ever use PCI functions anyways and not
ioremap() things manually.

So PCI should be as consistent as possible, I think. pcim_iomap()
unfortunately has 50 callers.
The cleanest way would be to port them to a pcim_iomap() that returns
an ERR_PTR(), but I don't have capacity for that right now.

>=20
> Then you add support for mapping BAR's partially. I never had such a
> use
> case. Are there use cases for this?

Yes (I was surprised by that as well). Patch #10's vboxvideo does that
and mapps a BAR partially.

The function pcim_iomap_region_range() just also takes care of a
partial region request. It could have been used as an alternative for
solving patch #10's issues.


> Maybe we could omit this for now, if it helps to reduce the
> complexity
> of the refactoring.
>=20
> I also have bisectability in mind, therefore my personal preference
> would
> be to make the single patches as small as possible. Not sure whether
> there's
> a way to reduce the size of what currently is the first patch of the
> series.

Well, the implementation is 100% based on common infrastructure that's
also used by pcim_iomap_region() (that would be enum
pcim_addr_devres_typ).

One could argue that as long as no one uses the function, it can cause
trouble =E2=80=93 and once someone uses it there would be a use case.
I tested the function previously and it behaved as intended.

But, indeed, I'm not sure whether it really hurts to remove or keep it.
I'm quite indifferent about it.

Regards,
P.

>=20
> > Greetings,
> > P.
> >=20
> > [1]
> > https://lore.kernel.org/all/20240301112959.21947-1-pstanner@redhat.com/
> >=20
> >=20
> > >=20
> > > Note: The check for !pci_resource_len() is included in
> > > pcim_iomap(), so we don't have to duplicate it.
> > >=20
> > > Make r8169 the first user of the new function.
> > >=20
> > > I'd prefer to handle this via the PCI tree.
> > >=20
> > > Heiner Kallweit (2):
> > > =C2=A0 PCI: Add pcim_iomap_region
> > > =C2=A0 r8169: use new function pcim_iomap_region()
> > >=20
> > > =C2=A0drivers/net/ethernet/realtek/r8169_main.c |=C2=A0 8 +++----
> > > =C2=A0drivers/pci/devres.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 28
> > > +++++++++++++++++++++++
> > > =C2=A0include/linux/pci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 2 ++
> > > =C2=A03 files changed, 33 insertions(+), 5 deletions(-)
> > >=20
> >=20
>=20
> Heiner
>=20


