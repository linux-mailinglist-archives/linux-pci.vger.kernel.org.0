Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6EC7621DC
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jul 2023 20:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjGYS6I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 14:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjGYS6G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 14:58:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43FB2136;
        Tue, 25 Jul 2023 11:58:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 485616187E;
        Tue, 25 Jul 2023 18:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB73C433C8;
        Tue, 25 Jul 2023 18:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690311484;
        bh=u0Fzbp4R0f1nygzN+bczCvvCFE+QvFMwXogvsDtUATo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=oq73uC3ps+VtADA3SnOfc8AlPWmx5iMlDHx7TeEQyotgybIeREXwg8qNy8Croa6PK
         qdEbcxOmt39NNJxd6qQr4c8a812ml9AgNvpHQJhQVNFhZ9UvP/8kUUN6+5UzcnuPqW
         vTs9/Ktch7q2o9CySYN2m6TY5lpEqFVYb3byJM2hrgDbCyiRtJT9UsdGuBvG+63PAA
         S/Fvj55H1J4JhwtVomVi13t1IU1kiWI9XHbMkrjQoGE8HGB2w72li7bewHImqhzvP9
         EdlIY+WhRcK+ApZ/rvafgAoGpoULe2l1f1St1VZbT3ZmvVTZcT6BVdv7k7f2NegNoO
         rKD2YDWTctmyw==
Date:   Tue, 25 Jul 2023 13:58:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh@kernel.org, mani@kernel.org, lpieralisi@kernel.org,
        bhelgaas@google.com, kw@linux.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        gregkh@linuxfoundation.org, dmitry.baryshkov@linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH V5] PCI: qcom: Fixing broken pcie enumeration for 2_3_3
 configs ops
Message-ID: <20230725185802.GA658415@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724063429.3980462-1-quic_srichara@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 24, 2023 at 12:04:29PM +0530, Sricharan Ramabadhran wrote:
> PARF_SLV_ADDR_SPACE_SIZE_2_3_3 macro is used for IPQ8074 2_3_3 post_init.
> PCIe slave addr register offset is 0x358, but was wrongly changed to
> 0x168 as a part of commit 39171b33f652 ("PCI: qcom: Remove PCIE20_ prefix
> from register definitions"). Fixing it, by using the right macro and remove
> the unused PARF_SLV_ADDR_SPACE_SIZE_2_3_3.
> 
> Without this access to the registers of slave addr space like iATU etc
> are broken leading to pcie enumeration failure.

This is harder to review than it should be because it mentions
"IPQ8074 2_3_3 post_init" instead of the specific
qcom_pcie_post_init_2_3_3().

Also it says the offset was changed to 0x168, when it was actually
changed to 0x16C.

Also it is not clear that PARF_SLV_ADDR_SPACE_SIZE_2_3_3 is the same
as the "PCIe slave addr register offset" (and this is apparently the
offset of the slave address space *size*, not the offset of the slave
address itself).

Maybe whoever applies this can fix these up.  At the same time,
will you please:

s/Fixing/Fix/ in subject and commit log
s/pcie/PCIe/

> Fixes: 39171b33f652 ("PCI: qcom: Remove PCIE20_ prefix from register definitions")
> Cc: <Stable@vger.kernel.org>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>  [v5] Fixed subject, commit log
>  [v4] Fix commit sub and added '<mani@kernel.org>' reviewed-by tag
>  [v3] Added reviewed-by tag, fixed subject, commit text
>  [v2] Fixed the 'fixes tag' correctly, subject, right macro usage 
> 
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
