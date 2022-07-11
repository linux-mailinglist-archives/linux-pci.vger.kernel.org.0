Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66007570A0C
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 20:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiGKSk1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 14:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiGKSk0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 14:40:26 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2D12A416;
        Mon, 11 Jul 2022 11:40:24 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id t25so10151787lfg.7;
        Mon, 11 Jul 2022 11:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KlQUK2zAvSsYY9+HkP1fxNkctblwyKNfY8+Zlr8/0W4=;
        b=GNL0CWbWjXmuPbVFuAxYcdBV7iXrGkC1IYqMjQo4jwPPjlODY/BX3gXpfZL4zVHvT8
         B9jKTqMv5Gy7lR5a4wt1DyGFslGrvii56AkOpMCCWiGnYJYNYFrVZU5U0YWR6QrqLMm4
         N+oV6tDyiAUyzcoUjgVuQ2aLsjdhnVEtfdBHoEqhQUrUO1ialxMBOa2bU2c9br5MEsar
         BqLhRA1ulAfhy/KkWSYoC1Ar1jQyyD18kQZM/wA+ZCAgp0IPIkfze4OeTbbvn04/hpZ4
         7AlkOk3OmHNJchgB/DDc+HxVvfEQJMSORa2I5ssWp3Ncy34ig7dbkLCO4iQSc9/+tvks
         W3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KlQUK2zAvSsYY9+HkP1fxNkctblwyKNfY8+Zlr8/0W4=;
        b=Zp9iDQ86DAIkU56MTk2JI+RS+fwcRyC5Ds4kGOEpG90bw43uy2mBR02aAEL29OlAig
         bLuACv9Gbt4p4lt+MnP9Hq5bvQuEvrEy4LDnTzvTgR5F7touZeks2zDtR/KWnc9ra0F/
         JlB7Tw35Rc1460hwMl4rQJoECerXjYVR4cL4vUxVYhaHQcbofV5CKL0HxQPVu0h2O9SU
         5ChfDyjADmjh3+p5zfNSFAVzGjNL4wG8jr+dPAQdgZpPB0UiWxiyw7Nf+haAHDLVgk0X
         OjQK3D8RhLHfNU8k8hT65ScSd62duk9W8rynA3Z8gPZdXg7WkUFPggic2OAFI5MpjP5/
         gOMg==
X-Gm-Message-State: AJIora+qbtOiVmMyD7AswnUOEnF9zbqEOLaJr2VkYnrJSAJxQalExgqV
        4l40pfyDZ06DsqaHHy9YPhw=
X-Google-Smtp-Source: AGRyM1vDE6nbnMjDZgCNsMQ1Fbxfr8MT1sluE3y17vg2UBfrADHdzgzByx3vNOhD9TFRAox2eTq15A==
X-Received: by 2002:ac2:4e10:0:b0:47f:9af2:9c64 with SMTP id e16-20020ac24e10000000b0047f9af29c64mr11762430lfr.109.1657564823066;
        Mon, 11 Jul 2022 11:40:23 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id b5-20020ac25625000000b004896ed8dce3sm1681064lff.2.2022.07.11.11.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 11:40:22 -0700 (PDT)
Date:   Mon, 11 Jul 2022 21:40:20 +0300
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
Message-ID: <20220711184020.k4i22724gr7nc4qw@mobilestation>
References: <20220624143428.8334-1-Sergey.Semin@baikalelectronics.ru>
 <20220628233527.GA1883848@bhelgaas>
 <20220629013836.r55ldp7s7v7acsbs@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220629013836.r55ldp7s7v7acsbs@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn.

On Wed, Jun 29, 2022 at 04:38:36AM +0300, Serge Semin wrote:
> On Tue, Jun 28, 2022 at 06:35:27PM -0500, Bjorn Helgaas wrote:
> > On Fri, Jun 24, 2022 at 05:34:10PM +0300, Serge Semin wrote:
> > > This patchset is a first one in the series created in the framework of
> > > my Baikal-T1 PCIe/eDMA-related work:
> > > 
> > > [1: In-progress v5] PCI: dwc: Various fixes and cleanups
> > > Link: ---you are looking at it---
> > > [2: In-progress v3] PCI: dwc: Add hw version and dma-ranges support
> > > Link: https://lore.kernel.org/linux-pci/20220610084444.14549-1-Sergey.Semin@baikalelectronics.ru/
> > > [3: In-progress v3] PCI: dwc: Add generic resources and Baikal-T1 support
> > > Link: https://lore.kernel.org/linux-pci/20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru/
> > > [4: In-progress v3] dmaengine: dw-edma: Add RP/EP local DMA support
> > > Link: https://lore.kernel.org/linux-pci/20220610091459.17612-1-Sergey.Semin@baikalelectronics.ru/
> > > 
> > > Note it is very recommended to merge the patchsets in the same order as
> > > they are placed in the list above in order to prevent possible merge
> > > conflicts. Nothing prevents them from being reviewed synchronously though.
> > > Any tests are very welcome!
> > > 
> > > [...]
> > > 
> > > Link: https://lore.kernel.org/linux-pci/20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru/
> > > Changelog v5:
> > > - Just resend the series.
> > > - Rebase onto v5.19-rcX.
> > > 
> > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > > Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> > > Cc: Jingoo Han <jingoohan1@gmail.com>
> > > Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > > Cc: "Krzysztof Wilczyński" <kw@linux.com>
> > > Cc: Frank Li <Frank.Li@nxp.com>
> > > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Cc: linux-pci@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > 
> 

