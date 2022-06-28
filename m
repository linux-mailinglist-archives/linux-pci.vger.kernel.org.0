Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C1455DEE6
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345127AbiF1K7f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 06:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343573AbiF1K7e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 06:59:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6CC1F63E;
        Tue, 28 Jun 2022 03:59:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 699EEB81DC6;
        Tue, 28 Jun 2022 10:59:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5993C3411D;
        Tue, 28 Jun 2022 10:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656413971;
        bh=Wqg0ETp02r05Seu7ujmQUQ414cg/uxWo81xExN0cy1Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nrh0nVqaQvbXB/U1O1AFBvjEHOWtM9Kmuc/cru4Q2as1yYm5yig+ESS0p35Ay3h1K
         174YJ8Bvo966syKkPSc4BVmTpPH6hYMWyHOUE84kt29ECeKnC7GStSNUZJRg52gr7J
         NhEWDbdOxwwnkdFdtBgNf+eygbATz2hJqKalAhUGO29zs7nyMidkFd9srg9DLaHRPM
         78Vvmuy284U4syr9bQlcPhQe3jXNROMmFt54M8s8KRDAseaAQttKxFJ8QN6EJ+GJb4
         DgeVmtRl7ckAuZIysrcEp4u6IBVCUpBZLRJStIUIGcrRZgds7GT2ubwVd9CJyLVQSw
         7YonD4CETuCpw==
Date:   Tue, 28 Jun 2022 05:59:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: pci-exynos.c phy_init() usage
Message-ID: <20220628105929.GA1819457@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ab52c5f-6c48-6381-e0f3-a1d9572dc2a9@linaro.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 28, 2022 at 10:27:31AM +0200, Krzysztof Kozlowski wrote:
> On 28/06/2022 10:13, Marek Szyprowski wrote:
> > On 27.06.2022 12:47, Krzysztof Kozlowski wrote:
> >> On 27/06/2022 12:30, Marek Szyprowski wrote:
> >>> On 24.06.2022 20:07, Krzysztof Kozlowski wrote:
> >>>> On 24/06/2022 19:35, Bjorn Helgaas wrote:
> >>>>> In exynos_pcie_host_init() [1], we call:
> >>>>>
> >>>>>     phy_reset(ep->phy);
> >>>>>     phy_power_on(ep->phy);
> >>>>>     phy_init(ep->phy);
> >>>>>
> >>>>> The phy_init() function comment [2] says it must be called before
> >>>>> phy_power_on().  Is exynos doing this backwards?
> >>>> Looks like. I don't have Exynos hardware with a PCI, so cannot
> >>>> test/fix/verify.
> >>>>
> >>>> Luckily for Exynos ;-) it's not alone in this pattern:
> >>>> drivers/net/ethernet/marvell/sky2.c
> >>>> drivers/usb/dwc2/platform.c
> >>> I've checked that on the real hardware. Swapping the order of
> >>> phy_power_on and phy_init breaks driver operation.
> >>>
> >>> However pci-exynos is the only driver that uses the phy-exynos-pcie, so
> >>> we can simply swap the content of the init and power_on in the phy
> >>> driver to adjust the code to the right order. power_on/init and
> >>> exit/power_off are also called one after the other in pci-exynos,
> >>> without any activity between them, so we can also simply move all
> >>> operation to one pair of the callback, like power_on/off.
> >>>
> >>> Krzysztof, which solution would you prefer?
> >> I think the real problem is that the Exynos PCIe phy init
> >> (exynos5433_pcie_phy_init) performs parts of power on procedure, so the
> >> code is mixed. Probably also the phy init could not happen earlier due
> >> to gated clocks (ungated in exynos5433_pcie_phy_power_on).
> >>
> >> I would prefer to clean it up while ordering init+power_on, so figure
> >> out more or less correct procedure.
> >>
> >> You can also look at Artpec-8 PHY - it seems using correct order
> >> (init+reset):
> >> https://lore.kernel.org/all/20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p7/
> > 
> > I've played a bit with those register writes in exynos_pcie_phy and 
> > frankly speaking the currenly used (power_on + init) is the only 
> > sequence that works properly. I'm leaning to move everything to 
> > phy_init/exit. I really don't see how to split it into init + power_on 
> > callbacks.
> 
> I was afraid it will be like this. I imagine that certain (not
> explicitly documented) init operations cannot even happen before power
> on, so this would be a lot of tries.
> 
> I am fine with it. Thanks for doing it.

If nothing can be improved, a comment to this effect might make it
look less like a mistake.

Bjorn
