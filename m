Return-Path: <linux-pci+bounces-42062-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD00C85D3C
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 16:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0923C3456A5
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 15:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FF319F137;
	Tue, 25 Nov 2025 15:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NOZgHvJR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVkQ0bhu"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2183191F92
	for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 15:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764085712; cv=none; b=IC9luYhHulWXqTGw6l5aKPtKjkn1chfvqMCKXSRd/L0c2RNjgh8qtlqEauQfRUl6jtEw92pVQf4MjmWM+U93GTuhM+So7+YFT3FLcNP7mdavSp+ELGMZM2haPiYoe5l9ahEGEmazB93nXz+WYCBUSQaaxN3soollDnldy4MbwE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764085712; c=relaxed/simple;
	bh=UXJeNlSO3UHGHBV9doi+HvjfXgdBQnSFuegzqXfDFpc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WdLyrcC1TvOWfiwqIAJN1XkquGfC4s6WyhOg1VKWT095nYAhs1swTZSHajJ7UJkVMRV1MkSbAiJEYRxLKJYkm6Hz+cP9L8wnDgc18w7AAkB9zvza4qvrcuif6HWpUQ+Npb/hf8G8Gr4sXzBqsyOqnKjzo41JBipM0YowJ18Fhvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NOZgHvJR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MVkQ0bhu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764085709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k9b09Krqnfah1Efwew759eb1g6delm/Yd1AUWIG5UK4=;
	b=NOZgHvJRke/0mec2snjja4wWMiCmZ7uHqRKighI+86Kn9eazQ/m2yHjYnB3BYYWzlZc5pp
	RsKEu6VdJoWYWtEipCDj935kNtCyXowo1pDHi2j9cktksswgZ/2AHJ5/wbjDZpaeC4XCMz
	aq8i7V3zb/ETQtTr2uCHiI0mCQeXV5A=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-ecB1NUjpNGCB2sOVWp7UwA-1; Tue, 25 Nov 2025 10:48:28 -0500
X-MC-Unique: ecB1NUjpNGCB2sOVWp7UwA-1
X-Mimecast-MFC-AGG-ID: ecB1NUjpNGCB2sOVWp7UwA_1764085707
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-295592eb5dbso119458485ad.0
        for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 07:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764085707; x=1764690507; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k9b09Krqnfah1Efwew759eb1g6delm/Yd1AUWIG5UK4=;
        b=MVkQ0bhuK0cr/lsE458pEs+3VYnLGdwnEbKYy0BTZG7+1uyg62o7i6Z6dMarAn7/m4
         8jYGWRgl2fw3t02BRZTWfazB4F475IYqJiUcqEUDT3JyAzf9oisJgYEyeNbdsu38No9m
         VAH6ub5AnxEL2LVzhddrOU2EyUwtvsaNIwX4qfS4+UCQUNjyYYxUrMFGdamK8by/2A8x
         EiqOv9vnW6l65GJpl+Lhn6FaPbhse/CL/lK94a7DxBTcgJzZcFD6SjbFZXDW2dsv4wOq
         KMKMMrcmc7V7Cfi86zClaQzoH5E94Gc21untP+HY63rzxpnPrqOK2DFfoxktICVb8g/N
         QLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764085707; x=1764690507;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k9b09Krqnfah1Efwew759eb1g6delm/Yd1AUWIG5UK4=;
        b=aBUK00s8YnMqfssWmUv6H7g3TkItRUtfDg7a8dKmRIyzHxP50I5RIuNEWR0Qo+nVc2
         StyVHD+Sb0q9wb4K4PWaMSadL0l5yvhRbOyellZ4qHkCOyHO3Ml1FOAzAUUpIFdV7O0K
         4Vj/PAYKxrRzagfrSxzAkHyRknVEg1afywmITsyzX1bUhaPrRulMMDdVTDAR76D/ccut
         y9frFk+dmgXY9YfMWAhdX2+wwfA5r1GG2TDp+35qb9FcSVNfuwoWyoTCUPDiVvfjTikO
         KH8gj1MUfPjct6qrPLtfXW3RVGCMS4zEAjjRGvuLntaR0yc/SX2pHDROADAuLqzBlbDO
         3JWA==
