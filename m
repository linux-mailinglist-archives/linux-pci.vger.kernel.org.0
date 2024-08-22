Return-Path: <linux-pci+bounces-12027-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 000A395BB1A
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 17:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 780E21F2241A
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 15:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34E41CDA2F;
	Thu, 22 Aug 2024 15:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lq6IpVGn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54261CDA24;
	Thu, 22 Aug 2024 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724342015; cv=none; b=ctSQvv3OB76dKM9NzKgU84O4sq0G7KgRbf7F1yNr9gXIDwRhqvOY5yhzaqCxPshvUgpdvfRJo0CJYUHfnlw3GEp8MmkQzIkHQvkmPfkc+dOeRzdvnyYegTJOfxz4T5bVQ6xjZAM2WEi9nwF5HR2IsVQvvG1AkhT3PcniCrSF0Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724342015; c=relaxed/simple;
	bh=i6d40Ft1FfFBzZ7bSfPOqc5aaJVCiXXzv0Xe4MizKvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBLPO5k5LfVpDxAZ6l8QUnqFAgRBSEhuCemkj85ViwLXAtjwqMM5WQ8X3bR/+GazjnMEpv+X/at2epPxgqSn4+h5qTuKWrrRtuvPqmAdB9q0raRAa+QPsDjm0Jnm6xgvvlrlrv93KyNG9pvQnF6E1hwdflzjFvrDc13xhqTQpmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lq6IpVGn; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724342014; x=1755878014;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i6d40Ft1FfFBzZ7bSfPOqc5aaJVCiXXzv0Xe4MizKvw=;
  b=lq6IpVGnCxjpBK/7evRbXWE/a6srp89wdkCuKvJ11C60W4PmR6xmGB29
   NU+TGGvmQzDZGHklhJLOx0hHMO6c5yPvi74Tm6L3qXu1NGT7M2h2Yb00e
   phNJzEmme/JUbsJv1cH5dxLdMu19Lj7/tF0ldOI4xwAD8v4JltnuCvBi5
   0K670S2K0s4KpSKYoLD4p+6jst27cuAEDhY2+ng+NMtaEnR04Ku67My+f
   jDHyRcYFAJVqNTPH6QoR/QsBcptUvHrhHQdcaAnjZAaZBhRniK2Cdwmal
   IRzlbhUWTSpfPw1szcPddpv1d8jOo/+WWKP6SlDn7lZeQLNXZ0ArYQjlx
   g==;
X-CSE-ConnectionGUID: IK614i3aQKKYnU/qg5kaFg==
X-CSE-MsgGUID: zhkD+LWvTHS9+ZDIJ8nouw==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="33434539"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="33434539"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 08:53:33 -0700
X-CSE-ConnectionGUID: FRzc4wwdSkypV/nXRQEJfA==
X-CSE-MsgGUID: uoo5XAYHTGWXq5HsH7eS1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="66326218"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 22 Aug 2024 08:53:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 4B9422F2; Thu, 22 Aug 2024 18:53:29 +0300 (EEST)
Date: Thu, 22 Aug 2024 18:53:29 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Esther Shimanovich <eshimanovich@chromium.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rajat Jain <rajatja@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	iommu@lists.linux.dev, Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Detect and trust built-in Thunderbolt chips
Message-ID: <20240822155329.GI1532424@black.fi.intel.com>
References: <20240815-trust-tbt-fix-v3-1-6ba01865d54c@chromium.org>
 <6da512d2-464d-40fa-9d05-02928246ddba@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6da512d2-464d-40fa-9d05-02928246ddba@amd.com>

Hi,

