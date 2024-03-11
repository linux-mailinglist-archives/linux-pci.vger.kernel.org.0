Return-Path: <linux-pci+bounces-4721-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B94E877F3E
	for <lists+linux-pci@lfdr.de>; Mon, 11 Mar 2024 12:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B8F3281371
	for <lists+linux-pci@lfdr.de>; Mon, 11 Mar 2024 11:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDFE3B794;
	Mon, 11 Mar 2024 11:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ePJOnNRv"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACD03A8DD
	for <linux-pci@vger.kernel.org>; Mon, 11 Mar 2024 11:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710157523; cv=none; b=Y62iAob2WiljAvQI9gwJgM0D7Uv0RBM8ahWOv5+wzC9c/CC+NVbwp6Mw0P55esUqKXvWlzxJxn/7ObHCKmwTRKj6PJ9aSYxUAE1xjdLHba3gsUwlhsltiCpCPz594f9JsX0x2Pd5yjtCB1Uut6OtMtACtG4Rm79PtVly7Us+aao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710157523; c=relaxed/simple;
	bh=EcNEaZMVk3aPUICbNCmMENQZ7/vKgD6kDbgmJolx/hs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bZTAvUDyREDKJ8rl/n26uENPJs9nzW7Nw4V93OE9yLq+GWYjW2idx6bi/lBxZkKN8r1MtbmJ1EQw6hXat/rx54ETzfKVr5HCA/xOcwJ3WR0aOQxtGvryZgjSE4ZBw6YSPj2OW0rZPnRX2bsxwQY96bShLQ8yH9/9XolsZoyCH8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ePJOnNRv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710157520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EcNEaZMVk3aPUICbNCmMENQZ7/vKgD6kDbgmJolx/hs=;
	b=ePJOnNRvepBgf8n8N77cnF9mBdRx2CFQxuRo2iAHYujENXBm1kCdkZQVvkOc5q6+jbhL5B
	yfDw9xCTAxHRRwj0nykZVikUJGRm888rFMaWhzxFUXm2JdXSvOCGasg9br+cVexYdn0YIt
	NI5wa0YqLTHAoOrQWIAvh85omZbqmj8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-PewoAhIMMgqqgq_I3exADA-1; Mon, 11 Mar 2024 07:45:18 -0400
X-MC-Unique: PewoAhIMMgqqgq_I3exADA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-56827399088so674912a12.0
        for <linux-pci@vger.kernel.org>; Mon, 11 Mar 2024 04:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710157517; x=1710762317;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EcNEaZMVk3aPUICbNCmMENQZ7/vKgD6kDbgmJolx/hs=;
        b=hU75eUMGaWCGl+46rFTJIuDRW4bp1TRkRv2tG446Ldkyc4Z9mWMJUkgiHGlVCL6gE8
         oG89BsIo4SwMklZkY71117xtREDliyIYuHx5i29cKSZnhjgWrpVHAtAOr/to2QVz7Nof
         8wiLPhJUhzpu/tkbx0BDvn1joyUuGyxh1odL5XH04hQbnnvZJq/YaP0dJLAya6VYR0Ak
         AyEAFvIGLM2Q0MgEl4XyLeTmMKg3Aclfiqc3wfRVhaIYZ5slg91PFfgtllfRIIVSxDol
         RirIqwUcpoTNPNlH7KoP1ufOUvzdOsnIhVFykHD4/QRUuOw8cS50QMp8rGOtk6hUZ92N
         xU8w==
X-Forwarded-Encrypted: i=1; AJvYcCWFwYm0iaac2JH8Q6PWdEsP9r+KXb3RIYi4XBFbo1/9OugFX9vxSWEwNfACRQ6gBzwtsvfPqP1vXmvdrEPoMaKYGiJTco0grBzJ
X-Gm-Message-State: AOJu0Yw6U5xx6HomR5H+JH/swP21Q1hxQ6rJWXKms53kDQean48ejCmR
	lmijH8nXa3ibAzrOHFUxCJbfKD3j2eanJ7WY+Ob811hzJhppfPF+U6sR3jJmLMMFhuIkugmatWL
	7tKzR6hpYS+aP7S90mYH6JcsdBpmzmaRj82V0b06iWmTh13joNKl8fNWQZA==
