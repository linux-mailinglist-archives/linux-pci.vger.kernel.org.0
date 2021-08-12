Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5A23EA667
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 16:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237259AbhHLOTM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Aug 2021 10:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbhHLOTM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Aug 2021 10:19:12 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E415C0617AD
        for <linux-pci@vger.kernel.org>; Thu, 12 Aug 2021 07:18:47 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id lw7-20020a17090b1807b029017881cc80b7so15437452pjb.3
        for <linux-pci@vger.kernel.org>; Thu, 12 Aug 2021 07:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BYIEVqAwtUQet5A0SgR3uxf9S0vFKIdFocOOg6UEHvc=;
        b=sZjJmMgs/qL5hh52BRvV7+VDIbNIvxy75sTex2lp1gz7Dy6zjw7u/ZJcYjFeGEqr3j
         EO4clORky0VgE26w1ua1vEagYaQB7OuahuAGnDfN+yPsrPf2iDnrsflisqTEeSk+ZiTO
         qgq8LmRLs2MtXn4KWqKmwgZ5SL8bUytKCv9KE6vN+TweSx4G7QCuiF6sXUX3zt3FzwPy
         bK2AXNWvgfZ01jLRXUD11ONVMnRNsCskQSnn5yphCxvjfbOn+THOmF8KraziQohUn5hQ
         1AAJaB0DNuqbI0Fdj5vwbGf4PkMktVAPr57SPkP9b6V64uFMqzdyCMJ4RKNhe/MF7fz5
         dlnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BYIEVqAwtUQet5A0SgR3uxf9S0vFKIdFocOOg6UEHvc=;
        b=jMlaOlLoy3qfVXPOHKUkIHyrrI6wmbtvgHCx0ZpPqdPnsFsk2NHhBTucOf33F25EAf
         6gyDQDHDnaKM7uU+PgZjxDE0ABVtSk21jOXsYNzJfYskFqJxklVgRUfmUoBpK+3jXh1V
         2arxf6/nPRdddfQLw6OanrMozdvb2m5KLXc+Pwxg4kdzlml5P/80InQthlNncMKqcExb
         nGc0UtpS8OsNVv6OzqEM8r+/b/s+rt5S2HY/bahMuSPttOUiqql/Mp54eMJg+0wrEhOk
         o+v3zkbmH7J6zftQP5EdLbzWXrfo0HBMIoHgwq6sq1m+PYskt6FX8gDfm54UGnBdU1nf
         TV8Q==
X-Gm-Message-State: AOAM530nuhkKyTcFguiDEqMVKoXBZPdTg/VwI1GoWn1D2HSBrfr70fgm
        QI7yDj9Ar5ciBEgfZGzH0cDY
X-Google-Smtp-Source: ABdhPJw6FoC6XUQlLIUFbTLhHX7pIBFRmHDm5S+hGtJ/FJbTjlF73jJSPu5m90BuVOp54j24GS1efA==
X-Received: by 2002:a63:88c7:: with SMTP id l190mr4036320pgd.438.1628777926652;
        Thu, 12 Aug 2021 07:18:46 -0700 (PDT)
Received: from workstation ([120.138.12.52])
        by smtp.gmail.com with ESMTPSA id b9sm2836554pfo.175.2021.08.12.07.18.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Aug 2021 07:18:46 -0700 (PDT)
Date:   Thu, 12 Aug 2021 19:48:41 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh@kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        hemantk@codeaurora.org, smohanad@codeaurora.org,
        bjorn.andersson@linaro.org, sallenki@codeaurora.org,
        skananth@codeaurora.org, vpernami@codeaurora.org,
        vbadigan@codeaurora.org
Subject: Re: [PATCH v7 0/3] Add Qualcomm PCIe Endpoint driver support
Message-ID: <20210812141841.GD7897@workstation>
References: <20210722121242.47838-1-manivannan.sadhasivam@linaro.org>
 <2a0b7f85-dcd7-fc87-8e02-37725f66b9cf@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a0b7f85-dcd7-fc87-8e02-37725f66b9cf@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,

