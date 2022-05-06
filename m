Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A07451DA74
	for <lists+linux-pci@lfdr.de>; Fri,  6 May 2022 16:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442038AbiEFO0m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 May 2022 10:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238749AbiEFO0l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 May 2022 10:26:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733F05A2C5;
        Fri,  6 May 2022 07:22:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1185F6212E;
        Fri,  6 May 2022 14:22:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19332C385A8;
        Fri,  6 May 2022 14:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651846977;
        bh=E6ckQimwVSaJW0lOSfV/5lkLUMUjbvk41FciJ2SCey8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lbg4lp/e+Ro7BaNZuo0VdvKl3tLnLoX4vaXA2rE2jhp3cB8b8PSn9BG/nhEUFTqZd
         XDK36kHSjqC/LRjmjSWyLzl8JrkegNQRhRyYVaFK/mDbku9OanJaC6mfLlkJOPfHiF
         u6Eu3EgN+vcR/3klokvMzrURadg6q1IIJ9HFtUZMXEcNYy7PtQUwoIovcrUsXFwO7a
         QFVkPRGhLD6tG3XM2wwdGsgAspTzCF9H+300lhSVib5p0caRTf5p+If+SHlpB+44gV
         9ZBOhK1pVcGNqJnmP89axU5KilkZ6DcHd6Wq7yUdfNGdcra4YUpmT3a8gkyO/5dyYK
         pZ03u0/mRlLmg==
Received: by pali.im (Postfix)
        id 220C21141; Fri,  6 May 2022 16:22:54 +0200 (CEST)
Date:   Fri, 6 May 2022 16:22:54 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/6] PCI: mvebu: Add support for PME and AER interrupts
Message-ID: <20220506142254.mzl7jotubvebptlp@pali>
References: <20220506134029.21470-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220506134029.21470-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 06 May 2022 15:40:23 Pali Rohár wrote:
> mvebu PCIe PME and AER interrupts are reported via PCIe summary
> interrupt. PCIe summary interrupt is reported via mvebu MPIC SoC error
> summary interrupt. And MPIC SoC error summary interrupt is reported via
> MPIC IRQ 4.
> 
> This patch series implements support for interrupts in MPIC SoC error
> hierarchy in irq-armada-370-xp.c driver and support for interrupts in
> mvebu PCIe hierarchy in pci-mvebu.c.
> 
> Finally PCIe PME and AER interrupts are routed to the correct PCIe Root
> Port, which allows kernel PME and AER drivers to take care of them.
> 
> Tested on A385 board and kernel PME and AER drivers works correctly:
> 
> [    0.898482] pcieport 0000:00:01.0: PME: Signaling with IRQ 61
> [    0.904422] pcieport 0000:00:01.0: AER: enabled with IRQ 61
> [    0.910113] pcieport 0000:00:02.0: enabling device (0140 -> 0142)
> [    0.916299] pcieport 0000:00:02.0: PME: Signaling with IRQ 62
> [    0.922216] pcieport 0000:00:02.0: AER: enabled with IRQ 62
> [    0.927917] pcieport 0000:00:03.0: enabling device (0140 -> 0142)
> [    0.934090] pcieport 0000:00:03.0: PME: Signaling with IRQ 63
> [    0.940006] pcieport 0000:00:03.0: AER: enabled with IRQ 63
> 
> This change finally allows to debug PCIe issues on A385 boards.

FYI I tested that AER errors are now really handled by kernel AER driver:

[ 2733.258661] pcieport 0000:00:02.0: AER: Multiple Uncorrected (Non-Fatal) error received: 0000:02:00.0
[ 2733.258661] pcieport 0000:00:01.0: AER: Multiple Corrected error received: 0000:01:00.0
[ 2733.258682] pcieport 0000:00:01.0: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
[ 2733.267932] ath10k_pci 0000:02:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
[ 2733.275956] pcieport 0000:00:01.0:   device [11ab:6820] error status/mask=00000001/00002000
[ 2733.285547] ath10k_pci 0000:02:00.0:   device [168c:003c] error status/mask=00100000/00000000
[ 2733.296876] pcieport 0000:00:01.0:    [ 0] RxErr                  (First)
[ 2733.305245] ath10k_pci 0000:02:00.0:    [20] UnsupReq               (First)
[ 2733.305251] ath10k_pci 0000:02:00.0: AER:   TLP Header: 30000000 02080030 00000000 00000000
[ 2733.305282] ath10k_pci 0000:02:00.0: AER: can't recover (no error_detected callback)
[ 2733.313816] nvme 0000:01:00.0: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Transmitter ID)
[ 2733.320671] pcieport 0000:00:02.0: AER: device recovery failed
[ 2733.327609] nvme 0000:01:00.0:   device [1e0f:0001] error status/mask=00001041/00002000
[ 2733.367127] nvme 0000:01:00.0:    [ 0] RxErr                  (First)
[ 2733.373591] nvme 0000:01:00.0:    [ 6] BadTLP                
[ 2733.379358] nvme 0000:01:00.0:    [12] Timeout               
[ 2733.385120] nvme 0000:01:00.0: AER:   Error of this Agent is reported first

> Pali Rohár (6):
>   dt-bindings: irqchip: armada-370-xp: Update information about MPIC SoC
>     Error
>   irqchip/armada-370-xp: Implement SoC Error interrupts
>   ARM: dts: armada-38x.dtsi: Add node for MPIC SoC Error IRQ controller
>   dt-bindings: PCI: mvebu: Update information about summary interrupt
>   PCI: mvebu: Implement support for interrupts on emulated bridge
>   ARM: dts: armada-385.dtsi: Add definitions for PCIe summary interrupts
> 
>  .../marvell,armada-370-xp-mpic.txt            |   9 +
>  .../devicetree/bindings/pci/mvebu-pci.txt     |   1 +
>  arch/arm/boot/dts/armada-385.dtsi             |  20 +-
>  arch/arm/boot/dts/armada-38x.dtsi             |   5 +
>  drivers/irqchip/irq-armada-370-xp.c           | 213 +++++++++++++++++-
>  drivers/pci/controller/pci-mvebu.c            | 208 +++++++++++++++--
>  6 files changed, 426 insertions(+), 30 deletions(-)
> 
> -- 
> 2.20.1
> 
