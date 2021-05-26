Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCDB3921B4
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 22:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbhEZVAN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 17:00:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233717AbhEZVAN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 May 2021 17:00:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0BAD6613D3;
        Wed, 26 May 2021 20:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622062721;
        bh=tca5jhJa+R66QtoXGvrvfr4L4lN/+LgPF3bkHUwVN64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IqpaWP4hrBZQWfPpeX+KY4vXPCZN4tFfh2wix4raRcP8uhvW1JskteRVnDJSFw7w7
         G9xVgaP4FSmFqG5AzxQdN7m1WapB4MVocpqD9PgP83oprYedT7dSjX4lqPk12UX3OR
         wFY20EHtmSxlfSY6/VWO5V8qW4dtBYoO2/87TwPR2V/UrKQiFsFJVRuviPLDI+jsH3
         AjYcAjb5auWc8GWImmHjpS0i+JCr7ioJNd6vImI1LqVbdUrKRFhOlnSwYuQrTkj7yv
         dvp6lHMd3gT+RPmXAo8D5Md+hspw2yEPNoPLUvDeA+WLbMybmPv4H4p5ZY5+fA605/
         EmL8gZwpaIeTw==
Date:   Wed, 26 May 2021 21:58:36 +0100
From:   Will Deacon <will@kernel.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, lorenzo.pieralisi@arm.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] Revert "arm64: PCI: Exclude ACPI "consumer"
 resources from host bridge windows"
Message-ID: <20210526205836.GA20320@willie-the-truck>
References: <20210510234020.1330087-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510234020.1330087-1-luzmaximilian@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 11, 2021 at 01:40:20AM +0200, Maximilian Luz wrote:
> The Microsoft Surface Pro X has host bridges defined as
> 
>     Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
>     Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
> 
>     Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
>     {
>         Name (RBUF, ResourceTemplate ()
>         {
>             Memory32Fixed (ReadWrite,
>                 0x60200000,         // Address Base
>                 0x01DF0000,         // Address Length
>                 )
>             WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
>                 0x0000,             // Granularity
>                 0x0000,             // Range Minimum
>                 0x0001,             // Range Maximum
>                 0x0000,             // Translation Offset
>                 0x0002,             // Length
>                 ,, )
>         })
>         Return (RBUF) /* \_SB_.PCI0._CRS.RBUF */
>     }
> 
> meaning that the memory resources aren't (explicitly) defined as
> "producers", i.e. host bridge windows.
> 
> Commit 8fd4391ee717 ("arm64: PCI: Exclude ACPI "consumer" resources from
> host bridge windows") introduced a check that removes such resources,
> causing BAR allocation failures later on:
> 
>     [ 0.150731] pci 0002:00:00.0: BAR 14: no space for [mem size 0x00100000]
>     [ 0.150744] pci 0002:00:00.0: BAR 14: failed to assign [mem size 0x00100000]
>     [ 0.150758] pci 0002:01:00.0: BAR 0: no space for [mem size 0x00004000 64bit]
>     [ 0.150769] pci 0002:01:00.0: BAR 0: failed to assign [mem size 0x00004000 64bit]
> 
> This eventually prevents the PCIe NVME drive from being accessible.
> 
> On x86 we already skip the check for producer/window due to some history
> with negligent firmware. It seems that Microsoft is intent on continuing
> that history on their ARM devices, so let's drop that check here too.
> 
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> ---
> 
> Please note: I am not sure if this is the right way to fix that, e.g. I
> don't know if any additional checks like on IA64 or x86 might be
> required instead, or if this might break things on other devices. So
> please consider this more as a bug report rather than a fix.
> 
> Apologies for the re-send, I seem to have unintentionally added a blank
> line before the subject.
> 
> ---
>  arch/arm64/kernel/pci.c | 14 --------------
>  1 file changed, 14 deletions(-)

Adding Lorenzo to cc, as he'll have a much better idea about this than me.

This is:

https://lore.kernel.org/r/20210510234020.1330087-1-luzmaximilian@gmail.com

Will
