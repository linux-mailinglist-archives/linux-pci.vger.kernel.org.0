Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D6B25FE71
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 18:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbgIGQQk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 12:16:40 -0400
Received: from foss.arm.com ([217.140.110.172]:40042 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729973AbgIGQQg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Sep 2020 12:16:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2845831B;
        Mon,  7 Sep 2020 09:16:29 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DBE93F68F;
        Mon,  7 Sep 2020 09:16:27 -0700 (PDT)
Date:   Mon, 7 Sep 2020 17:16:25 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Cc:     ray.jui@broadcom.com, helgaas@kernel.org, sbranden@broadcom.com,
        f.fainelli@gmail.com, robh@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PCI: iproc: Set affinity mask on MSI interrupts
Message-ID: <20200907161625.GB10272@e121166-lin.cambridge.arm.com>
References: <20200803035241.7737-1-mark.tomlinson@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803035241.7737-1-mark.tomlinson@alliedtelesis.co.nz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 03, 2020 at 03:52:40PM +1200, Mark Tomlinson wrote:
> The core interrupt code expects the irq_set_affinity call to update the
> effective affinity for the interrupt. This was not being done, so update
> iproc_msi_irq_set_affinity() to do so.
> 
> Fixes: 3bc2b2348835 ("PCI: iproc: Add iProc PCIe MSI support")
> Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
> ---
> changes in v2:
>  - Patch 1/2 Added Fixes tag
>  - Patch 2/2 Replace original change with change suggested by Bjorn
>    Helgaas.
> 
> changes in v3:
>  - Use bitfield rather than bool to save memory.
> 
>  drivers/pci/controller/pcie-iproc-msi.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Applied to pci/qcom, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
> index 3176ad3ab0e5..908475d27e0e 100644
> --- a/drivers/pci/controller/pcie-iproc-msi.c
> +++ b/drivers/pci/controller/pcie-iproc-msi.c
> @@ -209,15 +209,20 @@ static int iproc_msi_irq_set_affinity(struct irq_data *data,
>  	struct iproc_msi *msi = irq_data_get_irq_chip_data(data);
>  	int target_cpu = cpumask_first(mask);
>  	int curr_cpu;
> +	int ret;
>  
>  	curr_cpu = hwirq_to_cpu(msi, data->hwirq);
>  	if (curr_cpu == target_cpu)
> -		return IRQ_SET_MASK_OK_DONE;
> +		ret = IRQ_SET_MASK_OK_DONE;
> +	else {
> +		/* steer MSI to the target CPU */
> +		data->hwirq = hwirq_to_canonical_hwirq(msi, data->hwirq) + target_cpu;
> +		ret = IRQ_SET_MASK_OK;
> +	}
>  
> -	/* steer MSI to the target CPU */
> -	data->hwirq = hwirq_to_canonical_hwirq(msi, data->hwirq) + target_cpu;
> +	irq_data_update_effective_affinity(data, cpumask_of(target_cpu));
>  
> -	return IRQ_SET_MASK_OK;
> +	return ret;
>  }
>  
>  static void iproc_msi_irq_compose_msi_msg(struct irq_data *data,
> -- 
> 2.28.0
> 
