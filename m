Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B55FB0F86
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2019 15:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731818AbfILNEe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Sep 2019 09:04:34 -0400
Received: from foss.arm.com ([217.140.110.172]:33958 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731320AbfILNEd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Sep 2019 09:04:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AAF628;
        Thu, 12 Sep 2019 06:04:33 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9684F3F71F;
        Thu, 12 Sep 2019 06:04:32 -0700 (PDT)
Date:   Thu, 12 Sep 2019 14:04:30 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: fix find_next_bit() usage
Message-ID: <20190912130430.GG9720@e119886-lin.cambridge.arm.com>
References: <20190904160339.2800-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904160339.2800-1-niklas.cassel@linaro.org>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 04, 2019 at 06:03:38PM +0200, Niklas Cassel wrote:
> find_next_bit() takes a parameter of size long, and performs arithmetic
> that assumes that the argument is of size long.
> 
> Therefore we cannot pass a u32, since this will cause find_next_bit()
> to read outside the stack buffer and will produce the following print:
> BUG: KASAN: stack-out-of-bounds in find_next_bit+0x38/0xb0
> 
> Fixes: 1b497e6493c4 ("PCI: dwc: Fix uninitialized variable in dw_handle_msi_irq()")
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

>  drivers/pci/controller/dwc/pcie-designware-host.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index d3156446ff27..45f21640c977 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -78,7 +78,8 @@ static struct msi_domain_info dw_pcie_msi_domain_info = {
>  irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>  {
>  	int i, pos, irq;
> -	u32 val, num_ctrls;
> +	unsigned long val;
> +	u32 status, num_ctrls;
>  	irqreturn_t ret = IRQ_NONE;
>  
>  	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> @@ -86,14 +87,14 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>  	for (i = 0; i < num_ctrls; i++) {
>  		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_STATUS +
>  					(i * MSI_REG_CTRL_BLOCK_SIZE),
> -				    4, &val);
> -		if (!val)
> +				    4, &status);
> +		if (!status)
>  			continue;
>  
>  		ret = IRQ_HANDLED;
> +		val = status;
>  		pos = 0;
> -		while ((pos = find_next_bit((unsigned long *) &val,
> -					    MAX_MSI_IRQS_PER_CTRL,
> +		while ((pos = find_next_bit(&val, MAX_MSI_IRQS_PER_CTRL,
>  					    pos)) != MAX_MSI_IRQS_PER_CTRL) {
>  			irq = irq_find_mapping(pp->irq_domain,
>  					       (i * MAX_MSI_IRQS_PER_CTRL) +
> -- 
> 2.21.0
> 
