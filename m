Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E913275F3E3
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 12:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjGXKxc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 06:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbjGXKxb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 06:53:31 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07551E41;
        Mon, 24 Jul 2023 03:53:17 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f95bf5c493so6136432e87.3;
        Mon, 24 Jul 2023 03:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690195995; x=1690800795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bgb/1YdwJv7QAluNUaUNNWpEruzYnN7gGa3zvt2ASjQ=;
        b=gNK/bb4nxGoarMgM9FpFly/k/bpCvmhhJcGuJbdbrGHHaD0CZ11z0Y3vSv5GhIFUya
         TJbmsbbBH+NqQyDATHiUeGDkX5rZ0oTO4GtRMVj1sr/naVz5yI1rtrXiael11VIHFgiD
         IiZ06ax+4610TjDZS4+4IQNGDVq2rllu1ZssY4fOH1Eewxwlxv/A0Ioh40y1j7RvecKC
         3Qbzr0Cf5leJucn19553AzOMQCkiJKMjwe9UqJk1pwZni/ehwRW7wrhx2qcI+2VHxZK+
         ewOY1LpanVPY5ODJst9iOHOwAlvkdEnOBnmp2/6g2rWMo9m6kvhUfJmnJhLK5Bcub3jx
         ms/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690195995; x=1690800795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bgb/1YdwJv7QAluNUaUNNWpEruzYnN7gGa3zvt2ASjQ=;
        b=OJFKJR7bEe8YWhY+9V5SLwRyxVktD+gqgmJEmvq5xXiSLR30sQLrOpLuPxlDwqCZdN
         A5JOfmONJ2Kip4t53sly5mXq+oKtNWmNb60GCg7RbrYzc5+tKHDLyfx7BWqY5Dq3GJ/M
         HXugx5YPItBuBvPXpo6LIEUWy761JyATIE4QtKuAW0IqZStkVorrbwlo3Hj3p53OByG8
         Gkd1+KSNpANst6GCK07uk01zR1tYJge5AekN8u+WWevg9KCkz6eAVF3PEyxrw2p8m9wx
         WsOAxkySkdW6516fQ5N+4ZspmUaapLeCSvhXGCiXl119x+odA0LnVvYW8B99r6skwbUM
         i5Jg==
X-Gm-Message-State: ABy/qLZhyJa2fMQdjo2oSFE7gebU2I3T1CWpAcGE/q3+DTWw2LXu6ssT
        QM7IhydBXcG163mpsyLfhSo=
X-Google-Smtp-Source: APBJJlHFtnnIT3CduO3NVcIXRNDLdfE7BxHQu36vSq7y9d7xJ6FrwrG6pNHKxcrHgQyHkaWBFtVo+g==
X-Received: by 2002:a05:6512:3137:b0:4fb:8965:7882 with SMTP id p23-20020a056512313700b004fb89657882mr4465533lfd.35.1690195994950;
        Mon, 24 Jul 2023 03:53:14 -0700 (PDT)
Received: from mobilestation ([93.157.254.210])
        by smtp.gmail.com with ESMTPSA id g26-20020a19ee1a000000b004fb9fe34c27sm2162167lfb.92.2023.07.24.03.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 03:53:14 -0700 (PDT)
Date:   Mon, 24 Jul 2023 13:53:12 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v18 00/20] PCI: rcar-gen4: Add R-Car Gen4 PCIe support
Message-ID: <rhz7lezxzpzsdrwl3aq63fwn4nud2ynttgs5yamf4zwlmi3rwd@xklctlwuzzdk>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
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

On Fri, Jul 21, 2023 at 04:44:32PM +0900, Yoshihiro Shimoda wrote:
> Add R-Car S4-8 (R-Car Gen4) PCIe Host and Endpoint support.
> To support them, modify PCIe DesignWare common codes.

I'll have a closer look at the series later on this week.

-Serge(y)

> 
> Changes from v17:
> https://lore.kernel.org/linux-pci/20230705114206.3585188-1-yoshihiro.shimoda.uh@renesas.com/
>  - Based on the latest pci.git / next branch.
>  - Add comments in the commit log in the patch 01/20.
>  - Drop "Implicit" from "Message Routing" in the patch 01/20.
>  - Add Reviewed-by tag in the patch 0[14569]/20.
>  - Fix typo in the patch 07/20.
>  - Drop unnecessary description from the commit log in the patch 09/20.
>  - Add clk_bulk_disable_unprepare() calling in the patch 1[78]/20.
>  - Use .remove_new() in the patch 1[78]/20.
>  - Add rcar_gen4_pcie_basic_deinit() and .deinit() in the patch 17/20.
>  - Call rcar_gen4_pcie_basic_deinit() in .ep_deinit() in the patch 18/20.
>  - Minor updates for improved code readability in the patch 1[78]/20.
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
>  drivers/pci/controller/dwc/pcie-designware.h  |  35 ++-
>  drivers/pci/controller/dwc/pcie-keembay.c     |   2 +-
>  drivers/pci/controller/dwc/pcie-qcom-ep.c     |   4 +-
>  .../pci/controller/dwc/pcie-rcar-gen4-ep.c    | 189 +++++++++++++++++
>  .../pci/controller/dwc/pcie-rcar-gen4-host.c  | 149 +++++++++++++
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 200 ++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-rcar-gen4.h   |  44 ++++
>  drivers/pci/controller/dwc/pcie-tegra194.c    |   8 +-
>  drivers/pci/controller/dwc/pcie-uniphier-ep.c |   2 +-
>  drivers/pci/controller/pcie-rcar-ep.c         |   2 +-
>  drivers/pci/controller/pcie-rockchip-ep.c     |   2 +-
>  drivers/pci/endpoint/functions/pci-epf-test.c |  10 +-
>  drivers/pci/pci.h                             |  18 ++
>  include/linux/pci-epc.h                       |   4 +-
>  32 files changed, 1134 insertions(+), 159 deletions(-)
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
