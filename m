Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4221048C718
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 16:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbiALPUc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 10:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354682AbiALPTQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 10:19:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EFAC061212;
        Wed, 12 Jan 2022 07:19:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FE756166E;
        Wed, 12 Jan 2022 15:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE727C36AEB;
        Wed, 12 Jan 2022 15:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642000745;
        bh=fu0y6HF2w9TR9UC8AShHx0a+nQwyM62xkR4YrWTstSg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pG79wT9c/OQjU93VDoiJbr9aAubWS+bLRBbM3HIh+++enJ7Y6z9jc49LKf4f/IxHA
         pJgWvogXr42P86dH6qUACX7HC9f6/YfIfPuB0y//5G5Ue1rW8M0cYuue0Pgz2+KaMk
         EHSD0GG5AHUF6jxn3hqcfQ9tN1IVBJwPc5N70o/QhLcZG9gwfMGCDX3tvEHV5prJy/
         urRoeo3WjwaYrm9mbgkuvRzY7+msPtGSoBImOo4V1cCc3SsvtyxZTRxKk+ibPl5OZk
         wzb68qRa+mezIUEEUr5CMj33kkvFcOHVZkDRcQrK9XG8rbDqywtapitODOaTxaOOaJ
         m9HvqXksWL6vw==
Date:   Wed, 12 Jan 2022 09:19:03 -0600
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
Message-ID: <20220112151903.GA257550@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <013cc25a-d460-49eb-8cc0-8f59a0c5a45e@www.fastmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 12, 2022 at 12:57:44PM +0000, Jiaxun Yang wrote:
> 在2022年1月11日一月 下午9:46，Bjorn Helgaas写道：
> > [-cc many, +cc iproc, loongson, tegra maintainers]
> >
> > On Tue, Jul 21, 2020 at 08:25:14PM -0600, Rob Herring wrote:
> >> The majority of DT based host drivers use the default .map_irq() and
> >> .swizzle_irq() functions, so let's initialize the function pointers to
> >> the default and drop setting them in the host drivers.
> >> 
> >> Drivers like iProc which don't support legacy interrupts need to set
> >> .map_irq() back to NULL.
> >
> > Probably a dumb question...
> >
> > This patch removed all the ->swizzle_irq users in drivers/pci/, which
> > is great -- IIUC swizzling is specified by the PCI-to-PCI Bridge Spec,
> > r1.2, sec 9.1, and should not be device-specific.  I assume the few
> > remaining arch/ users (arm and alpha) are either bugs or workarounds
> > for broken devices.
> >
> > My question is why we still have a few users of ->map_irq: loongson,
> > tegra, iproc.  Shouldn't this mapping be described somehow via DT?
> 
> For Loongson we are describing IRQ map in DT for newer platforms.
> But for legacy platforms (AMD RS780E North Bridge) with i8259 irqchip,
> we need to read PCI IRQ registers to get mapping information.
> 
> It is not known until boot time, so we have to use map_irq callback.

I see these:

  Documentation/devicetree/bindings/pci/loongson.yaml
  arch/mips/boot/dts/loongson/rs780e-pch.dtsi

which makes me think there are Loongson systems with DT.  Are there
some Loongson systems with DT and some legacy ones without?

The only driver I see is drivers/pci/controller/pci-loongson.c.  Is
that used for all Loongson system?  It unconditionally uses ->map_irq
= loongson_map_irq().

loongson_map_irq() reads PCI_INTERRUPT_LINE; I think that depends on
firmware having previously programmed it, right?

Bjorn
