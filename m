Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D4953EE22
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jun 2022 20:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiFFSwL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jun 2022 14:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiFFSwK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jun 2022 14:52:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD1CAEE1F;
        Mon,  6 Jun 2022 11:52:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 951B5B81B3B;
        Mon,  6 Jun 2022 18:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015CBC385A9;
        Mon,  6 Jun 2022 18:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654541525;
        bh=zsuD2O4SLhEifPXTh2zByXf6KWOnKQ6q8wyOezSdqfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fit8FIY9xBwfcUcTCraTniCrCqvn6hKz6Omj9VnOHwxlDXTNDJDe+E1vP9L1x/pSe
         PlM9dydvBAkBuVA/wUFziZE9WN3LgspunuI6emSbxaviWd1A+l/bFEg6fKVfDQu+qD
         iBSvEqcUzas0yVAOKgHIbbxjVUar6KH4zbRTD0F5JZ/CCt549QIqmGoA08V7d6BY4c
         lO/7+iS4kWsv9OXxfmAQOk4dlVTv3uUK6rT0TaC6+9/xSXQL5iAkvyuDz2jIUH7S1A
         3vN8Yebg/aA8MWkvAcq9QUsjNNLJBfgEIAMj2vhijPPF3uliGrhwjctKYukYHyU45q
         Sy79eu1fLKHWw==
Date:   Mon, 6 Jun 2022 11:52:03 -0700
From:   Ben Widawsky <bwidawsk@kernel.org>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V10 8/9] cxl/port: Retry reading CDAT on failure
Message-ID: <20220606185203.ntm3yf73kf4u2o7a@bwidawsk-mobl5>
References: <20220605005049.2155874-1-ira.weiny@intel.com>
 <20220605005049.2155874-9-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220605005049.2155874-9-ira.weiny@intel.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-06-04 17:50:48, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> The CDAT read may fail for a number of reasons but mainly it is possible
> to get different parts of a valid state.  The checksum in the CDAT table
> protects against this.
> 
> Now that the cdat data is validated issue a retries if the CDAT read
s/validated issue a retries/validated, issue a retry/
> fails.  For now 5 retries are implemented.
> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
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
>  drivers/cxl/core/pci.c | 34 +++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 73e28b82ffcf..e68f13e66fcf 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -631,20 +631,18 @@ static int cxl_cdat_read_table(struct cxl_port *port,
>  	return rc;
>  }
>  
> -void read_cdat_data(struct cxl_port *port)
> +static int __read_cdat_data(struct cxl_port *port)
>  {
>  	struct device *dev = &port->dev;
>  	size_t cdat_length;
>  	int ret;
>  
>  	if (cxl_cdat_get_length(port, &cdat_length))
> -		return;
> +		return 0;
>  
>  	port->cdat.table = devm_kzalloc(dev, cdat_length, GFP_KERNEL);
> -	if (!port->cdat.table) {
> -		ret = -ENOMEM;
> -		goto error;
> -	}
> +	if (!port->cdat.table)
> +		return -ENOMEM;
>  
>  	port->cdat.length = cdat_length;
>  	ret = cxl_cdat_read_table(port, &port->cdat);
> @@ -652,12 +650,26 @@ void read_cdat_data(struct cxl_port *port)
>  		devm_kfree(dev, port->cdat.table);
>  		port->cdat.table = NULL;
>  		port->cdat.length = 0;
> -		ret = -EIO;
> -		goto error;
> +		return -EIO;
>  	}
>  
> -	return;
> -error:
> -	dev_err(dev, "CDAT data read error (%d)\n", ret);
> +	return 0;
> +}
> +
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

Out of curiousity, what is the purpose of the dev_dbg? To diagnose delays or
something?

> +	}
> +	dev_err(&port->dev, "CDAT data read failed after %d retries\n",
> +		retries);


Reviewed-by: Ben Widawsky <bwidawsk@kernel.org>

>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
> -- 
> 2.35.1
> 
