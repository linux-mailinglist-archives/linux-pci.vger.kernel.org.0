Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDCC8AD5C
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2019 06:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbfHMEKP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Aug 2019 00:10:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfHMEKP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Aug 2019 00:10:15 -0400
Received: from localhost (c-73-15-1-175.hsd1.ca.comcast.net [73.15.1.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EF9E2067D;
        Tue, 13 Aug 2019 04:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565669413;
        bh=pBZ3gmmaRQp2aJ+i6SiLiFOL+fiR4hq5/JfsTS2vGZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z/ghk4kYVXNk98LJT9PinIG1I34TxCImMH7W6GSyjarPv20CE92fnLyFp2xdXR/d2
         FeVdOlVFCj8PdV/VAUKnspZfmVeV9P2tLJA3aHTfd/DL7cJN6PO4y9IqmnmUxRzJ0/
         wPPtLZ3ACbwSm851oAKZzA0G+u9gpTaHvqvyrwks=
Date:   Mon, 12 Aug 2019 23:10:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
Subject: Re: [PATCH v5 2/7] PCI/ATS: Initialize PRI in pci_ats_init()
Message-ID: <20190813041012.GJ7302@google.com>
References: <cover.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <3dd8c36177ac52d9a87655badb000d11785a5a4a.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190812200432.GK11785@google.com>
 <4dec2267-408f-ec29-4407-c2be702467e1@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dec2267-408f-ec29-4407-c2be702467e1@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 12, 2019 at 02:35:32PM -0700, sathyanarayanan kuppuswamy wrote:
> On 8/12/19 1:04 PM, Bjorn Helgaas wrote:
> > On Thu, Aug 01, 2019 at 05:05:59PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > 
> > > Currently, PRI Capability checks are repeated across all PRI API's.
> > > Instead, cache the capability check result in pci_pri_init() and use it
> > > in other PRI API's. Also, since PRI is a shared resource between PF/VF,
> > > initialize default values for common PRI features in pci_pri_init().
> > This patch does two things, and it would be better if they were split:
> > 
> >    1) Cache the PRI capability offset
> >    2) Separate the PF and VF paths
> Ok. I will split it into two patches in next version.
> > 
> > > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > ---
> > >   drivers/pci/ats.c       | 80 ++++++++++++++++++++++++++++-------------
> > >   include/linux/pci-ats.h |  5 +++
> > >   include/linux/pci.h     |  1 +
> > >   3 files changed, 61 insertions(+), 25 deletions(-)
> > > 
> > > diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> > > index cdd936d10f68..280be911f190 100644
> > > --- a/drivers/pci/ats.c
> > > +++ b/drivers/pci/ats.c
> > > @@ -28,6 +28,8 @@ void pci_ats_init(struct pci_dev *dev)
> > >   		return;
> > >   	dev->ats_cap = pos;
> > > +
> > > +	pci_pri_init(dev);
> > >   }
> > >   /**
> > > @@ -170,36 +172,72 @@ int pci_ats_page_aligned(struct pci_dev *pdev)
> > >   EXPORT_SYMBOL_GPL(pci_ats_page_aligned);
> > >   #ifdef CONFIG_PCI_PRI
> > > +
> > > +void pci_pri_init(struct pci_dev *pdev)
> > > +{
> > > +	u32 max_requests;
> > > +	int pos;
> > > +
> > > +	/*
> > > +	 * As per PCIe r4.0, sec 9.3.7.11, only PF is permitted to
> > > +	 * implement PRI and all associated VFs can only use it.
> > > +	 * Since PF already initialized the PRI parameters there is
> > > +	 * no need to proceed further.
> > > +	 */
> > > +	if (pdev->is_virtfn)
> > > +		return;
> > > +
> > > +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
> > > +	if (!pos)
> > > +		return;
> > > +
> > > +	pci_read_config_dword(pdev, pos + PCI_PRI_MAX_REQ, &max_requests);
> > > +
> > > +	/*
> > > +	 * Since PRI is a shared resource between PF and VF, we must not
> > > +	 * configure Outstanding Page Allocation Quota as a per device
> > > +	 * resource in pci_enable_pri(). So use maximum value possible
> > > +	 * as default value.
> > > +	 */
> > > +	pci_write_config_dword(pdev, pos + PCI_PRI_ALLOC_REQ, max_requests);
> > > +
> > > +	pdev->pri_reqs_alloc = max_requests;
> > > +	pdev->pri_cap = pos;
> > > +}
> > > +
> > >   /**
> > >    * pci_enable_pri - Enable PRI capability
> > >    * @ pdev: PCI device structure
> > >    *
> > >    * Returns 0 on success, negative value on error
> > > + *
> > > + * TODO: Since PRI is a shared resource between PF/VF, don't update
> > > + * Outstanding Page Allocation Quota in the same API as a per device
> > > + * feature.
> > >    */
> > >   int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
> > >   {
> > >   	u16 control, status;
> > >   	u32 max_requests;
> > > -	int pos;
> > >   	if (WARN_ON(pdev->pri_enabled))
> > >   		return -EBUSY;
> > > -	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
> > > -	if (!pos)
> > > +	if (!pdev->pri_cap)
> > >   		return -EINVAL;
> > > -	pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);
> > > +	pci_read_config_word(pdev, pdev->pri_cap + PCI_PRI_STATUS, &status);
> > >   	if (!(status & PCI_PRI_STATUS_STOPPED))
> > >   		return -EBUSY;
> > > -	pci_read_config_dword(pdev, pos + PCI_PRI_MAX_REQ, &max_requests);
> > > +	pci_read_config_dword(pdev, pdev->pri_cap + PCI_PRI_MAX_REQ,
> > > +			      &max_requests);
> > >   	reqs = min(max_requests, reqs);
> > >   	pdev->pri_reqs_alloc = reqs;
> > > -	pci_write_config_dword(pdev, pos + PCI_PRI_ALLOC_REQ, reqs);
> > > +	pci_write_config_dword(pdev, pdev->pri_cap + PCI_PRI_ALLOC_REQ, reqs);

