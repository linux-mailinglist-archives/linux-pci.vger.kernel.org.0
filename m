Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B684A645D
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 19:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239774AbiBAS7b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 13:59:31 -0500
Received: from mga18.intel.com ([134.134.136.126]:60494 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229565AbiBAS7b (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Feb 2022 13:59:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643741971; x=1675277971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gktx86xlN/ZBVuVz8/vY09Ew+iIHrktJgCYkPO84vf4=;
  b=CMMrxA7vydm47D1YpKfUe1zUT5+P/5IPKLaV3RTNrs4nZEwAkom8zsiw
   uYpVqp1dyQr9u8kWcLy6NNlzvt4vyOW2ESiiz/5hDN7JME2rIbEJ4z7lB
   28TLctWBbQ0pRys6hvOGlHfh5BmZZX36+A525mzO4uBdvmTkO7yTb8hm6
   peIDnjctdNF7NalSs7z87leJzC093A7xBQl2WVtwTyOEbeIe/OKqSHB+2
   xRItH7XE0aKzSM/dMS8tE754Lj8xPC513QKkAD0+TKe+r9MZcUUsEFQxZ
   YdsjH5mrAOwPoGv5bu8jBlxzuXd/xH01xOvdnzXmbTTGf+HSnLwEAttqh
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="231333675"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="231333675"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 10:59:31 -0800
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="599312058"
Received: from rashmigh-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.132.8])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 10:59:30 -0800
Date:   Tue, 1 Feb 2022 10:59:28 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V6 09/10] cxl/mem: Retry reading CDAT on failure
Message-ID: <20220201185928.ffdgvnn6mcmo7by7@intel.com>
References: <20220201071952.900068-1-ira.weiny@intel.com>
 <20220201071952.900068-10-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201071952.900068-10-ira.weiny@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-01-31 23:19:51, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> The CDAT read may fail for a number of reasons but mainly it is possible
> to get different parts of a valid state.  The checksum in the CDAT table
> protects against this.
> 
> Now that the checksum is validated issue a retry if the CDAT read fails.
> For now 2 retries are implemented.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> NOTE: Is 2 enough?  Should this just be delayed until the time when the
> data is actually needed and not there?

I can't speak to retries at all, but one small issue below. It might make sense
if we keep this to make it a modparam.

> 
> Changes from V5:
> 	New patch -- easy to push off or drop.
> ---
>  drivers/cxl/core/memdev.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index a01068e98333..11d721c56f08 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -356,7 +356,8 @@ static const struct file_operations cxl_memdev_fops = {
>  	.llseek = noop_llseek,
>  };
>  
> -static int read_cdat_data(struct cxl_memdev *cxlmd, struct cxl_dev_state *cxlds)
> +static int __read_cdat_data(struct cxl_memdev *cxlmd,
> +			    struct cxl_dev_state *cxlds)
>  {
>  	struct device *dev = &cxlmd->dev;
>  	size_t cdat_length;
> @@ -371,6 +372,20 @@ static int read_cdat_data(struct cxl_memdev *cxlmd, struct cxl_dev_state *cxlds)
>  	return cxl_mem_cdat_read_table(cxlds, &cxlmd->cdat);
>  }
>  
> +static int read_cdat_data(struct cxl_memdev *cxlmd,
> +			  struct cxl_dev_state *cxlds)
> +{
> +	int retries = 2;
> +	int rc;
> +
> +	while (--retries) {

You either want retries--, or retries = 3...

> +		rc = __read_cdat_data(cxlmd, cxlds);
> +		if (!rc)
> +			break;
> +	}
> +	return rc;
> +}
> +
>  struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
>  {
>  	struct cxl_memdev *cxlmd;
> -- 
> 2.31.1
> 
