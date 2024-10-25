Return-Path: <linux-pci+bounces-15329-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F029B075C
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 17:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02C19284B2B
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 15:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1870C156875;
	Fri, 25 Oct 2024 15:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XpMmpAyw"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7E4139CFA
	for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2024 15:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868790; cv=none; b=pSXjS6G5HmOqJJhvmYxl5gb4KBZ+zcTjEOqjUePvlWxogjMWBEK8cdBynLjle2tsjCHxa0NBMepJCKhl2tVBdMZL6FV/84emdcOlEyydAefrzKLBUBIpUuRXFfp1tbtsZkyGQUxLsQesxEeHCuCGvf+/oAzRqmBCFmvLuIZ1dXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868790; c=relaxed/simple;
	bh=iYTgG8NanLdQKD+AsusgTN8Ch4lAf9ypWbQ35xI0bCU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UdHLfYh9e43A+PFLabsYV0hY3TOIXniCtyZY4YOPJ4MRm4AarYqYJ6hmiq4em/qPOC4B6PEFGx/hDqSRfUdg36Dn2FeSA9dsTRs5BtxyhnsLEYp9WeKGD0N0qinSjLedE3/21ynDfPxPpMgVbr1aJelCmBazPGhWghvtH2CPxms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XpMmpAyw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729868784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CIz46+x4bRXmvobS/E6y4UXGqgG2y4nXvZMzKFRszJs=;
	b=XpMmpAywW1Mv2NNV7wiqjp3DMsvA8ewWmkUpnDhzILyPOaH2uFJudQUnpFDS39nQbjv2J+
	VxQ7HD98IOqoW9aMKrTYa6oyScL3JAdpfAn/p3X/X5eYoBeFX3mNkvle6sEqgReoH1yeHH
	+/nYUMthIhy0+I0lDnD9b+SuiZ2Wc4Y=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-la3-h9DKNPCxDQq_wTB5Wg-1; Fri, 25 Oct 2024 11:06:23 -0400
X-MC-Unique: la3-h9DKNPCxDQq_wTB5Wg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a9a1af73615so151225066b.0
        for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2024 08:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729868782; x=1730473582;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CIz46+x4bRXmvobS/E6y4UXGqgG2y4nXvZMzKFRszJs=;
        b=voHI+kYV7z/fmmvQQ6VrZiH1WNXTcnJaaKhzIsYxyz6LAMbgjasQKYEZ8m8+ZkDG7Q
         i5GjMEWFWWXsCFy8scfZyW4+/fpl1dCxAImEHKQmw+TSr0aNkGVG1x4S4gkk7VJmcLY1
         ce8JL4Ni2KeDTcmiPOsnmn+WYT/iIeJaixnnAjzpQ6MiGnj/V+VHljRjs7vxm5JGbWKS
         VnRZt+LWp5FjahZYVgN+xMp/AM4ATOBbPTi9vXCh6YfUZrQPkMo7/AdIxY8RlcT6h+O0
         ImNxIF1YlwFnStKSnPxhX+ofXPrsDaTCOcXO1rhSsQYlZ4dDjG7sE0tcu+buZa/6Ix83
         JcXw==
X-Forwarded-Encrypted: i=1; AJvYcCXPxI0CEr/81NURR/xtNgIlRywNoxbC4wsbuaOBPd4r12Q2cs4PaGFh40G2kVgNp49ERy+uW96P7iA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzGeFg29pVJqY284Hf5nyfxgSgwBrui0kstF+T1o6R/eerEyzQ
	EVXD7blcgS+XvJYd2JozSVF7uJ/qI7zQXPqaTlStW6Nk/cSj+JMU4iMUASrY+uJTCBWEd5AJUZ0
	pMrSrMw+DO10L95c3NTnTJZPZKK/RO7t4cLPt4KG6Pv5MTj/DBZopMAYjZNpYHG2BjA==
X-Received: by 2002:a17:907:e9f:b0:a9a:422:ec7 with SMTP id a640c23a62f3a-a9ad275d9cemr511541566b.32.1729868782037;
        Fri, 25 Oct 2024 08:06:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFdN3GZL4gIyto9nt/eqaWje2kl2AtZnDgm2Uj/IF3mPI6nGQFRBSHLa0Dvg/S6O07CgiZUw==
X-Received: by 2002:a17:907:e9f:b0:a9a:422:ec7 with SMTP id a640c23a62f3a-a9ad275d9cemr511538766b.32.1729868781503;
        Fri, 25 Oct 2024 08:06:21 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82de5ba00738ac8dadaac7543.dip.versatel-1u1.de. [2001:16b8:2de5:ba00:738a:c8da:daac:7543])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b3a08b478sm79649766b.223.2024.10.25.08.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 08:06:21 -0700 (PDT)
