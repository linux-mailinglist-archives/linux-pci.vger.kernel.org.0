Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A346B4A9A9B
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 15:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358767AbiBDOEz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 09:04:55 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4678 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235381AbiBDOEz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Feb 2022 09:04:55 -0500
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jqy2R4j1kz67Xxg;
        Fri,  4 Feb 2022 22:04:15 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Fri, 4 Feb 2022 15:04:51 +0100
Received: from localhost (10.47.31.86) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 4 Feb
 2022 14:04:51 +0000
Date:   Fri, 4 Feb 2022 14:04:48 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V6 06/10] cxl/pci: Find the DOE mailbox which supports
 CDAT
Message-ID: <20220204140448.00003c23@Huawei.com>
In-Reply-To: <20220201221841.GO785175@iweiny-DESK2.sc.intel.com>
References: <20220201071952.900068-1-ira.weiny@intel.com>
        <20220201071952.900068-7-ira.weiny@intel.com>
        <20220201184947.5yx4l74nruyoapvr@intel.com>
        <20220201221841.GO785175@iweiny-DESK2.sc.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.31.86]
X-ClientProxiedBy: lhreml724-chm.china.huawei.com (10.201.108.75) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 1 Feb 2022 14:18:41 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> On Tue, Feb 01, 2022 at 10:49:47AM -0800, Widawsky, Ben wrote:
> > On 22-01-31 23:19:48, ira.weiny@intel.com wrote:  
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > Memory devices need the CDAT data from the device.  This data is read
> > > from a DOE mailbox which supports the CDAT protocol.
> > > 
> > > Search the DOE auxiliary devices for the one which supports the CDAT
> > > protocol.  Cache that device to be used for future queries.
> > > 
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>  
> 
> [snip]
> 
> > >  
> > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > index d4ae79b62a14..dcc55c4efd85 100644
> > > --- a/drivers/cxl/pci.c
> > > +++ b/drivers/cxl/pci.c
> > > @@ -536,12 +536,53 @@ static int cxl_dvsec_ranges(struct cxl_dev_state *cxlds)
> > >  	return rc;
> > >  }
> > >  
> > > +static int cxl_match_cdat_doe_device(struct device *dev, const void *data)
> > > +{
> > > +	const struct cxl_dev_state *cxlds = data;
> > > +	struct auxiliary_device *adev;
> > > +	struct pci_doe_dev *doe_dev;
> > > +
> > > +	/* First determine if this auxiliary device belongs to the cxlds */
> > > +	if (cxlds->dev != dev->parent)
> > > +		return 0;  
> > 
> > I don't understand auxiliary bus but I'm wondering why it's checking the parent
> > of the device?  
> 
> auxiliary_find_device() iterates all the auxiliary devices in the system.  This
> check was a way for the match function to know if the auxiliary device belongs
> to the cxlds we are interested in...
> 
> But now that I think about it we could have other auxiliary devices attached
> which are not DOE...  :-/  So this check is not complete.
> 
> FWIW I'm not thrilled with the way auxiliary_find_device() is defined.  And now
> that I look at it I think the only user of it currently is wrong.  They too
> have a check like this but it is after another check...  :-/
> 
> I was hoping to avoid having a list of DOE devices in the cxlds and simply let
> the auxiliary bus infrastructure do that somehow.  IIRC Jonathan was thinking
> along the same lines.  I think he actually suggested auxiliary_find_device()...

Ah.. I think I'd been thinking it was scoped to a single parent rather than
all devices in the system.  Definitely rather horrible.
Can we do something with device_for_each_child() instead with a match on
bus type to check its an auxilliary bus device then I guess a name based
check on whether that is a doe.  etc.


> 
> It would be nice if I could have an aux_find_child() or something which
> iterated the auxiliary devices attached to a particular parent device.  I've
> just not figured out exactly how to implement that better than what I did here.
> 
> >   
> > > +
> > > +	adev = to_auxiliary_dev(dev);
> > > +	doe_dev = container_of(adev, struct pci_doe_dev, adev);
> > > +
> > > +	/* If it is one of ours check for the CDAT protocol */
> > > +	if (pci_doe_supports_prot(doe_dev, PCI_DVSEC_VENDOR_ID_CXL,
> > > +				  CXL_DOE_PROTOCOL_TABLE_ACCESS))
> > > +		return 1;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static int cxl_setup_doe_devices(struct cxl_dev_state *cxlds)
> > >  {
> > >  	struct device *dev = cxlds->dev;
> > >  	struct pci_dev *pdev = to_pci_dev(dev);
> > > +	struct auxiliary_device *adev;
> > > +	int rc;
> > >  
> > > -	return pci_doe_create_doe_devices(pdev);
> > > +	rc = pci_doe_create_doe_devices(pdev);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	adev = auxiliary_find_device(NULL, cxlds, &cxl_match_cdat_doe_device);
> > > +
> > > +	if (adev) {
> > > +		struct pci_doe_dev *doe_dev = container_of(adev,
> > > +							   struct pci_doe_dev,
> > > +							   adev);
> > > +
> > > +		/*
> > > +		 * No reference need be taken.  The DOE device lifetime is
> > > +		 * longer that the CXL device state lifetime
> > > +		 */  
> > 
> > You're holding a reference to the adev here. Did you mean to drop it?  
> 
> Does find device get a reference? ...  Ah shoot I did not see that.
> 
> Yea the reference should be dropped somewhere.
> 
> Thanks,
> Ira
> 
> >   
> > > +		cxlds->cdat_doe = doe_dev;
> > > +	}
> > > +
> > > +	return 0;
> > >  }
> > >  
> > >  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > > -- 
> > > 2.31.1
> > >   

