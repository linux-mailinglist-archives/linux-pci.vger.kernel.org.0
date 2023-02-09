Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB806690658
	for <lists+linux-pci@lfdr.de>; Thu,  9 Feb 2023 12:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjBILQQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Feb 2023 06:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjBILPz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2023 06:15:55 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0275931E1D;
        Thu,  9 Feb 2023 03:15:32 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PCDgq1nkJz6J7kV;
        Thu,  9 Feb 2023 19:11:03 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 9 Feb
 2023 11:15:30 +0000
Date:   Thu, 9 Feb 2023 11:15:29 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <rafael@kernel.org>, <bhelgaas@google.com>,
        <robert.moore@intel.com>
Subject: Re: [PATCH 01/18] cxl: Export QTG ids from CFMWS to sysfs
Message-ID: <20230209111529.00007f2c@Huawei.com>
In-Reply-To: <167571656940.587790.15913351407119270213.stgit@djiang5-mobl3.local>
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
        <167571656940.587790.15913351407119270213.stgit@djiang5-mobl3.local>
Followup-To: linux-cxl@vger.kernel.org
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
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

On Mon, 06 Feb 2023 13:49:30 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Export the QoS Throttling Group ID from the CXL Fixed Memory Window
> Structure (CFMWS) under the root decoder sysfs attributes.
> CXL rev3.0 9.17.1.3 CXL Fixed Memory Window Structure (CFMWS)
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Hi Dave,


I've no objection to this, but would good to say why this
might be of use to userspace.  What tooling needs it?

One comment on docs inline. With those two things tidied up
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |    7 +++++++
>  drivers/cxl/acpi.c                      |    3 +++
>  drivers/cxl/core/port.c                 |   14 ++++++++++++++
>  drivers/cxl/cxl.h                       |    3 +++
>  4 files changed, 27 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 8494ef27e8d2..0932c2f6fbf4 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -294,6 +294,13 @@ Description:
>  		(WO) Write a string in the form 'regionZ' to delete that region,
>  		provided it is currently idle / not bound to a driver.
>  
> +What:		/sys/bus/cxl/devices/decoderX.Y/qtg_id
> +Date:		Jan, 2023
> +KernelVersion:	v6.3
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Shows the QoS Throttling Group ID. The QTG ID for a root
> +		decoder comes from the CFMWS structure of the CEDT.

Document the -1 value for no ID in here. Hopefully people will write
their userspace against this document and we want them to know about that
corner case!

>  
>  What:		/sys/bus/cxl/devices/regionZ/uuid
>  Date:		May, 2022
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 13cde44c6086..7a71bb5041c7 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -289,6 +289,9 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>  			}
>  		}
>  	}
> +
> +	cxld->qtg_id = cfmws->qtg_id;
> +
>  	rc = cxl_decoder_add(cxld, target_map);
>  err_xormap:
>  	if (rc)
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index b631a0520456..fe78daf7e7c8 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -284,6 +284,16 @@ static ssize_t interleave_ways_show(struct device *dev,
>  
>  static DEVICE_ATTR_RO(interleave_ways);
>  
> +static ssize_t qtg_id_show(struct device *dev,
> +			   struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_decoder *cxld = to_cxl_decoder(dev);
> +
> +	return sysfs_emit(buf, "%d\n", cxld->qtg_id);
> +}
> +
> +static DEVICE_ATTR_RO(qtg_id);
> +
>  static struct attribute *cxl_decoder_base_attrs[] = {
>  	&dev_attr_start.attr,
>  	&dev_attr_size.attr,
> @@ -303,6 +313,7 @@ static struct attribute *cxl_decoder_root_attrs[] = {
>  	&dev_attr_cap_type2.attr,
>  	&dev_attr_cap_type3.attr,
>  	&dev_attr_target_list.attr,
> +	&dev_attr_qtg_id.attr,
>  	SET_CXL_REGION_ATTR(create_pmem_region)
>  	SET_CXL_REGION_ATTR(delete_region)
>  	NULL,
> @@ -1606,6 +1617,7 @@ struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
>  	}
>  
>  	atomic_set(&cxlrd->region_id, rc);
> +	cxld->qtg_id = CXL_QTG_ID_INVALID;
>  	return cxlrd;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_root_decoder_alloc, CXL);
> @@ -1643,6 +1655,7 @@ struct cxl_switch_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
>  
>  	cxld = &cxlsd->cxld;
>  	cxld->dev.type = &cxl_decoder_switch_type;
> +	cxld->qtg_id = CXL_QTG_ID_INVALID;
>  	return cxlsd;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_switch_decoder_alloc, CXL);
> @@ -1675,6 +1688,7 @@ struct cxl_endpoint_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port)
>  	}
>  
>  	cxld->dev.type = &cxl_decoder_endpoint_type;
> +	cxld->qtg_id = CXL_QTG_ID_INVALID;
>  	return cxled;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_alloc, CXL);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1b1cf459ac77..f558bbfc0332 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -279,6 +279,7 @@ enum cxl_decoder_type {
>   */
>  #define CXL_DECODER_MAX_INTERLEAVE 16
>  
> +#define CXL_QTG_ID_INVALID	-1
>  
>  /**
>   * struct cxl_decoder - Common CXL HDM Decoder Attributes
> @@ -290,6 +291,7 @@ enum cxl_decoder_type {
>   * @target_type: accelerator vs expander (type2 vs type3) selector
>   * @region: currently assigned region for this decoder
>   * @flags: memory type capabilities and locking
> + * @qtg_id: QoS Throttling Group ID
>   * @commit: device/decoder-type specific callback to commit settings to hw
>   * @reset: device/decoder-type specific callback to reset hw settings
>  */
> @@ -302,6 +304,7 @@ struct cxl_decoder {
>  	enum cxl_decoder_type target_type;
>  	struct cxl_region *region;
>  	unsigned long flags;
> +	int qtg_id;
>  	int (*commit)(struct cxl_decoder *cxld);
>  	int (*reset)(struct cxl_decoder *cxld);
>  };
> 
> 

