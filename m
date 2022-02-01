Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6EF4A6366
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 19:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241871AbiBASRB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 13:17:01 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4607 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241985AbiBASQY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 13:16:24 -0500
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JpChN44dFz67rWf;
        Wed,  2 Feb 2022 02:12:36 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Feb 2022 19:16:22 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 1 Feb
 2022 18:16:21 +0000
Date:   Tue, 1 Feb 2022 18:16:20 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <patches@lists.linux.dev>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Bjorn Helgaas" <helgaas@kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 09/14] cxl/region: Add infrastructure for decoder
 programming
Message-ID: <20220201181620.00006a9d@Huawei.com>
In-Reply-To: <20220128002707.391076-10-ben.widawsky@intel.com>
References: <20220128002707.391076-1-ben.widawsky@intel.com>
 <20220128002707.391076-10-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 27 Jan 2022 16:27:02 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> There are 3 steps in handling region programming once it has been
> configured by userspace.
> 1. Sanitize the parameters against the system.
> 2. Collect decoder resources from the topology
> 3. Program decoder resources
> 
> The infrastructure added here addresses #2. Two new APIs are introduced
> to allow collecting and returning decoder resources. Additionally the
> infrastructure includes two lists managed by the region driver, a staged
> list, and a commit list. The staged list contains those collected in
> step #2, and the commit list are all the decoders programmed in step #3.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

Minor comments inline.

>  static void cxld_unregister(void *dev)
>  {
>  	device_unregister(dev);
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 784e4ba25128..a62d48454a56 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -440,6 +440,8 @@ struct cxl_region *cxl_alloc_region(struct cxl_decoder *cxld, int id)
>  	if (!cxlr)
>  		return ERR_PTR(-ENOMEM);
>  
> +	INIT_LIST_HEAD(&cxlr->staged_list);
> +	INIT_LIST_HEAD(&cxlr->commit_list);
>  	cxlr->id = id;
>  
>  	return cxlr;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index ed984465b59c..8ace6cca0776 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -35,6 +35,8 @@
>  #define   CXL_CM_CAP_CAP_ID_HDM 0x5
>  #define   CXL_CM_CAP_CAP_HDM_VERSION 1
>  
> +#define CXL_DECODER_MAX_INSTANCES 10
> +
>  /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
>  #define CXL_HDM_DECODER_CAP_OFFSET 0x0
>  #define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
> @@ -265,6 +267,7 @@ enum cxl_decoder_type {
>   * @target_lock: coordinate coherent reads of the target list
>   * @region_ida: allocator for region ids.
>   * @address_space: Used/free address space for regions.
> + * @region_link: This decoder's place on either the staged, or commit list.
>   * @nr_targets: number of elements in @target
>   * @target: active ordered target list in current decoder configuration
>   */
> @@ -282,6 +285,7 @@ struct cxl_decoder {
>  	seqlock_t target_lock;
>  	struct ida region_ida;
>  	struct gen_pool *address_space;
> +	struct list_head region_link;
>  	int nr_targets;
>  	struct cxl_dport *target[];
>  };
> @@ -326,6 +330,7 @@ struct cxl_nvdimm {
>   * @id: id for port device-name
>   * @dports: cxl_dport instances referenced by decoders
>   * @endpoints: cxl_ep instances, endpoints that are a descendant of this port
> + * @region_link: this port's node on the region's list of ports

docs but no field in the structure...


>   * @decoder_ida: allocator for decoder ids
>   * @component_reg_phys: component register capability base address (optional)
>   * @dead: last ep has been removed, force port re-creation
> @@ -396,6 +401,8 @@ struct cxl_port *find_cxl_root(struct device *dev);
>  int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
>  int cxl_bus_rescan(void);
>  struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd);
> +struct cxl_decoder *cxl_get_decoder(struct cxl_port *port);
> +void cxl_put_decoder(struct cxl_decoder *cxld);
>  bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd);
>  
>  struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
> @@ -406,6 +413,7 @@ struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
>  struct cxl_port *ep_find_cxl_port(struct cxl_memdev *cxlmd, unsigned int depth);
>  
>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
> +bool is_cxl_decoder(struct device *dev);

They are multiplying!! (see 2 lines down.)

>  bool is_root_decoder(struct device *dev);
>  bool is_cxl_decoder(struct device *dev);
>  struct cxl_decoder *cxl_root_decoder_alloc(struct cxl_port *port,

> diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
> index d2f6c990c8a8..145d7bb02714 100644
> --- a/drivers/cxl/region.c
> +++ b/drivers/cxl/region.c
> @@ -359,21 +359,59 @@ static bool has_switch(const struct cxl_region *cxlr)
>  	return false;
>  }
>

...

>  static int bind_region(const struct cxl_region *cxlr)
> @@ -559,7 +648,7 @@ static int cxl_region_probe(struct device *dev)
>  		return -ENXIO;
>  	}
>  
> -	if (!rootd_valid(cxlr, rootd)) {
> +	if (!rootd_valid(cxlr, rootd, true)) {
>  		dev_err(dev, "Picked invalid rootd\n");
>  		return -ENXIO;
>  	}
> @@ -574,14 +663,18 @@ static int cxl_region_probe(struct device *dev)
>  
>  	ret = collect_ep_decoders(cxlr);
>  	if (ret)
> -		return ret;
> +		goto err;
>  
>  	ret = bind_region(cxlr);
> -	if (!ret) {
> -		cxlr->active = true;
> -		dev_info(dev, "Bound");
> -	}
> +	if (ret)
> +		goto err;
>  
> +	cxlr->active = true;
> +	dev_info(dev, "Bound");

Not keen on this being always printed in the logs.  dev_dbg() perhaps with
some more detail may be 

> +	return 0;
> +
> +err:
> +	cleanup_staged_decoders(cxlr);
>  	return ret;
>  }
>  
> diff --git a/drivers/cxl/region.h b/drivers/cxl/region.h
> index 00a6dc729c26..fc15abaeb638 100644
> --- a/drivers/cxl/region.h
> +++ b/drivers/cxl/region.h
> @@ -14,6 +14,9 @@
>   * @list: Node in decoder's region list.
>   * @res: Resource this region carves out of the platform decode range.
>   * @active: If the region has been activated.
> + * @staged_list: All decoders staged for programming.
> + * @commit_list: All decoders programmed for this region's parameters.
> + *

Why the blank line?  If it makes sense should be in earlier patch
and I'm not sure if kernel-doc allows blank lines in the list.


>   * @config: HDM decoder program config
>   * @config.size: Size of the region determined from LSA or userspace.
>   * @config.uuid: The UUID for this region.
> @@ -27,6 +30,8 @@ struct cxl_region {
>  	struct list_head list;
>  	struct resource *res;
>  	bool active;
> +	struct list_head staged_list;
> +	struct list_head commit_list;
>  
>  	struct {
>  		u64 size;

