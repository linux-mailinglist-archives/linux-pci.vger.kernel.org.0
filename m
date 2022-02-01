Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B764A67A3
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 23:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238039AbiBAWSn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 17:18:43 -0500
Received: from mga14.intel.com ([192.55.52.115]:9058 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229971AbiBAWSm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Feb 2022 17:18:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643753922; x=1675289922;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N1pYMtoifGkvk1GZdHfarNxiC8SwrZB1coh6JHcccJ8=;
  b=egsyWGMhSvIaqxjejdNiZJeyRzqTxDFviczJg0eBexq5VLhRV6A3A732
   /fNuTP50QycvT8mMQoBxX7Qze4sV2TUcQFIfpy6y0NmE0j0yMp8WKUAO8
   Og18DC4x/aLkSmzlSYjVkWvInt6ioZCYgVX3nfhg93YOEUrXjPX/u1Aeq
   PPJv2o4P41IqYAaxBec34nYyoSWpP3TPbQBoLzVenqSTtgSRu+gt1fcOC
   xduHVs78IKQbN/+itU/ibpui3EbFOxDMA0we3zHdZ9Fp/sERX5MHvfamO
   3xAXgwRM6qrYwMCgPJtWA0z/8YRjOoxQKA/COx9oMpup8284jgporrtW8
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="248028749"
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="248028749"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 14:18:42 -0800
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="482557745"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 14:18:41 -0800
Date:   Tue, 1 Feb 2022 14:18:41 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V6 06/10] cxl/pci: Find the DOE mailbox which supports
 CDAT
Message-ID: <20220201221841.GO785175@iweiny-DESK2.sc.intel.com>
Mail-Followup-To: Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20220201071952.900068-1-ira.weiny@intel.com>
 <20220201071952.900068-7-ira.weiny@intel.com>
 <20220201184947.5yx4l74nruyoapvr@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201184947.5yx4l74nruyoapvr@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 01, 2022 at 10:49:47AM -0800, Widawsky, Ben wrote:
> On 22-01-31 23:19:48, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Memory devices need the CDAT data from the device.  This data is read
> > from a DOE mailbox which supports the CDAT protocol.
> > 
> > Search the DOE auxiliary devices for the one which supports the CDAT
> > protocol.  Cache that device to be used for future queries.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>

[snip]

> >  
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index d4ae79b62a14..dcc55c4efd85 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -536,12 +536,53 @@ static int cxl_dvsec_ranges(struct cxl_dev_state *cxlds)
> >  	return rc;
> >  }
> >  
> > +static int cxl_match_cdat_doe_device(struct device *dev, const void *data)
> > +{
> > +	const struct cxl_dev_state *cxlds = data;
> > +	struct auxiliary_device *adev;
> > +	struct pci_doe_dev *doe_dev;
> > +
> > +	/* First determine if this auxiliary device belongs to the cxlds */
> > +	if (cxlds->dev != dev->parent)
> > +		return 0;
> 
> I don't understand auxiliary bus but I'm wondering why it's checking the parent
> of the device?

auxiliary_find_device() iterates all the auxiliary devices in the system.  This
check was a way for the match function to know if the auxiliary device belongs
to the cxlds we are interested in...

But now that I think about it we could have other auxiliary devices attached
which are not DOE...  :-/  So this check is not complete.

FWIW I'm not thrilled with the way auxiliary_find_device() is defined.  And now
that I look at it I think the only user of it currently is wrong.  They too
have a check like this but it is after another check...  :-/

I was hoping to avoid having a list of DOE devices in the cxlds and simply let
the auxiliary bus infrastructure do that somehow.  IIRC Jonathan was thinking
along the same lines.  I think he actually suggested auxiliary_find_device()...

It would be nice if I could have an aux_find_child() or something which
iterated the auxiliary devices attached to a particular parent device.  I've
just not figured out exactly how to implement that better than what I did here.

> 
> > +
> > +	adev = to_auxiliary_dev(dev);
> > +	doe_dev = container_of(adev, struct pci_doe_dev, adev);
> > +
> > +	/* If it is one of ours check for the CDAT protocol */
> > +	if (pci_doe_supports_prot(doe_dev, PCI_DVSEC_VENDOR_ID_CXL,
> > +				  CXL_DOE_PROTOCOL_TABLE_ACCESS))
> > +		return 1;
> > +
> > +	return 0;
> > +}
> > +
> >  static int cxl_setup_doe_devices(struct cxl_dev_state *cxlds)
> >  {
> >  	struct device *dev = cxlds->dev;
> >  	struct pci_dev *pdev = to_pci_dev(dev);
> > +	struct auxiliary_device *adev;
> > +	int rc;
> >  
> > -	return pci_doe_create_doe_devices(pdev);
> > +	rc = pci_doe_create_doe_devices(pdev);
> > +	if (rc)
> > +		return rc;
> > +
> > +	adev = auxiliary_find_device(NULL, cxlds, &cxl_match_cdat_doe_device);
> > +
> > +	if (adev) {
> > +		struct pci_doe_dev *doe_dev = container_of(adev,
> > +							   struct pci_doe_dev,
> > +							   adev);
> > +
> > +		/*
> > +		 * No reference need be taken.  The DOE device lifetime is
> > +		 * longer that the CXL device state lifetime
> > +		 */
> 
> You're holding a reference to the adev here. Did you mean to drop it?

Does find device get a reference? ...  Ah shoot I did not see that.

Yea the reference should be dropped somewhere.

Thanks,
Ira

> 
> > +		cxlds->cdat_doe = doe_dev;
> > +	}
> > +
> > +	return 0;
> >  }
> >  
> >  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > -- 
> > 2.31.1
> > 
