Return-Path: <linux-pci+bounces-6687-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 733EB8B31FA
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 10:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2653C2834B7
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 08:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE76A13C8F6;
	Fri, 26 Apr 2024 08:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUu67gYV"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ECA13C8F0
	for <linux-pci@vger.kernel.org>; Fri, 26 Apr 2024 08:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714118831; cv=none; b=Yel/q4zuFkDTwdicQc+n7ECXB+Shm+5oNvlSW0IeqBVJX/6HG4Q3/cfD6HvHSu9K4kEQ6/SZ8i8g7AKee6VSLlIHuWN7TdIxEhcoYKPnztRz92jF/GK8aJWXtz9G8V+BgLTnuFjJiHqiNKCWUUWERJyiDpy6qre/H+JK2bC3Xd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714118831; c=relaxed/simple;
	bh=TGAcZesai+U0xVAWvA7J/MAJQ7c0rregms0Ggpsl5S0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q3y7k5W+DML/T4GdKeOJtKo9zXhqLR98glDGKSIP2jmKiFy1ABEekdMPFlJTQbOr4HkJLH8n+UBSt7YBpmwk0PIMGy3VGQUEiCkxDNmt7OetilIjjtz/Pgo03rdQrHE5840mogEEF67ohTlvuDqQIpBmYYWR+h7tTFVypFTnGlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iUu67gYV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714118829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TGAcZesai+U0xVAWvA7J/MAJQ7c0rregms0Ggpsl5S0=;
	b=iUu67gYVsOfcyjG+kN3vXsAneSSnXQkTVp9hfFTqttetZvbqD2FJIP0w/pGLoKykusMSgJ
	lZm92ZXTg09PD58PrG7IzWi32fqknR0KAfpDVvjz1+KJl88UGqzI+pF6zB0G+s0yE4a+F8
	No+6drArGznBHC5gFVATD0FULwLFf0Y=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-1t7mEoqENA22zZmDu4ECZQ-1; Fri, 26 Apr 2024 04:07:07 -0400
X-MC-Unique: 1t7mEoqENA22zZmDu4ECZQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-434ed2e412fso5817371cf.0
        for <linux-pci@vger.kernel.org>; Fri, 26 Apr 2024 01:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714118827; x=1714723627;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TGAcZesai+U0xVAWvA7J/MAJQ7c0rregms0Ggpsl5S0=;
        b=Lt+ZxmFy3d04Iu7XDKhhjvTlix3/Cs2igd4t+G6qsje1FKQkeVQAE80u2xE30UWhsM
         lpMN6hKO/hxZr41ly2ZXnXPVaEhkGIVZ7BxpbZyJlKbkbmmwmaw7HL+nYzAOSfxetasD
         61I+UGtgJyjassul2ghPP6xhvZTTh0REfo7dfEXCyFWQEgv0qzU6zwQ9KEIG7FMa8JWF
         I6KSBb+8MpMYPEDN/3KkDMIubUNhTLJyeaWNuBA6CnJxqI//+8ojWzdU+G2JaVsxxWR3
         MYFG6YWwAjqqq81ywc0da7V7JgG9OSpCF3KmvuzPXwFZr+W4k1hMxfsvsFuu20VDQpHO
         4EuA==
X-Forwarded-Encrypted: i=1; AJvYcCV+MrFB1JYVQPYEMtwC10CHZk0966VYtO6YC5fXFBaUJZCos469uy19dinu2FsCk+vku+yJ68VD0nkLd42QEYobnIgzRtJ99htk
X-Gm-Message-State: AOJu0YzdVAH3VMAu76CnHHIyfsyripYUQE314mvnujhdOgQ7qT0fwjmM
	Rzv/b0Ee+eIoqpFmhEdpRnA1ac/qakTinAqUAUmG0xt8kPLUqBFivOz1nNTWlOIW5tRgW8Pr4Ji
	nGKe3wyPtc9swwjikdxGIDMxTdCIogXrdCGrzv7Xt2h9Gq01m6sSAwtG/Jw==
X-Received: by 2002:a05:6214:4008:b0:6a0:b2e4:583c with SMTP id kd8-20020a056214400800b006a0b2e4583cmr268839qvb.3.1714118826876;
        Fri, 26 Apr 2024 01:07:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9/G3aBbIJJGde1rRzmHIwatW3ktBZ39Vo5CZV6c+UaHMj1uKk0ppHJzc4RWsj3GbzINlW+w==
