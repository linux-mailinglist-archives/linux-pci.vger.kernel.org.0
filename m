Return-Path: <linux-pci+bounces-44869-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 393A4D21556
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 22:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5D6C304A7F5
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 21:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EA636166F;
	Wed, 14 Jan 2026 21:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KdfkLWm0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8DD285041;
	Wed, 14 Jan 2026 21:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768426022; cv=none; b=iCQKz3IxyAzVJ5Sm03j00Sp4sfn1nlND1bVPdrx6qN/WXWjjPGgkHeAxPNcThRu/tpgWk5L7OE8PQA29zL2vLE312PCv1q1Fzesr15hjr3UK1Oxejcv0STGF32CHQNISm3hM9fmK1g6ViqxQRoKycfVG6Uc87ZX2RJJtylbaG/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768426022; c=relaxed/simple;
	bh=o5b27HopzzqbxoRQ+swulM0LrWo6LqlQwDn0miCkCNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IvqN01WLiuFpCgayYroQO+hVB8H5X3PAl6qW/uDKUe5BJdGeE66dlbYv2HxudPWwczp1uqE3mmZa+cf0dzvCteiOqhw/5FA8zWN0HdfCyD8i3MV117lFi4r2FMf+quedBWdDSVS8I+65r12w4ChQUptoRdN+K55vFLNwGwhTj3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KdfkLWm0; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768426019; x=1799962019;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o5b27HopzzqbxoRQ+swulM0LrWo6LqlQwDn0miCkCNo=;
  b=KdfkLWm0wq7RKCAOin9mzR0U5/fZltFJTBrA5rkJmywO1AdEzrwuwQd5
   SK7ZETCb2F7w4d7nxSpWesz3SxDKTv+GntheK+hNskfq21e6PsgnOQSr9
   0x9IOUmIYCG1/r8BSX+j23OdZ1SzD7SGVJfeP9sI89zsA92DUEkgbt65e
   OhepOnRxSRgo9uo18qwj0sSva29NI1BOeV5ZlWz4AE/P9t9kpD/m73cta
   HlXya5CJoxKQc+y1uamBJazRO7CFMyMsk0rKCs01jztGDr1qkxpl7ri9P
   hdj9U82M83J4Z9/HqJe42woxVKpDR4YNGqeavHUEy9+tOn54Ny2xUx4r4
   Q==;
X-CSE-ConnectionGUID: tfZWCuOGSeKaZfyhVARz0g==
X-CSE-MsgGUID: M8p+lwpxT2aeessVqX7hkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="81179029"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="81179029"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 13:26:59 -0800
X-CSE-ConnectionGUID: IcP3sTStRxOCxFlU1ka7xA==
X-CSE-MsgGUID: bRfNHXsIQya/mD4eVHzl7Q==
X-ExtLoop1: 1
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.111.5]) ([10.125.111.5])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 13:26:57 -0800
Message-ID: <cfb643d3-4434-4909-95d0-2ef744458684@intel.com>
Date: Wed, 14 Jan 2026 14:26:56 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 19/34] cxl/port: Fix devm resource leaks around with
 dport management
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, vishal.l.verma@intel.com, alucerop@amd.com,
 ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-20-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260114182055.46029-20-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/14/26 11:20 AM, Terry Bowman wrote:
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

