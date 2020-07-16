Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83FD222DFB
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jul 2020 23:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgGPVbX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jul 2020 17:31:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbgGPVbX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Jul 2020 17:31:23 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 034C7207CB;
        Thu, 16 Jul 2020 21:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594935082;
        bh=9idFZGZVoTwBNK85r+TA37JLm954F3UhdG0razYIHIE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZxWBgfcmTfq8MZqDTN8xd+b89lsPeZzWaTo2rad3asA+09v3B6Wyr7XUH1q6xm7pp
         nEnqtB1UgesiSiendYfpbByg5ezOTcPAZ+4/gNbthTNKPjJWA2xdiec/1fus+17yDc
         giWwV41JdqxOWx+H3M+nyqR13r03LNqChE3HvTyA=
Date:   Thu, 16 Jul 2020 16:31:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        linux-pci@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [RFC PATCH] hwtracing: Add HiSilicon PCIe Tune and Trace device
 driver
Message-ID: <20200716213120.GA648781@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f945bfe-eaec-464e-9f01-8c76fb467a1d@hisilicon.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 16, 2020 at 05:06:19PM +0800, Yicong Yang wrote:
> On 2020/7/11 7:09, Bjorn Helgaas wrote:
> > On Sat, Jun 13, 2020 at 05:32:13PM +0800, Yicong Yang wrote:
> >> HiSilicon PCIe tune and trace device(PTT) is a PCIe Root Complex
> >> integrated Endpoint(RCiEP) device, providing the capability
> >> to dynamically monitor and tune the PCIe traffic parameters(tune),
> >> and trace the TLP headers to the memory(trace).
> >>
> >> Add the driver for the device to enable its functions. The driver
> >> will create debugfs directory for each PTT device, and users can
> >> operate the device through the files under its directory.

> >> +Tune
> >> +====
> >> +
> >> +PTT tune is designed for monitoring and adjusting PCIe link parameters(events).
> >> +Currently we support events 4 classes. The scope of the events
> >> +covers the PCIe core with which the PTT device belongs to.
> > All of these look like things that have the potential to break the
> > PCIe protocol and cause errors like timeouts, receiver overflows, etc.
> > That's OK for a debug/analysis situation, but it should taint the
> > kernel somehow because I don't want to debug problems like that if
> > they're caused by users tweaking things.
> >
> > That might even be a reason *not* to merge the tune side of this.  I
> > can see how it might be useful for you internally, but it's not
> > obvious to me how it will benefit other users.  Maybe that part should
> > be an out-of-tree module?
> 
> All the tuning values are not accurate, but abstracted to several
> _levels_ of each events. The levels are delicately designed to
> guarantee by the hardware that they are always valid and will not
> break the PCIe link.  The possible level values exposed to the users
> is tested and safe and other values will not be accepted.
> 
> The final tuning events is not settled and we'll not exposed the
> events which will may lead to the link broken. Furthermore, maybe we
> could default disable the tune events' level adjustment and make
> them readonly. The user can enable the full tune function by a
> module parameters or in the BIOS, and a warning message will be
> displayed.
> 
> The tune part is beneficial for the users and not only for our
> internal use.  We intends to provide a way to tune the link
> depending on the downstream components and link configuration. For
> example, users can tune the data path QoS level to get better
> performance according to the link width is x8 or x16, or according
> to the endpoints' class is a network card or a nvme disk.  It will
> make our controller adapt to different condition with high
> performance, so we hope this feature to be merged.

OK.  This driver itself is outside my area, so I guess merging it is
up to Alexander.

Do you have any measurements of performance improvements?  I think it
would be good to have real numbers showing that this is useful.

You mentioned a warning message, so I assume you'll add some kind of
dmesg logging when tuning happens?

Is this protected so it's only usable by root or other appropriate
privileged user?

> >> +		 * The PTT can designate function for trace.
> >> +		 * Add the root port's subordinates in the list as we
> >> +		 * can specify certain function.
> >> +		 */
> >> +		child_bus = tpdev->subordinate;
> >> +		list_for_each_entry(tpdev, &child_bus->devices, bus_list) {
> > *This* looks like a potential problem with hotplug.  How do you deal
> > with devices being added/removed after this loop?
> 
> Yes. I have considered the add/remove situation but not intend to address it
> in this RFC and assume the topology is static after probing.
> I will manage the situation in next version.

What happens if a device is added or removed after boot?  If the only
limitation is that you can't tune or trace a hot-added device, that's
fine.  (I mean, it's really *not* fine because it's a poor user
experience, but at least it's just a usability issue, not a crash.)

But if hot-adding or hot-removing a device can cause an oops or a
crash or something, *that* is definitely a problem.

Bjorn
