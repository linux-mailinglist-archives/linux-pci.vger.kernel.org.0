Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6041E2522
	for <lists+linux-pci@lfdr.de>; Tue, 26 May 2020 17:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgEZPNF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 11:13:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728205AbgEZPNF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 May 2020 11:13:05 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDDE12078C;
        Tue, 26 May 2020 15:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590505984;
        bh=mLAN8D6oIJoa3xggwgfTsbQUrUGKyiAShX7jqMOfqpQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TwwVC+24PxfZ9n8pI3uZo1gP7BUT14m+GVWVUjEuzJ19b989LBWKZjSDjv/kPV1ex
         L6uQJSmJPjTj8IXOAE5zqwykadOzOqlPyc4fH9x/KqRNyGBVD62xdvunQ1MvXvKizj
         2XBl6a+OPGFq6NlEgOuIG4xeKo2Nm0kKRMRoalz8=
Received: by mail-oi1-f179.google.com with SMTP id j145so18969007oib.5;
        Tue, 26 May 2020 08:13:04 -0700 (PDT)
X-Gm-Message-State: AOAM531+aFI0HyQnJlBo0CYWapiZsZzGwyXGu/0pWcg16srZRy5Ken2n
        yiH5UP3Jxvshw3ntVYqbrJ6QpB8gK0fyrf6zJg==
X-Google-Smtp-Source: ABdhPJxnWdsB33/h+eNDJFncCR1n3OmMuD+wbzq8824aW+7RwYNdy8Fq+5CjchUFaYrWK3vesXy9roYP9HkRJfjTDcY=
X-Received: by 2002:aca:f084:: with SMTP id o126mr14928427oih.106.1590505984103;
 Tue, 26 May 2020 08:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200522033631.32574-1-kishon@ti.com> <20200522033631.32574-4-kishon@ti.com>
 <CAL_JsqJjXUUgTbSAi83w4Eie-sVTrkLLMGh_PRQsd8k2vuua4Q@mail.gmail.com> <df29309d-8401-4040-eb1e-90bb3af93a82@ti.com>
In-Reply-To: <df29309d-8401-4040-eb1e-90bb3af93a82@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 26 May 2020 09:12:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLy9T8O81stSW8RHpsUXFFjon80VG9-Jgync1eVR4iTew@mail.gmail.com>
Message-ID: <CAL_JsqLy9T8O81stSW8RHpsUXFFjon80VG9-Jgync1eVR4iTew@mail.gmail.com>
Subject: Re: [PATCH v5 03/14] PCI: cadence: Convert all r/w accessors to
 perform only 32-bit accesses
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        linux-omap <linux-omap@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, May 24, 2020 at 9:30 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi Rob,
>
> On 5/22/2020 9:24 PM, Rob Herring wrote:
> > On Thu, May 21, 2020 at 9:37 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> >>
> >> Certain platforms like TI's J721E using Cadence PCIe IP can perform only
> >> 32-bit accesses for reading or writing to Cadence registers. Convert all
> >> read and write accesses to 32-bit in Cadence PCIe driver in preparation
> >> for adding PCIe support in TI's J721E SoC.
> >
> > Looking more closely I don't think cdns_pcie_ep_assert_intx is okay
> > with this and never can be given the PCI_COMMAND and PCI_STATUS
> > registers are in the same word (IIRC, that's the main reason 32-bit
> > config space accesses are broken). So this isn't going to work at
>
> right, PCI_STATUS has write '1' to clear bits and there's a chance that it
> could be reset while raising legacy interrupt. While this cannot be avoided for
> TI's J721E, other platforms doesn't have to have this limitation.
> > least for EP accesses. And maybe you need a custom .raise_irq() hook
> > to minimize any problems (such as making the RMW atomic at least from
> > the endpoint's perspective).
>
> This is to make sure EP doesn't update in-consistent state when RC is updating
> the PCI_STATUS register? Since this involves two different systems, how do we
> make this atomic?

You can't make it atomic WRT both systems, but is there locking around
each RMW? Specifically, are preemption and interrupts disabled to
ensure time between a read and write are minimized? You wouldn't want
interrupts disabled during the delay too though (i.e. around
.raise_irq()).

BTW, I've asked this question before, but aren't PCI legacy interrupts
level triggered? If so, isn't generating a pulse wrong?

Rob
