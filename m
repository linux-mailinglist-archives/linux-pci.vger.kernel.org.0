Return-Path: <linux-pci+bounces-36790-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF504B9706C
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 19:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E37E2E0655
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 17:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C03227FB26;
	Tue, 23 Sep 2025 17:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVBCvLeE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2262425D540;
	Tue, 23 Sep 2025 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758648598; cv=none; b=ZkWdYygAR0lC2rneZHTUNtx+NVfowgH4UYuPYqCRnDesnstqvLfRpmy9yYxLfCjpWURyspyQvZzrivFm11xYldOmPaihIE7d2TuvTMs0v8oHBMw0UqrkVFQ96P3r52aTZUcfdMhqG5rYdLN3nAtl+VA6pGbAbqNIy84wzI0ReNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758648598; c=relaxed/simple;
	bh=JW9b1933GdW1RBbOvpjXMRWf45ICiGvWGtT1t24ar5E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hT8tuPXMzSdcnAar+eueTDUeWs4gUmo16kCKwdVf3dsD87WfSzcbJZEYrGEAg/jNbd8vxZA4zjbaeXdCv1ap2dImQPUImpLZAbyKEuyD0vJ3i5yK9rpqIs3MHZGFYQ2Xz2+AQrRehB0KC1bq7ORbwPaEKgEWACMoiodC5qoX8Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVBCvLeE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B60C4CEF5;
	Tue, 23 Sep 2025 17:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758648597;
	bh=JW9b1933GdW1RBbOvpjXMRWf45ICiGvWGtT1t24ar5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gVBCvLeEN7js5lmgDMRc1lRs6XvNnrIztN/O4iGf+W3ifw1iqFNWv84aFoUCIp3sV
	 IGRDhZ21Cg1im2ABOBnD7kU30H5eBAXSkaAF5PlVnvnYA71EPeRRHFlWaL07O4eC+N
	 Fch1FG3HylCD4DdjxU/diO4pXpYxOGQB7h+BF/+OEH+QqnwX2vI/tGPIc6Sc6koaNX
	 wuOF9quSgsv3tAZQslKwCg9WPYKrmTOP/ypHmBSUmVq1GluJIWWDUC30DwhAzFCowj
	 zd1jcmAR28QbQM7ayglB/35mzNUmcWXTPkDrxeR07jvducWrqWPi1v+wyhSML7a5Mb
	 Wb7lXS2RUY3pg==
Date: Tue, 23 Sep 2025 12:29:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tony Hutter <hutter2@llnl.gov>, Lukas Wunner <lukas@wunner.de>
Cc: corey@minyard.net, alok.a.tiwari@oracle.com,
	mariusz.tkaczyk@linux.intel.com, minyard@acm.org,
	linux-pci@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] Introduce Cray ClusterStor E1000 NVMe slot LED driver
Message-ID: <20250923172956.GA1956431@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea057313-d467-4bc2-9dcd-68dd57a715fa@llnl.gov>

On Tue, Aug 26, 2025 at 02:22:32PM -0700, Tony Hutter wrote:
> Add driver to control the NVMe slot LEDs on the Cray ClusterStor E1000.
> The driver provides hotplug attention status callbacks for the 24 NVMe
> slots on the E1000.  This allows users to access the E1000's locate and
> fault LEDs via the normal /sys/bus/pci/slots/<slot>/attention sysfs
> entries.  This driver uses IPMI to communicate with the E1000 controller
> to toggle the LEDs.
> 
> Signed-off-by: Tony Hutter <hutter2@llnl.gov>

Lukas, interested in your thoughts on this.

