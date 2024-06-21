Return-Path: <linux-pci+bounces-9096-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F8E912EF9
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 22:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2896F1F27374
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 20:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF4E17BB12;
	Fri, 21 Jun 2024 20:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CS35jpz3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1E316849B;
	Fri, 21 Jun 2024 20:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719003209; cv=none; b=vACAPD0/ahyFhRxv7QU7f+8ohTur+508mGgrfJCVTedS6CIXPRJdmMmxpoaOvvPiL2atZdhRjLTLp890OvooPvPx6kEUNQxsccFSIyIq3L1qLgZO4KSWRPP3qq63LnILkncpQdLe3N33q0tKpghTyjRVS/s6lwGQTLDpjbzQAwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719003209; c=relaxed/simple;
	bh=QXpovGML+Y3eTIIItb+1ZNZoQfaYtRRW+bXluvwolfM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qNCYRu2Oz64PO3T4BuJBDZf3L8MEne/47Scf5PEhfh2tZ+dIviuvyojeHC/uXEja5dWs8Is7Nn2IZfxkJ2W46NTtm2boX74nNsn3fPzRadOwUWt0FgIMix0qKTv5OGDg1uY7SV9fj4s9C1g7FQO/arCv1+oqE/CK6IyBnHdWSxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CS35jpz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E93C2BBFC;
	Fri, 21 Jun 2024 20:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719003209;
	bh=QXpovGML+Y3eTIIItb+1ZNZoQfaYtRRW+bXluvwolfM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CS35jpz3uCLkk9S7rKNm6oR3QWAL16Ewze/wMHhZTihqunEPEkIYAmS8loLW38l+M
	 WuQl0llXXKV+fQHRB8uxwvEnn406ICWL7lQ6rGdTbao5lQP+NEyzlYMxDrFCiM7RIw
	 CkwOQtk3zYJw/P0HEkAbgJQGKFTbS1ctuGN6X9zi1nscT/RHnexQO4dqTtceF2xzUN
	 dw2WUKs0XyyHokXdY6sqRFXy/om6o6EtRZu83XH0o1nt/Xeq9r2T9kOFjGt0oXXoY/
	 4aPpKpzB76mnlada/4xnikKObZhEGDPi/Qqjc+sz0FQY5jFv8+KaxJUboik4s1s70z
	 3xqc0/FiNWfNg==
Date: Fri, 21 Jun 2024 15:53:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	linux-kernel@vger.kernel.org, sumanesh.samanta@broadcom.com,
	sathya.prakash@broadcom.com, Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH 1/2] switch_discovery: Add new module to discover inter
 switch links between PCI-to-PCI bridges
Message-ID: <20240621205327.GA1374772@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1718191656-32714-2-git-send-email-shivasharan.srikanteshwara@broadcom.com>

[+cc Logan]

Surface-level comments below.

On Wed, Jun 12, 2024 at 04:27:35AM -0700, Shivasharan S wrote:
> This kernel module discovers the virtual inter-switch P2P links present
> between two PCI-to-PCI bridges that allows an optimal data path for data
> movement. The module creates sysfs entries for upstream PCI-to-PCI
> bridges which supports the inter switch P2P links as below:
> 
>                              Host root bridge
>                 ---------------------------------------
>                 |                                     |
>   NIC1 --- PCI Switch1 --- Inter-switch link --- PCI Switch2 --- NIC2
> (af:00.0)   (ad:00.0)                             (8b:00.0)   (8d:00.0)
>                 |                                     |
>                GPU1                                  GPU2
>             (b0:00.0)                             (8e:00.0)
>                                SERVER 1
> 
> /sys/kernel/pci_switch_link/virtual_switch_links
> ├── 0000:8b:00.0
> │   └── 0000:ad:00.0 -> ../0000:ad:00.0
> └── 0000:ad:00.0
>     └── 0000:8b:00.0 -> ../0000:8b:00.0
> 
> Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
> Signed-off-by: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
> ---
>  .../driver-api/pci/switch_discovery.rst       |  52 +++
>  MAINTAINERS                                   |  13 +
>  drivers/pci/switch/Kconfig                    |   9 +
>  drivers/pci/switch/Makefile                   |   1 +
>  drivers/pci/switch/switch_discovery.c         | 375 ++++++++++++++++++
>  drivers/pci/switch/switch_discovery.h         |  44 ++
>  6 files changed, 494 insertions(+)
>  create mode 100644 Documentation/driver-api/pci/switch_discovery.rst
>  create mode 100644 drivers/pci/switch/switch_discovery.c
>  create mode 100644 drivers/pci/switch/switch_discovery.h
> 
> diff --git a/Documentation/driver-api/pci/switch_discovery.rst b/Documentation/driver-api/pci/switch_discovery.rst
> new file mode 100644
> index 000000000000..7c1476260e5e
> --- /dev/null
> +++ b/Documentation/driver-api/pci/switch_discovery.rst
> @@ -0,0 +1,52 @@
> +=================================
> +Linux PCI Switch discovery module

