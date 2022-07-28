Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54AAA584434
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jul 2022 18:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiG1Qee (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jul 2022 12:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiG1Qed (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jul 2022 12:34:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7F92A408;
        Thu, 28 Jul 2022 09:34:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60913B824A4;
        Thu, 28 Jul 2022 16:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCECC433C1;
        Thu, 28 Jul 2022 16:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659026070;
        bh=nHxv6d85T9pP+ZMr9V+fyaj2Jn/Rv2IPUgxkxsht70U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cqYXCPuHS+WT6FGL4i5sVVQ3hh488bn5WY8VefisqFETD+o830r8o5DuzRgLVW53p
         lNZeGzhyQ8QOiB1mNtSQFEJJPpx11tMYKlvZ5TmINHyTmE1VrfDVQIeLcRL93LnTJu
         pRtByKNRTw4unO5i+yUbdipm3koH7i1SaIYGKGeHp8pZ3Q1LkTPvSJZl3i6qk1STPT
         IIkKTlokqLliUiO+4/zVGlgsVe9V8ANEMNh6aTwI7kaDEYRM8oKhpcGDv5ckqBHqRW
         cRpmTEGnjAaovH786jk/Zl02k6dDD4RObN6O4rYHoGdZ0dwmfiXGBMEpDWSsLNvACE
         nVo4A5EIx9yWQ==
Date:   Thu, 28 Jul 2022 11:34:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH RESEND v4 03/15] PCI: dwc: Convert to using native
 IP-core versions representation
Message-ID: <20220728163428.GA309179@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d644682-094d-6151-aa2f-86552c8f9a87@codethink.co.uk>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 28, 2022 at 04:31:17PM +0100, Ben Dooks wrote:
> On 28/07/2022 16:24, Bjorn Helgaas wrote:
> > On Fri, Jun 24, 2022 at 05:39:35PM +0300, Serge Semin wrote:
> > > Since DWC PCIe v4.70a the controller version can be read from the
> > > PORT_LOGIC.PCIE_VERSION_OFF register. Version is represented in the FourCC
> > > format [1]. It's standard versioning approach for the Synopsys DWC
> > > IP-cores. Moreover some of the DWC kernel drivers already make use of it
> > > to fixup version-dependent functionality (See DWC USB3, Stmicro STMMAC or
> > > recent DW SPI driver).
> > 
> > These references to other drivers might be useful, but without a
> > function name or file name, I can't easily find them.
> > 
> > > In order to preserve the standard version
> > > representation and prevent the data conversion back and forth, we suggest
> > > to preserve the native version representation in the DWC PCIe driver too
> > > in the same way as it has already been done in the rest of the DWC
> > > drivers. IP-core version reading from the CSR will be introduced in the
> > > next commit together with a simple macro-based API to use it.
> > > 
> > > [1] https://en.wikipedia.org/wiki/FourCC
> 
> I'm currently looking at a OF based dw-apb-timers-pwm driver, so also
> would like to follow this.

FWIW, the breadcrumbs I found are:

  dwc3_core_is_valid()
  stmmac_hwif_init()
  dw_spi_hw_init()