On Thu, Aug 22, 2024 at 10:29:55AM -0500, Mario Limonciello wrote:
> On 8/15/2024 14:07, Esther Shimanovich wrote:
> > Some computers with CPUs that lack Thunderbolt features use discrete
> > Thunderbolt chips to add Thunderbolt functionality. These Thunderbolt
> > chips are located within the chassis; between the root port labeled
> > ExternalFacingPort and the USB-C port.
> > 
> > These Thunderbolt PCIe devices should be labeled as fixed and trusted,
> > as they are built into the computer. Otherwise, security policies that
> > rely on those flags may have unintended results, such as preventing
> > USB-C ports from enumerating.
> > 
> > Detect the above scenario through the process of elimination.
> > 
> > 1) Integrated Thunderbolt host controllers already have Thunderbolt
> >     implemented, so anything outside their external facing root port is
> >     removable and untrusted.
> > 
> >     Detect them using the following properties:
> > 
> >       - Most integrated host controllers have the usb4-host-interface
> >         ACPI property, as described here:
> > Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#mapping-native-protocols-pcie-displayport-tunneled-through-usb4-to-usb4-host-routers
> > 
> >       - Integrated Thunderbolt PCIe root ports before Alder Lake do not
> >         have the usb4-host-interface ACPI property. Identify those with
> >         their PCI IDs instead.
> > 
> > 2) If a root port does not have integrated Thunderbolt capabilities, but
> >     has the ExternalFacingPort ACPI property, that means the manufacturer
> >     has opted to use a discrete Thunderbolt host controller that is
> >     built into the computer.
> > 
> >     This host controller can be identified by virtue of being located
> >     directly below an external-facing root port that lacks integrated
> >     Thunderbolt. Label it as trusted and fixed.
> > 
> >     Everything downstream from it is untrusted and removable.
> > 
> > The ExternalFacingPort ACPI property is described here:
> > Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-externally-exposed-pcie-root-ports
> > 
> > Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Signed-off-by: Esther Shimanovich <eshimanovich@chromium.org>
> > Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> > While working with devices that have discrete Thunderbolt chips, I
> > noticed that their internal TBT chips are inaccurately labeled as
> > untrusted and removable.
> > 
> > I've observed that this issue impacts all computers with internal,
> > discrete Intel JHL Thunderbolt chips, such as JHL6240, JHL6340, JHL6540,
> > and JHL7540, across multiple device manufacturers such as Lenovo, Dell,
> > and HP.
> > 
> > This affects the execution of any downstream security policy that
> > relies on the "untrusted" or "removable" flags.
> > 
> > I initially submitted a quirk to resolve this, which was too small in
> > scope, and after some discussion, Mika proposed a more thorough fix:
> > https://lore.kernel.org/lkml/20240510052616.GC4162345@black.fi.intel.com
> > I refactored it and am submitting as a new patch.
> 
> My apologies on my delayed response, I've been OOO a while.
> 
> I had a test with this patch on an AMD Phoenix system on top of 6.11-rc4.  I
> am noticing that with it, it's now flagging an internal PCI host bridge as
> untrusted.  I added some extra debugging and it falls through to the last
> case of pcie_is_tunneled() where it returns true.
> 
> Here is the topology of the system:
> 
> -[0000:00]-+-00.0
>            +-00.2
>            +-01.0
>            +-01.3-[01]----00.0
>            +-02.0
>            +-02.1-[02]----00.0
>            +-02.4-[03]----00.0
>            +-03.0
>            +-03.1-[04-62]--
>            +-04.0
>            +-04.1-[63-c1]--
>            +-08.0
>            +-08.1-[c2]--+-00.0
>            |            +-00.1
>            |            +-00.2
>            |            +-00.3
>            |            +-00.4
>            |            +-00.5
>            |            +-00.6
>            |            \-00.7
>            +-08.2-[c3]--+-00.0
>            |            \-00.1
>            +-08.3-[c4]--+-00.0
>            |            +-00.3
>            |            +-00.4
>            |            +-00.5
>            |            \-00.6
>            +-14.0
>            +-14.3
>            +-18.0
>            +-18.1
>            +-18.2
>            +-18.3
>            +-18.4
>            +-18.5
>            +-18.6
>            \-18.7
> 
> Here are the details of all devices on the system:
> 
> 00:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
> [1022:14e8]
> 00:00.2 IOMMU [0806]: Advanced Micro Devices, Inc. [AMD] Device [1022:14e9]
> 00:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
> [1022:14ea]
> 00:01.3 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device
> [1022:14ee]
> 00:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
> [1022:14ea]
> 00:02.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device
> [1022:14ee]
> 00:02.4 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device
> [1022:14ee]
> 00:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
> [1022:14ea]
> 00:03.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 19h
> USB4/Thunderbolt PCIe tunnel [1022:14ef]
> 00:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
> [1022:14ea]
> 00:04.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 19h
> USB4/Thunderbolt PCIe tunnel [1022:14ef]
> 00:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
> [1022:14ea]
> 00:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device
> [1022:14eb]
> 00:08.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device
> [1022:14eb]
> 00:08.3 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device
> [1022:14eb]
> 00:14.0 SMBus [0c05]: Advanced Micro Devices, Inc. [AMD] FCH SMBus
> Controller [1022:790b] (rev 71)
> 00:14.3 ISA bridge [0601]: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge
> [1022:790e] (rev 51)
> 00:18.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
> [1022:14f0]
> 00:18.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
> [1022:14f1]
> 00:18.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
> [1022:14f2]
> 00:18.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
> [1022:14f3]
> 00:18.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
> [1022:14f4]
> 00:18.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
> [1022:14f5]
> 00:18.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
> [1022:14f6]
> 00:18.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
> [1022:14f7]
> 01:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
> RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller [10ec:8168]
> (rev 1c)
> 02:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS5261 PCI
> Express Card Reader [10ec:5261] (rev 01)
> 03:00.0 Non-Volatile memory controller [0108]: Samsung Electronics Co Ltd
> NVMe SSD Controller PM9A1/PM9A3/980PRO [144d:a80a]
> c2:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc.
> [AMD/ATI] Phoenix1 [1002:15bf] (rev 03)
> c2:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI]
> Rembrandt Radeon High Definition Audio Controller [1002:1640]
> c2:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD]
> Family 19h (Model 74h) CCP/PSP 3.0 Device [1022:15c7]
> c2:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device
> [1022:15b9]
> c2:00.4 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device
> [1022:15ba]
> c2:00.5 Multimedia controller [0480]: Advanced Micro Devices, Inc. [AMD]
> ACP/ACP3X/ACP6x Audio Coprocessor [1022:15e2] (rev 63)
> c2:00.6 Audio device [0403]: Advanced Micro Devices, Inc. [AMD] Family
> 17h/19h HD Audio Controller [1022:15e3]
> c2:00.7 Signal processing controller [1180]: Advanced Micro Devices, Inc.
> [AMD] Device [1022:164a]
> c3:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc.
> [AMD] Device [1022:14ec]
> c3:00.1 Signal processing controller [1180]: Advanced Micro Devices, Inc.
> [AMD] AMD IPU Device [1022:1502]
> c4:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc.
> [AMD] Device [1022:14ec]
> c4:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device
> [1022:15c0]
> c4:00.4 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device
> [1022:15c1]
> c4:00.5 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Pink
> Sardine USB4/Thunderbolt NHI controller #1 [1022:1668]
> c4:00.6 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Pink
> Sardine USB4/Thunderbolt NHI controller #2 [1022:1669]
> 
> Here's the snippet from the kernel log with the patch in place.  You can see
> it flagged 00:02.0 as untrusted and removable, but it definitely isn't.

Is it marked as ExternalFacingPort in the ACPI tables?

