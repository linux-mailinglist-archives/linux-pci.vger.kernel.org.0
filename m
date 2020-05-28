Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461FB1E6773
	for <lists+linux-pci@lfdr.de>; Thu, 28 May 2020 18:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405029AbgE1QdQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 May 2020 12:33:16 -0400
Received: from mga17.intel.com ([192.55.52.151]:28295 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404897AbgE1QdP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 May 2020 12:33:15 -0400
IronPort-SDR: S1iTSRFFHhDlpaoa/fMjeg9/MogrLf9V8h52IQvop+1K7KlZOmrsR2xBFk4vErB91dtBmWXAUa
 cEeQ+ECUeUOA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 09:33:15 -0700
IronPort-SDR: g+sBksrbZ/XPPBDhZNXgLL2wNxU+emyH9f97Pnz6m4VoyQfhHez3cx0vTlXK0xPEnkI0Os675G
 e4jdi87hHCwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,445,1583222400"; 
   d="scan'208";a="310974192"
Received: from ssp-nc-cdi361.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
  by FMSMGA003.fm.intel.com with ESMTP; 28 May 2020 09:33:15 -0700
Date:   Thu, 28 May 2020 09:33:15 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Darrel Goeddel <DGoeddel@forcepoint.com>,
        Mark Scott <mscott@forcepoint.com>,
        Romil Sharma <rsharma@forcepoint.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH] iommu: Relax ACS requirement for Intel RCiEP devices.
Message-ID: <20200528163315.GA6461@otc-nc-03>
References: <1590531455-19757-1-git-send-email-ashok.raj@intel.com>
 <20200526170715.18c0ee98@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526170715.18c0ee98@x1.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alex

On Tue, May 26, 2020 at 05:07:15PM -0600, Alex Williamson wrote:
> > ---
> >  drivers/iommu/iommu.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 2b471419e26c..31b595dfedde 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -1187,7 +1187,18 @@ static struct iommu_group *get_pci_function_alias_group(struct pci_dev *pdev,
> >  	struct pci_dev *tmp = NULL;
> >  	struct iommu_group *group;
> >  
> > -	if (!pdev->multifunction || pci_acs_enabled(pdev, REQ_ACS_FLAGS))
> > +	/*
> > +	 * Intel VT-d Specification Section 3.16, Root-Complex Peer to Peer
> > +	 * Considerations manadate that all transactions in RCiEP's and
> > +	 * even Integrated MFD's *must* be sent up to the IOMMU. P2P is
> > +	 * only possible on translated addresses. This gives enough
> > +	 * guarantee that such devices can be forgiven for lack of ACS
> > +	 * support.
> > +	 */
> > +	if (!pdev->multifunction ||
> > +	    (pdev->vendor == PCI_VENDOR_ID_INTEL &&
> > +	     pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END) ||
> > +	     pci_acs_enabled(pdev, REQ_ACS_FLAGS))
> >  		return NULL;
> >  
> >  	for_each_pci_dev(tmp) {
> 
> Hi Ashok,
> 
> As this is an Intel/VT-d standard, not a PCIe standard, why not
> implement this in pci_dev_specific_acs_enabled() with all the other
> quirks?  Thanks,

Yes, that sounds like the right place.. I have a new patch, once its tested
i'll resend it. Thanks for pointing it out.

Cheers,
Ashok
