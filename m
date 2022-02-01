Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012464A5BFB
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 13:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbiBAMNd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 07:13:33 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4596 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbiBAMNd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 07:13:33 -0500
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jp3jQ4dcMz67mkr;
        Tue,  1 Feb 2022 20:12:58 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Feb 2022 13:13:30 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 1 Feb
 2022 12:13:29 +0000
Date:   Tue, 1 Feb 2022 12:13:28 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v3 32/40] cxl/core/port: Add switch port enumeration
Message-ID: <20220201121328.00006f3e@Huawei.com>
In-Reply-To: <164298428940.3018233.18042207990919432824.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164298428940.3018233.18042207990919432824.stgit@dwillia2-desk3.amr.corp.intel.com>
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

On Sun, 23 Jan 2022 16:31:29 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> So far the platorm level CXL resources have been enumerated by the
> cxl_acpi driver, and cxl_pci has gathered all the pre-requisite
> information it needs to fire up a cxl_mem driver. However, the first
> thing the cxl_mem driver will be tasked to do is validate that all the
> PCIe Switches in its ancestry also have CXL capabilities and an CXL.mem
> link established.
> 
> Provide a common mechanism for a CXL.mem endpoint driver to enumerate
> all the ancestor CXL ports in the topology and validate CXL.mem
> connectivity.
> 
> Multiple endpoints may end up racing to establish a shared port in the
> topology. This race is resolved via taking the device-lock on a parent
> CXL Port before establishing a new child. The winner of the race
> establishes the port, the loser simply registers its interest in the
> port via 'struct cxl_ep' place-holder reference.
> 
> At endpoint teardown the same parent port lock is taken as 'struct
> cxl_ep' references are deleted. Last endpoint to drop its reference
> unregisters the port.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

I've not done Qemu switch emulation yet, but should probably get on with
it to test his (not a big job, but lots of other stuff to do as ever!)
As such I haven't tested this beyond the not breaking cases without a
switch yet.

Comments inline. Mostly trivial but I think the error handling paths in
add_port_register_ep() need another look.

Jonathan


> ---
>  drivers/cxl/acpi.c      |   17 --
>  drivers/cxl/core/port.c |  379 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h       |   20 ++
>  3 files changed, 400 insertions(+), 16 deletions(-)
> 


> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 26c3eb9180cd..cd95d9f8c624 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -7,6 +7,7 @@

...


> +/**
> + * cxl_add_ep - register an endpoint's interest in a port
> + * @port: a port in the endpoint's topology ancestry
> + * @ep_dev: device representing the endpoint
> + *
> + * Intermediate CXL ports are scanned based on the arrival of endpoints.
> + * When those endpoints depart the port can be destroyed once all
> + * endpoints that care about that port have been removed.
> + */
> +static int cxl_add_ep(struct cxl_port *port, struct device *ep_dev)
> +{
> +	struct cxl_ep *ep;
> +	int rc;
> +
> +	ep = kzalloc(sizeof(*ep), GFP_KERNEL);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&ep->list);
> +	ep->ep = get_device(ep_dev);
> +
> +	rc = add_ep(port, ep);
> +	if (rc)
> +		cxl_ep_release(ep);
> +	return rc;
> +}
> +


...

> +
> +static struct device *grandparent(struct device *dev)
> +{
> +	if (dev && dev->parent)
> +		return dev->parent->parent;
> +	return NULL;
> +}
> +
> +static void delete_switch_port(struct cxl_memdev *cxlmd, struct cxl_port *port,
> +			       struct list_head *dports)
> +{
> +	struct cxl_dport *dport, *_d;
> +

This hand manipulation of devm managed stuff could benefit from an explanatory
comment or two.

> +	dev_dbg(&cxlmd->dev, "delete %s\n", dev_name(&port->dev));
> +	list_for_each_entry_safe(dport, _d, dports, list) {
> +		devm_release_action(&port->dev, cxl_dport_unlink, dport);
> +		devm_release_action(&port->dev, cxl_dport_remove, dport);
> +		devm_kfree(&port->dev, dport);
> +	}
> +	devm_release_action(port->dev.parent, cxl_unlink_uport, port);
> +	devm_release_action(port->dev.parent, unregister_port, port);
> +}
> +
> +static void cxl_remove_ep(void *data)

Maybe naming needs a rethink.  Instinctively I'd expect this to do the opposite
of add_ep whereas it does a whole lot more. Mind you I can't think of
a better name...

