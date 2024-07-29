Return-Path: <linux-pci+bounces-10974-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E978393F9CB
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 17:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 774FE1F22F6D
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 15:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44918004F;
	Mon, 29 Jul 2024 15:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="izW7cAvx"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CA44A0A
	for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 15:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267953; cv=none; b=EV1Va87nocs6fIFgJ564mcgGMIa/DywzZKKB/OtMLdQav9O6YD0X5fk5BZCn+IcDTRMboITL25QiAB5t209njir9YAcYsayy5jDgomhcQQkVSyOLD5tdABii70SiNbK+fFRy7tMwZeLWyuefaDAzcO3toUibsvp2imqYXXmpwm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267953; c=relaxed/simple;
	bh=JxgZ3Ifg/PSxDq6OtaagWOlp0rxC7nXSKFXCSKD/qVI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TS4KcpT7XUyj7HdSuIJ2nVVWALPUNl2yqWa5QxCOepVZUAfGktZqmv29M5rvLprMhI8Xr6Iky8uqB6W40RVtBzAM2eBB/jeu4wPLDBlZamrPatKvhcjVrdDFWhuerIKk/vE8yF4x8smc9y3npKhWq32zOZpjKctfIqV7X01hcBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=izW7cAvx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722267951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JxgZ3Ifg/PSxDq6OtaagWOlp0rxC7nXSKFXCSKD/qVI=;
	b=izW7cAvxxbDxj84tPLTi4oFCwBVBIXFflBvabnJZGsd39Ktpj+HTFrBlMMMmvl0cIRQKYJ
	TUaiaywqEMBDTCnE9dunBhv9tRNuwsCUy9yEfau3H2f0HPTdqyhiXBy9vk+RcNv1EUUtkt
	rQOVdoU4Gk5gVYvG49ogZA1LSZDY+x8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-u8T61zG1Mx2FToKhPw2maw-1; Mon, 29 Jul 2024 11:45:49 -0400
X-MC-Unique: u8T61zG1Mx2FToKhPw2maw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4280abe7c02so4751295e9.3
        for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 08:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722267948; x=1722872748;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JxgZ3Ifg/PSxDq6OtaagWOlp0rxC7nXSKFXCSKD/qVI=;
        b=dFg5boD9CrF/FgDcC6yQuCZV4te38Vr87favfd8owKpRpsopJY28TztEgyzofQlX6d
         4JtJL5X1iiGbf1jh45SpuP5rxAd/rbl90nNi3F/rZHpD25cFTid/gzg2NHxoKYsgEP2y
         Zfo72uKOTrfdFFYT9eVdMuqRA2wUOARk5co0NAu4OyvCmgJ8Ndc6B5HaF6IdcElppLJO
         CyBLgIBEwE5Jr+C0wMBwVIUKJWeHFffqZI0yTGw2URAAlrJmbOSUmFToi9UQNJiCTcYl
         i4AX2c5lxL07TZNQuTSE90chUNsmQjDYOBMkYqTDLz9sAZhJrBd/++JG7r2D+666EUtt
         w4ng==
X-Gm-Message-State: AOJu0Yy6aIFJron/S4Su5VejpQ56cGDq5Wg97oOvgXmCLvs8A99+YOmk
	TiWp6SJvV8r1Vme45+c6Ucw+zo26UrEH4Z3DEAGBUu6BX4+raHcpY0weA2wEwFHdjuUKzrN+XTM
	7y7U48gqvaNnYhPhsO99wQK3VgLxcdcntGHZRpNkc+3HvnI6DxYmOBvU7SA==
X-Received: by 2002:a05:600c:1c99:b0:427:9f6c:e4bc with SMTP id 5b1f17b1804b1-4280570b81emr62730175e9.5.1722267948136;
        Mon, 29 Jul 2024 08:45:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfKo6gmKRB6oJviMGyggbkl9dDIA1Vm2eC8aDPIJNF7i/+EJ13QdeIo1kTM34oikvl0PCezw==
X-Received: by 2002:a05:600c:1c99:b0:427:9f6c:e4bc with SMTP id 5b1f17b1804b1-4280570b81emr62730065e9.5.1722267947463;
        Mon, 29 Jul 2024 08:45:47 -0700 (PDT)
