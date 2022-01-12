Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003D648CD79
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 22:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbiALVKp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 16:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbiALVKn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 16:10:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481FAC06173F;
        Wed, 12 Jan 2022 13:10:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12A86B820E0;
        Wed, 12 Jan 2022 21:10:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DFBC36AEC;
        Wed, 12 Jan 2022 21:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642021840;
        bh=SCZfVDR/DICg7y5IJblkJMpx8rF2UrcotY0FTQsBNIM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OtZhi9pUdFOilXiB6ELZse0nJGGd5JwmUVEL9PMrHkaJagrI5ox4Q49dF+QKh6Woj
         IijpluplthICPpbrTyxLyA1l/zN+T2kHTIYSWY+cj7E3B6LjLX/wi3ycN0ytrGsaYn
         9B+vbNoHhbQPE8wQ6EJTAvEgFm9KXMXO0wN+brStXb8afQtECWAdv5vNSItGcdJ+f1
         pKXIUirQGZldwdD0JWYIvSuLQ3GRJ+geylot0obCONi9OztVsM3G0n9wk1r7+Gza7s
         HZnDufyqVRVVg3kP8W5CnnUJ3ENynAtCPToEkCWoMR6GWQoCH+djE5aZ6JA5JNLNeL
         5DYQMUsfOBVVw==
Date:   Wed, 12 Jan 2022 15:10:39 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 19/19] PCI: Set bridge map_irq and swizzle_irq to default
 functions
Message-ID: <20220112211039.GA281591@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84d849b5-9386-4db5-87fe-34de3d6c487b@www.fastmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 12, 2022 at 08:08:45PM +0000, Jiaxun Yang wrote:
> 在2022年1月12日一月 下午3:19，Bjorn Helgaas写道：
> > On Wed, Jan 12, 2022 at 12:57:44PM +0000, Jiaxun Yang wrote:
> >> 在2022年1月11日一月 下午9:46，Bjorn Helgaas写道：
> >> > [-cc many, +cc iproc, loongson, tegra maintainers]
> [...]
> > I see these:
> >
> >   Documentation/devicetree/bindings/pci/loongson.yaml
> >   arch/mips/boot/dts/loongson/rs780e-pch.dtsi
> >
> > which makes me think there are Loongson systems with DT.  Are there
> > some Loongson systems with DT and some legacy ones without?
> 
> Actually all present MIPS/Loongson systems are legacy and we just
> built-in DTs in kernel and select which one to use at boot time. 

So I guess you know enough about what platform it is to select which
DT to use, but you don't know enough to know the I8259 routing?

If you *could* select a DT that described the I8259 routing, I guess
maybe you could select a matching DT or update a DT in-place?

> > The only driver I see is drivers/pci/controller/pci-loongson.c.
> > Is that used for all Loongson system?  It unconditionally uses
> > ->map_irq = loongson_map_irq().
> 
> Yes, it's used among all Loongson systems.  For system using LS7A
> PCH the IRQ mapping is fixed so we just programmed it in DT. For
> RS780E we use this routine to read PCI_INTERRUPT_LINE to select
> which I8259 IRQ to use.
> 
> > loongson_map_irq() reads PCI_INTERRUPT_LINE; I think that depends
> > on firmware having previously programmed it, right?
> 
> I'm unclear about what did firmware do but as AMD RS780E is used in
> x86 PCs as well it should be the same way.

PCI devices don't use the value in PCI_INTERRUPT_LINE, and the spec
doesn't define a default value.  It's only for use by software.

I'm pretty sure that on ACPI x86, we don't depend on
PCI_INTERRUPT_LINE except for things like quirks.

I think the ACPI MADT and _PRT are supposed to contain all the INTx
routing information we need.  Obviously this isn't an ACPI system.
I'm just making the point that it *should* be possible to remove this
dependency on firmware if we can identify the specific platform (which
determines the I8259 routing).

Bjorn
