Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6591EB0B2
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jun 2020 23:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgFAVIt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jun 2020 17:08:49 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:36749 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727863AbgFAVIt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jun 2020 17:08:49 -0400
Received: by mail-il1-f195.google.com with SMTP id a13so6021928ilh.3;
        Mon, 01 Jun 2020 14:08:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rQVvO9YcsH98PCSINw+ZwEqkjtHr5m+TPLH4ZiOhBSI=;
        b=OAjHOAJgnY3HXYIzx4xHLUsG+loBOTJZaIGOjDx1b/rpInApUjAyj5RzL8Fq8wiJNp
         kU2hdT2SSFbR+tJU/dPtUfm57ZxudvrfylbJs8ml2YKq7z2RHLQltRvGZjtN2XPcvYEv
         msXD9pRLEaeRO0GWIj2a5+Er3gGQ4G3PWh3UqKyQhL6dUkZ3A3sEc1tX6VA2ocdaukJJ
         XbBu5l839ktuy+4ntebH9vE8hvNdwfURxMp7YkLlf2ZZln4X2YPYpZpSEy6ZozW2GWJw
         0M0CIEEkqeuuMysUOBffyPZjwSo6T4yHiDEx+iPGGT1gyD/EugccmCyAUEMiHwHA1n3m
         hzOQ==
X-Gm-Message-State: AOAM533A8hN1N6+koMRo18kjPICyQl5rJSZyNXqzGwQKEHYcKb/LT1ld
        sdMta7WC9s0UFqPkCHsfcQ==
X-Google-Smtp-Source: ABdhPJzXcxL8+3NgmnRb6dWmMr84dXfoGP1OI2sbRhY73rzNL7sSQdLiqG1j+BL6omEOStjfYxLq6w==
X-Received: by 2002:a05:6e02:dc5:: with SMTP id l5mr14132808ilj.216.1591045727058;
        Mon, 01 Jun 2020 14:08:47 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id t26sm367868ild.86.2020.06.01.14.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 14:08:46 -0700 (PDT)
Received: (nullmailer pid 1500269 invoked by uid 1000);
        Mon, 01 Jun 2020 21:08:44 -0000
Date:   Mon, 1 Jun 2020 15:08:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sham Muthayyan <smuthayy@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/10] PCI: qcom: Add ipq8064 rev2 variant and set tx
 term offset
Message-ID: <20200601210844.GA1494556@bogus>
References: <20200514200712.12232-1-ansuelsmth@gmail.com>
 <20200514200712.12232-9-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514200712.12232-9-ansuelsmth@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 14, 2020 at 10:07:09PM +0200, Ansuel Smith wrote:
> Add tx term offset support to pcie qcom driver need in some revision of
> the ipq806x SoC. Ipq8064 have tx term offset set to 7. Ipq8064-v2 revision
> and ipq8065 have the tx term offset set to 0.

Seems like this should be 2 patches or why isn't 'Ipq8064 have tx term 
offset set to 7' done in the prior patch? One tweak is needed for 
stable, but this isn't?

> 
> Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index f5398b0d270c..ab6f1bdd24c3 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -45,6 +45,9 @@
>  #define PCIE_CAP_CPL_TIMEOUT_DISABLE		0x10
>  
>  #define PCIE20_PARF_PHY_CTRL			0x40
> +#define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	GENMASK(20, 16)
> +#define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		((x) << 16)
> +
>  #define PCIE20_PARF_PHY_REFCLK			0x4C
>  #define PHY_REFCLK_SSP_EN			BIT(16)
>  #define PHY_REFCLK_USE_PAD			BIT(12)
> @@ -363,7 +366,8 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
>  	val &= ~BIT(0);
>  	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
>  
> -	if (of_device_is_compatible(node, "qcom,pcie-ipq8064")) {
> +	if (of_device_is_compatible(node, "qcom,pcie-ipq8064") |
> +	    of_device_is_compatible(node, "qcom,pcie-ipq8064-v2")) {
>  		writel(PCS_DEEMPH_TX_DEEMPH_GEN1(24) |
>  			       PCS_DEEMPH_TX_DEEMPH_GEN2_3_5DB(24) |
>  			       PCS_DEEMPH_TX_DEEMPH_GEN2_6DB(34),
> @@ -374,9 +378,18 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
>  		writel(PHY_RX0_EQ(4), pcie->parf + PCIE20_PARF_CONFIG_BITS);
>  	}
>  
> +	if (of_device_is_compatible(node, "qcom,pcie-ipq8064")) {
> +		/* set TX termination offset */
> +		val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> +		val &= ~PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK;
> +		val |= PHY_CTRL_PHY_TX0_TERM_OFFSET(7);
> +		writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
> +	}
> +
>  	/* enable external reference clock */
>  	val = readl(pcie->parf + PCIE20_PARF_PHY_REFCLK);
> -	val |= BIT(16);
> +	val &= ~PHY_REFCLK_USE_PAD;
> +	val |= PHY_REFCLK_SSP_EN;
>  	writel(val, pcie->parf + PCIE20_PARF_PHY_REFCLK);
>  
>  	/* wait for clock acquisition */
> @@ -1452,6 +1465,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-apq8084", .data = &ops_1_0_0 },
>  	{ .compatible = "qcom,pcie-ipq8064", .data = &ops_2_1_0 },
> +	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &ops_2_1_0 },
>  	{ .compatible = "qcom,pcie-apq8064", .data = &ops_2_1_0 },
>  	{ .compatible = "qcom,pcie-msm8996", .data = &ops_2_3_2 },
>  	{ .compatible = "qcom,pcie-ipq8074", .data = &ops_2_3_3 },
> -- 
> 2.25.1
> 
