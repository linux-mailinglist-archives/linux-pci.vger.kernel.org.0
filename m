Return-Path: <linux-pci+bounces-25272-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEE3A7B718
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 07:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC9BD189C9E4
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 05:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B6F1494A8;
	Fri,  4 Apr 2025 05:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="crGCxc7K"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3992376;
	Fri,  4 Apr 2025 05:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743744180; cv=none; b=QlF61pwtwxyRt045vxfs9pxZiwCO9oCP7IYw9clRnPJsEdprVhjTH0/BV0Ntjyg7n3+QyTEc0Y3xL+9gUE8CnnjrghzSUHzosOYm7nfcfdf1K0LtWDTc1mAeJs2wuFYrmfA70AWJqld/t8z5e3Py5/g4xHOp4O+CRkQB7iKNYok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743744180; c=relaxed/simple;
	bh=KKZ5C39aE4fuP8nxojux9CSU6b3alZdEFak+Yg8W9uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooG11p5V6TuC7qUFmdtcRi2n4YuHgCP1nruvanoxxdyda1Eg0zuWK3Zfv65CW+S8eW270+T9uX0b+pGlMpDtXCwb1kx2FiRADv9HQJi30DPpqJCRhh0BKfn56XlYW0IVmGavyZlCCK0mhBH6aslU9fvLCAcB1p+jD8vfNpzGPfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=crGCxc7K; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743744179; x=1775280179;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KKZ5C39aE4fuP8nxojux9CSU6b3alZdEFak+Yg8W9uk=;
  b=crGCxc7KRsZCZ+UQwDrLX9ZlXBh76joEHaM8l1VJkk588zvxsdh9ennf
   iUFjBZAdThYXZYtPIY82RGIaNJHh8jFP1iI7tHZsfen0wqk0r0/vLkeeq
   Sw19eMfQmGaDRknM2AquqlQFiTTk18eDIBHIqyX+m9uDo5WNVkqnahN8/
   cSB5YD8FdkoEIL/IFtJKsR6vVoADFQWxBZBDgoLSHXFlPLuNyvCmtsDOF
   sNsFKLI5C7pUdvuqyGOd+r3GQp+/XSoNvYi/bXmi+4trAU2xNjP/lpHq1
   8BR1eepo1i8ndcya5PxKiGkZTAvwxbvrLyOM6DLNTQFabLGY8XUE0Kcdt
   Q==;
X-CSE-ConnectionGUID: Zvp1lXDVS0u2DWQgi/0mxQ==
X-CSE-MsgGUID: Lh9y8uk1TBmIsJVW+lCDKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="45297440"
X-IronPort-AV: E=Sophos;i="6.15,187,1739865600"; 
   d="scan'208";a="45297440"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 22:22:58 -0700
X-CSE-ConnectionGUID: 9USZBu0ET8W5sQckAion3g==
X-CSE-MsgGUID: FtaWlJAAQ1uj8E3S8xDATQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,187,1739865600"; 
   d="scan'208";a="132333907"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 22:22:56 -0700
Date: Fri, 4 Apr 2025 08:22:53 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: rafael@kernel.org, mahesh@linux.ibm.com, oohall@gmail.com,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v1] PCI/AER: Avoid power state transition during system
 suspend
Message-ID: <Z-9srbRKYRMcuksZ@black.fi.intel.com>
References: <20250403074425.1181053-1-raag.jadav@intel.com>
 <Z-9NPQUMt2s90CAA@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-9NPQUMt2s90CAA@wunner.de>

On Fri, Apr 04, 2025 at 05:08:45AM +0200, Lukas Wunner wrote:
> On Thu, Apr 03, 2025 at 01:14:25PM +0530, Raag Jadav wrote:
> > If an error is triggered while system suspend is in progress, any bus
> > level power state transition will result in unpredictable error handling.
> > Mark skip_bus_pm flag as true to avoid this.
> [...]
> > Ideally we'd want to defer recovery until system resume, but this is
> > good enough to prevent device suspend.
> 
> if (system_state == SYSTEM_SUSPEND)
> 
> ... tells you whether the system is suspending, so you could catch that
> in the error recovery code.

Even if we catch it, what'd be the expectation with it?
Do we can simply ignore the error because of system state?

I'm assuming deferring will require a fair bit of revamp (and I'm
not sure if I'm qualified for it).

> Suspend to ACPI state S3 or S4 shouldn't need error recovery through reset
> upon resume because devices are generally reset by BIOS on resume anyway.

Thanks for your input. We have s2idle usecase as well.

So the question here is whether we should allow suspending the device
with errors at all (atleast until successful recovery). Wouldn't the
device resume be unpredictable because of it?

Raag

