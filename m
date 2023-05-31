Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E365717E0A
	for <lists+linux-pci@lfdr.de>; Wed, 31 May 2023 13:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbjEaL3n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 May 2023 07:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjEaL3m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2023 07:29:42 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C96E56;
        Wed, 31 May 2023 04:29:19 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f4b80bf93aso6457152e87.0;
        Wed, 31 May 2023 04:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685532556; x=1688124556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=akQTwso+lPrye4sUUo/UEde3lPFhlHH3Ok+kinULKsE=;
        b=oAoEDv4Aza7S5BHUV4eC09G+wt7e6HOPCVH1b4j4rkPMYrV9B3ZZpYCR2jjkH/h599
         TBb6SGVM4n3BctePdjrf6tHW8nYa+oaVKqa+qmJeEXM1/K/nzOihGhqxE4R7ie1BVYpG
         tAFPSqtfczV2DxY02Oadlfr4nm8SU/uVktX0//f04A4xkDhuV1udQYc9eJwhth37K17n
         lt0Lg+KCJR8GIgXbscD+cGonb8hzBP1zCXmM7o0C1QuOtW2UYBXVkH/mMVqDpZR2vC4n
         9Ve4AMoBEi7jrYAL/MgSp87qMh+NyATMpH/vxxVaTVAXhqiHGtBupbaDxmz6gIKD0rZb
         ylwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685532556; x=1688124556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akQTwso+lPrye4sUUo/UEde3lPFhlHH3Ok+kinULKsE=;
        b=H3zVq81OaMFlIb3Kuo6o7zH55hEa/5l8O9zMliYYBM2Y0+xwQlVIvR1fmQYj2hvX/6
         ZMt6HMmaVWg387mTXlOVr909rmZmq23C7QX13UhlKQ1ryF7vYQdXHCMrgbmtUfKnhkC2
         FzBNuivV2pJaVtZsZ918HTZSa5ASFhkd70fGIrQ/vSG0dVMx9V35Mp3wo91svuO5Yllp
         swQuARSfWU/pSz4cK5eTb5VMlCKdj0xgpMbrI51pUyvlVOWgVFj2QgjmPc/C5+kv8gpT
         Fco99V5anY41Lr/t5MqJP0/4gZ6tKDRuFQHY0xVr9A8lAD1MqSIqEccArzV4l3bUeksh
         PDJg==
X-Gm-Message-State: AC+VfDxGFIb5iESgyxXYm9wJef9zHO8s3FcXd4/evpvpW2ZqNti6f9qg
        V2UcCuiPxrvvFgl7oR3XnkA=
X-Google-Smtp-Source: ACHHUZ4OeyaYtXrALpVXy/Ab24IG+OZaeMPn8A02VVjP1dyIT3Q15HKxpDhLN7KpPzMoMAFaq9yXsQ==
X-Received: by 2002:ac2:520a:0:b0:4f3:a485:919f with SMTP id a10-20020ac2520a000000b004f3a485919fmr2512817lfl.32.1685532556136;
        Wed, 31 May 2023 04:29:16 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id p3-20020a19f003000000b004d40e22c1eesm683097lfc.252.2023.05.31.04.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 04:29:15 -0700 (PDT)
Date:   Wed, 31 May 2023 14:29:13 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh+dt@kernel.org, kw@linux.com, bhelgaas@google.com,
        kishon@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v16 00/22] PCI: rcar-gen4: Add R-Car Gen4 PCIe support
Message-ID: <20230531112913.n3bljxn2ew6x5t7b@mobilestation>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Yoshihiro

On Wed, May 10, 2023 at 03:22:12PM +0900, Yoshihiro Shimoda wrote:
> Add R-Car S4-8 (R-Car Gen4) PCIe Host and Endpoint support.
> To support them, modify PCIe DesignWare common codes.

Thanks for the updated series. I'll have a look at it on this week.

-Serge(y)

