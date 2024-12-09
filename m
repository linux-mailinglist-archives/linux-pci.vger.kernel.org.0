Return-Path: <linux-pci+bounces-17942-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5182A9E96A2
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 14:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3553188AB53
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 13:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1069F1F2C30;
	Mon,  9 Dec 2024 13:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9++LRX/"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0EF1B4221
	for <linux-pci@vger.kernel.org>; Mon,  9 Dec 2024 13:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733750126; cv=none; b=kQzcuSYj7r+KMusTv3+CM9+xXjgf8JsBdQWZBNlICitE0nINYIMdF90gILcldEsbIQa8uuWbDLMQA9+9GNe/AUNJMG9u8VealIDcIAVeBoKjHB4nEOWnMnpvhLx8RfTv+Kcj24L6yB/OQJtJ8RXEXaZXsRKuCGNGC61Oco7Vbko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733750126; c=relaxed/simple;
	bh=ftWr6DBR7xHeC3+2czi3lER0J1bIqDP2zyiWq3WBWpU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K1sWramsslrbW53PgRyhmLThofM6j4EZBhn8encTjY8XreVnG5gd1wXvNhTfH75aOUPC9X2vArFySkhctSnXEABlBvfBd30ngIoz99mudcL9WpwcI6rk+9tZJjZzVS++TGYwoYQ83B/fK1zn8am8xHGb7wJtEI8eAj5AbkF/su0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H9++LRX/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733750123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1WoHdJlzjlTmm0KIYckzqnb3Qs1nO0xVPTt7EQVV3wE=;
	b=H9++LRX/5oDcB6OjU3zW9pwDTQeAAI14PWjEH5yH1lU61BIuCJGkqN+EvDeHoz0Mr+r6aD
	5fx9mcUlB4eC+YeyhQp5vv1MAWGX77aO0hGEbybuit3dJE9aJg39hROdoEXiDLvTGXcnPH
	5LgWIoivEBv1Q8FDWo274nTudYYRGwo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-HyHY5XAQNT2KXQYBC7srBQ-1; Mon, 09 Dec 2024 08:15:22 -0500
X-MC-Unique: HyHY5XAQNT2KXQYBC7srBQ-1
X-Mimecast-MFC-AGG-ID: HyHY5XAQNT2KXQYBC7srBQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-434f40667e5so8060485e9.1
        for <linux-pci@vger.kernel.org>; Mon, 09 Dec 2024 05:15:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733750121; x=1734354921;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1WoHdJlzjlTmm0KIYckzqnb3Qs1nO0xVPTt7EQVV3wE=;
        b=dFVoQZWE13Rp3T9wf1t+RBS8REZ+yOqumhwUaZVToTJAhj4dtgNtM6gosoYxfkgki3
         2zC2sgHcW3xbcTDvSXdGbwHh3ksioBgsLCLVyz1d8hZA41L2f7OQ9bhvCWV7ps9n+UJQ
         z/l3/dtNRxmSsYqWTbPyqYUfyU3ojkUjTviiMa67kIokNA1FAxGLSyqY228TghXey8ga
         njga/pYDef/ov/EXJGl+HUewaodwlXluCEpD7DDnaW157UZI8v0C1Mrz3Zvtj6UWiUNO
         a65FAQ2888+E7Np5BFGutVat/G4HXTBnoGcGqHtCjVFRuf+uc9dKnAMr8owx++kPkrDv
         xreQ==
X-Gm-Message-State: AOJu0YyIcvpJrF2traWL6guM3IFf/tyrSaMy3irUc3rI2sjme19JXfQC
	V+1nDP1Sz2KozjBEktfVOq/ppLLPm2t8RGvUXXk5fPEoBwY/aVp2eXYIm6/F94rP7qSqJy7PNK6
	e45Q+xeeWrJiSUy07grwmuxA5MDHJQsUrxO1hJXsPQ25L56+ZO1kXDdorRg==
X-Gm-Gg: ASbGncsB90SkzHaT1VkcBwfNwK15K/hB3mtjx5dO6Vw/XxNct1nISzJU5xIQu2B19wT
	91geeiFdEjFsg2PXdpd0zBEJj3LbZfr7U3MJ22ShZYARxSyG1+FdhiFzOJrrEloQZEMEAFHDFmH
	pGD06VdM0SBLpZ9ZL7wECUuxT2twhQRwZOG2649oO2MMwehnN/qNwlor5SYlNcjckd78dzFY2Ck
	XV4dJKTJxYXpD9wpGEIvZcEdAsAyNooWc8uL3X+s6vqwHR5QwxpocfiwAufTLDOXYbDH+uIrsOq
X-Received: by 2002:a05:600c:c13:b0:434:a4a6:51f8 with SMTP id 5b1f17b1804b1-434ffeab1e9mr5040845e9.0.1733750121114;
        Mon, 09 Dec 2024 05:15:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEo6rhI5Rwhuku2z2Wkz+O2ZILKJ3hsE1idySSFe81rLuc+JjxWkz6Ky9SyAJR0p+DU9jKMgw==
X-Received: by 2002:a05:600c:c13:b0:434:a4a6:51f8 with SMTP id 5b1f17b1804b1-434ffeab1e9mr5040615e9.0.1733750120752;
        Mon, 09 Dec 2024 05:15:20 -0800 (PST)
