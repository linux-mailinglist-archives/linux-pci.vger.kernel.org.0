Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 893409CD9E
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2019 12:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbfHZKv3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Aug 2019 06:51:29 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40612 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfHZKv3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Aug 2019 06:51:29 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7QApC57034435;
        Mon, 26 Aug 2019 05:51:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566816672;
        bh=O/tV/BiqtIjvXu2mCuXlyWNwiQlqRop6Ouwwvo5FKPI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ShZIVP+FXE4VbBhHyt09yUil5pW9LT+gduaatXGxT1O8mHRKAZe0VIpktGOtyyJ/W
         Vt9AtWPGSOG4OGwSxBzoddzpwfzElBb5m92pG4hwI8nk0lDMGs2/+kVh012Zjwzd6h
         aG2J83o3KDYfTsPQyd24aXf97ncz7otlXMMtuNqI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7QApCEt129854
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Aug 2019 05:51:12 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 26
 Aug 2019 05:51:12 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 26 Aug 2019 05:51:12 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7QAp9TO063548;
        Mon, 26 Aug 2019 05:51:10 -0500
Subject: Re: [PATCH] pci: endpoint: functions: Add a virtnet EP function
To:     Haotian Wang <haotian.wang@sifive.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>
CC:     <mst@redhat.com>, <jasowang@redhat.com>,
        <linux-pci@vger.kernel.org>, <haotian.wang@duke.edu>
References: <20190823213145.2016-1-haotian.wang@sifive.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <c656fd34-68b1-46d9-38e4-c77138d3604f@ti.com>
Date:   Mon, 26 Aug 2019 16:21:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823213145.2016-1-haotian.wang@sifive.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Haotian Wang,

On 24/08/19 3:01 AM, Haotian Wang wrote:
> This endpoint function enables the PCI endpoint to establish a virtual
> ethernet link with the PCI host. The main features are:
> 
> - Zero modification of PCI host kernel. The only requirement for the
>   PCI host is to enable virtio, virtio_pci, virtio_pci_legacy and
>   virito_net.
> 
> - The virtual ethernet link is stable enough to support ordinary
>   capabilities of the Linux network stack. User space programs such as
>   ping, ssh, iperf and scp can run on the link without additional
>   hassle.
> 
> - This function fits in the PCI endpoint framework
>   (drivers/pci/endpoint/) and makes API calls provided by virtio_net
>   (drivers/net/virtio_net.c). It does not depend on
>   architecture-specific or hardware-specific features.

Nice!
> 
> This function driver is tested on the following pair of systems. The PCI
> endpoint is a Xilinx VCU118 board programmed with a SiFive Linux-capable
> core running Linux 5.2. The PCI host is an x86_64 Intel(R) Core(TM)
> i3-6100 running unmodified Linux 5.2. The virtual link achieved a
> stable throughput of ~180KB/s during scp sessions of a 50M file. The

I assume this is not using DMA as below you mentioned you got worse throughput
with DMA. What's the throughput using DMA?
> PCI host could setup ip-forwarding and NAT to enable the PCI endpoint to
> have Internet access. Documentation for using this function driver is at
> Documentation/PCI/endpoint/pci-epf-virtio-howto.rst.
> 
> Reference Docs,
> - Documentation/PCI/endpoint/pci-endpoint.rst. Initialization and
>   removal of endpoint function device and driver.
> - Documentation/PCI/endpoint/pci-endpoint-cfs.rst. Use configfs to
>   control bind, linkup and unbind behavior.
> - https://docs.oasis-open.org/virtio/virtio/v1.1/csprd01/virtio-v1.1-
>   csprd01.html, drivers/virtio/ and drivers/net/virtio_net.c. Algorithms
>   and data structures used by the virtio framework.

At a high level, you need more layering as it'll help to add more virtio based
devices over PCIe. Ideally all the vring/virtqueue part should be added as a
library.

You've modeled the endpoint side as virtio_device. However I would have
expected this to be vhost_dev and would have tried re-using some parts of vhost
(ignoring the userspace part). Was this considered during your design?
> 
> Signed-off-by: Haotian Wang <haotian.wang@sifive.com>
> ---
>  Documentation/PCI/endpoint/index.rst          |    1 +
>  .../PCI/endpoint/pci-epf-virtio-howto.rst     |  176 ++

Please add the Documentation as a separate patch.
>  MAINTAINERS                                   |    7 +
>  drivers/pci/endpoint/functions/Kconfig        |   45 +
>  drivers/pci/endpoint/functions/Makefile       |    1 +
>  .../pci/endpoint/functions/pci-epf-virtio.c   | 2043 +++++++++++++++++
>  include/linux/pci-epf-virtio.h                |  253 ++
>  7 files changed, 2526 insertions(+)
>  create mode 100644 Documentation/PCI/endpoint/pci-epf-virtio-howto.rst
>  create mode 100644 drivers/pci/endpoint/functions/pci-epf-virtio.c
>  create mode 100644 include/linux/pci-epf-virtio.h
> 
> diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
> index d114ea74b444..ac396afb3e99 100644
> --- a/Documentation/PCI/endpoint/index.rst
> +++ b/Documentation/PCI/endpoint/index.rst
> @@ -11,3 +11,4 @@ PCI Endpoint Framework
>     pci-endpoint-cfs
>     pci-test-function
>     pci-test-howto
> +   pci-epf-virtio-howto
> diff --git a/Documentation/PCI/endpoint/pci-epf-virtio-howto.rst b/Documentation/PCI/endpoint/pci-epf-virtio-howto.rst
> new file mode 100644
> index 000000000000..f62d830ab820
> --- /dev/null
> +++ b/Documentation/PCI/endpoint/pci-epf-virtio-howto.rst
> @@ -0,0 +1,176 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==========================================
> +PCI Virtio Net Endpoint Function Userguide
> +==========================================
> +
> +:Author: Haotian Wang <haotian.wang@sifive.com>
> +
> +This document provides steps to use the pci-epf-virtio endpoint function driver
> +on the PCI endpoint, together with virtio_net on the PCI host side, to achieve a
> +virtual ethernet connection between the two ends.
> +
> +Host Device
> +===========
> +
> +Build the host kernel with virtio, virtio_pci, virtio_pci_legacy, virtio_net as
> +BUILT-IN modules. The locations of these configurations in `make menuconfig`
> +are:
> +
> +	virtio: Device Drivers/Virtio drivers
> +	virtio_pci: Device Drivers/Virtio drivers/PCI driver for virtio devices
> +	virtio_pci_legacy: Device Drivers/Virtio drivers/Support for legacy
> +			   virtio draft 0.9.X and older devices
> +	virtio_net: Device Drivers/Network device support/Virtio network driver
> +
> +After `make menuconfig`, make sure these config options are set to "=y" in the
> +.config file:
> +
> +	CONFIG_VIRTIO
> +	CONFIG_VIRTIO

^^redundant line.
> +	CONFIG_VIRTIO_PCI_LEGACY
> +	CONFIG_VIRTIO_NET
> +
> +CONFIG_PCI_HOST_LITTLE_ENDIAN must be set at COMPILE TIME. Toggle it on to build
> +the module with the PCI host being in little endianness.

It would be better if we could get the endianness of the host at runtime. That
way irrespective of the host endianness we could use the same kernel image in
endpoint.
> +
> +Build the kernel with the .config file. These are all the requirements for the
> +host side.
> +
> +Endpoint Device
> +===============
> +
> +Required Modules
> +----------------
> +
> +pci-epf-virtio relies on PCI_ENDPOINT, PCI_ENDPOINT_CONFIGFS, VIRTIO, VIRTIO_NET
> +to function properly. Make sure those are BUILT-IN. PCI_ENDPOINT_DMAENGINE and
> +PCI_EPF_VIRTIO_SUPPRESS_NOTIFICATION have to be turned on or off at compile time
> +for pci-epf-virtio to recognize these options.
> +
> +Enable PCI_ENDPOINT_DMAENGINE if your endpoint controller has an implementation

Presence of dma engine could come from epc_features. Or try to get dma channel
always and use mem_copy if that fails. config option for dmaengine looks
un-necessary.
> +for that feature. Enable PCI_EPF_VIRTIO_SUPPRESS_NOTIFICATION for possible
> +performance gain.
> +
> +Endpoint Function Drivers
> +-------------------------
> +
> +To find the list of endpoint function drivers in the kernel::
> +
> +	# ls /sys/bus/pci-epf/drivers
> +	  pci_epf_virtio
> +OR::
> +
> +	# ls /sys/kernel/config/pci_ep/functions
> +	  pci_epf_virtio
> +
> +Creating pci-epf-virtio Device
> +------------------------------
> +
> +Since CONFIG_PCI_ENDPOINT_CONFIGFS is enabled, use the following commands to
> +create a pci-epf-virtio device::
> +
> +	# mount -t configfs none /sys/kernel/config
> +	# cd /sys/kernel/config/pci_ep
> +	# mkdir functions/pci_epf_virtio/func1
> +
> +Now the device will be probed by the pci_epf_virtio driver.
> +
> +Binding pci-epf-virtio Device to Endpoint Controller
> +----------------------------------------------------
> +
> +A `ln` command on the configfs will call the `bind` function defined in
> +pci-epf-virtio.c. This will bind the endpoint device to the controller::
> +
> +	# ln -s functions/pci_epf_virtio/func1 controllers/<some string>.pcie_ep
> +
> +Starting the Link
> +-----------------
> +
> +Once the device is bound to the endpoint controller. Use the configfs to
> +actually start the link with the PCI host side::
> +
> +	# echo 1 > controllers/<some string>.pcie_ep/start
> +
> +Using pci-epf-virtio
> +====================
> +
> +Setting Up Network Interfaces
> +-----------------------------
> +
> +Once the PCI link is brought up, both the host and endpoint will see a virtual
> +network interface if running `ifconfig`. On the host side, the virtual network
> +interface will have a mac address 02:02:02:02:02:02. On the endpoint side, if
> +will be 04:04:04:04:04:04. An easy way to enable a virtual ethernet link between
> +the two is to give them IP addresses that belong to the same subnet. For
> +example, assume the interface on the host side is called "enp2s0", and the
> +interface on the endpoint side is called "eth0". Run the following commonds.
> +
> +On the host side::
> +
> +	# ifconfig enp2s0 192.168.1.1 up
> +
> +On the endpoint side::
> +
> +	# ifconfig eth0 192.168.1.2 up
> +
> +Please note that if the host side usually has a complete distro such as Ubuntu
> +or Fedora. In that case, it is better to use the NetworkManager GUI provided by
> +the distro to assign a static IP address to "enp2s0", because the GUI will keep
> +trying to overwrite `ifconfig` settings with its settings. At this point of
> +time, the link between the host and endpoint is established.
> +
> +Using the Virtual Ethernet Link
> +-------------------------------
> +
> +User can run any task between these two network interfaces as if there were a
> +physical ethernet cable between two network devices. `ssh`, `scp`, `ping` work
> +out of the box from either side to the other side. `wireshark` can be run to
> +monitor packet traffic on the virtual network interfaces. If `ip-forwarding` is
> +enabled on the host side, and the host has Internet access, the host can use
> +`iptables -t nat` or equivalent programs to set up packet routing between the
> +Internet and the endpoint.
> +
> +Endpoint pci-epf-virtio Runtime Module Parameters
> +-------------------------------------------------
> +
> +On the endpoint, all module parameters shown can be toggled at runtime::
> +
> +	# ls /sys/module/pci_epf_virtio/parameters
> +	  check_queues_usec_max
> +	  check_queues_usec_min
> +	  notif_poll_usec_max
> +	  notif_poll_usec_min
> +
> +If PCI_ENDPOINT_DMAENGINE is enabled at COMPILE TIME, there will be an
> +additional parameter, enable_dma.
> +
> +If PCI_EPF_VIRTIO_SUPPRESS_NOTIFICATION is enabled at COMPILE TIME, there will
> +be an additional parameter, event_suppression.
> +
> +check_queues_usec_min/max specify the range of interval in microseconds between
> +two consecutive polls of vring data structures on the host by the endpoint.
> +Lower these values for more frequent polling, which probably increases traffic
> +throughput but hogs more CPU resources on the endpoint. The default values for
> +this pair are 100/200.
> +
> +notif_poll_usec_min/max specify the range of interval in microseconds between
> +two consecutive polls of vring update notices from the host by the endpoint.
> +Lowering them has similar effect to lowering check_queues_usec_min/max. The
> +default values for this pair are 10/20.
> +
> +It should be noted that notif_poll_usec_min/max should be much smaller than
> +check_queues_usec_min/max because check_queues is a much heavier task than
> +notif_poll. check_queues is implemented as a last resort in case update notices
> +from the host are missed by the endpoint, and should not be done as frequently
> +as polling for update notices from the host.
> +
> +If enable_dma is set to true, dma transfer will be used for each packet
> +transfer. Right now enabling dma actually hurts performance, so this option is
> +not recommended. The default value is false.
> +
> +event_suppression is an int value. Recommended values are between 2 and 5. This
> +value is used by endpoint and host as a reference. For example, if it is set to
> +3, the host will only update the endpoint after each batch of 3 packets are
> +transferred. Without event suppression, both sides will try to signal the other
> +end after every single packet is transferred. The default value is 3.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 997a4f8fe88e..fe6c7651a894 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12384,6 +12384,13 @@ F:	drivers/pci/endpoint/
>  F:	drivers/misc/pci_endpoint_test.c
>  F:	tools/pci/
>  
> +PCI ENDPOINT VIRTIO NET FUNCTION
> +M:	Haotian Wang <haotian.wang@sifive.com>
> +L:	linux-pci@vger.kernel.org
> +S:	Supported
> +F:	drivers/pci/endpoint/functions/pci-epf-virtio.c
> +F:	include/linux/pci-epf-virtio.h
> +
>  PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
>  M:	Russell Currey <ruscur@russell.cc>
>  M:	Sam Bobroff <sbobroff@linux.ibm.com>
> diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
> index 8820d0f7ec77..e9e78fcd90d2 100644
> --- a/drivers/pci/endpoint/functions/Kconfig
> +++ b/drivers/pci/endpoint/functions/Kconfig
> @@ -12,3 +12,48 @@ config PCI_EPF_TEST
>  	   for PCI Endpoint.
>  
>  	   If in doubt, say "N" to disable Endpoint test driver.
> +
> +config PCI_EPF_VIRTIO
> +	tristate "PCI Endpoint virtio driver"
> +	depends on PCI_ENDPOINT
> +	select VIRTIO
> +	select VIRTIO_NET
> +	help
> +	   Enable this configuration option to enable the virtio net
> +	   driver for PCI Endpoint. Enabling this function driver automatically
> +	   selects virtio and virtio_net modules in your kernel build.
> +	   If the endpoint has this driver built-in or loaded, and
> +	   the PCI host enables virtio_net, the two systems can communicate
> +	   with each other via a pair of virtual network devices.
> +
> +	   If in doubt, say "N" to disable Endpoint virtio driver.
> +
> +config PCI_EPF_VIRTIO_SUPPRESS_NOTIFICATION
> +	bool "PCI Virtio Endpoint Function Notification Suppression"
> +	default n
> +	depends on PCI_EPF_VIRTIO
> +	help
> +	  Enable this configuration option to allow virtio queues to suppress
> +	  some notifications and interrupts. Normally the host and the endpoint
> +	  send a notification/interrupt to each other after each packet has been
> +	  provided/consumed. Notifications/Interrupts can be generally expensive
> +	  across the PCI bus. If this config is enabled, both sides will only
> +	  signal the other end after a batch of packets has been consumed/
> +	  provided. However, in reality, this option does not offer significant
> +	  performance gain so far.

