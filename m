Return-Path: <linux-pci+bounces-2477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A2B838BA4
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 11:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE8471F25E3C
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 10:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695D55A788;
	Tue, 23 Jan 2024 10:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OPH5xail"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A355A11C
	for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2024 10:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706005409; cv=none; b=KZFXPMIutZDxTMgavTg+sE4IV0JEa+Ep1g5EWqIS3UfEegxAFbZvK6+MZm4/L0d9T6aivPfDfHaECnOtZFHnxJLhVdpqsSnEYTBx3vDFAgKVdCZgOTGDhCea4x/O5CYReDzDLL9kl+jv2pGSeD5eUa7WCHULG1oB0t3vAzJnhyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706005409; c=relaxed/simple;
	bh=H02eA1JDGkow8TUG7Xi9rs7v7agisQt1t/WZcMgxK70=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PBHc9YBcLh3A66tNsqkbI+tunJYfcMBGDxQAV+Sp7OoasKoFADZy15N/nWFReFQIlTkIE7l456jLxL3sA6PMI7FNdpL3WBW94ROoReSQ9Imtd7lnzqWlCWUR7jy8TINWjdQbIg51thmWulCTojyJoZkijtAZPVAPrp6/GyqnJvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OPH5xail; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706005406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OnxS8TUXze8cVtdA6154n5Rqo7M9l26NFn0F0PoNH8E=;
	b=OPH5xail/o64/auwWVT2TnIfxxTxV5nkdV/EC4AXV7JhEs4duuED1XV/YTXtzIcnzCIccM
	aVuVDF+mzHN8UP1Ngk6uN0XT04blCNiXg0QbWV3mijmOWPeOhUcZjx72GBrdMUfmFOgDvw
	WVsNDHA89SmYfEydf2yKLtOTYrIp5Ts=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-1myRAofYPDGsw58uNYDmAw-1; Tue, 23 Jan 2024 05:23:24 -0500
X-MC-Unique: 1myRAofYPDGsw58uNYDmAw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-78313358d3bso125403285a.0
        for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2024 02:23:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706005404; x=1706610204;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OnxS8TUXze8cVtdA6154n5Rqo7M9l26NFn0F0PoNH8E=;
        b=YXeBkT4A7FEXj816JtX+m4MU9JJf+Etgb2gbm7/TIDRsALyvykAuwdfENljYKz+qBp
         Nne/mFigI7S7P5CclO9a5QsoK2jFVY2bnDhxbAyuThxHXd+puZOWi6rF80XZ1S/ZfpCQ
         LJAPUoYYpgZtLvgdd0WOilMWmmQ9krHIYXb0o8u2FtOhxRuBhIGkyAEwCKTUSowMBWRS
         3PC1XYBZBKiZvVzreV6umDceuF36zWvL0XXbydNV9dAh+5XOuHzGMeUsIN3B+nqizC7o
         9HcuDcooeXKh8nlocJo6UkWPkSHhp6xCdfgaTOH8fqT+4t70o5ho/wmUQ114ZRFvs7G6
         wRAw==
X-Gm-Message-State: AOJu0YzS6Z+0khqlqrRla8GxeAgplLAUorzmc7W/KB7exNauB5YQBFmz
	wO1sC9UdEeZstDrROyiG8xr9ueYj+kYtcww8tvdr1g/+pBGh4o2uYwexHi74j3VLr+hGTos3dPa
	o8WaU/WDaH2QUQEGECsIFJ0PeVsTn+SCyUd8YFJHjXsUX+KcKD5jQIXTiQA==
X-Received: by 2002:a05:620a:1a26:b0:783:88e1:5221 with SMTP id bk38-20020a05620a1a2600b0078388e15221mr10976654qkb.6.1706005404052;
        Tue, 23 Jan 2024 02:23:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9GfusdFoULGiTnMXwI+zcNJUBSCsfSKoWHpn+j+OQKvKW7sF0qqOHjpzmwKekN7gRPPL31w==
X-Received: by 2002:a05:620a:1a26:b0:783:88e1:5221 with SMTP id bk38-20020a05620a1a2600b0078388e15221mr10976638qkb.6.1706005403799;
        Tue, 23 Jan 2024 02:23:23 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id t8-20020a05620a034800b00783a206381csm1341717qkm.37.2024.01.23.02.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 02:23:23 -0800 (PST)
Message-ID: <3b2746f7779aa5dc39a406593dae37c4a8da676d.camel@redhat.com>
Subject: Re: [PATCH v2 00/10] Make PCI's devres API more consistent
From: Philipp Stanner <pstanner@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>, Hans de Goede <hdegoede@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Bjorn Helgaas
 <bhelgaas@google.com>, Sam Ravnborg <sam@ravnborg.org>, dakr@redhat.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
Date: Tue, 23 Jan 2024 11:23:20 +0100
In-Reply-To: <20240123094317.15958-1-pstanner@redhat.com>
References: <20240123094317.15958-1-pstanner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Forgot to add a few changes to the changelog:

