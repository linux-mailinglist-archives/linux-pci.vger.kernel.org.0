Return-Path: <linux-pci+bounces-21286-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D38F0A32689
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 14:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7284518832A0
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 13:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037AC20C49F;
	Wed, 12 Feb 2025 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IO69Mgzy"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5BD20ADF9;
	Wed, 12 Feb 2025 13:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739365486; cv=none; b=BaPJk8qgALCI5wbKpAldcfinltrPNaNeBYxDW7gCtWSdSeEkxvFsB1BqU6U1YG95sSKr0uKTe1yoiHryq85UZeWVx7YeJ8w87oidQpFMdYb+QS0O122uMbJS5mIOhkgL8au+2PkxDgmLZqaMGfLwhBv6nLOtk8UGKgCiWyMtnuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739365486; c=relaxed/simple;
	bh=WCZsRoAfBIeeP3j95FBTutfOm1Sci4pePFSJGSy/PIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTYUiSjOqS7U2T1ytLqrcPDAVemaSDYo5An2qAygsO2aEVS+kNmv6n/Lrl0rKhs1yFyb6zS3GtLegHaM1RRUagrd9Vfw1vb3vhXLGXlxR1GakS3Vk7WJQkpsfO0hSrtfNS3wFxDxKLLC1EOnOcTGz1Ou9tNSuxnUTezxUbdrjgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IO69Mgzy; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739365474; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=+4pi028ZDZ90b4IIC+xGLwCUNexH+xZRBu7t7xVHCM8=;
	b=IO69Mgzy5WxTI9luBqerMpIHLn94KMSSvDcU7TT4W3L9Qt0xO99ZkPWaudlAtTmDw3dBa8X/vpWbvg6UuNlT4KzaccKAmJ7sb4UaY73ar/XyTUHyaOv0Ahj2/wixzwwueZ8o6Rym0d/eRzwbSpnGVdbgiG3xcf5SJcx8t0Yll9E=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WPKJpeQ_1739365473 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Feb 2025 21:04:33 +0800
Date: Wed, 12 Feb 2025 21:04:32 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Lukas Wunner <lukas@wunner.de>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonthan.Cameron@huawei.com>,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: Disable PCIE hotplug interrupts early when msi
 is disabled
Message-ID: <Z6ycYOKUeOECrcgb@U-2FWC9VHC-2323.local>
References: <20250204053758.6025-1-feng.tang@linux.alibaba.com>
 <20250204053758.6025-2-feng.tang@linux.alibaba.com>
 <Z6HcoUB3i51bzQDs@wunner.de>
 <Z6LhzGaYBW5S41MJ@U-2FWC9VHC-2323.local>
 <Z6RU-681eXl7hcp6@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z6RU-681eXl7hcp6@wunner.de>

On Thu, Feb 06, 2025 at 07:21:47AM +0100, Lukas Wunner wrote:
> [to += Rafael, start of thread is here:
> https://lore.kernel.org/all/Z6HcoUB3i51bzQDs@wunner.de/
> ]
> 
> Hi Rafael,
> 
> On Wed, Feb 05, 2025 at 11:58:04AM +0800, Feng Tang wrote:
> > On Tue, Feb 04, 2025 at 10:23:45AM +0100, Lukas Wunner wrote:
> > > On Tue, Feb 04, 2025 at 01:37:58PM +0800, Feng Tang wrote:
> > > > There was a irq storm bug when testing "pci=nomsi" case, and the root
> > > > cause is: 'nomsi' will disable MSI and let devices and root ports use
> > > > legacy INTX inerrupt, and likely make several devices/ports share one
> > > > interrupt. In the failure case, BIOS doesn't disable the PCIE hotplug
> > > > interrupts, and  actually asserts the command-complete interrupt.
> > > > As MSI is disabled, ACPI initialization code will not enumerate root
> > > > port's PCIE hotplug capability, and pciehp service driver wont' be
> > > > enabled for the root port to handle that interrupt, later on when it is
> > > > shared and enabled by other device driver like NVME or NIC, the "nobody
> > > > care irq storm" happens.
> > >
> > > Is there a section in the PCI Firmware Spec which says ACPI doesn't
> > > enumerate the hotplug capability if MSI is disabled?
> > 
> > No, I didn't get it from spec, but found the logic by code reading
> > during debugging the irq storm issue. The related code is about:
> > 
> > #define ACPI_PCIE_REQ_SUPPORT (OSC_PCI_EXT_CONFIG_SUPPORT \
> > 				| OSC_PCI_ASPM_SUPPORT \
> > 				| OSC_PCI_CLOCK_PM_SUPPORT \
> > 				| OSC_PCI_MSI_SUPPORT)
> 
> Commit 415e12b23792 ("PCI/ACPI: Request _OSC control once for each root
> bridge (v3)") contains a change which doesn't seem to be explained in
> the commit message:
> 
> If the user passes "pci=nomsi" on the command line, Linux doesn't
> request hotplug control (or any other control) from the platform.
> So ACPI always remains responsible for hotplug in the "pci=nomsi"
> case.
> 
> The commit sought to fix a cpu hog issue:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=29722
> 
> It's unclear to me if that bug was fixed by requesting _OSC only once,
> as the commit message suggests, or if the addition of OSC_MSI_SUPPORT
> to ACPI_PCIE_REQ_SUPPORT fixed the issue.
> 
> Since the latter is not mentioned in the commit message,
> it seems plausible to assume that the OSC_MSI_SUPPORT change
> was unintentional.
> 
> In any case it doesn't seem to make sense to not request any
> control in the "pci=nomsi" case.
> 
> It's also worth noting that the behavior is different on
> Apple machines as they use a fixed _OSC set even for "pci=nomsi".
> 
> I'm wondering if OSC_PCI_MSI_SUPPORT should simply be removed
> from ACPI_PCIE_REQ_SUPPORT, but I'm worried that it may cause
> reappearance of the cpu hog issue.
 
Hi Lukas,

I tried to remove OSC_PCI_MSI_SUPPORT from ACPI_PCIE_REQ_SUPPORT, but
after negotiate_os_control(), the 'PCIeHotplug' control is still
disabled in the control capability after ACPI query_osc, run_osc
routines (I haven't figured out why yet), thus the pciehp severvice
driver can't be loader.

Thanks,
Feng

> Thoughts?
> 
> Thanks,
> 
> Lukas

