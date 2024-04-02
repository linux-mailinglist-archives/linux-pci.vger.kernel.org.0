Return-Path: <linux-pci+bounces-5541-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D34C895653
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 16:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FF501C22BA0
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 14:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2F074262;
	Tue,  2 Apr 2024 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BQ8VxdzJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D9585268
	for <linux-pci@vger.kernel.org>; Tue,  2 Apr 2024 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712067085; cv=none; b=HKOCKfPAp/mmroVoHyP5Fpy/oiZ9eGKsEmJQL0Wl8kkXwpK9ZoTRSLDmIXNxatnNhOaPLNRPbU/NK3nnOI1T8btFOdx2tsfD+J4QQNpU9sqHGAQHwscRAsyaiaPZ65m0/+4vghVKB++UUsqt4+x7vD/vKa63Gjv8uKslYW6Kdcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712067085; c=relaxed/simple;
	bh=wUFzHeEcaMcD3D55Fr06URpXnNXE3mmghBXvFWBUI9o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fvh3dq9owCg1PJEjyutchTWesDNqy0SmbrFm0fHD5+iAZ2RUJlBPEoYUc1l83utETfGP83wShkKgqn5SXL0P1RYvlMY0JAEguH4QKKfjuKHWHQWcCwCsSqNSKnuzEFMvZUSFSqk2a7u6ibCKaZAmmCPBDrcvInXMcDY/Xu3qNJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BQ8VxdzJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712067082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B5eqEvJU0n3cPtoAn2FvL1nyZ89oK0H+CV/UfPwmYV4=;
	b=BQ8VxdzJuBcAj3pUwZhiVsWEXnt7XTyi+1PrlJkESdF0jPGd5jlWo+3W4/xeRaOL2Y5DRG
	HqY0/VxMVY/fxv+hAG8JwK03311BQY+L+avng9inut/3DSviU6g+2oqUdLYhLGm8CXTGj3
	VWUQ7xn0FL+F8bwpCFVngNJ4+62LjuE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-XLb6lPJYM1WltRd7UhpoIQ-1; Tue, 02 Apr 2024 10:11:21 -0400
X-MC-Unique: XLb6lPJYM1WltRd7UhpoIQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3436fab808aso141254f8f.0
        for <linux-pci@vger.kernel.org>; Tue, 02 Apr 2024 07:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712067080; x=1712671880;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B5eqEvJU0n3cPtoAn2FvL1nyZ89oK0H+CV/UfPwmYV4=;
        b=aTQ6igBcrah6GAxDcF8ZNeHzAbygsYwZOfVTrctmKDNZJKC7UQ+XyTXEizIs+Pq4hu
         jTgYrriNBxx5SVbNJdAtj09CVYMeCw4+i+bUheNoDwG4rjLe24chhArKwyw7dBL2FECn
         D60FIn7GMMF3QYeWqcDoFvbWgeqIfyRZDtb2HJrOxqODpk84bRP91tfYsJQyFpYpkNG1
         amT8VsmSP+zYcJ8M9Zr2FHw18r9AX24n3PePZR7nEmPpk/g9w6nETZ+ECNLuPC3DAOmf
         B2gm0PsZ21lEEDM0wtzpb9/k7hbFg0DrM0Cj9jM8o86kdf3i0V0v0IeLSqiMLdktZCIP
         ihyg==
X-Gm-Message-State: AOJu0YwcKsmkfDqghLIrFEdxl4umF1Me6MF4898nyedsIr3WuUA2fEcf
	8QSwiUN4mrlvT3hG5Sr10+ZcnwXIfuxteV2kYOrkxZeG8Dqb/5ilyC/Dz/hFgZIAFLNYdZegY/P
	ciN9iNeY+SW9Iy97u2a59VZ2yroGd/kPee6PcAuCMMtbw2+1NTEmTg/aopQ==
X-Received: by 2002:a05:600c:1d24:b0:415:6725:f9be with SMTP id l36-20020a05600c1d2400b004156725f9bemr3633015wms.0.1712067080289;
        Tue, 02 Apr 2024 07:11:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZle0g/UFFZBK6MAx9uOTm9SXWNxzs4YP5onSHg+W8FvLfi8HuZqfuTRsrvJshkYtze4S70A==
