Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C4C6F0BBF
	for <lists+linux-pci@lfdr.de>; Thu, 27 Apr 2023 20:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244360AbjD0SJL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Apr 2023 14:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243708AbjD0SJK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Apr 2023 14:09:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7331C40F0;
        Thu, 27 Apr 2023 11:09:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 176DB63EFA;
        Thu, 27 Apr 2023 18:09:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4A5C433D2;
        Thu, 27 Apr 2023 18:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682618948;
        bh=QBydXWhrxQNK3CFJbJDwWowfRxr+Zi+M4F7Gcl55S/k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dZx9rn78ovZWadDWRrpeXNPkOUvJazxFz83IgAuJk82x4ouLrBB70Wk4gWvIHt3Tg
         0/LiXVmF7Ev+EZ5kNnYjWg8qxTXqCudJFYnrhV3BdH3Xn8zd9yv+wzrRQf4ixqr/gA
         TyoXmX2i8pfKvINeXCwMP4EfVA40ZQg+mtMbgBlOn1ksvpXqSzlzrWYVMEA/7bKKfU
         XL8AB1tuk2ZUeezDSBlMbM4+QwCQ3z+LddGkewnOY3arrpEg5hP5zXuuxBocL3Jpdr
         USiDtdYlWL4igPY0VjljLBOPulu8ORWnAuHNrea1tWqB/ktQui0IvyOLSYbtMXFbpU
         LUToGs7f43mXQ==
Date:   Thu, 27 Apr 2023 13:09:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Frank Li <Frank.Li@nxp.com>,
        Jon Mason <jdmason@kudzu.us>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ren Zhijie <renzhijie2@huawei.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [RFC PATCH v2 3/3] PCI: endpoint: Add EP function driver to
 provide virtio-console functionality
Message-ID: <20230427180906.GA261441@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230427104428.862643-4-mie@igel.co.jp>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Random typos and trivial things.  No need to repost until somebody
does a more substantive review.

On Thu, Apr 27, 2023 at 07:44:28PM +0900, Shunsuke Mie wrote:
> Add a new PCIe endpoint function driver that works as a pci virtio-console
> device. The console connect to endpoint side console. It enables to
> communicate PCIe host and endpoint.

s/pci/PCI/

> Architecture is following:
> 
>  ┌────────────┐         ┌──────────────────────┬────────────┐
>  │virtioe     │         │                      │virtio      │
>  │console drv │         ├───────────────┐      │console drv │
>  ├────────────┤         │(virtio console│      ├────────────┤
>  │ virtio bus │         │ device)       │◄────►│ virtio bus │
>  ├────────────┤         ├---------------┤      └────────────┤
>  │            │         │ pci ep virtio │                   │
>  │  pci bus   │         │  console drv  │                   │
>  │            │  pcie   ├───────────────┤                   │
>  │            │ ◄─────► │  pci ep Bus   │                   │
>  └────────────┘         └───────────────┴───────────────────┘
>    PCIe Root              PCIe Endpoint

s/virtioe/virtio/
s/pci/PCI/
s/pcie/PCIe/
s/ep/EP/

> +config PCI_EPF_VCON
> +	tristate "PCI Endpoint virito-console driver"

s/virito/virtio/

> +	depends on PCI_ENDPOINT
> +	select VHOST_RING
> +	select PCI_EPF_VIRTIO
> +	help
> +	  PCIe Endpoint virtio-console function implementatino. This module
> +	  enables to show the virtio-console as pci device to PCIe host side, and
> +	  another virtual virtio-console device registers to endpoint system.
> +	  Those devices are connected virtually and can communicate each other.

s/implementatino/implementation/
s/pci/PCI/
s/can communicate/can communicate with/

> + * PCI Endpoint function driver to impliment virtio-console device
> + * functionality.

s/impliment/implement/

> +static int virtio_queue_size = 0x100;
> +module_param(virtio_queue_size, int, 0444);
> +MODULE_PARM_DESC(virtio_queue_size, "A length of virtqueue");

When and why would users need this parameter?  Where is it documented?

> +	/* To access virtqueus of local host driver */

