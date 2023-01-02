Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A7365B608
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jan 2023 18:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjABRnZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Jan 2023 12:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjABRnY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Jan 2023 12:43:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CFEA187;
        Mon,  2 Jan 2023 09:43:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21F86B80D09;
        Mon,  2 Jan 2023 17:43:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32CFCC433EF;
        Mon,  2 Jan 2023 17:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672681400;
        bh=eeGID9WmDRN6FuuErqklRn+h70OeSzjZBAKTjhskM+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=luxdFTD+QXYVTSa7Nduryhj6TpxluC4iF/W9vgyottAV562iYTJTOkLeL+Pt0hWhC
         jLULQzDynK9ABKhZjLXajlqGpCzKq412I9cdY5vCmOfxJ+TTJylPS6xvHPuLLTyKPy
         NXvXIrg9XtA/rKf6AmFoVNNmJAns6no8UjmeV0D0unDpqkxatQ8LgwDiVdbPTv0K+W
         9bRTATKLTgpNcIeXPoXVrH7jdAU9sH/7Y0nhTgYqbqgZytbCaa1CQFcC11OYdCbeTg
         +Xul8nMEeHAPmdGPeLY7U/y9pixCBG4Sbc7oI8qlDUJGwK4uGtrLjGwEN2L0IpNuus
         /Gv0759iieMLw==
Date:   Mon, 2 Jan 2023 23:13:13 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PCI: qcom: Fix host-init error handling
Message-ID: <20230102174313.GC16638@thinkpad>
References: <20221017114705.8277-1-johan+linaro@kernel.org>
 <20221017114705.8277-2-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221017114705.8277-2-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 17, 2022 at 01:47:04PM +0200, Johan Hovold wrote:
> Implement the new host_deinit() callback so that the PHY is powered off
> and regulators and clocks are disabled also on late host-init errors.
> 
> Fixes: 82a823833f4e ("PCI: qcom: Add Qualcomm PCIe controller driver")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 0c13f976626f..417be4d225ed 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1534,8 +1534,19 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>  	return ret;
>  }
>  
> +static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> +
> +	qcom_ep_reset_assert(pcie);
> +	phy_power_off(pcie->phy);
> +	pcie->cfg->ops->deinit(pcie);
> +}
> +
>  static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
> -	.host_init = qcom_pcie_host_init,
> +	.host_init	= qcom_pcie_host_init,
> +	.host_deinit	= qcom_pcie_host_deinit,
>  };
>  
>  /* Qcom IP rev.: 2.1.0	Synopsys IP rev.: 4.01a */
> -- 
> 2.37.3
> 

-- 
மணிவண்ணன் சதாசிவம்
