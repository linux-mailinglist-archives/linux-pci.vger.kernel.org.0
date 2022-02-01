Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDBAA4A60C5
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 16:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240715AbiBAPx1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 10:53:27 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4604 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240707AbiBAPx1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 10:53:27 -0500
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jp8WS0w14z67Gvv;
        Tue,  1 Feb 2022 23:49:40 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Feb 2022 16:53:25 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 1 Feb
 2022 15:53:24 +0000
Date:   Tue, 1 Feb 2022 15:53:22 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <patches@lists.linux.dev>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Bjorn Helgaas" <helgaas@kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 01/14] cxl/region: Add region creation ABI
Message-ID: <20220201155322.00004e7c@Huawei.com>
In-Reply-To: <20220128002707.391076-2-ben.widawsky@intel.com>
References: <20220128002707.391076-1-ben.widawsky@intel.com>
        <20220128002707.391076-2-ben.widawsky@intel.com>
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

On Thu, 27 Jan 2022 16:26:54 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Regions are created as a child of the decoder that encompasses an
> address space with constraints. Regions have a number of attributes that
> must be configured before the region can be activated.
> 
> The ABI is not meant to be secure, but is meant to avoid accidental
> races. As a result, a buggy process may create a region by name that was
> allocated by a different process. However, multiple processes which are
> trying not to race with each other shouldn't need special
> synchronization to do so.
> 
> // Allocate a new region name
> region=$(cat /sys/bus/cxl/devices/decoder0.0/create_region)
> 
> // Create a new region by name
> echo $region > /sys/bus/cxl/devices/decoder0.0/create_region
> 
> // Region now exists in sysfs
> stat -t /sys/bus/cxl/devices/decoder0.0/$region
> 
> // Delete the region, and name
> echo $region > /sys/bus/cxl/devices/decoder0.0/delete_region
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> 

One trivial comment below.


> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 13fb06849199..b9f0099c1f39 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -221,6 +221,7 @@ enum cxl_decoder_type {
>   * @target_type: accelerator vs expander (type2 vs type3) selector
>   * @flags: memory type capabilities and locking
>   * @target_lock: coordinate coherent reads of the target list
> + * @region_ida: allocator for region ids.
>   * @nr_targets: number of elements in @target
>   * @target: active ordered target list in current decoder configuration
>   */
> @@ -236,6 +237,7 @@ struct cxl_decoder {
>  	enum cxl_decoder_type target_type;
>  	unsigned long flags;
>  	seqlock_t target_lock;
> +	struct ida region_ida;
>  	int nr_targets;
>  	struct cxl_dport *target[];
>  };
> @@ -323,6 +325,13 @@ struct cxl_ep {
>  	struct list_head list;
>  };
>  
> +bool is_cxl_region(struct device *dev);

Not in this patch. Looks like it is in patch 4.


> +struct cxl_region *to_cxl_region(struct device *dev);
> +struct cxl_region *cxl_alloc_region(struct cxl_decoder *cxld,
> +				    int interleave_ways);
> +int cxl_add_region(struct cxl_decoder *cxld, struct cxl_region *cxlr);
> +int cxl_delete_region(struct cxl_decoder *cxld, const char *region);
> +
>  static inline bool is_cxl_root(struct cxl_port *port)
>  {
>  	return port->uport == port->dev.parent;

