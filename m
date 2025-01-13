Return-Path: <linux-pci+bounces-19675-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C68AA0BB6C
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 16:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53E657A5021
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 15:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4C222BADC;
	Mon, 13 Jan 2025 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AfT6ZQvM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3073232;
	Mon, 13 Jan 2025 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736780914; cv=none; b=VFbEDpNK/fnu0hjkjeNYREqHYaXhlKJY4Gd4PU9qBocwBw8hbE9W/kDQ9a6I0n466iqiAb0WQf0VnrIEcE9RmVVRPHHsFfS5JSBo2JJymNDeLAyY3l/keZingr/JZYKVkdOHYnmwGfmPxsEk+U9byNgke2SHiJtpjWslUxEog1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736780914; c=relaxed/simple;
	bh=DVAgDqBnLldsPJKtnI8H57aI3ouV13upU7AZUNtcT44=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gQAOdu9oAk/BAZ31K67n5T+ylWJS4MU8Rj8MWaFtDA+w0Liyqe+Or8+uDqwru1+/hloAgRRaX6a5tYQYXnkrhnuEiZAgYJSQVid0uxtGbebNUHMVMcZD47FQjKedbJoS6gRYi59Cn7QInzy0eROAamjJ1ZkLb2bmSDw8/Qi43S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AfT6ZQvM; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736780914; x=1768316914;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DVAgDqBnLldsPJKtnI8H57aI3ouV13upU7AZUNtcT44=;
  b=AfT6ZQvMAUlKdhsBwtBNx+0X52hqvS61uGtkrXHezS5A//Xkcey2GoFF
   /WuvH0zAhIEUNbyZ773wHU7DwftUr6FKPcJAnnE10C//raB/j4L9qqHcE
   e1kHdBodBA/WGUdBpnWQM0afRsCXsRbwYUsRHyo3PdxOv4Y8eUeyAazBJ
   hA8g98XdzxkhCasKEQeQOHnaA/lxT2i+G8JBbMH+e+j82CLbSaGNAjn0b
   U0dEpR3TwSB+n9WQ++ZRRUmttpkrcJnvHNpUkRJbMC39nmQS52RTIQeco
   DaF0ojtuQLTp+x1T5Li9ViAVFHDo3iyX3NvaGyoJmnEPl9Vnj0YPxIkNM
   g==;
X-CSE-ConnectionGUID: qlPazgzTRW6Dn/JTmD/pDw==
X-CSE-MsgGUID: Up6jNn7zRPKIVIdjl5HPaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="54465872"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="54465872"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 07:08:31 -0800
X-CSE-ConnectionGUID: Gzn1SQeaRuqW4apa/ep+QQ==
X-CSE-MsgGUID: CYbhLrIFRQOOygKImgXxZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="109526452"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.121])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 07:08:28 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 13 Jan 2025 17:08:24 +0200 (EET)
To: Jiwei Sun <jiwei.sun.bj@qq.com>
cc: macro@orcam.me.uk, bhelgaas@google.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, guojinhui.liam@bytedance.com, 
    helgaas@kernel.org, Lukas Wunner <lukas@wunner.de>, ahuang12@lenovo.com, 
    sunjw10@lenovo.com
Subject: Re: [PATCH 2/2] PCI: Fix the PCIe bridge decreasing to Gen 1 during
 hotplug testing
In-Reply-To: <tencent_B9290375427BDF73A2DC855F50397CC9FA08@qq.com>
Message-ID: <3fe7b527-5030-c916-79fe-241bf37e4bab@linux.intel.com>
References: <tencent_B9290375427BDF73A2DC855F50397CC9FA08@qq.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 10 Jan 2025, Jiwei Sun wrote:

