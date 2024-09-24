Return-Path: <linux-pci+bounces-13444-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B152984819
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 16:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07251F21EAC
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 14:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923691AAE2A;
	Tue, 24 Sep 2024 14:58:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D75F224D7;
	Tue, 24 Sep 2024 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727189883; cv=none; b=YaauaBCU/FSWm7XOsP4/ITM0L51mkfgyO0JK8nYMMRX6mCCATXijq4D+Ithvu1n57QKgvHSUybiE3OqZtP3M5693cegnjp8aQZjBgORd9y2WjchTdgISHnx7vvfiEIpJJWmGh3DIUwW08znoR1ATfF1eeB5M3x6HX/yNzqIn2cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727189883; c=relaxed/simple;
	bh=q6Cj1/QgGbOFeEJUTVWDo9jRzdiAClF33TA/Ns6qIUI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H6qE4a5sIuQ2Lg/E44LTRlYFNhc6Yuqksn/r0FIdCkhrFKNeZc26dcZ4l8FY96lCjMHZc3PsWDWaUcElDkkTvSwGmCEEyRLn2FMKKl99MI6WhElkroGVWgM5inRyjIBghyOnbEM1ziFI/ntva3yU9lOTKq2HXCBIO0Jz64h7g6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XCjXg0lkpz6K5lq;
	Tue, 24 Sep 2024 22:53:23 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 95411140B39;
	Tue, 24 Sep 2024 22:57:57 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Sep
 2024 16:57:57 +0200
Date: Tue, 24 Sep 2024 15:57:55 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
CC: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
	<manivannan.sadhasivam@linaro.org>, <logang@deltatee.com>,
	<linux-kernel@vger.kernel.org>, <sumanesh.samanta@broadcom.com>,
	<sathya.prakash@broadcom.com>, <sjeaugey@nvidia.com>
Subject: Re: [PATCH 1/2 v2] PCI/portdrv: Enable reporting inter-switch P2P
 links
Message-ID: <20240924155755.000069cd@Huawei.com>
In-Reply-To: <1726733624-2142-2-git-send-email-shivasharan.srikanteshwara@broadcom.com>
References: <1726733624-2142-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
	<1726733624-2142-2-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 19 Sep 2024 01:13:43 -0700
Shivasharan S <shivasharan.srikanteshwara@broadcom.com> wrote:

> Broadcom PCI switches supports inter-switch P2P links between two
> PCI-to-PCI bridges. This presents an optimal data path for data
> movement. The patch exports a new sysfs entry for PCI devices that
> support the inter switch P2P links and reports the B:D:F information
> of the devices that are connected through this inter switch link as
> shown below:
> 
>                              Host root bridge
>                 ---------------------------------------
>                 |                                     |
>   NIC1 --- PCI Switch1 --- Inter-switch link --- PCI Switch2 --- NIC2
> (2c:00.0)   (2a:00.0)                             (3d:00.0)   (40:00.0)
>                 |                                     |
>                GPU1                                  GPU2
>             (2d:00.0)                             (3f:00.0)
>                                SERVER 1
> 
> $ find /sys/ -name "p2p_link" | xargs grep .
> /sys/devices/pci0000:29/0000:29:01.0/0000:2a:00.0/p2p_link:0000:3d:00.0
> /sys/devices/pci0000:3c/0000:3c:01.0/0000:3d:00.0/p2p_link:0000:2a:00.0
> 
> Current support is added to report the P2P links available for
> Broadcom switches based on the capability that is reported by the
> upstream bridges through their vendor-specific capability registers.
> 
> Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
> Signed-off-by: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
> ---
> Changes in v2:
> Integrated the code into PCIe portdrv to create the sysfs entries during
> probe, as suggested by Mani.

Hmm. So we are trying to rework portdrv in general to support extensibility.
I'm a little nervous about taking in vendor specific code in the meantime
even if it is trivial like this is.  We will be having an extensible
discovery scheme but for now the plan is that will be child device based
for non PCI standard features.

It is a fairly small bit of code, so maybe it is fine - I'm not keen
on adding the implementation of the vendor specific parts to the
main driver though. Push that to an optional c file.

