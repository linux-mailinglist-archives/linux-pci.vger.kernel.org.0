Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8F1627B7B
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 12:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236624AbiKNLHH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 06:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236006AbiKNLHC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 06:07:02 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CBD1EEED
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2022 03:07:00 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso13467160pjc.0
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2022 03:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MkiR3wHiiW1PYTQ7TE0X6JrLq1vnHDKlS/zuy1ypUvQ=;
        b=ZyksGHtPdVe30jSTgBir0r6zjbL2u5GpgzS6sid5bMO3qTdKn3E/3GkV/i3dPVbdIk
         RsGErEozMC3CakHQBZoiCYtATnxPpYCBd+IucCJ9ZuaQSWUq4pfCBp/NTMDK/Cv7qXw9
         5soHBfyk3f0ZRFpK1JDNpN8a3MUnSPhZcDjP7hcLzQmyTOB7zBY2NIhRn5NJB3i88QEW
         uHe3xe3Cp+S6p9sz5gne5a/sseMiLdvXDYwRxYM/upoVE/afbaOLEji0SIlHpKOngidm
         uO/Ito79czfU+1qwEEdq9xI5eXwdEsfaysfzdHOeIBwIpL5qwMg9hT40U3hyBJLxpup5
         FHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MkiR3wHiiW1PYTQ7TE0X6JrLq1vnHDKlS/zuy1ypUvQ=;
        b=gpE82ieqE6UDjqRQRRwOOjmMIcFGSSCGwkxaSbNA77L8ti31bxFNDOuhD1RMWR9XzQ
         1ft1n2e8EzDPrxq+hfQgciRyKH3JWzBoFA1M78TkKH+4EyGB2R3uc/NIOxbK7uB1QUIG
         Axi56jRTCNkm64DwPKwlwx+m+DkEDfu1vvxKLCCCkwG8sWo3gl5tKtBGJ18LatWrY8wq
         gvSD1DEQbRd2cF1+PP1vDeb4eCDBuZ/pUeipbC5D9TuGfTEsd181AZ1sGo1aZB7fjxTk
         5LcvHeW4XT/OAcPtwrd+ruqcxSf5dMvkStkbIixzyK0bukbVzLvYK6FWS62MUiwmX7ur
         Brnw==
X-Gm-Message-State: ANoB5pkVl20yMPs/OSFQZbktEluZ2LUONzHbEjp0oUbIJniGR5LXyngH
        jZ5pwbuTH8gAXgpjYGX1yJ1T
X-Google-Smtp-Source: AA0mqf5eoKaaLhLXcQHHPo+28RlJ+upBEvK/afNrX2kqhp8MLM29+9/SV1+DyMsD+pEiLuFQDG7UuA==
X-Received: by 2002:a17:902:7843:b0:187:282c:9b9c with SMTP id e3-20020a170902784300b00187282c9b9cmr13283212pln.29.1668424019854;
        Mon, 14 Nov 2022 03:06:59 -0800 (PST)
Received: from thinkpad ([117.248.0.54])
        by smtp.gmail.com with ESMTPSA id y2-20020a62ce02000000b0056bbd286cf4sm6362246pfg.167.2022.11.14.03.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 03:06:58 -0800 (PST)
Date:   Mon, 14 Nov 2022 16:36:54 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vidyas@nvidia.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, lpieralisi@kernel.org,
        bhelgaas@google.com
Subject: Re: [PATCH v4 2/5] PCI: tegra194: Move dw_pcie_ep_linkup() to
 threaded IRQ handler
Message-ID: <20221114110654.GL3869@thinkpad>
References: <20221025145101.116393-1-manivannan.sadhasivam@linaro.org>
 <20221025145101.116393-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221025145101.116393-3-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 25, 2022 at 08:20:58PM +0530, Manivannan Sadhasivam wrote:
> dw_pcie_ep_linkup() may take more time to execute depending on the EPF
> driver implementation. Calling this API in the hard IRQ handler is not
> encouraged since the hard IRQ handlers are supposed to complete quickly.
> 
> So move the dw_pcie_ep_linkup() call to threaded IRQ handler.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
