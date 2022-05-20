Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CBA52EEAA
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 17:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350596AbiETPGO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 May 2022 11:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350595AbiETPGN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 11:06:13 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A952E9DC;
        Fri, 20 May 2022 08:06:11 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id v9so5614273oie.5;
        Fri, 20 May 2022 08:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MMzrxEofByja+qMgDSjgy43yQLfQq7Ckp2duOorHFa8=;
        b=gR+ffFHbTVFviwr8zEkdQhwdv01AZZ0F1p4AZlTRtlgC1kQkBoFFna+WFpJ6ILK9tj
         9WDMViKswqorkPWbM52W6b8CVTNbR2w/YS0fFyH2opCLkvkFEQIi+D4iJhF6PU0sMKWQ
         qQ8gAyu+5lsK+nQ0VJS+jED8KJ1IkxDsy43aHRx0dAJ93Gy95zLiZe8mRqQxIn7vCi0M
         gdz3Yqp7F5AQN+m0S53Ujxx+4351JT81D2DpIapVu7HzEV/Ikw57we25zGNmtmVJaCT1
         V32AXm1ryObcPCSpy721Ql1kkK+/FkApN3pVWhAqPwM4Frd98hm7w4g5r2YBfdYyK43O
         fx+g==
X-Gm-Message-State: AOAM532HYZxsJbBLKM9CDL9uTYaSECRrvEHMFckyz2l3AEfUhesHOE+T
        tXo4XeSYpMUVP0Ruzv0h7A==
X-Google-Smtp-Source: ABdhPJyDjyMabagci+qzfR5r1nT/tLH/Z2mobu3J0sl1sdPEQh5b1iEMdO7Ks9T0n2XCpPm3zQi2AQ==
X-Received: by 2002:a05:6808:3099:b0:32b:77c:669c with SMTP id bl25-20020a056808309900b0032b077c669cmr1094167oib.297.1653059171059;
        Fri, 20 May 2022 08:06:11 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h62-20020acab741000000b0032ae70865e3sm1094313oif.14.2022.05.20.08.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 08:06:10 -0700 (PDT)
Received: (nullmailer pid 3857203 invoked by uid 1000);
        Fri, 20 May 2022 15:06:09 -0000
Date:   Fri, 20 May 2022 10:06:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
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
Subject: Re: [PATCH v2 05/17] PCI: dwc: Convert to using native IP-core
 versions representation
Message-ID: <20220520150609.GA3853502-robh@kernel.org>
References: <20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru>
 <20220503214638.1895-6-Sergey.Semin@baikalelectronics.ru>
 <20220516203003.GB3209795-robh@kernel.org>
 <20220520092954.fz62wbrpj7qss6pj@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520092954.fz62wbrpj7qss6pj@mobilestation>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 20, 2022 at 12:29:54PM +0300, Serge Semin wrote:
