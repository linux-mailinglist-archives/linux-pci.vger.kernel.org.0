Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FE7760C6D
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jul 2023 09:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjGYHwJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 03:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjGYHwI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 03:52:08 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46F0BF
        for <linux-pci@vger.kernel.org>; Tue, 25 Jul 2023 00:52:07 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6687096c6ddso2935536b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 25 Jul 2023 00:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690271527; x=1690876327;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OmasqMUtJENc1u5aTvRQMoAivuz8HYaIGy1Y1ma70D8=;
        b=UmB4B6smVGikTJLcujt/b4P3lhWQmrB9TXbcM8coHikIALIEXs1/pL5rpjkQ6mkOBg
         9jdW6ZLlvh3LBvJBTKtiSpHy6kFaoD/dlfYjrIPOlVPUog3SqjHQLIRj8oTdSXg78fvn
         m61/3xqmr/R17ONxQGI9CeXnaU3Vb4KdloupShqgK4bKG8vA00liUGyZbtyMvSDMdlpJ
         JJwGvfNbxfNt5f90YM7FGx1FzeDO2f85WF3Q1SjrVqcPI6qrI5bk0oycevJ4rcbVOkyQ
         YVl7pwZ8wacbaGW8mhlw2Jsuwoho2+2ApJFwmznFj1N0jVAMyUhiADVYIsGyl8YLipYG
         NGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690271527; x=1690876327;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OmasqMUtJENc1u5aTvRQMoAivuz8HYaIGy1Y1ma70D8=;
        b=B7NOSgOjAhbiWUzo3lTIxlA6m/hFl2B/7Q6c2d8ZjwmvpbaXEnomrlsKnMhbjL4IOC
         yeTpxERC3QiS8BohAfsdOTSZbVnMrCNMjZ7F4AagIu6ckfSIAKffEfNsYuXTg9kMvz4O
         eMmBmnDeUb1Od/ViFbcYEp0H1Q55szyHUzuikMI+GqdeJxCX5SQ/XdkMaugW8DNIBbVe
         WkUvs7hytXK1pFSsJVKTLiUmmBoI59ts46gQm9jlcsjfjzHpF3P2wB8kVXwtoG5qE0fQ
         bgIJTAYqfWuFfma918iex8A+E7rMDBw04NlTmOBUWNAOF8ByDrjDCWuTIv7VP+mS85HF
         MF0g==
X-Gm-Message-State: ABy/qLayrDwhD1gMspM5ELbZymFXUw+PLicyifZKIHAuuhjoCBrQ64NV
        9ge6AMPLSSvRrl8Qkwas741zZ4i4XDMzx9T3LQ==
X-Google-Smtp-Source: APBJJlEFsFBmcbu+kGDXRDjdPf4YlThrOLcJmvZxtOGuaDCNZbKmlWT96t6835OyA8ouWWRJyxLeJw==
X-Received: by 2002:a05:6a20:3b30:b0:137:26b9:f403 with SMTP id c48-20020a056a203b3000b0013726b9f403mr9308853pzh.49.1690271527205;
        Tue, 25 Jul 2023 00:52:07 -0700 (PDT)
Received: from thinkpad ([117.206.117.206])
        by smtp.gmail.com with ESMTPSA id a13-20020aa780cd000000b006863240ef3bsm9267172pfn.171.2023.07.25.00.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 00:52:06 -0700 (PDT)
Date:   Tue, 25 Jul 2023 13:21:59 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, Sergey.Semin@baikalelectronics.ru,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1] Revert "PCI: tegra194: Enable support for 256 Byte
 payload"
Message-ID: <20230725075159.GB22139@thinkpad>
References: <20230608093652.1409485-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230608093652.1409485-1-vidyas@nvidia.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 08, 2023 at 03:06:52PM +0530, Vidya Sagar wrote:
> This reverts commit 4fb8e46c1bc4 ("PCI: tegra194: Enable
> support for 256 Byte payload")
> 
> Consider a PCIe hierarchy with a PCIe switch and a device connected
> downstream of the switch that has support for MPS which is the minimum
> in the hierarchy, and root port programmed with an MPS in its DevCtl
> register that is greater than the minimum. In this scenario, the default
> bus configuration of the kernel i.e. "PCIE_BUS_DEFAULT" doesn't
> configure the MPS settings in the hierarchy correctly resulting in the
> device with support for minimum MPS in the hierarchy receiving the TLPs
> of size more than that. Although this can be addresed by appending
> "pci=pcie_bus_safe" to the kernel command line, it doesn't seem to be a
> good idea to always have this commandline argument even for the basic
> functionality to work.
> Reverting commit 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256
> Byte payload") avoids this requirement and ensures that the basic
> functionality of the devices irrespective of the hierarchy and the MPS of
> the devices in the hierarchy.
> To reap the benefits of having support for higher MPS, optionally, one can
> always append the kernel command line with "pci=pcie_bus_perf".
> 
> Fixes: 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256 Byte payload")
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>

I know that this patch is merged. But I happen to test a similar change on Qcom
platform during a patch review and found that the PCI core changes MPS to 128
when a 128byte supported device is found:

[    3.174290] pci 0000:01:00.0: Upstream bridge's Max Payload Size set to 128 (was 256, max 128)
[    3.186538] pci 0000:01:00.0: Max Payload Size set to 128 (was 128, max 128)

This was just randomly tested on a platform whose Root port DEVCAP was 128, but
it shouldn't matter. And I didn't change the default bus configuration.

Wondering how you ended up facing issues with it.

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 4fdadc7b045f..877d81b13334 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -892,7 +892,6 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
>  	u32 val;
> -	u16 val_16;
>  
>  	pp->bridge->ops = &tegra_pci_ops;
>  
> @@ -900,11 +899,6 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
>  		pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
>  							      PCI_CAP_ID_EXP);
>  
> -	val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL);
> -	val_16 &= ~PCI_EXP_DEVCTL_PAYLOAD;
> -	val_16 |= PCI_EXP_DEVCTL_PAYLOAD_256B;
> -	dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL, val_16);
> -
>  	val = dw_pcie_readl_dbi(pci, PCI_IO_BASE);
>  	val &= ~(IO_BASE_IO_DECODE | IO_BASE_IO_DECODE_BIT8);
>  	dw_pcie_writel_dbi(pci, PCI_IO_BASE, val);
> @@ -1756,7 +1750,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>  	struct device *dev = pcie->dev;
>  	u32 val;
>  	int ret;
> -	u16 val_16;
>  
>  	if (pcie->ep_state == EP_STATE_ENABLED)
>  		return;
> @@ -1887,11 +1880,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>  	pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
>  						      PCI_CAP_ID_EXP);
>  
> -	val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL);
> -	val_16 &= ~PCI_EXP_DEVCTL_PAYLOAD;
> -	val_16 |= PCI_EXP_DEVCTL_PAYLOAD_256B;
> -	dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL, val_16);
> -
>  	/* Clear Slot Clock Configuration bit if SRNS configuration */
>  	if (pcie->enable_srns) {
>  		val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base +
> @@ -1900,7 +1888,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>  		dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA,
>  				   val_16);
>  	}
> -
>  	clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
>  
>  	val = (ep->msi_mem_phys & MSIX_ADDR_MATCH_LOW_OFF_MASK);
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
