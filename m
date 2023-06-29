Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8989F742DF7
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jun 2023 22:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjF2T6I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jun 2023 15:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjF2T6A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jun 2023 15:58:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB6130DF;
        Thu, 29 Jun 2023 12:57:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD8926162A;
        Thu, 29 Jun 2023 19:57:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF6EC433C8;
        Thu, 29 Jun 2023 19:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688068667;
        bh=u3ttCy42n8pxBa9jK9GPeMUVp+0ORmLRpU2eoQyiC5s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=f2dTVbDqaMBpoBp3OG84hq733t7zmYuiDLY0AEf1RftC6JFtQoGURapOKVtK7BC3y
         OAUXpWIrHGc7XSKVTELonOVDNwdLq5WlxNaJJek+A0JWih+iq9rvNZ1wdHLJ3V5R1h
         gxJ41hbDWTcEu0A7Zfa8xK33wJVAOXDOmR3s/62aVPwIcp9trkknMpi+SvbFrX9Kau
         Oug90wBpwcDC2dR5PuUu9MFBaPJf+34jWL9bWnpF3X0cPDB9J3YnNA7MWx0WDwK+8o
         szoHt9SvUXum6SizdaC/O3ypYRRI7jN8Z2Bw95JZwOT1MIkmwabMrooAtcynGAHlt7
         xZwxhd5J6OWAQ==
Date:   Thu, 29 Jun 2023 14:57:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Radu Rendec <rrendec@redhat.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: dwc: Use regular interrupt instead of chained
Message-ID: <20230629195745.GA444039@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629183019.1992819-2-rrendec@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 29, 2023 at 02:30:19PM -0400, Radu Rendec wrote:
> The DesignWare PCIe host driver uses a chained interrupt to demultiplex
> the downstream MSI interrupts. On Qualcomm SA8540P Ride, enabling both
> pcie2a and pcie3a at the same time can create an interrupt storm where
> the parent interrupt fires continuously, even though reading the PCIe
> host registers doesn't identify any child MSI interrupt source. This
> effectively locks up CPU0, which spends all the time servicing these
> interrupts.
> 
> This is a clear example of how bypassing the interrupt core by using
> chained interrupts can be very dangerous if the hardware misbehaves.
> 
> Convert the driver to use a regular interrupt for the demultiplex
> handler. This allows the interrupt storm detector to detect the faulty
> interrupt and disable it, allowing the system to run normally.

There are many other users of irq_set_chained_handler_and_data() in
drivers/pci/controller/.  Should they be similarly converted?  If not,
how do we decide which need to use irq_set_chained_handler_and_data()
and which do not?

> Signed-off-by: Radu Rendec <rrendec@redhat.com>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 35 +++++++++----------
>  1 file changed, 17 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 9952057c8819c..b603796d415d7 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -83,18 +83,9 @@ irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp)
>  	return ret;
>  }
>  
> -/* Chained MSI interrupt service routine */
> -static void dw_chained_msi_isr(struct irq_desc *desc)
> +static irqreturn_t dw_pcie_msi_isr(int irq, void *dev_id)
>  {
> -	struct irq_chip *chip = irq_desc_get_chip(desc);
> -	struct dw_pcie_rp *pp;
> -
> -	chained_irq_enter(chip, desc);
> -
> -	pp = irq_desc_get_handler_data(desc);
> -	dw_handle_msi_irq(pp);
> -
> -	chained_irq_exit(chip, desc);
> +	return dw_handle_msi_irq(dev_id);
>  }
>  
>  static void dw_pci_setup_msi_msg(struct irq_data *d, struct msi_msg *msg)
> @@ -254,20 +245,21 @@ int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
>  	return 0;
>  }
>  
> -static void dw_pcie_free_msi(struct dw_pcie_rp *pp)
> +static void __dw_pcie_free_msi(struct dw_pcie_rp *pp, u32 num_ctrls)
>  {
>  	u32 ctrl;
>  
> -	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++) {
> +	for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
>  		if (pp->msi_irq[ctrl] > 0)
> -			irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
> -							 NULL, NULL);
> +			free_irq(pp->msi_irq[ctrl], pp);
>  	}
>  
>  	irq_domain_remove(pp->msi_domain);
>  	irq_domain_remove(pp->irq_domain);
>  }
>  
> +#define dw_pcie_free_msi(pp) __dw_pcie_free_msi(pp, MAX_MSI_CTRLS)

What is the benefit of the dw_pcie_free_msi() macro?

>  static void dw_pcie_msi_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -361,9 +353,16 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>  		return ret;
>  
>  	for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
> -		if (pp->msi_irq[ctrl] > 0)
> -			irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
> -						    dw_chained_msi_isr, pp);
> +		if (pp->msi_irq[ctrl] > 0) {
> +			ret = request_irq(pp->msi_irq[ctrl], dw_pcie_msi_isr, 0,
> +					  dev_name(dev), pp);
> +			if (ret) {
> +				dev_err(dev, "Failed to request irq %d: %d\n",
> +					pp->msi_irq[ctrl], ret);
> +				__dw_pcie_free_msi(pp, ctrl);
> +				return ret;
> +			}
> +		}
>  	}
>  
>  	/*
> -- 
> 2.41.0
> 
