Return-Path: <linux-pci+bounces-4064-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A075868474
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 00:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14BD11C212AA
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 23:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7936135A76;
	Mon, 26 Feb 2024 23:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEPafC+t"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C3313540A;
	Mon, 26 Feb 2024 23:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708988739; cv=none; b=uyVQHVxLZLpsDUKe13l6JSbtmAIc1+7gto+VUYOPhw5VbrrCB6BtP0IFpNq5bAI8kI1cHrorVS/lbvx86kupBr63SbD0OIRQyFpTehwc9q92p7Rw4hzYZEP82O9JtHFn2xPkUPTOUPlgSlhE/5rAugHsGdG/dt+PguBARGXbFiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708988739; c=relaxed/simple;
	bh=8wwmBH1m4ZSTAQXnR7kRtjV2xxJFOcBKklt2hP0Ls5k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eJVEsA6BGxtj2s94AHZfgTqrmt8WSa6a6sNUDqF2ViK0MvKXf+/Hmd5jRVX1f5SEAQqRaQ6WWGQa4wtBKHTxXWXMwQnVo4onf+Npp0dDZsAWG+XvhSOPiPm6Rpx8x355Lll1PGob+U3HewJmo5s+K9uxJfo44nvVqwvd8+SstSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEPafC+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37C9C433C7;
	Mon, 26 Feb 2024 23:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708988739;
	bh=8wwmBH1m4ZSTAQXnR7kRtjV2xxJFOcBKklt2hP0Ls5k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZEPafC+t/EDIu9/YZQ97UcneVJZkdEGYM8Eo9rXxSIvnC9CK7fhRSgqOaTOnfF9nH
	 zXmWZIbuJDHjTab5mzDgXFZT7X8utRaRVv8o9F7C0WGm9WMEXcNXhF1PRISIWd5cWw
	 277K9TwSR+0HxBIn3yq3npm7laVEiIiTcYC3uPVYYd9YeEe5C+hCxN7EDy9Cdt0XIa
	 Xo+bcsyM1fxEijO34r9tLjBa6zZc06Ee4fAljbWR7iLxNFtJCbuplY5M7xPNJjJN1C
	 PpoNTZ9zmjxT/W6usux9GJ9DL8JoVe+hCXX23saRj3PfGPBpKIfhQ67hdL8MzJ8DFK
	 /wIuB8AmHXWnQ==
Date: Mon, 26 Feb 2024 17:05:37 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Ethan Zhao <haifeng.zhao@linux.intel.com>, bhelgaas@google.com,
	robin.murphy@arm.com, jgg@ziepe.ca, kevin.tian@intel.com,
	dwmw2@infradead.org, will@kernel.org, lukas@wunner.de,
	yi.l.liu@intel.com, dan.carpenter@linaro.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Haorong Ye <yehaorong@bytedance.com>
Subject: Re: [PATCH v13 1/3] PCI: make pci_dev_is_disconnected() helper
 public for other drivers
Message-ID: <20240226230537.GA10383@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c4637d5-6496-4c68-b2db-4be1e56ca746@linux.intel.com>

On Thu, Feb 22, 2024 at 08:54:54PM +0800, Baolu Lu wrote:
> On 2024/2/22 17:02, Ethan Zhao wrote:
> > Make pci_dev_is_disconnected() public so that it can be called from
> > Intel VT-d driver to quickly fix/workaround the surprise removal
> > unplug hang issue for those ATS capable devices on PCIe switch downstream
> > hotplug capable ports.
> > 
> > Beside pci_device_is_present() function, this one has no config space
> > space access, so is light enough to optimize the normal pure surprise
> > removal and safe removal flow.
> > 
> > Tested-by: Haorong Ye<yehaorong@bytedance.com>
> > Signed-off-by: Ethan Zhao<haifeng.zhao@linux.intel.com>
> > ---
> >   drivers/pci/pci.h   | 5 -----
> >   include/linux/pci.h | 5 +++++
> >   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> Hi PCI subsystem maintainers,
> 
> The iommu drivers (including, but not limited to, the Intel VT-d driver)
> require a helper to check the physical presence of a PCI device in two
> scenarios:
> 
> - During the iommu_release_device() path: This ensures the device is
>   physically present before sending device TLB invalidation to device.

This wording is fundamentally wrong.  Testing
pci_dev_is_disconnected() can never ensure the device will still be
present by the time a TLB invalidation is sent.

The device may be removed after the pci_dev_is_disconnected() test and
before a TLB invalidate is sent.

This is why I hesitate to expose pci_dev_is_disconnected() (and
pci_device_is_present(), which we already export) outside
drivers/pci/.  They both lead to terrible mistakes like relying on the
false assumption that the result will remain valid after the functions
return, without any recognition that we MUST be able to deal with the
cases where that assumption is broken.

This series claims to avoid "continuous hard lockup warnings and
system hangs".  It may reduce the likelihood, but I don't think it can
completely avoid them.  

I don't see any acknowledgement of that in the commit logs of this
series.  E.g., it doesn't say "we can recover from ATS Invalidate
Completion Timeouts, but the timeouts are on the order of minutes, so
we want to avoid them when possible."

And given the "system hangs" language, I am not convinced that we
actually *can* recover from those timeouts.

Using pci_dev_is_disconnected() may make those timeouts less frequent
and give the illusion that the problem is "solved", but it just means
the problem is still there and harder to reproduce.

> - During the device driver lifecycle when a device TLB invalidation
>   timeout event is generated by the IOMMU hardware: This helps handle
>   situations where the device might have been hot-removed.
> 
> While there may be some adjustments needed in patch 3/3, I'd like to
> confirm with you whether it's feasible to expose this helper for general
> use within the iommu subsystem.
> 
> If you agree with this change, I can route this patch to Linus through
> the iommu tree with an "acked-by" or "reviewed-by" tag from you.
> 
> Best regards,
> baolu