X-Forwarded-Encrypted: i=1; AJvYcCUFOdqrUpN5BYk2FjvLaBxtTCAutsxypwfTpxERjQl/lSd49+VsqSiRxfBDg9MvagjUFT8KM9VEUbA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2IgmHWpl8j3lvMjjXbXwf14tLK+PcijlIv8g8/cXIGU40Xt0x
	Tuo5Db4dYz1lKs+btPtStA5CIrWr7R6r4J5JbENZh+x79GfbzUrilVfpxr38ZhliXiWe3f1n6nL
	tg/W6dqWXymOfrKqciu2YDUFzTumZD5zzZtmgt3yp0Z+VCSQwiQiorhKtjVrSHA==
X-Gm-Gg: ASbGnctKQeP7fhEhnmDT8atDRI9zIrPVwU2hJ8ZajHxUzfbtuiJcOaHXtoO/tfeA1Ui
	+I4oTurl6GTpI4MaV2scZkvpkIXe0ZQcNpqgwrwsRANOQFYRqJGj6k4XpSs99U4Eh83EA2XGrNM
	LFLvuTLFv9ZbFcUe/ZyzlesVk9cHm95PggHH7p+sdQ/TB5Hha+Cj6Zfet6kvkim2T8A1ezkQHlF
	HIBzMkVh7v4hTrqzGlheM8IjgzjRGUynZuXwrHu3ibUONqKvEClEFJFMU5Xs03TpTR0cTy1sytK
	wRmzWBWPpHxAWYCdctUIeVzcSSMCAar2qppO5ZFZpRxL2ksLmUPWcGm5+05rh3IOwKnvx8ikwqw
	VrvzsA+eW/kAzaOGAB5GBKDV0lYLSMJ/Shf5z
X-Received: by 2002:a17:903:b86:b0:295:4d97:8503 with SMTP id d9443c01a7336-29b6c575180mr187671415ad.30.1764085707033;
        Tue, 25 Nov 2025 07:48:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKvgNQbyrXYYI1Dt7FHL145Gwg3yi+vBGB1qCw8Ugy59NPU8GBaC78JFLtZrJ3YPzGWPblAA==
X-Received: by 2002:a17:903:b86:b0:295:4d97:8503 with SMTP id d9443c01a7336-29b6c575180mr187671005ad.30.1764085706489;
        Tue, 25 Nov 2025 07:48:26 -0800 (PST)
