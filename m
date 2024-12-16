Return-Path: <linux-pci+bounces-18485-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE8F9F2A87
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 07:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91B45188129C
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 06:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163BC1C07C1;
	Mon, 16 Dec 2024 06:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xv2Pc6jt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB0914D2B7;
	Mon, 16 Dec 2024 06:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734332249; cv=none; b=JgOK0LBLhDriyp9bm9Kb0PkTzkkswH8pgeE4x7MU6C1lrvG4Cz5CYCiYui0R4O2nyaJ3im055jTJq5iaMCOAmbisQZEf9/hrsZDJoTl2gVoDAXtqP+NN/S0RgZ6fgpni+NSNb2NamkmtQOlewyhfDbmEmWkQCVP7toVheJurTYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734332249; c=relaxed/simple;
	bh=mE6dYNIlY28OWcfnd/CJnogiqYFMZrcABGluAIq6/HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooiTOf+ei0B1ld56YOdcufy8t54Uxq4kh1G/d3LJLz6gOrvPKfRYiVleM+cc8cmhTVf5jamFri71VqZion8n0+uaI1RNcqibYZR6Z1QrtyHXQGZ1Vmq+zIxBO8zC10U8QU3QzHSDJ7jfhESIo4M+pqi61xdo/YE/tHYfWGO28uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xv2Pc6jt; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734332248; x=1765868248;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mE6dYNIlY28OWcfnd/CJnogiqYFMZrcABGluAIq6/HE=;
  b=Xv2Pc6jtelsKUpMj34zbPafF6qMowxJ2bxo9u9t+frFc4uxTJe+h6ofl
   4s35Yl3tGvfb8vpADXzyxeJhzB598LYOK0VdVokNnlseg4ohj5cy+bzpd
   jcQ79B17IZhQLGZes3vSZNCa7wKV43n5SBHqLBm7kYA/7xXH0SNgQih1Y
   TkZX3/2jqpJV3e680SWa2uxcpkPUmJxMrI0n/xfCz78V4ifqiHUP6HXIN
   9lICjVGgAQPZrjPUrdMXExGVERuABbhDQiH0VpGZS1wyztiKNChMRlrKh
   fuz+ilc3xkn1t8Fzl/ntDueyI18mMbrulV5QPvKWVOSPE/J927dmxrRGk
   w==;
X-CSE-ConnectionGUID: qpURufUXTBKSC9VxfogG/w==
X-CSE-MsgGUID: f+vNz9FEQtaNarDfnpZsuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="34437845"
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="34437845"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 22:57:26 -0800
X-CSE-ConnectionGUID: rK+hPPh9QICvnGMn5ZMo5Q==
X-CSE-MsgGUID: b8UfaVs6SniBj6Oqi74eFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="96859421"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 15 Dec 2024 22:57:21 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 0E771329; Mon, 16 Dec 2024 08:57:19 +0200 (EET)
Date: Mon, 16 Dec 2024 08:57:19 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Niklas Schnelle <niks@kernel.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>, Krzysztof Wilczy??ski <kw@linux.com>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH] PCI/portdrv: Disable bwctrl service if port is fixed at
 2.5 GT/s
Message-ID: <20241216065719.GA3713119@black.fi.intel.com>
References: <20241207-fix_bwctrl_thunderbolt-v1-1-b711f572a705@kernel.org>
 <Z1gSZCdv3fwnRRNk@wunner.de>
 <70829798889c6d779ca0f6cd3260a765780d1369.camel@kernel.org>
 <Z1lF468L8c84QJkD@wunner.de>
 <dc6e677f-4c19-dd25-8878-8eae9154cff4@linux.intel.com>
 <Z1qoDmF6urJDN5jh@wunner.de>
 <97bbbdecb8c65cfa2625b47aa2585a7417ddcb81.camel@linux.ibm.com>
 <Z1rX1BgdsPHIHOv4@wunner.de>
 <1dcc3ca74c3fbb3b4a1adcafb648dfd2501310f1.camel@kernel.org>
 <Z1vyLNW20RuVaZe5@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z1vyLNW20RuVaZe5@wunner.de>

On Fri, Dec 13, 2024 at 09:37:00AM +0100, Lukas Wunner wrote:
> On Thu, Dec 12, 2024 at 09:40:04PM +0100, Niklas Schnelle wrote:
> > On Thu, 2024-12-12 at 13:32 +0100, Lukas Wunner wrote:
> > > pcie_get_supported_speeds() is used to fill in the supported_speeds
> > > field in struct pci_dev.
> > > 
> > > And that field is used in a number of places (exposure of the max link
> > > speed in sysfs, delay handling in pci_bridge_wait_for_secondary_bus(),
> > > link tuning in radeon/amdgpu drivers, etc).
> > 
> > Side question. If this is used in radeon/amdgpu could detecting the
> > thunderbolt port's max link speed as 2.5 GT/s cause issues for external
> > GPUs?
> 
> I don't think so:
> 
> An attached Thunderbolt gadget (e.g. eGPU) is visible to the OS as a
> PCIe switch.  A portion of the Switch Downstream Ports is used to
> attach Endpoints (e.g. GPU) and the remainder is used for tunneling,
> i.e. to extend the hierarchy further if multiple Thunderbolt devices
> are daisy-chained.
> 
> My expectation is that the Max Link Speed is 8 GT/s on those Downstream
> Ports leading to Endpoints and 2.5 GT/s on those Downstream Ports used
> for tunneling (to conform with the USB4/Thunderbolt spec).  In other words,
> the Supported Link Speeds is the same on all of them, but Max Link Speed
> is reduced to 2.5 GT/s on so-called PCIe Adapters (in USB4/Thunderbolt
> terminology).
> 
> The PCIe Adapters encapsulate PCIe TLPs into Thunderbolt packets and
> send them over the Thunderbolt fabric, and similarly decapsulate TLPs
> received from the fabric.
> 
> There are some illustrations available here which explain the distinction
> between the two types of Downstream Ports:
> 
> https://developer.apple.com/library/archive/documentation/HardwareDrivers/Conceptual/ThunderboltDevGuide/Basics/Basics.html
> 
> I'm hoping Mika or Ilpo can verify the above information.  I have
> lspci dumps here of MeteorLake-P and BarlowRidge host controllers,
> but without any attached USB4/Thunderbolt gadgets.

That's right.

The bandwidth in the PCIe tunnel is dynamic but the adapters announce Gen 1
x 4 according to USB4 spec. You can get up to the 90% of the available
TB/USB4 link bandwidth for PCIe depending what is being tunneled. Graphics
drivers should not really look for these "virtual" PCIe links but instead
the native link if they need to.