> 
> Changes from v15:
> https://lore.kernel.org/linux-pci/20230509124156.150200-1-yoshihiro.shimoda.uh@renesas.com/
>  - Based on next-20230509 + pci.git / next branch (the commit 174977dc80b7
>    ("Merge branch 'pci/controller/vmd'"))
>  - (no change, JFYI) Based on the following cleanups patches:
>    [PATCH v4 00/14] PCI: dwc: Relatively simple fixes and cleanups
>    https://lore.kernel.org/linux-pci/20230414021832.13167-1-Sergey.Semin@baikalelectronics.ru/
>  - Modify the code comments in patch 8/22.
> 
> Changes from v14:
> https://lore.kernel.org/linux-pci/20230426045557.3613826-1-yoshihiro.shimoda.uh@renesas.com/
>  - Based on next-20230508.
>  - (no change, JFYI) Based on the following cleanups patches:
>    [PATCH v4 00/14] PCI: dwc: Relatively simple fixes and cleanups
>    https://lore.kernel.org/linux-pci/20230414021832.13167-1-Sergey.Semin@baikalelectronics.ru/
>  - Add Reviewed-by from Serge in the patch {4,5,15,}/21.
>  - Drop PCI_EXP_LNKCAP_MLW handling of pcie-tegra194.c because
>    pcie-designware.c takes care of it.
>  - Change subjects in the patch {5,6,7,8,10}/21.
>  - Drop dw_pcie_prog_ep_outbound_atu().
>  - Modify dw_pcie_link_set_max_link_width() to improve code readability.
>  - Move the retrain code to .start_link().
>  - Fix some minor issues.
> 
> Yoshihiro Shimoda (22):
>   PCI: Add PCI_EXP_LNKCAP_MLW macros
>   PCI: Add PCI_HEADER_TYPE_MULTI_FUNC
>   PCI: Add INTx Mechanism Messages macros
>   PCI: Rename PCI_EPC_IRQ_LEGACY to PCI_EPC_IRQ_INTX
>   PCI: dwc: Rename "legacy_irq" to "INTx_irq"
>   PCI: dwc: Change arguments of dw_pcie_prog_outbound_atu()
>   PCI: dwc: Add outbound MSG TLPs support
>   PCI: designware-ep: Add INTx IRQs support
>   PCI: dwc: Add dw_pcie_link_set_max_link_width()
>   PCI: dwc: Modify PCIE_PORT_LINK_CONTROL handling
>   PCI: dwc: Add dw_pcie_link_set_max_cap_width()
>   PCI: tegra194: Drop PCI_EXP_LNKSTA_NLW setting.
>   PCI: dwc: Add EDMA_UNROLL capability flag
>   PCI: dwc: Expose dw_pcie_ep_exit() to module
>   PCI: dwc: Introduce .ep_pre_init() and .ep_deinit()
>   dt-bindings: PCI: dwc: Update maxItems of reg and reg-names
>   dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Host
>   dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Endpoint
>   PCI: rcar-gen4: Add R-Car Gen4 PCIe Host support
>   PCI: rcar-gen4-ep: Add R-Car Gen4 PCIe Endpoint support
>   MAINTAINERS: Update PCI DRIVER FOR RENESAS R-CAR for R-Car Gen4
>   misc: pci_endpoint_test: Add Device ID for R-Car S4-8 PCIe controller
> 
>  .../bindings/pci/rcar-gen4-pci-ep.yaml        |  98 +++++++++
>  .../bindings/pci/rcar-gen4-pci-host.yaml      | 109 ++++++++++
>  .../bindings/pci/snps,dw-pcie-ep.yaml         |   4 +-
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml |   4 +-
>  MAINTAINERS                                   |   1 +
>  drivers/misc/pci_endpoint_test.c              |   4 +
>  .../pci/controller/cadence/pcie-cadence-ep.c  |   2 +-
>  drivers/pci/controller/dwc/Kconfig            |  18 ++
>  drivers/pci/controller/dwc/Makefile           |   4 +
>  drivers/pci/controller/dwc/pci-dra7xx.c       |   2 +-
>  drivers/pci/controller/dwc/pci-imx6.c         |   4 +-
>  drivers/pci/controller/dwc/pci-keystone.c     |   2 +-
>  .../pci/controller/dwc/pci-layerscape-ep.c    |   4 +-
>  drivers/pci/controller/dwc/pcie-artpec6.c     |   2 +-
>  .../pci/controller/dwc/pcie-designware-ep.c   |  98 +++++++--
>  .../pci/controller/dwc/pcie-designware-host.c |  52 +++--
>  .../pci/controller/dwc/pcie-designware-plat.c |   4 +-
>  drivers/pci/controller/dwc/pcie-designware.c  | 160 ++++++++-------
>  drivers/pci/controller/dwc/pcie-designware.h  |  33 ++-
>  drivers/pci/controller/dwc/pcie-keembay.c     |   2 +-
>  drivers/pci/controller/dwc/pcie-qcom-ep.c     |   4 +-
>  .../pci/controller/dwc/pcie-rcar-gen4-ep.c    | 166 +++++++++++++++
>  .../pci/controller/dwc/pcie-rcar-gen4-host.c  | 141 +++++++++++++
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 190 ++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-rcar-gen4.h   |  46 +++++
>  drivers/pci/controller/dwc/pcie-tegra194.c    |   8 +-
>  drivers/pci/controller/dwc/pcie-uniphier-ep.c |   2 +-
>  drivers/pci/controller/pcie-rcar-ep.c         |   2 +-
>  drivers/pci/controller/pcie-rockchip-ep.c     |   2 +-
>  drivers/pci/endpoint/functions/pci-epf-test.c |  10 +-
>  drivers/pci/pci.h                             |  18 ++
>  drivers/pci/probe.c                           |   2 +-
>  drivers/pci/quirks.c                          |   4 +-
>  include/linux/pci-epc.h                       |   4 +-
>  include/uapi/linux/pci_regs.h                 |   7 +
>  35 files changed, 1061 insertions(+), 152 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
>  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c
>  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
>  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.c
>  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.h
> 
> -- 
> 2.25.1
> 