Received: from [10.200.68.138] (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b107774sm168940565ad.9.2025.11.25.07.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 07:48:25 -0800 (PST)
Message-ID: <414bc2c721bfc60b8b8a1b7d069ff0fc9b3e5283.camel@redhat.com>
Subject: Re: [PATCH v9 02/13] PCI: Add devres helpers for iomap table
 [resulting in backtraces on HPPA]
From: Philipp Stanner <pstanner@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Hans de Goede <hdegoede@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, Sam
 Ravnborg <sam@ravnborg.org>, dakr@redhat.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-parisc@vger.kernel.org, Helge Deller
 <deller@gmx.de>
Date: Tue, 25 Nov 2025 16:48:11 +0100
In-Reply-To: <16cd212f-6ea0-471d-bf32-34f55d7292fe@roeck-us.net>
References: <20240613115032.29098-1-pstanner@redhat.com>
	 <20240613115032.29098-3-pstanner@redhat.com>
	 <16cd212f-6ea0-471d-bf32-34f55d7292fe@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-11-23 at 08:42 -0800, Guenter Roeck wrote:
> Hi,
>=20
> On Thu, Jun 13, 2024 at 01:50:15PM +0200, Philipp Stanner wrote:
> > The pcim_iomap_devres.table administrated by pcim_iomap_table() has its
> > entries set and unset at several places throughout devres.c using manua=
l
> > iterations which are effectively code duplications.
> >=20
> > Add pcim_add_mapping_to_legacy_table() and
> > pcim_remove_mapping_from_legacy_table() helper functions and use them w=
here
> > possible.
> >=20
> > Link: https://lore.kernel.org/r/20240605081605.18769-4-pstanner@redhat.=
com
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > [bhelgaas: s/short bar/int bar/ for consistency]
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> > =C2=A0drivers/pci/devres.c | 77 +++++++++++++++++++++++++++++++++------=
-----
> > =C2=A01 file changed, 58 insertions(+), 19 deletions(-)
> >=20
> > diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
> > index f13edd4a3873..845d6fab0ce7 100644
> > --- a/drivers/pci/devres.c
> > +++ b/drivers/pci/devres.c
> > @@ -297,6 +297,52 @@ void __iomem * const *pcim_iomap_table(struct pci_=
dev *pdev)
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL(pcim_iomap_table);
> > =C2=A0
> > +/*
> > + * Fill the legacy mapping-table, so that drivers using the old API ca=
n
> > + * still get a BAR's mapping address through pcim_iomap_table().
> > + */
> > +static int pcim_add_mapping_to_legacy_table(struct pci_dev *pdev,
> > +					=C2=A0=C2=A0=C2=A0 void __iomem *mapping, int bar)
> > +{
> > +	void __iomem **legacy_iomap_table;
> > +
> > +	if (bar >=3D PCI_STD_NUM_BARS)
> > +		return -EINVAL;
> > +
> > +	legacy_iomap_table =3D (void __iomem **)pcim_iomap_table(pdev);
> > +	if (!legacy_iomap_table)
> > +		return -ENOMEM;
> > +
> > +	/* The legacy mechanism doesn't allow for duplicate mappings. */
> > +	WARN_ON(legacy_iomap_table[bar]);
> > +
>=20
> Ever since this patch has been applied, I see this warning on all hppa
> (parisc) systems.
>=20
> [=C2=A0=C2=A0=C2=A0 0.978177] WARNING: CPU: 0 PID: 1 at drivers/pci/devre=
s.c:473 pcim_add_mapping_to_legacy_table.part.0+0x54/0x80
> [=C2=A0=C2=A0=C2=A0 0.978850] Modules linked in:
> [=C2=A0=C2=A0=C2=A0 0.979277] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not ta=
inted 6.18.0-rc6-64bit+ #1 NONE
> [=C2=A0=C2=A0=C2=A0 0.979519] Hardware name: 9000/785/C3700
> [=C2=A0=C2=A0=C2=A0 0.979715]
> [=C2=A0=C2=A0=C2=A0 0.979768]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 YZrvWESTHLNXB=
CVMcbcbcbcbOGFRQPDI
> [=C2=A0=C2=A0=C2=A0 0.979886] PSW: 00001000000001000000000000001111 Not t=
ainted
> [=C2=A0=C2=A0=C2=A0 0.980006] r00-03=C2=A0 000000000804000f 00000000414e1=
0a0 0000000040acb300 00000000434b1440
> [=C2=A0=C2=A0=C2=A0 0.980167] r04-07=C2=A0 00000000414a78a0 0000000000029=
000 0000000000000000 0000000043522000
> [=C2=A0=C2=A0=C2=A0 0.980314] r08-11=C2=A0 0000000000000000 0000000000000=
008 0000000000000000 00000000434b0de8
> [=C2=A0=C2=A0=C2=A0 0.980461] r12-15=C2=A0 00000000434b11b0 000000004156a=
8a0 0000000043c655a0 0000000000000000
> [=C2=A0=C2=A0=C2=A0 0.980608] r16-19=C2=A0 000000004016e080 000000004019e=
7d8 0000000000000030 0000000043549780
> [=C2=A0=C2=A0=C2=A0 0.981106] r20-23=C2=A0 0000000020000000 0000000000000=
000 000000000800000e 0000000000000000
> [=C2=A0=C2=A0=C2=A0 0.981317] r24-27=C2=A0 0000000000000000 0000000008000=
00f 0000000043522260 00000000414a78a0
> [=C2=A0=C2=A0=C2=A0 0.981480] r28-31=C2=A0 00000000436af480 00000000434b1=
680 00000000434b14d0 0000000000027000
> [=C2=A0=C2=A0=C2=A0 0.981641] sr00-03=C2=A0 0000000000000000 000000000000=
0000 0000000000000000 0000000000000000
> [=C2=A0=C2=A0=C2=A0 0.981805] sr04-07=C2=A0 0000000000000000 000000000000=
0000 0000000000000000 0000000000000000
> [=C2=A0=C2=A0=C2=A0 0.981972]
> [=C2=A0=C2=A0=C2=A0 0.982024] IASQ: 0000000000000000 0000000000000000 IAO=
Q: 0000000040acb31c 0000000040acb320
> [=C2=A0=C2=A0=C2=A0 0.982185]=C2=A0 IIR: 03ffe01f=C2=A0=C2=A0=C2=A0 ISR: =
0000000000000000=C2=A0 IOR: 00000000436af410
> [=C2=A0=C2=A0=C2=A0 0.982322]=C2=A0 CPU:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0=C2=A0=C2=A0 CR30: 0000000043549780 CR31: 0000000000000000
> [=C2=A0=C2=A0=C2=A0 0.982458]=C2=A0 ORIG_R28: 00000000434b16b0
> [=C2=A0=C2=A0=C2=A0 0.982548]=C2=A0 IAOQ[0]: pcim_add_mapping_to_legacy_t=
able.part.0+0x54/0x80
> [=C2=A0=C2=A0=C2=A0 0.982733]=C2=A0 IAOQ[1]: pcim_add_mapping_to_legacy_t=
able.part.0+0x58/0x80
> [=C2=A0=C2=A0=C2=A0 0.982871]=C2=A0 RP(r2): pcim_add_mapping_to_legacy_ta=
ble.part.0+0x38/0x80
> [=C2=A0=C2=A0=C2=A0 0.983100] Backtrace:
> [=C2=A0=C2=A0=C2=A0 0.983439]=C2=A0 [<0000000040acba1c>] pcim_iomap+0xc4/=
0x170
> [=C2=A0=C2=A0=C2=A0 0.983577]=C2=A0 [<0000000040ba3e4c>] serial8250_pci_s=
etup_port+0x8c/0x168
> [=C2=A0=C2=A0=C2=A0 0.983725]=C2=A0 [<0000000040ba7588>] setup_port+0x38/=
0x50
> [=C2=A0=C2=A0=C2=A0 0.983837]=C2=A0 [<0000000040ba7d94>] pci_hp_diva_setu=
p+0x8c/0xd8
> [=C2=A0=C2=A0=C2=A0 0.983957]=C2=A0 [<0000000040baa47c>] pciserial_init_p=
orts+0x2c4/0x358
> [=C2=A0=C2=A0=C2=A0 0.984088]=C2=A0 [<0000000040baa8bc>] pciserial_init_o=
ne+0x31c/0x330
> [=C2=A0=C2=A0=C2=A0 0.984214]=C2=A0 [<0000000040abfab4>] pci_device_probe=
+0x194/0x270
>=20
> Looking into serial8250_pci_setup_port():
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pci_resource_flags(dev, ba=
r) & IORESOURCE_MEM) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (!pcim_iomap(dev, bar, 0) && !pcim_iomap_table(dev))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -=
ENOMEM;

Strange. From the code I see here the WARN_ON in
pcim_add_mapping_to_legacy_table() should not fire. I suspect that it's
actually triggered somewhere else.

>=20
> This suggests that the failure is expected. I can see that pcim_iomap_tab=
le()
> is deprecated, and that one is supposed to use pcim_iomap() instead. Howe=
ver,
> pcim_iomap() _is_ alrady used, and I don't see a function which lets the
> caller replicate what is done above (attach multiple serial ports to the
> same PCI bar).

Is serial8250_pci_setup_port() invoked in a loop somewhere? Where does
the "attach multiple" happen?

>=20
> How would you suggest to fix the problem ?

I suggest you try to remove the `&& pcim_iomap_table(dev)` from above
to see if that's really the cause. pcim_iomap() already creates the
table, and if it succeeds the table has been created with absolute
certainty. The entries will also be present. So the table-check is
surplus.

Report back please if that helps, I'd want to understand what's
happening here.


Regards
P.


