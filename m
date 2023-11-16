Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A487EDB8B
	for <lists+linux-pci@lfdr.de>; Thu, 16 Nov 2023 07:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjKPGaI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Nov 2023 01:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjKPGaH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Nov 2023 01:30:07 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6702D127
        for <linux-pci@vger.kernel.org>; Wed, 15 Nov 2023 22:30:03 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-66cfd874520so2412596d6.2
        for <linux-pci@vger.kernel.org>; Wed, 15 Nov 2023 22:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700116202; x=1700721002; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PB/tb7x/wwBfMXKFlAwdEXt9fJqb2hzUXhb3693FMFI=;
        b=pM70wgon19wcKb2jRCMBD6WKF4W4YezlxwnqWKgKbq36CTXgbzotfjlsyDcYK/tC6o
         M8JSRRdCTO6W90KL4Rnpuh1Yb0ja6wLMr+dZjeo+k4EjLiE7K/fJyhGCfqq/A1JoD1nL
         aG8beuDtlDLyEJBwbmd1q1hUzt67ALCkAt/XBpAGRJ39ft05utlZOEailKOH5CCg+A6l
         SPLUIwhM58jX724aRkVMsdlUf0FPzZUvfMTto1OrGtgRIIDqjBTK5e6lp6kpXVOCym5D
         fdPWv4Ot13PymrC/a/jjfyNn/D0IM6IUWbslGE/bBooJ1ADFNGVzDfWL0BJelY/SnKbT
         +JAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700116202; x=1700721002;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PB/tb7x/wwBfMXKFlAwdEXt9fJqb2hzUXhb3693FMFI=;
        b=CFSc3Mh19U7lE5bm22DQmywG/q2UfTy1LvX793RGm+edDntRb5iY7jPBwy6wv6foYU
         DOaHvOPJ8VJjJ7RL4XaWtjQvhpk6Sr8flVFDeP+fE9WyhWG7pKbOiA3NW8ARdTFlFOdd
         HWIzm1fT51CuvhLzsOvnK3CmnTh3coyFFQ1GnSCu2NF+d+CTC5lFC7DLYKKkMfokWFJg
         wr4u4DKddiMZHEEJKtVR0nv3XyZPe1RcfX9EcR2Srd+1bQa8/UwNGvu1+jLxy7ptoQmo
         Zg3vL6mu3QX/w1zuWRmIiHyG3axVoRDCyMXUK2sBGj89RWzenFtzNea38K38o3H0z/4B
         rYOw==
X-Gm-Message-State: AOJu0YwmbNTByyKwCmGJbRAhGo2V7NatDh/5yRu9EZdP6ie1A6Swhup1
        hOdwM0L5wPhvRH3RXqUWGcL7
X-Google-Smtp-Source: AGHT+IEt8cECYm2VNPS0pn16zEsLLLHhSV0cG4YvuKehpByAru6JTwlYnq7ZubFBquXWqDAvW7VJjA==
X-Received: by 2002:a0c:ec50:0:b0:66d:544d:8e68 with SMTP id n16-20020a0cec50000000b0066d544d8e68mr8276026qvq.3.1700116202454;
        Wed, 15 Nov 2023 22:30:02 -0800 (PST)
Received: from thinkpad ([117.207.24.140])
        by smtp.gmail.com with ESMTPSA id u3-20020ad44983000000b00677ad5a91e1sm1149979qvx.53.2023.11.15.22.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 22:30:01 -0800 (PST)
Date:   Thu, 16 Nov 2023 11:59:51 +0530
From:   'Manivannan Sadhasivam' <manivannan.sadhasivam@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Shradha Todi <shradha.t@samsung.com>, jingoohan1@gmail.com,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski@linaro.org,
        alim.akhtar@samsung.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        pankaj.dubey@samsung.com
Subject: Re: [PATCH] PCI: exynos: Adapt to clk_bulk_* APIs
Message-ID: <20231116062951.GD3443@thinkpad>
References: <CGME20231009062222epcas5p36768b75c13c7c79965b5863521361a64@epcas5p3.samsung.com>
 <20231009062216.6729-1-shradha.t@samsung.com>
 <20231027134849.GA23716@thinkpad>
 <000b01da178e$a43088d0$ec919a70$@samsung.com>
 <bbcee6bf-850b-43c0-a5d3-9d5a66b24dc5@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bbcee6bf-850b-43c0-a5d3-9d5a66b24dc5@samsung.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 15, 2023 at 10:06:19AM +0100, Marek Szyprowski wrote:
