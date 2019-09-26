Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44B89BF3C8
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2019 15:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbfIZNL3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Sep 2019 09:11:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfIZNL3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Sep 2019 09:11:29 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BD3C222BE
        for <linux-pci@vger.kernel.org>; Thu, 26 Sep 2019 13:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569503488;
        bh=tT5vM+GZhNbV0tvTup56SJvx/nMnMTGW90qmtz76n+M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bFsirGxmtIM1FIlYEIsCNNuaL1b7vAPENm3IeCnfYIxhh9K3sz6YoinrjPGJy0pfX
         LVjVJQT4+uNrFCAJcAz/aV8Lit+syYgHjPqqoggm+++hhwVSBtnXMrpSMgnBZoPCCK
         H6Pu5dVMQqs8TQdNIou4MVtdmNGPSfOTBhauiAhQ=
Received: by mail-qt1-f175.google.com with SMTP id u22so2699816qtq.13
        for <linux-pci@vger.kernel.org>; Thu, 26 Sep 2019 06:11:28 -0700 (PDT)
X-Gm-Message-State: APjAAAXJwmZ4h6A1Qux9Ati27rDITyhAJN3xoIVHwjCRKV5GQObWkZPj
        8CkwCkLusMyBxAGMztKErlNJEgPrxGzLtzF6Hg==
X-Google-Smtp-Source: APXvYqz2YmZPtaxfDUNbuK9E+BoLaBgNiFLl5CUOshw+4r3CboxK8fvajywPHBid9YklNqM1bpfDj//EaGOnnTYP31s=
X-Received: by 2002:ac8:6982:: with SMTP id o2mr3793298qtq.143.1569503487451;
 Thu, 26 Sep 2019 06:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190924214630.12817-1-robh@kernel.org> <20190926084859.GB9720@e119886-lin.cambridge.arm.com>
 <036f298c-c65c-7da2-92dc-fc80892672c1@free.fr>
In-Reply-To: <036f298c-c65c-7da2-92dc-fc80892672c1@free.fr>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 26 Sep 2019 08:11:16 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLtYYXCgGN6_t8SuPqPmQwhhRJXaf8+kxnKxLHbRQRaDQ@mail.gmail.com>
Message-ID: <CAL_JsqLtYYXCgGN6_t8SuPqPmQwhhRJXaf8+kxnKxLHbRQRaDQ@mail.gmail.com>
Subject: Re: [PATCH 00/11] PCI dma-ranges parsing consolidation
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Andrew Murray <andrew.murray@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mans Rullgard <mans@mansr.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 26, 2019 at 6:20 AM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>
> [ Tweaking recipients list ]
>
> On 26/09/2019 10:49, Andrew Murray wrote:
>
> > On Tue, Sep 24, 2019 at 04:46:19PM -0500, Rob Herring wrote:
> >
> >> pci-rcar-gen2 is the only remaining driver doing its own dma-ranges
> >> handling as it is still using the old ARM PCI functions. Looks like it
> >> is the last one (in drivers/pci/).
> >
> > It also seems that pcie-tango is using of_pci_dma_range_parser_init
> > and so parsing dma-ranges. Though it's using the dma_ranges for a
> > slightly different purpose.

Seems I missed that as I only grep'ed for for_each_of_pci_range...

>
> The rationale for that code can be found here:
>
>         https://patchwork.kernel.org/patch/9915469/
>
> NB: 1) The PCIE_TANGO_SMP8759 Kconfig symbol is marked "depends on BROKEN",
> and 2) The driver adds TAINT_CRAP,
> and 3) The maker of the tango platform is dead.

Given that and that I'd have to rework the probe to do the MSI range
setup after pci_host_common_probe, I'm just going to leave this one
alone.

Rob
