Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C576DD93F
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 13:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjDKLUt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 07:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjDKLUs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 07:20:48 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3A71984
        for <linux-pci@vger.kernel.org>; Tue, 11 Apr 2023 04:20:47 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1a645fd0c6dso2562985ad.1
        for <linux-pci@vger.kernel.org>; Tue, 11 Apr 2023 04:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681212047;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7zNLCqP6owqpDv0VpdmDaSbaHG9NuBOnzsd1ItJEgtY=;
        b=o4oJ3kgpmE9NEeZDt4aUZrw22E6mGLCbNeQlxlauE198mAELSstKgXs57cjw1j0y8u
         aGkyTAaIfR+v1GydHCxrqHBxqVInT0BGSvLWqUndkxAT40DU7f/tKrE0qgmF+5R9fFHY
         NFrr5UwcKYjZqjZjl/fXMpAUcZaboNJenbaotfbW5doDunTTukiElrbLGx6xSU/GxVft
         SZIJS6QpsH4Ywxr46WUL6uHiQFHbjczMUYe/0WFo+bYApuirtgC8OiwJGWux3u4OjtlE
         Te4ivWbbNBqOizXwvE4rV2DkIv9sOV4GFxHQmj8LTC3d+0frcB6FiuZPyKydvfUjNcwG
         9c1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681212047;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7zNLCqP6owqpDv0VpdmDaSbaHG9NuBOnzsd1ItJEgtY=;
        b=o2mj4dL/gCFBqnwuWgWzQIqzgR6XqbdE9KHBM2ruGADqZe5SlflcK/fpJ52TsBGs5T
         wvH2ifgwT2rluk7p18uGkwMv7qdnJno5ToUb7hTQec8XL1y3sEKKBX5UM17OyAZVCH9p
         4N1PNECjq1hjsATS5bR67TKKJAUiyPvzmAsT4xhkUUlxXWf1rFZxIccdUNdZjWUr2Alh
         sbB58FL3l5qSeDMD1x0GEaop3Ah/bQqgEW0I00is+N0ofhlD4NjHhR5fRHZCoL1G0kI0
         c4GY+VIWGey+T+PJf7BN+DqQS7IkjivjL74zs1Www5OS0c/gwv92zm9xyzGWNsc9gMoF
         5rzA==
X-Gm-Message-State: AAQBX9c8YlWbEXvAu5rOOxxZZdS1gl5LslsPamtYH5kSB+KjTH3GDwE/
        oVxSXK2XcE2bMgTa16mDh4zC
X-Google-Smtp-Source: AKy350a4MY/M7jgh+qM0pXF0i1DkZaqvdVyS7EZ/EXV48+5Vt6iuBjTSTSKfmGqvd8WejDpT7/8IJw==
X-Received: by 2002:aa7:9ec8:0:b0:626:6a3:6b81 with SMTP id r8-20020aa79ec8000000b0062606a36b81mr15960993pfq.15.1681212047192;
        Tue, 11 Apr 2023 04:20:47 -0700 (PDT)
Received: from thinkpad ([117.216.120.128])
        by smtp.gmail.com with ESMTPSA id n3-20020a62e503000000b0062db34242aesm9565964pff.167.2023.04.11.04.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 04:20:46 -0700 (PDT)
Date:   Tue, 11 Apr 2023 16:50:37 +0530
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
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 08/10] MAINTAINERS: Add all generic DW PCIe
 RP/EP DT-schemas
Message-ID: <20230411112037.GJ5333@thinkpad>
References: <20230411033928.30397-1-Sergey.Semin@baikalelectronics.ru>
 <20230411033928.30397-9-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230411033928.30397-9-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 11, 2023 at 06:39:26AM +0300, Serge Semin wrote:
> Recently the DT-schema of the DW PCIe Root Port and End-point controllers
> has been refactored by detaching the common bindings into a separate
> schema. The provided modification must be reflected in the MAINTAINERS
> list so the patch submitters would be aware of the new files maintainers.
> Let's do that by adding the maintained files wildcard pattern like
> snps,dw-pcie*.yaml, which is applicable for all the old DW PCIe DT-schema
> files and the new one.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ec57c42ed544..489fd4b4c7ae 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16063,8 +16063,7 @@ M:	Jingoo Han <jingoohan1@gmail.com>
>  M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> -F:	Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> +F:	Documentation/devicetree/bindings/pci/snps,dw-pcie*.yaml
>  F:	drivers/pci/controller/dwc/*designware*
>  
>  PCI DRIVER FOR TI DRA7XX/J721E
> -- 
> 2.40.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
