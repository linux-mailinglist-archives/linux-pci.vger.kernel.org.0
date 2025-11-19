Return-Path: <linux-pci+bounces-41663-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A82C702F8
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 17:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F4DF500E69
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 16:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4C936A029;
	Wed, 19 Nov 2025 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h1kKYwma";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uAH0RHZ6"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE45B34D393
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763569163; cv=none; b=WWC9aeH6OQSevsAtX211tr3vEDsrS1LQnukzJBhCaUQWK4PgRbEj7oWMOlon6sZeeU3Usg0nfspZOJmJsyhWFifj3CG/inPjl6iTGZhqXkUYwZlsxb4PR0mGX7OaYj/rlWJX5LSdLGzIKDowTfVQU1yip/di4NoN0XUlDKy4rcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763569163; c=relaxed/simple;
	bh=zpp/bl7U8S6QS2wIZhr67ianm3gLkDtfnvM4QRSd1Xk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UU0C1LuRcV67KizBCjXbIT+Jt5y49wOVGo1sx8314MC1eBQPKC0XWGs+viwbVmcESOxfJOM8k0HPwhKRTvi5fiNuvViCcB19rEoyvbhsC3B+CX9ybr/vaS2lMeYNDZXItgaPVEgHGu/rsaE3DLL1LG7WMfAl065cN6/zHas1tHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h1kKYwma; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uAH0RHZ6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763569159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p6XnmoS9y/QjExQSUhzgtUPy4+P7HWebJCxAjmxqDoI=;
	b=h1kKYwmaWUrASjvorMOHL2uGeuWcC47OWwWXUBS6/qJiUEyJWFGA0lMRfiWMT40sAh3GmJ
	XCE+nUJRpqgLfRwQeGDJkwvSWU238asxDCWS87Wmfcs8k/9C60Cy2yTEYDWh843JEC07kz
	rNz0c7thTybAoC7OYB0uaAMj1iLV2SM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-RUAYB4KzOoKFkz6qNarYvQ-1; Wed, 19 Nov 2025 11:19:17 -0500
X-MC-Unique: RUAYB4KzOoKFkz6qNarYvQ-1
X-Mimecast-MFC-AGG-ID: RUAYB4KzOoKFkz6qNarYvQ_1763569157
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ee04f4c632so98941731cf.3
        for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 08:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763569157; x=1764173957; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p6XnmoS9y/QjExQSUhzgtUPy4+P7HWebJCxAjmxqDoI=;
        b=uAH0RHZ6lKyNHc4jZuYQSA8BDFPxdlUGUhMf82jMsHUguOTPdB7N8N4JdDCGo7ET88
         9aEjUCRGfewlUcZIMqYs4+PCyxFIkG56JlWZDWNVUfd93rvskKAqPMZTrY1GUqsSemNU
         Uhzw3U9EgByqsOmq29VJoiqvKotunCecYx4TRtySQv6SeQ0PTq3foE3OJJ3HbcNQ2Ju5
         jU57D9FGYJhd6S16qyc2u/KOAV5G4XiVz3N1c2p86A+asTP8p2UNzMvdIbrIx87yEq6D
         BgBWfyxyq5p6o8Z43W+YrUgZOYGPORG3s0DrFFWK52z7EmqaPZVilTNK4/zNfRbZsw3h
         n22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763569157; x=1764173957;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p6XnmoS9y/QjExQSUhzgtUPy4+P7HWebJCxAjmxqDoI=;
        b=M9ZeqLfs3hICrKTY5r/AhnsLPsIbxZUglMPYvFfZjXiC8faMuEsrZqepjru3zCycre
         TR4V9b753ubvTJHPi1vS+p897X4nXqaKWAAPRFBD3J16Nm7g29nYxeTXQuTppVUWwToB
         T1N+PKDv6CeYW2DwQixjItSNOoKsCFU5KpyTFyszWVs4yCqA87D8wqfkql4WKSxvxxxL
         +2fj586BCECyPUfHXy72wo3q2StUyymdM1B40BLQ+TB2mvKX1Dks6a4Z3i+/UTADeINY
         4fjLw76MWU7tAYQpGBNDt/LYXeT+P/rKkiFWCmS65HohlVtygIO1WMHaMeM1rfYoeae7
         8HXg==
