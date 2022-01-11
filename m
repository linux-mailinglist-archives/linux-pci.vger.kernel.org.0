Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D02448B0AA
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jan 2022 16:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243488AbiAKPTK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jan 2022 10:19:10 -0500
Received: from elvis.franken.de ([193.175.24.41]:42587 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231986AbiAKPTJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Jan 2022 10:19:09 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1n7IvR-0004j6-01; Tue, 11 Jan 2022 16:19:05 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 1FA0DC0E68; Tue, 11 Jan 2022 16:18:41 +0100 (CET)
Date:   Tue, 11 Jan 2022 16:18:41 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-mips@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>,
        Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v1 0/4] PCI: brcmstb: Augment driver for MIPs SOCs
Message-ID: <20220111151841.GB11006@alpha.franken.de>
References: <20211209204726.6676-1-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209204726.6676-1-jim2101024@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 09, 2021 at 03:47:21PM -0500, Jim Quinlan wrote:
> With this patchset, the Broadcom STB PCIe controller driver 
> supports Arm, Arm64, and now MIPs.
> 
> Jim Quinlan (4):
>   dt-bindings: PCI: Add compatible string for Brcmstb 74[23]5 MIPs SOCs
>   MIPS: bmips: Add support PCIe controller device nodes
>   MIPS: bmips: Remove obsolete DMA mapping support
>   PCI: brcmstb: Augment driver for MIPs SOCs
> 
>  .../bindings/pci/brcm,stb-pcie.yaml           |   2 +
>  arch/mips/Kconfig                             |   1 -
>  arch/mips/bmips/dma.c                         | 106 +-----------------
>  arch/mips/boot/dts/brcm/bcm7425.dtsi          |  30 +++++
>  arch/mips/boot/dts/brcm/bcm7435.dtsi          |  30 +++++
>  arch/mips/boot/dts/brcm/bcm97425svmb.dts      |   9 ++
>  arch/mips/boot/dts/brcm/bcm97435svmb.dts      |   9 ++
>  drivers/pci/controller/Kconfig                |   2 +-
>  drivers/pci/controller/pcie-brcmstb.c         |  82 +++++++++++++-
>  9 files changed, 161 insertions(+), 110 deletions(-)

series applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
