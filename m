Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C824597C0
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 23:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbhKVWhv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 17:37:51 -0500
Received: from mga04.intel.com ([192.55.52.120]:9794 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232738AbhKVWhu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Nov 2021 17:37:50 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="233617166"
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="233617166"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 14:34:32 -0800
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="456825559"
Received: from wqiu6-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.143.45])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 14:34:31 -0800
Date:   Mon, 22 Nov 2021 14:34:30 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 16/23] cxl/pci: Cache device DVSEC offset
Message-ID: <20211122223430.gvkwj3yeckriffes@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
 <20211120000250.1663391-17-ben.widawsky@intel.com>
 <20211122164621.000059fc@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122164621.000059fc@Huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-11-22 16:46:21, Jonathan Cameron wrote:
> On Fri, 19 Nov 2021 16:02:43 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > The PCIe device DVSEC, defined in the CXL 2.0 spec, 8.1.3 is required to
> > be implemented by CXL 2.0 endpoint devices. Since the information
> > contained within this DVSEC will be critically important for region
> > configuration, it makes sense to find the value early.
> > 
> > Since this DVSEC is not strictly required for mailbox functionality,
> > failure to find this information does not result in the driver failing
> > to bind.
> 
> That feels like a path we are going to forget to test sometime in the
> future.  Given it's a specification requirement, I'd treat it as
> an error and make our lives easier going forwards!
> 
> Otherwise looks good to me.
> 

Agreed. This is silly. Basically nothing will work if the device dvsec can't be
found. I don't remember what I was thinking...

> > 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > ---
> >  drivers/cxl/cxlmem.h | 2 ++
> >  drivers/cxl/pci.c    | 7 +++++++
> >  2 files changed, 9 insertions(+)
> > 
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 8d96d009ad90..3ef3c652599e 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -98,6 +98,7 @@ struct cxl_mbox_cmd {
> >   *
> >   * @dev: The device associated with this CXL state
> >   * @regs: Parsed register blocks
> > + * @device_dvsec: Offset to the PCIe device DVSEC
> >   * @payload_size: Size of space for payload
> >   *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
> >   * @lsa_size: Size of Label Storage Area
> > @@ -125,6 +126,7 @@ struct cxl_dev_state {
> >  	struct device *dev;
> >  
> >  	struct cxl_regs regs;
> > +	int device_dvsec;
> >  
> >  	size_t payload_size;
> >  	size_t lsa_size;
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index d2c743a31b0c..f3872cbee7f8 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -474,6 +474,13 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	if (IS_ERR(cxlds))
> >  		return PTR_ERR(cxlds);
> >  
> > +	cxlds->device_dvsec = pci_find_dvsec_capability(pdev,
> > +							PCI_DVSEC_VENDOR_ID_CXL,
> > +							CXL_DVSEC_PCIE_DEVICE);
> > +	if (!cxlds->device_dvsec)
> > +		dev_warn(&pdev->dev,
> > +			 "Device DVSEC not present. Expect limited functionality.\n");
> > +
> >  	rc = cxl_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
> >  	if (rc)
> >  		return rc;
> 
