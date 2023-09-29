Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF10A7B3B91
	for <lists+linux-pci@lfdr.de>; Fri, 29 Sep 2023 22:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbjI2UsR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Sep 2023 16:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjI2UsQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Sep 2023 16:48:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCAA1A7;
        Fri, 29 Sep 2023 13:48:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF49C433C9;
        Fri, 29 Sep 2023 20:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696020494;
        bh=8Oeq2oyvclFb8e5vneLF5O4C3f3cxRlcpro2BcWHes4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tdCCKVkwLs8N/mkl3LWPdO47xAroH163igwOK4121omnkF3zit2PjnHPyFyuQa3JJ
         PXsc9FWOpRPA7HOdlwRviTYwenh/GaL1KGo187fLHcYs+ODFlYqgQy6DyDwA8ArVMG
         RN03+3cjx2oII8/ai9bkeIUhqWiXxUiL0YQxGh2IrY1uXvWHNzSETDA1/+sWc+eQko
         sHHJe1IdhYjKAuH/4c3WcsD4sixUmFxxxvqd+8ACcu6FykHqZJvjHzjnhnzijXhgqW
         Jw4b5m9tjYtk+qVKdBM8IpY9Ao/h7xDouDu3E4E+ivoM7K3HbTEGV089tvuOI7ttJm
         7IZEd8jF9V97A==
Date:   Fri, 29 Sep 2023 15:48:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh@kernel.org, mani@kernel.org, lpieralisi@kernel.org,
        bhelgaas@google.com, kw@linux.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        gregkh@linuxfoundation.org, dmitry.baryshkov@linaro.org,
        stable@vger.kernel.org, robimarko@gmail.com
Subject: Re: [PATCH V6] PCI: qcom: Fix broken pcie enumeration for 2_3_3
 configs ops
Message-ID: <20230929204812.GA553836@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Tested-by: Robert Marko <robimarko@gmail.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>

Applied to for-linus for v6.6, thanks!

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
