Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD54C5A6E1B
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 22:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiH3UHK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 16:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiH3UHI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 16:07:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF469754B1;
        Tue, 30 Aug 2022 13:07:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E34A617C9;
        Tue, 30 Aug 2022 20:07:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24D5C433C1;
        Tue, 30 Aug 2022 20:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661890023;
        bh=GjZuCVubdGfBGAy1tO+YfYRaULtpFbUgYBOf98neQH8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LlxBq1BhJaqq3JColJ2FFAgCSxP7PN23KPz697Ua2ozUObW+vt5V1qPnhYw1zLojr
         /UkXw/AOuxfZLwtu3ZVBUSRxc1flHI1lry6T5hisnZaR/qPV1t7aRxGxkREPUyciLt
         RRiYrH1xqsAPiplKMZzsWMgHcW1CNk2OTsIC4ODgiNPgl5XwlayP1Le/QHmlAsAOFL
         c2WFXzjb+nlnlTK3JPLqdaDJaxZczuIa8vQJYxyDZGgWeerXzmYfny3LOfzHUR9qij
         bz3JV31/Ui/lla/MV7rh0HAHuG52R/ayl6xlhI6YYh857DBD+fIIHvBA/DcF+PhyKu
         2F+9niLoNLPFA==
Date:   Tue, 30 Aug 2022 15:07:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Steven J Abner <pheonix.sja@att.net>, linux-kernel@vger.kernel.org,
        PCI <linux-pci@vger.kernel.org>
Subject: Re: pcieport bug?
Message-ID: <20220830200702.GA122616@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd8fb085-76dc-f2b0-6101-f84c93b8a0af@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 29, 2022 at 03:14:23PM -0700, Randy Dunlap wrote:
> On 8/29/22 10:59, Steven J Abner wrote:
> > Hi
> > Building a kernel tailored for AMD 2400g on ASRock B450 using 5.18.12 as base, OS
> > is Elementary 6.1 on top of Ubuntu 20.04.5.
> > In a config I changed some which lead to this query,'cause not sure what it means.
> > So up to you see if it is of concern. Notation igpu# refers to build sequence tests.
> > Also note that pcieport may affect other drivers?

igpu32 is built with CONFIG_PCIEPORTBUS=y and igpu33 is built with
CONFIG_PCIEPORTBUS not set.  Both are built from the same kernel
version.  Right?

And you see some lspci differences bewteen igpu32 and igpu33?

Is there something that does not work as you expect it to work?

Obviously with CONFIG_PCIEPORTBUS not set, we expect things that
depend on PCIEPORTBUS will not work.  This includes AER, hotplug, PME,
DPC, etc.

If you're seeing something unexpected, can you collect the complete
dmesg log and complete "sudo lspci -vv" output for both cases?  If
they're too big for email, you can open a report at
https://bugzilla.kernel.org and attach them there.

> > config differences
> > igpu33
> > # CONFIG_PCIEPORTBUS is not set
> > # CONFIG_PCI_IOV is not set
> > # CONFIG_VGA_ARB is not set
> > # CONFIG_HOTPLUG_PCI is not set
> > igpu32
> > CONFIG_PCIEPORTBUS=y
> > CONFIG_HOTPLUG_PCI_PCIE=y
> > CONFIG_PCIEAER=y
> > # CONFIG_PCIEAER_INJECT is not set
> > # CONFIG_PCIE_ECRC is not set
> > CONFIG_PCIE_PME=y
> > CONFIG_PCIE_DPC=y
> > # CONFIG_PCIE_EDR is not set
> > CONFIG_PCI_REALLOC_ENABLE_AUTO=y
> > # CONFIG_PCI_PF_STUB is not set
> > CONFIG_PCI_IOV=y
> > CONFIG_VGA_ARB=y
> > CONFIG_VGA_ARB_MAX_GPUS=16
> > CONFIG_HOTPLUG_PCI=y
> > CONFIG_HOTPLUG_PCI_ACPI=y
> > # CONFIG_HOTPLUG_PCI_ACPI_IBM is not set
> > CONFIG_HOTPLUG_PCI_CPCI=y
> > # CONFIG_HOTPLUG_PCI_CPCI_ZT5550 is not set
> > # CONFIG_HOTPLUG_PCI_CPCI_GENERIC is not set
> > CONFIG_HOTPLUG_PCI_SHPC=y
> > # CONFIG_RAPIDIO_TSI721 is not set
> > # CONFIG_EEEPC_LAPTOP is not set
> > 
> > lspci differences:
> > start with identical:
> > 00:00.0 Host bridge
> > 00:00.2 IOMMU
> > 00:01.0 Host bridge
> > 
> > kernel builds after igpu33 stable flags, only irq differences
> > kernel builds upto igpu32 flags differ including non-pcieport drivers,
> > there was a few builds where flags matched out of 32 different builds
> > I thought was normal that flags changed prior to 33-37 being very stable.
> > 
> > under 00:01.1 PCI bridge:
> > igpu33
> > Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> > DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> > RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible+
> > Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
> >  Address: 0000000000000000 Data: 0000
> > RootCmd: CERptEn- NFERptEn- FERptEn-
> > 
> > igpu32
> > Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> > Interrupt: pin ? routed to IRQ 26
> > DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
> > RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible+
> > Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
> >  Address: 00000000fee00000 Data: 0000
> > RootCmd: CERptEn+ NFERptEn+ FERptEn+
> > Kernel driver in use: pcieport
> > 
> > under these, nearly same readout as above (32vs33 use of pcieport)
> > 00:01.6 PCI bridge
> > 00:08.1 PCI bridge
> > 00:08.2 PCI bridge
> > 11:01.0 PCI bridge
> > 11:02.0 PCI bridge
> > 15:00.2 PCI bridge
> > 1d:00.0 PCI bridge
> > 1d:01.0 PCI bridge
> > 1d:04.0 PCI bridge
> > 1d:05.0 PCI bridge
> > 1d:06.0 PCI bridge
> > 1d:07.0 PCI bridge
> > 
> > on non-pcieport drivers minor differences in +- states
> > on nvme added line:
> > Physical Slot: 0
> > but +- state can change like others
> > 
> > dmesg differences (alphabetical):
> > igu33
> > acpi PNP0A08:00: PCIe port services disabled; not requesting _OSC control
> > igpu32
> > acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> > acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
> > acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug LTR]
> > amdgpu 0000:38:00.0: vgaarb: deactivate vga console
> > pci 0000:38:00.0: vgaarb: bridge control possible
> > pci 0000:38:00.0: vgaarb: setting as boot VGA device
> > pci 0000:38:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
> > pcieport 0000:00:01.1: AER: enabled with IRQ 26
> > pcieport 0000:00:01.1: PME: Signaling with IRQ 26
> > pcieport 0000:00:01.2: AER: enabled with IRQ 27
> > pcieport 0000:00:01.2: PME: Signaling with IRQ 27
> > pcieport 0000:00:01.6: AER: enabled with IRQ 28
> > pcieport 0000:00:01.6: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
> > pcieport 0000:00:01.6: PME: Signaling with IRQ 28
> > pcieport 0000:00:08.1: PME: Signaling with IRQ 29
> > pcieport 0000:00:08.2: PME: Signaling with IRQ 30
> > shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> > vgaarb: loaded
> > 
> > Steve
> > 
> > I wish to be personally CC'ed the answers/comments posted to the list
> > in response to your posting, please.
> -- 
> ~Randy
