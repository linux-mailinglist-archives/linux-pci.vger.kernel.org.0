Return-Path: <linux-pci+bounces-20726-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0741EA2832B
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 04:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94F87165680
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 03:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3660D2139CB;
	Wed,  5 Feb 2025 03:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fMgBbi4V"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0042135C6;
	Wed,  5 Feb 2025 03:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738727898; cv=none; b=CdPuuzamUnlY7u2fPG4sLVo3pkxqsZTutq/M1iDTxUB766vVHk7AxoqVG4WFlRDpncJmYQUVAG63sjrw9PDi6kXYwtKCrkALPsIfaCswY5jpDTLAB1bhb9xaG7XaMXkEIga+p5qchrXzEpYVp7PHZC0hgGQylYPHcTIqRUcwEj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738727898; c=relaxed/simple;
	bh=GZaJfporUK/phOXzDkty93vLcPN/XKaQbeggVKEPrrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6VXwATtIwTcCGvwTUB2OWmShsuckGKHZin/14nAOmc2MLJMKpnGHOupU1W6dRfx8Q/tAEUZ1VtOf5aYly2VOU9eEdCtqQHAeLilcwDefhfjNGQHRWYQcY+8B5VtLhCOEqGdW8HuTmaVw82RIxQjCJuER4Z2jAjwSA2sLkI9ToY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fMgBbi4V; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1738727887; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=TtKV6U+sWTUfUHGjC85VuLjyM+QKfX8/NYWJ0FoT3ZA=;
	b=fMgBbi4VZ4jwXaamkzAEaO6voCvd32L+sYigllCmLjlL9PhEUwrVIXU6gJzmiaAGUMk27z8XdPNroTvssKYJPYxdQmnk8vmBZETQQts3d3RNh+WdPXvZRziVaajgJQznscxdift4x+W+kXWbuDp4qGSD4BBKvLwnUeS3jObsiyE=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WOmBVA6_1738727886 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 05 Feb 2025 11:58:06 +0800
Date: Wed, 5 Feb 2025 11:58:04 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonthan.Cameron@huawei.com>,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: Disable PCIE hotplug interrupts early when msi
 is disabled
Message-ID: <Z6LhzGaYBW5S41MJ@U-2FWC9VHC-2323.local>
References: <20250204053758.6025-1-feng.tang@linux.alibaba.com>
 <20250204053758.6025-2-feng.tang@linux.alibaba.com>
 <Z6HcoUB3i51bzQDs@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z6HcoUB3i51bzQDs@wunner.de>

Hi Lukas,

On Tue, Feb 04, 2025 at 10:23:45AM +0100, Lukas Wunner wrote:
> On Tue, Feb 04, 2025 at 01:37:58PM +0800, Feng Tang wrote:
> > There was a irq storm bug when testing "pci=nomsi" case, and the root
> > cause is: 'nomsi' will disable MSI and let devices and root ports use
> > legacy INTX inerrupt, and likely make several devices/ports share one
> > interrupt. In the failure case, BIOS doesn't disable the PCIE hotplug
> > interrupts, and  actually asserts the command-complete interrupt.
> > As MSI is disabled, ACPI initialization code will not enumerate root
> > port's PCIE hotplug capability, and pciehp service driver wont' be
> > enabled for the root port to handle that interrupt, later on when it is
> > shared and enabled by other device driver like NVME or NIC, the "nobody
> > care irq storm" happens.
> 
> Is there a section in the PCI Firmware Spec which says ACPI doesn't
> enumerate the hotplug capability if MSI is disabled?

No, I didn't get it from spec, but found the logic by code reading
during debugging the irq storm issue. The related code is about:


#define ACPI_PCIE_REQ_SUPPORT (OSC_PCI_EXT_CONFIG_SUPPORT \
				| OSC_PCI_ASPM_SUPPORT \
				| OSC_PCI_CLOCK_PM_SUPPORT \
				| OSC_PCI_MSI_SUPPORT)

 acpi_pci_root_add
	negotiate_os_control
		calculate_support
			if (pci_msi_enabled())
				support |= OSC_PCI_MSI_SUPPORT;
		decode_osc_support
		os_control_query_checks
			if ((support & ACPI_PCIE_REQ_SUPPORT) != ACPI_PCIE_REQ_SUPPORT)
				return false
		acpi_pci_osc_control_set

And later in get_port_device_capability(), the pciehp service bit
won't be set, and driver is not loaded.

Thanks,
Feng

> If so, it should be referenced in the commit message.
> 
> If not, I'm wondering if it's safe to fiddle with the Slot Control
> register given the platform hasn't granted OSPM control of it.
> 
> Of course if this is spec-defined behavior in the nomsi case,
> we could make the write to the Slot Control register conditional
> on that.  But if this turns out to be platform-specific behavior,
> we can't deal with it in generic PCI code but only in a quirk.
> 
> Thanks,
> 
> Lukas

