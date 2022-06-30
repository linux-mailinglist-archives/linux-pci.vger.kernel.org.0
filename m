Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34743561FAA
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jun 2022 17:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbiF3PsQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jun 2022 11:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbiF3PsO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2022 11:48:14 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5515913CD5;
        Thu, 30 Jun 2022 08:48:10 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LYjPz4P6Vz67jhH;
        Thu, 30 Jun 2022 23:47:19 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 30 Jun 2022 17:48:08 +0200
Received: from localhost (10.81.200.250) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 30 Jun
 2022 16:48:07 +0100
Date:   Thu, 30 Jun 2022 16:48:05 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
        <hch@lst.de>
Subject: Re: [PATCH 39/46] cxl/acpi: Add a host-bridge index lookup
 mechanism
Message-ID: <20220630164805.00007b0c@Huawei.com>
In-Reply-To: <20220624041950.559155-14-dan.j.williams@intel.com>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <20220624041950.559155-14-dan.j.williams@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.200.250]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
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

On Thu, 23 Jun 2022 21:19:43 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> The ACPI CXL Fixed Memory Window Structure (CFMWS) defines multiple
> methods to determine which host bridge provides access to a given
> endpoint relative to that device's position in the interleave. The
> "Interleave Arithmetic" defines either a "standard modulo" /
> round-random algorithm, or "xormap" based algorithm which can be defined
> as a non-linear transform. Given that there are already more options
> beyond "standard modulo" and that "xormap" may turn out to be ACPI CXL
> specific, provide a callback for the region provisioning code to map
> endpoint positions back to expected host bridge id (cxl_dport target).
> 
> For now just support the simple modulo math case and save the xormap for
> a follow-on change.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/port.c | 15 +++++++++++++++
>  drivers/cxl/cxl.h       |  2 ++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 562a6453249b..7756409d0a58 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1422,6 +1422,20 @@ static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
>  	return rc;
>  }
>  
> +static struct cxl_dport *cxl_hb_modulo(struct cxl_root_decoder *cxlrd, int pos)
> +{
> +	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
> +	struct cxl_decoder *cxld = &cxlsd->cxld;
> +	int iw;
> +
> +	iw = cxld->interleave_ways;
> +	if (dev_WARN_ONCE(&cxld->dev, iw != cxlsd->nr_targets,
> +			  "misconfigured root decoder\n"))
> +		return NULL;
> +
> +	return cxlrd->cxlsd.target[pos % iw];
> +}
> +
>  static struct lock_class_key cxl_decoder_key;
>  
>  /**
> @@ -1466,6 +1480,7 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
>  				if (rc < 0)
>  					goto err;
>  				atomic_set(&cxlrd->region_id, rc);
> +				cxlrd->calc_hb = cxl_hb_modulo;
>  			} else
>  				cxlsd = NULL;
>  		} else {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 9340deccad4f..30227348f768 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -315,11 +315,13 @@ struct cxl_switch_decoder {
>   * struct cxl_root_decoder - Static platform CXL address decoder
>   * @res: host / parent resource for region allocations
>   * @region_id: region id for next region provisioning event
> + * @calc_hb: which host bridge covers the n'th position by granularity
>   * @cxlsd: base cxl switch decoder
>   */
>  struct cxl_root_decoder {
>  	struct resource *res;
>  	atomic_t region_id;
> +	struct cxl_dport *(*calc_hb)(struct cxl_root_decoder *cxlrd, int pos);
>  	struct cxl_switch_decoder cxlsd;
>  };
>  

