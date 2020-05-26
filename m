Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7361E338D
	for <lists+linux-pci@lfdr.de>; Wed, 27 May 2020 01:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389728AbgEZXSl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 19:18:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:56936 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389709AbgEZXSl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 May 2020 19:18:41 -0400
IronPort-SDR: PDLdGCUmwFUFd/WsIREBQAwnqGyfilP7n37QujhabXSSzBv2ghg2JHzd5En3m6LpW/CBberDcT
 4yl6eEHbqFUQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 16:18:40 -0700
IronPort-SDR: Li330vBe6ISt2pvFdqKegpO1Sndq+68bSDB5BLBY2Px7m46MYPkStA2Dp0wC9BHNS/AdPnm65I
 9eAJ1dAPEcXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,439,1583222400"; 
   d="scan'208";a="291378667"
Received: from zalvear-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.254.67.58])
  by fmsmga004.fm.intel.com with ESMTP; 26 May 2020 16:18:40 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v4 0/5] Remove AER HEST table parser
Date:   Tue, 26 May 2020 16:18:24 -0700
Message-Id: <cover.1590534843.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Commit c100beb9ccfb ("PCI/AER: Use only _OSC to determine AER ownership")
removed HEST dependency in determining the AER ownership status. The
following patch set cleansup rest of the HEST table related code from
AER driver.

This patchset also includes some minor AER driver fixes.

Changes since v3:
 * Fixed compilation issues reported by kbuild test robot.

Changes since v2:
 * Fixed commit sha id for patch "PCI/AER: Use only _OSC to determine AER ownership".

Kuppuswamy Sathyanarayanan (5):
  PCI/AER: Remove redundant pci_is_pcie() checks.
  PCI/AER: Remove redundant dev->aer_cap checks.
  ACPI/PCI: Ignore _OSC negotiation result if pcie_ports_native is set.
  ACPI/PCI: Ignore _OSC DPC negotiation result if pcie_ports_dpc_native
    is set.
  PCI/AER: Replace pcie_aer_get_firmware_first() with
    pcie_aer_is_native()

 drivers/acpi/pci_root.c    |  28 ++++----
 drivers/pci/pcie/aer.c     | 139 ++++---------------------------------
 drivers/pci/pcie/dpc.c     |   2 +-
 drivers/pci/pcie/portdrv.h |  15 +---
 include/linux/pci.h        |   2 +
 5 files changed, 34 insertions(+), 152 deletions(-)

-- 
2.17.1