Received: from [10.200.68.91] (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38621fbbd70sm12987741f8f.90.2024.12.09.05.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:15:20 -0800 (PST)
Message-ID: <5201b58b1b20f6af6104c4f9153545b7859bd22e.camel@redhat.com>
Subject: Re: [PATCH v2] PCI: Restore the original INTX_DISABLE bit by
 pcim_intx()
From: Philipp Stanner <pstanner@redhat.com>
To: Takashi Iwai <tiwai@suse.de>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 09 Dec 2024 14:15:19 +0100
In-Reply-To: <61ef07331f843c25b19e5a6f68419e0a607a1b0b.camel@redhat.com>
References: <20241031134300.10296-1-tiwai@suse.de>
	 <61ef07331f843c25b19e5a6f68419e0a607a1b0b.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-11-04 at 10:14 +0100, Philipp Stanner wrote:
> On Thu, 2024-10-31 at 14:42 +0100, Takashi Iwai wrote:
> > pcim_intx() tries to restore the INTx bit at removal via devres,
> > but
> > there is a chance that it restores a wrong value.
> > Because the value to be restored is blindly assumed to be the
> > negative
> > of the enable argument, when a driver calls pcim_intx()
> > unnecessarily
> > for the already enabled state, it'll restore to the disabled state
> > in
> > turn.=C2=A0 That is, the function assumes the case like:
> >=20
> > =C2=A0 // INTx =3D=3D 1
> > =C2=A0 pcim_intx(pdev, 0); // old INTx value assumed to be 1 -> correct
> >=20
> > but it might be like the following, too:
> >=20
> > =C2=A0 // INTx =3D=3D 0
> > =C2=A0 pcim_intx(pdev, 0); // old INTx value assumed to be 1 -> wrong
> >=20
> > Also, when a driver calls pcim_intx() multiple times with different
> > enable argument values, the last one will win no matter what value
> > it
> > is.=C2=A0 This can lead to inconsistency, e.g.
> >=20
> > =C2=A0 // INTx =3D=3D 1
> > =C2=A0 pcim_intx(pdev, 0); // OK
> > =C2=A0 ...
> > =C2=A0 pcim_intx(pdev, 1); // now old INTx wrongly assumed to be 0
> >=20
> > This patch addresses those inconsistencies by saving the original
> > INTx state at the first pcim_intx() call.=C2=A0 For that,
> > get_or_create_intx_devres() is folded into pcim_intx() caller side;
> > it allows us to simply check the already allocated devres and
> > record
> > the original INTx along with the devres_alloc() call.
> >=20
> > Fixes: 25216afc9db5 ("PCI: Add managed pcim_intx()")
> > Cc: stable@vger.kernel.org=C2=A0# 6.11+
> > Link: https://lore.kernel.org/87v7xk2ps5.wl-tiwai@suse.de
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
>=20
> Reviewed-by: Philipp Stanner <pstanner@redhat.com>

Hello,

it seems we forgot about this patch.

Regards,
P.


>=20
> Nice!
>=20
> > ---
> > v1->v2: refactoring, fold get_or_create_intx_devres() into the
> > caller
> > instead of retrieving the original INTx there.
> > Also add comments and improve the patch description.
> >=20
> > =C2=A0drivers/pci/devres.c | 34 +++++++++++++++++++---------------
> > =C2=A01 file changed, 19 insertions(+), 15 deletions(-)
> >=20
> > diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
> > index b133967faef8..c93d4d4499a0 100644
> > --- a/drivers/pci/devres.c
> > +++ b/drivers/pci/devres.c
> > @@ -438,19 +438,12 @@ static void pcim_intx_restore(struct device
> > *dev, void *data)
> > =C2=A0	__pcim_intx(pdev, res->orig_intx);
> > =C2=A0}
> > =C2=A0
> > -static struct pcim_intx_devres *get_or_create_intx_devres(struct
> > device *dev)
> > +static void save_orig_intx(struct pci_dev *pdev, struct
> > pcim_intx_devres *res)
> > =C2=A0{
> > -	struct pcim_intx_devres *res;
> > +	u16 pci_command;
> > =C2=A0
> > -	res =3D devres_find(dev, pcim_intx_restore, NULL, NULL);
> > -	if (res)
> > -		return res;
> > -
> > -	res =3D devres_alloc(pcim_intx_restore, sizeof(*res),
> > GFP_KERNEL);
> > -	if (res)
> > -		devres_add(dev, res);
> > -
> > -	return res;
> > +	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
> > +	res->orig_intx =3D !(pci_command &
> > PCI_COMMAND_INTX_DISABLE);
> > =C2=A0}
> > =C2=A0
> > =C2=A0/**
> > @@ -466,12 +459,23 @@ static struct pcim_intx_devres
> > *get_or_create_intx_devres(struct device *dev)
> > =C2=A0int pcim_intx(struct pci_dev *pdev, int enable)
> > =C2=A0{
> > =C2=A0	struct pcim_intx_devres *res;
> > +	struct device *dev =3D &pdev->dev;
> > =C2=A0
> > -	res =3D get_or_create_intx_devres(&pdev->dev);
> > -	if (!res)
> > -		return -ENOMEM;
> > +	/*
> > +	 * pcim_intx() must only restore the INTx value that
> > existed
> > before the
> > +	 * driver was loaded, i.e., before it called pcim_intx()
> > for
> > the
> > +	 * first time.
> > +	 */
> > +	res =3D devres_find(dev, pcim_intx_restore, NULL, NULL);
> > +	if (!res) {
> > +		res =3D devres_alloc(pcim_intx_restore,
> > sizeof(*res),
> > GFP_KERNEL);
> > +		if (!res)
> > +			return -ENOMEM;
> > +
> > +		save_orig_intx(pdev, res);
> > +		devres_add(dev, res);
> > +	}
> > =C2=A0
> > -	res->orig_intx =3D !enable;
> > =C2=A0	__pcim_intx(pdev, enable);
> > =C2=A0
> > =C2=A0	return 0;
>=20


