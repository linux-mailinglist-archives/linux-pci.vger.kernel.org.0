Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4117E1C0577
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 20:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgD3S7n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 14:59:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:41232 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbgD3S7l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Apr 2020 14:59:41 -0400
IronPort-SDR: PrkwaH9mR5483nBgQzYqgHRDUVaz5+p5NF08fcSMYO4UBi7N+bFUsK95X5/132PxdCnM9t5HmG
 lZhSXLe4SqJQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 11:59:39 -0700
IronPort-SDR: BlYZtidfD65fncyjXHDrpSCg2JPoKFEZmaEJHKVFahiz9xGTdY1EfI2WfTFBkrkhIfaS48FEMM
 Zxv56zbw3LhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,336,1583222400"; 
   d="scan'208";a="303360008"
Received: from unknown (HELO nsgsw-wilsonpoint.lm.intel.com) ([10.232.116.102])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Apr 2020 11:59:38 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     <linux-pci@vger.kernel.org>,
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
Subject: [PATCH v3 1/2] PCI/AER: Use _OSC to determine Firmware First before HEST
Date:   Thu, 30 Apr 2020 12:46:08 -0600
Message-Id: <1588272369-2145-2-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588272369-2145-1-git-send-email-jonathan.derrick@intel.com>
References: <1588272369-2145-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

After a5bf8719af: "PCI/AER: Use only _OSC to determine AER ownership",
_OSC is the primary determiner of ownership of Firmware First error
handling rather than HEST.

ACPI Root Bus enumeration has been modified to flag Host Bridge devices
as using Native AER when _OSC has been negotiated for AER services.

This patch ensures the PCI layers first uses the _OSC negotiated state
by checking the Host Bridge's Native AER flag prior to HEST parsing.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/pcie/aer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index efc2677..f3d02f4 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -314,6 +314,9 @@ int pcie_aer_get_firmware_first(struct pci_dev *dev)
 	if (pcie_ports_native)
 		return 0;
 
+	if (pci_find_host_bridge(dev->bus)->native_aer)
+		return 0;
+
 	if (!dev->__aer_firmware_first_valid)
 		aer_set_firmware_first(dev);
 	return dev->__aer_firmware_first;
-- 
1.8.3.1

