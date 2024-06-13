Return-Path: <linux-pci+bounces-8733-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E73E9071CA
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 14:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74BFDB268BE
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 12:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC07139CFE;
	Thu, 13 Jun 2024 12:40:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C8C161;
	Thu, 13 Jun 2024 12:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282417; cv=none; b=K9m+lO94AM5cUjXMXveFvPKupAEwVwu1QxtXdAbDeXEDLpDZ+uUEQU9vRRdR8l2XAdtG1sJ4hnwQjGF2mv/91KPqoilSnynbzEaRNyXMDIY93HBYyPrPvT2QMDf5kaRHnzZb2I2DBGewFHmqeSs2K7xalAjoJl+wR6sqROIOGEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282417; c=relaxed/simple;
	bh=P/jZt5pzDcv9VG3JpSM/zeAdwqCDaaPpD1QSdsub+Gw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TDrSB/nq9MQmTtoWwq4lz2JSrx0g7xAv/O9rSpO2oJGdxeN6Ww28zBW7y91EZ7yueDer8bSd3bFMCZo82xNbrR5iqJbHNA1BHm4FoOvh4iO+cCrQyDvGRtLWFPeGOZ3FQW2LYu+KCrSiKTTLks+ZtT+cqDMI/E8ojdZz1rVHoMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W0MQw2C0sz6K9HG;
	Thu, 13 Jun 2024 20:38:48 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 01723140B2A;
	Thu, 13 Jun 2024 20:40:11 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 13 Jun
 2024 13:40:04 +0100
Date: Thu, 13 Jun 2024 13:40:03 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
CC: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
	<linux-kernel@vger.kernel.org>, <sumanesh.samanta@broadcom.com>,
	<sathya.prakash@broadcom.com>
Subject: Re: [PATCH 1/2] switch_discovery: Add new module to discover inter
 switch links between PCI-to-PCI bridges
Message-ID: <20240613134003.00003a38@Huawei.com>
In-Reply-To: <1718191656-32714-2-git-send-email-shivasharan.srikanteshwara@broadcom.com>
References: <1718191656-32714-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
	<1718191656-32714-2-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 12 Jun 2024 04:27:35 -0700
Shivasharan S <shivasharan.srikanteshwara@broadcom.com> wrote:

> This kernel module discovers the virtual inter-switch P2P links present
> between two PCI-to-PCI bridges that allows an optimal data path for data
> movement. The module creates sysfs entries for upstream PCI-to-PCI
> bridges which supports the inter switch P2P links as below:
>=20
>                              Host root bridge
>                 ---------------------------------------
>                 |                                     |
>   NIC1 --- PCI Switch1 --- Inter-switch link --- PCI Switch2 --- NIC2
> (af:00.0)   (ad:00.0)                             (8b:00.0)   (8d:00.0)
>                 |                                     |
>                GPU1                                  GPU2
>             (b0:00.0)                             (8e:00.0)
>                                SERVER 1
>=20
> /sys/kernel/pci_switch_link/virtual_switch_links
> =E2=94=9C=E2=94=80=E2=94=80 0000:8b:00.0
> =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 0000:ad:00.0 -> ../0000=
:ad:00.0
> =E2=94=94=E2=94=80=E2=94=80 0000:ad:00.0
>     =E2=94=94=E2=94=80=E2=94=80 0000:8b:00.0 -> ../0000:8b:00.0

It think the functionality is useful in general.

Not sure that's an appropriate location though.  I'd rather
see something in in each of the USP devices that references
to others they share with.  I also don't think we actually care
if these are virtual or real inter switch links (which are hidden
from the host anyway I think?)  The discovery means might be different
in those case (large 'switch' made up of multiple connected smaller
switches).  We may want a way to discover the bandwidth though.


Needs a formal sysfs doc under
Documentation/ABI/testing/sysfs*  (not totally sure where for this
interface, but I think that location will change anyway)

The comments below are mostly superficial. I need to think a bit
more on how this might fit better with the linux driver model
as I really don't like magic things that cross many devices.

