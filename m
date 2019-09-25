Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA77BDE1A
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2019 14:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfIYMds (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Sep 2019 08:33:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbfIYMds (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Sep 2019 08:33:48 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E51CF214D9
        for <linux-pci@vger.kernel.org>; Wed, 25 Sep 2019 12:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569414828;
        bh=S0OrKaNGyI7miKcAbsKkAI+PcBOyiQjsvgRplH/VDqw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eRxpEohqKHmIhxjJm7exIF0yXeHlVGVt9kR88jA91C6GzDYJ6euGKRlDr3Sssif9K
         ukENO9Qe3wlZREEQKAAkS/xUPiR6mILEZQfWFUsrcSs+xuejWUQqbX9L5gY4Nhf1Lz
         b1YhZvtb4WUPZYvtB14nguCVgF0BGa4lsABYdxQM=
Received: by mail-qk1-f169.google.com with SMTP id f16so5057448qkl.9
        for <linux-pci@vger.kernel.org>; Wed, 25 Sep 2019 05:33:47 -0700 (PDT)
X-Gm-Message-State: APjAAAVtngr7VMHwgyMS8V0LUcpDsTD8V+SIB3yD8RQhbYhxlMri3MnG
        X+Egpu9XdwmaD6UOJl+KStpQ9HgW/BHKOGrLlQ==
X-Google-Smtp-Source: APXvYqy+VpYHMrr0wwSi/PfiGlcOuazbCBbOD42iktFq7hAvyqzObahXJTnQcyL704BO/ru4JPY6Qp1tigUlCnAJsFY=
X-Received: by 2002:a05:620a:12d5:: with SMTP id e21mr3321791qkl.152.1569414827046;
 Wed, 25 Sep 2019 05:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190924214630.12817-1-robh@kernel.org> <20190924214630.12817-3-robh@kernel.org>
 <20190925102423.GR9720@e119886-lin.cambridge.arm.com>
In-Reply-To: <20190925102423.GR9720@e119886-lin.cambridge.arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 25 Sep 2019 07:33:35 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKN709cOLtDLdKXmDzeNLYtGekMT2BiZic4x45UopenwA@mail.gmail.com>
Message-ID: <CAL_JsqKN709cOLtDLdKXmDzeNLYtGekMT2BiZic4x45UopenwA@mail.gmail.com>
Subject: Re: [PATCH 02/11] PCI: altera: Use pci_parse_request_of_pci_ranges()
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ley Foon Tan <lftan@altera.com>, rfi@lists.rocketboards.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 25, 2019 at 5:24 AM Andrew Murray <andrew.murray@arm.com> wrote:
>
> On Tue, Sep 24, 2019 at 04:46:21PM -0500, Rob Herring wrote:
> > Convert altera host bridge to use the common
> > pci_parse_request_of_pci_ranges().
> >
> > Cc: Ley Foon Tan <lftan@altera.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: rfi@lists.rocketboards.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---

> > @@ -833,9 +800,8 @@ static int altera_pcie_probe(struct platform_device *pdev)
> >               return ret;
> >       }
> >
> > -     INIT_LIST_HEAD(&pcie->resources);
> > -
> > -     ret = altera_pcie_parse_request_of_pci_ranges(pcie);
> > +     ret = pci_parse_request_of_pci_ranges(dev, &pcie->resources,
>
> Does it matter that we now map any given IO ranges whereas we didn't
> previously?
>
> As far as I can tell there are no users that pass an IO range, if they
> did then with the existing code the probe would fail and they'd get
> a "I/O range found for %pOF. Please provide an io_base pointer...".
> However with the new code if any IO range was given (which would
> probably represent a misconfiguration), then we'd proceed to map the
> IO range. When that IO is used, who knows what would happen.

Yeah, I'm assuming that the DT doesn't have an IO range if IO is not
supported. IMO, it is not the kernel's job to validate the DT.

> I wonder if there is a better way for a host driver to indicate that
> it doesn't support IO?

We can probably test for this in the schema.

ranges:
  items:
    minItems: 7
    items:
      - not: { const: 0x01000000 }

Or "- enum: [ 0x42000000, 0x02000000 ]"

Of course, in theory, the bus, dev, fn fields could be non-zero and we
could use minium/maximum to handle those, but in practice I think they
are rarely used for FDT.

Rob
