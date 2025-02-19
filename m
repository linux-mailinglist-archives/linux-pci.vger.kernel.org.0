Return-Path: <linux-pci+bounces-21792-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD3DA3B1D6
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 07:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9A48188902B
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 06:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1ED41BD018;
	Wed, 19 Feb 2025 06:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eUGjJ8c0"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6731B425D;
	Wed, 19 Feb 2025 06:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739948035; cv=none; b=NeVF7o2AKMc5j0hBSW0zfrgKwirFvSyhxbk5a/ZX/I0M56+9V+Jx4qDDBBTQcSu4ZE5zN/7FMUxlTUdTTNUzag1omqudhvX7iqSGRuhJtv3kUUzqRuhi3gKqVdOokA0BkbxxHZwk/vO8aIHMZyNBEBoCqBSKlZUbxp0T2p5LcOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739948035; c=relaxed/simple;
	bh=koRbriV2FJHYpkx4yetqvAA3ugjCmnG0nn4gTbjWO0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nw1uhGT+TutPEoozAP+wBQ+zDV4J3JLryjKgUxb4/mvd1C3Z1KxPF4yTVB7DO83eO8Uo6EFlhZFep28QDHdpWh2HOLUT9XIqhLKcADS1EDbzjlq6mIv7uyM6ooWx+dkdgBs7w4+6CBPCHITrF5kRhTQt5b9f8AGHNMo4t7Rbe60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eUGjJ8c0; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739948027; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=2FnyiGRSEFSuMDZlvV3tsUAzNH+mhZyEV7s87LjUa9Q=;
	b=eUGjJ8c0njfS5WYJBWfFMVJTxbLVgtk8VKHJiLhs17/oteW13z4t9MRdhSkkxQJ6U3LYQYJ1/czqMe8gD0uYIBfaudQkI3yRZgg4S3zGnjZRnmLhe0hmL8HrLAmsIfoTEjXCLIE3heUrBOjqzKJldI1boNGZD2iVkJw+dFpecoo=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WPoD3cj_1739948026 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Feb 2025 14:53:46 +0800
Date: Wed, 19 Feb 2025 14:53:44 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Liguang Zhang <zhangliguang@linux.alibaba.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>, rafael@kernel.org,
	Markus Elfring <Markus.Elfring@web.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI/portdrv: Add necessary wait for disabling
 hotplug events
Message-ID: <Z7V_-KuL483hU8Dw@U-2FWC9VHC-2323.local>
References: <20250218034859.40397-1-feng.tang@linux.alibaba.com>
 <99d1cd4d-2526-4ce0-aabd-508fa03cb100@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <99d1cd4d-2526-4ce0-aabd-508fa03cb100@linux.intel.com>

Hi Sathyanarayanan,

On Tue, Feb 18, 2025 at 10:58:19AM -0800, Sathyanarayanan Kuppuswamy wrote:
> 
> On 2/17/25 7:48 PM, Feng Tang wrote:
> > There was problem reported by firmware developers that they received
> > 2 pcie link control commands in very short intervals on an ARM server,
> > which doesn't comply with pcie spec, and broke their state machine and
> > work flow. According to PCIe 6.1 spec, section 6.7.3.2, software needs
> > to wait at least 1 second for the command-complete event, before
> > resending the cmd or sending a new cmd.
> > 
> > And the first link control command firmware received is from
> > get_port_device_capability(), which sends cmd to disable pcie hotplug
> > interrupts without waiting for its completion.
> 
> Were you able to narrow down the source of the second command? The
> reason I am asking is, the commit you are trying to fix seems to have
> existed for 10+ years and no one had faced any issues with it. So
> I am wondering whether this needs to fixed at this place or before
> executing the second command.

The second command comes from pcie_enable_notification(), which in our
case will send command to enable hotplug interrupt again.

The firmware developer found the problem when handling some device
hotplug case, kind of stress case. 

I think maybe it's better to add the wait after this first command,
which follows the PCIe spec naturally. Also v2 patch adds the logic
of skipping the interrupt-disabling command, if it has been disabled
earlier, either by kernel or BIOS.

> 
> > 
> > Fix it by adding the necessary wait to comply with PCIe spec, referring
> > pcie_poll_cmd().
> > 
> > Also make the interrupt disabling not dependent on whether pciehp
> > service driver will be loaded as suggested by Lukas.
> 
> May be this needs a new patch?

Yes, will do.

> > 
> > Fixes: 2bd50dd800b5 ("PCI: PCIe: Disable PCIe port services during port initialization")
> > Originally-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
> > Suggested-by: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
> > Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
> > ---
> 
> Code wise it looks fine to me.

Thanks for the review!

- Feng