>=20
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
>=20
> diff --git a/Documentation/driver-api/pci/switch_discovery.rst b/Document=
ation/driver-api/pci/switch_discovery.rst
> new file mode 100644
> index 000000000000..7c1476260e5e
> --- /dev/null
> +++ b/Documentation/driver-api/pci/switch_discovery.rst
> @@ -0,0 +1,52 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Linux PCI Switch discovery module
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Modern PCI switches support inter switch Peer-to-Peer(P2P) data transfer
> +without using host resources. For example, Broadcom(PLX) PCIe Switches h=
ave a
> +capability where a single physical switch can be divided up into multiple
> +virtual switches at SOD. PCIe switch discovery module detects the virtua=
l links
> +between the switches that belong to the same physical switch.
> +This allows user space applications to discover these virtual links that=
 belong
> +to the same physical switch and configure optimized data paths.
> +
> +Userspace Interface
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The module exposes sysfs entries for user space applications like MPI, N=
CCL,
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
> +The simple topology above shows SERVER1, has Switch1 and Switch2 which a=
re
> +virtual switches that belong to the same physical switch that support
> +Inter switch P2P.
> +Switch1 and Switch2 have a GPU and NIC each connected.
> +The module will detect the virtual P2P link existing between the two swi=
tches
> +and create the sysfs entries as below.
> +
> +/sys/kernel/pci_switch_link/virtual_switch_links
> +=E2=94=9C=E2=94=80=E2=94=80 0000:8b:00.0
> +=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 0000:ad:00.0 -> ../000=
0:ad:00.0
> +=E2=94=94=E2=94=80=E2=94=80 0000:ad:00.0
> +    =E2=94=94=E2=94=80=E2=94=80 0000:8b:00.0 -> ../0000:8b:00.0
> +
> +The HPC/AI libraries that analyze the topology can decide the optimal da=
ta
> +path like: NIC1->GPU1->GPU2->NIC1 which would have otherwise take a
> +non-optimal path like NIC1->GPU1->GPU2->GPU1->NIC1.
> +
> +Enable P2P DMA to discover virtual links
> +----------------------------------------
> +The module also enhances :c:func:`pci_p2pdma_distance()` to determine a =
virtual
> +link between the upstream PCI-to-PCI bridges of the devices and detect o=
ptimal
> +path for applications using P2P DMA API.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 823387766a0c..b1bf3533ea6f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17359,6 +17359,19 @@ F:	Documentation/driver-api/pci/p2pdma.rst
>  F:	drivers/pci/p2pdma.c
>  F:	include/linux/pci-p2pdma.h
> =20
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
> =20
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
>  obj-$(CONFIG_PCI_SW_SWITCHTEC) +=3D switchtec.o
> +obj-$(CONFIG_PCI_SW_DISCOVERY) +=3D switch_discovery.o
> diff --git a/drivers/pci/switch/switch_discovery.c b/drivers/pci/switch/s=
witch_discovery.c
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

Pick an ordering scheme for headers. Can't remember which PCI uses
but alphabetical is always a good starting point unless there is
a local standard.

> +#include "switch_discovery.h"
> +
> +static DECLARE_RWSEM(sw_disc_rwlock);
> +static struct kobject *sw_disc_kobj, *sw_link_kobj;
> +static struct kobject *sw_kobj[SWD_MAX_VIRT_SWITCH];
Why can't this be dynamically sized?  Use a list.

> +static DECLARE_BITMAP(swdata_valid, SWD_MAX_VIRT_SWITCH);
> +
> +static struct switch_data *swdata;
> +
> +static int sw_disc_probe(void);
> +static int sw_disc_create_sysfs_files(void);
> +static bool brcm_sw_is_p2p_supported(struct pci_dev *pdev, char *serial_=
num);

Can you reorder the code to avoid the need for these forwards definitions?

