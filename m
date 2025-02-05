Return-Path: <linux-pci+bounces-20724-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB209A28223
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 03:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EF97161B45
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 02:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9B83E47B;
	Wed,  5 Feb 2025 02:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rMMSqvtW"
X-Original-To: linux-pci@vger.kernel.org
Received: from out199-16.us.a.mail.aliyun.com (out199-16.us.a.mail.aliyun.com [47.90.199.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C8025A65E;
	Wed,  5 Feb 2025 02:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738723605; cv=none; b=Q/1a/LZxok1/2qvFCSVl+MkfWgCmp3l6q25SnCiN7vI4rLsfoLdQqPhXPRceQvAhLXFjkt0mj+Du2terErTzGuYPYWczPhB2BrauH3EpScd1OrHI/e/LD8Qv0V/mYPMXjbqSYXHFIDB/3D6xW6ozTpw5kxhhdM34AL4CIovulp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738723605; c=relaxed/simple;
	bh=e/5SkRQh2vsArYffaJoNcIXisgLxwqYXRtoMPz5/8Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aif9NCRv1G44TLuJIhu1jcz1/Etbq2bWNnRIcOSjC41RNd1xhHUi2DerK6GYr+LnavltC+A7KB9hcQrjc/kHVntZSWqXnMJ1th6qL/aqu7JncASoS1Hh7d67gZSS3PMNC3E7NbHJxkdkikIF/EeKSZ/+Ft18gDDoz4TnIou6feQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rMMSqvtW; arc=none smtp.client-ip=47.90.199.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1738723587; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=hwDI5UmdjvGToD+3YreRxREJVDtUf+JVz9D01mHq17Q=;
	b=rMMSqvtWCzoZBACOzH5aNrG4Y2K1dq+387sI2ms7ybqbaKgEh7snF+cuM7SVwGUyIxxaOFeQKP2KDjTQBy1YYW2NZraPT4yD4yGiMiemTLIiXBfq42h1RpGho8NGcsB/fEu0GRlReYI2xndgbdsrogcYWCfaqRv+23jKsyb6wy8=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WOlcrU6_1738723586 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 05 Feb 2025 10:46:27 +0800
Date: Wed, 5 Feb 2025 10:46:26 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonthan.Cameron@huawei.com>,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI/portdrv: Add necessary delay for disabling
 hotplug events
Message-ID: <Z6LRAozZm1UfgjqT@U-2FWC9VHC-2323.local>
References: <20250204053758.6025-1-feng.tang@linux.alibaba.com>
 <Z6HYuBDP6uvE1Sf4@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z6HYuBDP6uvE1Sf4@wunner.de>

Hi Lukas,

Thanks for your review and suggestions!

On Tue, Feb 04, 2025 at 10:07:04AM +0100, Lukas Wunner wrote:
> On Tue, Feb 04, 2025 at 01:37:57PM +0800, Feng Tang wrote:
> > According to PCIe 6.1 spec, section 6.7.3.2, software need to wait at
> > least 1 second for the command-complete event, before resending the cmd
> > or sending a new cmd.
> > 
> > Currently get_port_device_capability() sends slot control cmd to disable
> > PCIe hotplug interrupts without waiting for its completion and there was
> > real problem reported for the lack of waiting.
> > 
> > Add the necessary wait to comply with PCIe spec. The waiting logic refers
> > existing pcie_poll_cmd().
> [...]
> > --- a/drivers/pci/pcie/portdrv.c
> > +++ b/drivers/pci/pcie/portdrv.c
> > @@ -230,8 +260,7 @@ static int get_port_device_capability(struct pci_dev *dev)
> >  		 * Disable hot-plug interrupts in case they have been enabled
> >  		 * by the BIOS and the hot-plug service driver is not loaded.
> >  		 */
> > -		pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
> > -			  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
> > +		pcie_disable_hp_interrupts_early(dev);
> >  	}
> 
> The language of the code comment is a bit confusing in that it
> says the hot-plug driver may not be "loaded".  This sounds like
> it could be modular.  But it can't.  It's always built-in.

I'm not sure what problem this piece of code try to avoid, maybe
something simliar to the irq storm isseu as mentioned in the 2/2 patch?
The code comments could be about the small time window between this
point and the loading of pciehp driver, which will request_irq and
enable hotplug interrupt again.

> So I think what is really meant here is that the driver may be
> *disabled* in the config, i.e. CONFIG_HOTPLUG_PCI_PCIE=n.
> 
> Now if CONFIG_HOTPLUG_PCI_PCIE=n, you don't need to observe the
> Command Completed delay because the hotplug driver won't touch
> the Slot Control register afterwards.  It's not compiled in.
> 
> On the other hand if CONFIG_HOTPLUG_PCI_PCIE=y, you don't need
> to disable the CCIE and HPIE interrupt because the hotplug driver
> will handle them.
> 
> So I think the proper solution here is to make the write to the
> Slot Control register conditional on CONFIG_HOTPLUG_PCI_PCIE,
> like this:
> 
> 	if (dev->is_hotplug_bridge &&
> 	    (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> -	     pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM) &&
> -	    (pcie_ports_native || host->native_pcie_hotplug)) {
> -		services |= PCIE_PORT_SERVICE_HP;
> +	     pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM)) {
> +		if (pcie_ports_native || host->native_pcie_hotplug)
> +			services |= PCIE_PORT_SERVICE_HP;
> 
> 		/*
> 		 * Disable hot-plug interrupts in case they have been enabled
> 		 * by the BIOS and the hot-plug service driver is not loaded.
> 		 */
> -		pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
> -			  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
> +		if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
> +			pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
> +				  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);

Yes, this could sovlve the original issue. 

The problem I heard from BIOS developer is, they didn't expect to
receive 2 link control commands at almost the same time, which doesn't
comply to pcie spec, and normaly the handling of one command will take
some time, though not as long as 1 second.

Thanks,
Feng

> The above patch also makes sure the interrupts are quiesced if the
> platform didn't grant hotplug control to OSPM.
> 
> Thanks,
> 
> Lukas