> > Changlog:
> > 
> >    since v1:
> >      * Add the Originally-by for Liguang. The issue was found on a 5.10 kernel,
> >        then 6.6. I was initially given a 5.10 kernel tar bar without git info to
> >        debug the issue, and made the patch. Thanks to Guanghui who recently pointed
> >        me to tree https://gitee.com/anolis/cloud-kernel which show the wait logic
> >        in 5.10 was originally from Liguang, and never hit mainline.
> >      * Make the irq disabling not dependent on wthether pciehp service driver
> >        will be loaded (Lukas Wunner)
> >      * Use read_poll_timeout() API to simply the waiting logic (Sathyanarayanan
> >        Kuppuswamy)
> >      * Add logic to skip irq disabling if it is already disabled.
> > 
> >   drivers/pci/pci.h          |  2 ++
> >   drivers/pci/pcie/portdrv.c | 44 +++++++++++++++++++++++++++++++++-----
> >   2 files changed, 41 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 01e51db8d285..c1e234d1b81d 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -759,12 +759,14 @@ static inline void pcie_ecrc_get_policy(char *str) { }
> >   #ifdef CONFIG_PCIEPORTBUS
> >   void pcie_reset_lbms_count(struct pci_dev *port);
> >   int pcie_lbms_count(struct pci_dev *port, unsigned long *val);
> > +void pcie_disable_hp_interrupts_early(struct pci_dev *dev);
> >   #else
> >   static inline void pcie_reset_lbms_count(struct pci_dev *port) {}
> >   static inline int pcie_lbms_count(struct pci_dev *port, unsigned long *val)
> >   {
> >   	return -EOPNOTSUPP;
> >   }
> > +static inline void pcie_disable_hp_interrupts_early(struct pci_dev *dev) {}
> >   #endif
> >   struct pci_dev_reset_methods {
> > diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> > index 02e73099bad0..2470333bba2f 100644
> > --- a/drivers/pci/pcie/portdrv.c
> > +++ b/drivers/pci/pcie/portdrv.c
> > @@ -18,6 +18,7 @@
> >   #include <linux/string.h>
> >   #include <linux/slab.h>
> >   #include <linux/aer.h>
> > +#include <linux/iopoll.h>
> >   #include "../pci.h"
> >   #include "portdrv.h"
> > @@ -205,6 +206,40 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
> >   	return 0;
> >   }
> > +static int pcie_wait_sltctl_cmd_raw(struct pci_dev *dev)
> > +{
> > +	u16 slot_status = 0;
> > +	int ret, ret1, timeout_us;
> > +
> > +	/* 1 second, according to PCIe spec 6.1, section 6.7.3.2 */
> > +	timeout_us = 1000000;
> > +	ret = read_poll_timeout(pcie_capability_read_word, ret1,
> > +				(slot_status & PCI_EXP_SLTSTA_CC), 10000,
> > +				timeout_us, true, dev, PCI_EXP_SLTSTA,
> > +				&slot_status);
> > +	if (!ret)
> > +		pcie_capability_write_word(dev, PCI_EXP_SLTSTA,
> > +						PCI_EXP_SLTSTA_CC);
> > +
> > +	return  ret;
> > +}
> > +
> > +void pcie_disable_hp_interrupts_early(struct pci_dev *dev)
> > +{
> > +	u16 slot_ctrl = 0;
> > +
> > +	pcie_capability_read_word(dev, PCI_EXP_SLTCTL, &slot_ctrl);
> > +	/* Bail out early if it is already disabled */
> > +	if (!(slot_ctrl & (PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE)))
> > +		return;
> > +
> > +	pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
> > +		  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
> > +
> > +	if (pcie_wait_sltctl_cmd_raw(dev))
> > +		pci_info(dev, "Timeout on disabling PCIE hot-plug interrupt\n");
> > +}
> > +
> >   /**
> >    * get_port_device_capability - discover capabilities of a PCI Express port
> >    * @dev: PCI Express port to examine
> > @@ -222,16 +257,15 @@ static int get_port_device_capability(struct pci_dev *dev)
> >   	if (dev->is_hotplug_bridge &&
> >   	    (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> > -	     pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM) &&
> > -	    (pcie_ports_native || host->native_pcie_hotplug)) {
> > -		services |= PCIE_PORT_SERVICE_HP;
> > +	     pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM)) {
> > +		if (pcie_ports_native || host->native_pcie_hotplug)
> > +			services |= PCIE_PORT_SERVICE_HP;
> >   		/*
> >   		 * Disable hot-plug interrupts in case they have been enabled
> >   		 * by the BIOS and the hot-plug service driver is not loaded.
> >   		 */
> > -		pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
> > -			  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
> > +		pcie_disable_hp_interrupts_early(dev);
> >   	}
> >   #ifdef CONFIG_PCIEAER
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer

