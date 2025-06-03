Return-Path: <linux-pci+bounces-28883-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CC8ACCBB9
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 19:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CE601890968
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 17:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41ED1A256E;
	Tue,  3 Jun 2025 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h331Tqlt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11407155C82;
	Tue,  3 Jun 2025 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748970597; cv=none; b=jxqUgBy8wuasT14arrIStwv8q8Mc6WR8ATzFvL3DIgYv4ruhSyhh9yMMtnHtGtEXKrj3CsEDghDHRUdetOuuOZCingPIH1lgv4ym0f183DpipvV3N/R+UpiFVQifxx6+pZ1k/gP3sihZgMoCT0mZjNsoVUwflykrjZEYKVH0EcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748970597; c=relaxed/simple;
	bh=xnKsYymRbXGa0LSn7YAZAlc8guuGA+k8iCPbSMNG4rA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=O8HfJUgOp1YtsLbpaO8T8+8qNWGWoqSH9HoNsHnDJdrBcqN4BBi6qLj85IZF8xnUcp3wBEHv8U2UmQY71nQYshBbv50iJkdjCBGmyZH2RVHKC+CEiLVcuxinLkAOk41UXF0MSIz+7O70kq0+QAzOVfzYuVDTPCCij88Os/WlbB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h331Tqlt; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748970596; x=1780506596;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xnKsYymRbXGa0LSn7YAZAlc8guuGA+k8iCPbSMNG4rA=;
  b=h331Tqltlq7VFB7T0W/ABedqQfPpwBbQm7y1MrJi7f3bmsUoxow1LnoP
   5jFyxJ9chWbV/gq1O6p4s7tz8dWDVnq3rc+zmdCukIGFMjrUx04ktdsYe
   k8+m4uPGldvDkh/0YNFqwrY7fHsbzYycuc+3UKLNhGSTSBdWvLOSvCNCe
   4nFRJ5Yeqjnf3HiCJ3ZoU8BKlNAO0ZKAzY1Rp82oM7s9Rbl6F2WjfbJ14
   rBbpFs8QwKRVRG2FH/FuDg26onXzwo60//mhRQJ35mWFDLCzR9q3iHAA7
   /St7IQftDUGGAZolBuQDtGlqOrUTT/MIqjwb8seCmjzo20GP4f1ysvmRc
   w==;
X-CSE-ConnectionGUID: Zp8v0b15TzqJAA7LDgWNoQ==
X-CSE-MsgGUID: ES2q7KDmSZ6rUNkc4zkvEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="73555397"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="73555397"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 10:09:55 -0700
X-CSE-ConnectionGUID: VpzspcPMRbG1hz/zJ4yAsQ==
X-CSE-MsgGUID: EQWme7gmSbWv56mXA2DfMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="145543777"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.141])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 10:09:53 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 3 Jun 2025 20:09:49 +0300 (EEST)
To: Tudor Ambarus <tudor.ambarus@linaro.org>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    =?ISO-8859-2?Q?Micha=B3_Winiarski?= <michal.winiarski@intel.com>, 
    Igor Mammedov <imammedo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    William McVicker <willmcvicker@google.com>
Subject: Re: [PATCH 24/25] PCI: Perform reset_resource() and build fail list
 in sync
In-Reply-To: <8df02df4-243e-fbbc-aa00-2da7affde4a0@linux.intel.com>
Message-ID: <6b4f3e14-a3b1-db7e-52c0-0eca7350fc93@linux.intel.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com> <20241216175632.4175-25-ilpo.jarvinen@linux.intel.com> <5f103643-5e1c-43c6-b8fe-9617d3b5447c@linaro.org> <8f281667-b4ef-9385-868f-93893b9d6611@linux.intel.com> <3a47fc82-dc21-46c3-873d-68e713304af3@linaro.org>
 <f6ee05f7-174b-76d4-3dbe-12473f676e4d@linux.intel.com> <867e47dc-9454-c00f-6d80-9718e5705480@linux.intel.com> <a56284a4-755d-4eb4-ba77-9ea30e18d08f@linaro.org> <7e882cfb-a35a-bab0-c333-76a4e79243b6@linux.intel.com> <f2d149c6-41a4-4a9a-9739-1ea1c4b06f4b@linaro.org>
 <19ccc09c-1d6b-930e-6ed6-398b34020ca1@linux.intel.com> <c1c0bacd-7842-4e9e-aec4-66eb481aa43f@linaro.org> <fc611a93-1f5f-a86d-f3ca-cb737ed5fa4a@linux.intel.com> <bd579412-d07c-476d-8932-55c1f69adc9f@linaro.org>
 <8df02df4-243e-fbbc-aa00-2da7affde4a0@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-627129416-1748970589=:937"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-627129416-1748970589=:937
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 3 Jun 2025, Ilpo J=E4rvinen wrote:

> On Tue, 3 Jun 2025, Tudor Ambarus wrote:
> > On 6/3/25 3:13 PM, Ilpo J=E4rvinen wrote:
> > > On Tue, 3 Jun 2025, Tudor Ambarus wrote:
> > >> On 6/3/25 9:13 AM, Ilpo J=E4rvinen wrote:
> > >>> So please test if this patch solves your problem:
> > >>
> > >> It fails in a different way, the bridge window resource never gets
> > >> assigned with the proposed patch.
> > >=20
> > > Is that a failure? I was expecting that to occur. It didn't assign=20
> > > any resources into that bridge window.
> >=20
> > It leads to a watchdog interrupt on my pixel6. Last print I see on my
> > console is related to the modem booting status. My wild guess is that
> > that modem accesses something from the unassigned bridge window.
>=20
> The bridge window is not for the bridge device itself. It's as the name=
=20
> says, a window into where subordinate busses can assign their resources.
> The bridge knows it must forward that window address range to the=20
> subordinate bus.
>=20
> > In the working case I see the bridge window printed:
> > [   15.457310][ T1083] pcieport 0000:00:00.0: [s51xx_pcie_probe] BAR 14=
:
> > tmp rsc : [mem 0x40000000-0x401fffff]
> >=20
> > [   15.457683][ T1083] cpif: s51xx_pcie_probe: Set Doorbell register
> > address.
> >=20
> > In the failing case I see:
> > [   15.623270][ T1113] pcieport 0000:00:00.0: [s51xx_pcie_probe] BAR 14=
:
> > tmp rsc : [??? 0x00000000 flags 0x0]
> >=20
> > [   15.623638][ T1113] cpif: s51xx_pcie_probe: Set Doorbell register
> > address.
>=20
> Oh, is it this one?
>=20
> https://github.com/oberdfr/google-modules_radio_samsung_s5300/blob/11a10f=
955a267a45a1997f65671d7054adf1a33a/s51xx_pcie.c#L366
>=20
> There are number of crazy things going on there... Probe shouldn't be=20
> messing resources like that. If it wants to change resources, a quirk=20
> would be more appropriate place I guess but I'm very unsure what that=20
> even tries to achieve with all that craziness ("Disable BAR resources" by=
=20
> assigning them :-/).

Or maybe DT, I'm not very familiar with DT things.

--
 i.

> But yes, it seems to take the bridge window's address and assumes=20
> something is there (which isn't there as we know). So this driver code is=
=20
> plain wrong.
>=20
> Perhaps it would want to use the address of some endpoint device resource=
=20
> instead of the bridge window address (e.g., that device with class 0?).
>=20
> > > If there's nothing to be assigned into the bridge window, the bridge=
=20
> > > window itself is not created, that is the expected behavior (working =
as=20
> > > designed). So you're comparing to the bridge window that was made too=
=20
> > > large due to the disparity (and left unused, AFAICT).
> > >=20
> > > It would be possible to put the condition inside the block which adds=
=20
> > > the resource to the realloc_head, I initially put it there but then=
=20
> > > decided to remove the disparity completely because why keep it if no=
=20
> > > resource is going to be placed into the bridge window.
> > >=20
> > Thanks for the educative answers.
> >=20
> > > What's that class 0 device anyway? Why it has class 0?
> > >
> > I don't know yet, it's the first time I'm dealing with a PCI driver. An=
y
> > idea where is the class typically assigned?
>=20
> https://pcisig.com/sites/default/files/files/PCI_Code-ID_r_1_12__v9_Jan_2=
020.pdf
>=20
> Perhaps try a quirk which changes the class of the device underneath the=
=20
> bridge to something else than 0, it should make the resource fitting and=
=20
> allocation to assign its resources.
>=20
> But honestly, that s51xx_pcie_probe() has more than one thing wrong.
>=20
> > >> With the patch applied: https://termbin.com/h3w0
> > >> With the blamed commit reverted: https://termbin.com/3rh6
> > >=20
> >=20
>=20
>=20
--8323328-627129416-1748970589=:937--

