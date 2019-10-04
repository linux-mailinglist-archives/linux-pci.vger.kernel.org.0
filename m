Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30816CBAA8
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2019 14:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387756AbfJDMjx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Oct 2019 08:39:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:46473 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387412AbfJDMjw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Oct 2019 08:39:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 05:39:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,256,1566889200"; 
   d="scan'208";a="222127758"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 04 Oct 2019 05:39:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id AFFDB14E; Fri,  4 Oct 2019 15:39:47 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Matthias Andree <matthias.andree@gmx.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] PCI: Add missing link delays
Date:   Fri,  4 Oct 2019 15:39:45 +0300
Message-Id: <20191004123947.11087-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

This is second version of the reworked PCIe link delay patch posted earlier
here:

  https://patchwork.kernel.org/patch/11106611/

Changes from v1:

  * Introduce pcie_wait_for_link_delay() in a separate patch
  * Tidy up changelog, remove some debug output
  * Rename pcie_wait_downstream_accessible() to
    pci_bridge_wait_for_secondary_bus() and make it generic to all PCI
    bridges.
  * Handle Tpvrh + Trhfa for conventional PCI even though we don't do PM
    for them right now.
  * Use pci_dbg() instead of dev_dbg().
  * Dropped check for pm_suspend_no_platform() and only check for D3cold.
  * Drop pcie_get_downstream_delay(), same delay applies equally to all
    devices (it is not entirely clear from the spec).

I'm still checking for downstream device because I think we can skip the
delays if there is nothing connected. The reason is that if device is added
when the downstream/root port is in D3 the delay is handled by pciehp in
its board_added(). In case of ACPI hotplug the firmware is supposed to
configure the device (and handle the delay).

I also checked we do resume sibling devices in paraller (I think due to
async_suspend).

@Matthias, @Paul and @Nicholas, I appreciate if you could check that this
does not cause any issues for your systems.

Mika Westerberg (2):
  PCI: Introduce pcie_wait_for_link_delay()
  PCI: Add missing link delays required by the PCIe spec

 drivers/pci/pci-driver.c |  18 +++++++
 drivers/pci/pci.c        | 113 +++++++++++++++++++++++++++++++++++----
 drivers/pci/pci.h        |   1 +
 3 files changed, 122 insertions(+), 10 deletions(-)

-- 
2.23.0

