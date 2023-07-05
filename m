Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725587483B7
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jul 2023 14:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjGEMD2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jul 2023 08:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjGEMD2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jul 2023 08:03:28 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648FD1705;
        Wed,  5 Jul 2023 05:03:26 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f96d680399so10055068e87.0;
        Wed, 05 Jul 2023 05:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688558604; x=1691150604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=03OjytsEKOlrGBYHckO757KbIT4hQXjQ/wUsIUu1mq4=;
        b=jaE9HDAqMw8dAVCIPPVHDxbslYO/AJ1oqwrzK/oWglqgHTfTsqt59nNKi/rNza6Kwo
         dc19GxJxmi38V0mWCmKgm3nQGcovLhuFsPmLALGpP+/4m3+7bFeoQn75hXgXt7OYQLAQ
         3G4kDfbB2tp96g50Qd17Rv7f7/nrSnuZI2oggNN9yPeVsem2pHgqZOlQ/ggEIoPXbAId
         j4nSVB0FDPL+gr/vgJUB3Gtq4UIsyJKPmeLXweQzxFaw/L4C+skE5FP4ja5q8Qz4NE+K
         ITZxX8mm8f4rSVj54eDgn+TnxP38fLr7pOWB7Bod3u6nVZ6cV91/LDrEPjah9L6ACNIc
         8ppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688558604; x=1691150604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03OjytsEKOlrGBYHckO757KbIT4hQXjQ/wUsIUu1mq4=;
        b=dtW60YPtRnJq4RzglGhjtkFyCiuw6ZsMtaSKUlpn41EGs7sYvbba78oVQYQVMrG2NW
         SnMccpQdq1mGYFONTd75ZNBtwtqc7XJflV4N9DTdeVQPgdFaWBpERJyMSRl6rGUxur29
         l44Vr/8jd8MOV3RAD/VyUOXgYHaDMxFsXJPrsAe+MoR8+CTBLBj/JShPE4gQuBtCRqbs
         mOecDdTkH0vlbULf9CWtrJGNk3fKpKUcsSyBQNIAf9mGfRgq/SLd1eW+nQWrzaVHjy7A
         NctHk2/MzqrOZjts/5nIgoB+CL0rhjYTyIbNKU7qIDPlAOkxYWemwIS8+tplzrxbJZAp
         cDJA==
X-Gm-Message-State: ABy/qLYZ9OmRr54WZKR2iULlc0NQrikpDK/htarkzaE6iZTrXSHFeNtw
        nVzyRbC89CC2W9vd15A2slU=
X-Google-Smtp-Source: APBJJlGvJUbqyyd3/U3/d23b8QcfI69wZbPQy9joD5K4Fzi/+x8ASGScubm0d5unXJIyeTew4RLygg==
X-Received: by 2002:a05:6512:557:b0:4f3:b258:fee4 with SMTP id h23-20020a056512055700b004f3b258fee4mr12201391lfl.59.1688558604238;
        Wed, 05 Jul 2023 05:03:24 -0700 (PDT)
Received: from mobilestation ([109.197.207.72])
        by smtp.gmail.com with ESMTPSA id a23-20020ac25217000000b004fbc0c7218bsm380002lfl.118.2023.07.05.05.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 05:03:23 -0700 (PDT)
Date:   Wed, 5 Jul 2023 15:03:18 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v17 00/20] PCI: rcar-gen4: Add R-Car Gen4 PCIe support
Message-ID: <4fweg4rscidwx4s2qimae2hosutx4u6nlq5cbwdku5ekowbxem@knieycgcgtaa>
References: <20230705114206.3585188-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705114206.3585188-1-yoshihiro.shimoda.uh@renesas.com>
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

