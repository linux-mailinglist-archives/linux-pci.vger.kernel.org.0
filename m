Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B2421D1B0
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 10:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgGMI1u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 04:27:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgGMI1u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jul 2020 04:27:50 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA7FD2067D;
        Mon, 13 Jul 2020 08:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594628869;
        bh=Mzu5M8J7qSSUdRCwII36kgtNKcgkXpCVKQg6uo3q2aM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rBywLjk8q/9SCapOGSwOqN3Vg8NO4eBR99O6xSiKoblZ6EvtQULlpw0SYhMGfq1yX
         E385iR9JXzbY0Vl5jNNie7Nrv2DcIwUsZzy83qd8i/v9NzvIu/XMa1SdSTJdO13qWo
         aWbYjZSjZpteIpXWZwv7X29SmxWQNPC2bhh3WKIY=
Received: by pali.im (Postfix)
        id E8996857; Mon, 13 Jul 2020 10:27:47 +0200 (CEST)
Date:   Mon, 13 Jul 2020 10:27:47 +0200
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
Message-ID: <20200713082747.e3q3ml3wpbszn4j7@pali>
References: <20200528143141.29956-1-pali@kernel.org>
 <20200702083036.12230-1-pali@kernel.org>
 <20200709113509.GB19638@e121166-lin.cambridge.arm.com>
 <20200709122208.rmfeuu6zgbwh3fr5@pali>
 <20200709144701.GA21760@e121166-lin.cambridge.arm.com>
 <20200709150959.wq6zfkcy4m6hvvpl@pali>
 <20200710091800.GA3419@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200710091800.GA3419@e121166-lin.cambridge.arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 10 July 2020 10:18:00 Lorenzo Pieralisi wrote:
> On Thu, Jul 09, 2020 at 05:09:59PM +0200, Pali Rohár wrote:
> > > I understand that but the bridge bus resource can be trimmed to just
> > > contain the root bus because that's the only one where there is a
> > > chance you can enumerate a device.
> > 
> > It is possible to register only root bridge without endpoint?
> 
> It is possible to register the root bridge with a trimmed IORESOURCE_BUS
> so that you don't enumerate anything other than the root port.

Hello Lorenzo! I really do not know how to achieve it. From code it
looks like that pci/probe.c scans child buses unconditionally.

pci-aardvark.c calls pci_host_probe() which calls functions
pci_scan_root_bus_bridge() which calls pci_scan_child_bus() which calls
pci_scan_child_bus_extend() which calls pci_scan_bridge_extend() (bridge
needs to be reconfigured) which then try to probe child bus via
pci_scan_child_bus_extend() because bridge is not card bus.

In function pci_scan_bridge_extend() I do not see a way how to skip
probing for child buses which would avoid enumerating aardvark root
bridge when PCIe device is not connected.

dmesg output contains:

  advk-pcie d0070000.pcie: link never came up
  advk-pcie d0070000.pcie: PCI host bridge to bus 0000:00
  pci_bus 0000:00: root bus resource [bus 00-ff]
  pci_bus 0000:00: root bus resource [mem 0xe8000000-0xe8ffffff]
  pci_bus 0000:00: root bus resource [io  0x0000-0xffff] (bus address [0xe9000000-0xe900ffff])
  pci_bus 0000:00: scanning bus
  pci 0000:00:00.0: [1b4b:0100] type 01 class 0x060400
  pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x000007ff pref]
  pci_bus 0000:00: fixups for bus
  pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 0
  pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
  pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
  pci_bus 0000:01: scanning bus
  advk-pcie d0070000.pcie: advk_pcie_valid_device