> ---
> Changes in v5:
>  - Removed unnecessary ipmi_smi.h #include.
>  - Added WARN_ON() to craye1k_do_message() to sanity check that craye1k->lock
>    is held.
>  - Added additional comments for when craye1k->lock should be held.
> 
> Changes in v4:
>  - Fix typo in Kconfig: "is it" ->  "it is"
>  - Rename some #defines to CRAYE1K_SUBCMD_*
>  - Use IS_ERR() check in craye1k_debugfs_init()
>  - Return -EIO instead of -EINVAL when LED value check fails
> 
> Changes in v3:
>  - Add 'attention' values in Documentation/ABI/testing/sysfs-bus-pci.
>  - Remove ACPI_PCI_SLOT dependency.
>  - Cleanup craye1k_do_message() error checking.
>  - Skip unneeded memcpy() on failure in __craye1k_do_command().
>  - Merge craye1k_do_command_and_netfn() code into craye1k_do_command().
>  - Make craye1k_is_primary() return boolean.
>  - Return negative error code on failure in craye1k_set_primary().
> 
> Changes in v2:
>  - Integrated E1000 code into the pciehp driver as an built-in
>    extention rather than as a standalone module.
>  - Moved debug tunables and counters to debugfs.
>  - Removed forward declarations.
>  - Kept the /sys/bus/pci/slots/<slot>/attention interface rather
>    than using NPEM/_DSM or led_classdev as suggested.  The "attention"
>    interface is more beneficial for our site, since it allows us to
>    control the NVMe slot LEDs agnostically across different enclosure
>    vendors and kernel versions using the same scripts.  It is also
>    nice to use the same /sys/bus/pci/slots/<slot>/ sysfs directory for
>    both slot LED toggling ("attention") and slot power control
>    ("power").
> ---
>  Documentation/ABI/testing/sysfs-bus-pci |  21 +
>  MAINTAINERS                             |   5 +
>  drivers/pci/hotplug/Kconfig             |  10 +
>  drivers/pci/hotplug/Makefile            |   3 +
>  drivers/pci/hotplug/pciehp.h            |   7 +
>  drivers/pci/hotplug/pciehp_core.c       |  12 +
>  drivers/pci/hotplug/pciehp_craye1k.c    | 672 ++++++++++++++++++++++++
>  7 files changed, 730 insertions(+)
>  create mode 100644 drivers/pci/hotplug/pciehp_craye1k.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 69f952fffec7..9b1c008c39c2 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -231,6 +231,27 @@ Description:
>  		    - scXX contains the device subclass;
>  		    - iXX contains the device class programming interface.
>  
> +What:		/sys/bus/pci/slots/.../attention
> +Date:		February 2025
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		The attention attribute is used to read or write the attention
> +		status for an enclosure slot.  This is often used to set the
> +		slot LED value on a NVMe storage enclosure.
> +
> +		Common values:
> +		0 = OFF
> +		1 = ON
> +		2 = blink (ampere, ibmphp, pciehp, rpaphp, shpchp)
> +
> +		Using the pciehp_craye1k extensions:
> +		0 = fault LED OFF, locate LED OFF
> +		1 = fault LED ON,  locate LED OFF
> +		2 = fault LED OFF, locate LED ON
> +		3 = fault LED ON,  locate LED ON
> +
> +		Other values are no-op, OFF, or ON depending on the driver.
> +
>  What:		/sys/bus/pci/slots/.../module
>  Date:		June 2009
>  Contact:	linux-pci@vger.kernel.org
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe168477caa4..6701fb9e211f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6459,6 +6459,11 @@ S:	Maintained
>  F:	Documentation/filesystems/cramfs.rst
>  F:	fs/cramfs/
>  
> +CRAY CLUSTERSTOR E1000 NVME SLOT LED DRIVER EXTENSIONS
> +M:	Tony Hutter <hutter2@llnl.gov>
> +S:	Maintained
> +F:	drivers/pci/hotplug/pciehp_craye1k.c
> +
>  CRC LIBRARY
>  M:	Eric Biggers <ebiggers@kernel.org>
>  R:	Ard Biesheuvel <ardb@kernel.org>
> diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
> index 3207860b52e4..8994bffe04c1 100644
> --- a/drivers/pci/hotplug/Kconfig
> +++ b/drivers/pci/hotplug/Kconfig
> @@ -183,4 +183,14 @@ config HOTPLUG_PCI_S390
>  
>  	  When in doubt, say Y.
>  
> +config HOTPLUG_PCI_PCIE_CRAY_E1000
> +	bool "PCIe Hotplug extensions for Cray ClusterStor E1000"
> +	depends on HOTPLUG_PCI_PCIE && IPMI_HANDLER=y
> +	help
> +	  Say Y here if you have a Cray ClusterStor E1000 and want to control
> +	  your NVMe slot LEDs.  Without this driver it is not possible
> +	  to control the fault and locate LEDs on the E1000's 24 NVMe slots.
> +
> +	  When in doubt, say N.
> +
>  endif # HOTPLUG_PCI
> diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
> index 40aaf31fe338..82a1f0592d0a 100644
> --- a/drivers/pci/hotplug/Makefile
> +++ b/drivers/pci/hotplug/Makefile
> @@ -66,6 +66,9 @@ pciehp-objs		:=	pciehp_core.o	\
>  				pciehp_ctrl.o	\
>  				pciehp_pci.o	\
>  				pciehp_hpc.o
> +ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
> +pciehp-objs		+=	pciehp_craye1k.o
> +endif
>  
>  shpchp-objs		:=	shpchp_core.o	\
>  				shpchp_ctrl.o	\
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index debc79b0adfb..f4c09a110a07 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -199,6 +199,13 @@ int pciehp_get_raw_indicator_status(struct hotplug_slot *h_slot, u8 *status);
>  
>  int pciehp_slot_reset(struct pcie_device *dev);
>  
> +#ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
> +int craye1k_get_attention_status(struct hotplug_slot *hotplug_slot, u8 *status);
> +int craye1k_set_attention_status(struct hotplug_slot *hotplug_slot, u8 status);
> +bool is_craye1k_slot(struct controller *ctrl);
> +int craye1k_init(void);
> +#endif
> +
>  static inline const char *slot_name(struct controller *ctrl)
>  {
>  	return hotplug_slot_name(&ctrl->hotplug_slot);
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> index f59baa912970..835052384879 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -73,6 +73,13 @@ static int init_slot(struct controller *ctrl)
>  		ops->get_attention_status = pciehp_get_raw_indicator_status;
>  		ops->set_attention_status = pciehp_set_raw_indicator_status;
>  	}
> +#ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
> +	if (is_craye1k_slot(ctrl)) {
> +		/* slots 1-24 on Cray E1000s are controlled differently */
> +		ops->get_attention_status = craye1k_get_attention_status;
> +		ops->set_attention_status = craye1k_set_attention_status;
> +	}
> +#endif
>  
>  	/* register this slot with the hotplug pci core */
>  	ctrl->hotplug_slot.ops = ops;
> @@ -378,6 +385,11 @@ int __init pcie_hp_init(void)
>  	pr_debug("pcie_port_service_register = %d\n", retval);
>  	if (retval)
>  		pr_debug("Failure to register service\n");
> +#ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
> +	retval = craye1k_init();
> +	if (retval)
> +		pr_debug("Failure to register Cray E1000 extensions");
> +#endif

