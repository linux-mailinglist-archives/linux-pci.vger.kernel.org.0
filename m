Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9305769C8
	for <lists+linux-pci@lfdr.de>; Sat, 16 Jul 2022 00:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbiGOWSW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 18:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiGOWSV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 18:18:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164A312AA4
        for <linux-pci@vger.kernel.org>; Fri, 15 Jul 2022 15:18:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4B23B82E7F
        for <linux-pci@vger.kernel.org>; Fri, 15 Jul 2022 22:18:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16351C34115;
        Fri, 15 Jul 2022 22:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657923498;
        bh=ji4bB2+uHpVkvVNvuakvxVccsoYJCf4V/2iFWe9iE2E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EMR5v3HxD/E3Wc2b+yxuSGzHcOwmA8qzp2O3qDyb+SySq+D5kLoouqgkt+M9FC+3r
         P0/FifhnxhUeo7FyS4dHVkC13S+kdLVh21LrQ06jOVNw1X3+xbKYwTnK25W8rLhjMc
         e/zQ1lxNKVHwrGbLzpdkERSSWXTwXY+coL/lGvKyP06dbGyhUGPZNo/Wpcoh6sxBs1
         Lfa3HOtg8wrxsHwMoj/LHuJUJy0nwslW0EHKG5ZmSmOgGHOQAY85uBXhjDBG14phQ/
         mbXrE6hciPpFApz7VTRmB6wVICyBwpJfir3eChnAwwdlXgcqtH46mxSCyi2Dc7hFlG
         5uMDqYAeaLKOg==
Date:   Fri, 15 Jul 2022 17:18:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH V16 0/7] PCI: Loongson pci improvements and quirks
Message-ID: <20220715221816.GA1203890@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714124216.1489304-1-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 14, 2022 at 08:42:09PM +0800, Huacai Chen wrote:
> This patchset improves Loongson PCI controller driver and resolves some
> problems: LS2K/LS7A's PCI config space supports 1/2/4-bytes access, so
> the first patch use pci_generic_config_read()/pci_generic_config_write()
> for them; the second patch add ACPI init support which will be used by
> LoongArch; the third patch improves the mrrs quirk for LS7A chipset; The
> fourth patch add a new quirk for LS7A chipset to avoid poweroff/reboot
> failure, and the fifth patch add a new quirk for LS7A chipset to fix the
> multifunction devices' irq pin mappings.
> ...

> Huacai Chen, Tiezhu Yang and Jianmin Lv(6):
>  PCI/ACPI: Guard ARM64-specific mcfg_quirks
>  PCI: loongson: Use generic 8/16/32-bit config ops on LS2K/LS7A.
>  PCI: loongson: Add ACPI init support.
>  PCI: loongson: Don't access non-existant devices.
>  PCI: Add quirk for multifunction devices of LS7A.

I applied the above to pci/ctrl/loongson to get them out of the way.

>  PCI: loongson: Improve the MRRS quirk for LS7A.
>  PCI: Add quirk for LS7A to avoid reboot failure.

These touch core code in some sort of ugly ways and I'm still thinking
about them.