X-Received: by 2002:a05:6214:4008:b0:6a0:b2e4:583c with SMTP id kd8-20020a056214400800b006a0b2e4583cmr268820qvb.3.1714118826480;
        Fri, 26 Apr 2024 01:07:06 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id y18-20020a0c9a92000000b0069f77a0079fsm7761670qvd.34.2024.04.26.01.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 01:07:06 -0700 (PDT)
Message-ID: <77ee27e2f155abd340b166e2856181577fdf08cc.camel@redhat.com>
Subject: Re: [PATCH v6 00/10] Make PCI's devres API more consistent
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, Sam
 Ravnborg <sam@ravnborg.org>, dakr@redhat.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org
Date: Fri, 26 Apr 2024 10:07:02 +0200
In-Reply-To: <20240424201229.GA503230@bhelgaas>
References: <20240424201229.GA503230@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-24 at 15:12 -0500, Bjorn Helgaas wrote:
> On Mon, Apr 08, 2024 at 10:44:12AM +0200, Philipp Stanner wrote:
> > ...
> > PCI's devres API suffers several weaknesses:
> >=20
> > 1. There are functions prefixed with pcim_. Those are always
> > managed
> > =C2=A0=C2=A0 counterparts to never-managed functions prefixed with pci_=
 =E2=80=93 or
> > so one
> > =C2=A0=C2=A0 would like to think. There are some apparently unmanaged
> > functions
> > =C2=A0=C2=A0 (all region-request / release functions, and pci_intx()) w=
hich
> > =C2=A0=C2=A0 suddenly become managed once the user has initialized the =
device
> > with
> > =C2=A0=C2=A0 pcim_enable_device() instead of pci_enable_device(). This
> > "sometimes
> > =C2=A0=C2=A0 yes, sometimes no" nature of those functions is confusing =
and
> > =C2=A0=C2=A0 therefore bug-provoking. In fact, it has already caused a =
bug in
> > DRM.
> > =C2=A0=C2=A0 The last patch in this series fixes that bug.
> > 2. iomappings: Instead of giving each mapping its own callback, the
> > =C2=A0=C2=A0 existing API uses a statically allocated struct tracking o=
ne
> > mapping
> > =C2=A0=C2=A0 per bar. This is not extensible. Especially, you can't cre=
ate
> > =C2=A0=C2=A0 _ranged_ managed mappings that way, which many drivers wan=
t.
> > 3. Managed request functions only exist as "plural versions" with a
> > =C2=A0=C2=A0 bit-mask as a parameter. That's quite over-engineered
> > considering
> > =C2=A0=C2=A0 that each user only ever mapps one, maybe two bars.
> >=20
> > This series:
> > - add a set of new "singular" devres functions that use devres the
> > way
> > =C2=A0 its intended, with one callback per resource.
> > - deprecates the existing iomap-table mechanism.
> > - deprecates the hybrid nature of pci_ functions.
> > - preserves backwards compatibility so that drivers using the
> > existing
> > =C2=A0 API won't notice any changes.
> > - adds documentation, especially some warning users about the
> > =C2=A0 complicated nature of PCI's devres.
>=20
> There's a lot of good work here; thanks for working on it.

Thanks!
Good to get some more feedback from you

>=20
> > Philipp Stanner (10):
> > =C2=A0 PCI: Add new set of devres functions
>=20
> This first patch adds some infrastructure and several new exported
> interfaces:
>=20
> =C2=A0 void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
> const char *name)
> =C2=A0 void pcim_iounmap_region(struct pci_dev *pdev, int bar)
> =C2=A0 int pcim_request_region(struct pci_dev *pdev, int bar, const char
> *name)
> =C2=A0 void pcim_release_region(struct pci_dev *pdev, int bar)
> =C2=A0 void __iomem *pcim_iomap_range(struct pci_dev *pdev, int bar,
> =C2=A0 void __iomem *pcim_iomap_region_range(struct pci_dev *pdev, int
> bar,
> =C2=A0 void pcim_iounmap_region_range(struct pci_dev *pdev, int bar,
>=20
> > =C2=A0 PCI: Deprecate iomap-table functions
>=20
> This adds a little bit of infrastructure (add/remove to
> legacy_table),
> reimplements these existing interfaces:
>=20
> =C2=A0 void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned
> long maxlen)
> =C2=A0 void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr)
> =C2=A0 int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char
> *name)
> =C2=A0 int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
> =C2=A0 void pcim_iounmap_regions(struct pci_dev *pdev, int mask)
>=20
> and adds a couple new exported interfaces:
>=20
> =C2=A0 void pcim_release_all_regions(struct pci_dev *pdev)
> =C2=A0 int pcim_request_all_regions(struct pci_dev *pdev, const char
> *name)
>=20
> There's a lot going on in these two patches, so they're hard to
> review.=C2=A0 I think it would be easier if you could do the fixes to
> existing interfaces first,

