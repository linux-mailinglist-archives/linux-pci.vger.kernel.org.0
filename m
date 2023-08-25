Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD09E788EB5
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 20:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjHYS2E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 14:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjHYS1i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 14:27:38 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589DDE67;
        Fri, 25 Aug 2023 11:27:33 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4ffa94a7a47so1845056e87.1;
        Fri, 25 Aug 2023 11:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692988051; x=1693592851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pi91gNrlpnAXuraBHh2yRna/sc+hxfkLOoI5kXfHcng=;
        b=nJarkQiUNw56JjTilZn474jTNxZhpJtFMLXVQrEUUSvwZF7lOKl/1aUpzLnMKFe/ya
         VD5Zi43DJ5Xwr9LZAIYb3mfJqzrPC0Y16Csonw5vdKhYc6nW6nHKKDqdDWcBPFKxQq0R
         3i3hBzGy3QwU4TRPXep/h/B8nP+5QYI7U0tK0OhZOpJVIx6hhpOXH7nkfNmcnJDdOnMF
         NeTey5GVUROANT9t/n6g7aPJOVR/kAwkltCyiQofE9sPitqBK/WrkfxjzpszS6Lk+rt+
         9IIPXljUgiSNGaMkC6IfUSsmpSWWYBKBpBzFph7ZHvJEIrk06KaJq7Wm9LpOAR88mzRw
         EIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692988051; x=1693592851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pi91gNrlpnAXuraBHh2yRna/sc+hxfkLOoI5kXfHcng=;
        b=bBD0qcZtzuFKRKFTNrSXApvy/uc8wellqfgpOfb3zpsG7DDJ92DZlwpVPPK5AdH1se
         cHrLTMyB+GBGKTaT/18sgobOyNasNBXW5eao4KLp+FdQcn75UhF7Qyv2TzxEv9jSPped
         PMuNSfyoju7hJ9oC4wVWw3bDcfShu7A7S9DEHKHGWBtu/HhUjTeRBFmbRC9juIeTus11
         7v+Nc7ACvfKk0+q35XkBOj3zs06KT4NBipMXY2gFMyuTqHKLveZl3/hgVhR2qMJz2bfW
         05j7JlR6jhUKnlmqGJnU0afsgqY/EshNiPoU3FHx7SCndiDXpEZLbudIAyUyjZ6ZZiwT
         lpgw==
X-Gm-Message-State: AOJu0YwvKXi/4fMmuPFQ6+k0G12Y7TDn7cbjQDVAk9d4vbcHdkWzy5EA
        CNG6xkQgwraGeK7oAXMPJJA=
X-Google-Smtp-Source: AGHT+IHpGxAAwWUcVwj27QtGoPWpakbTp4dHkAJsfti+D6luypuzh5eVe+BFZjw0Ql787CzbGhLE+Q==
X-Received: by 2002:a05:6512:2029:b0:4fb:81f2:4228 with SMTP id s9-20020a056512202900b004fb81f24228mr12561802lfs.31.1692988051262;
        Fri, 25 Aug 2023 11:27:31 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id f17-20020ac25331000000b00500a2091e2bsm376753lfh.99.2023.08.25.11.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 11:27:30 -0700 (PDT)
Date:   Fri, 25 Aug 2023 21:27:26 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        robh+dt@kernel.org, manivannan.sadhasivam@linaro.org,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v20 00/19] PCI: rcar-gen4: Add R-Car Gen4 PCIe support
Message-ID: <dgxpl5ubvpdgtgtkokgtn23kski2j57dwjddsthv6flza7bw2j@gp6rnifrxpbr>
References: <20230825093219.2685912-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825093219.2685912-1-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mani, Bjorn, Lorenzo, Krzysztof, Rob

On Fri, Aug 25, 2023 at 06:32:00PM +0900, Yoshihiro Shimoda wrote:
> Add R-Car S4-8 (R-Car Gen4) PCIe Host and Endpoint support.
> To support them, modify PCIe DesignWare common codes.

No more comments from my side for this series. It looks good to me
now. If you have nothing to note too please merge it in especially
seeing it's already v20.)

-Serge(y)