Would be good to profile and document the bottle-neck so that this could be
improved upon.
> +
> +	  If in doubt, say "N" to enable this feature.
> +
> +config PCI_HOST_LITTLE_ENDIAN
> +	bool "PCI host will be in little endianness"
> +	depends on PCI_EPF_VIRTIO
> +	default y
> +	help
> +	  Enable this configuration option if the PCI host uses little endianness.
> +	  Disable it if the PCI host uses big endianness. pci-epf-virtio
> +	  leverages the functions of the legacy virtio framework. Legacy
> +	  virtio does not specify a fixed endianness used between systems. Thus,
> +	  at compile time, the user has to build the endpoint function with
> +	  the endianness of the PCI host already known.
> +
> +	  The default option assumes PCI host is little endian.
> diff --git a/drivers/pci/endpoint/functions/Makefile b/drivers/pci/endpoint/functions/Makefile
> index d6fafff080e2..9b5e72a324eb 100644
> --- a/drivers/pci/endpoint/functions/Makefile
> +++ b/drivers/pci/endpoint/functions/Makefile
> @@ -4,3 +4,4 @@
>  #
>  
>  obj-$(CONFIG_PCI_EPF_TEST)		+= pci-epf-test.o
> +obj-$(CONFIG_PCI_EPF_VIRTIO)		+= pci-epf-virtio.o
> diff --git a/drivers/pci/endpoint/functions/pci-epf-virtio.c b/drivers/pci/endpoint/functions/pci-epf-virtio.c
> new file mode 100644
> index 000000000000..5cc8cb02fb48
> --- /dev/null
> +++ b/drivers/pci/endpoint/functions/pci-epf-virtio.c
> @@ -0,0 +1,2043 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * PCI epf driver to implement virtio endpoint functionality
> + *
> + * Author: Haotian Wang <haotian.wang@sifive.com>
> + */
> +
> +#include <linux/io.h>
> +#include <linux/pci-epc.h>
> +#include <linux/pci-epf.h>
> +#include <linux/pci_regs.h>
> +#include <linux/module.h>
> +#include <linux/pci_ids.h>
> +#include <linux/random.h>
> +#include <linux/kernel.h>
> +#include <linux/virtio.h>
> +#include <linux/if_ether.h>
> +#include <linux/etherdevice.h>
> +#include <linux/slab.h>
> +#include <linux/virtio_ring.h>
> +#include <linux/virtio_byteorder.h>
> +#include <uapi/linux/virtio_pci.h>
> +#include <uapi/linux/virtio_net.h>
> +#include <uapi/linux/virtio_ring.h>
> +#include <uapi/linux/virtio_types.h>
> +#include <uapi/linux/sched/types.h>
> +#include <uapi/linux/virtio_config.h>
> +#include <linux/pci-epf-virtio.h>
> +
> +#ifdef CONFIG_PCI_EPF_VIRTIO_SUPPRESS_NOTIFICATION
> +static int event_suppression = EVENT_SUPPRESSION;
> +module_param(event_suppression, int, 0644);
> +#endif
> +static int notif_poll_usec_min = CATCH_NOTIFY_USEC_MIN;
> +module_param(notif_poll_usec_min, int, 0644);
> +static int notif_poll_usec_max = CATCH_NOTIFY_USEC_MAX;
> +module_param(notif_poll_usec_max, int, 0644);
> +static int check_queues_usec_min = CHECK_QUEUES_USEC_MIN;
> +module_param(check_queues_usec_min, int, 0644);
> +static int check_queues_usec_max = CHECK_QUEUES_USEC_MAX;
> +module_param(check_queues_usec_max, int, 0644);
> +#ifdef CONFIG_PCI_ENDPOINT_DMAENGINE
> +static bool enable_dma = ENABLE_DMA;
> +module_param(enable_dma, bool, 0644);
> +#endif
> +
> +/* Default information written to configfs */
> +static struct pci_epf_header virtio_header = {
> +	.vendorid	= PCI_VENDOR_ID_REDHAT_QUMRANET,
> +	.deviceid	= VIRTIO_DEVICE_ID,
> +	.baseclass_code = PCI_CLASS_OTHERS,
> +	.interrupt_pin	= PCI_INTERRUPT_INTA,
> +	.subsys_id	= VIRTIO_NET_SUBSYS_ID,
> +	.subsys_vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET,
> +};
> +
> +/* Default bar sizes */
> +static size_t bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };

