Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340593B93DF
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jul 2021 17:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbhGAP1p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 11:27:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233064AbhGAP1p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Jul 2021 11:27:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E12A96140A;
        Thu,  1 Jul 2021 15:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625153114;
        bh=+xwpidjwxHnbYP8ChZRNxTaoNpy++W26pPBlNiZG1Es=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YE1gmcnGC9g80E48RRI74yVfqEgwwBB2bKAeTy4DSkuQhlA9/8EOdAK+quQe0R/fZ
         QZGdA60OQIAmf8X54geE76/5GIhw2kc8aPAkegkan+nwD+yYdnrOEtLGHngCzXszMi
         z/8iYsXxwzLtyuUWHEHaNgvnIaIqwYcbmg3uLh+9ukbLGgk8D9/d+WsfqdzShslDRC
         4E8DyJ+UVGFQSXByxm0ESUjpqZIfzPhXLbe5XTP4BzMppZXitZ5m/4k6rLQCPs31zX
         8eOwQWjYoLw2uXyx+edD60Yd9zlQEUdA8T2OksazGEWz2WvimcIHL1CKGuKlMRx0Y2
         h9ro5wQDaYH3g==
Received: by mail-ej1-f45.google.com with SMTP id bg14so11020110ejb.9;
        Thu, 01 Jul 2021 08:25:14 -0700 (PDT)
X-Gm-Message-State: AOAM5321ZNxX9mQ30BQBya0tz6yj0neSExHS0EUuFz0/u+toUPQdhbk4
        dogHXhxWwkmCMCoVLYOAOrViU96aaOxzBkEY8w==
X-Google-Smtp-Source: ABdhPJzUEsTvx8EteF/IK3c/gYkviXw1F7trsPeasxSHv8iu+ZIaHLTIVsLiLpAQlbHQOTQVV45g91QrmyohrBAw17o=
X-Received: by 2002:a17:907:3e8a:: with SMTP id hs10mr372288ejc.359.1625153113214;
 Thu, 01 Jul 2021 08:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210630034653.10260-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20210630034653.10260-1-manivannan.sadhasivam@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 1 Jul 2021 09:25:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLHp3kBc1VtGVRxVr_k69GqSC_JX88jo3stdM4W9Qq6AQ@mail.gmail.com>
Message-ID: <CAL_JsqLHp3kBc1VtGVRxVr_k69GqSC_JX88jo3stdM4W9Qq6AQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add Qualcomm PCIe Endpoint driver support
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org, PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        hemantk@codeaurora.org,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        skananth@codeaurora.org, vpernami@codeaurora.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 29, 2021 at 9:47 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Hello,
>
> This series adds support for Qualcomm PCIe Endpoint controller found
> in platforms like SDX55. The Endpoint controller is based on the designware
> core with additional Qualcomm wrappers around the core.
>
> The driver is added separately unlike other Designware based drivers that
> combine RC and EP in a single driver. This is done to avoid complexity and
> to maintain this driver autonomously.
>
> The driver has been validated with an out of tree MHI function driver on
> SDX55 based Telit FN980 EVB connected to x86 host machine over PCIe.
>
> Thanks,
> Mani
>
> Changes in v5:
>
> * Removed the DBI register settings that are not needed
> * Used the standard definitions available in pci_regs.h
> * Added defines for all the register fields
> * Removed the left over code from previous iteration
>
> Changes in v4:
>
> * Removed the active_config settings needed for IPA integration
> * Switched to writel for couple of relaxed versions that sneaked in

I thought we resolved this discussion. Use _relaxed variants unless
you need the stronger ones.

Rob

>
> Changes in v3:
>
> * Lot of minor cleanups to the driver patch based on review from Bjorn and Stan.
> * Noticeable changes are:
>   - Got rid of _relaxed calls and used readl/writel
>   - Got rid of separate TCSR memory region and used syscon for getting the
>     register offsets for Perst registers
>   - Changed the wake gpio handling logic
>   - Added remove() callback and removed "suppress_bind_attrs"
>   - stop_link() callback now just disables PERST IRQ
> * Added MMIO region and doorbell interrupt to the binding
> * Added logic to write MMIO physicall address to MHI base address as it is
>   for the function driver to work
>
> Changes in v2:
>
> * Addressed the comments from Rob on bindings patch
> * Modified the driver as per binding change
> * Fixed the warnings reported by Kbuild bot
> * Removed the PERST# "enable_irq" call from probe()
>
> Manivannan Sadhasivam (3):
>   dt-bindings: pci: Add devicetree binding for Qualcomm PCIe EP
>     controller
>   PCI: dwc: Add Qualcomm PCIe Endpoint controller driver
>   MAINTAINERS: Add entry for Qualcomm PCIe Endpoint driver and binding
>
>  .../devicetree/bindings/pci/qcom,pcie-ep.yaml | 160 ++++
>  MAINTAINERS                                   |  10 +-
>  drivers/pci/controller/dwc/Kconfig            |  10 +
>  drivers/pci/controller/dwc/Makefile           |   1 +
>  drivers/pci/controller/dwc/pcie-qcom-ep.c     | 742 ++++++++++++++++++
>  5 files changed, 922 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
>  create mode 100644 drivers/pci/controller/dwc/pcie-qcom-ep.c
>
> --
> 2.25.1
>
