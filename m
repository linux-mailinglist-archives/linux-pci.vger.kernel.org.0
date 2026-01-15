Return-Path: <linux-pci+bounces-44955-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC08D2506A
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 15:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4FCE4301B331
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 14:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC693A7DE0;
	Thu, 15 Jan 2026 14:46:24 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E73430E824;
	Thu, 15 Jan 2026 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768488384; cv=none; b=CkwMcppMrh8kXYo+AKLqOaY10ty2qbTcKa2ZT4lvSlH0ks5S4EScIn7Cp3mO5PPoGNKNx0SldyZue58mrSiUSADVTi2Lbt078jNgtSxltbYy/NnxFjSQBS9kvYsDvevVEUFuCn+cipJEE6GJe8I7XFwP4mtXyas76c/spNt7m/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768488384; c=relaxed/simple;
	bh=fjSf15uCtdSH7MOgSSj/phoZdS/nHJ2Ms1DSWSQa6CU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QN4/TjeAtxkjwPgoPpX6FOifaOxC3FVp6jFFxRFqjz5k2yFrxhvMxbmf8e5IPBGuAWdc1jFTI8oUGjLqbDueGHxX/hS8QajOrV20/WIkR1w7d/s4v8KU744FFad9pyZ/9yEwxu0G8epnDe7MTCaIetFABg8+B87SnYmo7v3Bxpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dsQlF1GbpzHnH56;
	Thu, 15 Jan 2026 22:45:45 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 3DBE040584;
	Thu, 15 Jan 2026 22:46:07 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 15 Jan
 2026 14:46:06 +0000
Date: Thu, 15 Jan 2026 14:46:05 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v14 19/34] cxl/port: Fix devm resource leaks around with
 dport management
Message-ID: <20260115144605.00000666@huawei.com>
In-Reply-To: <20260114182055.46029-20-terry.bowman@amd.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
	<20260114182055.46029-20-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 14 Jan 2026 12:20:40 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> From: Dan Williams <dan.j.williams@intel.com>
> 
> With dport addition moving out of cxl_switch_port_probe() it is no longer
> the case that a single dport-add failure will cause all dport resources
> to be automatically unwound.
> 
> devm still helps all dport resources get cleaned up when the port is
> detached, but setup now needs to avoid leaking resources if an early exit
> occurs during setup.
> 
> Convert from a "devm add" model, to an "auto remove" model that makes the
> caller responsible for registering devm reclaim after the object is fully
> instantiated.
> 
> As a side of effect of this reorganization port->nr_dports is now always
> consistent with the number of entries in the port->dports xarray, and this
> can stop playing games with ida_is_empty() which is unreliable as a
> detector of whether decoders are setup. I.e. consider how
> CONFIG_DEBUG_KOBJECT_RELEASE might wreak havoc with this approach.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Terry Bowman <terry.bowman@amd.com>
> 
> ---
> 
> Changes in v13 -> v14:
> - New patch
Hi Dan, Terry,

I think this needs a little reorganization to ensure we don't have
dport and dport_add both being the same pointer for different free
reasons.  Adding a helper and we can combine them with a clear
hand over of ownership.

Wrapping devres_remove_group() in a function that is called close_group()
rings alarm bells.

Jonathan


> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index fef3aa0c6680..a05a1812bb6e 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c

> -static struct cxl_dport *
> -__devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
> -		     int port_id, resource_size_t component_reg_phys,
> -		     resource_size_t rcrb)
> +static struct cxl_dport *__cxl_add_dport(struct cxl_port *port,
> +					 struct device *dport_dev, int port_id,
> +					 resource_size_t component_reg_phys,
> +					 resource_size_t rcrb)
>  {
>  	char link_name[CXL_TARGET_STRLEN];
> -	struct cxl_dport *dport;
> -	struct device *host;
>  	int rc;
>  
> -	if (is_cxl_root(port))
> -		host = port->uport_dev;
> -	else
> -		host = &port->dev;
> -
> -	if (!host->driver) {
> -		dev_WARN_ONCE(&port->dev, 1, "dport:%s bad devm context\n",
> -			      dev_name(dport_dev));
> -		return ERR_PTR(-ENXIO);
> -	}
> -
>  	if (snprintf(link_name, CXL_TARGET_STRLEN, "dport%d", port_id) >=
>  	    CXL_TARGET_STRLEN)
>  		return ERR_PTR(-EINVAL);
>  
> -	dport = devm_kzalloc(host, sizeof(*dport), GFP_KERNEL);
> +	struct cxl_dport *dport __free(kfree) =
> +		kzalloc(sizeof(*dport), GFP_KERNEL);
>  	if (!dport)
>  		return ERR_PTR(-ENOMEM);
>  
> @@ -1176,48 +1175,27 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  			&component_reg_phys);
>  
>  	cond_cxl_root_lock(port);
> -	rc = add_dport(port, dport);
> +	struct cxl_dport *dport_add __free(remove_dport) =
> +		add_dport(port, dport);

This pattern of having both dport and dport_add effectively
pointing to the same pointer concerns me from a readability / maintainability
point of view. We've often made use of helper functions to avoid doing
this and I think that would make sense here as well.

Take everything down to and including dport_add() as a helper called
something like (naming needs work!)
	struct dport_dev *dport __free(remove_and_free_dport) =
		add_dport_wrapper();

With the __free doing the kfree as well as remove.