This looks wrong to me; if pcie_port_service_register() fails, I think
we should return the failure and skip the craye1k init.

>  	return retval;
>  }
> diff --git a/drivers/pci/hotplug/pciehp_craye1k.c b/drivers/pci/hotplug/pciehp_craye1k.c
> new file mode 100644
> index 000000000000..211ac62c4d5b
> --- /dev/null
> +++ b/drivers/pci/hotplug/pciehp_craye1k.c
> @@ -0,0 +1,672 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2022-2024 Lawrence Livermore National Security, LLC
> + */
> +/*
> + * Cray ClusterStor E1000 hotplug slot LED driver extensions
> + *
> + * This driver controls the NVMe slot LEDs on the Cray ClusterStore E1000.
> + * It provides hotplug attention status callbacks for the 24 NVMe slots on
> + * the E1000.  This allows users to access the E1000's locate and fault
> + * LEDs via the normal /sys/bus/pci/slots/<slot>/attention sysfs entries.
> + * This driver uses IPMI to communicate with the E1000 controller to toggle
> + * the LEDs.
> + *
> + * This driver is based off of ibmpex.c
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/errno.h>
> +#include <linux/dmi.h>
> +#include <linux/ipmi.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/pci_hotplug.h>
> +#include <linux/random.h>
> +#include "pciehp.h"
> +
> +/* Cray E1000 commands */
> +#define CRAYE1K_CMD_NETFN       0x3c
> +#define CRAYE1K_CMD_PRIMARY     0x33
> +#define CRAYE1K_CMD_FAULT_LED   0x39
> +#define CRAYE1K_CMD_LOCATE_LED  0x22
> +
> +/* Subcommands */
> +#define CRAYE1K_SUBCMD_GET_LED		0x0
> +#define CRAYE1K_SUBCMD_SET_LED		0x1
> +#define CRAYE1K_SUBCMD_SET_PRIMARY	0x1
> +
> +/*
> + * Milliseconds to wait after get/set LED command.  200ms value found though
> + * experimentation
> + */
> +#define	CRAYE1K_POST_CMD_WAIT_MS	200

Looks like accidental tab instead of space here.

