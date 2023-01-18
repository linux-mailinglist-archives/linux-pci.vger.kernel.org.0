Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938A6671F52
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jan 2023 15:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjAROUD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 09:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjAROTh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 09:19:37 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA88863E0D
        for <linux-pci@vger.kernel.org>; Wed, 18 Jan 2023 06:01:17 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 7-20020a17090a098700b002298931e366so2242575pjo.2
        for <linux-pci@vger.kernel.org>; Wed, 18 Jan 2023 06:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xx6Y6y6cT1ok/SNtLnujkKdJJBlAkD7OxMPbiXw8JP4=;
        b=N1jwAWsQs5hOuxoZgvgQM+FFG8M90mTXzlVvI7rbWEJiwOmwMAalj6WScsPe1Y+rHz
         +XFpFFLpVF8qFjA6lwSwQiV9Tu0ilgTIwzvXRsqxoQlDYExGWOZ9zo/8SIfMaEuZ2kkq
         VAGC5ZUrYT2ruz2drL3tm8N+pIU7hrVvo6ZVP1vyc2e+E8+SJtS1lFyQmUKh9yBavtI7
         /ntMAOvXQXn4nFNOmhYNGtoGJxc/YN031InZEmzu4K+8AmWzktf1wIjkgl6A51a5QUb3
         Oswv729d0SEZ7BHBDLJaISoEl5EZEnoP5wl4VRH3+YKgAcFR6CMlD18w6a+T8nQx7F0Q
         jNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xx6Y6y6cT1ok/SNtLnujkKdJJBlAkD7OxMPbiXw8JP4=;
        b=MjHoP2Z3PENi4aaMy8Uq53frWuceSOXr0fxzOhGKWyTUSbeIkhM/w/SxSGoIFsIRkL
         pmfNO6mTtq+gkPYO1C0g0Rlxu/DwFB/twnhlkhEklLznLMxADPeUy3sWtagtOQ+IQBX5
         TFWa6vto8tT9iYHLB02SM9guLh9WNiCO33MQkrSvWkgJ0hp4MicbkiImYaWVowtHYhac
         W7puwpREQNR0gjBXr6ftAFpSGaKRXegbLMLkznxZcLV63ZBDswx/VigkJadsT9L6AygI
         H0h6Nxe05B6QbZU90MIVdGPGyqvbSd2P8FbUM+kxyBGs6Eo1Nx8cvbf5tlBtBF3UVRCX
         p5Eg==
X-Gm-Message-State: AFqh2kolXwzYHtfrDVtrTriHlIufGad2LmZFOL/dvds1sKeUrNTlibCS
        m208wWkHCOfWXCIU89pjz20s
X-Google-Smtp-Source: AMrXdXu6oKACAoX3xa39wxVKZ6/nwlfRSyq2XUxodK1F0MNIr3V5bqfuW9nJ08rJgmCxV9PJNbfWdA==
X-Received: by 2002:a05:6a21:99a7:b0:b5:d781:ca7 with SMTP id ve39-20020a056a2199a700b000b5d7810ca7mr9562128pzb.3.1674050477158;
        Wed, 18 Jan 2023 06:01:17 -0800 (PST)
Received: from thinkpad ([103.197.115.83])
        by smtp.gmail.com with ESMTPSA id a3-20020a170902900300b00189393ab02csm5686227plp.99.2023.01.18.06.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 06:01:15 -0800 (PST)
Date:   Wed, 18 Jan 2023 19:31:11 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vidyas@nvidia.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vidyas@nvidia.com, vigneshr@ti.com,
        kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com
Subject: Re: [RESEND v4 2/5] PCI: tegra194: Move dw_pcie_ep_linkup() to
 threaded IRQ handler
Message-ID: <20230118140111.GA4690@thinkpad>
References: <20230111114059.6553-1-manivannan.sadhasivam@linaro.org>
 <20230111114059.6553-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230111114059.6553-3-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 11, 2023 at 05:10:56PM +0530, Manivannan Sadhasivam wrote:
> dw_pcie_ep_linkup() may take more time to execute depending on the EPF
> driver implementation. Calling this API in the hard IRQ handler is not
> encouraged since the hard IRQ handlers are supposed to complete quickly.
> 
> So move the dw_pcie_ep_linkup() call to threaded IRQ handler.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Hi Vidya,

Could you please review this patch? This patch is blocking the merge since last
release. And there are other series pending to be submitted/merged due to this
(including one from you).

Thanks,
Mani

> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 02d78a12b6e7..09825b4a075e 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -286,6 +286,7 @@ struct tegra_pcie_dw {
>  	struct gpio_desc *pex_refclk_sel_gpiod;
>  	unsigned int pex_rst_irq;
>  	int ep_state;
> +	long link_status;
>  };
>  
>  static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
> @@ -449,9 +450,13 @@ static void pex_ep_event_hot_rst_done(struct tegra_pcie_dw *pcie)
>  static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
>  {
>  	struct tegra_pcie_dw *pcie = arg;
> +	struct dw_pcie_ep *ep = &pcie->pci.ep;
>  	struct dw_pcie *pci = &pcie->pci;
>  	u32 val, speed;
>  
> +	if (test_and_clear_bit(0, &pcie->link_status))
> +		dw_pcie_ep_linkup(ep);
> +
>  	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
>  		PCI_EXP_LNKSTA_CLS;
>  	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
> @@ -498,7 +503,6 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
>  static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
>  {
>  	struct tegra_pcie_dw *pcie = arg;
> -	struct dw_pcie_ep *ep = &pcie->pci.ep;
>  	int spurious = 1;
>  	u32 status_l0, status_l1, link_status;
>  
> @@ -514,7 +518,8 @@ static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
>  			link_status = appl_readl(pcie, APPL_LINK_STATUS);
>  			if (link_status & APPL_LINK_STATUS_RDLH_LINK_UP) {
>  				dev_dbg(pcie->dev, "Link is up with Host\n");
> -				dw_pcie_ep_linkup(ep);
> +				set_bit(0, &pcie->link_status);
> +				return IRQ_WAKE_THREAD;
>  			}
>  		}
>  
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
