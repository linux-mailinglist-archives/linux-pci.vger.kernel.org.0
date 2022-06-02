Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F62D53B9FC
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 15:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbiFBNmb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 09:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbiFBNm1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 09:42:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AE620E15D;
        Thu,  2 Jun 2022 06:42:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67386617B5;
        Thu,  2 Jun 2022 13:42:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD61C385A5;
        Thu,  2 Jun 2022 13:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654177344;
        bh=/ss0pOz0sSGPpXYi8/QCoSWhJ9XGlhQ1lSXpqvNoLI8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=neR1ogYBf9o06NbPsYbT+rBopWy/WkhJ6eiWdPzuwSxjgarReX5GzWv9khYLa/3tB
         wPs3xQchlpf5g/DcwgWBeG6xe21D47PqHrdrWr/x0Iz0onVpsgZ/Ncdr+M34Aarxu5
         LoQ9SGynHjMGfoys7WQW8a8HTQtTRUqL2ClufFCHT/gnEZ7LI6Xt3cuma/5hKUK8mH
         orEGRSwZaJ1fGT98hRVnw6OkYaW4ijFIvxY7xgTK/IUJ+E+dcjEvnUHe+nQfKzJkVr
         m9uiKfovom/Vw436eG7NMgYQA1DE4qv+vVoRLTJkS8jAxeZRbz94Qdkln/XLjZtqcu
         iVE2xjvPilfig==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nwl5b-0005eP-OS; Thu, 02 Jun 2022 15:42:15 +0200
Date:   Thu, 2 Jun 2022 15:42:15 +0200
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
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v12 2/8] PCI: dwc: Correct msi_irq condition in
 dw_pcie_free_msi()
Message-ID: <Ypi+N8uUNGxsWrQN@hovoldconsulting.com>
References: <20220523181836.2019180-1-dmitry.baryshkov@linaro.org>
 <20220523181836.2019180-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523181836.2019180-3-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 23, 2022 at 09:18:30PM +0300, Dmitry Baryshkov wrote:
> The subdrivers pass -ESOMETHING if they do not want the core to touch
> MSI IRQ. dw_pcie_host_init() also checks if (msi_irq > 0) rather than
> just if (msi_irq). So let's make dw_pcie_free_msi() also check that
> msi_irq is greater than zero.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 9979302532b7..af91fe69f542 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -257,7 +257,7 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
>  
>  static void dw_pcie_free_msi(struct pcie_port *pp)
>  {
> -	if (pp->msi_irq)
> +	if (pp->msi_irq > 0)
>  		irq_set_chained_handler_and_data(pp->msi_irq, NULL, NULL);
>  
>  	irq_domain_remove(pp->msi_domain);

Looks good.

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
