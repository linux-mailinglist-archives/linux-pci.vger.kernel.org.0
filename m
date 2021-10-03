Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4128E41FF28
	for <lists+linux-pci@lfdr.de>; Sun,  3 Oct 2021 04:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhJCCHl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 2 Oct 2021 22:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhJCCHk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 2 Oct 2021 22:07:40 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F75C0613EC
        for <linux-pci@vger.kernel.org>; Sat,  2 Oct 2021 19:05:54 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id w206so16808402oiw.4
        for <linux-pci@vger.kernel.org>; Sat, 02 Oct 2021 19:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7C0b2cFCcna/0gouIocopgF7nydJ9yWQNLPlnlyqk3U=;
        b=gmE904g/PJu0hBIIKtyjE3F3uyVbRbFzIuo9J7gTs09Ac+xrxzHTf3RQsm77J0ZJwJ
         /GMH4NndA42MXCBjnnGdsiXhxa23SZxJqP+08CzUuNSKEeWQbcMTEOewJ5jp58x1cX9Q
         vCIRRx8hgXk12Ho2+WG/pfqH0wzRFqOeSiXi89fetgz/aOR0JVhgkPCdgG8F4I6l4Yo6
         SjN8Ez4RrlFXfOVgWOgBBFk4JmWyv/Iw16z/zSN7I4R9t1530Kq4eHoCUlFVNW1EBivH
         /VPsFJwi9RyGroXEc0+T/qOIsG1NNMpY8hKps/D69Dpg8TkOPaNZUCrbNX38p1RVtndr
         MC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7C0b2cFCcna/0gouIocopgF7nydJ9yWQNLPlnlyqk3U=;
        b=u7vg3kwZnH2uUb3ugV3ieqvl06z39sBbZ3A32jMviILBrNcZQU6gGB47TUZSlcgndy
         Z7TOx6C+wGprIi9R18HD+2Biz4uuTT6hWKSCygCIfmeGCf5tv5uR0L1lwpnA0uG6+TDh
         3rBHSGtsW2aD8jDuqT64s95GOi/n5lmGn0Kl0yFM7sGo6nDyS7YVFeEKy7D7NJVeWljm
         D9t7Z9IlcWohGnPo3HUagZOhHqBusi8LlyhA0ZPl2VuJSKd02boJQnMhq96hGaXQdHqp
         7F1mXX6WO8n/eFMRBlAccOc5BxosvdOekHv4HBhsUcur4wW3ZnzKq1lUAFd5Ets3cuFp
         YLEg==
X-Gm-Message-State: AOAM5316XRuy1D55TdknALbmfJCqfRrKs2e9jR7Dfb2Nm3TcW/qOt/iH
        ApPibKpdK8mNP1Vmq0oKMr/0OYOCaDAUGunpXRxBXDZm
X-Google-Smtp-Source: ABdhPJyPOqCFM6kLIAVdGZVUPjUvOGfQYeCcEZkeBNKLeQjKNXIVnky1glykPePgD5ohWttxlXNkmcqlqKDCpadfZDA=
X-Received: by 2002:a05:6808:1211:: with SMTP id a17mr9068878oil.91.1633226753619;
 Sat, 02 Oct 2021 19:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAHP4M8XszWK6eGEPvvAV0E3mJWhZZdZMb4CmUsQg6jRdoABWjw@mail.gmail.com>
 <20211002193311.GA977182@bhelgaas>
In-Reply-To: <20211002193311.GA977182@bhelgaas>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Sun, 3 Oct 2021 07:35:41 +0530
Message-ID: <CAHP4M8XzZCwKk3TGmHKVMdf5mkWKfafE75DEKBs6-t4ZPw-kaw@mail.gmail.com>
Subject: Re: None of the virtual/physical/bus address matches the (base) BAR-0 register
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

>
> I don't think these last two make any sense.  You're doing an MMIO
> read from the address bar0_ptr, so this value (0x721f4000001e) came
> from the PCI devices.  There's no reason to think it's a kernel
> virtual address, so you shouldn't call virt_to_phys() on it.

Got it, thanks !

>
> Yes.  You should not need to use virt_to_phys() for PCI MMIO
> addresses.

Hmm, the thing that started it all :P


>
> This path is IN the picture.  This is exactly the path used by drivers
> doing MMIO accesses.
>
> The CPU does a load from a virtual address (0xffffa0c6c02eb000).  The
> MMU translates that virtual address to a physical address
> (0xe2c20000).

Hmm, so I guess the core takeaway is that the virtual-address <=>
physical-address mapping is indeed happening as envisioned. It's just
that there is no programmatic way to prove/display the mapped physical
address, in the case of PCI-MMIO transfers (as virt_to_phys() is not
usable in this case).

May be, someday it will :)

  The PCI host bridge decodes that address and generates
> a PCIe Memory Read transaction to the bus address 0xe2c20000.
>
> Your dmesg log should have lines similar to this:
>
>   pci_bus 0000:00: root bus resource [mem 0x7f800000-0xefffffff window]
>   pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
>
> that show the parts of the CPU physical address space that result in
> MMIO to PCI devices.  0xe2c20000 should be inside one of those
> windows.
>

It indeed is, in one of the pci-bridge range.


Thanks a ton Bjorn, for taking out the time to provide help, taking
the particular program-values as per my run.
I am grateful for your patience; nature bless you !


Thanks and Regards,
Ajay