> From: Jiwei Sun <sunjw10@lenovo.com>
> 
> When we do the quick hot-add/hot-remove test (within 1 second) with a PCIE
> Gen 5 NVMe disk, there is a possibility that the PCIe bridge will decrease
> to 2.5GT/s from 32GT/s
> 
> pcieport 10002:00:04.0: pciehp: Slot(75): Link Down
> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
> pcieport 10002:00:04.0: pciehp: Slot(75): No device found
> ...
> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
> pcieport 10002:00:04.0: pciehp: Slot(75): No device found
> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
> pcieport 10002:00:04.0: pciehp: Slot(75): No device found
> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
> pcieport 10002:00:04.0: pciehp: Slot(75): No device found
> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
> pcieport 10002:00:04.0: pciehp: Slot(75): No device found
> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
> pcieport 10002:00:04.0: pciehp: Slot(75): No device found
> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
> pcieport 10002:00:04.0: broken device, retraining non-functional downstream link at 2.5GT/s
> pcieport 10002:00:04.0: pciehp: Slot(75): No link
> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
> pcieport 10002:00:04.0: pciehp: Slot(75): Link Up
> pcieport 10002:00:04.0: pciehp: Slot(75): No device found
> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
> pcieport 10002:00:04.0: pciehp: Slot(75): No device found
> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
> pci 10002:02:00.0: [144d:a826] type 00 class 0x010802 PCIe Endpoint
> pci 10002:02:00.0: BAR 0 [mem 0x00000000-0x00007fff 64bit]
> pci 10002:02:00.0: VF BAR 0 [mem 0x00000000-0x00007fff 64bit]
> pci 10002:02:00.0: VF BAR 0 [mem 0x00000000-0x001fffff 64bit]: contains BAR 0 for 64 VFs
> pci 10002:02:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x4 link at 10002:00:04.0 (capable of 126.028 Gb/s with 32.0 GT/s PCIe x4 link)
> 
> If a NVMe disk is hot removed, the pciehp interrupt will be triggered, and
> the kernel thread pciehp_ist will be woken up, the
> pcie_failed_link_retrain() will be called as the following call trace.
> 
>    irq/87-pciehp-2524    [121] ..... 152046.006765: pcie_failed_link_retrain <-pcie_wait_for_link
>    irq/87-pciehp-2524    [121] ..... 152046.006782: <stack trace>
>  => [FTRACE TRAMPOLINE]
>  => pcie_failed_link_retrain
>  => pcie_wait_for_link
>  => pciehp_check_link_status
>  => pciehp_enable_slot
>  => pciehp_handle_presence_or_link_change
>  => pciehp_ist
>  => irq_thread_fn
>  => irq_thread
>  => kthread
>  => ret_from_fork
>  => ret_from_fork_asm
> 
> Accorind to investigation, the issue is caused by the following scenerios,
> 
> NVMe disk	pciehp hardirq
> hot-remove 	top-half		pciehp irq kernel thread
> ======================================================================
> pciehp hardirq
> will be triggered
> 	    	cpu handle pciehp
> 		hardirq
> 		pciehp irq kthread will
> 		be woken up
> 					pciehp_ist
> 					...
> 					  pcie_failed_link_retrain
> 					    read PCI_EXP_LNKCTL2 register
> 					    read PCI_EXP_LNKSTA register
> If NVMe disk
> hot-add before
> calling pcie_retrain_link()
> 					    set target speed to 2_5GT

This assumes LBMS has been seen but DLLLA isn't? Why is that?

> 					      pcie_bwctrl_change_speed
> 	  				        pcie_retrain_link

> 						: the retrain work will be
> 						  successful, because
> 						  pci_match_id() will be
> 						  0 in
> 						  pcie_failed_link_retrain()

There's no pci_match_id() in pcie_retrain_link() ?? What does that : mean?
I think the nesting level is wrong in your flow description?

I don't understand how retrain success relates to the pci_match_id() as 
there are two different steps in pcie_failed_link_retrain().

In step 1, pcie_failed_link_retrain() sets speed to 2.5GT/s if DLLLA=0 and 
LBMS has been seen. Why is that condition happening in your case? You 
didn't explain LBMS (nor DLLLA) in the above sequence so it's hard to 
follow what is going on here. LBMS in particular is of high interest here 
because I'm trying to understand if something should clear it on the 
hotplug side (there's already one call to clear it in remove_board()).

In step 2 (pcie_set_target_speed() in step 1 succeeded), 
pcie_failed_link_retrain() attempts to restore >2.5GT/s speed, this only 
occurs when pci_match_id() matches. I guess you're trying to say that step 
2 is not taken because pci_match_id() is not matching but the wording 
above is very confusing.

Overall, I failed to understand the scenario here fully despite trying to 
think it through over these few days.

> 						  the target link speed
> 						  field of the Link Control
> 						  2 Register will keep 0x1.
> 
> In order to fix the issue, don't do the retraining work except ASMedia
> ASM2824.
> 
> Fixes: a89c82249c37 ("PCI: Work around PCIe link training failures")
> Reported-by: Adrian Huang <ahuang12@lenovo.com>
> Signed-off-by: Jiwei Sun <sunjw10@lenovo.com>
> ---
>  drivers/pci/quirks.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 605628c810a5..ff04ebd9ae16 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -104,6 +104,9 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
>  	u16 lnksta, lnkctl2;
>  	int ret = -ENOTTY;
>  
> +	if (!pci_match_id(ids, dev))
> +		return 0;
> +
>  	if (!pci_is_pcie(dev) || !pcie_downstream_port(dev) ||
>  	    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting)
>  		return ret;
> @@ -129,8 +132,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
>  	}
>  
>  	if ((lnksta & PCI_EXP_LNKSTA_DLLLA) &&
> -	    (lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT &&
> -	    pci_match_id(ids, dev)) {
> +	    (lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT) {
>  		u32 lnkcap;
>  
>  		pci_info(dev, "removing 2.5GT/s downstream link speed restriction\n");
> 

-- 
 i.



