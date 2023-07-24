Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4457A75EB53
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 08:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjGXGRp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 02:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjGXGRo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 02:17:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15791BE;
        Sun, 23 Jul 2023 23:17:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 646C760E8E;
        Mon, 24 Jul 2023 06:17:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E06C433C8;
        Mon, 24 Jul 2023 06:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690179462;
        bh=oEu91Uj13ngC2hlPGZmp9Z9g/jlfBj9S4viyw/aj5FM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jTG1WsUHTQVKBBCakpRfQYnPU2eZBlglYfj3mDjn6gxed2Hx+FJDRe+NMMW0G3wZE
         P1Z22+nMf1VJwZo4uycZVDG4MPzZv+HHSxkLVN6sVJr+eEo1JPO0OPKrYOlLf3M9hi
         Arnqf3noN41CqgBGmAc6sRMwphZXmHKKP2GAtDocktYPQSTp+2se8e3fzGjYhJIcHM
         cqFhwWbYK+Gn7ykxbEGd+9GUw2FWN6/XejAjFyNvx/xYQTQ9Lb2Vg40LtLwMDmd05h
         aZwqrw1Mqa1KG/kY4jnrNz50k2eZKvBCJphE8DXpfm9a5Orf54w0bMRrrwhIWxUzIe
         0JkEdX78LH90g==
Date:   Mon, 24 Jul 2023 11:47:24 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, quic_shazhuss@quicinc.com,
        quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com,
        quic_nayiluri@quicinc.com, dmitry.baryshkov@linaro.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] PCI: qcom: Add support for sa8775p SoC
Message-ID: <20230724061724.GI2370@thinkpad>
References: <1689960276-29266-1-git-send-email-quic_msarkar@quicinc.com>
 <1689960276-29266-3-git-send-email-quic_msarkar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1689960276-29266-3-git-send-email-quic_msarkar@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 21, 2023 at 10:54:33PM +0530, Mrinmay Sarkar wrote:
> Add support for sa8775p SoC that uses controller version 5.90
> reusing the 1.9.0 config.
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index cee4e40..e2f2940 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1613,6 +1613,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
>  	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
>  	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_1_9_0 },
> +	{ .compatible = "qcom,pcie-sa8775p", .data = &cfg_1_9_0},
>  	{ .compatible = "qcom,pcie-sc7280", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sc8180x", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sc8280xp", .data = &cfg_1_9_0 },
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
