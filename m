Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BBC511D51
	for <lists+linux-pci@lfdr.de>; Wed, 27 Apr 2022 20:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244481AbiD0SA5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Apr 2022 14:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244483AbiD0SA5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Apr 2022 14:00:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2483632A9F3;
        Wed, 27 Apr 2022 10:57:45 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KpRGm2GrZz67D4J;
        Thu, 28 Apr 2022 01:54:56 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 19:57:43 +0200
Received: from localhost (10.81.200.74) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 18:57:42 +0100
Date:   Wed, 27 Apr 2022 18:57:40 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V8 09/10] cxl/mem: Retry reading CDAT on failure
Message-ID: <20220427185740.00001ea5@Huawei.com>
In-Reply-To: <20220414203237.2198665-10-ira.weiny@intel.com>
References: <20220414203237.2198665-1-ira.weiny@intel.com>
        <20220414203237.2198665-10-ira.weiny@intel.com>
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

On Thu, 14 Apr 2022 13:32:36 -0700
ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> The CDAT read may fail for a number of reasons but mainly it is possible
> to get different parts of a valid state.  The checksum in the CDAT table
> protects against this.
> 
> Now that the cdat data is validated issue a retries if the CDAT read

validated, retry if the CDAT read fails.

> fails.  For now 5 retries are implemented.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> Changes from V6
> 	Move to pci.c
> 	Fix retries count
> 	Change to 5 retries
> 
> Changes from V5:
> 	New patch -- easy to push off or drop.
> ---
>  drivers/cxl/pci.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index d7952156dd02..43cbc297079d 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -940,7 +940,7 @@ static void cxl_initialize_cdat_callbacks(struct cxl_dev_state *cxlds)
>  	cxlds->cdat_read_table = cxl_cdat_read_table;
>  }
>  
> -static int read_cdat_data(struct cxl_dev_state *cxlds)
> +static int __read_cdat_data(struct cxl_dev_state *cxlds)
>  {
>  	struct device *dev = cxlds->dev;
>  	size_t cdat_length;
> @@ -962,6 +962,21 @@ static int read_cdat_data(struct cxl_dev_state *cxlds)
>  	return ret;
>  }
>  
> +static void read_cdat_data(struct cxl_dev_state *cxlds)
> +{
> +	int retries = 5;
> +	int rc;
> +
> +	while (retries--) {
> +		rc = __read_cdat_data(cxlds);
> +		if (!rc)
> +			break;
> +		dev_err(cxlds->dev,
> +			"CDAT data read error rc=%d (retries %d)\n",
> +			rc, retries);
> +	}
> +}
> +
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct cxl_register_map map;
> @@ -1035,9 +1050,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	cxl_initialize_cdat_callbacks(cxlds);
>  
>  	/* Cache the data early to ensure is_visible() works */
> -	rc = read_cdat_data(cxlds);
> -	if (rc)
> -		dev_err(&pdev->dev, "CDAT data read error (%d)\n", rc);
> +	read_cdat_data(cxlds);
>  
>  	cxl_dvsec_ranges(cxlds);
>  

