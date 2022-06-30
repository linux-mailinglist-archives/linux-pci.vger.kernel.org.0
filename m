Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF02C561622
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jun 2022 11:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbiF3JTg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jun 2022 05:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234378AbiF3JTB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2022 05:19:01 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA1541319;
        Thu, 30 Jun 2022 02:18:13 -0700 (PDT)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LYXhH2KzVz67x9N;
        Thu, 30 Jun 2022 17:14:07 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 30 Jun 2022 11:18:11 +0200
Received: from localhost (10.81.200.250) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 30 Jun
 2022 10:18:10 +0100
Date:   Thu, 30 Jun 2022 10:18:08 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
        <hch@lst.de>
Subject: Re: [PATCH 28/46] cxl/port: Move dport tracking to an xarray
Message-ID: <20220630101808.0000714f@Huawei.com>
In-Reply-To: <20220624041950.559155-3-dan.j.williams@intel.com>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <20220624041950.559155-3-dan.j.williams@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.200.250]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 23 Jun 2022 21:19:32 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Reduce the complexity and the overhead of walking the topology to
> determine endpoint connectivity to root decoder interleave
> configurations.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Hi Dan,

A few minor comments inline around naming and also one query on why
the refactor or reap_ports is connected to the xarray change.

Thanks,

Jonathan

> ---
>  drivers/cxl/acpi.c      |  2 +-
>  drivers/cxl/core/hdm.c  |  6 ++-
>  drivers/cxl/core/port.c | 88 ++++++++++++++++++-----------------------
>  drivers/cxl/cxl.h       | 12 +++---
>  4 files changed, 51 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 09fe92177d03..92ad1f359faf 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -197,7 +197,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  	if (!bridge)
>  		return 0;
>  
> -	dport = cxl_find_dport_by_dev(root_port, match);
> +	dport = cxl_dport_load(root_port, match);

Load is kind of specific to the xarray.  I'd be tempted to keep it to
original find naming.


