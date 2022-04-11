Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F9B4FC2C1
	for <lists+linux-pci@lfdr.de>; Mon, 11 Apr 2022 18:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243308AbiDKQzY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Apr 2022 12:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241922AbiDKQzX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2022 12:55:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C8235264
        for <linux-pci@vger.kernel.org>; Mon, 11 Apr 2022 09:53:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EAA7EB81716
        for <linux-pci@vger.kernel.org>; Mon, 11 Apr 2022 16:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B41C385A3;
        Mon, 11 Apr 2022 16:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649695986;
        bh=JWgIvFStReKHFvazyQ+P5dMXzxxteokY9DZL2RDHylI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LGrOxFQkUB9z4Vkadd1ZxqLpJmS8gacRwBVXUmTquXkHsdZV8y92PCw4kkFnHzm6D
         czEiRK7nKPCxzjHzs6kaIZ6lpPuqGvCrBuvo828ftSuk6aT1GNZ1R2Uz4K5q7QxvCZ
         /HeXoXC0ZGwPJBqtTQ9Tyg35ck0OYQrxu2QcXJ+26vmtNsMDl0OJMYU5o7y/uWg/aB
         gdyHnzVkEZlyWOi0pdzkmtHlSvULFQi7Yjept23GYmF0zGq+s2IQJID4yEkbCSY0H9
         j6limE9Mu7ImEBusNzvrqYZmkY+zbEeKMyCJB3sLCLfhE66WG9XDUl/MSuUwgDdiSL
         +BGBte1zn3Saw==
Received: by pali.im (Postfix)
        id 537D1947; Mon, 11 Apr 2022 18:53:03 +0200 (CEST)
Date:   Mon, 11 Apr 2022 18:53:03 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH 00/18] PCI: aardvark controller changes BATCH 5
Message-ID: <20220411165303.stupmwjszh3otlme@pali>
References: <20220220193346.23789-1-kabel@kernel.org>
 <YlRLC/WlHzUUugr8@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YlRLC/WlHzUUugr8@lpieralisi>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 11 April 2022 16:36:43 Lorenzo Pieralisi wrote:
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
> > 
> > Marek
> 
> Hi Marek,
> 
> I noticed Pali posted patches [9,11] separately:
> 
> https://lore.kernel.org/linux-pci/20220325093827.4983-1-pali@kernel.org

Patches 9,10,11 from this patch series are also in above mvebu patch
series as they are required for other patch in above patch series.

Above patch series is v3 and I'm planning to send v4 to address all
review issues.

So basically patches 9,10,11 in this patch series should be replaced
with new version.

> I will review the rest of the series - when it comes to merging patches
> we will handle how to apply them.
> 
> Lorenzo
> 
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
