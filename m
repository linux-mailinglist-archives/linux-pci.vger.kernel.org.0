Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E13275B934
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2019 12:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfGAKnj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jul 2019 06:43:39 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:56119 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfGAKnj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jul 2019 06:43:39 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id c2c9cab37650c19c; Mon, 1 Jul 2019 12:43:36 +0200
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
Subject: [PATCH v2 0/5] PM: PCI/ACPI: Hibernation handling fixes
Date:   Mon, 01 Jul 2019 12:42:14 +0200
Message-ID: <4976412.ihyb9sT5jY@kreacher>
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

The v2 addresses Hans' concerns regarding the LPSS changes.

First of all, all of the runtime-suspended PCI devices and devices in the ACPI PM and LPSS
PM domains will be resumed during hibernation (first patch).  This appears to be the
only way to avoid weird corner cases and the benefit from avoiding to resume those
devices during hibernation is questionable.

That change allows the the hibernation callbacks in all of the involved subsystems to be
simplified (patches 2 and 3).

Moreover, reusing bus-level suspend callbacks for the "poweroff" transition during
hibernation (which is the case for the ACPI PM domain and LPSS) is incorrect, so patch 4
fixes that.

Finally, there are some leftover items in linux/acpi.h that can be dropped (patch 5).

Thanks,
Rafael






