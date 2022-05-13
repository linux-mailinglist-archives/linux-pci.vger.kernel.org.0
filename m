Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DF8526769
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 18:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240361AbiEMQs3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 12:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbiEMQs2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 12:48:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB830522C3
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 09:48:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62D9E61EFE
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 16:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B45C34100;
        Fri, 13 May 2022 16:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652460505;
        bh=R8Ovr0t1XquDu8/0O/FVoSyineOGnSMDllavpJzGm3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pjw85g0VbZFckhbyvInWIlyi1gaNTmEma7X8e+JHYmtG0/XFj9LqRYm6hQrifVHUE
         MBNRxQH7U4natczXTNOdA8tWXQi+i3OL07Yg4RceZ191+8OiIRN//lsRNlyFn2Cujm
         5rVpv2fnFXGiKMI2FZkKsvZ1Bjgj8sED8IwUKkV4LUVHwDna0mPQNPHUQ3YEWzza9l
         TUHfwXsbGI1sdzYn0arB1yAWmc+16KBLv7gBcXC52/AF6qL3aj+664RwCdQbXNrESu
         aedbzdV1j7umrA/lNlBQYm5Na47NPH3LFu+XAU3FkJVsEWSFAa8j76kdfvADV3fb5X
         G/U1BeGwEQ6nw==
Received: by pali.im (Postfix)
        id B4BEC2B90; Fri, 13 May 2022 18:48:22 +0200 (CEST)
Date:   Fri, 13 May 2022 18:48:22 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH 00/18] PCI: aardvark controller changes BATCH 5
Message-ID: <20220513164822.x34qe4blx5hfw5tx@pali>
References: <20220220193346.23789-1-kabel@kernel.org>
 <20220513103328.GB26886@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220513103328.GB26886@lpieralisi>
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

On Friday 13 May 2022 11:33:28 Lorenzo Pieralisi wrote:
> On Sun, Feb 20, 2022 at 08:33:28PM +0100, Marek Behún wrote:
> > Hello Lorenzo, Krzysztof,
> > 
> > here comes batch 5 of changes for Aardvark PCIe controller.
> > 
> > This batch
> > - adds support for AER
> > - adds support for DLLSC and hotplug interrupt
> > - adds support for sending slot power limit message
> > - adds enabling/disabling PCIe clock
> > - adds suspend support
> > - optimizes link training by adding it into separate worker
> > - optimizes GPIO resetting by asserting it only if it wasn't asserted
> >   already
> 
> I had a look and I can take patches 3 and 5 to cut the delta further,
> please let me know if that helps.

Hello! Hopefully Marek would be back in week or more. Meanwhile patches
3 and 5 should be fine to take.

> Thanks,
> Lorenzo
> 
> > Marek
> > 
> > Marek Behún (1):
> >   arm64: dts: marvell: armada-37xx: Add clock to PCIe node
> > 
> > Miquel Raynal (2):
> >   PCI: aardvark: Add clock support
> >   PCI: aardvark: Add suspend to RAM support
> > 
> > Pali Rohár (13):
> >   PCI: aardvark: Add support for AER registers on emulated bridge
> >   PCI: Add PCI_EXP_SLTCAP_*_SHIFT macros
> >   PCI: aardvark: Fix reporting Slot capabilities on emulated bridge
> >   PCI: pciehp: Enable DLLSC interrupt only if supported
> >   PCI: pciehp: Enable Command Completed Interrupt only if supported
> >   PCI: aardvark: Add support for DLLSC and hotplug interrupt
> >   PCI: Add PCI_EXP_SLTCTL_ASPL_DISABLE macro
> >   PCI: Add function for parsing `slot-power-limit-milliwatt` DT property
> >   dt-bindings: PCI: aardvark: Describe slot-power-limit-milliwatt
> >   PCI: aardvark: Send Set_Slot_Power_Limit message
> >   arm64: dts: armada-3720-turris-mox: Define slot-power-limit-milliwatt
> >     for PCIe
> >   PCI: aardvark: Run link training in separate worker
> >   PCI: aardvark: Optimize PCIe card reset via GPIO
> > 
> > Russell King (2):
> >   PCI: pci-bridge-emul: Re-arrange register tests
> >   PCI: pci-bridge-emul: Add support for PCIe extended capabilities
> > 
> >  .../devicetree/bindings/pci/aardvark-pci.txt  |   2 +
> >  .../dts/marvell/armada-3720-turris-mox.dts    |   1 +
> >  arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |   1 +
> >  drivers/pci/controller/pci-aardvark.c         | 380 ++++++++++++++++--
> >  drivers/pci/hotplug/pciehp_hpc.c              |  34 +-
> >  drivers/pci/hotplug/pnv_php.c                 |  13 +-
> >  drivers/pci/of.c                              |  64 +++
> >  drivers/pci/pci-bridge-emul.c                 | 130 +++---
> >  drivers/pci/pci-bridge-emul.h                 |  15 +
> >  drivers/pci/pci.h                             |  15 +
> >  include/uapi/linux/pci_regs.h                 |   4 +
> >  11 files changed, 565 insertions(+), 94 deletions(-)
> > 
> > -- 
> > 2.34.1
> > 
