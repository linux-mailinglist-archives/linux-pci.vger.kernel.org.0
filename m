Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255F33FBC87
	for <lists+linux-pci@lfdr.de>; Mon, 30 Aug 2021 20:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbhH3SgL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Aug 2021 14:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbhH3SgK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Aug 2021 14:36:10 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDC8C06175F
        for <linux-pci@vger.kernel.org>; Mon, 30 Aug 2021 11:35:16 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id d3-20020a17090ae28300b0019629c96f25so598152pjz.2
        for <linux-pci@vger.kernel.org>; Mon, 30 Aug 2021 11:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4lObGbOH7wYXLZts3Wjag1RVJ/fSvvfuumDMeXOvamY=;
        b=Q7lSvLugEcsO6jz/dsvEvqZfD5CfuPaFmPsqDAtVPqSs20Jd/6dgCj3+ylqcIr1EnF
         jwLepnTsPsP/+QPpe0p2M4mjvLGTJj0BWKxHTP9O7z1aO2tFiTY3aHcZlUOb+a6XlQXM
         ATUXIgkDyHiUBCYrZWUoo8y35gJiW/5N5IyhGJ73fequBefUKl85zNfhuYdjRjOwkFFO
         DMcbXDNdSqX8SPThW2njxQagVjwPbOA5wHbxiKMLnrCe3jWHierYYo0BcKop19CuPfp+
         rkjM8Q2Fg/hZzBzo1IglI+E+uAlQI1OjhJFzgdnkDt7bDMl3n3HYnvg6BBlII8/6fxOb
         eN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4lObGbOH7wYXLZts3Wjag1RVJ/fSvvfuumDMeXOvamY=;
        b=UIDm3Wyh7O32tmdew+s+h+dle85pvCS1e48tRJa4dZj8g5bj2uyYB2ZoTlb6ka3J26
         hwQVXfv4dEW5i43VXweUQpok9hi0M/ATAXRALO8821QgGECwTDBsQxCteuvt7r6FKLs2
         E4FepGmvDvdG0XyN1z9v9T2wA583hXu7To3qT9yi1P2+zjgOIooucjg3L0Kll5oWg2I4
         A39VkajNrMORBV2THjJQ2SXYQ9U+1qoI2LCjIxQuf+13G/rTbhINtZKAo1hpvHuVWjSU
         mnWBBtC3pfYlmbF0SHokm+72SLWIWWEGnFQYu8gnay7jKuA0vWXI4NiehuBjbV5sQFcK
         Tkqw==
X-Gm-Message-State: AOAM533u5NLfiY6Jh9EPzOjfS0HtdFYgWOf+sVzecysRoEgPowM5JP08
        T0AWeqB4Gtp5C+HWCST5NbPL
X-Google-Smtp-Source: ABdhPJymp1hhLxI4Bg+PenRAv5ZqZvFwlomKc4Z90s9V466OSSk/8nDL72VECdaY3v0GglRuL8taGg==
X-Received: by 2002:a17:90a:940e:: with SMTP id r14mr497274pjo.208.1630348516218;
        Mon, 30 Aug 2021 11:35:16 -0700 (PDT)
Received: from thinkpad ([2409:4072:6e8f:10da:9c90:a2f4:77aa:6f51])
        by smtp.gmail.com with ESMTPSA id n14sm208169pjm.5.2021.08.30.11.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 11:35:15 -0700 (PDT)
Date:   Tue, 31 Aug 2021 00:05:08 +0530
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
Message-ID: <20210830183508.GA50238@thinkpad>
References: <20210722121242.47838-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722121242.47838-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

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

Any chance this driver could make v5.15?

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
