Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44892586B91
	for <lists+linux-pci@lfdr.de>; Mon,  1 Aug 2022 15:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbiHANHd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Aug 2022 09:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbiHANHc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Aug 2022 09:07:32 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBAC1C3
        for <linux-pci@vger.kernel.org>; Mon,  1 Aug 2022 06:07:26 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id r186so9631661pgr.2
        for <linux-pci@vger.kernel.org>; Mon, 01 Aug 2022 06:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Sux9Y25GfognHFX+b76W5SqbBgwqteQfWNix1OICqJc=;
        b=dC40LYiAZIDR8DgQ3fdItRcIw4ln9Ye2VFHYtn47PMW/uxc3npraQDUkHrS70sTspW
         HfxctYd5IlTce/Lwx3jU2kEcoHV516eEG/2WKByCKvfvdI0AZwrlynI3ZEW82Ez08Nf1
         gfKgpp0RMHQSot+Cndke6u5d1RURDVtYapB2/s9V/78Rhg/oy5mF3FPOPUHZG3S/FCYT
         85KsNa6pnJ9uBZm6hhVwJWhatupKa5NbhSl5+s3b6qJOeunfSxOg+uegM2Fy46th6ADe
         weFB0YwfNI/8tBbihYlsLm1JqJ1aB09pjQ8VNwgLlONna5d40T9kBn219ppVxmGfzMPC
         QyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Sux9Y25GfognHFX+b76W5SqbBgwqteQfWNix1OICqJc=;
        b=pUbhPOGKCBNntYrQzwN0W0bn+2hWulZmBFZiF1BVk0k9/piMhoD4KGHQWES8YEszOH
         tcxKJ+SJg8eFFnAhxVq7YdZ3vRoBTtvYb3rzGe6r/Fi+3DWCLRLjRS0gvYzWNSl7r7w9
         +iqmj+XF+e86kwR+5zztOUuJTLpz9/W0mfeAuwAFj+ckSNeWzMUv5gWtDQjubh12x560
         qvzi6JtnxKbWU7lrK71w92zypnFwhTjyFxv6peMFUD0e9Ap28CtWEvBTieP2eVHyQZi/
         gaxgyykdzw4LxNytghxIkAOAxgsWX7UHm/Etale2PW0RUGJJxcpTW/xI/pjxQKgj0Xh8
         0soQ==
X-Gm-Message-State: AJIora+CX0ykh90FZmMKi1T3UfSA4I3FCZXbDrkQHUrkoS6r9GDyu6Dh
        xRIrsuWqfFjpunOmABEuAkKZ
X-Google-Smtp-Source: AGRyM1uetyesLX93jrFypqV6LM2PlvQal8ZkmN7w5nQhndHX/tEkzaMKV4kZw0fuq0XOIC2fjrU4yw==
X-Received: by 2002:a63:1923:0:b0:419:b27c:7acf with SMTP id z35-20020a631923000000b00419b27c7acfmr13131160pgl.449.1659359246198;
        Mon, 01 Aug 2022 06:07:26 -0700 (PDT)
Received: from thinkpad ([117.217.185.73])
        by smtp.gmail.com with ESMTPSA id nk4-20020a17090b194400b001f30bf6346csm11551532pjb.30.2022.08.01.06.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 06:07:25 -0700 (PDT)
Date:   Mon, 1 Aug 2022 18:37:13 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH RESEND v4 03/15] PCI: dwc: Convert to using native
 IP-core versions representation
Message-ID: <20220801130713.GC93763@thinkpad>
References: <20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru>
 <20220624143947.8991-4-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220624143947.8991-4-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 24, 2022 at 05:39:35PM +0300, Serge Semin wrote:
