Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B9F3C55C8
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jul 2021 12:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345920AbhGLIMA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jul 2021 04:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353281AbhGLIBs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jul 2021 04:01:48 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0633BC0604C1
        for <linux-pci@vger.kernel.org>; Mon, 12 Jul 2021 00:53:08 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id d12so17395000pgd.9
        for <linux-pci@vger.kernel.org>; Mon, 12 Jul 2021 00:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8H0yUJOEvi3zZTuxDoA57QDVjTfFiJnGcoqqzbwxmVs=;
        b=ZG5p7Tqp7gaCXtfqcGueAgC03BaZ6tkCjgmLL+HntOiwhJVqLV6P6FH1PU6ijigIwa
         2D4aHrU2WxmK0t/cVP5bhnfA6Hkfog08BhnyIsOcgCOM9FnYRcvnd7v6hZUq3SbkC8p8
         drICwrUijHqS3WKlo2GtM6VUvreUSiSm45XYaSrDodqEoAdcJwkF91hPc2NmPEe2cBy8
         Ln6qOoZO1+4J3z+jn4vMSOYSxCAI7XrZrZj0PRJtLPs4Ww9EUDq+huGj459Y7BO1sr9d
         e2PNoPqExJBslLp/TZZ8xwXSDQ/72n1gP1FAu2OXrZICejo4aQ5No5TQFgZsULmFensl
         vafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8H0yUJOEvi3zZTuxDoA57QDVjTfFiJnGcoqqzbwxmVs=;
        b=SPR6OAU1tqIcmbr0JUZNn4NH3e2uWbDdaISylyzkcvZd53PM0NfxV1RBcFyYUM/ncV
         G9beYRrIvkpVUP/Qqivg6S1d7dRpxGlw1J8qaTd7kJUhUc+Y2rkLs4muBLX51vMM+7qJ
         oJ54ZdobWJ+t5JD6D1asBfCviOsnnYsjVV9ofleQT6i5nNvfY7kfOu8Zy9qHsUeapeV2
         tWzc8MZIYi66vo/vVhVk6dSJKSEeK/HE4b8lps6Z8d/BvdRL7RiQjZj1EhSC1XUqfysu
         ZderMQctMIkQu/QT8JcjZLho6QyuxcuUBbzvbOO9xUaEiCAPLN6CXBtwR+UAjtNxzMRk
         M54A==
X-Gm-Message-State: AOAM533tB3j1DmeW74MQqUf2w3KWJSOR356VVKdMvoUdzNa0EHv2t3qc
        N7MpwRFb5tnTYy2Qbtb8RiCK
X-Google-Smtp-Source: ABdhPJwSTnl9VFCmFcSRDus9OJnYbw708x25bRrEGojoECLrgUODo4vjpCMqB2mk+hCd78dAXbA+kw==
X-Received: by 2002:a62:1d86:0:b029:32a:311a:9595 with SMTP id d128-20020a621d860000b029032a311a9595mr10855485pfd.74.1626076387347;
        Mon, 12 Jul 2021 00:53:07 -0700 (PDT)
Received: from workstation ([120.138.12.18])
        by smtp.gmail.com with ESMTPSA id z3sm16409753pgl.77.2021.07.12.00.53.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Jul 2021 00:53:07 -0700 (PDT)
Date:   Mon, 12 Jul 2021 13:23:02 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rob Herring <robh@kernel.org>
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
Subject: Re: [PATCH v5 0/3] Add Qualcomm PCIe Endpoint driver support
Message-ID: <20210712075302.GA8113@workstation>
References: <20210630034653.10260-1-manivannan.sadhasivam@linaro.org>
 <CAL_JsqLHp3kBc1VtGVRxVr_k69GqSC_JX88jo3stdM4W9Qq6AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLHp3kBc1VtGVRxVr_k69GqSC_JX88jo3stdM4W9Qq6AQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 01, 2021 at 09:25:01AM -0600, Rob Herring wrote:
> On Tue, Jun 29, 2021 at 9:47 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
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
> > Thanks,
> > Mani
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
> 
> I thought we resolved this discussion. Use _relaxed variants unless
> you need the stronger ones.
> 

I thought the discussion was resolved in favor of using read/writel. Here
is the last reply from Bjorn:

"I think we came to the conclusion that writel() was better
than incorrect use of writel_relaxed() followed by wmb(). And in this
particular case it's definitely not happening in a hot code path..."

IMO, it is safer to use readl/writel calls than the relaxed variants.
And so far the un-written rule I assumed is, only consider using the
relaxed variants if the code is in hot path (but somehow I used the
relaxed version in v1 :P )

Thanks,
Mani

> Rob
> 
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
> >   PCI: dwc: Add Qualcomm PCIe Endpoint controller driver
> >   MAINTAINERS: Add entry for Qualcomm PCIe Endpoint driver and binding
> >
> >  .../devicetree/bindings/pci/qcom,pcie-ep.yaml | 160 ++++
> >  MAINTAINERS                                   |  10 +-
> >  drivers/pci/controller/dwc/Kconfig            |  10 +
> >  drivers/pci/controller/dwc/Makefile           |   1 +
> >  drivers/pci/controller/dwc/pcie-qcom-ep.c     | 742 ++++++++++++++++++
> >  5 files changed, 922 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> >  create mode 100644 drivers/pci/controller/dwc/pcie-qcom-ep.c
> >
> > --
> > 2.25.1
> >
