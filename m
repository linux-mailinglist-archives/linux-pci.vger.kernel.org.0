Return-Path: <linux-pci+bounces-42764-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEDDCAD862
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 16:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1984300D337
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 15:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D73C2765DF;
	Mon,  8 Dec 2025 15:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MkNXsxUF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE31DDAB;
	Mon,  8 Dec 2025 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765206211; cv=none; b=LO9m3cmyYNSwosTmEqXHJxKmK64CKQEaklEAk2GJ5B/bYZTfbhNUl+Y2FYXaTk0zibsiIfS2CopGZSSE9PH9ovDBUkb0tSlS6T4oFbQk89hfK43QtGIy9R2g75gUUDS0i1TuFJjDsVPIPQll694KIOqng9DsUaU1UnfxbZIfkGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765206211; c=relaxed/simple;
	bh=5vPJncbtLYap/wSlTQmsZDhyykhPwyETQQqrK9SPjek=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HWNKjD7nJVin4ypOuEROlzC87589R0WIIXSEkkGBWbLuj438AoTg7F2W2iOh2saXdaNHVGBIKd3cxH+rUCbjqg8M8uosSSikxM9zsacfeQ7hNzAScNUlCBWCSZTSt9JKk9OqpzA/pzwYjLQ1JDJxeIg7o3O9R4Fc34fa7bKu8Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MkNXsxUF; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765206209; x=1796742209;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5vPJncbtLYap/wSlTQmsZDhyykhPwyETQQqrK9SPjek=;
  b=MkNXsxUFXX2fRHXutcFvPGmCrbCowN3x/k4xyqFDrubketPtLmTvvhru
   fGvcAkjxXDtsauaQ2cnQ7Uig3WEp+qBfFXcoEBrSDoKMiRRv789lGySl4
   YAfVFY7AjLLhx3O6pMj7lR+dT4RjWfcRfahGlLQfQSiNzaS4qxiLeFm6s
   StT2sZKPau5xiYhAi3HNNK67h6QE+nJ9TSSttKcOmv+aYyAlbelgIeS7I
   CIAX0TsNChK87WQal+Gf/KB/+P0F7VCKzoU74u07TMZ4hBTxne2HcZuKG
   xa53ATSO6KOLL4kFcDAz7rIKY7iAfJKNkWOFaUYgNFHKN2nbZhQi1/3GQ
   Q==;
X-CSE-ConnectionGUID: xeCi7x9TRK6MrUnskbJwtw==
X-CSE-MsgGUID: kEX5bdXiSDKU/KQOvbd49g==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="84554296"
X-IronPort-AV: E=Sophos;i="6.20,259,1758610800"; 
   d="scan'208";a="84554296"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 07:03:28 -0800
X-CSE-ConnectionGUID: xGuQG+DOS6qnHiDZbW7kTw==
X-CSE-MsgGUID: tL4x0/u9S1eBbXiSoX3HpQ==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 07:03:24 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 8 Dec 2025 17:03:21 +0200 (EET)
To: Christian Marangi <ansuelsmth@gmail.com>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    Dan Williams <dan.j.williams@intel.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Jonathan Cameron <jonathan.cameron@huawei.com>, 
    Magnus Damm <damm@igel.co.jp>, LKML <linux-kernel@vger.kernel.org>, 
    "Rob Herring (Arm)" <robh@kernel.org>, stable@vger.kernel.org, 
    linux-pci@vger.kernel.org
Subject: Re: [PATCH] resource: handle wrong resource_size value on zero
 start/end resource