X-Received: by 2002:a05:6402:3884:b0:568:4b96:36d2 with SMTP id fd4-20020a056402388400b005684b9636d2mr3389008edb.2.1710157517768;
        Mon, 11 Mar 2024 04:45:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZxthictsCT7kiFqPXiANc0599HzfXAwKn859lfAHV1rT6UpTe08qMtRLSkmAxkb65LOECOg==
X-Received: by 2002:a05:6402:3884:b0:568:4b96:36d2 with SMTP id fd4-20020a056402388400b005684b9636d2mr3388970edb.2.1710157517001;
        Mon, 11 Mar 2024 04:45:17 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (p200300d967002a00b6f567b28c2df44b.dip0.t-ipconnect.de. [2003:d9:6700:2a00:b6f5:67b2:8c2d:f44b])
        by smtp.gmail.com with ESMTPSA id s27-20020a50d49b000000b0056729e902f7sm2997003edi.56.2024.03.11.04.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 04:45:16 -0700 (PDT)
Message-ID: <e1e0044a364b218fea285b1c9e80d925ad4c9d90.camel@redhat.com>
Subject: Re: [PATCH v4 00/10] Make PCI's devres API more consistent
From: Philipp Stanner <pstanner@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, Sam
 Ravnborg <sam@ravnborg.org>, dakr@redhat.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Date: Mon, 11 Mar 2024 12:45:15 +0100
In-Reply-To: <20240301112959.21947-1-pstanner@redhat.com>
References: <20240301112959.21947-1-pstanner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Gentle ping because the Merge Window opened 8-)

On Fri, 2024-03-01 at 12:29 +0100, Philipp Stanner wrote:
> This v4 now can (hopefully) be applied to linux-next, but not to
> mainline/master.
>=20
> Changes in v4:
> =C2=A0 - Rebase against linux-next
>=20
> Changes in v3:
> =C2=A0 - Use the term "PCI devres API" at some forgotten places.
> =C2=A0 - Fix more grammar errors in patch #3.
> =C2=A0 - Remove the comment advising to call (the outdated) pcim_intx() i=
n
> pci.c
> =C2=A0 - Rename __pcim_request_region_range() flags-field "exclusive" to
> =C2=A0=C2=A0=C2=A0 "req_flags", since this is what the int actually repre=
sents.
> =C2=A0 - Remove the call to pcim_region_request() from patch #10. (Hans)
>=20
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
> =C2=A0 - Make pcim_intx() visible only for the PCI subsystem so that
> new=C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 drivers won't use this outdated API (Andy, Myself)
> =C2=A0 - Add a NOTE to pcim_iomap() to warn about this function being
> the=C2=A0=C2=A0=C2=A0 onee
> =C2=A0=C2=A0=C2=A0 xception that does just return NULL.
> =C2=A0 - Consistently use the term "PCI devres API"; also in Patch #10
> (Bjorn)
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
> =C2=A0 PCI: Add new set of devres functions
> =C2=A0 PCI: Deprecate iomap-table functions
> =C2=A0 PCI: Warn users about complicated devres nature
> =C2=A0 PCI: Make devres region requests consistent
> =C2=A0 PCI: Move dev-enabled status bit to struct pci_dev
> =C2=A0 PCI: Move pinned status bit to struct pci_dev
> =C2=A0 PCI: Give pcim_set_mwi() its own devres callback
> =C2=A0 PCI: Give pci(m)_intx its own devres callback
> =C2=A0 PCI: Remove legacy pcim_release()
> =C2=A0 drm/vboxvideo: fix mapping leaks
>=20
> =C2=A0drivers/gpu/drm/vboxvideo/vbox_main.c |=C2=A0=C2=A0 20 +-
> =C2=A0drivers/pci/devres.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1013 ++++++++++=
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
=C2=A0=C2=A0 21 +-
> =C2=A0include/linux/pci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
18 +-
> =C2=A06 files changed, 1001 insertions(+), 212 deletions(-)
>=20


