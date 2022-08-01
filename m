Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423E2586BFD
	for <lists+linux-pci@lfdr.de>; Mon,  1 Aug 2022 15:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiHAN3a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Aug 2022 09:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbiHAN30 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Aug 2022 09:29:26 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280613C8F8
        for <linux-pci@vger.kernel.org>; Mon,  1 Aug 2022 06:29:25 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 15-20020a17090a098f00b001f305b453feso15272190pjo.1
        for <linux-pci@vger.kernel.org>; Mon, 01 Aug 2022 06:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=piHbK3UTbLD9iX3PR06IXvcLd5J15k6XNiAP53ZMJ4M=;
        b=uarbxJk2fAKWggvb+nqWwyIdVHYdxMvhC3w+walHGbRvIXqB/KHaPOb1ekLfW5unTw
         FleMMIiUYW4Ox6mnoQvMRDLVgqJbyNjh8uZTkuxJcVY2OuIC5YAueJRbPnCEnEA/WHwF
         Cppgpm4qkdJ34arKkjA5Bo7fozZ+Jt4lh/SZ9TMlxqF+zWANlRQXfFf1bGQedPoRSWTz
         x752vYb4PVKFaK+yZy0ofrS8Y4fkLsFcQicGYgL7PF9bW7MwJoNQA56yQ6NsvOuF54xd
         VjWEGBSYVTgMI7ga5Tp7HPy8FPwnZK3M8UZUsdF6CQiE2Yf1lH8SCys76qUtTPc1rUOp
         IDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=piHbK3UTbLD9iX3PR06IXvcLd5J15k6XNiAP53ZMJ4M=;
        b=spFha1sM4oeM+7SA5drREt6ZjU0TwV57OFawZ0AazKQfow6X9di5BPjlRL3eB5Ub+P
         SwQ5WLGPr56/wlDF/994fFeHHTxpdEhxJiVip0QBwSbmWGgvjkwrYtGJWOtIYGu3wGnE
         WQ9gB4kk/r2XLhanWXcOW6ELM7H6LI+vuiy8w+FMxMEjFIEtE0xPLUYNH96ERACMEHef
         L0QIywbf3lI+XhpE/AFJ+pRr6nA/oN27t7APbUhK4FnFY4hJk+oig76Y8eBc+mH3sxVj
         ncTAa7vylY8iNUGtAEqrecpmOnJ6KdSK/7+CE1p1Gty6KVhhLCqEaKZ2g4WxRs6JopDt
         6Apw==
X-Gm-Message-State: ACgBeo3khJZFcFycEKMMNWxxUpeZNkVrm1LohHSJo86bgng34fYXJUVC
        93sPOmwJjvtSoltsKe4f04gv
X-Google-Smtp-Source: AA6agR6f2gG1JYF96xw37fgWxbCpANQ6x8CkczTqANqhYTnastBsdlFNyUsPc3C5KODvwf6fE5Bb3A==
X-Received: by 2002:a17:90b:3a90:b0:1f2:edfe:db4 with SMTP id om16-20020a17090b3a9000b001f2edfe0db4mr19430937pjb.105.1659360564404;
        Mon, 01 Aug 2022 06:29:24 -0700 (PDT)
Received: from thinkpad ([117.217.185.73])
        by smtp.gmail.com with ESMTPSA id l190-20020a6225c7000000b0052d98fbf8f3sm1647563pfl.56.2022.08.01.06.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 06:29:24 -0700 (PDT)
Date:   Mon, 1 Aug 2022 18:59:12 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH RESEND v4 07/15] PCI: tegra194: Drop manual DW PCIe
 controller version setup
Message-ID: <20220801132912.GG93763@thinkpad>
References: <20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru>
 <20220624143947.8991-8-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220624143947.8991-8-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 24, 2022 at 05:39:39PM +0300, Serge Semin wrote:
> Since the DW PCIe common code now supports the IP-core version
> auto-detection there is no point in manually setting the version up for the
> controllers newer than v4.70a. Seeing Tegra 194 PCIe Host and EP
> controllers are based on the DW PCIe v4.90a IP-core we can freely drop the
> dw_pcie.version field initialization.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> 
> ---
> 
> Folks, I don't have Tegra 194 PCIe hw instance to test it out. Could you
> please make sure this patch doesn't brake anything?
> 
> Changelog v3:
> - This is a new patch create as a result of the discussion:
>   https://lore.kernel.org/linux-pci/20220503214638.1895-6-Sergey.Semin@baikalelectronics.ru/
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index f24b30b7454f..e497e6de8d15 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1979,7 +1979,6 @@ static int tegra194_pcie_probe(struct platform_device *pdev)
>  	pci->ops = &tegra_dw_pcie_ops;
>  	pci->n_fts[0] = N_FTS_VAL;
>  	pci->n_fts[1] = FTS_VAL;
> -	pci->version = DW_PCIE_VER_490A;
>  
>  	pp = &pci->pp;
>  	pp->num_vectors = MAX_MSI_IRQS;
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
