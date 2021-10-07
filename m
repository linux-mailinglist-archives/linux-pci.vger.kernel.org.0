Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D449425388
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 14:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240452AbhJGM71 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 08:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233872AbhJGM70 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Oct 2021 08:59:26 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02492C061746
        for <linux-pci@vger.kernel.org>; Thu,  7 Oct 2021 05:57:33 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id n2so3835816plk.12
        for <linux-pci@vger.kernel.org>; Thu, 07 Oct 2021 05:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vQY2vR3JgZ7UpKkWrQZDehl7P8KiMsXS+BrIiJW4faw=;
        b=bJomXKg/1nq3R2YS3lQKJ7igUG7a7MxOQThIPFhHbftHvmvrdGqDEIW79PQhyKvxVK
         qPv1ngrKQOeadlDBNPyU5hcBB1bKVzqkwDZzBIyX0BemoAl5JjRQ2USYjYzBdEJIincc
         4sCIG3uEdrnrBKtANe13OFMiEYrDpn/BuF0suYziikgWqhH0oRYIFOzbfqVjwyuwVnJE
         5ZEFj/JJfCERacrVLTV1gn4GeLhwG4YNEtr7/92G5GKbW4FqgSL7YnX0XpXOoPZEi6gK
         7oCCIbIhjGPLsJuHDK2v2Dcgu94pZH06MxvIuAa8sfL59IHT37o7DmILh7+JWcD+r5dQ
         kCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vQY2vR3JgZ7UpKkWrQZDehl7P8KiMsXS+BrIiJW4faw=;
        b=zcbZPRRieftVjn6WEX4h5PmCwRDWPGfAe/Iy3V46ye9+D+TQWtED4Po3ofVzG+8Wk8
         D/F8Ve8ifcnqtKP/cp7GlGwApbw04WmLVz7B5mZMO+P5JluQzyinSmJeWBV+fQYoBJJf
         5iSUKTIQXNOpWr4Bm8rErnJOafTdFtmK/LbYjdCsCa6+u2Qbt5gdi3HKybaU/VdRoOva
         Yk+sWZgD0ZGVjzApWZyeHcKb6oqfh9FJQIiVxsvvaCgz3gW7R6oJqj6qRorbN1Qo4c/M
         D49vhR0cn58wC7XSpNQNAzGjOa4492FIQEYCYPRG/tw0FIpcwmkKOiH58HrUqAIJYRSU
         T4dw==
X-Gm-Message-State: AOAM531cgzIhumTUregm+PP+/wc5hDK5hjUSBBuRzQLrgqnc1CFHc75j
        aNmMJRQwdJBwGbQGqWjFY4vL
X-Google-Smtp-Source: ABdhPJyYuVz4xSiU1qQP1SwuVkloHPNzNlgzKo/0anLbdAkCS6A455j327vkwO03/OU8G/f5B8dbwQ==
X-Received: by 2002:a17:902:e0c2:b0:13e:7f73:f181 with SMTP id e2-20020a170902e0c200b0013e7f73f181mr3600459pla.10.1633611452428;
        Thu, 07 Oct 2021 05:57:32 -0700 (PDT)
Received: from thinkpad ([117.202.189.72])
        by smtp.gmail.com with ESMTPSA id rm6sm2881121pjb.18.2021.10.07.05.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 05:57:31 -0700 (PDT)
Date:   Thu, 7 Oct 2021 18:27:24 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        robh@kernel.org
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        hemantk@codeaurora.org, bjorn.andersson@linaro.org,
        sallenki@codeaurora.org, skananth@codeaurora.org,
        vpernami@codeaurora.org, vbadigan@codeaurora.org
Subject: Re: [PATCH v8 0/3] Add Qualcomm PCIe Endpoint driver support
Message-ID: <20211007125724.GA27987@thinkpad>
References: <20210920065946.15090-1-manivannan.sadhasivam@linaro.org>
 <20211004041949.GA16442@workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004041949.GA16442@workstation>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 04, 2021 at 09:49:49AM +0530, Manivannan Sadhasivam wrote:
> On Mon, Sep 20, 2021 at 12:29:43PM +0530, Manivannan Sadhasivam wrote:
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
> > 
> 
> Ping on this series! Patchwork says the state is still "New". Both
> binding and driver patches got enough reviews I believe. Are there any
> issues pending to be addressed?
> 

Sorry for the noise. But not seeing any activity on this series is tempting me
to ping this thread. This series has been under review for almost 3 releases and
I don't want to miss this one too without any obvious reasons.

Thanks,
Mani

> Thanks,
> Mani
> 
> > Thanks,
> > Mani
> > 
> > Changes in v8:
> > 
> > * Added Reviewed-by tag from Rob for the driver patch
> > * Rebased on top of v5.15-rc1
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
> > -- 
> > 2.25.1
> > 
