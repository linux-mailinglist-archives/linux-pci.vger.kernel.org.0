Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CB552B406
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 09:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbiERHl5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 03:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbiERHls (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 03:41:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4348119044;
        Wed, 18 May 2022 00:41:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80F19B81EB5;
        Wed, 18 May 2022 07:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FEEC385A5;
        Wed, 18 May 2022 07:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652859704;
        bh=c8iCGLcUXxaDvWrWbaDeBrz2DTTuP5qpnM6pAeQ+3lk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PtXjKC8XfuQRXmP+M6fdOh/y+Q1nW1wIE9Dt9dEoc7abiJAq8NpqnGLKWzDVuewb1
         qafu/ZYLTIbj4fAZbohs1EIqjv3x6DR0JgZdaJra7wheSkdenhaZqZmrhB9kJ6bGTS
         inPoWqRB+xCSqK25pFlwicCCArbsktcT4dvoG/OPEtB5qi/T/KhtwS3nvFaNavyuFv
         p0vyCqiQP4qhBA7p2k5e8hQz+fAAb3qm27/cBaeDsF61s2D1G0c9WbomkYrQURV+RU
         ulG1vnKYS/C6G6NOyIdMdedjOjRUTI0qvpK3RsKevz1wjiYlNToiKvvDvSCptdGv1D
         ddudoPM7EmlSQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nrEJU-0004HN-MB; Wed, 18 May 2022 09:41:44 +0200
Date:   Wed, 18 May 2022 09:41:44 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 5/5] PCI: qcom: Drop manual pipe_clk_src handling
Message-ID: <YoSjOHL3YmMyYCNa@hovoldconsulting.com>
References: <20220513175339.2981959-1-dmitry.baryshkov@linaro.org>
 <20220513175339.2981959-6-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513175339.2981959-6-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 13, 2022 at 08:53:39PM +0300, Dmitry Baryshkov wrote:
> Manual reparenting of pipe_clk_src is being replaced with the parking of
> the clock with clk_disable()/clk_enable() in the phy driver. Drop
> redundant code switching of the pipe clock between the PHY clock source
> and the safe bi_tcxo.

Thanks for updating the commit message.

> Cc: Prasad Malisetty <quic_pmaliset@quicinc.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 39 +-------------------------
>  1 file changed, 1 insertion(+), 38 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index a6becafb6a77..b48c899bcc97 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c

> @@ -1496,14 +1461,12 @@ static const struct qcom_pcie_cfg sm8450_pcie0_cfg = {
>  static const struct qcom_pcie_cfg sm8450_pcie1_cfg = {
>  	.ops = &ops_1_9_0,
>  	.has_ddrss_sf_tbu_clk = true,
> -	.pipe_clk_need_muxing = true,
>  	.has_aggre1_clk = true,
>  };
>  
>  static const struct qcom_pcie_cfg sc7280_cfg = {
>  	.ops = &ops_1_9_0,
>  	.has_tbu_clk = true,
> -	.pipe_clk_need_muxing = true,
>  };
>  
>  static const struct dw_pcie_ops dw_pcie_ops = {

Note that this hunk fails to apply due to commit 134b5ce3ed33 ("PCI:
qcom: Remove ddrss_sf_tbu clock from SC8180X").

Fixing it up is trivial but still.

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>

Johan