s/virtqueus/virtqueues/

> +	/* To show a status whether this driver is ready and the remote is connected */

Make this fit in 80 columns.

> +	/* This is a minimum implementation. Doesn't support any features of
> +	 * virtio console. It means driver and device use just 2 virtuque for tx
> +	 * and rx.
> +	 */

Use common multi-line comment style:

  /*
   * This is ...
   */

s/virtuque/virtqueues/

> +static void epf_vcon_raise_irq_handler(struct work_struct *work)
> +{
> +	struct epf_vcon *vcon =
> +		container_of(work, struct epf_vcon, raise_irq_work);

Rewrap.

> +static int epf_vcon_setup_common(struct epf_vcon *vcon)
> +{
> +	vcon->features = 0;
> +	vcon->connected = false;
> +
> +	vcon->task_wq =
> +		alloc_workqueue("pci-epf-vcon/task-wq",

Looks like this would fit on the previous line?

> +				WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_UNBOUND, 0);

> +static void epf_vcon_initialize_complete(void *param)
> +{
> +	struct epf_vcon *vcon = param;
> +
> +	pr_debug("Remote host has connected\n");

Is there any device info you could include here, e.g., with dev_dbg()?
It's nice if users have a little context.

> +static int epf_vcon_setup_ep_func(struct epf_vcon *vcon, struct pci_epf *epf)
> +{
> +	int err;
> +	struct epf_virtio *evio = &vcon->evio;
> +	unsigned int nvq = epf_vcon_get_nvq(vcon);
> +
> +	vcon->rdev_iovs =
> +		kmalloc_array(nvq, sizeof(vcon->rdev_iovs[0]), GFP_KERNEL);

Move the function name and as many parameters as fit in 80 columns to
the previous line to match prevailing style.

> +	/* There is no config for virtio console because this console device
> +	 * doesn't any support features
> +	 */

Multi-line comment style.

s/doesn't any support/doesn't support any/?  Is that what you mean?

> +	/* Do nothing because this console device doesn't any support features */

Same.

> +static void epf_vcon_vdev_set_status(struct virtio_device *vdev, u8 status)
> +{
> +	if (status & VIRTIO_CONFIG_S_FAILED)
> +		pr_debug("driver failed to setup this device\n");

dev_dbg() if possible.

> +		err = vringh_init_kern(&vcon->vdev_vrhs[i], vcon->features,
> +				       virtio_queue_size, false, vring->desc,
> +				       vring->avail, vring->used);
> +		if (err) {
> +			pr_err("failed to init vringh for vring %d\n", i);

dev_err() if possible.

> +static int epf_vcon_setup_vdev(struct epf_vcon *vcon, struct device *parent)
> +{
> +	int err;
> +	struct virtio_device *vdev = &vcon->vdev;
> +	const unsigned int nvq = epf_vcon_get_nvq(vcon);
> +
> +	vcon->vdev_vrhs =
> +		kmalloc_array(nvq, sizeof(vcon->vdev_vrhs[0]), GFP_KERNEL);

Rewrap.

> +	vcon->vdev_iovs =
> +		kmalloc_array(nvq, sizeof(vcon->vdev_iovs[0]), GFP_KERNEL);

Rewrap.

> +	vcon->vdev_vqs =
> +		kmalloc_array(nvq, sizeof(vcon->vdev_vrhs[0]), GFP_KERNEL);

Rewrap.

> +static void epf_vcon_cleanup_vdev(struct epf_vcon *vcon)
> +{
> +	unregister_virtio_device(&vcon->vdev);
> +	/* Cleanup struct virtio_device that has kobject, otherwise error occures when
> +	 * reregister the virtio device.
> +	 */

Multi-line style and rewrap to fit in 80 columns.

> +static int __init epf_vcon_init(void)
> +{
> +	int err;
> +
> +	err = pci_epf_register_driver(&epf_vcon_drv);
> +	if (err)
> +		pr_err("Failed to register PCI EP virtio-console function\n");

dev_err() if possible (doesn't look like it *is* possible).

Looks like this registers a *driver*, so maybe change the message from
"function" to "driver"?

Bjorn
