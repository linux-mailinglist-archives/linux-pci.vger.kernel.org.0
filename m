Return-Path: <linux-pci+bounces-44870-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE76D216FD
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 22:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E4AB1301A309
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 21:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4E83A1E73;
	Wed, 14 Jan 2026 21:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bWj9YpVI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9153A1D1E;
	Wed, 14 Jan 2026 21:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768427200; cv=none; b=qfUY/E6bv3FdboNzGZi9BNnIkujOLNgJp6kK3PepAuoSGHpcpOFA1yNTlM1Za86ojk5AeG+tY9L23bBT9xDhxn3BSupxvUhf/WjQMTal2IEQ/7D+yOO1rsTChfsVpg6kPcu5HqMLls9xteOOL194hh8XHCxiQ1+XnNnS90Q7OcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768427200; c=relaxed/simple;
	bh=EbBdf286FEodTpbXYGYzgJ4EEypXrEmNLqgby+LXs+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MrzdrR6B1CJM7607QkJWNcnp+71BUA3eM7gyni0TPWoWPeG2UUaqtGkamuDvzgPkYP7QkhSTDvym+YDxYo7rQDmquSbYHh305l/Yb2zKT7Nk+tmTXk4lrmRXZHfmNZ6iQf3pjjTK2w/2nBHXvw5Qej9UDSG84sqdUGyuSSA8VcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bWj9YpVI; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768427172; x=1799963172;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EbBdf286FEodTpbXYGYzgJ4EEypXrEmNLqgby+LXs+A=;
  b=bWj9YpVIXX9Pq2244re+Ir0esrPQr8hShQdnzzx5vcPXnGZ5ZFMwhsUN
   kD3j5lwSBqMOsw7e175B19UZXe9T7CVBG2iug/dZIxBRvrBIRTpDJ3ffB
   LHQwI5t6wKpYZ5K3afwDRSXJkfIcy46VK41MoJQM4Ho0tGVPxW1XAv+qA
   pi5GUxatrGB2E3bE/I4BrWSVsEOkVUCU+LJOelh2f99e7G2EJVo8hy2el
   vHHwwAkUo+aBZfkwCfgTUrDPDtMpUT5BXvKh+KTNuLyJdn1Lokrm35C2M
   btLQwxBSPwmoaHLo07qQo6xSuPYxFPjWU2XuLMN50J/hS0fNb8GNqIo/X
   A==;
X-CSE-ConnectionGUID: Vn5QF39STAq3SwiA+3HSYA==
X-CSE-MsgGUID: uQT2X07BR9WhR0jo7R1hIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69901671"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="69901671"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 13:46:03 -0800
X-CSE-ConnectionGUID: uZKeXffNSuqSeut1+ibQ/Q==
X-CSE-MsgGUID: mJs+osODTCq4wbqF7Z3tKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="209251337"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.111.5]) ([10.125.111.5])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 13:46:00 -0800
Message-ID: <0490d2d1-9583-44d6-9a4b-115bdf36f98b@intel.com>
Date: Wed, 14 Jan 2026 14:45:59 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 20/34] cxl/port: Move dport operations to a driver
 event
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
 <20260114182055.46029-21-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260114182055.46029-21-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/14/26 11:20 AM, Terry Bowman wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> 
> In preparation for adding more register setup to the cxl_port_add_dport()
> path (for RAS register mapping), move the dport creation event to a driver
> callback. This achieves 2 things it puts driver operations logically where
> they belong, in a driver, and it obviates the gymnastics of
> DECLARE_TESTABLE() which just makes a mess of grepping for CXL symbols.
> 
> In other words, a driver callback is less of an ongoing maintenance burden
> than this DECLARE_TESTABLE arrangement that does not scale and diminishes
> the grep-ability of the codebase.
> 
> cxl_port_add_dport() moves mostly unmodified from drivers/cxl/core/port.c.
> The only deliberate change is that it now assumes that the device_lock is
> held on entry and the driver is attached (just like cxl_port_probe()).
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Terry Bowman <terry.bowman@amd.com>