I agree that the patches can be further split into smaller chunks to
make them more atomic and easier to review. I can do that.

BUT I'd need some more details about what you mean by "do the fixes
first" =E2=80=93 which fixes?
The later patches at least in part rely on the new better functions
being available.


> followed by adding new things, maybe
> something like separate patches that:
>=20
> =C2=A0 - Add pcim_addr_devres_alloc(), pcim_addr_devres_free(),
> =C2=A0=C2=A0=C2=A0 pcim_addr_devres_clear().
>=20
> =C2=A0 - Add pcim_add_mapping_to_legacy_table(),
> =C2=A0=C2=A0=C2=A0 pcim_remove_mapping_from_legacy_table(),
> =C2=A0=C2=A0=C2=A0 pcim_remove_bar_from_legacy_table().
>=20
> =C2=A0 - Reimplement pcim_iomap(), pcim_iomap_regions(), pcim_iounmap().
>=20
> =C2=A0 - Add new interfaces like pcim_iomap_region(),
> =C2=A0=C2=A0=C2=A0 pcim_request_region(), etc.
>=20
> =C2=A0=C2=A0=C2=A0 AFAICS, except for pcim_iomap_range() (used by vbox), =
these new
> =C2=A0=C2=A0=C2=A0 interfaces have no users outside drivers/pci, so ... w=
e might
> =C2=A0=C2=A0=C2=A0 defer adding them, or at least defer exposing them via
> =C2=A0=C2=A0=C2=A0 include/linux/pci.h, until we have users for them.

Dropping (the export of) functions like pcim_request_region_range() or
pcim_request_all_regions() is not a problem.

What I quite fundamentally have to disagree with, however, is not to
export the functions=C2=A0

 * pcim_request_region()
 * pcim_iomap_region()

the main point of this series is to deprecate that hybrid nature of
those existing pci_* functions. You can only deprecate something when
you provide users with new, better alternatives.

Not exporting them would inevitably tempt driver programmers into using
pcim_enable_device() + pci_*() as they did so far, which caused at
least that leak in vboxvideo and another one that my plan was to
address after we got this merged.

Once we have those new pcim_ functions exported, we could successively
port the older drivers which use the aforementioned combination with
pcim_enable_device().
Then we could drop the hybrid nature of pci_ functions once and for all
and would end up with a consistent, clean API.

I intended to do that over the months after we merged this.

So I'd suggest let me cancel the export of the "luxury functions" and
let's keep the two listed above exported


P.

>=20
> > =C2=A0 PCI: Warn users about complicated devres nature
> > =C2=A0 PCI: Make devres region requests consistent
> > =C2=A0 PCI: Move dev-enabled status bit to struct pci_dev
> > =C2=A0 PCI: Move pinned status bit to struct pci_dev
> > =C2=A0 PCI: Give pcim_set_mwi() its own devres callback
> > =C2=A0 PCI: Give pci(m)_intx its own devres callback
> > =C2=A0 PCI: Remove legacy pcim_release()
> > =C2=A0 drm/vboxvideo: fix mapping leaks
> >=20
> > =C2=A0drivers/gpu/drm/vboxvideo/vbox_main.c |=C2=A0=C2=A0 20 +-
> > =C2=A0drivers/pci/devres.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1011
> > +++++++++++++++++++++----
> > =C2=A0drivers/pci/iomap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 18 +
> > =C2=A0drivers/pci/pci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 123 ++-
> > =C2=A0drivers/pci/pci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 21 +-
> > =C2=A0include/linux/pci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 18 +-
> > =C2=A06 files changed, 999 insertions(+), 212 deletions(-)
> >=20
> > --=20
> > 2.44.0
> >=20
>=20