X-Received: by 2002:a05:600c:1d24:b0:415:6725:f9be with SMTP id l36-20020a05600c1d2400b004156725f9bemr3633006wms.0.1712067079905;
        Tue, 02 Apr 2024 07:11:19 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id r11-20020a05600c35cb00b004149530aa97sm18225378wmq.10.2024.04.02.07.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 07:11:19 -0700 (PDT)
Message-ID: <dada4d02089cc2e60a7de04970aeb0327dec7059.camel@redhat.com>
Subject: Re: [PATCH 0/2] PCI: Add and use pcim_iomap_region()
From: Philipp Stanner <pstanner@redhat.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Tue, 02 Apr 2024 16:11:18 +0200
In-Reply-To: <38eb4bed-f2e9-4e3e-993b-78da54bf988e@gmail.com>
References: <982b02cb-a095-4131-84a7-24817ac68857@gmail.com>
	 <4cf0d7710a74095a14bedc68ba73612943683db4.camel@redhat.com>
	 <348fa275-3922-4ad1-944e-0b5d1dd3cff5@gmail.com>
	 <7af7182d-0f14-4111-b0c4-b57d2d24edd9@gmail.com>
	 <a0d0b6b1269babb6a8f4e3bcceafee87bb49dcd1.camel@redhat.com>
	 <38eb4bed-f2e9-4e3e-993b-78da54bf988e@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-04-02 at 15:54 +0200, Heiner Kallweit wrote:
> On 02.04.2024 15:17, Philipp Stanner wrote:
> > On Thu, 2024-03-28 at 23:03 +0100, Heiner Kallweit wrote:
> > > On 28.03.2024 18:35, Heiner Kallweit wrote:
> > > > On 27.03.2024 14:20, Philipp Stanner wrote:
> > > > > On Wed, 2024-03-27 at 12:52 +0100, Heiner Kallweit wrote:
> > > > > > Several drivers use the following sequence for a single
> > > > > > BAR:
> > > > > > rc =3D pcim_iomap_regions(pdev, BIT(bar), name);
> > > > > > if (rc)
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error;
> > > > > > addr =3D pcim_iomap_table(pdev)[bar];
> > > > > >=20
> > > > > > Let's create a simpler (from implementation and usage
> > > > > > perspective)
> > > > > > pcim_iomap_region() for this use case.
> > > > >=20
> > > > > I like that idea =E2=80=93 in fact, I liked it so much that I wro=
te
> > > > > that
> > > > > myself, although it didn't make it vor v6.9 ^^
> > > > >=20
> > > > > You can look at the code here [1]
> > > > >=20
> > > > > Since my series cleans up the PCI devres API as much as
> > > > > possible,
> > > > > I'd
> > > > > argue that prefering it would be better.
> > > > >=20
> > > > Thanks for the hint. I'm not in a hurry, so yes: We should
> > > > refactor
> > > > the
> > > > pcim API, and then add functionality.
> > > >=20
> > > > > But maybe you could do a review, since you're now also
> > > > > familiar
> > > > > with
> > > > > the code?
> > > > >=20
> > > > I'm not subscribed to linux-pci, so I missed the cover letter,
> > > > but
> > > > had a
> > > > look at the patches in patchwork. Few remarks:
> > > >=20
> > > > Instead of first adding a lot of new stuff and then cleaning
> > > > up,
> > > > I'd
> > > > propose to start with some cleanups. E.g. patch 7 could come
> > > > first,
> > > > this would already allow to remove member mwi from struct
> > > > pci_devres.
> > > >=20
> > > When looking at the intx members of struct pci_devres:
> > > Why not simply store the initial state of bit
> > > PCI_COMMAND_INTX_DISABLE
> > > in struct pci_dev and restore this bit in
> > > do_pci_disable_device()?
> > > This should allow us to get rid of these members.
> >=20
> > Those members have been there before I touched anything.
> > Patch #8 removes them entirely, so I'd say that result has been
> > achieved.
> >=20
>=20
> - all the networking people because discussion is solely about PCI
> core now
>=20
> I think the proposed pcim_intx() is more complex than needed,

It is complex =E2=80=93 but that complexity has been there before. It's jus=
t
moved from pci.c to devres.c and gets coupled with devres.

Note that it's very hard to clean up the PCI devres API because it's
ossificated and used everywhere. That's why several hybrid functions in
pci.c get redirected to devres.c, including pci_intx().