A few general comments inline.

> 
>  Documentation/ABI/testing/sysfs-bus-pci |  14 +++
>  drivers/pci/pcie/portdrv.c              | 131 ++++++++++++++++++++++++
>  drivers/pci/pcie/portdrv.h              |  10 ++
>  3 files changed, 155 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index ecf47559f495..e5d02f20655f 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -572,3 +572,17 @@ Description:
>  		enclosure-specific indications "specific0" to "specific7",
>  		hence the corresponding led class devices are unavailable if
>  		the DSM interface is used.
> +
> +What:		/sys/bus/pci/devices/.../p2p_link
> +Date:		September 2024
> +Contact:	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
> +Description:
> +		This file appears on PCIe upstream ports which supports an
> +		internal P2P link.
> +		Reading this attribute will provide the list of other upstream
> +		ports on the system which have an internal P2P link available
> +		between the two ports.

Given this only applies to 'internal' links and not inter switch physical links
I think you should rename it.  An eventual p2p link between physical switches
is going to be much more complex as will need routing information.
Let us avoid trampling on that space.

> +Users:
> +		Userspace applications interested in determining a optimal P2P
> +		link for data transfers between devices connected to the PCIe
> +		switches.

Need more data that 'there is a link' for this.
I'd like to see some info on bandwidth and latency. I've previously been
in discussions about similar devices that provide a low latency but low
bandwidth direct path.  That gets more likely if we scale up to
multiple physical switches or the software stack is choosing between
multiple p2p targets (e.g. getting nearest path to a multiheaded NIC).

Perhaps best bet is to leave space for that by using a directory
here to cover everything about p2p?  Maybe have links under there to the
other upstream ports? That might be fiddly to manage though.

> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 6af5e0425872..c940b4b242fd 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -18,6 +18,7 @@
>  #include <linux/string.h>
>  #include <linux/slab.h>
>  #include <linux/aer.h>
> +#include <linux/bitops.h>
>  
>  #include "../pci.h"
>  #include "portdrv.h"
> @@ -37,6 +38,134 @@ struct portdrv_service_data {
>  	u32 service;
>  };
>  
> +/**
> + * pcie_brcm_is_p2p_supported - Broadcom device specific handler
> + *       to check if the upstream port supports inter switch P2P.
> + *
> + * @dev: PCIe upstream port to check
> + *
> + * This function assumes the PCIe upstream port is a Broadcom
> + * PCIe device.
> + */
> +static bool pcie_brcm_is_p2p_supported(struct pci_dev *dev)

Put this in a separate c file + use a config option and some
stubs to make it go away if people don't want to support it.
The layering and separation in portdrv is currently messy but
we shouldn't make it worse :(

