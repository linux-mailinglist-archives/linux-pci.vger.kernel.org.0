Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A100350480F
	for <lists+linux-pci@lfdr.de>; Sun, 17 Apr 2022 16:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbiDQOpL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 17 Apr 2022 10:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiDQOpK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Apr 2022 10:45:10 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6075DF19;
        Sun, 17 Apr 2022 07:42:34 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x17so20863649lfa.10;
        Sun, 17 Apr 2022 07:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n8qbGzq11qvS6KiqFGJ23ExAr8QWkaIDZ2xdc2/Eqzw=;
        b=fXSaeaioLvweA18aWfmj5LrRmPeubWdrLBIAojC6A4GuIE8Bvhb5uN3P+OW767U7gW
         hc5b568y4C4sgWQw+VIwnluJGDGhBWvk3jL1OeoCt7AQz575dVLZL4QJnMWwq6FwOGmF
         dpMVjj4PGtrgvCmn42t1Ix5Og83G2xj54izb2M5Nw0eFw74QU2c7ZCZAO0AM18h9ZVuk
         Uw0H7wMZEDWOf9VLBuRPJzf+GomPWjbNi4AAPu48nXPh75WO8jRxcatO41Z56lBiqci0
         9/Sx8s9vfyDt3Gv9OQD8/CdcNSmTcFD3coe2dczEWG5TEZCbPZoFCxjAp5YG2oC2gn28
         rPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n8qbGzq11qvS6KiqFGJ23ExAr8QWkaIDZ2xdc2/Eqzw=;
        b=kvMRQE5qIuJRhHKwdslDW9iU2dwd/sH8J/NljwGIEV9ZMH0mIBtmqnPf9rc/XnvWEj
         zapQUqkBpgknTfB/4foz50mAWYwR7fsL6lNkEXoQmeZgUXOe/TiOdtLrK1ZY24+Dy3tt
         lvL2D/sD9YAhnma9dwd52WFsqQNYev4/gSPPm+9kt0OCRr1ArEcLOer1nYZnDOHjlllB
         y/9tAWdg25CMQlJJfEmRO4DvKn0+Ucu/pGU7kXOGGX8+Pj1jJhyaGivAf6U6S+zW0p6q
         b4X7cgDEr7q6WErtL/YhAXKiGK9vRRKPeaMdAvEJIin4Q5VQt8iMiejY+OsDtwhDzXAH
         dJhw==
X-Gm-Message-State: AOAM531pqdL4PreDGuB/ZoH1/uRufiC4oI+Kf7ZI7y3TbzOv8tLpthHi
        e1ScSb4TNaxxceCEHBD1+hVOKJqUQApjgA==
X-Google-Smtp-Source: ABdhPJyhzs3341vXO9OoQPFpHuR2pJi8QIkkVzvz7G1mfghaC8Qf1l+wuM5IAjhnp/+kvqecOo2/Lg==
X-Received: by 2002:a05:6512:3f8c:b0:45d:cb2a:8779 with SMTP id x12-20020a0565123f8c00b0045dcb2a8779mr5538346lfa.499.1650206552124;
        Sun, 17 Apr 2022 07:42:32 -0700 (PDT)
Received: from mobilestation (ip1.ibrae.ac.ru. [91.238.191.1])
        by smtp.gmail.com with ESMTPSA id a27-20020a19fc1b000000b004704dbac1b0sm521261lfi.14.2022.04.17.07.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 07:42:31 -0700 (PDT)
Date:   Sun, 17 Apr 2022 17:42:28 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 04/16] PCI: dwc: Convert to using native IP-core versions
 representation
Message-ID: <20220417144228.pqufj4li45qj4vyq@mobilestation>
References: <20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru>
 <20220324013734.18234-5-Sergey.Semin@baikalelectronics.ru>
 <YkMfFrKzz5eHPMrJ@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkMfFrKzz5eHPMrJ@robh.at.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 29, 2022 at 10:00:38AM -0500, Rob Herring wrote:
