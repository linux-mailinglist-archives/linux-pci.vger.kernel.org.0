Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F32FD60363
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2019 11:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbfGEJui (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jul 2019 05:50:38 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42261 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbfGEJui (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Jul 2019 05:50:38 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 46046217919f682c; Fri, 5 Jul 2019 11:50:35 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans De Goede <hdegoede@redhat.com>,
        "Robert R. Howell" <RHowell@uwyo.edu>
Subject: Re: [PATCH v2 0/5] PM: PCI/ACPI: Hibernation handling fixes
Date:   Fri, 05 Jul 2019 11:50:35 +0200
Message-ID: <3380486.WkxyVYbAKD@kreacher>
In-Reply-To: <20190701162017.GB2640@lahna.fi.intel.com>
References: <4976412.ihyb9sT5jY@kreacher> <20190701162017.GB2640@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday, July 1, 2019 6:20:17 PM CEST Mika Westerberg wrote:
> On Mon, Jul 01, 2019 at 12:42:14PM +0200, Rafael J. Wysocki wrote:
> > Hi All,
> > 
> > This series of patches addresses a few issues related to the handling of
> > hibernation in the PCI bus type and the ACPI PM domain and ACPI LPSS driver.
> > 
> > The v2 addresses Hans' concerns regarding the LPSS changes.
> > 
> > First of all, all of the runtime-suspended PCI devices and devices in the ACPI PM and LPSS
> > PM domains will be resumed during hibernation (first patch).  This appears to be the
> > only way to avoid weird corner cases and the benefit from avoiding to resume those
> > devices during hibernation is questionable.
> > 
> > That change allows the the hibernation callbacks in all of the involved subsystems to be
> > simplified (patches 2 and 3).
> > 
> > Moreover, reusing bus-level suspend callbacks for the "poweroff" transition during
> > hibernation (which is the case for the ACPI PM domain and LPSS) is incorrect, so patch 4
> > fixes that.
> > 
> > Finally, there are some leftover items in linux/acpi.h that can be dropped (patch 5).
> 
> For the whole series,
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 

Thanks!

Queued for 5.3 with the tags from you and Hans (I've fixed up comments in the first patch while applying it).




