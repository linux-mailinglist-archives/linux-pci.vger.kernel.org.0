Return-Path: <linux-pci+bounces-22733-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 996F2A4B7C0
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 06:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1CE1891692
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 05:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C2078F51;
	Mon,  3 Mar 2025 05:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UQn7qTpz"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC3DEADC;
	Mon,  3 Mar 2025 05:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740981372; cv=none; b=E7u2n5uDFbkF0w5pas2YilDSYv5YsUsAAORbWY5RLuhoEXV879yirmTEyzyGMjd0cF3NIM+kkQ1msROVRzXatjIX5VFJI/YzBfwnTuad7xMJs91cuGDEZKq4myBzmSPvBTb6Tm32/Apvu+xiYFn0yZIVL/sUyCgy5D/5nuByuLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740981372; c=relaxed/simple;
	bh=Jw7U3WAInx/bkEVkzJx5UaDPn6RT42UMO4XMwGteUN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvdLSUypLLrb4/jcJysN3xgL0AgrJqCQCDTiTfGYGBFEmgZtQPkPHYre0hgF3NaIRUqG2rZipjbyF7EwlEzXq7+79cOv9dnvYx2Serz4rlswTM3aZBn+mT6uXKHJw3f2KYtXMWMj68lzVAgfR60esF9/R5tW+xlNDDgY2BXlocs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UQn7qTpz; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740981360; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=H/yjwu1L0or8oQXoSnkX6Eqgkqb/O5PVG0vAikt1sKw=;
	b=UQn7qTpzJmxe55xin+MpuLHMKyZjY37zUfMprQbEiAqh3RjyXyAyFMjKyLyJ/ddfNLHBqMXMKJ5K57L+nrUvxdO4+LyYoRh3QAv5qJhL1LZnqUfQ6H3t68SXVURRBSENJcY3XPmUfVOcg0L5iAGwRSFFRe3CJKFCGnfQ26wfSHw=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WQYoT3M_1740981359 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 03 Mar 2025 13:55:59 +0800
Date: Mon, 3 Mar 2025 13:55:58 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Liguang Zhang <zhangliguang@linux.alibaba.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>, rafael@kernel.org,
	Markus Elfring <Markus.Elfring@web.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] PCI/portdrv: Only disable hotplug interrupts early
 when needed.
Message-ID: <Z8VEbpv-uobfAgs7@U-2FWC9VHC-2323.local>
References: <20250303023630.78397-1-feng.tang@linux.alibaba.com>
 <746fed71-f9cd-467c-ba0c-a61acd58da8d@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <746fed71-f9cd-467c-ba0c-a61acd58da8d@linux.intel.com>

Hi Sathyanarayanan,

On Sun, Mar 02, 2025 at 07:35:21PM -0800, Sathyanarayanan Kuppuswamy wrote:
> 
> On 3/2/25 6:36 PM, Feng Tang wrote:
> > There was problem reported by firmware developers that they received
> > two PCIe hotplug commands in very short intervals on an ARM server,
> > which doesn't comply with PCIe spec, and broke their state machine and
> > work flow. According to PCIe 6.1 spec, section 6.7.3.2, software needs
> > to wait at least 1 second for the command-complete event, before
> > resending the command or sending a new command.
> > 
> > In the failure case, the first PCIe hotplug command firmware received
> > is from get_port_device_capability(), which sends command to disable
> > PCIe hotplug interrupts without waiting for its completion, and the
> > second command comes from pcie_enable_notification() of pciehp driver,
> > which enables hotplug interrupts again.
> > 
> > One solution is to add the necessary delay after the first command [1],
> > while Lukas proposed an optimization that if the pciehp driver will be
> > loaded soon and handle the interrupts, then the hotplug and the wait
> > are not needed and can be saved, for every root port.
> 
> I think above part of the commit message might need some rewording.
> 
> The way you are fixing this issue is to make the first command conditional
> on hotplug driver not enabled. That way you can skip one of these
> commands in both enable/disable hotplug driver case.
> 
> I also recommend adding some info about why making this change
> should not affect the original intention of commit # 2bd50dd800b5

Sure. Will add.

> Code wise looks fine.
> 
> Reviewed-by: Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com>
 
Thank you!

- Feng

> > 
> > So fix it by only disabling the hotplug interrupts when pciehp driver
> > is not enabled.
> > 
> > [1]. https://lore.kernel.org/lkml/20250224034500.23024-1-feng.tang@linux.alibaba.com/t/#u
> > 
> > Fixes: 2bd50dd800b5 ("PCI: PCIe: Disable PCIe port services during port initialization")
> > Suggested-by: Lukas Wunner <lukas@wunner.de>
> > Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
> > ---
> > Changelog:
> > 
> >    since v3:
> >      * Separate this patch from patches dealing with irq storm in nomsi case
> >      * Take Lukas's suggestion (Lukas Wunner)
> > 
> >    since v2:
> >      * Add patch 0001, which move the waiting logic of pcie_poll_cmd from pciehp
> >        driver to PCIe port driver for code reuse (Bjorn Helgaas)
> >      * Separate Lucas' suggestion out as patch 0003 (Bjorn and Sathyanarayanan)
> >      * Avoid hotplug command waiting for HW without command-complete
> >        event support (Bjorn Helgaas)
> >      * Fix spell issue in commit log (Bjorn and Markus)
> >      * Add cover-letter for whole patchset (Markus Elfring)
> >      * Handle a set-but-unused build warning (0Day lkp bot)
> > 
> >    since v1:
> >      * Add the Originally-by for Liguang for patch 0002. The issue was found on
> >        a 5.10 kernel, then 6.6. I was initially given a 5.10 kernel tar ball
> >        without git info to debug the issue, and made the patch. Thanks to Guanghui
> >        who recently pointed me to tree https://gitee.com/anolis/cloud-kernel which
> >        show the wait logic in 5.10 was originally from Liguang, and never hit
> >        mainline.
> >      * Make the irq disabling not dependent on wthether pciehp service driver
> >        will be loaded (Lukas Wunner)
> >      * Use read_poll_timeout() API to simply the waiting logic (Sathyanarayanan
> >        Kuppuswamy)
> >      * Fix wrong email address (Markus Elfring)
> >      * Add logic to skip irq disabling if it is already disabled.
> > 
> > 
> >   drivers/pci/pcie/portdrv.c | 8 +++++---
> >   1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> > index 02e73099bad0..e8318fd5f6ed 100644
> > --- a/drivers/pci/pcie/portdrv.c
> > +++ b/drivers/pci/pcie/portdrv.c
> > @@ -228,10 +228,12 @@ static int get_port_device_capability(struct pci_dev *dev)
> >   		/*
> >   		 * Disable hot-plug interrupts in case they have been enabled
> > -		 * by the BIOS and the hot-plug service driver is not loaded.
> > +		 * by the BIOS and the hot-plug service driver won't be loaded
> I think you can use "is not enabled" instead of won't be loaded.
> 
> > +		 * to handle them.
> >   		 */
> > -		pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
> > -			  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
> > +		if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
> > +			pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
> > +				PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
> >   	}
> >   #ifdef CONFIG_PCIEAER
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer

