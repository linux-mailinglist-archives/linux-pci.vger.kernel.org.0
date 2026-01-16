Return-Path: <linux-pci+bounces-45058-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B5AD33147
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 16:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5AD0530DB102
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 15:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EA1338921;
	Fri, 16 Jan 2026 15:01:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E60338906;
	Fri, 16 Jan 2026 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768575694; cv=none; b=FxRXfNEUCBQXGHBEY+W0h2/ldZUdx+nMjJX5yvISn7BbQFEWIBPWwEo97jWD5so6PWGoVNKVOiGM7z3WZYj7/a9XN8FKSo2PduBx/s/XYCq4d/bGPtx+DARWbfUuBiiysCKawzmXiUdYMs0sFZVPp/yjcqPKEbVfz+sks+auoJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768575694; c=relaxed/simple;
	bh=idi5olqACnD1x+hDqV7SANPsH+W54R8Ag/1sbG6zaVE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fc9ADVag/g0ruSlhOXfET4gy1kLsuCNbspBHtxe9nr6v9sdk3GYFXhS26JnuEocmdIgpNMusT+cQoNhDJUphxxSJNjSWFfZ9Tr3CWWdSKaUm8UzRAPv0Pl+t03Bw2q9Mi/uHN+hYacGRDSiuc4ChBYGrhOBeXo6uUJhGJ18Ozi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dt32L3Jx5zHnGgv;
	Fri, 16 Jan 2026 23:00:58 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 8194E40086;
	Fri, 16 Jan 2026 23:01:22 +0800 (CST)
Received: from localhost (10.126.168.43) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 16 Jan
 2026 15:01:21 +0000
Date: Fri, 16 Jan 2026 15:01:19 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <dan.j.williams@intel.com>
CC: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>, <bhelgaas@google.com>,
	<shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<vishal.l.verma@intel.com>, <alucerop@amd.com>, <ira.weiny@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v14 19/34] cxl/port: Fix devm resource leaks around with
 dport management
Message-ID: <20260116150119.00003bbd@huawei.com>
In-Reply-To: <6969c260b7998_34d2a100f6@dwillia2-mobl4.notmuch>
References: <20260114182055.46029-1-terry.bowman@amd.com>
	<20260114182055.46029-20-terry.bowman@amd.com>
	<20260115144605.00000666@huawei.com>
	<6969c260b7998_34d2a100f6@dwillia2-mobl4.notmuch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 15 Jan 2026 20:45:20 -0800
dan.j.williams@intel.com wrote:

