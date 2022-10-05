Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547CF5F5925
	for <lists+linux-pci@lfdr.de>; Wed,  5 Oct 2022 19:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiJERff (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Oct 2022 13:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiJERfe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Oct 2022 13:35:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A10C7434F;
        Wed,  5 Oct 2022 10:35:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7A42616E8;
        Wed,  5 Oct 2022 17:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFBCC433C1;
        Wed,  5 Oct 2022 17:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664991331;
        bh=rJiZBFfu9nk89r7yZw0kyuFOVd/opop0/sSQNO56/74=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BT33SsLgNpZr5TKr2FSrdN+HUsRN7EJS6k7zkZNpsang3ho333H/0U3UcgLxUyqxP
         X7wnNsTWqDXrN6eWmnGw5OCGtwiauljOqQ0Zyjrm6baeZ2YUKIeMg3NjUWPc415k7T
         xEjrXzNGO+xIRP7G6cbYbmVELHj3Zp7idFnIkXwyJLLJEGZYp0RjJh3FfPlRNhOrzb
         /3uUSEqJsMcTbXWhTrNK2Q9ZDsBSA0dBkXAS4nTbjDSxMoy15zqra54eKtJ7GJZ551
         7JCKCF4DLmEbxgganUfniqUhYeGrpti4RXjhnunVrK4IyJZew7FymgmxykSV5OYSx5
         HBhNgzVpTyenQ==
Date:   Wed, 5 Oct 2022 12:35:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, robh@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] PCI: qcom-ep: Fix disabling global_irq in error path
Message-ID: <20221005173529.GA2304247@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005135852.22634-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 05, 2022 at 07:28:52PM +0530, Manivannan Sadhasivam wrote:
> After commit 6a534df3da88 ("PCI: qcom-ep: Disable IRQs during driver
> remove"), the global irq is stored in the "global_irq" member of pcie_ep
> structure. This eliminates the need of local "irq" variable but that
> commit didn't remove the "irq" variable usage completely and it is still
> used for disable_irq() in error path which is wrong since the variable is
> uninitialized.
> 
> Fix this by removing the local "irq" variable and using
> "pcie_ep->global_irq" for disable_irq() in error path.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 6a534df3da88 ("PCI: qcom-ep: Disable IRQs during driver remove")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

For today's "next" branch, I dropped 6a534df3da88 and the subsequent
patches.  Hopefully Lorenzo can squash this fix into 6a534df3da88.

I could clone the branch and squash it myself, but that's pretty
fiddly and I usually mess it up.

> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 16bb8f166c3b..00a0728d5ecd 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -614,7 +614,7 @@ static irqreturn_t qcom_pcie_ep_perst_irq_thread(int irq, void *data)
>  static int qcom_pcie_ep_enable_irq_resources(struct platform_device *pdev,
>  					     struct qcom_pcie_ep *pcie_ep)
>  {
> -	int irq, ret;
> +	int ret;
>  
>  	pcie_ep->global_irq = platform_get_irq_byname(pdev, "global");
>  	if (pcie_ep->global_irq < 0)
> @@ -637,7 +637,7 @@ static int qcom_pcie_ep_enable_irq_resources(struct platform_device *pdev,
>  					"perst_irq", pcie_ep);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to request PERST IRQ\n");
> -		disable_irq(irq);
> +		disable_irq(pcie_ep->global_irq);
>  		return ret;
>  	}
>  
> -- 
> 2.25.1
> 
