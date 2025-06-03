Return-Path: <linux-pci+bounces-28878-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5DDACCBA6
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 19:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D55F3A7362
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 17:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDBE1A3160;
	Tue,  3 Jun 2025 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ObMCOIWb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12BB155C82;
	Tue,  3 Jun 2025 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748970191; cv=none; b=u0MP3/T6itO4CplIB/EGwTqinv0dIvFpWp10pRa2wPuFuTyyNZ+fggi5XXjkle46FNLnKTpd2DH1bo1COmG3jrHfeZJXGV+86XIP8ic6QRC1MdxhaLePs7jzkYmoq91T/pPzciDakTt52rR/5FR+7XE0JU0jL+rOlvTPD/rqoXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748970191; c=relaxed/simple;
	bh=TRM77rUDHAB4m63wuszm/af252clkJ3m7pLdueQYJvU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ODunuovgDvc7NTJN8+wOLfKAtWnpKlKAophV9fjyIFJm6i4Paqg/qj4xUb5NgPmOLDYh/u2XlWIRZAiIc0i4bSGa1k+6u0CWzVZrkY1GypQxDW/kwSnXZk9sqkrglwja7H/XwAD7K1QnCgcWiK1T53vv/G0FFjKZ3AH/yhonQ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ObMCOIWb; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748970190; x=1780506190;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=TRM77rUDHAB4m63wuszm/af252clkJ3m7pLdueQYJvU=;
  b=ObMCOIWbjIRmpgAg6KILXH0cQk62p/chQ42Ry5a9tJXi5OKKHdRsMdhm
   kwtHy7QqLP3cf68rHI6nXxijqZhqQKXi5iub9cy9LPXzPvSkFJEbLpBef
   Zi8auincccGzk9h4DUpw+qt6Zk4cTa25BxVhYrxbHyu55M9YHmiEWukG3
   OXHq9NGM5KCB9nkWOAopGCVD3fIx0cZh6nnC3Y5bLuo7rmUulOnCFHgKW
   IA/ltGkuPz5PBZ+6nAScNVcxPIc0VBYA2GaTK1zS2MvjebuTWkr+p44zp
   2NEXmKpzNZOnWRT4//7ljPFD97d3p2XfvGU60mFnSpTxthK+9JhsAlojc
   A==;
X-CSE-ConnectionGUID: baLkccmdQ66uiuUgw8/k2A==
X-CSE-MsgGUID: Vw5HSXD/TPK+RsdJ0pynKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="61287730"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="61287730"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 10:03:09 -0700
X-CSE-ConnectionGUID: zcEwYNqjQc+waIKAYZFRQA==
X-CSE-MsgGUID: NU1Z8OqeTQCvx/gLS2TDZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="144803125"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.141])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 10:03:07 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 3 Jun 2025 20:03:02 +0300 (EEST)
To: Tudor Ambarus <tudor.ambarus@linaro.org>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    =?ISO-8859-2?Q?Micha=B3_Winiarski?= <michal.winiarski@intel.com>, 
    Igor Mammedov <imammedo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    William McVicker <willmcvicker@google.com>
Subject: Re: [PATCH 24/25] PCI: Perform reset_resource() and build fail list
 in sync
In-Reply-To: <bd579412-d07c-476d-8932-55c1f69adc9f@linaro.org>
Message-ID: <8df02df4-243e-fbbc-aa00-2da7affde4a0@linux.intel.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com> <20241216175632.4175-25-ilpo.jarvinen@linux.intel.com> <5f103643-5e1c-43c6-b8fe-9617d3b5447c@linaro.org> <8f281667-b4ef-9385-868f-93893b9d6611@linux.intel.com> <3a47fc82-dc21-46c3-873d-68e713304af3@linaro.org>
 <f6ee05f7-174b-76d4-3dbe-12473f676e4d@linux.intel.com> <867e47dc-9454-c00f-6d80-9718e5705480@linux.intel.com> <a56284a4-755d-4eb4-ba77-9ea30e18d08f@linaro.org> <7e882cfb-a35a-bab0-c333-76a4e79243b6@linux.intel.com> <f2d149c6-41a4-4a9a-9739-1ea1c4b06f4b@linaro.org>
 <19ccc09c-1d6b-930e-6ed6-398b34020ca1@linux.intel.com> <c1c0bacd-7842-4e9e-aec4-66eb481aa43f@linaro.org> <fc611a93-1f5f-a86d-f3ca-cb737ed5fa4a@linux.intel.com> <bd579412-d07c-476d-8932-55c1f69adc9f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1144988712-1748968017=:937"
