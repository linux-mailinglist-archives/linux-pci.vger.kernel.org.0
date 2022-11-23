Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D16636E3B
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 00:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiKWXQN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 18:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiKWXP4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 18:15:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD03F4A58F;
        Wed, 23 Nov 2022 15:15:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58FEC61F5C;
        Wed, 23 Nov 2022 23:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A532C433C1;
        Wed, 23 Nov 2022 23:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669245319;
        bh=bWh0T0oFSkJB4PdiGGy2fzByge1TZxmhgUDK3+WVRwQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hOsL4XS3Ls3qrj//pdUPbpdj+bs3yrDTUf2+YCvHJOcLO96rX1hwTJysQesJ4OxXO
         1QN13hX76UR86edLyOE82ZXmQIOb6+ciFjaOFlb/HzTB6QcttSr7FiWjsu6OdlW0hI
         ESLz2htJ4t/8vPubL5XR/fY7MCxlq0qOIk1M62UvPMcT9rnBqIz0BSRdGbJZ5u5M6N
         IfSKX0Lj22j6681Hku9IO3xbNOf94rmi/G0aD0aOe3AtJ1xUeS4zPBqN05bZa9nOpu
         7Mp3b1P4NYcUXM3CfdzyhKoaIva8vB4wB6yuQPMPbR6SLHag8QJ6uAeFvNSj3XFEqz
         VzfK2GNkl40MQ==
Date:   Wed, 23 Nov 2022 23:15:14 +0000
From:   Conor Dooley <conor@kernel.org>
To:     daire.mcnamara@microchip.com
Cc:     conor.dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, lpieralisi@kernel.org,
        kw@linux.com, bhelgaas@google.com, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 0/9] PCI: microchip: Partition address translations
Message-ID: <Y36pgsCplC5hN2ij@spud>
References: <20221116135504.258687-1-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116135504.258687-1-daire.mcnamara@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hey Daire,

On Wed, Nov 16, 2022 at 01:54:55PM +0000, daire.mcnamara@microchip.com wrote:
> From: Daire McNamara <daire.mcnamara@microchip.com>
> 
> Microchip PolarFire SoC is a 64-bit device and has DDR starting at
> 0x80000000 and 0x1000000000. Its PCIe rootport is connected to the CPU
> Coreplex via an FPGA fabric. The AXI connections between the Coreplex and
> the fabric are 64-bit and the AXI connections between the fabric and the
> rootport are 32-bit.  For the CPU CorePlex to act as an AXI-Master to the
> PCIe devices and for the PCIe devices to act as bus masters to DDR at these
> base addresses, the fabric can be customised to add/remove offsets for bits
> 38-32 in each direction. These offsets, if present, vary with each
> customer's design.
> 
> To support this variety, the rootport driver must know how much address
> translation (both inbound and outbound) is performed by a particular
> customer design and how much address translation must be provided by the
> rootport.
> 
> This patchset contains a parent/child dma-ranges scheme suggested by Rob
> Herring. It creates an FPGA PCIe parent bus which wraps the PCIe rootport
> and implements a parsing scheme where the root port identifies what address
> translations are performed by the FPGA fabric parent bus, and what
> address translations must be done by the rootport itself.

I've tried this scheme with a bunch of different PCI configurations, and
it holds water, so I am happy with it :) Hopefully Rob is a lot happier
with this version of it too!

It's been long enough that I think you should be good to submit a
cleaned up version, provided Rob's happy on the DT side I think.

Thanks,
Conor.

> See https://lore.kernel.org/linux-pci/20220902142202.2437658-1-daire.mcnamara@microchip.com/
> for the relevant previous patch submission discussion.
> 
> It also re-partitions the probe() and init() functions as suggested by
> Bjorn Helgaas to make them more maintainable as the init() function had
> become too large.
> 
> It also contains some minor fixes and clean-ups that are pre-requisites:
> - to align register, offset, and mask names with the hardware documentation
>   and to have the register definitions appear in the same order as in the
>   hardware documentation;
> - to harvest the MSI information from the hardware configuration register
>   as these depend on the FPGA fabric design and can vary with different
>   customer designs;
> - to clean up interrupt initialisation to make it more maintainable;
> - to fix SEC and DED interrupt handling.
> 
> I expect Conor will take the dts patch via the soc tree once the PCIe parts
> of the series are accepted.
> 
> Conor Dooley (1):
>   riscv: dts: microchip: add parent ranges and dma-ranges for IKRD
>     v2022.09
> 
> Daire McNamara (8):
>   PCI: microchip: Align register, offset, and mask names with hw docs
>   PCI: microchip: Correct the DED and SEC interrupt bit offsets
>   PCI: microchip: Enable event handlers to access bridge and ctrl ptrs
>   PCI: microchip: Clean up initialisation of interrupts
>   PCI: microchip: Gather MSI information from hardware config registers
>   PCI: microchip: Re-partition code between probe() and init()
>   PCI: microchip: Partition outbound address translation
>   PCI: microchip: Partition inbound address translation
> 
>  .../dts/microchip/mpfs-icicle-kit-fabric.dtsi |  62 +-
>  drivers/pci/controller/pcie-microchip-host.c  | 676 +++++++++++++-----
>  2 files changed, 522 insertions(+), 216 deletions(-)
> 
> 
> base-commit: 3c1f24109dfc4fb1a3730ed237e50183c6bb26b3
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
