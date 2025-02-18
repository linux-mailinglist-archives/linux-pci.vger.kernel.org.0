Return-Path: <linux-pci+bounces-21769-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD17A3ABBD
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 23:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951421631FE
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 22:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6341D0F5A;
	Tue, 18 Feb 2025 22:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkuwkLj3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B941B87EB;
	Tue, 18 Feb 2025 22:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739918036; cv=none; b=IAFX4Kkhv7bDmbK6SLgpMTrYSU7Ty26A+ekBbdcB1aubIBW5Mf37n2wjFUYQP4pEwKonnoCH0HdLFV9NT2NQHhyYfcxmWBSUtPh+ukh/Qk0tdpn5ez8zgW6uYXpCvqzUOD/c/TVzzrmQh9zj/GkHf/ShXXlHDUCKc4BNe4lLV/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739918036; c=relaxed/simple;
	bh=P6sZ3lNpHHpplB4AD6dWKBij+UC5ODnu6yXG6d0hA9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=J0g0CHmCOsUgYLVm4igvkjMWR9/Crw5t7pLQumFYN7sidJBAcMhQcPKeJa5nP7shph4umj2O4SnGF9UAPq90QKAVed/qvlmWlo++fJcY+m5ouBMYIIY2BB7QHjBuiCUx/3CxeDLtObf+xSO+snMwu44stKL44GECQfPOejL6D/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkuwkLj3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F74C4CEE2;
	Tue, 18 Feb 2025 22:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739918035;
	bh=P6sZ3lNpHHpplB4AD6dWKBij+UC5ODnu6yXG6d0hA9Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NkuwkLj3PkFL0Ng4mzbutDA/bj9RAYmBvq1aLtZvMK2HBgh93GVKt20ul8PJTeoJj
	 oDmXtJOH5LQ6/vj0s6j2A31/Glap7l95tD3NCTTKVrZrUAqKxP8ttLM0GFTBjkdwN4
	 EJqiOqaNHT9hWZqE4pKSEpZEbjA9mnPvGmFq9x29VkEAiuxlrNHYlPyAIWh7STyOgg
	 aaCGfWWDKmjRZomOccAL3LhmOrRACl7cjDoYmUbwLooJWgQ/S+r05t2fqkB2blU5cX
	 7wd61R+vGpdcwP0S5yth+2eMSa3yOUlZH27knbwsAC4KzwGUUkseRGn3TGz9oT1a9v
	 5ptiZB6XVcg1g==
Date: Tue, 18 Feb 2025 16:33:54 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Liguang Zhang <zhangliguang@linux.alibaba.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>, rafael@kernel.org,
	Markus Elfring <Markus.Elfring@web.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI/portdrv: Add necessary wait for disabling
 hotplug events
Message-ID: <20250218223354.GA196886@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218034859.40397-1-feng.tang@linux.alibaba.com>

On Tue, Feb 18, 2025 at 11:48:58AM +0800, Feng Tang wrote:
> There was problem reported by firmware developers that they received
> 2 pcie link control commands in very short intervals on an ARM server,
> which doesn't comply with pcie spec, and broke their state machine and
> work flow. According to PCIe 6.1 spec, section 6.7.3.2, software needs
> to wait at least 1 second for the command-complete event, before
> resending the cmd or sending a new cmd.

s/link control/hotplug/ (also below)
s/2/two/
s/pcie/PCIe/ (also below)

> And the first link control command firmware received is from
> get_port_device_capability(), which sends cmd to disable pcie hotplug
> interrupts without waiting for its completion.
> 
> Fix it by adding the necessary wait to comply with PCIe spec, referring
> pcie_poll_cmd().
> 
> Also make the interrupt disabling not dependent on whether pciehp
> service driver will be loaded as suggested by Lukas.

This sounds like maybe it should be two separate patches.

