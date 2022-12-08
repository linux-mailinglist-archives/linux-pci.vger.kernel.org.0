Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BE96474AF
	for <lists+linux-pci@lfdr.de>; Thu,  8 Dec 2022 17:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiLHQwV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Dec 2022 11:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLHQwU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Dec 2022 11:52:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55942AFCE7;
        Thu,  8 Dec 2022 08:52:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 064F6B82564;
        Thu,  8 Dec 2022 16:52:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D4FC433D2;
        Thu,  8 Dec 2022 16:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670518334;
        bh=4WrMdYITldKP0ThbWmM1u/RmubvIhmMNNr2z8jJN90E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QqralZ40WP+rgs/esX6RanE0XO06VcT6eO5n8fU9AcAmrKv/mQQi5RxN8oBFDc3qb
         NdChANi2TyKOr96fVFkEUY5Poe4LL3wBnZQ6vMO5jhWmfdvYU9B21redw52GUbi2ya
         3RHQa9FtUA/2bgCIcO/UkiGXCqlQjU8AyWySJc4qP/gOb3WE4i56FjE316zUG6ipsk
         AxmUQ8w10V9loYNa0h4IXkfM2H3gIQ2wGI35VyRd2xggnB0awkBVvm+nXnN5Sa3bbk
         zl5d8G5nkvl14CIVuTXnegHx0qT/iCoYokXz8M19ND1cwDxnDpQy32gipG8XMY+huv
         wpLpaelk4GfsQ==
Date:   Thu, 8 Dec 2022 10:52:13 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: xilinx-nwl: Fix coding style violations
Message-ID: <20221208165213.GA1548600@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17c75e7003bb8c43a0f45ae3d7c45cac230ef852.1670503129.git.michal.simek@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 08, 2022 at 01:38:50PM +0100, Michal Simek wrote:
> Fix code alignments and remove additional newline.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Since we're up against the merge window, I applied this directly to
pci/ctrl/xilinx for v6.2, thanks!

> ---
>  drivers/pci/controller/pcie-xilinx-nwl.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
> index 40d070e54ad2..e10a58649bf5 100644
> --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> @@ -474,15 +474,15 @@ static int nwl_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>  
>  	for (i = 0; i < nr_irqs; i++) {
>  		irq_domain_set_info(domain, virq + i, bit + i, &nwl_irq_chip,
> -				domain->host_data, handle_simple_irq,
> -				NULL, NULL);
> +				    domain->host_data, handle_simple_irq,
> +				    NULL, NULL);
>  	}
>  	mutex_unlock(&msi->lock);
>  	return 0;
>  }
>  
>  static void nwl_irq_domain_free(struct irq_domain *domain, unsigned int virq,
> -					unsigned int nr_irqs)
> +				unsigned int nr_irqs)
>  {
>  	struct irq_data *data = irq_domain_get_irq_data(domain, virq);
>  	struct nwl_pcie *pcie = irq_data_get_irq_chip_data(data);
> @@ -722,7 +722,6 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
>  	/* Enable all misc interrupts */
>  	nwl_bridge_writel(pcie, MSGF_MISC_SR_MASKALL, MSGF_MISC_MASK);
>  
> -
>  	/* Disable all legacy interrupts */
>  	nwl_bridge_writel(pcie, (u32)~MSGF_LEG_SR_MASKALL, MSGF_LEG_MASK);
>  
> -- 
> 2.36.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
