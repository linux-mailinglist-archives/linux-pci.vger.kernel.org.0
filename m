Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B85586BD6
	for <lists+linux-pci@lfdr.de>; Mon,  1 Aug 2022 15:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiHANVg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Aug 2022 09:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiHANVe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Aug 2022 09:21:34 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608163206B
        for <linux-pci@vger.kernel.org>; Mon,  1 Aug 2022 06:21:33 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id bf13so9648445pgb.11
        for <linux-pci@vger.kernel.org>; Mon, 01 Aug 2022 06:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/aediu4tsdLNLL4oscxsQg+7Obmai1/AXwHZTzocrgU=;
        b=s1IFt+5ANDg6QbKg1CiSsxspNdp+WP9rUxo6sWqX3SXKxRXHtj+TF+Bn2/DKGxPfjV
         ZC1kVw/P926gGZ0vZmuLEKzsfB4RWN4fhUgNNVqKY7wIC7z8yuAaDaLZQJEyliF5fLXh
         ck4FzT1va1FwiKdxI15S6Ew9WGdRZprjYD66xDnizvu+y2oE3au0c0c1/fQeAtKPS2J0
         fDLX0KGpc5n7aDzPlRXh3uBR+5OYY3/bKxVM0E/vNOLUYryY+HHquimwKzzTs44JWlFF
         fRX4YhWKilTVodnUw/nJRuHCNugHM8An8YOof5C3aABKLA6PJNkH6ygB0Lyn/F7YeaCI
         vl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/aediu4tsdLNLL4oscxsQg+7Obmai1/AXwHZTzocrgU=;
        b=jjRZxJVVbP23xck/indycwu3YMms73tPIr94+XFf+8IQiPthgkngsw1pAEQblNxCBy
         j+0cYdPL6OQgjCEopcrVilJhJFw8Sj3J909F12o2XoL3naZR2Fm7U2+/swKe1fn2RRPp
         MT8gMwmqSHL4CjO8DOfvKCYEdpXcaEgWPsxfLiVk8mWXU0YhQJ2G6iFHxl5qSvLMj29D
         Xw35aYf5v527q7Fo6d4ARHhRFP/W9sK2D/SFtrVi4iQVRI6CHT0mesLhsqJbnEGRuJs1
         Q61sUQQ1382/jNCMMqba/b6cvwPlKpHESXURZdEdPMCOQVswXbkM//0GqZArvM5KBve7
         /8xA==
X-Gm-Message-State: AJIora9VkJci1jeY/v8OhfGZ6i/TezBtF5kSLjeTfIMXVPC/aP/RO0QS
        Hxh4s6HgFiaMOoVv1VCbTgyh
X-Google-Smtp-Source: AGRyM1sw+ThhQQr+LBp7UJWbIm+SWhOMxPqWyYGwKlVPvw6vThsXuLcUm15uG7AaEFkkHFBaKhHLbQ==
X-Received: by 2002:a65:6d10:0:b0:41a:1817:2c59 with SMTP id bf16-20020a656d10000000b0041a18172c59mr13215371pgb.320.1659360092800;
        Mon, 01 Aug 2022 06:21:32 -0700 (PDT)
Received: from thinkpad ([117.217.185.73])
        by smtp.gmail.com with ESMTPSA id w135-20020a627b8d000000b0052d36feb7fcsm4010707pfc.198.2022.08.01.06.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 06:21:32 -0700 (PDT)
Date:   Mon, 1 Aug 2022 18:51:21 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4 05/15] PCI: dwc: Introduce Synopsys IP-core
 versions/types interface
Message-ID: <20220801132121.GE93763@thinkpad>
References: <20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru>
 <20220624143947.8991-6-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220624143947.8991-6-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 24, 2022 at 05:39:37PM +0300, Serge Semin wrote:
