Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8601854F5B0
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jun 2022 12:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381939AbiFQKlu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jun 2022 06:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381952AbiFQKlt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2022 06:41:49 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28F76B023;
        Fri, 17 Jun 2022 03:41:47 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id m25so4283445lji.11;
        Fri, 17 Jun 2022 03:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xyIh7SRi1+uQL1EcstdGCewgYDmpWa5/DYnD0Wi9meA=;
        b=hur8IJerFsNRVOx4RBRLr+jnfw8dufcv54gIBIauLsqyU3jWZZzpI/myuKkOyu65aI
         pplfh5QNq2Ecug/fhc22KLgPUHXyNWZ+cO15eHk1cYPv2FWfX9+7AZhT5EzDSNQ428WG
         c/9ETnw6L9oayrl8xCHudGn6qPLpcL2YiuX0SPmisHeHKAYgMmwail1ChUodr4AzPUiQ
         yfgHK2ziXmplsqjED603UaE0m0ql8f2k+ekOW/SPyw8ExWW9DirYf0pEXaJ8G4aOJc2n
         r6bRgGsra6XcrgMOkIOeYtGRAJQtrA08yiATlrFEy0HvA/MgEWSfnl2FQKQM2DIuWVf4
         22hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xyIh7SRi1+uQL1EcstdGCewgYDmpWa5/DYnD0Wi9meA=;
        b=CqXQ3XZkfOP7lBYKtcE/1oh1/9XUEoI87cbChsKGO8632TVmVMycCh2rL0nN7AWgnF
         npXqj3Z3eWitK8/6OECyKlBqs2ISElNFEzPMn2XyTyotCkXMWaNqwMPgbDGYsIIHDKsh
         KLuxZcWI5XQ8FEL3gGPhtdTXfn2BW+bwfmJa3aOBTYkeLbuLsF7lEP4M63tQGCpku2Pf
         +RbRC2x25n/Aw/D7QyKdh0+gStTrU5R35aT1dTAwn8841O6/+HS08V13TnXdMSVnLAj5
         a5I3904zO2xjQsO9GtzE4w3NUk1Yta6qp2AUy/RQaX6Z3Mm8yVgnU2ynLH4z2ei9F2UG
         yvEQ==
X-Gm-Message-State: AJIora/obuBPsulYqALptsFXRHiEKjofV4MzFe8QWaK9eey4f/EZzPDK
        Al++rItV2RxdlkwaRcN1g6M=
X-Google-Smtp-Source: AGRyM1sUBgFASvsZCX+N7xQuvyLpKw0H8qKSzJdquZm4VXGzOue/rBHIm/rCVxd82VUUi7oilY7NxQ==
X-Received: by 2002:a2e:94cc:0:b0:24f:81d:15f3 with SMTP id r12-20020a2e94cc000000b0024f081d15f3mr4661643ljh.407.1655462505810;
        Fri, 17 Jun 2022 03:41:45 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id s12-20020a05651c200c00b00253cd476074sm499276ljo.111.2022.06.17.03.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 03:41:45 -0700 (PDT)
Date:   Fri, 17 Jun 2022 13:41:43 +0300
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
Subject: Re: [PATCH v4 00/18] PCI: dwc: Various fixes and cleanups
Message-ID: <20220617104143.yj2mlnj4twoxoeld@mobilestation>
References: <20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru>
 <20220616200316.GA1106102@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220616200316.GA1106102@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 16, 2022 at 03:03:16PM -0500, Bjorn Helgaas wrote:
> On Fri, Jun 10, 2022 at 11:25:16AM +0300, Serge Semin wrote:
> > This patchset is a first one in the series created in the framework of
> > my Baikal-T1 PCIe/eDMA-related work:
> > 
> > [1: In-progress v4] PCI: dwc: Various fixes and cleanups
> > Link: ---you are looking at it---
> > [2: In-progress v2] PCI: dwc: Add hw version and dma-ranges support
> > Link: https://lore.kernel.org/linux-pci/20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru/
> > [3: In-progress v2] PCI: dwc: Add extended YAML-schema and Baikal-T1 support
> > Link: https://lore.kernel.org/linux-pci/20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru/
> > [4: In-progress v2] dmaengine: dw-edma: Add RP/EP local DMA support
> > Link: https://lore.kernel.org/linux-pci/20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru/
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
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> > Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > Cc: "Krzysztof Wilczyński" <kw@linux.com>
> > Cc: Frank Li <Frank.Li@nxp.com>
> > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Cc: linux-pci@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > 
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
> >  drivers/pci/controller/dwc/pci-dra7xx.c       |  12 +-
> >  drivers/pci/controller/dwc/pci-exynos.c       |   6 +-
> >  drivers/pci/controller/dwc/pci-imx6.c         |   6 +-
> >  drivers/pci/controller/dwc/pci-keystone.c     |  20 ++--
> >  .../pci/controller/dwc/pci-layerscape-ep.c    |  12 --
> >  drivers/pci/controller/dwc/pci-layerscape.c   |   2 +-
> >  drivers/pci/controller/dwc/pci-meson.c        |   2 +-
> >  drivers/pci/controller/dwc/pcie-al.c          |   6 +-
> >  drivers/pci/controller/dwc/pcie-armada8k.c    |   4 +-
> >  drivers/pci/controller/dwc/pcie-artpec6.c     |   4 +-
> >  .../pci/controller/dwc/pcie-designware-ep.c   |  30 +++--
> >  .../pci/controller/dwc/pcie-designware-host.c | 104 ++++++++++--------
> >  .../pci/controller/dwc/pcie-designware-plat.c |  25 +----
> >  drivers/pci/controller/dwc/pcie-designware.c  |  72 +++++++-----
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
> >  26 files changed, 225 insertions(+), 202 deletions(-)
> 

> This doesn't apply cleanly on v5.19-rc1 (my "main" branch).  v5.19-rc1
> was tagged June 5, but apparently v4 was rebased to v5.18 and posted
> June 10?  That's just a non-starter because many of these files were
> changed during the merge window between v5.18 and v5.19-rc1.

Ok. I'll rebase it on top of v5.19-rcX on the next cycle.

> 
> I'll be looking for an ack from Jingoo and/or Gustavo, maintainers of
> pcie-designware.c and related files.

Alas this will be very unluckily to happen. They have been inactive
for more than four months on this and the rest of the patchsets
(that's how long the patchsets have been hanging out on review).
The last commit authored by Gustavo was the commit ce31ff786ddf
("PCI: dwc: Fix 'cast truncates bits from constant value'") posted
in Sep 22, 2020 and no review activity afterwards. Jingoo' last
ack was in Jun 25, 2019. So two and three years of silence accordingly
doesn't give any hope on the sooner reaction from them.

> 
> Generally I wait for owners of files to comment before I review in
> detail.  This is just expedient because they know the code better than
> I do and can resolve lots of things in parallel before getting
> single-threaded on me or Lorenzo.

I do understand the standard approach, but in this case it seems like
the official maintainers've abandoned the drivers (DW PCIe and eDMA).
That's why I offered my hands (at least twice) in looking for both DW
PCIe and eDMA drivers seeing none of the maintainers have shown any
sign of interest in reviewing the submitted cleanup/fixes/features
patches (there are about 110 patches I've submitted altogether).

-Sergey

> 
> Bjorn
