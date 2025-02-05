Return-Path: <linux-pci+bounces-20736-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 399FBA28BB4
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 14:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508B63A284A
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 13:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2901617BA1;
	Wed,  5 Feb 2025 13:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dArVt+xM"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D49E195;
	Wed,  5 Feb 2025 13:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762297; cv=none; b=r1cju+mzBRok72o8Ugh53/gHVZkceF/lEMShWvWMJ0uJJ6dc2RziT0mFZL+utBJu9JYM6ulmFzttfE9J9QbU1toAayQqaN4cUXIbJVkaiyOXlQ3SgcFPmdNcCDNRneI9DHKAAccSUICZWeNvLjA5BxyBUK6HRaNXqhn7uoB7M/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762297; c=relaxed/simple;
	bh=Jtny5v5xwyP3zMuUPiJUoDCkBGR6m8XkjW2Bk5fbJBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIQyQVT2igaHPuSF1KowCQjPnMEoakuOoZRwRFhQDheOQlI770vUzemc/icqv4SihV2jZJDwus5ZX0guMO1Fx5ExZCLLEGMm3Gntg8G4bhB1PQU0ZzFZeeuNpV52gZU0vA/k9MzBfMuNMMqu9ojN+XrLOLaa3QUeYadpuEN+ygQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dArVt+xM; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1738762283; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=OC0ysBz7zniKgFykvNd2f4lB0AnD//qysLg9NE0XTac=;
	b=dArVt+xM390W19tCYLi24L/3a7DHdYMwEgT1Fp8fjePKehtGEZ0v6fc63ZeKMTV/2Okdd+tl+pPlhAte2t//a9xIiSQp3qgjrpoZWQYv8F8iynEwrYqN9vYPp7KNP1H1WmoLNTXxKWf1S2d6+trYXEyQTLfO9Cm4sNqIkkoD+YY=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WOsbfIs_1738762282 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 05 Feb 2025 21:31:23 +0800
Date: Wed, 5 Feb 2025 21:31:22 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonthan.Cameron@huawei.com>,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: Disable PCIE hotplug interrupts early when msi
 is disabled
Message-ID: <Z6NoKq6RQWNZC3s2@U-2FWC9VHC-2323.local>
References: <20250204053758.6025-1-feng.tang@linux.alibaba.com>
 <20250204053758.6025-2-feng.tang@linux.alibaba.com>
 <Z6HaYkIKLXji_EO7@wunner.de>
 <Z6MF3DuNc4OWHNm-@U-2FWC9VHC-2323.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z6MF3DuNc4OWHNm-@U-2FWC9VHC-2323.local>

On Wed, Feb 05, 2025 at 02:31:56PM +0800, Feng Tang wrote:
> On Tue, Feb 04, 2025 at 10:14:10AM +0100, Lukas Wunner wrote:
> > On Tue, Feb 04, 2025 at 01:37:58PM +0800, Feng Tang wrote:
> > > There was a irq storm bug when testing "pci=nomsi" case, and the root
> > > cause is: 'nomsi' will disable MSI and let devices and root ports use
> > > legacy INTX inerrupt, and likely make several devices/ports share one
> > > interrupt. In the failure case, BIOS doesn't disable the PCIE hotplug
> > > interrupts, and  actually asserts the command-complete interrupt.
> > > As MSI is disabled, ACPI initialization code will not enumerate root
> > > port's PCIE hotplug capability, and pciehp service driver wont' be
> > > enabled for the root port to handle that interrupt, later on when it is
> > > shared and enabled by other device driver like NVME or NIC, the "nobody
> > > care irq storm" happens.
> > > 
> > > So disable the pcie hotplug CCIE/HPIE interrupt in early boot phase when
> > > MSI is not enbaled.
> > 
> > So I think this issue should go away if disabling the interrupt
> > by portdrv is no longer conditional on
> > 
> >   (pcie_ports_native || host->native_pcie_hotplug)
> > 
> > like I've just proposed here:
> > 
> >   https://lore.kernel.org/r/Z6HYuBDP6uvE1Sf4@wunner.de/
> > 
> > ... in which case this patch won't be necessary.  Can you confirm that?
> 
> Thanks for the suggestion! I will try to get the platform for test,
> and report back.
 
I haven't got the platform, but I recalled something, that disabling HP
interrupts inside get_port_device_capability()/portdrv_probe() got called
after the nvme_probe(), so it may still cause the irq storm due to:

* pcie root port's hotplug interrupt asserted
* the interrupt is shared with NVME and other device
* those device drivers enable the interrupt line early before portdrv's
  probe()

That's why we tried to put the disabling early in PCI initialization code.

Thanks,
Feng

> As for the change, 
> 	 +		if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
> 	 +			pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
> 	 +				  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
> 
> The CONFIG_HOTPLUG_PCI_PCIE is always enabled on our platform and many
> distros, I guess the check needs to be removed, which sees the 1 second
> waiting again, and need the waiting logic in 1/2 patch?
> 
> Thanks,
> Feng

