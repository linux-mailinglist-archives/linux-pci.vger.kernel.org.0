Return-Path: <linux-pci+bounces-7000-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 440AB8B9879
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 12:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBE9E1F247FD
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 10:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E44E56B76;
	Thu,  2 May 2024 10:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iWJ3dun0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE06F56B77;
	Thu,  2 May 2024 10:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714644466; cv=none; b=oimMLMAvoAcLa7MqHLtFEm5JDokjMGl1LVpLiFz4EeGhIvpeengxg6zOdTb7jTPkmMFq0ENVPRdOiJKE35AjlyKEfHnSm8HZZS+6aH4q7IbDVKzxLgj2VtPAysoKV8oPLR45NRLchbOOFjiKYJdRl0ggxHYSOBQjLtpmFNhYEP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714644466; c=relaxed/simple;
	bh=8uB3G0pGdRL8CBBXyH3JKYPUdc1Rc914PuNuP+Iad8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THXNadgc6POeh2aHZjbKw/mnqFhOK4wUdrIKIPcbu5mCLd3tgl8JdxwDYfV92WsaHKAVVKIwVHl1wjf0Rewdq3psGyzrPN0iWZBWAjZTimhwPqIHu9amCbOqrWQm2BUmwYolmGoy3vZ7aU+OTrN62AMRFSJVwimk9B4ld/xlHQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iWJ3dun0; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714644465; x=1746180465;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8uB3G0pGdRL8CBBXyH3JKYPUdc1Rc914PuNuP+Iad8w=;
  b=iWJ3dun0TsnwhQzlc18o6P8eEA/TpnVw+YM5fAH4sLEIe4+ZFc+UgGwo
   w54vG3I+Wx94Oa3/W5r+8oGYComEggTAUaqwjzQrU9xDa1PhW8zJ64OLf
   bKRdKuASe1t95Rl832CmWufgQ/suByaQligrXKM+RdTQmJx12U3NwQZWS
   D4zpf4CIT0MWCO5FDOIpKb40qoGKTMoMDGeJlSSQSJbVC/3EOAgFvsgno
   IwRIGIJdGEGW3uVNqEGe3P8OjqfBaB3NkW31WhKYu0lnUZQ6leylHEnKU
   OFOEsi8Bj7tSlt361PZSPWSexJF01LIBkvIy2FqM4m/IAboHsC61qRqcv
   A==;
X-CSE-ConnectionGUID: rdRTCGuCSM6+/SXa06RtFw==
X-CSE-MsgGUID: 224PmC9tToiU2+kpaQ7jaA==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="32919308"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="32919308"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 03:07:44 -0700
X-CSE-ConnectionGUID: bU+k3h2oQFK3Fk5YbdZTwg==
X-CSE-MsgGUID: sbHBYNo5QWqGpnUmUoVp+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27088453"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 02 May 2024 03:07:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 81BFC21A; Thu,  2 May 2024 13:07:40 +0300 (EEST)
Date: Thu, 2 May 2024 13:07:40 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Esther Shimanovich <eshimanovich@chromium.org>,
	Lukas Wunner <lukas@wunner.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <20240502100740.GH3969176@black.fi.intel.com>
References: <CA+Y6NJEpWpfPqHO6=Z1XFCXZDUq1+g6EFryB+Urq1=h0PhT+fg@mail.gmail.com>
 <7d68a112-0f48-46bf-9f6d-d99b88828761@amd.com>
 <20240423053312.GY112498@black.fi.intel.com>
 <7197b2ce-f815-48a1-a78e-9e139de796b7@amd.com>
 <20240424085608.GE112498@black.fi.intel.com>
 <CA+Y6NJFyi6e7ype6dTAjxsy5aC80NdVOt+Vg-a0O0y_JsfwSGg@mail.gmail.com>
 <Zi0VLrvUWH6P1_or@wunner.de>
 <CA+Y6NJE8hA+wt+auW1wJBWA6EGMc6CGpmdExr3475E_Yys-Zdw@mail.gmail.com>
 <20240502043832.GG3969176@black.fi.intel.com>
 <0f83698e-dca8-4296-b969-fdacda39fec7@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f83698e-dca8-4296-b969-fdacda39fec7@amd.com>

On Thu, May 02, 2024 at 04:54:56AM -0500, Mario Limonciello wrote:
> On 5/1/2024 23:38, Mika Westerberg wrote:
> > Hi,
> > 
> > On Wed, May 01, 2024 at 06:23:28PM -0400, Esther Shimanovich wrote:
> > > I don’t have this device available at my office. I just saw that
> > > StarTech sells a universal laptop docking station with chipset-id
> > > Intel - Alpine Ridge DSL6540. Then I looked up the device, and found
> > > it here: https://linux-hardware.org/?id=pci:8086-1577-8086-0000
> > > 
> > > Therefore, I concluded that the DSL6540 has an NHI component.
> > 
> > Okay understood. Yes Alpine Ridge can be both host and device router. In
> > device configuration such as the above it does not expose NHI. If it is
> > host as in the above list you shared then it includes one.
> 
> There are different PCI IDs for AR for host vs device though, right?

No they are the same. Well I think Titan Ridge has different for device.

Here's my system with AR host and AR dock:

06:00.0 0604: 8086:15d3 (rev 02)
07:00.0 0604: 8086:15d3 (rev 02)
07:01.0 0604: 8086:15d3 (rev 02)
07:02.0 0604: 8086:15d3 (rev 02)
07:04.0 0604: 8086:15d3 (rev 02)
08:00.0 0880: 8086:15d2 (rev 02)

09:00.0 0604: 8086:15d3 (rev 02)
0a:00.0 0604: 8086:15d3 (rev 02)
0a:01.0 0604: 8086:15d3 (rev 02)
0a:02.0 0604: 8086:15d3 (rev 02)
0a:03.0 0604: 8086:15d3 (rev 02)
0a:04.0 0604: 8086:15d3 (rev 02)

> But I guess that could technically be spoofed.
> Is there a fixed PCI ID for the RP used to tunnel for host AR?

No, I don't think so. The Root Port can be anything even non-Intel.

> If so you could special case that anything connected to that PCI ID for RP
> used to tunnel isn't trusted.

None of the PCIe tunnels are trusted. We have IOMMU already in place
that blocks accesses outside. Also it is not possible to have anoter
host router in a domain because:

* The connection manager in the real host router needs to enumerate the
  device router before any tunnels can be established.

* Once it does that it has TopologyID > 0 so it is not a host router and
  cannot receive packets with CM bit set in the route string.

* If it still exposes a PCIe endpoint with NHI that is behind a PCIe
  tunnel from the host router PCIe downstream port so it is behind the full IOMMU
  mappings (as these ports are "external_facing").

Yes if there is such PCIe device the Thunderbolt driver may attach to it
but I don't see what the harm would be since it cannot really affect the
topology (except maybe trying to crash the driver by sending unexpected
replies, or so).