Message-ID: <5a2739f702a59deb51d19d7570c352b98b1e0628.camel@redhat.com>
Subject: Re: [PATCH] PCI: Restore the original INTX_DISABLE bit by
 pcim_intx()
From: Philipp Stanner <pstanner@redhat.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 25 Oct 2024 17:06:20 +0200
In-Reply-To: <87ldycs097.wl-tiwai@suse.de>
References: <20241024155539.19416-1-tiwai@suse.de>
	 <933083faa55109949cbb5a07dcec27f3e4bff9ec.camel@redhat.com>
	 <87y12csbqe.wl-tiwai@suse.de>
	 <5b2911489844f6a970da053ebfc126eddf7c896c.camel@redhat.com>
	 <87ldycs097.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-10-25 at 16:52 +0200, Takashi Iwai wrote:
> On Fri, 25 Oct 2024 16:28:42 +0200,
> Philipp Stanner wrote:
> >=20
> > On Fri, 2024-10-25 at 12:44 +0200, Takashi Iwai wrote:
> > > On Fri, 25 Oct 2024 11:26:18 +0200,
> > > Philipp Stanner wrote:
> > > >=20
> > > > Hi,
> > > >=20
> > > > On Thu, 2024-10-24 at 17:55 +0200, Takashi Iwai wrote:
> > > > > pcim_intx() tries to restore the INTX_DISABLE bit at removal
> > > > > via
> > > > > devres, but there is a chance that it restores a wrong value.
> > > > > Because the value to be restored is blindly assumed to be the
> > > > > negative
> > > > > of the enable argument, when a driver calls pcim_intx()
> > > > > unnecessarily
> > > > > for the already enabled state, it'll restore to the disabled
> > > > > state in
> > > > > turn.

btw following our discussion I think the commit message should then
also explicitly state that pcim_intx() is supposed to restore the value
before the function itself had been called by that driver for the very
first time.

