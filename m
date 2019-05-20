Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB6692422B
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2019 22:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbfETUhd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 May 2019 16:37:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbfETUhd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 May 2019 16:37:33 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B6CA21019;
        Mon, 20 May 2019 20:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558384652;
        bh=uVbjxAUWgCbC+3W6qUA4GM+o+g6rMmmsC7o/66teuCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p8eQOUOSP4VPav8rhVBRjLttgRZQ9uFqptDiDuCLlAxvIb7mQ5ZQoPB7mJKMabxf3
         0CRkwsnHenKlW4ZhoSOnWXc3OJZSnFxke+708NryVmv7GcXTP3ordbOVmbiYPjJmiJ
         fBK1TpkRYOX5kw88+elCoKaFCTGG+fybOZ8CTC+0=
Date:   Mon, 20 May 2019 15:37:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V4 20/28] PCI: tegra: Use legacy IRQ for port service
 drivers
Message-ID: <20190520203731.GA54609@google.com>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
 <20190516055307.25737-21-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516055307.25737-21-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 16, 2019 at 11:22:59AM +0530, Manikanta Maddireddy wrote:
> Tegra signals PCIe services like AER, PME, etc. over legacy IRQ line.
> By default, service drivers register interrupt routine over MSI IRQ line.
> Use pcie_pme_disable_msi() function to disable MSI for service drivers.

I think this device is not quite spec-compliant:

  https://lore.kernel.org/linux-pci/20190520175729.GC49425@google.com/

and you should work around this with a quirk that sets pdev->no_msi so
we don't use MSI for it at all.

> PME and AER interrupts registered to MSI without this change,
> cat /proc/interrupts | grep -i pci
> 36: 21 0 0 0 0 0 GICv2 104 Level       PCIE
> 37: 35 0 0 0 0 0 GICv2 105 Level       Tegra PCIe MSI
> 76: 0  0 0 0 0 0 Tegra PCIe MSI 0 Edge PCIe PME, aerdrv, PCIe BW notif
> 
> PME and AER interrupts registered to legacy IRQ with this change,
> cat /proc/interrupts | grep -i pci
> 36: 33 0 0 0 0 0 GICv2 104 Level      PCIE, PCIe PME, aerdrv, PCIe BW notif
> 37: 52 0 0 0 0 0 GICv2 105 Level      Tegra PCIe MSI
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
> V4: No change
> 
> V3: Corrected typo in commit log
> 
> V2: No change
> 
>  drivers/pci/controller/pci-tegra.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index ac57c5badd9b..0024bc42b400 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -41,6 +41,7 @@
>  #include <soc/tegra/pmc.h>
>  
>  #include "../pci.h"
> +#include "../pcie/portdrv.h"
>  
>  #define INT_PCI_MSI_NR (8 * 32)
>  
> @@ -2725,6 +2726,9 @@ static int tegra_pcie_probe(struct platform_device *pdev)
>  		goto put_resources;
>  	}
>  
> +	/* Switch to legacy IRQ for PCIe services like AER, PME*/
> +	pcie_pme_disable_msi();
> +
>  	pm_runtime_enable(pcie->dev);
>  	err = pm_runtime_get_sync(pcie->dev);
>  	if (err) {
> -- 
> 2.17.1
> 