On Wed, Jul 05, 2023 at 08:41:46PM +0900, Yoshihiro Shimoda wrote:
> Add R-Car S4-8 (R-Car Gen4) PCIe Host and Endpoint support.
> To support them, modify PCIe DesignWare common codes.
> 
> Changes from v16:
> https://lore.kernel.org/linux-pci/20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com/
>  - Based on next-20230704.
>  - Drop a patch about PCI_EXP_LNKCAP_MLW.
>  - Drop a patch about PCI_HEADER_TYPE_MULTI_FUNC.
>  - Update comments in the patch [01/20].
>  - Drop CC-list from actual commit log in the patch [02/20].
>  - Update the commit log in the patch [04/20].
>  - Remove unnecessary bit setting in the patch [05/20].
>  - (New) Add .func_conf_select2() ops for multiple PFs support in the patch [07/20].
>  - Modify dw_pcie_link_set_max_link_width() refactoring in the patch [08/20].
>  - Use FIELD_PREP() to improve code readability in the patch [09/20].
>  - Add Reviewed-by in the patch [1[02]/20] (Thanks, Serge!).
>  - Minor fix of the commit log in the patch [11/20].
>  - Add clock-names property in the patch [1[56]/20].
>  - Add max-functions property in the patch [16/20].
>  - Drop unnecessary dw_pcie_dbi_ro_wr_en() in the patch [17/20].
>  - Modify .stark_link() handling in the patch [17/20].
>  - Change function name of rcar_gen4_pcie_set_device_type() in the patch [17/20].
>  - Modify reset/clock handling in the patch [17/20].
>  - Add enum dw_pcie_device_mode handling in the patch [17/20].
>  - Drop single-function setting in the patch [18/20].
>  - Add multi PFs support in the patch [18/20].
>  - Fix .reserved_bar value in the patch [18/20].

Awesome work! Just a general note about the changes list. I normally
create two of them: common one in the cover-letter (what you already
have) and a commit/patch-specific one (in each commit under the "---"
line so "git am" would drop it on merge). Thus the reviewers will
always be able to track the changes specific to the particular
commit/patch with no need in parsing the entire series change log.

Anyway thanks for resubmitting the series. I'll have a closer look at
it on this week or early on the next week.

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
> 
> Yoshihiro Shimoda (20):
>   PCI: Add INTx Mechanism Messages macros
>   PCI: Rename PCI_EPC_IRQ_LEGACY to PCI_EPC_IRQ_INTX
>   PCI: dwc: Rename "legacy_irq" to "INTx_irq"
>   PCI: dwc: Change arguments of dw_pcie_prog_outbound_atu()
>   PCI: dwc: Add outbound MSG TLPs support
>   PCI: designware-ep: Add INTx IRQs support
>   PCI: dwc: endpoint: Add multiple PFs support for dbi2
>   PCI: dwc: Add dw_pcie_link_set_max_link_width()
>   PCI: dwc: Add PCI_EXP_LNKCAP_MLW handling
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
>  .../bindings/pci/rcar-gen4-pci-ep.yaml        | 106 ++++++++++
>  .../bindings/pci/rcar-gen4-pci-host.yaml      | 123 +++++++++++
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
>  .../pci/controller/dwc/pcie-designware-ep.c   | 133 ++++++++++--
>  .../pci/controller/dwc/pcie-designware-host.c |  52 +++--
>  .../pci/controller/dwc/pcie-designware-plat.c |   4 +-
>  drivers/pci/controller/dwc/pcie-designware.c  | 155 +++++++-------
>  drivers/pci/controller/dwc/pcie-designware.h  |  35 +++-
>  drivers/pci/controller/dwc/pcie-keembay.c     |   2 +-
>  drivers/pci/controller/dwc/pcie-qcom-ep.c     |   4 +-
>  .../pci/controller/dwc/pcie-rcar-gen4-ep.c    | 191 +++++++++++++++++
>  .../pci/controller/dwc/pcie-rcar-gen4-host.c  | 144 +++++++++++++
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 197 ++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-rcar-gen4.h   |  43 ++++
>  drivers/pci/controller/dwc/pcie-tegra194.c    |   8 +-
>  drivers/pci/controller/dwc/pcie-uniphier-ep.c |   2 +-
>  drivers/pci/controller/pcie-rcar-ep.c         |   2 +-
>  drivers/pci/controller/pcie-rockchip-ep.c     |   2 +-
>  drivers/pci/endpoint/functions/pci-epf-test.c |  10 +-
>  drivers/pci/pci.h                             |  18 ++
>  include/linux/pci-epc.h                       |   4 +-
>  32 files changed, 1127 insertions(+), 159 deletions(-)
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