> +{
> +	struct cxl_memdev *cxlmd = data;
> +	struct device *iter;
> +
> +	for (iter = &cxlmd->dev; iter; iter = grandparent(iter)) {
> +		struct device *dport_dev = grandparent(iter);
> +		struct cxl_port *port, *parent_port;
> +		LIST_HEAD(reap_dports);
> +		struct cxl_ep *ep;
> +
> +		if (!dport_dev)
> +			break;
> +
> +		port = find_cxl_port(dport_dev);
> +		if (!port || is_cxl_root(port)) {
> +			put_device(&port->dev);
> +			continue;
> +		}
> +
> +		parent_port = to_cxl_port(port->dev.parent);
> +		cxl_device_lock(&parent_port->dev);
> +		if (!parent_port->dev.driver) {

Might be good to have a comment here on 'why' this condition might be hit.
In similar path in setup there happens to be a dev_dbg() that does
the job of a comment.

> +			cxl_device_unlock(&parent_port->dev);
> +			put_device(&port->dev);
> +			continue;
> +		}
> +
> +		cxl_device_lock(&port->dev);
> +		ep = find_ep(port, &cxlmd->dev);
> +		dev_dbg(&cxlmd->dev, "disconnect %s from %s\n",
> +			ep ? dev_name(ep->ep) : "", dev_name(&port->dev));
> +		cxl_ep_release(ep);
> +		if (ep && !port->dead && list_empty(&port->endpoints) &&
> +		    !is_cxl_root(parent_port)) {
> +			/*
> +			 * This was the last ep attached to a dynamically
> +			 * enumerated port. Block new cxl_add_ep() and garbage
> +			 * collect the port.
> +			 */
> +			port->dead = true;
> +			list_splice_init(&port->dports, &reap_dports);
> +		}
> +		cxl_device_unlock(&port->dev);
> +
> +		if (!list_empty(&reap_dports))
> +			delete_switch_port(cxlmd, port, &reap_dports);
> +		put_device(&port->dev);
> +		cxl_device_unlock(&parent_port->dev);
> +	}
> +}
> +
> +static resource_size_t find_component_registers(struct device *dev)
> +{
> +	struct cxl_register_map map;
> +	struct pci_dev *pdev;
> +
> +	/*
> +	 * Theoretically, CXL component registers can be hosted on a
> +	 * non-PCI device, in practice, only cxl_test hits this case.
> +	 */
> +	if (!dev_is_pci(dev))
> +		return CXL_RESOURCE_NONE;
> +
> +	pdev = to_pci_dev(dev);
> +
> +	cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> +	return cxl_regmap_to_base(pdev, &map);
> +}
> +
> +static int add_port_register_ep(struct cxl_memdev *cxlmd,
> +				struct device *uport_dev,
> +				struct device *dport_dev)
> +{
> +	struct cxl_port *port, *parent_port;
> +	resource_size_t component_reg_phys;
> +	int rc;
> +
> +	parent_port = find_cxl_port(grandparent(dport_dev));
> +	if (!parent_port) {
> +		/*
> +		 * The root CXL port is added by the CXL platform driver, fail
> +		 * for now to be re-probed after platform driver attaches.
> +		 */
> +		if (!grandparent(dport_dev)) {

Possibly worth a local variable for grandparent(dport_dev)?
Could you pull this out before trying to call find_cxl_port(NULL)?
Obviously that's safe, but this seems more complex than it needs to be.

	struct device *gp = grandparent(dport_dev);

	if (!gp) {
		/*
		 * The root CXL port is added by the CXL platform driver, fail
		 * for now to be re-probed after platform driver attaches.
		 */
		dev_dbg(&cxlmd->dev, "%s is a root dport\n",
			dev_name(dport_dev));
			return -ENXIO;
	}
	parent_port = find_cxl_port(gp);
	if (!parent_port) {
		/* iterate to create this parent port */
		return -EAGAIN;
	}


> +			dev_dbg(&cxlmd->dev, "%s is a root dport\n",
> +				dev_name(dport_dev));
> +			return -ENXIO;
> +		}
> +		/* ...otherwise, iterate to create this parent_port */
> +		return -EAGAIN;
> +	}
> +
> +	cxl_device_lock(&parent_port->dev);
> +	if (!parent_port->dev.driver) {
> +		dev_warn(&cxlmd->dev,
> +			 "port %s:%s disabled, failed to enumerate CXL.mem\n",
> +			 dev_name(&parent_port->dev), dev_name(uport_dev));
> +		rc = -ENXIO;
> +		goto out;

In this path, port isn't initialized (see below)

> +	}
> +
> +	port = find_cxl_port_at(parent_port, dport_dev);
> +	if (!port) {
> +		component_reg_phys = find_component_registers(uport_dev);
> +		port = devm_cxl_add_port(&parent_port->dev, uport_dev,
> +					 component_reg_phys, parent_port);
> +		if (!IS_ERR(port))
> +			get_device(&port->dev);
> +	}
> +out:
> +	cxl_device_unlock(&parent_port->dev);
> +
> +	if (IS_ERR(port))

Port isn't initialized in all paths above...
I think you want to skip on to the put_device(&parent_port->dev) if
rc is set..

> +		rc = PTR_ERR(port);
> +	else {

We could enter this path with rc set and continue as if it wasn't.

> +		dev_dbg(&cxlmd->dev, "add to new port %s:%s\n",
> +			dev_name(&port->dev), dev_name(port->uport));
> +		rc = cxl_add_ep(port, &cxlmd->dev);
> +		if (rc == -EEXIST) {
> +			/*
> +			 * "can't" happen, but this error code means
> +			 * something to the caller, so translate it.
> +			 */
> +			rc = -ENXIO;
> +		}
> +		put_device(&port->dev);
> +	}
> +
> +	put_device(&parent_port->dev);
> +	return rc;
> +}
> +
> +int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
> +{
> +	struct device *dev = &cxlmd->dev;
> +	struct device *iter;
> +	int rc;
> +
> +	rc = devm_add_action_or_reset(&cxlmd->dev, cxl_remove_ep, cxlmd);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * Scan for and add all cxl_ports in this device's ancestry.
> +	 * Repeat until no more ports are added. Abort if a port add
> +	 * attempt fails.
> +	 */
> +retry:
> +	for (iter = dev; iter; iter = grandparent(iter)) {
> +		struct device *dport_dev = grandparent(iter);
> +		struct device *uport_dev;
> +		struct cxl_port *port;
> +
> +		if (!dport_dev)
> +			break;
> +		uport_dev = dport_dev->parent;
> +		dev_dbg(dev, "scan: iter: %s dport_dev: %s parent: %s\n",
> +			dev_name(iter), dev_name(dport_dev),
> +			uport_dev ? dev_name(uport_dev) : "'none'");

Given the uport_dev is something we don't expect to happen and it'll be warned
on anyway, maybe move this dev_dbg() after the check and possibly augment that
dev_warn with iter so all the information is there as well.

Will end up with a simpler dev_dbg()


> +		if (!uport_dev) {
> +			dev_warn(dev, "unexpected topology, no parent for %s\n",
> +				 dev_name(dport_dev));
> +			rc = -ENXIO;
> +			break;

This rc isn't returned below.
return -ENOXIO; here is probably better option anyway.

> +		}
> +
> +		port = find_cxl_port(dport_dev);
> +		if (port) {
> +			dev_dbg(&cxlmd->dev,
> +				"found already registered port %s:%s\n",
> +				dev_name(&port->dev), dev_name(port->uport));
> +			rc = cxl_add_ep(port, &cxlmd->dev);
> +
> +			/*
> +			 * If the endpoint already exists in the port's list,
> +			 * that's ok, it was added on a previous pass.
> +			 * Otherwise, retry in add_port_register_ep() after
> +			 * taking the parent_port lock as the current port may
> +			 * be being reaped.
> +			 */
> +			if (rc && rc != -EEXIST) {
> +				put_device(&port->dev);
> +				return rc;
> +			}
> +
> +			if (is_cxl_port(port->dev.parent) &&
> +			    !is_cxl_root(to_cxl_port(port->dev.parent))) {

I'd like a comment on what this is matching.  What types of port will
result in us following this path?

> +				put_device(&port->dev);
> +				continue;
> +			}
> +
> +			put_device(&port->dev);
> +			break;
> +		}
> +
> +		rc = add_port_register_ep(cxlmd, uport_dev, dport_dev);
> +		/* port missing, try to add parent */
> +		if (rc == -EAGAIN)
> +			continue;
> +		/* failed to add ep or port */
> +		if (rc)
> +			return rc;
> +		/* port added, new descendants possible, start over */
> +		goto retry;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_ports, CXL);
> +
> +struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd)
> +{
> +	return find_cxl_port(grandparent(&cxlmd->dev));
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_find_port, CXL);
> +

>  static int decoder_populate_targets(struct cxl_decoder *cxld,
>  				    struct cxl_port *port, int *target_map)
>  {


