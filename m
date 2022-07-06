Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C583568FB3
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jul 2022 18:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbiGFQvt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jul 2022 12:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbiGFQvr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2022 12:51:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF152A42D;
        Wed,  6 Jul 2022 09:51:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 181E9B81E32;
        Wed,  6 Jul 2022 16:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072EBC3411C;
        Wed,  6 Jul 2022 16:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657126303;
        bh=pIiWhmzedFgugbr07W1T7Td/EKYRbZ9ectUju0WGfCk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ge+fJ19MGAxwkfdGkPGAlffA869wkEJnIo+qBMcyxMktWwMme4Xr9KH58gLkM4hVP
         RGn62if3hFffimiyBpH1AeFafkJ1iAPhLLfJYp/KmWyDpZZWH2igubVXIZhshv1Tai
         oPzS9Iarw52/FXD+nX/hhgt2l5ZpJMz8YG0xJVLQ7z2QbWfXzj5p+/046/QrIwnmNr
         Rg2w7Q6XXF3zI1vhEiVl8QCDJJ3aef2yQjxJtRxCMKJe4Zze1H2AGMCHrKiF777+I3
         onCecIwtu022Fs04j2Tn8sGleZ/QyrSZy8gZpbOcAVpbfVpG2e6utJlxTnt7wdxtlH
         SM49rT+6RZFvA==
Date:   Wed, 6 Jul 2022 22:21:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Wangseok Lee <wangseok.lee@samsung.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "kernel@axis.com" <kernel@axis.com>,
        Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>,
        Yeeun Kim <yeeun119.kim@samsung.com>
Subject: Re: [PATCH v3 4/5] phy: Add ARTPEC-8 PCIe PHY driver
Message-ID: <YsW9m6hotDKacXe3@matsya>
References: <YsPYc3YPuG56yTYM@matsya>
 <20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p7>
 <20220614013446epcms2p8c88ea65da49447f72fef6536c7f73fb6@epcms2p8>
 <CGME20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p6>
 <20220706081036epcms2p6baf1d8afac994cd0d45c5e59029c8ce7@epcms2p6>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220706081036epcms2p6baf1d8afac994cd0d45c5e59029c8ce7@epcms2p6>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 06-07-22, 17:10, Wangseok Lee wrote:
> On 05-07-22, 15:30, Vinod Koul wrote:
> > On 14-06-22, 10:34, Wangseok Lee wrote:
> >> Add support Axis, ARTPEC-8 SoC.
> >> ARTPEC-8 is the SoC platform of Axis Communications.
> >> This is based on arm64 and support GEN4 & 2lane.
> >> This driver provides PHY interface for ARTPEC-8 SoC PCIe controller,
> >> based on Samsung PCIe PHY IP.
> >> 
> >> Signed-off-by: Wangseok Lee <wangseok.lee@samsung.com>
> >> Signed-off-by: Jaeho Cho <jaeho79.cho@samsung.com>
> >> ---
> >> v2->v3 :
> >> -remove unnecessary indentation
> >> -redefine local struct to statis const
> >> -add static const to struct that requires static const definition
> >> -remove wrappers on writel and readl
> >> 
> >> v1->v2 :
> >> -change folder name of phy driver to axis from artpec
> >> ---
> >>  drivers/phy/Kconfig                 |   1 +
> >>  drivers/phy/Makefile                |   1 +
> >>  drivers/phy/axis/Kconfig            |   9 +
> >>  drivers/phy/axis/Makefile           |   2 +
> >>  drivers/phy/axis/phy-artpec8-pcie.c | 776 ++++++++++++++++++++++++++++++++++++
> >>  5 files changed, 789 insertions(+)
> >>  create mode 100644 drivers/phy/axis/Kconfig
> >>  create mode 100644 drivers/phy/axis/Makefile
> >>  create mode 100644 drivers/phy/axis/phy-artpec8-pcie.c
> >> 
> >> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> >> index 300b0f2..92b8232 100644
> >> --- a/drivers/phy/Kconfig
> >> +++ b/drivers/phy/Kconfig
> >> @@ -73,6 +73,7 @@ config PHY_CAN_TRANSCEIVER
> >>  
> >>  source "drivers/phy/allwinner/Kconfig"
> >>  source "drivers/phy/amlogic/Kconfig"
> >> +source "drivers/phy/axis/Kconfig"
> >>  source "drivers/phy/broadcom/Kconfig"
> >>  source "drivers/phy/cadence/Kconfig"
> >>  source "drivers/phy/freescale/Kconfig"
> >> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> >> index 01e9eff..808c055e 100644
> >> --- a/drivers/phy/Makefile
> >> +++ b/drivers/phy/Makefile
> >> @@ -12,6 +12,7 @@ obj-$(CONFIG_PHY_PISTACHIO_USB)                += phy-pistachio-usb.o
> >>  obj-$(CONFIG_USB_LGM_PHY)                += phy-lgm-usb.o
> >>  obj-y                                        += allwinner/        \
> >>                                             amlogic/        \
> >> +                                           axis/                \
> >>                                             broadcom/        \
> >>                                             cadence/        \
> >>                                             freescale/        \
> >> diff --git a/drivers/phy/axis/Kconfig b/drivers/phy/axis/Kconfig
> >> new file mode 100644
> >> index 0000000..7198b93
> >> --- /dev/null
> >> +++ b/drivers/phy/axis/Kconfig
> >> @@ -0,0 +1,9 @@
> >> +config PHY_ARTPEC8_PCIE
> >> +        bool "ARTPEC-8 PCIe PHY driver"
> >> +        depends on OF && (ARCH_ARTPEC8 || COMPILE_TEST)
> >> +        select GENERIC_PHY
> >> +        help
> >> +          Enable PCIe PHY support for ARTPEC-8 SoC.
> >> +          This driver provides PHY interface for ARTPEC-8 SoC
> >> +          PCIe controller.
> >> +          This is based on Samsung PCIe PHY IP.
> > 
> > How different is it from SS IP and why should it not be under
> > phy/samsung/ then?
> > 
> 
> SoC platform is completely different from exynos platform and different 
> from exynos PCIe PHY. So the overall sysreg configuration is different
> and register map is also different. The reset method and type of PHY for
> initialization are different. This is not a driver that supports Samsung
> SoC platform, but this PHY driver that supports only Axis, Artpec-8
> platforms, so it is not added to phy/samsung.

SoC is a moot point. If the IP block is same then we should try to reuse
the existing phy driver, modifications to current driver to support your
changes should be fine...

Is that feasible?

-- 
~Vinod
