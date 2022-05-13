Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F73525FE1
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 12:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379487AbiEMKdj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 06:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379445AbiEMKdg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 06:33:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94D021A8DD5
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 03:33:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6959B1477;
        Fri, 13 May 2022 03:33:34 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.2.233])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DADF3F5A1;
        Fri, 13 May 2022 03:33:32 -0700 (PDT)
Date:   Fri, 13 May 2022 11:33:28 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>, pali@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH 00/18] PCI: aardvark controller changes BATCH 5
Message-ID: <20220513103328.GB26886@lpieralisi>
References: <20220220193346.23789-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220220193346.23789-1-kabel@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Feb 20, 2022 at 08:33:28PM +0100, Marek Beh�n wrote:
> Hello Lorenzo, Krzysztof,
> 
> here comes batch 5 of changes for Aardvark PCIe controller.
> 
> This batch
> - adds support for AER
> - adds support for DLLSC and hotplug interrupt
> - adds support for sending slot power limit message
> - adds enabling/disabling PCIe clock
> - adds suspend support
> - optimizes link training by adding it into separate worker
> - optimizes GPIO resetting by asserting it only if it wasn't asserted
>   already

I had a look and I can take patches 3 and 5 to cut the delta further,
please let me know if that helps.

Thanks,
Lorenzo

> Marek
> 
> Marek Beh�n (1):
>   arm64: dts: marvell: armada-37xx: Add clock to PCIe node
> 
> Miquel Raynal (2):
>   PCI: aardvark: Add clock support
>   PCI: aardvark: Add suspend to RAM support
> 
> Pali Roh�r (13):
>   PCI: aardvark: Add support for AER registers on emulated bridge
>   PCI: Add PCI_EXP_SLTCAP_*_SHIFT macros
>   PCI: aardvark: Fix reporting Slot capabilities on emulated bridge
>   PCI: pciehp: Enable DLLSC interrupt only if supported
>   PCI: pciehp: Enable Command Completed Interrupt only if supported
>   PCI: aardvark: Add support for DLLSC and hotplug interrupt
>   PCI: Add PCI_EXP_SLTCTL_ASPL_DISABLE macro
>   PCI: Add function for parsing `slot-power-limit-milliwatt` DT property
>   dt-bindings: PCI: aardvark: Describe slot-power-limit-milliwatt
>   PCI: aardvark: Send Set_Slot_Power_Limit message
>   arm64: dts: armada-3720-turris-mox: Define slot-power-limit-milliwatt
>     for PCIe
>   PCI: aardvark: Run link training in separate worker
>   PCI: aardvark: Optimize PCIe card reset via GPIO
> 
> Russell King (2):
>   PCI: pci-bridge-emul: Re-arrange register tests
>   PCI: pci-bridge-emul: Add support for PCIe extended capabilities
> 
>  .../devicetree/bindings/pci/aardvark-pci.txt  |   2 +
>  .../dts/marvell/armada-3720-turris-mox.dts    |   1 +
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |   1 +
>  drivers/pci/controller/pci-aardvark.c         | 380 ++++++++++++++++--
>  drivers/pci/hotplug/pciehp_hpc.c              |  34 +-
>  drivers/pci/hotplug/pnv_php.c                 |  13 +-
>  drivers/pci/of.c                              |  64 +++
>  drivers/pci/pci-bridge-emul.c                 | 130 +++---
>  drivers/pci/pci-bridge-emul.h                 |  15 +
>  drivers/pci/pci.h                             |  15 +
>  include/uapi/linux/pci_regs.h                 |   4 +
>  11 files changed, 565 insertions(+), 94 deletions(-)
> 
> -- 
> 2.34.1
> 