> Jonathan Cameron wrote:
> > On Wed, 14 Jan 2026 12:20:40 -0600
> > Terry Bowman <terry.bowman@amd.com> wrote:
> >   
> > > From: Dan Williams <dan.j.williams@intel.com>
> > > 
> > > With dport addition moving out of cxl_switch_port_probe() it is no longer
> > > the case that a single dport-add failure will cause all dport resources
> > > to be automatically unwound.
> > > 
> > > devm still helps all dport resources get cleaned up when the port is
> > > detached, but setup now needs to avoid leaking resources if an early exit
> > > occurs during setup.
> > > 
> > > Convert from a "devm add" model, to an "auto remove" model that makes the
> > > caller responsible for registering devm reclaim after the object is fully
> > > instantiated.
> > > 
> > > As a side of effect of this reorganization port->nr_dports is now always
> > > consistent with the number of entries in the port->dports xarray, and this
> > > can stop playing games with ida_is_empty() which is unreliable as a
> > > detector of whether decoders are setup. I.e. consider how
> > > CONFIG_DEBUG_KOBJECT_RELEASE might wreak havoc with this approach.
> > > 
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > Reviewed-by: Terry Bowman <terry.bowman@amd.com>
> > > 
> > > ---
> > > 
> > > Changes in v13 -> v14:
> > > - New patch  
> > Hi Dan, Terry,
> > 
> > I think this needs a little reorganization to ensure we don't have
> > dport and dport_add both being the same pointer for different free
> > reasons.  Adding a helper and we can combine them with a clear
> > hand over of ownership.
> > 
> > Wrapping devres_remove_group() in a function that is called close_group()
> > rings alarm bells.
> > 
> > Jonathan  
> [..]
> >   
> > > @@ -1176,48 +1175,27 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
> > >  			&component_reg_phys);
> > >  
> > >  	cond_cxl_root_lock(port);
> > > -	rc = add_dport(port, dport);
> > > +	struct cxl_dport *dport_add __free(remove_dport) =
> > > +		add_dport(port, dport);  
> > 
> > This pattern of having both dport and dport_add effectively
> > pointing to the same pointer concerns me from a readability / maintainability
> > point of view. We've often made use of helper functions to avoid doing
> > this and I think that would make sense here as well.  
> 
> Yeah, while I do think the multi-variable pattern is useful for
> many-step object construction, I can usually easily be persuaded to
> consider a helper function.
> 
> > Take everything down to and including dport_add() as a helper called
> > something like (naming needs work!)
> > 	struct dport_dev *dport __free(remove_and_free_dport) =
> > 		add_dport_wrapper();  
> 
> I ended up with the patch below which is similar in spirit to this
> without a new DEFINE_FREE().
> 
> 
> >   
> > >  	cond_cxl_root_unlock(port);
> > > -	if (rc)
> > > -		return ERR_PTR(rc);
> > > -
> > > -	/*
> > > -	 * Setup port register if this is the first dport showed up. Having
> > > -	 * a dport also means that there is at least 1 active link.
> > > -	 */
> > > -	if (port->nr_dports == 1 &&
> > > -	    port->component_reg_phys != CXL_RESOURCE_NONE) {
> > > -		rc = cxl_port_setup_regs(port, port->component_reg_phys);
> > > -		if (rc) {
> > > -			xa_erase(&port->dports, (unsigned long)dport->dport_dev);
> > > -			return ERR_PTR(rc);
> > > -		}
> > > -		port->component_reg_phys = CXL_RESOURCE_NONE;
> > > -	}
> > > +	if (IS_ERR(dport_add))
> > > +		return dport_add;
> > >  
> > > -	get_device(dport_dev);
> > > -	rc = devm_add_action_or_reset(host, cxl_dport_remove, dport);
> > > -	if (rc)
> > > -		return ERR_PTR(rc);
> > > +	if (dev_is_pci(dport_dev))
> > > +		dport->link_latency = cxl_pci_get_latency(to_pci_dev(dport_dev));
> > >  
> > >  	rc = sysfs_create_link(&port->dev.kobj, &dport_dev->kobj, link_name);
> > >  	if (rc)
> > >  		return ERR_PTR(rc);
> > >  
> > > -	rc = devm_add_action_or_reset(host, cxl_dport_unlink, dport);
> > > -	if (rc)
> > > -		return ERR_PTR(rc);
> > > -
> > > -	if (dev_is_pci(dport_dev))
> > > -		dport->link_latency = cxl_pci_get_latency(to_pci_dev(dport_dev));
> > > -
> > >  	cxl_debugfs_create_dport_dir(dport);
> > >  
> > > -	return dport;
> > > +	retain_and_null_ptr(dport_add);
> > > +	return no_free_ptr(dport);
> > >  }  
> > 
> > 
> >   
> > > +
> > > +/*
> > > + * Note: this only services dynamic removal of mid-level ports, root ports are
> > > + * always removed by the platform driver (e.g. cxl_acpi). @host can be
> > > + * hard-coded to &port->dev.
> > > + */
> > >  static void del_dport(struct cxl_dport *dport)
> > >  {
> > >  	struct cxl_port *port = dport->port;
> > >  
> > > -	devm_release_action(&port->dev, cxl_dport_unlink, dport);
> > > -	devm_release_action(&port->dev, cxl_dport_remove, dport);
> > > -	devm_kfree(&port->dev, dport);
> > > +	devm_release_action(&port->dev, unlink_dport, dport);
> > >  }
> > >  
> > >  static void del_dports(struct cxl_port *port)
> > > @@ -1597,10 +1603,24 @@ static int update_decoder_targets(struct device *dev, void *data)
> > >  	return 0;
> > >  }
> > >  
> > > -DEFINE_FREE(del_cxl_dport, struct cxl_dport *, if (!IS_ERR_OR_NULL(_T)) del_dport(_T))
> > > +static struct cxl_port *cxl_port_devres_group(struct cxl_port *port)
> > > +{
> > > +	if (!devres_open_group(&port->dev, port, GFP_KERNEL))
> > > +		return ERR_PTR(-ENOMEM);
> > > +	return port;
> > > +}
> > > +DEFINE_FREE(cxl_port_group_free, struct cxl_port *,
> > > +	if (!IS_ERR_OR_NULL(_T)) devres_release_group(&(_T)->dev, _T))
> > > +
> > > +static void cxl_port_group_close(struct cxl_port *port)  
> > 
> > This feels like misleading naming and I'm not sure what intent is. 
> > Would have expected it to call devres_close_group()  
> 
> Agree. The hastiness of this patch shows. Switched all the naming to not
> be surprising. The flow is:
> 
> cxl_port_open_group(): start recording devres resource acquisition
> cxl_port_remove_group(): on success, stop tracking the group, leave the resources
> cxl_port_release_group(): on failure, destroy the group, free the resources

