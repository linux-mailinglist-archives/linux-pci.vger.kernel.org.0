Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96AD5C024F
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2019 11:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfI0J1y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Sep 2019 05:27:54 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34301 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfI0J1x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Sep 2019 05:27:53 -0400
Received: by mail-oi1-f194.google.com with SMTP id 83so4659938oii.1;
        Fri, 27 Sep 2019 02:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZuIpLrnmCtbTcNmkaVEbY5RnzH0IidLhv5Un+nLqG40=;
        b=mxfB3N/WFfH9s083hNl0XX8HIbZ5YYIx+4XHuwFFTNb+SrQQsNXMF20syn2hEIJZBE
         kWBXCPTttr7vFeXERNXQ0mgQjf5cvg5Mf3fHWilO6z0d4Yil2KpCM+htMvhlXXAt581c
         8zqhSp4HmRUschpuCvNHqbUzkNuh8bHt5KmUjPPk8t/l9QxGb7bLWqtBIZIPtBkkVsj5
         /x5Tj4zm/kV+nIBTU7u3aQrl5ntkvqG7Ng3GlFixDcJXTIGQv3bGYV/dnfONKRZw96xD
         JSovrFmFWkg8vr45yMQPgT2b0DgA2p21FoAtUXWCaK2B+nNaQjg4KR04Wme1lamORs/o
         Hviw==
X-Gm-Message-State: APjAAAX1Ar7eGHhI4IPLonp9i7mRXt2C2Iis4GY5prv84hEuw+leFbgP
        tE9rybnFmi289MVGYaaf/HD3uB0aXmh5uQyjEtk=
X-Google-Smtp-Source: APXvYqyyyy+Ihi6sqWQx+bGhqfv/SISJnOCsEM+Y5KRi52vFflrFO4JElgkqTh/Ae+rRbd5z58NlEhBeEk2bK1GHC4c=
X-Received: by 2002:aca:cdc7:: with SMTP id d190mr6076791oig.148.1569576472781;
 Fri, 27 Sep 2019 02:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190927002455.13169-1-robh@kernel.org> <20190927002455.13169-9-robh@kernel.org>
In-Reply-To: <20190927002455.13169-9-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 27 Sep 2019 11:27:41 +0200
Message-ID: <CAMuHMdVOJt9b4FQpKOytgA-GV3PUECZ7-GkwR=ma8w8P9RKJww@mail.gmail.com>
Subject: Re: [PATCH 08/11] of: Factor out #{addr,size}-cells parsing
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Marek Vasut <marek.vasut@gmail.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 27, 2019 at 2:25 AM Rob Herring <robh@kernel.org> wrote:
> From: Robin Murphy <robin.murphy@arm.com>
>
> In some cases such as PCI host controllers, we may have a "parent bus"
> which is an OF leaf node, but still need to correctly parse ranges from
> the point of view of that bus. For that, factor out variants of the
> "#addr-cells" and "#size-cells" parsers which do not assume they have a
> device node and thus immediately traverse upwards before reading the
> relevant property.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> [robh: don't make of_bus_n_{addr,size}_cells() public]
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
