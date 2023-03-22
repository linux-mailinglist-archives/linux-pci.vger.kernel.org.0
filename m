Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101FE6C5A3F
	for <lists+linux-pci@lfdr.de>; Thu, 23 Mar 2023 00:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjCVXXU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Mar 2023 19:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjCVXXS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Mar 2023 19:23:18 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE998728D;
        Wed, 22 Mar 2023 16:23:17 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id k37so12560218lfv.0;
        Wed, 22 Mar 2023 16:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679527396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dMy1FNiyNC7nH9b0uj1+Mx7vs2yZ0RgzNddRt7P+HAU=;
        b=Fs7ZHdJsCAajCOduLTKLgiTzmLUvOiKW1QSuUnxK3JiXTbVV9p2Ahwv6D6dDsTwkZR
         MXAcqVv3XTXIqkz3Xn60tbrHrfMSZIhLoG9keX7qXwgG+bIxPiLitBiCw/PK78bap56D
         Te4L+hH0a5Sz5L/24uUJpxaKA7o97Pj/GvV/fmUzaajGx1Q02cXxKbC0jclph7Xc2vXe
         dM10B8zHDniYXfD5fCABpAleuYFytyUm1Mm6AlLXoOGgPJcqfD2eaprW819gTV64v2HY
         OgZakG+BXrsHfveOjveIEH+uRz9XtSi7AyWJfOgYVEXyZ66zeLTZ7/wrYqsMVcanRX9e
         3uSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679527396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMy1FNiyNC7nH9b0uj1+Mx7vs2yZ0RgzNddRt7P+HAU=;
        b=XEspVVRT1bv7Xt2LoSFXSwImTubiDl8d53ILaXhaSMjB7/xSH8JyWm9hjqZE79UBhw
         wJjbYRONP9MHmYM3WPQNZ4/Q3J5c8XtxoV7Bp9z+Zss26BVwNdm5pljdv+4rK9OC4jbh
         wfydUsi/klH3iMGIb+6yRfASBQaMwpFaIkKBk4J1Ec8SBxT3wuENVx2MGtdTmYBAX9xu
         N1FZhCaIRThl4WCawR2XQWN0xXf87/sqv8IxhNat2A2W1bwyDpXUfmxPUYeEtdZP9SFV
         mw6loBSOl9qnnCjU6t+RbXVjz1J6ApYwldZkX5gMY3YgeYJ6YwBqRQS67oEo36B5S3wB
         FsxQ==
X-Gm-Message-State: AO0yUKWzXu40SM1CHoicU4DjRRyxLXM3IQmewcWm2q39Lk7jyfiCIT7l
        nvjlR3Xq7XhddCdgGiLOau0=
X-Google-Smtp-Source: AK7set8irtP6Ap/MgUUkGWgx7DnC3q4LagvB2NKtgQ2zF4+eNyRMRgU2fKL5luAycwxi1gLEiL2DcA==
X-Received: by 2002:ac2:554d:0:b0:4b6:fddc:1fcd with SMTP id l13-20020ac2554d000000b004b6fddc1fcdmr1127317lfk.23.1679527395939;
        Wed, 22 Mar 2023 16:23:15 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id f17-20020a056512093100b004db0d26adb4sm2696553lft.182.2023.03.22.16.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 16:23:15 -0700 (PDT)
Date:   Thu, 23 Mar 2023 02:23:13 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Elad Nachman <enachman@marvell.com>
Cc:     thomas.petazzoni@bootlin.com, bhelgaas@google.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuval Shaia <yshaia@marvell.com>
Subject: Re: [PATCH v4 3/8] PCI: armada8k: Add AC5 MSI support
Message-ID: <20230322232313.zbxhodgfqeoyclbg@mobilestation>
References: <20230313124016.17102-1-enachman@marvell.com>
 <20230313124016.17102-4-enachman@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313124016.17102-4-enachman@marvell.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 13, 2023 at 02:40:11PM +0200, Elad Nachman wrote:
