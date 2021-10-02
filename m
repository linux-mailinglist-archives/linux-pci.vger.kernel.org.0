Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BCD41F992
	for <lists+linux-pci@lfdr.de>; Sat,  2 Oct 2021 06:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhJBEIm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 2 Oct 2021 00:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhJBEIm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 2 Oct 2021 00:08:42 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675A3C061775
        for <linux-pci@vger.kernel.org>; Fri,  1 Oct 2021 21:06:57 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 77-20020a9d0ed3000000b00546e10e6699so14004912otj.2
        for <linux-pci@vger.kernel.org>; Fri, 01 Oct 2021 21:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XzBmn1bjJscFKKYL1A9ROQRvwc4SqdMQKhoTf/C2Jfg=;
        b=WE4OYQKBdCdRy78wEAIhrywRu28dI9zQWmMS8F1szqZajB8i1euiLEB0R3dDGt/t1U
         g6nD2jh0A4HmDrayoOXt8jwtRUp3bxUXOn3uJJcMVuU7/WW3HwzDTbeEV8yvr/+xVRaG
         n+yBoFt45Lq5FtBSn2xCcYuj2yiVqBckfcewkV5wZN5e0wDGuLRNXZZFC/a9AMRx9OBM
         +K4eHUHY6PbHu0M9FT+qSjm18uffzPyzjPDZcogGtcNyUkxF5MdYJnlX+OSguZCm7LJT
         gAc9VWW22TMaLa2yGleXOW7NFo3fUcd94SqAnTAnteJvjdTrGYuyWuhTCPw7+AmImtx/
         +J6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XzBmn1bjJscFKKYL1A9ROQRvwc4SqdMQKhoTf/C2Jfg=;
        b=V19zPOWLSZARf8pilkGg17LuyauKbu+cbS1Mc1XI0FtQMpa8ncywwtyPGJe+7JlrfB
         VKPklPrTJzwAtU1r8ynUmluHt+SqXabMPvsKCdSbj7qeWOU1oWMd3ec9Cl41psU+6fxT
         D6S4Blu91VEBtYNX07KE1VVsl2JYTPYnLDedlWQ2Z11n+IggHMFsgSO5XbnITyXrDPlP
         2841RCinckcHh+YRea5i6Gv/a5Nzmnkb4m4k9druyVyWDCNf/na019Ro2GKkmDoLJgtL
         kKy9wxK+DgLiFhY8MVVguGu0A1FtK2l9NMG+c4YVKcSflqzXRON6VrfijuLa/+xjl37l
         GWfQ==
X-Gm-Message-State: AOAM53340kd7JgBiE0cyJcfP8jB3IdoIR9uzYZincaok/yRsSTQhAEtb
        R8nBt2AB1o588wpWHn/L+SV0Yvbly+TdjLS2Arf0/Tvc
X-Google-Smtp-Source: ABdhPJy4xOnRJhzEGoXj6bnvkWVaUem7E9ZZ9RW+1jTRWm1qH/ycvLv86qaPfrgZvvEi3V6uxrKVJp9EE6IuSJBLVaw=
X-Received: by 2002:a05:6830:2816:: with SMTP id w22mr1204256otu.351.1633147616748;
 Fri, 01 Oct 2021 21:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAHP4M8UqzA4ET2bDVuucQYMJk9Lk4WqRr-9xX8=6YWXFOBBNzw@mail.gmail.com>
 <20211001151322.GA408729@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20211001151322.GA408729@dhcp-10-100-145-180.wdc.com>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Sat, 2 Oct 2021 09:36:44 +0530
Message-ID: <CAHP4M8U-uGwZqqGk5Z9KP7w_hESgTtrAsSrwxFfCiLZOht1uYw@mail.gmail.com>
Subject: Re: None of the virtual/physical/bus address matches the (base) BAR-0 register
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks Keith.

Let's take a x86 world as of now, and let's say the physical address
(returned by virt_to_phys()) is 0661a070.
The pci address (as stated) is e2c20000.


Since the BAR0-region is of size 256 bytes, so the system-agent (as
per x86-terminology) will monitor the highest 24 bits of
address-lines, to sense a MMIO read/write, and then forward the
transaction to the corresponding pci bridge/device.

So, in the present case, would

a)
The system-agent sense address-lines A31-A8 value as 0661a07? If yes,
is it the system-agent that does the translation from 0661a070 =>
e2c20000, before finally forwarding the transaction to pci
bridge/device?

b)
The system-agent sense address-lines A31-A8 value as e2c2000 (and
simply forwards the transaction to pci bridge/device)? If yes,
who/what does the translation from 0661a070 =? e2c20000?


Meanwhile, I am also trying to learn how to do kernel-development for
statically linked modules (like pci).
That would help in a much better understanding of the things-flow :P


Thanks for the help.


Thanks and Regards,
Ajay

On Fri, Oct 1, 2021 at 8:43 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Fri, Oct 01, 2021 at 08:21:06PM +0530, Ajay Garg wrote:
> > Hi All.
> >
> > I have a SD/MMC reader over PCI, which displays the following (amongst
> > others) when we do "lspci -vv" :
> >
> > #########################################################
> > Region 0: Memory at e2c20000 (32-bit, non-prefetchable) [size=512]
> > #########################################################
> >
> > Above shows that e2c20000 is the physical (base-)address of BAR0.
> >
> > Now, in the device driver, I do the following :
> >
> > ########################################################
> > .....
> > struct pci_dev *ptr;
> > void __iomem *bar0_ptr;
> > ......
> >
> > ......
> > pci_request_region(ptr, 0, "ajay_sd_mmc_BAR0_region");
> > bar0_ptr = pci_iomap(ptr, 0, pci_resource_len(ptr, 0));
> >
> > printk("Base virtual-address = [%p]\n", bar0_ptr);
> > printk("Base physical-address = [%p]\n", virt_to_phys(bar0_ptr));
> > printk("Base bus-address = [%p]\n", virt_to_bus(bar0_ptr));
> >
> > I have removed error-checking, but I confirm that pci_request_region()
> > and pci_iomap calls are successful.
> >
> > Now, in the 3 printk's, none of the value is printed as e2c20000.
> > I was expecting that the 2nd result, of virt_to_phys() translation,
> > would be equal to the base-address of BAR0 register, as reported by
> > lspci.
> >
> >
> > What am I missing?
> > Will be grateful for pointers.
>
> The CPU address isn't always the same as the PCI address. For example,
> some memory resources are added via pci_add_resource_offset(), so the
> windows the host sees will be different than the ones the devices use.