> +
> +static inline bool sw_disc_is_supported_pdev(struct pci_dev *pdev)
> +{
> +	if ((pdev->vendor =3D=3D PCI_VENDOR_ID_LSI) &&
> +	   ((pdev->device =3D=3D PCI_DEVICE_ID_BRCM_PEX_89000_HLC) ||
> +	    (pdev->device =3D=3D PCI_DEVICE_ID_BRCM_PEX_89000_LLC)))
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
> +	retval =3D sw_disc_probe();
> +	if (!retval) {
> +		pr_debug("No new switch found\n");
> +		goto exit_success;
> +	}
> +
> +	retval =3D sw_disc_create_sysfs_files();
> +	if (retval < 0) {
> +		pr_err("Failed to create the sysfs entries, retval %d\n",
> +		       retval);
> +	}
> +
> +exit_success:
> +	up_write(&sw_disc_rwlock);
> +	return sysfs_emit(buf, SWD_SCAN_DONE);
Don't have side effects on a read.  Write 1 to the file to scan and when
it is done, return len;

> +}
> +
> +/* This function probes the PCIe devices for virtual links */

I'm not sure if a bus walk and search is the right way to do this.

I need to think on this more, but options that occur are:
1) Do it in the PCI core (so without a driver binding).
   /sys/bus/pci/devices/0000:0c:00.0/isl/0000:12:00.0 -> ../../../0000:12:0=
0.0
   Controversial perhaps because PCIe provides no 'standard' way to discover
   this but it it is slim enough, maybe?

2) Do it in portdrv as that will currently bind to the USP anyway.

There are other discussions on going on refactoring the pcie portdrv
and this usecase might well fit in there.  Doesn't seem very invasive
to add this.