> From: Yuval Shaia <yshaia@marvell.com>
> 
> AC5 requires different handling for MSI as with armada8k.
> Fix it by:
> 
> 1. Enabling the relevant bits in init phase
> 2. Dispatch virtual IRQ handlers when MSI interrupts are received
> 
> Also enable/disable PCIE_APP_LTSSM for AC5.
> 
> Signed-off-by: Yuval Shaia <yshaia@marvell.com>
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> ---
> v4:
>    Fix commit subject to be aligned with previous patch in series
> 
> v2:
>    1) fix W1 warnings which caused by unused leftover code
> 
>    2) fix type in "requieres" word in the description
> 
>  drivers/pci/controller/dwc/pcie-armada8k.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
> index b9fb1375dc58..02481ecadd25 100644
> --- a/drivers/pci/controller/dwc/pcie-armada8k.c
> +++ b/drivers/pci/controller/dwc/pcie-armada8k.c
> @@ -50,6 +50,7 @@ struct armada8k_pcie_of_data {
>  
>  #define PCIE_GLOBAL_CONTROL_REG		(PCIE_VENDOR_REGS_OFFSET + 0x0)
>  #define PCIE_APP_LTSSM_EN		BIT(2)
> +#define PCIE_APP_LTSSM_EN_AC5		BIT(24)
>  #define PCIE_DEVICE_TYPE_SHIFT		4
>  #define PCIE_DEVICE_TYPE_MASK		0xF
>  #define PCIE_DEVICE_TYPE_RC		0x4 /* Root complex */
> @@ -69,6 +70,7 @@ struct armada8k_pcie_of_data {
>  #define PCIE_INT_B_ASSERT_MASK_AC5	BIT(13)
>  #define PCIE_INT_C_ASSERT_MASK_AC5	BIT(14)
>  #define PCIE_INT_D_ASSERT_MASK_AC5	BIT(15)
> +#define PCIE_MSI_MASK_AC5		BIT(11)
>  
>  #define PCIE_ATU_ACCESS_MASK_AC5	GENMASK(21, 20)
>  
> @@ -184,6 +186,16 @@ static int armada8k_pcie_start_link(struct dw_pcie *pci)
>  	return 0;
>  }
>  
> +static void ac5_pcie_msi_init(struct dw_pcie *pci)
> +{
> +	u32 val;
> +
> +	/* Set MSI bit in interrupt mask */
> +	val = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_MASK1_REG);
> +	val |= PCIE_MSI_MASK_AC5;
> +	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_MASK1_REG, val);
> +}
> +
>  static int armada8k_pcie_host_init(struct dw_pcie_rp *pp)
>  {
>  	u32 reg;
> @@ -193,7 +205,10 @@ static int armada8k_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (!dw_pcie_link_up(pci)) {
>  		/* Disable LTSSM state machine to enable configuration */
>  		reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_CONTROL_REG);

> -		reg &= ~(PCIE_APP_LTSSM_EN);
> +		if (pcie->pcie_type == ARMADA8K_PCIE_TYPE_AC5)
> +			reg &= ~(PCIE_APP_LTSSM_EN_AC5);
> +		else
> +			reg &= ~(PCIE_APP_LTSSM_EN);

This has nothing to do with MSIs.

-Serge(y)

>  		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_CONTROL_REG, reg);
>  	}
>  
> @@ -233,6 +248,9 @@ static int armada8k_pcie_host_init(struct dw_pcie_rp *pp)
>  		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_MASK1_REG, reg);
>  	}
>  
> +	if (IS_ENABLED(CONFIG_PCI_MSI) && (pcie->pcie_type == ARMADA8K_PCIE_TYPE_AC5))
> +		ac5_pcie_msi_init(pci);
> +
>  	return 0;
>  }
>  
> @@ -249,6 +267,8 @@ static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
>  	 */
>  	val = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_CAUSE1_REG);
>  	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_CAUSE1_REG, val);
> +	if ((PCIE_MSI_MASK_AC5 & val) && (pcie->pcie_type == ARMADA8K_PCIE_TYPE_AC5))
> +		dw_handle_msi_irq(&pci->pp);
>  
>  	return IRQ_HANDLED;
>  }
> -- 
> 2.17.1
> 
> 
