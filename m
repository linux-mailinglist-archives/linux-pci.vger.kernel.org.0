Return-Path: <linux-pci+bounces-28237-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5013DABFD49
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 21:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704069E710E
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 19:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1C828F924;
	Wed, 21 May 2025 19:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ix0Hjd6V"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8217280311;
	Wed, 21 May 2025 19:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747855435; cv=none; b=AjS6PYhgMQtoMKyewhoiZLV1pZmhi28ms8BVWe2C3g+XMihfZ09iLsMDM3sgdMCG8metSTJayO+2V9x5g1bTHeAWSi6jTf+A6O+EnQKcBdMiDXIf1LjwY9OFk/WuehK1S3RxnGvP1MG+behPaSA5Cpe94JHbopKZ7eR100HJCzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747855435; c=relaxed/simple;
	bh=x7SU6M9EiUqm3oCZdiOBIeMXoijnsJiejNFd+jPSSMc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uXiEfSxT9pvjx0l/c+aNoMBZNYIS8aayxfx1CtiQ9ETfa92u9dM7Qj6k48g16cvS8riGt/Gq3JFxnxT1mKB75pVeh2V93htxm3dXx6peC3QbXAgG68dE057C0Dcjb07HN6bnTZ/nTgAirv0ihZAjsBsolwGrWcUij6LuzrHV9qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ix0Hjd6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29530C4CEE4;
	Wed, 21 May 2025 19:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747855434;
	bh=x7SU6M9EiUqm3oCZdiOBIeMXoijnsJiejNFd+jPSSMc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Ix0Hjd6V1tx7KT5m6va1h0PDbofHGDHqXg8V7tyNqlwUs2SN7+1SUzlq6WqxYUK3n
	 Y0tNStRGPFzn3dbbIvkfZmgdo5Z/7NRBsMJdIZ/wYzDnjbYWG8hwysgv1lxLMgk+sK
	 9EQxQy1UMIy9XBxaKH5/0Hf7GAFkxpUO3uvXiAd7AcpuY10uxrfkHafU7YUaZTN137
	 5Z8caXYvQebeBl/TVEU5w0gRMrBIqDeFamINoGn4dvFv+ZUUj0A+Lq3BIjoPC1VOwA
	 fgG5xBra7M6bxg1bZ3l5deHZpQCYIFhjHBQe02WK++ej1oZ2WqvKuG7we9YLRBctWv
	 KTCJJzLwrJ5JA==
Date: Wed, 21 May 2025 14:23:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-pci@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Weinan Liu <wnliu@google.com>,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, Sargun Dhillon <sargun@meta.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v7 02/17] PCI/DPC: Log Error Source ID only when valid
Message-ID: <20250521192352.GA1430719@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250521100035.0000544e@huawei.com>

On Wed, May 21, 2025 at 10:00:35AM +0100, Jonathan Cameron wrote:
> On Tue, 20 May 2025 16:50:19 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > DPC Error Source ID is only valid when the DPC Trigger Reason indicates
> > that DPC was triggered due to reception of an ERR_NONFATAL or ERR_FATAL
> > Message (PCIe r6.0, sec 7.9.14.5).
> > 
> > When DPC was triggered by ERR_NONFATAL (PCI_EXP_DPC_STATUS_TRIGGER_RSN_NFE)
> > or ERR_FATAL (PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE) from a downstream device,
> > log the Error Source ID (decoded into domain/bus/device/function).  Don't
> > print the source otherwise, since it's not valid.
> > 
> > For DPC trigger due to reception of ERR_NONFATAL or ERR_FATAL, the dmesg
> > logging changes:
> > 
> >   - pci 0000:00:01.0: DPC: containment event, status:0x000d source:0x0200
> >   - pci 0000:00:01.0: DPC: ERR_FATAL detected
> >   + pci 0000:00:01.0: DPC: containment event, status:0x000d, ERR_FATAL received from 0000:02:00.0
> > 
> > and when DPC triggered for other reasons, where DPC Error Source ID is
> > undefined, e.g., unmasked uncorrectable error:
> > 
> >   - pci 0000:00:01.0: DPC: containment event, status:0x0009 source:0x0200
> >   - pci 0000:00:01.0: DPC: unmasked uncorrectable error detected
> >   + pci 0000:00:01.0: DPC: containment event, status:0x0009: unmasked uncorrectable error detected
> > 
> > Previously the "containment event" message was at KERN_INFO and the
> > "%s detected" message was at KERN_WARNING.  Now the single message is at
> > KERN_WARNING.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > Tested-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
> > Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Matches the spec conditions as far as I can tell.
> 
> I guess interesting debate on whether providing extra garbage info is
> a bug or not. Maybe a fixes tag for this one as well?

I added:

  Fixes: 26e515713342 ("PCI: Add Downstream Port Containment driver")

since it looks like we've printed the source unconditionally since the
addition of DPC:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pcie/pcie-dpc.c?id=26e515713342#n69

> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> I briefly wondered if it makes sense to have a prefix string initialized
> outside the switch with "containment event, status:%#06x:"
> made sense but it's probably not worth the effort and maybe makes it
> harder to grep for the error messages.  So in the end
> I think your code here is the best option.
> 
> Jonathan

