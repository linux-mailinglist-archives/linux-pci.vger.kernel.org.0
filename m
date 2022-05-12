Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD56524FA4
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 16:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353954AbiELOO3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 10:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346430AbiELOO2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 10:14:28 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55AA24EA06
        for <linux-pci@vger.kernel.org>; Thu, 12 May 2022 07:14:26 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id x18so4995023plg.6
        for <linux-pci@vger.kernel.org>; Thu, 12 May 2022 07:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=855eDGLf46dk2I/7iZtXjVz1AoTrOAqreqM5iGfMOk4=;
        b=Lvdn3txiHxnaCtzOKdJulNIQEjT2sfYMExRSkNDxLgNnLdkoYcQIxNifde1KWh7k8b
         o2VdMrw4/sGCOwE0YP88pyuZPjGdMxfuO5Wm5/qORIkIGqBdYiCzZdaDt0L+yPVE4FC5
         m9fsTtWHWkl8d9CCZaJdEeWN4JPireHLB+7RvCzvLVBZDGorSBBu+Wh2Vg9a1iwhuonH
         yCyDHmORCElgKnWBz+x46MJS1R5Cxs+RShRaDIER8LJewMiu84nzTxuB6uT/lfKFxLGG
         ZVHf6NaiZb99FBJwVRcHKynmSAGsIihQejmIipsvZX1/I/yVcp613nEa6nRYLG4meVYL
         luEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=855eDGLf46dk2I/7iZtXjVz1AoTrOAqreqM5iGfMOk4=;
        b=Y0Zk3bOUQ5fNqfEeGbO3Awg7djSqN4teJHXiZS20z3oNSN5UQyuahTxjAMlshFGc0k
         p2UoJOAk+eQ42dYRybKamhMG1jC5h22oYVZYazRLy2VFwj2IGMYq4D7HwA8HEEb/VMWL
         TJas+YtGtI01cRHsr1+EM2v+nPNGuHxubCWJZbFkLw8MbJhQ9OIk14ti9coEWr78eDuf
         0H43KKdM+m/JY8/CtO06evP+sNrs3HhtlihaMt3f9Gxp/IzjKSXSC4WHXCzDdrZGRcS8
         HcK2spe/SB+3csih0j8HaKlDSlWqiHH3O7OsNainSWsNDBIQfYS6V6riVl/Edc9kSU/U
         VzvQ==
X-Gm-Message-State: AOAM533DIVb3RWR6/LoBPSZiXDeYcAQVLCoNO/ff625NZp3RkhGwZd4O
        1I1z+SGlptJaQiNA9conrEUi
X-Google-Smtp-Source: ABdhPJyl+d6P0bQLR5sG5lI33UWoVqR705r+74cxaGYxgMWDrkSINBBxzjyznv60jcLaOJoPdAzi9g==
X-Received: by 2002:a17:902:7798:b0:158:ee95:f45b with SMTP id o24-20020a170902779800b00158ee95f45bmr30824571pll.97.1652364866131;
        Thu, 12 May 2022 07:14:26 -0700 (PDT)
Received: from thinkpad ([117.202.184.202])
        by smtp.gmail.com with ESMTPSA id 204-20020a6302d5000000b003c619f3d086sm2033296pgc.2.2022.05.12.07.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 07:14:25 -0700 (PDT)
Date:   Thu, 12 May 2022 19:44:18 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org,
        vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        Sergey.Semin@baikalelectronics.ru
Subject: Re: [PATCH v10 0/9] Enable designware PCI EP EDMA locally
Message-ID: <20220512141418.GF35848@thinkpad>
References: <20220503005801.1714345-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220503005801.1714345-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 02, 2022 at 07:57:52PM -0500, Frank Li wrote:
> Default Designware EDMA just probe remotely at host side.
> This patch allow EDMA driver can probe at EP side.
> 
> 1. Clean up patch
>    dmaengine: dw-edma: Detach the private data and chip info structures
>    dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
>    dmaengine: dw-edma: Change rg_region to reg_base in struct
>    dmaengine: dw-edma: rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
> 
> 2. Enhance EDMA driver to allow prode eDMA at EP side
>    dmaengine: dw-edma: Add support for chip specific flags
>    dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific flags
> 
> 3. Bugs fix at EDMA driver when probe eDMA at EP side
>    dmaengine: dw-edma: Fix programming the source & dest addresses for ep
>    dmaengine: dw-edma: Don't rely on the deprecated "direction" member
> 
> 4. change pci-epf-test to use EDMA driver to transfer data.
>    PCI: endpoint: Add embedded DMA controller test
> 
> 5. Using imx8dxl to do test, but some EP functions still have not
> upstream yet. So below patch show how probe eDMA driver at EP
> controller driver.
> https://lore.kernel.org/linux-pci/20220309120149.GB134091@thinkpad/T/#m979eb506c73ab3cfca2e7a43635ecdaec18d8097

I've now tested the eDMA patches on top of Serge's patches plus some Qcom
specific changes. So feel free to add my Tested-by tag for eDMA patches.

Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

I can't test pci-epf-test on my platform, so intentionally left it out.

Thanks,
Mani

> 
> 
> Frank Li (7):
>   dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
>   dmaengine: dw-edma: Detach the private data and chip info structures
>   dmaengine: dw-edma: Change rg_region to reg_base in struct
>     dw_edma_chip
>   dmaengine: dw-edma: Rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
>     dw_edma_chip
>   dmaengine: dw-edma: Add support for chip specific flags
>   dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific flags
>   PCI: endpoint: Enable DMA controller tests for endpoints with DMA
>     capabilities
> 
> Serge Semin (2):
>   dmaengine: dw-edma: Drop dma_slave_config.direction field usage
>   dmaengine: dw-edma: Fix eDMA Rd/Wr-channels and DMA-direction
>     semantics
> 
>  drivers/dma/dw-edma/dw-edma-core.c            | 141 +++++++++++-------
>  drivers/dma/dw-edma/dw-edma-core.h            |  31 +---
>  drivers/dma/dw-edma/dw-edma-pcie.c            |  83 +++++------
>  drivers/dma/dw-edma/dw-edma-v0-core.c         |  54 ++++---
>  drivers/dma/dw-edma/dw-edma-v0-core.h         |   4 +-
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.c      |  18 +--
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.h      |   8 +-
>  drivers/pci/endpoint/functions/pci-epf-test.c | 108 ++++++++++++--
>  include/linux/dma/edma.h                      |  61 +++++++-
>  9 files changed, 323 insertions(+), 185 deletions(-)
> 
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