> +{
> +	u64 dsn;
> +	u16 vsec;
> +	u32 vsec_data;
> +
> +	dsn = pci_get_dsn(dev);
> +	if (!dsn) {
> +		pci_dbg(dev, "DSN capability is not present\n");
> +		return false;
> +	}

Why get the dsn (which will frequently exist on other devices)
before getting the vsec which won't?  Reorder these first
two checks. For most devices the match on vendor will fail in the
vsec check.

> +
> +	vsec = pci_find_vsec_capability(dev, PCI_VENDOR_ID_LSI_LOGIC,
> +					PCIE_BRCM_SW_P2P_VSEC_ID);
> +	if (!vsec) {
> +		pci_dbg(dev, "Failed to get VSEC capability\n");
> +		return false;
> +	}
> +
> +	pci_read_config_dword(dev, vsec + PCIE_BRCM_SW_P2P_MODE_VSEC_OFFSET,
> +			      &vsec_data);
> +
> +	pci_dbg(dev, "Serial Number: 0x%llx VSEC 0x%x\n",
> +		dsn, vsec_data);
> +
> +	if (!PCIE_BRCM_SW_IS_SECURE_PART(dsn))

Add a comment on this. Not obvious what this is checking as it's picking
a single bit out of a serial number...

> +		return false;
> +
> +	if (FIELD_GET(PCIE_BRCM_SW_P2P_MODE_MASK, vsec_data) !=
> +		PCIE_BRCM_SW_P2P_MODE_INTER_SW_LINK)
> +		return false;
> +
> +	return true;
	return FIELD_GET(PCIE_BRCM_SW_P2P_MODE_MASK, vsec_data) ==
	       PCIE_BRCM_SW_P2P_MODE_INTER_SW_LINK;
perhaps.

> +}
> +
> +/**
> + * Determine if device supports Inter switch P2P links.
> + *
> + * Return value: true if inter switch P2P is supported, return false otherwise.
> + */
> +static bool pcie_port_is_p2p_supported(struct pci_dev *dev)
> +{
> +	/* P2P link attribute is supported on upstream ports only */
> +	if (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM)
> +		return false;
> +
> +	/*
> +	 * Currently Broadcom PEX switches are supported.
> +	 */
> +	if (dev->vendor == PCI_VENDOR_ID_LSI_LOGIC &&
> +	    (dev->device == PCI_DEVICE_ID_BRCM_PEX_89000_HLC ||
> +	     dev->device == PCI_DEVICE_ID_BRCM_PEX_89000_LLC))
> +		return pcie_brcm_is_p2p_supported(dev);
> +
> +	return false;
> +}
> +
> +/*
> + * Traverse list of all PCI bridges and find devices that support Inter switch P2P
> + * and have the same serial number to create report the BDF over sysfs.
> + */
> +static ssize_t p2p_link_show(struct device *dev, struct device_attribute *attr,
> +			     char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev), *pdev_link = NULL;
> +	size_t len = 0;
> +	u64 dsn, dsn_link;
> +
> +	dsn = pci_get_dsn(pdev);

Maybe add a comment that we don't need to repeat checks that were done
to make the attribute visible. Hence dsn will exist and it will be p2p link capable.

> +
> +	/* Traverse list of PCI bridges to determine any available P2P links */
> +	while ((pdev_link = pci_get_class(PCI_CLASS_BRIDGE_PCI << 8, pdev_link))

Feels like we should have a for_each_pci_bridge() similar to for_each_pci_dev()
that does this, but that is already defined to mean something else...

Bjorn, is this something we should be looking to make more consistent
perhaps with naming to make it clear what is a search of all instances
on any bus and what is a search below a particular bus?

> +			!= NULL) {
> +		if (pdev_link == pdev)
> +			continue;
> +
> +		if (!pcie_port_is_p2p_supported(pdev_link))
> +			continue;
> +
> +		dsn_link = pci_get_dsn(pdev_link);
> +		if (!dsn_link)
> +			continue;
> +
> +		if (dsn == dsn_link)
> +			len += sysfs_emit_at(buf, len, "%04x:%02x:%02x.%d\n",
> +					     pci_domain_nr(pdev_link->bus),
> +					     pdev_link->bus->number, PCI_SLOT(pdev_link->devfn),
> +					     PCI_FUNC(pdev_link->devfn));
> +	}
> +
> +	return len;
> +}


> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> index 12c89ea0313b..1be06cb45665 100644
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -25,6 +25,16 @@
>  
>  #define PCIE_PORT_DEVICE_MAXSERVICES   5
>  
> +/* P2P Link supported device IDs */
> +#define PCI_DEVICE_ID_BRCM_PEX_89000_HLC	0xC030
> +#define PCI_DEVICE_ID_BRCM_PEX_89000_LLC	0xC034
> +
> +#define PCIE_BRCM_SW_P2P_VSEC_ID		0x1
> +#define PCIE_BRCM_SW_P2P_MODE_VSEC_OFFSET	0xC
> +#define PCIE_BRCM_SW_P2P_MODE_MASK		GENMASK(9, 8)
> +#define PCIE_BRCM_SW_P2P_MODE_INTER_SW_LINK	0x2
> +#define PCIE_BRCM_SW_IS_SECURE_PART(dsn)	((dsn) & 0x8)
Define the mask, and use FIELD_GET() to get that.
> +
>  extern bool pcie_ports_dpc_native;
>  
>  #ifdef CONFIG_PCIEAER


