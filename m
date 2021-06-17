Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E893ABE6D
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jun 2021 23:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhFQV5u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Jun 2021 17:57:50 -0400
Received: from mga07.intel.com ([134.134.136.100]:16700 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230494AbhFQV5t (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Jun 2021 17:57:49 -0400
IronPort-SDR: 2zJZy86vQxPd/0B6aC9zSt3YGq5pcnZcRmxugSU18PFJwkBk3JzhFlYSf9an0mwp/ehcoWQomF
 0WSBYtOey0bg==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="270304152"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="270304152"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 14:55:41 -0700
IronPort-SDR: 1xhvMVZ1+S3+IX9VIl8+qKUkMfwdn9WaDjg/nl4pDQic89Khzk6wjKo2qVGAmI1Njri6OkQqV1
 jt4kbV0lnf2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="488810895"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 17 Jun 2021 14:55:40 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id 9A0645801CA;
        Thu, 17 Jun 2021 14:55:40 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     lee.jones@linaro.org, david.e.box@linux.intel.com,
        hdegoede@redhat.com, mgross@linux.intel.com, bhelgaas@google.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 0/4] MFD: intel_pmt: Split OOBMSM from intel_pmt driver
Date:   Thu, 17 Jun 2021 14:54:04 -0700
Message-Id: <20210617215408.1412409-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Most of the devices in the intel_pmt driver are PMT only devices. However,
the Out of Band Management Services Module (OOBMSM) can also be used
access non-PMT devices. In order to better support this without the
confusion of a dependency on MFD_INTEL_PMT, this patch set rewrites the
intel_pmt driver to split the functionality into 3 components:

	1. intel_pmt - driver for PMT only devices
	2. intel-oobmsm - driver for devices using the OOBMSM IP which can
	   support multiple types of capabilities, including PMT
	3. intel-extended-cap - symbols to handle adding platform device
	   for both drivers

Additionally, this patch set provides additional DVSEC macros in the PCI
header as well as support for reading capabilities from a VSEC structure.

Patch 1 - Adds PCI defines for DVSEC registers
Patch 2 - Removes OOBMSM from intel_pmt and creates intel-extended-cap.c
	  support the creation of platform devices for capabilities from
	  both intel_pmt and intel-oobmsm (Patch 3)
Patch 2 - Creates a separate driver for OOBMSM
Patch 3 - Adds support for reading capabilities from PCIe VSEC structures

For submission through MFD branch.

David E. Box (4):
  PCI: Add #defines for accessing PCIE DVSEC fields
  MFD: intel_pmt: Remove OOBMSM device for placement in own driver
  MFD: Add the Intel Out of Band Management Services Module (OOBMSM)
    driver
  MFD: intel-extended-cap: Add support for PCIe VSEC structures

 MAINTAINERS                                |   2 +
 drivers/mfd/Kconfig                        |  15 ++
 drivers/mfd/Makefile                       |   2 +
 drivers/mfd/intel_extended_caps.c          | 267 +++++++++++++++++++++
 drivers/mfd/intel_extended_caps.h          |  40 +++
 drivers/mfd/intel_oobmsm.c                 |  61 +++++
 drivers/mfd/intel_pmt.c                    | 198 ++-------------
 drivers/platform/x86/Kconfig               |   4 +-
 drivers/platform/x86/intel_pmt_crashlog.c  |   2 +-
 drivers/platform/x86/intel_pmt_telemetry.c |   2 +-
 include/uapi/linux/pci_regs.h              |   4 +
 11 files changed, 409 insertions(+), 188 deletions(-)
 create mode 100644 drivers/mfd/intel_extended_caps.c
 create mode 100644 drivers/mfd/intel_extended_caps.h
 create mode 100644 drivers/mfd/intel_oobmsm.c

-- 
2.25.1