X-Forwarded-Encrypted: i=1; AJvYcCWwmvRMUZE4ZiRgy65BDGNsTS0K0qKMpVOFu8CFboKf6idcMWg/H6HPpoHZ1npgVNRL27Ce7jrRJAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxazwmkuNmweZBi/AUKm2tRdI6iIsCjeOz+hW8OAEkaRNgEjpd4
	P6afoDF0lj1pawodXTuyTd2KkL6zaIyE/+q4VtZ/+L9RHWHuiRdAUUn4U6JFJ+MqoBMaCvsKB1b
	hRJCzeNH6MTGkk54xy+dfyzkBpyNx+lrFk23s7OsF6bV1TZ2dogfCUyxa0D2SxA==
X-Gm-Gg: ASbGncvm2Xxv0V3XxcXh9Df5mQpVUE3DxuZDP79l2WUyKzE05gOmI+XupBEzZIdzlw5
	M5X7C5wabnqodzDp0oXuPLbUQYgkkr+/j+wvbDopmoy1co1RDVe6DQwo3sR3OLS10yIamg7Ba/M
	irLwpS8NDEb4hPTmuUTg8HacdUVzizJ6U2yErueJlAif3y2XkYkHH28JtOfq3mwppLRFpIke3QE
	6jgdJJfQqd+6okfK42peyVeawCZKIgLKxr3aL3qLL/XcbIgpysoSiBQS5GS0/VZQSVS4vhLYFYl
	4aOZKBYUh0JKHPIYKUWmQYSKOueZdAsk9lmumooKW2nhlGsixWVcBY70ZyHgXSy5AAF27sy1PVw
	nPmDCtCBpdJKgYDqHRW6cs0eG1tAevtycYsWE0Kzq+zR31wGzeVLT1Zy0X1PdPZ1D7UBKpOzcEz
	tf
X-Received: by 2002:a05:622a:54:b0:4ed:ee58:215 with SMTP id d75a77b69052e-4edf20a914amr267334931cf.35.1763569156871;
        Wed, 19 Nov 2025 08:19:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELqiwovxwlqJiYgFVyaJyQQOyrVralmsihXdBDVIMZmS6bJi/KAR2C8mhzRxFKA1o8g2zcpA==
X-Received: by 2002:a05:622a:54:b0:4ed:ee58:215 with SMTP id d75a77b69052e-4edf20a914amr267334511cf.35.1763569156436;
        Wed, 19 Nov 2025 08:19:16 -0800 (PST)
Received: from thinkpad-p1.localdomain (pool-174-112-193-187.cpe.net.cable.rogers.com. [174.112.193.187])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ee4513af31sm7265511cf.24.2025.11.19.08.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 08:19:15 -0800 (PST)
Message-ID: <d7b6b7de88a374a79c7ed707c74f12797b50cc58.camel@redhat.com>
Subject: Re: [PATCH 1/2] PCI: host-common: Do not set drvdata in
 pci_host_common_init()
From: Radu Rendec <rrendec@redhat.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Manivannan Sadhasivam
 <mani@kernel.org>,  Will Deacon <will@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=	
 <kwilczynski@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 19 Nov 2025 11:19:14 -0500
In-Reply-To: <86jyzms036.wl-maz@kernel.org>
References: <20251118221244.372423-1-rrendec@redhat.com>
		<20251118221244.372423-2-rrendec@redhat.com> <86jyzms036.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-19 at 12:01 +0000, Marc Zyngier wrote:
> On Tue, 18 Nov 2025 22:12:43 +0000,
> Radu Rendec <rrendec@redhat.com> wrote:
> >=20
> > Currently pci_host_common_init() uses the platform device's drvdata to
> > store the pointer to the allocated struct pci_host_bridge. This makes
> > sense for drivers that use pci_host_common_{probe,remove}() directly as
> > the platform probe/remove functions, but leaves no option for more
> > complex drivers to store a pointer to their own private data.
> >=20
> > Change pci_host_common_init() to return the pointer to the allocated
> > struct pci_host_bridge, and move the platform_set_drvdata() call to
> > pci_host_common_probe(). This way, drivers that implement their own
> > probe function can still use pci_host_common_init() but store their own
> > pointer in the platform device's drvdata.
> >=20
> > For symmetry, move the release code to a new function that takes a
> > pointer to struct pci_host_bridge, and make pci_host_common_release() a
> > wrapper to it that extracts the pointer from the platform device's
> > drvdata. This way, drivers that store their own private pointer in the
> > platform device's drvdata can still use the library release code.
> >=20
> > No functional change to the existing users of pci-host-common is
> > intended, with the exception of the pcie-apple driver, which is modifie=
d
> > in a subsequent patch.
>=20
> This paragraph doesn't belong here. Maybe as a note, but not in the
> commit message.

