Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9C45F5C69
	for <lists+linux-pci@lfdr.de>; Thu,  6 Oct 2022 00:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJEWIy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Oct 2022 18:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiJEWIu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Oct 2022 18:08:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB00982D08;
        Wed,  5 Oct 2022 15:08:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40A20B81F6B;
        Wed,  5 Oct 2022 22:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CC1C433C1;
        Wed,  5 Oct 2022 22:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665007726;
        bh=gKOVo4rUV9LgPwc755tdGNCMqjAmEyTDy12BI9mdJXg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KJDFnz6vlfEd1fwDXYA/yBOB/hH4FpuL8bV55dTUZqTb/qL4OqfQOcKd/uSALm1GS
         7q8u7gYql5IkId3wXpD06IzD3X8zkEHTLvFRWliHopytXGh+kZ7dYnnBm2mpelAo3r
         oN2GbX1wNcldGi/LVSfp69PzACaYqzn6LzBSulqKnyDXxmFxOLjzBRmhw1M30K+4bE
         9UVTBH1TUcWsblFVHA1LFct46LuS4NVCkBS5jMgWtZqiWDSD3BiuCGnNDW/bCEahBX
         jkxZTaiPwKZacVmGmJVAN6R72Nn3xwBOGVeVaUbYpk75D7YJjKb3dIxXYs05SGjE/2
         QPsc7zCc2jXIg==
Date:   Wed, 5 Oct 2022 17:08:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org,
        kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Subject: Re: [PATCH v4 06/12] PCI: qcom-ep: Gate Master AXI clock to MHI bus
 during L1SS
Message-ID: <20221005220838.GA2400326@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914075350.7992-7-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Krishna]

On Wed, Sep 14, 2022 at 01:23:44PM +0530, Manivannan Sadhasivam wrote:
> During L1SS, gate the Master clock supplied to the MHI bus to save power.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 2dc6d4e44aff..526e98ea23f6 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -27,6 +27,7 @@
>  #define PARF_SYS_CTRL				0x00
>  #define PARF_DB_CTRL				0x10
>  #define PARF_PM_CTRL				0x20
> +#define PARF_MHI_CLOCK_RESET_CTRL		0x174
>  #define PARF_MHI_BASE_ADDR_LOWER		0x178
>  #define PARF_MHI_BASE_ADDR_UPPER		0x17c
>  #define PARF_DEBUG_INT_EN			0x190
> @@ -89,6 +90,9 @@
>  #define PARF_PM_CTRL_READY_ENTR_L23		BIT(2)
>  #define PARF_PM_CTRL_REQ_NOT_ENTR_L1		BIT(5)
>  
> +/* PARF_MHI_CLOCK_RESET_CTRL fields */
> +#define PARF_MSTR_AXI_CLK_EN			BIT(1)
> +
>  /* PARF_AXI_MSTR_RD_HALT_NO_WRITES register fields */
>  #define PARF_AXI_MSTR_RD_HALT_NO_WRITE_EN	BIT(0)
>  
> @@ -394,6 +398,11 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
>  		       pcie_ep->parf + PARF_MHI_BASE_ADDR_LOWER);
>  	writel_relaxed(0, pcie_ep->parf + PARF_MHI_BASE_ADDR_UPPER);
>  
> +	/* Gate Master AXI clock to MHI bus during L1SS */
> +	val = readl_relaxed(pcie_ep->parf + PARF_MHI_CLOCK_RESET_CTRL);
> +	val &= ~PARF_MSTR_AXI_CLK_EN;
> +	val = readl_relaxed(pcie_ep->parf + PARF_MHI_CLOCK_RESET_CTRL);

Is this code executed when the link actually transitions to L1.x, or
is this just configuring things so that when the link does transition
to L1.x sometime later, hardware will gate the Master AXI clock?

Just curious because this looks more like *configuration*, i.e., the
latter, but there's the ongoing conversation about qcom system
suspend/resume, where IIUC, software is involved at least in some
L1.2 exits.

>  	dw_pcie_ep_init_notify(&pcie_ep->pci.ep);
>  
>  	/* Enable LTSSM */
> -- 
> 2.25.1
> 
