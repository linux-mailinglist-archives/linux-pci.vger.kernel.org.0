Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F058A4592E8
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 17:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240217AbhKVQXu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 11:23:50 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4138 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240080AbhKVQXt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Nov 2021 11:23:49 -0500
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HyXTY6Jrkz67KMD;
        Tue, 23 Nov 2021 00:16:49 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Mon, 22 Nov 2021 17:20:40 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 22 Nov
 2021 16:20:40 +0000
Date:   Mon, 22 Nov 2021 16:20:39 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 12/23] cxl: Introduce endpoint decoders
Message-ID: <20211122162039.000022c1@Huawei.com>
In-Reply-To: <20211120000250.1663391-13-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
        <20211120000250.1663391-13-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml737-chm.china.huawei.com (10.201.108.187) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 19 Nov 2021 16:02:39 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Endpoints have decoders too. It is useful to share the same
> infrastructure from cxl_core. Endpoints do not have dports (downstream
> targets), only the underlying physical medium. As a result, some special
> casing is needed.
> 
> There is no functional change introduced yet as endpoints don't actually
> enumerate decoders yet.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

I'm not a fan of special values like using 0 here to indicate endpoint
device.  I'd rather see a base cxl_decode_alloc(..., bool ep)
and possibly wrappers for the non ep case and ep one.

Jonathan

> ---
>  drivers/cxl/core/bus.c | 41 +++++++++++++++++++++++++++++++++--------
>  1 file changed, 33 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> index 1ee12a60f3f4..16b15f54fb62 100644
> --- a/drivers/cxl/core/bus.c
> +++ b/drivers/cxl/core/bus.c
> @@ -187,6 +187,12 @@ static const struct attribute_group *cxl_decoder_switch_attribute_groups[] = {
>  	NULL,
>  };
>  
> +static const struct attribute_group *cxl_decoder_endpoint_attribute_groups[] = {
> +	&cxl_decoder_base_attribute_group,
> +	&cxl_base_attribute_group,
> +	NULL,
> +};
> +
>  static void cxl_decoder_release(struct device *dev)
>  {
>  	struct cxl_decoder *cxld = to_cxl_decoder(dev);
> @@ -196,6 +202,12 @@ static void cxl_decoder_release(struct device *dev)
>  	kfree(cxld);
>  }
>  
> +static const struct device_type cxl_decoder_endpoint_type = {
> +	.name = "cxl_decoder_endpoint",
> +	.release = cxl_decoder_release,
> +	.groups = cxl_decoder_endpoint_attribute_groups,
> +};
> +
>  static const struct device_type cxl_decoder_switch_type = {
>  	.name = "cxl_decoder_switch",
>  	.release = cxl_decoder_release,
> @@ -208,6 +220,11 @@ static const struct device_type cxl_decoder_root_type = {
>  	.groups = cxl_decoder_root_attribute_groups,
>  };
>  
> +static bool is_endpoint_decoder(struct device *dev)
> +{
> +	return dev->type == &cxl_decoder_endpoint_type;
> +}
> +
>  bool is_root_decoder(struct device *dev)
>  {
>  	return dev->type == &cxl_decoder_root_type;
> @@ -499,7 +516,9 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
>   * cxl_decoder_alloc - Allocate a new CXL decoder
>   * @port: owning port of this decoder
>   * @nr_targets: downstream targets accessible by this decoder. All upstream
> - *		ports and root ports must have at least 1 target.
> + *		ports and root ports must have at least 1 target. Endpoint
> + *		devices will have 0 targets. Callers wishing to register an
> + *		endpoint device should specify 0.
>   *
>   * A port should contain one or more decoders. Each of those decoders enable
>   * some address space for CXL.mem utilization. A decoder is expected to be
> @@ -516,7 +535,7 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
>  	struct device *dev;
>  	int rc = 0;
>  
> -	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE || nr_targets == 0)
> +	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE)
>  		return ERR_PTR(-EINVAL);
>  
>  	cxld = kzalloc(struct_size(cxld, target, nr_targets), GFP_KERNEL);
> @@ -535,8 +554,11 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
>  	dev->parent = &port->dev;
>  	dev->bus = &cxl_bus_type;
>  
> +	/* Endpoints don't have a target list */
> +	if (nr_targets == 0)
> +		dev->type = &cxl_decoder_endpoint_type;
>  	/* root ports do not have a cxl_port_type parent */
> -	if (port->dev.parent->type == &cxl_port_type)
> +	else if (port->dev.parent->type == &cxl_port_type)
>  		dev->type = &cxl_decoder_switch_type;
>  	else
>  		dev->type = &cxl_decoder_root_type;
> @@ -579,12 +601,15 @@ int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
>  	if (cxld->interleave_ways < 1)
>  		return -EINVAL;
>  
> -	port = to_cxl_port(cxld->dev.parent);
> -	rc = decoder_populate_targets(cxld, port, target_map);
> -	if (rc)
> -		return rc;
> -
>  	dev = &cxld->dev;
> +
> +	port = to_cxl_port(cxld->dev.parent);
> +	if (!is_endpoint_decoder(dev)) {
> +		rc = decoder_populate_targets(cxld, port, target_map);
> +		if (rc)
> +			return rc;
> +	}
> +
>  	rc = dev_set_name(dev, "decoder%d.%d", port->id, cxld->id);
>  	if (rc)
>  		return rc;

