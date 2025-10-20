Return-Path: <linux-pci+bounces-38785-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B2DBF2AFA
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 19:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5902E4F9B28
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 17:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5E633030D;
	Mon, 20 Oct 2025 17:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WqhhcVLN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45333EA8D;
	Mon, 20 Oct 2025 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760980920; cv=none; b=RV2zCJJZPu9sWwEp4X1SERgU2h8B8IxT38PFZ5ZmCHM2NRDHQHDI7bgCKgFXQFC+W/cNMF2FNN6Jf9RrGY/o5S5jdUSi72BpQNdrw1/7vAZhVQM9GexFXxVmNelq6nWY1ngsePIQczYs9SD/U1le7raTcr6qbroNi6LP974yxmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760980920; c=relaxed/simple;
	bh=iJqMvZac2E0f+Oxr20WqP5nOrAvbvfhXXALhJCt9CkU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aMOxmZZHbikjHeepMmL6SBUL+Uh20opluPVjVyOu1j6pHwib+Z+KUHQJ2VkTVvTrnSuyiSlBkxuWvOy2LRTO+m77lBbnYh+yaLw7Msi1qIak5Ndp9qxbEsUYgc4rQSxdvyzN/Q1DezVM10E2lc3xSTIyijzbC0OdkBTkMGr4Fks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WqhhcVLN; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760980919; x=1792516919;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=iJqMvZac2E0f+Oxr20WqP5nOrAvbvfhXXALhJCt9CkU=;
  b=WqhhcVLN13xltbJpcYkmeM07LRYU/Z/qydxiYF1e6wd5foeSKqaBomoX
   pRiTRJbMEn0K7UUBA9m19vEN8TP14RjdlSEhA1KJHWjLEneLsOD8+hCwi
   Q9kGyB4YCLV0EKZVymfHllKKRA8orqf5/q9vaS2aY0DKIptOWz0As2gao
   WDDUIkWUry3fQ9K5WcP+wsw9XLq6fgmffvZEK2JjKjN5bLbhg+RhlPD0v
   SW/t2wQNoV7GJb1Vj1kAlU0b12rZO1boGYfPhVJegp6UfQ/jbqGzjph5y
   VG/BMkIKX3fyKAE9Sk9kKLJ1Gtgua+QjoDk6BZiQKn3ccyfmA5Gqu3LE1
   g==;
X-CSE-ConnectionGUID: ZqYpqx/AROaCWAvh4UTGQw==
X-CSE-MsgGUID: UbSjwaTMTm6JQAqTpdoMhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66963428"
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="66963428"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 10:21:58 -0700
X-CSE-ConnectionGUID: e/w/l0y9RRyykEXuVKLRTw==
X-CSE-MsgGUID: 23GQxlJYTHmGekoGk5KnDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="213996061"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.76])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 10:21:55 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 20 Oct 2025 20:21:50 +0300 (EEST)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Geert Uytterhoeven <geert@linux-m68k.org>, 
    Kai-Heng Feng <kaihengf@nvidia.com>, Rob Herring <robh@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 2/3] PCI: Do not coalesce host bridge resource structs
 in place
In-Reply-To: <aO-vtdECWNpYpo6f@smile.fi.intel.com>
Message-ID: <8401388b-2957-0853-d80b-4479e02c47f0@linux.intel.com>
References: <20251010144231.15773-1-ilpo.jarvinen@linux.intel.com> <20251010144231.15773-3-ilpo.jarvinen@linux.intel.com> <aO-vtdECWNpYpo6f@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1466463382-1760971186=:976"
Content-ID: <75a6f024-b34f-2903-90ea-e1c92620223a@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1466463382-1760971186=:976
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <97670638-677e-29f2-e779-6228452507bb@linux.intel.com>

On Wed, 15 Oct 2025, Andy Shevchenko wrote:

> On Fri, Oct 10, 2025 at 05:42:30PM +0300, Ilpo J=E4rvinen wrote:
> > The resource coalescing for host bridge windows in
> > pci_register_host_bridge() can alter the underlying struct resource
> > which is inherently dangerous as this code has no knowledge of who else
> > holds a pointer the same resource.
> >=20
> > Merge the struct resource inside a newly added
> > resource_list_merge_entries() which uses the internal __res member of
> > the struct resource_entry to store the merged resource, thus preserving
> > the original resource structs.
>=20
> ...
>=20
> > +static void resource_clear_tree_links(struct resource *res)
> > +{
> > +=09res->parent =3D NULL;
> > +=09res->child =3D NULL;
> > +=09res->sibling =3D NULL;
> > +}
>=20
> Not sure if this is the best location to inject a new helper to in the co=
de
> (I mean the position in the file). But I leave it to you just to give ano=
ther
> look in case something more suitable can be found.

