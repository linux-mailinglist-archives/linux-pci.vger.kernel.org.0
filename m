Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47E6F336FB
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2019 19:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbfFCRms (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jun 2019 13:42:48 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46368 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfFCRmr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jun 2019 13:42:47 -0400
Received: by mail-lj1-f194.google.com with SMTP id m15so8762842ljg.13
        for <linux-pci@vger.kernel.org>; Mon, 03 Jun 2019 10:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BS0Zh3jyjSb17eotilocZwY1GzUHeKUqjyq+4Kft1pQ=;
        b=NLVEIvLReVVSzUzdDGbor2dZ8ubeUlpmhNjUd82WAFgUKIBO7BoTaJIz44rPbkJPrM
         JJz4js2fDKmejIAwjlAnvQUcKyHnNvReqS52dXsAbD52WeR9RocU/fFCzu8ITS9tQb+D
         sjdkFNrjpp4ImFYc4Kuo0V3DKMhlkSDsj4aV0PqjKBhap8WtjQEFx4oGPrufWt9qZt13
         IDkqSzV1VP9Tf7KZJTXe3BxwI+so/wNAIi1UwJ/LM5p+TAe/TOZwfJ7kqtY5LqqbxW1q
         FsUPRQuHOQNPJr0m9+/rAnq/VlACSBwzANEDY+HFEiaFoP6z/PllCBlxwNNdkyJvoWe+
         4odQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BS0Zh3jyjSb17eotilocZwY1GzUHeKUqjyq+4Kft1pQ=;
        b=ACAzv6FIZeiVhykBT/Ub3ittFqopw7uE2m6wE4RkjgfkxJADJegUEfQWwcwHUKfYrK
         Db9T6rfnlUt2/nbYRRkM8WADTIriYgTDaBygy+FYPFHbpGZwExleRAWXp+AWXEfzQJuG
         waFPSg7hbzKfZ/iymDok1g/oAls17cc9ug997SJNJFCtkAnEZcyng//W1M+FfaacaA58
         Q8aPI3xlfeId58YKPz58L0KV6fzrTqFbTPZhbDVJEreNTj4vTmH1Ta7obV93zlRISYIf
         koFpIfVgQSIVaghAo8rT5EchyV7+krWVPN/v4i+ZLpb39/rhj2hgUJsSb4zzx9b+KzM6
         f+sg==
X-Gm-Message-State: APjAAAXrHPCsv78OPSBUstsbvj4GyIMrWJIHKV8DCfpp+4Q3+bZCx7Qw
        GvmhIn3OL2EY61iPg9pLPa4BKdhzkCki11bwUV2Cwg==
X-Google-Smtp-Source: APXvYqy7436P4CRHoCyJ2XXuGEbIzmE7qmlHxfIe0H476OtQDIN20Vza1a6fj3+LTeOrwhyyTraNzBYtaxJteM56H8U=
X-Received: by 2002:a2e:8587:: with SMTP id b7mr14668645lji.101.1559583766018;
 Mon, 03 Jun 2019 10:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <1558650258-15050-1-git-send-email-alan.mikhak@sifive.com>
 <305100E33629484CBB767107E4246BBB0A6FAFFD@DE02WEMBXB.internal.synopsys.com>
 <CABEDWGxsQ9NXrN7W_8HVrXQBb9HiBd+d1dNfv+cXmoBpXQnLwA@mail.gmail.com>
 <305100E33629484CBB767107E4246BBB0A6FC308@DE02WEMBXB.internal.synopsys.com>
 <CABEDWGxL-WYz1BY7yXJ6eKULgVtKeo67XhgHZjvtm5Ka5foKiA@mail.gmail.com>
 <192e3a19-8b69-dfaf-aa5c-45c7087548cc@ti.com> <CABEDWGxLeD-K8PjkD5hPSTFGJKs2hxEaAVO+nE5eC9Nx2yw=ig@mail.gmail.com>
 <75d578c2-a98c-d1ef-1633-6dc5dc3b0913@ti.com> <CABEDWGxBxmiKjoPUSUaUBXUhKkUTXVX0U9ooRou8tcWJojb52g@mail.gmail.com>
 <6e692ff6-e64f-e651-c8ae-34d0034ad7b9@ti.com>
In-Reply-To: <6e692ff6-e64f-e651-c8ae-34d0034ad7b9@ti.com>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Mon, 3 Jun 2019 10:42:34 -0700
Message-ID: <CABEDWGx2N66L=27JY6Ywbfny78UaxENkxBTqxU37PfuQO-ZMZw@mail.gmail.com>
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

On Sun, Jun 2, 2019 at 9:43 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> Hi Alan,
> On 31/05/19 11:46 PM, Alan Mikhak wrote:
> > On Thu, May 30, 2019 at 10:08 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> >> Hi Alan,
> >>> Hi Kishon,
> >>
> >> I still have to look closer into your DMA patch but linked-list mode or single
> >> block mode shouldn't be an user select-able option but should be determined by
> >> the size of transfer.
> >
> > Please consider the following when taking a closer look at this patch.
>
> After seeing comments from Vinod and Arnd, it looks like the better way of
> adding DMA support would be to register DMA within PCI endpoint controller to
> DMA subsystem (as dmaengine) and use only dmaengine APIs in pci_epf_test.

Thanks Kishon. That makes it clear where these pieces should go.

> > In my specific use case, I need to verify that any valid block size,
> > including a one byte transfer, can be transferred across the PCIe bus
> > by memcpy_toio/fromio() or by DMA either as a single block or as
> > linked-list. That is why, instead of deciding based on transfer size,
> > this patch introduces the '-L' flag for pcitest to communicate the
> > user intent across the PCIe bus to pci-epf-test so the endpoint can
> > initiate the DMA transfer using a single block or in linked-list mode.
> The -L option seems to select an internal DMA configuration which might be
> specific to one implementation. As Gustavo already pointed, we should have only
> generic options in pcitest. This would no longer be applicable when we move to
> dmaengine.

Single-block DMA seemed as generic as linked-list DMA and
memcpy_toio/fromio. It remains unclear how else to communicate that
intent to pci_epf_test each time I invoke pcitest.

Regards,
Alan
