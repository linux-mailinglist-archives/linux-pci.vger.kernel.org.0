Return-Path: <linux-pci+bounces-7145-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5728BDCF8
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 10:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02A062851E5
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 08:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8712413C9A7;
	Tue,  7 May 2024 08:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sk4iW552"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467CC13C91C
	for <linux-pci@vger.kernel.org>; Tue,  7 May 2024 08:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715069506; cv=none; b=Ez4Mf9cXzexcAKN6RVXDXYbi31turEUIYkADWggnY5G/iPf1beQJ1H0gfxtybGZ3Nw6e2Xd7zHRf2cBvSYvWZsQUcc8nXYQkzjLMvG1jZpv+1nSRXB99JN8FfnAZJ8K5NCZ5ldlnO62KncIumv4jCXX2eLsWNxzJVWgLyWPYa+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715069506; c=relaxed/simple;
	bh=Q1WtGpJ/PqnOdfl24h9oU0yMCxyLbKUfiHt5Vr8Pucw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iAf/l71Q9lRqxogON5QQ+ezqjgMR1o3wZb6+0j/aSnwgK+8Tod0HHnxhXzvClbZLbRs5x4wY+grNWDh6zse3vGutbdsAi/Akh6uYLlgC5qNQQSb3Dhk8KkLdA4FXHklTfC95qwO4D9VbbN+o1j4OtjtXeSkV2YPZJ2UALSighjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sk4iW552; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715069503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=97EnrSmoY+vqswtinWEF90pPBNS1du8dFQW0Vh3EGhg=;
	b=Sk4iW5527JVJQqxhv0B3F8WMp0UAnXlPSwHin4F3Vca8exrBKju9eMoz8W9J7MVkHOBj/G
	9NRRtnLbpC1dBEzz7YXD87WRFjagak34GPUDkThj6tBS+cezNp2CZzGqEghZ59tL/kh3Uu
	QIU6XO+uKBvWrTJxoUdTsJFRehxnKtU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-1QmsMU3PPtybids7T5tppg-1; Tue, 07 May 2024 04:11:41 -0400
X-MC-Unique: 1QmsMU3PPtybids7T5tppg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6a123aaa5b6so3013246d6.2
        for <linux-pci@vger.kernel.org>; Tue, 07 May 2024 01:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715069501; x=1715674301;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=97EnrSmoY+vqswtinWEF90pPBNS1du8dFQW0Vh3EGhg=;
        b=YqNkA46TFpBS1/y2UqkURFLISISl/1z4pGY2+uy+D6XHt62eAMWg0SIzQKXePcMNLC
         B3sP+iQoZ31gWUuxPKGa32NxW15qEYxpcGfOCU1OlZf2uXOwdLGLunyRYHVfRXJJvzZX
         tPUr99vmyEmlzHnbW7A7D7NhSprPTHf5DxoL8ZeXu7dTw3NTCQJznNpvsaLVObC5bjlB
         xmojSn69COIudbsYme1QJMI0tggZQeOGt3lOGzV9Rn0BPPMAH8upFI6QcAS7XUUoph9c
         e72N14E4VJqa/LASrTLFUoVxrlK0TxZIIz2mJR0tHo2rmLhrUOvXlYz8AoLoR/V15/YF
         /4yQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgwB8409xNwRkO7sO5zrtOu34kGoicVAxK4AM4Axh3l1AqrwtkHrbBS7ysgGpYUihvE4QiMZDs39nScYi8b4QNMcrfCAvYR3k6
X-Gm-Message-State: AOJu0Yz4PgcmeZ4NKA1hgBypT+Wcz3YxTOpFXqAru82CJGCbQHF1lCHx
	hsK0SHRTu90nYDcYVY2lEB/+DKTTTvCbPNmuBoTCJGpaXzVz7MPF7FtroD2RsVJH3joRT+nDkdR
	SYix1Uhf6nYE4lnCsFc9TOB/3W6oF18kUBzuS4C45lXlz7bD9QrGoHrGn5w==
