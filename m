Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 034BC112F99
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2019 17:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbfLDQHe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Dec 2019 11:07:34 -0500
Received: from foss.arm.com ([217.140.110.172]:58154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727878AbfLDQHe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Dec 2019 11:07:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0A7831B;
        Wed,  4 Dec 2019 08:07:32 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FA3A3F52E;
        Wed,  4 Dec 2019 08:07:32 -0800 (PST)
Date:   Wed, 4 Dec 2019 16:07:30 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] PCI: iproc: Add INTx support with better modeling
Message-ID: <20191204160729.GJ18399@e119886-lin.cambridge.arm.com>
References: <1575349026-8743-1-git-send-email-srinath.mannam@broadcom.com>
 <1575349026-8743-3-git-send-email-srinath.mannam@broadcom.com>
 <20191203155514.GE18399@e119886-lin.cambridge.arm.com>
 <CAHp75Vf7d=Gw24MTq2q3BKspkLEDDM24GVK4Zh_4zfZEzVuZjw@mail.gmail.com>
 <40fffa66-4b06-a851-84c2-4de36d5c6777@broadcom.com>
 <CAHp75VfyKAg4OhzUa4swGXOGTvJ5fVO8mhGSG=5HAUP__M-URQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfyKAg4OhzUa4swGXOGTvJ5fVO8mhGSG=5HAUP__M-URQ@mail.gmail.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 04, 2019 at 10:29:51AM +0200, Andy Shevchenko wrote:
> On Wed, Dec 4, 2019 at 12:09 AM Ray Jui <ray.jui@broadcom.com> wrote:
> > On 12/3/19 11:27 AM, Andy Shevchenko wrote:
> > > On Tue, Dec 3, 2019 at 5:55 PM Andrew Murray <andrew.murray@arm.com> wrote:
> > >> On Tue, Dec 03, 2019 at 10:27:02AM +0530, Srinath Mannam wrote:
> > >
> > >>> +     /* go through INTx A, B, C, D until all interrupts are handled */
> > >>> +     do {
> > >>> +             status = iproc_pcie_read_reg(pcie, IPROC_PCIE_INTX_CSR);
> > >>
> > >> By performing this read once and outside of the do/while loop you may improve
> > >> performance. I wonder how probable it is to get another INTx whilst handling
> > >> one?
> > >
> > > May I ask how it can be improved?
> > > One read will be needed any way, and so does this code.
> > >
> >
> > I guess the current code will cause the IPROC_PCIE_INTX_CSR register to
> > be read TWICE, if it's ever set to start with.
> >
> > But then if we do it outside of the while loop, if we ever receive an
> > interrupt while servicing one, the interrupt will still need to be
> > serviced, and in this case, it will cause additional context switch
> > overhead by going out and back in the interrupt context.

Yes it's a trade off - if you dropped the do/while loop and thus had a single
read you'd reduce the overhead on interrupt handling in every case except
where another INTx is received whilst in this function. But as you point out
each time that does happen you'll pay the penalty of a context switch.

I don't have any knowledge of this platform so I have no idea if such a change
would be good/bad or material. However I thought I'd point it out. Looking at
the other controller drivers, some handle in a loop and some don't.


> >
> > My take is that it's probably more ideal to leave this portion of code
> > as it is.
> 
> Can't we simple drop a do-while completely and leave only
> for_each_set_bit() loop?
> 

I'm happy either way.

Thanks,

Andrew Murray

> >
> > >>> +             for_each_set_bit(bit, &status, PCI_NUM_INTX) {
> > >>> +                     virq = irq_find_mapping(pcie->irq_domain, bit);
> > >>> +                     if (virq)
> > >>> +                             generic_handle_irq(virq);
> > >>> +                     else
> > >>> +                             dev_err(dev, "unexpected INTx%u\n", bit);
> > >>> +             }
> > >>> +     } while ((status & SYS_RC_INTX_MASK) != 0);
> > >
> 
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
