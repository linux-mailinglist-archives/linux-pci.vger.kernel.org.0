Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B321BB2F2
	for <lists+linux-pci@lfdr.de>; Tue, 28 Apr 2020 02:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgD1Acz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 20:32:55 -0400
Received: from mga03.intel.com ([134.134.136.65]:53455 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbgD1Acv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Apr 2020 20:32:51 -0400
IronPort-SDR: WE4VW56HMcP6Yb/KYWFvfKAagHJCrtiVcgOdEoH0EBFFICUlttHJ4Vr0Z7lw0wVBIdoUa/Egw+
 vZTb4rC73Ajg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 17:32:50 -0700
IronPort-SDR: S6siCG9eoW2gDi2go+lBLTfZ0I6oOsSrhS7as1w04pGxOS2bxIxLT4+UTXar1EAtw952ZV1v7r
 GTUljKNc4dnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,325,1583222400"; 
   d="scan'208";a="367331794"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 27 Apr 2020 17:32:49 -0700
Received: from debox1-hc.jf.intel.com (debox1-hc.jf.intel.com [10.54.75.159])
        by linux.intel.com (Postfix) with ESMTP id C52EB58081E;
        Mon, 27 Apr 2020 17:32:49 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, bhelgaas@google.com,
        kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 2/2] drivers/nvme: Add support for ACPI StorageD3Enable property
Date:   Mon, 27 Apr 2020 17:32:14 -0700
Message-Id: <20200428003214.3764-3-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200428003214.3764-1-david.e.box@linux.intel.com>
References: <20200428003214.3764-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

NVMe storage power management during suspend-to-idle, particularly on
laptops, has been inconsistent with some devices working with D3 while
others must rely on NVMe APST in order for power savings to be realized.
Currently the default is to use APST unless quirked to do otherwise.
However newer platforms, like Intel Comet Lake systems, may require NVMe
drives to use D3 in order for the PCIe ports to be properly power managed.
To make it easier for drivers to choose, these platforms may supply a
special "StorageD3Enable" _DSD property under the root port that the device
is attached to. If supplied, the driver must use D3 in order for the
platform to realize the deepest power savings in suspend-to-idle.

Add check of StorageD3Enable property during probe to use D3 as specified
by platform firmware.

Acked-by: Dan Williams <dan.j.williams@intel.com>
Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/nvme/host/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4e79e412b276..4d67735975f6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2777,6 +2777,13 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	quirks |= check_vendor_combination_bug(pdev);
 
+	/*
+	 * Platform requires storage device to use D3 for kernel managed
+	 * suspend.
+	 */
+	if (pdev->storage_d3)
+		quirks |= NVME_QUIRK_SIMPLE_SUSPEND;
+
 	/*
 	 * Double check that our mempool alloc size will cover the biggest
 	 * command we support.
-- 
2.20.1