> On Thu, Mar 24, 2022 at 04:37:22AM +0300, Serge Semin wrote:
> > Since DWC PCIe v4.70a the controller version can be read from the
> > PORT_LOGIC.PCIE_VERSION_OFF register. Version is represented in the FourCC
> > format [1]. It's standard versioning approach for the Synopsys DWC
> > IP-cores. Moreover some of the DWC kernel drivers already make use of it
> > to fixup version-dependent functionality (See DWC USB3, Stmicro STMMAC or
> > recent DW SPI driver). In order to preserve the standard version
> > representation and prevent the data conversion back and forth, we suggest
> > to preserve the native version representation in the DWC PCIe driver too
> > in the same way as it has already been done in the rest of the DWC
> > drivers. IP-core version reading from the CSR will be introduced in the
> > next commit together with a simple macro-based API to use it.
> > 
> > [1] https://en.wikipedia.org/wiki/FourCC
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  drivers/pci/controller/dwc/pci-keystone.c    | 12 ++++++------
> >  drivers/pci/controller/dwc/pcie-designware.c |  8 ++++----
> >  drivers/pci/controller/dwc/pcie-designware.h | 10 +++++++++-
> >  drivers/pci/controller/dwc/pcie-intel-gw.c   |  4 ++--
> >  drivers/pci/controller/dwc/pcie-tegra194.c   |  2 +-
> >  5 files changed, 22 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> > index 1c2ee4e13f1c..ec65355dd29b 100644
> > --- a/drivers/pci/controller/dwc/pci-keystone.c
> > +++ b/drivers/pci/controller/dwc/pci-keystone.c
> > @@ -109,7 +109,7 @@ struct ks_pcie_of_data {
> >  	enum dw_pcie_device_mode mode;
> >  	const struct dw_pcie_host_ops *host_ops;
> >  	const struct dw_pcie_ep_ops *ep_ops;
> > -	unsigned int version;
> > +	u32 version;
> >  };
> >  
> >  struct keystone_pcie {
> > @@ -1069,19 +1069,19 @@ static int ks_pcie_am654_set_mode(struct device *dev,
> >  
> >  static const struct ks_pcie_of_data ks_pcie_rc_of_data = {
> >  	.host_ops = &ks_pcie_host_ops,
> > -	.version = 0x365A,
> > +	.version = DW_PCIE_VER_365A,
> >  };
> >  
> >  static const struct ks_pcie_of_data ks_pcie_am654_rc_of_data = {
> >  	.host_ops = &ks_pcie_am654_host_ops,
> >  	.mode = DW_PCIE_RC_TYPE,

> > -	.version = 0x490A,
> > +	.version = DW_PCIE_VER_490A,
> 
> This version should be readable, so get rid of hardcoding it here.

Sorry but what do you mean by 'readable'? Do you mean that since the
version CSR has been available since 4.70a, it is supposed to be read
from the h/w registers for the newer IPs and there is no point in
having that field initialized here? If so do you suggest to drop the
initialization from the both pci-keystone.c:ks_pcie_am654_rc_of_data
and pci-keystone.c:ks_pcie_am654_rc_of_data structure instances? If
so then the same can be done in the pcie-tegra194.c and
pcie-intel-gw.c drivers. Shall I drop it from there too?

Anyway if that's what you mean it needs to be done in a dedicated
patch, not here.

> 
> >  };
> >  
> >  static const struct ks_pcie_of_data ks_pcie_am654_ep_of_data = {
> >  	.ep_ops = &ks_pcie_am654_ep_ops,
> >  	.mode = DW_PCIE_EP_TYPE,
> > -	.version = 0x490A,
> > +	.version = DW_PCIE_VER_490A,
> >  };
> >  
> >  static const struct of_device_id ks_pcie_of_match[] = {
> > @@ -1114,12 +1114,12 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
> >  	struct device_link **link;
> >  	struct gpio_desc *gpiod;
> >  	struct resource *res;
> > -	unsigned int version;
> >  	void __iomem *base;
> >  	u32 num_viewport;
> >  	struct phy **phy;
> >  	u32 num_lanes;
> >  	char name[10];
> > +	u32 version;
> >  	int ret;
> >  	int irq;
> >  	int i;
> > @@ -1233,7 +1233,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
> >  		goto err_get_sync;
> >  	}
> >  
> > -	if (pci->version >= 0x480A)
> > +	if (pci->version >= DW_PCIE_VER_480A)
> >  		ret = ks_pcie_am654_set_mode(dev, mode);
> >  	else
> >  		ret = ks_pcie_set_mode(dev);
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index f1693e25afcb..c21373c6cb51 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -289,7 +289,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
> >  	val = type | PCIE_ATU_FUNC_NUM(func_no);
> >  	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr))
> >  		val |= PCIE_ATU_INCREASE_REGION_SIZE;
> > -	if (pci->version == 0x490A)
> > +	if (pci->version == DW_PCIE_VER_490A)
> >  		val = dw_pcie_enable_ecrc(val);
> >  	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, val);
> >  	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
> > @@ -336,7 +336,7 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
> >  			   upper_32_bits(cpu_addr));
> >  	dw_pcie_writel_dbi(pci, PCIE_ATU_LIMIT,
> >  			   lower_32_bits(limit_addr));
> > -	if (pci->version >= 0x460A)
> > +	if (pci->version >= DW_PCIE_VER_460A)
> >  		dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_LIMIT,
> >  				   upper_32_bits(limit_addr));
> >  	dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_TARGET,
> > @@ -345,9 +345,9 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
> >  			   upper_32_bits(pci_addr));
> >  	val = type | PCIE_ATU_FUNC_NUM(func_no);
> >  	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
> > -	    pci->version >= 0x460A)
> > +	    pci->version >= DW_PCIE_VER_460A)
> >  		val |= PCIE_ATU_INCREASE_REGION_SIZE;
> > -	if (pci->version == 0x490A)
> > +	if (pci->version == DW_PCIE_VER_490A)
> >  		val = dw_pcie_enable_ecrc(val);
> >  	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, val);
> >  	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, PCIE_ATU_ENABLE);
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index 7d6e9b7576be..5be43c662176 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -20,6 +20,14 @@
> >  #include <linux/pci-epc.h>
> >  #include <linux/pci-epf.h>
> >  

