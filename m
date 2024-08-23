Return-Path: <linux-pci+bounces-12086-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 989F895CB0D
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 12:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE691C22251
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 10:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF3418732C;
	Fri, 23 Aug 2024 10:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EmciLw9H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3DD37144;
	Fri, 23 Aug 2024 10:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724410432; cv=none; b=psaWx0C7Rf+nwHIlmab5PJDi5fhwCKYH6ylI2b6RKwqvqeU2wDAJCJRoAie6eDh5Du5HRZEY7OOkD2al98IsEGGw/fkm3bZoiIMcHDoz/Zl0ukazbk0tAdowxz92HyN6Gnk/qdqO8/kHVB3ueB15AhBQ39z3T6RjxyjCxHsaRMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724410432; c=relaxed/simple;
	bh=iGkLY/v6ghXA1OxL7cIoBgQyjf7ERgHHew9RY/Ed3fM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=L2xLv/OAVsJozmHOSLc8hXtEpEHvBxuCEImkYHH34vOyWryvoDShwBoMypoVANlEOMWmrQCEJFqdBJ554mp685RRLFDRxZfY8MBs6Q2usd6yNLM/7hh+SJ65IaNdHuQBBLeyq715hBAEJYoWjK0nIEm/QFbXQNXt/n7HE1ID15E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EmciLw9H; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724410431; x=1755946431;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iGkLY/v6ghXA1OxL7cIoBgQyjf7ERgHHew9RY/Ed3fM=;
  b=EmciLw9HL9GWMkXidTQCvRmeZyCUC0BFBhleMKKIDVgzxI89rJzZzxyQ
   A5qsvR1a+QB+VPB3nccNp9L7aEKebr9W/MJ39bTdpINecCc2EDdYuH3/w
   3oMtI0L45dPmMpWtMPcWpfjCTjDg+WaOHJaN/g/yzYIWrEa5Qu6jsn8qI
   KtSPJQGdRx2QEh5DoTHiTTkD0QRmYl1ftumceSOkK5Jzl4Mof2WPA/ffN
   y3A57EtjmCc2mKcNZyypamAN6I0bLsUpMcNkw900yuYIJDG9CmYra8JxQ
   UXcUeXIwEs2DPgm4qBt8wV5w4ACTzEV1Adlq+AWrtIFMNZUNmpX3lNQ0J
   A==;
X-CSE-ConnectionGUID: 4yb7JnttR4q4uLFUvK+orw==
X-CSE-MsgGUID: gAXhFwR4TTiLCVQgIS/y3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="23044432"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="23044432"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 03:53:50 -0700
X-CSE-ConnectionGUID: Wl5cllhrRJGRNFkTG7pLpg==
X-CSE-MsgGUID: UyYMN4NLTda+PYeMUiQl/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="61913835"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.2])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 03:53:46 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 23 Aug 2024 13:53:42 +0300 (EEST)
To: Shijith Thotton <sthotton@marvell.com>
cc: bhelgaas@google.com, Jonathan.Cameron@Huawei.com, 
    LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, 
    "Rafael J. Wysocki" <rafael@kernel.org>, scott@os.amperecomputing.com, 
    jerinj@marvell.com, schalla@marvell.com, vattunuru@marvell.com
Subject: Re: [PATCH v2] PCI: hotplug: Add OCTEON PCI hotplug controller
 driver
In-Reply-To: <20240823052251.1087505-1-sthotton@marvell.com>
Message-ID: <a4a8a1f9-3b9c-7827-3e98-44009d8d440d@linux.intel.com>
References: <PH0PR18MB442535D2828B701CD84A3994D98E2@PH0PR18MB4425.namprd18.prod.outlook.com> <20240823052251.1087505-1-sthotton@marvell.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 23 Aug 2024, Shijith Thotton wrote:

