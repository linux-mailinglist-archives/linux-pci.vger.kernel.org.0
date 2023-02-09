Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866E3690D0D
	for <lists+linux-pci@lfdr.de>; Thu,  9 Feb 2023 16:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjBIPeT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Feb 2023 10:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjBIPeJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2023 10:34:09 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1273560D64;
        Thu,  9 Feb 2023 07:34:07 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PCLTf5Cs8z6J9Zc;
        Thu,  9 Feb 2023 23:32:38 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 9 Feb
 2023 15:34:04 +0000
Date:   Thu, 9 Feb 2023 15:34:03 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <rafael@kernel.org>,
        <bhelgaas@google.com>, <robert.moore@intel.com>
Subject: Re: [PATCH 17/18] cxl: Attach QTG IDs to the DPA ranges for the
 device
Message-ID: <20230209153403.00005fb8@Huawei.com>
In-Reply-To: <167571671461.587790.3035047445704886954.stgit@djiang5-mobl3.local>
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
        <167571671461.587790.3035047445704886954.stgit@djiang5-mobl3.local>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 06 Feb 2023 13:51:55 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Match the DPA ranges of the mem device and the calcuated DPA range attached
> to the DSMAS. If a match is found, then assign the QTG ID to the relevant
> DPA range of the memory device.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/mbox.c |    2 ++
>  drivers/cxl/cxlmem.h    |    2 ++
>  drivers/cxl/port.c      |   35 +++++++++++++++++++++++++++++++++++
>  3 files changed, 39 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index b03fba212799..2a7b07d65010 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -869,6 +869,8 @@ struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
>  
>  	mutex_init(&cxlds->mbox_mutex);
>  	cxlds->dev = dev;
> +	cxlds->pmem_qtg_id = -1;
> +	cxlds->ram_qtg_id = -1;
>  
>  	return cxlds;
>  }
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index ab138004f644..d88b88ecc807 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -251,6 +251,8 @@ struct cxl_dev_state {
>  	struct resource dpa_res;
>  	struct resource pmem_res;
>  	struct resource ram_res;
> +	int pmem_qtg_id;
> +	int ram_qtg_id;
>  	u64 total_bytes;
>  	u64 volatile_only_bytes;
>  	u64 persistent_only_bytes;
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 6b2ad22487f5..c4cee69d6625 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -68,6 +68,39 @@ static int cxl_port_qos_calculate(struct cxl_port *port)
>  	return 0;
>  }
>  
> +static bool dpa_match_qtg_range(struct range *dpa, struct range *qtg)
> +{
> +	if (dpa->start >= qtg->start && dpa->end <= qtg->end)
> +		return true;
> +	return false;

	return dpa->start >= qtg->start && dpa->end <= qtg-end;

> +}
> +
> +static void cxl_dev_set_qtg(struct cxl_port *port, struct cxl_dev_state *cxlds)
> +{
> +	struct dsmas_entry *dent;
> +	struct range ram_range = {
> +		.start = cxlds->ram_res.start,
> +		.end = cxlds->ram_res.end,
> +	};
> +	struct range pmem_range =  {
> +		.start = cxlds->pmem_res.start,
> +		.end = cxlds->pmem_res.end,
> +	};
> +
> +	mutex_lock(&port->cdat.dsmas_lock);
> +	list_for_each_entry(dent, &port->cdat.dsmas_list, list) {
> +		if (dpa_match_qtg_range(&ram_range, &dent->dpa_range)) {
> +			cxlds->ram_qtg_id = dent->qtg_id;
> +			break;
> +		}
> +		if (dpa_match_qtg_range(&pmem_range, &dent->dpa_range)) {
> +			cxlds->pmem_qtg_id = dent->qtg_id;

Could be multiple ranges in ram and pmem. I guess we can leave that for
future work.

> +			break;
> +		}
> +	}
> +	mutex_unlock(&port->cdat.dsmas_lock);
> +}
> +
>  static int cxl_port_probe(struct device *dev)
>  {
>  	struct cxl_port *port = to_cxl_port(dev);
> @@ -134,6 +167,8 @@ static int cxl_port_probe(struct device *dev)
>  		rc = cxl_mem_create_range_info(cxlds);
>  		if (rc)
>  			return rc;
> +
> +		cxl_dev_set_qtg(port, cxlds);
>  	}
>  
>  	rc = devm_cxl_enumerate_decoders(cxlhdm);
> 
> 

