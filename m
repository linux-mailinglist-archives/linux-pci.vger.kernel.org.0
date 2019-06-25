Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28D6F5298C
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 12:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfFYKaJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 06:30:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:39954 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731972AbfFYK3q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Jun 2019 06:29:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2019 03:29:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,415,1557212400"; 
   d="scan'208";a="169741352"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Jun 2019 03:29:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 2ED35162; Tue, 25 Jun 2019 13:29:42 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v3 0/3] PCI / ACPI: Handle sibling devices sharing power resources
Date:   Tue, 25 Jun 2019 13:29:39 +0300
Message-Id: <20190625102942.27740-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

This is third iteration of the patch series addressing issues around
sibling PCI devices sharing ACPI power resources.

As a concrete example in Intel Ice Lake the Thunderbolt controller, PCIe
root ports and xHCI all share the same ACPI power resources. When they are
all in D3hot power resources (returned by _PR3) can be turned off powering
off the whole block. However, there are two issues around this.

Firstly the PCI core sets the device power state by asking what the real
ACPI power state is. This results that all but last device sharing the
power resources are in D3hot when the power resources are turned off. This
causes issues if user runs for example 'lspci' because the device is really
in D3cold so what user gets back is all ones (0xffffffff).

Secondly if any of the device is runtime resumed the power resources are
turned on bringing all other devices sharing the resources to
D0uninitialized losing their wakeup configuration.

This series aims to fix the two issues by:

  1. Using the ACPI cached power state when PCI devices are transitioned
     into low power states instead of reading back the "real" power state.

  2. Introducing concept of "_PR0 dependent devices" that get runtime
     resumed whenever their power resource (which they might share with
     other sibling devices) gets turned on.

The series is based on the idea of Rafael J. Wysocki <rafael@kernel.org>.

Previous version of the series can be found here:

  v2: https://lore.kernel.org/linux-pci/20190618161858.77834-1-mika.westerberg@linux.intel.com/T/#m7a41d0b745400054543324ce84125040dbfed912
  v1: https://www.spinics.net/lists/linux-pci/msg83583.html

Changes from v2:

  * Updated changelog of patch [1/3] according to comments I got. I left
    the D3C power resource and xHCI there because it shows that we can have
    multiple shared power resources.

  * Added link to the discussion around v2.

  * Use adev->flags.power_manageable in patch [2/3].

Mika Westerberg (3):
  PCI / ACPI: Use cached ACPI device state to get PCI device power state
  ACPI / PM: Introduce concept of a _PR0 dependent device
  PCI / ACPI: Add _PR0 dependent devices

 drivers/acpi/power.c    | 135 ++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci-acpi.c  |   5 +-
 include/acpi/acpi_bus.h |   4 ++
 3 files changed, 143 insertions(+), 1 deletion(-)

-- 
2.20.1