> On Mon, May 16, 2022 at 03:30:03PM -0500, Rob Herring wrote:
> > On Wed, May 04, 2022 at 12:46:26AM +0300, Serge Semin wrote:
> > > Since DWC PCIe v4.70a the controller version can be read from the
> > > PORT_LOGIC.PCIE_VERSION_OFF register. Version is represented in the FourCC
> > > format [1]. It's standard versioning approach for the Synopsys DWC
> > > IP-cores. Moreover some of the DWC kernel drivers already make use of it
> > > to fixup version-dependent functionality (See DWC USB3, Stmicro STMMAC or
> > > recent DW SPI driver). In order to preserve the standard version
> > > representation and prevent the data conversion back and forth, we suggest
> > > to preserve the native version representation in the DWC PCIe driver too
> > > in the same way as it has already been done in the rest of the DWC
> > > drivers. IP-core version reading from the CSR will be introduced in the
> > > next commit together with a simple macro-based API to use it.
> > > 
> > > [1] https://en.wikipedia.org/wiki/FourCC
> > > 
> > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > ---
> > >  drivers/pci/controller/dwc/pci-keystone.c    | 12 ++++++------
> > >  drivers/pci/controller/dwc/pcie-designware.c |  8 ++++----
> > >  drivers/pci/controller/dwc/pcie-designware.h | 10 +++++++++-
> > >  drivers/pci/controller/dwc/pcie-intel-gw.c   |  4 ++--
> > >  drivers/pci/controller/dwc/pcie-tegra194.c   |  2 +-
> > >  5 files changed, 22 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> > > index d10e5fd0f83c..c51018c68b56 100644
> > > --- a/drivers/pci/controller/dwc/pci-keystone.c
> > > +++ b/drivers/pci/controller/dwc/pci-keystone.c
> > > @@ -109,7 +109,7 @@ struct ks_pcie_of_data {
> > >  	enum dw_pcie_device_mode mode;
> > >  	const struct dw_pcie_host_ops *host_ops;
> > >  	const struct dw_pcie_ep_ops *ep_ops;
> > > -	unsigned int version;
> > > +	u32 version;
> > >  };
> > >  
> > >  struct keystone_pcie {
> > > @@ -1069,19 +1069,19 @@ static int ks_pcie_am654_set_mode(struct device *dev,
> > >  
> > >  static const struct ks_pcie_of_data ks_pcie_rc_of_data = {
> > >  	.host_ops = &ks_pcie_host_ops,
> > > -	.version = 0x365A,
> > > +	.version = DW_PCIE_VER_365A,
> > >  };
> > >  
> > >  static const struct ks_pcie_of_data ks_pcie_am654_rc_of_data = {
> > >  	.host_ops = &ks_pcie_am654_host_ops,
> > >  	.mode = DW_PCIE_RC_TYPE,
> > > -	.version = 0x490A,
> > > +	.version = DW_PCIE_VER_490A,
> > >  };
> > >  
> > >  static const struct ks_pcie_of_data ks_pcie_am654_ep_of_data = {
> > >  	.ep_ops = &ks_pcie_am654_ep_ops,
> > >  	.mode = DW_PCIE_EP_TYPE,
> > > -	.version = 0x490A,
> > > +	.version = DW_PCIE_VER_490A,
> > >  };
> > >  
> > >  static const struct of_device_id ks_pcie_of_match[] = {
> > > @@ -1114,12 +1114,12 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
> > >  	struct device_link **link;
> > >  	struct gpio_desc *gpiod;
> > >  	struct resource *res;
> > > -	unsigned int version;
> > >  	void __iomem *base;
> > >  	u32 num_viewport;
> > >  	struct phy **phy;
> > >  	u32 num_lanes;
> > >  	char name[10];
> > > +	u32 version;
> > >  	int ret;
> > >  	int irq;
> > >  	int i;
> > > @@ -1233,7 +1233,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
> > >  		goto err_get_sync;
> > >  	}
> > >  
> > > -	if (pci->version >= 0x480A)
> > > +	if (pci->version >= DW_PCIE_VER_480A)
> > >  		ret = ks_pcie_am654_set_mode(dev, mode);
> > >  	else
> > >  		ret = ks_pcie_set_mode(dev);
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > index 1682f477bf20..3ebb7bfee10f 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > @@ -289,7 +289,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
> > >  	val = type | PCIE_ATU_FUNC_NUM(func_no);
> > >  	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr))
> > >  		val |= PCIE_ATU_INCREASE_REGION_SIZE;
> > > -	if (pci->version == 0x490A)
> > > +	if (pci->version == DW_PCIE_VER_490A)
> > >  		val = dw_pcie_enable_ecrc(val);
> > >  	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, val);
> > >  	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
> > > @@ -336,7 +336,7 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
> > >  			   upper_32_bits(cpu_addr));
> > >  	dw_pcie_writel_dbi(pci, PCIE_ATU_LIMIT,
> > >  			   lower_32_bits(limit_addr));
> > > -	if (pci->version >= 0x460A)
> > > +	if (pci->version >= DW_PCIE_VER_460A)
> > >  		dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_LIMIT,
> > >  				   upper_32_bits(limit_addr));
> > >  	dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_TARGET,
> > > @@ -345,9 +345,9 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
> > >  			   upper_32_bits(pci_addr));
> > >  	val = type | PCIE_ATU_FUNC_NUM(func_no);
> > >  	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
> > > -	    pci->version >= 0x460A)
> > > +	    pci->version >= DW_PCIE_VER_460A)
> > >  		val |= PCIE_ATU_INCREASE_REGION_SIZE;
> > > -	if (pci->version == 0x490A)
> > > +	if (pci->version == DW_PCIE_VER_490A)
> > >  		val = dw_pcie_enable_ecrc(val);
> > >  	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, val);
> > >  	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, PCIE_ATU_ENABLE);
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > index 7d6e9b7576be..5be43c662176 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > @@ -20,6 +20,14 @@
> > >  #include <linux/pci-epc.h>
> > >  #include <linux/pci-epf.h>
> > >  
> > > +/* DWC PCIe IP-core versions (native support since v4.70a) */
> > > +#define DW_PCIE_VER_365A		0x3336352a
> > > +#define DW_PCIE_VER_460A		0x3436302a
> > > +#define DW_PCIE_VER_470A		0x3437302a
> > > +#define DW_PCIE_VER_480A		0x3438302a
> > > +#define DW_PCIE_VER_490A		0x3439302a
> > > +#define DW_PCIE_VER_520A		0x3532302a
> > > +
> > >  /* Parameters for the waiting for link up routine */
> > >  #define LINK_WAIT_MAX_RETRIES		10
> > >  #define LINK_WAIT_USLEEP_MIN		90000
> > > @@ -269,7 +277,7 @@ struct dw_pcie {
> > >  	struct pcie_port	pp;
> > >  	struct dw_pcie_ep	ep;
> > >  	const struct dw_pcie_ops *ops;
> > > -	unsigned int		version;
> > > +	u32			version;
> > >  	int			num_lanes;
> > >  	int			link_gen;
> > >  	u8			n_fts[2];
> > > diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
> > > index 5ba144924ff8..786af2ba379f 100644
> > > --- a/drivers/pci/controller/dwc/pcie-intel-gw.c
> > > +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
> > > @@ -59,7 +59,7 @@
> > >  #define RESET_INTERVAL_MS		100
> > >  
> > >  struct intel_pcie_soc {
> > > -	unsigned int	pcie_ver;
> > > +	u32	pcie_ver;
> > 
> 
> > This is not used by the Intel driver code, but just passed to the DWC 
> > core code. Given that and that the IP version is new enough, this should 
> > be removed one the detection is in place.
> 
> Ok. I'll drop it in an additional patch placed after the version
> detection patch in the series. What about the Tegra 194 code? Shall I
> drop it from there too? I've got DW PCIe 4.90a reference manual here.
> It states there are the PCIE_VERSION_NUMBER_OFF and
> PCIE_VERSION_TYPE_OFF registers in the port logic reg space. So the
> removal shall not cause problems.

Yes, anywhere we can remove it would be good.

Rob
