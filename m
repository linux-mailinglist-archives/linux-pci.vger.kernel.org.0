Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEFC4EAFF4
	for <lists+linux-pci@lfdr.de>; Tue, 29 Mar 2022 17:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238319AbiC2PKr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Mar 2022 11:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238318AbiC2PKl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2022 11:10:41 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F89C203A6B;
        Tue, 29 Mar 2022 08:08:57 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-d39f741ba0so18992548fac.13;
        Tue, 29 Mar 2022 08:08:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9MI9Y0hjLEdGkyBn4a4gJ7Wyi0ARALBjm+l4Te7k6eY=;
        b=rt+pi0heUTMFlD3lSIoBTXXHeO9bYGwc/dHBsA0GoEbjCw1g9TjfHyHNIbnWBaP/oR
         +awkseq5+l7PTjuEx/5pkdouqzYCBZe+1bNOavfVshq9roa6HullT9YWOk4IjW4274As
         HU9exJOTzNM9AZPeN62MN5Wtu7DvC/Ax1oglSj8MHS3lRlclxzaP+4k0wpfgZHMHZOgt
         TD0mOWvNJl4khK6wgFq74/SkyIajpK+rv5wzhzlR0uAOUtcnJag5uWg6Pne+nAsUqdqV
         5tjqCu0tHu8xK7a2GfPImxUWiAsCeS6ZfZ6gyZtbTuoJXZ50hiZyVF47W8kHP/Bm8bYL
         G00Q==
X-Gm-Message-State: AOAM532j/ZTECFkpRN66voVlsAoLcd7IhBRvoE0NZOiSZMzxwI83Oikc
        518t12we3pMwaIkRFfb4jg==
X-Google-Smtp-Source: ABdhPJzRxexG0L1mdf99NN5f59K5nX3DNtXTbLk6WqzsW6LOT2KNboRu9Ho4Ve3cYaW1RXUHrNkTOw==
X-Received: by 2002:a05:6870:461d:b0:de:4705:7fe8 with SMTP id z29-20020a056870461d00b000de47057fe8mr29959oao.221.1648566536694;
        Tue, 29 Mar 2022 08:08:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g8-20020a9d2d88000000b005b238f7551csm8724772otb.53.2022.03.29.08.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 08:08:55 -0700 (PDT)
Received: (nullmailer pid 680061 invoked by uid 1000);
        Tue, 29 Mar 2022 15:08:53 -0000
Date:   Tue, 29 Mar 2022 10:08:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/16] PCI: dwc: Add IP-core version detection procedure
Message-ID: <YkMhBdrd9Bq4hzjq@robh.at.kernel.org>
References: <20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru>
 <20220324013734.18234-6-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324013734.18234-6-Sergey.Semin@baikalelectronics.ru>
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

On Thu, Mar 24, 2022 at 04:37:23AM +0300, Serge Semin wrote:
> Since DWC PCIe v4.70a the controller version and version type can be read
> from the PORT_LOGIC.PCIE_VERSION_OFF and PORT_LOGIC.PCIE_VERSION_TYPE_OFF
> registers respectively. Seeing the generic code has got version-dependent
> parts let's use these registers to find out the controller version.  The
> detection procedure is executed for both RC and EP modes right after the
> platform-specific initialization. We can't do that earlier since the
> glue-drivers can perform the DBI-related setups there including the bus
> reference clocks activation, without which the CSRs just can't be read.
> 
> Note the CSRs content is zero on the older DWC PCIe controller. In that
> case we have no choice but to rely on the platform setup.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   |  2 ++
>  .../pci/controller/dwc/pcie-designware-host.c |  2 ++
>  drivers/pci/controller/dwc/pcie-designware.c  | 24 +++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h  |  6 +++++
>  4 files changed, 34 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 7c9315fffe24..3b981d13cca9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -645,6 +645,8 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
>  	u32 reg;
>  	int i;
>  
> +	dw_pcie_version_detect(pci);
> +
>  	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE) &
>  		   PCI_HEADER_TYPE_MASK;
>  	if (hdr_type != PCI_HEADER_TYPE_NORMAL) {
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 8364ea234e88..8f0d473ff770 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -398,6 +398,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  		}
>  	}
>  
> +	dw_pcie_version_detect(pci);
> +
>  	dw_pcie_iatu_detect(pci);
>  
>  	dw_pcie_setup_rc(pp);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index c21373c6cb51..49c494d82042 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -16,6 +16,30 @@
>  #include "../../pci.h"
>  #include "pcie-designware.h"
>  
> +void dw_pcie_version_detect(struct dw_pcie *pci)
> +{
> +	u32 ver;
> +
> +	/* The content of the CSR is zero on DWC PCIe older than v4.70a */
> +	ver = dw_pcie_readl_dbi(pci, PCIE_VERSION_NUMBER);
> +	if (!ver)
> +		return;
> +
> +	if (pci->version && pci->version != ver)
> +		dev_warn(pci->dev, "Versions don't match (%08x != %08x)\n",
> +			 pci->version, ver);

Trust the h/w is correct until we have a known case where it isn't. Just 
read the h/w reg if pci->version is zero.

I would suspect as-is this will give some warnings. No doubt there is 
some platform with multiple revs of Si that didn't change their version 
in the driver. Or the author just guessed on the version that picked the 
right paths in the driver.

Rob