>  	cond_cxl_root_unlock(port);
> -	if (rc)
> -		return ERR_PTR(rc);
> -
> -	/*
> -	 * Setup port register if this is the first dport showed up. Having
> -	 * a dport also means that there is at least 1 active link.
> -	 */
> -	if (port->nr_dports == 1 &&
> -	    port->component_reg_phys != CXL_RESOURCE_NONE) {
> -		rc = cxl_port_setup_regs(port, port->component_reg_phys);
> -		if (rc) {
> -			xa_erase(&port->dports, (unsigned long)dport->dport_dev);
> -			return ERR_PTR(rc);
> -		}
> -		port->component_reg_phys = CXL_RESOURCE_NONE;
> -	}
> +	if (IS_ERR(dport_add))
> +		return dport_add;
>  
> -	get_device(dport_dev);
> -	rc = devm_add_action_or_reset(host, cxl_dport_remove, dport);
> -	if (rc)
> -		return ERR_PTR(rc);
> +	if (dev_is_pci(dport_dev))
> +		dport->link_latency = cxl_pci_get_latency(to_pci_dev(dport_dev));
>  
>  	rc = sysfs_create_link(&port->dev.kobj, &dport_dev->kobj, link_name);
>  	if (rc)
>  		return ERR_PTR(rc);
>  
> -	rc = devm_add_action_or_reset(host, cxl_dport_unlink, dport);
> -	if (rc)
> -		return ERR_PTR(rc);
> -
> -	if (dev_is_pci(dport_dev))
> -		dport->link_latency = cxl_pci_get_latency(to_pci_dev(dport_dev));
> -
>  	cxl_debugfs_create_dport_dir(dport);
>  
> -	return dport;
> +	retain_and_null_ptr(dport_add);
> +	return no_free_ptr(dport);
>  }



> +
> +/*
> + * Note: this only services dynamic removal of mid-level ports, root ports are
> + * always removed by the platform driver (e.g. cxl_acpi). @host can be
> + * hard-coded to &port->dev.
> + */
>  static void del_dport(struct cxl_dport *dport)
>  {
>  	struct cxl_port *port = dport->port;
>  
> -	devm_release_action(&port->dev, cxl_dport_unlink, dport);
> -	devm_release_action(&port->dev, cxl_dport_remove, dport);
> -	devm_kfree(&port->dev, dport);
> +	devm_release_action(&port->dev, unlink_dport, dport);
>  }
>  
>  static void del_dports(struct cxl_port *port)
> @@ -1597,10 +1603,24 @@ static int update_decoder_targets(struct device *dev, void *data)
>  	return 0;
>  }
>  
> -DEFINE_FREE(del_cxl_dport, struct cxl_dport *, if (!IS_ERR_OR_NULL(_T)) del_dport(_T))
> +static struct cxl_port *cxl_port_devres_group(struct cxl_port *port)
> +{
> +	if (!devres_open_group(&port->dev, port, GFP_KERNEL))
> +		return ERR_PTR(-ENOMEM);
> +	return port;
> +}
> +DEFINE_FREE(cxl_port_group_free, struct cxl_port *,
> +	if (!IS_ERR_OR_NULL(_T)) devres_release_group(&(_T)->dev, _T))
> +
> +static void cxl_port_group_close(struct cxl_port *port)

This feels like misleading naming and I'm not sure what intent is. 
Would have expected it to call devres_close_group()

> +{
> +	devres_remove_group(&port->dev, port);
> +}
> +
>  static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
>  					    struct device *dport_dev)
>  {
> +	struct cxl_dport *new_dport;
>  	struct cxl_dport *dport;
>  	int rc;
>  
> @@ -1615,29 +1635,46 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
>  		return ERR_PTR(-EBUSY);
>  	}
>  
> -	struct cxl_dport *new_dport __free(del_cxl_dport) =
> -		devm_cxl_add_dport_by_dev(port, dport_dev);
> -	if (IS_ERR(new_dport))
> -		return new_dport;
> -
> -	cxl_switch_parse_cdat(new_dport);
> +	/*
> +	 * With the first dport arrival it is now safe to start looking at
> +	 * component registers. Be careful to not strand resources if dport
> +	 * creation ultimately fails.
> +	 */
> +	struct cxl_port *port_group __free(cxl_port_group_free) =
> +		cxl_port_devres_group(port);
> +	if (IS_ERR(port_group))
> +		return ERR_CAST(port_group);
>  
> -	if (ida_is_empty(&port->decoder_ida)) {
> +	if (port->nr_dports == 0) {
>  		rc = devm_cxl_switch_port_decoders_setup(port);
>  		if (rc)
>  			return ERR_PTR(rc);
> -		dev_dbg(&port->dev, "first dport%d:%s added with decoders\n",
> -			new_dport->port_id, dev_name(dport_dev));
> -		return no_free_ptr(new_dport);
> +		/*
> +		 * Note, when nr_dports returns to zero the port is unregistered
> +		 * and triggers cleanup. I.e. no need for open-coded release
> +		 * action on dport removal. See cxl_detach_ep() for that logic.
> +		 */
>  	}
>  
> +	new_dport = cxl_add_dport_by_dev(port, dport_dev);
> +	if (IS_ERR(new_dport))
> +		return new_dport;
> +
> +	rc = cxl_dport_autoremove(new_dport);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	cxl_switch_parse_cdat(new_dport);
> +
> +	cxl_port_group_close(no_free_ptr(port_group));

Give name vs what it does I'm not sure how this currently works.

> +
> +	dev_dbg(&port->dev, "dport[%d] id:%d dport_dev: %s added\n",
> +		port->nr_dports - 1, new_dport->port_id, dev_name(dport_dev));
> +
>  	/* New dport added, update the decoder targets */
>  	device_for_each_child(&port->dev, new_dport, update_decoder_targets);
>  
> -	dev_dbg(&port->dev, "dport%d:%s added\n", new_dport->port_id,
> -		dev_name(dport_dev));
> -
> -	return no_free_ptr(new_dport);
> +	return new_dport;
>  }
>  
>  static struct cxl_dport *devm_cxl_create_port(struct device *ep_dev,



