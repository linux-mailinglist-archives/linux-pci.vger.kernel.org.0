Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73DA53BA0B
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 15:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbiFBNqF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 09:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbiFBNqE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 09:46:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61FC2997BB;
        Thu,  2 Jun 2022 06:46:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42FFD617C0;
        Thu,  2 Jun 2022 13:46:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F982C385A5;
        Thu,  2 Jun 2022 13:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654177562;
        bh=LF9ujRGQwC/PzoKQQnyQ8iS6J6qDgX/J6tvc8EW5/uc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A4H62RqOHwiVB8g7V+AQ46e1d2Gpj3CiA8OOZgzcSrZtqCHGhXyftpXVN0FB3CQLP
         1/hWSTFuNJW7mBXL6nltD4ktdRxMMfxAYz/NHVVc6elbX9BFzUaQ4r8alh3oH7zllz
         lCR9Z/ZE7EtJj+3+YGjquxrYLXqt7fRr3QgCp/P2rVmImlhBxvFHTh7hrn3HWaa7Uf
         1AIctWIVvQ9zMpD9TG74FQf6ioJwAVkfDIGyn3exjm6udEmguE9wrDEdTo2dFw4eFq
         LFi1QUiOzE2MgDzSH81wrPZhK4gXl4MqwgGOp5eXfnP11IsN31Gb5zyXmJz6dcD+pI
         C3AcLqS1Pbq5g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nwl9D-0005gM-8S; Thu, 02 Jun 2022 15:45:59 +0200
Date:   Thu, 2 Jun 2022 15:45:59 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v12 3/8] PCI: dwc: Convert msi_irq to the array
Message-ID: <Ypi/F/3XdpDo4cfY@hovoldconsulting.com>
References: <20220523181836.2019180-1-dmitry.baryshkov@linaro.org>
 <20220523181836.2019180-4-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523181836.2019180-4-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 23, 2022 at 09:18:31PM +0300, Dmitry Baryshkov wrote:
> Qualcomm version of DWC PCIe controller supports more than 32 MSI
> interrupts, but they are routed to separate interrupts in groups of 32
> vectors. To support such configuration, change the msi_irq field into an
> array. Let the DWC core handle all interrupts that were set in this
> array.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c       |  2 +-
>  drivers/pci/controller/dwc/pci-exynos.c       |  2 +-
>  .../pci/controller/dwc/pcie-designware-host.c | 30 +++++++++++--------
>  drivers/pci/controller/dwc/pcie-designware.h  |  2 +-
>  drivers/pci/controller/dwc/pcie-keembay.c     |  2 +-
>  drivers/pci/controller/dwc/pcie-spear13xx.c   |  2 +-
>  drivers/pci/controller/dwc/pcie-tegra194.c    |  2 +-
>  7 files changed, 24 insertions(+), 18 deletions(-)

> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index af91fe69f542..8dd913f69de7 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -257,8 +257,11 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
>  
>  static void dw_pcie_free_msi(struct pcie_port *pp)
>  {
> -	if (pp->msi_irq > 0)
> -		irq_set_chained_handler_and_data(pp->msi_irq, NULL, NULL);
> +	u32 ctrl;
> +
> +	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
> +		if (pp->msi_irq[ctrl] > 0)
> +			irq_set_chained_handler_and_data(pp->msi_irq[ctrl], NULL, NULL);

I'd use brackets around multline statements for readability.

>  	irq_domain_remove(pp->msi_domain);
>  	irq_domain_remove(pp->irq_domain);

> @@ -383,10 +388,11 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  			if (ret)
>  				return ret;
>  
> -			if (pp->msi_irq > 0)
> -				irq_set_chained_handler_and_data(pp->msi_irq,
> -							    dw_chained_msi_isr,
> -							    pp);
> +			for (ctrl = 0; ctrl < num_ctrls; ctrl++)
> +				if (pp->msi_irq[ctrl] > 0)
> +					irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
> +									 dw_chained_msi_isr,
> +									 pp);

Same here (even if the old code didn't use it).

>  			ret = dma_set_mask(pci->dev, DMA_BIT_MASK(32));
>  			if (ret)

Looks good otherwise.

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan
