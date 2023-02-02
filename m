Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A823687B71
	for <lists+linux-pci@lfdr.de>; Thu,  2 Feb 2023 12:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjBBLDX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Feb 2023 06:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbjBBLCL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Feb 2023 06:02:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B468AC1F;
        Thu,  2 Feb 2023 03:02:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4533D61AEA;
        Thu,  2 Feb 2023 11:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B71C4339B;
        Thu,  2 Feb 2023 11:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675335728;
        bh=lzDIUBwozYSnkNAtq+CbXRRVFuVSaq6m9YLSNh7qQGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MoJmx3pzVPOfdioUSvGq2DqDBcmghnKSAm4WKHhY1lPV58gO+92ShLq4EzyxcbnNY
         Jf+OdjwR1imNuLA/e9WQH249Z9jr/lbBxU1znZGtQ7eSS2Y9btxdFV+kAh4d4GlKeB
         vj6o8j9R8WO8WzQDBH4aXVZDRAJQW0w6i3Y8/P7oSvOjGqTAJxZZ3wSg8cbT5e699A
         3zHWZKizXZA6Xsry1mnf7nzqiIkCuYCJnhDV30We5RpfeF6IUZrHZaQ2GwzGoDQiyG
         QOF09Mhp1+jMIBZPrar5kffHQbUpUD8XFIBbO5klhiBXIOX2LQOr+eyPSKGHqvk6nQ
         kVPlLKoHGwbLA==
Date:   Thu, 2 Feb 2023 12:02:02 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Daire.McNamara@microchip.com
Cc:     linux-riscv@lists.infradead.org, kw@linux.com,
        Conor.Dooley@microchip.com, devicetree@vger.kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-pci@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        bhelgaas@google.com
Subject: Re: [PATCH v3 00/11] PCI: microchip: Partition address translations
Message-ID: <Y9uYKp24fHGkqI5Z@lpieralisi>
References: <20230111125323.1911373-1-daire.mcnamara@microchip.com>
 <d5a5ba3b01953c9db435f2371adee6e2b61d26dd.camel@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5a5ba3b01953c9db435f2371adee6e2b61d26dd.camel@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 31, 2023 at 05:03:00PM +0000, Daire.McNamara@microchip.com wrote:
> Hi all,
> 
> Just touching base here.  Can I take it that things are in-hand, and
> this patchset is moving into the kernel or is there something I need to
> do at my end?

I will have a look shortly, sorry for the delay.

Thanks,
Lorenzo

> best regards
> daire
> 
> On Wed, 2023-01-11 at 12:53 +0000, daire.mcnamara@microchip.com wrote:
> > From: Daire McNamara <daire.mcnamara@microchip.com>
> > 
> > Changes since v2:
> > - Replaced GENMASK(63,0) with GENMASK_ULL(63,0) to remove warning
> > - Added patch to avoid warning on cast of argument to
> > devm_add_action_or_reset()
> > - Added patch to enable building driver as a module
> > 
> > Changes since v1:
> > - Removed unused variables causing compile warnings
> > - Removed incorrect Signed-off-by: tags
> > - Capitalised msi and msi-x
> > - Capitalised FIC and respelled busses to buses
> > - Capitalised all comments
> > - Renamed fabric inter connect to Fabric Interface Controller as per
> > PolarFire SoC TRM
> > 
> > Microchip PolarFire SoC is a 64-bit device and has DDR starting at
> > 0x80000000 and 0x1000000000. Its PCIe rootport is connected to the
> > CPU
> > Coreplex via an FPGA fabric. The AXI connections between the Coreplex
> > and
> > the fabric are 64-bit and the AXI connections between the fabric and
> > the
> > rootport are 32-bit.  For the CPU CorePlex to act as an AXI-Master to
> > the
> > PCIe devices and for the PCIe devices to act as bus masters to DDR at
> > these
> > base addresses, the fabric can be customised to add/remove offsets
> > for bits
> > 38-32 in each direction. These offsets, if present, vary with each
> > customer's design.
> > 
> > To support this variety, the rootport driver must know how much
> > address
> > translation (both inbound and outbound) is performed by a particular
> > customer design and how much address translation must be provided by
> > the
> > rootport.
> > 
> > This patchset contains a parent/child dma-ranges scheme suggested by
> > Rob
> > Herring. It creates an FPGA PCIe parent bus which wraps the PCIe
> > rootport
> > and implements a parsing scheme where the root port identifies what
> > address
> > translations are performed by the FPGA fabric parent bus, and what
> > address translations must be done by the rootport itself.
> > 
> > See 
> > https://lore.kernel.org/linux-pci/20220902142202.2437658-1-daire.mcnamara@microchip.com/
> > for the relevant previous patch submission discussion.
> > 
> > It also re-partitions the probe() and init() functions as suggested
> > by
> > Bjorn Helgaas to make them more maintainable as the init() function
> > had
> > become too large.
> > 
> > It also contains some minor fixes and clean-ups that are pre-
> > requisites:
> > - to align register, offset, and mask names with the hardware
> > documentation
> >   and to have the register definitions appear in the same order as in
> > the
> >   hardware documentation;
> > - to harvest the MSI information from the hardware configuration
> > register
> >   as these depend on the FPGA fabric design and can vary with
> > different
> >   customer designs;
> > - to clean up interrupt initialisation to make it more maintainable;
> > - to fix SEC and DED interrupt handling.
> > 
> > I expect Conor will take the dts patch via the soc tree once the PCIe
> > parts
> > of the series are accepted.
> > 
> > Conor Dooley (1):
> >   riscv: dts: microchip: add parent ranges and dma-ranges for IKRD
> >     v2022.09
> > 
> > Daire McNamara (10):
> >   PCI: microchip: Correct the DED and SEC interrupt bit offsets
> >   PCI: microchip: Remove cast warning for devm_add_action_or_reset()
> > arg
> >   PCI: microchip: enable building this driver as a module
> >   PCI: microchip: Align register, offset, and mask names with hw docs
> >   PCI: microchip: Enable event handlers to access bridge and ctrl
> > ptrs
> >   PCI: microchip: Clean up initialisation of interrupts
> >   PCI: microchip: Gather MSI information from hardware config
> > registers
> >   PCI: microchip: Re-partition code between probe() and init()
> >   PCI: microchip: Partition outbound address translation
> >   PCI: microchip: Partition inbound address translation
> > 
> >  .../dts/microchip/mpfs-icicle-kit-fabric.dtsi |  62 +-
> >  drivers/pci/controller/Kconfig                |   2 +-
> >  drivers/pci/controller/pcie-microchip-host.c  | 688 +++++++++++++---
> > --
> >  3 files changed, 533 insertions(+), 219 deletions(-)
> > 
> > 
> > base-commit: 3c1f24109dfc4fb1a3730ed237e50183c6bb26b3
