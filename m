Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BB64E632C
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 13:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346378AbiCXMWN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 08:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348354AbiCXMWM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 08:22:12 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F393264BCD
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 05:20:39 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id w7so1183471pfu.11
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 05:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Sq7j6iSxRKK6Kt1JbPBxrMzpPU1BHoXKoWT5K0bHTLw=;
        b=vS85uYfJPAX+A1dJ4gU9kCAk0U40hRffDI5iNQYRVejKhSQK3EwdsUigFOetgmPdtP
         t5bjTwyxR92DDPn31LQyTEq6Lu8Sb5P0S9KlZjQVDLBAx3xeLfui/S0W2OgOvxVhYcUo
         K3n7hWBES7FCmMj18E94Nwj6w7q+xg1gVXM51bOHJ0WLz/fX3mVxlFxovnoFECkLbg0q
         y8H1x0vbsoERo9WKoNhVQAH03XnnDa8nWZi7vy849K0h1H3bvN1K9wdodykiCA8JIbtc
         cvRAfJQ0B3ohZjxQ5Abc+U4u6y3aRPOFupYVoUm96lpPYC/yLrN+Tqx6Ti8rM5kJz7On
         oi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sq7j6iSxRKK6Kt1JbPBxrMzpPU1BHoXKoWT5K0bHTLw=;
        b=vXfNb+bdWX3CM4xe7Rcx76SGAPHLnf2ieNhDnYAfZTetME6vxFcvtK9r2Fa3zcrzxS
         1yvjKxlCTgp9xXOeooXl2qYat3YrJUAdgLztPnADE5WcpdtLGIgXfUW7yJ0KiFswhN4a
         AYL4zAG2GgaLp5h5mejItAT59bEzwKu7ZkOQ8Xnib6s40cYXHzK8PGnElwMJE/XiLEvV
         +Gn3bMhOhwxFUtGmvvJGWssiCHEkakiddM4DtyxL5t2UWajue0chRuPg0wtnNvj9GNnm
         xxrBvZ0T8DTK85fYPV++11hYjACar2hK4X118OEQIQZXoSXQyDcoql18kLBOZfws7Ur+
         UIRw==
X-Gm-Message-State: AOAM531D7kkFAUrdRaQRc1N/5vOjVEY8Kp0MP61Jvw5ACVDOWEsy17cN
        N3G4cnmZKsllJGxOsARQ35UaAxQgGj/X
X-Google-Smtp-Source: ABdhPJyL5lAjJysSfFyqGKp96Br+RyUoZouCYPycoRDcyoOS2b+vQe2+uGP1i8f5KOxwOc+wezjKfw==
X-Received: by 2002:a65:5a82:0:b0:386:f95:40fd with SMTP id c2-20020a655a82000000b003860f9540fdmr3921405pgt.256.1648124439393;
        Thu, 24 Mar 2022 05:20:39 -0700 (PDT)
Received: from thinkpad ([220.158.158.107])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090ad20600b001b8d01566ccsm9309426pju.8.2022.03.24.05.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 05:20:39 -0700 (PDT)
Date:   Thu, 24 Mar 2022 17:50:34 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] PCI: dwc: Convert Link-up status method to using
 dw_pcie_readl_dbi()
Message-ID: <20220324122034.GI2854@thinkpad>
References: <20220324012524.16784-1-Sergey.Semin@baikalelectronics.ru>
 <20220324012524.16784-10-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324012524.16784-10-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 24, 2022 at 04:25:20AM +0300, Serge Semin wrote:
> While the rest of the generic DWC PCIe code is using the dedicated IO-mem
> accessors, the dw_pcie_link_up() method for some unobvious reason directly
> calls readl() to get PortLogic.DEBUG1 register content. Since the way the
> dbi-bus is accessed can be platform-specific let's replace the direct dbi
> memory space read procedure with the readl-wrapper invocation. Thus we'll
> have a slightly more generic dw_pcie_link_up() method.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index e3d2c11e6998..6e81264fdfb4 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -548,7 +548,7 @@ int dw_pcie_link_up(struct dw_pcie *pci)
>  	if (pci->ops && pci->ops->link_up)
>  		return pci->ops->link_up(pci);
>  
> -	val = readl(pci->dbi_base + PCIE_PORT_DEBUG1);
> +	val = dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG1);
>  	return ((val & PCIE_PORT_DEBUG1_LINK_UP) &&
>  		(!(val & PCIE_PORT_DEBUG1_LINK_IN_TRAINING)));
>  }
> -- 
> 2.35.1
> 