Missing sign off tag

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> 
> Changes in v13 -> v14:
> - New patch
> ---
>  drivers/cxl/acpi.c                   |  11 +-
>  drivers/cxl/core/pci.c               |  10 +-
>  drivers/cxl/core/port.c              | 225 ++++++++++++++++-----------
>  drivers/cxl/cxl.h                    |  23 +--
>  drivers/cxl/port.c                   |   8 +-
>  tools/testing/cxl/Kbuild             |   3 +-
>  tools/testing/cxl/cxl_core_exports.c |  13 +-
>  tools/testing/cxl/exports.h          |   4 +-
>  tools/testing/cxl/test/cxl.c         |   6 +-
>  tools/testing/cxl/test/mock.c        |  25 ++-
>  tools/testing/cxl/test/mock.h        |   4 +-
>  11 files changed, 188 insertions(+), 144 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 77ac940e3013..1e1383eb9bd5 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -679,16 +679,19 @@ static int add_host_bridge_dport(struct device *match, void *arg)
>  	if (ctx.cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11) {
>  		dev_dbg(match, "RCRB found for UID %lld: %pa\n", ctx.uid,
>  			&ctx.base);
> -		dport = devm_cxl_add_rch_dport(root_port, bridge, ctx.uid,
> -					       ctx.base);
> +		dport = cxl_add_rch_dport(root_port, bridge, ctx.uid, ctx.base);
>  	} else {
> -		dport = devm_cxl_add_dport(root_port, bridge, ctx.uid,
> -					   CXL_RESOURCE_NONE);
> +		dport = cxl_add_dport(root_port, bridge, ctx.uid,
> +				      CXL_RESOURCE_NONE);
>  	}
>  
>  	if (IS_ERR(dport))
>  		return PTR_ERR(dport);
>  
> +	ret = cxl_dport_autoremove(dport);
> +	if (ret)
> +		return ret;
> +
>  	ret = get_genport_coordinates(match, dport);
>  	if (ret)
>  		dev_dbg(match, "Failed to get generic port perf coordinates.\n");
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 0305a421504e..512a3e29a095 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -41,14 +41,14 @@ static int pci_get_port_num(struct pci_dev *pdev)
>  }
>  
>  /**
> - * __devm_cxl_add_dport_by_dev - allocate a dport by dport device
> + * __cxl_add_dport_by_dev - allocate a dport by dport device
>   * @port: cxl_port that hosts the dport
>   * @dport_dev: 'struct device' of the dport
>   *
>   * Returns the allocated dport on success or ERR_PTR() of -errno on error
>   */
> -struct cxl_dport *__devm_cxl_add_dport_by_dev(struct cxl_port *port,
> -					      struct device *dport_dev)
> +struct cxl_dport *__cxl_add_dport_by_dev(struct cxl_port *port,
> +					 struct device *dport_dev)
>  {
>  	struct cxl_register_map map;
>  	struct pci_dev *pdev;
> @@ -67,9 +67,9 @@ struct cxl_dport *__devm_cxl_add_dport_by_dev(struct cxl_port *port,
>  		return ERR_PTR(rc);
>  
>  	device_lock_assert(&port->dev);
> -	return devm_cxl_add_dport(port, dport_dev, port_num, map.resource);
> +	return cxl_add_dport(port, dport_dev, port_num, map.resource);
>  }
> -EXPORT_SYMBOL_NS_GPL(__devm_cxl_add_dport_by_dev, "CXL");
> +EXPORT_SYMBOL_NS_GPL(__cxl_add_dport_by_dev, "CXL");
>  
>  struct cxl_walk_context {
>  	struct pci_bus *bus;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index fef3aa0c6680..a05a1812bb6e 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1051,7 +1051,8 @@ static struct cxl_dport *find_dport(struct cxl_port *port, int id)
>  	return NULL;
>  }
>  
> -static int add_dport(struct cxl_port *port, struct cxl_dport *dport)
> +static struct cxl_dport *add_dport(struct cxl_port *port,
> +				   struct cxl_dport *dport)
>  {
>  	struct cxl_dport *dup;
>  	int rc;
> @@ -1063,16 +1064,33 @@ static int add_dport(struct cxl_port *port, struct cxl_dport *dport)
>  			"unable to add dport%d-%s non-unique port id (%s)\n",
>  			dport->port_id, dev_name(dport->dport_dev),
>  			dev_name(dup->dport_dev));
> -		return -EBUSY;
> +		return ERR_PTR(-EBUSY);
> +	}
> +
> +	/*
> +	 * Unlike CXL switch upstream ports where it can train a CXL link
> +	 * independent of its downstream ports, a host bridge upstream port may
> +	 * not enable CXL registers until at least one downstream port (root
> +	 * port) trains CXL. Enumerate registers once when the number of dports
> +	 * transitions from zero to one.
> +	 */
> +	if (!port->nr_dports) {
> +		rc = cxl_port_setup_regs(port, port->component_reg_phys);
> +		if (rc)
> +			return ERR_PTR(rc);
>  	}
>  
> +	/* Arrange for dport_dev to be valid through remove_dport() */
> +	struct device *dev __free(put_device) = get_device(dport->dport_dev);
> +
>  	rc = xa_insert(&port->dports, (unsigned long)dport->dport_dev, dport,
>  		       GFP_KERNEL);
>  	if (rc)
> -		return rc;
> +		return ERR_PTR(rc);
>  
> +	retain_and_null_ptr(dev);
>  	port->nr_dports++;
> -	return 0;
> +	return dport;
>  }
>  
>  /*
> @@ -1094,51 +1112,32 @@ static void cond_cxl_root_unlock(struct cxl_port *port)
>  		device_unlock(&port->dev);
>  }
>  
> -static void cxl_dport_remove(void *data)
> +static void remove_dport(struct cxl_dport *dport)
>  {
> -	struct cxl_dport *dport = data;
>  	struct cxl_port *port = dport->port;
>  
> +	port->nr_dports--;
>  	xa_erase(&port->dports, (unsigned long) dport->dport_dev);
>  	put_device(dport->dport_dev);
>  }
>  
> -static void cxl_dport_unlink(void *data)
> -{
> -	struct cxl_dport *dport = data;
> -	struct cxl_port *port = dport->port;
> -	char link_name[CXL_TARGET_STRLEN];
> +DEFINE_FREE(remove_dport, struct cxl_dport *,
> +	if (!IS_ERR_OR_NULL(_T)) remove_dport(_T))
>  
> -	sprintf(link_name, "dport%d", dport->port_id);
> -	sysfs_remove_link(&port->dev.kobj, link_name);
> -}
> -
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
>  
>  /**
> - * devm_cxl_add_dport - append VH downstream port data to a cxl_port
> + * cxl_add_dport - append VH downstream port data to a cxl_port
>   * @port: the cxl_port that references this dport
>   * @dport_dev: firmware or PCI device representing the dport
>   * @port_id: identifier for this dport in a decoder's target list
> @@ -1227,14 +1205,13 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>   * either the port's host (for root ports), or the port itself (for
>   * switch ports)
>   */
> -struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
> -				     struct device *dport_dev, int port_id,
> -				     resource_size_t component_reg_phys)
> +struct cxl_dport *cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
> +				int port_id, resource_size_t component_reg_phys)
>  {
>  	struct cxl_dport *dport;
>  
> -	dport = __devm_cxl_add_dport(port, dport_dev, port_id,
> -				     component_reg_phys, CXL_RESOURCE_NONE);
> +	dport = __cxl_add_dport(port, dport_dev, port_id, component_reg_phys,
> +				CXL_RESOURCE_NONE);
>  	if (IS_ERR(dport)) {
>  		dev_dbg(dport_dev, "failed to add dport to %s: %ld\n",
>  			dev_name(&port->dev), PTR_ERR(dport));
> @@ -1245,10 +1222,10 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
>  
>  	return dport;
>  }
> -EXPORT_SYMBOL_NS_GPL(devm_cxl_add_dport, "CXL");
> +EXPORT_SYMBOL_NS_GPL(cxl_add_dport, "CXL");
>  
>  /**
> - * devm_cxl_add_rch_dport - append RCH downstream port data to a cxl_port
> + * cxl_add_rch_dport - append RCH downstream port data to a cxl_port
>   * @port: the cxl_port that references this dport
>   * @dport_dev: firmware or PCI device representing the dport
>   * @port_id: identifier for this dport in a decoder's target list
> @@ -1256,9 +1233,9 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_add_dport, "CXL");
>   *
>   * See CXL 3.0 9.11.8 CXL Devices Attached to an RCH
>   */
> -struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
> -					 struct device *dport_dev, int port_id,
> -					 resource_size_t rcrb)
> +struct cxl_dport *cxl_add_rch_dport(struct cxl_port *port,
> +				    struct device *dport_dev, int port_id,
> +				    resource_size_t rcrb)
>  {
>  	struct cxl_dport *dport;
>  
> @@ -1267,8 +1244,8 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> -	dport = __devm_cxl_add_dport(port, dport_dev, port_id,
> -				     CXL_RESOURCE_NONE, rcrb);
> +	dport = __cxl_add_dport(port, dport_dev, port_id, CXL_RESOURCE_NONE,
> +				rcrb);
>  	if (IS_ERR(dport)) {
>  		dev_dbg(dport_dev, "failed to add RCH dport to %s: %ld\n",
>  			dev_name(&port->dev), PTR_ERR(dport));
> @@ -1279,7 +1256,7 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>  
>  	return dport;
>  }
> -EXPORT_SYMBOL_NS_GPL(devm_cxl_add_rch_dport, "CXL");
> +EXPORT_SYMBOL_NS_GPL(cxl_add_rch_dport, "CXL");
>  
>  static int add_ep(struct cxl_ep *new)
>  {
> @@ -1439,13 +1416,42 @@ static void delete_switch_port(struct cxl_port *port)
>  	devm_release_action(port->dev.parent, unregister_port, port);
>  }
>  
> +static void unlink_dport(void *data)
> +{
> +	struct cxl_dport *dport = data;
> +	struct cxl_port *port = dport->port;
> +	char link_name[CXL_TARGET_STRLEN];
> +
> +	sprintf(link_name, "dport%d", dport->port_id);
> +	sysfs_remove_link(&port->dev.kobj, link_name);
> +	remove_dport(dport);
> +	kfree(dport);
> +}
> +
> +int cxl_dport_autoremove(struct cxl_dport *dport)
> +{
> +	struct cxl_port *port = dport->port;
> +	struct device *host;
> +
> +	if (is_cxl_root(port))
> +		host = port->uport_dev;
> +	else
> +		host = &port->dev;
> +
> +	return devm_add_action_or_reset(host, unlink_dport, dport);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dport_autoremove, "CXL");
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
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 6f3741a57932..47ee06c95433 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -796,12 +796,12 @@ struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
>  				   struct cxl_dport **dport);
>  bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd);
>  
> -struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
> -				     struct device *dport, int port_id,
> -				     resource_size_t component_reg_phys);
> -struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
> -					 struct device *dport_dev, int port_id,
> -					 resource_size_t rcrb);
> +struct cxl_dport *cxl_add_dport(struct cxl_port *port, struct device *dport,
> +				int port_id,
> +				resource_size_t component_reg_phys);
> +struct cxl_dport *cxl_add_rch_dport(struct cxl_port *port,
> +				    struct device *dport_dev, int port_id,
> +				    resource_size_t rcrb);
>  
>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
>  struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
> @@ -824,6 +824,7 @@ static inline int cxl_root_decoder_autoremove(struct device *host,
>  	return cxl_decoder_autoremove(host, &cxlrd->cxlsd.cxld);
>  }
>  int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
> +int cxl_dport_autoremove(struct cxl_dport *dport);
>  
>  /**
>   * struct cxl_endpoint_dvsec_info - Cached DVSEC info
> @@ -937,10 +938,10 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  			     struct access_coordinate *c2);
>  
>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
> -struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
> -					    struct device *dport_dev);
> -struct cxl_dport *__devm_cxl_add_dport_by_dev(struct cxl_port *port,
> -					      struct device *dport_dev);
> +struct cxl_dport *cxl_add_dport_by_dev(struct cxl_port *port,
> +				       struct device *dport_dev);
> +struct cxl_dport *__cxl_add_dport_by_dev(struct cxl_port *port,
> +					 struct device *dport_dev);
>  
>  /*
>   * Unit test builds overrides this to __weak, find the 'strong' version
> @@ -964,7 +965,7 @@ u16 cxl_gpf_get_dvsec(struct device *dev);
>   */
>  #ifndef CXL_TEST_ENABLE
>  #define DECLARE_TESTABLE(x) __##x
> -#define devm_cxl_add_dport_by_dev DECLARE_TESTABLE(devm_cxl_add_dport_by_dev)
> +#define cxl_add_dport_by_dev DECLARE_TESTABLE(cxl_add_dport_by_dev)
>  #define devm_cxl_switch_port_decoders_setup DECLARE_TESTABLE(devm_cxl_switch_port_decoders_setup)
>  #endif
>  
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 51c8f2f84717..167cc0a87484 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -59,8 +59,12 @@ static int discover_region(struct device *dev, void *unused)
>  
>  static int cxl_switch_port_probe(struct cxl_port *port)
>  {
> -	/* Reset nr_dports for rebind of driver */
> -	port->nr_dports = 0;
> +	/*
> +	 * Unfortunately, typical driver operations like "find and map
> +	 * registers", can not be done at port device attach time and must wait
> +	 * for dport arrival. See cxl_port_add_dport() and the comments in
> +	 * add_dport() for details.
> +	 */
>  
>  	/* Cache the data early to ensure is_visible() works */
>  	read_cdat_data(port);
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 6eceefefb0e0..4d740392aac5 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -5,7 +5,8 @@ ldflags-y += --wrap=acpi_evaluate_integer
>  ldflags-y += --wrap=acpi_pci_find_root
>  ldflags-y += --wrap=nvdimm_bus_register
>  ldflags-y += --wrap=cxl_await_media_ready
> -ldflags-y += --wrap=devm_cxl_add_rch_dport
> +ldflags-y += --wrap=cxl_add_rch_dport
> +ldflags-y += --wrap=cxl_rcd_component_reg_phys
>  ldflags-y += --wrap=cxl_endpoint_parse_cdat
>  ldflags-y += --wrap=cxl_dport_init_ras_reporting
>  ldflags-y += --wrap=devm_cxl_endpoint_decoders_setup
> diff --git a/tools/testing/cxl/cxl_core_exports.c b/tools/testing/cxl/cxl_core_exports.c
> index 6754de35598d..02d479867a12 100644
> --- a/tools/testing/cxl/cxl_core_exports.c
> +++ b/tools/testing/cxl/cxl_core_exports.c
> @@ -7,16 +7,15 @@
>  /* Exporting of cxl_core symbols that are only used by cxl_test */
>  EXPORT_SYMBOL_NS_GPL(cxl_num_decoders_committed, "CXL");
>  
> -cxl_add_dport_by_dev_fn _devm_cxl_add_dport_by_dev =
> -	__devm_cxl_add_dport_by_dev;
> -EXPORT_SYMBOL_NS_GPL(_devm_cxl_add_dport_by_dev, "CXL");
> +cxl_add_dport_by_dev_fn _cxl_add_dport_by_dev = __cxl_add_dport_by_dev;
> +EXPORT_SYMBOL_NS_GPL(_cxl_add_dport_by_dev, "CXL");
>  
> -struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
> -					    struct device *dport_dev)
> +struct cxl_dport *cxl_add_dport_by_dev(struct cxl_port *port,
> +				       struct device *dport_dev)
>  {
> -	return _devm_cxl_add_dport_by_dev(port, dport_dev);
> +	return _cxl_add_dport_by_dev(port, dport_dev);
>  }
> -EXPORT_SYMBOL_NS_GPL(devm_cxl_add_dport_by_dev, "CXL");
> +EXPORT_SYMBOL_NS_GPL(cxl_add_dport_by_dev, "CXL");
>  
>  cxl_switch_decoders_setup_fn _devm_cxl_switch_port_decoders_setup =
>  	__devm_cxl_switch_port_decoders_setup;
> diff --git a/tools/testing/cxl/exports.h b/tools/testing/cxl/exports.h
> index 7ebee7c0bd67..cbb16073be18 100644
> --- a/tools/testing/cxl/exports.h
> +++ b/tools/testing/cxl/exports.h
> @@ -4,8 +4,8 @@
>  #define __MOCK_CXL_EXPORTS_H_
>  
>  typedef struct cxl_dport *(*cxl_add_dport_by_dev_fn)(struct cxl_port *port,
> -							  struct device *dport_dev);
> -extern cxl_add_dport_by_dev_fn _devm_cxl_add_dport_by_dev;
> +						     struct device *dport_dev);
> +extern cxl_add_dport_by_dev_fn _cxl_add_dport_by_dev;
>  
>  typedef int(*cxl_switch_decoders_setup_fn)(struct cxl_port *port);
>  extern cxl_switch_decoders_setup_fn _devm_cxl_switch_port_decoders_setup;
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 81e2aef3627a..b7a2b550c0b0 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1060,8 +1060,8 @@ static struct cxl_dport *mock_cxl_add_dport_by_dev(struct cxl_port *port,
>  		if (&pdev->dev != dport_dev)
>  			continue;
>  
> -		return devm_cxl_add_dport(port, &pdev->dev, pdev->id,
> -					  CXL_RESOURCE_NONE);
> +		return cxl_add_dport(port, &pdev->dev, pdev->id,
> +				     CXL_RESOURCE_NONE);
>  	}
>  
>  	return ERR_PTR(-ENODEV);
> @@ -1126,9 +1126,9 @@ static struct cxl_mock_ops cxl_mock_ops = {
>  	.devm_cxl_switch_port_decoders_setup = mock_cxl_switch_port_decoders_setup,
>  	.devm_cxl_endpoint_decoders_setup = mock_cxl_endpoint_decoders_setup,
>  	.cxl_endpoint_parse_cdat = mock_cxl_endpoint_parse_cdat,
> -	.devm_cxl_add_dport_by_dev = mock_cxl_add_dport_by_dev,
>  	.hmat_get_extended_linear_cache_size =
>  		mock_hmat_get_extended_linear_cache_size,
> +	.cxl_add_dport_by_dev = mock_cxl_add_dport_by_dev,
>  	.list = LIST_HEAD_INIT(cxl_mock_ops.list),
>  };
>  
> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> index 44bce80ef3ff..660e8402189c 100644
> --- a/tools/testing/cxl/test/mock.c
> +++ b/tools/testing/cxl/test/mock.c
> @@ -15,14 +15,13 @@
>  static LIST_HEAD(mock);
>  
>  static struct cxl_dport *
> -redirect_devm_cxl_add_dport_by_dev(struct cxl_port *port,
> -				   struct device *dport_dev);
> +redirect_cxl_add_dport_by_dev(struct cxl_port *port, struct device *dport_dev);
>  static int redirect_devm_cxl_switch_port_decoders_setup(struct cxl_port *port);
>  
>  void register_cxl_mock_ops(struct cxl_mock_ops *ops)
>  {
>  	list_add_rcu(&ops->list, &mock);
> -	_devm_cxl_add_dport_by_dev = redirect_devm_cxl_add_dport_by_dev;
> +	_cxl_add_dport_by_dev = redirect_cxl_add_dport_by_dev;
>  	_devm_cxl_switch_port_decoders_setup =
>  		redirect_devm_cxl_switch_port_decoders_setup;
>  }
> @@ -34,7 +33,7 @@ void unregister_cxl_mock_ops(struct cxl_mock_ops *ops)
>  {
>  	_devm_cxl_switch_port_decoders_setup =
>  		__devm_cxl_switch_port_decoders_setup;
> -	_devm_cxl_add_dport_by_dev = __devm_cxl_add_dport_by_dev;
> +	_cxl_add_dport_by_dev = __cxl_add_dport_by_dev;
>  	list_del_rcu(&ops->list);
>  	synchronize_srcu(&cxl_mock_srcu);
>  }
> @@ -207,7 +206,7 @@ int __wrap_cxl_await_media_ready(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(__wrap_cxl_await_media_ready, "CXL");
>  
> -struct cxl_dport *__wrap_devm_cxl_add_rch_dport(struct cxl_port *port,
> +struct cxl_dport *__wrap_cxl_add_rch_dport(struct cxl_port *port,
>  						struct device *dport_dev,
>  						int port_id,
>  						resource_size_t rcrb)
> @@ -217,19 +216,19 @@ struct cxl_dport *__wrap_devm_cxl_add_rch_dport(struct cxl_port *port,
>  	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
>  
>  	if (ops && ops->is_mock_port(dport_dev)) {
> -		dport = devm_cxl_add_dport(port, dport_dev, port_id,
> -					   CXL_RESOURCE_NONE);
> +		dport = cxl_add_dport(port, dport_dev, port_id,
> +				      CXL_RESOURCE_NONE);
>  		if (!IS_ERR(dport)) {
>  			dport->rcrb.base = rcrb;
>  			dport->rch = true;
>  		}
>  	} else
> -		dport = devm_cxl_add_rch_dport(port, dport_dev, port_id, rcrb);
> +		dport = cxl_add_rch_dport(port, dport_dev, port_id, rcrb);
>  	put_cxl_mock_ops(index);
>  
>  	return dport;
>  }
> -EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_add_rch_dport, "CXL");
> +EXPORT_SYMBOL_NS_GPL(__wrap_cxl_add_rch_dport, "CXL");
>  
>  void __wrap_cxl_endpoint_parse_cdat(struct cxl_port *port)
>  {
> @@ -257,17 +256,17 @@ void __wrap_cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device
>  }
>  EXPORT_SYMBOL_NS_GPL(__wrap_cxl_dport_init_ras_reporting, "CXL");
>  
> -struct cxl_dport *redirect_devm_cxl_add_dport_by_dev(struct cxl_port *port,
> -						     struct device *dport_dev)
> +struct cxl_dport *redirect_cxl_add_dport_by_dev(struct cxl_port *port,
> +						struct device *dport_dev)
>  {
>  	int index;
>  	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
>  	struct cxl_dport *dport;
>  
>  	if (ops && ops->is_mock_port(port->uport_dev))
> -		dport = ops->devm_cxl_add_dport_by_dev(port, dport_dev);
> +		dport = ops->cxl_add_dport_by_dev(port, dport_dev);
>  	else
> -		dport = __devm_cxl_add_dport_by_dev(port, dport_dev);
> +		dport = __cxl_add_dport_by_dev(port, dport_dev);
>  	put_cxl_mock_ops(index);
>  
>  	return dport;
> diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
> index 2684b89c8aa2..fa13aca4e260 100644
> --- a/tools/testing/cxl/test/mock.h
> +++ b/tools/testing/cxl/test/mock.h
> @@ -22,8 +22,8 @@ struct cxl_mock_ops {
>  	int (*devm_cxl_switch_port_decoders_setup)(struct cxl_port *port);
>  	int (*devm_cxl_endpoint_decoders_setup)(struct cxl_port *port);
>  	void (*cxl_endpoint_parse_cdat)(struct cxl_port *port);
> -	struct cxl_dport *(*devm_cxl_add_dport_by_dev)(struct cxl_port *port,
> -						       struct device *dport_dev);
> +	struct cxl_dport *(*cxl_add_dport_by_dev)(struct cxl_port *port,
> +						  struct device *dport_dev);
>  	int (*hmat_get_extended_linear_cache_size)(struct resource *backing_res,
>  						   int nid,
>  						   resource_size_t *cache_size);


