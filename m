Return-Path: <linux-pci+bounces-4286-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0448B86D6E0
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 23:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E96EC1C21250
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 22:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57512200BA;
	Thu, 29 Feb 2024 22:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inTfoRGv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA601E531;
	Thu, 29 Feb 2024 22:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709245984; cv=none; b=LRZydg4PsS0i+Y9j/Jgnvb6RQw5aIUcMb1DUDVrBeNsS2A76ZxGEwGyJ5ZLoqhWcMkBON9D4fkO7PrVCq/sEzG1g2bOJTKzTYbrM4WFMFbFlEnCBP6nyDC8KayK1eaIwrX6axAsbBTRjU185oH+Ry2dy7ms2Opay+DB78L5czZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709245984; c=relaxed/simple;
	bh=Tqdr7me05aTCy55LfVFGoDfhRt9iG44IkAYhOWbHstw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=negJXJJfAd+tyDQ79YnTUk0BzWN0PTH9xiBx5AEx7kBlIN3a8/eKn0L/kv5Zm2MIuJOXsO/V5Ebt1hhO/vLdPhykbqLdpQ+y8jTb8ljsPQ8WTKLXK192zq6W2jAh9crzFKB2HI2izQg2YhY7FqvpAw3WRzkWV5A6U5NfMUkEMzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inTfoRGv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F9EC433F1;
	Thu, 29 Feb 2024 22:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709245983;
	bh=Tqdr7me05aTCy55LfVFGoDfhRt9iG44IkAYhOWbHstw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=inTfoRGvWL0DQ/ZeVQyyjlc+jAPNd3f7AYusD/kVPSOjy+4P6A6aTdM0FSceXuP4H
	 0uxBBAP6PPpf419LSEuqiTtJpXugqaiWLVCmO8b3QssufpKG3oHkBm7RPS4Tm/RaQw
	 WBkmZ2ZrKldVwMxtRLutILAHRsQRjEJUkLbLiIEvijKlRgXLHRha2Hm3VtyZYpAEjA
	 W6eV+JqD/U5a8BP0nef8mYELLu2IBA+0Rho4aXRnltyCuK3a1Wpruw3+wY+W3e7bGI
	 UfsaXVAnZjbGKT1uUYYGk9M3lhcjeeuZYYuntJTYwv2tc1ihw6Syem15By8zzmL0TM
	 dfwAe/DW6maUA==
Date: Thu, 29 Feb 2024 16:33:02 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, bhelgaas@google.com,
	robin.murphy@arm.com, jgg@ziepe.ca, kevin.tian@intel.com,
	dwmw2@infradead.org, will@kernel.org, lukas@wunner.de,
	yi.l.liu@intel.com, dan.carpenter@linaro.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Haorong Ye <yehaorong@bytedance.com>
Subject: Re: [PATCH v13 1/3] PCI: make pci_dev_is_disconnected() helper
 public for other drivers
Message-ID: <20240229223302.GA363505@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3585084-5587-49ca-bc2d-db92714a557b@linux.intel.com>

On Thu, Feb 29, 2024 at 09:58:43AM +0800, Ethan Zhao wrote:
> On 2/27/2024 7:05 AM, Bjorn Helgaas wrote:
> > On Thu, Feb 22, 2024 at 08:54:54PM +0800, Baolu Lu wrote:
> > > On 2024/2/22 17:02, Ethan Zhao wrote:
> > > > Make pci_dev_is_disconnected() public so that it can be called from
> > > > Intel VT-d driver to quickly fix/workaround the surprise removal
> > > > unplug hang issue for those ATS capable devices on PCIe switch downstream
> > > > hotplug capable ports.
> > > > 
> > > > Beside pci_device_is_present() function, this one has no config space
> > > > space access, so is light enough to optimize the normal pure surprise
> > > > removal and safe removal flow.
> > > > 
> > > > Tested-by: Haorong Ye<yehaorong@bytedance.com>
> > > > Signed-off-by: Ethan Zhao<haifeng.zhao@linux.intel.com>
> > > > ---
> > > >    drivers/pci/pci.h   | 5 -----
> > > >    include/linux/pci.h | 5 +++++
> > > >    2 files changed, 5 insertions(+), 5 deletions(-)
> > > Hi PCI subsystem maintainers,
> > > 
> > > The iommu drivers (including, but not limited to, the Intel VT-d driver)
> > > require a helper to check the physical presence of a PCI device in two
> > > scenarios:
> > > 
> > > - During the iommu_release_device() path: This ensures the device is
> > >    physically present before sending device TLB invalidation to device.
> > This wording is fundamentally wrong.  Testing
> > pci_dev_is_disconnected() can never ensure the device will still be
> > present by the time a TLB invalidation is sent.
> 
> The logic of testing pci_dev_is_disconnected() in patch [2/3] works
> in the opposite:
> 
> 1. if pci_dev_is_disconnected() return true, means the device is in
>    the process of surprise removal handling, adapter already been
>    removed from the slot.
> 
> 2. for removed device, no need to send ATS invalidation request to it.
>    removed device lost power, its devTLB wouldn't be valid anymore.
> 
> 3. if pci_dev_is_disconnected() return false, the device is *likely*
>    to be removed at any momoment after this function called.
>    such case will be treated in the iommu ITE fault handling, not to
>    retry the timeout request if device isn't present (patch [3/3]).
> 
> > The device may be removed after the pci_dev_is_disconnected() test and
> > before a TLB invalidate is sent.
> 
> even in the process while TLB is invalidating.
> 
> > This is why I hesitate to expose pci_dev_is_disconnected() (and
> > pci_device_is_present(), which we already export) outside
> > drivers/pci/.  They both lead to terrible mistakes like relying on the
> > false assumption that the result will remain valid after the functions
> > return, without any recognition that we MUST be able to deal with the
> > cases where that assumption is broken.
> 
> Yup, your concern is worthy ,but isn't happening within this patchset.

OK, I acked the patch.

I guess my complaint is really with pci_device_is_present() because
that's even harder to use correctly.

pci_device_is_present():
  slow (may do config access to device)
  true  => device *was* present in the recent past, may not be now
  false => device is not accessible

pci_dev_is_disconnected():
  fast (doesn't touch device)
  true  => device is not accessible
  false => basically means nothing

I guess they're both hard ;)

Bjorn

