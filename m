Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 969B23147F
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2019 20:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfEaSQ7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 May 2019 14:16:59 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34298 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfEaSQ7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 May 2019 14:16:59 -0400
Received: by mail-lj1-f193.google.com with SMTP id j24so10538166ljg.1
        for <linux-pci@vger.kernel.org>; Fri, 31 May 2019 11:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mMKtgmWbW8xYAGhBwAG4c8b4zuI5g6VzqZjp1pMjfUg=;
        b=TSgZ8KSuC8Uh58feLuA2QmX3LpgiOCKvOAfRY8zwRYZZsWEog8DDbJslbbYif12yFl
         9QxkArhnQZY7+fOQo4Tk7jI6vHsOtddSAbU/CiK4w9329KysTnC1NMLUI3PJLpkKoYBd
         vHlK890XEuNv6cYqTLxqksKmYyl9sTMpSMmy3HAlGhPDq+C9s8cVpkezs8LcrrbvnQNu
         /zS3BaFkKBxPF1Q3rn6mOjMyMFSX2mxYbhgEew3wRsL2GOScavdE+SbI9WTP1c/X3Gof
         4VLgMOU7ffGPB+HUW115BIIw9JvtIpssUl6Q2lLuWT7c5CrtiJHS5cM2PQdMJWbb1Jz8
         e2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mMKtgmWbW8xYAGhBwAG4c8b4zuI5g6VzqZjp1pMjfUg=;
        b=nQO6WkDpAiVcZbqdO/J1DM1Aw0a0v2RBvYVTJOpu1F/t2sydNMvxcTrUdVzXKhQg2p
         rUAbvv6+FrRI0l2yOZe0SYcckQXxwWCgIge6FT22cO/LezSPIr3ZxCE0WnaRKh1Yp8qC
         tZxeZRFn3V0b0jsWVhzOtAOTEHrXpj87Xi3blF2Hk4sbOdTcp+/1n3wqf9N+xR5MqxFc
         VEWWmQ2ehpQTKX5BRdbcnm/Q5rHOY4YmWj9DLCCpLmKLqhEx+6WZAP5bvz+T1wZ+iaqD
         5dbgOjG3UX4VURA9s/yZf57VVYKZ2qvDZySUiImRfbipIA1j2CjPmZDkz7Y3DhlOMltr
         zP1Q==
X-Gm-Message-State: APjAAAWmq3qSbWh8Xz7ziDHOtQ3+kTi2siW92V+4smcN8KhenC8lMC0W
        Su/evZsCkrModmYozDyaeF4S0ey4IFVZVq+6+/l2Kg==
X-Google-Smtp-Source: APXvYqxtHw0FLL/5LL6+uKZaUo8UTHEM9pyFRWVXtoz6RHQ9WnvCDZHxV3XOVaoKoFIbWWrVdMOLUlR3ZRO8fhjVXzQ=
X-Received: by 2002:a2e:80d5:: with SMTP id r21mr6619039ljg.43.1559326617481;
 Fri, 31 May 2019 11:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <1558650258-15050-1-git-send-email-alan.mikhak@sifive.com>
 <305100E33629484CBB767107E4246BBB0A6FAFFD@DE02WEMBXB.internal.synopsys.com>
 <CABEDWGxsQ9NXrN7W_8HVrXQBb9HiBd+d1dNfv+cXmoBpXQnLwA@mail.gmail.com>
 <305100E33629484CBB767107E4246BBB0A6FC308@DE02WEMBXB.internal.synopsys.com>
 <CABEDWGxL-WYz1BY7yXJ6eKULgVtKeo67XhgHZjvtm5Ka5foKiA@mail.gmail.com>
 <192e3a19-8b69-dfaf-aa5c-45c7087548cc@ti.com> <CABEDWGxLeD-K8PjkD5hPSTFGJKs2hxEaAVO+nE5eC9Nx2yw=ig@mail.gmail.com>
 <75d578c2-a98c-d1ef-1633-6dc5dc3b0913@ti.com>
In-Reply-To: <75d578c2-a98c-d1ef-1633-6dc5dc3b0913@ti.com>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Fri, 31 May 2019 11:16:46 -0700
Message-ID: <CABEDWGxBxmiKjoPUSUaUBXUhKkUTXVX0U9ooRou8tcWJojb52g@mail.gmail.com>
Subject: Re: [PATCH] PCI: endpoint: Add DMA to Linux PCI EP Framework
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "wen.yang99@zte.com.cn" <wen.yang99@zte.com.cn>,
        "kjlu@umn.edu" <kjlu@umn.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 30, 2019 at 10:08 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> Hi Alan,
