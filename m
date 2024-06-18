Return-Path: <linux-pci+bounces-8915-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B89390D201
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 15:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4CAC282E87
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 13:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AA41AAE3A;
	Tue, 18 Jun 2024 13:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OB5B9a9x"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7883C13CA97;
	Tue, 18 Jun 2024 13:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716499; cv=none; b=S5whtr88xZABOhxBbNrg/rfK6XrWAD5wSsf3qRV/ZKO9XHKTYUiSkHMWMmg+0OEJLx1Ql6Ab8qyo7Eq4BBX5lzNQL4xGJ+F4iqJxiU0Q+G8FVuDCZZ1q5GG8UvqocAYeUsrlKYcQtTLde35hgMXPgdrutj7BTEtAWbk4BrwvAr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716499; c=relaxed/simple;
	bh=WgDyQ5YzUy6HdCGUckeHXwVK5Oj57SOYRJWXwepLxS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hB0QxZ9Yu5dmmF017PSGXD6jtW6SHZsy8dduT8ZLSFYwcPNXmssHwh6cuqUU9IMZM9RdG79oCOE6QnjF0Cm8Ryi5TIuaJ09doTAP/kAme7NcXqU1fhv6fdrCpg5u8oug1jL69lWL+2p+2ZWPcOyiOCl0mCl4yTvjO+SRo/L8hF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OB5B9a9x; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718716498; x=1750252498;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WgDyQ5YzUy6HdCGUckeHXwVK5Oj57SOYRJWXwepLxS8=;
  b=OB5B9a9xj/+Nq9DNIrY4sQ4lJJ05buh1yveWt1Hu2MUs+5INawR1oWc9
   8M28Dv8jO+i5MxRQ4/rtSweW40OqVzTjAuppdOxGH60t6Qyg4roF2KDyf
   ktDlEDUPV0rc3cuc7SwYKVkkqM0F+k2gS6Vbw/uoPDxVfr5nmHEogfzzZ
   lACugowYK2CoyMejd4A+zSm5uGI6EbiE6IcUFrwnEZ5WC2AKwK/jH3JIy
   /e4lb9ulEEo4sXlXtF8s7x2QO9MMBQ/onwLotK92WC+bCu1FeM13hAxdr
   928Yx90SaQTVH5uQtyr9QG6EHywurzCqs3+npWs8uF57O8w9QdAeybl9q
   A==;
X-CSE-ConnectionGUID: s/T1Z5RwTCipmCC8z9HKAQ==
X-CSE-MsgGUID: 9JsJC2L/R9SEdrq0cdNVNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="26223701"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="26223701"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 06:14:56 -0700
X-CSE-ConnectionGUID: CJpw4o/XQnStVhsVr8QvxQ==
X-CSE-MsgGUID: XUx20M8NTvSpegtYzyN6TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="41415394"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 18 Jun 2024 06:14:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 092D41CB; Tue, 18 Jun 2024 16:14:52 +0300 (EEST)
Date: Tue, 18 Jun 2024 16:14:52 +0300
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
Message-ID: <20240618131452.GC1532424@black.fi.intel.com>
References: <20240613054204.5850-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240613054204.5850-1-mario.limonciello@amd.com>

Hi Mario,

On Thu, Jun 13, 2024 at 12:42:00AM -0500, Mario Limonciello wrote:
> Gary has reported that when a dock is plugged into a system at the same
> time the autosuspend delay has tripped that the USB4 stack malfunctions.
> 
> Messages show up like this:
> 
> ```
> thunderbolt 0000:e5:00.6: ring_interrupt_active: interrupt for TX ring 0 is already enabled
> ```
> 
> Furthermore the USB4 router is non-functional at this point.

Once the USB4 domain starts the sleep transition, it cannot be
interrupted by anything so it always should go through full sleep
transition and only then back from sleep.

> Those messages happen because the device is still in D3cold at the time
> that the PCI core handed control back to the USB4 connection manager
> (thunderbolt).

This is weird. Yes we should be getting the wake from the hotplug but
that should happen only after the domain is fully in sleep (D3cold). The
BIOS ACPI code is supposed to deal with this.

> The issue is that it takes time for a device to enter D3cold and do a
> conventional reset, and then more time for it to exit D3cold.
> 
> This appears not to be a new problem; previously there were very similar
> reports from Ryzen XHCI controllers.  Quirks were added for those.
> Furthermore; adding extra logging it's apparent that other PCI devices
> in the system can take more than 10ms to recover from D3cold as well.

They can take anything up to 100ms after the link has trained.

