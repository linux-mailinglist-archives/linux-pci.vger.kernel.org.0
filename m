Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680BD6DD8DE
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 13:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjDKLGR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 07:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjDKLGP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 07:06:15 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826314691
        for <linux-pci@vger.kernel.org>; Tue, 11 Apr 2023 04:05:54 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-24663864a71so356584a91.1
        for <linux-pci@vger.kernel.org>; Tue, 11 Apr 2023 04:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681211153;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3Henn4DTyZ5csO3RcwwNDZOMw3VH+OflLLeQ1lsdR/Y=;
        b=Fv7ALfGPeofF6viDgC+eYRkrcB2kl2eVyjeLUk2Jul6IgsRYqtnz62FLA9xOn06ppc
         NnE94DKoSjf/eOuqAWTL68wRHQDPeqzZzlPyXgIH5RAOdAV3jwDokQAuBsyX6sIhBf0A
         haIEdQQeFbrlo3C9HhYQhQTM9RGSydK3dR52p77s29WeNxG8kz34+U0B/4GVUO8pzYlo
         BZIClb6Dus2umAMBe7KQm1c6Opyim8o4prfbVtQS04gTcfmG22UlzBv+plXMr12nOCHY
         ZNrU7MZyOp9X7TNeHnYr9jfVvZ1fYFC0GMRJXKQ8rRGt2tUKGzS1sfutyZQCPJNVEuDY
         F4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681211153;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Henn4DTyZ5csO3RcwwNDZOMw3VH+OflLLeQ1lsdR/Y=;
        b=JdlUTdaYsB0Vhu2jwh4wTuqMarCJpKmQC5Qdn0ssLqAM1EO3SIxPNL3f+obv6rT7EC
         P2Cujd/lur4nb3I+ev7vDr1JX1lVIqCU55cI+0RZeoCxjNuI/hfVdU1X84WH5MhDKyLx
         y2i92huSygpnbM1EwcAxk2ymJP0GeJIx8CWp4hiEasQyfgEPgWY2P0E33R1+hVNGT4te
         b9+EQK24b1VivusAXrLDIjJx9rNlaOjIOcgaUBoVqlf36MpNirY7o2lmWE54vnzykP0b
         BWs4PK9VmKUJvhg9QZY28/F6ifbCoglDzrHn4Ph5TVrD+dGbrCEP1Q+qO9cNriwlrAl3
         8rXQ==
X-Gm-Message-State: AAQBX9enocjSXZiRhn8QRUk+YEbB6N4JyZQBtO9eqBviDs9475P78J+s
        nqKr0ScUuscbpmnfXsw4N28k
X-Google-Smtp-Source: AKy350ZaDwG/ecpJNgVpobQmPOIs1jBN4tLQI3KG+sNWursEWwg0eY0WIL1Il4to3tRF2DCV8H2HrA==
X-Received: by 2002:a62:1d8c:0:b0:626:29ed:941f with SMTP id d134-20020a621d8c000000b0062629ed941fmr13651820pfd.5.1681211153473;
        Tue, 11 Apr 2023 04:05:53 -0700 (PDT)
Received: from thinkpad ([117.216.120.128])
        by smtp.gmail.com with ESMTPSA id b8-20020aa78708000000b005d72e54a7e1sm4309437pfo.215.2023.04.11.04.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 04:05:53 -0700 (PDT)
Date:   Tue, 11 Apr 2023 16:35:45 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 03/10] PCI: bt1: Enable async probe type
Message-ID: <20230411110545.GE5333@thinkpad>
References: <20230411033928.30397-1-Sergey.Semin@baikalelectronics.ru>
 <20230411033928.30397-4-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230411033928.30397-4-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 11, 2023 at 06:39:21AM +0300, Serge Semin wrote:
> It's safe to enable the asyncronous probe type since the PCIe peripheral
> devices probing order isn't essential for booting the system. Moreover
> enabling that feature saves 0.5 seconds of bootup time if no any device
> attached to the PCIe root port. It's a significant performance gain seeing
> the total bootup time takes about 3 seconds.
> 
> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-bt1.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-bt1.c b/drivers/pci/controller/dwc/pcie-bt1.c
> index 95a723a6fd46..e36a20bf82cf 100644
> --- a/drivers/pci/controller/dwc/pcie-bt1.c
> +++ b/drivers/pci/controller/dwc/pcie-bt1.c
> @@ -638,6 +638,7 @@ static struct platform_driver bt1_pcie_driver = {
>  	.driver = {
>  		.name	= "bt1-pcie",
>  		.of_match_table = bt1_pcie_of_match,
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  	},
>  };
>  module_platform_driver(bt1_pcie_driver);
> -- 
> 2.40.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
