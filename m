Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C393E261C
	for <lists+linux-pci@lfdr.de>; Fri,  6 Aug 2021 10:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243303AbhHFI3n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Aug 2021 04:29:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244688AbhHFI3U (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Aug 2021 04:29:20 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9EFD604DB;
        Fri,  6 Aug 2021 08:29:04 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mBvDy-003JiD-SH; Fri, 06 Aug 2021 09:29:03 +0100
MIME-Version: 1.0
Date:   Fri, 06 Aug 2021 09:29:02 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] PCI: aardvark: Check for virq mapping when processing
 INTx IRQ
In-Reply-To: <20210625090319.10220-3-pali@kernel.org>
References: <20210625090319.10220-1-pali@kernel.org>
 <20210625090319.10220-3-pali@kernel.org>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <f38ad6edfb6ee63f273a430154e1038f@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: pali@kernel.org, lorenzo.pieralisi@arm.com, thomas.petazzoni@bootlin.com, bhelgaas@google.com, robh@kernel.org, kabel@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-06-25 10:03, Pali Rohár wrote:
> It is possible that we receive spurious INTx interrupt. So add needed 
> check
> before calling generic_handle_irq() function.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Reviewed-by: Marek Behún <kabel@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  drivers/pci/controller/pci-aardvark.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c
> b/drivers/pci/controller/pci-aardvark.c
> index 36fcc077ec72..59f91fad2481 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -1226,7 +1226,11 @@ static void advk_pcie_handle_int(struct 
> advk_pcie *pcie)
>  			    PCIE_ISR1_REG);
> 
>  		virq = irq_find_mapping(pcie->irq_domain, i);
> -		generic_handle_irq(virq);
> +		if (virq)
> +			generic_handle_irq(virq);
> +		else
> +			dev_err_ratelimited(&pcie->pdev->dev, "unexpected INT%c IRQ\n",
> +					    (char)i+'A');
>  	}
>  }

Please use generic_handle_domain_irq() instead of irq_find_mapping()
and generic_handle_irq().

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
