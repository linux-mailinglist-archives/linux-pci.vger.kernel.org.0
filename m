Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4FF309AF
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2019 09:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbfEaHuL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 May 2019 03:50:11 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43751 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaHuL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 May 2019 03:50:11 -0400
Received: by mail-qt1-f196.google.com with SMTP id z24so10238728qtj.10;
        Fri, 31 May 2019 00:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GwaITjmEuTof6u7MeG3GyILN9L8qj0XaOeE2YibaLeg=;
        b=iPV7jVvzfu9YBzUX9T7bjvZwCOcxrN0Hd8HIWSZd5Uz2NGNBB5fhx0B2M35RsSUvBk
         6kDrnKeZ1nBvYxjBZB2uZDW6P/fLPFtRlEkT3tmPWZXCCqo5IzZIZt6nQj9V/zCi7QDX
         WO675+pXDp8uArx7zCW2LivpTvq1Flg3Kqs/DgS/pCrSKMfqlp+3IVWMSRpdnKI1BX8D
         G4UCNOEHXna9mGYk8Mn+VsXqnRrjr180ps8a2VHXypqqZqxQY7kvcp1Gk72uGrafZTFs
         3YotdQjKlqfm7yORpLJRKXEBne0LlO3KeF0NjdFcqGEYbXPRcd29PvNMWCWzYdYAijLy
         FEww==
X-Gm-Message-State: APjAAAX14/AWRBYMgE5giXl5h22Q2myejED9QTJTTSIO0wYpQKQrxtnw
        dmGZ18UPkAi4/838w+qKTAx1hENxPR2UGCodlTQ=
X-Google-Smtp-Source: APXvYqwQB/JhCGjqlpNaldYQoGI4yfCEZhY1gzjbw3cSbTwub4t7W4H0B3NZ9jqg8ZYIlsA2SYsCySbJzJJdaOlmM1Y=
X-Received: by 2002:aed:2bc1:: with SMTP id e59mr6984448qtd.7.1559289010013;
 Fri, 31 May 2019 00:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <1558650258-15050-1-git-send-email-alan.mikhak@sifive.com>
 <305100E33629484CBB767107E4246BBB0A6FAFFD@DE02WEMBXB.internal.synopsys.com>
 <CABEDWGxsQ9NXrN7W_8HVrXQBb9HiBd+d1dNfv+cXmoBpXQnLwA@mail.gmail.com>
 <305100E33629484CBB767107E4246BBB0A6FC308@DE02WEMBXB.internal.synopsys.com>
 <CABEDWGxL-WYz1BY7yXJ6eKULgVtKeo67XhgHZjvtm5Ka5foKiA@mail.gmail.com>
 <192e3a19-8b69-dfaf-aa5c-45c7087548cc@ti.com> <20190531050727.GO15118@vkoul-mobl>
 <d2d8a904-d796-f9f2-8f4a-61e857355a4f@ti.com> <20190531063247.GP15118@vkoul-mobl>
In-Reply-To: <20190531063247.GP15118@vkoul-mobl>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 31 May 2019 09:49:53 +0200
Message-ID: <CAK8P3a2jePe7Qfjciq4fdfngAudzCb-cai4fr3_BG_evnbjhvw@mail.gmail.com>
Subject: Re: [PATCH] PCI: endpoint: Add DMA to Linux PCI EP Framework
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Alan Mikhak <alan.mikhak@sifive.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "wen.yang99@zte.com.cn" <wen.yang99@zte.com.cn>,
        "kjlu@umn.edu" <kjlu@umn.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 31, 2019 at 8:32 AM Vinod Koul <vkoul@kernel.org> wrote:
> On 31-05-19, 10:50, Kishon Vijay Abraham I wrote:
> > On 31/05/19 10:37 AM, Vinod Koul wrote:
> > > On 30-05-19, 11:16, Kishon Vijay Abraham I wrote:
> > >>
> > >> right, my initial thought process was to use only dmaengine APIs in
> > >> pci-epf-test so that the system DMA or DMA within the PCIe controller can be
> > >> used transparently. But can we register DMA within the PCIe controller to the
> > >> DMA subsystem? AFAIK only system DMA should register with the DMA subsystem.
> > >> (ADMA in SDHCI doesn't use dmaengine). Vinod Koul can confirm.
> > >
> > > So would this DMA be dedicated for PCI and all PCI devices on the bus?
> >
> > Yes, this DMA will be used only by PCI ($patch is w.r.t PCIe device mode. So
> > all endpoint functions both physical and virtual functions will use the DMA in
> > the controller).
> > > If so I do not see a reason why this cannot be using dmaengine. The use
> >
> > Thanks for clarifying. I was under the impression any DMA within a peripheral
> > controller shouldn't use DMAengine.
>
> That is indeed a correct assumption. The dmaengine helps in cases where
> we have a dma controller with multiple users, for a single user case it
> might be overhead to setup dma driver and then use it thru framework.
>
> Someone needs to see the benefit and cost of using the framework and
> decide.

I think the main question is about how generalized we want this to be.
There are lots of difference PCIe endpoint implementations, and in
case of some licensable IP cores like the designware PCIe there are
many variants, as each SoC will do the implementation in a slightly
different way.

If we can have a single endpoint driver than can either have an
integrated DMA engine or use an external one, then abstracting that
DMA engine helps make the driver work more readily either way.

Similarly, there may be PCIe endpoint implementations that have
a dedicated DMA engine in them that is not usable for anything else,
but that is closely related to an IP core we already have a dmaengine
driver for. In this case, we can avoid duplication.

      Arnd
