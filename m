Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEDBF2FC12
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2019 15:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfE3NRl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 May 2019 09:17:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfE3NRl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 May 2019 09:17:41 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74A202596C;
        Thu, 30 May 2019 13:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559222259;
        bh=/8naYiZk1zWUHlRZ2Zk7467h0WzUbi/3GqU0INsdl/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c5Q9xj5I0ZGYLKMCHnjAl/kGmdwdB8l9vg29wprx/rJWtXMAIDv0DWLsvOdIKpKY+
         qW6gVW9amMwkT3YlnO6Ln5s7zQMxgP32W5JQsAGuXYuedkImsdSrS1GdWpIDJN0QCp
         AsBeuB6xhI0raSrOrcrQ3pvaa8snWIH2dbXgrueM=
Date:   Thu, 30 May 2019 08:17:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com
Subject: Re: [PATCH v2 1/5] PCI/ATS: Add PRI support for PCIe VF devices
Message-ID: <20190530131738.GK28250@google.com>
References: <cover.1557162861.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <f773440c0eee2a8d4e5d6e2856717404ac836458.1557162861.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190529225714.GE28250@google.com>
 <20190529230426.GB5108@araj-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529230426.GB5108@araj-mobl1.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 29, 2019 at 04:04:27PM -0700, Raj, Ashok wrote:
> On Wed, May 29, 2019 at 05:57:14PM -0500, Bjorn Helgaas wrote:
> > On Mon, May 06, 2019 at 10:20:03AM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > 
> > > When IOMMU tries to enable PRI for VF device in
> > > iommu_enable_dev_iotlb(), it always fails because PRI support for PCIe
> > > VF device is currently broken in PCIE driver. Current implementation
> > > expects the given PCIe device (PF & VF) to implement PRI capability
> > > before enabling the PRI support. But this assumption is incorrect. As
> > > per PCIe spec r4.0, sec 9.3.7.11, all VFs associated with PF can only
> > > use the Page Request Interface (PRI) of the PF and not implement it.
> > > Hence we need to create exception for handling the PRI support for PCIe
> > > VF device.
> > > 
> > > Since PRI is shared between PF/VF devices, following rules should apply.
> > > 
> > > 1. Enable PRI in VF only if its already enabled in PF.
> > > 2. When enabling/disabling PRI for VF, instead of configuring the
> > > registers just increase/decrease the usage count (pri_ref_cnt) of PF.
> > > 3. Disable PRI in PF only if pr_ref_cnt is zero.
> > 
> > s/pr_ref_cnt/pri_ref_cnt/
> > 
> > > Cc: Ashok Raj <ashok.raj@intel.com>
> > > Cc: Keith Busch <keith.busch@intel.com>
> > > Suggested-by: Ashok Raj <ashok.raj@intel.com>
> > > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > ---
> > >  drivers/pci/ats.c   | 53 +++++++++++++++++++++++++++++++++++++++++++--
> > >  include/linux/pci.h |  1 +
> > >  2 files changed, 52 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> > > index 97c08146534a..5582e5d83a3f 100644
> > > --- a/drivers/pci/ats.c
> > > +++ b/drivers/pci/ats.c
> > > @@ -181,12 +181,39 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
> > >  	u16 control, status;
> > >  	u32 max_requests;
> > >  	int pos;
> > > +	struct pci_dev *pf;
> > >  
> > >  	if (WARN_ON(pdev->pri_enabled))
> > >  		return -EBUSY;
> > >  
> > >  	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
> > > -	if (!pos)
> > > +
> > > +	if (pdev->is_virtfn) {
> > > +		/*
> > > +		 * Per PCIe r4.0, sec 9.3.7.11, VF must not implement PRI
> > > +		 * Capability.
> > > +		 */
> > > +		if (pos) {
> > > +			dev_err(&pdev->dev, "VF must not implement PRI");
> > > +			return -EINVAL;
> > > +		}
> > 
> > This seems gratuitous.  It finds implementation errors, but since we
> > correctly use the PF here anyway, it doesn't *need* to prevent PRI on
> > the VF from working.
> > 
> > I think you should just have:
> > 
> >   if (pdev->is_virtfn) {
> >     pf = pci_physfn(pdev);
> >     if (!pf->pri_enabled)
> >       return -EINVAL;
> 
> This would be incorrect. Since if we never did any bind_mm to the PF
> PRI would not have been enabled. Currently this is done in the IOMMU 
> driver, and not in the device driver. 

This is functionally the same as the original patch, only omitting the
"VF must not implement PRI" check.

> I suppose we should enable PF capability if its not enabled. Same
> comment would be applicable for PASID as well.

Operating on a device other than the one the driver owns opens the
issue of mutual exclusion and races, so would require careful
scrutiny.  Are PRI/PASID things that could be *always* enabled for the
PF at enumeration-time, or do we have to wait until a driver claims
the VF?  If the latter, are there coordination issues between drivers
of different VFs?

> >     pdev->pri_enabled = 1;
> >     atomic_inc(&pf->pri_ref_cnt);
> >   }
> > 
> >   pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
> >   if (!pos)
> >     return -EINVAL;
> > 
> > > +		pf = pci_physfn(pdev);
> > > +
> > > +		/* If VF config does not match with PF, return error */
> > > +		if (!pf->pri_enabled)
> > > +			return -EINVAL;
> > > +
> > > +		pdev->pri_reqs_alloc = pf->pri_reqs_alloc;
> > 
> > Is there any point in setting vf->pri_reqs_alloc?  I don't think it's
> > used for anything since pri_reqs_alloc is only used to write the PF
> > capability, and we only do that for the PF.
> > 
> > > +		pdev->pri_enabled = 1;
> > > +
> > > +		/* Increment PF PRI refcount */
> > 
> > Superfluous comment, since that's exactly what the code says.  It's
> > always good when the code is so clear that it doesn't require comments :)
> > 
> > > +		atomic_inc(&pf->pri_ref_cnt);
> > > +
> > > +		return 0;
> > > +	}
> > > +
> > > +	if (pdev->is_physfn && !pos)
> > >  		return -EINVAL;
> > >  
> > >  	pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);
> > > @@ -202,7 +229,6 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
> > >  	pci_write_config_word(pdev, pos + PCI_PRI_CTRL, control);
> > >  
> > >  	pdev->pri_enabled = 1;
> > > -
> > >  	return 0;
