Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D207F1C4E19
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 08:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgEEGLO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 02:11:14 -0400
Received: from mga03.intel.com ([134.134.136.65]:24371 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgEEGLO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 May 2020 02:11:14 -0400
IronPort-SDR: 3GtEF5PyFJDPVq90cjqb9ep7/MHMuUWLkSzuqlYKj2Vcxkb/wn0exQH6QZK0Z200SQtUJJ0VW7
 RMn1E3HLqa4Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 23:11:08 -0700
IronPort-SDR: V7xGuKgTmHsrqJ1LWIleEXUUPdshBrPcR0pCTD8WwfbnMI/fV4SMleOaml1JQGO/MXh5MfGbj9
 ZEjnYNeGfOTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,354,1583222400"; 
   d="scan'208";a="304386453"
Received: from araj-mobl1.jf.intel.com ([10.254.74.162])
  by FMSMGA003.fm.intel.com with ESMTP; 04 May 2020 23:11:07 -0700
Date:   Mon, 4 May 2020 23:11:07 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Darrel Goeddel <DGoeddel@forcepoint.com>,
        Mark Scott <mscott@forcepoint.com>,
        Romil Sharma <rsharma@forcepoint.com>,
        Joerg Roedel <joro@8bytes.org>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH] iommu: Relax ACS requirement for RCiEP devices.
Message-ID: <20200505061107.GA22974@araj-mobl1.jf.intel.com>
References: <1588653736-10835-1-git-send-email-ashok.raj@intel.com>
 <20200504231936.2bc07fe3@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504231936.2bc07fe3@x1.home>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alex

+ Joerg, accidently missed in the Cc.

On Mon, May 04, 2020 at 11:19:36PM -0600, Alex Williamson wrote:
> On Mon,  4 May 2020 21:42:16 -0700
> Ashok Raj <ashok.raj@intel.com> wrote:
> 
> > PCIe Spec recommends we can relax ACS requirement for RCIEP devices.
> > 
> > PCIe 5.0 Specification.
> > 6.12 Access Control Services (ACS)
> > Implementation of ACS in RCiEPs is permitted but not required. It is
> > explicitly permitted that, within a single Root Complex, some RCiEPs
> > implement ACS and some do not. It is strongly recommended that Root Complex
> > implementations ensure that all accesses originating from RCiEPs
> > (PFs and VFs) without ACS capability are first subjected to processing by
> > the Translation Agent (TA) in the Root Complex before further decoding and
> > processing. The details of such Root Complex handling are outside the scope
> > of this specification.
> > 
> > Since Linux didn't give special treatment to allow this exception, certain
> > RCiEP MFD devices are getting grouped in a single iommu group. This
> > doesn't permit a single device to be assigned to a guest for instance.
> > 
> > In one vendor system: Device 14.x were grouped in a single IOMMU group.
> > 
> > /sys/kernel/iommu_groups/5/devices/0000:00:14.0
> > /sys/kernel/iommu_groups/5/devices/0000:00:14.2
> > /sys/kernel/iommu_groups/5/devices/0000:00:14.3
> > 
> > After the patch:
> > /sys/kernel/iommu_groups/5/devices/0000:00:14.0
> > /sys/kernel/iommu_groups/5/devices/0000:00:14.2
> > /sys/kernel/iommu_groups/6/devices/0000:00:14.3 <<< new group
> > 
> > 14.0 and 14.2 are integrated devices, but legacy end points.
> > Whereas 14.3 was a PCIe compliant RCiEP.
> > 
> > 00:14.3 Network controller: Intel Corporation Device 9df0 (rev 30)
> > Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
> > 
> > This permits assigning this device to a guest VM.
> > 
> > Fixes: f096c061f552 ("iommu: Rework iommu_group_get_for_pci_dev()")
> > Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> > To: Joerg Roedel <joro@8bytes.org>
> > To: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: iommu@lists.linux-foundation.org
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Darrel Goeddel <DGoeddel@forcepoint.com>
> > Cc: Mark Scott <mscott@forcepoint.com>,
> > Cc: Romil Sharma <rsharma@forcepoint.com>
> > Cc: Ashok Raj <ashok.raj@intel.com>
> > ---
> >  drivers/iommu/iommu.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 2b471419e26c..5744bd65f3e2 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -1187,7 +1187,20 @@ static struct iommu_group *get_pci_function_alias_group(struct pci_dev *pdev,
> >  	struct pci_dev *tmp = NULL;
> >  	struct iommu_group *group;
> >  
> > -	if (!pdev->multifunction || pci_acs_enabled(pdev, REQ_ACS_FLAGS))
> > +	/*
> > +	 * PCI Spec 5.0, Section 6.12 Access Control Service
> > +	 * Implementation of ACS in RCiEPs is permitted but not required.
> > +	 * It is explicitly permitted that, within a single Root
> > +	 * Complex, some RCiEPs implement ACS and some do not. It is
> > +	 * strongly recommended that Root Complex implementations ensure
> > +	 * that all accesses originating from RCiEPs (PFs and VFs) without
> > +	 * ACS capability are first subjected to processing by the Translation
> > +	 * Agent (TA) in the Root Complex before further decoding and
> > +	 * processing.
> > +	 */
> 
> Is the language here really strong enough to make this change?  ACS is
> an optional feature, so being permitted but not required is rather
> meaningless.  The spec is also specifically avoiding the words "must"
> or "shall" and even when emphasized with "strongly", we still only have
> a recommendation that may or may not be honored.  This seems like a
> weak basis for assuming that RCiEPs universally honor this
> recommendation.  Thanks,
> 

We are speaking about PCIe spec, where people write it about 5 years ahead
and every vendor tries to massage their product behavior with vague
words like this..  :)

But honestly for any any RCiEP, or even integrated endpoints, there 
is no way to send them except up north. These aren't behind a RP.

I did check with couple folks who are part of the SIG, and seem to agree
that ACS treatment for RCiEP's doesn't mean much. 

I understand the language isn't strong, but it doesn't seem like ACS should
be a strong requirement for RCiEP's and reasonable to relax.

What are your thoughts? 

Cheers,
Ashok
> 
> > +	if (!pdev->multifunction ||
> > +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END) ||
> > +	     pci_acs_enabled(pdev, REQ_ACS_FLAGS))
> >  		return NULL;
> >  
> >  	for_each_pci_dev(tmp) {
> 
