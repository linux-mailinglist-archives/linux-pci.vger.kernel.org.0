Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2767642052C
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 06:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbhJDEVp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 00:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbhJDEVo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 00:21:44 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B549AC061783
        for <linux-pci@vger.kernel.org>; Sun,  3 Oct 2021 21:19:55 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id v19so10622301pjh.2
        for <linux-pci@vger.kernel.org>; Sun, 03 Oct 2021 21:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nkBLnfIsoJnhn8NRb8usqu66QRMK/RQn75Px35J6+AY=;
        b=ot2u8Z/Yt5Y0ISRxv8cit0uhhE08cvJeaL0HcPO+pnukIRlTCL8euTXBY2lNukLRPF
         2UCy6Yn30smr1/SpsDEl3Ppxx0n0iegZdv9qthlHsdQRtUL8DAcKm7YJpS69/EBK2sd2
         RBdMYYwD5hkQh9zIqMZugdXquRaXrVVcypWrNuVmFPPlboTnHpVArF44Ap03dGbgARTW
         9X10YSGSvRGWQn69t2jh0tUOXOPZm6AiGLS4xPfSKW2APdBrIofimyqa4iKUaPVgCmNX
         gHSzoAYBXuucfaL6uKcy2LzID0wQtmYkeu6ZZ7QKrphwNp5AV5OEI7ShXmv+5RRPcsjl
         ISkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nkBLnfIsoJnhn8NRb8usqu66QRMK/RQn75Px35J6+AY=;
        b=q9T0wXPmxKMW9y/CWHEBx0cnCNeXHjAOF6sXnn8Tad+al9yyjimPXaxaTyb7jfZ1vz
         l43+B+3nAVCIF0P+NVFl21R5sqg0saymWkJNtgTGQ9HDkIO6h+6ifX5hHZ+zYcjTN8eQ
         rgTf/wFY71G0fwJCJzCpWNQ63WTZrkrav2hrBRtoFpr5TPxJHVlrwqgDKbUZegjwhXXb
         u1CJWk1p1dkWqN8bLg9eJ4BYbZK1hT8NekXk7gDXOcHWdSQENt1YLi/wdmwnpA7Zu7uV
         QX67AeoFqSv8s4C4LsxhWwc+ELO9zO1H6qN9bOvN8uTUQW+LGi2kMLowQoCXNUH7R+qm
         oesg==
X-Gm-Message-State: AOAM5336xDTLLq42fW/q0ndw9g9JHYFb8o5Rqjzal+770VPxCbsxbo3h
        7r3V3mfYRrpEb7XbYsGaNdao
X-Google-Smtp-Source: ABdhPJwtQWBeQqrtBE+6wxqEVwZ0D1JaosowhqtpKk0F8kGR/QDu96iWhiOtM5i6ncvsnyPMFCna3g==
X-Received: by 2002:a17:902:9895:b0:13c:94f8:d74b with SMTP id s21-20020a170902989500b0013c94f8d74bmr22483622plp.20.1633321194891;
        Sun, 03 Oct 2021 21:19:54 -0700 (PDT)
Received: from workstation ([120.138.13.170])
        by smtp.gmail.com with ESMTPSA id g27sm12887048pfk.173.2021.10.03.21.19.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Oct 2021 21:19:54 -0700 (PDT)
Date:   Mon, 4 Oct 2021 09:49:49 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        robh@kernel.org
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        hemantk@codeaurora.org, bjorn.andersson@linaro.org,
        sallenki@codeaurora.org, skananth@codeaurora.org,
        vpernami@codeaurora.org, vbadigan@codeaurora.org
Subject: Re: [PATCH v8 0/3] Add Qualcomm PCIe Endpoint driver support
Message-ID: <20211004041949.GA16442@workstation>
References: <20210920065946.15090-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920065946.15090-1-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 20, 2021 at 12:29:43PM +0530, Manivannan Sadhasivam wrote:
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

Ping on this series! Patchwork says the state is still "New". Both
binding and driver patches got enough reviews I believe. Are there any
issues pending to be addressed?

Thanks,
Mani

> Thanks,
> Mani
> 
> Changes in v8:
> 
> * Added Reviewed-by tag from Rob for the driver patch
> * Rebased on top of v5.15-rc1
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