Hi Dan, thanks for getting back on this so quickly!

Ok. So I'd misunderstood intent. If we don't have the option of close_group()
then these are just for temporary tracking of potential cleanup stuff
rather than because we want to optionally roll back part of the main
devres stuff (the bit that gets cleaned up on driver unbind /
just after remove())

I was thinking this was odd usage, but it is documented in devres.rst as one
or the two group examples, so I'm less concerned about that. Maybe
sprinkle a comment or two on the temporary nature of the devres group?

However, this makes me wonder why the other model in devres.rst
https://elixir.bootlin.com/linux/v6.19-rc5/source/Documentation/driver-api/driver-model/devres.rst#L187

  int my_midlayer_create_something()
  {
	if (!devres_open_group(dev, my_midlayer_create_something, GFP_KERNEL))
		return -ENOMEM;

	...

	devres_close_group(dev, my_midlayer_create_something);
	return 0;
  }

  void my_midlayer_destroy_something()
  {
	devres_release_group(dev, my_midlayer_create_something);
  }

isn't more appropriate here. 

Did you give that approach a go?  Assuming unlink_dport() cleans up all the
same stuff as was covered by the group (it doesn't quite because of the
last few things that can't fail) it should be a much less invasive
change. A small complexity is you'd need group to be created on the right dev
so that it matches what is done in the new autoremove code.
I'll give this a go, but might take a while so sending this in the meantime.

Anyhow, some of the comments that follow are on what you have done, and
a few others are on what the devres_close_group approach would look like.

This might the hardest to review patch I've looked at in a while...
Not sure what you could do about that though!

> 
> New patch, added a Fixes: tag.
> 
> -- 8< --
> From 9731bb6cb5638a0d2141dc072f90db0d00400680 Mon Sep 17 00:00:00 2001
> From: Dan Williams <dan.j.williams@intel.com>
> Date: Wed, 14 Jan 2026 12:20:40 -0600
> Subject: [PATCH] cxl/port: Fix devm resource leaks with dport management
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

Given complexity of ownership, can we have a flow chart of who owns what when?

> 
> Cc: <stable@vger.kernel.org>
> Fixes: 4f06d81e7c6a ("cxl: Defer dport allocation for switch ports")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>


> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index b838c59d7a3c..ce117812e5c8 100644
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
>  static int cxl_dvsec_mem_range_valid(struct cxl_dev_state *cxlds, int id)
>  {
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index fef3aa0c6680..41b65babd057 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1066,11 +1066,28 @@ static int add_dport(struct cxl_port *port, struct cxl_dport *dport)
>  		return -EBUSY;
>  	}
>  
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
> +			return rc;
> +	}
> +
> +	/* Arrange for dport_dev to be valid through remove_dport() */
> +	struct device *dev __free(put_device) = get_device(dport->dport_dev);
> +
>  	rc = xa_insert(&port->dports, (unsigned long)dport->dport_dev, dport,
>  		       GFP_KERNEL);
>  	if (rc)
>  		return rc;
>  
> +	retain_and_null_ptr(dev);
>  	port->nr_dports++;
>  	return 0;
>  }
> @@ -1094,51 +1111,64 @@ static void cond_cxl_root_unlock(struct cxl_port *port)
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
> +static struct cxl_dport *__register_dport(struct cxl_dport *dport)
>  {
> -	struct cxl_dport *dport = data;
> -	struct cxl_port *port = dport->port;
> +	int rc;
>  	char link_name[CXL_TARGET_STRLEN];
> +	struct cxl_port *port = dport->port;
> +	struct device *dport_dev = dport->dport_dev;
>  
> -	sprintf(link_name, "dport%d", dport->port_id);
> -	sysfs_remove_link(&port->dev.kobj, link_name);
> -}
> +	if (snprintf(link_name, CXL_TARGET_STRLEN, "dport%d", dport->port_id) >=
> +	    CXL_TARGET_STRLEN)
> +		return ERR_PTR(-EINVAL);
>  
> -static struct cxl_dport *
> -__devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
> -		     int port_id, resource_size_t component_reg_phys,
> -		     resource_size_t rcrb)
> -{
> -	char link_name[CXL_TARGET_STRLEN];
> -	struct cxl_dport *dport;
> -	struct device *host;
> -	int rc;
> +	cond_cxl_root_lock(port);
> +	rc = add_dport(port, dport);
> +	cond_cxl_root_unlock(port);
> +	if (rc)
> +		return ERR_PTR(rc);
>  
> -	if (is_cxl_root(port))
> -		host = port->uport_dev;
> -	else
> -		host = &port->dev;
> +	if (dev_is_pci(dport_dev))
> +		dport->link_latency = cxl_pci_get_latency(to_pci_dev(dport_dev));
>  
> -	if (!host->driver) {
> -		dev_WARN_ONCE(&port->dev, 1, "dport:%s bad devm context\n",
> -			      dev_name(dport_dev));
> -		return ERR_PTR(-ENXIO);
> +	rc = sysfs_create_link(&port->dev.kobj, &dport_dev->kobj, link_name);
> +	if (rc) {

There are several operations in here that get undone in unlink_dport()
I'd wrap those up in an __unregister_dport() function so it is easy to see
what pairs with what.

> +		remove_dport(dport);
> +		return ERR_PTR(rc);
>  	}
>  
> -	if (snprintf(link_name, CXL_TARGET_STRLEN, "dport%d", port_id) >=
> -	    CXL_TARGET_STRLEN)
> -		return ERR_PTR(-EINVAL);
> +	cxl_debugfs_create_dport_dir(dport);
>  
> -	dport = devm_kzalloc(host, sizeof(*dport), GFP_KERNEL);
> +	return dport;
> +}


> @@ -1439,13 +1430,42 @@ static void delete_switch_port(struct cxl_port *port)
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

To me this removes half the advantage of devres which is
that we don't need to be careful to remove things in the right
order.  Ah well, perhaps a price we need to pay.

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

If you did go with the devres_close_group() suggestion I think you could
then call devres_remove_group() to undo the dport stuff leaving the
rest of the devres on port-dev in place.


>  }
>  
>  static void del_dports(struct cxl_port *port)
> @@ -1597,10 +1617,24 @@ static int update_decoder_targets(struct device *dev, void *data)
>  	return 0;
>  }
>  
> -DEFINE_FREE(del_cxl_dport, struct cxl_dport *, if (!IS_ERR_OR_NULL(_T)) del_dport(_T))
> +static struct cxl_port *cxl_port_open_group(struct cxl_port *port)
> +{
> +	if (!devres_open_group(&port->dev, port, GFP_KERNEL))

The use of port as the ID is tiny bit nasty but necessary I guess for the DEFINE_FREE to
work (you could use &port->dev) but that doesn't really help.

Disadvantage is you can't stack these groups without breaking the advice
in devres not to reuse IDs. In practice I think that actually works but
it's the sort of advice comment that makes me think it might not always do so!

> +		return ERR_PTR(-ENOMEM);
> +	return port;
> +}
> +DEFINE_FREE(cxl_port_release_group, struct cxl_port *,
> +	if (!IS_ERR_OR_NULL(_T)) devres_release_group(&(_T)->dev, _T))
> +
> +static void cxl_port_remove_group(struct cxl_port *port)
> +{
> +	devres_remove_group(&port->dev, port);
> +}
> +
>  static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
>  					    struct device *dport_dev)
>  {
> +	struct cxl_dport *new_dport;
>  	struct cxl_dport *dport;

Too many dports.  Given the existing one is only used for a sanity check, can we
have a precursor that gets rid of it via a helper

int check_no_existing_dport(struct cxl_dport *port, struct device *dport_dev)
{
	struct cxl_dport *dport = cxl_find_dport_by_dev(port, dport_dev);
	if (dport) {
		dev_dbg(&port->dev, "dport%d:%s already exists\n",
			dport->port_id, dev_name(dport_dev));
		return -EBUSY;
	}

	return 0;
}

...
	rc = check_no_existing_dport(port, dport_dev);
	if (rc)
		return ERR_PTR(rc);

then can rename new_dport to dport for this patch.
Or don't bother hiding it and just use dport variable for both. 


>  	int rc;
>  
> @@ -1615,29 +1649,47 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
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
> +	struct cxl_port *port_group __free(cxl_port_release_group) =
> +		cxl_port_open_group(port);

So this is relies on everything being registered against port->dev, whereas
for root ports this then gets handed off to port->uport_dev.
That's a bit obscure - hence request for some patch description text
on who owns what resources + when.

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
> +	/* group tracking no longer needed, dport successfully added */
> +	cxl_port_remove_group(no_free_ptr(port_group));

I think this is a tiny bit too late (though my head hurts so could be wrong).
If we hit the error condition just above, we already freed the stuff
that this group controls.  

I'd be tempted to have a helper for the entire region the group is held for

helper()
{
	struct cxl_port *port_group __free(cxl_port_release_group) =
		cxl_port_open_group(port);
	if (IS_ERR(port_group))
		return ERR_CAST(port_group);

	...
	cxl_port_remove_group(no_free_ptr(port_group));
	return something good;
} 
so that the scope is clear.


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

