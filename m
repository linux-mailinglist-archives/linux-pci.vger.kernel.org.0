Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD4065A9EE
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2019 11:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfF2JxM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Jun 2019 05:53:12 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52207 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbfF2JxL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Jun 2019 05:53:11 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id cb0f85cb5e292c0e; Sat, 29 Jun 2019 11:53:08 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans De Goede <hdegoede@redhat.com>,
        "Robert R. Howell" <RHowell@uwyo.edu>
Subject: [PATCH 0/6] PM: PCI/ACPI: Hibernation handling fixes
Date:   Sat, 29 Jun 2019 11:33:30 +0200
Message-ID: <2318839.0szTqvJMZa@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

This series of patches addresses a few issues related to the handling of
hibernation in the PCI bus type and the ACPI PM domain and ACPI LPSS driver.

First of all, all of the runtime-suspended PCI devices and devices in the ACPI PM and LPSS
PM domains will be resumed during hibernation (first patch).  This appears to be the
only way to avoid weird corner cases and the benefit from avoiding to resume those
devices during hibernation is questionable.

That change allows the the hibernation callbacks in all of the involved subsystems to be
simplified (patches 2 and 3).

While at it, there is a subtle issue in the LPSS suspend callbacks which is addressed
by patch 4.

Moreover, reusing bus-level suspend callbacks for the "poweroff" transition during
hibernation (which is the case for the ACPI PM domain and LPSS) is incorrect, so patch 5
fixes that.

Finally, there are some leftover items in linux/acpi.h that can be dropped (patch 6).

Thanks,
Rafael



