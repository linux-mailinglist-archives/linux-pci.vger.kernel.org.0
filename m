Return-Path: <linux-pci+bounces-3036-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719508475A4
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 18:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 098E5B29F5B
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 17:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7558414901A;
	Fri,  2 Feb 2024 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IPZbVFv7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECC214900B;
	Fri,  2 Feb 2024 17:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893402; cv=none; b=TgsOlk1PuPIeX+pl88BYgPgPdfYvoNZzGNsKsjimBmkdsT4jsubtYWi408GNnJFtP9aKuOIxgBvFlOQVHQcRNQXf9ZYtEMFKKG81Aa/H0U75jjDDOXjD12DIeBdNw5OTGOMqAA0/i1DPJD6csSZbG8e2ybPqqXRSZFbs8bvFuGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893402; c=relaxed/simple;
	bh=rZLMeTlxZA/EwnRxj6VIy4cYWe9sHIWrTOCd03DOiuw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DLPAWea0wXwiI1WJUrE0rreer/jtpRoLcQ8hNsiNnkNF6Ky/iryhtbK3j0NCgYMqTTDxYExpAeRHx10VH+zzKBRQdB07pcUW/g1ceBToRGymTutb4hUQ9VRnzrJ5VNSdajDZ8kU4tmklktPLOMjB/MF1BiIyb1trtPSjakJVufM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IPZbVFv7; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706893401; x=1738429401;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rZLMeTlxZA/EwnRxj6VIy4cYWe9sHIWrTOCd03DOiuw=;
  b=IPZbVFv7xR+FGxn/6z3HPHrnRVzXtx6YYPS71NkZY9MtJBCchAF8XyHP
   fwQuhI7mSjQCj1A/ExNWUiCCDDuLHUJrVpE7pJtgorrrwwIX++QVQtl52
   quOzYuAn2XOm3zQ2sbfqA8hK6QSiiNAyrllH/5lsWclSC+s8X5/rRseOH
   utdAF/7CBWL1mf7XYmezhJ/VuyhcFM9xdjVO5aPZzjs8292PT08hR6tX9
   gpMGbkyEffKXiAlvsXGpoD0KnUTeMyOKKkQ6an7P3uQ/0Xz0eq3zvSu8k
   XZ5BkvSXL9VleoKl+wnnFV14oxWJJ5vEwvNFIok1BPUuyV3x7LcMocZXS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="11560083"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="11560083"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 09:03:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="417485"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.50.66])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 09:03:17 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 2 Feb 2024 19:03:12 +0200 (EET)
To: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
    linux-pci@vger.kernel.org, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] PCI: Do not wait for disconnected devices when
 resuming
In-Reply-To: <964b697f-a412-2fd5-a649-036e9f6b596e@linux.intel.com>
Message-ID: <088bce2b-1d2f-f921-1fdb-b411abc9fe71@linux.intel.com>
References: <20240129185544.GA471021@bhelgaas> <964b697f-a412-2fd5-a649-036e9f6b596e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1519507509-1706893392=:1020"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1519507509-1706893392=:1020
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 30 Jan 2024, Ilpo J=C3=A4rvinen wrote:

> On Mon, 29 Jan 2024, Bjorn Helgaas wrote:
>=20
> > On Mon, Jan 29, 2024 at 01:27:10PM +0200, Ilpo J=C3=A4rvinen wrote:
> > > On runtime resume, pci_dev_wait() is called:
> > >   pci_pm_runtime_resume()
> > >     pci_pm_bridge_power_up_actions()
> > >       pci_bridge_wait_for_secondary_bus()
> > >         pci_dev_wait()
> > >=20
> > > While a device is runtime suspended along with its PCIe hierarchy, th=
e
> > > device could get disconnected. In such case, the link will not come u=
p
> > > no matter how log pci_dev_wait() waits for it.
> >=20
> > s/PCIe/PCI/ (unless this is a PCIe-specific thing)
> > s/log/long/
> >=20
> > > Besides the above mentioned case, there could be other ways to get th=
e
> > > device disconnected while pci_dev_wait() is waiting for the link to
> > > come up.
> > >=20
> > > Make pci_dev_wait() to exit if the device is already disconnected to
> > > avoid unnecessary delay. As disconnected device is not really even a
> > > failure in the same sense as link failing to come up for whatever
> > > reason, return 0 instead of errno.
> >=20
> > The device being disconnected is not the same as a link failure.
>=20
> This we agree and it's what I tried to write above.
>=20
> > Do
> > all the callers do the right thing if pci_dev_wait() returns success
> > when there's no device there?
>=20
> It's a bit complicated. I honestly don't know what is the best approach=
=20
> here so I'm very much open to your suggestion what would be preferrable.
>=20
> There are two main use cases (more than two callers but they seem boil=20
> down to two use cases).
>=20
> One use case is reset related functions and those would probably prefer t=
o=20
> have error returned if the wait, and thus reset, failed.
>=20
> Then the another is wait for buses, that is,=20
> pci_bridge_wait_for_secondary_bus() which return 0 if there's no device=
=20
> (wait successful). For it, it would make sense to return 0 also when=20
> device is disconnected because it seems analoguous to the case where=20
> there's no device in the first place.
>=20
> Perhaps it would be better to return -ENOTTY from pci_dev_wait() and chec=
k=20
> for that disconnected condition inside=20
> pci_bridge_wait_for_secondary_bus()? To further complicate things,=20
> however, DPC also depends on the return value of=20
> pci_bridge_wait_for_secondary_bus() and from its perspective, returning=
=20
> error when there is a device that is disconnected might be the desirable=
=20
> alternative (but I'm not fully sure how everything in DPC works but I=20
> highly suspect I'm correct here).

Just to note here I intend to reverse the return to -ENOTTY in v2.=20
It is easier and doing anything more complicated than that felt=20
over-engineering because it would have just avoided marking same=20
disconnected devices disconnected for another time which is harmless.

--=20
 i.

--8323328-1519507509-1706893392=:1020--

