Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4E12A58C2
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 22:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730994AbgKCVy4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 16:54:56 -0500
Received: from mga04.intel.com ([192.55.52.120]:64306 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730976AbgKCUpO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Nov 2020 15:45:14 -0500
IronPort-SDR: lK9uwlL9GEnHYmKUKjSsHnGNLiBtTiUjvJQjB9eFJl4d0TEDTt5ViHqUPn5rTuTo7WS85iorl/
 HWEaRBjdbqJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="166533693"
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="166533693"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 12:45:13 -0800
IronPort-SDR: Kn7pr1SjtLIO7vgNmRTf7Nx2eS+7gOaG6Wq5WPGE/3s2MLVxIWPA9WRQAf+dmRunEBuCRwTgp2
 cBCnBM6rWN6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="527317813"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 03 Nov 2020 12:45:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BB5A512A; Tue,  3 Nov 2020 22:45:10 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH v6 0/7] resource: introduce union(), intersection() API
Date:   Tue,  3 Nov 2020 22:45:03 +0200
Message-Id: <20201103204510.19154-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some users may want to use resource library to manage their own resources,
besides existing users that open code union() and intersection()
implementations.

Provide a generic API for wider use.

Changelog v6:
- added missed tags

Changelog v5:
- added test cases (Greg)

Changelog v4:
- added Rb tag (Rafael)
- Cc'ed to LKML and Greg (Rafael)

Changelog v3:
- rebased on top of v5.10-rc1
- dropped upstreamed dependencies
- added Rb tag to the last patch (Mika)

Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org

Andy Shevchenko (7):
  resource: Simplify region_intersects() by reducing conditionals
  resource: Group resource_overlaps() with other inline helpers
  resource: Introduce resource_union() for overlapping resources
  resource: Introduce resource_intersection() for overlapping resources
  resource: Add test cases for new resource API
  PCI/ACPI: Replace open coded variant of resource_union()
  ACPI: watchdog: Replace open coded variant of resource_union()

 drivers/acpi/acpi_watchdog.c |   6 +-
 drivers/acpi/pci_root.c      |   4 +-
 include/linux/ioport.h       |  34 ++++++--
 kernel/Makefile              |   1 +
 kernel/resource.c            |  10 +--
 kernel/resource_kunit.c      | 150 +++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug            |  11 +++
 7 files changed, 196 insertions(+), 20 deletions(-)
 create mode 100644 kernel/resource_kunit.c

-- 
2.28.0

