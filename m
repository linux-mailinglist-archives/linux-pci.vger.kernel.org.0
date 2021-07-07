Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316983BECF8
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jul 2021 19:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhGGRX7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jul 2021 13:23:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229949AbhGGRX6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Jul 2021 13:23:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C98B261C9A;
        Wed,  7 Jul 2021 17:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625678478;
        bh=9+TnQNEyGUeUXH3JMvMpjH01KIt9rzwBq4016TVjiBs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NS4Nre1TFVwZpHF1c03qOAzGiLrVuVB4ZOn9uW3H2RUqYzj2GO/2hdBBO87R2a6K8
         j5D9r+QdwBzHtMRETPMuyBMVeAeOTNrPdGCDcsPgjpxjnK/uGPYWJvYfZ7k/Fw9eNP
         Qu8+204bieZ3HKkV0aZh7DsLzT3A5rpWB9sSPyBIOBz6sC20o4bhhC+/nYppUHImNT
         sRO6IuWHAzNTmDtoZbeRMnVh6Cozr/WWdOgVRr7kg7Q//yyzSdyDGORuQiv3jHsO7F
         HEEPftwtVTuQwPPyQm4NUDXTxsPpQaCBDxnGmvXqVwmPEucjJnoqYSk+vzyjdCkUZh
         bQtILIe1WeAMw==
Date:   Wed, 7 Jul 2021 12:21:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Art Nikpal <email2tema@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        =?utf-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>,
        Yue Wang <yue.wang@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Artem Lapkin <art@khadas.com>, Nick Xie <nick@khadas.com>,
        Gouwa Wang <gouwa@khadas.com>
Subject: Re: [PATCH 0/4] PCI: replace dublicated MRRS limit quirks
Message-ID: <20210707172108.GA908207@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707165735.GA905464@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 07, 2021 at 11:57:35AM -0500, Bjorn Helgaas wrote:
> On Wed, Jul 07, 2021 at 06:43:13PM +0200, Neil Armstrong wrote:
> > On 07/07/2021 17:54, Bjorn Helgaas wrote:
> > > On Tue, Jul 06, 2021 at 11:54:05AM +0200, Neil Armstrong wrote:
> > >> In their Designware PCIe controller driver, amlogic sets the
> > >> Max_Payload_Size & Max_Read_Request_Size to 256:
> > >> https://elixir.bootlin.com/linux/latest/source/drivers/pci/controller/dwc/pci-meson.c#L260
> > >> https://elixir.bootlin.com/linux/latest/source/drivers/pci/controller/dwc/pci-meson.c#L276
> > >> in their root port PCIe Express Device Control Register.
> > >>
> > >> Looking at the Synopsys DW-PCIe Databook, Max_Payload_Size &
> > >> Max_Read_Request_Size are used to decompose into AXI burst, but it
> > >> seems the Max_Payload_Size & Max_Read_Request_Size are set by
> > >> default to 512 but the internal Max_Payload_Size_Supported is set to
> > >> 256, thus changing these values to 256 at runtime to match and
> > >> optimize bandwidth.
> > >>
> > >> It's said, "Reducing Outbound Decomposition" :
> > >>  - "Ensure that your application master does not generate bursts of
> > >>    size greater than or equal to Max_Payload_Size"
> > >>
> > >>  - "Program your PCIe system with a larger value of Max_Payload_Size
> > >>    without exceeding Max_Payload_Size_Supported"
> > >>
> > >>  - "Program your PCIe system with a larger value of Max_Read_Request
> > >>    without exceeding Max_Payload_Size_Supported:
> > >>
> > >> So leaving 512 in Max_Payload_Size & Max_Read_Request leads to
> > >> Outbound Decomposition which decreases PCIe link and degrades the
> > >> AXI bus by doubling the bursts, leading to this fix to avoid
> > >> overflowing the AXI bus.
> > >>
> > >> So it seems to be still needed, I assume this *should* be handled in
> > >> the core somehow to propagate these settings to child endpoints to
> > >> match the root port Max_Payload_Size & Max_Read_Request sizes.
> > >>
> > >> Maybe by adding a core function to set these values instead of using
> > >> the dw_pcie_find_capability() & dw_pcie_write/readl_dbi() helpers
> > >> and set a state on the root port to propagate the value ?
> > > 
> > > I don't have the Synopsys DW-PCIe Databook, so I'm lacking any
> > > context.  The above *seems* to say that MPS/MRRS settings affect AXI
> > > bus usage.
> > 
> > It does when the TLPs are directed to the RC.
> 
> That's a defect in the RC.

I mean, it's OK if MPS affects the *performance* of traffic on AXI,
but the RC must work correctly for any MPS up to the MPSS (Max Payload
Size Supported) it advertises.  And there's no PCIe mechanism for
managing the AXI performance impact, so I think it's a mistake if
Synopsys expects device-specific code in the MPS/MRRS configuration
path.  That code should be device-independent.

> > > The MPS and MRRS registers are defined to affect traffic on *PCIe*.  If
> > > a platform uses MPS and MRRS values to optimize transfers on non-PCIe
> > > links, that's a problem because the PCI core code that manages MPS and
> > > MRRS has no knowledge of those non-PCIe parts of the system.
> > 
> > Yes and no, it only affects PCIe in P2P, in non-P2P is will certainly affect
> > transfers on the internal SoC/Processor/Chip internal bus/fabric.
> > 
> > > You might be able to deal with this in Synopsys-specific code somehow,
> > > but it's going to be a bit of a hassle because I don't want it to make
> > > maintenance of the generic MPS/MRRS code harder.
> > 
> > I understand, but this is why these quirks are currently implemented in the
> > controller driver and only applies when the controller has been probed
> > and to each endpoint detected on this particular controller.
> > 
> > So we may continue having separate quirks for each controller if the core
> > isn't the right place to handle MPS/MRRS.
> 
> The PCI core is the correct place to handle MPS/MRRS because their
> behavior is defined by the PCIe spec.
> 
> Quirks are the way to work around this defect in the Synopsys PCIe IP.
> 
> Bjorn
