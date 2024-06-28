Return-Path: <linux-pci+bounces-9427-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D739991C912
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 00:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16E8D1C20A54
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 22:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB3180635;
	Fri, 28 Jun 2024 22:25:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A094DA08;
	Fri, 28 Jun 2024 22:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719613505; cv=none; b=aWdZN7kUkM0kWCKexapLA0+RK2E22nR1xxo9C4AQudd5KoH7QPctVumhK/IdKAXui1ZPBOj5wMTj/4swZdOAFoBLCUOUBUDEl6ipAP/NAh8wQytK1d320G8kE8w9VSNFY2oGvuuPALOTggi3o29hz828H5QowIYMpcR7ypPKCz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719613505; c=relaxed/simple;
	bh=Az2RZTuoSKJP3L1ZoMdhA+h5aArUlT4AoE1Omk8ihXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQ8sJ0oj1OEXvLgZlX/VcI1TnhBCrqv2oHV0Jp8jUtS//OQxL0RdHj2JcEs9ffVSzeRD3EMy+Tl+IjCxsvX9fAZuC2RI/uaTA0bqji/+9W8rjy/HgE+SS4yw7T8MyLHWmjm5erWHWKbNbiLgk6ZsrqDV9e4BSV4e5eTQAkNmgNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72701C116B1;
	Fri, 28 Jun 2024 22:24:58 +0000 (UTC)
Date: Fri, 28 Jun 2024 23:24:56 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	maz@kernel.org, anna-maria@linutronix.de, shawnguo@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com, bhelgaas@google.com,
	rdunlap@infradead.org, vidyas@nvidia.com,
	ilpo.jarvinen@linux.intel.com, apatel@ventanamicro.com,
	kevin.tian@intel.com, nipun.gupta@amd.com, den@valinux.co.jp,
	andrew@lunn.ch, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, gregkh@linuxfoundation.org,
	rafael@kernel.org, alex.williamson@redhat.com, will@kernel.org,
	lorenzo.pieralisi@arm.com, jgg@mellanox.com,
	ammarfaizi2@gnuweeb.org, robin.murphy@arm.com,
	lpieralisi@kernel.org, nm@ti.com, kristo@kernel.org,
	vkoul@kernel.org, okaya@kernel.org, agross@kernel.org,
	andersson@kernel.org, mark.rutland@arm.com,
	shameerali.kolothum.thodi@huawei.com, yuzenghui@huawei.com,
	shivamurthy.shastri@linutronix.de
Subject: Re: [patch V4 05/21] irqchip/gic-v3-its: Provide MSI parent for
 PCI/MSI[-X]
Message-ID: <Zn84OIS0zLWASKr2@arm.com>
References: <20240623142137.448898081@linutronix.de>
 <20240623142235.024567623@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240623142235.024567623@linutronix.de>

Hi Thomas,

On Sun, Jun 23, 2024 at 05:18:39PM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The its_pci_msi_prepare() function from the ITS-PCI/MSI code provides the
> 'global' PCI/MSI domains. Move this function to the ITS-MSI parent code and
> amend the function to use the domain hardware size, which is the MSI[X]
> vector count, for allocating the ITS slots for the PCI device.
> 
> Enable PCI matching in msi_parent_ops and provide the necessary update to
> the ITS specific child domain initialization function so that the prepare
> callback gets invoked on allocations.
> 
> The latter might be optimized to do the allocation right at the point where
> the child domain is initialized, but keep it simple for now.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

I just noticed guests (under KVM) failing to boot on my TX2 with your
latest branch. I bisected to this patch as the first bad commit.

I'm away this weekend, so won't have time to dive deeper. It looks like
the CPU is stuck in do_idle() (no timer interrupts?). Also sysrq did not
seem able to get the stack trace on the other CPUs. It fails both with a
single or multiple CPUs in the same way place (shortly before mounting
the rootfs and starting user space).

Not sure whether it's related by Red Hat's CI is also reporting boot
failures:

https://lore.kernel.org/r/66859.124062817530400571@us-mta-477.us.mimecast.lan

I'll drop your branch from the arm64 for-kernelci for now and have a
look again on Monday.

-- 
Catalin