> 
> Changes from v19:
> https://lore.kernel.org/linux-pci/20230823091153.2578417-1-yoshihiro.shimoda.uh@renesas.com/
>  - Based on the latest pci.git / next branch and the following patches:
>    [PATCH v3 0/2] Cleanup IRQ type definitions
>    https://lore.kernel.org/linux-pci/20230802094036.1052472-1-dlemoal@kernel.org/
>  - Rename PCI_MSG_TYPE_R_* macros in the patch 01/19.
>  - Fix the comment in the patch 04/19.
>  - Add Reviewed-by in the patch {06,1[2678]/19.
>  - Modify common functions for the same method of clock handling in the patch
>    1[78]/19.
>  - Remove redundant gpio handling in the patch 16/19.
> 
> Changes from v18:
> https://lore.kernel.org/linux-pci/20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com/
>  - Based on the latest pci.git / next branch and the following patches:
>    [PATCH v3 0/2] Cleanup IRQ type definitions
>    https://lore.kernel.org/linux-pci/20230802094036.1052472-1-dlemoal@kernel.org/
>  - Drop some patches about converting "legacy" to "INTx".
>  - Add detailed description in the patch 0[26]/19.
>  - Add a new patch "Expose dw_pcie_write_dbi2" in the patch 11/19.
>  - Revise typo in the patch 12/19.
>  - Fix calling order of deinit in the patch 12/19.
>  - Revise Kconfig about kernel module names in the patch 1[67]/19.
>  - Rename drivers' file names in the patch 1[67]/19.
>  - Some other minor change/fix in the patch 1[67]/19.
> 
> Yoshihiro Shimoda (19):
>   PCI: Add INTx Mechanism Messages macros
>   PCI: dwc: Change arguments of dw_pcie_prog_outbound_atu()
>   PCI: dwc: Add outbound MSG TLPs support
>   PCI: designware-ep: Add INTx IRQs support
>   PCI: dwc: endpoint: Add multiple PFs support for dbi2
>   PCI: dwc: Add dw_pcie_link_set_max_link_width()
>   PCI: dwc: Add missing PCI_EXP_LNKCAP_MLW handling
>   PCI: tegra194: Drop PCI_EXP_LNKSTA_NLW setting
>   PCI: dwc: Add EDMA_UNROLL capability flag
>   PCI: dwc: Expose dw_pcie_ep_exit() to module
>   PCI: dwc: Expose dw_pcie_write_dbi2() to module
>   PCI: dwc: endpoint: Introduce .pre_init() and .deinit()
>   dt-bindings: PCI: dwc: Update maxItems of reg and reg-names
>   dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Host
>   dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Endpoint
>   PCI: rcar-gen4: Add R-Car Gen4 PCIe Host support
>   PCI: rcar-gen4-ep: Add R-Car Gen4 PCIe Endpoint support
>   MAINTAINERS: Update PCI DRIVER FOR RENESAS R-CAR for R-Car Gen4
>   misc: pci_endpoint_test: Add Device ID for R-Car S4-8 PCIe controller
> 
>  .../bindings/pci/rcar-gen4-pci-ep.yaml        | 106 ++++++++
>  .../bindings/pci/rcar-gen4-pci-host.yaml      | 123 ++++++++++
>  .../bindings/pci/snps,dw-pcie-ep.yaml         |   4 +-
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml |   4 +-
>  MAINTAINERS                                   |   1 +
>  drivers/misc/pci_endpoint_test.c              |   4 +
>  drivers/pci/controller/dwc/Kconfig            |  20 ++
>  drivers/pci/controller/dwc/Makefile           |   4 +
>  .../pci/controller/dwc/pcie-designware-ep.c   | 136 +++++++++--
>  .../pci/controller/dwc/pcie-designware-host.c |  52 ++--
>  drivers/pci/controller/dwc/pcie-designware.c  | 156 ++++++------
>  drivers/pci/controller/dwc/pcie-designware.h  |  29 ++-
>  .../controller/dwc/pcie-rcar-gen4-ep-drv.c    | 173 +++++++++++++
>  .../controller/dwc/pcie-rcar-gen4-host-drv.c  | 135 +++++++++++
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 227 ++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-rcar-gen4.h   |  44 ++++
>  drivers/pci/controller/dwc/pcie-tegra194.c    |   6 -
>  drivers/pci/pci.h                             |  18 ++
>  18 files changed, 1111 insertions(+), 131 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
>  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-ep-drv.c
>  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-host-drv.c
>  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.c
>  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.h
> 
> -- 
> 2.25.1
> 
