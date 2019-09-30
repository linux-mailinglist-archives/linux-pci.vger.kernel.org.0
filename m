Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66027C2381
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 16:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbfI3Ojs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 10:39:48 -0400
Received: from foss.arm.com ([217.140.110.172]:55898 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730780AbfI3Ojs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Sep 2019 10:39:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACB0428;
        Mon, 30 Sep 2019 07:39:47 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A963B3F706;
        Mon, 30 Sep 2019 07:39:46 -0700 (PDT)
Date:   Mon, 30 Sep 2019 15:39:41 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Grzegorz Jaszczyk <jaz@semihalf.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Marcin Wojtas <mw@semihalf.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v2] PCI: aardvark: fix big endian support
Message-ID: <20190930143941.GA3744@e121166-lin.cambridge.arm.com>
References: <1563279127-30678-1-git-send-email-jaz@semihalf.com>
 <CAH76GKMZy7z05Gc9HVDUkpM04+tXMa8xEEMBWMQ7Zx1Bt_B0xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH76GKMZy7z05Gc9HVDUkpM04+tXMa8xEEMBWMQ7Zx1Bt_B0xQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 30, 2019 at 10:17:33AM +0200, Grzegorz Jaszczyk wrote:
> Hello,
> 
> I want to kindly remind about this patch.

I need Thomas' ACK on these patches to merge them.

Thanks,
Lorenzo

> Best regards,
> Grzegorz
> 
> wt., 16 lip 2019 o 14:12 Grzegorz Jaszczyk <jaz@semihalf.com> napisał(a):
> >
> > Initialise every not-byte wide fields of emulated pci bridge config
> > space with proper cpu_to_le* macro. This is required since the structure
> > describing config space of emulated bridge assumes little-endian
> > convention.
> >
> > Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> > ---
> > v1->v2
> > - add missing cpu_to_le32 for class_revison assignment (issues found by
> > Thomas Petazzoni and also detected by Sparse tool).
> >
> >  drivers/pci/controller/pci-aardvark.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > index 134e030..178e92f 100644
> > --- a/drivers/pci/controller/pci-aardvark.c
> > +++ b/drivers/pci/controller/pci-aardvark.c
> > @@ -479,18 +479,20 @@ static void advk_sw_pci_bridge_init(struct advk_pcie *pcie)
> >  {
> >         struct pci_bridge_emul *bridge = &pcie->bridge;
> >
> > -       bridge->conf.vendor = advk_readl(pcie, PCIE_CORE_DEV_ID_REG) & 0xffff;
> > -       bridge->conf.device = advk_readl(pcie, PCIE_CORE_DEV_ID_REG) >> 16;
> > +       bridge->conf.vendor =
> > +               cpu_to_le16(advk_readl(pcie, PCIE_CORE_DEV_ID_REG) & 0xffff);
> > +       bridge->conf.device =
> > +               cpu_to_le16(advk_readl(pcie, PCIE_CORE_DEV_ID_REG) >> 16);
> >         bridge->conf.class_revision =
> > -               advk_readl(pcie, PCIE_CORE_DEV_REV_REG) & 0xff;
> > +               cpu_to_le32(advk_readl(pcie, PCIE_CORE_DEV_REV_REG) & 0xff);
> >
> >         /* Support 32 bits I/O addressing */
> >         bridge->conf.iobase = PCI_IO_RANGE_TYPE_32;
> >         bridge->conf.iolimit = PCI_IO_RANGE_TYPE_32;
> >
> >         /* Support 64 bits memory pref */
> > -       bridge->conf.pref_mem_base = PCI_PREF_RANGE_TYPE_64;
> > -       bridge->conf.pref_mem_limit = PCI_PREF_RANGE_TYPE_64;
> > +       bridge->conf.pref_mem_base = cpu_to_le16(PCI_PREF_RANGE_TYPE_64);
> > +       bridge->conf.pref_mem_limit = cpu_to_le16(PCI_PREF_RANGE_TYPE_64);
> >
> >         /* Support interrupt A for MSI feature */
> >         bridge->conf.intpin = PCIE_CORE_INT_A_ASSERT_ENABLE;
> > --
> > 2.7.4
> >
