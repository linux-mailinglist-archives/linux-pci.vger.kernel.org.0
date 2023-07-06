Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC97749EC4
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jul 2023 16:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbjGFOPw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jul 2023 10:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjGFOPv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jul 2023 10:15:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0EADD;
        Thu,  6 Jul 2023 07:15:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 488A16194B;
        Thu,  6 Jul 2023 14:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A28FC433C8;
        Thu,  6 Jul 2023 14:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688652949;
        bh=4TOSiu4hNpYajoZSKm9yhp7UOHi9Xa2Fplej3+VGsCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F5RI3wNhh1kj0hhsMoOehx785a+f6f7CgmN4Oj454kC3bOLMiZKYC0M/SPOZ6LlQ5
         rYBBp2fsT38UkPjYQsm+Rmgt/Zyj41nwJAx8kuKyLRNxwMT4zc9Tyh7AihS1ujsHlj
         ESEUN4ge+qJJbLSTwd3/z9njVPufNdLwLgpOB9j9cUvhTH6z/xG5/yMfQWBI4mL1O7
         UOctLRh9g4mJgMHefgj9r6ItOwR9tyT9xFPQ7aCwhDOyYvRYw/5CXMTyiSp+Sw1ika
         T/4xOzQDP/taokHXqYBGM1MSWpsmqRIamU9svDRQI33JJfMPSUH/DP2o7SqS9wciZI
         Ut+JbP6/hLllg==
Date:   Thu, 6 Jul 2023 19:45:36 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com,
        kw@linux.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH V3] PCI: qcom: Fix broken pcie bring up for 2_3_3 configs
 ops
Message-ID: <20230706141536.GA18220@thinkpad>
References: <20230706121537.3129617-1-quic_srichara@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230706121537.3129617-1-quic_srichara@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 06, 2023 at 05:45:37PM +0530, Sricharan Ramabadhran wrote:
> PARF_SLV_ADDR_SPACE_SIZE_2_3_3 macro is used for IPQ8074
> 2_3_3 post_init ops. PCIe slave addr size was initially set
> to 0x358, but was wrongly changed to 0x168 as a part of
> 

nit: no need of newline here.

> commit 39171b33f652 ("PCI: qcom: Remove PCIE20_ prefix from
> register definitions"). Fixing it, by using the right macro
> PARF_SLV_ADDR_SPACE_SIZE and removing the unused
> PARF_SLV_ADDR_SPACE_SIZE_2_3_3.
> 

As said in last iteration, commit message should be in imperative mood ie.,
s/Fixing/Fix and s/removing/remove.

> Without this pcie bring up on IPQ8074 is broken now.
> 
> Fixes: 39171b33f652 ("PCI: qcom: Remove PCIE20_ prefix from register definitions")
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>

With above changes,

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

> ---
>  [v3] Added reviewed-by tag, fixed subject, commit text
> 

Please keep full changelog.

- Mani

>  drivers/pci/controller/dwc/pcie-qcom.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 4ab30892f6ef..8418894b3de7 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -43,7 +43,6 @@
>  #define PARF_PHY_REFCLK				0x4c
>  #define PARF_CONFIG_BITS			0x50
>  #define PARF_DBI_BASE_ADDR			0x168
> -#define PARF_SLV_ADDR_SPACE_SIZE_2_3_3		0x16c /* Register offset specific to IP ver 2.3.3 */
>  #define PARF_MHI_CLOCK_RESET_CTRL		0x174
>  #define PARF_AXI_MSTR_WR_ADDR_HALT		0x178
>  #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
> @@ -810,8 +809,7 @@ static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
>  	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>  	u32 val;
>  
> -	writel(SLV_ADDR_SPACE_SZ,
> -		pcie->parf + PARF_SLV_ADDR_SPACE_SIZE_2_3_3);
> +	writel(SLV_ADDR_SPACE_SZ, pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
>  
>  	val = readl(pcie->parf + PARF_PHY_CTRL);
>  	val &= ~PHY_TEST_PWR_DOWN;
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
