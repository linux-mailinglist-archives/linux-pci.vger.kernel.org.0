Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4F94E60C7
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 10:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344534AbiCXJBg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 05:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237104AbiCXJBf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 05:01:35 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F09972E1
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 02:00:03 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y10so142529pfa.7
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 02:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=moE3lhU0orNGD+WYGUFvC/ixbs2Ayr8MA1pW3p2i+Qk=;
        b=SDoW7fqkMXkislH4O/hYEdTxz9Mj5AMwSIlbKlbtSyBWKa8f9DFgalAzC7VYHFHuJD
         /w5ePUPZ8qJ2RSzubJNGPj8CbSOL72E8pg4dKEe/8fNot4iREXkg0Z8oHpTW0SlS7g1y
         8uH8of7NcRnK9fFJAiDbHo3T50srUtDnQuUs4VxdSI3U51puSO92+H1jwQ7fodwbP2MN
         9BkzxZQTakklDJSt/CuAxT0LjpRUvXE332nKzr9olrVKLKEuxCQtOc0DF0/nPYER0AK0
         1QOvP5a8zoNIVbeHtfwK8HaV2meRU0UYrlAnncXp4wFmM4OatVb8JkEa+/hHU2U2H8XJ
         7vMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=moE3lhU0orNGD+WYGUFvC/ixbs2Ayr8MA1pW3p2i+Qk=;
        b=jhlwQpeIH09z1WUBQIyEGBVhbM4oOJDXiZHj3qve+tolrFelsXzqg8ISlckfhGO1mL
         5Bfk0rpKlT7pNruvbJSatEX9/k1xaZI/pKnM9MAiGv3eu3xz7FvRrvzCNGFKmmJltkNo
         /i8vycZCCoYEV2UZeUMfX6eqIlpIz9jDLwn7bbp1x24jp/B+WGWgaAafICXFo272XOOy
         /wodCuS51YdInKMZmq+n46PAukaop1xywMh2JviPkLoO6xKhL0UPgSdBGfdZeVV3itzx
         2moZLFiCxL8u2Rp40KpozURUr9zJyF8/lRJcf+F1SfFY6WwDQEFagNZ08eYo5QpnDJKj
         zYBg==
X-Gm-Message-State: AOAM533GLHRWFy/P0d+b4XES4k/Xd9tJQ2Hx3Ehe8puKy0ItdhFqPh/7
        RSIrvJV094+95uwrN/o8INoQ
X-Google-Smtp-Source: ABdhPJwoROpeTysCOTaYFdASklJVDFj2JvTNVBcuXGLFinXIxKl8+v+AOv9IrUC9rqMamZVGtXq6nQ==
X-Received: by 2002:a05:6a00:711:b0:4fa:daf1:94c1 with SMTP id 17-20020a056a00071100b004fadaf194c1mr4025286pfl.52.1648112402841;
        Thu, 24 Mar 2022 02:00:02 -0700 (PDT)
Received: from thinkpad ([220.158.158.107])
        by smtp.gmail.com with ESMTPSA id k11-20020a056a00168b00b004f7e1555538sm2729029pfc.190.2022.03.24.01.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 02:00:02 -0700 (PDT)
Date:   Thu, 24 Mar 2022 14:29:56 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] PCI: dwc: Add unroll iATU space support to the
 regions disable method
Message-ID: <20220324085956.GC2854@thinkpad>
References: <20220324012524.16784-1-Sergey.Semin@baikalelectronics.ru>
 <20220324012524.16784-4-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324012524.16784-4-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 24, 2022 at 04:25:14AM +0300, Serge Semin wrote:
> The dw_pcie_disable_atu() method was introduced in the commit f8aed6ec624f
> ("PCI: dwc: designware: Add EP mode support"). Since then it hasn't
> changed at all.  For all that time the method has supported the viewport
> version of the iATU CSRs only. Basically it works for the DW PCIe IP-cores
> older than v4.80a since the newer controllers are equipped with the
> unrolled iATU/eDMA space. It means the methods using it like
> pci_epc_ops.clear_bar and pci_epc_ops.unmap_addr callbacks just don't work
> correctly for the DW PCIe controllers with unrolled iATU CSRs. The same
> concerns the dw_pcie_setup_rc() method, which disables the outbound iATU
> entries before re-initializing them.
> 
> So in order to fix the problems denoted above let's convert the
> dw_pcie_disable_atu() method to disabling the iATU inbound and outbound
> regions in the unrolled iATU CSRs in case the DW PCIe controller has been
> synthesized with the ones support. The former semantics will be remained
> for the controller having iATU mapped over the viewport.
> 
> Fixes: f8aed6ec624f ("PCI: dwc: designware: Add EP mode support")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index d92c8a25094f..7dc8c360a0d4 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -504,8 +504,18 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
>  		return;
>  	}
>  
> -	dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, region | index);
> -	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, ~(u32)PCIE_ATU_ENABLE);
> +	if (pci->iatu_unroll_enabled) {
> +		if (region == PCIE_ATU_REGION_INBOUND) {
> +			dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
> +						 ~(u32)PCIE_ATU_ENABLE);
> +		} else {
> +			dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
> +						 ~(u32)PCIE_ATU_ENABLE);
> +		}
> +	} else {
> +		dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, region | index);
> +		dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, ~(u32)PCIE_ATU_ENABLE);
> +	}
>  }
>  
>  int dw_pcie_wait_for_link(struct dw_pcie *pci)
> -- 
> 2.35.1
> 
