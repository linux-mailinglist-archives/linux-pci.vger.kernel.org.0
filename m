Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA9436599C
	for <lists+linux-pci@lfdr.de>; Tue, 20 Apr 2021 15:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhDTNPF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Apr 2021 09:15:05 -0400
Received: from foss.arm.com ([217.140.110.172]:34670 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231422AbhDTNPF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Apr 2021 09:15:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE07B1478;
        Tue, 20 Apr 2021 06:14:33 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E74D03F792;
        Tue, 20 Apr 2021 06:14:32 -0700 (PDT)
Date:   Tue, 20 Apr 2021 14:14:28 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Don't rename the Tegra MSI interrupt
Message-ID: <20210420131428.GA5734@lpieralisi>
References: <20210420125545.1315970-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420125545.1315970-1-jonathanh@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 20, 2021 at 01:55:45PM +0100, Jon Hunter wrote:
> Commit 973a28677e39 ("PCI: tegra: Convert to MSI domains") renamed the
> Tegra PCIe MSI interrupt from 'Tegra PCIe MSI' to 'tegra PCIe MSI'. This
> is breaking a PCIe sanity test that we are running on Tegra124 Jetson
> TK1 because it is looking for an interrupt called 'Tegra PCIe MSI' which
> is no longer found. Although we could update the test to fix this, at
> the same time it does not seem necessary to rename the interrupt.
> Therefore, change the name of the interrupt back to 'Tegra PCIe MSI'.
> 
> Fixes: 973a28677e39 ("PCI: tegra: Convert to MSI domains")
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Squashed with the Fixes: commit in my pci/msi branch, pushed out.

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index eaba7b2fab4a..32ca16c87092 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -1593,7 +1593,7 @@ static void tegra_msi_top_irq_unmask(struct irq_data *d)
>  }
>  
>  static struct irq_chip tegra_msi_top_chip = {
> -	.name		= "tegra PCIe MSI",
> +	.name		= "Tegra PCIe MSI",
>  	.irq_ack	= tegra_msi_top_irq_ack,
>  	.irq_mask	= tegra_msi_top_irq_mask,
>  	.irq_unmask	= tegra_msi_top_irq_unmask,
> -- 
> 2.25.1
> 
