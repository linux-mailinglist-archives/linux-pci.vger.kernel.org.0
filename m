Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13C7E670FE
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2019 16:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfGLOHy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Jul 2019 10:07:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfGLOHy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Jul 2019 10:07:54 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF3AD206B8;
        Fri, 12 Jul 2019 14:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562940474;
        bh=WI9/V+ZKiQt8N2ZXkmgG410vHGUKy60lwdIntaFOAvM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TaocqWa1LwZBshmqZLXcMcYGa1EH4XaJ9rHBAhR7BVJQOgIPhYR1uzHx6a9n2gSXM
         YMHHF/5/LwZuwvr3bem/r0KGFycDEmgMEeNUNU8SBwaUEijIlmO1PrVhHwzlerwfZR
         JxuzHn4UsVkNUl9Ti/RDV8bPf2Vnb9IymrMNyByA=
Date:   Fri, 12 Jul 2019 09:07:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, patchwork-lst@pengutronix.de,
        kernel@pengutronix.de
Subject: Re: [PATCH] PCI: dwc: avoid OOB read in find_next_bit
Message-ID: <20190712140752.GE46935@google.com>
References: <20190712132611.3374-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712132611.3374-1-l.stach@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 12, 2019 at 03:26:11PM +0200, Lucas Stach wrote:
> Find_next_bit works on a long type, which causes a OOB read on the
> u32 input when used on ARM64.

s/Find_next_bit/find_next_bit()/ so it's obviously a function name and
we can directly grep for it (in subject also, and capitalize "Avoid").

Please spell out "OOB"; I *assume* that means "out of bounds"?

> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 77db32529319..81a2139d68d6 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -78,15 +78,16 @@ static struct msi_domain_info dw_pcie_msi_domain_info = {
>  irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>  {
>  	int i, pos, irq;
> -	u32 val, num_ctrls;
> +	u32 num_ctrls;
>  	irqreturn_t ret = IRQ_NONE;
> +	unsigned long val;
>  
>  	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
>  
>  	for (i = 0; i < num_ctrls; i++) {
>  		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_STATUS +
>  					(i * MSI_REG_CTRL_BLOCK_SIZE),
> -				    4, &val);
> +				    4, (u32 *)&val);

I agree that the "val" we pass to find_next_bit() needs to be an
"unsigned long", so I like that part.

It's not completely obvious to me that it's safe to cast "val" to
"u32 *" here; does that do the right thing regardless of byte order?

Doing something like:

  u32 status;
  unsigned long val;

  dw_pcie_rd_own_conf(..., &status);

  val = status;
  find_next_bit(&val, ...);

would be more obvious to me.

>  		if (!val)
>  			continue;
>  
> -- 
> 2.20.1
> 
