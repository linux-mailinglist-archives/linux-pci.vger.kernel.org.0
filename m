Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C629C13BCFA
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 11:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbgAOKBD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 05:01:03 -0500
Received: from foss.arm.com ([217.140.110.172]:34234 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729532AbgAOKBD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jan 2020 05:01:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E91F31B;
        Wed, 15 Jan 2020 02:01:02 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 268343F6C4;
        Wed, 15 Jan 2020 02:01:00 -0800 (PST)
Date:   Wed, 15 Jan 2020 10:00:54 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     andrew.murray@arm.com, maz@kernel.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        mbrugger@suse.com, phil@raspberrypi.org, wahrenst@gmx.net,
        jeremy.linton@arm.com, linux-pci@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 3/6] PCI: brcmstb: Add Broadcom STB PCIe host
 controller driver
Message-ID: <20200115100054.GA2174@e121166-lin.cambridge.arm.com>
References: <20191216110113.30436-1-nsaenzjulienne@suse.de>
 <20191216110113.30436-4-nsaenzjulienne@suse.de>
 <20200114171101.GA11177@e121166-lin.cambridge.arm.com>
 <8a7057fe1aaf415272d28f4e690313984c3a148d.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a7057fe1aaf415272d28f4e690313984c3a148d.camel@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 14, 2020 at 07:18:46PM +0100, Nicolas Saenz Julienne wrote:
> Hi Lorenzo,
> 
> On Tue, 2020-01-14 at 17:11 +0000, Lorenzo Pieralisi wrote:
> > On Mon, Dec 16, 2019 at 12:01:09PM +0100, Nicolas Saenz Julienne wrote:
> > > From: Jim Quinlan <james.quinlan@broadcom.com>
> > > 
> > > This adds a basic driver for Broadcom's STB PCIe controller, for now
> > > aimed at Raspberry Pi 4's SoC, bcm2711.
> > > 
> > > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > > Co-developed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> > > Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
> > > 
> > > ---
> > > 
> > > Changes since v3:
> > >   - Update commit message
> > >   - rollback roundup_pow_two usage, it'll be updated later down the line
> > >   - Remove comment in register definition
> > > 
> > > Changes since v2:
> > >   - Correct rc_bar2_offset sign
> > 
> > In relation to this change.
> > 
> > [...]
> > 
> > > +static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie
> > > *pcie,
> > > +							u64 *rc_bar2_size,
> > > +							u64 *rc_bar2_offset)
> > > +{
> > > +	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
> > > +	struct device *dev = pcie->dev;
> > > +	struct resource_entry *entry;
> > > +
> > > +	entry = resource_list_first_type(&bridge->dma_ranges, IORESOURCE_MEM);
> > > +	if (!entry)
> > > +		return -ENODEV;
> > > +
> > > +	*rc_bar2_offset = -entry->offset;
> > 
> > I think this deserves a comment - I guess it has to do with how the
> > controller expects CPU<->PCI offsets to be expressed compared to how it
> > is computed in dma_ranges entries.
> 
> You're right, OF code calculates it by doing:
> 
> 	offset = cpu_start_addr - pci_start_addr (see
> devm_of_pci_get_host_bridge_resources())
> 
> While the RC_BAR2_CONFIG register expects the opposite subtraction.
> I'll add a comment on the next revision.

There is no need for a new posting, either write that comment here
and I update the code or inline the patch or just resend *this* updated
patch to the list.

Thanks,
Lorenzo