> > I applied these to pci/ctrl/dwc-fixes for now.  We'll have some tweaks
> > (to merge with previous dwc changes, if nothing else), but I pushed
> > this interim version 
> 
> I've got three more DW PCIe+eDMA based patchsets to review and merge in.
> As I noted in the cover letter and graphically represented here:
> Link: https://lore.kernel.org/linux-pci/20220616152048.gcqacgs2ed66vsl4@mobilestation/
> the last series depends on the previous changes and the changes
> introduced by Frank Li. The Frank' work has been merged in into the
> branch 'pci/edma' of your repo. Could you please move my patchset(s)
> there too in order to avoid merge conflicts in future?

Are you back from vacation yet? If so please consider the request
above.

-Sergey

> 
> > since I'll be on vacation for a week or so.
> > 
> 
> * Sigh... I have a feeling one more merge window will pass with
> my patchsets hanging out in limbo.
> 
> > Looks like some nice fixes and cleanups, thank you!
> 
> Thanks.
> 
> -Sergey
> 
> > 
> > > Serge Semin (18):
> > >   PCI: dwc: Stop link in the host init error and de-initialization
> > >   PCI: dwc: Add unroll iATU space support to the regions disable method
> > >   PCI: dwc: Disable outbound windows for controllers with iATU
> > >   PCI: dwc: Set INCREASE_REGION_SIZE flag based on limit address
> > >   PCI: dwc: Deallocate EPC memory on EP init error
> > >   PCI: dwc: Enable CDM-check independently from the num_lanes value
> > >   PCI: dwc: Add braces to the multi-line if-else statements
> > >   PCI: dwc: Add trailing new-line literals to the log messages
> > >   PCI: dwc: Discard IP-core version checking on unrolled iATU detection
> > >   PCI: dwc: Convert Link-up status method to using dw_pcie_readl_dbi()
> > >   PCI: dwc: Organize local variables usage
> > >   PCI: dwc: Re-use local pointer to the resource data
> > >   PCI: dwc: Add start_link/stop_link inliners
> > >   PCI: dwc: Move io_cfg_atu_shared to the Root Port descriptor
> > >   PCI: dwc: Add dw_ prefix to the pcie_port structure name
> > >   PCI: dwc-plat: Simplify the probe method return value handling
> > >   PCI: dwc-plat: Discard unused regmap pointer
> > >   PCI: dwc-plat: Drop dw_plat_pcie_of_match forward declaration
> > > 
> > >  drivers/pci/controller/dwc/pci-dra7xx.c       |  12 +--
> > >  drivers/pci/controller/dwc/pci-exynos.c       |   6 +-
> > >  drivers/pci/controller/dwc/pci-imx6.c         |   6 +-
> > >  drivers/pci/controller/dwc/pci-keystone.c     |  20 ++--
> > >  .../pci/controller/dwc/pci-layerscape-ep.c    |  12 ---
> > >  drivers/pci/controller/dwc/pci-layerscape.c   |   2 +-
> > >  drivers/pci/controller/dwc/pci-meson.c        |   2 +-
> > >  drivers/pci/controller/dwc/pcie-al.c          |   6 +-
> > >  drivers/pci/controller/dwc/pcie-armada8k.c    |   4 +-
> > >  drivers/pci/controller/dwc/pcie-artpec6.c     |   4 +-
> > >  .../pci/controller/dwc/pcie-designware-ep.c   |  30 ++++--
> > >  .../pci/controller/dwc/pcie-designware-host.c | 102 ++++++++++--------
> > >  .../pci/controller/dwc/pcie-designware-plat.c |  25 ++---
> > >  drivers/pci/controller/dwc/pcie-designware.c  |  72 +++++++------
> > >  drivers/pci/controller/dwc/pcie-designware.h  |  46 +++++---
> > >  drivers/pci/controller/dwc/pcie-dw-rockchip.c |   4 +-
> > >  drivers/pci/controller/dwc/pcie-fu740.c       |   2 +-
> > >  drivers/pci/controller/dwc/pcie-histb.c       |  10 +-
> > >  drivers/pci/controller/dwc/pcie-intel-gw.c    |   6 +-
> > >  drivers/pci/controller/dwc/pcie-keembay.c     |   4 +-
> > >  drivers/pci/controller/dwc/pcie-kirin.c       |   2 +-
> > >  drivers/pci/controller/dwc/pcie-qcom.c        |   4 +-
> > >  drivers/pci/controller/dwc/pcie-spear13xx.c   |   6 +-
> > >  drivers/pci/controller/dwc/pcie-tegra194.c    |  22 ++--
> > >  drivers/pci/controller/dwc/pcie-uniphier.c    |  10 +-
> > >  drivers/pci/controller/dwc/pcie-visconti.c    |   6 +-
> > >  26 files changed, 224 insertions(+), 201 deletions(-)
> > > 
> > > -- 
> > > 2.35.1
> > > 