> > +/* DWC PCIe IP-core versions (native support since v4.70a) */
> > +#define DW_PCIE_VER_365A		0x3336352a
> > +#define DW_PCIE_VER_460A		0x3436302a
> > +#define DW_PCIE_VER_470A		0x3437302a
> > +#define DW_PCIE_VER_480A		0x3438302a
> > +#define DW_PCIE_VER_490A		0x3439302a
> > +#define DW_PCIE_VER_520A		0x3532302a
> 
> Create a macro to form these so we can do:
> 
> DW_PCIE_VER('5', '2', '0', 'A')

I am ok with that as long as you suggest to use it in the definition
of the macros above. Like this:

+#define DW_PCIE_VER_365A	__DW_PCIE_VER('3', '5', '6', '*')

otherwise if we used the macro suggested by you right in the code or
in the introduced further dw_pcie_ver_is() macros, the version
checking conditional statements turn into the much longer constructions.
I'd rather avoid that. So could you clarify what is the usage scenario
of the macro DW_PCIE_VER() suggested by you?

Please also note that mainly the DW PCIe (USB, SPI, *MAC, etc) FourCC
versions don't contain the letter symbols, but are enclosed with the
'*' symbol (see 0x2a ASCII code). So the 3.65a version isn't encoded
as 0x333635_61_, but as 0x333635_2a_. I don't know a real reasoning of
that, but can guess that the same version value might be used for the
series of releases like 3.65a, 4.65b, 4.65c, etc as some kind of
wildcard. Alas I don't have any non-'a' implementation of the Synopsys
IP-core to check that out.

-Sergey

> 
> > +
> >  /* Parameters for the waiting for link up routine */
> >  #define LINK_WAIT_MAX_RETRIES		10
> >  #define LINK_WAIT_USLEEP_MIN		90000
> > @@ -269,7 +277,7 @@ struct dw_pcie {
> >  	struct pcie_port	pp;
> >  	struct dw_pcie_ep	ep;
> >  	const struct dw_pcie_ops *ops;
> > -	unsigned int		version;
> > +	u32			version;
> >  	int			num_lanes;
> >  	int			link_gen;
> >  	u8			n_fts[2];
> > diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
> > index 5ba144924ff8..786af2ba379f 100644
> > --- a/drivers/pci/controller/dwc/pcie-intel-gw.c
> > +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
> > @@ -59,7 +59,7 @@
> >  #define RESET_INTERVAL_MS		100
> >  
> >  struct intel_pcie_soc {
> > -	unsigned int	pcie_ver;
> > +	u32	pcie_ver;
> >  };
> >  
> >  struct intel_pcie {
> > @@ -395,7 +395,7 @@ static const struct dw_pcie_host_ops intel_pcie_dw_ops = {
> >  };
> >  
> >  static const struct intel_pcie_soc pcie_data = {
> > -	.pcie_ver =		0x520A,
> > +	.pcie_ver =		DW_PCIE_VER_520A,
> >  };
> >  
> >  static int intel_pcie_probe(struct platform_device *pdev)
> > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> > index b1b5f836a806..6f1330ed63e5 100644
> > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > @@ -1981,7 +1981,7 @@ static int tegra194_pcie_probe(struct platform_device *pdev)
> >  	pci->ops = &tegra_dw_pcie_ops;
> >  	pci->n_fts[0] = N_FTS_VAL;
> >  	pci->n_fts[1] = FTS_VAL;
> > -	pci->version = 0x490A;
> > +	pci->version = DW_PCIE_VER_490A;
> >  
> >  	pp = &pci->pp;
> >  	pp->num_vectors = MAX_MSI_IRQS;
> > -- 
> > 2.35.1
> > 