Missing sign off

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> 
> Changes in v13 -> v14:
> - New patch
> ---
>  drivers/cxl/core/hdm.c               |  6 +--
>  drivers/cxl/core/pci.c               |  8 +--
>  drivers/cxl/core/port.c              | 79 ++++++----------------------
>  drivers/cxl/cxl.h                    | 23 ++------
>  drivers/cxl/port.c                   | 71 +++++++++++++++++++++++++
>  tools/testing/cxl/Kbuild             |  2 +
>  tools/testing/cxl/cxl_core_exports.c | 21 --------
>  tools/testing/cxl/exports.h          | 13 -----
>  tools/testing/cxl/test/mock.c        | 23 +++-----
>  9 files changed, 107 insertions(+), 139 deletions(-)
>  delete mode 100644 tools/testing/cxl/exports.h
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 1c5d2022c87a..365b02b7a241 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -1219,12 +1219,12 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>  }
>  
>  /**
> - * __devm_cxl_switch_port_decoders_setup - allocate and setup switch decoders
> + * devm_cxl_switch_port_decoders_setup - allocate and setup switch decoders
>   * @port: CXL port context
>   *
>   * Return 0 or -errno on error
>   */
> -int __devm_cxl_switch_port_decoders_setup(struct cxl_port *port)
> +int devm_cxl_switch_port_decoders_setup(struct cxl_port *port)
>  {
>  	struct cxl_hdm *cxlhdm;
>  
> @@ -1248,7 +1248,7 @@ int __devm_cxl_switch_port_decoders_setup(struct cxl_port *port)
>  	dev_err(&port->dev, "HDM decoder capability not found\n");
>  	return -ENXIO;
>  }
> -EXPORT_SYMBOL_NS_GPL(__devm_cxl_switch_port_decoders_setup, "CXL");
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_switch_port_decoders_setup, "CXL");
>  
>  /**
>   * devm_cxl_endpoint_decoders_setup - allocate and setup endpoint decoders
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 512a3e29a095..8633bfdef38d 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -41,14 +41,14 @@ static int pci_get_port_num(struct pci_dev *pdev)
>  }
>  
>  /**
> - * __cxl_add_dport_by_dev - allocate a dport by dport device
> + * cxl_add_dport_by_dev - allocate a dport by dport device
>   * @port: cxl_port that hosts the dport
>   * @dport_dev: 'struct device' of the dport
>   *
>   * Returns the allocated dport on success or ERR_PTR() of -errno on error
>   */
> -struct cxl_dport *__cxl_add_dport_by_dev(struct cxl_port *port,
> -					 struct device *dport_dev)
> +struct cxl_dport *cxl_add_dport_by_dev(struct cxl_port *port,
> +				       struct device *dport_dev)
>  {
>  	struct cxl_register_map map;
>  	struct pci_dev *pdev;
> @@ -69,7 +69,7 @@ struct cxl_dport *__cxl_add_dport_by_dev(struct cxl_port *port,
>  	device_lock_assert(&port->dev);
>  	return cxl_add_dport(port, dport_dev, port_num, map.resource);
>  }
> -EXPORT_SYMBOL_NS_GPL(__cxl_add_dport_by_dev, "CXL");
> +EXPORT_SYMBOL_NS_GPL(cxl_add_dport_by_dev, "CXL");
>  
>  struct cxl_walk_context {
>  	struct pci_bus *bus;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index a05a1812bb6e..2184c20af011 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1603,78 +1603,31 @@ static int update_decoder_targets(struct device *dev, void *data)
>  	return 0;
>  }
>  
> -static struct cxl_port *cxl_port_devres_group(struct cxl_port *port)
> +void cxl_port_update_decoder_targets(struct cxl_port *port,
> +				     struct cxl_dport *dport)
>  {
> -	if (!devres_open_group(&port->dev, port, GFP_KERNEL))
> -		return ERR_PTR(-ENOMEM);
> -	return port;
> +	device_for_each_child(&port->dev, dport, update_decoder_targets);
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_port_update_decoder_targets, "CXL");
> +
>  DEFINE_FREE(cxl_port_group_free, struct cxl_port *,
>  	if (!IS_ERR_OR_NULL(_T)) devres_release_group(&(_T)->dev, _T))
>  
> -static void cxl_port_group_close(struct cxl_port *port)
> -{
> -	devres_remove_group(&port->dev, port);
> -}
> -
> -static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
> -					    struct device *dport_dev)
> +static struct cxl_dport *probe_dport(struct cxl_port *port,
> +				     struct device *dport_dev)
>  {
> -	struct cxl_dport *new_dport;
> -	struct cxl_dport *dport;
> -	int rc;
> +	struct cxl_driver *drv;
>  
>  	device_lock_assert(&port->dev);
>  	if (!port->dev.driver)
>  		return ERR_PTR(-ENXIO);
>  
> -	dport = cxl_find_dport_by_dev(port, dport_dev);
> -	if (dport) {
> -		dev_dbg(&port->dev, "dport%d:%s already exists\n",
> -			dport->port_id, dev_name(dport_dev));
> -		return ERR_PTR(-EBUSY);
> -	}
> -
> -	/*
> -	 * With the first dport arrival it is now safe to start looking at
> -	 * component registers. Be careful to not strand resources if dport
> -	 * creation ultimately fails.
> -	 */
> -	struct cxl_port *port_group __free(cxl_port_group_free) =
> -		cxl_port_devres_group(port);
> -	if (IS_ERR(port_group))
> -		return ERR_CAST(port_group);
> -
> -	if (port->nr_dports == 0) {
> -		rc = devm_cxl_switch_port_decoders_setup(port);
> -		if (rc)
> -			return ERR_PTR(rc);
> -		/*
> -		 * Note, when nr_dports returns to zero the port is unregistered
> -		 * and triggers cleanup. I.e. no need for open-coded release
> -		 * action on dport removal. See cxl_detach_ep() for that logic.
> -		 */
> -	}
> -
> -	new_dport = cxl_add_dport_by_dev(port, dport_dev);
> -	if (IS_ERR(new_dport))
> -		return new_dport;
> -
> -	rc = cxl_dport_autoremove(new_dport);
> -	if (rc)
> -		return ERR_PTR(rc);
> -
> -	cxl_switch_parse_cdat(new_dport);
> -
> -	cxl_port_group_close(no_free_ptr(port_group));
> -
> -	dev_dbg(&port->dev, "dport[%d] id:%d dport_dev: %s added\n",
> -		port->nr_dports - 1, new_dport->port_id, dev_name(dport_dev));
> -
> -	/* New dport added, update the decoder targets */
> -	device_for_each_child(&port->dev, new_dport, update_decoder_targets);
> +	drv = container_of(port->dev.driver, struct cxl_driver, drv);
> +	if (!drv->add_dport)
> +		return ERR_PTR(-ENXIO);
>  
> -	return new_dport;
> +	/* see cxl_port_add_dport() */
> +	return drv->add_dport(port, dport_dev);
>  }
>  
>  static struct cxl_dport *devm_cxl_create_port(struct device *ep_dev,
> @@ -1721,7 +1674,7 @@ static struct cxl_dport *devm_cxl_create_port(struct device *ep_dev,
>  	}
>  
>  	guard(device)(&port->dev);
> -	return cxl_port_add_dport(port, dport_dev);
> +	return probe_dport(port, dport_dev);
>  }
>  
>  static int add_port_attach_ep(struct cxl_memdev *cxlmd,
> @@ -1753,7 +1706,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  	scoped_guard(device, &parent_port->dev) {
>  		parent_dport = cxl_find_dport_by_dev(parent_port, dparent);
>  		if (!parent_dport) {
> -			parent_dport = cxl_port_add_dport(parent_port, dparent);
> +			parent_dport = probe_dport(parent_port, dparent);
>  			if (IS_ERR(parent_dport))
>  				return PTR_ERR(parent_dport);
>  		}
> @@ -1789,7 +1742,7 @@ static struct cxl_dport *find_or_add_dport(struct cxl_port *port,
>  	device_lock_assert(&port->dev);
>  	dport = cxl_find_dport_by_dev(port, dport_dev);
>  	if (!dport) {
> -		dport = cxl_port_add_dport(port, dport_dev);
> +		dport = probe_dport(port, dport_dev);
>  		if (IS_ERR(dport))
>  			return dport;
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 47ee06c95433..46491046f101 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -841,8 +841,9 @@ struct cxl_endpoint_dvsec_info {
>  };
>  
>  int devm_cxl_switch_port_decoders_setup(struct cxl_port *port);
> -int __devm_cxl_switch_port_decoders_setup(struct cxl_port *port);
>  int devm_cxl_endpoint_decoders_setup(struct cxl_port *port);
> +void cxl_port_update_decoder_targets(struct cxl_port *port,
> +				     struct cxl_dport *dport);
>  
>  struct cxl_dev_state;
>  int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
> @@ -856,6 +857,8 @@ struct cxl_driver {
>  	const char *name;
>  	int (*probe)(struct device *dev);
>  	void (*remove)(struct device *dev);
> +	struct cxl_dport *(*add_dport)(struct cxl_port *port,
> +				       struct device *dport_dev);
>  	struct device_driver drv;
>  	int id;
>  };
> @@ -940,8 +943,6 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
>  struct cxl_dport *cxl_add_dport_by_dev(struct cxl_port *port,
>  				       struct device *dport_dev);
> -struct cxl_dport *__cxl_add_dport_by_dev(struct cxl_port *port,
> -					 struct device *dport_dev);
>  
>  /*
>   * Unit test builds overrides this to __weak, find the 'strong' version
> @@ -953,20 +954,4 @@ struct cxl_dport *__cxl_add_dport_by_dev(struct cxl_port *port,
>  
>  u16 cxl_gpf_get_dvsec(struct device *dev);
>  
> -/*
> - * Declaration for functions that are mocked by cxl_test that are called by
> - * cxl_core. The respective functions are defined as __foo() and called by
> - * cxl_core as foo(). The macros below ensures that those functions would
> - * exist as foo(). See tools/testing/cxl/cxl_core_exports.c and
> - * tools/testing/cxl/exports.h for setting up the mock functions. The dance
> - * is done to avoid a circular dependency where cxl_core calls a function that
> - * ends up being a mock function and goes to * cxl_test where it calls a
> - * cxl_core function.
> - */
> -#ifndef CXL_TEST_ENABLE
> -#define DECLARE_TESTABLE(x) __##x
> -#define cxl_add_dport_by_dev DECLARE_TESTABLE(cxl_add_dport_by_dev)
> -#define devm_cxl_switch_port_decoders_setup DECLARE_TESTABLE(devm_cxl_switch_port_decoders_setup)
> -#endif
> -
>  #endif /* __CXL_H__ */
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 167cc0a87484..2770bc8520d3 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -155,9 +155,80 @@ static const struct attribute_group *cxl_port_attribute_groups[] = {
>  	NULL,
>  };
>  
> +static struct cxl_port *cxl_port_devres_group(struct cxl_port *port)
> +{
> +	if (!devres_open_group(&port->dev, port, GFP_KERNEL))
> +		return ERR_PTR(-ENOMEM);
> +	return port;
> +}
> +DEFINE_FREE(cxl_port_group_free, struct cxl_port *,
> +	    if (!IS_ERR_OR_NULL(_T)) devres_release_group(&(_T)->dev, _T))
> +
> +static void cxl_port_group_close(struct cxl_port *port)
> +{
> +	devres_remove_group(&port->dev, port);
> +}
> +
> +static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
> +					    struct device *dport_dev)
> +{
> +	struct cxl_dport *new_dport;
> +	struct cxl_dport *dport;
> +	int rc;
> +
> +	dport = cxl_find_dport_by_dev(port, dport_dev);
> +	if (dport) {
> +		dev_dbg(&port->dev, "dport%d:%s already exists\n",
> +			dport->port_id, dev_name(dport_dev));
> +		return ERR_PTR(-EBUSY);
> +	}
> +
> +	/*
> +	 * With the first dport arrival it is now safe to start looking at
> +	 * component registers. Be careful to not strand resources if dport
> +	 * creation ultimately fails.
> +	 */
> +	struct cxl_port *port_group __free(cxl_port_group_free) =
> +		cxl_port_devres_group(port);
> +	if (IS_ERR(port_group))
> +		return ERR_CAST(port_group);
> +
> +	if (port->nr_dports == 0) {
> +		rc = devm_cxl_switch_port_decoders_setup(port);
> +		if (rc)
> +			return ERR_PTR(rc);
> +		/*
> +		 * Note, when nr_dports returns to zero the port is unregistered
> +		 * and triggers cleanup. I.e. no need for open-coded release
> +		 * action on dport removal. See cxl_detach_ep() for that logic.
> +		 */
> +	}
> +
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
> +	/* New dport added, update the decoder targets */
> +	cxl_port_update_decoder_targets(port, new_dport);
> +
> +	return new_dport;
> +}
> +
>  static struct cxl_driver cxl_port_driver = {
>  	.name = "cxl_port",
>  	.probe = cxl_port_probe,
> +	.add_dport = cxl_port_add_dport,
>  	.id = CXL_DEVICE_PORT,
>  	.drv = {
>  		.dev_groups = cxl_port_attribute_groups,
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 4d740392aac5..25516728535e 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -11,6 +11,8 @@ ldflags-y += --wrap=cxl_endpoint_parse_cdat
>  ldflags-y += --wrap=cxl_dport_init_ras_reporting
>  ldflags-y += --wrap=devm_cxl_endpoint_decoders_setup
>  ldflags-y += --wrap=hmat_get_extended_linear_cache_size
> +ldflags-y += --wrap=cxl_add_dport_by_dev
> +ldflags-y += --wrap=devm_cxl_switch_port_decoders_setup
>  
>  DRIVERS := ../../../drivers
>  CXL_SRC := $(DRIVERS)/cxl
> diff --git a/tools/testing/cxl/cxl_core_exports.c b/tools/testing/cxl/cxl_core_exports.c
> index 02d479867a12..f088792a8925 100644
> --- a/tools/testing/cxl/cxl_core_exports.c
> +++ b/tools/testing/cxl/cxl_core_exports.c
> @@ -2,27 +2,6 @@
>  /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
>  
>  #include "cxl.h"
> -#include "exports.h"
>  
>  /* Exporting of cxl_core symbols that are only used by cxl_test */
>  EXPORT_SYMBOL_NS_GPL(cxl_num_decoders_committed, "CXL");
> -
> -cxl_add_dport_by_dev_fn _cxl_add_dport_by_dev = __cxl_add_dport_by_dev;
> -EXPORT_SYMBOL_NS_GPL(_cxl_add_dport_by_dev, "CXL");
> -
> -struct cxl_dport *cxl_add_dport_by_dev(struct cxl_port *port,
> -				       struct device *dport_dev)
> -{
> -	return _cxl_add_dport_by_dev(port, dport_dev);
> -}
> -EXPORT_SYMBOL_NS_GPL(cxl_add_dport_by_dev, "CXL");
> -
> -cxl_switch_decoders_setup_fn _devm_cxl_switch_port_decoders_setup =
> -	__devm_cxl_switch_port_decoders_setup;
> -EXPORT_SYMBOL_NS_GPL(_devm_cxl_switch_port_decoders_setup, "CXL");
> -
> -int devm_cxl_switch_port_decoders_setup(struct cxl_port *port)
> -{
> -	return _devm_cxl_switch_port_decoders_setup(port);
> -}
> -EXPORT_SYMBOL_NS_GPL(devm_cxl_switch_port_decoders_setup, "CXL");
> diff --git a/tools/testing/cxl/exports.h b/tools/testing/cxl/exports.h
> deleted file mode 100644
> index cbb16073be18..000000000000
> --- a/tools/testing/cxl/exports.h
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/* Copyright(c) 2025 Intel Corporation */
> -#ifndef __MOCK_CXL_EXPORTS_H_
> -#define __MOCK_CXL_EXPORTS_H_
> -
> -typedef struct cxl_dport *(*cxl_add_dport_by_dev_fn)(struct cxl_port *port,
> -						     struct device *dport_dev);
> -extern cxl_add_dport_by_dev_fn _cxl_add_dport_by_dev;
> -
> -typedef int(*cxl_switch_decoders_setup_fn)(struct cxl_port *port);
> -extern cxl_switch_decoders_setup_fn _devm_cxl_switch_port_decoders_setup;
> -
> -#endif
> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> index 660e8402189c..10140a4c5fac 100644
> --- a/tools/testing/cxl/test/mock.c
> +++ b/tools/testing/cxl/test/mock.c
> @@ -10,20 +10,12 @@
>  #include <cxlmem.h>
>  #include <cxlpci.h>
>  #include "mock.h"
> -#include "../exports.h"
>  
>  static LIST_HEAD(mock);
>  
> -static struct cxl_dport *
> -redirect_cxl_add_dport_by_dev(struct cxl_port *port, struct device *dport_dev);
> -static int redirect_devm_cxl_switch_port_decoders_setup(struct cxl_port *port);
> -
>  void register_cxl_mock_ops(struct cxl_mock_ops *ops)
>  {
>  	list_add_rcu(&ops->list, &mock);
> -	_cxl_add_dport_by_dev = redirect_cxl_add_dport_by_dev;
> -	_devm_cxl_switch_port_decoders_setup =
> -		redirect_devm_cxl_switch_port_decoders_setup;
>  }
>  EXPORT_SYMBOL_GPL(register_cxl_mock_ops);
>  
> @@ -31,9 +23,6 @@ DEFINE_STATIC_SRCU(cxl_mock_srcu);
>  
>  void unregister_cxl_mock_ops(struct cxl_mock_ops *ops)
>  {
> -	_devm_cxl_switch_port_decoders_setup =
> -		__devm_cxl_switch_port_decoders_setup;
> -	_cxl_add_dport_by_dev = __cxl_add_dport_by_dev;
>  	list_del_rcu(&ops->list);
>  	synchronize_srcu(&cxl_mock_srcu);
>  }
> @@ -162,7 +151,7 @@ __wrap_nvdimm_bus_register(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(__wrap_nvdimm_bus_register);
>  
> -int redirect_devm_cxl_switch_port_decoders_setup(struct cxl_port *port)
> +int __wrap_devm_cxl_switch_port_decoders_setup(struct cxl_port *port)
>  {
>  	int rc, index;
>  	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
> @@ -170,11 +159,12 @@ int redirect_devm_cxl_switch_port_decoders_setup(struct cxl_port *port)
>  	if (ops && ops->is_mock_port(port->uport_dev))
>  		rc = ops->devm_cxl_switch_port_decoders_setup(port);
>  	else
> -		rc = __devm_cxl_switch_port_decoders_setup(port);
> +		rc = devm_cxl_switch_port_decoders_setup(port);
>  	put_cxl_mock_ops(index);
>  
>  	return rc;
>  }
> +EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_switch_port_decoders_setup, "CXL");
>  
>  int __wrap_devm_cxl_endpoint_decoders_setup(struct cxl_port *port)
>  {
> @@ -256,8 +246,8 @@ void __wrap_cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device
>  }
>  EXPORT_SYMBOL_NS_GPL(__wrap_cxl_dport_init_ras_reporting, "CXL");
>  
> -struct cxl_dport *redirect_cxl_add_dport_by_dev(struct cxl_port *port,
> -						struct device *dport_dev)
> +struct cxl_dport *__wrap_cxl_add_dport_by_dev(struct cxl_port *port,
> +					      struct device *dport_dev)
>  {
>  	int index;
>  	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
> @@ -266,11 +256,12 @@ struct cxl_dport *redirect_cxl_add_dport_by_dev(struct cxl_port *port,
>  	if (ops && ops->is_mock_port(port->uport_dev))
>  		dport = ops->cxl_add_dport_by_dev(port, dport_dev);
>  	else
> -		dport = __cxl_add_dport_by_dev(port, dport_dev);
> +		dport = cxl_add_dport_by_dev(port, dport_dev);
>  	put_cxl_mock_ops(index);
>  
>  	return dport;
>  }
> +EXPORT_SYMBOL_NS_GPL(__wrap_cxl_add_dport_by_dev, "CXL");
>  
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("cxl_test: emulation module");