> +
> +struct craye1k {
> +	struct device *dev;   /* BMC device */
> +	struct mutex lock;
> +	struct completion read_complete;
> +	struct ipmi_addr address;
> +	struct ipmi_user *user;
> +	int iface;
> +
> +	long tx_msg_id;
> +	struct kernel_ipmi_msg tx_msg;
> +	unsigned char tx_msg_data[IPMI_MAX_MSG_LENGTH];
> +	unsigned char rx_msg_data[IPMI_MAX_MSG_LENGTH];
> +	unsigned long rx_msg_len;
> +	unsigned char rx_result;	/* IPMI completion code */
> +
> +	/* Parent dir for all our debugfs entries */
> +	struct dentry *parent;
> +
> +	/* debugfs stats */
> +	u64 check_primary;
> +	u64 check_primary_failed;
> +	u64 was_already_primary;
> +	u64 was_not_already_primary;
> +	u64 set_primary;
> +	u64 set_initial_primary_failed;
> +	u64 set_primary_failed;
> +	u64 set_led_locate_failed;
> +	u64 set_led_fault_failed;
> +	u64 set_led_readback_failed;
> +	u64 set_led_failed;
> +	u64 get_led_failed;
> +	u64 completion_timeout;
> +	u64 wrong_msgid;
> +	u64 request_failed;
> +
> +	/* debugfs configuration options */
> +
> +	/* Print info on spurious IPMI messages */
> +	bool print_errors;
> +
> +	/* Retries for kernel IPMI layer */
> +	u32 ipmi_retries;
> +
> +	/* Timeout in ms for IPMI (0 = use IPMI default_retry_ms) */
> +	u32 ipmi_timeout_ms;
> +
> +	/* Timeout in ms to wait for E1000 message completion */
> +	u32 completion_timeout_ms;
> +};
> +
> +/*
> + * Make our craye1k a global so get/set_attention_status() can access it.
> + * This is safe since there's only one node controller on the board, and so it's
> + * impossible to instantiate more than one craye1k.
> + */
> +static struct craye1k *craye1k_global;

The global pointer pattern is kind of problematic because it requires
implicit knowledge about the system to know that this is safe.  But I
guess you don't have a good place to stash the pointer otherwise.

