Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFE1448B3
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 19:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393559AbfFMRKl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 13:10:41 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:45376 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbfFLWix (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jun 2019 18:38:53 -0400
Received: from 79.184.253.190.ipv4.supernova.orange.pl (79.184.253.190) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 74cce591a9c77b62; Thu, 13 Jun 2019 00:38:51 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/3] PCI / ACPI: Handle sibling devices sharing power resources
Date:   Thu, 13 Jun 2019 00:38:50 +0200
Message-ID: <26924432.Xal58bVLXT@kreacher>
In-Reply-To: <20190606143606.GN2781@lahna.fi.intel.com>
References: <20190605145820.37169-1-mika.westerberg@linux.intel.com> <CAJZ5v0gwqMd0W43KQoU80=fdYooLkgPg1n0cbbAWjPqrOepYsg@mail.gmail.com> <20190606143606.GN2781@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday, June 6, 2019 4:36:06 PM CEST Mika Westerberg wrote:
> On Thu, Jun 06, 2019 at 04:27:21PM +0200, Rafael J. Wysocki wrote:
> > On Thu, Jun 6, 2019 at 4:17 PM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > >
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
> OK, thanks.

Basically, at the pci_acpi_setup() time dev and adev need to be passed to a function that
will add dev as a "dependent device" for each of the power resources in the adev's D0
list.

Next whenever a power resource with a list of "dependent devices" goes _ON successfully,
pm_request_resume() needs to be called for each device in that list.

Finally, at the pci_acpi_cleanup() time, dev needs to be removed from the lists of
"dependent devices" for all power resources in its ACPI companion's D0 list.

At least that's how I see that.



