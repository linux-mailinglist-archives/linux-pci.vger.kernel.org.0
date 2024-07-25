Return-Path: <linux-pci+bounces-10813-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC0693CA7A
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 00:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED71AB21AA3
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 22:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894F6146A87;
	Thu, 25 Jul 2024 21:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5GNVIln"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63568143738
	for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 21:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721944789; cv=none; b=F5pBGoznBmrhqNw8Mvu/tHGjR1yz3J5xPLO2QwJp91Qjr1oMaat4nkhgE4SEUeGHVWduV+XnnwJY1+5IZOn0ceoHqz38xIpDbflbjq0E2aI5NChxRgMcrpnuhpcTUs8wxuhZcBKcFHcMA84GzHwiFDYp2ok8NV/YPgf3d6eQP+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721944789; c=relaxed/simple;
	bh=ibNBeyQOCiKyZH7YFgK1XFv1KZ7LiJLSsvOAU4BTQJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SuXhL0tw6m9mjsuj/Rq3+v/gXWGo73m6ofztGBAkdWTiuIyEYac/LE+0rRBuiXCfgRT+ycQ5Tpz968WbqaofBGJaKRNk6hgWCqOx4cJDxrptqFLw2A0w+HOF/HRdw6cwyXf5D7iKcIjBX2r6qnvn8qJ561bHEB1mhKAkBCEp80A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5GNVIln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1A2C4AF07;
	Thu, 25 Jul 2024 21:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721944789;
	bh=ibNBeyQOCiKyZH7YFgK1XFv1KZ7LiJLSsvOAU4BTQJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=e5GNVIlnxSxo0MqzC+yJZAx0Zht/zGvyUMqm5OWbhx2WHnoEI2SKP89o5KZx1PLGL
	 1+oGK74NFQf7GGNB58yo389mNvWJkLkFQIPDgvjfQ+q3cp6ILrNr0RJmou5Yp/r+ti
	 ZAO3wGb2R1kc3mo4XVF5l2v7LGb9Xel/XhfOIRZgKqIr+4aYwfDebP9PtFahiR5dqD
	 ZNvmRZ2wh29/8WAG6G42WCbhGzOcd6u/0ZiEPyDgvdJT8jaQsyhIHAzk++PwUlfL12
	 YmjQY7w+0P4wWeH3Le0vmjPDXTsWLvO7W5MxW+f1f9Tq2RqAhQP1gIMLAst6aN3/vP
	 KEzoVtrw7bUNg==
Date: Thu, 25 Jul 2024 16:59:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Blazej Kucman <blazej.kucman@intel.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com, mariusz.tkaczyk@linux.intel.com,
	Myron Stowe <myron.stowe@redhat.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] PCI: pciehp_hpc: Fix set raw indicator status
Message-ID: <20240725215945.GA855755@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722141440.7210-1-blazej.kucman@intel.com>

[+cc Myron, Kai-Heng, Joerg: fix for regression already in distros]

On Mon, Jul 22, 2024 at 04:14:40PM +0200, Blazej Kucman wrote:
> Set raw indicator status interface has been designed to respect bits
> responsible for Attention and Power Indicator Control [1]. But since
> abaaac4845a0 ("PCI: hotplug: Use FIELD_GET/PREP()") only processes
> Attention Indicator Control bits.
> 
> Mentioned change replace direct bit shift, via macro FIELD_PREP, which
> additionally performs an AND operation with the passed bitmask. The
> regression results from an incorrect bitmask, the mask should include bits
> responsible for Attention and Power Indicator Control, but only Attention
> Indicator Control was passed. This lead to a loss of passed bits
> responsible for Power Indicator control.
> 
> This fix restores Power Indicator Control bits support.
> 
> [1] 576243b3f9ea ("PCI: pciehp: Allow exclusive userspace control of indicators")
> 
> Fixes: abaaac4845a0 ("PCI: hotplug: Use FIELD_GET/PREP()")
> Signed-off-by: Blazej Kucman <blazej.kucman@intel.com>

Thanks for the regression report and for debugging and fixing it!

I propose the following commit log update to add more details of what
broke and what's affects (only Intel VMD, IIUC).

And also a stable tag since abaaac4845a0 appeared in v6.7 and is
already in distros.

I plan to put this on for-linus for v6.11.

  PCI: pciehp: Retain Power Indicator bits for userspace indicators
  
  The sysfs "attention" file normally controls the Slot Control Attention
  Indicator with 0 (off), 1 (on), 2 (blink) settings.
  
  576243b3f9ea ("PCI: pciehp: Allow exclusive userspace control of
  indicators") added pciehp_set_raw_indicator_status() to allow userspace to
  directly control all four bits in both the Attention Indicator and the
  Power Indicator fields via the "attention" file.
  
  This is used on Intel VMD bridges so utilities like "ledmon" can use sysfs
  "attention" to control up to 16 indicators for NVMe device RAID status.
  
  abaaac4845a0 ("PCI: hotplug: Use FIELD_GET/PREP()") broke this by masking
  the sysfs data with PCI_EXP_SLTCTL_AIC, which discards the upper two bits
  intended for the Power Indicator Control field (PCI_EXP_SLTCTL_PIC).
  
  For NVMe devices behind an Intel VMD, ledmon settings that use the
  PCI_EXP_SLTCTL_PIC bits, i.e., ATTENTION_REBUILD (0x5), ATTENTION_LOCATE
  (0x7), ATTENTION_FAILURE (0xD), ATTENTION_OFF (0xF), no longer worked
  correctly.
  
  Mask with PCI_EXP_SLTCTL_AIC | PCI_EXP_SLTCTL_PIC to retain both the
  Attention Indicator and the Power Indicator bits.
  
  Fixes: abaaac4845a0 ("PCI: hotplug: Use FIELD_GET/PREP()")
  Link: https://lore.kernel.org/r/20240722141440.7210-1-blazej.kucman@intel.com
  Signed-off-by: Blazej Kucman <blazej.kucman@intel.com>
  [bhelgaas: commit log]
  Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
  Cc: stable@vger.kernel.org	# v6.7+

> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 061f01f60db4..736ad8baa2a5 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -485,7 +485,9 @@ int pciehp_set_raw_indicator_status(struct hotplug_slot *hotplug_slot,
>  	struct pci_dev *pdev = ctrl_dev(ctrl);
>  
>  	pci_config_pm_runtime_get(pdev);
> -	pcie_write_cmd_nowait(ctrl, FIELD_PREP(PCI_EXP_SLTCTL_AIC, status),
> +
> +	/* Attention and Power Indicator Control bits are supported */
> +	pcie_write_cmd_nowait(ctrl, FIELD_PREP(PCI_EXP_SLTCTL_AIC | PCI_EXP_SLTCTL_PIC, status),
>  			      PCI_EXP_SLTCTL_AIC | PCI_EXP_SLTCTL_PIC);
>  	pci_config_pm_runtime_put(pdev);
>  	return 0;
> -- 
> 2.35.3
> 

