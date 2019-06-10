Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 403683B38D
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2019 12:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388489AbfFJK5s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jun 2019 06:57:48 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58448 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388100AbfFJK5s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jun 2019 06:57:48 -0400
Received: from 79.184.253.190.ipv4.supernova.orange.pl (79.184.253.190) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 88e807b607143e00; Mon, 10 Jun 2019 12:57:46 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/3] PCI / ACPI: Handle sibling devices sharing power resources
Date:   Mon, 10 Jun 2019 12:57:45 +0200
Message-ID: <3235484.ejFT65BlB1@kreacher>
In-Reply-To: <20190609185835.cqjbgzfwajbg4kks@wunner.de>
References: <20190605145820.37169-1-mika.westerberg@linux.intel.com> <CAJZ5v0gwqMd0W43KQoU80=fdYooLkgPg1n0cbbAWjPqrOepYsg@mail.gmail.com> <20190609185835.cqjbgzfwajbg4kks@wunner.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sunday, June 9, 2019 8:58:35 PM CEST Lukas Wunner wrote:
> On Thu, Jun 06, 2019 at 04:27:21PM +0200, Rafael J. Wysocki wrote:
> > On Thu, Jun 6, 2019 at 4:17 PM Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> > > On Thu, Jun 06, 2019 at 04:08:11PM +0200, Rafael J. Wysocki wrote:
> > > > That isn't necessary IMO as long as the device are not accessed.  If
> > > > the kernel thinks that a given device is in D3cold and doesn't access
> > > > it, then it really doesn't matter too much what state the device is in
> > > > physically.  On the first access the device should be reinitialized
> > > > anyway.
> > >
> > > But if the device is configured to wake. For example when it detects a
> > > hotplug that state is gone when it goes to D0unitialized.
> > 
> > For this we'll need a pm_runtime_resume() of the dependent device on
> > the resource going "on".
> > 
> > That means we need a list of devices to resume when the resource goes
> > "on" after being taken "off".
> 
> An idea would be to model every ACPI power resource as a struct device
> and automatically set up a device link from the devices using that
> power resource (consumers).  After all dependent devices runtime suspend,
> the power resource "device" runtime suspends by turning itself off
> (and updating the PCI current_state of dependent devices to D3cold).
> When the power resource runtime resumes, it schedules a runtime resume
> of all dependent devices.

The sharing of power resources is covered already.  That's not the problem here.

The missing part is the runtime resume of dependent devices and I'm not even sure
if it needs to be done in general or for PCI devices only.  At least it doesn't need to be
done for devices that are not configured for wakeup, even on a PCI bus.

Thanks,
Rafael