> > The comment above says "don't update Outstanding Page Allocation
> > Quota" but it looks like that's what this is doing.
> 
> I don't want to fix it in the current patch-set. It needs further scrutiny.
> That's why I have added the TODO comment for it.

You don't have to fix everything in this patch set, but the comment
should match what the code does.  If you desire, it can go on to
explain why the current behavior is incorrect.  But the current
comment is confusing.

I think the series would read better if the patch that changed from
trying to use the PRI capability on the VF (which always fails) to
using the one on the PF were *first*, i.e., if this change:

  - pci_write_config_dword(pdev, ... + PCI_PRI_ALLOC_REQ, reqs);
  + pci_write_config_dword(pf, ... + PCI_PRI_ALLOC_REQ, reqs);

were before adding the pri_cap cache:

  - pci_write_config_dword(pf, pos + PCI_PRI_ALLOC_REQ, reqs);
  + pci_write_config_dword(pf, pf->pri_cap + PCI_PRI_ALLOC_REQ, reqs);

In the current order, you add the cache to several lines of code that
are never executed.

> Currently, intel-iommu and amd-iommu drivers (only users of
> pci_enable_pri()) hard-codes 32 as a default value for Outstanding Page
> Allocation Quota. Only exception is, amd-iommu sets this value as 1 for
> devices with erratum AMD_PRI_DEV_ERRATUM_LIMIT_REQ_ONE. There is no comment
> or spec reference that explains why 32 is chosen as default value. Also
> configuring 32 as per device max value will break for PF/VF devices since
> they share the PRI interface. So without clear history, I don't want to make
> any changes which might affect their functionality.
> 
> IMO, the correct way is to configure the Outstanding Page Allocation Quota
> with maximum value in pci_pri_init(). So, even if IOMMU can't handle more
> than 32 page request per device, it can fail properly and it should not
> affect the functionality.
> 
> I have added proper configuration for Outstanding Page Allocation Quota in
> pci_pri_init(), but it does not serve any purpose until we fix the part of
> the issue in pci_enable_pri(). If you want, I can remove it for now, and add
> it when fixing the issue in pci_enable_pri().

If it doesn't serve any purpose, please remove it for now.  I think
it's better to keep all the pieces related to that fix together so we
can test them together and backport them together.

