Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818CA446B5A
	for <lists+linux-pci@lfdr.de>; Sat,  6 Nov 2021 00:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhKEXxj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Nov 2021 19:53:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:39417 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232810AbhKEXxi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Nov 2021 19:53:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10159"; a="295446280"
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="295446280"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 16:50:58 -0700
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="502172640"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 16:50:58 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 0/5] CXL: Read CDAT and DSMAS data from the device.
Date:   Fri,  5 Nov 2021 16:50:51 -0700
Message-Id: <20211105235056.3711389-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

This work was built on Jonathan's V4 series here[1].  The big change is a
conversion to an Auxiliary bus infrastructure which allows the DOE code to be
in a separate driver object which is attached to any DOE devices created by any
device.

The series creates a new DOE auxiliary bus driver.  The CXL devices are
modified to create DOE auxiliary devices to be driven by the new DOE driver.

After the devices are created and the driver attaches, CDAT data is read from
the device and DSMAS information parsed from that CDAT blob for use later.

This work was tested using qemu with additional patches.[2, 3]

[1] https://lore.kernel.org/linux-cxl/20210524133938.2815206-1-Jonathan.Cameron@huawei.com
[2] https://lore.kernel.org/qemu-devel/20210202005948.241655-1-ben.widawsky@intel.com/
[3] https://lore.kernel.org/qemu-devel/1619454964-10190-1-git-send-email-cbrowy@avery-design.com/

Ira Weiny (1):
  cxl/cdat: Parse out DSMAS data from CDAT table

Jonathan Cameron (4):
  PCI: Add vendor ID for the PCI SIG
  PCI/DOE: Add Data Object Exchange Aux Driver
  cxl/pci: Add DOE Auxiliary Devices
  cxl/mem: Add CDAT table reading from DOE

 drivers/cxl/Kconfig           |   1 +
 drivers/cxl/cdat.h            |  81 ++++
 drivers/cxl/core/memdev.c     | 157 ++++++++
 drivers/cxl/cxl.h             |  20 +
 drivers/cxl/cxlmem.h          |  48 +++
 drivers/cxl/pci.c             | 212 ++++++++++
 drivers/pci/Kconfig           |  10 +
 drivers/pci/Makefile          |   3 +
 drivers/pci/doe.c             | 701 ++++++++++++++++++++++++++++++++++
 include/linux/pci-doe.h       |  63 +++
 include/linux/pci_ids.h       |   1 +
 include/uapi/linux/pci_regs.h |  29 +-
 12 files changed, 1325 insertions(+), 1 deletion(-)
 create mode 100644 drivers/cxl/cdat.h
 create mode 100644 drivers/pci/doe.c
 create mode 100644 include/linux/pci-doe.h

-- 
2.28.0.rc0.12.gb6a658bd00c9

