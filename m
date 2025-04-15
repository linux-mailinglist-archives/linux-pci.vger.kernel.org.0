Return-Path: <linux-pci+bounces-25927-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F61A8A268
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 17:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6297A172871
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 15:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEB81DE3C4;
	Tue, 15 Apr 2025 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRrGEh6D"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ACA199FA4;
	Tue, 15 Apr 2025 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744729736; cv=none; b=ZCOUQrb+wL8YivW4y26Eb2IFz/J21txmmAqcGXkptfTrujwtQJI1GtMLRItTSne7n1yF2j3bIzcJbPB+MJqE8CcrQhRyOcL2JNsIvKtaVCrIhF2LProKXYd2x0L9KEnA0pubeTQEKApW969aLNGauRTgTg236bjb+cqoMUa1MXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744729736; c=relaxed/simple;
	bh=iOCFGQAT84b68xAt3pMOFOVCOmjgcX1L+OzWMeDgY+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P65x3XRp9JSQ/PQkfE7IQ59tY7YsZPsvyzhctSLete+kWi4a6skS+qNQ96Tu2IEgEe5z60x60s8dAZC8okjyIZ1Hz2NbGlJ//oEV8F+uHF2ecURsioJVny2YcSkmd5+W9HgP9M2pGtctfPaRv4XyS2pP0LK0oHBJ+sMROyP8edg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRrGEh6D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0849BC4CEEB;
	Tue, 15 Apr 2025 15:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744729736;
	bh=iOCFGQAT84b68xAt3pMOFOVCOmjgcX1L+OzWMeDgY+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DRrGEh6Dx4EKmnikulVWAAbjfm1F0kKtYZQ8q3BEwTpCDZA0B9+QzGhuCuBKrLymY
	 HV/yOnn7C8aTzJXBXnUmq4iyL34gnw2vr2UacavgID0On6wW26QnN/9ByvcBn57ZSx
	 QnN4owL31dMbGuRaEr6/1i403ibnllJv3xrmPCbvjfyvZDI/bqizPnEgFo+mPzwFKR
	 yYedYK9YV9W+FdohnLbAlY5xySk9MVdddKDk/2RAQp4uMF/Tb9wTwG64yZi3phdI1g
	 JA4V8NNuptOnMFG74HHX/Vi4QD6pEr86q0WMz/EgK09XUoUnOMLZ8KN8iWSMugGijC
	 jwOTQfgTv9e/g==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1u4hu9-000000007Q0-1YOd;
	Tue, 15 Apr 2025 17:08:53 +0200
Date: Tue, 15 Apr 2025 17:08:53 +0200
From: Johan Hovold <johan@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Charan Teja Kalla <quic_charante@quicinc.com>
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe
 path
Message-ID: <Z_52heGno2Y5M6uF@hovoldconsulting.com>
References: <cover.1740753261.git.robin.murphy@arm.com>
 <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
 <Z_jMiC1uj_MJpKVj@hovoldconsulting.com>
 <50a06ba8-0a99-40d2-8601-778ebf451f6a@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50a06ba8-0a99-40d2-8601-778ebf451f6a@arm.com>

On Mon, Apr 14, 2025 at 04:37:59PM +0100, Robin Murphy wrote:
> On 2025-04-11 9:02 am, Johan Hovold wrote:
> > On Fri, Feb 28, 2025 at 03:46:33PM +0000, Robin Murphy wrote:

> >> @@ -155,7 +155,12 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
> >>   		dev_iommu_free(dev);
> >>   	mutex_unlock(&iommu_probe_device_lock);
> >>   
> >> -	if (!err && dev->bus)
> >> +	/*
> >> +	 * If we're not on the iommu_probe_device() path (as indicated by the
> >> +	 * initial dev->iommu) then try to simulate it. This should no longer
> >> +	 * happen unless of_dma_configure() is being misused outside bus code.
> >> +	 */
> > 
> > This assumption does not hold as there is nothing preventing iommu
> > driver probe from racing with a client driver probe.
> 
> Not sure I follow - *this* assumption is that if we arrived here with 
> dev->iommu already allocated then __iommu_probe_device() is already in 
> progress for this device, either in the current callchain or on another 
> thread, and so we can (and should) skip calling into it again. There's 
> no ambiguity about that.

I was referring to the this "should no longer happen unless
of_dma_configure() is being misused outside bus code" claim, which
appears to be false given the splat below.

> >> +	if (!err && dev->bus && !dev_iommu_present)
> >>   		err = iommu_probe_device(dev);
> >>   
> >>   	if (err && err != -EPROBE_DEFER)
> > 
> > I hit the (now moved) dev_WARN() on the ThinkPad T14s where the GPU SMMU
> > is probed late due to a clock dependency and can end up probing in
> > parallel with the GPU driver.
> 
> And what *should* happen is that the GPU driver probe waits for the 
> IOMMU driver probe to finish. Do you have fw_devlink enabled?

Yes, but you shouldn't rely on devlinks for correctness.

That said it does seem like something is not working as you think it is
here, and indeed the iommu supplier link is not created until SMMUv2
probe_device() (see arm_smmu_probe_device()).

So client devices can start to be probed (bus dma_configure() is called)
before their iommu is ready also with devlinks enabled (and I do see
this happen on every boot).

> > [    3.805282] arm-smmu 3da0000.iommu: probing hardware configuration...

> > [    3.829042] platform 3d6a000.gmu: Adding to iommu group 8
> > 
> > [    3.992050] ------------[ cut here ]------------
> > [    3.993045] adreno 3d00000.gpu: late IOMMU probe at driver bind, something fishy here!
> > [    3.994058] WARNING: CPU: 9 PID: 343 at drivers/iommu/iommu.c:579 __iommu_probe_device+0x2b0/0x4ac
> > 
> > [    4.003272] CPU: 9 UID: 0 PID: 343 Comm: kworker/u50:2 Not tainted 6.15.0-rc1 #109 PREEMPT
> > [    4.003276] Hardware name: LENOVO 21N2ZC5PUS/21N2ZC5PUS, BIOS N42ET83W (2.13 ) 10/04/2024
> > 
> > [    4.025943] Call trace:
> > [    4.025945]  __iommu_probe_device+0x2b0/0x4ac (P)
> > [    4.030453]  iommu_probe_device+0x38/0x7c
> > [    4.030455]  of_iommu_configure+0x188/0x26c
> > [    4.030457]  of_dma_configure_id+0xcc/0x300
> > [    4.030460]  platform_dma_configure+0x74/0xac
> > [    4.030462]  really_probe+0x74/0x38c
> 
> Indeed this is exactly what is *not* supposed to be happening - does 
> this patch help at all?
> 
> https://lore.kernel.org/linux-iommu/09d901ad11b3a410fbb6e27f7d04ad4609c3fe4a.1741706365.git.robin.murphy@arm.com/

I've only seen that splat once so far so I don't have a reliable
reproducer.

But AFAICS that patch won't help help here where we appear to have iommu
probe racing with bus dma_configure() called from really_probe() for the
client device.

Johan

