Return-Path: <linux-pci+bounces-2804-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 757828425F7
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 14:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FF0E293540
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 13:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99506BB40;
	Tue, 30 Jan 2024 13:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DX9tCY39"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C057460874;
	Tue, 30 Jan 2024 13:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706620527; cv=none; b=OGgc+sW/TmDe7mo/hAMgvSWiWI+GlyWUzZTA8YkU6Vo4fGQXxNQjmQTE1vGATWps4jzd6D9sFw7b9VV+gDPKm5G7URElGyk3eU92500GqOwxxzIqdqdUKIYoqQh+i/Wjcxh1QHHUGmYrEEwJTiZXVd0dSuizkWGt4xM7DjY5Yg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706620527; c=relaxed/simple;
	bh=YqZzIcojda4nyn+FMMQhoHdEpUzR5h93PZGcwzJyjac=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FXLGD7HWxpAJzywr+dHFokValGm8njkrVoYm4q/4/b7taTK0eMcxo60bO5zqbf0xn/Ngc1kBNtAwudgDyzduBa3Cajqo9GouQxjkTGFkLoeN+tzn2NDPldr2es6etlSDXBs1Z2m5HB6B4lgZUmSeZ7MibUzEfkQzqN7DTKuXY2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DX9tCY39; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706620525; x=1738156525;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YqZzIcojda4nyn+FMMQhoHdEpUzR5h93PZGcwzJyjac=;
  b=DX9tCY39w4M1QuS0D/1KtNHbhz4M38NCDfHtDdYEjlsJxIkeaZ6PyrGI
   MjfbtrqRJIUr9ePkD9nTi3udyNxfEl4ahonqer0tMFuc/XqAnzSB84MU6
   YuNbMINZZK8gaLnex9NtOMukEeZBJWjMHB6BD/qZb3AuUilZLuZ/MLi95
   EtrGSpA4Hw2v/CLd0ZNJ5Hrt7VDhKeqfnE/E4RL5MLqrFntclB+4awYsC
   xU0NrG7PuIO8mvayj2iQztXpMWzgL/dEK2VLqIFIk8NZrEf/sTZy4FiDK
   CqugLfmu+B7vL17Z39M59hLTYxe3dUYLkcv7uSzYhb+xGS+r9QrltFWj1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="400413381"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="400413381"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 05:15:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3689802"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.34.252])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 05:15:22 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 30 Jan 2024 15:15:18 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    "Maciej W. Rozycki" <macro@orcam.me.uk>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] PCI: Do not wait for disconnected devices when
 resuming
In-Reply-To: <20240129185544.GA471021@bhelgaas>
Message-ID: <964b697f-a412-2fd5-a649-036e9f6b596e@linux.intel.com>
References: <20240129185544.GA471021@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1132523681-1706620518=:1000"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1132523681-1706620518=:1000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 29 Jan 2024, Bjorn Helgaas wrote:

> On Mon, Jan 29, 2024 at 01:27:10PM +0200, Ilpo J=C3=A4rvinen wrote:
> > On runtime resume, pci_dev_wait() is called:
> >   pci_pm_runtime_resume()
> >     pci_pm_bridge_power_up_actions()
> >       pci_bridge_wait_for_secondary_bus()
> >         pci_dev_wait()
> >=20
> > While a device is runtime suspended along with its PCIe hierarchy, the
> > device could get disconnected. In such case, the link will not come up
> > no matter how log pci_dev_wait() waits for it.
>=20
> s/PCIe/PCI/ (unless this is a PCIe-specific thing)
> s/log/long/
>=20
> > Besides the above mentioned case, there could be other ways to get the
> > device disconnected while pci_dev_wait() is waiting for the link to
> > come up.
> >=20
> > Make pci_dev_wait() to exit if the device is already disconnected to
> > avoid unnecessary delay. As disconnected device is not really even a
> > failure in the same sense as link failing to come up for whatever
> > reason, return 0 instead of errno.
>=20
> The device being disconnected is not the same as a link failure.

This we agree and it's what I tried to write above.

> Do
> all the callers do the right thing if pci_dev_wait() returns success
> when there's no device there?

It's a bit complicated. I honestly don't know what is the best approach=20
here so I'm very much open to your suggestion what would be preferrable.

There are two main use cases (more than two callers but they seem boil=20
down to two use cases).

One use case is reset related functions and those would probably prefer to=
=20
have error returned if the wait, and thus reset, failed.

Then the another is wait for buses, that is,=20
pci_bridge_wait_for_secondary_bus() which return 0 if there's no device=20
(wait successful). For it, it would make sense to return 0 also when=20
device is disconnected because it seems analoguous to the case where=20
there's no device in the first place.

Perhaps it would be better to return -ENOTTY from pci_dev_wait() and check=
=20
for that disconnected condition inside=20
pci_bridge_wait_for_secondary_bus()? To further complicate things,=20
however, DPC also depends on the return value of=20
pci_bridge_wait_for_secondary_bus() and from its perspective, returning=20
error when there is a device that is disconnected might be the desirable=20
alternative (but I'm not fully sure how everything in DPC works but I=20
highly suspect I'm correct here).

Either way, the fix itself does care and seemed to work regardless of the=
=20
actual value returned by pci_dev_wait().

> > Also make sure compiler does not become too clever with
> > dev->error_state and use READ_ONCE() to force a fetch for the
> > up-to-date value.
>=20
> I think we should have a comment there to say why READ_ONCE() is
> needed.  Otherwise it's hard to know whether a future change might
> make it unnecessary.

Sure, I'll add a comment there.

--=20
 i.

--8323328-1132523681-1706620518=:1000--