>  	if (!dport) {
>  		dev_dbg(host, "host bridge expected and not found\n");
>  		return 0;
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index c0164f9b2195..672bf3e97811 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -50,8 +50,9 @@ static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
>  {
>  	struct cxl_switch_decoder *cxlsd;
> -	struct cxl_dport *dport;
> +	struct cxl_dport *dport = NULL;
>  	int single_port_map[1];
> +	unsigned long index;
>  
>  	cxlsd = cxl_switch_decoder_alloc(port, 1);
>  	if (IS_ERR(cxlsd))
> @@ -59,7 +60,8 @@ int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
>  
>  	device_lock_assert(&port->dev);
>  
> -	dport = list_first_entry(&port->dports, typeof(*dport), list);
> +	xa_for_each(&port->dports, index, dport)
> +		break;
>  	single_port_map[0] = dport->port_id;
>  
>  	return add_hdm_decoder(port, &cxlsd->cxld, single_port_map);
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index ea3ab9baf232..d2f6898940fa 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -452,6 +452,7 @@ static void cxl_port_release(struct device *dev)
>  	xa_for_each(&port->endpoints, index, ep)
>  		cxl_ep_remove(port, ep);
>  	xa_destroy(&port->endpoints);
> +	xa_destroy(&port->dports);
>  	ida_free(&cxl_port_ida, port->id);
>  	kfree(port);
>  }
> @@ -566,7 +567,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
>  	port->component_reg_phys = component_reg_phys;
>  	ida_init(&port->decoder_ida);
>  	port->dpa_end = -1;
> -	INIT_LIST_HEAD(&port->dports);
> +	xa_init(&port->dports);
>  	xa_init(&port->endpoints);
>  
>  	device_initialize(dev);
> @@ -696,17 +697,13 @@ static int match_root_child(struct device *dev, const void *match)
>  		return 0;
>  
>  	port = to_cxl_port(dev);
> -	device_lock(dev);
> -	list_for_each_entry(dport, &port->dports, list) {
> -		iter = match;
> -		while (iter) {
> -			if (iter == dport->dport)
> -				goto out;
> -			iter = iter->parent;
> -		}
> +	iter = match;
> +	while (iter) {
> +		dport = cxl_dport_load(port, iter);
> +		if (dport)
> +			break;
> +		iter = iter->parent;
>  	}
> -out:
> -	device_unlock(dev);
>  
>  	return !!iter;
>  }
> @@ -730,9 +727,10 @@ EXPORT_SYMBOL_NS_GPL(find_cxl_root, CXL);
>  static struct cxl_dport *find_dport(struct cxl_port *port, int id)
>  {
>  	struct cxl_dport *dport;
> +	unsigned long index;
>  
>  	device_lock_assert(&port->dev);
> -	list_for_each_entry (dport, &port->dports, list)
> +	xa_for_each(&port->dports, index, dport)
>  		if (dport->port_id == id)
>  			return dport;
>  	return NULL;
> @@ -741,18 +739,21 @@ static struct cxl_dport *find_dport(struct cxl_port *port, int id)
>  static int add_dport(struct cxl_port *port, struct cxl_dport *new)
>  {
>  	struct cxl_dport *dup;
> +	int rc;
>  
>  	device_lock_assert(&port->dev);
>  	dup = find_dport(port, new->port_id);
> -	if (dup)
> +	if (dup) {
>  		dev_err(&port->dev,
>  			"unable to add dport%d-%s non-unique port id (%s)\n",
>  			new->port_id, dev_name(new->dport),
>  			dev_name(dup->dport));
> -	else
> -		list_add_tail(&new->list, &port->dports);
> +		rc = -EBUSY;

Direct return slightly simpler and reduce indent on next bit plus makes
this more obviously an 'error condition' by indenting it.

> +	} else
> +		rc = xa_insert(&port->dports, (unsigned long)new->dport, new,
> +			       GFP_KERNEL);
>  
> -	return dup ? -EEXIST : 0;
> +	return rc;
>  }
>  
>  /*
> @@ -779,10 +780,8 @@ static void cxl_dport_remove(void *data)
>  	struct cxl_dport *dport = data;
>  	struct cxl_port *port = dport->port;
>  
> +	xa_erase(&port->dports, (unsigned long) dport->dport);
>  	put_device(dport->dport);
> -	cond_cxl_root_lock(port);
> -	list_del(&dport->list);
> -	cond_cxl_root_unlock(port);
>  }
>  
>  static void cxl_dport_unlink(void *data)
> @@ -834,7 +833,6 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
>  	if (!dport)
>  		return ERR_PTR(-ENOMEM);
>  
> -	INIT_LIST_HEAD(&dport->list);
>  	dport->dport = dport_dev;
>  	dport->port_id = port_id;
>  	dport->component_reg_phys = component_reg_phys;
> @@ -925,7 +923,7 @@ static int match_port_by_dport(struct device *dev, const void *data)
>  		return 0;
>  
>  	port = to_cxl_port(dev);
> -	dport = cxl_find_dport_by_dev(port, ctx->dport_dev);
> +	dport = cxl_dport_load(port, ctx->dport_dev);
>  	if (ctx->dport)
>  		*ctx->dport = dport;
>  	return dport != NULL;
> @@ -1025,19 +1023,27 @@ EXPORT_SYMBOL_NS_GPL(cxl_endpoint_autoremove, CXL);
>   * for a port to be unregistered is when all memdevs beneath that port have gone
>   * through ->remove(). This "bottom-up" removal selectively removes individual
>   * child ports manually. This depends on devm_cxl_add_port() to not change is
> - * devm action registration order.
> + * devm action registration order, and for dports to have already been
> + * destroyed by reap_dports().
>   */
> -static void delete_switch_port(struct cxl_port *port, struct list_head *dports)
> +static void delete_switch_port(struct cxl_port *port)
> +{
> +	devm_release_action(port->dev.parent, cxl_unlink_uport, port);
> +	devm_release_action(port->dev.parent, unregister_port, port);
> +}
> +
> +static void reap_dports(struct cxl_port *port)
>  {
> -	struct cxl_dport *dport, *_d;
> +	struct cxl_dport *dport;
> +	unsigned long index;
> +
> +	device_lock_assert(&port->dev);
>  
> -	list_for_each_entry_safe(dport, _d, dports, list) {
> +	xa_for_each(&port->dports, index, dport) {
>  		devm_release_action(&port->dev, cxl_dport_unlink, dport);
>  		devm_release_action(&port->dev, cxl_dport_remove, dport);
>  		devm_kfree(&port->dev, dport);
>  	}
> -	devm_release_action(port->dev.parent, cxl_unlink_uport, port);
> -	devm_release_action(port->dev.parent, unregister_port, port);
>  }
>  
>  static struct cxl_ep *cxl_ep_load(struct cxl_port *port,
> @@ -1054,8 +1060,8 @@ static void cxl_detach_ep(void *data)
>  	for (iter = &cxlmd->dev; iter; iter = grandparent(iter)) {
>  		struct device *dport_dev = grandparent(iter);
>  		struct cxl_port *port, *parent_port;
> -		LIST_HEAD(reap_dports);
>  		struct cxl_ep *ep;
> +		bool died = false;
>  
>  		if (!dport_dev)
>  			break;
> @@ -1095,15 +1101,16 @@ static void cxl_detach_ep(void *data)
>  			 * enumerated port. Block new cxl_add_ep() and garbage
>  			 * collect the port.
>  			 */
> +			died = true;
>  			port->dead = true;
> -			list_splice_init(&port->dports, &reap_dports);
> +			reap_dports(port);

I'm not immediately clear on why this refactor is tied up with moving
to the xarray.  Perhaps a comment in the commit message to add
more detail around this?

>  		}
>  		device_unlock(&port->dev);
>  
> -		if (!list_empty(&reap_dports)) {
> +		if (died) {
>  			dev_dbg(&cxlmd->dev, "delete %s\n",
>  				dev_name(&port->dev));
> -			delete_switch_port(port, &reap_dports);
> +			delete_switch_port(port);
>  		}
>  		put_device(&port->dev);
>  		device_unlock(&parent_port->dev);
> @@ -1282,23 +1289,6 @@ struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_find_port, CXL);
>  
> -struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
> -					const struct device *dev)
> -{
> -	struct cxl_dport *dport;
> -
> -	device_lock(&port->dev);
> -	list_for_each_entry(dport, &port->dports, list)
> -		if (dport->dport == dev) {
> -			device_unlock(&port->dev);
> -			return dport;
> -		}
> -
> -	device_unlock(&port->dev);
> -	return NULL;
> -}
> -EXPORT_SYMBOL_NS_GPL(cxl_find_dport_by_dev, CXL);
> -
>  static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
>  				    struct cxl_port *port, int *target_map)
>  {
> @@ -1309,7 +1299,7 @@ static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
>  
>  	device_lock_assert(&port->dev);
>  
> -	if (list_empty(&port->dports))
> +	if (xa_empty(&port->dports))
>  		return -EINVAL;
>  
>  	write_seqlock(&cxlsd->target_lock);