Content-ID: <52a0b719-2ea7-4622-cb85-1d872f1eb4d6@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1144988712-1748968017=:937
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <cdb1ba6d-ce3a-9525-202b-9d2d3bb82a8d@linux.intel.com>

On Tue, 3 Jun 2025, Tudor Ambarus wrote:
> On 6/3/25 3:13 PM, Ilpo J=E4rvinen wrote:
> > On Tue, 3 Jun 2025, Tudor Ambarus wrote:
> >> On 6/3/25 9:13 AM, Ilpo J=E4rvinen wrote:
> >>> So please test if this patch solves your problem:
> >>
> >> It fails in a different way, the bridge window resource never gets
> >> assigned with the proposed patch.
> >=20
> > Is that a failure? I was expecting that to occur. It didn't assign=20
> > any resources into that bridge window.
>=20
> It leads to a watchdog interrupt on my pixel6. Last print I see on my
> console is related to the modem booting status. My wild guess is that
> that modem accesses something from the unassigned bridge window.

The bridge window is not for the bridge device itself. It's as the name=20
says, a window into where subordinate busses can assign their resources.
The bridge knows it must forward that window address range to the=20
subordinate bus.

> In the working case I see the bridge window printed:
> [   15.457310][ T1083] pcieport 0000:00:00.0: [s51xx_pcie_probe] BAR 14:
> tmp rsc : [mem 0x40000000-0x401fffff]
>=20
> [   15.457683][ T1083] cpif: s51xx_pcie_probe: Set Doorbell register
> address.
>=20
> In the failing case I see:
> [   15.623270][ T1113] pcieport 0000:00:00.0: [s51xx_pcie_probe] BAR 14:
> tmp rsc : [??? 0x00000000 flags 0x0]
>=20
> [   15.623638][ T1113] cpif: s51xx_pcie_probe: Set Doorbell register
> address.

Oh, is it this one?

https://github.com/oberdfr/google-modules_radio_samsung_s5300/blob/11a10f95=
5a267a45a1997f65671d7054adf1a33a/s51xx_pcie.c#L366

There are number of crazy things going on there... Probe shouldn't be=20
messing resources like that. If it wants to change resources, a quirk=20
would be more appropriate place I guess but I'm very unsure what that=20
even tries to achieve with all that craziness ("Disable BAR resources" by=
=20
assigning them :-/).

But yes, it seems to take the bridge window's address and assumes=20
something is there (which isn't there as we know). So this driver code is=
=20
plain wrong.

Perhaps it would want to use the address of some endpoint device resource=
=20
instead of the bridge window address (e.g., that device with class 0?).

> > If there's nothing to be assigned into the bridge window, the bridge=20
> > window itself is not created, that is the expected behavior (working as=
=20
> > designed). So you're comparing to the bridge window that was made too=
=20
> > large due to the disparity (and left unused, AFAICT).
> >=20
> > It would be possible to put the condition inside the block which adds=
=20
> > the resource to the realloc_head, I initially put it there but then=20
> > decided to remove the disparity completely because why keep it if no=20
> > resource is going to be placed into the bridge window.
> >=20
> Thanks for the educative answers.
>=20
> > What's that class 0 device anyway? Why it has class 0?
> >
> I don't know yet, it's the first time I'm dealing with a PCI driver. Any
> idea where is the class typically assigned?

https://pcisig.com/sites/default/files/files/PCI_Code-ID_r_1_12__v9_Jan_202=
0.pdf

Perhaps try a quirk which changes the class of the device underneath the=20
bridge to something else than 0, it should make the resource fitting and=20
allocation to assign its resources.

But honestly, that s51xx_pcie_probe() has more than one thing wrong.

> >> With the patch applied: https://termbin.com/h3w0
> >> With the blamed commit reverted: https://termbin.com/3rh6
> >=20
>=20

--=20
 i.
--8323328-1144988712-1748968017=:937--

