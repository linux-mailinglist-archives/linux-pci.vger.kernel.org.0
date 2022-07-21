Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EFC57D502
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 22:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbiGUUqP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 16:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbiGUUqN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 16:46:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3ED18F523;
        Thu, 21 Jul 2022 13:46:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88F8B60C38;
        Thu, 21 Jul 2022 20:46:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B2DC3411E;
        Thu, 21 Jul 2022 20:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658436370;
        bh=VQEWtXe/A0L9a7Q3acg4i1U73avpZGLjwzCLwILH3Xk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=En9QMtV3/2r65guGCZgrhlhS4Ox21QDxnKqJRoWWrIL2xFdZBHOoTyF2+nDF3XB5O
         B9f78KCJJ4rFjSqTRMaIJnrRgEtHEoGxiTDgknJGDcpseSHF+zsbimoE17+l5K/Cni
         mON8bPCD/ehzxc6x7J1+71ZruhVFsM2c08DFvyZPbxVX7R/roRmYkaDj0xulYwUCZu
         MLl9aEExdPLmthI4HlcRPewV+C1F3gArSj+H4zqYRmjkj/8PRc3rmTKQYFWVyTNDQx
         ZjsXnPIUz3Y0KIf0apFieXzWNjS3WMaS5jJZR4BsW/j/sDpQ5OiFa8DbfT15Czz5Wd
         Drs7B1ArZwsow==
Received: by pali.im (Postfix)
        id 81BED22EF; Thu, 21 Jul 2022 22:46:07 +0200 (CEST)
Date:   Thu, 21 Jul 2022 22:46:07 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        linux-pci@vger.kernel.org, Tom Joseph <tjoseph@cadence.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Why set .suppress_bind_attrs even though .remove() implemented?
Message-ID: <20220721204607.xklzyklbgwcgepjm@pali>
References: <20220721195433.GA1747571@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721195433.GA1747571@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On Thursday 21 July 2022 14:54:33 Bjorn Helgaas wrote:
> The j721e, kirin, tegra, and mediatek drivers all implement .remove().
> 
> They also set ".suppress_bind_attrs = true".  I think this means
> bus_add_driver() will not create the "bind" and "unbind" sysfs
> attributes for the driver that would allow users to users to manually
> attach and detach devices from it.
> 
> Is there a reason for this, or should these drivers stop setting
> .suppress_bind_attrs?

I have already asked this question during review of kirin driver:
https://lore.kernel.org/linux-pci/20211031205527.ochhi72dfu4uidii@pali/

Microchip driver wanted to change its type from bool to tristate
https://lore.kernel.org/linux-pci/20220420093449.38054-1-u.kleine-koenig@pengutronix.de/t/#u
and after discussion it seems that it is needed to do more work for this
driver.

> For example, Pali and Ley Foon *did* stop setting .suppress_bind_attrs
> when adding .remove() methods in these commits:
> 
>   0746ae1be121 ("PCI: mvebu: Add support for compiling driver as module")
>   526a76991b7b ("PCI: aardvark: Implement driver 'remove' function and allow to build it as module")
>   ec15c4d0d5d2 ("PCI: altera: Allow building as module")
> 
> Bjorn

I added it for both pci-mvebu.c and pci-aardvark.c. And just few days
ago I realized why suppress_bind_attrs was set to true and remove method
was not implemented.

Implementing remove method is not really simple, specially when pci
controller driver implements also interrupt controller (e.g. for
handling legacy interrupts).

Here are waiting fixup patches for pci-mvebu.c and pci-aardvark.c which
fixes .remove callback. Without these patches calling 'rmmod driver' let
dangling pointer in kernel which may cause random kernel crashes. See:

https://lore.kernel.org/linux-pci/20220709161858.15031-1-pali@kernel.org/
https://lore.kernel.org/linux-pci/20220711120626.11492-1-pali@kernel.org/
https://lore.kernel.org/linux-pci/20220711120626.11492-2-pali@kernel.org/

So I would suggest to do more detailed review when adding .remove
callback for pci controller driver (or when remove suppress_bind_attrs)
and do more testings and checking if all IRQ mappings are disposed.