> Since DWC PCIe v4.70a the controller version can be read from the
> PORT_LOGIC.PCIE_VERSION_OFF register. Version is represented in the FourCC
> format [1]. It's standard versioning approach for the Synopsys DWC
> IP-cores. Moreover some of the DWC kernel drivers already make use of it
> to fixup version-dependent functionality (See DWC USB3, Stmicro STMMAC or
> recent DW SPI driver). In order to preserve the standard version
> representation and prevent the data conversion back and forth, we suggest
> to preserve the native version representation in the DWC PCIe driver too
> in the same way as it has already been done in the rest of the DWC
> drivers. IP-core version reading from the CSR will be introduced in the
> next commit together with a simple macro-based API to use it.
> 
> [1] https://en.wikipedia.org/wiki/FourCC
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/pci/controller/dwc/pci-keystone.c    | 12 ++++++------
>  drivers/pci/controller/dwc/pcie-designware.c |  8 ++++----
>  drivers/pci/controller/dwc/pcie-designware.h | 10 +++++++++-
>  drivers/pci/controller/dwc/pcie-intel-gw.c   |  4 ++--
>  drivers/pci/controller/dwc/pcie-tegra194.c   |  2 +-
>  5 files changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index c3d88aa27dd4..c4ab3d775a18 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -109,7 +109,7 @@ struct ks_pcie_of_data {
>  	enum dw_pcie_device_mode mode;
>  	const struct dw_pcie_host_ops *host_ops;
>  	const struct dw_pcie_ep_ops *ep_ops;
> -	unsigned int version;
> +	u32 version;
>  };
>  
>  struct keystone_pcie {
> @@ -1069,19 +1069,19 @@ static int ks_pcie_am654_set_mode(struct device *dev,
>  
>  static const struct ks_pcie_of_data ks_pcie_rc_of_data = {
>  	.host_ops = &ks_pcie_host_ops,
> -	.version = 0x365A,
> +	.version = DW_PCIE_VER_365A,
>  };
>  
>  static const struct ks_pcie_of_data ks_pcie_am654_rc_of_data = {
>  	.host_ops = &ks_pcie_am654_host_ops,
>  	.mode = DW_PCIE_RC_TYPE,
> -	.version = 0x490A,
> +	.version = DW_PCIE_VER_490A,
>  };
>  
>  static const struct ks_pcie_of_data ks_pcie_am654_ep_of_data = {
>  	.ep_ops = &ks_pcie_am654_ep_ops,
>  	.mode = DW_PCIE_EP_TYPE,
> -	.version = 0x490A,
> +	.version = DW_PCIE_VER_490A,
>  };
>  
>  static const struct of_device_id ks_pcie_of_match[] = {
> @@ -1114,12 +1114,12 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>  	struct device_link **link;
>  	struct gpio_desc *gpiod;
>  	struct resource *res;
> -	unsigned int version;
>  	void __iomem *base;
>  	u32 num_viewport;
>  	struct phy **phy;
>  	u32 num_lanes;
>  	char name[10];
> +	u32 version;
>  	int ret;
>  	int irq;
>  	int i;
> @@ -1233,7 +1233,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>  		goto err_get_sync;
>  	}
>  
> -	if (pci->version >= 0x480A)
> +	if (pci->version >= DW_PCIE_VER_480A)
>  		ret = ks_pcie_am654_set_mode(dev, mode);
>  	else
>  		ret = ks_pcie_set_mode(dev);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index e66d16a86168..f10a7d5d94e8 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -289,7 +289,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
>  	val = type | PCIE_ATU_FUNC_NUM(func_no);
>  	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr))
>  		val |= PCIE_ATU_INCREASE_REGION_SIZE;
> -	if (pci->version == 0x490A)
> +	if (pci->version == DW_PCIE_VER_490A)
>  		val = dw_pcie_enable_ecrc(val);
>  	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, val);
>  	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
> @@ -336,7 +336,7 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
>  			   upper_32_bits(cpu_addr));
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_LIMIT,
>  			   lower_32_bits(limit_addr));
> -	if (pci->version >= 0x460A)
> +	if (pci->version >= DW_PCIE_VER_460A)
>  		dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_LIMIT,
>  				   upper_32_bits(limit_addr));
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_TARGET,
> @@ -345,9 +345,9 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
>  			   upper_32_bits(pci_addr));
>  	val = type | PCIE_ATU_FUNC_NUM(func_no);
>  	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
> -	    pci->version >= 0x460A)
> +	    pci->version >= DW_PCIE_VER_460A)
>  		val |= PCIE_ATU_INCREASE_REGION_SIZE;
> -	if (pci->version == 0x490A)
> +	if (pci->version == DW_PCIE_VER_490A)
>  		val = dw_pcie_enable_ecrc(val);
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, val);
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, PCIE_ATU_ENABLE);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 32df3ebccf19..6b81530fb2ca 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -20,6 +20,14 @@
>  #include <linux/pci-epc.h>
>  #include <linux/pci-epf.h>
>  
> +/* DWC PCIe IP-core versions (native support since v4.70a) */
> +#define DW_PCIE_VER_365A		0x3336352a
> +#define DW_PCIE_VER_460A		0x3436302a
> +#define DW_PCIE_VER_470A		0x3437302a
> +#define DW_PCIE_VER_480A		0x3438302a
> +#define DW_PCIE_VER_490A		0x3439302a
> +#define DW_PCIE_VER_520A		0x3532302a
> +
>  /* Parameters for the waiting for link up routine */
>  #define LINK_WAIT_MAX_RETRIES		10
>  #define LINK_WAIT_USLEEP_MIN		90000
> @@ -270,7 +278,7 @@ struct dw_pcie {
>  	struct dw_pcie_rp	pp;
>  	struct dw_pcie_ep	ep;
>  	const struct dw_pcie_ops *ops;
> -	unsigned int		version;
> +	u32			version;
>  	int			num_lanes;
>  	int			link_gen;
>  	u8			n_fts[2];
> diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
> index 07bc54886d71..371b5aa189d1 100644
> --- a/drivers/pci/controller/dwc/pcie-intel-gw.c
> +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
> @@ -59,7 +59,7 @@
>  #define RESET_INTERVAL_MS		100
>  
>  struct intel_pcie_soc {
> -	unsigned int	pcie_ver;
> +	u32	pcie_ver;
>  };
>  
>  struct intel_pcie {
> @@ -395,7 +395,7 @@ static const struct dw_pcie_host_ops intel_pcie_dw_ops = {
>  };
>  
>  static const struct intel_pcie_soc pcie_data = {
> -	.pcie_ver =		0x520A,
> +	.pcie_ver =		DW_PCIE_VER_520A,
>  };
>  
>  static int intel_pcie_probe(struct platform_device *pdev)
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 65135f5c4a4a..f24b30b7454f 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1979,7 +1979,7 @@ static int tegra194_pcie_probe(struct platform_device *pdev)
>  	pci->ops = &tegra_dw_pcie_ops;
>  	pci->n_fts[0] = N_FTS_VAL;
>  	pci->n_fts[1] = FTS_VAL;
> -	pci->version = 0x490A;
> +	pci->version = DW_PCIE_VER_490A;
>  
>  	pp = &pci->pp;
>  	pp->num_vectors = MAX_MSI_IRQS;
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
