Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6F56035A
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2019 11:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfGEJsG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jul 2019 05:48:06 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57011 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbfGEJsF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Jul 2019 05:48:05 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id e6098ef7f880b9e0; Fri, 5 Jul 2019 11:48:02 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PCI: PM/ACPI: Refresh all stale power state data in pci_pm_complete()
Date:   Fri, 05 Jul 2019 11:48:02 +0200
Message-ID: <78143872.4kPcvaPlWD@kreacher>
In-Reply-To: <20190625160918.GK2640@lahna.fi.intel.com>
References: <6435024.1ODgWP2se3@kreacher> <20190625160918.GK2640@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday, June 25, 2019 6:09:18 PM CEST Mika Westerberg wrote:
> On Tue, Jun 25, 2019 at 02:09:12PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > In pci_pm_complete() there are checks to decide whether or not to
> > resume devices that were left in runtime-suspend during the preceding
> > system-wide transition into a sleep state.  They involve checking the
> > current power state of the device and comparing it with the power
> > state of it set before the preceding system-wide transition, but the
> > platform component of the device's power state is not handled
> > correctly in there.
> > 
> > Namely, on platforms with ACPI, the device power state information
> > needs to be updated with care, so that the reference counters of
> > power resources used by the device (if any) are set to ensure that
> > the refreshed power state of it will be maintained going forward.
> > 
> > To that end, introduce a new ->refresh_state() platform PM callback
> > for PCI devices, for asking the platform to refresh the device power
> > state data and ensure that the corresponding power state will be
> > maintained going forward, make it invoke acpi_device_update_power()
> > (for devices with ACPI PM) on platforms with ACPI and make
> > pci_pm_complete() use it, through a new pci_refresh_power_state()
> > wrapper function.
> > 
> > Fixes: a0d2a959d3da (PCI: Avoid unnecessary resume after direct-complete)
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> I also tested this on Ice Lake system and did not see any issues over
> several suspend-to-ram cycles.
> 

Thanks!

Patch queued for 5.3.