Ack. And thanks for reviewing! More comments below.

> >=20
> > Signed-off-by: Radu Rendec <rrendec@redhat.com>
> > ---
> > =C2=A0drivers/pci/controller/pci-host-common.c | 36 ++++++++++++++++---=
-----
> > =C2=A0drivers/pci/controller/pci-host-common.h |=C2=A0 6 ++--
> > =C2=A02 files changed, 29 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/con=
troller/pci-host-common.c
> > index 810d1c8de24e9..86002195c93ac 100644
> > --- a/drivers/pci/controller/pci-host-common.c
> > +++ b/drivers/pci/controller/pci-host-common.c
> > @@ -52,25 +52,24 @@ struct pci_config_window *pci_host_common_ecam_crea=
te(struct device *dev,
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_GPL(pci_host_common_ecam_create);
> > =C2=A0
> > -int pci_host_common_init(struct platform_device *pdev,
> > - const struct pci_ecam_ops *ops)
> > +struct pci_host_bridge *pci_host_common_init(struct platform_device *p=
dev,
> > + =C2=A0=C2=A0=C2=A0=C2=A0 const struct pci_ecam_ops *ops)
> > =C2=A0{
> > =C2=A0 struct device *dev =3D &pdev->dev;
> > =C2=A0 struct pci_host_bridge *bridge;
> > =C2=A0 struct pci_config_window *cfg;
> > + int rc;
> > =C2=A0
> > =C2=A0 bridge =3D devm_pci_alloc_host_bridge(dev, 0);
> > =C2=A0 if (!bridge)
> > - return -ENOMEM;
> > + return ERR_PTR(-ENOMEM);
> > =C2=A0
> > =C2=A0 of_pci_check_probe_only();
> > =C2=A0
> > - platform_set_drvdata(pdev, bridge);
> > -
> > =C2=A0 /* Parse and map our Configuration Space windows */
> > =C2=A0 cfg =3D pci_host_common_ecam_create(dev, bridge, ops);
> > =C2=A0 if (IS_ERR(cfg))
> > - return PTR_ERR(cfg);
> > + return (struct pci_host_bridge *)cfg;
> > =C2=A0
> > =C2=A0 bridge->sysdata =3D cfg;
> > =C2=A0 bridge->ops =3D (struct pci_ops *)&ops->pci_ops;
> > @@ -78,31 +77,46 @@ int pci_host_common_init(struct platform_device *pd=
ev,
> > =C2=A0 bridge->disable_device =3D ops->disable_device;
> > =C2=A0 bridge->msi_domain =3D true;
> > =C2=A0
> > - return pci_host_probe(bridge);
> > + rc =3D pci_host_probe(bridge);
> > + if (rc)
> > + return ERR_PTR(rc);
> > +
> > + return bridge;
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_GPL(pci_host_common_init);
> > =C2=A0
> > =C2=A0int pci_host_common_probe(struct platform_device *pdev)
> > =C2=A0{
> > =C2=A0 const struct pci_ecam_ops *ops;
> > + struct pci_host_bridge *bridge;
> > =C2=A0
> > =C2=A0 ops =3D of_device_get_match_data(&pdev->dev);
> > =C2=A0 if (!ops)
> > =C2=A0 return -ENODEV;
> > =C2=A0
> > - return pci_host_common_init(pdev, ops);
> > + bridge =3D pci_host_common_init(pdev, ops);
> > + if (IS_ERR(bridge))
> > + return PTR_ERR(bridge);
> > +
> > + platform_set_drvdata(pdev, bridge);
>=20
> Congratulations, you just broke pcie-microchip-host.c again.
>=20
> Yes, I did that myself in afc0a570bb613871 ("PCI: host-generic:
> Extract an ECAM bridge creation helper from pci_host_common_probe()"),
> and it was fixed by Geert in bdb32a0f67806 ("PCI: host-generic: Set
> driver_data before calling gen_pci_init()").

Right. Which means there is an assumption (outside of
pci_host_common_probe() and pci_host_common_remove()) that the device's
drvdata is a pointer to the bridge. This is what I had feared but it
wasn't obvious and I failed to check thoroughly. Sorry!

> > +
> > + return 0;
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_GPL(pci_host_common_probe);
> > =C2=A0
> > -void pci_host_common_remove(struct platform_device *pdev)
> > +void pci_host_common_release(struct pci_host_bridge *bridge)
> > =C2=A0{
> > - struct pci_host_bridge *bridge =3D platform_get_drvdata(pdev);
> > -
> > =C2=A0 pci_lock_rescan_remove();
> > =C2=A0 pci_stop_root_bus(bridge->bus);
> > =C2=A0 pci_remove_root_bus(bridge->bus);
> > =C2=A0 pci_unlock_rescan_remove();
> > =C2=A0}
> > +EXPORT_SYMBOL_GPL(pci_host_common_release);
>=20
> Even with the pcie-apple.c driver change, this is never called. I'd
> refrain from adding an export until we actually have an identified
> user.

That's fair. I just wanted to provide it for symmetry. But it's not
even needed if we change the approach (see below).

> > +
> > +void pci_host_common_remove(struct platform_device *pdev)
> > +{
> > + pci_host_common_release(platform_get_drvdata(pdev));
> > +}
> > =C2=A0EXPORT_SYMBOL_GPL(pci_host_common_remove);
> > =C2=A0
> > =C2=A0MODULE_DESCRIPTION("Common library for PCI host controller driver=
s");
> > diff --git a/drivers/pci/controller/pci-host-common.h b/drivers/pci/con=
troller/pci-host-common.h
> > index 51c35ec0cf37d..018e593bafe47 100644
> > --- a/drivers/pci/controller/pci-host-common.h
> > +++ b/drivers/pci/controller/pci-host-common.h
> > @@ -11,11 +11,13 @@
> > =C2=A0#define _PCI_HOST_COMMON_H
> > =C2=A0
> > =C2=A0struct pci_ecam_ops;
> > +struct pci_host_bridge;
> > =C2=A0
> > =C2=A0int pci_host_common_probe(struct platform_device *pdev);
> > -int pci_host_common_init(struct platform_device *pdev,
> > - const struct pci_ecam_ops *ops);
> > +struct pci_host_bridge *pci_host_common_init(struct platform_device *p=
dev,
> > + =C2=A0=C2=A0=C2=A0=C2=A0 const struct pci_ecam_ops *ops);
> > =C2=A0void pci_host_common_remove(struct platform_device *pdev);
> > +void pci_host_common_release(struct pci_host_bridge *bridge);
> > =C2=A0
> > =C2=A0struct pci_config_window *pci_host_common_ecam_create(struct devi=
ce *dev,
> > =C2=A0 struct pci_host_bridge *bridge, const struct pci_ecam_ops *ops);
>=20
> My concern with this is two-fold:
>=20
> - it is yet another obscure API change with odd side effects,
> =C2=A0 requiring to track and understand the per-driver flow of informati=
on
> =C2=A0 (and the apple pcie driver is a prime example of how hard this is)
>=20
> - we can't directly associate the PCIe port data with the bridge like
> =C2=A0 must drivers do, because the bridge allocation is done outside of
> =C2=A0 the calling driver, and there is no link back to the bridge from
> =C2=A0 pci_config_window.
>=20
> I'd rather that last point was addressed so that we could make the
> Apple driver behave similarly to other drivers, and let it use the
> bridge private data for its PCIe port information.

Using the bridge private data to store the driver's private data was my
first thought too. In fact, in the first version of my (local) changes
I added a "size" parameter to pci_host_common_init(), to pass it down
to devm_pci_alloc_host_bridge() as the priv size.

But there's another problem with this approach: pci_host_common_init()
also calls pci_host_common_ecam_create() -> pci_ecam_create() ->
ops->init(), so init() would be called with the bridge private area
allocated but not populated.

I don't see an elegant solution to this. The two options that crossed
my mind are these:
 * Add yet another parameter to pci_host_common_init(), a void *, so it
   takes a void *priv and a size_t size. The size would be passed down
   to devm_pci_alloc_host_bridge(), then `size` bytes would be copied
   from `priv` to the bridge private data area. What I don't like about
   this is the extra memcpy() and the fact that the calling driver
   would have to prepare an "offline" copy of its private data (likely
   as a local variable) and pass it to pci_host_common_init().
 * Pass just the void *priv to pci_host_common_init(). By convention,
   the bridge private data would be used to store that void *priv
   itself, which is a pointer to the driver's private data. So, the 2nd
   parameter to devm_pci_alloc_host_bridge() would be sizeof(void *).
   The downside is that there's an extra pointer indirection.

In any case, your other concern about linking back to the bridge from
pci_config_window would be addressed because pci_config_window has a
pointer to the device (the `parent` field), which (in this scenario, by
convention) has the bridge pointer stored as drvdata.

If any of the options above looks appealing, or if you have a better
idea, please let me know, and I can prepare a v2.

--=20
Thanks,
Radu