> Instead of manual DW PCIe data version field comparison let's use a handy
> macro-based interface in order to shorten out the statements, simplify the
> corresponding parts, improve the code readability and maintainability in
> perspective when more complex version-based dependencies need to
> implemented. Similar approaches have already been implemented in the DWC
> USB3 and DW SPI drivers (though with some IP-core evolution specifics).
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pci/controller/dwc/pci-keystone.c    |  2 +-
>  drivers/pci/controller/dwc/pcie-designware.c |  8 ++++----
>  drivers/pci/controller/dwc/pcie-designware.h | 15 +++++++++++++++
>  3 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index c4ab3d775a18..2a9bbde224af 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -1233,7 +1233,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>  		goto err_get_sync;
>  	}
>  
> -	if (pci->version >= DW_PCIE_VER_480A)
> +	if (dw_pcie_ver_is_ge(pci, 480A))
>  		ret = ks_pcie_am654_set_mode(dev, mode);
>  	else
>  		ret = ks_pcie_set_mode(dev);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index cbb36ccaa48b..bd575ad32bc4 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -313,7 +313,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
>  	val = type | PCIE_ATU_FUNC_NUM(func_no);
>  	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr))
>  		val |= PCIE_ATU_INCREASE_REGION_SIZE;
> -	if (pci->version == DW_PCIE_VER_490A)
> +	if (dw_pcie_ver_is(pci, 490A))
>  		val = dw_pcie_enable_ecrc(val);
>  	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, val);
>  	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
> @@ -360,7 +360,7 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
>  			   upper_32_bits(cpu_addr));
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_LIMIT,
>  			   lower_32_bits(limit_addr));
> -	if (pci->version >= DW_PCIE_VER_460A)
> +	if (dw_pcie_ver_is_ge(pci, 460A))
>  		dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_LIMIT,
>  				   upper_32_bits(limit_addr));
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_TARGET,
> @@ -369,9 +369,9 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
>  			   upper_32_bits(pci_addr));
>  	val = type | PCIE_ATU_FUNC_NUM(func_no);
>  	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
> -	    pci->version >= DW_PCIE_VER_460A)
> +	    dw_pcie_ver_is_ge(pci, 460A))
>  		val |= PCIE_ATU_INCREASE_REGION_SIZE;
> -	if (pci->version == DW_PCIE_VER_490A)
> +	if (dw_pcie_ver_is(pci, 490A))
>  		val = dw_pcie_enable_ecrc(val);
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, val);
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, PCIE_ATU_ENABLE);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 7899808bdbc6..d247f227464c 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -28,6 +28,21 @@
>  #define DW_PCIE_VER_490A		0x3439302a
>  #define DW_PCIE_VER_520A		0x3532302a
>  
> +#define __dw_pcie_ver_cmp(_pci, _ver, _op) \
> +	((_pci)->version _op DW_PCIE_VER_ ## _ver)
> +
> +#define dw_pcie_ver_is(_pci, _ver) __dw_pcie_ver_cmp(_pci, _ver, ==)
> +
> +#define dw_pcie_ver_is_ge(_pci, _ver) __dw_pcie_ver_cmp(_pci, _ver, >=)
> +

The macro names are not very intuitive. But I cannot come with anything better.

> +#define dw_pcie_ver_type_is(_pci, _ver, _type) \
> +	(__dw_pcie_ver_cmp(_pci, _ver, ==) && \
> +	 __dw_pcie_ver_cmp(_pci, TYPE_ ## _type, ==))
> +
> +#define dw_pcie_ver_type_is_ge(_pci, _ver, _type) \
> +	(__dw_pcie_ver_cmp(_pci, _ver, ==) && \
> +	 __dw_pcie_ver_cmp(_pci, TYPE_ ## _type, >=))
> +

Are these macros used anywhere?

Thanks,
Mani

>  /* Parameters for the waiting for link up routine */
>  #define LINK_WAIT_MAX_RETRIES		10
>  #define LINK_WAIT_USLEEP_MIN		90000
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