> Hi!
> 
> On 15.11.2023 07:40, Shradha Todi wrote:
> >> -----Original Message-----
> >> From: Manivannan Sadhasivam [mailto:manivannan.sadhasivam@linaro.org]
> >> Sent: 27 October 2023 19:19
> >> To: Shradha Todi<shradha.t@samsung.com>
> >> Cc:jingoohan1@gmail.com;lpieralisi@kernel.org;kw@linux.com;
> >> robh@kernel.org;bhelgaas@google.com;krzysztof.kozlowski@linaro.org;
> >> alim.akhtar@samsung.com;linux-pci@vger.kernel.org; linux-arm-
> >> kernel@lists.infradead.org;linux-samsung-soc@vger.kernel.org; linux-
> >> kernel@vger.kernel.org;pankaj.dubey@samsung.com
> >> Subject: Re: [PATCH] PCI: exynos: Adapt to clk_bulk_* APIs
> >>
> >> On Mon, Oct 09, 2023 at 11:52:16AM +0530, Shradha Todi wrote:
> >>> There is no need to hardcode the clock info in the driver as driver
> >>> can rely on the devicetree to supply the clocks required for the
> >>> functioning of the peripheral. Get rid of the static clock info and
> >>> obtain the platform supplied clocks. The total number of clocks
> >>> supplied is obtained using the devm_clk_bulk_get_all() API and used
> >>> for the rest of the clk_bulk_* APIs.
> >>>
> >>> Signed-off-by: Shradha Todi<shradha.t@samsung.com>
> >>> ---
> >>>   drivers/pci/controller/dwc/pci-exynos.c | 46
> >>> ++++++-------------------
> >>>   1 file changed, 11 insertions(+), 35 deletions(-)
> >>>
> >>> diff --git a/drivers/pci/controller/dwc/pci-exynos.c
> >>> b/drivers/pci/controller/dwc/pci-exynos.c
> >>> index 9e42cfcd99cc..023cf41fccd7 100644
> >>> --- a/drivers/pci/controller/dwc/pci-exynos.c
> >>> +++ b/drivers/pci/controller/dwc/pci-exynos.c
> >>> @@ -54,8 +54,8 @@
> >>>   struct exynos_pcie {
> >>>   	struct dw_pcie			pci;
> >>>   	void __iomem			*elbi_base;
> >>> -	struct clk			*clk;
> >>> -	struct clk			*bus_clk;
> >>> +	struct clk_bulk_data		*clks;
> >>> +	int				clk_cnt;
> >>>   	struct phy			*phy;
> >>>   	struct regulator_bulk_data	supplies[2];
> >>>   };
> >>> @@ -65,30 +65,18 @@ static int exynos_pcie_init_clk_resources(struct
> >> exynos_pcie *ep)
> >>>   	struct device *dev = ep->pci.dev;
> >>>   	int ret;
> >>>
> >>> -	ret = clk_prepare_enable(ep->clk);
> >>> -	if (ret) {
> >>> -		dev_err(dev, "cannot enable pcie rc clock");
> >>> +	ret = devm_clk_bulk_get_all(dev, &ep->clks);
> >>> +	if (ret < 0)
> >> Please use !(ret) here and below to be consistent with the driver.
> >>
> > In this case, only negative values indicate failure. Hence we cannot use (!ret) here.
> >
> >>>   		return ret;
> >>> -	}
> >>>
> >>> -	ret = clk_prepare_enable(ep->bus_clk);
> >>> -	if (ret) {
> >>> -		dev_err(dev, "cannot enable pcie bus clock");
> >>> -		goto err_bus_clk;
> >>> -	}
> >>> +	ep->clk_cnt = ret;
> >> Since clk_cnt is "int", you can just use it directly instead of "ret".
> >>
> > Thanks for this suggestion! Will take care in v2.
> >
> >>> -	return 0;
> >>> -
> >>> -err_bus_clk:
> >>> -	clk_disable_unprepare(ep->clk);
> >>> -
> >>> -	return ret;
> >>> +	return clk_bulk_prepare_enable(ep->clk_cnt, ep->clks);
> >>>   }
> >>>
> >>>   static void exynos_pcie_deinit_clk_resources(struct exynos_pcie *ep)
> >>> {
> >>> -	clk_disable_unprepare(ep->bus_clk);
> >>> -	clk_disable_unprepare(ep->clk);
> >>> +	clk_bulk_disable_unprepare(ep->clk_cnt, ep->clks);
> >>>   }
> >>>
> >>>   static void exynos_pcie_writel(void __iomem *base, u32 val, u32 reg)
> >>> @@ -332,17 +320,9 @@ static int exynos_pcie_probe(struct
> >> platform_device *pdev)
> >>>   	if (IS_ERR(ep->elbi_base))
> >>>   		return PTR_ERR(ep->elbi_base);
> >>>
> >>> -	ep->clk = devm_clk_get(dev, "pcie");
> >>> -	if (IS_ERR(ep->clk)) {
> >>> -		dev_err(dev, "Failed to get pcie rc clock\n");
> >>> -		return PTR_ERR(ep->clk);
> >>> -	}
> >>> -
> >>> -	ep->bus_clk = devm_clk_get(dev, "pcie_bus");
> >>> -	if (IS_ERR(ep->bus_clk)) {
> >>> -		dev_err(dev, "Failed to get pcie bus clock\n");
> >>> -		return PTR_ERR(ep->bus_clk);
> >>> -	}
> >>> +	ret = exynos_pcie_init_clk_resources(ep);
> >>> +	if (ret < 0)
> >>> +		return ret;
> >>>
> >>>   	ep->supplies[0].supply = "vdd18";
> >>>   	ep->supplies[1].supply = "vdd10";
> >>> @@ -351,10 +331,6 @@ static int exynos_pcie_probe(struct
> >> platform_device *pdev)
> >>>   	if (ret)
> >>>   		return ret;
> >>>
> >>> -	ret = exynos_pcie_init_clk_resources(ep);
> >>> -	if (ret)
> >>> -		return ret;
> >>> -
> >>>   	ret = regulator_bulk_enable(ARRAY_SIZE(ep->supplies), ep-
> >>> supplies);
> >>>   	if (ret)
> >> You need to disable_unprepare() clocks in error path here and above.
> >>
> > Thanks for pointing out! Will take care in v2.
> 
> 
> Maybe it would make sense to add devm_clk_bulk_get_all_enabled() to 
> clock framework, similar to the existing devm_clk_get_enabled()?
> 
> It is really a common pattern to get all clocks and enable them for the 
> time of driver operation.
> 

Right. Someone may argue that the users would need to check the number of clocks
returned by the devm_clk_bulk_get_all() API, before enabling them. But I don't
think the drivers should check those values as they need to rely on the
firmware (unless accessing the clocks manually later). Even for those cases, the
individual APIs can be used.

So IMO it is worth to give it a shot.

- Mani

> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland

-- 
மணிவண்ணன் சதாசிவம்
