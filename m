Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61681D7423
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 13:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfJOLDA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 07:03:00 -0400
Received: from foss.arm.com ([217.140.110.172]:35542 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbfJOLDA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Oct 2019 07:03:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D119A28;
        Tue, 15 Oct 2019 04:02:59 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CED563F68E;
        Tue, 15 Oct 2019 04:02:58 -0700 (PDT)
Date:   Tue, 15 Oct 2019 12:02:54 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Andrew Murray <andrew.murray@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ley Foon Tan <lftan@altera.com>, rfi@lists.rocketboards.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 02/11] PCI: altera: Use pci_parse_request_of_pci_ranges()
Message-ID: <20191015110254.GA5160@e121166-lin.cambridge.arm.com>
References: <20190924214630.12817-1-robh@kernel.org>
 <20190924214630.12817-3-robh@kernel.org>
 <20190925102423.GR9720@e119886-lin.cambridge.arm.com>
 <CAL_JsqKN709cOLtDLdKXmDzeNLYtGekMT2BiZic4x45UopenwA@mail.gmail.com>
 <20190930151346.GD42880@e119886-lin.cambridge.arm.com>
 <CAL_Jsq+3S7+E+a5E122aR7s0a9SxkMyxw2t=OkO4pS5QUR+0CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+3S7+E+a5E122aR7s0a9SxkMyxw2t=OkO4pS5QUR+0CA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 30, 2019 at 12:36:22PM -0500, Rob Herring wrote:
> On Mon, Sep 30, 2019 at 10:13 AM Andrew Murray <andrew.murray@arm.com> wrote:
> >
> > On Wed, Sep 25, 2019 at 07:33:35AM -0500, Rob Herring wrote:
> > > On Wed, Sep 25, 2019 at 5:24 AM Andrew Murray <andrew.murray@arm.com> wrote:
> > > >
> > > > On Tue, Sep 24, 2019 at 04:46:21PM -0500, Rob Herring wrote:
> > > > > Convert altera host bridge to use the common
> > > > > pci_parse_request_of_pci_ranges().
> > > > >
> > > > > Cc: Ley Foon Tan <lftan@altera.com>
> > > > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > > Cc: rfi@lists.rocketboards.org
> > > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > > ---
> > >
> > > > > @@ -833,9 +800,8 @@ static int altera_pcie_probe(struct platform_device *pdev)
> > > > >               return ret;
> > > > >       }
> > > > >
> > > > > -     INIT_LIST_HEAD(&pcie->resources);
> > > > > -
> > > > > -     ret = altera_pcie_parse_request_of_pci_ranges(pcie);
> > > > > +     ret = pci_parse_request_of_pci_ranges(dev, &pcie->resources,
> > > >
> > > > Does it matter that we now map any given IO ranges whereas we didn't
> > > > previously?
> > > >
> > > > As far as I can tell there are no users that pass an IO range, if they
> > > > did then with the existing code the probe would fail and they'd get
> > > > a "I/O range found for %pOF. Please provide an io_base pointer...".
> > > > However with the new code if any IO range was given (which would
> > > > probably represent a misconfiguration), then we'd proceed to map the
> > > > IO range. When that IO is used, who knows what would happen.
> > >
> > > Yeah, I'm assuming that the DT doesn't have an IO range if IO is not
> > > supported. IMO, it is not the kernel's job to validate the DT.
> >
> > Sure. Is it worth mentioning in the commit message this subtle change
> > in behaviour?
> 
> Will do.

Hi Rob,

I would like to merge this series, are you resending it ? It does not
apply to v5.4-rc1, if you rebase it please also update this patch
log, as per comments above (I can do it too but if you resend it
there is no point).

Thanks,
Lorenzo