In-Reply-To: <6936d6f9.5d0a0220.2a4b1f.ab28@mx.google.com>
Message-ID: <f77507b6-dfe5-919a-2682-9e7d5831ee0d@linux.intel.com>
References: <20251207215359.28895-1-ansuelsmth@gmail.com> <9c126c75-1d50-6315-4a15-e58e1adf20e4@linux.intel.com> <6936d6f9.5d0a0220.2a4b1f.ab28@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2039098437-1765206201=:971"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2039098437-1765206201=:971
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 8 Dec 2025, Christian Marangi wrote:
> On Mon, Dec 08, 2025 at 03:29:01PM +0200, Ilpo J=E4rvinen wrote:
> > On Sun, 7 Dec 2025, Christian Marangi wrote:
> >=20
> > > Commit 900730dc4705 ("wifi: ath: Use
> > > of_reserved_mem_region_to_resource() for "memory-region"") uncovered =
a
> > > massive problem with the usage of resource_size() helper.
> > >=20
> > > The reported commit caused a regression with ath11k WiFi firmware
> > > loading and the change was just a simple replacement of duplicate cod=
e
> > > with a new helper of_reserved_mem_region_to_resource().
> > >=20
> > > On reworking this, in the commit also a check for the presence of the
> > > node was replaced with resource_size(&res). This was done following t=
he
> > > logic that if the node wasn't present then it's expected that also th=
e
> > > resource_size is zero, mimicking the same if-else logic.
> >=20
> > So what's the actual resource that causes this ath11 regression? You se=
em=20
> > possess that knowledge as you knew to create this patch.
>=20
> I'm not gatekeeping the information. Just trying to get involved as much
> people as possible in checking this.
>=20
> This helper is used in generic OF and PCI code and since there is the
> combo 2008 code + no comments, then it's sensible to make sure no
> confusion was applied across the year.
>=20
> > of_reserved_mem_region_to_resource() does use resource_set_range() so h=
ow=20
> > did the end address become 0? Is there perhaps some other bug being=20
> > covered up with this patch to resource_size()?
> >=20
>=20
> This IS EXACTLY the problem HERE. There is the assumption that
> resource_size() MUST be used ALWAYS after a resource struct is used.
>=20
> But this is not alywas the case... nothing stops to call resource_size()
> on a a local
>=20
> struct resource res =3D {}
>=20
> and assume resource_size() returning 0 (as struct resource is all zero
> and assuming logically the size to be zero) (this assumption has been
> already proved to be wrong by the previous message but it's very common
> to assume that an helper called on an all zero struct returns 0 if the
> subject is about size or range of address)

I guess you might have written this before reading the entire email as
the WARN_ON_ONCE() I suggested would have caught the caller side bug(s).

The ath11k assumes res was setup by of_reserved_mem_region_to_resource()=20
that appearently wasn't the case (a logic bug introduced in the commit=20
900730dc4705 ("wifi: ath: Use of_reserved_mem_region_to_resource() for=20
"memory-region""), and then calls resource_size() without first making=20
sure the resource is valid.

There are at least two, if not three, problems on the caller side here.=20

> > > This was also the reason the regression was mostly hard to catch at
> > > first sight as the rework is correctly done given the assumption on t=
he
> > > used helpers.
> > >=20
> > > BUT this is actually not the case. On further inspection on
> > > resource_size() it was found that it NEVER actually returns 0.
> > >
> > > Even if the resource value of start and end are 0, the return value o=
f
> > > resource_size() will ALWAYS be 1, resulting in the broken if-else
> > > condition ALWAYS going in the first if condition.
> > >=20
> > > This was simply confirmed by reading the resource_size() logic:
> > >=20
> > > =09return res->end - res->start + 1;
> >=20
> > ???
> >=20
> > resource_size() does return 0 when ->start =3D 0 and ->end =3D - 1 whic=
h is=20
> > the correctly setup of a zero-sized resource (when flags are non-zero).
> >=20
>=20
> Again IF the resource struct is correctly init, in the case of
> kmalloc-ed stuff or local variables init to zero, then you quickly
> trigger the bug as both start and end will be zero.
>=20
> Also I honestly found some difficulties finding where end is set to -1.

git grep -e '->end =3D .* - 1'

A more complex pattern or Coccinelle can find more for you if you want to=
=20
find multiline or other more complex constructs.

Those mostly predate the init helpers (I did have a series to convert them=
=20
to resource_set_range() but DEFINE_RES() got introduced in the meantime=20
too so I'd have needed to adapt many of the changes so I left the series=20
to rotten as it was always a cleanup side-project to me and I've more=20
on my plate than I've time for currently even in the main resource=20
assignment algorithm).

> I actually found case in OF code where both start and end are set to -1
> resulting.
>=20
> Can you point me where is this init code?

As noted below, DEFINE_RES*(), resource_set_range() and=20
resource_set_size() in include/linux/ioport.h are your friends here.
In general, DEFINE_RES is preferred but when only addresses of a resource=
=20
are adjusted dynamically, those C functions are better suited for the=20
task.

> > > Given the confusion,
> >=20
> > There's lots of resource setup code which does set resource end address=
=20
> > properly by applying -1 to it.
> >=20
> > > also other case of such usage were searched in the
> > > kernel and with great suprise it seems LOTS of place assume
> > > resource_size() should return zero in the context of the resource sta=
rt
> > > and end set to 0.
> > >
> > > Quoting for example comments in drivers/vfio/pci/vfio_pci_core.c:
> > >=20
> > > =09=09/*
> > > =09=09 * The PCI core shouldn't set up a resource with a
> > > =09=09 * type but zero size. But there may be bugs that
> > > =09=09 * cause us to do that.
> > > =09=09 */
> > > =09=09if (!resource_size(res))
> > > =09=09=09goto no_mmap;
> >=20
> > This place does not tell you what ->end is expected to be set? Where di=
d=20
> > you infer that information?
> >=20
> > I suspect this code would want to do resource_is_assigned() (which does=
n't=20
> > exists yet but would check only res->parent !=3D NULL) or base the chec=
k on=20
> > IORESOURCE_UNSET|IORESOURCE_DISABLED.
> >=20
> > Often using resourse_size() (or a few other address based checks) in=20
> > drivers is misguided, what drivers are more interested in is if the=20
> > resource is valid and/or properly in the resource tree (assigned by=20
> > the PCI core which implies it's valid too and has a non-zero size), not=
 so=20
> > much about it's size. As you can see, size itself not even used here at=
=20
> > all, that is, this place never was interested in size but uses it as a=
=20
> > proxy for something else (like also many other drivers do)!
> >=20
>=20
> Yes I agree that resource_size() is not the correct way to check if a
> resource is valid but it seems to be used for this task in some code.
>
> > > It really seems resource_size() was tought with the assumption that
> > > resource struct was always correctly initialized before calling it an=
d
> > > never set to zero.
> > >=20
> > > But across the year this got lost and now there are lots of driver th=
at
> > > assume resource_size() returns 0 if start and end are also 0.
> >=20
> > Who creates such resources?
> >=20
>=20
> It's more a matter of using resource_size() in place where struct
> resource is optionally used.=20

Yes but it is a latent logic bug (using the resource size as the proxy=20
for proper validity check in the logic).

Using these proxies (in general) is what makes it hard to make some=20
resource change I'd actually want to do in the PCI core so I don't have=20
have much love for it (I'll probably eventually have to audit them all=20
myself :-(). As a result, we currently have the unfortunate situation that=
=20
a resizable BAR that cannot be initially assigned is lost forever. The=20
resource had to be reset on assignment failure to keep these proxies=20
agreeing with the state of the resource, as endpoint drivers would be=20
confused otherwise, so making space by resizing other BARs will not bring=
=20
the other BAR back.

This proxy problem actually extends beyond mere resource_size(). There are=
=20
also start and end address checks and pci_resource_len() checks similarly=
=20
used as proxies. None of those proxies remain valid if PCI core stops to=20
reset resource addresses and flags.

> > If flags are non-zero, those places should be fixed (I'm currently fixi=
ng=20
> > one case from drivers/pci/probe.c thanks to you bringing this up :-)) b=
ut=20
> > I think the number of places to fix are fewer than you seem to think. I=
=20
> > read though all end assignments in PCI core and found only this single(=
!)=20
> > problem there.
> >=20
>=20
> Thanks a lot for checking the PCI code, that is one of my concern
> subsystem where this might be problematic. The other is the OF code.

Unfortunately I'm no OF expert but at least drivers/of/ didn't have=20
anything interesting when grepping with:

git grep -e '->end =3D ' -e '\.end =3D ' -- drivers/of

> > > To better handle this and make resource_size() returns correct value =
in
> > > such case, add a simple check and return 0 if both resource start and
> > > resource end are zero.
> > >
> > > Cc: Rob Herring (Arm) <robh@kernel.org>
> > > Cc: stable@vger.kernel.org
> > > Fixes: 1a4e564b7db9 ("resource: add resource_size()")
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > ---
> > >  include/linux/ioport.h | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >=20
> > > diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> > > index 9afa30f9346f..1b8ce62255db 100644
> > > --- a/include/linux/ioport.h
> > > +++ b/include/linux/ioport.h
> > > @@ -288,6 +288,9 @@ static inline void resource_set_range(struct reso=
urce *res,
> > > =20
> > >  static inline resource_size_t resource_size(const struct resource *r=
es)
> > >  {
> > > +=09if (!res->start && !res->end)
> > > +=09=09return 0;
> >=20
> > This looks wrong to me.
> >=20
>=20
> Yes it's indded wrong as I didn't think of case where start and end can
> match and correctly return a size of 1.
>=20
> > Lets try to fix the resource setup side instead. The real problem is in=
=20
> > any code that sets ->end to zero when it wanted to set resource size to=
=20
> > zero, which are not the same thing. To make it simpler (no need to=20
> > manually apply -1 to the end address) and less error prone, we have=20
> > helpers resource_set_range/size() and DEFINE_RES() that handle applying=
 -1=20
> > correctly.
> >=20
>=20
> OK! Thanks for the pointer so there is a DEFINE_RES() for local
> variables!
>=20
> > > +
> > >  =09return res->end - res->start + 1;
> > >  }
> > >  static inline unsigned long resource_type(const struct resource *res=
)
> >=20
> >=20
> > Taking this suggestion from your other email:
> >=20
> > > if (!res.flags && !res.start && !res.end)
> > > =09return 0;
> >=20
> > IMO, the caller shouldn't be calling resource_size() at all when=20
> > !res.flags as that indicates the caller is confused and doesn't really=
=20
> > know what it is even checking for. If a driver does even know if the=20
> > resource is valid (has a valid type) or not, it should be checking that=
=20
> > _first_ (it might needs the size for valid resources but it should IMO=
=20
> > still check validity of the resource first).
> >=20
> > Also, as mentioned above, some/many drivers are not fundamentally=20
> > interested in validity itself but whether the resource is assigned to t=
he=20
> > resource tree.
> >=20
> > For valid resources, this extra check is entirely unnecessary.
> >=20
> > I'd be supportive of adding
> >=20
> > WARN_ON_ONCE(!res.flags)
> >=20
> > ...here but that will be likely a bit too noisy without first auditting=
=20
> > many places (from stable people's perspective a triggering WARN_ON() =
=3D>=20
> > DoS). But that's IMO the direction kernel code should be heading.
> >=20
>=20
> I'm more than happy to send a v2 of this fixing ath11k and adding the
> WARN_ON_ONCE with res.flags.
>=20
> Seems the only correct way to track this down and improve this in the
> next kernel versions.
>=20
> Also thanks to Andy and you for explaining this and reasurme me there
> wasn't a big bug around this helper but just some minor logical
> confusion.
>=20
> Do you agree on the plan for v2? (we can assume the noise won't be so
> much as I expect only SOME driver to be affected by this problem) (I
> hope)

Yes please to fixing ath11k!

And if you're fine with dealing all the reports that will get directed to=
=20
you because of adding that WARN_ON_ONCE() into resource_size() I'd be very=
=20
happy of having to not do it myself eventually but please do realize it
may be more than a few reports over a few next kernel releases. ;-)

That being said, I just tested on one machine here and it seems to not=20
fire even once so we could get more lucky than I was assuming.

It might also be helpful to add kernel doc to resource_size() and mention=
=20
it should not be used as a proxy for other things as we've discussed here.


On contrary to what I said earlier, I just realized the series adding
resource_assigned() got accepted [1] in this cycle so it's now available=20
in Linus' tree.

[1] https://lore.kernel.org/all/69339e215b09f_1e0210057@dwillia2-mobl4.notm=
uch/

--=20
 i.

--8323328-2039098437-1765206201=:971--

