Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6915290CF
	for <lists+linux-pci@lfdr.de>; Mon, 16 May 2022 22:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiEPUmj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 16:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236252AbiEPUjS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 16:39:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CFB517C1;
        Mon, 16 May 2022 13:19:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD91861170;
        Mon, 16 May 2022 20:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B73C34100;
        Mon, 16 May 2022 20:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652732394;
        bh=SHhiQGhVcUE0vHNCt6nUYr9ak3tUjCBNu2xVT+ZMvnk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EHGLL0p67u5Tt7xDUhDyvi/TAxlteDKDzicHOufHj+R8QMP66W6j0/Yi5ak/tM3J7
         nv3zbzvcU2XV82k0yDfDcn8X7qvOLFbUcvYsbCnbOlkPtbhCpX1keGPxZsjsH+TlGO
         k5rTXoTDPci4VnUjAAarqDNMD2zQ28U8QqkvRdfoS87Sf8R/pii2VzQppCjs/lNOkS
         C+zTIEkzohAE4FB0HlQBZjA0f7UX6ZPiG6NELfw6TjsWrN3B1i4rgjiznUqx0EJEwM
         3nQsLdMCbXwwLATjCErNnujmwiIxLRW3/+MYfVKAFFVctcsp5Mx1Ud+dGemtODSt5U
         Op7PYa/bRtUiQ==
Date:   Mon, 16 May 2022 15:19:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com, kbusch@kernel.org,
        hch@lst.de, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, svarbanov@mm-sol.com,
        bjorn.andersson@linaro.org, axboe@fb.com,
        quic_vbadigan@quicinc.com, quic_krichai@quicinc.com,
        quic_nitirawa@quicinc.com, vidyas@nvidia.com, sagi@grimberg.me
Subject: Re: [PATCH 2/3] PCI: dwc: qcom: Set suspend_poweroff flag for SC7280
Message-ID: <20220516201950.GA1047412@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513110027.31015-3-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 13, 2022 at 04:30:26PM +0530, Manivannan Sadhasivam wrote:
> For aggressive power saving on SC7280 SoCs, the power for the PCI devices
> will be taken off during system suspend. Hence, notify the same to the
> PCI device drivers using "suspend_poweroff" flag so that the drivers can
> prepare the PCI devices to handle the poweroff and recover them during
> resume.

No doubt "power ... will be taken off during system suspend" is true,
but this isn't very informative.  Is this a property of SC7280?  A
choice made by the SC7280 driver?  Why is this not applicable to other
systems?

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 6ab90891801d..4b0ad2827f8f 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -199,6 +199,7 @@ struct qcom_pcie_cfg {
>  	unsigned int has_ddrss_sf_tbu_clk:1;
>  	unsigned int has_aggre0_clk:1;
>  	unsigned int has_aggre1_clk:1;
> +	unsigned int suspend_poweroff:1;
>  };
>  
>  struct qcom_pcie {
> @@ -1220,6 +1221,10 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  	if (pcie->cfg->pipe_clk_need_muxing)
>  		clk_set_parent(res->pipe_clk_src, res->ref_clk_src);
>  
> +	/* Indicate PCI device drivers that the power will be taken off during system suspend */
> +	if (pcie->cfg->suspend_poweroff)
> +		pci->pp.bridge->suspend_poweroff = true;
> +
>  	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
>  	if (ret < 0)
>  		goto err_disable_regulators;
> @@ -1548,6 +1553,7 @@ static const struct qcom_pcie_cfg sc7280_cfg = {
>  	.ops = &ops_1_9_0,
>  	.has_tbu_clk = true,
>  	.pipe_clk_need_muxing = true,
> +	.suspend_poweroff = true,
>  };
>  
>  static const struct dw_pcie_ops dw_pcie_ops = {
> -- 
> 2.25.1
> 
