Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAB272C4CB
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jun 2023 14:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjFLMqO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jun 2023 08:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjFLMqN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jun 2023 08:46:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4E8AA;
        Mon, 12 Jun 2023 05:46:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 263696158F;
        Mon, 12 Jun 2023 12:46:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9596BC433D2;
        Mon, 12 Jun 2023 12:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686573971;
        bh=MBd1cofKeU2sXm9omVYNK8uPvLmV1nDtHJoOhzzzE5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FpbbWG0Pdn8BL6YeMdPcWoxh5Sj+TZSBsVZx18av79kNbMDrJ7w+kVYBcCVAGAA7W
         j9A/lUmFIbqbUhRcxrHT6aPDzH6MYo8XOkZq0K1aiqUpc6LGSne4OqR2PgVEhciTkL
         yhgsFrgQiijFAqLDdRMZ8W0e3lTpEfp4xKxyvumalzd0GTBva29RRktDZjYZ+nCiaK
         nmuUT+xiCE3rGbjOQEnItCxoQDIfpx3GoxOqZDjgdMYOG3XgqwTP5e4ap6mQ8P0JVD
         aHU4CUkMeiGen2QaX7wOJ3wNhzi1MfpqamKByoll5WG0gXrh9jJvpXnuxrrw42sPIe
         DBBh/rkb1muFA==
Date:   Mon, 12 Jun 2023 14:46:04 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     kw@linux.com, bhelgaas@google.com, robh@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v3 1/8] PCI: qcom: Use DWC helpers for modifying the
 read-only DBI registers
Message-ID: <ZIcTjO8GhBk/MVBX@lpieralisi>
References: <20230601163900.15500-1-manivannan.sadhasivam@linaro.org>
 <20230601163900.15500-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601163900.15500-2-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 01, 2023 at 10:08:53PM +0530, Manivannan Sadhasivam wrote:
> DWC core already exposes dw_pcie_dbi_ro_wr_{en/dis} helper APIs for
> enabling and disabling the write access to read only DBI registers. So
> let's use them instead of doing it manually.
> 
> Also, the existing code doesn't disable the write access when it's done.
> This is also fixed now.

I am afraid we need to split this up, sorry, it is two logical
changes (and of them is a fix AFAICS).

Lorenzo

> Fixes: 5d76117f070d ("PCI: qcom: Add support for IPQ8074 PCIe controller")
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 4ab30892f6ef..01795ee7ce45 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -61,7 +61,6 @@
>  /* DBI registers */
>  #define AXI_MSTR_RESP_COMP_CTRL0		0x818
>  #define AXI_MSTR_RESP_COMP_CTRL1		0x81c
> -#define MISC_CONTROL_1_REG			0x8bc
>  
>  /* MHI registers */
>  #define PARF_DEBUG_CNT_PM_LINKST_IN_L2		0xc04
> @@ -132,9 +131,6 @@
>  /* AXI_MSTR_RESP_COMP_CTRL1 register fields */
>  #define CFG_BRIDGE_SB_INIT			BIT(0)
>  
> -/* MISC_CONTROL_1_REG register fields */
> -#define DBI_RO_WR_EN				1
> -
>  /* PCI_EXP_SLTCAP register fields */
>  #define PCIE_CAP_SLOT_POWER_LIMIT_VAL		FIELD_PREP(PCI_EXP_SLTCAP_SPLV, 250)
>  #define PCIE_CAP_SLOT_POWER_LIMIT_SCALE		FIELD_PREP(PCI_EXP_SLTCAP_SPLS, 1)
> @@ -826,7 +822,9 @@ static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
>  	writel(0, pcie->parf + PARF_Q2A_FLUSH);
>  
>  	writel(PCI_COMMAND_MASTER, pci->dbi_base + PCI_COMMAND);
> -	writel(DBI_RO_WR_EN, pci->dbi_base + MISC_CONTROL_1_REG);
> +
> +	dw_pcie_dbi_ro_wr_en(pci);
> +
>  	writel(PCIE_CAP_SLOT_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
>  
>  	val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
> @@ -836,6 +834,8 @@ static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
>  	writel(PCI_EXP_DEVCTL2_COMP_TMOUT_DIS, pci->dbi_base + offset +
>  		PCI_EXP_DEVCTL2);
>  
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +
>  	return 0;
>  }
>  
> -- 
> 2.25.1
> 
