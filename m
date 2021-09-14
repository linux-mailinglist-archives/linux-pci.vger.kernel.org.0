Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93BEA40A8EA
	for <lists+linux-pci@lfdr.de>; Tue, 14 Sep 2021 10:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhINILe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 04:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhINILW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Sep 2021 04:11:22 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DB4C0613AE
        for <linux-pci@vger.kernel.org>; Tue, 14 Sep 2021 01:09:20 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 17so12008612pgp.4
        for <linux-pci@vger.kernel.org>; Tue, 14 Sep 2021 01:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HORz+N9iPM3MBLFTrD2etygd1AQ7C3FwAZKQ2ef9vXA=;
        b=hNqZp1dwfdFkEDBjv3xUXxcGBjBFOYQgKv9Fg+Lztu1zsRHrV3An6X4PLGSsbKhgOa
         t9JlCxXjagpAmLziP/AL4bkyLre2pXearJ6vsOhr3a4OMeeE5IWFJItz28A/KEi4a3t8
         mBpgnfsVbpl9pw9GSX02QXTV+i2OrSKCNJzSQLhyxVbOQSMnvydpM/9vsKsudJbutJt/
         VlHtTVJtBzxB+XhxVk5T/zY1+eqmH4bBZobJzk0Ccqr9JCQQ/PGT4tbPOkPrXWRl3JCx
         nFuZpm82/kf2CtsMtwOjplejstBJ5m09BzGpksPce+zrvVQFXeXb8WLPsb6c9Mn8XRYL
         NIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HORz+N9iPM3MBLFTrD2etygd1AQ7C3FwAZKQ2ef9vXA=;
        b=dZWHHmt4p25u3IuIZQ0syd02X6mT2MvCsRMamJjvLn+POTFiOT445O+v7mTovue0JM
         Nz3B4nSzjgrmWGLrGTIhOAwTFfhHvFzWufjkg8Chemrujvgs6GkHYqPYcA6a0ZVTwyip
         vcIngSl4Ov0G6kuQZCrHzqbdJ8A7O1TSiMlIDVxxnQNEi13Ksh22BPBC8wBVcFbmmLsJ
         M48q+Z38nhA1QSBue1Lg2nExatdxZM8kjiC2EVIUq27d3ImLBJkGLAjhgGNqP+meV4Cj
         M9gRSnkvkNWSLqYtt+IxEeoQm/ybbld30a3pDpm/ES4RlszlD7LmRJtkZupk8fhCY0Kp
         biCg==
X-Gm-Message-State: AOAM533jAubwN/g8ba61HsbWOO64yjuVOaZe2Sh5/JMxzgXWgqhuXLlN
        VSu0FQaeLMm1dfhi1qsYRiDb
X-Google-Smtp-Source: ABdhPJyh/TNWx4PNfVhDrSi721PTkgySN/TIS/csuXWue6mCXR6CsUoAqZhV2TwTkxInYfdYoJMZGw==
X-Received: by 2002:aa7:9f8a:0:b0:43c:39be:23fb with SMTP id z10-20020aa79f8a000000b0043c39be23fbmr3434984pfr.57.1631606959868;
        Tue, 14 Sep 2021 01:09:19 -0700 (PDT)
Received: from thinkpad ([2409:4072:6211:54eb:fe9c:efbb:2b75:a575])
        by smtp.gmail.com with ESMTPSA id d5sm669016pjs.53.2021.09.14.01.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 01:09:19 -0700 (PDT)
Date:   Tue, 14 Sep 2021 13:39:11 +0530
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
Message-ID: <20210914080911.GA16774@thinkpad>
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

Ping again! Do I need to resend this series on top of v5.15-rc1? I thought this
one could go in for v5.15 but...

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
