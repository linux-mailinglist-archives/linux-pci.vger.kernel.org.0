Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BF466AF62
	for <lists+linux-pci@lfdr.de>; Sun, 15 Jan 2023 05:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjAOEao (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Jan 2023 23:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjAOEag (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Jan 2023 23:30:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886EE4C07;
        Sat, 14 Jan 2023 20:30:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22CF260C48;
        Sun, 15 Jan 2023 04:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB22DC433D2;
        Sun, 15 Jan 2023 04:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673757033;
        bh=Dz/F242wNTKegzCcck2eierz0HsyObM/7nUIUe/bhYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gs6ulnOwVMI6zD6Qx6a5QXyBPMtlEhVAd5ZF++P1Wu+U8O0shpMd2AC6T33EkfD24
         r4wVXQlhWLWvaB8x8lM8h/FPhQANaMsO+GqCF7+4HT/CBYQe7D2a9wK6Kjl8LiLmve
         Sowk02Mt1mVxW8T1Rf6tVNsJm8UqObCVpwfnVx0wHW6gHEuWaS1/boMn3LWa+m9TsI
         OG2VNElhC2OBfK7SllAY/55NRzE3nQ55/clIlsEjA9YtTykRmP5fJaz4Lb81mmgsEM
         idweo8vQmUTEuiKZQOhoHhVv+dPwL9ix6Ubl6LD8rb/+lB+HRQR1wEHyFBBvZg60sB
         gjGo8K3/Acy3g==
Date:   Sun, 15 Jan 2023 10:00:24 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lpieralisi@kernel.org,
        kw@linux.com, svarbanov@mm-sol.com, shawn.guo@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] PCI: qcom: add support for IPQ8074 Gen3 port
Message-ID: <20230115043024.GL6568@thinkpad>
References: <20221116214841.1116735-1-robimarko@gmail.com>
 <20221116214841.1116735-7-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221116214841.1116735-7-robimarko@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16, 2022 at 10:48:39PM +0100, Robert Marko wrote:
> IPQ8074 has one Gen2 and one Gen3 port, with Gen2 port already supported.
> Add compatible for Gen3 port which uses the same controller as IPQ6018.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 77e5dc7b88ad..97e8510c53fb 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1817,6 +1817,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-ipq8064", .data = &cfg_2_1_0 },
>  	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
>  	{ .compatible = "qcom,pcie-ipq8074", .data = &cfg_2_3_3 },
> +	{ .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
>  	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
>  	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
>  	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_1_9_0 },
> -- 
> 2.38.1
> 

-- 
மணிவண்ணன் சதாசிவம்
