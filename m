Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8847EEE1E
	for <lists+linux-pci@lfdr.de>; Fri, 17 Nov 2023 10:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjKQJG4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Nov 2023 04:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbjKQJGz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Nov 2023 04:06:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB0211F;
        Fri, 17 Nov 2023 01:06:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F80DC433C8;
        Fri, 17 Nov 2023 09:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700212012;
        bh=T2mILB6OLuIKTcfZr2BT0zwlCFYVwcwy0W1B4jyIbBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ph8JTNUwYgHtIXJfkfXPfLie5d2K5Wq7VgxuXrBZHlXit6KamtJbUtOoX5xMiPa8A
         WUCPHw0FLlH3j9CX/vgJ0uRohjNxLdFFxSGyDhtENnG9sBVOFPm43vcBFvbG7vg906
         dzRvI4DM9urmNNRj8LcfFjxtK3QS1gOYduKIgsi9zbWQv2bVMGtRqIt/tmLQaSGu9p
         a3JFTg6j8ArUTbhERl+jSspESFJ9ii/zQmyBECMLfRy5x+JUlYNZWVY3R++zwMP7qk
         /0aXsEY+KOV1XzaN+8F8S2DXZVPP6IyhZK26tvXj29oTozCor0sD7ocf5KCzN8nOg3
         jgUt9gI0Rabrw==
Date:   Fri, 17 Nov 2023 14:36:40 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org, robh@kernel.org,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_parass@quicinc.com, quic_schintav@quicinc.com,
        quic_shijjose@quicinc.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: sa8775p: Mark PCIe controller
 as cache coherent
Message-ID: <20231117090640.GB250770@thinkpad>
References: <1700051821-1087-1-git-send-email-quic_msarkar@quicinc.com>
 <1700051821-1087-4-git-send-email-quic_msarkar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1700051821-1087-4-git-send-email-quic_msarkar@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 15, 2023 at 06:07:01PM +0530, Mrinmay Sarkar wrote:
> The PCIe controller on SA8775P supports cache coherency, hence add the

"PCIe RC controller" both in subject and description.

> "dma-coherent" property to mark it as such.
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>

With that,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index 7eab458..ab01efe 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -3620,6 +3620,7 @@
>  				<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_0 0>;
>  		interconnect-names = "pcie-mem", "cpu-pcie";
>  
> +		dma-coherent;
>  		iommus = <&pcie_smmu 0x0000 0x7f>;
>  		resets = <&gcc GCC_PCIE_0_BCR>;
>  		reset-names = "core";
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