> > > >=20
> > > > It depends on how it is called, no?
> > > >=20
> > > > // INTx =3D=3D 1
> > > > pcim_intx(pdev, 0); // old INTx value assumed to be 1 ->
> > > > correct
> > > >=20
> > > > ---
> > > >=20
> > > > // INTx =3D=3D 0
> > > > pcim_intx(pdev, 0); // old INTx value assumed to be 1 -> wrong
> > > >=20
> > > > Maybe it makes sense to replace part of the commit text with
> > > > something
> > > > like the example above?
> > >=20
> > > If it helps better understanding, why not.
> > >=20
> > > > > =C2=A0 Also, when a driver calls pcim_intx() multiple times with
> > > > > different enable argument values, the last one will win no
> > > > > matter
> > > > > what
> > > > > value it is.
> > > >=20
> > > > Means
> > > >=20
> > > > // INTx =3D=3D 0
> > > > pcim_intx(pdev, 0); // orig_INTx =3D=3D 1, INTx =3D=3D 0
> > > > pcim_intx(pdev, 1); // orig_INTx =3D=3D 0, INTx =3D=3D 1
> > > > pcim_intx(pdev, 0); // orig_INTx =3D=3D 1, INTx =3D=3D 0
> > > >=20
> > > > So in this example the first call would cause a wrong
> > > > orig_INTx,
> > > > but
> > > > the last call =E2=80=93 the one "who will win" =E2=80=93 seems to d=
o the right
> > > > thing,
> > > > dosen't it?
> > >=20
> > > Yes and no.=C2=A0 The last call wins to write the current value, but
> > > shouldn't win for setting the original value.=C2=A0 The original valu=
e
> > > must
> > > be recorded only from the first call.
> >=20
> > Alright, so you think that pcim_intx() should always restore the
> > INTx
> > state that existed before the driver was loaded.
> >=20
> > > > > This patch addresses those inconsistencies by saving the
> > > > > original
> > > > > INTX_DISABLE state at the first devres_alloc(); this assures
> > > > > that
> > > > > the
> > > > > original state is restored properly, and the later
> > > > > pcim_intx()
> > > > > calls
> > > > > won't overwrite res->orig_intx any longer.
> > > > >=20
> > > > > Fixes: 25216afc9db5 ("PCI: Add managed pcim_intx()")
> > > >=20
> > > > That commit is also in 6.11, so we need:
> > > >=20
> > > > Cc: stable@vger.kernel.org=C2=A0# 6.11+
> > >=20
> > > OK.
> > >=20
> > > > > Link: https://lore.kernel.org/87v7xk2ps5.wl-tiwai@suse.de
> > > > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > > > ---
> > > > > =C2=A0drivers/pci/devres.c | 18 ++++++++++++++----
> > > > > =C2=A01 file changed, 14 insertions(+), 4 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
> > > > > index b133967faef8..aed3c9a355cb 100644
> > > > > --- a/drivers/pci/devres.c
> > > > > +++ b/drivers/pci/devres.c
> > > > > @@ -438,8 +438,17 @@ static void pcim_intx_restore(struct
> > > > > device
> > > > > *dev, void *data)
> > > > > =C2=A0	__pcim_intx(pdev, res->orig_intx);
> > > > > =C2=A0}
> > > > > =C2=A0
> > > > > -static struct pcim_intx_devres
> > > > > *get_or_create_intx_devres(struct
> > > > > device *dev)
> > > > > +static void save_orig_intx(struct pci_dev *pdev, struct
> > > > > pcim_intx_devres *res)
> > > > > =C2=A0{
> > > > > +	u16 pci_command;
> > > > > +
> > > > > +	pci_read_config_word(pdev, PCI_COMMAND,
> > > > > &pci_command);
> > > > > +	res->orig_intx =3D !(pci_command &
> > > > > PCI_COMMAND_INTX_DISABLE);
> > > > > +}
> > > > > +
> > > > > +static struct pcim_intx_devres
> > > > > *get_or_create_intx_devres(struct
> > > > > pci_dev *pdev)
> > > > > +{
> > > > > +	struct device *dev =3D &pdev->dev;
> > > > > =C2=A0	struct pcim_intx_devres *res;
> > > > > =C2=A0
> > > > > =C2=A0	res =3D devres_find(dev, pcim_intx_restore, NULL,
> > > > > NULL);
> > > > > @@ -447,8 +456,10 @@ static struct pcim_intx_devres
> > > > > *get_or_create_intx_devres(struct device *dev)
> > > > > =C2=A0		return res;
> > > > > =C2=A0
> > > > > =C2=A0	res =3D devres_alloc(pcim_intx_restore, sizeof(*res),
> > > > > GFP_KERNEL);
> > > > > -	if (res)
> > > > > +	if (res) {
> > > > > +		save_orig_intx(pdev, res);
> > > >=20
> > > > This is not the correct place =E2=80=93 get_or_create_intx_devres()
> > > > should
> > > > get
> > > > the resource if it exists, or allocate it if it doesn't, but
> > > > its
> > > > purpose is not to modify the resource.
> > >=20
> > > The behavior of the function makes the implementation a bit
> > > harder,
> > > because the initialization of res->orig_intx should be done only
> > > once
> > > at the very first call.
> > >=20
> > > > > =C2=A0		devres_add(dev, res);
> > > > > +	}
> > > > > =C2=A0
> > > > > =C2=A0	return res;
> > > > > =C2=A0}
> > > > > @@ -467,11 +478,10 @@ int pcim_intx(struct pci_dev *pdev, int
> > > > > enable)
> > > > > =C2=A0{
> > > > > =C2=A0	struct pcim_intx_devres *res;
> > > > > =C2=A0
> > > > > -	res =3D get_or_create_intx_devres(&pdev->dev);
> > > > > +	res =3D get_or_create_intx_devres(pdev);
> > > > > =C2=A0	if (!res)
> > > > > =C2=A0		return -ENOMEM;
> > > > > =C2=A0
> > > > > -	res->orig_intx =3D !enable;
> > > >=20
> > > > Here is the right place to call save_orig_intx(). That way you
> > > > also
> > > > won't need the new variable struct device *dev above :)
> > >=20
> > > The problem is that, at this place, we don't know whether it's a
> > > freshly created devres or it's an inherited one.=C2=A0 So, we'd need
> > > to
> > > modify get_or_create_intx_devres() to indicate that it's a new
> > > creation.=C2=A0 Or, maybe simpler would be rather to flatten
> > > get_or_create_intx_devres() into pcim_intx().=C2=A0 It's a small
> > > function,
> > > and it wouldn't be worsen the readability so much.
> >=20
> > That might be the best solution. If it's done that way it should
> > include a comment detailing the problem.
> >=20
> > Looking at the implementation of pci_intx() before
> > 25216afc9db53d85dc648aba8fb7f6d31f2c8731 probably indicates that
> > you're
> > right:
> >=20
> > 	if (dr && !dr->restore_intx) {
> > 		dr->restore_intx =3D 1;
> > 		dr->orig_intx =3D !enable;
> > 	}
> >=20
> >=20
> > So they used a boolean to only take the first state. Although that
> > still wouldn't have necessarily been the pre-driver INTx state.
>=20
> IIRC, this code path is reached only after checking that the INTx
> state is changed.=C2=A0 Hence "!enable" is assured to be the pre-driver
> INTx state in the old code.

Oh man. Have those folks never heard of comments :(

>=20
>=20
> > >=20
> > > That is, something like below.
> > >=20
> > >=20
> > > thanks,
> > >=20
> > > Takashi
> > >=20
> > > --- a/drivers/pci/devres.c
> > > +++ b/drivers/pci/devres.c
> > > @@ -438,21 +438,6 @@ static void pcim_intx_restore(struct device
> > > *dev, void *data)
> > > =C2=A0	__pcim_intx(pdev, res->orig_intx);
> > > =C2=A0}
> > > =C2=A0
> > > -static struct pcim_intx_devres *get_or_create_intx_devres(struct
> > > device *dev)
> > > -{
> > > -	struct pcim_intx_devres *res;
> > > -
> > > -	res =3D devres_find(dev, pcim_intx_restore, NULL, NULL);
> > > -	if (res)
> > > -		return res;
> > > -
> > > -	res =3D devres_alloc(pcim_intx_restore, sizeof(*res),
> > > GFP_KERNEL);
> > > -	if (res)
> > > -		devres_add(dev, res);
> > > -
> > > -	return res;
> > > -}
> > > -
> > > =C2=A0/**
> > > =C2=A0 * pcim_intx - managed pci_intx()
> > > =C2=A0 * @pdev: the PCI device to operate on
> > > @@ -466,12 +451,21 @@ static struct pcim_intx_devres
> > > *get_or_create_intx_devres(struct device *dev)
> > > =C2=A0int pcim_intx(struct pci_dev *pdev, int enable)
> > > =C2=A0{
> > > =C2=A0	struct pcim_intx_devres *res;
> > > +	struct device *dev =3D &pdev->dev;
> > > +	u16 pci_command;
> > > =C2=A0
> > > -	res =3D get_or_create_intx_devres(&pdev->dev);
> > > -	if (!res)
> > > -		return -ENOMEM;
> > > +	res =3D devres_find(dev, pcim_intx_restore, NULL, NULL);
> >=20
> > sth like:
> >=20
> > /*
> > =C2=A0* pcim_intx() must only restore the INTx value that existed befor=
e
> > the
> > =C2=A0* driver was loaded, i.e., before it called pcim_intx() for the
> > =C2=A0* first time.
> > =C2=A0*/
>=20
> OK, will add it.
>=20
> > > +	if (!res) {
> > > +		res =3D devres_alloc(pcim_intx_restore,
> > > sizeof(*res),
> > > GFP_KERNEL);
> > > +		if (!res)
> > > +			return -ENOMEM;
> > > +
> > > +		pci_read_config_word(pdev, PCI_COMMAND,
> > > &pci_command);
> > > +		res->orig_intx =3D !(pci_command &
> > > PCI_COMMAND_INTX_DISABLE);
> > > +
> > > +		devres_add(dev, res);
> > > +	}
> > > =C2=A0
> > > -	res->orig_intx =3D !enable;
> > > =C2=A0	__pcim_intx(pdev, enable);
> >=20
> > Looks like a good idea to me
> >=20
> > The only thing I'm wondering about right now is the following: In
> > the
> > old days, there was only pci_intx(), which either did devres or
> > didn't.
> >=20
> > Now you have two functions, pcim_intx() and pci_intx().
> >=20
> > The thing is that the driver could theoretically still intermingle
> > them
> > and for example call pci_intx() before pcim_intx(), which would
> > lead
> > the latter to still restore the wrong value.
> >=20
> > But that's very unlikely and I'm not sure whether we can do
> > something
> > about it.
>=20
> Right, pcim_intx() assures to restore INTx value back to the moment
> it
> was called.=C2=A0 And that should be enough and consistent behavior.

The moment *before* it was called *for the first time*.


>=20
> BTW, a possible optimization would be to skip the devres if the value
> isn't really changed from the current state (which is similar like
> the
> old code before pcim_intx()).=C2=A0 OTOH, this can lead to inconsistencie=
s
> when INTx is changed manually after pcim_intx() somehow.=C2=A0 So maybe
> it's not worth.

There is only a very tiny number of pci{m}_intx() users, they mostly
use it in their probe() function, and future use is discouraged in
favor of pci_alloc_irq_vectors().

So I think you can save yourself that effort.

P.


>=20
>=20
> thanks,
>=20
> Takashi
>=20