On Tue, 2024-01-23 at 10:42 +0100, Philipp Stanner wrote:
> Changes in v2:
> =C2=A0 - Make commit head lines congruent with PCI's style (Bjorn)
> =C2=A0 - Add missing error checks for devm_add_action(). (Andy)
> =C2=A0 - Repair the "Returns: " marks for docu generation (Andy)
> =C2=A0 - Initialize the addr_devres struct with memset(). (Andy)
> =C2=A0 - Make pcim_intx() a PCI-internal function so that new drivers
> won't
> =C2=A0=C2=A0=C2=A0 be encouraged to use the outdated pci_intx() mechanism=
.
> =C2=A0=C2=A0=C2=A0 (Andy / Philipp)
> =C2=A0 - Fix grammar and spelling (Bjorn)
> =C2=A0 - Be more precise on why pcim_iomap_table() is problematic (Bjorn)
> =C2=A0 - Provide the actual structs' and functions' names in the commit
> =C2=A0=C2=A0=C2=A0 messages (Bjorn)
> =C2=A0 - Remove redundant variable initializers (Andy)
> =C2=A0 - Regroup PM bitfield members in struct pci_dev (Andy)
> =C2=A0 - Consistently use the term "PCI devres API"; also in Patch #10
> (Bjorn)

 * Make pcim_intx() visible only for the PCI subsystem so that new   =20
   drivers won't use this outdated API (Andy, Myself)
 * Add a NOTE to pcim_iomap() to warn about this function being the    onee
   xception that does just return NULL.

This v2 now contains most of the feedback, except the ones Andy and I
haven't agreed on yet.

Thx,
P.

>=20
>=20
> =C2=A1Hola!
>=20
> PCI's devres API suffers several weaknesses:
>=20
> 1. There are functions prefixed with pcim_. Those are always managed
> =C2=A0=C2=A0 counterparts to never-managed functions prefixed with pci_ =
=E2=80=93 or so
> one
> =C2=A0=C2=A0 would like to think. There are some apparently unmanaged fun=
ctions
> =C2=A0=C2=A0 (all region-request / release functions, and pci_intx()) whi=
ch
> =C2=A0=C2=A0 suddenly become managed once the user has initialized the de=
vice
> with
> =C2=A0=C2=A0 pcim_enable_device() instead of pci_enable_device(). This
> "sometimes
> =C2=A0=C2=A0 yes, sometimes no" nature of those functions is confusing an=
d
> =C2=A0=C2=A0 therefore bug-provoking. In fact, it has already caused a bu=
g in
> DRM.
> =C2=A0=C2=A0 The last patch in this series fixes that bug.
> 2. iomappings: Instead of giving each mapping its own callback, the
> =C2=A0=C2=A0 existing API uses a statically allocated struct tracking one
> mapping
> =C2=A0=C2=A0 per bar. This is not extensible. Especially, you can't creat=
e
> =C2=A0=C2=A0 _ranged_ managed mappings that way, which many drivers want.
> 3. Managed request functions only exist as "plural versions" with a
> =C2=A0=C2=A0 bit-mask as a parameter. That's quite over-engineered consid=
ering
> =C2=A0=C2=A0 that each user only ever mapps one, maybe two bars.
>=20
> This series:
> - add a set of new "singular" devres functions that use devres the
> way
> =C2=A0 its intended, with one callback per resource.
> - deprecates the existing iomap-table mechanism.
> - deprecates the hybrid nature of pci_ functions.
> - preserves backwards compatibility so that drivers using the
> existing
> =C2=A0 API won't notice any changes.
> - adds documentation, especially some warning users about the
> =C2=A0 complicated nature of PCI's devres.
>=20
>=20
> Note that this series is based on my "unify pci_iounmap"-series from
> a
> few weeks ago. [1]
>=20
> I tested this on a x86 VM with a simple pci test-device with two
> regions. Operates and reserves resources as intended on my system.
> Kasan and kmemleak didn't find any problems.
>=20
> I believe this series cleans the API up as much as possible without
> having to port all existing drivers to the new API. Especially, I
> think
> that this implementation is easy to extend if the need for new
> managed
> functions arises :)
>=20
> Greetings,
> P.
>=20
> Philipp Stanner (10):
> =C2=A0 PCI: add new set of devres functions
> =C2=A0 PCI: deprecate iomap-table functions
> =C2=A0 PCI: warn users about complicated devres nature
> =C2=A0 PCI: make devres region requests consistent
> =C2=A0 PCI: move dev-enabled status bit to struct pci_dev
> =C2=A0 PCI: move pinned status bit to struct pci_dev
> =C2=A0 PCI: give pcim_set_mwi() its own devres callback
> =C2=A0 PCI: give pci(m)_intx its own devres callback
> =C2=A0 PCI: remove legacy pcim_release()
> =C2=A0 drm/vboxvideo: fix mapping leaks
>=20
> =C2=A0Documentation/driver-api/pci/pci.rst=C2=A0 |=C2=A0=C2=A0=C2=A0 3 +
> =C2=A0drivers/gpu/drm/vboxvideo/vbox_main.c |=C2=A0=C2=A0 24 +-
> =C2=A0drivers/pci/devres.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1015 ++++++++++=
+++++++++++--
> --
> =C2=A0drivers/pci/iomap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
18 +
> =C2=A0drivers/pci/pci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 123 ++-
> =C2=A0drivers/pci/pci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 25 +-
> =C2=A0include/linux/pci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
18 +-
> =C2=A07 files changed, 1011 insertions(+), 215 deletions(-)
>=20


