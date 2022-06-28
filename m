Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67D955D734
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbiF1Ghc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 02:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245649AbiF1GhV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 02:37:21 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B4E63C5
        for <linux-pci@vger.kernel.org>; Mon, 27 Jun 2022 23:37:20 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id w19-20020a17090a8a1300b001ec79064d8dso14856488pjn.2
        for <linux-pci@vger.kernel.org>; Mon, 27 Jun 2022 23:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MqYzMC6Te7mlb10SfH+/fm3WKhKw2/0wG3c+ugfn1go=;
        b=VYt1p89pFqNN9bWhxz+uiIHDDeaKUiThIHYcnA3b6Q4sCoqKFrmOFAxouoIAWIxv44
         oq8cvexu8JvcOLvcIXP9I5RyTGv362pdNfYZwTygLrkaEqO638k0VWF/o9Wpm055Bg10
         DnYSOANLA9hPxynYyV5/H3G6vOZtIGGi5PszUJGmZa3X/BHzrlE+Kot5hiYhV+MPO2Fx
         K2boW1z1Bk1hZevFYBwwCsKiCfNxz7b4chZ9GVKugCHC5vfweIK4+3/3PnFMqOAR62LX
         6ZOKltumQ1QVzeIrVzrPG3tKmfA3UmRUGnkNK2JEo+sZix5pdW5+siZZ5Ur7hrvMc31h
         zUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MqYzMC6Te7mlb10SfH+/fm3WKhKw2/0wG3c+ugfn1go=;
        b=jrW0kMvNQu69ZUkrE7rYFcRpnc5kT/zfxbwMJq62xZmCZK/TJKM+1ZSBynmiJt7VXa
         qXqwGT/nNxx6xK6zXNtmtj/euMKzP/G5sysWHijOAthq93ZEmcaClrHKIZ9uVE2MX7kd
         dLJeq5rRS60/shFpuVbZebks2sGKgkq4rfQGy+x98RqjLn0JcpZQtQ/rKKERUNSIpOxa
         agJEyx408eEhr3CnFBzPbJjeDj4G2dkaTWNTUboIh56+p2Pa11jsSgCt+W3rF36MOQjd
         I0c6J27RuJtz1GmpwYDkvseC0YuvLIvkmdezZZeh3VkxQHGkpk66W+Ui4tpEyIrq9PfF
         ht6g==
X-Gm-Message-State: AJIora8/4sIRHiCKK6GAkbz0TIUnX39h18xSGhPemQA5XF1SF/ojD2ed
        VjySNzfZ/NTrdAtFFMjeIIXy
X-Google-Smtp-Source: AGRyM1vJHZiVEQTsGRo0ArrFYMPWcuuPYuc/iE6XO49ONg9YiUMf82xLNF5Fiq6EeD6/DYROMCi4Kg==
X-Received: by 2002:a17:902:c948:b0:16a:58f4:c142 with SMTP id i8-20020a170902c94800b0016a58f4c142mr2168340pla.103.1656398239965;
        Mon, 27 Jun 2022 23:37:19 -0700 (PDT)
Received: from thinkpad ([27.111.75.159])
        by smtp.gmail.com with ESMTPSA id x5-20020a1709029a4500b001678e9670d8sm8388858plv.2.2022.06.27.23.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 23:37:19 -0700 (PDT)
Date:   Tue, 28 Jun 2022 12:07:14 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Thierry Reding <treding@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5 06/18] PCI: dwc: Enable CDM-check independently
 from the num_lanes value
Message-ID: <20220628063714.GC23601@thinkpad>
References: <20220624143428.8334-1-Sergey.Semin@baikalelectronics.ru>
 <20220624143428.8334-7-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220624143428.8334-7-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 24, 2022 at 05:34:16PM +0300, Serge Semin wrote:
> Currently the embedded CDM IOs consistency check-engine is enabled only if
> the num_lanes field of dw_pcie structure is set to non-zero value. It's
> definitely wrong since the CDM checking has nothing to do with the PCIe
> lanes settings, while that feature will be left disabled for the platforms
> which expect it being enabled and prefer keeping the default lanes setup.
> Let's fix that by enabling the CDM-check feature before the num_lanes
> parameter is handled.
> 
> Fixes: 07f123def73e ("PCI: dwc: Add support to enable CDM register check")

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> ---
> 
> Changelog v4:
> - This is a new patch created on v4 lap of the series.
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 347251bf87d0..5848cc520b52 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -740,6 +740,13 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  	val |= PORT_LINK_DLL_LINK_EN;
>  	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
>  
> +	if (of_property_read_bool(np, "snps,enable-cdm-check")) {
> +		val = dw_pcie_readl_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS);
> +		val |= PCIE_PL_CHK_REG_CHK_REG_CONTINUOUS |
> +		       PCIE_PL_CHK_REG_CHK_REG_START;
> +		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
> +	}
> +
>  	of_property_read_u32(np, "num-lanes", &pci->num_lanes);
>  	if (!pci->num_lanes) {
>  		dev_dbg(pci->dev, "Using h/w default number of lanes\n");
> @@ -786,11 +793,4 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  		break;
>  	}
>  	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> -
> -	if (of_property_read_bool(np, "snps,enable-cdm-check")) {
> -		val = dw_pcie_readl_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS);
> -		val |= PCIE_PL_CHK_REG_CHK_REG_CONTINUOUS |
> -		       PCIE_PL_CHK_REG_CHK_REG_START;
> -		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
> -	}
>  }
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