> This patch introduces a PCI hotplug controller driver for the OCTEON
> PCIe device, a multi-function PCIe device where the first function acts
> as a hotplug controller. It is equipped with MSI-x interrupts to notify
> the host of hotplug events from the OCTEON firmware.
> 
> The driver facilitates the hotplugging of non-controller functions
> within the same device. During probe, non-controller functions are
> removed and registered as PCI hotplug slots. The slots are added back
> only upon request from the device firmware. The driver also allows the
> enabling and disabling of the slots via sysfs slot entries, provided by
> the PCI hotplug framework.
> 
> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> Co-developed-by: Vamsi Attunuru <vattunuru@marvell.com>
> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> ---
> 
> This patch introduces a PCI hotplug controller driver for OCTEON PCIe hotplug
> controller. The OCTEON PCIe device is a multi-function device where the first
> function acts as a PCI hotplug controller.
> 
>               +--------------------------------+
>               |           Root Port            |
>               +--------------------------------+
>                               |
>                              PCIe
>                               |
> +---------------------------------------------------------------+
> |              OCTEON PCIe Multifunction Device                 |
> +---------------------------------------------------------------+
>             |                    |              |            |
>             |                    |              |            |
> +---------------------+  +----------------+  +-----+  +----------------+
> |      Function 0     |  |   Function 1   |  | ... |  |   Function 7   |
> | (Hotplug controller)|  | (Hotplug slot) |  |     |  | (Hotplug slot) |
> +---------------------+  +----------------+  +-----+  +----------------+
>             |
>             |
> +-------------------------+
> |   Controller Firmware   |
> +-------------------------+
> 
> The hotplug controller driver facilitates the hotplugging of non-controller
> functions in the same device. During the probe of the driver, the non-controller
> function are removed and registered as PCI hotplug slots. They are added back
> only upon request from the device firmware. The driver also allows the user to
> enable/disable the functions using sysfs slot entries provided by PCI hotplug
> framework.
> 
> This solution adopts a hardware + software approach for several reasons:
> 
> 1. To reduce hardware implementation cost. Supporting complete hotplug
>    capability within the card would require a PCI switch implemented within.
> 
> 2. In the multi-function device, non-controller functions can act as emulated
>    devices. The firmware can dynamically enable or disable them at runtime.
> 
> 3. Not all root ports support PCI hotplug. This approach provides greater
>    flexibility and compatibility across different hardware configurations.
> 
> The hotplug controller function is lightweight and is equipped with MSI-x
> interrupts to notify the host about hotplug events. Upon receiving an
> interrupt, the hotplug register is read, and the required function is enabled
> or disabled.
> 
> This driver will be beneficial for managing PCI hotplug events on the OCTEON
> PCIe device without requiring complex hardware solutions.
> 
> Changes in v2:
> - Added missing include files.
> - Used dev_err_probe() for error handling.
> - Used guard() for mutex locking.
> - Splited cleanup actions and added per-slot cleanup action.
> - Fixed coding style issues.
> - Added co-developed-by tag.
> 
>  MAINTAINERS                    |   6 +
>  drivers/pci/hotplug/Kconfig    |  10 +
>  drivers/pci/hotplug/Makefile   |   1 +
>  drivers/pci/hotplug/octep_hp.c | 412 +++++++++++++++++++++++++++++++++
>  4 files changed, 429 insertions(+)
>  create mode 100644 drivers/pci/hotplug/octep_hp.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 42decde38320..7b5a618eed1c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13677,6 +13677,12 @@ R:	schalla@marvell.com
>  R:	vattunuru@marvell.com
>  F:	drivers/vdpa/octeon_ep/
>  
> +MARVELL OCTEON HOTPLUG CONTROLLER DRIVER
> +R:	Shijith Thotton <sthotton@marvell.com>
> +R:	Vamsi Attunuru <vattunuru@marvell.com>
> +S:	Supported
> +F:	drivers/pci/hotplug/octep_hp.c
> +
>  MATROX FRAMEBUFFER DRIVER
>  L:	linux-fbdev@vger.kernel.org
>  S:	Orphan
> diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
> index 1472aef0fb81..2e38fd25f7ef 100644
> --- a/drivers/pci/hotplug/Kconfig
> +++ b/drivers/pci/hotplug/Kconfig
> @@ -173,4 +173,14 @@ config HOTPLUG_PCI_S390
>  
>  	  When in doubt, say Y.
>  
> +config HOTPLUG_PCI_OCTEONEP
> +	bool "OCTEON PCI device Hotplug controller driver"
> +	depends on HOTPLUG_PCI
> +	help
> +	  Say Y here if you have an OCTEON PCIe device with a hotplug
> +	  controller. This driver enables the non-controller functions of the
> +	  device to be registered as hotplug slots.
> +
> +	  When in doubt, say N.
> +
>  endif # HOTPLUG_PCI
> diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
> index 240c99517d5e..40aaf31fe338 100644
> --- a/drivers/pci/hotplug/Makefile
> +++ b/drivers/pci/hotplug/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_HOTPLUG_PCI_RPA)		+= rpaphp.o
>  obj-$(CONFIG_HOTPLUG_PCI_RPA_DLPAR)	+= rpadlpar_io.o
>  obj-$(CONFIG_HOTPLUG_PCI_ACPI)		+= acpiphp.o
>  obj-$(CONFIG_HOTPLUG_PCI_S390)		+= s390_pci_hpc.o
> +obj-$(CONFIG_HOTPLUG_PCI_OCTEONEP)	+= octep_hp.o
>  
>  # acpiphp_ibm extends acpiphp, so should be linked afterwards.
>  
> diff --git a/drivers/pci/hotplug/octep_hp.c b/drivers/pci/hotplug/octep_hp.c
> new file mode 100644
> index 000000000000..3ac90ffff564
> --- /dev/null
> +++ b/drivers/pci/hotplug/octep_hp.c
> @@ -0,0 +1,412 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2024 Marvell. */
> +
> +#include <linux/cleanup.h>
> +#include <linux/container_of.h>
> +#include <linux/delay.h>
> +#include <linux/dev_printk.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +#include <linux/pci_hotplug.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/workqueue.h>
> +
> +#define OCTEP_HP_INTR_OFFSET(x) (0x20400 + ((x) << 4))
> +#define OCTEP_HP_INTR_VECTOR(x) (16 + (x))
> +#define OCTEP_HP_DRV_NAME "octep_hp"
> +
> +/*
> + * Type of MSI-X interrupts.
> + * The macros OCTEP_HP_INTR_VECTOR and OCTEP_HP_INTR_OFFSET are used to
> + * generate the vector and offset for an interrupt type.
> + */
> +enum octep_hp_intr_type {
> +	OCTEP_HP_INTR_INVALID = -1,
> +	OCTEP_HP_INTR_ENA,
> +	OCTEP_HP_INTR_DIS,

Making these numbers explicit (since they cannot be just any numbers) fell 
through cracks.


-- 
 i.