> +/* Return parent dir dentry */
> +static struct dentry *
> +craye1k_debugfs_init(struct craye1k *craye1k)
> +{
> +	umode_t mode = 0644;
> +	struct dentry *parent = debugfs_create_dir("pciehp_craye1k", NULL);
> +
> +	if (IS_ERR(parent))
> +		return NULL;
> +
> +	debugfs_create_x64("check_primary", mode, parent,
> +			   &craye1k->check_primary);
> +	debugfs_create_x64("check_primary_failed", mode, parent,
> +			   &craye1k->check_primary_failed);
> +	debugfs_create_x64("was_already_primary", mode, parent,
> +			   &craye1k->was_already_primary);
> +	debugfs_create_x64("was_not_already_primary", mode, parent,
> +			   &craye1k->was_not_already_primary);
> +	debugfs_create_x64("set_primary", mode, parent,
> +			   &craye1k->set_primary);
> +	debugfs_create_x64("set_initial_primary_failed", mode, parent,
> +			   &craye1k->set_initial_primary_failed);
> +	debugfs_create_x64("set_primary_failed", mode, parent,
> +			   &craye1k->set_primary_failed);
> +	debugfs_create_x64("set_led_locate_failed", mode, parent,
> +			   &craye1k->set_led_locate_failed);
> +	debugfs_create_x64("set_led_fault_failed", mode, parent,
> +			   &craye1k->set_led_fault_failed);
> +	debugfs_create_x64("set_led_readback_failed", mode, parent,
> +			   &craye1k->set_led_readback_failed);
> +	debugfs_create_x64("set_led_failed", mode, parent,
> +			   &craye1k->set_led_failed);
> +	debugfs_create_x64("get_led_failed", mode, parent,
> +			   &craye1k->get_led_failed);
> +	debugfs_create_x64("completion_timeout", mode, parent,
> +			   &craye1k->completion_timeout);
> +	debugfs_create_x64("wrong_msgid", mode, parent,
> +			   &craye1k->wrong_msgid);
> +	debugfs_create_x64("request_failed", mode, parent,
> +			   &craye1k->request_failed);
> +
> +	debugfs_create_x32("ipmi_retries", mode, parent,
> +			   &craye1k->ipmi_retries);
> +	debugfs_create_x32("ipmi_timeout_ms", mode, parent,
> +			   &craye1k->ipmi_timeout_ms);
> +	debugfs_create_x32("completion_timeout_ms", mode, parent,
> +			   &craye1k->completion_timeout_ms);
> +	debugfs_create_bool("print_errors", mode, parent,
> +			    &craye1k->print_errors);
> +
> +	return parent;
> +}
> +
> +/*
> + * craye1k_msg_handler() - IPMI message response handler
> + */
> +static void craye1k_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
> +{
> +	struct craye1k *craye1k = user_msg_data;
> +
> +	if (msg->msgid != craye1k->tx_msg_id) {
> +		craye1k->wrong_msgid++;
> +		if (craye1k->print_errors) {
> +			dev_warn_ratelimited(craye1k->dev, "rx msgid %d != %d",
> +					     (int)msg->msgid,
> +					     (int)craye1k->tx_msg_id);
> +		}
> +		ipmi_free_recv_msg(msg);
> +		return;
> +	}
> +
> +	/* Set rx_result to the IPMI completion code */
> +	if (msg->msg.data_len > 0)
> +		craye1k->rx_result = msg->msg.data[0];
> +	else
> +		craye1k->rx_result = IPMI_UNKNOWN_ERR_COMPLETION_CODE;
> +
> +	if (msg->msg.data_len > 1) {
> +		/* Exclude completion code from data bytes */
> +		craye1k->rx_msg_len = msg->msg.data_len - 1;
> +		memcpy(craye1k->rx_msg_data, msg->msg.data + 1,
> +		       craye1k->rx_msg_len);
> +	} else {
> +		craye1k->rx_msg_len = 0;
> +	}
> +
> +	ipmi_free_recv_msg(msg);
> +
> +	complete(&craye1k->read_complete);
> +}
> +
> +static const struct ipmi_user_hndl craye1k_user_hndl = {
> +	.ipmi_recv_hndl = craye1k_msg_handler
> +};
> +
> +static void craye1k_new_smi(int iface, struct device *dev)
> +{
> +	int rc;
> +	struct craye1k *craye1k;
> +
> +	/* There's only one node controller so driver data should not be set */
> +	WARN_ON(craye1k_global);
> +
> +	craye1k = kzalloc(sizeof(*craye1k), GFP_KERNEL);
> +	if (!craye1k)
> +		return;
> +
> +	craye1k->address.addr_type = IPMI_SYSTEM_INTERFACE_ADDR_TYPE;
> +	craye1k->address.channel = IPMI_BMC_CHANNEL;
> +	craye1k->iface = iface;
> +	craye1k->dev = dev;
> +	craye1k->tx_msg.data = craye1k->tx_msg_data;
> +	craye1k->ipmi_retries = 4;
> +	craye1k->ipmi_timeout_ms = 500;
> +	craye1k->completion_timeout_ms = 300;
> +
> +	init_completion(&craye1k->read_complete);
> +	mutex_init(&craye1k->lock);
> +
> +	dev_set_drvdata(dev, craye1k);
> +
> +	rc = ipmi_create_user(craye1k->iface, &craye1k_user_hndl, craye1k,
> +			      &craye1k->user);
> +	if (rc < 0) {
> +		dev_err_ratelimited(dev,
> +				    "Unable to register IPMI user, iface %d\n",
> +				    craye1k->iface);
> +		kfree(craye1k);
> +		dev_set_drvdata(dev, NULL);
> +		return;
> +	}
> +
> +	craye1k_global = craye1k;
> +
> +	craye1k->parent = craye1k_debugfs_init(craye1k);
> +	if (!craye1k->parent)
> +		dev_warn_ratelimited(dev, "Cannot create debugfs");
> +
> +	dev_info_ratelimited(dev,
> +			     "Cray ClusterStor E1000 slot LEDs registered");

I'm curious about the ratelimiting here because this doesn't look like
a potential high-frequency path.  It looks like basically a one-time
init path.

> +}
> +
> +static void craye1k_smi_gone(int iface)
> +{
> +	pr_warn("craye1k: Got unexpected smi_gone, iface=%d", iface);
> +}
> +
> +static struct ipmi_smi_watcher craye1k_smi_watcher = {
> +	.owner = THIS_MODULE,
> +	.new_smi = craye1k_new_smi,
> +	.smi_gone = craye1k_smi_gone
> +};
> +
> +/*
> + * craye1k_send_message() - Send the message already setup in 'craye1k'
> + *
> + * Context: craye1k->lock is already held.
> + * Return: 0 on success, non-zero on error.
> + */
> +static int craye1k_send_message(struct craye1k *craye1k)
> +{
> +	int rc;
> +
> +	rc = ipmi_validate_addr(&craye1k->address, sizeof(craye1k->address));
> +	if (rc) {
> +		dev_err_ratelimited(craye1k->dev, "validate_addr() = %d\n", rc);
> +		return rc;
> +	}
> +
> +	craye1k->tx_msg_id++;
> +
> +	rc = ipmi_request_settime(craye1k->user, &craye1k->address,
> +				  craye1k->tx_msg_id, &craye1k->tx_msg, craye1k,
> +				  0, craye1k->ipmi_retries,
> +				  craye1k->ipmi_timeout_ms);
> +
> +	if (rc) {
> +		craye1k->request_failed++;
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * craye1k_do_message() - Send the message in 'craye1k' and wait for a response
> + *
> + * Context: craye1k->lock is already held.
> + * Return: 0 on success, non-zero on error.
> + */
> +static int craye1k_do_message(struct craye1k *craye1k)
> +{
> +	int rc;
> +	struct completion *read_complete = &craye1k->read_complete;
> +	unsigned long tout = msecs_to_jiffies(craye1k->completion_timeout_ms);
> +
> +	WARN_ON(!mutex_is_locked(&craye1k->lock));
> +
> +	rc = craye1k_send_message(craye1k);
> +	if (rc)
> +		return rc;
> +
> +	rc = wait_for_completion_killable_timeout(read_complete, tout);
> +	if (rc == 0) {
> +		/* timed out */
> +		craye1k->completion_timeout++;
> +		return -ETIME;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * __craye1k_do_command() - Do an IPMI command
> + *
> + * Send a command with optional data bytes, and read back response bytes.
> + *
> + * Context: craye1k->lock is already held.
> + * Returns: 0 on success, non-zero on error.
> + */
> +static int __craye1k_do_command(struct craye1k *craye1k, u8 netfn, u8 cmd,
> +				u8 *send_data, u8 send_data_len, u8 *recv_data,
> +				u8 recv_data_len)
> +{
> +	int rc;
> +
> +	craye1k->tx_msg.netfn = netfn;
> +	craye1k->tx_msg.cmd = cmd;
> +
> +	if (send_data) {
> +		memcpy(&craye1k->tx_msg_data[0], send_data, send_data_len);
> +		craye1k->tx_msg.data_len = send_data_len;
> +	} else {
> +		craye1k->tx_msg_data[0] = 0;
> +		craye1k->tx_msg.data_len = 0;
> +	}
> +
> +	rc = craye1k_do_message(craye1k);
> +	if (rc == 0)
> +		memcpy(recv_data, craye1k->rx_msg_data, recv_data_len);
> +
> +	return rc;
> +}
> +
> +/*
> + * craye1k_do_command() - Do a Cray E1000 specific IPMI command.
> + * @cmd: Cray E1000 specific command
> + * @send_data:  Data to send after the command
> + * @send_data_len: Data length
> + *
> + * Context: craye1k->lock is already held.
> + * Returns: the last byte from the response or 0 if response had no response
> + * data bytes, else -1 on error.
> + */
> +static int craye1k_do_command(struct craye1k *craye1k, u8 cmd, u8 *send_data,
> +			      u8 send_data_len)
> +{
> +	int rc;
> +
> +	rc = __craye1k_do_command(craye1k, CRAYE1K_CMD_NETFN, cmd, send_data,
> +				  send_data_len, NULL, 0);
> +	if (rc != 0) {
> +		/* Error attempting command */
> +		return -1;
> +	}
> +
> +	if (craye1k->tx_msg.data_len == 0)
> +		return 0;
> +
> +	/* Return last received byte value */
> +	return craye1k->rx_msg_data[craye1k->rx_msg_len - 1];
> +}
> +
> +/*
> + * __craye1k_set_primary() - Tell the BMC we want to be the primary server
> + *
> + * An E1000 board has two physical servers on it.  In order to set a slot
> + * NVMe LED, this server needs to first tell the BMC that it's the primary
> + * server.
> + *
> + * Context: craye1k->lock is already held.
> + * Returns: 0 on success, non-zero on error.
> + */
> +static int __craye1k_set_primary(struct craye1k *craye1k)
> +{
> +	u8 bytes[2] = {CRAYE1K_SUBCMD_SET_PRIMARY, 1};	/* set primary to 1 */
> +
> +	craye1k->set_primary++;
> +	return craye1k_do_command(craye1k, CRAYE1K_CMD_PRIMARY, bytes, 2);
> +}
> +
> +/*
> + * craye1k_is_primary() - Are we the primary server?
> + *
> + * Context: craye1k->lock is already held.
> + * Returns: true if we are the primary server, false otherwise.
> + */
> +static bool craye1k_is_primary(struct craye1k *craye1k)
> +{
> +	u8 byte = 0;
> +	int rc;
> +
> +	/* Response byte is 0x1 on success */
> +	rc = craye1k_do_command(craye1k, CRAYE1K_CMD_PRIMARY, &byte, 1);
> +	craye1k->check_primary++;
> +	if (rc == 0x1)
> +		return true;   /* success */
> +
> +	craye1k->check_primary_failed++;
> +	return false;   /* We are not the primary server node */
> +}
> +
> +/*
> + * craye1k_set_primary() - Attempt to set ourselves as the primary server
> + *
> + * Context: craye1k->lock is already held.
> + * Returns: 0 on success, -1 otherwise.
> + */
> +static int craye1k_set_primary(struct craye1k *craye1k)
> +{
> +	int tries = 10;
> +
> +	if (craye1k_is_primary(craye1k)) {
> +		craye1k->was_already_primary++;
> +		return 0;
> +	}
> +	craye1k->was_not_already_primary++;
> +
> +	/* delay found through experimentation */
> +	msleep(300);
> +
> +	if (__craye1k_set_primary(craye1k) != 0) {
> +		craye1k->set_initial_primary_failed++;
> +		return -1;	/* error */
> +	}
> +
> +	/*
> +	 * It can take 2 to 3 seconds after setting primary for the controller
> +	 * to report that it is the primary.
> +	 */
> +	while (tries--) {
> +		msleep(500);
> +		if (craye1k_is_primary(craye1k))
> +			break;
> +	}
> +
> +	if (tries == 0) {
> +		craye1k->set_primary_failed++;
> +		return -1;	/* never reported that it's primary */
> +	}
> +
> +	/* Wait for primary switch to finish */
> +	msleep(1500);
> +
> +	return 0;
> +}
> +
> +/*
> + * craye1k_get_slot_led() - Get slot LED value
> + * @slot: Slot number (1-24)
> + * @is_locate_led: 0 = get fault LED value, 1 = get locate LED value
> + *
> + * Context: craye1k->lock is already held.
> + * Returns: slot value on success, -1 on failure.
> + */
> +static int craye1k_get_slot_led(struct craye1k *craye1k, unsigned char slot,
> +				bool is_locate_led)
> +{
> +	u8 bytes[2];
> +	u8 cmd;
> +
> +	bytes[0] = CRAYE1K_SUBCMD_GET_LED;
> +	bytes[1] = slot;
> +
> +	cmd = is_locate_led ? CRAYE1K_CMD_LOCATE_LED : CRAYE1K_CMD_FAULT_LED;
> +
> +	return craye1k_do_command(craye1k, cmd, bytes, 2);
> +}
> +
> +/*
> + * craye1k_set_slot_led() - Attempt to set the locate/fault LED to a value
> + * @slot: Slot number (1-24)
> + * @is_locate_led: 0 = use fault LED, 1 = use locate LED
> + * @value: Value to set (0 or 1)
> + *
> + * Check the LED value after calling this function to ensure it has been set
> + * properly.
> + *
> + * Context: craye1k->lock is already held.
> + * Returns: 0 on success, non-zero on failure.
> + */
> +static int craye1k_set_slot_led(struct craye1k *craye1k, unsigned char slot,
> +				unsigned char is_locate_led,
> +				unsigned char value)
> +{
> +	u8 bytes[3];
> +	u8 cmd;
> +
> +	bytes[0] = CRAYE1K_SUBCMD_SET_LED;
> +	bytes[1] = slot;
> +	bytes[2] = value;
> +
> +	cmd = is_locate_led ? CRAYE1K_CMD_LOCATE_LED : CRAYE1K_CMD_FAULT_LED;
> +
> +	return craye1k_do_command(craye1k, cmd, bytes, 3);
> +}
> +
> +/*
> + * __craye1k_get_attention_status() - Get LED value
> + *
> + * Context: craye1k->lock is already held.
> + * Returns: 0 on success, -EIO on failure.
> + */
> +static int __craye1k_get_attention_status(struct hotplug_slot *hotplug_slot,
> +					  u8 *status, bool set_primary)
> +{
> +	unsigned char slot;
> +	int locate, fault;
> +	struct craye1k *craye1k;
> +
> +	craye1k = craye1k_global;
> +	slot = PSN(to_ctrl(hotplug_slot));
> +
> +	if (set_primary) {
> +		if (craye1k_set_primary(craye1k) != 0) {
> +			craye1k->get_led_failed++;
> +			return -EIO;
> +		}
> +	}
> +
> +	locate = craye1k_get_slot_led(craye1k, slot, true);
> +	if (locate == -1) {
> +		craye1k->get_led_failed++;
> +		return -EIO;
> +	}
> +	msleep(CRAYE1K_POST_CMD_WAIT_MS);
> +
> +	fault = craye1k_get_slot_led(craye1k, slot, false);
> +	if (fault == -1) {
> +		craye1k->get_led_failed++;
> +		return -EIO;
> +	}
> +	msleep(CRAYE1K_POST_CMD_WAIT_MS);
> +
> +	*status = locate << 1 | fault;
> +
> +	return 0;
> +}
> +
> +int craye1k_get_attention_status(struct hotplug_slot *hotplug_slot,
> +				 u8 *status)
> +{
> +	int rc;
> +	struct craye1k *craye1k;
> +
> +	craye1k = craye1k_global;
> +
> +	if (mutex_lock_interruptible(&craye1k->lock) != 0)
> +		return -EINTR;
> +
> +	rc =  __craye1k_get_attention_status(hotplug_slot, status, true);
> +
> +	mutex_unlock(&craye1k->lock);
> +	return rc;
> +}
> +
> +int craye1k_set_attention_status(struct hotplug_slot *hotplug_slot,
> +				 u8 status)
> +{
> +	unsigned char slot;
> +	int tries = 4;
> +	int rc;
> +	u8 new_status;
> +	struct craye1k *craye1k;
> +	bool locate, fault;
> +
> +	craye1k = craye1k_global;
> +
> +	slot = PSN(to_ctrl(hotplug_slot));
> +
> +	if (mutex_lock_interruptible(&craye1k->lock) != 0)
> +		return -EINTR;
> +
> +	/* Retry to ensure all LEDs are set */
> +	while (tries--) {
> +		/*
> +		 * The node must first set itself to be the primary node before
> +		 * setting the slot LEDs (each board has two nodes, or
> +		 * "servers" as they're called by the manufacturer).  This can
> +		 * lead to contention if both nodes are trying to set the LEDs
> +		 * at the same time.

My fuzzy mental picture is that you have two nodes, each running their
own kernel, somehow the E1000 is shared between them, and you want
either kernel to be able to control the LEDs.

But maybe each individual NVMe device is assigned to one of the nodes,
and it's just that the single BMC controls all the LEDs, regardless of
which node owns the associated NVMe device?

This whole "make me primary" dance seems kind of slow and error-prone,
but I guess we have to work with the hardware supplied to us, and you
want this to work even if the other node is crashed so you can't
really centralize it.

> +		 */
> +		rc = craye1k_set_primary(craye1k);
> +		if (rc != 0) {
> +			/* Could not set as primary node.  Just retry again. */
> +			continue;
> +		}
> +
> +		/* Write value twice to increase success rate */
> +		locate = (status & 0x2) >> 1;
> +		craye1k_set_slot_led(craye1k, slot, 1, locate);
> +		if (craye1k_set_slot_led(craye1k, slot, 1, locate) != 0) {
> +			craye1k->set_led_locate_failed++;
> +			continue;	/* fail, retry */
> +		}
> +
> +		msleep(CRAYE1K_POST_CMD_WAIT_MS);
> +
> +		fault = status & 0x1;
> +		craye1k_set_slot_led(craye1k, slot, 0, fault);
> +		if (craye1k_set_slot_led(craye1k, slot, 0, fault) != 0) {
> +			craye1k->set_led_fault_failed++;
> +			continue;	/* fail, retry */
> +		}
> +
> +		msleep(CRAYE1K_POST_CMD_WAIT_MS);
> +
> +		rc = __craye1k_get_attention_status(hotplug_slot, &new_status,
> +						    false);
> +
> +		msleep(CRAYE1K_POST_CMD_WAIT_MS);
> +
> +		if (rc == 0 && new_status == status)
> +			break;	/* success */
> +
> +		craye1k->set_led_readback_failed++;
> +
> +		/*
> +		 * At this point we weren't successful in setting the LED and
> +		 * need to try again.
> +		 *
> +		 * Do a random back-off to reduce contention with other server
> +		 * node in the unlikely case that both server nodes are trying to
> +		 * trying to set a LED at the same time.
> +		 *
> +		 * The 500ms minimum in the back-off reduced the chance of this
> +		 * whole retry loop failing from 1 in 700 to none in 10000.
> +		 */
> +		msleep(500 + (get_random_long() % 500));
> +	}
> +	mutex_unlock(&craye1k->lock);
> +	if (tries == 0) {
> +		craye1k->set_led_failed++;
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool is_craye1k_board(void)
> +{
> +	return dmi_match(DMI_PRODUCT_NAME, "VSSEP1EC");
> +}
> +
> +bool is_craye1k_slot(struct controller *ctrl)
> +{
> +	return (PSN(ctrl) >= 1 && PSN(ctrl) <= 24 && is_craye1k_board());
> +}
> +
> +int craye1k_init(void)
> +{
> +	if (!is_craye1k_board())
> +		return 0;
> +
> +	return ipmi_smi_watcher_register(&craye1k_smi_watcher);
> +}
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Tony Hutter <hutter2@llnl.gov>");
> +MODULE_DESCRIPTION("Cray E1000 NVMe Slot LED driver");
> -- 
> 2.43.7

