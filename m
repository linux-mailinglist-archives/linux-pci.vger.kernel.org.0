Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF22E55E2F6
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243240AbiF1DdR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jun 2022 23:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243224AbiF1DdP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jun 2022 23:33:15 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D0F19295;
        Mon, 27 Jun 2022 20:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656387194; x=1687923194;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RIjvKUR796IyUxJTtFj5FcgK1bph80T/8NgXlcqVZDs=;
  b=cqkhiDiaroMY14r2sNoG0OaoRhawsBoXAgkSrSuw8zzv2rcnjwlHC+Dl
   2Shn0dG98cpPWdmbF4Ko7clBK2SSVpXVmROeFOcuuSUuEQ89GQSyjGHJU
   Cng8iq8gE3Yn41auc9+3CFo7/6XdHvH6PjxSN3LhIhCqYqpMKXdkQGVrI
   tIWdmsdZRmbU4OuboLcRk6LKH51SyW0fjQQkkCrz78qFMzMy2RThtxXrf
   efqf1fEbshD+S53/jC3EFo2Fv4ReXqFwWqleD+DCqNkNePGRKWYygDVok
   9+MO+QkgrJx2JNjKBBxeAanX7N8nDZozS/MlH7qaVMqyQUgThcBR7vVqH
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="279168348"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="279168348"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 20:33:13 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="767016640"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 20:33:13 -0700
Date:   Mon, 27 Jun 2022 20:32:29 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     "Weiny, Ira" <ira.weiny@intel.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V11 7/8] cxl/port: Retry reading CDAT on failure
Message-ID: <20220628033229.GA1575428@alison-desk>
References: <20220610202259.3544623-1-ira.weiny@intel.com>
 <20220610202259.3544623-8-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610202259.3544623-8-ira.weiny@intel.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 10, 2022 at 01:22:58PM -0700, Ira Weiny wrote:
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
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


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
>  drivers/cxl/core/pci.c | 40 +++++++++++++++++++++++++++++++---------
>  1 file changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index cb70287e2984..fd02bc7c0d97 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -617,19 +617,13 @@ static int cxl_cdat_read_table(struct device *dev,
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
>  
>  	/*
>  	 * Ensure a reference on the underlying uport device which has the
> @@ -640,17 +634,21 @@ void read_cdat_data(struct cxl_port *port)
>  	cdat_mb = find_cdat_mb(uport);
>  	if (!cdat_mb) {
>  		dev_dbg(dev, "No CDAT mailbox\n");
> +		ret = -EIO;
>  		goto out;
>  	}
>  
>  	if (cxl_cdat_get_length(dev, cdat_mb, &cdat_length)) {
>  		dev_dbg(dev, "No CDAT length\n");
> +		ret = -EIO;
>  		goto out;
>  	}
>  
>  	port->cdat.table = devm_kzalloc(dev, cdat_length, GFP_KERNEL);
> -	if (!port->cdat.table)
> +	if (!port->cdat.table) {
> +		ret = -ENOMEM;
>  		goto out;
> +	}
>  
>  	port->cdat.length = cdat_length;
>  	ret = cxl_cdat_read_table(dev, cdat_mb, &port->cdat);
> @@ -664,5 +662,29 @@ void read_cdat_data(struct cxl_port *port)
>  
>  out:
>  	put_device(uport);
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
> -- 
> 2.35.1
> 
