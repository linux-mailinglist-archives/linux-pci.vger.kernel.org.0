Return-Path: <linux-pci+bounces-35040-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AA0B3A6CF
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 18:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B7B7165BFB
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 16:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705BB1624D5;
	Thu, 28 Aug 2025 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GxzqBMLl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875AF30CD95;
	Thu, 28 Aug 2025 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756399639; cv=none; b=E3RhUgJzeKSQokznGX+ZOJKUWO9LCqJKCBu1NZesMvQy7r6Isz/aJO7a9S9EyENd2sV6Q1qdkNisksr2zoikUBzUcbdIl4CimerWWYniOjnDEFNK/HxvztQGWcU053MFa0Fy/WScIUcwDZMpDzjWLR3x5hoYbNy4e3DOk/9XkJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756399639; c=relaxed/simple;
	bh=aU91kSbFDXIVNuJ60vvVOrVduOxjp8fd95hLA1xmbMQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QVpVTMGdt+mGXZSx2/GkYwRqa6XShHjz6cwDb1Bbkn8d5XmXJl9RczulFZsO4FuHhuI+nTS6Dm88cRG8aKkNykvbYqVflBw35spcns9BGVdZL2nnVTW+C+6mPWBH0YVPuN1zbTKYTK7AW0B3/nAn9gzjB4s3vQdvadmK0WGQvSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GxzqBMLl; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756399637; x=1787935637;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=aU91kSbFDXIVNuJ60vvVOrVduOxjp8fd95hLA1xmbMQ=;
  b=GxzqBMLlSJ7ayIDlYbPgK8JNOsXgBOjB4LvNtbo+GUEsOzLHV2FAKEjL
   2OMbLda7FBwvLs+sSKMnyfWDhoINNK7tOZb+qCahd316JEjlQTyK5AuD/
   WR/iNOGbsO+Cy4CNi80mr7bhBlfjYmH7UcGCmG669oCHc8tdQi8NC2c+E
   TCt+Nfb8EFZYkF1RvOIx8dpw0zM7a1mrc1uQTEuMv7uaKA5RTLM283pLU
   ePa9coiJ8ousxIEiNh4jraVaBHanL2F6vnCYZi3TBCwPXShOC6uop90u1
   iCd2bePQe3idICd7EVyQI7dAIVWkwXYYX9WlorN2m9zjHju4rtYxCQ3DZ
   w==;
X-CSE-ConnectionGUID: JIUsepvYR8O8bemB4mP9ww==
X-CSE-MsgGUID: q3FqIogeR5abXu1ncbHtZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58621132"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58621132"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 09:47:16 -0700
X-CSE-ConnectionGUID: SjrdaJHHQdK4rDEfENOp0g==
X-CSE-MsgGUID: vM+TeRjKRZ2iMMw4509i4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,220,1751266800"; 
   d="scan'208";a="207303211"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 09:47:09 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 28 Aug 2025 19:47:06 +0300 (EEST)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Andreas Larsson <andreas@gaisler.com>, Bjorn Helgaas <bhelgaas@google.com>, 
    "David S. Miller" <davem@davemloft.net>, 
    Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, 
    linux-mips@vger.kernel.org, linux-pci@vger.kernel.org, 
    sparclinux@vger.kernel.org, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
    Yinghai Lu <yinghai@kernel.org>, Igor Mammedov <imammedo@redhat.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    =?ISO-8859-2?Q?Micha=B3_Winiarski?= <michal.winiarski@intel.com>, 
    linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 00/24] PCI: Bridge window selection improvements
In-Reply-To: <20250827223606.GA915856@bhelgaas>
Message-ID: <d209c08a-56df-5aac-869d-7c6c548c0614@linux.intel.com>
References: <20250827223606.GA915856@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-231680363-1756381945=:938"
Content-ID: <11bc2533-54ae-273a-c46a-d271790c5a86@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-231680363-1756381945=:938
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <f90962a0-95ab-8e0a-58b9-2afe95683ba6@linux.intel.com>

On Wed, 27 Aug 2025, Bjorn Helgaas wrote:

> On Fri, Aug 22, 2025 at 05:55:41PM +0300, Ilpo J=E4rvinen wrote:
> > This series is based on top of the three resource fitting and
> > assignment algorithm fixes (v3).
> >=20
> > PCI resource fitting and assignment code needs to find the bridge
> > window a resource belongs to in multiple places, yet, no common
> > function for that exists. Thus, each site has its own version of
> > the decision, each with their own corner cases, misbehaviors, and
> > some resulting in complex interfaces between internal functions.
> > ...
>=20
> > I've tried to look out for any trouble that code under arch/ could
> > cause after the flags start to behave differently and therefore ended
> > up consolidating arch/ code to use pci_enable_resources(). My
> > impression is that strictly speaking only the MIPS code would break
> > similar to PCI core's copy of pci_enable_resources(), the others were
> > much more lax in checking so they'd likely keep working but
> > consolidation seemed still the best approach there as the enable checks
> > seemed diverging for no apparent reason.
> > ...
>=20
> >   m68k/PCI: Use pci_enable_resources() in pcibios_enable_device()
> >   sparc/PCI: Remove pcibios_enable_device() as they do nothing extra
> >   MIPS: PCI: Use pci_enable_resources()
> > ...
>=20
> >  arch/m68k/kernel/pcibios.c   |  39 +-
> >  arch/mips/pci/pci-legacy.c   |  38 +-
> >  arch/sparc/kernel/leon_pci.c |  27 --
> >  arch/sparc/kernel/pci.c      |  27 --
> >  arch/sparc/kernel/pcic.c     |  27 --
> > ...
>=20
> I love the fact that you're doing so much cleanup.  Thanks for all the
> work in this!
>
> Obviously all this code is quite sensitive, so I put it on
> pci/resource to get more exposure in -next.

Thanks. I really appreciate the opportunity to have it in next for extra=20
testing as my testing, while relatively extensive, still has its limits.

I'll need to do minor corrections into a few intermediate patches though=20
to ensure bisectability, we really want to make this as bisectable as=20
possible. In other words, I've found 2 relatively small issues in them=20
which won't change the end result when the whole series is complete and=20
fixed some small grammar errors in the changelogs.

I see you made some corrections so I'm not sure what's the best course of=
=20
action here to update them. Should I just send v2 normally and you deal=20
with your changes while replacing v1 with v2?

> If it turns out that we
> trip over things or just don't feel comfortable yet for v6.18, we can
> always defer this part until the next cycle.

I agree, and really please don't hesitate to postpone if it turns out=20
necessary.

> I will also watch for acks from the m68k, mips, and sparc maintainers
> for those pieces.
>=20
> Bjorn
>=20

--=20
 i.
--8323328-231680363-1756381945=:938--

