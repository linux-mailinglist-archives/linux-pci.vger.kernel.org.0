Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F140F2FC058
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jan 2021 20:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbhASTt2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jan 2021 14:49:28 -0500
Received: from foss.arm.com ([217.140.110.172]:47778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728435AbhASTtJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Jan 2021 14:49:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7A49D6E;
        Tue, 19 Jan 2021 11:47:59 -0800 (PST)
Received: from [10.57.39.58] (unknown [10.57.39.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E12EC3F719;
        Tue, 19 Jan 2021 11:47:58 -0800 (PST)
Subject: Re: [PATCH 1/3] PCI: dwc: Skip allocating own MSI domain if using
 external MSI domain
To:     Simon Xue <xxm@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        linux-rockchip@lists.infradead.org
References: <20210118091739.247040-1-xxm@rock-chips.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e17fcf83-18f1-c2c4-3a0c-a68e74138e15@arm.com>
Date:   Tue, 19 Jan 2021 19:47:57 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210118091739.247040-1-xxm@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-01-18 09:17, Simon Xue wrote:
> From: Shawn Lin <shawn.lin@rock-chips.com>
> 
> On some platform, external MSI domain is using instead of the one
> created by designware driver. For instance, if using GIC-V3-ITS
> as a MSI domain, we only need set msi-map in the devicetree but
> never need any bit in the designware driver to handle MSI stuff.
> So skip allocating its own MSI domain for that case.

How is this different from the existing pp->has_msi_ctrl? AFAICS, 
dw_pcie_host_init() won't call dw_pcie_allocate_domains() anyway if an 
external MSI controller is present.

Robin.

> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> ---
>   drivers/pci/controller/dwc/pcie-designware-host.c | 10 +++++++++-
>   drivers/pci/controller/dwc/pcie-designware.h      |  1 +
>   2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 8a84c005f32b..d9d93cab970a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -235,6 +235,10 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>   	struct fwnode_handle *fwnode = of_node_to_fwnode(pci->dev->of_node);
>   
> +	/* Rely on the external MSI domain */
> +	if (pp->msi_ext)
> +		return 0;
> +
>   	pp->irq_domain = irq_domain_create_linear(fwnode, pp->num_vectors,
>   					       &dw_pcie_msi_domain_ops, pp);
>   	if (!pp->irq_domain) {
> @@ -258,6 +262,9 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
>   
>   static void dw_pcie_free_msi(struct pcie_port *pp)
>   {
> +	if (pp->msi_ext)
> +		return;
> +
>   	if (pp->msi_irq) {
>   		irq_set_chained_handler(pp->msi_irq, NULL);
>   		irq_set_handler_data(pp->msi_irq, NULL);
> @@ -359,7 +366,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
>   	if (pci->link_gen < 1)
>   		pci->link_gen = of_pci_get_max_link_speed(np);
>   
> -	if (pci_msi_enabled()) {
> +	if (pci_msi_enabled() &&
> +	    !pp->msi_ext) {
>   		pp->has_msi_ctrl = !(pp->ops->msi_host_init ||
>   				     of_property_read_bool(np, "msi-parent") ||
>   				     of_property_read_bool(np, "msi-map"));
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 0207840756c4..cf3b0664302a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -195,6 +195,7 @@ struct pcie_port {
>   	u32			irq_mask[MAX_MSI_CTRLS];
>   	struct pci_host_bridge  *bridge;
>   	raw_spinlock_t		lock;
> +	int			msi_ext;
>   	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
>   };
>   
> 
