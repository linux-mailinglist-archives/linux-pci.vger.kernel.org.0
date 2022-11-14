Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7FC627B76
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 12:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236566AbiKNLGQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 06:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236271AbiKNLGP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 06:06:15 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41131EED3
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2022 03:06:14 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id io19so9726774plb.8
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2022 03:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:cc:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KfFvid/s/EazTIm5SJZ8j+8OoeKKY3JzPToO5BRuUw4=;
        b=QPewNo2ksaUisA6qY43wocst55uxRBFul8b1t4eaKbBKQ3hZCkBH+oeKN7kGV0+2vV
         x1kC34OUKfeDbonXRNyhwR50iucLrgoZLboIRZv3Eb7M3iVnc+V2pU0WEtonimSnNPXt
         Kb6MRwcAY96NVeoRFUFNJtB/4471P8ob5cCWmkT/lDTwUja5LNRkmIEkH21/nZ0PZ51h
         KZMdNmdpyNy9zHzCDWdaf8Kaowl9plBGgjyb3psgtFOACQRfSstdW4vKl8lq/fdLo9kS
         ZbBKXfYpgTWgrjb2hw2q+zhKNWmLymI1jdqctKC8PpjpqbRTQL85cd9CWj3eDIy2nuWI
         sDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:cc:to:from:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KfFvid/s/EazTIm5SJZ8j+8OoeKKY3JzPToO5BRuUw4=;
        b=z49mJG6Sd45AEYxMjrpuycP+HabuNSN0UFiS78nMV9beZgHgvi35n8tAXaeBEitqEA
         3OR3BURJKsC4g3V03jlkz51VfR/20dvD3dicu71tkx0SDiWSuGiAWISnotlk8sz2CYlc
         hQvTsKHInGMsNMnC78Uw0PSVFlHDovKPM/4lGy9zscVSW3SyQ6ZHe0Lb1pojdtaw5mkl
         GFw2irkCGggj99YJUKXcLfZkFX08RmlCeLuRBKSTGO2/C2pBAYPJ78pMFMLUoeI6o59D
         d2Ep1lkOIOqEALNOe78oM07tgJvgIr7q++Kl47xxoEjqbslcDsvebJ9QmiXZzKf4XFGT
         Ppeg==
X-Gm-Message-State: ANoB5pl1QCYIwLxWxqrAukIeeU+8zP0RG4jW1EmR24Sps9HWvHkIhKPu
        hyNTaM/HEiFmnhPKpK7s0YDRID4KcxIo
X-Google-Smtp-Source: AA0mqf5iGyOp1bdT7o4fiJvNrahYywkH4PXJpd2e3cUjFCPXEO4+SggeuqOW1kUhyGBIb6XUm5TvAQ==
X-Received: by 2002:a17:902:a508:b0:188:9542:515 with SMTP id s8-20020a170902a50800b0018895420515mr13404204plq.102.1668423974133;
        Mon, 14 Nov 2022 03:06:14 -0800 (PST)
Received: from thinkpad ([117.248.0.54])
        by smtp.gmail.com with ESMTPSA id k15-20020aa7998f000000b0056bd95259d6sm6435405pfh.189.2022.11.14.03.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 03:06:13 -0800 (PST)
Date:   Mon, 14 Nov 2022 16:36:07 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vidyas@nvidia.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vigneshr@ti.com, kishon@kernel.org,
        lpieralisi@kernel.org, bhelgaas@google.com
Message-ID: <20221114110607.GK3869@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_SUBJECT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bcc: 
Subject: Re: [PATCH v4 2/5] PCI: tegra194: Move dw_pcie_ep_linkup() to
 threaded IRQ handler
Reply-To: 
In-Reply-To: <20221025145101.116393-3-manivannan.sadhasivam@linaro.org>

On Tue, Oct 25, 2022 at 08:20:58PM +0530, Manivannan Sadhasivam wrote:
> dw_pcie_ep_linkup() may take more time to execute depending on the EPF
> driver implementation. Calling this API in the hard IRQ handler is not
> encouraged since the hard IRQ handlers are supposed to complete quickly.
> 
> So move the dw_pcie_ep_linkup() call to threaded IRQ handler.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Vidya, could you please review this patch?

Thanks,
Mani

> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 1b6b437823d2..a0d231b7a435 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -287,6 +287,7 @@ struct tegra_pcie_dw {
>  	struct gpio_desc *pex_refclk_sel_gpiod;
>  	unsigned int pex_rst_irq;
>  	int ep_state;
> +	long link_status;
>  };
>  
>  static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
> @@ -450,9 +451,13 @@ static void pex_ep_event_hot_rst_done(struct tegra_pcie_dw *pcie)
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
> @@ -499,7 +504,6 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
>  static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
>  {
>  	struct tegra_pcie_dw *pcie = arg;
> -	struct dw_pcie_ep *ep = &pcie->pci.ep;
>  	int spurious = 1;
>  	u32 status_l0, status_l1, link_status;
>  
> @@ -515,7 +519,8 @@ static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
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
