Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC4D2A5104
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 21:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgKCUhA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 15:37:00 -0500
Received: from mga18.intel.com ([134.134.136.126]:55780 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729502AbgKCUg7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Nov 2020 15:36:59 -0500
IronPort-SDR: bmVLRXqmEcn5igGpkQ1FL937QnwVEwI5zprSXMAK1MTv5RqrhgtjPY5bxojte0Y9A+0bEe0uMS
 spILSwbUrfiA==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="156898590"
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="156898590"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 12:36:58 -0800
IronPort-SDR: 8W/pMaqCngLbMEg5q0pWuMWJn6ULD6UnHvVEUojd1NlMvJiiFG/90mzx86cW3t/kebuG132HDD
 ieLAp4hxDPfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="352454745"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 03 Nov 2020 12:36:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D74DA12A; Tue,  3 Nov 2020 22:36:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH v5 0/7] resource: introduce union(), intersection() API
Date:   Tue,  3 Nov 2020 22:36:48 +0200
Message-Id: <20201103203655.17701-1-andriy.shevchenko@linux.intel.com>
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

