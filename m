Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1914B4B2C16
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 18:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352332AbiBKRvA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Feb 2022 12:51:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352330AbiBKRvA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Feb 2022 12:51:00 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A452FCEC;
        Fri, 11 Feb 2022 09:50:57 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59F281042;
        Fri, 11 Feb 2022 09:50:57 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B0AC3F70D;
        Fri, 11 Feb 2022 09:50:56 -0800 (PST)
Date:   Fri, 11 Feb 2022 17:50:45 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/11] PCI: mvebu: subsystem ids, AER and INTx
Message-ID: <20220211175029.GA2300@lpieralisi>
References: <20220105150239.9628-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220105150239.9628-1-pali@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 05, 2022 at 04:02:28PM +0100, Pali Rohár wrote:
> This patch series extends pci-bridge-emul.c driver to emulate PCI Subsystem
> Vendor ID capability and PCIe extended capabilities. And then implement
> in pci-mvebu.c driver support for PCI Subsystem Vendor IDs, PCIe AER
> registers, support for legacy INTx interrupts, configuration for X1/X4
> mode and usage of new PCI child_ops API.
> 
> This patch series depends on other pci-mvebu and pci-bridge-emul patches from:
> https://lore.kernel.org/linux-pci/20220104153529.31647-1-pali@kernel.org/
Hi Pali,

I went through the series quickly and I don't think there is anything
controversial, posted some minor comments. Do not repost yet, I will
be back at v5.17-rc5 and work towards merging it for v5.18.

Lorenzo

> 
> Pali Rohár (9):
>   PCI: pci-bridge-emul: Add support for PCI Bridge Subsystem Vendor ID
>     capability
>   dt-bindings: PCI: mvebu: Add num-lanes property
>   PCI: mvebu: Correctly configure x1/x4 mode
>   PCI: mvebu: Add support for PCI Bridge Subsystem Vendor ID on emulated
>     bridge
>   PCI: mvebu: Add support for Advanced Error Reporting registers on
>     emulated bridge
>   PCI: mvebu: Use child_ops API
>   dt-bindings: PCI: mvebu: Update information about intx interrupts
>   PCI: mvebu: Implement support for legacy INTx interrupts
>   ARM: dts: armada-385.dtsi: Add definitions for PCIe legacy INTx
>     interrupts
> 
> Russell King (2):
>   PCI: pci-bridge-emul: Re-arrange register tests
>   PCI: pci-bridge-emul: Add support for PCIe extended capabilities
> 
>  .../devicetree/bindings/pci/mvebu-pci.txt     |  16 +
>  arch/arm/boot/dts/armada-385.dtsi             |  52 ++-
>  drivers/pci/controller/pci-mvebu.c            | 352 +++++++++++++++---
>  drivers/pci/pci-bridge-emul.c                 | 167 ++++++---
>  drivers/pci/pci-bridge-emul.h                 |  17 +
>  5 files changed, 494 insertions(+), 110 deletions(-)
> 
> -- 
> 2.20.1
> 
