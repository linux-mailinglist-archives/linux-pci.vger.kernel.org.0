Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C00C70B829
	for <lists+linux-pci@lfdr.de>; Mon, 22 May 2023 10:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjEVI53 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 May 2023 04:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbjEVI4w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 May 2023 04:56:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFBF196;
        Mon, 22 May 2023 01:56:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40708611A9;
        Mon, 22 May 2023 08:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66729C4339B;
        Mon, 22 May 2023 08:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684745787;
        bh=LN/rjbcvhhidlr7lNhdnVlcRMhOuBdd16O7dwepf3xY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f0kh7xX0HJit3/nP7bCLGauFMhd+TSb2IUwM7Z4PoyXJF0KQPZ0U97x78v9PClSII
         84pD7O/g0AkV5dEK8mMD1LcobSya6NmnGi2csAFa81atYZjBzGrKLMki7VXImbL76U
         0598zdUQZcn36+zIU2lhMXLkV1R8TztMPliLgp5RxyUPoiHC91Xs5IZoJR94oahe/B
         s1pE/04nhGAhabRVsBN9hPyY2N+bSPtUVP3lyNqv9spgp3Vxkaci/kgcz+HfV37a2c
         oUP2+rlqiuoTWNH57YEsKWsLe0m+kVoufYbWnsi041bVWfFV6jdMWeKQyHLArwYOFW
         8mFGxa/Zfp1LA==
Date:   Mon, 22 May 2023 10:56:19 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     kw@linux.com, bhelgaas@google.com, robh@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com, dmitry.baryshkov@linaro.org,
        Dmitry Baryshkov <dmitry.baryshkov@gmail.com>
Subject: Re: [PATCH v2 2/8] PCI: qcom: Disable write access to read only
 registers for IP v2.9.0
Message-ID: <ZGsuM8CAv7AtluVx@lpieralisi>
References: <20230519143117.23875-1-manivannan.sadhasivam@linaro.org>
 <20230519143117.23875-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519143117.23875-3-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 19, 2023 at 08:01:11PM +0530, Manivannan Sadhasivam wrote:
> In the post init sequence of v2.9.0, write access to read only registers
> are not disabled after updating the registers. Fix it by disabling the
> access after register update.
> 
> Fixes: 0cf7c2efe8ac ("PCI: qcom: Add IPQ60xx support")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@gmail.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 01795ee7ce45..391a45d1e70a 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1136,6 +1136,7 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
>  	writel(0, pcie->parf + PARF_Q2A_FLUSH);
>  
>  	dw_pcie_dbi_ro_wr_en(pci);
> +

Nit: spurious change.

Lorenzo

>  	writel(PCIE_CAP_SLOT_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
>  
>  	val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
> @@ -1145,6 +1146,8 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
>  	writel(PCI_EXP_DEVCTL2_COMP_TMOUT_DIS, pci->dbi_base + offset +
>  			PCI_EXP_DEVCTL2);
>  
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +
>  	for (i = 0; i < 256; i++)
>  		writel(0, pcie->parf + PARF_BDF_TO_SID_TABLE_N + (4 * i));
>  
> -- 
> 2.25.1
> 
