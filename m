Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0713C507193
	for <lists+linux-pci@lfdr.de>; Tue, 19 Apr 2022 17:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353772AbiDSPXo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Apr 2022 11:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353769AbiDSPXl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2022 11:23:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9FA237C7;
        Tue, 19 Apr 2022 08:20:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87CD961685;
        Tue, 19 Apr 2022 15:20:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986E0C385A7;
        Tue, 19 Apr 2022 15:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650381657;
        bh=fJp7yQJNvvX2MmXaIzcbM8RzbPPUIBZ6s777OJkBTw8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=stfDx2eA/Mcz94iKo3DOA0RPzhMccdQGNrkEt2sncPJN1tHXJkY4dkgToWNjtWSgh
         5qgpImpVdEVcj6Af6tGJUbe4n+fBt9/O7lS8RwSSpcUtEdudcF/4IRM8CdUGYIiOSy
         lvJMdYXLtQSuFc5HqmX3+toxjOFuZq/cbovViZl0F0RuWmbmEq5ZjD0UyxfsiH9SJH
         GiW+6FUmnlFgfB2+dKgGSqiptWAL5srKYTARRZ4VdZjw2Jc1CpGIYTFmaOKWTORTMS
         Dvl98RiVcWgP6dOyTgrVPkk/2kYZ36wdOcQKmNQRI1NORUhsbhiHHM2fedHABaYcCB
         0bFBil9FeOuNA==
Date:   Tue, 19 Apr 2022 10:20:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     wangseok.lee@samsung.com, robh+dt <robh+dt@kernel.org>,
        krzk+dt <krzk+dt@kernel.org>, kishon <kishon@ti.com>,
        vkoul <vkoul@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "jesper.nilsson" <jesper.nilsson@axis.com>,
        "lars.persson" <lars.persson@axis.com>,
        bhelgaas <bhelgaas@google.com>,
        linux-phy <linux-phy@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi" <lorenzo.pieralisi@arm.com>, kw <kw@linux.com>,
        linux-arm-kernel <linux-arm-kernel@axis.com>,
        kernel <kernel@axis.com>, Moon-Ki Jun <moonki.jun@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>
Subject: Re: [PATCH 3/5] PCI: axis: Add ARTPEC-8 PCIe controller driver
Message-ID: <20220419152055.GA1203016@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62bbc2a6-92fb-ff2b-a43f-ecb402e8f90c@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 19, 2022 at 09:11:09AM +0200, Krzysztof Kozlowski wrote:
> On 19/04/2022 02:07, Wangseok Lee wrote:
> >> On 28/03/2022 04:14, 이왕석 wrote:
> >>>  Add support Axis, ARTPEC-8 SoC.
> >>>  ARTPEC-8 is the SoC platform of Axis Communications.
> >>>  This is based on arm64 and support GEN4 & 2lane.
> >>>  This PCIe controller is based on DesignWare Hardware core
> >>>  and uses DesignWare core functions to implement the driver.
> >>>  This is based on driver/pci/controller/dwc/pci-exynos.c
> >>>  
> >>>  Signed-off-by: Wangseok Lee 
> >>> ---
> >>>  drivers/pci/controller/dwc/Kconfig        |  31 +
> >>>  drivers/pci/controller/dwc/Makefile       |   1 +
> >>>  drivers/pci/controller/dwc/pcie-artpec8.c | 912 ++++++++++++++++++++++++++++++
> >>>  3 files changed, 944 insertions(+)
> >>>  create mode 100644 drivers/pci/controller/dwc/pcie-artpec8.c
> >>>
> >>
> >> I took a look at the your driver and at existing PCIe Exynos driver.
> >> Unfortunately PCIe Exynos driver is in poor shape, really poor. This
> >> would explain that maybe it's better to have new driver instead of
> >> merging them, especially that hardware is different. Although I am still
> >> waiting for some description of these differences...
> >>
> >> I said that Exynos PCIe looks poor... but what is worse, it looks like
> >> you based on it so you copied or some bad patterns it had.
> >>
> >> Except this the driver has several coding style issues, so please be
> >> sure to run checkpatch, sparse and smatch before sending it.
> >>
> >> Please work on this driver to make it close to Linux coding style, so
> >> there will be no need for us, reviewers, focus on basic stuff.
> >>
> >> Optionally, send all this to staging. :)
> >>
> >> Best regards,
> >> Krzysztof
> > Hi,
> > 
> > Thank you for your kindness review.
> > I will re-work again close to the linux coding style.
> > Addiltionaly, If you tell me what "bad patterns" you mentioned,
> > it will be very helpful for the work.
> > Could you please tell me that?
> 
> Except the tools I mentioned before, the patterns are:
> 1. debug messages for probe or other functions (we have ftrace and other
> tools for that).
> 2. Inconsistent coding style (e.g. different indentation in structure
> members).
> 3. Inconsistent code (e.g. artpec8_pcie_get_subsystem_resources() gets
> device from pdev and from pci so you have two same pointers; or
> artpec8_pcie_get_ep_mem_resources() stores dev as local variable but
> uses instead pdev->dev).
> 4. Not using devm_platform_ioremap_resource().
> 5. Wrappers over writel() and readl() which do nothing else than wrap
> one function.
> 6. Printing messages in interrupt handlers.
> 7. Several local/static structures or array are not const. Plus they are
> defined all through the code, instead of beginning of a file.

Thanks, Krzysztof, all great advice.

Not having looked at the driver at all, and because I'm not at all
expert in native drivers like this, also reuse as much of the
structure of other drivers as possible, especially the siblings in
drivers/pci/controller/dwc/.  That means similar structure, similar
variable names, similar function names, etc.  This makes it easier for
people to compare with other drivers to see which are affected by
future bug fixes.

Bjorn
