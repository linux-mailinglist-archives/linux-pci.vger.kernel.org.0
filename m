Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3617683AB8
	for <lists+linux-pci@lfdr.de>; Wed,  1 Feb 2023 00:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjAaXvA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Jan 2023 18:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjAaXu7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Jan 2023 18:50:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B61538EAD;
        Tue, 31 Jan 2023 15:50:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1EDB1B81D77;
        Tue, 31 Jan 2023 23:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE10C433D2;
        Tue, 31 Jan 2023 23:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675209053;
        bh=aFl+VUDVpujhoAOWmOzkpNW/4tGNs0cKm/I6jSpI+qc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=k3yR/xuWZbpREb18GdLiL+NMHiy0tlBAmleW023UO5DMEl66flLruIRGz/ZtVAcJM
         9k3/rsjd0C98GBW66GVqWg8xw3LIyeOQDrdRRM1D2KiIYXiN2dz5gchGT7R5FdvIin
         G3fTRDiHCUDq5+JM6x3vNPnImjIetjIrDgDj5v9oFFFXsW+hwpSFDpGvEE4bDipKRd
         0UBAAHp0aSJjuKugbwGc4MoKp8GXYb3qrCFeKgYUqnLc60f6x7m9/OztoePjwNZizZ
         qRKTxLQ7Vdz9Pl+yCTQbx9IDrP65CHCJFzCOWD0RYQzteNcokS3hQB7O+nls+hrtt/
         lcg9hT+yBPnEg==
Date:   Tue, 31 Jan 2023 17:50:52 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Matt Fagnani <matt.fagnani@bell.net>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Tony Zhu <tony.zhu@intel.com>, linux-pci@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] PCI: Add translated request only flag for
 pci_enable_pasid()
Message-ID: <20230131235052.GA1811430@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9gQxCmzqq6WXZK4@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 30, 2023 at 02:47:32PM -0400, Jason Gunthorpe wrote:
> On Mon, Jan 30, 2023 at 12:38:10PM -0600, Bjorn Helgaas wrote:
> 
> > Sorry, I'm still confused.  PCI_PASID_XLATED_REQ_ONLY is a
> > device-specific property, and you want to opt-in AMD graphics devices.
> > Where's the AMD graphics-specific change?  The current patch does
> > this:
> > 
> >   pdev_pri_ats_enable
> >     pci_enable_pasid(pdev, 0, PCI_PASID_XLATED_REQ_ONLY)
> > 
> > which looks like it does it for *all* devices below an AMD IOMMU,
> > without any device or driver input.
> 
> AMD GPU has a private interface to AMD IOMMU to support PASID support
> that only it uses.

What is it that makes this a private interface?  It seems like we will
end up enabling PASID on any device below an AMD v2 IOMMU.

I do see the DRM amdgpu_amdkfd_device_init() path that ends up at
domain_enable_v2().  Maybe that's it?

But amd_iommu_domain_alloc() also leads to domain_enable_v2(), and
that's pretty generic, so it looks like we set PD_IOMMUV2_MASK
whenever the IOMMU supports it.

And it seems like we call pci_enable_pasid() for all endpoints below
a v2 IOMMU.  Of course, if the endpoint doesn't have a PASID cap,
pci_enable_pasid() fails (and pdev_pri_ats_enable() probably splats
useless warnings when we try to disable PRI and PASID which haven't
been enabled).

I guess I'm trying to convince myself that no harm in enabling PASID
for any device below an AMD v2 IOMMU.  But I don't think a device is
*required* to use translated addresses with PASID, and if it uses
untranslated addresses with PASID, don't we need ACS to avoid
misrouting?

Bjorn
