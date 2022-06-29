Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB9555F2DF
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 03:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiF2Bim (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 21:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiF2Bim (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 21:38:42 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE022253A;
        Tue, 28 Jun 2022 18:38:40 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a2so25381746lfg.5;
        Tue, 28 Jun 2022 18:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Eonjr0R2gJ4d+xqZQdJN+tFnlG8Bv2N89tocGdDg4co=;
        b=CEedd4KawuwG3Z1YZRU9mXIDBQ1zsG1LrrGYDu62dYG5MnpbveLHcQzizCfBuhrbgR
         StaOVLkHSuyYYoMfl+c4/SVXVZhxScT35t0eHqRiTbKacJhZSWOIv8/0owaUTtL1eSQy
         xrax/6z7eqSS39lH58BZx4tI1bWOTmxSzerPYHGDqrSRW1ddV98coy0Dq2URENEfSf1Z
         9wuLkJgGdqsTajQk3TFXzcEp/gdjneLObRRSYn4wKpe5Z8d2j5Z4b1r3MF9GBV46yf3e
         rAcEZXr/F8p76U0AqMYXporkh3jywDAkLxh6CVrQ7MIXag411oaq7hbU9qFWzzWOSjXF
         a/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Eonjr0R2gJ4d+xqZQdJN+tFnlG8Bv2N89tocGdDg4co=;
        b=6j5uiUlZ+DVbjIpO5daPLCXzLQQWJqirUrR6XjkNgoUs9SfqtViZtrtu9cz1B2cNvs
         aOFLz1VDIWBCKDMM9I+0h5LbNhKqjQHM/sQr9fZKbYFYTgrY/Fp2ESIyMUmYuUs+AlF2
         aWm34p1KbmNKfEVnPXXWqO9YeWu4t3ydlgoRBiRNRR1iGZnASwCoHm7TB4gt/NNS08Vh
         X59rQO3Rb+9JlLTpIo5Ixk8ZyU87JcAUv6tE2WmsNpMkK89tn5WOJ/2HBm3QvuSxDycc
         blfbxXWMhJAQAoqtYYzQl/qBqtK2dJy9yDO0SBHWzuBsqIoDIh7zp9Mpn+LMPnsshhqc
         Z//Q==
X-Gm-Message-State: AJIora/rc8IBtxfFOEX/W9bdqtMwsqdRQ9ntH7aeIJZPI3xLr0xlqACi
        sidBF0DMD//iwRwpYRxigNQ=
X-Google-Smtp-Source: AGRyM1vCh7h+F+PkIIZymSQsxvwBlXlgfzG2FjrtO2VihiHhJ+EQ85Y0uGT49pSGf/eH2CmyqMf2DQ==
X-Received: by 2002:a05:6512:39d1:b0:47f:6152:8e4 with SMTP id k17-20020a05651239d100b0047f615208e4mr447127lfu.461.1656466719086;
        Tue, 28 Jun 2022 18:38:39 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id e16-20020a196910000000b0047f6ab55fdbsm2389288lfc.267.2022.06.28.18.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 18:38:38 -0700 (PDT)
Date:   Wed, 29 Jun 2022 04:38:36 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5 00/18] PCI: dwc: Various fixes and cleanups
Message-ID: <20220629013836.r55ldp7s7v7acsbs@mobilestation>
References: <20220624143428.8334-1-Sergey.Semin@baikalelectronics.ru>
 <20220628233527.GA1883848@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220628233527.GA1883848@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 28, 2022 at 06:35:27PM -0500, Bjorn Helgaas wrote:
> On Fri, Jun 24, 2022 at 05:34:10PM +0300, Serge Semin wrote:
> > This patchset is a first one in the series created in the framework of
> > my Baikal-T1 PCIe/eDMA-related work:
> > 
> > [1: In-progress v5] PCI: dwc: Various fixes and cleanups
> > Link: ---you are looking at it---
> > [2: In-progress v3] PCI: dwc: Add hw version and dma-ranges support
> > Link: https://lore.kernel.org/linux-pci/20220610084444.14549-1-Sergey.Semin@baikalelectronics.ru/
> > [3: In-progress v3] PCI: dwc: Add generic resources and Baikal-T1 support
> > Link: https://lore.kernel.org/linux-pci/20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru/
> > [4: In-progress v3] dmaengine: dw-edma: Add RP/EP local DMA support
> > Link: https://lore.kernel.org/linux-pci/20220610091459.17612-1-Sergey.Semin@baikalelectronics.ru/
> > 
> > Note it is very recommended to merge the patchsets in the same order as
> > they are placed in the list above in order to prevent possible merge
> > conflicts. Nothing prevents them from being reviewed synchronously though.
> > Any tests are very welcome!
> > 
> > As it can be easily inferred from the patchset title, this series is about
> > the DW PCIe Root Port/Endpoint driver fixes and the code cleanups, where
> > fixes come before the cleanup patches. The patchset starts with adding the
> > stop_link() platform-specific method invocation in case of the PCIe host
> > probe procedure errors. It has been missing in the cleanup-on-error path
> > of the DW PCIe Host initialization method. After that the unrolled CSRs
> > layout is added to the iATU disable procedure. In third the disable iATU
> > procedure is fixed to be called only for the internal ATU as being
> > specific for the internal ATU implementation. Then the outbound iATU
> > extended region setup procedure is fixed to have the INCREASE_REGION_SIZE
> > flag set based on the limit-address - not the region size one. The last
> > but not least the CDM-check enabling procedure is fixed to be independent
> > from the non-related num_lanes field state.
> > 
> > Afterwards there is a series of cleanups. It concerns the changes like
> > adding braces to the multi-line if-else constructions, trailing new-lines
> > to the print format-string, dropping unnecessary version checking, and
> > various code simplifications and optimizations.
> > 
> > New features like adding two-level DT bindings abstraction, adding better
> > structured IP-core version interface, adding iATU regions size detection
> > and the PCIe regions verification procedure, adding dma-ranges support,
> > introducing a set of generic platform clocks and resets and finally adding
> > Baikal-T1 PCIe interface support will be submitted in the next part of the
> > series.
> > 
> > Link: https://lore.kernel.org/linux-pci/20220324012524.16784-1-Sergey.Semin@baikalelectronics.ru/
> > Changelog v2:
> > - Fix the end address of the example in the patch log with
> >   the INCREASE_REGION_SIZE flag usage fixup. It should be
> >   0x1000FFFF and not 0x0000FFFF (@Manivannan).
> > - Add the cleanup-on-error path to the dw_pcie_ep_init() function.
> >   (@Manivannan)
> > 
> > Link: https://lore.kernel.org/linux-pci/20220503212300.30105-1-Sergey.Semin@baikalelectronics.ru/
> > Changelog v3:
> > - Convert region variable type to u32 in order to fix the implicit type
> >   conversion peculiarity. (@kbot)
> > - Rebase onto v5.18-rc6.
> > 
> > Link: https://lore.kernel.org/linux-pci/20220517125058.18488-1-Sergey.Semin@baikalelectronics.ru/
> > Changelog v4:
> > - Move the patch "PCI: dwc: Deallocate EPC memory on EP init error" to
> >   being applied before the cleanup patches.
> > - Add a new fixes patch: "PCI: dwc: Enable CDM-check independently from
> >   the num_lanes value".
> > - Add a new cleanup patch: "PCI: dwc: Organize local variables usage".
> > - Add a new cleanup patch: "PCI: dwc: Re-use local pointer to the
> >   resource data".
> > - Add a new cleanup patch: "PCI: dwc: Add start_link/stop_link inliners".
> > - Add a new cleanup patch: "PCI: dwc: Move io_cfg_atu_shared to the Root
> >   Port descriptor".
> > - Add a new cleanup patch: "PCI: dwc: Add dw_ prefix to the pcie_port
> >   structure name".
> > - Drop the patch "PCI: dwc: Don't use generic IO-ops for DBI-space
> >   access". (@Rob)
> > - Drop Manivannan tested tag from the changed patches.
> > - Rebase onto v5.18.
> > 
> > Link: https://lore.kernel.org/linux-pci/20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru/
> > Changelog v5:
> > - Just resend the series.
> > - Rebase onto v5.19-rcX.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> > Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > Cc: "Krzysztof Wilczyński" <kw@linux.com>
> > Cc: Frank Li <Frank.Li@nxp.com>
> > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Cc: linux-pci@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> 

> I applied these to pci/ctrl/dwc-fixes for now.  We'll have some tweaks
> (to merge with previous dwc changes, if nothing else), but I pushed
> this interim version 

I've got three more DW PCIe+eDMA based patchsets to review and merge in.
As I noted in the cover letter and graphically represented here:
Link: https://lore.kernel.org/linux-pci/20220616152048.gcqacgs2ed66vsl4@mobilestation/
the last series depends on the previous changes and the changes
introduced by Frank Li. The Frank' work has been merged in into the
branch 'pci/edma' of your repo. Could you please move my patchset(s)
there too in order to avoid merge conflicts in future?

> since I'll be on vacation for a week or so.
> 

* Sigh... I have a feeling one more merge window will pass with
my patchsets hanging out in limbo.

> Looks like some nice fixes and cleanups, thank you!

Thanks.

-Sergey

> 
> > Serge Semin (18):
> >   PCI: dwc: Stop link in the host init error and de-initialization
> >   PCI: dwc: Add unroll iATU space support to the regions disable method
> >   PCI: dwc: Disable outbound windows for controllers with iATU
> >   PCI: dwc: Set INCREASE_REGION_SIZE flag based on limit address
> >   PCI: dwc: Deallocate EPC memory on EP init error
> >   PCI: dwc: Enable CDM-check independently from the num_lanes value
> >   PCI: dwc: Add braces to the multi-line if-else statements
> >   PCI: dwc: Add trailing new-line literals to the log messages
> >   PCI: dwc: Discard IP-core version checking on unrolled iATU detection
> >   PCI: dwc: Convert Link-up status method to using dw_pcie_readl_dbi()
> >   PCI: dwc: Organize local variables usage
> >   PCI: dwc: Re-use local pointer to the resource data
> >   PCI: dwc: Add start_link/stop_link inliners
> >   PCI: dwc: Move io_cfg_atu_shared to the Root Port descriptor
> >   PCI: dwc: Add dw_ prefix to the pcie_port structure name
> >   PCI: dwc-plat: Simplify the probe method return value handling
> >   PCI: dwc-plat: Discard unused regmap pointer
> >   PCI: dwc-plat: Drop dw_plat_pcie_of_match forward declaration
> > 
> >  drivers/pci/controller/dwc/pci-dra7xx.c       |  12 +--
> >  drivers/pci/controller/dwc/pci-exynos.c       |   6 +-
> >  drivers/pci/controller/dwc/pci-imx6.c         |   6 +-
> >  drivers/pci/controller/dwc/pci-keystone.c     |  20 ++--
> >  .../pci/controller/dwc/pci-layerscape-ep.c    |  12 ---
> >  drivers/pci/controller/dwc/pci-layerscape.c   |   2 +-
> >  drivers/pci/controller/dwc/pci-meson.c        |   2 +-
> >  drivers/pci/controller/dwc/pcie-al.c          |   6 +-
> >  drivers/pci/controller/dwc/pcie-armada8k.c    |   4 +-
> >  drivers/pci/controller/dwc/pcie-artpec6.c     |   4 +-
> >  .../pci/controller/dwc/pcie-designware-ep.c   |  30 ++++--
> >  .../pci/controller/dwc/pcie-designware-host.c | 102 ++++++++++--------
> >  .../pci/controller/dwc/pcie-designware-plat.c |  25 ++---
> >  drivers/pci/controller/dwc/pcie-designware.c  |  72 +++++++------
> >  drivers/pci/controller/dwc/pcie-designware.h  |  46 +++++---
> >  drivers/pci/controller/dwc/pcie-dw-rockchip.c |   4 +-
> >  drivers/pci/controller/dwc/pcie-fu740.c       |   2 +-
> >  drivers/pci/controller/dwc/pcie-histb.c       |  10 +-
> >  drivers/pci/controller/dwc/pcie-intel-gw.c    |   6 +-
> >  drivers/pci/controller/dwc/pcie-keembay.c     |   4 +-
> >  drivers/pci/controller/dwc/pcie-kirin.c       |   2 +-
> >  drivers/pci/controller/dwc/pcie-qcom.c        |   4 +-
> >  drivers/pci/controller/dwc/pcie-spear13xx.c   |   6 +-
> >  drivers/pci/controller/dwc/pcie-tegra194.c    |  22 ++--
> >  drivers/pci/controller/dwc/pcie-uniphier.c    |  10 +-
> >  drivers/pci/controller/dwc/pcie-visconti.c    |   6 +-
> >  26 files changed, 224 insertions(+), 201 deletions(-)
> > 
> > -- 
> > 2.35.1
> > 
