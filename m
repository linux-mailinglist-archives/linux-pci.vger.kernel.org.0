Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB5553088E
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2019 08:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbfEaGcw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 May 2019 02:32:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfEaGcw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 May 2019 02:32:52 -0400
Received: from localhost (unknown [106.201.101.143])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51F4826455;
        Fri, 31 May 2019 06:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559284371;
        bh=oFP/SAJV+4Vb3UNWlxHUzFHUMIdfilBJY3UrKlBzR5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GToR4zeeVAd2EKPmME5kECg0EgfRINrTh6m1b1OFxqVCb/u5f7mwd7iPF/E+sQWEQ
         Wc8/8NL+Jf1Ibhv7sPBcaC8szot64JsZk7cY6sSTnkNgVOCXBMYj/dh7hfY2t330+i
         5R0HdYVc8bFjSuohKnVhv4Wns1WYghfoMNF/YYxg=
Date:   Fri, 31 May 2019 12:02:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Alan Mikhak <alan.mikhak@sifive.com>,
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
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
Subject: Re: [PATCH] PCI: endpoint: Add DMA to Linux PCI EP Framework
Message-ID: <20190531063247.GP15118@vkoul-mobl>
References: <1558650258-15050-1-git-send-email-alan.mikhak@sifive.com>
 <305100E33629484CBB767107E4246BBB0A6FAFFD@DE02WEMBXB.internal.synopsys.com>
 <CABEDWGxsQ9NXrN7W_8HVrXQBb9HiBd+d1dNfv+cXmoBpXQnLwA@mail.gmail.com>
 <305100E33629484CBB767107E4246BBB0A6FC308@DE02WEMBXB.internal.synopsys.com>
 <CABEDWGxL-WYz1BY7yXJ6eKULgVtKeo67XhgHZjvtm5Ka5foKiA@mail.gmail.com>
 <192e3a19-8b69-dfaf-aa5c-45c7087548cc@ti.com>
 <20190531050727.GO15118@vkoul-mobl>
 <d2d8a904-d796-f9f2-8f4a-61e857355a4f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2d8a904-d796-f9f2-8f4a-61e857355a4f@ti.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 31-05-19, 10:50, Kishon Vijay Abraham I wrote:
> Hi Vinod,
> 
> On 31/05/19 10:37 AM, Vinod Koul wrote:
> > Hi Kishon,
> > 
> > On 30-05-19, 11:16, Kishon Vijay Abraham I wrote:
> >> +Vinod Koul
> >>
> >> Hi,
> >>
> >> On 30/05/19 4:07 AM, Alan Mikhak wrote:
> >>> On Mon, May 27, 2019 at 2:09 AM Gustavo Pimentel
> >>> <Gustavo.Pimentel@synopsys.com> wrote:
> >>>>
> >>>> On Fri, May 24, 2019 at 20:42:43, Alan Mikhak <alan.mikhak@sifive.com>
> >>>> wrote:
> >>>>
> >>>> Hi Alan,
> >>>>
> >>>>> On Fri, May 24, 2019 at 1:59 AM Gustavo Pimentel
> >>>>> <Gustavo.Pimentel@synopsys.com> wrote:
> >>>>>>
> >>>>>> Hi Alan,
> >>>>>>
> >>>>>> This patch implementation is very HW implementation dependent and
> >>>>>> requires the DMA to exposed through PCIe BARs, which aren't always the
> >>>>>> case. Besides, you are defining some control bits on
> >>>>>> include/linux/pci-epc.h that may not have any meaning to other types of
> >>>>>> DMA.
> >>>>>>
> >>>>>> I don't think this was what Kishon had in mind when he developed the
> >>>>>> pcitest, but let see what Kishon was to say about it.
> >>>>>>
> >>>>>> I've developed a DMA driver for DWC PCI using Linux Kernel DMAengine API
> >>>>>> and which I submitted some days ago.
> >>>>>> By having a DMA driver which implemented using DMAengine API, means the
> >>>>>> pcitest can use the DMAengine client API, which will be completely
> >>>>>> generic to any other DMA implementation.
> >>
> >> right, my initial thought process was to use only dmaengine APIs in
> >> pci-epf-test so that the system DMA or DMA within the PCIe controller can be
> >> used transparently. But can we register DMA within the PCIe controller to the
> >> DMA subsystem? AFAIK only system DMA should register with the DMA subsystem.
> >> (ADMA in SDHCI doesn't use dmaengine). Vinod Koul can confirm.
> > 
> > So would this DMA be dedicated for PCI and all PCI devices on the bus?
> 
> Yes, this DMA will be used only by PCI ($patch is w.r.t PCIe device mode. So
> all endpoint functions both physical and virtual functions will use the DMA in
> the controller).
> > If so I do not see a reason why this cannot be using dmaengine. The use
> 
> Thanks for clarifying. I was under the impression any DMA within a peripheral
> controller shouldn't use DMAengine.

That is indeed a correct assumption. The dmaengine helps in cases where
we have a dma controller with multiple users, for a single user case it
might be overhead to setup dma driver and then use it thru framework.

Someone needs to see the benefit and cost of using the framework and
decide.

> > case would be memcpy for DMA right or mem to device (vice versa) transfers?
> 
> The device is memory mapped so it would be only memcopy.
> > 
> > Btw many driver in sdhci do use dmaengine APIs and yes we are missing
> > support in framework than individual drivers
> 
> I think dmaengine APIs is used only when the platform uses system DMA and not
> ADMA within the SDHCI controller. IOW there is no dma_async_device_register()
> to register ADMA in SDHCI with DMA subsystem.

We are looking it from the different point of view. You are looking for
dmaengine drivers in that (which would be in drivers/dma/) and I am
pointing to users of dmaengine in that.

So the users in mmc would be ones using dmaengine APIs:
$git grep -l dmaengine_prep_* drivers/mmc/

which tells me 17 drivers!

HTH
-- 
~Vinod
