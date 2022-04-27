Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68FF511E3E
	for <lists+linux-pci@lfdr.de>; Wed, 27 Apr 2022 20:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244446AbiD0RxQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Apr 2022 13:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244427AbiD0RxQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Apr 2022 13:53:16 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D1D46141;
        Wed, 27 Apr 2022 10:50:00 -0700 (PDT)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KpR5r0hSMz67NpT;
        Thu, 28 Apr 2022 01:47:12 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 27 Apr 2022 19:49:58 +0200
Received: from localhost (10.81.200.74) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 18:49:58 +0100
Date:   Wed, 27 Apr 2022 18:49:56 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V8 06/10] cxl/pci: Find the DOE mailbox which supports
 CDAT
Message-ID: <20220427184956.00004507@Huawei.com>
In-Reply-To: <20220414203237.2198665-7-ira.weiny@intel.com>
References: <20220414203237.2198665-1-ira.weiny@intel.com>
        <20220414203237.2198665-7-ira.weiny@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.200.74]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 14 Apr 2022 13:32:33 -0700
ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> Each CXL device may have multiple DOE mailbox capabilities and each
> mailbox may support multiple protocols.
> 
> Search the DOE auxiliary devices for one which supports the CDAT
> protocol.  Cache that device to be used for future queries.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

One question inline.  With that addressed (or convincing argument why not)
the rest looks good.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> Changes from V7
> 	Minor code clean ups
> 
> Changes from V6
> 	Adjust for aux devices being a CXL only concept
> 	Update commit msg.
> 	Ensure devices iterated by auxiliary_find_device() are checked
> 		to be DOE devices prior to checking for the CDAT
> 		protocol
> 	From Ben
> 		Ensure reference from auxiliary_find_device() is dropped
> ---
>  drivers/cxl/cxl.h    |  2 ++
>  drivers/cxl/cxlmem.h |  2 ++
>  drivers/cxl/pci.c    | 76 +++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 79 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 990b6670222e..50817fd2c912 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -90,6 +90,8 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
>  #define CXLDEV_MBOX_BG_CMD_STATUS_OFFSET 0x18
>  #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
>  
> +#define CXL_DOE_PROTOCOL_TABLE_ACCESS 2
> +
>  /*
>   * Using struct_group() allows for per register-block-type helper routines,
>   * without requiring block-type agnostic code to include the prefix.
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 7235d2f976e5..0dc6988afb30 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -168,6 +168,7 @@ struct cxl_endpoint_dvsec_info {
>   * Currently only memory devices are represented.
>   *
>   * @dev: The device associated with this CXL state
> + * @cdat_doe: Auxiliary DOE device capabile of reading CDAT
>   * @regs: Parsed register blocks
>   * @cxl_dvsec: Offset to the PCIe device DVSEC
>   * @payload_size: Size of space for payload
> @@ -200,6 +201,7 @@ struct cxl_endpoint_dvsec_info {
>  struct cxl_dev_state {
>  	struct device *dev;
>  
> +	struct cxl_doe_dev *cdat_doe;
>  	struct cxl_regs regs;
>  	int cxl_dvsec;
>  
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 0dec1f1a3f38..622cac925262 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -706,6 +706,80 @@ static int cxl_pci_create_doe_devices(struct pci_dev *pdev)
>  	return 0;
>  }
>  
> +static bool cxl_doe_dev_supports_prot(struct cxl_doe_dev *doe_dev, u16 vid, u16 pid)
> +{
> +	struct cxl_doe_drv_state *doe_ds;
> +	bool ret;
> +
> +	doe_ds = cxl_pci_doe_get_drv(doe_dev);
> +	if (!doe_ds) {
> +		cxl_pci_doe_put_drv(doe_dev);

That means the get_drv has a rather unexpected side effect.
Could you move the NULL check into the function so that we don't retain
a reference if it fails?

> +		return false;
> +	}
> +	ret = pci_doe_supports_prot(doe_ds->doe_mb, vid, pid);
> +	cxl_pci_doe_put_drv(doe_dev);
> +	return ret;
> +}
> +
> +static int cxl_match_cdat_doe_device(struct device *dev, const void *data)
> +{
> +	const struct cxl_dev_state *cxlds = data;
> +	struct auxiliary_device *adev = to_auxiliary_dev(dev);
> +	struct cxl_doe_dev *doe_dev;
> +
> +	/* Ensure this is a DOE device */
> +	if (strcmp(DOE_DEV_NAME, adev->name))
> +		return 0;
> +
> +	/* Determine if this auxiliary device belongs to the cxlds */
> +	if (cxlds->dev != dev->parent)
> +		return 0;
> +
> +	doe_dev = container_of(adev, struct cxl_doe_dev, adev);
> +
> +	/* If it is one of ours check for the CDAT protocol */
> +	if (!cxl_doe_dev_supports_prot(doe_dev, PCI_DVSEC_VENDOR_ID_CXL,
> +				   CXL_DOE_PROTOCOL_TABLE_ACCESS))
> +		return 0;
> +
> +	return 1;
> +}
> +
> +static void drop_cdat_doe_ref(void *data)
> +{
> +	struct cxl_doe_dev *cdat_doe = data;
> +
> +	put_device(&cdat_doe->adev.dev);
> +}
> +
> +static int cxl_setup_doe_devices(struct cxl_dev_state *cxlds)
> +{
> +	struct device *dev = cxlds->dev;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct auxiliary_device *adev;
> +	int rc;
> +
> +	rc = cxl_pci_create_doe_devices(pdev);
> +	if (rc)
> +		return rc;
> +
> +	adev = auxiliary_find_device(NULL, cxlds, &cxl_match_cdat_doe_device);
> +
> +	if (adev) {
> +		struct cxl_doe_dev *doe_dev = container_of(adev,
> +							   struct cxl_doe_dev,
> +							   adev);
> +
> +		/* auxiliary_find_device() takes the reference */
> +		rc = devm_add_action_or_reset(dev, drop_cdat_doe_ref, doe_dev);
> +		if (rc)
> +			return rc;
> +		cxlds->cdat_doe = doe_dev;
> +	}
> +
> +	return 0;
> +}
> +
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct cxl_register_map map;
> @@ -772,7 +846,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_pci_create_doe_devices(pdev);
> +	rc = cxl_setup_doe_devices(cxlds);
>  	if (rc)
>  		return rc;
>  

