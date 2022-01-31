Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0134C4A49A0
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jan 2022 15:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240920AbiAaOq4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 09:46:56 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4563 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbiAaOqy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jan 2022 09:46:54 -0500
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JnW8r6MNyz67x8d;
        Mon, 31 Jan 2022 22:46:20 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Mon, 31 Jan 2022 15:46:51 +0100
Received: from localhost (10.47.73.212) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Mon, 31 Jan
 2022 14:46:50 +0000
Date:   Mon, 31 Jan 2022 14:46:45 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        <linux-pci@vger.kernel.org>, <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v3 11/40] cxl/core/port: Clarify decoder creation
Message-ID: <20220131144645.000005e1@Huawei.com>
In-Reply-To: <164298417755.3018233.850001481653928773.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164298417755.3018233.850001481653928773.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.73.212]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 23 Jan 2022 16:29:37 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> From: Ben Widawsky <ben.widawsky@intel.com>
> 
> Add wrappers for the creation of decoder objects at the root level and
> switch level, and keep the core helper private to cxl/core/port.c. Root
> decoders are static descriptors conveyed from platform firmware (e.g.
> ACPI CFMWS). Switch decoders are CXL standard decoders enumerated via
> the HDM decoder capability structure. The base address for the HDM
> decoder capability structure may be conveyed either by PCIe or platform
> firmware (ACPI CEDT.CHBS).

The switch naming is a bit odd for host bridge decoders, but
I can't immediately think of an alternative. Perhaps just call
out that case in the relevant docs?

Probably a good idea to call out that this patch also adds some documentation
to related functions alongside the changes mentioned above.

A few minor comments inline.

Jonathan

> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> [djbw: fixup changelog]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/acpi.c      |    4 +-
>  drivers/cxl/core/port.c |   78 ++++++++++++++++++++++++++++++++++++++++++-----
>  drivers/cxl/cxl.h       |   10 +++++-
>  3 files changed, 81 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index da70f1836db6..0b267eabb15e 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -102,7 +102,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>  	for (i = 0; i < CFMWS_INTERLEAVE_WAYS(cfmws); i++)
>  		target_map[i] = cfmws->interleave_targets[i];
>  
> -	cxld = cxl_decoder_alloc(root_port, CFMWS_INTERLEAVE_WAYS(cfmws));
> +	cxld = cxl_root_decoder_alloc(root_port, CFMWS_INTERLEAVE_WAYS(cfmws));
>  	if (IS_ERR(cxld))
>  		return 0;
>  
> @@ -260,7 +260,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  	 * dport. Disable the range until the first CXL region is enumerated /
>  	 * activated.
>  	 */
> -	cxld = cxl_decoder_alloc(port, 1);
> +	cxld = cxl_switch_decoder_alloc(port, 1);
>  	if (IS_ERR(cxld))
>  		return PTR_ERR(cxld);
>  
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 63c76cb2a2ec..2910c36a0e58 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -495,13 +495,26 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
>  	return rc;
>  }
>  
> -struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
> +/**
> + * cxl_decoder_alloc - Allocate a new CXL decoder
> + * @port: owning port of this decoder
> + * @nr_targets: downstream targets accessible by this decoder. All upstream
> + *		ports and root ports must have at least 1 target.
> + *
> + * A port should contain one or more decoders. Each of those decoders enable
> + * some address space for CXL.mem utilization. A decoder is expected to be
> + * configured by the caller before registering.
> + *
> + * Return: A new cxl decoder to be registered by cxl_decoder_add()
> + */
> +static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
> +					     unsigned int nr_targets)
>  {
>  	struct cxl_decoder *cxld;
>  	struct device *dev;
>  	int rc = 0;
>  
> -	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE || nr_targets < 1)
> +	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE || nr_targets == 0)
>  		return ERR_PTR(-EINVAL);
>  
>  	cxld = kzalloc(struct_size(cxld, target, nr_targets), GFP_KERNEL);
> @@ -519,20 +532,69 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
>  	device_set_pm_not_required(dev);
>  	dev->parent = &port->dev;
>  	dev->bus = &cxl_bus_type;
> -
> -	/* root ports do not have a cxl_port_type parent */
> -	if (port->dev.parent->type == &cxl_port_type)
> -		dev->type = &cxl_decoder_switch_type;
> +	if (is_cxl_root(port))
> +		cxld->dev.type = &cxl_decoder_root_type;
>  	else
> -		dev->type = &cxl_decoder_root_type;
> +		cxld->dev.type = &cxl_decoder_switch_type;
>  
>  	return cxld;
>  err:
>  	kfree(cxld);
>  	return ERR_PTR(rc);
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_decoder_alloc, CXL);
>  
> +/**
> + * cxl_root_decoder_alloc - Allocate a root level decoder
> + * @port: owning CXL root port of this decoder

root port is a bit confusing here given the other meanings of that in PCI.
Perhaps port of CXL root or something else?

> + * @nr_targets: number of downstream targets. The number of downstream targets
> + *		is determined with a platform specific mechanism.
> + *
> + * Return: A new cxl decoder to be registered by cxl_decoder_add()
> + */
> +struct cxl_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
> +					   unsigned int nr_targets)
> +{
> +	if (!is_cxl_root(port))
> +		return ERR_PTR(-EINVAL);
> +
> +	return cxl_decoder_alloc(port, nr_targets);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_root_decoder_alloc, CXL);
> +
> +/**
> + * cxl_switch_decoder_alloc - Allocate a switch level decoder
> + * @port: owning CXL switch port of this decoder
> + * @nr_targets: number of downstream targets. The number of downstream targets
> + *		is determined via CXL capability registers.

Perhaps call out that it's the _maximum_ number of downstream targets?
Whether all are used is I think a configuration choice.
The accessible wording you use above gives the appropriate indication
of flexibility.

> + *
> + * Return: A new cxl decoder to be registered by cxl_decoder_add()
> + */
> +struct cxl_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
> +					     unsigned int nr_targets)
> +{
> +	if (is_cxl_root(port))
> +		return ERR_PTR(-EINVAL);
> +
> +	return cxl_decoder_alloc(port, nr_targets);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_switch_decoder_alloc, CXL);
> +
> +/**

This new documentation is non trivial enough it should either be in a separate
patch, or at least called out in the patch description.

> + * cxl_decoder_add - Add a decoder with targets
> + * @cxld: The cxl decoder allocated by cxl_decoder_alloc()
> + * @target_map: A list of downstream ports that this decoder can direct memory
> + *              traffic to. These numbers should correspond with the port number
> + *              in the PCIe Link Capabilities structure.
> + *
> + * Certain types of decoders may not have any targets. The main example of this
> + * is an endpoint device. A more awkward example is a hostbridge whose root
> + * ports get hot added (technically possible, though unlikely).
> + *
> + * Context: Process context. Takes and releases the cxld's device lock.
> + *
> + * Return: Negative error code if the decoder wasn't properly configured; else
> + *	   returns 0.
> + */
>  int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
>  {
>  	struct cxl_port *port;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index bfd95acea66c..e60878ab4569 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -278,6 +278,11 @@ struct cxl_dport {
>  	struct list_head list;
>  };
>  
> +static inline bool is_cxl_root(struct cxl_port *port)
This is non obvious enough to perhaps warrant an explanation
of why this condition indicates a cxl_root.

> +{
> +	return port->uport == port->dev.parent;
> +}
> +
>  struct cxl_port *to_cxl_port(struct device *dev);
>  struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
>  				   resource_size_t component_reg_phys,
> @@ -288,7 +293,10 @@ int cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
>  
>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
>  bool is_root_decoder(struct device *dev);
> -struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets);
> +struct cxl_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
> +					   unsigned int nr_targets);
> +struct cxl_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
> +					     unsigned int nr_targets);
>  int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
>  int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);
>  
> 