On Tue, Aug 03, 2021 at 10:57:00AM +0530, Kishon Vijay Abraham I wrote:
> Hi Manivannan,
> 
> On 22/07/21 5:42 pm, Manivannan Sadhasivam wrote:
> > Hello,
> > 
> > This series adds support for Qualcomm PCIe Endpoint controller found
> > in platforms like SDX55. The Endpoint controller is based on the designware
> > core with additional Qualcomm wrappers around the core.
> > 
> > The driver is added separately unlike other Designware based drivers that
> > combine RC and EP in a single driver. This is done to avoid complexity and
> > to maintain this driver autonomously.
> > 
> > The driver has been validated with an out of tree MHI function driver on
> > SDX55 based Telit FN980 EVB connected to x86 host machine over PCIe.
> 
> Can you also validate it with in-kernel pci-endpoint-test?
> 

The Qcom EP driver or the DWC IP is designed to work only for MHI bus
that has the fixed BAR address and register layout etc...

So we can't use the pci-endpoint-test driver to validate the EP driver.
But I do have an out of tree MHI EPF driver and validated using that.

> It would also help if you can test your patches after
> https://lore.kernel.org/r/20210803050310.27122-1-kishon@ti.com
> 

I added below patches (v7) on top and verified that the EP driver works fine.

PCI: endpoint: Add virtual function number in pci_epc ops
PCI: endpoint: Add support to link a physical function to a virtual function
PCI: endpoint: Add support to add virtual function in endpoint core

Thanks,
Mani

> Not expecting any dependencies but just to cross check.
> 
> Thanks
> Kishon
> 
> > 
> > Thanks,
> > Mani
> > 
> > Changes in v7:
> > 
> > * Used existing naming convention for callback functions
> > * Used active low state for PERST# gpio
> > 
> > Changes in v6:
> > 
> > * Removed status property in DT and added reviewed tag from Rob
> > * Switched to _relaxed variants as suggested by Rob
> > 
> > Changes in v5:
> > 
> > * Removed the DBI register settings that are not needed
> > * Used the standard definitions available in pci_regs.h
> > * Added defines for all the register fields
> > * Removed the left over code from previous iteration
> > 
> > Changes in v4:
> > 
> > * Removed the active_config settings needed for IPA integration
> > * Switched to writel for couple of relaxed versions that sneaked in
> > 
> > Changes in v3:
> > 
> > * Lot of minor cleanups to the driver patch based on review from Bjorn and Stan.
> > * Noticeable changes are:
> >   - Got rid of _relaxed calls and used readl/writel
> >   - Got rid of separate TCSR memory region and used syscon for getting the
> >     register offsets for Perst registers
> >   - Changed the wake gpio handling logic
> >   - Added remove() callback and removed "suppress_bind_attrs"
> >   - stop_link() callback now just disables PERST IRQ
> > * Added MMIO region and doorbell interrupt to the binding
> > * Added logic to write MMIO physicall address to MHI base address as it is
> >   for the function driver to work
> > 
> > Changes in v2:
> > 
> > * Addressed the comments from Rob on bindings patch
> > * Modified the driver as per binding change
> > * Fixed the warnings reported by Kbuild bot
> > * Removed the PERST# "enable_irq" call from probe()
> > 
> > Manivannan Sadhasivam (3):
> >   dt-bindings: pci: Add devicetree binding for Qualcomm PCIe EP
> >     controller
> >   PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver
> >   MAINTAINERS: Add entry for Qualcomm PCIe Endpoint driver and binding
> > 
> >  .../devicetree/bindings/pci/qcom,pcie-ep.yaml | 158 ++++
> >  MAINTAINERS                                   |  10 +-
> >  drivers/pci/controller/dwc/Kconfig            |  10 +
> >  drivers/pci/controller/dwc/Makefile           |   1 +
> >  drivers/pci/controller/dwc/pcie-qcom-ep.c     | 710 ++++++++++++++++++
> >  5 files changed, 888 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> >  create mode 100644 drivers/pci/controller/dwc/pcie-qcom-ep.c
> > 
