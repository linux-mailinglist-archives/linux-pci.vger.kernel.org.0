Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8FC1ECE15
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jun 2020 13:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgFCLPG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 07:15:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgFCLPG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jun 2020 07:15:06 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 885C02067B;
        Wed,  3 Jun 2020 11:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591182905;
        bh=DIzdZtES3weee8kFjADfjxp0jxzg8+EHuNSTFll5o64=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dHtLL2bjjmWlybWqZVA7JugSObOSlVQlMOrxeXn8QK/b8Ox/RqzeafeE5m5ch1Izs
         Tz1D7UKIVGzJUyx6siommZjcz7WJlmZrcScBIPFjDjjWJANJMLTnAV9K+k1W5XgjN2
         DRGRpfciWQDzfqPiZ5dCG1Z2jQ8NYtIkuq4PJjPo=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jgRMO-00HQQ8-22; Wed, 03 Jun 2020 12:15:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 03 Jun 2020 12:15:04 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH v3 1/6] PCI: dwc: Add msi_host_isr() callback
In-Reply-To: <1591174481-13975-2-git-send-email-hayashi.kunihiko@socionext.com>
References: <1591174481-13975-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1591174481-13975-2-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <95bb3ffbfab4923854e20266c6b0b098@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: hayashi.kunihiko@socionext.com, bhelgaas@google.com, lorenzo.pieralisi@arm.com, jingoohan1@gmail.com, gustavo.pimentel@synopsys.com, robh+dt@kernel.org, yamada.masahiro@socionext.com, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-06-03 09:54, Kunihiko Hayashi wrote:
> This adds msi_host_isr() callback function support to describe
> SoC-dependent service triggered by MSI.
> 
> For example, when AER interrupt is triggered by MSI, the callback 
> function
> reads SoC-dependent registers and detects that the interrupt is from 
> AER,
> and invoke AER interrupts related to MSI.
> 
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 8 ++++----
>  drivers/pci/controller/dwc/pcie-designware.h      | 1 +
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
> b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 0a4a5aa..9b628a2 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -112,13 +112,13 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port 
> *pp)
>  static void dw_chained_msi_isr(struct irq_desc *desc)
>  {
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
> -	struct pcie_port *pp;
> +	struct pcie_port *pp = irq_desc_get_handler_data(desc);
> 
> -	chained_irq_enter(chip, desc);
> +	if (pp->ops->msi_host_isr)
> +		pp->ops->msi_host_isr(pp);

Why is this call outside of the enter/exit guards?
Do you still need to execute the standard handler?

> 
> -	pp = irq_desc_get_handler_data(desc);
> +	chained_irq_enter(chip, desc);
>  	dw_handle_msi_irq(pp);
> -
>  	chained_irq_exit(chip, desc);
>  }
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h
> b/drivers/pci/controller/dwc/pcie-designware.h
> index 656e00f..e741967 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -170,6 +170,7 @@ struct dw_pcie_host_ops {
>  	void (*scan_bus)(struct pcie_port *pp);
>  	void (*set_num_vectors)(struct pcie_port *pp);
>  	int (*msi_host_init)(struct pcie_port *pp);
> +	void (*msi_host_isr)(struct pcie_port *pp);
>  };
> 
>  struct pcie_port {

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