This placement was far from random. I'd also want to start clearing links=
=20
of any childs  resources (direct or grand) on a release of a resource=20
(when called with  __release_resource(..., release_child=3Dtrue). It's what=
=20
lead to placing this helper here right above __release_resource().

Currently, released child resources have no way of knowing they've been=20
removed from the resource tree as the resource tree links are all left in=
=20
place (only old->parent is set to NULL by __release_resource(), strictly=20
speaking even that wouldn't be necessary if we don't care for stale=20
links).

My goal is to make res->parent invariant that unambiguously tells whether=
=20
the resource is within the resource tree or not (sans the root "anchor"=20
resources that are parentless).

(But as you could see, it's not part of this series.)

I initially tried to also change old->parent =3D NULL in=20
__release_resource() to use this new helper but then realized there can be=
=20
children too which will have stale links so to make all resource links=20
coherent, a bigger change would have been needed so I left it to a later=20
patch as this series was to fix PCI host bridge resource coalescing=20
algorithm.

Clearing stale links from the children will come with potential=20
performance penalty as the entire subtree have to be walked so it might=20
result in discussion and perhaps some even opposing the idea. But I'd=20
assume it to be small and likely not measurable in practice, and how=20
much resource are removed from the resource tree anyway, not much I=20
think except perhaps in some hotplug stress test.

I've not yet investigated how often there are unreleased children still=20
remaining in first place when calling __release_resource(). It could be=20
that the calling code has released those before calling release of the=20
resource itself (making the performance impact nil in practice).

> >  static int __release_resource(struct resource *old, bool release_child=
)
>=20
> ...
>=20
> > +/**
> > + * resource_mergeable - Test if resources are contiguous and can be me=
rged
> > + * @r1: first resource
> > + * @r2: second resource
> > + *
> > + * Tests @r1 is followed by @r2 contiguously and share the metadata.
>=20
> This needs an additional explanation about name equivalence that's not on=
ly by
> pointers, but by a content.

Okay. The point was to check names are the same, the pointer check was=20
just an optimization as these resources are expected to carry the same=20
name even on the pointer level.

> > + * Return: %true if resources are mergeable non-destructively.
> > + */
> > +static bool resource_mergeable(struct resource *r1, struct resource *r=
2)
> > +{
> > +=09if ((r1->flags !=3D r2->flags) ||
> > +=09    (r1->desc !=3D r2->desc) ||
> > +=09    (r1->parent !=3D r2->parent) ||
> > +=09    (r1->end + 1 !=3D r2->start))
> > +=09=09return false;
>=20
> > +=09if (r1->name =3D=3D r2->name)
> > +=09=09return true;
> > +
> > +=09if (r1->name && r2->name && !strcmp(r1->name, r2->name))
> > +=09=09return true;
> > +
> > +=09return false;
>=20
> Hmm... Can we keep the logic more straight as in returning false cases as=
 soon
> as possible?
>=20
> I think of something like this:
>=20
> =09if (r1->name && r2->name)
> =09=09return strcmp(r1->name, r2->name) =3D=3D 0;
>=20
> =09return r1->name =3D=3D r2->name;

But the point the order above was to avoid strcmp() when the pointer=20
itself is same which I think is quite common case. I don't think strcmp()=
=20
itself checks whether the pointer is the same.

Thanks for the review.

--=20
 i.

> > +}
>=20
> ...
>=20
> > +=09new_res->start =3D res->start;
> > +=09new_res->end =3D next_res->end;
> > +=09new_res->name =3D res->name;
> > +=09new_res->flags =3D res->flags;
> > +=09new_res->desc =3D res->desc;
>=20
> Hmm... IIRC I saw similar code lines a few times in the kernel in resourc=
e.c
> and might be elsewhere. Perhaps a time for another helper?
>=20
>=20
> ...
>=20
> > +=09/* prepare for step 2), find res & next_res from child/sibling chai=
n. */
> > +=09p =3D &parent->child;
> > +=09while (1) {
> > +=09=09tmp =3D *p;
> > +=09=09if (tmp =3D=3D res)
> > +=09=09=09break;
> > +
> > +=09=09/*  No res in child/sibling, the resource tree is corrupted! */
>=20
> Extra space which is not needed.
>=20
> > +=09=09if (WARN_ON_ONCE(!tmp))
> > +=09=09=09return -EINVAL;
> > +
> > +=09=09p =3D &tmp->sibling;
> > +=09}
>=20
> ...
>=20
> > static bool system_ram_resources_mergeable(struct resource *r1,
> >  =09=09=09=09=09   struct resource *r2)
> >  {
> >  =09/* We assume either r1 or r2 is IORESOURCE_SYSRAM_MERGEABLE. */
> > -=09return r1->flags =3D=3D r2->flags && r1->end + 1 =3D=3D r2->start &=
&
> > -=09       r1->name =3D=3D r2->name && r1->desc =3D=3D r2->desc &&
> > +=09return resource_mergeable(r1, r2) &&
> >  =09       !r1->child && !r2->child;
>=20
> Now one line?
>=20
> >  }
>=20
> > +struct resource_entry *resource_list_merge_entries(struct resource_ent=
ry *entry,
> > +=09=09=09=09=09=09   struct resource_entry *next)
> > +{
> > +=09struct resource *res =3D entry->res, *next_res =3D next->res, *new_=
res;
> > +=09int ret;
> > +
> > +=09if ((entry->offset !=3D next->offset) ||
> > +=09    !resource_mergeable(res, next_res))
>=20
> One line? (It's only 82 characters long)
>=20
> > +=09=09return ERR_PTR(-EINVAL);
> > +
> > +=09/* Use the internal __res to not mutate the input resources. */
> > +=09struct resource_entry __free(kfree) *new =3D resource_list_create_e=
ntry(NULL, 0);
> > +=09if (!new)
> > +=09=09return ERR_PTR(-ENOMEM);
> > +
> > +=09new->offset =3D next->offset;
> > +=09new_res =3D new->res;
> > +
> > +=09ret =3D resource_coalesce(res, next_res, new_res);
> > +=09if (ret)
> > +=09=09return ERR_PTR(ret);
> > +
> > +=09resource_list_add_tail(new, &entry->node);
> > +=09resource_list_destroy_entry(entry);
> > +=09resource_list_destroy_entry(next);
> > +
> > +=09return no_free_ptr(new);
> > +}
>=20
>=20
--8323328-1466463382-1760971186=:976--

