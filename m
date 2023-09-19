Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A26C7A62A7
	for <lists+linux-pci@lfdr.de>; Tue, 19 Sep 2023 14:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjISMUV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Sep 2023 08:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjISMUF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Sep 2023 08:20:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E18DCD2;
        Tue, 19 Sep 2023 05:19:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C8BC433C8;
        Tue, 19 Sep 2023 12:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695125956;
        bh=KWxrBE8BT1ctag8F1WD5tAIg+4DrPuUNHnklsRSxoSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h1ieTEC7kJrlAKkCSFGmz/GMmrgdOneAwxqrwiVeVtI3H3Dkr2DNMYY/5iwe3nZkt
         fQHHEPjl+1pbSu4IJq6W8Tz9NI/LyHwt387rujE6jlckQxZiH3LBmPucwpZyDpaq18
         /TYlcLKZL5VipVjjoO9GtRfmWQC4q60qPg2QaDhcll/Md8NTQHx19m99AVVeUlHEot
         Rekfq1IZJnmZoRijp2A5ITBcdker3hovduuu3e1SvQ0TTrTxHZzgTuQVDakxfIwWuh
         Rj8fs9xIs20S+5Berz5mxpfU/6HOHzU0KRrgqxGzpdT9jZhUjr5dDRAI8+9k3Wwxe3
         VCOOvbi8K+duw==
Date:   Tue, 19 Sep 2023 14:19:09 +0200
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com,
        kw@linux.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        gregkh@linuxfoundation.org, dmitry.baryshkov@linaro.org,
        stable@vger.kernel.org, robimarko@gmail.com
Subject: Re: [PATCH V6] PCI: qcom: Fix broken pcie enumeration for 2_3_3
 configs ops
Message-ID: <20230919121909.GF4732@thinkpad>
References: <20230919102948.1844909-1-quic_srichara@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230919102948.1844909-1-quic_srichara@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 19, 2023 at 03:59:48PM +0530, Sricharan Ramabadhran wrote:
> PARF_SLV_ADDR_SPACE_SIZE_2_3_3 macro is used for qcom_pcie_post_init_2_3_3.
> PCIe slave address space size register offset is 0x358, but was wrongly
> changed to 0x16c as a part of commit 39171b33f652 ("PCI: qcom: Remove
> PCIE20_ prefix from register definitions"). Fixing it, by using the right
> macro and remove the unused PARF_SLV_ADDR_SPACE_SIZE_2_3_3.
> 
> Without this access to the registers of slave addr space like iATU etc
> are broken leading to PCIe enumeration failure on IPQ8074.
> 
> Fixes: 39171b33f652 ("PCI: qcom: Remove PCIE20_ prefix from register definitions")
> Cc: <Stable@vger.kernel.org>

Please fix the stable list address: stable@vger.kernel.org

- Mani

> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Tested-by: Robert Marko <robimarko@gmail.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>  [V6] Fixed subject and commit text as per Bjorn Helgaas
> 
>  drivers/pci/controller/dwc/pcie-qcom.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index e2f29404c84e..64420ecc24d1 100644
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
> @@ -797,8 +796,7 @@ static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
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
