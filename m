Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3B93AB41
	for <lists+linux-pci@lfdr.de>; Sun,  9 Jun 2019 20:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbfFIS6j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Jun 2019 14:58:39 -0400
Received: from bmailout2.hostsharing.net ([83.223.90.240]:43575 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729082AbfFIS6i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Jun 2019 14:58:38 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id ED9DB2800B48A;
        Sun,  9 Jun 2019 20:58:35 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id AB6064D0F9; Sun,  9 Jun 2019 20:58:35 +0200 (CEST)
Date:   Sun, 9 Jun 2019 20:58:35 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/3] PCI / ACPI: Handle sibling devices sharing power
 resources
Message-ID: <20190609185835.cqjbgzfwajbg4kks@wunner.de>
References: <20190605145820.37169-1-mika.westerberg@linux.intel.com>
 <20190605145820.37169-4-mika.westerberg@linux.intel.com>
 <CAJZ5v0iGu8f6H68082RGDmDCQsmQZNTULLwnb5JzpKA7m1QvVA@mail.gmail.com>
 <20190606112640.GA2781@lahna.fi.intel.com>
 <20190606134419.GL2781@lahna.fi.intel.com>
 <CAJZ5v0gHTVPNc_LJzPCOLZpHU=wsbYQs__WabOQHmu8GPCChag@mail.gmail.com>
 <20190606141717.GM2781@lahna.fi.intel.com>
 <CAJZ5v0gwqMd0W43KQoU80=fdYooLkgPg1n0cbbAWjPqrOepYsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gwqMd0W43KQoU80=fdYooLkgPg1n0cbbAWjPqrOepYsg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 06, 2019 at 04:27:21PM +0200, Rafael J. Wysocki wrote:
> On Thu, Jun 6, 2019 at 4:17 PM Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> > On Thu, Jun 06, 2019 at 04:08:11PM +0200, Rafael J. Wysocki wrote:
> > > That isn't necessary IMO as long as the device are not accessed.  If
> > > the kernel thinks that a given device is in D3cold and doesn't access
> > > it, then it really doesn't matter too much what state the device is in
> > > physically.  On the first access the device should be reinitialized
> > > anyway.
> >
> > But if the device is configured to wake. For example when it detects a
> > hotplug that state is gone when it goes to D0unitialized.
> 
> For this we'll need a pm_runtime_resume() of the dependent device on
> the resource going "on".
> 
> That means we need a list of devices to resume when the resource goes
> "on" after being taken "off".

An idea would be to model every ACPI power resource as a struct device
and automatically set up a device link from the devices using that
power resource (consumers).  After all dependent devices runtime suspend,
the power resource "device" runtime suspends by turning itself off
(and updating the PCI current_state of dependent devices to D3cold).
When the power resource runtime resumes, it schedules a runtime resume
of all dependent devices.

Thanks,

Lukas
