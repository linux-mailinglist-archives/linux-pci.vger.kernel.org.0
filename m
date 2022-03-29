Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821B64EAFBE
	for <lists+linux-pci@lfdr.de>; Tue, 29 Mar 2022 17:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238201AbiC2PCZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Mar 2022 11:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235770AbiC2PCY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2022 11:02:24 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD7D17C431;
        Tue, 29 Mar 2022 08:00:41 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id o20-20020a9d7194000000b005cb20cf4f1bso12918648otj.7;
        Tue, 29 Mar 2022 08:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ATnw6PEqyAxFDklqcM0ljDLZ/jMZkSYwbsmucfTRygY=;
        b=aZ33l3mMTBrOqfw6DCMSFq9dSSMwQKF6sgNfgiYTtf/7u+23lrpDyTDx4+af05o3fJ
         piL5l1f40ScP8S+2dtiSqTZf79dXxUH1EiYh8pAS5tQAU2tpMGOosAyAUfTOkRJ8cwLq
         +BdtTmDLdxqQCbWBzktw/Y2QiYsS7t56cieZqIJuZjg9OX3q+s+9ZmqtbpdK0WQRmrjB
         zzF0WXcYjKbzXzAA93+DgEeXWWuUpjbFaxywGobqdaIXOf7ic5yCziLF13qKDfOYbFEa
         MIQmPs/lk5ePijXOJwPATVdfKkiaOJyARHKbpkmGfo11vpdjSUg4koS8PRQVzcN+TNAI
         EI1A==
X-Gm-Message-State: AOAM531cH/NNCrAGgphvsToS8e8spgbspKvBtcqscdjhJS1iy9cuEOIi
        1pSpehd2ritXX8uQylKpvg==
X-Google-Smtp-Source: ABdhPJyNJO0gA0k/KVdjVen1vXFioSf2B/kpcozdjb4xczFxoGU93vUVOmtUWW6a5SaJpCAnXw0XyA==
X-Received: by 2002:a05:6830:3c1:b0:5b0:3e3d:b788 with SMTP id p1-20020a05683003c100b005b03e3db788mr1260223otc.179.1648566040718;
        Tue, 29 Mar 2022 08:00:40 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i7-20020a9d6247000000b005cdd13c217asm5626239otk.48.2022.03.29.08.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 08:00:39 -0700 (PDT)
Received: (nullmailer pid 665655 invoked by uid 1000);
        Tue, 29 Mar 2022 15:00:38 -0000
Date:   Tue, 29 Mar 2022 10:00:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 04/16] PCI: dwc: Convert to using native IP-core versions
 representation
Message-ID: <YkMfFrKzz5eHPMrJ@robh.at.kernel.org>
References: <20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru>
 <20220324013734.18234-5-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324013734.18234-5-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 24, 2022 at 04:37:22AM +0300, Serge Semin wrote:
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
> ---
>  drivers/pci/controller/dwc/pci-keystone.c    | 12 ++++++------
>  drivers/pci/controller/dwc/pcie-designware.c |  8 ++++----
>  drivers/pci/controller/dwc/pcie-designware.h | 10 +++++++++-
>  drivers/pci/controller/dwc/pcie-intel-gw.c   |  4 ++--
>  drivers/pci/controller/dwc/pcie-tegra194.c   |  2 +-
>  5 files changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 1c2ee4e13f1c..ec65355dd29b 100644
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

This version should be readable, so get rid of hardcoding it here.

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
> index f1693e25afcb..c21373c6cb51 100644
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
> index 7d6e9b7576be..5be43c662176 100644
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

Create a macro to form these so we can do:

DW_PCIE_VER('5', '2', '0', 'A')

> +
>  /* Parameters for the waiting for link up routine */
>  #define LINK_WAIT_MAX_RETRIES		10
>  #define LINK_WAIT_USLEEP_MIN		90000
> @@ -269,7 +277,7 @@ struct dw_pcie {
>  	struct pcie_port	pp;
>  	struct dw_pcie_ep	ep;
>  	const struct dw_pcie_ops *ops;
> -	unsigned int		version;
> +	u32			version;
>  	int			num_lanes;
>  	int			link_gen;
>  	u8			n_fts[2];
> diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
> index 5ba144924ff8..786af2ba379f 100644
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
> index b1b5f836a806..6f1330ed63e5 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1981,7 +1981,7 @@ static int tegra194_pcie_probe(struct platform_device *pdev)
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
