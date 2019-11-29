Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B08F910D80A
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2019 16:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfK2Pqd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Nov 2019 10:46:33 -0500
Received: from foss.arm.com ([217.140.110.172]:49556 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbfK2Pqd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Nov 2019 10:46:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A832C30E;
        Fri, 29 Nov 2019 07:46:32 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 214B93F68E;
        Fri, 29 Nov 2019 07:46:31 -0800 (PST)
Date:   Fri, 29 Nov 2019 15:46:30 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        mbrugger@suse.com, phil@raspberrypi.org, jeremy.linton@arm.com,
        linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 5/7] PCI: brcmstb: add MSI capability
Message-ID: <20191129154629.GF43905@e119886-lin.cambridge.arm.com>
References: <20191126091946.7970-1-nsaenzjulienne@suse.de>
 <20191126091946.7970-6-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126091946.7970-6-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 26, 2019 at 10:19:43AM +0100, Nicolas Saenz Julienne wrote:
> From: Jim Quinlan <james.quinlan@broadcom.com>
> 
> This adds MSI support to the Broadcom STB PCIe host controller. The MSI
> controller is physically located within the PCIe block, however, there
> is no reason why the MSI controller could not be moved elsewhere in the
> future. MSIX is not supported by the HW.
> 
> Since the internal Brcmstb MSI controller is intertwined with the PCIe
> controller, it is not its own platform device but rather part of the
> PCIe platform device.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> Co-developed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> 
> ---
> 
> Changes since v2 (kept Marc's Reviewed-by as changes didn't affect irq
> subsystem stuff or seem petty enough):
>   - Use standard APIs on register operations
>   - Get rid of revision code

Do any RPI4's have a HW revision of less than 33?


>   - Update rules to msi_target_addr selection
>   - Remove unwarranted MSI_FLAG_PCI_MSIX
>   - Small cosmetic changes
> 
> Changes since v1:
>   - Move revision code and some registers to this patch
>   - Use PCIE_MSI_IRQ_DOMAIN in Kconfig
>   - Remove redundant register read from ISR
>   - Fail probe on MSI init error
>   - Get rid of msi_internal
>   - Use bitmap family of functions
>   - Use edge triggered setup
>   - Add comment regarding MultiMSI
>   - Simplify compose_msi_msg to avoid reg read
> 
> This is based on Jim's original submission[1] with some slight changes
> regarding how pcie->msi_target_addr is decided.
> 
> [1] https://patchwork.kernel.org/patch/10605955/
> 
>  drivers/pci/controller/Kconfig        |   1 +
>  drivers/pci/controller/pcie-brcmstb.c | 261 +++++++++++++++++++++++++-
>  2 files changed, 261 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 27504f108ee5..918e283bbff1 100644


> +
> +static void brcm_msi_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
> +{
> +	struct brcm_msi *msi = irq_data_get_irq_chip_data(data);
> +
> +	msg->address_lo = lower_32_bits(msi->target_addr);
> +	msg->address_hi = upper_32_bits(msi->target_addr);
> +	msg->data = 0x6540 | data->hwirq;

NIT: Perhaps this 0x6540 can be a define - just in the same way we have a define
for PCIE_MISC_MSI_DATA_CONFIG_VAL.

Thanks,

Andrew Murray

> +}
> +
> -- 
> 2.24.0
> 
