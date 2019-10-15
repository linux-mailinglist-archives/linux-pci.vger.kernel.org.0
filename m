Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB2F4D74BF
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 13:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfJOLRg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 07:17:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:55322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbfJOLRg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Oct 2019 07:17:36 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BFF721835
        for <linux-pci@vger.kernel.org>; Tue, 15 Oct 2019 11:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571138255;
        bh=oJs4Nz/w5KcJqHZkCZCLIDvyah4l8VweCXBAgTjhNYs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b32Cjb9nv5iuC2edc5oLuv0kNikzaqCU+laPpIrHyWfA8edNBRj1164v0Qeu5TZMV
         0HSmF28RcGMyGbff/ShNudJDFleGB1X4fqOU0hmQCS4/tzdj69jEUTxZC1RhnA7D4i
         98hOmbzOfncbKIOuXNIoFEX/G4MYJ+zTiy4ETvxo=
Received: by mail-qt1-f175.google.com with SMTP id u40so29892182qth.11
        for <linux-pci@vger.kernel.org>; Tue, 15 Oct 2019 04:17:35 -0700 (PDT)
X-Gm-Message-State: APjAAAVoir63jJwtyqRhvHRr58ONMyxpVFevE/25Rc8Ammm5uxq52yOV
        USWNkkBCIwAh4WH23FQxNkTln4ZDr9NBc0ScVA==
X-Google-Smtp-Source: APXvYqxZBQjXM06pV3GgKICK1b1Wdn//r19XqyM/3vYWnaPxKSp5jNZnSkfg00Qy9v7U1ZTrW9FlkUNkrdvCpYUlXGI=
X-Received: by 2002:ac8:6782:: with SMTP id b2mr37959337qtp.143.1571138254502;
 Tue, 15 Oct 2019 04:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190924214630.12817-1-robh@kernel.org> <20190924214630.12817-3-robh@kernel.org>
 <20190925102423.GR9720@e119886-lin.cambridge.arm.com> <CAL_JsqKN709cOLtDLdKXmDzeNLYtGekMT2BiZic4x45UopenwA@mail.gmail.com>
 <20190930151346.GD42880@e119886-lin.cambridge.arm.com> <CAL_Jsq+3S7+E+a5E122aR7s0a9SxkMyxw2t=OkO4pS5QUR+0CA@mail.gmail.com>
 <20191015110254.GA5160@e121166-lin.cambridge.arm.com>
In-Reply-To: <20191015110254.GA5160@e121166-lin.cambridge.arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 15 Oct 2019 06:17:22 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJwmiUZmJSmRU4RAecKd=Zw+vGKGrHZ4UXrAwOGCNMF5g@mail.gmail.com>
Message-ID: <CAL_JsqJwmiUZmJSmRU4RAecKd=Zw+vGKGrHZ4UXrAwOGCNMF5g@mail.gmail.com>
Subject: Re: [PATCH 02/11] PCI: altera: Use pci_parse_request_of_pci_ranges()
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Andrew Murray <andrew.murray@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ley Foon Tan <lftan@altera.com>, rfi@lists.rocketboards.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 15, 2019 at 6:03 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Mon, Sep 30, 2019 at 12:36:22PM -0500, Rob Herring wrote:
> > On Mon, Sep 30, 2019 at 10:13 AM Andrew Murray <andrew.murray@arm.com> wrote:
> > >
> > > On Wed, Sep 25, 2019 at 07:33:35AM -0500, Rob Herring wrote:
> > > > On Wed, Sep 25, 2019 at 5:24 AM Andrew Murray <andrew.murray@arm.com> wrote:
> > > > >
> > > > > On Tue, Sep 24, 2019 at 04:46:21PM -0500, Rob Herring wrote:
> > > > > > Convert altera host bridge to use the common
> > > > > > pci_parse_request_of_pci_ranges().
> > > > > >
> > > > > > Cc: Ley Foon Tan <lftan@altera.com>
> > > > > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > > > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > > > Cc: rfi@lists.rocketboards.org
> > > > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > > > ---
> > > >
> > > > > > @@ -833,9 +800,8 @@ static int altera_pcie_probe(struct platform_device *pdev)
> > > > > >               return ret;
> > > > > >       }
> > > > > >
> > > > > > -     INIT_LIST_HEAD(&pcie->resources);
> > > > > > -
> > > > > > -     ret = altera_pcie_parse_request_of_pci_ranges(pcie);
> > > > > > +     ret = pci_parse_request_of_pci_ranges(dev, &pcie->resources,
> > > > >
> > > > > Does it matter that we now map any given IO ranges whereas we didn't
> > > > > previously?
> > > > >
> > > > > As far as I can tell there are no users that pass an IO range, if they
> > > > > did then with the existing code the probe would fail and they'd get
> > > > > a "I/O range found for %pOF. Please provide an io_base pointer...".
> > > > > However with the new code if any IO range was given (which would
> > > > > probably represent a misconfiguration), then we'd proceed to map the
> > > > > IO range. When that IO is used, who knows what would happen.
> > > >
> > > > Yeah, I'm assuming that the DT doesn't have an IO range if IO is not
> > > > supported. IMO, it is not the kernel's job to validate the DT.
> > >
> > > Sure. Is it worth mentioning in the commit message this subtle change
> > > in behaviour?
> >
> > Will do.
>
> Hi Rob,
>
> I would like to merge this series, are you resending it ? It does not
> apply to v5.4-rc1, if you rebase it please also update this patch
> log, as per comments above (I can do it too but if you resend it
> there is no point).

Yes, I plan to resend it.

Rob