> > >   	control = PCI_PRI_CTRL_ENABLE;
> > > -	pci_write_config_word(pdev, pos + PCI_PRI_CTRL, control);
> > > +	pci_write_config_word(pdev, pdev->pri_cap + PCI_PRI_CTRL, control);
> > >   	pdev->pri_enabled = 1;
> > > @@ -216,18 +254,16 @@ EXPORT_SYMBOL_GPL(pci_enable_pri);
> > >   void pci_disable_pri(struct pci_dev *pdev)
> > >   {
> > >   	u16 control;
> > > -	int pos;
> > >   	if (WARN_ON(!pdev->pri_enabled))
> > >   		return;
> > > -	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
> > > -	if (!pos)
> > > +	if (!pdev->pri_cap)
> > >   		return;
> > > -	pci_read_config_word(pdev, pos + PCI_PRI_CTRL, &control);
> > > +	pci_read_config_word(pdev, pdev->pri_cap + PCI_PRI_CTRL, &control);
> > >   	control &= ~PCI_PRI_CTRL_ENABLE;
> > > -	pci_write_config_word(pdev, pos + PCI_PRI_CTRL, control);
> > > +	pci_write_config_word(pdev, pdev->pri_cap + PCI_PRI_CTRL, control);
> > >   	pdev->pri_enabled = 0;
> > >   }
> > > @@ -241,17 +277,15 @@ void pci_restore_pri_state(struct pci_dev *pdev)
> > >   {
> > >   	u16 control = PCI_PRI_CTRL_ENABLE;
> > >   	u32 reqs = pdev->pri_reqs_alloc;
> > > -	int pos;
> > >   	if (!pdev->pri_enabled)
> > >   		return;
> > > -	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
> > > -	if (!pos)
> > > +	if (!pdev->pri_cap)
> > >   		return;
> > > -	pci_write_config_dword(pdev, pos + PCI_PRI_ALLOC_REQ, reqs);
> > > -	pci_write_config_word(pdev, pos + PCI_PRI_CTRL, control);
> > > +	pci_write_config_dword(pdev, pdev->pri_cap + PCI_PRI_ALLOC_REQ, reqs);
> > > +	pci_write_config_word(pdev, pdev->pri_cap + PCI_PRI_CTRL, control);
> > >   }
> > >   EXPORT_SYMBOL_GPL(pci_restore_pri_state);
> > > @@ -265,17 +299,15 @@ EXPORT_SYMBOL_GPL(pci_restore_pri_state);
> > >   int pci_reset_pri(struct pci_dev *pdev)
> > >   {
> > >   	u16 control;
> > > -	int pos;
> > >   	if (WARN_ON(pdev->pri_enabled))
> > >   		return -EBUSY;
> > > -	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
> > > -	if (!pos)
> > > +	if (!pdev->pri_cap)
> > >   		return -EINVAL;
> > >   	control = PCI_PRI_CTRL_RESET;
> > > -	pci_write_config_word(pdev, pos + PCI_PRI_CTRL, control);
> > > +	pci_write_config_word(pdev, pdev->pri_cap + PCI_PRI_CTRL, control);
> > >   	return 0;
> > >   }
> > > @@ -410,13 +442,11 @@ EXPORT_SYMBOL_GPL(pci_pasid_features);
> > >   int pci_prg_resp_pasid_required(struct pci_dev *pdev)
> > >   {
> > >   	u16 status;
> > > -	int pos;
> > > -	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
> > > -	if (!pos)
> > > +	if (!pdev->pri_cap)
> > >   		return 0;
> > > -	pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);
> > > +	pci_read_config_word(pdev, pdev->pri_cap + PCI_PRI_STATUS, &status);
> > >   	if (status & PCI_PRI_STATUS_PASID)
> > >   		return 1;
> > > diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
> > > index 1a0bdaee2f32..33653d4ca94f 100644
> > > --- a/include/linux/pci-ats.h
> > > +++ b/include/linux/pci-ats.h
> > > @@ -6,6 +6,7 @@
> > >   #ifdef CONFIG_PCI_PRI
> > > +void pci_pri_init(struct pci_dev *pdev);
> > I think this could be moved to drivers/pci/pci.h, since it doesn't
> > need to be visible outside drivers/pci/.
> Makes sense. I will move it.
> > 
> > >   int pci_enable_pri(struct pci_dev *pdev, u32 reqs);
> > >   void pci_disable_pri(struct pci_dev *pdev);
> > >   void pci_restore_pri_state(struct pci_dev *pdev);
> > > @@ -13,6 +14,10 @@ int pci_reset_pri(struct pci_dev *pdev);
> > >   #else /* CONFIG_PCI_PRI */
> > > +static inline void pci_pri_init(struct pci_dev *pdev)
> > > +{
> > > +}
> > > +
> > >   static inline int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
> > >   {
> > >   	return -ENODEV;
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > index 9e700d9f9f28..56b55db099fc 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -455,6 +455,7 @@ struct pci_dev {
> > >   	atomic_t	ats_ref_cnt;	/* Number of VFs with ATS enabled */
> > >   #endif
> > >   #ifdef CONFIG_PCI_PRI
> > > +	u16		pri_cap;	/* PRI Capability offset */
> > >   	u32		pri_reqs_alloc; /* Number of PRI requests allocated */
> > >   #endif
> > >   #ifdef CONFIG_PCI_PASID
> > > -- 
> > > 2.21.0
> > > 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux kernel developer
> 
