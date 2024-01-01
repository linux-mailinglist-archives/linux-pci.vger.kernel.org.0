Return-Path: <linux-pci+bounces-1587-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4A18214FC
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jan 2024 19:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C765C281D06
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jan 2024 18:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0933234;
	Mon,  1 Jan 2024 18:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lV8z3DVn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AE6D518;
	Mon,  1 Jan 2024 18:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704133908; x=1735669908;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uHQYWjLuuveSvnDuj/VEd1ZDF12rii/PI2weQakgYeg=;
  b=lV8z3DVnp1z+wZFc24jYFvZbAMNL6Kkm81BfIwrFjUHtN0tZ9ajH7oVa
   jLYMG9NGirOAiOKattadR3IXRjYZoMIVja3R2IJdyPa3m2rH/cUCrwiei
   WhNGRRtfy3RUO0s+IdA/lz1CEUbZ0LXGLf++KpsBbuVTEgVE1OmW6hKWo
   S0hObpV/tdyAoxGMEca50IkkO3xgMLbzLk5m1cRw2RcFonsR3Tbdmxsc/
   HDav4DNLt2qqODUPgPEC6f0Di+L9kLB4/RZwjlqFNFv7p+HgRCDbo50ox
   BuIx90wl9/R9O/tsI0J/zHik77pv1Yzbt0XXm/jNpZDEld9dTUpA/J4fE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="4141744"
X-IronPort-AV: E=Sophos;i="6.04,322,1695711600"; 
   d="scan'208";a="4141744"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 10:31:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,322,1695711600"; 
   d="scan'208";a="27877970"
Received: from amazouz-mobl.ger.corp.intel.com ([10.251.210.158])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 10:31:43 -0800
Date: Mon, 1 Jan 2024 20:31:39 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, Krzysztof Wilczy??ski <kw@linux.com>, 
    Alexandru Gagniuc <mr.nuke.me@gmail.com>, 
    Krishna chaitanya chundru <quic_krichai@quicinc.com>, 
    Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
    Bjorn Helgaas <bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>, 
    Alex Deucher <alexdeucher@gmail.com>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, 
    Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v3 06/10] PCI: Cache PCIe device's Supported Speed
 Vector
In-Reply-To: <20231230151931.GA25718@wunner.de>
Message-ID: <94973372-91fc-27fc-b187-7427af9e4b7d@linux.intel.com>
References: <20230929115723.7864-1-ilpo.jarvinen@linux.intel.com> <20230929115723.7864-7-ilpo.jarvinen@linux.intel.com> <20231230151931.GA25718@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-122494420-1704133906=:7866"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-122494420-1704133906=:7866
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Sat, 30 Dec 2023, Lukas Wunner wrote:

> On Fri, Sep 29, 2023 at 02:57:19PM +0300, Ilpo Järvinen wrote:
> > The Supported Link Speeds Vector in the Link Capabilities Register 2
> > corresponds to the bus below on Root Ports and Downstream Ports,
> > whereas it corresponds to the bus above on Upstream Ports and
> > Endpoints.
> 
> It would be good to add a pointer to the spec here.  I think the
> relevant section is PCIe r6.1 sec 7.5.3.18 which says:
> 
>  "Supported Link Speeds Vector - This field indicates the supported
>   Link speed(s) of the associated Port."
>                        ^^^^^^^^^^^^^^^
> 
> Obviously the associated port is upstream on a Switch Upstream Port
> or Endpoint, whereas it is downstream on a Switch Downstream Port
> or Root Port.
> 
> Come to think of it, what about edge cases such as RCiEPs?

On real HW I've seen, RCiEPs don't seem to have these speeds at all 
(PCIe r6.1, sec 7.5.3):

"The Link Capabilities, Link Status, and Link Control registers are 
required for all Root Ports, Switch Ports, Bridges, and Endpoints that are 
not RCiEPs. For Functions that do not implement the Link Capabilities, 
Link Status, and Link Contro registers, these spaces must be hardwired to 
0. Link Capabilities 2, Link Status 2, and Link Control 2 registers are
required for all Root Ports, Switch Ports, Bridges, and Endpoints (except 
for RCiEPs) that implement capabilities requiring those registers. For 
Functions that do not implement the Link Capabilities 2, Link Status 2, 
and Link Control 2 registers, these spaces must be hardwired to 0b."

> > Only the former is currently cached in pcie_bus_speeds in
> > the struct pci_bus. The link speeds that are supported is the
> > intersection of these two.
> 
> I'm wondering if caching both is actually necessary.  Why not cache
> just the intersection?  Do we need either of the two somewhere?

Intersection is enough at least for bwctrl. The only downside that is 
barely worth mentioning is that the bus SLSV has to be re-read when
function 0 sets the intersection.

I can think of somebody wanting to expose the list of both supported speed 
to userspace though sysfs (not done by this patch series), but they could 
be read from the registers in that case so that use case doesn't really 
matter much, IMO.

> > Store the device's Supported Link Speeds Vector into the struct pci_bus
> > when the Function 0 is enumerated (the Multi-Function Devices must have
> > same speeds the same for all Functions) to be easily able to calculate
> > the intersection of Supported Link Speeds.
> 
> Might want to add an explanation what you're going to need this for,
> I assume it's accessed frequently by the bandwidth throttling driver
> in a subsequent patch?

Yes. I tend to try to avoid forward references because some maintainers 
complain about them (leading to minimal changes where true motivations 
have to be hidden because "future" cannot be used to motivate a change 
even if that's often the truest motivation within a patch series). But 
I'll add a fwd ref here to make it more obvious. :-)

-- 
 i.

--8323329-122494420-1704133906=:7866--

