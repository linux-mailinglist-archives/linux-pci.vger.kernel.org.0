Return-Path: <linux-pci+bounces-20727-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B52A28483
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 07:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E80A23A5BF3
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 06:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A13D217663;
	Wed,  5 Feb 2025 06:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ed37Cxby"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AF122836C;
	Wed,  5 Feb 2025 06:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738737131; cv=none; b=U1b0MtM6mu6EUMsxiJwDmecqYMsNjfTtye6UWwCcLKn1Iian9q0f6Dz/lxarekk0U8H90bSatuT69TpG86oc67cxO5FHaP8nUBb/fcNrnze8wsMAFhxaRXnHmYKbqo5rgWyteokF4//kwKBX2+mix8Nw+xULG5NP9leYG9SbZII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738737131; c=relaxed/simple;
	bh=MkEwKRMU6vsAAFz81NBfQv71aLbGIEEf+K61XYbKAok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h63vj7tBpsMGTYY2NjoxuApFB8uCgWVWaQ5ossx70ewaTVUKVjixOPc/i/XM+r/2DonkG0EKP657b36xCFsTVuF94BcPdc9O5tMP896w6fBoy1QMQ489ht4bfXf0R1Xt57TF+rCTvKDTxg3B+2ojXtpN08XvBNt8Nj0Jo2jkPbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ed37Cxby; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1738737117; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=sTLmyCgxYvpCv8kOMjVj1C6THoBks18tPqCKH2j+emU=;
	b=ed37CxbynWRYJlh1fdNpUWhH8dU8ZW8567PaR5QshpQzFAPwWu7IsDqudCxr6/2mCieOIw91KWbiJG09O2p3Ik7uIz1NX+kj/QIpFI95JzxysjroBgYuOrA5F0tOjynX1OTE7aG6C85radvDQENsk157RAWePmsBeyiXNTFITlw=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WOo-bHM_1738737117 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 05 Feb 2025 14:31:57 +0800
Date: Wed, 5 Feb 2025 14:31:56 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonthan.Cameron@huawei.com>,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: Disable PCIE hotplug interrupts early when msi
 is disabled
Message-ID: <Z6MF3DuNc4OWHNm-@U-2FWC9VHC-2323.local>
References: <20250204053758.6025-1-feng.tang@linux.alibaba.com>
 <20250204053758.6025-2-feng.tang@linux.alibaba.com>
 <Z6HaYkIKLXji_EO7@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z6HaYkIKLXji_EO7@wunner.de>

On Tue, Feb 04, 2025 at 10:14:10AM +0100, Lukas Wunner wrote:
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
> > 
> > So disable the pcie hotplug CCIE/HPIE interrupt in early boot phase when
> > MSI is not enbaled.
> 
> So I think this issue should go away if disabling the interrupt
> by portdrv is no longer conditional on
> 
>   (pcie_ports_native || host->native_pcie_hotplug)
> 
> like I've just proposed here:
> 
>   https://lore.kernel.org/r/Z6HYuBDP6uvE1Sf4@wunner.de/
> 
> ... in which case this patch won't be necessary.  Can you confirm that?

Thanks for the suggestion! I will try to get the platform for test,
and report back.

As for the change, 
	 +		if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
	 +			pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
	 +				  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);

The CONFIG_HOTPLUG_PCI_PCIE is always enabled on our platform and many
distros, I guess the check needs to be removed, which sees the 1 second
waiting again, and need the waiting logic in 1/2 patch?

Thanks,
Feng

> 
> You can split the change I've proposed into two patches if you like.
> 
> Thanks,
> 
> Lukas

