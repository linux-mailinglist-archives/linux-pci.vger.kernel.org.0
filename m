Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4354D1C54CB
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 13:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgEELxR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 07:53:17 -0400
Received: from foss.arm.com ([217.140.110.172]:38182 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbgEELxQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 May 2020 07:53:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E61A30E;
        Tue,  5 May 2020 04:53:16 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EE683F68F;
        Tue,  5 May 2020 04:53:15 -0700 (PDT)
Date:   Tue, 5 May 2020 12:53:13 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: dwc: Fix inner MSI IRQ domain registration
Message-ID: <20200505115313.GF12543@e121166-lin.cambridge.arm.com>
References: <20200501113921.366597-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501113921.366597-1-maz@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 01, 2020 at 12:39:21PM +0100, Marc Zyngier wrote:
> On a system that uses the internal DWC MSI widget, I get this
> warning from debugfs when CONFIG_GENERIC_IRQ_DEBUGFS is selected:
> 
>   debugfs: File ':soc:pcie@fc000000' in directory 'domains' already present!
> 
> This is due to the fact that the DWC MSI code tries to register two
> IRQ domains for the same firmware node, without telling the low
> level code how to distinguish them (by setting a bus token). This
> further confuses debugfs which tries to create corresponding
> files for each domain.
> 
> Fix it by tagging the inner domain as DOMAIN_BUS_NEXUS, which is
> the closest thing we have as to "generic MSI".
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied to pci/dwc, thanks !

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 395feb8ca051..3c43311bb95c 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -264,6 +264,8 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
>  		return -ENOMEM;
>  	}
>  
> +	irq_domain_update_bus_token(pp->irq_domain, DOMAIN_BUS_NEXUS);
> +
>  	pp->msi_domain = pci_msi_create_irq_domain(fwnode,
>  						   &dw_pcie_msi_domain_info,
>  						   pp->irq_domain);
> -- 
> 2.26.2
> 