> >
> > Hi Kishon,
> >
> > I have some improvements in mind for a v2 patch in response to
> > feedback from Gustavo Pimentel that the current implementation is HW
> > specific. I hesitate from submitting a v2 patch because it seems best
> > to seek comment on possible directions this may be taking.
> >
> > One alternative is to wait for or modify test functions in
> > pci-epf-test.c to call DMAengine client APIs, if possible. I imagine
> > pci-epf-test.c test functions would still allocate the necessary local
> > buffer on the endpoint side for the same canned tests for everyone to
> > use. They would prepare the buffer in the existing manner by filling
> > it with random bytes and calculate CRC in the case of a write test.
> > However, they would then initiate DMA operations by using DMAengine
> > client APIs in a generic way instead of calling memcpy_toio() and
> > memcpy_fromio(). They would post-process the buffer in the existing
>
> No, you can't remove memcpy_toio/memcpy_fromio APIs. There could be platforms
> without system DMA or they could have system DMA but without MEMCOPY channels
> or without DMA in their PCI controller.

I agree. I wouldn't remove memcpy_toio/fromio. That is the reason this
patch introduces the '-d' flag for pcitest to communicate that user
intent across the PCIe bus to pci-epf-test so the endpoint can
initiate the transfer using either memcpy_toio/fromio or DMA.

> > manner such as the checking for CRC in the case of a read test.
> > Finally, they would release the resources and report results back to
> > the user of pcitest across the PCIe bus through the existing methods.
> >
> > Another alternative I have in mind for v2 is to change the struct
> > pci_epc_dma that this patch added to pci-epc.h from the following:
> >
> > struct pci_epc_dma {
> >         u32     control;
> >         u32     size;
> >         u64     sar;
> >         u64     dar;
> > };
> >
> > to something similar to the following:
> >
> > struct pci_epc_dma {
> >         size_t  size;
> >         void *buffer;
> >         int flags;
> > };
> >
> > The 'flags' field can be a bit field or separate boolean values to
> > specify such things as linked-list mode vs single-block, etc.
> > Associated #defines would be removed from pci-epc.h to be replaced if
> > needed with something generic. The 'size' field specifies the size of
> > DMA transfer that can fit in the buffer.
>
> I still have to look closer into your DMA patch but linked-list mode or single
> block mode shouldn't be an user select-able option but should be determined by
> the size of transfer.

Please consider the following when taking a closer look at this patch.

In my specific use case, I need to verify that any valid block size,
including a one byte transfer, can be transferred across the PCIe bus
by memcpy_toio/fromio() or by DMA either as a single block or as
linked-list. That is why, instead of deciding based on transfer size,
this patch introduces the '-L' flag for pcitest to communicate the
user intent across the PCIe bus to pci-epf-test so the endpoint can
initiate the DMA transfer using a single block or in linked-list mode.

When user issues 'pcitest -r' to perform a read buffer test,
pci-epf-test calls pci_epf_test_write() which uses memcpy_toio(). As
before, a read from the user point of view is a write from the
endpoint point of view.
When user issues 'pcitest -r -d', pci-epf-test calls a new function
pci_epf_test_write_dma() to initiate a single block DMA transfer.
When user issues 'pcitest -r -d -L', pci-epf-test calls a new function
pci_epf_test_write_dma_list() to initiate a linked-list DMA transfer.

The '-d' and '-L' flags also apply to the '-w' flag when the user
performs a write buffer test. The user can specify any valid transfer
size for any of the above examples using the '-s' flag as before.

> > That way the dma test functions in pci-epf-test.c can simply kmalloc
> > and prepare a local buffer on the endpoint side for the DMA transfer
> > and pass its pointer down the stack using the 'buffer' field to lower
> > layers. This would allow different PCIe controller drivers to
> > implement DMA or not according to their needs. Each implementer can
> > decide to use DMAengine client API, which would be preferable, or
> > directly read or write to DMA hardware registers to suit their needs.
>
> yes, that would be my preferred method as well. In fact I had implemented
> pci_epf_tx() in [1], as a way for pci-epf-test to pass buffer address to
> endpoint controller driver. I had also implemented helpers for platforms using
> system DMA (i.e uses DMAengine).
>
> Thanks
> Kishon
>
> [1] ->
> http://git.ti.com/cgit/cgit.cgi/ti-linux-kernel/ti-linux-kernel.git/tree/drivers/pci/endpoint/pci-epf-core.c?h=ti-linux-4.19.y
> >
> > I would appreciate feedback and comment on such choices as part of this review.

Thanks for all your comments and providing the link to your
implementation of pci_epf_tx() in [1] above. It clarifies a lot and
provides a very useful reference.

Regards,
Alan Mikhak
