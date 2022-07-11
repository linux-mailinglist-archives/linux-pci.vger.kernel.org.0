Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2BB5709FB
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 20:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiGKSd5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 14:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiGKSd4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 14:33:56 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B29643F;
        Mon, 11 Jul 2022 11:33:39 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id n7so5733722ioo.7;
        Mon, 11 Jul 2022 11:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a7SPj/JcwiIibv/j3Xnv5Pkj9mSSAfyBYGS0cNpMSHk=;
        b=lSd/w448Y+T9TH1ASU7L2LFJH7EMkH8UMRSTX292IlCPiPvzs2TNFxr/enMZFGHchw
         vt/o/m6w41Rz8So73Diz28//ZuuTTG+98Pzknx+WoKZdtFq2houJocpWWcOdV0NQmwPy
         tI9uCBCIdpU7OlRa62y39TahBdIcDQ5l5fTkU7sfqGsPNW7FUcmNEgWwSKMRXE+QVstr
         MH4BUK8NChauNNY9Ly/OB57ya83mDcFfs50QEJfYDVh7M+2x17+3Cq0lpT9+WVKUtgxl
         uXbkPo4/yrhjejOvp1i8Rj1SGXPwoqM0E05r13lD7D/DdZLOrPGSAe5/6zNi3bPcZUQz
         JG+w==
X-Gm-Message-State: AJIora+jBSX9Y+dWh6ftGZUzucDTQ2B/7SDDMvYYqy3/eMHRWNOLyZgH
        7kn1L7RGbWTaGby7cGfC/g==
X-Google-Smtp-Source: AGRyM1tEMxhJw/w9P3ZNB04okY94YF2i/D+LdTVD/y9iPPFmUuC8Kj1e7N1ygZK07c1GV1OHRwCcQg==
X-Received: by 2002:a05:6638:1686:b0:33e:9977:2e1f with SMTP id f6-20020a056638168600b0033e99772e1fmr10688635jat.7.1657564418924;
        Mon, 11 Jul 2022 11:33:38 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id y24-20020a056602201800b0067b755b2546sm3887807iod.24.2022.07.11.11.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 11:33:38 -0700 (PDT)
Received: (nullmailer pid 47902 invoked by uid 1000);
        Mon, 11 Jul 2022 18:33:36 -0000
Date:   Mon, 11 Jul 2022 12:33:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        krzk+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 06/13] PCI: dwc: host: Read num-lanes property before
 host_init()
Message-ID: <20220711183336.GA4189538-robh@kernel.org>
References: <20220701085420.870306-1-yoshihiro.shimoda.uh@renesas.com>
 <20220701085420.870306-7-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701085420.870306-7-yoshihiro.shimoda.uh@renesas.com>
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

On Fri, Jul 01, 2022 at 05:54:13PM +0900, Yoshihiro Shimoda wrote:
> Vendor-specific initialization needs this information so that
> read it before host_init(). And then, we can assume that
> dw_pcie_{ep,host}_init() gets the property so that dw_pcie_setup()
> doesn't need to get it again.

Patches 5 and 6 should be combined.

We already have 2 drivers (keystone and tegra) that need this earlier 
still which this patch doesn't address. I think we need some sort of 
function to initialize the dw_pcie struct with defaults to be called 
after alloc or as part of alloc. To do the latter, there needs to be 
more unification on whether dw_pcie is a pointer or struct in the 
platform specific struct. That's a lot of churn though...

> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 2 ++
>  drivers/pci/controller/dwc/pcie-designware.c      | 1 -
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 1e3972c487b5..cf875bdcfabb 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -336,6 +336,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	if (pci->link_gen < 1)
>  		pci->link_gen = of_pci_get_max_link_speed(np);
>  
> +	of_property_read_u32(np, "num-lanes", &pci->num_lanes);
> +
>  	/* Set default bus ops */
>  	bridge->ops = &dw_pcie_ops;
>  	bridge->child_ops = &dw_child_pcie_ops;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index d92c8a25094f..101e892e22e8 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -726,7 +726,6 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  	val |= PORT_LINK_DLL_LINK_EN;
>  	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
>  
> -	of_property_read_u32(np, "num-lanes", &pci->num_lanes);
>  	if (!pci->num_lanes) {
>  		dev_dbg(pci->dev, "Using h/w default number of lanes\n");
>  		return;
> -- 
> 2.25.1
> 
> 
