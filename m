Return-Path: <linux-pci+bounces-6551-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF128ADD26
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 07:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13C91C217EA
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 05:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BE720B0F;
	Tue, 23 Apr 2024 05:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F6s/+jxH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D0C208A5;
	Tue, 23 Apr 2024 05:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713850398; cv=none; b=aI4qVCJfDbpPaJw03FmYcXcW4F1cvF7aArb36Ccmp/uEyPhK75dXtWkCCCeME7nSNHVAQQ4p1zaBe9RwsOWD94kxX96TRDdfeisv1IjbuQrJ8ncQLs3jTz/zXClc9lje2b/lYtYk5IrKuhdTFkQjkvyMaV62VTpaLvcQHGk746Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713850398; c=relaxed/simple;
	bh=R2BSKo8hmc08qir57IGk8gXwODURxQQjLkkhDnV2CCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTZnW/tdtplAoGFsCNpalf/hDYDSlfKMJockfGB4zoi/kMYxwZ4G01R6LsPK4awJuULCY3wvUcW9ZxGBgutmAsXtbTaES7bCEy2zLpln8oH+Yps5NxFpaZC576eV2CK6U+mMKug5jH9SR7CvMScn06qcxNe77dhKzAnMRokRybw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F6s/+jxH; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713850397; x=1745386397;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R2BSKo8hmc08qir57IGk8gXwODURxQQjLkkhDnV2CCE=;
  b=F6s/+jxHmJMTsjLxcvaa8MyGuNALSqmkxGvQB9pKZh294SKnKHjqmJ1v
   eZGgPbSVN00rwfhQ6Qmba5JcOvTqYR9K33VxwY8pU83akmGChkQWW0gMi
   JtakB6ccZJdDdlYhbRHMCEzHJ0X1R9xTkxcxA1tWXWN2rWsqKLRYVe0nJ
   JMuZSNx6G2dKFYw6mT2lYlfEIdukpDGOFgiC593JYhMAjhxPhNh/upzPc
   yxv1FA3+DrwxxBrFoMcILae0cP9F2zqGM6tYxmFiVp3zeWv0G2SN2znUM
   h8C9UcP7USdSTllSxsbd78hiDuZ1PyzpF/PLWIsZFIkj09Y0JcaWWoL7L
   g==;
X-CSE-ConnectionGUID: WuVrdM/pS/64dyyX9sb9nQ==
X-CSE-MsgGUID: xT2l6yoqRY2o/EjUwDjSJw==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="20838961"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="20838961"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 22:33:16 -0700
X-CSE-ConnectionGUID: THToSZMuRHqjJB8EBwXxdA==
X-CSE-MsgGUID: WbEYetJeQOe3RccjRD4aCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24692913"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 22 Apr 2024 22:33:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 26000192; Tue, 23 Apr 2024 08:33:12 +0300 (EEST)
Date: Tue, 23 Apr 2024 08:33:12 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Esther Shimanovich <eshimanovich@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <20240423053312.GY112498@black.fi.intel.com>
References: <20240119102258.GE2543524@black.fi.intel.com>
 <03926c6c-43dc-4ec4-b5a0-eae57c17f507@amd.com>
 <20240123061820.GL2543524@black.fi.intel.com>
 <CA+Y6NJFMDcB7NV49r2WxFzcfgarRiWsWO0rEPwz43PKDiXk61g@mail.gmail.com>
 <CA+Y6NJGz6f8hE4kRDUTGgCj+jddUyHeD_8ocFBkARr7w90jmBw@mail.gmail.com>
 <20240416050353.GI112498@black.fi.intel.com>
 <CA+Y6NJF6+s5zUZeaWtagpMt8Qu0a1oE+3re3c6EsppH+ZsuMRQ@mail.gmail.com>
 <20240419044945.GR112498@black.fi.intel.com>
 <CA+Y6NJEpWpfPqHO6=Z1XFCXZDUq1+g6EFryB+Urq1=h0PhT+fg@mail.gmail.com>
 <7d68a112-0f48-46bf-9f6d-d99b88828761@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d68a112-0f48-46bf-9f6d-d99b88828761@amd.com>

On Mon, Apr 22, 2024 at 02:21:18PM -0500, Mario Limonciello wrote:
> On 4/22/2024 14:17, Esther Shimanovich wrote:
> > Thanks for the explanation! I still don't fully understand how that
> > would work for my use case.
> > 
> > Perhaps it would be better for me to describe the case I am trying to
> > protect against.
> > 
> > To rehash, this quirk was written for devices with discrete
> > Thunderbolt controllers.
> > 
> > For example,
> > CometLake_CPU -> AlpineRidge_Chip -> USB-C Port
> > This device has the ExternalFacingPort property in ACPI.
> > My quirk relabels the Alpine Ridge chip as "fixed" and
> > external-facing, so that devices attached to the USB-C port could be
> > labeled as "removable"
> > 
> > Let's say we have a TigerLake CPU, which has integrated
> > Thunderbolt/USB4 capabilities:
> > 
> > TigerLake_ThunderboltCPU -> USB-C Port
> > This device also has the ExternalFacingPort property in ACPI and lacks
> > the usb4-host-interface property in the ACPI.
> > 
> > My worry is that someone could take an Alpine Ridge Chip Thunderbolt
> > Dock and attach it to the TigerLake CPU
> > 
> > TigerLake_ThunderboltCPU -> USB-C Port -> AlpineRidge_Dock
> > 
> > If that were to happen, this quirk would incorrectly label the Alpine
> > Ridge Dock as "fixed" instead of "removable".
> > 
> > My thinking was that we could prevent this scenario from occurring if
> > we filtered this quirk not to apply on CPU's like Tiger Lake, with
> > integrated Thunderbolt/USB4 capabilities.
> > 
> > ExternalFacingPort is found both on the Comet Lake ACPI and also on
> > the Tiger Lake ACPI. So I can't use that to distinguish between CPUs
> > which don't have integrated Thunderbolt, like Comet Lake, and CPUs
> > with integrated Thunderbolt, like Tiger Lake.
> > 
> > I am looking for something that can tell me if the device's Root Port
> > has the Thunderbolt controller upstream to it or not.
> > Is there anything like that?
> > Or perhaps should I add a check which compares the name of the
> > device's CPU with a list of CPUs that this quirk can be applied to?
> > Or is there some way I can identify the Thunderbolt controller, then
> > determine if it's upstream or downstream from the root port?
> > Or are Alpine Ridge docks not something to worry about at all?
> 
> My thought was once you have a device as untrusted, everything else
> connected to it should "also" be untrusted.

I think what you are looking for is that anything behind a PCIe tunnel
should not have this applied. IIRC the AMD GPU or some code there were
going to add identification of "virtual" links to the bandwidth
calculation functionality.

@Mario, do you remember if this was done already and if that could maybe
be re-used here?

The other way I think is something like this:

  - If it does not have "usb4-host-interface" property (or behind a port
    that has that). These are all tunneled (e.g virtual).

  - It is directly connected to a PCIe root port with
    "ExternalFacingPort" and it has sibling device that is "Thunderbolt
    NHI". This is because you can only have "NHI" on a host router
    according to the USB4 spec.

I may be forgetting something though.