Received: from dhcp-64-164.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427fb7bdfa0sm213434375e9.14.2024.07.29.08.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 08:45:47 -0700 (PDT)
Message-ID: <b23b0f84c7895c8c0029423bbc3f402c103d9ea4.camel@redhat.com>
Subject: Re: [PATCH] PCI: Fix devres regression in pci_intx()
From: Philipp Stanner <pstanner@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>,  Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 29 Jul 2024 17:45:46 +0200
In-Reply-To: <d4bb01e9-0293-4d6a-a2c1-3d37b3a368ca@kernel.org>
References: <20240725120729.59788-2-pstanner@redhat.com>
	 <6ce4c9f4-7c75-4451-8c6f-fe3d6a3dd913@kernel.org>
	 <ee44ea7ac760e73edad3f20b30b4d2fff66c1a85.camel@redhat.com>
	 <d4bb01e9-0293-4d6a-a2c1-3d37b3a368ca@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-29 at 20:29 +0900, Damien Le Moal wrote:
> On 7/27/24 03:43, pstanner@redhat.com=C2=A0wrote:
> > > That said, I do not see that as an issue in itself. What I fail
> > > to
> > > understand
> > > though is why that intx devres is not deleted on device teardown.
> > > I
> > > think this
> > > may have something to do with the fact that pcim_intx() always
> > > does
> > > "res->orig_intx =3D !enable;", that is, it assumes that if there is
> > > a
> > > call to
> > > pcim_intx(dev, 0), then it is because intx where enabled already,
> > > which I do not
> > > think is true for most drivers... So we endup with INTX being
> > > wrongly
> > > enabled on
> > > device teardown by pcim_intx_restore(), and because of that, the
> > > intx
> > > resource
> > > is not deleted ?
> >=20
> > Spoiler: The device resources that have initially been created do
> > get
> > deleted. Devres works as intended. The issue is that the forces of
> > evil
> > invoke pci_intx() through another path, hidden behind an API,
> > through
> > another devres callback.
> >=20
> > So the device resource never gets deleated because it is *created*
> > on
> > driver detach, when devres already ran.
>=20
> That explains the issue :)
>=20
> > > Re-enabling intx on teardown is wrong I think, but that still
> > > does
> > > not explain
> > > why that resource is not deleted. I fail to see why.
> >=20
> > You came very close to the truth ;)
> >=20
> > With some help from my favorite coworker I did some tracing today
> > and
> > found this when doing `rmmod ahci`:
> >=20
> > =3D> pci_intx
> > =3D> pci_msi_shutdown
> > =3D> pci_disable_msi
> > =3D> devres_release_all
> > =3D> device_unbind_cleanup
> > =3D> device_release_driver_internal
> > =3D> driver_detach
> > =3D> bus_remove_driver
> > =3D> pci_unregister_driver
> > =3D> __do_sys_delete_module
> > =3D> do_syscall_64
> > =3D> entry_SYSCALL_64_after_hwframe
> >=20
> > The SYSCALL is my `rmmod`.
> >=20
> > As you can see, pci_intx() is invoked indirectly through
> > pci_disable_msi() =E2=80=93 which gets invoked by devres, which is
> > precisely
> > one reason why you could not find the suspicious pci_intx() call in
> > the
> > ahci code base.
> >=20
> > Now the question is: Who set up that devres callback which
> > indirectly
> > calls pci_intx()?
> >=20
> > It is indeed MSI, here in msi/msi.c:
> >=20
> > static void pcim_msi_release(void *pcidev)
> > {
> > =C2=A0struct pci_dev *dev =3D pcidev;
> >=20
> > =C2=A0dev->is_msi_managed =3D false;
> > =C2=A0pci_free_irq_vectors(dev); // <-- calls pci_disable_msi(), which
> > calls pci_intx(), which re-registers yet another devres callback
> > }
> >=20
> > /*
> > =C2=A0* Needs to be separate from pcim_release to prevent an ordering
> > problem
> >=20
> > =3D=3D> Oh, here they even had a warning about that interacting with
> > devres somehow...
> >=20
> > =C2=A0* vs. msi_device_data_release() in the MSI core code.
> > =C2=A0*/
> > static int pcim_setup_msi_release(struct pci_dev *dev)
> > {
> > =C2=A0int ret;
> >=20
> > =C2=A0if (!pci_is_managed(dev) || dev->is_msi_managed)
> > =C2=A0return 0;
> >=20
> > =C2=A0ret =3D devm_add_action(&dev->dev, pcim_msi_release, dev);
> > =C2=A0if (ret)
> > =C2=A0return ret;
> >=20
> > =C2=A0dev->is_msi_managed =3D true;
> > =C2=A0return 0;
> > }
> >=20
> > I don't know enough about AHCI to see where exactly it jumps into
> > these, but a candidate would be:
> > =C2=A0* pci_enable_msi(), called among others in acard-ahci.c
> >=20
> > Another path is:
> > =C2=A0=C2=A0 1. ahci_init_one() calls
> > =C2=A0=C2=A0 2. ahci_init_msi() calls
> > =C2=A0=C2=A0 3. pci_alloc_irq_vectors() calls
> > =C2=A0=C2=A0 4. pci_alloc_irq_vectors_affinity() calls
> > =C2=A0=C2=A0 5. __pci_enable_msi_range() OR __pci_enable_msix_range() c=
all
> > =C2=A0=C2=A0 6. pci_setup_msi_context() calls
> > =C2=A0=C2=A0 7. pcim_setup_msi_release() which registers the callback t=
o
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_intx()
>=20
> ahci_init_one() is the function used by the default AHCI driver
> (ahci.ko), so
> this path is correct.
>=20
> > Ha!
> >=20
> > I think I earned myself a Friday evening beer now 8-)
>=20
> I was way ahead of you :)
>=20
> > Now the interesting question will be how the heck we're supposed to
> > clean that up.
>=20
> If pcim_intx() always gets called on device release, AND MSI/MSIX are
> also
> managed interrupts with a devres action on release, I would say that
> pcim_msi_release() should NOT lead to a path calling pci_intx(dev,
> 0), as that
> would create the intx devres again.