> Fixes: 2bd50dd800b5 ("PCI: PCIe: Disable PCIe port services during port initialization")
> Originally-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
> Suggested-by: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
> ---
> Changlog:
> 
>   since v1:
>     * Add the Originally-by for Liguang. The issue was found on a 5.10 kernel,
>       then 6.6. I was initially given a 5.10 kernel tar bar without git info to
>       debug the issue, and made the patch. Thanks to Guanghui who recently pointed
>       me to tree https://gitee.com/anolis/cloud-kernel which show the wait logic
>       in 5.10 was originally from Liguang, and never hit mainline.
>     * Make the irq disabling not dependent on wthether pciehp service driver
>       will be loaded (Lukas Wunner) 
>     * Use read_poll_timeout() API to simply the waiting logic (Sathyanarayanan
>       Kuppuswamy)
>     * Add logic to skip irq disabling if it is already disabled.
> 
>  drivers/pci/pci.h          |  2 ++
>  drivers/pci/pcie/portdrv.c | 44 +++++++++++++++++++++++++++++++++-----
>  2 files changed, 41 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 01e51db8d285..c1e234d1b81d 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -759,12 +759,14 @@ static inline void pcie_ecrc_get_policy(char *str) { }
>  #ifdef CONFIG_PCIEPORTBUS
>  void pcie_reset_lbms_count(struct pci_dev *port);
>  int pcie_lbms_count(struct pci_dev *port, unsigned long *val);
> +void pcie_disable_hp_interrupts_early(struct pci_dev *dev);
>  #else
>  static inline void pcie_reset_lbms_count(struct pci_dev *port) {}
>  static inline int pcie_lbms_count(struct pci_dev *port, unsigned long *val)
>  {
>  	return -EOPNOTSUPP;
>  }
> +static inline void pcie_disable_hp_interrupts_early(struct pci_dev *dev) {}
>  #endif
>  
>  struct pci_dev_reset_methods {
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 02e73099bad0..2470333bba2f 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -18,6 +18,7 @@
>  #include <linux/string.h>
>  #include <linux/slab.h>
>  #include <linux/aer.h>
> +#include <linux/iopoll.h>
>  
>  #include "../pci.h"
>  #include "portdrv.h"
> @@ -205,6 +206,40 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
>  	return 0;
>  }
>  
> +static int pcie_wait_sltctl_cmd_raw(struct pci_dev *dev)
> +{
> +	u16 slot_status = 0;
> +	int ret, ret1, timeout_us;
> +
> +	/* 1 second, according to PCIe spec 6.1, section 6.7.3.2 */
> +	timeout_us = 1000000;
> +	ret = read_poll_timeout(pcie_capability_read_word, ret1,
> +				(slot_status & PCI_EXP_SLTSTA_CC), 10000,
> +				timeout_us, true, dev, PCI_EXP_SLTSTA,
> +				&slot_status);
> +	if (!ret)
> +		pcie_capability_write_word(dev, PCI_EXP_SLTSTA,
> +						PCI_EXP_SLTSTA_CC);
> +
> +	return  ret;

Ugh.  I really don't like the way this basically duplicates
pcie_poll_cmd().  I don't have a great suggestion to fix it; maybe we
need a way to build part of pciehp unconditionally.  At the very least
we need a comment here pointing to pcie_poll_cmd().

And IIUC this will add a one second delay for ports that don't need
command completed events.  I don't think that's fair to those ports.

> +}
> +
> +void pcie_disable_hp_interrupts_early(struct pci_dev *dev)
> +{
> +	u16 slot_ctrl = 0;
> +
> +	pcie_capability_read_word(dev, PCI_EXP_SLTCTL, &slot_ctrl);
> +	/* Bail out early if it is already disabled */
> +	if (!(slot_ctrl & (PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE)))
> +		return;
> +
> +	pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
> +		  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
> +
> +	if (pcie_wait_sltctl_cmd_raw(dev))
> +		pci_info(dev, "Timeout on disabling PCIE hot-plug interrupt\n");

s/PCIE/PCIe/

> +}
> +
>  /**
>   * get_port_device_capability - discover capabilities of a PCI Express port
>   * @dev: PCI Express port to examine
> @@ -222,16 +257,15 @@ static int get_port_device_capability(struct pci_dev *dev)
>  
>  	if (dev->is_hotplug_bridge &&
>  	    (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> -	     pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM) &&
> -	    (pcie_ports_native || host->native_pcie_hotplug)) {
> -		services |= PCIE_PORT_SERVICE_HP;
> +	     pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM)) {
> +		if (pcie_ports_native || host->native_pcie_hotplug)
> +			services |= PCIE_PORT_SERVICE_HP;
>  
>  		/*
>  		 * Disable hot-plug interrupts in case they have been enabled
>  		 * by the BIOS and the hot-plug service driver is not loaded.
>  		 */
> -		pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
> -			  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
> +		pcie_disable_hp_interrupts_early(dev);
>  	}
>  
>  #ifdef CONFIG_PCIEAER
> -- 
> 2.43.5
> 

