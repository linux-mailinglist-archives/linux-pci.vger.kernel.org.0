Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8974A325D
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jan 2022 23:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353123AbiA2WeG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Jan 2022 17:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243417AbiA2WeG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Jan 2022 17:34:06 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 282C3C061714
        for <linux-pci@vger.kernel.org>; Sat, 29 Jan 2022 14:34:06 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 4E85792009C; Sat, 29 Jan 2022 23:34:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 4823E92009B;
        Sat, 29 Jan 2022 22:34:03 +0000 (GMT)
Date:   Sat, 29 Jan 2022 22:34:03 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 19/19] PCI: Set bridge map_irq and swizzle_irq to default
 functions
In-Reply-To: <20220111214608.GA169999@bhelgaas>
Message-ID: <alpine.DEB.2.21.2201220459090.58572@angie.orcam.me.uk>
References: <20220111214608.GA169999@bhelgaas>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 11 Jan 2022, Bjorn Helgaas wrote:

> This patch removed all the ->swizzle_irq users in drivers/pci/, which
> is great -- IIUC swizzling is specified by the PCI-to-PCI Bridge Spec,
> r1.2, sec 9.1, and should not be device-specific.  I assume the few
> remaining arch/ users (arm and alpha) are either bugs or workarounds
> for broken devices.

 I skimmed over the Alpha stuff and it seems to mostly care about setting 
the slot value returned differently and defers to `pci_common_swizzle' for 
actual pin determination.  This could be moderately easy to sort out.

 One exception is `takara_swizzle' which looks incomplete to me; as this 
is a PICMG device[1] someone would have to fill in the missing details as 
AFAICT the PICMG connector is supposed to provide all the INT# A-D lines 
and then routing is done on the backplane using binding defined by PICMG.

 According to DEC documentation there's an alternative interrupt routing 
mode available too, using a external interrupt controller FPGA placed on 
the backplane[2], where no swizzling is done and instead each of the four 
INT# lines across all the PCI slots, up to 16, provided by a backplane is 
individually routed to 64 inputs of the interrupt controller.

 There is a paper by DEC available online[3] that could help filling in 
the missing details for either mode, especially someone who has access to 
such a system and could verify it in reality.

References:

[1] "DIGITAL 21164 PICMG SBC, User Information for the EBM21 and EBM23",
    V1.0, Digital Equipment Corporation, June 1997, Part Number: 
    EK-A0937-UG. A01

[2] "DIGITAL Modular Computing Components, OEM Information for DMCC 
    Backplanes", Version 4.1, Compaq Computer Corporation, January 1999, 
    Order Number: EK-A0929-TM. C01

[3] Ross L. Armstrong, "PCI Interrupt Controller for Industry Standard 
    PCI-ISA Bus Architecture using PCI-to-PCI Bridge Technology", Digital 
    Equipment Corporation (Scotland) Ltd., 1996

 FWIW,

  Maciej
