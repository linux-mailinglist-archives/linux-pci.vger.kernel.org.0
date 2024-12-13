Return-Path: <linux-pci+bounces-18367-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8618F9F0931
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 11:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99D7B163788
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 10:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DFF1B415A;
	Fri, 13 Dec 2024 10:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gQhDsu63"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A91B1B4141
	for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2024 10:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734084730; cv=none; b=UhBTe5h+R68XLFZuPPAhwzyx7dVIzM0ZM9V1ShVNYJFEIj7LvV1xQeYocDewyoJ1YpR4KV/9k9zdczgRaBNciER3xndLtm3UFLzhJ4j1AqG5UPi7tllL7oBRCM+KzKb+I05pK8I6QS0vdOTGc0lCm4bsZsxf5lh/d/zEMAMSd6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734084730; c=relaxed/simple;
	bh=7J9AjGA5m6fVQoUQ3ZKVcQJ+8CJq0GmOdjRln/HHw/Y=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JRlD0EwDjxqKUGTZf8Bwxq+tsYqxa5mDVESk6/AhRHXPQVbBrqImTS6qtjCcLp9F86hDM3rrqAApq/qNAUdV9WEG1TWbcJAvRcWsOuDsJSnIdCM/EFdPL/3JVBL4noibl5cQL8yIqmQNJO5nhrSJSeHVOuY/J3FEFukpo8VO0ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gQhDsu63; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734084730; x=1765620730;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7J9AjGA5m6fVQoUQ3ZKVcQJ+8CJq0GmOdjRln/HHw/Y=;
  b=gQhDsu639Ykdw2s+UWZanqWjj47wsKToGD/2cT1f4pCmU2sw8h2O3nR8
   8YU5NXbg7mRu3EbFd+iBK1KNDJgV1EVhfc+/iqgtDG8FwHFip1oucN7IF
   zTDG9zfa3VvVRLDxULPhin83CUz8FiqxiuNAL0CEzVmuU9QuilLimxVgX
   9YLZTIYRsjcB5KKO1LZXcIrWV5fzEQeNPWJlFnk717aJi7mv/yTglJnpc
   vPTpbWa1yOKae7imdB59Ga4uvhl9KFvYwoEnpQ7m+pY90vt3xKQmdF05j
   IKSv/VuSHhJ8IR7J7QTNvAAyUQp0rN4U1dGoB2K7L4kdk86JTE0USfErH
   A==;
X-CSE-ConnectionGUID: B1D1ZxutQUmQa3HUHTsa3A==
X-CSE-MsgGUID: ZS+9pLMVSWyg/Ovv6j6Vzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34668248"
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="34668248"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 02:12:09 -0800
X-CSE-ConnectionGUID: X8MSMM6hRIi/+A8UOj9UqQ==
X-CSE-MsgGUID: inZ8+hMhSK23DzXHD6XeQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="127307280"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.254])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 02:12:06 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 13 Dec 2024 12:12:02 +0200 (EET)
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
    Niklas Schnelle <niks@kernel.org>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCH for-linus] PCI: Honor Max Link Speed when determining
 supported speeds
In-Reply-To: <Z1tgJoTRnldq8NYE@wunner.de>
Message-ID: <f8bf764f-4233-0486-54b6-2380b446cd5a@linux.intel.com>
References: <e3386d62a766be6d0ef7138a001dabfe563cdff8.1733991971.git.lukas@wunner.de> <30db80fd-15bd-c4a7-9f73-a86a062bce52@linux.intel.com> <Z1tgJoTRnldq8NYE@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1467658126-1734084722=:934"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1467658126-1734084722=:934
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 12 Dec 2024, Lukas Wunner wrote:

> On Thu, Dec 12, 2024 at 04:33:23PM +0200, Ilpo J=E4rvinen wrote:
> > On Thu, 12 Dec 2024, Lukas Wunner wrote:
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -6240,12 +6240,14 @@ u8 pcie_get_supported_speeds(struct pci_dev *=
dev)
> > >  =09pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
> > >  =09speeds =3D lnkcap2 & PCI_EXP_LNKCAP2_SLS;
> > > =20
> > > +=09/* Ignore speeds higher than Max Link Speed */
> > > +=09pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> > > +=09speeds &=3D GENMASK(lnkcap & PCI_EXP_LNKCAP_SLS, 0);
> >=20
> > Why do you start GENMASK() from 0th position? That's the reserved bit.
> > (I doesn't exactly cause a misbehavior to & the never set 0th bit but
> > it is slightly confusing).
>=20
> GENMASK() does a BUILD_BUG_ON(l > h) and if a broken PCIe device
> does not set any bits in the PCI_EXP_LNKCAP_SLS field, I'd risk
> doing a GENMASK(0, 1) here, fulfilling the l > h condition.
>=20
> Granted, the BUILD_BUG_ON() only triggers if l and h can be
> evaluated at compile time, which isn't the case here.
>=20
> Still, I felt uneasy risking any potential future breakage.
> Including the reserved bit 0 is harmless because it's forced to
> zero by the earlier "speeds =3D lnkcap2 & PCI_EXP_LNKCAP2_SLS"
> expression.

Fair but that's quite many thoughts you didn't record into the commit=20
message. If you intentionally do confusing tricks like that, please be=20
mindful about the poor guy who has to figure this out years from now. :-)
(One of the most annoying thing in digging into commits far in the past=20
are those nagging "Why?" questions nobody is there to answer.)

I know it doesn't misbehave because of bit 0 is cleared by the earlier=20
statement. (I also thought of the GENMASK() inversion.)

Another option would be to explicitly ensure PCI_EXP_LNKCAP_SLS is at=20
least PCI_EXP_LNKCAP2_SLS_2_5GB which would also ensure pre-3.0 part
returns always at least one speed (which the current code doesn't=20
guarantee).

As in more broader terms there are other kinds of broken devices this=20
code doesn't handle. If PCI_EXP_LNKCAP2_SLS is empty of bits but the=20
device has >5GT/s in PCI_EXP_LNKCAP_SLS, this function will return 0.

> > I suggest to get that either from PCI_EXP_LNKCAP2_SLS_2_5GB or=20
> > PCI_EXP_LNKCAP2_SLS (e.g. with __ffs()) and do not use literal at all
> > to make it explicit where it originates from.
>=20
> Pardon me for being dense but I don't understand what you mean.

I meant that instead of GENMASK(..., 0) use
GENMASK(..., __ffs(PCI_EXP_LNKCAP2_SLS)). But it doesn't matter
if go with this bit 0 included into GENMASK() approach.

--=20
 i.

--8323328-1467658126-1734084722=:934--

