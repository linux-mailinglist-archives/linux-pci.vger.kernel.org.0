Return-Path: <linux-pci+bounces-22280-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 643DCA4335F
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 04:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0EBD3B0EC7
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 03:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C68B13632B;
	Tue, 25 Feb 2025 03:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="W9LLfq+5"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB17BE49;
	Tue, 25 Feb 2025 03:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740452821; cv=none; b=E7U4b2fMV18m6y3HrwC2RzzSjsmVN+7pSYqjYBzie37Kg7v+rv8yGFNAnZ2tfe8wKH6+FAsFvm3TUJnH3Y4R1r28UhVQVXCdrKf0Dcd5qYr10o80+NUOc+yxtyX5intHPh6hmAC5sFrnFsEXLbxDHjNkGBgy2wDeulkZcMHmMu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740452821; c=relaxed/simple;
	bh=lHEAxf5ZJA2azxyY/oKi7P/y8H4bZ4x9CyA6kaJAiGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jr40HIE5HuAMl6JPKX5xDxXBrjZy/B5h8WiFHjZlbUDxI+/AnymMhKH3LVaDaaTyPNPnvotACP71NdKM4NdfBv1SH1oM9hzwOIIzI/jr8gFIxAx3Ab4qV+rrEZdHJADSYh9PfjK3Q/N2TlzETaDHfz03qzK0k4rLcw0oRPcvdQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=W9LLfq+5; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740452811; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=tPFJL3Zgq99hh+p83jK5GeOO9zW89CPdsTMm5GrF2Dc=;
	b=W9LLfq+5/W5AmwotnDp4n7Hmd1wB85LE/53Y4iwvDbL7jm+Qotk/8ErUdR6troUsfDNMcJzCqTESOxKRIL4xBWDLa/+XcDdRzVG8+fRKCKFn1s+XxOpEfGrwae3hbjHUgPMcIE/MEfmNaWZxC2w0xntQkltvGdBRXmsq//vuXQk=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WQD2tsl_1740452810 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 25 Feb 2025 11:06:51 +0800
Date: Tue, 25 Feb 2025 11:06:50 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Lukas Wunner <lukas@wunner.de>, rafael@kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Liguang Zhang <zhangliguang@linux.alibaba.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>, rafael@kernel.org,
	Markus Elfring <Markus.Elfring@web.de>, lkp@intel.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] PCI/portdrv: Add necessary wait for disabling
 hotplug events
Message-ID: <Z70zyhZe6OrxNNT3@U-2FWC9VHC-2323.local>
References: <20250224034500.23024-1-feng.tang@linux.alibaba.com>
 <20250224034500.23024-3-feng.tang@linux.alibaba.com>
 <Z7y2e-EJLijQsp8D@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z7y2e-EJLijQsp8D@wunner.de>

Hi Lukas,

On Mon, Feb 24, 2025 at 07:12:11PM +0100, Lukas Wunner wrote:
> On Mon, Feb 24, 2025 at 11:44:58AM +0800, Feng Tang wrote:
> > @@ -255,8 +271,7 @@ static int get_port_device_capability(struct pci_dev *dev)
> >  		 * Disable hot-plug interrupts in case they have been enabled
> >  		 * by the BIOS and the hot-plug service driver is not loaded.
> >  		 */
> > -		pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
> > -			  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
> > +		pcie_disable_hp_interrupts_early(dev);
> >  	}
> 
> Moving the Slot Control code from pciehp to portdrv (as is done in
> patch 1 of this series) is hackish.  It should be avoided if at all
> possible.

I tried to remove the code duplication of 2 waiting function, according
to Bjorn's comment in https://lore.kernel.org/lkml/20250218223354.GA196886@bhelgaas/.
Maybe I didn't git it right. Any suggestion?

> 
> As I've already said before...
> 
> https://lore.kernel.org/all/Z6HYuBDP6uvE1Sf4@wunner.de/
> 
> ...it seems clearing those interrupts is only necessary
> in the CONFIG_HOTPLUG_PCI_PCIE=n case.  And in that case,
> there is no second Slot Control write, so there is no delay
> to be observed.
> 
> Hence the proper solution is to make the clearing of the
> interrupts conditional on: !IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE)
> 
> You keep sending new versions of these patches that do not
> incorporate the feedback I provided in the above-linked e-mail.
> 
> Please re-read that e-mail and verify if the solution that
> I proposed solves the problem.  That solution does not
> require moving the Slot Control code from pciehp to portdrv.

There might be some misunderstaning here :), I responded in
https://lore.kernel.org/lkml/Z6LRAozZm1UfgjqT@U-2FWC9VHC-2323.local/
that your suggestion could solve our issue.

And the reason I didn't take it is I was afraid that it might hurt
the problem what commit 2bd50dd800b5 ("PCI: PCIe: Disable PCIe port
services during port initialization") tried to solve.

As you mentioned, the comment for 2bd50dd800b5 is "a bit confusing",
and I tried to guess in my previous reply: 
"
I'm not sure what problem this piece of code try to avoid, maybe
something simliar to the irq storm isseu as mentioned in the 2/2 patch?
The code comments could be about the small time window between this
point and the loading of pciehp driver, which will request_irq and
enable hotplug interrupt again.
"

The code comment from 2bd50dd800b5 is:

	/*
	 * Disable hot-plug interrupts in case they have been
	 * enabled by the BIOS and the hot-plug service driver
	 * is not loaded.
	 */

The "is not loaded" has 2 possible meanings:
1. the pciehp driver is not loaded yet at this point inside
   get_port_device_capability(), and will be loaded later
2. the pciehp will never be loaded, i.e. CONFIG_HOTPLUG_PCI_PCIE=n 

If it's case 2, your suggestion can solve it nicely, but for case 1,
we may have to keep the interrupt disabling.

Thanks,
Feng

