Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C179C55E937
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 18:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiF1O50 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 10:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345186AbiF1O50 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 10:57:26 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A202A33885;
        Tue, 28 Jun 2022 07:57:24 -0700 (PDT)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LXSLd2Bkrz689F7;
        Tue, 28 Jun 2022 22:55:05 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 16:57:22 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 28 Jun
 2022 15:57:21 +0100
Date:   Tue, 28 Jun 2022 15:57:20 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V12 8/9] cxl/port: Retry reading CDAT on failure
Message-ID: <20220628155720.000034cb@Huawei.com>
In-Reply-To: <20220628041527.742333-9-ira.weiny@intel.com>
References: <20220628041527.742333-1-ira.weiny@intel.com>
        <20220628041527.742333-9-ira.weiny@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 27 Jun 2022 21:15:26 -0700
ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> The CDAT read may fail for a number of reasons but mainly it is possible
> to get different parts of a valid state.  The checksum in the CDAT table
> protects against this.
> 
> Now that the cdat data is validated, issue a retry if the CDAT read
> fails.  For now 5 retries are implemented.
> 
> Reviewed-by: Ben Widawsky <bwidawsk@kernel.org>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>


> 
> ---
> Changes from V10
> 	Pick up review tag and fix commit message
> 
> Changes from V9
> 	Alison Schofield/Davidlohr Bueso
> 		Print debug on each iteration and error only after failure
> 
> Changes from V8
> 	Move code to cxl/core/pci.c
> 
> Changes from V6
> 	Move to pci.c
> 	Fix retries count
> 	Change to 5 retries
> 
> Changes from V5:
> 	New patch -- easy to push off or drop.
> ---
>  drivers/cxl/core/pci.c | 41 ++++++++++++++++++++++++++++++-----------
>  1 file changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 6d775cc3dca1..d7c2a415cc5f 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -618,36 +618,30 @@ static int cxl_cdat_read_table(struct device *dev,
>  	return rc;
>  }
>  
> -/**
> - * read_cdat_data - Read the CDAT data on this port
> - * @port: Port to read data from
> - *
> - * This call will sleep waiting for responses from the DOE mailbox.
> - */
> -void read_cdat_data(struct cxl_port *port)
> +static int __read_cdat_data(struct cxl_port *port)
>  {
>  	static struct pci_doe_mb *cdat_mb;
>  	struct device *dev = &port->dev;
>  	struct device *uport = port->uport;
>  	size_t cdat_length;
> -	int ret;
> +	int ret = 0;
Fairly sure there isn't a path in which ret isn't set...


Mixing ret and rc is a bit inconsistent, maybe scrub patch set for
one or the other. (My fault originally I think :)


>  
>  	cdat_mb = find_cdat_mb(uport);
>  	if (!cdat_mb) {
>  		dev_dbg(dev, "No CDAT mailbox\n");
> -		return;
> +		return -EIO;
>  	}
>  
>  	port->cdat_sup = true;
>  
>  	if (cxl_cdat_get_length(dev, cdat_mb, &cdat_length)) {
>  		dev_dbg(dev, "No CDAT length\n");
> -		return;
> +		return -EIO;
>  	}
>  
>  	port->cdat.table = devm_kzalloc(dev, cdat_length, GFP_KERNEL);
>  	if (!port->cdat.table)
> -		return;
> +		return -ENOMEM;
>  
>  	port->cdat.length = cdat_length;
>  	ret = cxl_cdat_read_table(dev, cdat_mb, &port->cdat);
> @@ -658,5 +652,30 @@ void read_cdat_data(struct cxl_port *port)
>  		port->cdat.length = 0;
>  		dev_err(dev, "CDAT data read error\n");
>  	}
> +
> +	return ret;
> +}
> +
> +/**
> + * read_cdat_data - Read the CDAT data on this port
> + * @port: Port to read data from
> + *
> + * This call will sleep waiting for responses from the DOE mailbox.
> + */
> +void read_cdat_data(struct cxl_port *port)
> +{
> +	int retries = 5;
> +	int rc;
> +
> +	while (retries--) {
> +		rc = __read_cdat_data(port);
> +		if (!rc)
> +			return;
> +		dev_dbg(&port->dev,
> +			"CDAT data read error rc=%d (retries %d)\n",
> +			rc, retries);
> +	}
> +	dev_err(&port->dev, "CDAT data read failed after %d retries\n",
> +		retries);
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);