Only use the BARs actually required by the function.
> +
> +/*
> + * Clear mapped memory of a map. If there is memory allocated using the
> + * pci-ep framework, that memory will be released.
> + *
> + * @map: a map struct pointer that will be unmapped
> + */
> +static void pci_epf_unmap(struct pci_epf_map *map)
> +{
> +	if (map->iobase) {

how about this instead..
	if (!map->iobase)
		return;

> +		struct pci_epf *const epf = map->epf;
> +		struct pci_epc *const epc = epf->epc;
> +
> +		pci_epc_unmap_addr(epc, epf->func_no, map->phys_iobase);
> +		pci_epc_mem_free_addr(epc, map->phys_iobase,
> +				      map->iobase, map->iosize);
> +		map->iobase = NULL;
> +		map->ioaddr = NULL;
> +		map->phys_ioaddr = 0;
> +		map->phys_iobase = 0;
> +	}
> +}
> +
> +/*
> + * Release all mapped memory in the cache of maps.
> + *
> + * @lhead: the struct list_head that chains all maps together
> + * @slab: slab pointer used to allocate the maps. They are required
> + *	  to free the map structs according to slab allocator API.
> + */
> +static void pci_epf_free_map_cache(struct list_head *lhead,
> +				   struct kmem_cache *slab)
> +{
> +	struct pci_epf_map *iter;
> +	struct pci_epf_map *temp;
> +
> +	list_for_each_entry_safe(iter, temp, lhead, node) {
> +		list_del(&iter->node);
> +		kmem_cache_free(slab, iter);
> +	}
> +}
> +
> +/*
> + * Initialize a struct pci_epf_map.
> + *
> + * @map: ptr to map to be initialized
> + * @epf: required for following mapping and unmapping action
> + * @align: alignment requirement that the PCI endpoint may have
> + */
> +static void pci_epf_map_init(struct pci_epf_map *map,
> +			     struct pci_epf *epf,
> +			     size_t align)
> +{
> +	memset(map, 0, sizeof(*map));
> +	map->epf = epf;
> +	map->epc = epf->epc;
> +	map->align = align;
> +	INIT_LIST_HEAD(&map->node);
> +}
> +
> +/*
> + * Check whether the requested memory region is already mapped by the map.
> + *
> + * @map: ptr to the map to be checked
> + * @host_addr: physical address of the memory region on the PCI host
> + * @size: size in bytes of the memory region to be requested
> + *
> + * Returns true if the map already maps the region. Returns false if the map
> + * does not map the requested region.
> + */
> +static inline bool pci_epf_map_match(struct pci_epf_map *map, u64 host_addr,
> +				     size_t size)
> +{
> +	return host_addr >= map->prev_host_base &&
> +	       host_addr + size <= map->prev_host_base + map->iosize;
> +}
> +
> +/*
> + * Map a requested memory region
> + *
> + * @map: map ptr to hold the mapped memory
> + * @host_addr: physical memory address of starting byte on PCI host
> + * @size: size in bytes of the requested region
> + *
> + * Returns 0 on success and a negative error number on failure
> + */
> +static int pci_epf_map(struct pci_epf_map *map,
> +		       u64 host_addr,
> +		       size_t size)
> +{
> +	struct pci_epc *const epc = map->epc;
> +	struct pci_epf *const epf = map->epf;
> +	struct device *dev = &epf->dev;
> +	void __iomem *iobase;
> +	phys_addr_t phys_iobase;
> +	u64 host_base;
> +	off_t offset;
> +	size_t align, iosize;
> +	int ret;
> +
> +	align = map->align;
> +	iosize = (align > PAGE_SIZE && size < align) ? align : size;

The align parameter should already be configured correctly by epc_features and
the size should be already handled by pci_epc_mem_alloc_addr().
> +	iobase = pci_epc_mem_alloc_addr(epc, &phys_iobase, iosize);
> +	if (!iobase) {
> +		dev_err(dev, "Failed to allocate address map\n");
> +		return -ENOMEM;
> +	}
> +
> +	host_base = host_addr;
> +	if (align > PAGE_SIZE)
> +		host_base &= ~(align - 1);

This looks unnecessary.
> +
> +	ret = pci_epc_map_addr(epc, epf->func_no,
> +			       phys_iobase, host_base, iosize);
> +	if (ret) {
> +		dev_err(dev, "Failed to map host address\n");
> +		pci_epc_mem_free_addr(epc, phys_iobase, iobase, iosize);
> +		return ret;
> +	}
> +
> +	offset = host_addr - host_base;
> +
> +	map->prev_host_base = host_base;
> +	map->iosize = iosize;
> +	map->iobase = iobase;
> +	map->ioaddr = iobase + offset;
> +	map->phys_iobase = phys_iobase;
> +	map->phys_ioaddr = phys_iobase + offset;
> +
> +	return 0;
> +}
> +
> +/*
> + * Get a best map ptr from the lru cache and map the requested memory region
> + *
> + * @lru_head: head of list linking all available pci_epf_map
> + * @host_addr: physical memory address of starting byte on PCI host
> + * @size: size in bytes of requested memory region
> + *
> + * Returns a ptr to the mapped struct pci_epf_map on success
> + * or an error pointer on failure. The caller must make sure to check
> + * for error pointer.
> + */
> +static struct pci_epf_map *pci_epf_get_map(struct list_head *lru_head,
> +					   u64 host_addr,
> +					   size_t size)
> +{
> +	int ret;
> +	struct pci_epf_map *map;
> +
> +	list_for_each_entry(map, lru_head, node) {
> +		if (pci_epf_map_match(map, host_addr, size)) {
> +			map->phys_ioaddr = map->phys_iobase + host_addr
> +					   - map->prev_host_base;
> +			map->ioaddr = (void __iomem *)(map->iobase + host_addr
> +						       - map->prev_host_base);
> +			list_move(&map->node, lru_head);
> +			return map;
> +		}
> +	}
> +
> +	map = list_last_entry(lru_head, struct pci_epf_map, node);
> +	list_move(&map->node, lru_head);
> +	pci_epf_unmap(map);
> +	ret = pci_epf_map(map, host_addr, size);
> +	if (ret)
> +		return ERR_PTR(ret);
> +	return map;
> +}
> +
> +/*
> + * These functions convert __virtio unsigned integers which are in PCI host
> + * endianness to unsigned integers in PCI endpoint endianness
> + */
> +static inline u16 epf_virtio16_to_cpu(__virtio16 val)
> +{
> +#ifdef CONFIG_PCI_HOST_LITTLE_ENDIAN
> +	return le16_to_cpu((__force __le16)val);
> +#else
> +	return be16_to_cpu((__force __be16)val);
> +#endif
> +}
> +
> +static inline u32 epf_virtio32_to_cpu(__virtio32 val)
> +{
> +#ifdef CONFIG_PCI_HOST_LITTLE_ENDIAN
> +	return le32_to_cpu((__force __le32)val);
> +#else
> +	return be32_to_cpu((__force __be32)val);
> +#endif
> +}
> +
> +static inline u64 epf_virtio64_to_cpu(__virtio64 val)
> +{
> +#ifdef CONFIG_PCI_HOST_LITTLE_ENDIAN
> +	return le64_to_cpu((__force __le64)val);
> +#else
> +	return be64_to_cpu((__force __be64)val);
> +#endif
> +}
> +
> +/*
> + * These functions convert unsigned integers in PCI endpoint endianness
> + * to __virtio unsigned integers in PCI host endianness
> + */
> +static inline __virtio16 epf_cpu_to_virtio16(u16 val)
> +{
> +#ifdef CONFIG_PCI_HOST_LITTLE_ENDIAN
> +	return (__force __virtio16)cpu_to_le16(val);
> +#else
> +	return (__force __virtio16)cpu_to_be16(val);
> +#endif
> +}
> +
> +static inline __virtio32 epf_cpu_to_virtio32(u32 val)
> +{
> +#ifdef CONFIG_PCI_HOST_LITTLE_ENDIAN
> +	return (__force __virtio32)cpu_to_le32(val);
> +#else
> +	return (__force __virtio32)cpu_to_be32(val);
> +#endif
> +}
> +
> +static inline __virtio64 epf_cpu_to_virtio64(u64 val)
> +{
> +#ifdef CONFIG_PCI_HOST_LITTLE_ENDIAN
> +	return (__force __virtio64)cpu_to_le64(val);
> +#else
> +	return (__force __virtio64)cpu_to_be64(val);
> +#endif
> +}
> +
> +/*
> + * Though locally __virtio unsigned integers have the exact same endianness
> + * as the normal unsigned integers. These functions are here for type
> + * consistency as required by sparse.
> + */
> +static inline u16 local_virtio16_to_cpu(__virtio16 val)
> +{
> +	return (__force u16)val;
> +}
> +
> +static inline u32 local_virtio32_to_cpu(__virtio32 val)
> +{
> +	return (__force u32)val;
> +}
> +
> +static inline u64 local_virtio64_to_cpu(__virtio64 val)
> +{
> +	return (__force u64)val;
> +}
> +
> +static inline __virtio16 local_cpu_to_virtio16(u16 val)
> +{
> +	return (__force __virtio16)val;
> +}
> +
> +static inline __virtio32 local_cpu_to_virtio32(u32 val)
> +{
> +	return (__force __virtio32)val;
> +}
> +
> +static inline __virtio64 local_cpu_to_virtio64(u64 val)
> +{
> +	return (__force __virtio64)val;
> +}
> +
> +/*
> + * Convert a __virtio16 in PCI host endianness to PCI endpoint endianness
> + * in place.
> + *
> + * @ptr: ptr to __virtio16 value in PCI host endianness
> + */
> +static inline void convert_to_local(__virtio16 *ptr)
> +{
> +	*ptr = (__force __virtio16)epf_virtio16_to_cpu(*ptr);
> +}
> +
> +/*
> + * Convert a local __virtio16 in PCI endpoint endianness to PCI host endianness
> + * in place.
> + *
> + * @ptr: ptr to  __virtio16 value in PCI endpoint endianness
> + */
> +static inline void convert_to_remote(__virtio16 *ptr)
> +{
> +	*ptr = epf_cpu_to_virtio16((__force u16)*ptr);
> +}
> +
> +/*
> + * These functions read from an IO memory address from PCI host and convert
> + * the value to PCI endpoint endianness.
> + */
> +static inline u16 epf_ioread16(void __iomem *addr)
> +{
> +	return epf_virtio16_to_cpu((__force __virtio16)ioread16(addr));
> +}
> +
> +static inline u32 epf_ioread32(void __iomem *addr)
> +{
> +	return epf_virtio32_to_cpu((__force __virtio32)ioread32(addr));
> +}
> +
> +static inline u64 epf_ioread64(void __iomem *addr)
> +{
> +	return epf_virtio64_to_cpu((__force __virtio64)readq(addr));
> +}
> +
> +/*
> + * These functions convert values to PCI host endianness and write those values
> + * to an IO memory address to the PCI host.
> + */
> +static inline void epf_iowrite16(u16 val, void __iomem *addr)
> +{
> +	iowrite16((__force u16)epf_cpu_to_virtio16(val), addr);
> +}
> +
> +static inline void epf_iowrite32(u32 val, void __iomem *addr)
> +{
> +	iowrite32((__force u32)epf_cpu_to_virtio32(val), addr);
> +}
> +
> +static inline void epf_iowrite64(u64 val, void __iomem *addr)
> +{
> +	writeq((__force u64)epf_cpu_to_virtio64(val), addr);
> +}
> +
> +/*
> + * Generate a 32 bit number representing the features supported by the device
> + * seen by virtio_pci_legacy on the PCI host across the bus.
> + *
> + * @features: feature bits supported by the device
> + * @len: number of supported features
> + */
> +static inline u32 generate_dev_feature32(const unsigned int *features, int len)
> +{
> +	u32 feature = 0;
> +	int index = len - 1;
> +
> +	for (; index >= 0; index--)
> +		feature |= BIT(features[index]);
> +	return feature;
> +}
> +
> +/*
> + * Generate a 64 bit number representing the features supported by the device
> + * seen by the local virtio modules on the PCI endpoint.
> + *
> + * @features: feature bits supported by the local device
> + * @len: number of supported features
> + */
> +static inline u64 generate_local_dev_feature64(const unsigned int *features,
> +					       int len)
> +{
> +	u64 feature = 0;
> +	int i = 0;
> +
> +	for (; i < len; i++)
> +		feature |= BIT_ULL(features[i]);
> +	return feature;
> +}
> +
> +/*
> + * Simulate an interrupt by the local virtio_net device to the local virtio_net
> + * drivers on the PCI endpoint. There will be no real irq. Instead, there
> + * is enough information to invoke callbacks associated with some virtqueue
> + * directly.
> + *
> + * @vring: the vring on which an "interrupt" occurs
> + * @dev: local device required for error reporting
> + */
> +static void epf_virtio_interrupt(struct vring *vring, struct device *dev)
> +{
> +	struct vring_virtqueue *const vvq = container_of(vring,
> +							 struct vring_virtqueue,
> +							 split.vring);
> +	struct virtqueue *const vq = &vvq->vq;
> +
> +	if (vvq->last_used_idx == local_virtio16_to_cpu(vring->used->idx)) {
> +		dev_dbg(dev, "no more work for vq %#06x\n", vq->index);
> +		return;
> +	}
> +	if (unlikely(vvq->broken)) {
> +		dev_err(dev, "virtuque %#06x is broken\n", vq->index);
> +		return;
> +	}
> +	if (vq->callback)
> +		vq->callback(vq);
> +}
> +
> +#ifdef CONFIG_PCI_EPF_VIRTIO_SUPPRESS_NOTIFICATION
> +/*
> + * Read local used_event written by the local virtio_ring module.
> + *
> + * @avail: local avail vring
> + *
> + * Returns an u16 representing the used event idx
> + */
> +static inline u16 read_local_used_event(struct vring_avail *avail)
> +{
> +	return local_virtio16_to_cpu(avail->ring[EPF_VIRTIO_QUEUE_SIZE]);
> +}
> +
> +/*
> + * Write local avail_event read by the local virtio_ring module.
> + *
> + * @used: local used vring
> + * @val: the avail_event value to be written
> + */
> +static inline void write_local_avail_event(struct vring_used *used, u16 val)
> +{
> +	*(__force u16 *)&used->ring[EPF_VIRTIO_QUEUE_SIZE] = val;
> +}
> +
> +/*
> + * Read remote used_event written by remote virtio_ring module
> + *
> + * @avail: IO memory address of the avail ring on PCI host
> + *
> + * Returns an u16 representing the used event idx
> + */
> +static inline u16 read_used_event(void __iomem *avail)
> +{
> +	return epf_ioread16(IO_MEMBER_ARR_ELEM_PTR(avail,
> +						   struct vring_avail,
> +						   ring,
> +						   __virtio16,
> +						   EPF_VIRTIO_QUEUE_SIZE));
> +}
> +
> +/*
> + * Write remote avail event read by remote virtio_ring module
> + *
> + * @used: IO memory address of the used ring on PCI host
> + * @val: avail event in endpoint endianness to be written
> + */
> +static inline void write_avail_event(void __iomem *used, u16 val)
> +{
> +	epf_iowrite16(val, IO_MEMBER_ARR_ELEM_PTR(used,
> +						  struct vring_used,
> +						  ring,
> +						  struct vring_used_elem,
> +						  EPF_VIRTIO_QUEUE_SIZE));
> +}
> +#endif
> +
> +/*
> + * Increase a local __virtio16 value by some increment in place. idx_shadow
> + * will store the corresponding u16 value after increment in PCI endpoint
> + * endianness.
> + *
> + * @idx: ptr to the __virtio16 value to be incremented
> + * @idx_shadow: ptr to the u16 value to store the incremented value
> + * @increment: amount of increment
> + */
> +static inline void advance_idx(__virtio16 *idx,
> +			       u16 *idx_shadow,
> +			       int increment)
> +{
> +	*idx_shadow = local_virtio16_to_cpu(*idx) + increment;
> +	*idx = local_cpu_to_virtio16(*idx_shadow);
> +}
> +
> +/*
> + * Increase a remote __virtio16 value by some increment in place. idx_shadow
> + * will store the corresponding u16 value after increment in PCI endpoint
> + * endianness.
> + *
> + * @idx: IO memory address of the remote __virtio16 value to be incremented
> + * @idx_shadow: ptr to u16 value that stores the incremented value in PCI
> + *		endpoint endianness
> + * @increment: amount of increment
> + */
> +static inline void advance_idx_remote(void __iomem *idx,
> +				      u16 *idx_shadow,
> +				      int increment)
> +{
> +	*idx_shadow = epf_ioread16(idx) + increment;
> +	epf_iowrite16(*idx_shadow, idx);
> +}
> +
> +/*
> + * Function called when local endpoint function wants to notify the local
> + * virtio device about new available buffers.
> + *
> + * @vq: virtqueue where new notification occurs
> + *
> + * Returns true always
> + */
> +static inline bool epf_virtio_local_notify(struct virtqueue *vq)
> +{
> +#ifdef CONFIG_PCI_EPF_VIRTIO_SUPPRESS_NOTIFICATION
> +	__virtio16 avail_event;
> +#endif
> +	const u32 index = vq->index;
> +	struct epf_virtio_device *const epf_vdev = vq->priv;
> +	atomic_t *const local_pending = epf_vdev->local_pending;
> +
> +	if (index)
> +		atomic_cmpxchg(local_pending, 0, 1);
> +#ifdef CONFIG_PCI_EPF_VIRTIO_SUPPRESS_NOTIFICATION
> +	avail_event = epf_vdev->vrings[index]->avail->idx;
> +	write_local_avail_event(epf_vdev->vrings[index]->used,
> +				local_virtio16_to_cpu(avail_event)
> +				+ event_suppression);
> +#endif
> +	return true;
> +}
> +
> +/*
> + * Delete all vring_virtqueues of the local virtio_device
> + *
> + * @vdev: local virtio device
> + */
> +static void epf_virtio_local_del_vqs(struct virtio_device *vdev)
> +{
> +	int i;
> +	struct vring *vr;
> +	struct vring_virtqueue *vvq;
> +	struct epf_virtio_device *const epf_vdev = vdev_to_epf_vdev(vdev);
> +
> +	for (i = 0; i < 2; i++) {
> +		vr = epf_vdev->vrings[i];
> +		if (vr) {
> +			vvq = container_of(vr, struct vring_virtqueue,
> +					   split.vring);
> +			vring_del_virtqueue(&vvq->vq);
> +		}
> +	}
> +}
> +
> +/*
> + * Get value from the virtio network config of the local virtio device.
> + *
> + * @vdev: local virtio device
> + * @offset: offset of starting memory address from the start of local
> + *	    virtio network config in bytes
> + * @buf: virtual memory address to store the value
> + * @len: size of requested data in bytes
> + */
> +static inline void epf_virtio_local_get(struct virtio_device *vdev,
> +					unsigned int offset,
> +					void *buf,
> +					unsigned int len)
> +{
> +	memcpy(buf,
> +	       (void *)&vdev_to_epf_vdev(vdev)->local_net_cfg + offset,
> +	       len);
> +}

