Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E121A52069B
	for <lists+linux-pci@lfdr.de>; Mon,  9 May 2022 23:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiEIV3V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 May 2022 17:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiEIV3U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2022 17:29:20 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97C72C2571;
        Mon,  9 May 2022 14:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652131524; x=1683667524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w9/+znMpjVvEE7LipRzImJB90PLvzBYflKc/N0o5Bbw=;
  b=Il0iF2KPsWmdjr1+UqM8VO3/YixxuDDIJXhqFSyYlGIMAjYOPVOSflTJ
   fXYYjRqQ+tm1tm82lImNztIrF8kPlT1vghGTrpVDtStRhp7Ur0IBnfEbi
   OkLN3A7V7UjUc0+JPpoTiW2x8BXIiOaFj1YAzt+JDvIXKO7CdX3k+uTMj
   fYYwZ2kYFyo/KspvbUWM0LDJvKDHZlIcVmSBs57rHMrqO2qmdxRIEndcg
   AHuH80OW11zeceWij5vFreXNlWweAN63oNIgjWoBY3vPD56foHvgY3Et1
   Bm8iTi6Jx2byeieByfQLeRSJrquwziQeybxjGjobMBwCBjmgWoZkSIPEb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="249708360"
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="249708360"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 14:25:24 -0700
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="551468941"
Received: from sganapa1-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.98.230])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 14:25:23 -0700
Date:   Mon, 9 May 2022 14:25:23 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V8 06/10] cxl/pci: Find the DOE mailbox which supports
 CDAT
Message-ID: <YnmGw8bPMQYhd5N+@iweiny-desk3>
References: <20220414203237.2198665-1-ira.weiny@intel.com>
 <20220414203237.2198665-7-ira.weiny@intel.com>
 <20220427184956.00004507@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427184956.00004507@Huawei.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 27, 2022 at 06:49:56PM +0100, Jonathan Cameron wrote:
> On Thu, 14 Apr 2022 13:32:33 -0700
> ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Each CXL device may have multiple DOE mailbox capabilities and each
> > mailbox may support multiple protocols.
> > 
> > Search the DOE auxiliary devices for one which supports the CDAT
> > protocol.  Cache that device to be used for future queries.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> One question inline.  With that addressed (or convincing argument why not)
> the rest looks good.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks!

