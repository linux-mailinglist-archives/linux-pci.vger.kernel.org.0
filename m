Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF4B1300DA
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2019 19:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfE3RU5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 May 2019 13:20:57 -0400
Received: from mga18.intel.com ([134.134.136.126]:48336 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfE3RU4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 May 2019 13:20:56 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 May 2019 10:20:56 -0700
X-ExtLoop1: 1
Received: from araj-mobl1.jf.intel.com ([10.251.6.93])
  by orsmga002.jf.intel.com with ESMTP; 30 May 2019 10:20:55 -0700
Date:   Thu, 30 May 2019 10:20:55 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v2 1/5] PCI/ATS: Add PRI support for PCIe VF devices
Message-ID: <20190530172055.GB18559@araj-mobl1.jf.intel.com>
References: <cover.1557162861.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <f773440c0eee2a8d4e5d6e2856717404ac836458.1557162861.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190529225714.GE28250@google.com>
 <20190529230426.GB5108@araj-mobl1.jf.intel.com>
 <20190530131738.GK28250@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530131738.GK28250@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 30, 2019 at 08:17:38AM -0500, Bjorn Helgaas wrote:
> On Wed, May 29, 2019 at 04:04:27PM -0700, Raj, Ashok wrote:
> > On Wed, May 29, 2019 at 05:57:14PM -0500, Bjorn Helgaas wrote:
> > > On Mon, May 06, 2019 at 10:20:03AM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > > 
> > > > When IOMMU tries to enable PRI for VF device in
> > > > iommu_enable_dev_iotlb(), it always fails because PRI support for PCIe
> > > > VF device is currently broken in PCIE driver. Current implementation
> > > > expects the given PCIe device (PF & VF) to implement PRI capability
> > > > before enabling the PRI support. But this assumption is incorrect. As
> > > > per PCIe spec r4.0, sec 9.3.7.11, all VFs associated with PF can only
> > > > use the Page Request Interface (PRI) of the PF and not implement it.
> > > > Hence we need to create exception for handling the PRI support for PCIe
> > > > VF device.
> > > > 
> > > > Since PRI is shared between PF/VF devices, following rules should apply.
> > > > 
> > > > 1. Enable PRI in VF only if its already enabled in PF.
> > > > 2. When enabling/disabling PRI for VF, instead of configuring the
> > > > registers just increase/decrease the usage count (pri_ref_cnt) of PF.
> > > > 3. Disable PRI in PF only if pr_ref_cnt is zero.
> > > 
> > > s/pr_ref_cnt/pri_ref_cnt/
> > > 
> > > > Cc: Ashok Raj <ashok.raj@intel.com>
> > > > Cc: Keith Busch <keith.busch@intel.com>
> > > > Suggested-by: Ashok Raj <ashok.raj@intel.com>
> > > > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > > ---
> > > >  drivers/pci/ats.c   | 53 +++++++++++++++++++++++++++++++++++++++++++--
> > > >  include/linux/pci.h |  1 +
> > > >  2 files changed, 52 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> > > > index 97c08146534a..5582e5d83a3f 100644
> > > > --- a/drivers/pci/ats.c
> > > > +++ b/drivers/pci/ats.c
> > > > @@ -181,12 +181,39 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
> > > >  	u16 control, status;
> > > >  	u32 max_requests;
> > > >  	int pos;
> > > > +	struct pci_dev *pf;
> > > >  
> > > >  	if (WARN_ON(pdev->pri_enabled))
> > > >  		return -EBUSY;
> > > >  
> > > >  	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
> > > > -	if (!pos)
> > > > +
> > > > +	if (pdev->is_virtfn) {
> > > > +		/*
> > > > +		 * Per PCIe r4.0, sec 9.3.7.11, VF must not implement PRI
> > > > +		 * Capability.
> > > > +		 */
> > > > +		if (pos) {
> > > > +			dev_err(&pdev->dev, "VF must not implement PRI");
> > > > +			return -EINVAL;
> > > > +		}
> > > 
> > > This seems gratuitous.  It finds implementation errors, but since we
> > > correctly use the PF here anyway, it doesn't *need* to prevent PRI on
> > > the VF from working.
> > > 
> > > I think you should just have:
> > > 
> > >   if (pdev->is_virtfn) {
> > >     pf = pci_physfn(pdev);
> > >     if (!pf->pri_enabled)
> > >       return -EINVAL;
> > 
> > This would be incorrect. Since if we never did any bind_mm to the PF
> > PRI would not have been enabled. Currently this is done in the IOMMU 
> > driver, and not in the device driver. 
> 
> This is functionally the same as the original patch, only omitting the
> "VF must not implement PRI" check.
> 
> > I suppose we should enable PF capability if its not enabled. Same
> > comment would be applicable for PASID as well.
> 
> Operating on a device other than the one the driver owns opens the
> issue of mutual exclusion and races, so would require careful
> scrutiny.  Are PRI/PASID things that could be *always* enabled for the
> PF at enumeration-time, or do we have to wait until a driver claims
> the VF?  If the latter, are there coordination issues between drivers
> of different VFs?

I suppose that's a reasonably good alternative. You mean we could 
do this when VF's are being created? Otherwise we can do this as its
done today, on demand for all normal PF's. 


Cheers,
Ashok