>  and I see
> issues if it's called multiple times.

Which issues would that be?

If I implemented everything correctly (please say if I didn't), then a
driver using pcim_enable_device() + pci_intx() (without 'm') will
experience exactly the same behavior as before.

If pcim_intx() is buggy or problematic, it only is because pci_intx()
has always been that way.

So this would be bug-for-bug-compatible.
pci_intx() and pcim_intx() should be removed in the long term.

> In addition you state that pci_intx()
> is outdated, but add an API call for the same functionality.

I do that because that's the only way to kill struct pci_devres in
pci.h.
Take a look at the current implementation of pci_intx(). This is a
hybrid function. We can not just remove the devres part because we'd
break backwards compatiblity.

And, on Andy Shevchenko's request, the pcim_intx() call is not exposed
to users. It's just visible within the subsystem, to maintain
pci_intx()'s hybrid nature while being.

We could add a more detailed comment explaining the reasoning, if you
think that's worthwhile.

>=20
> Did you see the RFC patches I sent? they could help to reduce the
> complexity
> of the pcim refactoring.

Nope. Do you have a pointer?


P.

>=20
> > Besides, considering the current fragmentation of devres within the
> > PCI
> > subsystem, I think it's wise to do 100% of devres operations in
> > devres.c
> >=20
> > P.
> >=20
> > >=20
> > > > By the way, in patch 7 it may be a little simpler to have the
> > > > following
> > > > sequence:
> > > >=20
> > > > rc =3D pci_set_mwi()
> > > > if (rc)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error
> > > > rc =3D devm_add_action_or_reset(.., __pcim_clear_mwi, ..);
> > > > if (rc)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error
> > > >=20
> > > > This would avoid the call to devm_remove_action().
> > > >=20
> > > > We briefly touched the point whether the proposed new function
> > > > returns
> > > > NULL or an ERR_PTR. I find it annoying that often the kernel
> > > > doc
> > > > function
> > > > description doesn't mention whether a function returns NULL or
> > > > an
> > > > ERR_PTR
> > > > in the error case. So I have to look at the function code. It's
> > > > also a
> > > > typical bug source.
> > > > We won't solve this in general here. But I think we should be
> > > > in
> > > > line
> > > > with what related functions do.
> > > > The iomap() functions typically return NULL in the error case.
> > > > Therefore
> > > > I'd say any new pcim_...iomap...() function should return NULL
> > > > too.
> > > >=20
> > > > Then you add support for mapping BAR's partially. I never had
> > > > such
> > > > a use
> > > > case. Are there use cases for this?
> > > > Maybe we could omit this for now, if it helps to reduce the
> > > > complexity
> > > > of the refactoring.
> > > >=20
> > > > I also have bisectability in mind, therefore my personal
> > > > preference
> > > > would
> > > > be to make the single patches as small as possible. Not sure
> > > > whether there's
> > > > a way to reduce the size of what currently is the first patch
> > > > of
> > > > the series.
> > > >=20
> > > > > Greetings,
> > > > > P.
> > > > >=20
> > > > > [1]
> > > > > https://lore.kernel.org/all/20240301112959.21947-1-pstanner@redha=
t.com/
> > > > >=20
> > > > >=20
> > > > > >=20
> > > > > > Note: The check for !pci_resource_len() is included in
> > > > > > pcim_iomap(), so we don't have to duplicate it.
> > > > > >=20
> > > > > > Make r8169 the first user of the new function.
> > > > > >=20
> > > > > > I'd prefer to handle this via the PCI tree.
> > > > > >=20
> > > > > > Heiner Kallweit (2):
> > > > > > =C2=A0 PCI: Add pcim_iomap_region
> > > > > > =C2=A0 r8169: use new function pcim_iomap_region()
> > > > > >=20
> > > > > > =C2=A0drivers/net/ethernet/realtek/r8169_main.c |=C2=A0 8 +++--=
--
> > > > > > =C2=A0drivers/pci/devres.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 28
> > > > > > +++++++++++++++++++++++
> > > > > > =C2=A0include/linux/pci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
> > > > > > =C2=A03 files changed, 33 insertions(+), 5 deletions(-)
> > > > > >=20
> > > > >=20
> > > >=20
> > > > Heiner
> > >=20
> >=20
>=20


