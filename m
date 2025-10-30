Return-Path: <linux-pci+bounces-39785-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B868CC1F39D
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 10:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1943F1895587
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 09:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DD933FE34;
	Thu, 30 Oct 2025 09:14:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7F72D879A;
	Thu, 30 Oct 2025 09:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815643; cv=none; b=pEvL6TYFTvvH1Qog0f+W0aKlGnq7AKvNLSRlv2CSupgqUij+7wT5KRQmhXIktA0knIyiQY2z05r1xc88vhGB5ObWclADiqDRUeymdGM8pneWz59BYA76FHrNKVVTuubinglDAdxcfdjjJsJV4rD+7cMnRUmZG2xIwqWxnt2oRF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815643; c=relaxed/simple;
	bh=Atj3Q2XG7hRztItgdZBMCVL6u6uzx6C1ksnXHpqfUPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwHTbOnuM02Co72nUHNlbKHocmhGZdzSDVwhX0F90qjf1nAHkfwTt5mZ6K/lKLP3JNXfx1rmuVPG/3cqnDmTYWl1HWQWBasjW0IWgp9IAiepBJPAkyG1afnF1l7tlqdo8i71hhFZywvXz0YXCQ54sNOC7NEBx+jXHEk2hl8yTjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id CE5B42C07AA1;
	Thu, 30 Oct 2025 10:13:57 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B882824B7; Thu, 30 Oct 2025 10:13:57 +0100 (CET)
Date: Thu, 30 Oct 2025 10:13:57 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Tony Hutter <hutter2@llnl.gov>
Cc: Bjorn Helgaas <helgaas@kernel.org>, corey@minyard.net,
	alok.a.tiwari@oracle.com, mariusz.tkaczyk@linux.intel.com,
	minyard@acm.org, linux-pci@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] Introduce Cray ClusterStor E1000 NVMe slot LED driver
Message-ID: <aQMsVUCBDF7ZUSK-@wunner.de>
References: <d485bd74-e49d-4c89-b986-1b45c93e7975@llnl.gov>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d485bd74-e49d-4c89-b986-1b45c93e7975@llnl.gov>

On Wed, Oct 08, 2025 at 04:48:22PM -0700, Tony Hutter wrote:
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -231,6 +231,27 @@ Description:
>  		    - scXX contains the device subclass;
>  		    - iXX contains the device class programming interface.
>  
> +What:		/sys/bus/pci/slots/.../attention
> +Date:		February 2025

Please update the "Date" timestamp to the month of submission to the list.

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

An end user might not be able to understand all these driver names,
so I'd omit "(ampere, ibmphp, pciehp, rpaphp, shpchp)",
and replace "pciehp_craye1k" with "Cray ClusterStor E1000".

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

Per section 21 of Documentation/process/coding-style.rst,
please avoid the use of #ifdef and instead add an #else section
to pciehp.h with an inline stub for is_craye1k_slot() which returns false
and #define craye1k_{get,set}_attention_status to NULL.

Do these hotplug slots on the Cray E1000 have the Attention Indicator
Present bit set in the Slot Capabilities register?  If they do not,
please use "if else" instead of "if".  Right now you're overwriting
the default {get,set}_attention_status pointers, which only makes
sense if ATTN_LED(ctrl) is true.

When is craye1k_new_smi() called?  Is it guaranteed to be called
before the first invocation of craye1k_{get,set}_attention_status()?

I'm asking because craye1k_{get,set}_attention_status() do not
contain any checks whether the craye1k_global struct has been
populated.  You would need such checks if craye1k_new_smi() may
run later than the "attention" attribute appearing in sysfs.

Actually craye1k_new_smi() may fail, e.g. because of kzalloc()
returning NULL, so I think you'll need additional checks in any case.
However if craye1k_new_smi() is guaranteed to run before init_slot(),
you could check for an uninitialized craye1k_global struct already in
is_craye1k_slot().

Note that just checking "craye1k_global == NULL" is insufficient as
craye1k_new_smi() might run concurrently to
craye1k_{get,set}_attention_status().

I note that is_craye1k_slot() calls dmi_match(), so you should add
"depends on DMI" to the Kconfig entry you're adding.

> @@ -376,8 +383,16 @@ int __init pcie_hp_init(void)
>  
>  	retval = pcie_port_service_register(&hpdriver_portdrv);
>  	pr_debug("pcie_port_service_register = %d\n", retval);
> -	if (retval)
> +	if (retval) {
>  		pr_debug("Failure to register service\n");
> +		return retval;
> +	}
> +
> +#ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
> +	retval = craye1k_init();
> +	if (retval)
> +		pr_debug("Failure to register Cray E1000 extensions");
> +#endif

Another #ifdef that should be eliminated.

You also need to annotate craye1k_init() with __init.

> +++ b/drivers/pci/hotplug/pciehp_craye1k.c
[...]
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

dmi.h isn't inserted in alphabetical order.

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

I'm wondering if having all this debug code in mainline is useful?
Is the IPMI interface this brittle?  Was this just necessary
for initial development and may not be useful going forward?

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

Why use casts instead of %ld in the format string?

> +static void craye1k_smi_gone(int iface)
> +{
> +	pr_warn("craye1k: Got unexpected smi_gone, iface=%d", iface);
> +}

Why not kfree() the craye1k struct here, tear down debugfs etc?

Thanks,

Lukas

