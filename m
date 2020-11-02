Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FA92A35B8
	for <lists+linux-pci@lfdr.de>; Mon,  2 Nov 2020 22:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgKBVAw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 16:00:52 -0500
Received: from mga17.intel.com ([192.55.52.151]:16890 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbgKBVA2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Nov 2020 16:00:28 -0500
IronPort-SDR: uG8cB7L4HRZ6daE6bCaA8NDIkjSFIm8Bjr6//A7ygg0byArITsaXNDHX9BxGFYTfTaBqMiLKwn
 zIg+StRUqJMw==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="148807055"
X-IronPort-AV: E=Sophos;i="5.77,445,1596524400"; 
   d="scan'208";a="148807055"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 13:00:28 -0800
IronPort-SDR: KQ+SNPzFTT4B16KXnEVj9TbVs966y4HJPKIsychEFbktrvaujLszxuX8PDeA3RqqLWPHQv2h7i
 yFcUIeYMS5+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,445,1596524400"; 
   d="scan'208";a="305572035"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 02 Nov 2020 13:00:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A81DB12A; Mon,  2 Nov 2020 23:00:25 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH v4 0/6] resource: introduce union(), intersection() API
Date:   Mon,  2 Nov 2020 23:00:19 +0200
Message-Id: <20201102210025.53520-1-andriy.shevchenko@linux.intel.com>
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

Andy Shevchenko (6):
  resource: Simplify region_intersects() by reducing conditionals
  resource: Group resource_overlaps() with other inline helpers
  resource: Introduce resource_union() for overlapping resources
  resource: Introduce resource_intersection() for overlapping resources
  PCI/ACPI: Replace open coded variant of resource_union()
  ACPI: watchdog: Replace open coded variant of resource_union()

 drivers/acpi/acpi_watchdog.c |  6 +-----
 drivers/acpi/pci_root.c      |  4 +---
 include/linux/ioport.h       | 34 +++++++++++++++++++++++++++-------
 kernel/resource.c            | 10 +++++-----
 4 files changed, 34 insertions(+), 20 deletions(-)

-- 
2.28.0

