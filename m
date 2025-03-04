Return-Path: <linux-pci+bounces-22919-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140BCA4F14C
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 00:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B8B23A5BE5
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 23:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B807625F99E;
	Tue,  4 Mar 2025 23:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtitfG8p"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE1B1FF60A;
	Tue,  4 Mar 2025 23:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741130246; cv=none; b=Biot6pbzwozvl635W3uNv/Nw9uZAG2QPNcCGJmeqfv5VIUVw7lAeOMXL//DYkW7E8Ebz3Q6HYRSrWgg4JvuxPkjP9KETwtqQ5Sp46qmfC3flDmCNyKcK28261/0RBz/qm8K3itn7z2+NrViZTb6Mntt2fNdXQ2y/anm243bGwOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741130246; c=relaxed/simple;
	bh=Sr1bLjjVFJ5rjXiKSVLBrFS4W9IbS+9kJcL3dTiWIpY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PqHtf8PAIy99hSMkhkTRMP+pYX43XMADNwWflHahsenYEWCSinkQTLKDhntCeRl/fkDTs93tCt/oPf4vNnD1hLAuoY7/bDEwdu255sO5Jlz90qZslvGzWhL9Ig0O+0WyK+ODDrkBZJ5KJn5RBvvfaldfrBiCN6LvtqeHRcqP0ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtitfG8p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F85C4CEE5;
	Tue,  4 Mar 2025 23:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741130246;
	bh=Sr1bLjjVFJ5rjXiKSVLBrFS4W9IbS+9kJcL3dTiWIpY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HtitfG8pgqKjTpCNLN3u5v2kbXSaL41aGvDLRxQa7o9uh7NUBb3Im0iB//ar8jZ2g
	 sBYHUPWPepptg8pbztvDH2CH7wErv8xHRERbb13uBze7HuJ66Bvf2PsMNcuF1Wm74j
	 exfAeUJPSW5t3X7kyfljFves9PxYqVi7yHzBL26iJXmlvNLUw7n7ASnGruO5mWyZ+1
	 gYC3gt/1A2SvWTg+JZVhryff0cDZOI/GTHMPYxDUjVWY0eCwh2VDH4EEdM17RNHbTv
	 ii5f3kx07bV+J4yduo9R3Pq3LSnScfR6mARFw0WYC/SDglyx6sWxK2ZmKJSeLBaHp6
	 mwCDAdOw4gL2A==
Date: Tue, 4 Mar 2025 17:17:24 -0600
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
Subject: Re: [PATCH v4] PCI/portdrv: Only disable hotplug interrupts early
 when needed.
Message-ID: <20250304231724.GA264454@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303023630.78397-1-feng.tang@linux.alibaba.com>

On Mon, Mar 03, 2025 at 10:36:30AM +0800, Feng Tang wrote:
> There was problem reported by firmware developers that they received
> two PCIe hotplug commands in very short intervals on an ARM server,
> which doesn't comply with PCIe spec, and broke their state machine and
> work flow. According to PCIe 6.1 spec, section 6.7.3.2, software needs
> to wait at least 1 second for the command-complete event, before
> resending the command or sending a new command.
> 
> In the failure case, the first PCIe hotplug command firmware received
> is from get_port_device_capability(), which sends command to disable
> PCIe hotplug interrupts without waiting for its completion, and the
> second command comes from pcie_enable_notification() of pciehp driver,
> which enables hotplug interrupts again.
> 
> One solution is to add the necessary delay after the first command [1],
> while Lukas proposed an optimization that if the pciehp driver will be
> loaded soon and handle the interrupts, then the hotplug and the wait
> are not needed and can be saved, for every root port.
> 
> So fix it by only disabling the hotplug interrupts when pciehp driver
> is not enabled.
> 
> [1]. https://lore.kernel.org/lkml/20250224034500.23024-1-feng.tang@linux.alibaba.com/t/#u
> 
> Fixes: 2bd50dd800b5 ("PCI: PCIe: Disable PCIe port services during port initialization")
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>

Applied to pci/hotplug for v6.15, thanks!

> ---
> Changelog:
> 
>   since v3:
>     * Separate this patch from patches dealing with irq storm in nomsi case
>     * Take Lukas's suggestion (Lukas Wunner)  
> 
>   since v2:
>     * Add patch 0001, which move the waiting logic of pcie_poll_cmd from pciehp
>       driver to PCIe port driver for code reuse (Bjorn Helgaas)
>     * Separate Lucas' suggestion out as patch 0003 (Bjorn and Sathyanarayanan)  
>     * Avoid hotplug command waiting for HW without command-complete
>       event support (Bjorn Helgaas)
>     * Fix spell issue in commit log (Bjorn and Markus)
>     * Add cover-letter for whole patchset (Markus Elfring)
>     * Handle a set-but-unused build warning (0Day lkp bot)
> 
>   since v1:
>     * Add the Originally-by for Liguang for patch 0002. The issue was found on
>       a 5.10 kernel, then 6.6. I was initially given a 5.10 kernel tar ball
>       without git info to debug the issue, and made the patch. Thanks to Guanghui
>       who recently pointed me to tree https://gitee.com/anolis/cloud-kernel which
>       show the wait logic in 5.10 was originally from Liguang, and never hit
>       mainline.
>     * Make the irq disabling not dependent on wthether pciehp service driver
>       will be loaded (Lukas Wunner) 
>     * Use read_poll_timeout() API to simply the waiting logic (Sathyanarayanan
>       Kuppuswamy)
>     * Fix wrong email address (Markus Elfring)
>     * Add logic to skip irq disabling if it is already disabled.
> 
> 
>  drivers/pci/pcie/portdrv.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 02e73099bad0..e8318fd5f6ed 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -228,10 +228,12 @@ static int get_port_device_capability(struct pci_dev *dev)
>  
>  		/*
>  		 * Disable hot-plug interrupts in case they have been enabled
> -		 * by the BIOS and the hot-plug service driver is not loaded.
> +		 * by the BIOS and the hot-plug service driver won't be loaded
> +		 * to handle them.
>  		 */
> -		pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
> -			  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
> +		if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
> +			pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
> +				PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
>  	}
>  
>  #ifdef CONFIG_PCIEAER
> -- 
> 2.43.5
> 

