Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58352C1879
	for <lists+linux-pci@lfdr.de>; Mon, 23 Nov 2020 23:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731407AbgKWWeE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Nov 2020 17:34:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:47006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730198AbgKWWeD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Nov 2020 17:34:03 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ED11206B7;
        Mon, 23 Nov 2020 22:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606170842;
        bh=EfAu8mvkAKJtvXGIKHOfxbFORCHbR6lzt8aMQ7RnXjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l8w9dZ7t3FWKznc9S49rhn6NIXGz/p8IffABwKwfF5DIVGHepFHkRsjILerUwnVIw
         7A19bC/zDe/oZI2iD7jpUSOXivrfRImr/95RG1uEdmCD06Y8c1w77fJo14EJvcDwnd
         1REafM5KBMc7EBEBzmURh2A3U7dV0omHi5n2ALxI=
Date:   Mon, 23 Nov 2020 22:33:56 +0000
From:   Will Deacon <will@kernel.org>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Edgar Merger <Edgar.Merger@emerson.com>,
        Joerg Roedel <jroedel@suse.de>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken
Message-ID: <20201123223356.GC12069@willie-the-truck>
References: <20201123134410.10648-1-will@kernel.org>
 <MN2PR12MB4488308D26DB50C18EA3BE0FF7FC0@MN2PR12MB4488.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR12MB4488308D26DB50C18EA3BE0FF7FC0@MN2PR12MB4488.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 23, 2020 at 09:04:14PM +0000, Deucher, Alexander wrote:
> [AMD Public Use]
> 
> > -----Original Message-----
> > From: Will Deacon <will@kernel.org>
> > Sent: Monday, November 23, 2020 8:44 AM
> > To: linux-kernel@vger.kernel.org
> > Cc: linux-pci@vger.kernel.org; iommu@lists.linux-foundation.org; Will
> > Deacon <will@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>;
> > Deucher, Alexander <Alexander.Deucher@amd.com>; Edgar Merger
> > <Edgar.Merger@emerson.com>; Joerg Roedel <jroedel@suse.de>
> > Subject: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken
> > 
> > Edgar Merger reports that the AMD Raven GPU does not work reliably on his
> > system when the IOMMU is enabled:
> > 
> >   | [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx timeout,
> > signaled seq=1, emitted seq=3
> >   | [...]
> >   | amdgpu 0000:0b:00.0: GPU reset begin!
> >   | AMD-Vi: Completion-Wait loop timed out
> >   | iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT
> > device=0b:00.0 address=0x38edc0970]
> > 
> > This is indicative of a hardware/platform configuration issue so, since
> > disabling ATS has been shown to resolve the problem, add a quirk to match
> > this particular device while Edgar follows-up with AMD for more information.
> > 
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Reported-by: Edgar Merger <Edgar.Merger@emerson.com>
> > Suggested-by: Joerg Roedel <jroedel@suse.de>
> > Link:
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.
> > kernel.org%2Flinux-
> > iommu%2FMWHPR10MB1310F042A30661D4158520B589FC0%40MWHPR10M
> > B1310.namprd10.prod.outlook.com&amp;data=04%7C01%7Calexander.deuc
> > her%40amd.com%7C1a883fe14d0c408e7d9508d88fb5df4e%7C3dd8961fe488
> > 4e608e11a82d994e183d%7C0%7C0%7C637417358593629699%7CUnknown%7
> > CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi
> > LCJXVCI6Mn0%3D%7C1000&amp;sdata=TMgKldWzsX8XZ0l7q3%2BszDWXQJJ
> > LOUfX5oGaoLN8n%2B8%3D&amp;reserved=0
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> > 
> > Hi all,
> > 
> > Since Joerg is away at the moment, I'm posting this to try to make some
> > progress with the thread in the Link: tag.
> 
> + Felix
> 
> What system is this?  Can you provide more details?  Does a sbios update
> fix this?  Disabling ATS for all Ravens will break GPU compute for a lot
> of people.  I'd prefer to just black list this particular system (e.g.,
> just SSIDs or revision) if possible.

Cheers, Alex. I'll have to defer to Edgar for the details, as my
understanding from the original thread over at:

https://lore.kernel.org/linux-iommu/MWHPR10MB1310CDB6829DDCF5EA84A14689150@MWHPR10MB1310.namprd10.prod.outlook.com/

is that this is a board developed by his company.

Edgar -- please can you answer Alex's questions?

Will
