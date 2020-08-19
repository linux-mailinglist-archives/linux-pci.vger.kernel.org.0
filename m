Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E959249CFF
	for <lists+linux-pci@lfdr.de>; Wed, 19 Aug 2020 13:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgHSL7S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Aug 2020 07:59:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:34054 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728207AbgHSL7N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Aug 2020 07:59:13 -0400
IronPort-SDR: l/Vi+p/oYDFIQJwWbC5851F8JjEQnuFR0gtB1Y2dcbKHvvvjDDdn3MOvj/9K/deaTYGCWQ8nIn
 QBF+QwcqC7Pg==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="134610550"
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="134610550"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 04:59:10 -0700
IronPort-SDR: 0WeEkQrRE1815QZ5UKWM7RLitpA5/2/UWF8TiRGsVS+Dr5XU01lFBN42/NXfcjuBBt0n1uPYcK
 myHhCWxaOYtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="293095693"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 19 Aug 2020 04:59:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 493281FD; Wed, 19 Aug 2020 14:59:06 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-usb@vger.kernel.org
Cc:     Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Dana Alkattan <dana.alkattan@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 00/19] thunderbolt: Power Management improvements
Date:   Wed, 19 Aug 2020 14:58:46 +0300
Message-Id: <20200819115905.59834-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

This series improves power management in the Thunderbolt driver. We already
have a quite complete power management on systems where Firmware based
Connection Manager is used (this is pretty much all non-Apple systems out
there) so this series adds a couple of optimizations to make certain power
transitions slightly faster, hopefully improving user experience.

Rest of the patches improve power management in the Software Connection
manager side of the driver. USB4 spec covers power management for USB4
hosts and devices, and also TBT3 compatible devices so these patches
implement that. We also switch to use device links instead of PCI quirk to
make sure the Thunderbolt/USB4 host controller is resumed before tunneled
PCIe and USB 3.x ports (so that it gets the chance to restore the tunnels
properly before). Tiger Lake systems with Software Connection Manager
enabled describe these relationships using a new ACPI _DSD property that we
parse in the driver and populate device links accordingly.

Mika Westerberg (17):
  thunderbolt: Software CM only should set force power in Tiger Lake
  thunderbolt: Use bit 31 to check if Firmware CM is running in Tiger Lake
  thunderbolt: Do not program NFC buffers for USB4 router protocol adapters
  thunderbolt: No need to log an error if tb_switch_lane_bonding_enable() fails
  thunderbolt: Send reset only to first generation routers
  thunderbolt: Tear down DP tunnels when suspending
  thunderbolt: Initialize TMU again on resume
  thunderbolt: Do not change default USB4 router notification timeout
  thunderbolt: Configure link after lane bonding is enabled
  thunderbolt: Set port configured for both ends of the link
  thunderbolt: Configure port for XDomain
  thunderbolt: Disable lane 1 for XDomain connection
  thunderbolt: Enable wakes from system suspend
  PCI / thunderbolt: Switch to use device links instead of PCI quirk
  ACPI: Export acpi_get_first_physical_node() to modules
  thunderbolt: Create device links from ACPI description
  thunderbolt: Add runtime PM for Software CM

Rajmohan Mani (2):
  thunderbolt: Optimize Force Power logic
  thunderbolt: Optimize NHI LC mailbox command processing

 drivers/acpi/bus.c            |   1 +
 drivers/pci/quirks.c          |  57 --------
 drivers/thunderbolt/Makefile  |   2 +
 drivers/thunderbolt/acpi.c    | 117 ++++++++++++++++
 drivers/thunderbolt/domain.c  |   2 +
 drivers/thunderbolt/icm.c     |   5 +-
 drivers/thunderbolt/lc.c      | 151 ++++++++++++++++----
 drivers/thunderbolt/nhi.c     |  69 ++++++++++
 drivers/thunderbolt/nhi_ops.c |  31 +++--
 drivers/thunderbolt/switch.c  | 209 +++++++++++++++++++++++-----
 drivers/thunderbolt/tb.c      | 189 +++++++++++++++++++++++--
 drivers/thunderbolt/tb.h      |  35 ++++-
 drivers/thunderbolt/tb_regs.h |  16 +++
 drivers/thunderbolt/usb4.c    | 251 ++++++++++++++++++++++++++--------
 14 files changed, 935 insertions(+), 200 deletions(-)
 create mode 100644 drivers/thunderbolt/acpi.c

-- 
2.28.0

