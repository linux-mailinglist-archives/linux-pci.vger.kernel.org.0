Return-Path: <linux-pci+bounces-8950-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665B190E2AE
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 07:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7A06B21B04
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 05:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5434155897;
	Wed, 19 Jun 2024 05:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UvEwz7G/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6974D55887;
	Wed, 19 Jun 2024 05:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718774973; cv=none; b=jMN99mCi9NTphc0wnsghsR03jLMsf58tP4RcJuWG1q90w27RqLZ1W7F9WcrWyibTBTV0MWSN94HH0uIDmB78/x41C6iyW+L93/5pwqNtVwvLtMvoXgYhDscpjXTYCNbDKpnDCbPYLR9LtdmApLQWZBl3AHVCUsYBLCkD/nFohqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718774973; c=relaxed/simple;
	bh=ProNh6WDpQJsTCKWeK/xBB+DgqPo4qArcFsOCcPezwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSYYEEvVm/OgCbSwU7H+v7GW1YeooXLjWrhIDVOxKzJOiJg5VIkLLMOFnv79dobYZKyIgcTRpC+9T4DpscdMloyNeAno0dUUeA1ZacLEUFQvAF6Fuq52RiR+Tmd/ujGZ3KuJghldw2/S9jB/x7Wr60vAb5ojCiQ6cohfTuO5lw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UvEwz7G/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718774971; x=1750310971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ProNh6WDpQJsTCKWeK/xBB+DgqPo4qArcFsOCcPezwM=;
  b=UvEwz7G/0ZzxFAge9gmBj4C3LxCjmanrdUIp2EwrHCTyyAO7WFm1TNLL
   8Zr3YXsus3j26122QllO3Aqm0MXiq66jO+5UPaxbbcq8x6z6r3Ve13bGZ
   d/SuazcVK2mBhyZmOiCEVaqFlFgO24hyXcdO3NBcKlSqqdWJv02Kf96Qb
   qD29x2+g9fXk6eDZieoj+hKMX1THZutvL2J3LXjlX93trv8A6BIerrHVR
   gnEN439xbD5dQmm/gzMvhN7S1DVCWG9EkarINWDsG7kRAIfXjqrrL58ex
   /5rYol0kt3QQogMFEboIUEgEZvJmWWXPocga3L0An0yhdDP4ArlYdTkY8
   w==;
X-CSE-ConnectionGUID: czHvkxWIQTm6Q4uEzgfyBw==
X-CSE-MsgGUID: Rd0kxEWPQQWJL34wAosL/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="33235027"
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="33235027"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 22:29:30 -0700
X-CSE-ConnectionGUID: B63f9b/RT0WXS1EvrdiIRg==
X-CSE-MsgGUID: J9RujRSITdSp2fbnatoSKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="65031965"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 18 Jun 2024 22:29:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 705971A3; Wed, 19 Jun 2024 08:29:27 +0300 (EEST)
Date: Wed, 19 Jun 2024 08:29:27 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
	Daniel Drake <drake@endlessos.org>, Gary Li <Gary.Li@amd.com>
Subject: Re: [PATCH 0/4] Verify devices transition from D3cold to D0
Message-ID: <20240619052927.GF1532424@black.fi.intel.com>
References: <20240613054204.5850-1-mario.limonciello@amd.com>
 <20240618131452.GC1532424@black.fi.intel.com>
 <9f465ec4-32b9-4cd8-89de-a57a99880360@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9f465ec4-32b9-4cd8-89de-a57a99880360@amd.com>

On Tue, Jun 18, 2024 at 11:56:50AM -0500, Mario Limonciello wrote:
> On 6/18/2024 08:14, Mika Westerberg wrote:
> > Hi Mario,
> > 
> > On Thu, Jun 13, 2024 at 12:42:00AM -0500, Mario Limonciello wrote:
> > > Gary has reported that when a dock is plugged into a system at the same
> > > time the autosuspend delay has tripped that the USB4 stack malfunctions.
> > > 
> > > Messages show up like this:
> > > 
> > > ```
> > > thunderbolt 0000:e5:00.6: ring_interrupt_active: interrupt for TX ring 0 is already enabled
> > > ```
> > > 
> > > Furthermore the USB4 router is non-functional at this point.
> > 
> > Once the USB4 domain starts the sleep transition, it cannot be
> > interrupted by anything so it always should go through full sleep
> > transition and only then back from sleep.
> > 
> > > Those messages happen because the device is still in D3cold at the time
> > > that the PCI core handed control back to the USB4 connection manager
> > > (thunderbolt).
> > 
> > This is weird. Yes we should be getting the wake from the hotplug but
> > that should happen only after the domain is fully in sleep (D3cold). The
> > BIOS ACPI code is supposed to deal with this.
> 
> Is that from from experience or do you mean there is a spec behavior?
> 
> IE I'm wondering if we have different "expectations" from different
> company's hardware designers.

The spec and the CM guide "imply" this behaviour as far as I can tell,
so that the "sleep event" is done completely once started. I guess this
can be interpreted differently too because it is not explicitly said
there.

Can you ask AMD HW folks if this is their interpretation too? Basically
when we get "Sleep Ready" bit set for all the routers in the domain and
turn off power (send PERST) there cannot be wake events until that is
fully completed.

There is typically a timeout mechanism in the BIOS side (part of the
power off method) that waits for the PCIe links to enter L2 before it
triggers PERST. We have seen an issue on our side that if this L2
transition is not completed in time a wake event triggered but that was
a BIOS issue.

> > > The issue is that it takes time for a device to enter D3cold and do a
> > > conventional reset, and then more time for it to exit D3cold.
> > > 
> > > This appears not to be a new problem; previously there were very similar
> > > reports from Ryzen XHCI controllers.  Quirks were added for those.
> > > Furthermore; adding extra logging it's apparent that other PCI devices
> > > in the system can take more than 10ms to recover from D3cold as well.
> > 
> > They can take anything up to 100ms after the link has trained.
> 
> Right; so currently there is nothing checking they really made it back to D0
> after calling pci_power_up().  I feel like we've "mostly" gotten lucky.

We do have pci_bridge_wait_for_secondary_bus() there but I guess that's
not called for integrated PCIe endpoints such as xHCI and the USB4 Host
Interface. They too enter D3cold once power is turned off so I agree we
might have gotten lucky here with the D3hot 10ms delay.