X-Received: by 2002:a05:6214:501d:b0:696:b235:f39 with SMTP id jo29-20020a056214501d00b00696b2350f39mr13688428qvb.6.1715069501206;
        Tue, 07 May 2024 01:11:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFeqOJc8IqNgGmZu33Ok/1DP7gT5PQ9QKjlQHeC8Or8EBxR8EsuVNKcoVeuI0e3CuBmBE3YQ==
X-Received: by 2002:a05:6214:501d:b0:696:b235:f39 with SMTP id jo29-20020a056214501d00b00696b2350f39mr13688400qvb.6.1715069500595;
        Tue, 07 May 2024 01:11:40 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ml11-20020a056214584b00b006a0e5cb0254sm4503993qvb.55.2024.05.07.01.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 01:11:40 -0700 (PDT)
Message-ID: <829fbd8671ca770adaf894ce8a3e8fa625739504.camel@redhat.com>
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
Date: Tue, 07 May 2024 10:11:36 +0200
In-Reply-To: <20240426220150.GA608828@bhelgaas>
References: <20240426220150.GA608828@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hey Bjorn,

so I have spent a few hours seeing how we could simplify this series.
Here are my thoughts.


On Fri, 2024-04-26 at 17:01 -0500, Bjorn Helgaas wrote:
> On Fri, Apr 26, 2024 at 10:07:02AM +0200, Philipp Stanner wrote:
> > On Wed, 2024-04-24 at 15:12 -0500, Bjorn Helgaas wrote:
> > > On Mon, Apr 08, 2024 at 10:44:12AM +0200, Philipp Stanner wrote:
> > > > ...
> > > > PCI's devres API suffers several weaknesses:
> > > >=20
> > > > 1. There are functions prefixed with pcim_. Those are always
> > > > managed
> > > > =C2=A0=C2=A0 counterparts to never-managed functions prefixed with =
pci_ =E2=80=93
> > > > or
> > > > so one
> > > > =C2=A0=C2=A0 would like to think. There are some apparently unmanag=
ed
> > > > functions
> > > > =C2=A0=C2=A0 (all region-request / release functions, and pci_intx(=
))
> > > > which
> > > > =C2=A0=C2=A0 suddenly become managed once the user has initialized =
the
> > > > device
> > > > with
> > > > =C2=A0=C2=A0 pcim_enable_device() instead of pci_enable_device(). T=
his
> > > > "sometimes
> > > > =C2=A0=C2=A0 yes, sometimes no" nature of those functions is confus=
ing
> > > > and
> > > > =C2=A0=C2=A0 therefore bug-provoking. In fact, it has already cause=
d a
> > > > bug in
> > > > DRM.
> > > > =C2=A0=C2=A0 The last patch in this series fixes that bug.
> > > > 2. iomappings: Instead of giving each mapping its own callback,
> > > > the
> > > > =C2=A0=C2=A0 existing API uses a statically allocated struct tracki=
ng one
> > > > mapping
> > > > =C2=A0=C2=A0 per bar. This is not extensible. Especially, you can't
> > > > create
> > > > =C2=A0=C2=A0 _ranged_ managed mappings that way, which many drivers=
 want.
