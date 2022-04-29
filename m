Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28C15157E0
	for <lists+linux-pci@lfdr.de>; Sat, 30 Apr 2022 00:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358343AbiD2WKZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 18:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348757AbiD2WKX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 18:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36FAD080D;
        Fri, 29 Apr 2022 15:07:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BFF662247;
        Fri, 29 Apr 2022 22:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FD9C385A4;
        Fri, 29 Apr 2022 22:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651270022;
        bh=8xHzk89/28KxKOd9SWHEJFkmLSdBWuB+K18qV4FdOQ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BQvHeQUntHQ/5G/TOgsfZwLGfu8PVerEvQFyKreUqqdlthMsA/TcqxEWHkBFVQ4em
         qLsy0ts7f6HDd0MdgAkHBlmauBRxT/AOBujC9jB2cnCkIj0/GKclP4OJUMySCBjVT9
         YU9QaqX0PA+M8Nv2YGUYtuAUwCtsJC94CFA20UysdJFOscehgljoBZC5Bsaa80/oPv
         wqhgi7M8NzIQbNbP1wWcJcZGU0jlzJGGs+H/jevowT3xqGKq2m1phzq+jlJbU8YDO7
         wEBYnA0M+Uu0Gyno0TXXzgpThieOZMfuyguW8asN0g3Exj9grCH6g47Oor289cdkSc
         1K5IZjj8ouHVw==
Date:   Fri, 29 Apr 2022 17:07:00 -0500
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
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/7] PCI: qcom: Revert "PCI: qcom: Add support for
 handling MSIs from 8 endpoints"
Message-ID: <20220429220700.GA110578@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429214250.3728510-2-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 30, 2022 at 12:42:44AM +0300, Dmitry Baryshkov wrote:
> I have replied with my Tested-by to the patch at [2], which has landed
> in the linux-next as the commit 20f1bfb8dd62 ("PCI: qcom:
> Add support for handling MSIs from 8 endpoints"). However lately I
> noticed that during the tests I still had 'pcie_pme=nomsi', so the
> device was not forced to use higher MSI vectors.
> 
> After removing this option I noticed that hight MSI vectors are not
> delivered on tested platforms. Additional research pointed to
> a patch in msm-4.14 ([1]), which describes that each group of MSI
> vectors is mapped to the separate interrupt.
> 
> Without these changes specifying num_verctors can lead to missing MSI
> interrupts and thus to devices malfunction.
> 
> Fixes: 20f1bfb8dd62 ("PCI: qcom: Add support for handling MSIs from 8 endpoints")

20f1bfb8dd62 hasn't been merged upstream yet, so I think Lorenzo can
just drop it from his pci/qcom branch so we don't need to clutter the
git history with the revert.

> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index c940e67d831c..375f27ab9403 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1593,7 +1593,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
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
