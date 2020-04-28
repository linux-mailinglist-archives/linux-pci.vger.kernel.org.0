Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599401BB8CF
	for <lists+linux-pci@lfdr.de>; Tue, 28 Apr 2020 10:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgD1I0Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Apr 2020 04:26:24 -0400
Received: from foss.arm.com ([217.140.110.172]:47616 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbgD1I0Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Apr 2020 04:26:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EBE230E;
        Tue, 28 Apr 2020 01:26:24 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 746133F305;
        Tue, 28 Apr 2020 01:26:22 -0700 (PDT)
Date:   Tue, 28 Apr 2020 09:26:17 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>
Subject: Re: [PATCH V3] PCI: rcar: Add the suspend/resume for pcie-rcar driver
Message-ID: <20200428082617.GA12459@e121166-lin.cambridge.arm.com>
References: <CAMuHMdVGkM_-5q+pSOtQ5nBPGzMeOpRTJUqekYnvjiPMFepqLw@mail.gmail.com>
 <20200427174138.GA207841@google.com>
 <CAMuHMdXbpynd6N2-GF+j3ie3HG0CohebpPOaj=oiZhF_Pt9gAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXbpynd6N2-GF+j3ie3HG0CohebpPOaj=oiZhF_Pt9gAg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 27, 2020 at 10:08:52PM +0200, Geert Uytterhoeven wrote:
> Hi Bjorn,
> 
> On Mon, Apr 27, 2020 at 7:41 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Sat, Apr 25, 2020 at 10:55:21AM +0200, Geert Uytterhoeven wrote:
> > > On Fri, Apr 24, 2020 at 9:57 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > [+cc Vaibhav]
> > > >
> > > > Alternate less redundant subject:
> > > >
> > > >   PCI: rcar: Add suspend/resume support
> > >
> > > Note that there's both pcie-rcar.c (this driver, for R-Car Gen2 and Gen3
> > > PCIe) and pci-rcar-gen2.c (for R-Car Gen2 PCI).
> > > People tend to use the prefix "PCI: rcar: " for both :-(
> >
> > Yeah, that's pretty broken, thanks for pointing this out!
> >
> > For most drivers we use a chipset name ("keystone", "imx6", "tegra",
> > etc) as the changlog tag.  That's nice because it gives space for
> > multiple drivers from the same vendor, but I don't know anything
> > similarly specific for the R-Car drivers.
> >
> > pci-rcar-gen2.c seems to be for some sort of internal Conventional PCI
> 
> AFAIUI it's some internal PCI glue to the *HCI USB controller.
> 
> > bus?  The "gen2" is confusing because "Gen 2" is more commonly used
> > for PCIe than for Conventional PCI.
> 
> The "Gen2" applies to "R-Car", not to "PCI".

Wicked :) !

> > I would propose keeping "rcar" for the PCIe driver and using
> > "rcar-pci" for the Conventional PCI one, but the Conventional PCI one
> 
> (/me resists against bike-shedding)

I'd agree with Bjorn - I don't know, internal vs external seems
artificial. Certainly gen2 is misleading, it does not take much
to improve it.

> > (pci-rcar-gen2.c) seems pretty inactive.  The most recent commits are
> > from 2018, and they're trivial cleanups.  So I'm doubtful that anybody
> > will remember when the next change comes in.
> 
> I guess pci-rcar-gen2.c is simpler and more mature ;-)
> R-Car Gen2 SoCs have both (internal) PCI and PCIe, so the two drivers
> can be used together on the same hardware.

I'd remove gen2 to start with, you are better placed to know the
internals to come up with something significant.

Lorenzo
