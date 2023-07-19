Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBED6758F55
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 09:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjGSHmj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 03:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjGSHmI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 03:42:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573AB2685;
        Wed, 19 Jul 2023 00:41:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D831D612FD;
        Wed, 19 Jul 2023 07:41:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD33C433C8;
        Wed, 19 Jul 2023 07:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689752472;
        bh=b8GEqB/2sTmMlL5y18FKSNhfxtcA7qKBejTmK0tI0EI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O+YN10JPskc9ztReEFlJnjB72I1SIq5vKeTpSeV2hXjlFdrIp1fDy/b/q6uNV/WWD
         QV1ujwc4umRfGoa6ZtU0Vp0Fbg9J2WvAi+WmdBIjYNufejEqOb7rEbLNBvw555cSqu
         y+xjx4VrK7j8AZSkyro8k7IHin5y6ZreGREDgqvE8kp9v2Y9/Pdf+P21R4Qqm8tNtt
         JhF/1YksfB4xnxrlx3VHVCDfcF8xNYd7pwHkSzC+PJCIZpytBhS2gQzefvdmjhMSKs
         VZwsGVFwYFbJMoYpNtLMf3hXoB6knBJgLTdu34QSeJWv2I+y1ThAuZBQFWBYK+nbWr
         zBvNXXyteGLrg==
Date:   Wed, 19 Jul 2023 13:10:55 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     manivannan.sadhasivam@linaro.org, helgaas@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, krzysztof.kozlowski@linaro.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v10 3/4] arm: dts: qcom: sdx55: Add CPU PCIe EP
 interconnect path
Message-ID: <20230719074055.GB9312@thinkpad>
References: <1689751218-24492-1-git-send-email-quic_krichai@quicinc.com>
 <1689751218-24492-4-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1689751218-24492-4-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 19, 2023 at 12:50:17PM +0530, Krishna chaitanya chundru wrote:
> Add cpu-pcie interconnect path for PCIe EP to sdx55 platform.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  arch/arm/boot/dts/qcom/qcom-sdx55.dtsi | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
> index df3cd9c..a7c0c26 100644
> --- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
> +++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
> @@ -422,8 +422,9 @@
>  			interrupt-names = "global",
>  					  "doorbell";
>  
> -			interconnects = <&system_noc MASTER_PCIE &mc_virt SLAVE_EBI_CH0>;
> -			interconnect-names = "pcie-mem";
> +			interconnects = <&system_noc MASTER_PCIE &mc_virt SLAVE_EBI_CH0>,
> +					<&mem_noc MASTER_AMPSS_M0 &system_noc SLAVE_PCIE_0>;
> +			interconnect-names = "pcie-mem", "cpu-pcie";
>  
>  			resets = <&gcc GCC_PCIE_BCR>;
>  			reset-names = "core";
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