"switch discovery" sounds a lot like "switch enumeration".  What
you're doing here is not enumeration or discovery of the *switch*,
it's discovery of these special non-architected paths between
switches, so I think the name isn't quite right.

> +=================================
> +
> +Modern PCI switches support inter switch Peer-to-Peer(P2P) data transfer
> +without using host resources. For example, Broadcom(PLX) PCIe Switches have a
> +capability where a single physical switch can be divided up into multiple
> +virtual switches at SOD. PCIe switch discovery module detects the virtual links

SOD?

> +between the switches that belong to the same physical switch.
> +This allows user space applications to discover these virtual links that belong
> +to the same physical switch and configure optimized data paths.
> +
> +Userspace Interface
> +===================
> +
> +The module exposes sysfs entries for user space applications like MPI, NCCL,
> +UCC, RCCL, HCCL, etc to discover the virtual switch links.
> +
> +Consider the below topology
> +
> +                             Host root bridge
> +                ---------------------------------------
> +                |                                     |
> +  NIC1 --- PCI Switch1 --- Inter-switch link --- PCI Switch2 --- NIC2
> +(af:00.0)   (ad:00.0)                             (8b:00.0)   (8d:00.0)
> +                |                                     |
> +               GPU1                                  GPU2
> +            (b0:00.0)                             (8e:00.0)
> +                               SERVER 1
> +
> +The simple topology above shows SERVER1, has Switch1 and Switch2 which are
> +virtual switches that belong to the same physical switch that support
> +Inter switch P2P.

Need blank lines between paragraphs.  Or rewrap to fill 75 columns or
so if you intend a single paragraph.

