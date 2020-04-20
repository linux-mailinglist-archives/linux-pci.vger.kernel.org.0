Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA371B18F1
	for <lists+linux-pci@lfdr.de>; Tue, 21 Apr 2020 00:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgDTWBK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Apr 2020 18:01:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:16270 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgDTWBK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Apr 2020 18:01:10 -0400
IronPort-SDR: qoKQfzJteL6RsgVaj3P4Yh5WIKXd7CNFILYXA790Hs7HO4gfQMQp0475twJRuDUWVbtjeJ5NYn
 /eIut/iIlViQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 15:01:09 -0700
IronPort-SDR: v2mUQIi7v4D2xKtxr60yP70J2b/UTKidQjQWc+qcN/GLGbMyj6G/H9MxT9qEkCptVqixd2RvNN
 D8D5syiZFlVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,407,1580803200"; 
   d="scan'208";a="455848311"
Received: from unknown (HELO nsgsw-wilsonpoint.lm.intel.com) ([10.232.116.102])
  by fmsmga005.fm.intel.com with ESMTP; 20 Apr 2020 15:01:07 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     <linux-pci@vger.kernel.org>, Keith Busch <kbusch@kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Rajat Jain <rajatja@google.com>,
        "Patel, Mayurkumar" <mayurkumar.patel@intel.com>,
        Olof Johansson <olof@lixom.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Honoring Native AER/DPC Host Bridges
Date:   Mon, 20 Apr 2020 15:37:08 -0600
Message-Id: <1587418630-13562-1-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The two patches here force AER and DPC to honor the Host Bridge's Native
AER/DPC settings. This is under the assumption that when these bits are set,
that Firmware-First AER/DPC should not be in use for these ports. This
assumption seems to be true in ACPI, which explicitly clears these capability
settings in the host bridge if the service cannot be negotiated with _OSC.

This also fixes an issue I've seen in a few platforms whose BIOS and/or switch
firmware leaves DPC preconfigured. In these cases, the kernel DPC driver cannot
bind a handler to the interrupt and could result in unmanaged DPC link down
events.

Jon Derrick (2):
  PCI/AER: Allow Native AER Host Bridges to use AER
  PCI/DPC: Allow Native DPC Host Bridges to use DPC

 drivers/pci/pcie/aer.c          | 3 +++
 drivers/pci/pcie/dpc.c          | 3 ++-
 drivers/pci/pcie/portdrv_core.c | 3 ++-
 3 files changed, 7 insertions(+), 2 deletions(-)

-- 
1.8.3.1