> +static int sw_disc_probe(void)
> +{
> +	int i, bit;
> +	struct pci_dev *pdev =3D NULL;
> +	int topology_changed =3D 0;
> +	DECLARE_BITMAP(sw_found_map, SWD_MAX_VIRT_SWITCH);

As above, I'd use a list of found virtual switches then removal
is dropping an entry from middle of that list.
Probe finds what is there and moves things to a new temporary list.
Delete anything left on the old list.

> +
> +	while ((pdev =3D pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) !=3D NUL=
L) {

Not using the port class code?  Feels like every switch will if this isn't
in a different function? (I've been assuming it is vsec on the USP function)

> +		int sw_found;
> +
> +		/* Currently this function only traverses Broadcom
> +		 * PEX switches and determines the virtual SW links.
> +		 * Other Switch vendors can add their specific logic
> +		 * determine the virtual links.
> +		 */

I'd move this comment to the supported query. As you observe, it is
general in principle.

> +		if (!sw_disc_is_supported_pdev(pdev))

It's not really about discovering switches. So I'd call it
sw_might_be_virtual_switch() or something like that.

I'm sure we'll eventually have to handle multiple physical switches
with a real interswitchlink at some point, but that can be addressed
separately.


> +			continue;
> +
> +		sw_found =3D -1;

int sw_found =3D -1; above

> +
> +		for_each_set_bit(bit, swdata_valid, SWD_MAX_VIRT_SWITCH) {
> +			if (swdata[bit].devfn =3D=3D pdev->devfn &&
> +			    swdata[bit].bus =3D=3D pdev->bus) {

Can we use an xarray or similar to do this lookup?

> +				sw_found =3D bit;
> +				set_bit(sw_found, sw_found_map);
> +				break;
> +			}
> +		}
> +
> +		if (sw_found !=3D -1)
> +			continue;
> +
> +		for (i =3D 0; i < SWD_MAX_VIRT_SWITCH; i++)
> +			if (!swdata[i].bus)
> +				break;
> +
> +		if (i >=3D SWD_MAX_VIRT_SWITCH) {
> +			pr_err("Max switch exceeded\n");
> +			break;
> +		}
> +
> +		sw_found =3D i;
> +
> +		if (!brcm_sw_is_p2p_supported(pdev, (char *)&swdata[sw_found].serial_n=
um))
> +			continue;
> +
> +		/* Found a new switch which supports P2P */
> +		swdata[sw_found].devfn =3D pdev->devfn;
> +		swdata[sw_found].bus =3D pdev->bus;
> +
> +		topology_changed =3D 1;
> +		set_bit(sw_found, sw_found_map);
> +		set_bit(sw_found, swdata_valid);
> +	}
> +
> +	/* handle device removal */
> +	for_each_clear_bit(bit, sw_found_map, SWD_MAX_VIRT_SWITCH) {
> +		if (test_bit(bit, swdata_valid)) {
> +			memset(&swdata[bit], 0, sizeof(swdata[i]));
> +			clear_bit(bit, swdata_valid);
> +			topology_changed =3D 1;
> +		}
> +	}
> +
> +	return topology_changed;
> +}
> +
> +/* Check the various config space registers of the Broadcom PCI device a=
nd
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
> +	base =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DSN);
> +	if (!base) {
> +		pr_debug("Failed to get extended capability bus %x devfn %x\n",
> +			 pdev->bus->number, pdev->devfn);
> +		return false;
> +	}

I'd just call pci_get_dsn()   If it doesn't return 0 the cap is there
and we get the value and just use it.


> +
> +	vsec =3D pci_find_vsec_capability(pdev, PCI_VENDOR_ID_LSI, 1);
> +	if (!vsec) {
> +		pr_debug("Failed to get VSEC bus %x devfn %x\n",
> +			 pdev->bus->number, pdev->devfn);
> +		return false;
> +	}
> +
> +	if (pci_pcie_type(pdev) !=3D PCI_EXP_TYPE_UPSTREAM)
> +		return false;

I'd do this first.  Will apply to a lot of matches and this
is much cheaper than finding capabilities.

> +
> +	pci_read_config_dword(pdev, base + 8, &cap_data1);
> +	pci_read_config_dword(pdev, base + 4, &cap_data2);
> +
> +	pci_read_config_dword(pdev, vsec + 12, &vsec_data);

Use a define for that vsec offset that gives some indication
of it's purpose in the LSI VSEC. =20

> +
> +	pr_debug("Found Broadcom device bus 0x%x devfn 0x%x "
> +		 "Serial Number: 0x%x 0x%x, VSEC 0x%x\n",
> +		 pdev->bus->number, pdev->devfn,
> +		 cap_data1, cap_data2, vsec_data);
> +
> +	if (!SECURE_PART(cap_data1))
> +		return false;
FIELD_GET()

> +
> +	if (!(P2PMASK(vsec_data) & INTER_SWITCH_LINK))

FIELD_GET() for the relevant bits in each.

> +		return false;
> +
> +	if (serial_num)
> +		snprintf(serial_num, SWD_MAX_CHAR, "%x%x", cap_data1, cap_data2);
Just use the u64.=20
> +
> +	return true;
> +}
> +
> +static int sw_disc_create_sysfs_files(void)
> +{
> +	int i, j, retval;
> +
> +	for (i =3D 0; i < SWD_MAX_VIRT_SWITCH; i++) {
> +		if (sw_kobj[i]) {
> +			kobject_put(sw_kobj[i]);
> +			sw_kobj[i] =3D NULL;
If you are freeing kobjects in a creation path something went wrong.
Don't do this - if it makes sense free them before calling this create func=
tion.

> +		}
> +	}
> +
> +	if (sw_link_kobj) {
> +		kobject_put(sw_link_kobj);
> +		sw_link_kobj =3D NULL;
> +	}
> +
> +	sw_link_kobj =3D kobject_create_and_add(SWD_LINK_DIR_STRING, sw_disc_ko=
bj);

Don't use defines for file names. We want to see them inline as
much more readable!

> +	if (!sw_link_kobj) {
> +		pr_err("Failed to create pci link object\n");
> +		return -ENOMEM;
> +	}
> +
> +	for (i =3D 0; i < SWD_MAX_VIRT_SWITCH; i++) {
> +		int segment, bus, device, function;
> +		char bdf_i[SWD_MAX_CHAR];

No obvious reason why this is the same length as serial numbers?
Use an appropriate define for each.  We print the bdf in
various places, maybe there is already a suitable define and if
not perhaps worth adding one.

> +
> +		if (!test_bit(i, swdata_valid))
> +			continue;
> +
> +		segment =3D pci_domain_nr(swdata[i].bus);
> +		bus =3D swdata[i].bus->number;
> +		device =3D pci_ari_enabled(swdata[i].bus) ?
> +				0 : PCI_SLOT(swdata[i].devfn);
> +		function =3D pci_ari_enabled(swdata[i].bus) ?
> +				swdata[i].devfn : PCI_FUNC(swdata[i].devfn);
> +		sprintf(bdf_i, "%04x:%02x:%02x.%x",
> +			segment, bus, device, function);
> +
> +		for (j =3D i + 1; j < SWD_MAX_VIRT_SWITCH; j++) {
> +			char bdf_j[SWD_MAX_CHAR];
> +
> +			if (!test_bit(j, swdata_valid))
> +				continue;
> +			segment =3D pci_domain_nr(swdata[j].bus);
> +			bus =3D swdata[j].bus->number;
> +			device =3D pci_ari_enabled(swdata[j].bus) ?
> +					0 : PCI_SLOT(swdata[j].devfn);
> +			function =3D pci_ari_enabled(swdata[j].bus) ?
> +					swdata[j].devfn : PCI_FUNC(swdata[j].devfn);
> +			sprintf(bdf_j, "%04x:%02x:%02x.%x",
> +				segment, bus, device, function);
> +
> +			if (strcmp(swdata[i].serial_num, swdata[j].serial_num) =3D=3D 0) {
> +				if (!sw_kobj[i]) {
> +					sw_kobj[i] =3D kobject_create_and_add(bdf_i,
> +									    sw_link_kobj);
> +					if (!sw_kobj[i]) {
> +						pr_err("Failed to create sysfs entry for switch %s\n",
> +						       bdf_i);
> +					}
> +				}
> +
> +				if (!sw_kobj[j]) {
> +					sw_kobj[j] =3D kobject_create_and_add(bdf_j,
> +									    sw_link_kobj);
> +					if (!sw_kobj[j]) {
> +						pr_err("Failed to create sysfs entry for switch %s\n",
> +						       bdf_j);
> +					}
> +				}
> +
> +				retval =3D sysfs_create_link(sw_kobj[i], sw_kobj[j], bdf_j);
> +				if (retval)
> +					pr_err("Error creating symlink %s and %s\n",
> +					       bdf_i, bdf_j);
> +
> +				retval =3D sysfs_create_link(sw_kobj[j], sw_kobj[i], bdf_i);
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
No need to wrrap line.

> +{
> +	char serial_num_a[SWD_MAX_CHAR], serial_num_b[SWD_MAX_CHAR];
> +
> +	/*
> +	 * Check if the PCIe devices support Virtual P2P links
> +	 */

Single line comment
	/* Check if the PCIe devices support Virtual P2P links */

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
> +static struct kobj_attribute sw_disc_attribute =3D
> +	__ATTR(SWD_FILE_NAME_STRING, 0444, sw_disc_show, NULL);

As below. Use string directly for file names, don't hide it behind
a define.

> +
> +// Create attribute group
Drop comment + if it was here /* */

> +static struct attribute *attrs[] =3D {
> +	&sw_disc_attribute.attr,
> +	NULL,
No comma on NULL terminators as we won't add anything after them.

> +};
> +
> +static struct attribute_group attr_group =3D {
> +	.attrs =3D attrs,
> +};
> +
> +static int __init sw_discovery_init(void)
> +{
> +	int i, retval;
> +
> +	for (i =3D 0; i < SWD_MAX_VIRT_SWITCH; i++)
> +		sw_kobj[i] =3D NULL;
> +
> +	// Create "sw_disc" kobject

Drop any 'obvious' comments.

> +	sw_disc_kobj =3D kobject_create_and_add(SWD_DIR_STRING, kernel_kobj);
> +	if (!sw_disc_kobj) {
> +		pr_err("Failed to create sw_disc_kobj\n");
> +		return -ENOMEM;
> +	}
> +
> +	retval =3D sysfs_create_group(sw_disc_kobj, &attr_group);
> +	if (retval) {
> +		pr_err("Cannot register sysfs attribute group\n");
> +		kobject_put(sw_disc_kobj);
return an error.
> +	}
> +
> +	swdata =3D kzalloc(sizeof(swdata) * SWD_MAX_VIRT_SWITCH, GFP_KERNEL);
> +	if (!swdata) {
> +		sysfs_remove_group(sw_disc_kobj, &attr_group);
> +		kobject_put(sw_disc_kobj);
return an error.
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
I'm fairly sure that if you return an error in failure above (which shouldn=
't
fail anyway) you won't need this protection as for exit() to be called init=
()
must have succeeded and the data must have been allocated.

> +		kfree(swdata);
> +
> +	for (i =3D 0; i < SWD_MAX_VIRT_SWITCH; i++) {
> +		if (sw_kobj[i])
> +			kobject_put(sw_kobj[i]);
> +	}
> +
> +	// Remove kobject

/* Remove kobject */ but that's pretty obvious anyway so better to just dro=
p the
comment.


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
> diff --git a/drivers/pci/switch/switch_discovery.h b/drivers/pci/switch/s=
witch_discovery.h
> new file mode 100644
> index 000000000000..b84f5d2e29ac
> --- /dev/null
> +++ b/drivers/pci/switch/switch_discovery.h
> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + *  PCI Switch Discovery module
> + *
> + *  Copyright (c) 2024  Broadcom Inc.
> + *
> + *  Authors: Broadcom Inc.
> + *           Sumanesh Samanta <sumanesh.samanta@broadcom.com>
> + *           Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Why is the header needed?  Only seems to be used from one c file.
Move everything down there and drop this file.

> + */
> +
> +#ifndef PCI_SWITCH_DISC_H
> +#define PCI_SWITCH_DISC_H
> +
> +#define SWD_MAX_SWITCH		32
> +#define SWD_MAX_VER_PER_SWITCH	8
> +
> +#define SWD_MAX_VIRT_SWITCH	(SWD_MAX_SWITCH * SWD_MAX_VER_PER_SWITCH)
> +#define SWD_MAX_CHAR		16

Name this so it's clearer what it is sizing.

> +#define SWITCH_DISC_VERSION	"0.1.1"

Whilst there are module versions in the kernel etc, they are meaningless
as we must support backwards compatibility anyway. So don't give
it a version (this is basically ancient legacy no one uses any more)

> +#define SWD_DIR_STRING		"pci_switch_link"
All these better inline.  Defines just make yoru code harder to read.
> +#define SWD_LINK_DIR_STRING	"virtual_switch_links"
> +#define SWD_SCAN_DONE		"done\n"
Definitely inline!

> +
> +#define SWD_FILE_NAME_STRING	refresh_switch_toplogy
Just use the string directly inline. This doesn't belong in
a header.
> +
> +/* Broadcom Vendor Specific definitions */
> +#define PCI_VENDOR_ID_LSI			0x1000
> +#define PCI_DEVICE_ID_BRCM_PEX_89000_HLC	0xC030
> +#define PCI_DEVICE_ID_BRCM_PEX_89000_LLC	0xC034

> +
> +#define P2PMASK(x)		(((x) & 0x300) >> 8)

Use FIELD_GET() on the mask alone and make sure it's clear from
naming what register this applies to.

> +#define SECURE_PART(x)		((x) & 0x8)
> +#define INTER_SWITCH_LINK	0x2
Give this a name that matches with a register name or smilar.

> +
> +struct switch_data {

More specific name needed as this will clash with something at somepoint
in the future

> +	int  devfn;
extra space before devfn.

> +	struct pci_bus *bus;
> +	char serial_num[SWD_MAX_CHAR];
> +};
> +
> +bool sw_disc_check_virtual_link(struct pci_dev *a, struct pci_dev *b);
> +
> +#endif /* PCI_SWITCH_DISC_H */


