Return-Path: <linux-pci+bounces-2310-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65137831295
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 07:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5F72B23608
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 06:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED698F40;
	Thu, 18 Jan 2024 06:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YOwqiBC0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8A9B641;
	Thu, 18 Jan 2024 06:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705557701; cv=none; b=tAqVhTKDQ3tXfBk24F7rivOyWp2rD1Fuqv9AJkwUox6jgIymq3l2oK8HPLwM+MFJIplYs3Yo08987Q4HNc0qAmQUV/5R9/1zxEOgO1iXUc2ZXFWa+VfxSc+Mw8x1E33Sxh05X5lbBdCI102HDExPqyHPpL73xKQu9cTHrQO2xRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705557701; c=relaxed/simple;
	bh=qWJUF4vEm8pjestSXCI6d81SET0D64/8tA+HGwOLl+4=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To; b=Fqyp4Wceoaf82o3DLjq5Fjlgb58agVdvDDDT7PjAObfggTBiOTaVxgysQwPTGW/BNJGRngyfAJ+f5rbS0x7RCzy3c+FnMkm9phbLq1M7wBkWXQ3+zRALiTm3a/7BVGIyV7Refoaain/SgFqPzZ/TthxMHB1+5sCUwR50fkcUTmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YOwqiBC0; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705557700; x=1737093700;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qWJUF4vEm8pjestSXCI6d81SET0D64/8tA+HGwOLl+4=;
  b=YOwqiBC0SNdRxo1BTKGv/aZSFSlYpRoGeeg/xn/C1FPUkxxH36vBUJUY
   btiVs4Noy9vDlGF+UDIAMJ6o+NzlbX1HW4mhlSRFgHb/l5fFC0BKb3M22
   FwZwssi15DYcqNeovUaRFTc0+l+Syj/Ix0v8MnziwzxyIrfwNSa1C5nPw
   5IRfPNg+Q3rUo73g4lvUzrOvIFL1QwRQGYKvpB2CKByaSOfuKHqOkmPL+
   vUY4qcweu2vwmUjFR9H5y7Gg01nfDFa5eQS13eiohgNu28SCb+VPxYquU
   Fah6Fi0RsEFOoRTEsEvg/DgUywCooG6a8aHYnrmAHL28buQOVEPaVEUEW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="397512970"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="397512970"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 22:00:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="903714547"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="903714547"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 17 Jan 2024 22:00:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 3440039B; Thu, 18 Jan 2024 08:00:02 +0200 (EET)
Date: Thu, 18 Jan 2024 08:00:02 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Esther Shimanovich <eshimanovich@chromium.org>
Cc: Lukas Wunner <lukas@wunner.de>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <20240118060002.GV2543524@black.fi.intel.com>
References: <20231221-thunderbolt-pci-patch-4-v4-1-2e136e57c9bc@chromium.org>
 <20231228132517.GA12586@wunner.de>
 <20231228133949.GG2543524@black.fi.intel.com>
 <CA+Y6NJFQq39WSSwHwm37ZQV8_rwX+6k5r+0uUs_d1+UyGGLqUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+Y6NJFQq39WSSwHwm37ZQV8_rwX+6k5r+0uUs_d1+UyGGLqUw@mail.gmail.com>

On Wed, Jan 17, 2024 at 04:21:18PM -0500, Esther Shimanovich wrote:
> Thank you for all your comments! I really appreciate all your help
> with this. I will address the style feedback once we reach a decision
> on how we will fix this bug.
> I first will respond to your comments, and then I will list out the
> possible solutions to this bug, in a way that takes into account all
> of your insights.
> 
> On Tue, Dec 26, 2023 at 7:15 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > Can you include a citation (spec name, revision, section) for this
> > DMAR requirement?
> >
> This was my mistake–I misinterpreted what a firmware developer told
> me. This is a firmware ACPI requirement from windows, which is not in
> the DMAR spec. Windows uses it to identify externally exposed PCIE
> root ports.
> https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-externally-exposed-pcie-root-ports
> 
> > But I don't see where the defect is here.  And I doubt that this is
> > really a unique situation.  So it's likely that this will happen on
> > other systems, and we don't want to have to add quirks every time
> > another one shows up.
> ...
> > don't have the new interface.  But we at least need a plan that
> > doesn't require quirks indefinitely.
> ...
> On Thu, Dec 28, 2023 at 8:41 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > This is not scalable at all. You would need to include lots of systems
> > here. And there should be no issue at all anyways.
> My team tests hundreds of different devices, and this is the only one
> which exhibited this issue that we’ve seen so far.
> No other devices we’ve seen so far have a discrete internal
> Thunderbolt controller which is treated as a removable device.
> Therefore, we don’t expect that a large number of devices will need
> this quirk.

Well that's pretty much all Intel Titan Ridge and Maple Ridge based
systems. Some early ones did not use IOMMU but all the rest do.

> > There is really nothing "unique" here. It's exactly as specified by
> > this:
> >
> > https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-externally-exposed-pcie-root-ports
> >
> > and being used in many many system already out there and those have been
> > working just fine.
> I don’t know how many computers have a discrete Thunderbolt chip that
> is separate from their CPU, but this doesn’t seem to be a common
> occurrence.
> These devices were made during a narrow window of time when CPUs
> didn’t have Thunderbolt features yet, so a separate JHL6540 chip had
> to be added so that Lenovo could include Thunderbolt on X1 Carbon Gen
> 7/8.

Before Intel Ice Lake it was all discrete and it is still discrete with
the Barlow Ridge controller who will have exact same ExternalFacing port
as the previous models.

> As you said, these devices do indeed work fine in cases where you
> don’t care if a PCI Thunderbolt device is internal or external, which
> is most cases.
> Problems happen only whenever someone adds a security policy, or some
> other feature that cares about the distinction between a fixed or
> removable PCI device.

Do we have such security policy in the mainline kernel?

> > This has been working just fine so far and as far as I can tell there is
> > no such "policy" in place in the mainline kernel.
> Correct, there is no such policy in the mainline kernel as of now. The
> bug is that the linux kernel’s “removable” property is inaccurate for
> this device.

Or perhaps the "policy" should know this better? IIRC there were some
"exceptions" in the Chrome kernel that allowed to put these devices into
"allowlist" is this not the case anymore?

> > Can you elaborate what the issue is and which mainline kernel you are
> > using to reproduce this?
> Thanks for this question! On a Lenovo Thinkpad Gen 7/Gen 8 computer
> with the linux kernel installed, when you look at the properties of
> the JHL6540 Thunderbolt controller, you see that it is incorrectly
> labeled as removable. I have replicated this bug on the b85ea95d0864
> Linux 6.7-rc1 kernel.
> 
> Before my patch, you see that the JHL6540 controller is inaccurately
> labeled “removable”:
> $ udevadm info -a -p /sys/bus/pci/devices/0000:05:00.0 | grep -e
> {removable} -e {device} -e {vendor} -e looking
>   looking at device '/devices/pci0000:00/0000:00:1d.4/0000:05:00.0':
>     ATTR{device}=="0x15d3"
>     ATTR{removable}=="removable"
>     ATTR{vendor}=="0x8086"

This is actually accurate. The Thunderbolt controller is itself
hot-removable and that BTW happens to be hot-removed when fwupd applies
firmware upgrades to the device.

