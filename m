Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717EA55C2E9
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 14:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245699AbiF1GkB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 02:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245187AbiF1GkA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 02:40:00 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6AF65E5
        for <linux-pci@vger.kernel.org>; Mon, 27 Jun 2022 23:39:59 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 128so11106980pfv.12
        for <linux-pci@vger.kernel.org>; Mon, 27 Jun 2022 23:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tWeL+6Op+8SkPZGyAkSq9BLF4raBe7hD6vaAKPjqmDw=;
        b=U6cbQkP4ATNqQ+G3LVFzhHMjY0u19ErYheF8LJ1Klfl5QruEph//ljivWd/INMN1W5
         wDetdCoMBJoOvZV9lAr4n3rO9tqoEkFGH0lpQCpxgVyGdf6ggd4H6qgAd1Bbe/POxXcW
         Tbowv7+TRqrPx5BztFHA2TipeLC89yqZgSlMqSP8/VOsg5oWQVUfWDWC74rEwP/UKbUb
         jbY4yi/bkqlgz6Jib4eWRAAuj+KCup1aHHSA07m8EKNssqRhGc/XYImNe1m/GtpnsGgY
         9+qVqTnsaQ9v6b7s4NDfkB40NnQgxbaHfjr2b0AIqGPIqmPChsP+pkAijZQZA+1AofQa
         AsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tWeL+6Op+8SkPZGyAkSq9BLF4raBe7hD6vaAKPjqmDw=;
        b=qmtVyeK5uyWLgFc3WUKRN557GIBov/yWrENhX3Bm4dLMEOMJKNNunh00n5/2NwAVDU
         rSMxWOWG6xXPtQY4DprGlInkJ2UbVfCJXBO5O/opyndogVx4hgxLYq1vZqDtoAZfYEeL
         r4DrP2tpJq5i2D3c3prlaEvGXv/ng5MSnjEWNmSc+mCCNrag9JPIeTd22tAaapJbjCDE
         RfJr0Pjos8tA//MvzZfuwETbzMq4daUS3mdVedD5tYKl3rg/Sj3bUVtL94wzz2QMYa8y
         P6UjOJdCZ2JuzA+zFBF/kDLtwWO56qe0BiXtap7aMWwN+S7JGKV7ZGeW4iqxbttGdzvg
         e0Ig==
X-Gm-Message-State: AJIora/kSlDrOrqINYszTqbbIaxA3KfdGYGltO2RXLlHK8FtOvyShmVC
        TDq94830OfSeruOTxlO5Iw5u
X-Google-Smtp-Source: AGRyM1vWRIs4ATJi2e5H8aoCNvIcVxHPsHaCZqUPQC3DNYS46OluV/Mz9puFwY2T4h9I+kKd0/noqw==
X-Received: by 2002:a63:9d88:0:b0:40c:9c4d:29ba with SMTP id i130-20020a639d88000000b0040c9c4d29bamr16703568pgd.590.1656398399387;
        Mon, 27 Jun 2022 23:39:59 -0700 (PDT)
Received: from thinkpad ([27.111.75.159])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b001622c377c3esm8342531plb.117.2022.06.27.23.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 23:39:59 -0700 (PDT)
Date:   Tue, 28 Jun 2022 12:09:54 +0530
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
        Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5 12/18] PCI: dwc: Re-use local pointer to the
 resource data
Message-ID: <20220628063954.GE23601@thinkpad>
References: <20220624143428.8334-1-Sergey.Semin@baikalelectronics.ru>
 <20220624143428.8334-13-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220624143428.8334-13-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 24, 2022 at 05:34:22PM +0300, Serge Semin wrote:
> The dw_pcie_host_init() method has two instances of the resource structure
> pointers used in non-related places of the method. It's pointless to have
> two different local storages for them since the corresponding code is
> small and having resource specific names doesn't make it more readable.
> Let's convert these parts of the function to using just a common pointer
> to the resource structure instance. That shall make the code a bit nicer
> looking.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> ---
> 
> Changelog v4:
> - This is a new patch created on the v4 lap of the series.
> ---
>  .../pci/controller/dwc/pcie-designware-host.c    | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 54257874c154..2f13eec4812d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -293,17 +293,17 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct resource_entry *win;
>  	struct pci_host_bridge *bridge;
> -	struct resource *cfg_res;
> +	struct resource *res;
>  	int ret;
>  
>  	raw_spin_lock_init(&pp->lock);
>  
> -	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
> -	if (cfg_res) {
> -		pp->cfg0_size = resource_size(cfg_res);
> -		pp->cfg0_base = cfg_res->start;
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
> +	if (res) {
> +		pp->cfg0_size = resource_size(res);
> +		pp->cfg0_base = res->start;
>  
> -		pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, cfg_res);
> +		pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
>  		if (IS_ERR(pp->va_cfg0_base))
>  			return PTR_ERR(pp->va_cfg0_base);
>  	} else {
> @@ -312,8 +312,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	}
>  
>  	if (!pci->dbi_base) {
> -		struct resource *dbi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> -		pci->dbi_base = devm_pci_remap_cfg_resource(dev, dbi_res);
> +		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> +		pci->dbi_base = devm_pci_remap_cfg_resource(dev, res);
>  		if (IS_ERR(pci->dbi_base))
>  			return PTR_ERR(pci->dbi_base);
>  	}
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