Have all this network specific parts in a separate file. Use the layering
structure similar to vhost.
> +
> +/*
> + * Set a value in the virtio network config of the local virtio device.
> + *
> + * @vdev: local virtio device
> + * @offset: offset of starting memory address from start of local virtio
> + *	    network config in bytes
> + * @buf: source of data in virtual memory
> + * @len: size of data in bytes
> + */
> +static inline void epf_virtio_local_set(struct virtio_device *vdev,
> +					unsigned int offset,
> +					const void *buf,
> +					unsigned int len)
> +{
> +	memcpy((void *)&vdev_to_epf_vdev(vdev)->local_net_cfg + offset,
> +	       buf,
> +	       len);
> +}
> +
> +/* Dummy function */
> +static inline u32 epf_virtio_local_generation(struct virtio_device *vdev)
> +{
> +	return 0;
> +}
> +
> +/*
> + * Get status of local virtio device.
> + *
> + * @vdev: local virtio device
> + *
> + * Returns a byte representing the status of the device.
> + */
> +static inline u8 epf_virtio_local_get_status(struct virtio_device *vdev)
> +{
> +	return vdev_to_epf_vdev(vdev)->local_cfg.dev_status;
> +}
> +
> +/*
> + * Set the status of the local virtio device
> + *
> + * @vdev: local virtio device
> + * @status: a byte that will be written to the status of local virtio device
> + */
> +static inline void epf_virtio_local_set_status(struct virtio_device *vdev,
> +					       u8 status)
> +{
> +	WARN_ON(status == 0);
> +	vdev_to_epf_vdev(vdev)->local_cfg.dev_status = status;
> +}
> +
> +/*
> + * Simulate a "reset" action on the local virtio device
> + *
> + * @vdev: local virtio device
> + */
> +static inline void epf_virtio_local_reset(struct virtio_device *vdev)
> +{
> +	vdev_to_epf_vdev(vdev)->local_cfg.dev_status = 0;
> +}
> +
> +/*
> + * Allocate and initialize vrings for the local virtio device. irq affinity
> + * is not implemented, and this endpoint function does not yet support
> + * msix features of virtio_net.
> + *
> + * @vdev: local virtio device
> + * @nvqs: number of virtqueues to create. 2 for virtio_net device.
> + * @vqs: array of pointers that store the memory addresses of vrings
> + * @callbacks: callback functions associated with each vring. The interrupt
> + *	       callback function will be called when an "interrupt" is
> + *	       simulated on that vring.
> + * @names: names of vrings
> + * @ctx: not implemented because msix is not enabled
> + * @desc: not implemented because msix is not enabled
> + *
> + * Returns 0 on success and a negative error number on failure
> + */
> +static int epf_virtio_local_find_vqs(struct virtio_device *vdev,
> +				     unsigned int nvqs,
> +				     struct virtqueue *vqs[],
> +				     vq_callback_t *callbacks[],
> +				     const char * const names[],
> +				     const bool *ctx,
> +				     struct irq_affinity *desc)
> +{
> +	int i;
> +	int queue_idx = 0;
> +	struct virtqueue *vq;
> +	struct vring_virtqueue *vvq;
> +	struct epf_virtio_device *const epf_vdev = vdev_to_epf_vdev(vdev);
> +
> +	for (i = 0; i < nvqs; i++) {
> +		if (!names[i]) {
> +			vqs[i] = NULL;
> +			continue;
> +		}
> +		vq = vring_create_virtqueue(queue_idx++,
> +					    EPF_VIRTIO_QUEUE_SIZE,
> +					    VIRTIO_PCI_VRING_ALIGN,
> +					    vdev,
> +					    true,
> +					    false,
> +					    ctx ? ctx[i] : false,
> +					    epf_virtio_local_notify,
> +					    callbacks[i],
> +					    names[i]);
> +		if (!vq)
> +			goto out_del_vqs;
> +		vqs[i] = vq;
> +		vvq = container_of(vq, struct vring_virtqueue, vq);
> +		epf_vdev->vrings[i] = &vvq->split.vring;
> +		vq->priv = epf_vdev;
> +	}
> +	return 0;
> +out_del_vqs:
> +	epf_virtio_local_del_vqs(vdev);
> +	return -ENOMEM;
> +}
> +
> +/*
> + * Get features advertised by the local virtio device.
> + *
> + * @vdev: local virtio device
> + *
> + * Returns a 64 bit integer representing the features advertised by the device.
> + */
> +static inline u64 epf_virtio_local_get_features(struct virtio_device *vdev)
> +{
> +	return vdev_to_epf_vdev(vdev)->local_cfg.dev_feature;
> +}
> +
> +/*
> + * Finalize features supported by both the local virtio device and the local
> + * virtio drivers.
> + *
> + * @vdev: local virtio device
> + *
> + * Always returns 0.
> + */
> +static int epf_virtio_local_finalize_features(struct virtio_device *vdev)
> +{
> +	struct epf_virtio_device *const epf_vdev = vdev_to_epf_vdev(vdev);
> +
> +	vring_transport_features(vdev);
> +	epf_vdev->local_cfg.drv_feature = vdev->features;
> +	return 0;
> +}
> +
> +/*
> + * Get the bus name of the local virtio device.
> + *
> + * @vdev: local virtio device
> + *
> + * Returns the local bus name. It will always be "epf_virtio_local_bus".
> + */
> +static inline const char *epf_virtio_local_bus_name(struct virtio_device *vdev)
> +{
> +	return "epf_virtio_local_bus";
> +}
> +
> +/* Dummpy function. msix is not enabled. */
> +static inline int
> +	epf_virtio_local_set_vq_affinity(struct virtqueue *vq,
> +					 const struct cpumask *cpu_mask)
> +{
> +	return 0;
> +}
> +
> +/* Dummpy function. msix is not enabled. */
> +static inline const struct cpumask *
> +	epf_virtio_local_get_vq_affinity(struct virtio_device *vdev,
> +					 int index)
> +{
> +	return NULL;
> +}
> +
> +/* This function table will be used by local virtio modules. */
> +static const struct virtio_config_ops epf_virtio_local_dev_config_ops = {
> +	.get = epf_virtio_local_get,
> +	.set = epf_virtio_local_set,
> +	.get_status = epf_virtio_local_get_status,
> +	.set_status = epf_virtio_local_set_status,
> +	.reset = epf_virtio_local_reset,
> +	.find_vqs = epf_virtio_local_find_vqs,
> +	.del_vqs = epf_virtio_local_del_vqs,
> +	.get_features = epf_virtio_local_get_features,
> +	.finalize_features = epf_virtio_local_finalize_features,
> +	.bus_name = epf_virtio_local_bus_name,
> +	.set_vq_affinity = epf_virtio_local_set_vq_affinity,
> +	.get_vq_affinity = epf_virtio_local_get_vq_affinity,
> +	.generation = epf_virtio_local_generation,
> +};
> +
> +/*
> + * Initializes the virtio_pci and virtio_net config space that will be exposed
> + * to the remote virtio_pci and virtio_net modules on the PCI host. This
> + * includes setting up feature negotiation and default config setup etc.
> + *
> + * @epf_virtio: epf_virtio handler
> + */
> +static void pci_epf_virtio_init_cfg_legacy(struct pci_epf_virtio *epf_virtio)
> +{
> +	const u32 dev_feature =
> +		generate_dev_feature32(features, ARRAY_SIZE(features));
> +	struct virtio_legacy_cfg *const legacy_cfg = epf_virtio->reg[BAR_0];

virtio_reg_bar instead of BAR_0
> +	/* msix is disabled */
> +	struct virtio_net_config *const net_cfg = (void *)legacy_cfg +
> +						  VIRTIO_PCI_CONFIG_OFF(0);
> +
> +	epf_virtio->legacy_cfg = legacy_cfg;
> +	epf_virtio->net_cfg = net_cfg;
> +
> +	/* virtio PCI legacy cfg */
> +	legacy_cfg->q_select = epf_cpu_to_virtio16(2);
> +	legacy_cfg->q_size = epf_cpu_to_virtio16(EPF_VIRTIO_QUEUE_SIZE);
> +	legacy_cfg->dev_feature = epf_cpu_to_virtio32(dev_feature);
> +	legacy_cfg->q_notify = epf_cpu_to_virtio16(2);
> +	legacy_cfg->isr_status = VIRTIO_PCI_ISR_HIGH;
> +
> +	/* virtio net specific cfg */
> +	net_cfg->max_virtqueue_pairs = (__force __u16)epf_cpu_to_virtio16(1);
> +	memcpy(net_cfg->mac, host_mac, ETH_ALEN);
> +	dev_info(&epf_virtio->epf->dev,
> +		 "dev_feature is %#010x\n",
> +		 epf_virtio32_to_cpu(epf_virtio->legacy_cfg->dev_feature));
> +}
> +
> +/*
> + * Handles the actual transfer of data across PCI bus. Supports both read
> + * and write.
> + *
> + * @epf_virtio: epf_virtio handler
> + * @write: true for write from endpoint to host and false for read from host
> + *	   to endpoint
> + * @remote_addr: physical address on PCI host
> + * @buf: virtual address on PCI endpoint
> + * @len: size of data transfer in bytes
> + * @lhead: list head that links the cache of available maps
> + *
> + * Returns 0 on success and a negative error number on failure.
> + */
> +static int epf_virtio_rw(struct pci_epf_virtio *epf_virtio, bool write,
> +			 u64 remote_addr, void *buf, int len,
> +			 struct list_head *lhead)
> +{
> +#ifdef CONFIG_PCI_ENDPOINT_DMAENGINE
> +	int ret = 0;
> +	phys_addr_t src_addr;
> +	phys_addr_t dst_addr;
> +	struct device *const dma_dev = epf_virtio->epf->epc->dev.parent;
> +#endif
> +	struct device *const dev = &epf_virtio->epf->dev;
> +	struct pci_epf_map *const map = pci_epf_get_map(lhead,
> +							remote_addr,
> +							len);
> +	if (IS_ERR(map)) {
> +		dev_err(dev, "EPF map failed before io\n");
> +		return PTR_ERR(map);
> +	}
> +#ifdef CONFIG_PCI_ENDPOINT_DMAENGINE
> +	if (enable_dma) {
> +		if (write) {
> +			src_addr = dma_map_single(dma_dev,
> +						  buf,
> +						  len,
> +						  DMA_TO_DEVICE);
> +			if (dma_mapping_error(dma_dev,
> +					      src_addr)) {
> +				dev_err(dev,
> +					"Failed to map src buffer address\n");
> +				ret = -ENOMEM;
> +				goto out;
> +			}
> +			ret = pci_epf_tx(epf_virtio->epf,
> +					 map->phys_ioaddr,
> +					 src_addr,
> +					 len);
> +			dma_unmap_single(dma_dev,
> +					 src_addr,
> +					 len,
> +					 DMA_TO_DEVICE);
> +			if (ret)
> +				dev_err(dev, "DMA transfer failed\n");
> +		} else {
> +			dst_addr = dma_map_single(dma_dev,
> +						  buf,
> +						  len,
> +						  DMA_FROM_DEVICE);
> +			if (dma_mapping_error(dma_dev,
> +					      dst_addr)) {
> +				dev_err(dev,
> +					"Failed to map dst address\n");
> +				ret = -ENOMEM;
> +				goto out;
> +			}
> +			ret = pci_epf_tx(epf_virtio->epf,
> +					 dst_addr,
> +					 map->phys_ioaddr,
> +					 len);
> +			dma_unmap_single(dma_dev,
> +					 dst_addr,
> +					 len,
> +					 DMA_FROM_DEVICE);
> +			if (ret)
> +				dev_err(dev, "DMA transfer failed\n");
> +		}
> +	} else {
> +		if (write)
> +			memcpy_toio(map->ioaddr, buf, len);
> +		else
> +			memcpy_fromio(buf, map->ioaddr, len);
> +	}
> +	return 0;
> +out:
> +	pci_epf_unmap(map);
> +	return ret;
> +#else
> +	if (write)
> +		memcpy_toio(map->ioaddr, buf, len);
> +	else
> +		memcpy_fromio(buf, map->ioaddr, len);
> +	return 0;
> +#endif
> +}
> +
> +/*
> + * Free memory allocated on PCI endpoint that is used to store data
> + * about the vrings on PCI host.
> + *
> + * @epf_virtio: epf_virtio handler
> + * @n: number of vrings' information to be freed on PCI endpoint
> + */
> +static void free_vring_info(struct pci_epf_virtio *epf_virtio, int n)
> +{
> +	int i;
> +
> +	for (i = n; i >= 0; i--) {
> +		kfree(&epf_virtio->q_addrs[i]);
> +		kfree(&epf_virtio->q_pfns[i]);
> +		pci_epf_unmap(&epf_virtio->q_map[i]);
> +	}
> +}
> +
> +/*
> + * Allocate memory and store information about the vrings on PCI host.
> + * Information includes physical addresses of vrings and different members
> + * of those vrings.
> + *
> + * @epf_virtio: epf_virtio handler
> + *
> + * Returns 0 on success and a negative error number on failure.
> + */
> +static int store_host_vring(struct pci_epf_virtio *epf_virtio)
> +{
> +	struct pci_epf_map *map;
> +	int ret;
> +	int n;
> +	__virtio32 q_pfn;
> +	void __iomem *tmp_ptr;
> +
> +	for (n = 0; n < 2; n++) {
> +		map = &epf_virtio->q_map[n];
> +		/*
> +		 * The left shift is applied because virtio_pci_legacy
> +		 * applied the right shift first
> +		 */
> +		q_pfn = (__force __virtio32)atomic_read(&epf_virtio->q_pfns[n]);
> +		epf_virtio->q_addrs[n] = epf_virtio32_to_cpu(q_pfn);
> +		ret = pci_epf_map(map,
> +				  epf_virtio->q_addrs[n]
> +				  << VIRTIO_PCI_QUEUE_ADDR_SHIFT,
> +				  vring_size(EPF_VIRTIO_QUEUE_SIZE,
> +					     VIRTIO_PCI_VRING_ALIGN));
> +		if (ret) {
> +			dev_err(&epf_virtio->epf->dev,
> +				"EPF mapping error storing host ring%d\n",
> +				n);
> +			free_vring_info(epf_virtio, n - 1);
> +			return ret;
> +		}
> +		/* Store the remote vring addresses according to virtio-legacy*/
> +		epf_virtio->desc[n] = map->ioaddr;
> +		epf_virtio->avail[n] = map->ioaddr
> +				       + EPF_VIRTIO_QUEUE_SIZE
> +				       * sizeof(struct vring_desc);
> +		tmp_ptr = IO_MEMBER_ARR_ELEM_PTR(epf_virtio->avail[n],
> +						 struct vring_avail,
> +						 ring,
> +						 __virtio16,
> +						 EPF_VIRTIO_QUEUE_SIZE);
> +		epf_virtio->used[n] =
> +			(void __iomem *)(((uintptr_t)tmp_ptr
> +					  + sizeof(__virtio16)
> +					  + VIRTIO_PCI_VRING_ALIGN - 1)
> +					 & ~(VIRTIO_PCI_VRING_ALIGN - 1));
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Catch notification sent by the PCI host to the PCI endpoint. This usually
> + * happens when the PCI host has provided a new available buffer and wants
> + * the PCI endpoint to process the new buffer. This function will set the
> + * pending bit atomically to 1. The transfer handler thread will then under-
> + * stand that there are more unprocessed buffers.
> + *
> + * @data: kthread context data. It is actually the epf_virtio handler.
> + *
> + * Always returns 0.
> + */
> +static int pci_epf_virtio_catch_notif(void *data)
> +{
> +	u16 changed;
> +#ifdef CONFIG_PCI_EPF_VIRTIO_SUPPRESS_NOTIFICATION
> +	void __iomem *avail_idx;
> +	u16 event;
> +#endif
> +
> +	register const __virtio16 default_notify = epf_cpu_to_virtio16(2);
> +
> +	struct pci_epf_virtio *const epf_virtio = data;
> +	atomic_t *const pending = epf_virtio->pending;
> +
> +	while (!kthread_should_stop()) {
> +		changed = epf_virtio16_to_cpu(epf_virtio->legacy_cfg->q_notify);
> +		if (changed != 2) {
> +			epf_virtio->legacy_cfg->q_notify = default_notify;
> +			/* The pci host has made changes to virtqueues */
> +			if (changed)
> +				atomic_cmpxchg(pending, 0, 1);
> +#ifdef CONFIG_PCI_EPF_VIRTIO_SUPPRESS_NOTIFICATION
> +			avail_idx = IO_MEMBER_PTR(epf_virtio->avail[changed],
> +						  struct vring_avail,
> +						  idx);
> +			event = epf_ioread16(avail_idx) + event_suppression;
> +			write_avail_event(epf_virtio->used[changed], event);
> +#endif
> +		}
> +		usleep_range(notif_poll_usec_min,
> +			     notif_poll_usec_max);
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Transfer data from PCI host to PCI endpoint. Physical addresses of memory
> + * to read from are not passed in as parameters. Instead they are stored in
> + * the epf_virtio handler.
> + *
> + * @desc: local descriptor to store the data
> + * @epf_virtio: epf_virtio handler
> + * @cache_head: list head that links all the available maps
> + */
> +static void fill_ep_buf(struct vring_desc *desc,
> +			struct pci_epf_virtio *epf_virtio,
> +			struct list_head *cache_head)
> +{
> +	int ret;
> +	u64 local_addr;
> +	u16 flags;
> +	struct mem_frag *const hdr_frag = &epf_virtio->frags[0];
> +	struct mem_frag *const frag = &epf_virtio->frags[1];
> +	struct virtio_net_hdr *hdr;
> +	void *buf;
> +
> +	local_addr = local_virtio64_to_cpu(desc->addr);
> +	hdr = phys_to_virt((phys_addr_t)local_addr);
> +	ret = epf_virtio_rw(epf_virtio, false,
> +			    hdr_frag->addr, hdr,
> +			    hdr_frag->len, cache_head);
> +	if (ret)
> +		dev_err(&epf_virtio->epf->dev,
> +			"Read header failed\n");
> +	buf = (void *)hdr + hdr_frag->len;
> +	ret = epf_virtio_rw(epf_virtio, false, frag->addr, buf,
> +			    frag->len, cache_head);
> +	if (ret)
> +		dev_err(&epf_virtio->epf->dev,
> +			"Read data failed\n");
> +	flags = local_virtio16_to_cpu(desc->flags);
> +	desc->flags =
> +		local_cpu_to_virtio16(flags & ~(VRING_DESC_F_NEXT));
> +	desc->len = local_cpu_to_virtio32(frag->len + hdr_frag->len);
> +}
> +
> +/*
> + * Transfer data from PCI endpoint to PCI host. Physical addresses of local
> + * memory to write from are not passed in as parameters. Instead, they are
> + * stored in the epf_virtio_device in the epf_virtio handler.
> + *
> + * @desc: IO memory of the remote descriptor on PCI host to hold the data
> + * @epf_virtio: epf_virtio handler
> + * @cache_head: list head that links all the available maps
> + */
> +static void fill_host_buf(void __iomem *desc,
> +			  struct pci_epf_virtio *epf_virtio,
> +			  struct list_head *cache_head)
> +{
> +	int ret;
> +	u64 remote_addr;
> +	struct mem_frag *const hdr_frag =
> +		&epf_virtio->epf_vdev.local_frags[0];
> +	struct mem_frag *const frag = &epf_virtio->epf_vdev.local_frags[1];
> +	void __iomem *const flag_addr = IO_MEMBER_PTR(desc,
> +						      struct vring_desc,
> +						      flags);
> +	struct virtio_net_hdr *hdr;
> +	void *buf;
> +	u16 flags;
> +
> +	hdr = phys_to_virt((phys_addr_t)hdr_frag->addr);
> +	buf = phys_to_virt((phys_addr_t)frag->addr);
> +	remote_addr = epf_ioread64(IO_MEMBER_PTR(desc,
> +						 struct vring_desc,
> +						 addr));
> +	ret = epf_virtio_rw(epf_virtio, true, remote_addr, hdr,
> +			    hdr_frag->len, cache_head);
> +	if (ret)
> +		dev_err(&epf_virtio->epf->dev,
> +			"Write header failed\n");
> +
> +	remote_addr += hdr_frag->len;
> +	ret = epf_virtio_rw(epf_virtio, true, remote_addr, buf,
> +			    frag->len, cache_head);
> +	if (ret)
> +		dev_err(&epf_virtio->epf->dev,
> +			"write data failed\n");
> +	epf_iowrite32(frag->len + hdr_frag->len,
> +		      IO_MEMBER_PTR(desc,
> +				    struct vring_desc,
> +				    len));
> +	flags = epf_ioread16(flag_addr);
> +	epf_iowrite16(flags & ~(VRING_DESC_F_NEXT), flag_addr);
> +}
> +
> +/*
> + * Handle transfer from PCI host to PCI endpoint. This runs in a dedicated
> + * kernel thread infinitely unless the thread is stopped. This thread
> + * continuously polls for available buffers provided by PCI host and puts
> + * them in right places on PCI endpoint.
> + *
> + * @data: kthread context. Actually a epf_virtio handler.
> + *
> + * Always return 0. Only return when thread is stopped.
> + */
> +static int pci_epf_virtio_handle_tx(void *data)
> +{
> +	int i;
> +	u32 total_size;
> +	u16 idx_shadow;
> +	u16 local_idx_shadow;
> +#ifdef CONFIG_PCI_EPF_VIRTIO_SUPPRESS_NOTIFICATION
> +	u16 local_used_event;
> +	u16 used_event;
> +#endif
> +	u16 num_desc;
> +	__virtio16 desc_idx;
> +	u16 used_idx_modulo;
> +	u16 local_used_idx_modulo;
> +	u16 used_idx;
> +	u16 local_used_idx;
> +	struct mem_frag *remote_frag;
> +	void __iomem *desc;
> +	void __iomem *desc_next;
> +	void __iomem *avail_used_ptr;
> +	void __iomem *used_used_ptr;
> +	struct pci_epf_virtio *const epf_virtio = data;
> +	atomic_t *const pending = epf_virtio->pending;
> +	struct epf_virtio_device *const epf_vdev = &epf_virtio->epf_vdev;
> +	struct vring *const local_rx_vring = epf_vdev->vrings[0];
> +	struct vring_desc *const local_desc_head = local_rx_vring->desc;
> +	struct vring_desc *local_desc = local_desc_head;
> +	struct vring_used *const local_used = local_rx_vring->used;
> +	struct vring_avail *const local_avail = local_rx_vring->avail;
> +	struct pci_epf *epf = epf_virtio->epf;
> +	struct pci_epc *epc = epf->epc;
> +	void __iomem *const desc_head = epf_virtio->desc[1];
> +	void __iomem *const avail = epf_virtio->avail[1];
> +	void __iomem *const used = epf_virtio->used[1];
> +re_entry:
> +	if (kthread_should_stop())
> +		return 0;
> +#ifdef CONFIG_PCI_EPF_VIRTIO_SUPPRESS_NOTIFICATION
> +	local_used_event = 0;
> +	used_event = 0;
> +#endif
> +	num_desc = 0;
> +	used_idx = epf_ioread16(IO_MEMBER_PTR(used, struct vring_used, idx));
> +	local_used_idx = local_virtio16_to_cpu(local_used->idx);
> +	while (used_idx != epf_ioread16(IO_MEMBER_PTR(avail,
> +						      struct vring_avail,
> +						      idx))) {
> +		total_size = 0;
> +		used_idx_modulo = MODULO_QUEUE_SIZE(used_idx);
> +		local_used_idx_modulo = MODULO_QUEUE_SIZE(local_used_idx);
> +		avail_used_ptr = IO_MEMBER_ARR_ELEM_PTR(avail,
> +							struct vring_avail,
> +							ring,
> +							__virtio16,
> +							used_idx_modulo);
> +		used_used_ptr = IO_MEMBER_ARR_ELEM_PTR(used,
> +						       struct vring_used,
> +						       ring,
> +						       struct vring_used_elem,
> +						       used_idx_modulo);
> +		desc = IO_ARR_ELEM_PTR(desc_head,
> +				       struct vring_desc,
> +				       epf_ioread16(avail_used_ptr));
> +		for (i = 0; i < 2; i++) {
> +			remote_frag = &epf_virtio->frags[i];
> +			remote_frag->addr =
> +				epf_ioread64(IO_MEMBER_PTR(desc,
> +							   struct vring_desc,
> +							   addr));
> +			remote_frag->len =
> +				epf_ioread32(IO_MEMBER_PTR(desc,
> +							   struct vring_desc,
> +							   len));
> +			total_size += remote_frag->len;
> +			desc_next = IO_MEMBER_PTR(desc,
> +						  struct vring_desc,
> +						  next);
> +			desc = IO_ARR_ELEM_PTR(desc_head,
> +					       struct vring_desc,
> +					       epf_ioread16(desc_next));
> +		}
> +
> +		/* Copy content into local buffer from remote frags */
> +		desc_idx = local_avail->ring[local_used_idx_modulo];
> +		local_desc =
> +			&local_desc_head[local_virtio16_to_cpu(desc_idx)];
> +		fill_ep_buf(local_desc, epf_virtio, &epf_virtio->lru_head);
> +
> +		/* Update used rings for both sides */
> +		local_used->ring[local_used_idx_modulo].id =
> +			(__force __virtio32)desc_idx;
> +		local_used->ring[local_used_idx_modulo].len =
> +			local_cpu_to_virtio32(total_size);
> +		epf_iowrite32((u32)epf_ioread16(avail_used_ptr),
> +			      IO_MEMBER_PTR(used_used_ptr,
> +					    struct vring_used_elem,
> +					    id));
> +		epf_iowrite32(total_size,
> +			      IO_MEMBER_PTR(used_used_ptr,
> +					    struct vring_used_elem,
> +					    len));
> +#ifdef CONFIG_PCI_EPF_VIRTIO_SUPPRESS_NOTIFICATION
> +		/* Only update index after contents are updated */
> +		wmb();
> +		advance_idx_remote(IO_MEMBER_PTR(used,
> +						 struct vring_used,
> +						 idx),
> +				   &idx_shadow,
> +				   1);
> +		used_event = read_used_event(avail);
> +		advance_idx(&local_used->idx, &local_idx_shadow,
> +			    1);
> +		local_used_event = read_local_used_event(local_avail);
> +		/* Only signal after indices are updated */
> +		mb();
> +		if (local_idx_shadow == local_used_event + 1)
> +			epf_virtio_interrupt(local_rx_vring,
> +					     &epf_vdev->vdev.dev);
> +		if (idx_shadow == used_event + 1)
> +			pci_epc_raise_irq(epc,
> +					  epf->func_no,
> +					  PCI_EPC_IRQ_LEGACY,
> +					  0);
> +#endif
> +		local_used_idx++;
> +		used_idx++;
> +		num_desc++;
> +	}
> +#ifndef CONFIG_PCI_EPF_VIRTIO_SUPPRESS_NOTIFICATION
> +	if (num_desc) {
> +		/* Only update index after contents are updated */
> +		wmb();
> +		advance_idx_remote(IO_MEMBER_PTR(used, struct vring_used, idx),
> +				   &idx_shadow,
> +				   num_desc);
> +		advance_idx(&local_used->idx, &local_idx_shadow,
> +			    num_desc);
> +		/* Only signal after indices are updated */
> +		mb();
> +		if (likely(!(epf_ioread16(IO_MEMBER_PTR(avail,
> +							struct vring_avail,
> +							flags))
> +			     & VRING_AVAIL_F_NO_INTERRUPT)))
> +			pci_epc_raise_irq(epc,
> +					  epf->func_no,
> +					  PCI_EPC_IRQ_LEGACY,
> +					  0);
> +		if (likely(!(local_virtio16_to_cpu(local_avail->flags)
> +			     & VRING_AVAIL_F_NO_INTERRUPT)))
> +			epf_virtio_interrupt(local_rx_vring,
> +					     &epf_vdev->vdev.dev);
> +	}
> +#endif
> +	if (!atomic_xchg(pending, 0))
> +		usleep_range(check_queues_usec_min,
> +			     check_queues_usec_max);
> +	goto re_entry;
> +}
> +
> +/*
> + * Handle transfer from PCI endpoint to PCI host and run in a dedicated kernel
> + * thread. This function does not need to poll for notifications sent by the
> + * local virtio driver modules. Instead the local virtio modules will call
> + * exactly functions in this file, which will directly set up transfer envi-
> + * ronments.
> + *
> + * @data: kthread context. Actually a epf_virtio handler.
> + *
> + * Always return 0. Only return when the kernel thread is stopped.
> + */
> +static int pci_epf_virtio_local_handle_tx(void *data)
> +{
> +	int i;
> +	u32 total_size;
> +	struct vring_desc *desc;
> +	u16 idx_shadow;
> +	u16 local_idx_shadow;
> +	u16 used_idx_modulo;
> +	u16 host_used_idx_modulo;
> +	u16 used_idx;
> +	__virtio16 desc_idx;
> +#ifdef CONFIG_PCI_EPF_VIRTIO_SUPPRESS_NOTIFICATION
> +	u16 host_used_event;
> +	u16 used_event;
> +#endif
> +	u16 num_desc;
> +	u16 host_used_idx;
> +	void __iomem *avail_used_ptr;
> +	void __iomem *used_used_ptr;
> +	struct mem_frag *local_frag;
> +	struct pci_epf_virtio *const epf_virtio = data;
> +	struct epf_virtio_device *const epf_vdev = &epf_virtio->epf_vdev;
> +	struct pci_epf *const epf = epf_virtio->epf;
> +	struct pci_epc *const epc = epf->epc;
> +	void __iomem *const host_desc_head = epf_virtio->desc[0];
> +	void __iomem *host_desc = host_desc_head;
> +	void __iomem *const host_avail = epf_virtio->avail[0];
> +	void __iomem *const host_used = epf_virtio->used[0];
> +	struct vring *const vr = epf_vdev->vrings[1];
> +	struct vring_desc *const desc_head = vr->desc;
> +	struct vring_used *const used = vr->used;
> +	struct vring_avail *const avail = vr->avail;
> +	atomic_t *const local_pending = epf_vdev->local_pending;
> +re_entry:
> +	if (kthread_should_stop())
> +		return 0;
> +#ifdef CONFIG_PCI_EPF_VIRTIO_SUPPRESS_NOTIFICATION
> +	host_used_event = 0;
> +	used_event = 0;
> +#endif
> +	num_desc = 0;
> +	used_idx = local_virtio16_to_cpu(used->idx);
> +	host_used_idx = epf_ioread16(IO_MEMBER_PTR(host_used,
> +						   struct vring_used,
> +						   idx));
> +	while (used_idx != local_virtio16_to_cpu(avail->idx)) {
> +		total_size = 0;
> +		used_idx_modulo = MODULO_QUEUE_SIZE(used_idx);
> +		host_used_idx_modulo = MODULO_QUEUE_SIZE(host_used_idx);
> +		desc_idx = avail->ring[used_idx_modulo];
> +		desc = &desc_head[local_virtio16_to_cpu(desc_idx)];
> +		avail_used_ptr = IO_MEMBER_ARR_ELEM_PTR(host_avail,
> +							struct vring_avail,
> +							ring,
> +							__virtio16,
> +							host_used_idx_modulo);
> +		used_used_ptr = IO_MEMBER_ARR_ELEM_PTR(host_used,
> +						       struct vring_used,
> +						       ring,
> +						       struct vring_used_elem,
> +						       host_used_idx_modulo);
> +		for (i = 0; i < 2; i++) {
> +			/* Only allocate if there is none available */
> +			local_frag = &epf_vdev->local_frags[i];
> +			local_frag->addr = local_virtio64_to_cpu(desc->addr);
> +			local_frag->len = local_virtio32_to_cpu(desc->len);
> +			total_size += local_virtio32_to_cpu(desc->len);
> +			desc = &desc_head[local_virtio16_to_cpu(desc->next)];
> +		}
> +
> +		host_desc = IO_ARR_ELEM_PTR(host_desc_head,
> +					    struct vring_desc,
> +					    epf_ioread16(avail_used_ptr));
> +		fill_host_buf(host_desc, epf_virtio, &epf_vdev->local_lru_head);
> +
> +		/* Update used rings for both sides */
> +		epf_iowrite32((u32)epf_ioread16(avail_used_ptr),
> +			      IO_MEMBER_PTR(used_used_ptr,
> +					    struct vring_used_elem,
> +					    id));
> +		epf_iowrite32(total_size,
> +			      IO_MEMBER_PTR(used_used_ptr,
> +					    struct vring_used_elem,
> +					    len));
> +		used->ring[used_idx_modulo].id =
> +			(__force __virtio32)avail->ring[used_idx_modulo];
> +		used->ring[used_idx_modulo].len =
> +			local_cpu_to_virtio32(total_size);
> +#ifdef CONFIG_PCI_EPF_VIRTIO_SUPPRESS_NOTIFICATION
> +		/* Only update index after contents are updated */
> +		wmb();
> +		advance_idx_remote(IO_MEMBER_PTR(host_used,
> +						 struct vring_used,
> +						 idx),
> +				   &idx_shadow,
> +				   1);
> +		advance_idx(&used->idx, &local_idx_shadow, 1);
> +		host_used_event = read_used_event(host_avail);
> +		used_event = read_local_used_event(avail);
> +		/* Only signal after indices are updated */
> +		mb();
> +		if (local_idx_shadow == used_event + 1)
> +			epf_virtio_interrupt(vr, &epf_vdev->vdev.dev);
> +		if (idx_shadow == host_used_event + 1)
> +			pci_epc_raise_irq(epc,
> +					  epf->func_no,
> +					  PCI_EPC_IRQ_LEGACY,
> +					  0);
> +#endif
> +		host_used_idx++;
> +		used_idx++;
> +		num_desc++;
> +	}
> +#ifndef CONFIG_PCI_EPF_VIRTIO_SUPPRESS_NOTIFICATION
> +	if (num_desc) {
> +		/* Only update index after contents are updated */
> +		wmb();
> +		advance_idx_remote(IO_MEMBER_PTR(host_used,
> +						 struct vring_used,
> +						 idx),
> +				   &idx_shadow,
> +				   num_desc);
> +		advance_idx(&used->idx, &local_idx_shadow, num_desc);
> +		/* Only signal after indices are updated */
> +		mb();
> +		if (likely(!(epf_ioread16(IO_MEMBER_PTR(host_avail,
> +							struct vring_avail,
> +							flags))
> +			     & VRING_AVAIL_F_NO_INTERRUPT)))
> +			pci_epc_raise_irq(epc,
> +					  epf->func_no,
> +					  PCI_EPC_IRQ_LEGACY,
> +					  0);
> +		if (likely(!(local_virtio16_to_cpu(avail->flags)
> +			     & VRING_AVAIL_F_NO_INTERRUPT)))
> +			epf_virtio_interrupt(vr, &epf_vdev->vdev.dev);
> +	}
> +#endif
> +	if (!atomic_xchg(local_pending, 0))
> +		usleep_range(check_queues_usec_min,
> +			     check_queues_usec_max);
> +	goto re_entry;
> +}
> +
> +/*
> + * This function terminates early setup work and initializes variables
> + * for data transfer between the local vrings on PCI endpoint and remote vrings
> + * on PCI host. The initialization work includes storing information of
> + * physicaly addresses of remote vrings and starting two kernel threads
> + * that handle transfer between PCI host and endpoint. Some polling thread
> + * for notification from PCI host will also be set up.
> + *
> + * @epf_virtio: epf_virtio handler
> + *
> + * Return 0 on success and a negative error number on failure.
> + */
> +static int terminate_early_work(struct pci_epf_virtio *epf_virtio)
> +{
> +	int ret;
> +	struct net_device *netdev;
> +	struct epf_virtio_device *const epf_vdev = &epf_virtio->epf_vdev;
> +
> +	ret = store_host_vring(epf_virtio);
> +	if (ret) {
> +		dev_err(&epf_virtio->epf->dev,
> +			"Failed to store addresses of host vrings, abort\n");
> +		return ret;
> +	}
> +	ret = register_virtio_device(&epf_vdev->vdev);
> +	if (ret) {
> +		dev_err(&epf_vdev->vdev.dev,
> +			"local virtio device register failure\n");
> +		free_vring_info(epf_virtio, 2);
> +		return ret;
> +	}
> +	epf_vdev->registered = true;
> +	dev_info(&epf_vdev->vdev.dev,
> +		 "local_dev_feature is %#018llx\n",
> +		 epf_vdev->local_cfg.drv_feature);
> +	netdev = ((struct virtnet_info *)epf_vdev->vdev.priv)->dev;
> +	while (!(READ_ONCE(netdev->flags) & IFF_UP))
> +		schedule();
> +	epf_virtio->pending = kmalloc(sizeof(*epf_virtio->pending), GFP_KERNEL);
> +	epf_vdev->local_pending = kmalloc(sizeof(*epf_vdev->local_pending),
> +					  GFP_KERNEL);
> +	atomic_set(epf_virtio->pending, 0);
> +	atomic_set(epf_vdev->local_pending, 0);
> +	epf_virtio->catch_notif = kthread_run(pci_epf_virtio_catch_notif,
> +					      epf_virtio,
> +					      "catch host notification");
> +	if (!epf_virtio->catch_notif) {
> +		dev_err(&epf_virtio->epf->dev,
> +			"Failed to start thread for host notif\n");
> +		goto thread_alloc_err;
> +	}
> +	epf_virtio->handle_vq = kthread_run(pci_epf_virtio_handle_tx,
> +					    epf_virtio,
> +					    "host to ep transfer");
> +	if (!epf_virtio->handle_vq) {
> +		dev_err(&epf_virtio->epf->dev,
> +			"Failed to start thread for host to ep transfer\n");
> +		kthread_stop(epf_virtio->catch_notif);
> +		goto thread_alloc_err;
> +	}
> +	epf_vdev->local_handle_vq = kthread_run(pci_epf_virtio_local_handle_tx,
> +						epf_virtio,
> +						"endpoint to host transfer");
> +	if (!epf_vdev->local_handle_vq) {
> +		dev_err(&epf_vdev->vdev.dev,
> +			"Failed to start thread for ep to host transfer\n");
> +		kthread_stop(epf_virtio->catch_notif);
> +		kthread_stop(epf_virtio->handle_vq);
> +		goto thread_alloc_err;
> +	}
> +	return 0;
> +
> +thread_alloc_err:
> +	kfree(epf_virtio->pending);
> +	kfree(epf_vdev->local_pending);
> +	free_vring_info(epf_virtio, 2);
> +	return -ENOMEM;
> +}
> +
> +/*
> + * This function mostly runs in a high-priority real-time thread and attempts
> + * to store vring page frame numbers written by the PCI host's virtio_pci to
> + * BAR 0 of the PCI device. The PCI host usually has faster cores and will not
> + * wait for the PCI endpoint to respond. Therefore the PCI endpoint has to run
> + * in a tight loop to catch up with PCI host. Note that if this thread blocks,
> + * the whole kernel will hang.
> + *
> + * @data: kthread context. Actually epf_virtio handler.
> + *
> + * Return 0 on success and a negative error number on failure.
> + */
> +static int pci_epf_virtio_queue_cfg(void *data)
> +{
> +	int ret;
> +	struct pci_epf_virtio *const epf_virtio = data;
> +	__virtio16 *const q_select = &epf_virtio->legacy_cfg->q_select;
> +	atomic_t *const q_addr_atomic =
> +		(__force atomic_t *)&epf_virtio->legacy_cfg->q_addr;
> +	atomic_t *const rx_pfn = &epf_virtio->q_pfns[0];
> +	atomic_t *const tx_pfn = &epf_virtio->q_pfns[1];
> +
> +	register u32 val;
> +
> +	register const __virtio16 q_default = epf_cpu_to_virtio16(2);
> +
> +	while (READ_ONCE(*q_select) == q_default)
> +		DO_NOTHING
> +	while (!(val = atomic_xchg(q_addr_atomic, 0)))
> +		DO_NOTHING
> +	atomic_xchg(rx_pfn, val);
> +	while (!(val = atomic_xchg(q_addr_atomic, 0)))
> +		DO_NOTHING
> +	atomic_xchg(tx_pfn, val);
> +	sched_setscheduler_nocheck(epf_virtio->early_task,
> +				   SCHED_NORMAL,
> +				   &normal_param);
> +	ret = terminate_early_work(epf_virtio);
> +	if (ret) {
> +		dev_err(&epf_virtio->epf->dev,
> +			"Failed to terminate early work\n");
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Get called when the PCIe endpoint controller start the link. Allocate memory
> + * and initialize variables that will be used by the virtual network devices.
> + *
> + * @epf: epf handler
> + */
> +static void pci_epf_virtio_linkup(struct pci_epf *epf)
> +{
> +	int i;
> +	struct pci_epf_map *map;
> +	struct pci_epf_map *local_map;
> +	struct pci_epf_virtio *const epf_virtio = epf_get_drvdata(epf);
> +	const struct pci_epc_features *const features =
> +		epf_virtio->epc_features;
> +	const size_t align =
> +		(features && features->align) ? features->align : PAGE_SIZE;
> +
> +	pci_epf_map_init(&epf_virtio->q_map[0], epf, align);
> +	pci_epf_map_init(&epf_virtio->q_map[1], epf, align);
> +	epf_virtio->map_slab = kmem_cache_create("map slab",
> +						 sizeof(struct pci_epf_map),
> +						 0,
> +						 SLAB_HWCACHE_ALIGN,
> +						 NULL);
> +	if (!epf_virtio->map_slab) {
> +		dev_err(&epf_virtio->epf->dev,
> +			"Map slab allocation failed\n");
> +		return;
> +	}
> +	epf_virtio->epf_vdev.local_map_slab =
> +		kmem_cache_create("local map slab",
> +				  sizeof(struct pci_epf_map),
> +				  0,
> +				  SLAB_HWCACHE_ALIGN,
> +				  NULL);
> +	if (!epf_virtio->epf_vdev.local_map_slab) {
> +		dev_err(&epf_virtio->epf_vdev.vdev.dev,
> +			"Local map slab allocation failed\n");
> +		return;
> +	}
> +	INIT_LIST_HEAD(&epf_virtio->lru_head);
> +	INIT_LIST_HEAD(&epf_virtio->epf_vdev.local_lru_head);
> +	for (i = 0; i < MAP_CACHE_SIZE; i++) {
> +		map = kmem_cache_alloc(epf_virtio->map_slab,
> +				       GFP_KERNEL);
> +		if (!map) {
> +			dev_err(&epf_virtio->epf->dev,
> +				"Map %d allocation failed\n", i);
> +			return;
> +		}
> +		local_map =
> +			kmem_cache_alloc(epf_virtio->epf_vdev.local_map_slab,
> +					 GFP_KERNEL);
> +		if (!local_map) {
> +			dev_err(&epf_virtio->epf_vdev.vdev.dev,
> +				"Local map %d allocation failed\n", i);
> +			return;
> +		}
> +
> +		pci_epf_map_init(map, epf, align);
> +		list_add(&map->node, &epf_virtio->lru_head);
> +
> +		pci_epf_map_init(local_map, epf, align);
> +		list_add(&local_map->node,
> +			 &epf_virtio->epf_vdev.local_lru_head);
> +	}
> +	pci_epf_virtio_init_cfg_legacy(epf_virtio);
> +	epf_virtio->early_task = kthread_create(pci_epf_virtio_queue_cfg,
> +						epf_virtio,
> +						"early task");
> +	if (IS_ERR(epf_virtio->early_task)) {
> +		dev_err(&epf_virtio->epf->dev,
> +			"Thread creation error\n");
> +		return;
> +	}
> +	if (!epf_virtio->early_task) {
> +		dev_err(&epf_virtio->epf->dev,
> +			"No memory to allocate thread for early setup work\n");
> +		return;
> +	}
> +	/*
> +	 * TODO: find a better alternative than this.
> +	 * This gives the early task the highest priority and the scheduler
> +	 * will not be able to detect stalls on this thread. The kernel will not
> +	 * be able to recover from this thread if there is only one core
> +	 */
> +	sched_setscheduler_nocheck(epf_virtio->early_task,
> +				   SCHED_FIFO,
> +				   &high_rt);
> +	wake_up_process(epf_virtio->early_task);
> +}
> +
> +/*
> + * Get called when the endpoint function device is unbound from the PCIe
> + * endpoint controller. Free memory and stop continuously running kernel
> + * threads.
> + *
> + * @epf: epf handler
> + */
> +static void pci_epf_virtio_unbind(struct pci_epf *epf)
> +{
> +	struct pci_epf_virtio *epf_virtio = epf_get_drvdata(epf);
> +	struct pci_epc *epc = epf->epc;
> +	struct pci_epf_bar *epf_bar;
> +	int bar;
> +
> +	if (epf_virtio->catch_notif && kthread_stop(epf_virtio->catch_notif))
> +		dev_info(&epf_virtio->epf->dev,
> +			 "Never started catching host notification\n");
> +	if (epf_virtio->handle_vq && kthread_stop(epf_virtio->handle_vq))
> +		dev_info(&epf_virtio->epf->dev,
> +			 "Never starteding host to endpoint transfer\n");
> +	if (epf_virtio->epf_vdev.local_handle_vq &&
> +	    kthread_stop(epf_virtio->epf_vdev.local_handle_vq))
> +		dev_info(&epf_virtio->epf_vdev.vdev.dev,
> +			 "Never started endpoint to host transfer\n");
> +	if (epf_virtio->epf_vdev.registered)
> +		unregister_virtio_device(&epf_virtio->epf_vdev.vdev);
> +	pci_epf_unmap(&epf_virtio->q_map[0]);
> +	pci_epf_unmap(&epf_virtio->q_map[1]);
> +	if (epf_virtio->map_slab) {
> +		pci_epf_free_map_cache(&epf_virtio->lru_head,
> +				       epf_virtio->map_slab);
> +		kmem_cache_destroy(epf_virtio->map_slab);
> +	}
> +	if (epf_virtio->epf_vdev.local_map_slab) {
> +		pci_epf_free_map_cache(&epf_virtio->epf_vdev.local_lru_head,
> +				       epf_virtio->epf_vdev.local_map_slab);
> +		kmem_cache_destroy(epf_virtio->epf_vdev.local_map_slab);
> +	}
> +	kfree(epf_virtio->q_pfns);
> +	kfree(epf_virtio->q_addrs);
> +	kfree(epf_virtio->pending);
> +	kfree(epf_virtio->epf_vdev.local_pending);
> +	pci_epc_stop(epc);

You should never have pci_epc_stop() in function driver as that will break
multi-function endpoint devices. I'll fix this in pci-epf-test.c.
> +	for (bar = BAR_0; bar <= BAR_5; bar++) {
> +		epf_bar = &epf->bar[bar];
> +		if (epf_virtio->reg[bar]) {
> +			pci_epc_clear_bar(epc, epf->func_no, epf_bar);
> +			pci_epf_free_space(epf, epf_virtio->reg[bar], bar);
> +		}
> +	}
> +}
> +
> +/*
> + * Set BAR 0 to BAR 5 of the PCI endpoint device.
> + *
> + * @epf: epf handler
> + *
> + * Return 0 on success and a negative error number on failure.
> + */
> +static int pci_epf_virtio_set_bar(struct pci_epf *epf)
> +{
> +	int bar, add;
> +	int ret;
> +	struct pci_epf_bar *epf_bar;
> +	struct pci_epc *epc = epf->epc;
> +	struct device *dev = &epf->dev;
> +	struct pci_epf_virtio *epf_virtio = epf_get_drvdata(epf);
> +	enum pci_barno virtio_reg_bar = epf_virtio->virtio_reg_bar;
> +	const struct pci_epc_features *epc_features;
> +
> +	epc_features = epf_virtio->epc_features;
> +
> +	for (bar = BAR_0; bar <= BAR_5; bar += add) {
> +		epf_bar = &epf->bar[bar];
> +		/*
> +		 * pci_epc_set_bar() sets PCI_BASE_ADDRESS_MEM_TYPE_64
> +		 * if the specific implementation required a 64-bit BAR,
> +		 * even if we only requested a 32-bit BAR.
> +		 */
> +		add = (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ? 2 : 1;
> +
> +		if (!!(epc_features->reserved_bar & (1 << bar)))
> +			continue;
> +
> +		ret = pci_epc_set_bar(epc, epf->func_no, epf_bar);
> +		if (ret) {
> +			pci_epf_free_space(epf, epf_virtio->reg[bar], bar);
> +			dev_err(dev, "Failed to set BAR%d\n", bar);
> +			if (bar == virtio_reg_bar)
> +				return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Allocate space on BAR 0 for negotiating features and important information
> + * with virtio_pci on the PCI host side.
> + *
> + * @epf: epf handler
> + *
> + * Return 0 on success and a negative error number on failure.
> + */
> +static int pci_epf_virtio_alloc_space(struct pci_epf *epf)
> +{
> +	struct pci_epf_virtio *epf_virtio = epf_get_drvdata(epf);
> +	struct device *dev = &epf->dev;
> +	struct pci_epf_bar *epf_bar;
> +	void *base;
> +	int bar, add;
> +	enum pci_barno virtio_reg_bar = epf_virtio->virtio_reg_bar;
> +	const struct pci_epc_features *epc_features;
> +	size_t virtio_reg_size;
> +
> +	epc_features = epf_virtio->epc_features;
> +
> +	if (epc_features->bar_fixed_size[virtio_reg_bar])
> +		virtio_reg_size = bar_size[virtio_reg_bar];
> +	else
> +		virtio_reg_size = sizeof(struct virtio_legacy_cfg) +
> +				  sizeof(struct virtio_net_config);
> +
> +	base = pci_epf_alloc_space(epf, virtio_reg_size,
> +				   virtio_reg_bar, epc_features->align);
> +	if (!base) {
> +		dev_err(dev, "Failed to allocated register space\n");
> +		return -ENOMEM;
> +	}
> +	epf_virtio->reg[virtio_reg_bar] = base;
> +
> +	for (bar = BAR_0; bar <= BAR_5; bar += add) {

Are you using all these BARs? It's best to allocate and initialize the BARs we use.
> +		epf_bar = &epf->bar[bar];
> +		add = (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ? 2 : 1;
> +
> +		if (bar == virtio_reg_bar)
> +			continue;
> +
> +		if (!!(epc_features->reserved_bar & (1 << bar)))
> +			continue;
> +
> +		base = pci_epf_alloc_space(epf, bar_size[bar], bar,
> +					   epc_features->align);
> +		if (!base)
> +			dev_err(dev, "Failed to allocate space for BAR%d\n",
> +				bar);
> +		epf_virtio->reg[bar] = base;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Configure BAR of PCI endpoint device.
> + *
> + * @epf: epf handler
> + * @epc_features: set by vendor-specific epc features
> + */
> +static void pci_epf_configure_bar(struct pci_epf *epf,
> +				  const struct pci_epc_features *epc_features)
> +{
> +	struct pci_epf_bar *epf_bar;
> +	bool bar_fixed_64bit;
> +	int i;
> +
> +	for (i = BAR_0; i <= BAR_5; i++) {
> +		epf_bar = &epf->bar[i];
> +		bar_fixed_64bit = !!(epc_features->bar_fixed_64bit & (1 << i));
> +		if (bar_fixed_64bit)
> +			epf_bar->flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
> +		if (epc_features->bar_fixed_size[i])
> +			bar_size[i] = epc_features->bar_fixed_size[i];
> +	}
> +}
> +
> +/*
> + * Bind endpoint function device to PCI endpoint controller.
> + *
> + * @epf: epf hanlder
> + *
> + * Return 0 on success and a negative error number on failure.
> + */
> +static int pci_epf_virtio_bind(struct pci_epf *epf)
> +{
> +	int ret;
> +	struct pci_epf_virtio *epf_virtio = epf_get_drvdata(epf);
> +	struct pci_epf_header *header = epf->header;
> +	const struct pci_epc_features *epc_features;
> +	enum pci_barno virtio_reg_bar = BAR_0;
> +	struct pci_epc *epc = epf->epc;
> +	struct device *dev = &epf->dev;
> +	bool msix_capable = false;
> +	bool msi_capable = true;
> +
> +	if (WARN_ON_ONCE(!epc))
> +		return -EINVAL;
> +
> +	epc_features = pci_epc_get_features(epc, epf->func_no);
> +	if (epc_features) {
> +		msix_capable = epc_features->msix_capable;
> +		msi_capable = epc_features->msi_capable;
> +		virtio_reg_bar = pci_epc_get_first_free_bar(epc_features);
> +		pci_epf_configure_bar(epf, epc_features);
> +	}
> +
> +	epf_virtio->virtio_reg_bar = virtio_reg_bar;
> +	epf_virtio->epc_features = epc_features;
> +
> +	ret = pci_epc_write_header(epc, epf->func_no, header);
> +	if (ret) {
> +		dev_err(dev, "Configuration header write failed\n");
> +		return ret;
> +	}
> +
> +	ret = pci_epf_virtio_alloc_space(epf);
> +	if (ret)
> +		return ret;
> +
> +	ret = pci_epf_virtio_set_bar(epf);
> +	if (ret)
> +		return ret;
> +
> +	if (msi_capable) {
> +		ret = pci_epc_set_msi(epc, epf->func_no, epf->msi_interrupts);
> +		if (ret) {
> +			dev_err(dev, "MSI configuration failed\n");
> +			return ret;
> +		}
> +	}
> +
> +	if (msix_capable) {
> +		ret = pci_epc_set_msix(epc, epf->func_no, epf->msix_interrupts);
> +		if (ret) {
> +			dev_err(dev, "MSI-X configuration failed\n");
> +			return ret;
> +		}
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Destroy the virtual device associated with the local virtio device.
> + *
> + * @dev: a device handler to the virtual device
> + */
> +static inline void pci_epf_virtio_release(struct device *dev)
> +{
> +	memset(dev, 0, sizeof(*dev));
> +}
> +
> +/*
> + * Initialize the local epf_virtio_device. This local epf_virtio_device
> + * contains important information other than the virtio_device as required
> + * by the local virtio modules on the PCI endpoint. The fields of
> + * epf_virtio_device mostly mirror those of pci_epf_virtio. They are
> + * conceptual counterparts. pci_epf_virtio serves the remote PCI host,
> + * while epf_virtio_device serves the local PCI endpoint.
> + *
> + * @epf_virtio: epf_virtio handler
> + *
> + * Return 0 on success and a negative error number on failure.
> + */
> +static int init_local_epf_vdev(struct pci_epf_virtio *epf_virtio)
> +{
> +	struct epf_virtio_device *const epf_vdev = &epf_virtio->epf_vdev;
> +
> +	epf_vdev->vdev.dev.parent = &epf_virtio->epf->dev;
> +	epf_vdev->vdev.id.vendor = virtio_header.subsys_vendor_id;
> +	epf_vdev->vdev.id.device = virtio_header.subsys_id;
> +	epf_vdev->vdev.config = &epf_virtio_local_dev_config_ops;
> +	epf_vdev->vdev.dev.release = pci_epf_virtio_release;
> +	epf_vdev->local_cfg.dev_feature =
> +		generate_local_dev_feature64(local_features,
> +					     ARRAY_SIZE(local_features));
> +	epf_vdev->local_net_cfg.max_virtqueue_pairs = 1;
> +	epf_vdev->registered = false;
> +	memcpy(epf_vdev->local_net_cfg.mac, local_mac, ETH_ALEN);
> +	return 0;
> +}
> +
> +/*
> + * Endpoint function driver's probe function. This will get called
> + * when an endpoint function device is created by the user in userspace
> + * after kernel bootup with config filesystem.
> + *
> + * @epf: epf handler
> + *
> + * Return 0 on success and a negative error number on failure.
> + */
> +static int pci_epf_virtio_probe(struct pci_epf *epf)
> +{
> +	int ret;
> +	struct pci_epf_virtio *epf_virtio;
> +	struct device *dev = &epf->dev;
> +
> +	epf_virtio = devm_kzalloc(dev, sizeof(*epf_virtio), GFP_KERNEL);
> +	if (!epf_virtio)
> +		return -ENOMEM;
> +	epf->header = &virtio_header;
> +	epf_virtio->epf = epf;
> +	ret = init_local_epf_vdev(epf_virtio);
> +	if (ret) {
> +		dev_err(&epf_virtio->epf_vdev.vdev.dev,
> +			"Failed to initialize local virtio device\n");
> +		devm_kfree(dev, epf_virtio);
> +		return ret;
> +	}
> +	epf_virtio->q_pfns = kcalloc(2,
> +				     sizeof(*epf_virtio->q_pfns),
> +				     GFP_KERNEL);
> +	epf_virtio->q_addrs = kcalloc(2,
> +				      sizeof(*epf_virtio->q_addrs),
> +				      GFP_KERNEL);
> +	atomic_set(&epf_virtio->q_pfns[0], 0);
> +	atomic_set(&epf_virtio->q_pfns[1], 0);
> +	epf_set_drvdata(epf, epf_virtio);
> +	return 0;
> +}
> +
> +/* This function table is used by pci_epf_core. */
> +static struct pci_epf_ops ops = {
> +	.unbind	= pci_epf_virtio_unbind,
> +	.bind	= pci_epf_virtio_bind,
> +	.linkup = pci_epf_virtio_linkup,
> +};
> +
> +/* This function table is used by virtio.c on PCI endpoint */
> +static struct pci_epf_driver virtio_driver = {
> +	.driver.name	= "pci_epf_virtio",
> +	.probe		= pci_epf_virtio_probe,
> +	.id_table	= pci_epf_virtio_ids,
> +	.ops		= &ops,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static int __init pci_epf_virtio_init(void)
> +{
> +	int ret;
> +
> +	ret = pci_epf_register_driver(&virtio_driver);
> +	if (ret) {
> +		pr_err("Failed to register pci epf virtio driver --> %d\n",
> +		       ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +module_init(pci_epf_virtio_init);
> +
> +static void __exit pci_epf_virtio_exit(void)
> +{
> +	pci_epf_unregister_driver(&virtio_driver);
> +}
> +module_exit(pci_epf_virtio_exit);
> +
> +MODULE_DESCRIPTION("PCI EPF VIRTIO DRIVER");
> +MODULE_AUTHOR("Haotian Wang <haotian.wang@sifive.com, haotian.wang@duke.edu>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/pci-epf-virtio.h b/include/linux/pci-epf-virtio.h
> new file mode 100644
> index 000000000000..d68e8d0f570c
> --- /dev/null
> +++ b/include/linux/pci-epf-virtio.h
> @@ -0,0 +1,253 @@
> +/* SPDX-License-Identifier: GPL-2.0*/
> +#ifndef PCI_EPF_VIRTIO_H
> +#define PCI_EPF_VIRTIO_H
> +
> +#define VIRTIO_DEVICE_ID		(0x1000)
> +#define VIRTIO_NET_SUBSYS_ID		1
> +
> +#define EPF_VIRTIO_QUEUE_SIZE_SHIFT	5
> +#define EPF_VIRTIO_QUEUE_SIZE		BIT(EPF_VIRTIO_QUEUE_SIZE_SHIFT)
> +#define MAP_CACHE_SIZE			5
> +#define CATCH_NOTIFY_USEC_MIN		10
> +#define CATCH_NOTIFY_USEC_MAX		20
> +#define CHECK_QUEUES_USEC_MIN		100
> +#define CHECK_QUEUES_USEC_MAX		200
> +#ifdef CONFIG_PCI_EPF_VIRTIO_SUPPRESS_NOTIFICATION
> +#define EVENT_SUPPRESSION		3
> +#endif
> +#ifdef CONFIG_PCI_ENDPOINT_DMAENGINE
> +#define ENABLE_DMA			0
> +#endif
> +
> +#define VIRTIO_PCI_ISR_HIGH		1
> +
> +#define vdev_to_epf_vdev(vdev_ptr)		\
> +	container_of(vdev_ptr,			\
> +		     struct epf_virtio_device,	\
> +		     vdev)
> +
> +#define MODULO_QUEUE_SIZE(x)		((x) & (EPF_VIRTIO_QUEUE_SIZE - 1))
> +
> +/* These macros are used because structs are on PCI host */
> +#define IO_MEMBER_PTR(base_ptr, type, member)				\
> +	((base_ptr) + offsetof(type, member))
> +
> +#define IO_MEMBER_ARR_ELEM_PTR(base_ptr,			\
> +			       type,				\
> +			       member,				\
> +			       member_type,			\
> +			       index)				\
> +	(							\
> +		(base_ptr) + offsetof(type, member) +		\
> +		(index) * sizeof(member_type)			\
> +	)
> +
> +#define IO_ARR_ELEM_PTR(base_ptr, type, index)				\
> +	((base_ptr) + (index) * sizeof(type))
> +
> +#define DO_NOTHING {}
> +
> +static const u8 host_mac[ETH_ALEN] = { 2, 2, 2, 2, 2, 2 };
> +
> +static const u8 local_mac[ETH_ALEN] = { 4, 4, 4, 4, 4, 4 };
> +
> +static const struct sched_param high_rt = {
> +	.sched_priority = MAX_RT_PRIO - 1
> +};
> +
> +static const struct sched_param normal_param = {
> +	.sched_priority = 0
> +};
> +
> +static const unsigned int features[] = {
> +	VIRTIO_NET_F_MAC,
> +#ifdef CONFIG_PCI_EPF_VIRTIO_SUPPRESS_NOTIFICATION
> +	VIRTIO_RING_F_EVENT_IDX,
> +#endif
> +	VIRTIO_NET_F_GUEST_CSUM,
> +};
> +
> +static const unsigned int local_features[] = {
> +	VIRTIO_NET_F_MAC,
> +#ifdef CONFIG_PCI_EPF_VIRTIO_SUPPRESS_NOTIFICATION
> +	VIRTIO_RING_F_EVENT_IDX,
> +#endif
> +	VIRTIO_NET_F_GUEST_CSUM,
> +};
> +
> +static const struct pci_epf_device_id pci_epf_virtio_ids[] = {
> +	{
> +		.name = "pci_epf_virtio",
> +	},
> +	{},
> +};
> +
> +struct pci_epf_map {
> +	size_t iosize;
> +	size_t	align;
> +	void __iomem *ioaddr;
> +	void __iomem *iobase;
> +	phys_addr_t phys_ioaddr;
> +	phys_addr_t phys_iobase;
> +	u64 prev_host_base;
> +	struct pci_epf *epf;
> +	struct pci_epc *epc;
> +	struct list_head node;
> +};
> +
> +struct virtio_legacy_cfg {
> +	__virtio32	dev_feature;
> +	__virtio32	drv_feature;
> +	__virtio32	q_addr;
> +	__virtio16	q_size;
> +	__virtio16	q_select;
> +	__virtio16	q_notify;
> +	u8		dev_status;
> +	u8		isr_status;
> +} __packed;
> +
> +struct virtio_local_cfg {
> +	u64	dev_feature;
> +	u64	drv_feature;
> +	u8	dev_status;
> +};
> +
> +struct mem_frag {
> +	u64	addr;
> +	u32	len;
> +};
> +
> +struct epf_virtio_device {
> +	struct virtio_device		vdev;
> +	struct virtio_local_cfg		local_cfg;
> +	struct virtio_net_config	local_net_cfg;
> +	struct vring			*vrings[2];
> +	struct task_struct		*local_handle_vq;
> +	struct mem_frag			local_frags[2];
> +	struct kmem_cache		*local_map_slab;
> +	struct list_head		local_lru_head;
> +	bool				registered;
> +	atomic_t			*local_pending;
> +};
> +
> +struct pci_epf_virtio {
> +	void			*reg[6];
> +	atomic_t		*pending;
> +	atomic_t		*q_pfns;
> +	u64			*q_addrs;
> +	struct mem_frag		frags[2];
> +	struct pci_epf_map	q_map[2];
> +	void __iomem		*desc[2];
> +	void __iomem		*avail[2];
> +	void __iomem		*used[2];
> +	struct pci_epf		*epf;
> +	enum pci_barno		virtio_reg_bar;
> +	struct kmem_cache	*map_slab;
> +	struct list_head	lru_head;
> +	struct task_struct	*early_task;
> +	struct task_struct	*catch_notif;
> +	struct task_struct	*handle_vq;
> +	struct epf_virtio_device	epf_vdev;
> +	struct virtio_legacy_cfg	*legacy_cfg;
> +	struct virtio_net_config	*net_cfg;
> +	const struct pci_epc_features	*epc_features;
> +};
> +
> +struct vring_desc_state_split {
> +	void *data;			/* Data for callback. */
> +	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
> +};
> +
> +struct vring_desc_state_packed {
> +	void *data;			/* Data for callback. */
> +	struct vring_packed_desc *indir_desc; /* Indirect descriptor, if any. */
> +	u16 num;			/* Descriptor list length. */
> +	u16 next;			/* The next desc state in a list. */
> +	u16 last;			/* The last desc state in a list. */
> +};
> +
> +struct vring_desc_extra_packed {
> +	dma_addr_t addr;		/* Buffer DMA addr. */
> +	u32 len;			/* Buffer length. */
> +	u16 flags;			/* Descriptor flags. */
> +};
> +
> +struct vring_virtqueue {
> +	struct virtqueue vq;
> +	bool packed_ring;
> +	bool use_dma_api;
> +	bool weak_barriers;
> +	bool broken;
> +	bool indirect;
> +	bool event;
> +	unsigned int free_head;
> +	unsigned int num_added;
> +	u16 last_used_idx;
> +	union {
> +		struct {
> +			struct vring vring;
> +			u16 avail_flags_shadow;
> +			u16 avail_idx_shadow;
> +			struct vring_desc_state_split *desc_state;
> +			dma_addr_t queue_dma_addr;
> +			size_t queue_size_in_bytes;
> +		} split;
> +		struct {
> +			struct {
> +				unsigned int num;
> +				struct vring_packed_desc *desc;
> +				struct vring_packed_desc_event *driver;
> +				struct vring_packed_desc_event *device;
> +			} vring;
> +			bool avail_wrap_counter;
> +			bool used_wrap_counter;
> +			u16 avail_used_flags;
> +			u16 next_avail_idx;
> +			u16 event_flags_shadow;
> +			struct vring_desc_state_packed *desc_state;
> +			struct vring_desc_extra_packed *desc_extra;
> +			dma_addr_t ring_dma_addr;
> +			dma_addr_t driver_event_dma_addr;
> +			dma_addr_t device_event_dma_addr;
> +			size_t ring_size_in_bytes;
> +			size_t event_size_in_bytes;
> +		} packed;
> +	};
> +	bool (*notify)(struct virtqueue *vq);
> +	bool we_own_ring;
> +#ifdef DEBUG
> +	unsigned int in_use;
> +	bool last_add_time_valid;
> +	ktime_t last_add_time;
> +#endif
> +};
> +
> +struct virtnet_info {
> +	struct virtio_device *vdev;
> +	struct virtqueue *cvq;
> +	struct net_device *dev;
> +	struct send_queue *sq;
> +	struct receive_queue *rq;
> +	unsigned int status;
> +	u16 max_queue_pairs;
> +	u16 curr_queue_pairs;
> +	u16 xdp_queue_pairs;
> +	bool big_packets;
> +	bool mergeable_rx_bufs;
> +	bool has_cvq;
> +	bool any_header_sg;
> +	u8 hdr_len;
> +	struct delayed_work refill;
> +	struct work_struct config_work;
> +	bool affinity_hint_set;
> +	struct hlist_node node;
> +	struct hlist_node node_dead;
> +	struct control_buf *ctrl;
> +	u8 duplex;
> +	u32 speed;
> +	unsigned long guest_offloads;
> +	unsigned long guest_offloads_capable;
> +	struct failover *failover;
> +};

Please add a description for each of these structures.

Cheers
Kishon
