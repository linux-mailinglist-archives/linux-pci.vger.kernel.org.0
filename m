Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD4F758CBE
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 06:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjGSElh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 00:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGSElg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 00:41:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887781BE3;
        Tue, 18 Jul 2023 21:41:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17466611E2;
        Wed, 19 Jul 2023 04:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2884C433C8;
        Wed, 19 Jul 2023 04:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689741694;
        bh=lr4OuWdXDfDpuuaDYFHyPIgOa5g8cvbNddizBTZ+c0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bhw0lYeKczyAVl6k1k8k+230Fa9lCib9h478pVpVVFby1C28bTUe+5EROLWv2PFZf
         9N+SVzTxyd5tLXmzPJwhzmR2P3cn+34Wi5AcrttH27NOuYLG+21hex87GBwTSYUFn3
         CXip5zYYdycJZ7D7DhipNMgf+9gUvIOKx+7qQq8wqKyUjwSWKc90R5Q+B8f0pKAFOI
         k3Y/9v1cvNiGnMmlYN7Li3DbU97CMSDsJV0mRMWvvEfHTpcSQRxQ028rFAvU9qbo+U
         e6+o1MznFK2b1PF4S1efA4VmGuxxunPezTeVzjH/8Qwwi/DzTTCnUlD7287eJMplZL
         1C3WTTrk+EhqA==
Date:   Wed, 19 Jul 2023 10:11:18 +0530
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
Subject: Re: [PATCH v9 3/4] arm: dts: qcom: sdx55: Add CPU PCIe interconnect
 path
Message-ID: <20230719044118.GC5990@thinkpad>
References: <1689693645-28254-1-git-send-email-quic_krichai@quicinc.com>
 <1689693645-28254-4-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1689693645-28254-4-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 18, 2023 at 08:50:44PM +0530, Krishna chaitanya chundru wrote:
> Add cpu-pcie interconnect path to sdx65 platform.

sdx55 and please mention "PCIe RC". Perhaps you should also add "missing"?

- Mani

> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
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
