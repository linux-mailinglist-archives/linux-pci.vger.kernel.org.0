Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8F710CB14
	for <lists+linux-pci@lfdr.de>; Thu, 28 Nov 2019 15:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfK1O7Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Nov 2019 09:59:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:41364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727751AbfK1O7Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Nov 2019 09:59:24 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FA9821771;
        Thu, 28 Nov 2019 14:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574953163;
        bh=1tWSgyh5Bb0cADmA96mIGQLXOEiXVxaCkY2bgc7V5Ck=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aUjyC5R/dL/1RGcvEJ0kpnKCST8JwBJqimo4aJiaKdJwZc0oCXibvi+4jzky3/w95
         E3n2GBnhC92mMBDa38/M+3wB3ckUSs7O/WU3jJ8dzpQWJ+NshFZPvD6e6o2pIjGJee
         ftaMp4WiYaR04rgDOOY73UASaOmViUYk+vInNP7A=
Date:   Thu, 28 Nov 2019 08:59:21 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org
Subject: Re: Issue with 395f121e6199 ("PCI/PM: Wait for device to become
 ready after power-on")
Message-ID: <20191128145921.GA5570@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128082314.GD2665@lahna.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 28, 2019 at 10:23:14AM +0200, Mika Westerberg wrote:
> Hi,
> 
> For some reason I don't see this in linux-pci archives. Maybe it was not
> accepted because of the attachment? In any case the full dmesg can be
> found here as well:
> 
>   https://gist.github.com/westeri/ca2574a4e48dc6e3eb76184922e103e5
> 
> On Wed, Nov 27, 2019 at 05:34:37PM +0200, Mika Westerberg wrote:
> > Hi,
> > 
> > I noticed that latest Bjorn's pci/pm branch breaks native PCIe hotplug
> > so that when I unplug a device (connected over TBT) the pciehp notices
> > it but then the core PCI code starts waiting for all the devices that
> > are now gone:
> > 
> > [  160.344476] pcieport 0000:04:04.0: pciehp: pciehp_check_link_active: lnk_status = 5041
> > [  160.344531] pcieport 0000:04:04.0: pciehp: Slot(4): Card not present
> > [  160.346004] pcieport 0000:04:04.0: pciehp: pciehp_unconfigure_device: domain:bus:dev = 0000:3a:00
> > [  161.421569] pcieport 0000:3a:00.0: not ready 1023ms after Switch to D0; waiting
> > [  162.509610] pcieport 0000:3a:00.0: not ready 2047ms after Switch to D0; waiting
> > [  164.621620] pcieport 0000:3a:00.0: not ready 4095ms after Switch to D0; waiting
> > [  169.165529] pcieport 0000:3a:00.0: not ready 8191ms after Switch to D0; waiting
> > [  177.869521] pcieport 0000:3a:00.0: not ready 16383ms after Switch to D0; waiting
> > [  194.765581] pcieport 0000:3a:00.0: not ready 32767ms after Switch to D0; waiting
> > ...
> > 
> > It seems to continue forever so the devices are not removed from the
> > system.
> > 
> > The test system used here is Dell XPS 9380 but it happens also on other
> > systems that support native PCIe hotplug.
> > 
> > Reverting 395f121e6199 ("PCI/PM: Wait for device to become ready after
> > power-on") makes the problem go away.
> > 
> > I've attached full dmesg from the system. The way I reproduce this is
> > that I boot the system up (no device connected yet), the I connect TBT
> > dock that includes the PCIe switch etc. Then I unplug the dock. The
> > unplug happens around 160.335355 in the dmesg.

Thanks for testing this.  I dropped 395f121e6199 ("PCI/PM: Wait for
device to become ready after power-on") for now.  We can sort this out
for v5.6.
