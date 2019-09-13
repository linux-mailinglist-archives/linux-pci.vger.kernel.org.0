Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B455B24B0
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2019 19:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388211AbfIMRkE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Sep 2019 13:40:04 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33193 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388025AbfIMRkD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Sep 2019 13:40:03 -0400
Received: by mail-lf1-f67.google.com with SMTP id d10so22748494lfi.0
        for <linux-pci@vger.kernel.org>; Fri, 13 Sep 2019 10:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n/8TaZzU4/Xd0tjzBKZmUfSDILX2IFr4ta9frYs5Xs0=;
        b=SG0DRyf5kA6SfAWvLtYPpTznmt8fjufKkkzVymJlQgIOKEaXvEH993F6f5kACbN+Yz
         lQ59k1nNDgSMthjqAKWH0SnAOgMLOYCbaMK3He6s/3UrpVFl+fAcnwMUonRXg/N0V+vO
         LarcEqtWjc5HfRN9gtzoUpOdxFRF8Qwzk5gLh3zTcV9n00M6tKYglOrhOIALZHi1DdoV
         El/q3LbxaktFwDSOnnGv+Xol4RPbrjoB1LdYe4fVBNmNKd7TZvsHOtNY6YkSRO5SAD7J
         SksemlJhD2EzSXR8Z7pX7rHudvXcWTv6xul2cxLZ99PC43CGMv+oBnAWf56mQ0EJorqj
         fpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n/8TaZzU4/Xd0tjzBKZmUfSDILX2IFr4ta9frYs5Xs0=;
        b=M5T6UGHtKwQOsM/M08H37vVEHD6wGfiuSeJQslfhMawpCVTymWrdXGcjGU3BPB02hM
         paldFJk2GONkIptVv2T4cIRE37l+Xz4/EnibkSRszc2PYn//emIs7g2wFaW59qimKrcI
         WySqCaxGbnf969IZFazOM0Sf3SRKQS9bjzRGVSE08i2E6BQ/Ha1x4TtTbHFdZwBKh6zG
         r/Rm/V4XsWChy03zkuyLsll8VKPzoTHWO5PsUt2oG3mT/HKKinTGLTKYH3lKnMakNiuK
         W2L3RftXFlVJRAbAb1I1rXP758S/AdQ/L5MVQce1wAlwOhyaKC9uYzUY0dgh0QA1u/W4
         w+og==
X-Gm-Message-State: APjAAAVDNOVbSm3SfKz/RVHwJM4DJ8jjauZaEJD1xploX1UW0a943Mmy
        He6SmLCclOQkPrfxhdffavrhO1Q72YufIiUdfjpxSg==
X-Google-Smtp-Source: APXvYqyXa+N3QbXmZxivySXywHwcEIuvcRBkkU+lKWn7Lej6OFrBl0P0SWOoL1lQNIXYqbqvQ88ld/TUvWmVy+4lYxY=
X-Received: by 2002:a19:ac0c:: with SMTP id g12mr32149008lfc.128.1568396401610;
 Fri, 13 Sep 2019 10:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <1558650258-15050-1-git-send-email-alan.mikhak@sifive.com>
 <305100E33629484CBB767107E4246BBB0A6FAFFD@DE02WEMBXB.internal.synopsys.com>
 <CABEDWGxsQ9NXrN7W_8HVrXQBb9HiBd+d1dNfv+cXmoBpXQnLwA@mail.gmail.com>
 <305100E33629484CBB767107E4246BBB0A6FC308@DE02WEMBXB.internal.synopsys.com>
 <CABEDWGxL-WYz1BY7yXJ6eKULgVtKeo67XhgHZjvtm5Ka5foKiA@mail.gmail.com>
 <192e3a19-8b69-dfaf-aa5c-45c7087548cc@ti.com> <CABEDWGxLeD-K8PjkD5hPSTFGJKs2hxEaAVO+nE5eC9Nx2yw=ig@mail.gmail.com>
 <75d578c2-a98c-d1ef-1633-6dc5dc3b0913@ti.com> <CABEDWGxBxmiKjoPUSUaUBXUhKkUTXVX0U9ooRou8tcWJojb52g@mail.gmail.com>
 <6e692ff6-e64f-e651-c8ae-34d0034ad7b9@ti.com> <CABEDWGx2N66L=27JY6Ywbfny78UaxENkxBTqxU37PfuQO-ZMZw@mail.gmail.com>
 <40fafe93-d2dd-b1f5-bc16-cd84ff07bd13@ti.com>
In-Reply-To: <40fafe93-d2dd-b1f5-bc16-cd84ff07bd13@ti.com>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Fri, 13 Sep 2019 10:39:50 -0700
Message-ID: <CABEDWGy3VdH40QAz5NVhQHLLXXf2C5W22uUXEw3yCeNz0hfF-Q@mail.gmail.com>
Subject: Re: [PATCH] PCI: endpoint: Add DMA to Linux PCI EP Framework
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Haotian Wang <haotian.wang@sifive.com>, haotian.wang@duke.edu,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
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

On Fri, Sep 13, 2019 at 5:11 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> + Haotian Wang
>
> On 03/06/19 11:12 PM, Alan Mikhak wrote:
> > On Sun, Jun 2, 2019 at 9:43 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> >> Hi Alan,
> >> On 31/05/19 11:46 PM, Alan Mikhak wrote:
> >>> On Thu, May 30, 2019 at 10:08 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> >>>> Hi Alan,
> >>>>> Hi Kishon,
> >>>>
> >>>> I still have to look closer into your DMA patch but linked-list mode or single
> >>>> block mode shouldn't be an user select-able option but should be determined by
> >>>> the size of transfer.
> >>>
> >>> Please consider the following when taking a closer look at this patch.
> >>
> >> After seeing comments from Vinod and Arnd, it looks like the better way of
> >> adding DMA support would be to register DMA within PCI endpoint controller to
> >> DMA subsystem (as dmaengine) and use only dmaengine APIs in pci_epf_test.
> >
> > Thanks Kishon. That makes it clear where these pieces should go.
> >
> >>> In my specific use case, I need to verify that any valid block size,
> >>> including a one byte transfer, can be transferred across the PCIe bus
> >>> by memcpy_toio/fromio() or by DMA either as a single block or as
> >>> linked-list. That is why, instead of deciding based on transfer size,
> >>> this patch introduces the '-L' flag for pcitest to communicate the
> >>> user intent across the PCIe bus to pci-epf-test so the endpoint can
> >>> initiate the DMA transfer using a single block or in linked-list mode.
> >> The -L option seems to select an internal DMA configuration which might be
> >> specific to one implementation. As Gustavo already pointed, we should have only
> >> generic options in pcitest. This would no longer be applicable when we move to
> >> dmaengine.
> >
> > Single-block DMA seemed as generic as linked-list DMA and
> > memcpy_toio/fromio. It remains unclear how else to communicate that
> > intent to pci_epf_test each time I invoke pcitest.
> >
> > Regards,
> > Alan
> >

Hi Kishon,

FYI, I integrated your changes for DMAengine client support to PCI
endpoint framework into my development branch. The following is the
link you provided earlier as reference. I have been using it with good
results. Haotian Wang also used it in a recent patch for PCI endpoint
function for virtnet. Would you be able to comment on if and when your
DMAengine client support may be submitted upstream?

http://git.ti.com/cgit/cgit.cgi/ti-linux-kernel/ti-linux-kernel.git/tree/drivers/pci/endpoint/pci-epf-core.c?h=ti-linux-4.19.y

Regards,
Alan Mikhak
