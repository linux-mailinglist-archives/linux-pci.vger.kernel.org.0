Return-Path: <linux-pci+bounces-6685-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA20A8B2F8D
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 06:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42C5D1F22B0C
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 04:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73EE139D18;
	Fri, 26 Apr 2024 04:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cdv7YVjI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C5C1E531;
	Fri, 26 Apr 2024 04:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714107133; cv=none; b=UL7XXDlUngRRIcyLEtMWY77vKHITH043WuPvDxjDifiQA+H+ehu1AsHguDhAYD6/1VARijsn+68dk6BJLmeY432OiYaX2mDHdVuHYJ6yGeSyMdjRTKpb8ifDiiicQ98KRJprVRZK22qbUYSbemOA2zB6dXUA2pt0/gVJ6FP+0lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714107133; c=relaxed/simple;
	bh=Vf4TKhXDwa13uuOuAtx4yYLb09BGNATMaL4ZQCtSPJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjLNM+ZH2UvFy1irrZHqwNSpRcZmEwrBlp0YOpl7Ubpc8nHmmSzyKUeYtU9wR35f+eDjB0O1n2N/49gNYnd2OfHDqHBgjapz8e4Nl5vxRUDIlLldk24c2LalRALKv3ASyXyQyFRS9TvIj0kZpW0LDPe9jBN7u08HcR6Lt8cHz+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cdv7YVjI; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714107132; x=1745643132;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Vf4TKhXDwa13uuOuAtx4yYLb09BGNATMaL4ZQCtSPJQ=;
  b=Cdv7YVjI+cCGAn5c/NBwPvXZHjZ+L8Go2I/KXnLDDNid1ex0RYoReAqz
   6uHCSMh63iC7BlEZHWBEszSPgx2lqaSt1LNYK1USDvbBVJzPzhogzL6Oy
   To7POLTDq7lKMJe8vwEICko7sEQGQmEKg6Fun8JAqkXodZ0zhO8cpvOJK
   orxBc+wpSac76+KUr6u4GcCe5xgsOAvwcsSPQPgdgPJIUhhXrP69zUhf1
   gBp1IqURPhFTBe954eflB6E4iRhMCTlt915OBK6CgOD890iy6SsEd2RG7
   stcW5MXsOxVadZTmS0zxUszLrf6e9jN4KXN0l8+UA3PULg3uur0oa/2fe
   g==;
X-CSE-ConnectionGUID: fSNGvElwRXG6PhqsfNvfEw==
X-CSE-MsgGUID: UMdq9OzJR36YoxUOYmgTig==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="9993141"
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="9993141"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 21:52:11 -0700
X-CSE-ConnectionGUID: 4EX4sy79QYWPSxIZ9nalHg==
X-CSE-MsgGUID: tq2qCnrXQga7MLScO4X7CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="25183122"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 25 Apr 2024 21:52:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 7E69D1C5; Fri, 26 Apr 2024 07:52:07 +0300 (EEST)
Date: Fri, 26 Apr 2024 07:52:07 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Esther Shimanovich <eshimanovich@chromium.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <20240426045207.GI112498@black.fi.intel.com>
References: <CA+Y6NJGz6f8hE4kRDUTGgCj+jddUyHeD_8ocFBkARr7w90jmBw@mail.gmail.com>
 <20240416050353.GI112498@black.fi.intel.com>
 <CA+Y6NJF6+s5zUZeaWtagpMt8Qu0a1oE+3re3c6EsppH+ZsuMRQ@mail.gmail.com>
 <20240419044945.GR112498@black.fi.intel.com>
 <CA+Y6NJEpWpfPqHO6=Z1XFCXZDUq1+g6EFryB+Urq1=h0PhT+fg@mail.gmail.com>
 <7d68a112-0f48-46bf-9f6d-d99b88828761@amd.com>
 <20240423053312.GY112498@black.fi.intel.com>
 <7197b2ce-f815-48a1-a78e-9e139de796b7@amd.com>
 <20240424085608.GE112498@black.fi.intel.com>
 <CA+Y6NJFyi6e7ype6dTAjxsy5aC80NdVOt+Vg-a0O0y_JsfwSGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+Y6NJFyi6e7ype6dTAjxsy5aC80NdVOt+Vg-a0O0y_JsfwSGg@mail.gmail.com>

Hi,

On Thu, Apr 25, 2024 at 05:16:24PM -0400, Esther Shimanovich wrote:
> Thank you for all your help!
> 
> On Tue, Apr 23, 2024 at 1:33 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > The other way I think is something like this:
> >
> >   - If it does not have "usb4-host-interface" property (or behind a port
> >     that has that). These are all tunneled (e.g virtual).
> >
> >   - It is directly connected to a PCIe root port with
> >     "ExternalFacingPort" and it has sibling device that is "Thunderbolt
> >     NHI". This is because you can only have "NHI" on a host router
> >     according to the USB4 spec.
> >
> I did find one example of a docking station that uses the DSL6540
> chip, which has PCI IDs defined in include/linux/pci_ids.h:
> #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_NHI     0x1577
> #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_BRIDGE  0x1578
> It seems like it has an NHI, despite being in an external, removable
> docking station. This appears to contradict what you say about only
> having "NHI" on a host router. I am assuming that by host router, you
> mean the fixed discrete, fixed thunderbolt chip, or the thunderbolt
> controller upstream to the root port. Please correct me if I got
> anything wrong!

So it goes same way with other discrete chips from Intel at least. It is
the same silicon but the NHI is disabled on device routers.

That said, it is entirely possible for a "malicious" device to pretend
to have one so we need to be careful.

> Looking at 18-241_ThunderboltController_Brief_HI.pdf, it seems like
> these Alpine Ridge chips can be used either on a computer or a
> peripheral. (Expected usage: Computer or peripheral)

Yes as above. Most our chips are such.

> So I'm not sure if finding an NHI would guarantee that the device is
> not a peripheral. My original question was how to distinguish a
> Thunderbolt controller that is on a removable peripheral, like a
> docking station-- from one that is a discrete chip fixed to a computer
> or upstream to the root port.

Yes that's the problem. We can figure that out from full USB4 system by
looking at the "usb4-host-interface" ACPI _DSD properties of the
tunneled PCIe Root/Downstream ports. But this does not work with the
pre-USB4 hosts so that requires some sort of heuristics, unfortunately.

> So unless I am misunderstanding something, it appears that my only
> option is waiting for Lukas's patches. Please correct me if that is
> not the case!

I think with Lukas' patches (Lukas please correct me if I got that
wrong) you can find out the PCIe ports which have their link going over
a tunnel. His series works with pre-USB4 devices so that should cover
your case. (In addition to "usb4-host-interface" ACPI _DSD property there
is a special router operation that allows extracting the same PCIe
downstream port mapping that Lukas' patches are doing from DROM so this
should also allow identify all tunneled links.)

This way you can identify the xHCI (well and NHI) that are not behind
PCIe tunnel so that should mean they are really part of the host system
(being soldered or plugged to the PCIe slot or so). If I understood
right this is what you were looking for, correct?

