Return-Path: <linux-pci+bounces-2799-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AE6842423
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 12:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89189B23E7F
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 11:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FA167751;
	Tue, 30 Jan 2024 11:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f7jz4KrY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BDC6773C;
	Tue, 30 Jan 2024 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706615594; cv=none; b=dvgO9XD7zp/DlFAlIJKQJUbntSjezzJyDAVbgK+Qx/PLP/Z5iGCB9FGtAvf+S4oa+nzRuvBtLIx97f34Ve6L7bBIu+CdPlw9RXL6YHCpLjpTVMDK+nCoN+zAq3x7OUQwwf0I8nGil1B+lVZFtfjJJZBQnzRUg0ebJCneXaPYIWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706615594; c=relaxed/simple;
	bh=CiBDXOMbsf4fXKRpaWeY7ZHWwrT44E4KCMxjUpnuUHU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cmnEtQURv2vdCRw99AehgxlSH43DcHp/RnxHT5FyYG1cSNZBT53F0TOYDsw/RlWzYzGOCGx36xsnrdwqg2GAB72Z9xK9+CYMKOi8n2mfJNxVX4WMgOo9R5bW28/k2NZ0A1F4jBAIVxgcc9AAAqqS4iW/sevy7tkP/Z5ea+ZvOLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f7jz4KrY; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706615592; x=1738151592;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CiBDXOMbsf4fXKRpaWeY7ZHWwrT44E4KCMxjUpnuUHU=;
  b=f7jz4KrY8DbagkyZ3SbouvSFkwpwye6PbgWCf3aaMHGxphbq8GEgoggq
   ftBRLFFs8vldVQPg4UJ6nohUsKZ9zoC5f9Gk3HrHNDqsYswQ1FquXO1qT
   6i5m+5vAwC/rePAWCCNCe3PF2WSyDUcuygtMokdCK0vpGh64Gt/+gahhh
   IQFt2WEEfPFEMtf+dqxhdi8IXSzUzrK/yfXBSj2wrHGJ+5DktwYojhjO3
   C2t7jWNvXo7e2t45IFpNCuR0WS7dV9FToZXjZjAOZHvlz+4yJsuTThdb3
   dMt+zbd/Z1v38xa2NbMOnfzXXkc9OIWqbTMTAmlUaI6obv+Xxv2ODfmrx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="16640094"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="16640094"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 03:53:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="22414275"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.34.252])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 03:53:09 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 30 Jan 2024 13:53:04 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] PCI: Clear LBMS on resume to avoid Target Speed
 quirk
In-Reply-To: <20240129184354.GA470131@bhelgaas>
Message-ID: <aa2d1c4e-9961-d54a-00c7-ddf8e858a9b0@linux.intel.com>
References: <20240129184354.GA470131@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1875071770-1706615584=:1000"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1875071770-1706615584=:1000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 29 Jan 2024, Bjorn Helgaas wrote:

> On Mon, Jan 29, 2024 at 01:27:09PM +0200, Ilpo J=C3=A4rvinen wrote:
> > While a device is runtime suspended along with its PCIe hierarchy, the
> > device could get disconnected. Because of the suspend, the device
> > disconnection cannot be detected until portdrv/hotplug have resumed. On
> > runtime resume, pcie_wait_for_link_delay() is called:
> >=20
> >   pci_pm_runtime_resume()
> >     pci_pm_bridge_power_up_actions()
> >       pci_bridge_wait_for_secondary_bus()
> >         pcie_wait_for_link_delay()
> >=20
> > Because the device is already disconnected, this results in cascading
> > failures:
> >=20
> >   1. pcie_wait_for_link_status() returns -ETIMEDOUT.
> >=20
> >   2. After the commit a89c82249c37 ("PCI: Work around PCIe link
> >      training failures"),
>=20
> I this this also depends on the merge resolution in 1abb47390350
> ("Merge branch 'pci/enumeration'").  Just looking at a89c82249c37 in
> isolation suggests that pcie_wait_for_link_status() returning
> -ETIMEDOUT would not cause pcie_wait_for_link_delay() to call
> pcie_failed_link_retrain().

I was aware of the merge but I seem to have somehow misanalyzed the return=
=20
values earlier since I cannot anymore reach my earlier conclusion and now
ended up agreeing with your analysis that 1abb47390350 broke it.

That would imply there is a logic error in 1abb47390350 in addition to=20
the LBMS-logic problem in a89c82249c37 my patch is fixing... However, I=20
cannot pinpoint a single error because there seems to be more than one in=
=20
the whole code.

First of all, this is not true for pcie_failed_link_retrain():
 * Return TRUE if the link has been successfully retrained, otherwise FALSE=
=2E
If LBMS is not set, the Target Speed quirk is not applied but the function=
=20
still returns true. I think that should be changed to early return false
when no LBMS is present.

But if I make that change, then pcie_wait_for_link_delay() will do=20
msleep() + return true, and pci_bridge_wait_for_secondary_bus() will call=
=20
long ~60s pci_dev_wait().

I'll try to come up another patch to cleanup all that return logic so that=
=20
it actually starts to make some sense.

> >      pcie_failed_link_retrain() spuriously detects
> >      this failure as a Link Retraining failure and attempts the Target
> >      Speed trick, which also fails.
>=20
> Based on the comment below, I guess "Target Speed trick" probably
> refers to the "retrain at 2.5GT/s, then remove the speed restriction
> and retrain again" part of pcie_failed_link_retrain() (which I guess
> is basically the entire point of the function)?

Yes. I'll change the wording slightly to make it more obvious and put=20
(Target Speed quirk) into parenthesis so I can use it below.

> >   3. pci_bridge_wait_for_secondary_bus() then calls pci_dev_wait() whic=
h
> >      cannot succeed (but waits ~1 minute, delaying the resume).
> >=20
> > The Target Speed trick (in step 2) is only used if LBMS bit (PCIe r6.1
> > sec 7.5.3.8) is set. For links that have been operational before
> > suspend, it is well possible that LBMS has been set at the bridge and
> > remains on. Thus, after resume, LBMS does not indicate the link needs
> > the Target Speed quirk. Clear LBMS on resume for bridges to avoid the
> > issue.


--=20
 i.

--8323328-1875071770-1706615584=:1000--

