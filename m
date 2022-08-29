Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439455A56DD
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 00:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiH2WO1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Aug 2022 18:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiH2WO0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Aug 2022 18:14:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5340A7D78B;
        Mon, 29 Aug 2022 15:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:Cc:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=5bh+6c/zBVS1U48Zom3Me0IcZEFs+/RPrgsPPRgOxVk=; b=mm03mYlIcQ7K8cuqTLwVw7ug27
        jOa21wzn+kG2i6trNc84diYwqHNrvT79eRpxqN0lfqEr5Agkx6uZqwA6bURsFIzGz+gFA3XI6ROXu
        gMDoF+jd/VVS1+QoO/JVYKRZq0vTVwIzOtfYDUDbo6rWMmdVvl8LIXObd83/6cTWJl+ABmsLdGnTL
        yeU/WvW7qxESpQo5UWQg7Hfg03YT852YXzKQDM14XAmMId8ytPqEiOhmG8cuZTdy5F9J3T11fKnRt
        7iSHv8B3tqRF00veRPHJz1XUAz2XPeKUNWgsEddUipTiYY7x0d/Z8ASAoRjQxFxcH9nwavstl/9WH
        7D6q2x1g==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oSn1T-00D2DE-Ot; Mon, 29 Aug 2022 22:14:23 +0000
Message-ID: <dd8fb085-76dc-f2b0-6101-f84c93b8a0af@infradead.org>
Date:   Mon, 29 Aug 2022 15:14:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: pcieport bug?
Content-Language: en-US
To:     Steven J Abner <pheonix.sja@att.net>, linux-kernel@vger.kernel.org
References: <TY1EHR.8720BA9PHAKY2.ref@att.net> <TY1EHR.8720BA9PHAKY2@att.net>
Cc:     PCI <linux-pci@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <TY1EHR.8720BA9PHAKY2@att.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[adding linux-pci mailing list]


On 8/29/22 10:59, Steven J Abner wrote:
> Hi
> Building a kernel tailored for AMD 2400g on ASRock B450 using 5.18.12 as base, OS
> is Elementary 6.1 on top of Ubuntu 20.04.5.
> In a config I changed some which lead to this query,'cause not sure what it means.
> So up to you see if it is of concern. Notation igpu# refers to build sequence tests.
> Also note that pcieport may affect other drivers?
> 
> config differences
> igpu33
> # CONFIG_PCIEPORTBUS is not set
> # CONFIG_PCI_IOV is not set
> # CONFIG_VGA_ARB is not set
> # CONFIG_HOTPLUG_PCI is not set
> igpu32
> CONFIG_PCIEPORTBUS=y
> CONFIG_HOTPLUG_PCI_PCIE=y
> CONFIG_PCIEAER=y
> # CONFIG_PCIEAER_INJECT is not set
> # CONFIG_PCIE_ECRC is not set
> CONFIG_PCIE_PME=y
> CONFIG_PCIE_DPC=y
> # CONFIG_PCIE_EDR is not set
> CONFIG_PCI_REALLOC_ENABLE_AUTO=y
> # CONFIG_PCI_PF_STUB is not set
> CONFIG_PCI_IOV=y
> CONFIG_VGA_ARB=y
> CONFIG_VGA_ARB_MAX_GPUS=16
> CONFIG_HOTPLUG_PCI=y
> CONFIG_HOTPLUG_PCI_ACPI=y
> # CONFIG_HOTPLUG_PCI_ACPI_IBM is not set
> CONFIG_HOTPLUG_PCI_CPCI=y
> # CONFIG_HOTPLUG_PCI_CPCI_ZT5550 is not set
> # CONFIG_HOTPLUG_PCI_CPCI_GENERIC is not set
> CONFIG_HOTPLUG_PCI_SHPC=y
> # CONFIG_RAPIDIO_TSI721 is not set
> # CONFIG_EEEPC_LAPTOP is not set
> 
> lspci differences:
> start with identical:
> 00:00.0 Host bridge
> 00:00.2 IOMMU
> 00:01.0 Host bridge
> 
> kernel builds after igpu33 stable flags, only irq differences
> kernel builds upto igpu32 flags differ including non-pcieport drivers,
> there was a few builds where flags matched out of 32 different builds
> I thought was normal that flags changed prior to 33-37 being very stable.
> 
> under 00:01.1 PCI bridge:
> igpu33
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible+
> Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
>  Address: 0000000000000000 Data: 0000
> RootCmd: CERptEn- NFERptEn- FERptEn-
> 
> igpu32
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> Interrupt: pin ? routed to IRQ 26
> DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
> RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible+
> Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>  Address: 00000000fee00000 Data: 0000
> RootCmd: CERptEn+ NFERptEn+ FERptEn+
> Kernel driver in use: pcieport
> 
> under these, nearly same readout as above (32vs33 use of pcieport)
> 00:01.6 PCI bridge
> 00:08.1 PCI bridge
> 00:08.2 PCI bridge
> 11:01.0 PCI bridge
> 11:02.0 PCI bridge
> 15:00.2 PCI bridge
> 1d:00.0 PCI bridge
> 1d:01.0 PCI bridge
> 1d:04.0 PCI bridge
> 1d:05.0 PCI bridge
> 1d:06.0 PCI bridge
> 1d:07.0 PCI bridge
> 
> on non-pcieport drivers minor differences in +- states
> on nvme added line:
> Physical Slot: 0
> but +- state can change like others
> 
> dmesg differences (alphabetical):
> igu33
> acpi PNP0A08:00: PCIe port services disabled; not requesting _OSC control
> igpu32
> acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
> acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug LTR]
> amdgpu 0000:38:00.0: vgaarb: deactivate vga console
> pci 0000:38:00.0: vgaarb: bridge control possible
> pci 0000:38:00.0: vgaarb: setting as boot VGA device
> pci 0000:38:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
> pcieport 0000:00:01.1: AER: enabled with IRQ 26
> pcieport 0000:00:01.1: PME: Signaling with IRQ 26
> pcieport 0000:00:01.2: AER: enabled with IRQ 27
> pcieport 0000:00:01.2: PME: Signaling with IRQ 27
> pcieport 0000:00:01.6: AER: enabled with IRQ 28
> pcieport 0000:00:01.6: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
> pcieport 0000:00:01.6: PME: Signaling with IRQ 28
> pcieport 0000:00:08.1: PME: Signaling with IRQ 29
> pcieport 0000:00:08.2: PME: Signaling with IRQ 30
> shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> vgaarb: loaded
> 
> Steve
> 
> I wish to be personally CC'ed the answers/comments posted to the list
> in response to your posting, please.
> 
> 
> 
> 
> 
> 

-- 
~Randy
