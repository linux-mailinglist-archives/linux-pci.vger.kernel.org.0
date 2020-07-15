Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E039B220CC9
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jul 2020 14:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgGOMR3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jul 2020 08:17:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgGOMR3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jul 2020 08:17:29 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8303D2065D;
        Wed, 15 Jul 2020 12:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594815448;
        bh=oox3IXWADMTRayXaRJ2ttv7qQ4vHlGzipTP8KKgGols=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LlI75eE7yhlwt979Nx/dOdJXZJs8+5qMb3+utgc8rqZR/gwMjbq6Bnvw9X9CU7DUT
         0nrp3nGJEHjA5B4L1TEIT0JdL1zUk+ihUPhllCD+q8ciqqb0wi/Fk+4vPaKxHf1qvX
         0b64zk3z7FOMl0SvH9SXRuHivUu1unSUJJ4MmLZE=
Received: by pali.im (Postfix)
        id 55E077AC; Wed, 15 Jul 2020 14:17:26 +0200 (CEST)
Date:   Wed, 15 Jul 2020 14:17:26 +0200
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
Message-ID: <20200715121726.eh4xglkdbcqkh7td@pali>
References: <20200528143141.29956-1-pali@kernel.org>
 <20200702083036.12230-1-pali@kernel.org>
 <20200709113509.GB19638@e121166-lin.cambridge.arm.com>
 <20200709122208.rmfeuu6zgbwh3fr5@pali>
 <20200709144701.GA21760@e121166-lin.cambridge.arm.com>
 <20200709150959.wq6zfkcy4m6hvvpl@pali>
 <20200710091800.GA3419@e121166-lin.cambridge.arm.com>
 <20200713082747.e3q3ml3wpbszn4j7@pali>
 <20200713112325.GA25865@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200713112325.GA25865@e121166-lin.cambridge.arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 13 July 2020 12:23:25 Lorenzo Pieralisi wrote:
> On Mon, Jul 13, 2020 at 10:27:47AM +0200, Pali Rohár wrote:
> > On Friday 10 July 2020 10:18:00 Lorenzo Pieralisi wrote:
> > > On Thu, Jul 09, 2020 at 05:09:59PM +0200, Pali Rohár wrote:
> > > > > I understand that but the bridge bus resource can be trimmed to just
> > > > > contain the root bus because that's the only one where there is a
> > > > > chance you can enumerate a device.
> > > > 
> > > > It is possible to register only root bridge without endpoint?
> > > 
> > > It is possible to register the root bridge with a trimmed IORESOURCE_BUS
> > > so that you don't enumerate anything other than the root port.
> > 
> > Hello Lorenzo! I really do not know how to achieve it. From code it
> > looks like that pci/probe.c scans child buses unconditionally.
> > 
> > pci-aardvark.c calls pci_host_probe() which calls functions
> > pci_scan_root_bus_bridge() which calls pci_scan_child_bus() which calls
> > pci_scan_child_bus_extend() which calls pci_scan_bridge_extend() (bridge
> > needs to be reconfigured) which then try to probe child bus via
> > pci_scan_child_bus_extend() because bridge is not card bus.
> > 
> > In function pci_scan_bridge_extend() I do not see a way how to skip
> > probing for child buses which would avoid enumerating aardvark root
> > bridge when PCIe device is not connected.
> > 
> > dmesg output contains:
> > 
> >   advk-pcie d0070000.pcie: link never came up
> >   advk-pcie d0070000.pcie: PCI host bridge to bus 0000:00
> >   pci_bus 0000:00: root bus resource [bus 00-ff]
> 
> This resource can be limited to the root bus number only before calling
> pci_host_probe() (ie see pci_parse_request_of_pci_ranges() and code in
> pci_scan_bridge_extend() that programs primary/secondary/subordinate
> busses) but I think that only papers over the issue, it does not fix it.

I looked at the code in pci/probe.c again and I do not think it is
possible to avoid scanning devices. pci_scan_child_bus_extend() is
unconditionally calling pci_scan_slot() for devfn=0 as the first thing.
And this function unconditionally calls pci_scan_device() which is
directly trying to read vendor id from config register.

So for me it looks like that kernel expects that can read vendor id and
device id from config register for device which is not connected.

And trying to read config register would cause those timeouts in
aardvark.