> 
> > 
> > ---
> > Changes from V7
> > 	Minor code clean ups
> > 
> > Changes from V6
> > 	Adjust for aux devices being a CXL only concept
> > 	Update commit msg.
> > 	Ensure devices iterated by auxiliary_find_device() are checked
> > 		to be DOE devices prior to checking for the CDAT
> > 		protocol
> > 	From Ben
> > 		Ensure reference from auxiliary_find_device() is dropped
> > ---
> >  drivers/cxl/cxl.h    |  2 ++
> >  drivers/cxl/cxlmem.h |  2 ++
> >  drivers/cxl/pci.c    | 76 +++++++++++++++++++++++++++++++++++++++++++-
> >  3 files changed, 79 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 990b6670222e..50817fd2c912 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -90,6 +90,8 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
> >  #define CXLDEV_MBOX_BG_CMD_STATUS_OFFSET 0x18
> >  #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
> >  
> > +#define CXL_DOE_PROTOCOL_TABLE_ACCESS 2
> > +
> >  /*
> >   * Using struct_group() allows for per register-block-type helper routines,
> >   * without requiring block-type agnostic code to include the prefix.
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 7235d2f976e5..0dc6988afb30 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -168,6 +168,7 @@ struct cxl_endpoint_dvsec_info {
> >   * Currently only memory devices are represented.
> >   *
> >   * @dev: The device associated with this CXL state
> > + * @cdat_doe: Auxiliary DOE device capabile of reading CDAT
> >   * @regs: Parsed register blocks
> >   * @cxl_dvsec: Offset to the PCIe device DVSEC
> >   * @payload_size: Size of space for payload
> > @@ -200,6 +201,7 @@ struct cxl_endpoint_dvsec_info {
> >  struct cxl_dev_state {
> >  	struct device *dev;
> >  
> > +	struct cxl_doe_dev *cdat_doe;
> >  	struct cxl_regs regs;
> >  	int cxl_dvsec;
> >  
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 0dec1f1a3f38..622cac925262 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -706,6 +706,80 @@ static int cxl_pci_create_doe_devices(struct pci_dev *pdev)
> >  	return 0;
> >  }
> >  
> > +static bool cxl_doe_dev_supports_prot(struct cxl_doe_dev *doe_dev, u16 vid, u16 pid)
> > +{
> > +	struct cxl_doe_drv_state *doe_ds;
> > +	bool ret;
> > +
> > +	doe_ds = cxl_pci_doe_get_drv(doe_dev);
> > +	if (!doe_ds) {
> > +		cxl_pci_doe_put_drv(doe_dev);
> 
> That means the get_drv has a rather unexpected side effect.
> Could you move the NULL check into the function so that we don't retain
> a reference if it fails?

Indeed.  I struggled a bit with this because get_* is usually taking a
reference on the subject of the get but in this case we are really getting a
reference on the device not the driver...

I originally open coded this and the functions were 'get_device'...

:-/

I think this also may have been why the device was originally part of the
driver state.

I think this is the better way to code these access functions:

static struct cxl_doe_drv_state *cxl_pci_doe_get_drv(struct cxl_doe_dev *doe_dev)                                               
{
        struct cxl_doe_drv_state *cxl_ds;                                                                                       
 
        down_read(&doe_dev->driver_access);                                                                                     
        cxl_ds = auxiliary_get_drvdata(&doe_dev->adev);
        if (!cxl_ds)
                up_read(&doe_dev->driver_access);                                                                               
        return cxl_ds;
} 
  
static void cxl_pci_doe_put_drv(struct cxl_doe_drv_state *cxl_ds)                                                               
{ 
        if (!cxl_ds)
                return;
        up_read(&cxl_ds->doe_dev->driver_access);
} 

Ira

> 
> > +		return false;
> > +	}
> > +	ret = pci_doe_supports_prot(doe_ds->doe_mb, vid, pid);
> > +	cxl_pci_doe_put_drv(doe_dev);
> > +	return ret;
> > +}
> > +
> > +static int cxl_match_cdat_doe_device(struct device *dev, const void *data)
> > +{
> > +	const struct cxl_dev_state *cxlds = data;
> > +	struct auxiliary_device *adev = to_auxiliary_dev(dev);
> > +	struct cxl_doe_dev *doe_dev;
> > +
> > +	/* Ensure this is a DOE device */
> > +	if (strcmp(DOE_DEV_NAME, adev->name))
> > +		return 0;
> > +
> > +	/* Determine if this auxiliary device belongs to the cxlds */
> > +	if (cxlds->dev != dev->parent)
> > +		return 0;
> > +
> > +	doe_dev = container_of(adev, struct cxl_doe_dev, adev);
> > +
> > +	/* If it is one of ours check for the CDAT protocol */
> > +	if (!cxl_doe_dev_supports_prot(doe_dev, PCI_DVSEC_VENDOR_ID_CXL,
> > +				   CXL_DOE_PROTOCOL_TABLE_ACCESS))
> > +		return 0;
> > +
> > +	return 1;
> > +}
> > +
> > +static void drop_cdat_doe_ref(void *data)
> > +{
> > +	struct cxl_doe_dev *cdat_doe = data;
> > +
> > +	put_device(&cdat_doe->adev.dev);
> > +}
> > +
> > +static int cxl_setup_doe_devices(struct cxl_dev_state *cxlds)
> > +{
> > +	struct device *dev = cxlds->dev;
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	struct auxiliary_device *adev;
> > +	int rc;
> > +
> > +	rc = cxl_pci_create_doe_devices(pdev);
> > +	if (rc)
> > +		return rc;
> > +
> > +	adev = auxiliary_find_device(NULL, cxlds, &cxl_match_cdat_doe_device);
> > +
> > +	if (adev) {
> > +		struct cxl_doe_dev *doe_dev = container_of(adev,
> > +							   struct cxl_doe_dev,
> > +							   adev);
> > +
> > +		/* auxiliary_find_device() takes the reference */
> > +		rc = devm_add_action_or_reset(dev, drop_cdat_doe_ref, doe_dev);
> > +		if (rc)
> > +			return rc;
> > +		cxlds->cdat_doe = doe_dev;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  {
> >  	struct cxl_register_map map;
> > @@ -772,7 +846,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	if (rc)
> >  		return rc;
> >  
> > -	rc = cxl_pci_create_doe_devices(pdev);
> > +	rc = cxl_setup_doe_devices(cxlds);
> >  	if (rc)
> >  		return rc;
> >  
> 
