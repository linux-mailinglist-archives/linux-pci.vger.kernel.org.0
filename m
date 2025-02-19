Return-Path: <linux-pci+bounces-21788-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCF9A3AFD2
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 03:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1768C172928
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 02:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFA6188596;
	Wed, 19 Feb 2025 02:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bJBsQlMl"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0C228628D;
	Wed, 19 Feb 2025 02:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739933633; cv=none; b=Klsz9NS68DpoSsjGLa61sr2wM3qKx+nfoBzVibTaYgXnYT8uwUyBrIIt1Vh0msE4nJgwZqs81RZ7QOFoviQkH9JS5wQxHe02wdU+PY1FT6x5ilOR4mWR+3CfClgLeVxMBIUoSMvb9xzCYthjCPdKmpeKxfZGlGIpdcpyze7+R1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739933633; c=relaxed/simple;
	bh=WTuA/6zlo3WaMfQgV0PxqQOUf5HaH/BzEORKfOTcQWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuPl7gc+WVrxZTy7cPYGnFMYnd9qE603e+6OySPpjS/KFaNwtXbn2PK6IeWsB+zuBT471fqEwD3mYKBCDWEl5iO6tXU5Sj1jadq/V560MEmyaTibVV3yqVqZxPEn0RqZA2Q6Dji+oizvIcJXxKAiXQ83A6rfoYiHty9blUosvks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bJBsQlMl; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739933627; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=IZzdzW1u5LTjOOJ1vaRZH/M9adQ7NyTBBe2vFRTsMKU=;
	b=bJBsQlMlc+Pi/2ogGJZ9FH2r6wCz2bi3zSFSHuupBLfj0z5YHfapvSaOS7SjKLKHhomaOWtCo3DTE5qLotn8eQ8jL0jjBuYiVhPpx+znhnvnkVLTRk+G16BBHsGaywIbN63ZohXlGuoeoihMHyx52x67OZtrMfJZRW1yMqO7CsA=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WPnbXVJ_1739933626 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Feb 2025 10:53:46 +0800
Date: Wed, 19 Feb 2025 10:53:44 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <Z7VHuOFxilan4LX_@U-2FWC9VHC-2323.local>
References: <20250218034859.40397-1-feng.tang@linux.alibaba.com>
 <20250218223354.GA196886@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250218223354.GA196886@bhelgaas>

Hi Bjorn Helgaas,

Thanks for the review!

On Tue, Feb 18, 2025 at 04:33:54PM -0600, Bjorn Helgaas wrote:
> On Tue, Feb 18, 2025 at 11:48:58AM +0800, Feng Tang wrote:
> > There was problem reported by firmware developers that they received
> > 2 pcie link control commands in very short intervals on an ARM server,
> > which doesn't comply with pcie spec, and broke their state machine and
> > work flow. According to PCIe 6.1 spec, section 6.7.3.2, software needs
> > to wait at least 1 second for the command-complete event, before
> > resending the cmd or sending a new cmd.
> 
> s/link control/hotplug/ (also below)
> s/2/two/
> s/pcie/PCIe/ (also below)
 
Will follow.

> > And the first link control command firmware received is from
> > get_port_device_capability(), which sends cmd to disable pcie hotplug
> > interrupts without waiting for its completion.
> > 
> > Fix it by adding the necessary wait to comply with PCIe spec, referring
> > pcie_poll_cmd().
> > 
> > Also make the interrupt disabling not dependent on whether pciehp
> > service driver will be loaded as suggested by Lukas.
> 
> This sounds like maybe it should be two separate patches.

OK.

[...]
> >  
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
> 
> Ugh.  I really don't like the way this basically duplicates
> pcie_poll_cmd().  I don't have a great suggestion to fix it; maybe we
> need a way to build part of pciehp unconditionally.

Yes, I also thought about this. One idea is to unify the two functions,
and let pcie_poll_cmd() reuse this pcie_wait_sltctl_cmd_raw() here in
portdrv.c. As CONFIG_HOTPLUG_PCI_PCIE depends on CONFIG_PCIEPORTBUS,
there should be no dependency issue. How do you think? 

> At the very least
> we need a comment here pointing to pcie_poll_cmd().

Aha, I mentioned 'referring pcie_poll_cmd()' in commit log, but forgot
to add it here.

> 
> And IIUC this will add a one second delay for ports that don't need
> command completed events.  I don't think that's fair to those ports.

Good catch! So we should add a read of PCI_EXP_SLTCAP register and
check if PCI_EXP_SLTCAP_HPC bit is set.

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
> 
> s/PCIE/PCIe/

Will change.

Thanks,
Feng

