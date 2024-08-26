Return-Path: <linux-pci+bounces-12183-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C599A95E7AE
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 06:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78E572816A1
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 04:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32AD548F7;
	Mon, 26 Aug 2024 04:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I3u7PE/2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5482B58ABC;
	Mon, 26 Aug 2024 04:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724646684; cv=none; b=sEdVc7xs72sivRtFkx5OUAiLR1bGg1pcreYiJ0PBSTzhIEnr7q8QsFxfnQJcQF8totMYtpASRehkGCy+VMuRUzytTmBeXzTHpt7GmFAnHxBnpKS8JP1Lzyw/x7uRBooF8l7C+Au4IIIx8WjAE9/PR/6bN4rzIiYLypm3czHFwmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724646684; c=relaxed/simple;
	bh=7iS5NWe3HqFrtr52vuWoaZuDGSadZOfwHRQ1x6+cdH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KV5sUoc/S5A/uLwAQ3P9xnDqyEHsE9T6aCtUc0DdJJ2fU21Y0cjL4y4a8pCFsAbLfJaOIFPIEbdqCG8XxjzvdL2teRuVdIA9VYpDkVq8RzWlgUC1tZbNO+vIMKCL7tA/fCjBebBwzE2jK8ueL62hTKrdN2rYQNHv1bGEuOCG9Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I3u7PE/2; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724646684; x=1756182684;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7iS5NWe3HqFrtr52vuWoaZuDGSadZOfwHRQ1x6+cdH4=;
  b=I3u7PE/2MDxDEkwiRdOGl0EPZcdG3nmqhg1zXzBodNuZEiGwCt6VjRr3
   8EslW8LIR/lpFNDZ8eIlSMP+aoUk3QkO+4LaelVaDnPraqftmUlnkxl0L
   5Hz3stNKK56sTyEepo8DvNKGZZAYzwT4Q5xAsvGd/57SlhEmCPm3hL5un
   vLtmfuHWK4CpY4ULN2TRGzlXmETKeOOfz3LdJzzJ5Y0i78Y7FDtTvIgWR
   NDQaODZ9/N3kkWJ59vnV6vFJlrgDxo5dFWOvOhXWwl3vcFS/oi4s5MDLI
   HBWxotamWR++RNd3+66mogP5v1J97yU6AvlYhU5HwxugVP4/xxidXpuCJ
   g==;
X-CSE-ConnectionGUID: 3HF7QXuHSsWorSX4PsBDgw==
X-CSE-MsgGUID: ZzLQaHS8ShaW2KHAEetD6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="40517874"
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; 
   d="scan'208";a="40517874"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 21:31:23 -0700
X-CSE-ConnectionGUID: Bt0skaTmRQKBIzx+cfJlig==
X-CSE-MsgGUID: mlRtIT8lQSi4so/rsdg3AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; 
   d="scan'208";a="66714478"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 25 Aug 2024 21:31:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id A6BFC444; Mon, 26 Aug 2024 07:31:18 +0300 (EEST)
Date: Mon, 26 Aug 2024 07:31:18 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Esther Shimanovich <eshimanovich@chromium.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rajat Jain <rajatja@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	iommu@lists.linux.dev, Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] PCI: Detect and trust built-in Thunderbolt chips
Message-ID: <20240826043118.GN1532424@black.fi.intel.com>
References: <20240824042635.GM1532424@black.fi.intel.com>
 <20240824162042.GA411509@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240824162042.GA411509@bhelgaas>

On Sat, Aug 24, 2024 at 11:20:42AM -0500, Bjorn Helgaas wrote:
> On Sat, Aug 24, 2024 at 07:26:35AM +0300, Mika Westerberg wrote:
> > On Fri, Aug 23, 2024 at 04:12:54PM -0500, Bjorn Helgaas wrote:
> > > On Fri, Aug 23, 2024 at 04:53:16PM +0000, Esther Shimanovich wrote:
> > > > Some computers with CPUs that lack Thunderbolt features use discrete
> > > > Thunderbolt chips to add Thunderbolt functionality. These Thunderbolt
> > > > chips are located within the chassis; between the root port labeled
> > > > ExternalFacingPort and the USB-C port.
> > > 
> > > Is this a firmware defect?  I asked this before, and I interpret your
> > > answer of "ExternalFacingPort is not 100% accurate all of the time" as
> > > "yes, this is a firmware defect."  That should be part of the commit
> > > log and code comments.
> > > 
> > > We (of course) have to work around firmware defects, but workarounds
> > > need to be labeled as such instead of masquerading as generic code.
> > > 
> > > > These Thunderbolt PCIe devices should be labeled as fixed and trusted,
> > > > as they are built into the computer. Otherwise, security policies that
> > > > rely on those flags may have unintended results, such as preventing
> > > > USB-C ports from enumerating.
> > > > 
> > > > Detect the above scenario through the process of elimination.
> > > > 
> > > > 1) Integrated Thunderbolt host controllers already have Thunderbolt
> > > >    implemented, so anything outside their external facing root port is
> > > >    removable and untrusted.
> > > > 
> > > >    Detect them using the following properties:
> > > > 
> > > >      - Most integrated host controllers have the usb4-host-interface
> > > >        ACPI property, as described here:
> > > > Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#mapping-native-protocols-pcie-displayport-tunneled-through-usb4-to-usb4-host-routers
> > > > 
> > > >      - Integrated Thunderbolt PCIe root ports before Alder Lake do not
> > > >        have the usb4-host-interface ACPI property. Identify those with
> > > >        their PCI IDs instead.
> > > > 
> > > > 2) If a root port does not have integrated Thunderbolt capabilities, but
> > > >    has the ExternalFacingPort ACPI property, that means the manufacturer
> > > >    has opted to use a discrete Thunderbolt host controller that is
> > > >    built into the computer.
> > > 
> > > Unconvincing.  If a Root Port has an external connector, is it
> > > impossible to plug in a Thunderbolt device to that connector?  I
> > > assume the wires from a Root Port could be traces on a PCB to a
> > > soldered-down Thunderbolt controller, OR could be wires to a connector
> > > where a Thunderbolt controller could be plugged in.  How could we tell
> > > the difference?
> > 
> > You are talking about soldered down controller vs. add-in card (e.g PCIe
> > slot)? We don't really distinguish those.
> 
> That's kind of my point.  We're depending on the platform using
> ExternalFacingPort to tell us whether there's an external connector,
> and in this case it sounds like the platform is lying to us.

It is defined only for PCIe Root Ports (for reasons unknown to me) so
there is no way to put it under the PCIe Downstream Ports itself that
are tunneled. The platform does the best it can here.

> What about PCI_EXP_FLAGS_SLOT?  If a discrete Thunderbolt controller
> is built into the platform, maybe there would be no reason for the
> Root Port to set Slot Implemented and provide the Slot Capabilities/
> Control/Status registers.

It is a regular PCIe device with regular PCIe link upstream and it will
even be hot-removable during the firmware upgrade.

