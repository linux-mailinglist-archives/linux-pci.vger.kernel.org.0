Return-Path: <linux-pci+bounces-22403-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F006A45370
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 03:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122E218968C6
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 02:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0918A209F5C;
	Wed, 26 Feb 2025 02:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="spdpe50R"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6252AE7F;
	Wed, 26 Feb 2025 02:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740538472; cv=none; b=Ii7+SivrJPdB1OLrIknJMDPr1IqnqoJzsG9tnCZLRClsk0mKYG7Vqv/6ri/9oh01/EMxShs8Wgbt3eTYPR+VUdWtwczdgZMxKHM42YP8TL4/jfnb0HVjbWFrG1GsW3G24KVyNIEQ9ljwv7wd/Q+nVt4hDRI8II5UUNt9P0tMpVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740538472; c=relaxed/simple;
	bh=Mco5yrGfQsleB6phxnHQh35uc1UUoUhB84F1v6Gyl7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIH3fRth4OTl/G5khkRLkhSXdmMjSjTpPBmRLPYK2/zSgc/04tBN6GVkG5s4zWkcdigMa9uRl6Z7plFhhwCC+LXKFPiAgIUS+T91yi1kEX2ZW6iRYl3feKS/sOvRlhMFF7lDP3xNqTt1h1WCQPGdHuke3DTu1S0RFEncj8+VlA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=spdpe50R; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740538460; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=ajX6zcFiL0wqWl4lfvHEu+wu7H7hVyq4gLK0syUqpm8=;
	b=spdpe50RMuIXms1UiBbGcFLQiqF06Xo3XvJLkp5FOGTejA30OridVRiLTsHVPcqRdt5FZVdsVQQ43R2M53vFI9tYYR+BE8g7/NmCKCaiX6JkMSL4hxgRs3I3Jaiu7vIaBEiyFUBFdcERUA2QkMAA7JUU947c1HKqf3afjbJ6Igo=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WQGULAB_1740538459 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 26 Feb 2025 10:54:20 +0800
Date: Wed, 26 Feb 2025 10:54:18 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Liguang Zhang <zhangliguang@linux.alibaba.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>, rafael@kernel.org,
	Markus Elfring <Markus.Elfring@web.de>, lkp@intel.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] PCI/portdrv: Loose the condition check for
 disabling hotplug interrupts
Message-ID: <Z76CWifQmFIQugiZ@U-2FWC9VHC-2323.local>
References: <20250224034500.23024-1-feng.tang@linux.alibaba.com>
 <20250224034500.23024-4-feng.tang@linux.alibaba.com>
 <Z71CZyU11-cBXawr@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z71CZyU11-cBXawr@wunner.de>

Hi Lukas,

On Tue, Feb 25, 2025 at 05:09:11AM +0100, Lukas Wunner wrote:
> On Mon, Feb 24, 2025 at 11:44:59AM +0800, Feng Tang wrote:
> > Currently when 'pcie_ports_native' and host's 'native_pcie_hotplug' are
> > both false, kernel will not disable PCIe hotplug interrupts. But as
> > those could be affected by software setup like kernel cmdline parameter,
> > remove the depency over them.
> [...]
> > --- a/drivers/pci/pcie/portdrv.c
> > +++ b/drivers/pci/pcie/portdrv.c
> > @@ -263,9 +263,9 @@ static int get_port_device_capability(struct pci_dev *dev)
> >  
> >  	if (dev->is_hotplug_bridge &&
> >  	    (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> > -	     pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM) &&
> > -	    (pcie_ports_native || host->native_pcie_hotplug)) {
> > -		services |= PCIE_PORT_SERVICE_HP;
> > +	     pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM)) {
> > +		if  (pcie_ports_native || host->native_pcie_hotplug)
> > +			services |= PCIE_PORT_SERVICE_HP;
> >  
> >  		/*
> >  		 * Disable hot-plug interrupts in case they have been enabled
> 
> If the platform doesn't grant hotplug control to OSPM, OSPM isn't allowed
> to disable interrupts behind the platform's back.
> 
> So this change doesn't seem safe and we should focus on finding out
> why the platform isn't granting hotplug control in the pci=nomsi case.

Yes. As discussed in https://lore.kernel.org/lkml/Z6ycYOKUeOECrcgb@U-2FWC9VHC-2323.local/
the last state is:
"
I tried to remove OSC_PCI_MSI_SUPPORT from ACPI_PCIE_REQ_SUPPORT, but
after negotiate_os_control(), the 'PCIeHotplug' control is still
disabled in the control capability after ACPI query_osc, run_osc
routines (I haven't figured out why yet), thus the pciehp severvice
driver can't be loader.
"

After talking with some firmware developer, the root cause is the
parameter OS passed to OSC control shows it doesn't support MSI, then
firmware doesn't grant hotplug control. The hardware here is a ARM
server. As different OEM/vendor (X86/ARM) may have different
implementaions of firmware, other firmware may make different decision. 

Thanks,
Feng

