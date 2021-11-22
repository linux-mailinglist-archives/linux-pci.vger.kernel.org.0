Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA860459822
	for <lists+linux-pci@lfdr.de>; Tue, 23 Nov 2021 00:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhKVXFF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 18:05:05 -0500
Received: from mga02.intel.com ([134.134.136.20]:26829 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231709AbhKVXFE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Nov 2021 18:05:04 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="222123100"
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="222123100"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 15:01:47 -0800
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="674236746"
Received: from wqiu6-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.143.45])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 15:01:47 -0800
Date:   Mon, 22 Nov 2021 15:01:46 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 19/23] cxl/pci: Store component register base in cxlds
Message-ID: <20211122230146.lu5wuhelv6wwmrap@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
 <20211120000250.1663391-20-ben.widawsky@intel.com>
 <20211122171142.000002c4@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122171142.000002c4@Huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-11-22 17:11:42, Jonathan Cameron wrote:
> On Fri, 19 Nov 2021 16:02:46 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > The component register base address is enumerated and stored in the
> > cxl_device_state structure for use by the endpoint driver.
> > 
> > Component register base addresses are obtained through PCI mechanisms.
> > As such it makes most sense for the cxl_pci driver to obtain that
> > address. In order to reuse the port driver for enumerating decoder
> > resources for an endpoint, it is desirable to be able to add the
> > endpoint as a port. The endpoint does know of the cxlds and can pull the
> > component register base from there and pass it along to port creation.
> 
> This feels like a lot of explanation in for trivial caching of an address.
> I'm not sure you need to be that detailed, though I guess it does no real
> harm.

It is mostly to articulate that cxl_pci is responsible for PCI stuff, and
cxl_mem is responsible for CXL.mem stuff, and that's why we didn't just do this
work in cxl_mem (which indeed was what I originally did).

> 
> Another one where I'm unsure why we are muddling on after an error...

Same motivation as the other - mailbox can still be used even if the media isn't
available.

> 
> 
> > 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > ---
> > Changes since RFCv2:
> > This patch was originally named, "cxl/core: Store component register
> > base for memdevs". It plumbed the component registers through memdev
> > creation. After more work, it became apparent we needed to plumb other
> > stuff from the pci driver, so going forward, cxlds will just be
> > referenced by the cxl_mem driver. This also allows us to ignore the
> > change needed to cxl_test
> > 
> > - Rework patch to store the base in cxlds
> > - Remove defunct comment (Dan)
> > ---
> >  drivers/cxl/cxlmem.h |  2 ++
> >  drivers/cxl/pci.c    | 11 +++++++++++
> >  2 files changed, 13 insertions(+)
> > 
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index a9424dd4e5c3..b1d753541f4e 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -134,6 +134,7 @@ struct cxl_endpoint_dvsec_info {
> >   * @next_volatile_bytes: volatile capacity change pending device reset
> >   * @next_persistent_bytes: persistent capacity change pending device reset
> >   * @info: Cached DVSEC information about the device.
> > + * @component_reg_phys: register base of component registers
> >   * @mbox_send: @dev specific transport for transmitting mailbox commands
> >   *
> >   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> > @@ -165,6 +166,7 @@ struct cxl_dev_state {
> >  	u64 next_persistent_bytes;
> >  
> >  	struct cxl_endpoint_dvsec_info *info;
> > +	resource_size_t component_reg_phys;
> >  
> >  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
> >  	int (*wait_media_ready)(struct cxl_dev_state *cxlds);
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index f1a68bfe5f77..a8e375950514 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -663,6 +663,17 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	if (rc)
> >  		return rc;
> >  
> > +	/*
> > +	 * If the component registers can't be found, the cxl_pci driver may
> > +	 * still be useful for management functions so don't return an error.
> > +	 */
> > +	cxlds->component_reg_phys = CXL_RESOURCE_NONE;
> > +	rc = cxl_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> > +	if (rc)
> > +		dev_warn(&cxlmd->dev, "No component registers (%d)\n", rc);
> > +	else
> > +		cxlds->component_reg_phys = cxl_reg_block(pdev, &map);
> > +
> >  	rc = cxl_pci_setup_mailbox(cxlds);
> >  	if (rc)
> >  		return rc;
> 
