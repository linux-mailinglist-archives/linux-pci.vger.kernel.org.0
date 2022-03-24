Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3914E6351
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 13:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347602AbiCXM2b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 08:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350185AbiCXM17 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 08:27:59 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F948CCE9
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 05:26:28 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n18so4532995plg.5
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 05:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8xPB47npQGsnbqow09+7e0pd72NIwb8sCoRSdsw0rcA=;
        b=vrJr+tlTZcRn5istxlaDHcI6wE1uChrM30Js6/44rpTdqQoJs1Vy/K91SMYxMyMA+R
         aRumGVFQQFXUpQ0nGGkqSAQ+KqiAAJEu6hJTyzqomEqxw7FiRyepEsR3+yW1j4BGQxo4
         lfT8PxjtvShOtxu0N8Zw01dcp4QyKfW9/XKJu3kdt8ghAU1R9LyuFc8gJchfzovACGvB
         aVqTqb8U4dLAzNTz3HRe+ZFOoW7wg8fMdM/O9Tp9AI8p2fuuNo2w8VxCzRqN9djd7nzG
         lcs0ihtcWtR8fT5ukAfP1pGloGIQyLbPLVT8aHQzYHjy2/am/GRYK4KGR8kMnHJANEEq
         1PJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8xPB47npQGsnbqow09+7e0pd72NIwb8sCoRSdsw0rcA=;
        b=xtkbUX1cKmecwD0rmgM6wYKQ/q+8VqRGtK1LxHHp7jraD4kjAKF62cevtVGAoXMz5X
         gKzUsYzOYEREaQ+qPI2hF7NIoh1CUwmyqFQx1F/BryDdCCEChlFT7JhUw50SvzRuVC5P
         LdykxT/mLZKeUSxBLgjlB6MYOy2eH+v85XU8rkxtfmb+fRZnNoXB5BD9xAj78Uc1jxFg
         2i3kMRYdu52OavX1X/Vl56WMsaV6PNeYSXvUUeCVieF50/wC4k//EQH322ILM/yNB4bd
         Hk+Iy9enaca8IbodvqxSXlpqTx4p9DqVE4lPXziHETjV/tE2MeyMew71YNVPY/ZD6oJH
         6rJA==
X-Gm-Message-State: AOAM530+zjrTNtxeA5yDrQCN4uu18iccJ5MwTOHF6VPVbR55xW9n8Yzm
        0tLxyDlUXqL6AqkkJUJX9H7c
X-Google-Smtp-Source: ABdhPJwER0TSTDdBy2gEGVCvbb9B0sORoebwMAZCAoXFYk5F/lfONzwOdTpCjbj5Hhm1rdprbaSdrg==
X-Received: by 2002:a17:903:1210:b0:151:fa59:95ef with SMTP id l16-20020a170903121000b00151fa5995efmr5788482plh.57.1648124787671;
        Thu, 24 Mar 2022 05:26:27 -0700 (PDT)
Received: from thinkpad ([220.158.158.107])
        by smtp.gmail.com with ESMTPSA id ep2-20020a17090ae64200b001c6a7c22aedsm2753630pjb.37.2022.03.24.05.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 05:26:27 -0700 (PDT)
Date:   Thu, 24 Mar 2022 17:56:21 +0530
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
Subject: Re: [PATCH 12/12] PCI: dwc-plat: Drop dw_plat_pcie_of_match forward
 declaration
Message-ID: <20220324122621.GL2854@thinkpad>
References: <20220324012524.16784-1-Sergey.Semin@baikalelectronics.ru>
 <20220324012524.16784-13-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324012524.16784-13-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 24, 2022 at 04:25:23AM +0300, Serge Semin wrote:
> The denoted forward declaration used to be required to get the OF-device
> ID structure by calling the of_match_device() method. The later method
> invocation has been replaced with the of_device_get_match_data() call in
> the commit 5c204204cf24 ("PCI: designware-plat: Prefer
> of_device_get_match_data()"). Thus the forward declaration of the
> OF-compatible device strings no longer needed. Drop it for good.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/pci/controller/dwc/pcie-designware-plat.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
> index 99cf2ac5b0ba..e606c5d5f06f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-plat.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
> @@ -29,8 +29,6 @@ struct dw_plat_pcie_of_data {
>  	enum dw_pcie_device_mode	mode;
>  };
>  
> -static const struct of_device_id dw_plat_pcie_of_match[];
> -
>  static const struct dw_pcie_host_ops dw_plat_pcie_host_ops = {
>  };
>  
> -- 
> 2.35.1
> 