> +Switch1 and Switch2 have a GPU and NIC each connected.
> +The module will detect the virtual P2P link existing between the two switches
> +and create the sysfs entries as below.
> +
> +/sys/kernel/pci_switch_link/virtual_switch_links
> +├── 0000:8b:00.0
> +│   └── 0000:ad:00.0 -> ../0000:ad:00.0
> +└── 0000:ad:00.0
> +    └── 0000:8b:00.0 -> ../0000:8b:00.0
> +
> +The HPC/AI libraries that analyze the topology can decide the optimal data
> +path like: NIC1->GPU1->GPU2->NIC1 which would have otherwise take a
> +non-optimal path like NIC1->GPU1->GPU2->GPU1->NIC1.
> +
> +Enable P2P DMA to discover virtual links
> +----------------------------------------
> +The module also enhances :c:func:`pci_p2pdma_distance()` to determine a virtual
> +link between the upstream PCI-to-PCI bridges of the devices and detect optimal
> +path for applications using P2P DMA API.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 823387766a0c..b1bf3533ea6f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17359,6 +17359,19 @@ F:	Documentation/driver-api/pci/p2pdma.rst
>  F:	drivers/pci/p2pdma.c
>  F:	include/linux/pci-p2pdma.h
>  
> +PCI SWITCH DISCOVERY
> +M:	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
> +M:	Sumanesh Samanta <sumanesh.samanta@broadcom.com>
> +L:	linux-pci@vger.kernel.org
> +S:	Maintained
> +Q:	https://patchwork.kernel.org/project/linux-pci/list/
> +B:	https://bugzilla.kernel.org
> +C:	irc://irc.oftc.net/linux-pci
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
> +F:	Documentation/driver-api/pci/switch_discovery.rst
> +F:	drivers/pci/switch/switch_discovery.c
> +F:	drivers/pci/switch/switch_discovery.h
> +
>  PCI SUBSYSTEM
>  M:	Bjorn Helgaas <bhelgaas@google.com>
>  L:	linux-pci@vger.kernel.org
> diff --git a/drivers/pci/switch/Kconfig b/drivers/pci/switch/Kconfig
> index d370f4ce0492..fb4410153950 100644
> --- a/drivers/pci/switch/Kconfig
> +++ b/drivers/pci/switch/Kconfig
> @@ -12,4 +12,13 @@ config PCI_SW_SWITCHTEC
>  	 devices. See <file:Documentation/driver-api/switchtec.rst> for more
>  	 information.
>  
> +config PCI_SW_DISCOVERY
> +	depends on PCI
> +	tristate "PCI Switch discovery module"
> +	help
> +	 This kernel module discovers the PCI-to-PCI bridges of PCIe switches
> +	 and forms the virtual switch links if the bridges belong to the same
> +	 Physical switch. The switch links help to identify shorter distances
> +	 for P2P configurations.
> +
>  endmenu
> diff --git a/drivers/pci/switch/Makefile b/drivers/pci/switch/Makefile
> index acd56d3b4a35..a3584b5146af 100644
> --- a/drivers/pci/switch/Makefile
> +++ b/drivers/pci/switch/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_PCI_SW_SWITCHTEC) += switchtec.o
> +obj-$(CONFIG_PCI_SW_DISCOVERY) += switch_discovery.o
> diff --git a/drivers/pci/switch/switch_discovery.c b/drivers/pci/switch/switch_discovery.c
> new file mode 100644
> index 000000000000..a427d3885b1f
> --- /dev/null
> +++ b/drivers/pci/switch/switch_discovery.c
> @@ -0,0 +1,375 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  PCI Switch Discovery module
> + *
> + *  Copyright (c) 2024  Broadcom Inc.
> + *
> + *  Authors: Broadcom Inc.
> + *           Sumanesh Samanta <sumanesh.samanta@broadcom.com>
> + *           Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/sysfs.h>
> +#include <linux/slab.h>
> +#include <linux/rwsem.h>
> +#include <linux/pci.h>
> +#include <linux/vmalloc.h>
> +#include "switch_discovery.h"
> +
> +static DECLARE_RWSEM(sw_disc_rwlock);
> +static struct kobject *sw_disc_kobj, *sw_link_kobj;
> +static struct kobject *sw_kobj[SWD_MAX_VIRT_SWITCH];
> +static DECLARE_BITMAP(swdata_valid, SWD_MAX_VIRT_SWITCH);
> +
> +static struct switch_data *swdata;
> +
> +static int sw_disc_probe(void);
> +static int sw_disc_create_sysfs_files(void);
> +static bool brcm_sw_is_p2p_supported(struct pci_dev *pdev, char *serial_num);
> +
> +static inline bool sw_disc_is_supported_pdev(struct pci_dev *pdev)
> +{
> +	if ((pdev->vendor == PCI_VENDOR_ID_LSI) &&
> +	   ((pdev->device == PCI_DEVICE_ID_BRCM_PEX_89000_HLC) ||
> +	    (pdev->device == PCI_DEVICE_ID_BRCM_PEX_89000_LLC)))
> +		return true;
> +
> +	return false;
> +}
> +
> +static ssize_t sw_disc_show(struct kobject *kobj,
> +			struct kobj_attribute *attr,
> +			char *buf)
> +{
> +	int retval;
> +
> +	down_write(&sw_disc_rwlock);
> +	retval = sw_disc_probe();
> +	if (!retval) {
> +		pr_debug("No new switch found\n");
> +		goto exit_success;
> +	}
> +
> +	retval = sw_disc_create_sysfs_files();
> +	if (retval < 0) {
> +		pr_err("Failed to create the sysfs entries, retval %d\n",
> +		       retval);
> +	}
> +
> +exit_success:
> +	up_write(&sw_disc_rwlock);
> +	return sysfs_emit(buf, SWD_SCAN_DONE);
> +}
> +
> +/* This function probes the PCIe devices for virtual links */
> +static int sw_disc_probe(void)
> +{
> +	int i, bit;
> +	struct pci_dev *pdev = NULL;
> +	int topology_changed = 0;
> +	DECLARE_BITMAP(sw_found_map, SWD_MAX_VIRT_SWITCH);
> +
> +	while ((pdev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL) {

We might be forced to use pci_get_device() if we can't find a better
way, but every call of this interface is suspect because it leaves the
hotplug case unhandled.

> +		int sw_found;
> +
> +		/* Currently this function only traverses Broadcom
> +		 * PEX switches and determines the virtual SW links.
> +		 * Other Switch vendors can add their specific logic
> +		 * determine the virtual links.

Use drivers/pci comment style (/* by itself on first line).

Factor the things that you think are Broadcom-specific out to a
function with a name that is obviously Broadcom-specific.

> +		 */
> +		if (!sw_disc_is_supported_pdev(pdev))
> +			continue;
> +
> +		sw_found = -1;
> +
> +		for_each_set_bit(bit, swdata_valid, SWD_MAX_VIRT_SWITCH) {
> +			if (swdata[bit].devfn == pdev->devfn &&
> +			    swdata[bit].bus == pdev->bus) {
> +				sw_found = bit;
> +				set_bit(sw_found, sw_found_map);
> +				break;
> +			}
> +		}
> +
> +		if (sw_found != -1)
> +			continue;
> +
> +		for (i = 0; i < SWD_MAX_VIRT_SWITCH; i++)
> +			if (!swdata[i].bus)
> +				break;
> +
> +		if (i >= SWD_MAX_VIRT_SWITCH) {
> +			pr_err("Max switch exceeded\n");

Use pci_info/err/etc when possible.  "Max switch exceeded" by itself
in the dmesg log is useless.  You have a pdev available here, so use
that.

> +			break;
> +		}
> +
> +		sw_found = i;
> +
> +		if (!brcm_sw_is_p2p_supported(pdev, (char *)&swdata[sw_found].serial_num))
> +			continue;
> +
> +		/* Found a new switch which supports P2P */
> +		swdata[sw_found].devfn = pdev->devfn;
> +		swdata[sw_found].bus = pdev->bus;
> +
> +		topology_changed = 1;
> +		set_bit(sw_found, sw_found_map);
> +		set_bit(sw_found, swdata_valid);
> +	}
> +
> +	/* handle device removal */
> +	for_each_clear_bit(bit, sw_found_map, SWD_MAX_VIRT_SWITCH) {
> +		if (test_bit(bit, swdata_valid)) {
> +			memset(&swdata[bit], 0, sizeof(swdata[i]));
> +			clear_bit(bit, swdata_valid);
> +			topology_changed = 1;
> +		}
> +	}
> +
> +	return topology_changed;
> +}
> +
> +/* Check the various config space registers of the Broadcom PCI device and
> + * return true if the device supports inter switch P2P.
> + * If P2P is supported, return the device serial number back to
> + * caller.
> + */
> +bool brcm_sw_is_p2p_supported(struct pci_dev *pdev, char *serial_num)
> +{
> +	int base;
> +	u32 cap_data1, cap_data2;
> +	u16 vsec;
> +	u32 vsec_data;
> +
> +	base = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DSN);
> +	if (!base) {
> +		pr_debug("Failed to get extended capability bus %x devfn %x\n",
> +			 pdev->bus->number, pdev->devfn);

Another place to use pci_dbg with pdev.  More below.  There should not
be any pr_info(), pr_debug(), etc calls unless there's something that
cannot be associated with a device.

> +		return false;
> +	}
> +
> +	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_LSI, 1);
> +	if (!vsec) {
> +		pr_debug("Failed to get VSEC bus %x devfn %x\n",
> +			 pdev->bus->number, pdev->devfn);
> +		return false;
> +	}
> +
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM)
> +		return false;
> +
> +	pci_read_config_dword(pdev, base + 8, &cap_data1);
> +	pci_read_config_dword(pdev, base + 4, &cap_data2);
> +
> +	pci_read_config_dword(pdev, vsec + 12, &vsec_data);
> +
> +	pr_debug("Found Broadcom device bus 0x%x devfn 0x%x "
> +		 "Serial Number: 0x%x 0x%x, VSEC 0x%x\n",
> +		 pdev->bus->number, pdev->devfn,
> +		 cap_data1, cap_data2, vsec_data);
> +
> +	if (!SECURE_PART(cap_data1))
> +		return false;
> +
> +	if (!(P2PMASK(vsec_data) & INTER_SWITCH_LINK))
> +		return false;
> +
> +	if (serial_num)
> +		snprintf(serial_num, SWD_MAX_CHAR, "%x%x", cap_data1, cap_data2);
> +
> +	return true;
> +}
> +
> +static int sw_disc_create_sysfs_files(void)
> +{
> +	int i, j, retval;
> +
> +	for (i = 0; i < SWD_MAX_VIRT_SWITCH; i++) {
> +		if (sw_kobj[i]) {
> +			kobject_put(sw_kobj[i]);
> +			sw_kobj[i] = NULL;
> +		}
> +	}
> +
> +	if (sw_link_kobj) {
> +		kobject_put(sw_link_kobj);
> +		sw_link_kobj = NULL;
> +	}
> +
> +	sw_link_kobj = kobject_create_and_add(SWD_LINK_DIR_STRING, sw_disc_kobj);
> +	if (!sw_link_kobj) {
> +		pr_err("Failed to create pci link object\n");
> +		return -ENOMEM;
> +	}
> +
> +	for (i = 0; i < SWD_MAX_VIRT_SWITCH; i++) {
> +		int segment, bus, device, function;
> +		char bdf_i[SWD_MAX_CHAR];
> +
> +		if (!test_bit(i, swdata_valid))
> +			continue;
> +
> +		segment = pci_domain_nr(swdata[i].bus);
> +		bus = swdata[i].bus->number;
> +		device = pci_ari_enabled(swdata[i].bus) ?
> +				0 : PCI_SLOT(swdata[i].devfn);
> +		function = pci_ari_enabled(swdata[i].bus) ?
> +				swdata[i].devfn : PCI_FUNC(swdata[i].devfn);
> +		sprintf(bdf_i, "%04x:%02x:%02x.%x",
> +			segment, bus, device, function);
> +
> +		for (j = i + 1; j < SWD_MAX_VIRT_SWITCH; j++) {
> +			char bdf_j[SWD_MAX_CHAR];
> +
> +			if (!test_bit(j, swdata_valid))
> +				continue;
> +			segment = pci_domain_nr(swdata[j].bus);
> +			bus = swdata[j].bus->number;
> +			device = pci_ari_enabled(swdata[j].bus) ?
> +					0 : PCI_SLOT(swdata[j].devfn);
> +			function = pci_ari_enabled(swdata[j].bus) ?
> +					swdata[j].devfn : PCI_FUNC(swdata[j].devfn);
> +			sprintf(bdf_j, "%04x:%02x:%02x.%x",
> +				segment, bus, device, function);
> +
> +			if (strcmp(swdata[i].serial_num, swdata[j].serial_num) == 0) {

This gets too deep.  Needs to be factored out somehow to avoid
excessive indentation.

> +				if (!sw_kobj[i]) {
> +					sw_kobj[i] = kobject_create_and_add(bdf_i,
> +									    sw_link_kobj);
> +					if (!sw_kobj[i]) {
> +						pr_err("Failed to create sysfs entry for switch %s\n",
> +						       bdf_i);
> +					}
> +				}
> +
> +				if (!sw_kobj[j]) {
> +					sw_kobj[j] = kobject_create_and_add(bdf_j,
> +									    sw_link_kobj);
> +					if (!sw_kobj[j]) {
> +						pr_err("Failed to create sysfs entry for switch %s\n",
> +						       bdf_j);
> +					}
> +				}
> +
> +				retval = sysfs_create_link(sw_kobj[i], sw_kobj[j], bdf_j);
> +				if (retval)
> +					pr_err("Error creating symlink %s and %s\n",
> +					       bdf_i, bdf_j);
> +
> +				retval = sysfs_create_link(sw_kobj[j], sw_kobj[i], bdf_i);
> +				if (retval)
> +					pr_err("Error creating symlink %s and %s\n",
> +					       bdf_j, bdf_i);
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Check if the two pci devices have virtual P2P link available.
> + * This function is used by the p2pdma to determine virtual
> + * links between the PCI-to-PCI bridges
> + */
> +bool sw_disc_check_virtual_link(struct pci_dev *a,
> +				 struct pci_dev *b)

"check" is not a meaningful name.  "if (check(...))" suggests nothing
about what true and false return values mean.  Name it so reading the
caller makes sense without looking at the implementation to find out
what the return values mean.

> +{
> +	char serial_num_a[SWD_MAX_CHAR], serial_num_b[SWD_MAX_CHAR];
> +
> +	/*
> +	 * Check if the PCIe devices support Virtual P2P links
> +	 */
> +	if (!sw_disc_is_supported_pdev(a))
> +		return false;
> +
> +	if (!sw_disc_is_supported_pdev(b))
> +		return false;
> +
> +	if (brcm_sw_is_p2p_supported(a, serial_num_a) &&
> +	    brcm_sw_is_p2p_supported(b, serial_num_b))
> +		if (!strcmp(serial_num_a, serial_num_b))
> +			return true;
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(sw_disc_check_virtual_link);
> +
> +static struct kobj_attribute sw_disc_attribute =
> +	__ATTR(SWD_FILE_NAME_STRING, 0444, sw_disc_show, NULL);
> +
> +// Create attribute group

We don't use // comments.

> +static struct attribute *attrs[] = {
> +	&sw_disc_attribute.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group attr_group = {
> +	.attrs = attrs,
> +};
> +
> +static int __init sw_discovery_init(void)
> +{
> +	int i, retval;
> +
> +	for (i = 0; i < SWD_MAX_VIRT_SWITCH; i++)
> +		sw_kobj[i] = NULL;
> +
> +	// Create "sw_disc" kobject
> +	sw_disc_kobj = kobject_create_and_add(SWD_DIR_STRING, kernel_kobj);
> +	if (!sw_disc_kobj) {
> +		pr_err("Failed to create sw_disc_kobj\n");
> +		return -ENOMEM;
> +	}
> +
> +	retval = sysfs_create_group(sw_disc_kobj, &attr_group);
> +	if (retval) {
> +		pr_err("Cannot register sysfs attribute group\n");
> +		kobject_put(sw_disc_kobj);
> +	}
> +
> +	swdata = kzalloc(sizeof(swdata) * SWD_MAX_VIRT_SWITCH, GFP_KERNEL);
> +	if (!swdata) {
> +		sysfs_remove_group(sw_disc_kobj, &attr_group);
> +		kobject_put(sw_disc_kobj);
> +		return 0;
> +	}
> +
> +	pr_info("Loading PCIe switch discovery module, version %s\n",
> +		SWITCH_DISC_VERSION);
> +
> +	return 0;
> +}
> +
> +static void __exit sw_discovery_exit(void)
> +{
> +	int i;
> +
> +	if (!swdata)
> +		kfree(swdata);
> +
> +	for (i = 0; i < SWD_MAX_VIRT_SWITCH; i++) {
> +		if (sw_kobj[i])
> +			kobject_put(sw_kobj[i]);
> +	}
> +
> +	// Remove kobject
> +	if (sw_link_kobj)
> +		kobject_put(sw_link_kobj);
> +
> +	sysfs_remove_group(sw_disc_kobj, &attr_group);
> +	kobject_put(sw_disc_kobj);
> +}
> +
> +module_init(sw_discovery_init);
> +module_exit(sw_discovery_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Broadcom Inc.");
> +MODULE_VERSION(SWITCH_DISC_VERSION);
> +MODULE_DESCRIPTION("PCIe Switch Discovery Module");

> +++ b/drivers/pci/switch/switch_discovery.h

> +#define PCI_VENDOR_ID_LSI			0x1000

Already exists: PCI_VENDOR_ID_LSI_LOGIC

