Return-Path: <linux-pci+bounces-23021-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6C8A53E40
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 00:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5411885ACA
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 23:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CF6207A0F;
	Wed,  5 Mar 2025 23:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2TiLHVl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372802063F1;
	Wed,  5 Mar 2025 23:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741216201; cv=none; b=H9ReEi45ScdEnmdpfn6Hnn8tniINrUp0dif0kMPnc5END6CQK8SPDKzE/ddOwA7E/MzfVVc7G1/fq414p+N1zvTMrcO/upzjU/W/a+8yTy/Wv8KvqUyA/OJ9Uhb6E5kXaaaRh1KL8a/p2HqRg+iDn5b0PgnIRD7mE4Uiwxm5J2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741216201; c=relaxed/simple;
	bh=kGopj6j6jgckJ5Ft0fpI+xWmN9Dwb2KCJy3OJcG95aI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=l1+b+TrJouND253U8F46uiLNWckzhcrCcXi8qb7fehC9FRIOzVE0DNBsTdkmtqmwsGutmdRCACtBQn8RRGCDn6ttvnoBoNED852S5BU9YRujzk2ykjRHmr+rwfjj3LZeZIgSl3fAMBVQXxh7n/70/0xUkPsEHBLFUu9MhHyZ8Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2TiLHVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898E6C4CED1;
	Wed,  5 Mar 2025 23:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741216200;
	bh=kGopj6j6jgckJ5Ft0fpI+xWmN9Dwb2KCJy3OJcG95aI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=T2TiLHVlbll32ZOZir0XXYdnjED1b+iRbmDF1xFNa7SF4cSPK/jjjMogYquVXKHFe
	 tPoFqm/ZoZ89ARAcchijCC76EPDFYumUvnxMZ1LPlyqdzr1i6P4m9H1LSc9uxhakPM
	 SDqDVr4b1yCNbwY1zu1SK8HlQY6CFL8AcJDHooF6Y9gIzHjf8QpfpvgQyWWrf0l29w
	 10z61kEl/0OvljScd3SDjQHB8kBYdKkEJ/NAkPlPSuBuJGWJ1haHfqxgfNX8laEUFD
	 /SXPjrrcMYzvA4qOs4/+qAuAXeNB5CrkGMKlL6EuqqJZYaoARgZH1khbD5ka5aqiW4
	 XtHEVbNfJhMpA==
Date: Wed, 5 Mar 2025 17:09:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: pciehp: Fix system hang during resume with
 daisy-chained hotplug controllers
Message-ID: <20250305230959.GA318387@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022130243.263737-1-acelan.kao@canonical.com>

Sorry for the delayed response.

On Tue, Oct 22, 2024 at 09:02:43PM +0800, Chia-Lin Kao (AceLan) wrote:
> A system hang occurs when multiple PCIe hotplug controllers in a daisy-chained
> setup (like a Thunderbolt dock with NVMe storage) resume from system sleep.
> This happens when both the dock and its downstream devices try to process PDC
> events at the same time through pciehp_request().
> 
> This patch changes pciehp_request() to atomic_or(), which adds the PDC event to
> ctrl->pending_events atomically. This change prevents the race condition by
> making the event handling atomic across multiple hotplug controllers during
> resume.

Can you explain what the race is, how it leads to a system hang, and
how this change avoids it?

I assume that .resume_noirq() for two devices in the same PCIe path,
e.g., a dock and a device downstream from it, would be serialized at a
higher level, because we would want to resume the upstream device
before trying to resume the downstream one.  But you're seeing
something different?

> The bug was found with an Intel Thunderbolt 4 Bridge (8086:0b26) dock and a
> Phison NVMe controller (1987:5012), where the system would hang if both devices
> tried to handle presence detect changes during resume.

The code change is in the pciehp_device_replaced() path.  When you
reproduce the problem, do you actually replace a device?  Or is
something wrong with the pciehp_device_replaced() checks, and we
mistakenly *think* a device was replaced?

> Changes:
>   v2:
>     * Replace pciehp_request() with atomic_or() to fix race condition
> 
>   v1:
>     * https://lore.kernel.org/lkml/Zvf7xYEA32VgLRJ6@wunner.de/T/
>     * Remove pci_walk_bus() call
>     * Fix appeared to work due to lower reproduction rate

Thanks for including the changelog.  You can put it after "---",
because we don't include it in the commit anyway.

You can wrap the commit log to 75 columns so it fits in 80 even after
git log indents it.

> Fixes: 9d573d19547b ("PCI: pciehp: Detect device replacement during system sleep")
> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> ---
>  drivers/pci/hotplug/pciehp_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> index ff458e692fed..56bf23d55c41 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -332,7 +332,7 @@ static int pciehp_resume_noirq(struct pcie_device *dev)
>  			ctrl_dbg(ctrl, "device replaced during system sleep\n");
>  			pci_walk_bus(ctrl->pcie->port->subordinate,
>  				     pci_dev_set_disconnected, NULL);
> -			pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
> +			atomic_or(PCI_EXP_SLTSTA_PDC, &ctrl->pending_events);
>  		}
>  	}
>  
> -- 
> 2.43.0
> 

