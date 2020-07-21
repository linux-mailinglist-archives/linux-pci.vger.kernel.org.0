Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2D9227D8B
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jul 2020 12:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgGUKsK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 06:48:10 -0400
Received: from foss.arm.com ([217.140.110.172]:35834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgGUKsK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Jul 2020 06:48:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C364106F;
        Tue, 21 Jul 2020 03:48:09 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D8533F66E;
        Tue, 21 Jul 2020 03:48:08 -0700 (PDT)
Date:   Tue, 21 Jul 2020 11:48:02 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: aardvark: Don't touch PCIe registers if no card
 connected
Message-ID: <20200721104802.GA2618@e121166-lin.cambridge.arm.com>
References: <20200709113509.GB19638@e121166-lin.cambridge.arm.com>
 <20200709122208.rmfeuu6zgbwh3fr5@pali>
 <20200709144701.GA21760@e121166-lin.cambridge.arm.com>
 <20200709150959.wq6zfkcy4m6hvvpl@pali>
 <20200710091800.GA3419@e121166-lin.cambridge.arm.com>
 <20200713082747.e3q3ml3wpbszn4j7@pali>
 <20200713112325.GA25865@e121166-lin.cambridge.arm.com>
 <20200715121726.eh4xglkdbcqkh7td@pali>
 <20200715162108.GB3432@e121166-lin.cambridge.arm.com>
 <20200721085713.p2rbmucpk5ra3quw@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200721085713.p2rbmucpk5ra3quw@pali>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 21, 2020 at 10:57:13AM +0200, Pali Rohár wrote:
> On Wednesday 15 July 2020 17:21:08 Lorenzo Pieralisi wrote:
> > On Wed, Jul 15, 2020 at 02:17:26PM +0200, Pali Rohár wrote:
> > > On Monday 13 July 2020 12:23:25 Lorenzo Pieralisi wrote:
> > > > On Mon, Jul 13, 2020 at 10:27:47AM +0200, Pali Rohár wrote:
> > > > > On Friday 10 July 2020 10:18:00 Lorenzo Pieralisi wrote:
> > > > > > On Thu, Jul 09, 2020 at 05:09:59PM +0200, Pali Rohár wrote:
> > > > > > > > I understand that but the bridge bus resource can be trimmed to just
> > > > > > > > contain the root bus because that's the only one where there is a
> > > > > > > > chance you can enumerate a device.
> > > > > > > 
> > > > > > > It is possible to register only root bridge without endpoint?
> > > > > > 
> > > > > > It is possible to register the root bridge with a trimmed IORESOURCE_BUS
> > > > > > so that you don't enumerate anything other than the root port.
> > > > > 
> > > > > Hello Lorenzo! I really do not know how to achieve it. From code it
> > > > > looks like that pci/probe.c scans child buses unconditionally.
> > > > > 
> > > > > pci-aardvark.c calls pci_host_probe() which calls functions
> > > > > pci_scan_root_bus_bridge() which calls pci_scan_child_bus() which calls
> > > > > pci_scan_child_bus_extend() which calls pci_scan_bridge_extend() (bridge
> > > > > needs to be reconfigured) which then try to probe child bus via
> > > > > pci_scan_child_bus_extend() because bridge is not card bus.
> > > > > 
> > > > > In function pci_scan_bridge_extend() I do not see a way how to skip
> > > > > probing for child buses which would avoid enumerating aardvark root
> > > > > bridge when PCIe device is not connected.
> > > > > 
> > > > > dmesg output contains:
> > > > > 
> > > > >   advk-pcie d0070000.pcie: link never came up
> > > > >   advk-pcie d0070000.pcie: PCI host bridge to bus 0000:00
> > > > >   pci_bus 0000:00: root bus resource [bus 00-ff]
> > > > 
> > > > This resource can be limited to the root bus number only before calling
> > > > pci_host_probe() (ie see pci_parse_request_of_pci_ranges() and code in
> > > > pci_scan_bridge_extend() that programs primary/secondary/subordinate
> > > > busses) but I think that only papers over the issue, it does not fix it.
> > > 
> > > I looked at the code in pci/probe.c again and I do not think it is
> > > possible to avoid scanning devices. pci_scan_child_bus_extend() is
> > > unconditionally calling pci_scan_slot() for devfn=0 as the first thing.
> > > And this function unconditionally calls pci_scan_device() which is
> > > directly trying to read vendor id from config register.
> > > 
> > > So for me it looks like that kernel expects that can read vendor id and
> > > device id from config register for device which is not connected.
> > 
> > Not if it is connected to a bus that the root port does not decode,
> > that's what I am saying.
> > 
> > > And trying to read config register would cause those timeouts in
> > > aardvark.
> > 
> > The root port (which effectively works as PCI bridge from this
> > standpoint) does not issue config cycles for busses that aren't within
> > its decoded bus range, which in turn is determined by the firmware
> > IORESOURCE_BUS resource.
> > 
> > This issue is caused by devices that are connected downstream to
> > the root port.
> > 
> > Anyway - patch merged
> 
> Could you send me a link to git commit? I have looked into
> lpieralisi/pci.git repository, but I do not see it here.

Apologies - I did not push it out, I have pushed it out on
pci/aardvark now.

> > but I would be happy to keep this discussion going, somehow.
> 
> Ok, no problem. As I said if anybody has any idea or would like to see
> some tests from me, I can do it and provide results.

Sounds good, I will let you know, thanks.

Lorenzo

> > If the LPC20 VFIO/IOMMU/PCI microconference is approved it can be a
> > good venue for this to happen.
> > 
> > Lorenzo
