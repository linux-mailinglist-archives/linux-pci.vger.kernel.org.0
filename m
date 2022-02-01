Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8134A6434
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 19:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241931AbiBAStt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 13:49:49 -0500
Received: from mga18.intel.com ([134.134.136.126]:59728 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229915AbiBAStt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Feb 2022 13:49:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643741389; x=1675277389;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bg9FWKZPg6qD5wWLGmPj2TvHp//wEHqsVc4+P4TfgkI=;
  b=ZsUE2H98aeaYYpvcOpQUg0ZP7gTt204UaeLI9Uy35Oj9kwHkOtIvew0y
   5/31H8Uv035Q3724yOobFaiMfxU6LYFSAvQw3dSWsz085QefLSGjtjkT/
   Tta+ARRMVhxO6MUg2tnEXdNDqYNV9dMIx0nmmPu2lLZz6l2SXrLSCBqka
   74qFIHWo5OhM7ROTNsOZzK+OlQcRfROhaEu2gK/e7ewojmveAeTzJjhk+
   stjWgBmU+QPek93bGCpCudZVsXt4dpRQQv7hELulcw3+MlAbVG8mS3+8R
   sySYpnRmpIdxZ2UxDgibS5BiVMklcawl8kUngkwnCM9u7uj8H8D4biRQQ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="231332389"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="231332389"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 10:49:49 -0800
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="482491047"
Received: from rashmigh-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.132.8])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 10:49:48 -0800
Date:   Tue, 1 Feb 2022 10:49:47 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V6 06/10] cxl/pci: Find the DOE mailbox which supports
 CDAT
Message-ID: <20220201184947.5yx4l74nruyoapvr@intel.com>
References: <20220201071952.900068-1-ira.weiny@intel.com>
 <20220201071952.900068-7-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201071952.900068-7-ira.weiny@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-01-31 23:19:48, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Memory devices need the CDAT data from the device.  This data is read
> from a DOE mailbox which supports the CDAT protocol.
> 
> Search the DOE auxiliary devices for the one which supports the CDAT
> protocol.  Cache that device to be used for future queries.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/cxl/cxl.h    |  3 +++
>  drivers/cxl/cxlmem.h |  2 ++
>  drivers/cxl/pci.c    | 43 ++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 962629c5775f..7169101db553 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -90,6 +90,9 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
>  #define CXLDEV_MBOX_BG_CMD_STATUS_OFFSET 0x18
>  #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
>  
> +#define CXL_DOE_PROTOCOL_COMPLIANCE 0
> +#define CXL_DOE_PROTOCOL_TABLE_ACCESS 2
> +
>  /*
>   * Using struct_group() allows for per register-block-type helper routines,
>   * without requiring block-type agnostic code to include the prefix.
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 5d33ce24fe09..0fefe43951e3 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -117,6 +117,7 @@ struct cxl_endpoint_dvsec_info {
>   * Currently only memory devices are represented.
>   *
>   * @dev: The device associated with this CXL state
> + * @cdat_doe: Auxiliary DOE device capabile of reading CDAT
>   * @regs: Parsed register blocks
>   * @cxl_dvsec: Offset to the PCIe device DVSEC
>   * @payload_size: Size of space for payload
> @@ -149,6 +150,7 @@ struct cxl_endpoint_dvsec_info {
>  struct cxl_dev_state {
>  	struct device *dev;
>  
> +	struct pci_doe_dev *cdat_doe;
>  	struct cxl_regs regs;
>  	int cxl_dvsec;
>  
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index d4ae79b62a14..dcc55c4efd85 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -536,12 +536,53 @@ static int cxl_dvsec_ranges(struct cxl_dev_state *cxlds)
>  	return rc;
>  }
>  
> +static int cxl_match_cdat_doe_device(struct device *dev, const void *data)
> +{
> +	const struct cxl_dev_state *cxlds = data;
> +	struct auxiliary_device *adev;
> +	struct pci_doe_dev *doe_dev;
> +
> +	/* First determine if this auxiliary device belongs to the cxlds */
> +	if (cxlds->dev != dev->parent)
> +		return 0;

I don't understand auxiliary bus but I'm wondering why it's checking the parent
of the device?

> +
> +	adev = to_auxiliary_dev(dev);
> +	doe_dev = container_of(adev, struct pci_doe_dev, adev);
> +
> +	/* If it is one of ours check for the CDAT protocol */
> +	if (pci_doe_supports_prot(doe_dev, PCI_DVSEC_VENDOR_ID_CXL,
> +				  CXL_DOE_PROTOCOL_TABLE_ACCESS))
> +		return 1;
> +
> +	return 0;
> +}
> +
>  static int cxl_setup_doe_devices(struct cxl_dev_state *cxlds)
>  {
>  	struct device *dev = cxlds->dev;
>  	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct auxiliary_device *adev;
> +	int rc;
>  
> -	return pci_doe_create_doe_devices(pdev);
> +	rc = pci_doe_create_doe_devices(pdev);
> +	if (rc)
> +		return rc;
> +
> +	adev = auxiliary_find_device(NULL, cxlds, &cxl_match_cdat_doe_device);
> +
> +	if (adev) {
> +		struct pci_doe_dev *doe_dev = container_of(adev,
> +							   struct pci_doe_dev,
> +							   adev);
> +
> +		/*
> +		 * No reference need be taken.  The DOE device lifetime is
> +		 * longer that the CXL device state lifetime
> +		 */

You're holding a reference to the adev here. Did you mean to drop it?

> +		cxlds->cdat_doe = doe_dev;
> +	}
> +
> +	return 0;
>  }
>  
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> -- 
> 2.31.1
> 
