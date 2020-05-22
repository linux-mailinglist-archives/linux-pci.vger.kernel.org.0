Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33901DE55D
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 13:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgEVL3j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 07:29:39 -0400
Received: from foss.arm.com ([217.140.110.172]:33642 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728281AbgEVL3j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 May 2020 07:29:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07F6555D;
        Fri, 22 May 2020 04:29:39 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEEF33F305;
        Fri, 22 May 2020 04:29:37 -0700 (PDT)
Date:   Fri, 22 May 2020 12:29:35 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Use private data pointer of "struct
 irq_domain" to get pcie_port
Message-ID: <20200522112935.GB11785@e121166-lin.cambridge.arm.com>
References: <20191220100550.777-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220100550.777-1-kishon@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 20, 2019 at 03:35:50PM +0530, Kishon Vijay Abraham I wrote:
> No functional change. Get "struct pcie_port *" from private data
> pointer of "struct irq_domain" in dw_pcie_irq_domain_free() to make
> it look similar to how "struct pcie_port *" is obtained in
> dw_pcie_irq_domain_alloc()
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied (eventually) to pci/dwc, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 395feb8ca051..c3d72b06e964 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -236,7 +236,7 @@ static void dw_pcie_irq_domain_free(struct irq_domain *domain,
>  				    unsigned int virq, unsigned int nr_irqs)
>  {
>  	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
> -	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
> +	struct pcie_port *pp = domain->host_data;
>  	unsigned long flags;
>  
>  	raw_spin_lock_irqsave(&pp->lock, flags);
> -- 
> 2.17.1
> 