> > > > 3. Managed request functions only exist as "plural versions"
> > > > with a
> > > > =C2=A0=C2=A0 bit-mask as a parameter. That's quite over-engineered
> > > > considering
> > > > =C2=A0=C2=A0 that each user only ever mapps one, maybe two bars.
> > > >=20
> > > > This series:
> > > > - add a set of new "singular" devres functions that use devres
> > > > the
> > > > way
> > > > =C2=A0 its intended, with one callback per resource.
> > > > - deprecates the existing iomap-table mechanism.
> > > > - deprecates the hybrid nature of pci_ functions.
> > > > - preserves backwards compatibility so that drivers using the
> > > > existing
> > > > =C2=A0 API won't notice any changes.
> > > > - adds documentation, especially some warning users about the
> > > > =C2=A0 complicated nature of PCI's devres.
> > >=20
> > > There's a lot of good work here; thanks for working on it.
> >=20
> > Thanks!
> > Good to get some more feedback from you
> >=20
> > >=20
> > > > Philipp Stanner (10):
> > > > =C2=A0 PCI: Add new set of devres functions
> > >=20
> > > This first patch adds some infrastructure and several new
> > > exported
> > > interfaces:
> > >=20
> > > =C2=A0 void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
> > > const char *name)
> > > =C2=A0 void pcim_iounmap_region(struct pci_dev *pdev, int bar)
> > > =C2=A0 int pcim_request_region(struct pci_dev *pdev, int bar, const
> > > char
> > > *name)
> > > =C2=A0 void pcim_release_region(struct pci_dev *pdev, int bar)
> > > =C2=A0 void __iomem *pcim_iomap_range(struct pci_dev *pdev, int bar,
> > > =C2=A0 void __iomem *pcim_iomap_region_range(struct pci_dev *pdev, in=
t
> > > bar,
> > > =C2=A0 void pcim_iounmap_region_range(struct pci_dev *pdev, int bar,
> > >=20
> > > > =C2=A0 PCI: Deprecate iomap-table functions
> > >=20
> > > This adds a little bit of infrastructure (add/remove to
> > > legacy_table),
> > > reimplements these existing interfaces:
> > >=20
> > > =C2=A0 void __iomem *pcim_iomap(struct pci_dev *pdev, int bar,
> > > unsigned
> > > long maxlen)
> > > =C2=A0 void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr)
> > > =C2=A0 int pcim_iomap_regions(struct pci_dev *pdev, int mask, const
> > > char
> > > *name)
> > > =C2=A0 int pcim_iomap_regions_request_all(struct pci_dev *pdev, int
> > > mask,
> > > =C2=A0 void pcim_iounmap_regions(struct pci_dev *pdev, int mask)
> > >=20
> > > and adds a couple new exported interfaces:
> > >=20
> > > =C2=A0 void pcim_release_all_regions(struct pci_dev *pdev)
> > > =C2=A0 int pcim_request_all_regions(struct pci_dev *pdev, const char
> > > *name)
> > >=20
> > > There's a lot going on in these two patches, so they're hard to
> > > review.=C2=A0 I think it would be easier if you could do the fixes to
> > > existing interfaces first,
> >=20
> > I agree that the patches can be further split into smaller chunks
> > to
> > make them more atomic and easier to review. I can do that.
> >=20
> > BUT I'd need some more details about what you mean by "do the fixes
> > first" =E2=80=93 which fixes?
> > The later patches at least in part rely on the new better functions
> > being available.
> >=20
> > > followed by adding new things, maybe
> > > something like separate patches that:
> > >=20
> > > =C2=A0 - Add pcim_addr_devres_alloc(), pcim_addr_devres_free(),
> > > =C2=A0=C2=A0=C2=A0 pcim_addr_devres_clear().
> > >=20
> > > =C2=A0 - Add pcim_add_mapping_to_legacy_table(),
> > > =C2=A0=C2=A0=C2=A0 pcim_remove_mapping_from_legacy_table(),
> > > =C2=A0=C2=A0=C2=A0 pcim_remove_bar_from_legacy_table().
> > >=20
> > > =C2=A0 - Reimplement pcim_iomap(), pcim_iomap_regions(),
> > > pcim_iounmap().
>=20
> This is the part I meant by "fixes", but maybe it's not so much a fix
> as it is reimplementing based on different infrastructure.=C2=A0 The diff=
s
> in "PCI: Deprecate iomap-table functions" for pcim_iomap() and
> pcim_iounmap() are fairly straightforward and only depend on the
> above.
>=20
> pcim_iomap_regions() is a bit more complicated and probably needs
> pcim_iomap_region() but not necessarily __pcim_request_region() and
> __pcim_request_region_range().


Well, pcim_iomap_region() relies on __pcim_request_region() and
__pcim_request_region_range().
The entire architecture circles around those: At the bottom you have
generic functions that can reserve you any range, and at the top you
have functions that use those to get a whole BAR if needed.

That was done very specifically to have an extensible API that doesn't
suffer the limitations of the current devres API. It's super easy this
way to add all sorts of request() functions should the need ever arise,
all you need to do is add a PCIM_ADDR_* counterpart, basically.

Right now, I wouldn't even know how I could implement
pcim_iomap_region() without my __pcim_* helpers, since the later are
(see the comment above them) written as counter parts to the ones in
pci.c =E2=80=93 which are hybrid again.
So I couldn't write it that way, because then we'd have circle where
the pcim_ function calls the pci_ function which might call the pcim_
function again...

So the one thing I really want is to keep __pcim_request_region_range()
and its wrappers.

The algorithms for the region ranges in __pcim_request_region_range()
can IMO be trusted to work because they are just copies of the existing
ones in pci_iomap_region(). Only difference is that they request
instead of ioremap(). And the request part in turn is copied from
__pci_request_region(), only difference being that I tried to make it
more readable by storing the pci_resource_*() return values at the top
:)


There's really a reason why I did it this way:
   1. Add new, better interfaces
   2. Reimplement pcim_iomap() & partners
   3. Separate that hybrid API as much as possible

I really tried to put some thought into the existing approach.
Changing that now in v7 would be very work intensive, because I'd have
to think everything through again, refactor it, drop APIs again, split
commits, readjust commit messages and all the clean up comments inline
(which wouldn't fit anymore), test the build commit-by-commit carefully
once again with KASAN & Co...

Yesterday I also found that abandoning that "inner nature" of the
series would actually decrease readability in many cases, because
pcim_addr_resources_match() would be added later, whereas the logic
added in pcim_addr_resource_release() would be now empty at the
beginning and scattered over several patches etc.

>=20
> This would be a pretty small patch and defer making them deprecated
> until replacements are added.


I understand your desire to make those two patches smaller. We can work
on making things more readable and reduce the exported APIs

Let me suggest this:
 * I drop luxury functions no one needs (neither internally nor
   externally) yet (e.g., pcim_request_region_range()). That will
   already make patch #1 quite a bit smaller.
 * We don't export anything else which is not needed by users yet
   (pcim_request_all_regions(), pcim_request_region_exclusive() etc.)
 * I split patches #1 and #2 into smaller chunks where possible
   according to your suggestions above.
 * We keep __pcim_request_region(), and use it as the working horse
   cleanly separated from the hybrid counterparts in pci.c.

Would that work for you?


P.


>=20
> > > =C2=A0 - Add new interfaces like pcim_iomap_region(),
> > > =C2=A0=C2=A0=C2=A0 pcim_request_region(), etc.
> > >=20
> > > =C2=A0=C2=A0=C2=A0 AFAICS, except for pcim_iomap_range() (used by vbo=
x), these
> > > new
> > > =C2=A0=C2=A0=C2=A0 interfaces have no users outside drivers/pci, so .=
.. we might
> > > =C2=A0=C2=A0=C2=A0 defer adding them, or at least defer exposing them=
 via
> > > =C2=A0=C2=A0=C2=A0 include/linux/pci.h, until we have users for them.
> >=20
> > Dropping (the export of) functions like pcim_request_region_range()
> > or
> > pcim_request_all_regions() is not a problem.
> >=20
> > What I quite fundamentally have to disagree with, however, is not
> > to
> > export the functions=C2=A0
> >=20
> > =C2=A0* pcim_request_region()
> > =C2=A0* pcim_iomap_region()
> >=20
> > the main point of this series is to deprecate that hybrid nature of
> > those existing pci_* functions. You can only deprecate something
> > when
> > you provide users with new, better alternatives.
>=20
> Right.=C2=A0 But the new alternatives are only better when there are
> actual
> examples in the tree for people to look at.=C2=A0 If there are no users,
> more interfaces are at best confusing and at worst dead code.
>=20
> Bjorn
>=20


