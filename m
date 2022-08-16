Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6023F59601F
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 18:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236349AbiHPQ0C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 12:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236237AbiHPQ0A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 12:26:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B67B7B293
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 09:25:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22F7DB81A8C
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 16:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABD0C433C1;
        Tue, 16 Aug 2022 16:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660667156;
        bh=R1xq11x6NRuXRDw6mj7ARmgejl3H5Ns/RHgrrlQhP7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VMfRcPFrBNhQC7rN5PgbxXUXHTYvgNBuAl1g+yxFc21MKx1RhSE+ZdtgktJ+iitmk
         2nJt3uyqzqlTqy1IkoJG8hJJ8EW/BO6FtFKoIYmY9cnbZamMAX/+lcg8kibnFzBGz2
         V4WmD8pquWHLJVt03aDuDLlDBG+Gk4OB0hdD5HrDa+DQkT0GW2QVWP1Mk1F4sBzwiv
         /v5Npg4dTu/H76dmINec68Nn/MfECi6OA+6drod/CPp3ffhqLKkmXeoNwsRtePqHpo
         1XvBQE76moLbtvEOUg1bQuXQicw7NgYAOcnFROKHsqZ3YDYpK5RGWfn1g/c1K+JzVa
         jooahrgkwbTtg==
Date:   Tue, 16 Aug 2022 18:25:48 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>, pali@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH 00/18] PCI: aardvark controller changes BATCH 5
Message-ID: <YvvFDGpcEz8E4SpA@lpieralisi>
References: <20220220193346.23789-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220220193346.23789-1-kabel@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Feb 20, 2022 at 08:33:28PM +0100, Marek Behún wrote:
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
> 
> Marek
> 
> Marek Behún (1):
>   arm64: dts: marvell: armada-37xx: Add clock to PCIe node
> 
> Miquel Raynal (2):
>   PCI: aardvark: Add clock support
>   PCI: aardvark: Add suspend to RAM support
> 
> Pali Rohár (13):
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

Hi Marek,

back from a hiatus, just catching up with threads. According to
patchwork patches {8,14,16} of this series are still to be
reviewed; may I ask you please an update on the status and we
will take it from there.

Thanks,
Lorenzo