Yes, that is obviously wrong =E2=80=93 the thing is that we cannot remove t=
he
devres aspect of pci_intx() as long as the other callers (especially
drivers) rely on it.

And, most notably, we (=3D I) don't know if *MSI* relies on the devres
aspect being present in pci_intx() in MSI's cleanup path.

Looking at what pci_intx_for_msi() is good for and where it's used
might give a clue.

@Krzysztof: Aren't you the MSI expert? Any idea what this might be all
about?

There are definitely some hacks one could do to remove the devres
aspect from pci_intx() _just for MSI_, for example:
 * set struct pci_dev.is_managed =3D false in the disable path in MSI
 * Use yet another function, pci_intx_unmanaged(), in MSI

It's obviously work and all that and I don't think one should even try
it without an understanding of what MSI is supposed to do.


> But given the comment you point out above,
> it seems that there are some ordering constraints between disabling
> msi and intx
> ? If that is the case, then may be this indeed will be tricky.

No, I don't think that's related.
I think the ordering issue should have disappeared now in v6.11
(although I wouldn't bet my hand on it)

The issue was that until including v6.10, struct pci_devres bundled
everything needed by several managed PCI functions into just that one
struct. It is handled by 1 creator function and 1 cleanup function
(Should have never been implemented that way, since it violates the
basic concepts of devres, but here we are, should, would, could...).

I presume the author was then about to register that separate cleanup
devres callback in MSI and discovered that it would be racy if that MSI
code uses the same struct pci_devres, which is administrated by a
different function. It could have been freed already when the MSI
callback awakes -> UAF.

>=20
> > Another interesting question is: Did that only work by coincidence
> > during the last 15 years, or is it by design that the check in
> > pci_intx():
> >=20
> > if (new !=3D pci_command)
> >=20
> > only evaluates to true if we are not in a detach path.
>=20
> I would say that it evaluates to true for any device using intx,
> which tend to
> be rare these days. In such case, then enabling on device attach and
> disabling
> on detach would lead to new !=3D pci_command, including in the hidden
> intx disable
> path triggered by disabling msi. But the devres being recreated on
> detach
> definitely seem to depend on the disabling order though. So we may
> have been
> lucky indeed.

Hm. I hope you are right. If not, then other drivers would experience
the same regression you found in AHCI.

Let's keep our eyes open...

P.

>=20
> >=20
> > If it were coincidence, it would not have caused faults as it did
> > now
> > with my recent work, because the old version did not allocate in
> > pci_intx().
> >=20
> > But it could certainly have been racy and might run into a UAF
> > since
> > the old pci_intx() would have worked on memory that is also managed
> > by
> > devres, but has been registered at a different place. I guess that
> > is
> > what that comment in the MSI code quoted above is hinting at.
> >=20
> >=20
> > Christoph indeed rightfully called it voodoo ^^
> >=20
> >=20
> > Cheers,
> > P.
> >=20
> >=20
>=20


