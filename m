Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B572227B45
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jul 2020 10:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgGUI5Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 04:57:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbgGUI5Q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Jul 2020 04:57:16 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D43F20720;
        Tue, 21 Jul 2020 08:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595321835;
        bh=AxO3LjTo8QkpTvsdhl2LgGk5MZNj7vL6UQjqaA2SIVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aLMr7dKWCfWmQ+2Ezz7p6mSK1bvRItppKXbMxfDSUHaYFa02wmmC/Y3kWFcXsO+TF
         62gMRNW/LHDDRufXGVuSBh0ObNy0IErkXsGFBnKvjh3EEGtnjVOw4a+YOOJ8jjcyHz
         VdrnA7GoqYN59lj9DHJCSsItEUti/vyx7awC3V1Y=
Received: by pali.im (Postfix)
        id 40AB1830; Tue, 21 Jul 2020 10:57:13 +0200 (CEST)
Date:   Tue, 21 Jul 2020 10:57:13 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: aardvark: Don't touch PCIe registers if no card
 connected
Message-ID: <20200721085713.p2rbmucpk5ra3quw@pali>
References: <20200702083036.12230-1-pali@kernel.org>
 <20200709113509.GB19638@e121166-lin.cambridge.arm.com>
 <20200709122208.rmfeuu6zgbwh3fr5@pali>
 <20200709144701.GA21760@e121166-lin.cambridge.arm.com>
 <20200709150959.wq6zfkcy4m6hvvpl@pali>
 <20200710091800.GA3419@e121166-lin.cambridge.arm.com>
 <20200713082747.e3q3ml3wpbszn4j7@pali>
 <20200713112325.GA25865@e121166-lin.cambridge.arm.com>
 <20200715121726.eh4xglkdbcqkh7td@pali>
 <20200715162108.GB3432@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200715162108.GB3432@e121166-lin.cambridge.arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 15 July 2020 17:21:08 Lorenzo Pieralisi wrote:
> On Wed, Jul 15, 2020 at 02:17:26PM +0200, Pali Rohár wrote:
> > On Monday 13 July 2020 12:23:25 Lorenzo Pieralisi wrote:
> > > On Mon, Jul 13, 2020 at 10:27:47AM +0200, Pali Rohár wrote:
> > > > On Friday 10 July 2020 10:18:00 Lorenzo Pieralisi wrote:
> > > > > On Thu, Jul 09, 2020 at 05:09:59PM +0200, Pali Rohár wrote:
> > > > > > > I understand that but the bridge bus resource can be trimmed to just
> > > > > > > contain the root bus because that's the only one where there is a
> > > > > > > chance you can enumerate a device.
> > > > > > 
> > > > > > It is possible to register only root bridge without endpoint?
> > > > > 
> > > > > It is possible to register the root bridge with a trimmed IORESOURCE_BUS
> > > > > so that you don't enumerate anything other than the root port.
> > > > 
> > > > Hello Lorenzo! I really do not know how to achieve it. From code it
> > > > looks like that pci/probe.c scans child buses unconditionally.
> > > > 
> > > > pci-aardvark.c calls pci_host_probe() which calls functions
> > > > pci_scan_root_bus_bridge() which calls pci_scan_child_bus() which calls
> > > > pci_scan_child_bus_extend() which calls pci_scan_bridge_extend() (bridge
> > > > needs to be reconfigured) which then try to probe child bus via
> > > > pci_scan_child_bus_extend() because bridge is not card bus.
> > > > 
> > > > In function pci_scan_bridge_extend() I do not see a way how to skip
> > > > probing for child buses which would avoid enumerating aardvark root
> > > > bridge when PCIe device is not connected.
> > > > 
> > > > dmesg output contains:
> > > > 
> > > >   advk-pcie d0070000.pcie: link never came up
> > > >   advk-pcie d0070000.pcie: PCI host bridge to bus 0000:00
> > > >   pci_bus 0000:00: root bus resource [bus 00-ff]
> > > 
> > > This resource can be limited to the root bus number only before calling
> > > pci_host_probe() (ie see pci_parse_request_of_pci_ranges() and code in
> > > pci_scan_bridge_extend() that programs primary/secondary/subordinate
> > > busses) but I think that only papers over the issue, it does not fix it.
> > 
> > I looked at the code in pci/probe.c again and I do not think it is
> > possible to avoid scanning devices. pci_scan_child_bus_extend() is
> > unconditionally calling pci_scan_slot() for devfn=0 as the first thing.
> > And this function unconditionally calls pci_scan_device() which is
> > directly trying to read vendor id from config register.
> > 
> > So for me it looks like that kernel expects that can read vendor id and
> > device id from config register for device which is not connected.
> 
> Not if it is connected to a bus that the root port does not decode,
> that's what I am saying.
> 
> > And trying to read config register would cause those timeouts in
> > aardvark.
> 
> The root port (which effectively works as PCI bridge from this
> standpoint) does not issue config cycles for busses that aren't within
> its decoded bus range, which in turn is determined by the firmware
> IORESOURCE_BUS resource.
> 
> This issue is caused by devices that are connected downstream to
> the root port.
> 
> Anyway - patch merged

Could you send me a link to git commit? I have looked into
lpieralisi/pci.git repository, but I do not see it here.

> but I would be happy to keep this discussion going, somehow.

Ok, no problem. As I said if anybody has any idea or would like to see
some tests from me, I can do it and provide results.

> If the LPC20 VFIO/IOMMU/PCI microconference is approved it can be a
> good venue for this to happen.
> 
> Lorenzo
