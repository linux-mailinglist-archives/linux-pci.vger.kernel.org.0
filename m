Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36283F19F3
	for <lists+linux-pci@lfdr.de>; Thu, 19 Aug 2021 15:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbhHSNGV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Aug 2021 09:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237068AbhHSNGV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Aug 2021 09:06:21 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4FBC06175F
        for <linux-pci@vger.kernel.org>; Thu, 19 Aug 2021 06:05:45 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id g14so5446046pfm.1
        for <linux-pci@vger.kernel.org>; Thu, 19 Aug 2021 06:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j8qRe1VcgbKWgoFHwQvjx82rgCmqdfKPSvrqgoYqCbA=;
        b=jdk7f1rzl3NRxVo1+xPnWg+iCvrUhWP14lkj84hbls/oNbMOmphY8w52NYVAxKp3h/
         jUXYBmZ4cPn6QbmLihNW6zppH+1H6Evm6Wl6t99703iPjbUcosFND1eH1oAtZvVc6t+a
         /mURa0GkFJ8Ux9Niv3UZlUx8NIa7m5w8yBQNU5DVHCIsON+KNdfDg8Sw3YRz81hBL3W7
         1ws1vPcsoH6pAk1O+seh5qKXpuMAW8oVJMpFuA8+0D/s3coWn4BDcoEJz8anuqssKGya
         ujsxN+9TSlSINtJrrHbYaJ+SrVLFUgENjLkDEQ+6KE1CflQTJ1NqE/3uqzyLFH/hHCFw
         G2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j8qRe1VcgbKWgoFHwQvjx82rgCmqdfKPSvrqgoYqCbA=;
        b=tF0m0xt/T5fNfBXYwFjuHFCMoVGO9DK96XgzxXRrRQNA98WnlquJDaHLgc+e14py3h
         mwwLVbjY5fRXzm/l3+Opk3aUmkl66jKA1Zy7TOSa4n63LTFjH6O6JOthrnOIr6lLVUNq
         a05aLeiaJH4tNlWcQYNw8towFxauJtsC/R5sloZfzZcVSGhftIr8wMPpdYovTRN5eRJV
         VLI9goudculd4obPkJZIIRyPCLI40VHadfrYG1PSI30Gr/YeqG882McFEmZjRSyFIFCI
         nqyugAsGaJCNUx3geIkwnhJx8nbkz53PAH38HGEoa4gFP4IhbTp4ostnBCQEIICZq+S9
         K4Rg==
X-Gm-Message-State: AOAM532LU0anCq3kaIZJVksSCREZSFXgmdc0HuaT0B/ceKyBt8R0RtXq
        J+iDayZWhXx0pSQp2KlZnsCG
X-Google-Smtp-Source: ABdhPJwlVNkMT+7xFKhx8E+8JStufdEOlSgD/pRBJfUXBKrF7CvNcdgxlg7uDkzV3BlxwcQZUAHUig==
X-Received: by 2002:a63:2541:: with SMTP id l62mr14330979pgl.183.1629378344655;
        Thu, 19 Aug 2021 06:05:44 -0700 (PDT)
Received: from thinkpad ([2409:4072:6298:4497:5a1e:ff34:9091:5bac])
        by smtp.gmail.com with ESMTPSA id fh2sm3135830pjb.12.2021.08.19.06.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 06:05:44 -0700 (PDT)
Date:   Thu, 19 Aug 2021 18:35:37 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        robh@kernel.org
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        hemantk@codeaurora.org, smohanad@codeaurora.org,
        bjorn.andersson@linaro.org, sallenki@codeaurora.org,
        skananth@codeaurora.org, vpernami@codeaurora.org,
        vbadigan@codeaurora.org
Subject: Re: [PATCH v7 0/3] Add Qualcomm PCIe Endpoint driver support
Message-ID: <20210819130537.GA200135@thinkpad>
References: <20210722121242.47838-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722121242.47838-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 22, 2021 at 05:42:39PM +0530, Manivannan Sadhasivam wrote:
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

Ping on this series!

Thanks,
Mani

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
> -- 
> 2.25.1
> 
