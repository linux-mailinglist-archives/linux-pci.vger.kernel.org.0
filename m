Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6989E748001
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jul 2023 10:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjGEIpK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jul 2023 04:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbjGEIpJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jul 2023 04:45:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE9D19B;
        Wed,  5 Jul 2023 01:45:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DBEE61493;
        Wed,  5 Jul 2023 08:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC539C433C8;
        Wed,  5 Jul 2023 08:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688546708;
        bh=3I2hTeaGJBO9WRbnJZs9CjQRSwxF5Et8HWH3vhQF2R4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IyyzxTzpjRQ99S07jHM4YvYSM5O+NPQ8VPIwVeygMXzycK5oiHL7YKk34upTe6Qp3
         w7O1x2tV6MWOkBUPupVX3UnZE2RtQXJzOn0KIOHay8chlXi/CGNP6p9DDj/9bftVUi
         Bvm1dyMGpYbuR8K+eG9AM4XIeyKvmrEIn75F7GbtBrjwMr7zhdZo3w7ZpZT8m7S+4b
         V2MALGMozJ/oxnScVZ1+9xn+rJ7La5PHV2KvilxBMw7MpB8QPBUT54/P0DamN15RSr
         ptstEREff74SXUzlPlEM0Gp8AFrn82riVzUenSCEODNStMv9PWzwrj60I6fvlyoQ/J
         ttoJ0PewpXP/g==
Date:   Wed, 5 Jul 2023 14:14:54 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        lpieralisi@kernel.org, bhelgaas@google.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH V2] PCI: qcom: Use PARF_SLV_ADDR_SPACE_SIZE for ops_2_3_3
Message-ID: <20230705084454.GE11854@thinkpad>
References: <20230703175757.2425540-1-quic_srichara@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230703175757.2425540-1-quic_srichara@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 03, 2023 at 11:27:57PM +0530, Sricharan Ramabadhran wrote:
> PARF_SLV_ADDR_SPACE_SIZE_2_3_3 macro is used for IPQ8074
> 2_3_3 post_init ops. pcie slave addr size was initially set

PCIe

> to 0x358, but was wrongly changed to 0x168 as a part of

commit 39171b33f652 ("PCI: qcom: Remove PCIE20_ prefix from register definitions")

> "PCI: qcom: Remove PCIE20_ prefix from register definitions"
> Fixing it, by using the right macro PARF_SLV_ADDR_SPACE_SIZE
> and removing the unused PARF_SLV_ADDR_SPACE_SIZE_2_3_3.
> 

Commit message should be imperative.

> Without this pcie bring up on IPQ8074 is broken now.
> 
> Fixes: 39171b33f652 ("PCI: qcom: Remove PCIE20_ prefix from register definitions")
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>  [V2] Fixed the 'fixes tag' correctly, subject, right macro usage
> 
>  drivers/pci/controller/dwc/pcie-qcom.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 4ab30892f6ef..1689d072fe86 100644
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
> @@ -811,7 +810,7 @@ static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
>  	u32 val;
>  
>  	writel(SLV_ADDR_SPACE_SZ,
> -		pcie->parf + PARF_SLV_ADDR_SPACE_SIZE_2_3_3);
> +		pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);

This could be wrapped in the above line itself.

- Mani

>  
>  	val = readl(pcie->parf + PARF_PHY_CTRL);
>  	val &= ~PHY_TEST_PWR_DOWN;
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
