Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBD1575D51
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 10:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiGOIYt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 04:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiGOIYs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 04:24:48 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD2124BFC
        for <linux-pci@vger.kernel.org>; Fri, 15 Jul 2022 01:24:47 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y9so4048775pff.12
        for <linux-pci@vger.kernel.org>; Fri, 15 Jul 2022 01:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zq/ENRoQXla91PhPgglndMgEOmTX2K4lBPbsP0r9Ao8=;
        b=WV3I9/g+DoBl2rKdJzZIOZnex1O3fMhDD02zypuxlqAoAYyeFOCIm1mMiXJ5sH9Q6c
         QfrkveEcQg27Fw80Ym55wh9PdHckQS6Ju+hIolFG+wuAvbXl4D5+Kz1rXRg176uKikkv
         dvZAKadJysOVZckODLGocL0Rh5tW/egnDLlTLmKN1a3xUnrKa/pESEC5lT4Z9pQt0tRv
         C8iSvXCiU5qVkSLGnIqbSjj0N4QgDgtjzoIiGTzi/6Ta1My4QCSTRiFLfVzen1o0++IY
         QvIa5jujS1DV7VgKj7d1nkBxNfNPw6U9Vmse8k0ko5LmItAMbU0jYEh1kIbPpgC8HSss
         rPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zq/ENRoQXla91PhPgglndMgEOmTX2K4lBPbsP0r9Ao8=;
        b=l8rFeo4Aii9hnsAqCBUF+OHizK4q7nNLm3oGYW5kFVrBa2sWKB8wWgIqlBn6Y+929d
         8Ih9Nnfy4h3sgLq0E3hcTumtiyC8LGFhJqQNZhFt7kScm7tXibpU/Z3nxYZUExWvD/y2
         t6PrZgueX20WVzY/xoSDTrTyxlRV9LJIbraqnmNPhEklCAR1dMlx0Aur8nheP7hu/r+U
         Gufnf9ouGzsuS+fkyRDUyoziylnmH2nb4gwn9vEPgP4zOYvdFUt/EP2wCoMxAcxMTC7w
         vrCLbfZdlvdk5la7V8EZtzr/pIVGryAbXYYYHXnMwJk3Z3F14o2phrOgYRAAD5V4HIGI
         +ffw==
X-Gm-Message-State: AJIora++/+nJDnLsjo0Z9MhoHy5p+0q1wgV76iBFWdMKrxX0BW5sAnxX
        TQeCpzNagX9mySux6aKjKsNE
X-Google-Smtp-Source: AGRyM1vPh8pjtPYU81D/m9wIV5jmZRQ48TYfalrYpXHP1pXUAWlQTonOCipMZ3zFW80/A7ekVCcZWg==
X-Received: by 2002:a63:190b:0:b0:416:10ee:3c7a with SMTP id z11-20020a63190b000000b0041610ee3c7amr11156440pgl.490.1657873486699;
        Fri, 15 Jul 2022 01:24:46 -0700 (PDT)
Received: from workstation ([117.248.1.85])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090a708100b001ef3cec7f47sm2828835pjk.52.2022.07.15.01.24.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jul 2022 01:24:46 -0700 (PDT)
Date:   Fri, 15 Jul 2022 13:54:40 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, swboyd@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2] PCI: qcom: Allow L1 and its sub states
Message-ID: <20220715082440.GB12197@workstation>
References: <1654240730-31322-1-git-send-email-quic_krichai@quicinc.com>
 <1655298939-392-1-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655298939-392-1-git-send-email-quic_krichai@quicinc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 15, 2022 at 06:45:39PM +0530, Krishna chaitanya chundru wrote:
> Allow L1 and its sub-states in the qcom pcie driver.
> By default this is disabled in the hardware. So enabling it explicitly.
> 

You are enabling L1ss for controllers belonging to 2_7_0, so this should
be mentioned in the commit message. Otherwise, it will imply that the
L1ss is added for all controller versions.

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---

Change log should be added here for versions > 1.

Thanks,
Mani

>  drivers/pci/controller/dwc/pcie-qcom.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 6ab9089..0d8efcc 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -41,6 +41,9 @@
>  #define L23_CLK_RMV_DIS				BIT(2)
>  #define L1_CLK_RMV_DIS				BIT(1)
>  
> +#define PCIE20_PARF_PM_CTRL			0x20
> +#define REQ_NOT_ENTR_L1				BIT(5)
> +
>  #define PCIE20_PARF_PHY_CTRL			0x40
>  #define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	GENMASK(20, 16)
>  #define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		((x) << 16)
> @@ -1267,6 +1270,11 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  	val |= BIT(4);
>  	writel(val, pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
>  
> +	/* Enable L1 and L1ss */
> +	val = readl(pcie->parf + PCIE20_PARF_PM_CTRL);
> +	val &= ~REQ_NOT_ENTR_L1;
> +	writel(val, pcie->parf + PCIE20_PARF_PM_CTRL);
> +
>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>  		val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
>  		val |= BIT(31);
> -- 
> 2.7.4
> 
