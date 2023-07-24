Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7659E75F4EA
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 13:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjGXL3c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 07:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjGXL3a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 07:29:30 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AABE5C
        for <linux-pci@vger.kernel.org>; Mon, 24 Jul 2023 04:29:29 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666ed230c81so4058923b3a.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Jul 2023 04:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690198169; x=1690802969;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tH1KzEb9LDaTk96IPzTkrIp1SW5M233TgMxWfs0J9LI=;
        b=XMLazlr3dttQGvZf/4ZP8kfG3D25JCLt0KIklb43ZXZ3FbiY2GixMfiIL6FMQoRvbd
         765/JqWDzC4Qe+7JpMiAcv/f8IA27jCddJ1TnnDlnBAkOeDqAURaAmDdulo+kkcIzsMd
         QnNNZvz2OxyVlxcOgwtLprxNYbA9mzvjeQ+HfCIq94GlwUyccjCGarmGbp10Yk0n5eT0
         xnk5CTHA5erhtBi4aCYUttOOJoRprULfhVJzwTS3lW8NzF6nWxttvfQ2A8YhhI0SPRv1
         1UkTabOTkotwPa0qtK9hClebAi2NuctKWfL+u5L3WM+Wg5H9ma3CBUTmpYDJ66FVD3mk
         HP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690198169; x=1690802969;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tH1KzEb9LDaTk96IPzTkrIp1SW5M233TgMxWfs0J9LI=;
        b=HQVcAgfT0dQT2U5f2jjszdMDmbQ0KlQ9ws8K7dKN6ChV1Dgrsobfcj4F2e7WI4VBrY
         gEWXeBrU3xTGII8/gnjsPBJPlRg1IsT1iWIEVvGfuxfkmdQthhf5atxsW6aVNGI4N5vr
         WzqxYYtthjDJe9Tp7cZlo221IBImlHquf0gm/9EKAY4sATVgLvW/s5UjnrqeLX3L8ZGt
         t7mg91PXfFzzKYrEw3Jp/e7axl4+Y0F6ohZ7G+V19/tliPai1mFFUBGjy+cS8N1XW8xH
         94tWfpgwR2SZnk63L+unZc830A0sHxTMJ6XhjnrVP073ygy1reTwKMvazk/5gX3dmYGG
         jEBw==
X-Gm-Message-State: ABy/qLYdcB57T/wW+Jz1E8/5P6dfhNIYcqP+nm1wR6Npdu2eaVj5sMSH
        s6/WyqTAaosP6tLLRlnACt8p
X-Google-Smtp-Source: APBJJlGYCB+TMgYAep6VE5U5sZAM60sGkdTbx1IkkJ53ohprQAyGtHxXEIpF9khhqYe5gzQbsJbv9w==
X-Received: by 2002:a05:6a00:2ea6:b0:682:4e4c:48bc with SMTP id fd38-20020a056a002ea600b006824e4c48bcmr11463465pfb.21.1690198168857;
        Mon, 24 Jul 2023 04:29:28 -0700 (PDT)
Received: from thinkpad ([117.206.118.29])
        by smtp.gmail.com with ESMTPSA id k3-20020a63ab43000000b0055c090df2fasm8209624pgp.93.2023.07.24.04.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 04:29:28 -0700 (PDT)
Date:   Mon, 24 Jul 2023 16:59:19 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        marek.vasut+renesas@gmail.com, fancer.lancer@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v18 10/20] PCI: tegra194: Drop PCI_EXP_LNKSTA_NLW setting.
Message-ID: <20230724112919.GI6291@thinkpad>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-11-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230721074452.65545-11-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove full stop from subject.

On Fri, Jul 21, 2023 at 04:44:42PM +0900, Yoshihiro Shimoda wrote:
> dw_pcie_setup() will set PCI_EXP_LNKSTA_NLW to PCI_EXP_LNKCAP register
> so that drop such setting from tegra_pcie_dw_host_init().
> 

How about,

dw_pcie_setup() is already setting PCI_EXP_LNKCAP_MLW to pcie->num_lanes in the
PCI_EXP_LNKCAP register for programming maximum link width. Hence, remove the
redundant setting here.

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

With that,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 85cc64324efd..3bba174b1701 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -922,12 +922,6 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
>  		AMBA_ERROR_RESPONSE_CRS_SHIFT);
>  	dw_pcie_writel_dbi(pci, PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT, val);
>  
> -	/* Configure Max lane width from DT */
> -	val = dw_pcie_readl_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKCAP);
> -	val &= ~PCI_EXP_LNKCAP_MLW;
> -	val |= (pcie->num_lanes << PCI_EXP_LNKSTA_NLW_SHIFT);
> -	dw_pcie_writel_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKCAP, val);
> -
>  	/* Clear Slot Clock Configuration bit if SRNS configuration */
>  	if (pcie->enable_srns) {
>  		val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base +
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
