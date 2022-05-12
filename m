Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBE5525520
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 20:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357754AbiELSsW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 14:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357788AbiELSsU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 14:48:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F5E1756B6;
        Thu, 12 May 2022 11:48:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3C3161B65;
        Thu, 12 May 2022 18:48:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70646C385B8;
        Thu, 12 May 2022 18:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652381298;
        bh=1TlrlHB4aaOgWZa9mSfCmfQlvfeKx2rv8szLiBiWlkM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dXgtfhahrA28Qaqmcrp6B4ZMiqMxj2x1AA98remT8c/G65Fj/p0tml3qEhfJTiZgQ
         IZF6lxgcT5Sm56hSnnM4zunaPJ8yo/r8D//43nQl6RVazKW/OJ7VOaQsEc1Z9U2sCE
         JC8/3U0elfbwzSKKeUwEEr67p69cx9eONce3QEvGnwcNnLyc7o79dN3SOgfdUDuV0a
         5sN+4L/LzrJGSyAUEkjRjY+aBrrwFDE8tCeQjYIrQAVrCpGmv9Y2by832Rgi8AGakg
         MPI1TaQbJw/dBMGMYkR0Ge9Y2s13dBvI9WRQ+biLdQmhWiBdsk18z8HYdvTXPK+gfL
         RiDMFwhCb4Kcw==
Date:   Thu, 12 May 2022 13:48:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v8 01/10] PCI: qcom: Revert "PCI: qcom: Add support for
 handling MSIs from 8 endpoints"
Message-ID: <20220512184814.GA859760@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512104545.2204523-2-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 12, 2022 at 01:45:36PM +0300, Dmitry Baryshkov wrote:
> I have replied with my Tested-by to the patch at [2], which has landed
> in the linux-next as the commit 20f1bfb8dd62 ("PCI: qcom:
> Add support for handling MSIs from 8 endpoints"). However lately I
> noticed that during the tests I still had 'pcie_pme=nomsi', so the
> device was not forced to use higher MSI vectors.
> 
> After removing this option I noticed that high MSI vectors are not
> delivered on tested platforms. Additional research pointed to
> a patch in msm-4.14 ([1]), which describes that each group of MSI
> vectors is mapped to the separate interrupt.
> 
> Without these changes specifying num_vectors can lead to missing MSI
> interrupts and thus to devices malfunction.
> 
> Fixes: 20f1bfb8dd62 ("PCI: qcom: Add support for handling MSIs from 8 endpoints")

Hopefully Lorenzo will drop both 20f1bfb8dd62 and this patch if/when
he applies this series.

This commit log would need some rework because [1] and [2] are
mentioned in the cover letter, but that doesn't get included when the
series is applied.  Best if we can just avoid all this confusion by
dropping 20f1bfb8dd62 and this patch.

> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index f9a61ad6d1f0..2e5464edc36e 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1587,7 +1587,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	pci->dev = dev;
>  	pci->ops = &dw_pcie_ops;
>  	pp = &pci->pp;
> -	pp->num_vectors = MAX_MSI_IRQS;
>  
>  	pcie->pci = pci;
>  
> -- 
> 2.35.1
> 
