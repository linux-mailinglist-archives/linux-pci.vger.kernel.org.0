Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5228F3DE629
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 07:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbhHCF1Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 01:27:25 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47176 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhHCF1Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Aug 2021 01:27:25 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1735R7xT081485;
        Tue, 3 Aug 2021 00:27:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1627968427;
        bh=3GymSx5fuQhs/15Zd9CuB3vkNv8nNT+a9AI+QPpxCyQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=WDAAJ7MotOnmaj14mbtTpbefjyXXM02gXxzxgjaSz4Nf5Jdi+IABNlK3Sel0KH2AE
         ZhwpeeRJ6HasiZQhizT0gCB6Ig2aUwjddFoR47+8xnkKZHqShMAo/B0k4EIi2Z4LRN
         7NSqXRs3PUZfblU9CdXuHL/1Kr5+aUWOWDhniwnc=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1735R7KX002559
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Aug 2021 00:27:07 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 3 Aug
 2021 00:27:07 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 3 Aug 2021 00:27:07 -0500
Received: from [10.250.232.99] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1735R1V1115154;
        Tue, 3 Aug 2021 00:27:02 -0500
Subject: Re: [PATCH v7 0/3] Add Qualcomm PCIe Endpoint driver support
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <hemantk@codeaurora.org>, <smohanad@codeaurora.org>,
        <bjorn.andersson@linaro.org>, <sallenki@codeaurora.org>,
        <skananth@codeaurora.org>, <vpernami@codeaurora.org>,
        <vbadigan@codeaurora.org>
References: <20210722121242.47838-1-manivannan.sadhasivam@linaro.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <2a0b7f85-dcd7-fc87-8e02-37725f66b9cf@ti.com>
Date:   Tue, 3 Aug 2021 10:57:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210722121242.47838-1-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Manivannan,

On 22/07/21 5:42 pm, Manivannan Sadhasivam wrote:
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

Can you also validate it with in-kernel pci-endpoint-test?

It would also help if you can test your patches after
https://lore.kernel.org/r/20210803050310.27122-1-kishon@ti.com

Not expecting any dependencies but just to cross check.

Thanks
Kishon

> 
> Thanks,
> Mani
> 
> Changes in v7:
> 
> * Used existing naming convention for callback functions
> * Used active low state for PERST# gpio
> 
> Changes in v6:
> 
> * Removed status property in DT and added reviewed tag from Rob
> * Switched to _relaxed variants as suggested by Rob
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
>   PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver
>   MAINTAINERS: Add entry for Qualcomm PCIe Endpoint driver and binding
> 
>  .../devicetree/bindings/pci/qcom,pcie-ep.yaml | 158 ++++
>  MAINTAINERS                                   |  10 +-
>  drivers/pci/controller/dwc/Kconfig            |  10 +
>  drivers/pci/controller/dwc/Makefile           |   1 +
>  drivers/pci/controller/dwc/pcie-qcom-ep.c     | 710 ++++++++++++++++++
>  5 files changed, 888 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
>  create mode 100644 drivers/pci/controller/dwc/pcie-qcom-ep.c
> 
