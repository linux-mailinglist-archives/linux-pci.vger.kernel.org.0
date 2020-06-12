Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A1D1F7E37
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jun 2020 22:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgFLUsT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Jun 2020 16:48:19 -0400
Received: from mga17.intel.com ([192.55.52.151]:1168 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbgFLUsS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Jun 2020 16:48:18 -0400
IronPort-SDR: 9P098SalwTvKwqfOF9//WVn7gWAJTSED4hIMylUglgtv1On6+xyn7Jyegs74dMpa2DhHjU/Rcf
 KVWAEOvexEzQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2020 13:48:17 -0700
IronPort-SDR: 3MfeTCozN7FPSQrnsX3nzouD+Rf998ENV6PE36NyhpvxXUaau82Z14vNnqGRZYkZULZiFrq52M
 dLP7f54KZ0jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,504,1583222400"; 
   d="scan'208";a="275863120"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 12 Jun 2020 13:48:17 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id 516885803C5;
        Fri, 12 Jun 2020 13:48:17 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     shyjumon.n@intel.com, rjw@rjwysocki.net, lenb@kernel.org,
        bhelgaas@google.com, dan.j.williams@intel.com, kbusch@kernel.org,
        axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH V2 2/2] drivers/nvme: Add support for ACPI StorageD3Enable property
Date:   Fri, 12 Jun 2020 13:48:20 -0700
Message-Id: <20200612204820.20111-3-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200428003214.3764-1-david.e.box@linux.intel.com>
References: <20200428003214.3764-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch implements a solution for a BIOS hack used on some currently
shipping Intel systems to address issues with power management policy
decisions concerning PCIe NVMe drives. Some newer Intel platforms, like
some Comet Lake systems, require that PCIe devices use D3 when doing
suspend-to-idle in order to allow the platform to realize maximum power
savings. This is particularly needed to support ATX power supply shutdown
on desktop systems. In order to ensure this happens for root ports with
storage devices, Microsoft apparently created this ACPI _DSD property as a
way to override their driver policy. To my knowledge this property has not
been discussed with the NVME specification body.

Though the solution is not ideal, it addresses a problem that also affects
Linux since the NVMe driver's default policy of using NVMe APST during
suspend-to-idle would lead to higher power consumption for these platforms.

The patch uses the previously added pci_acpi_storage_d3 function to check
for the StorageD3Enable property during probe and enables D3 as a quirk if
set.  It also provides a 'noacpi' module parameter to allow skipping the
quirk if needed.

Tested on:
PM961 NVMe SED Samsung 512GB
INTEL SSDPEKKF512G8

Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvme/host/pci.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4e79e412b276..427505c47e79 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -78,6 +78,10 @@ static unsigned int poll_queues;
 module_param(poll_queues, uint, 0644);
 MODULE_PARM_DESC(poll_queues, "Number of queues to use for polled IO.");
 
+static bool noacpi;
+module_param(noacpi, bool, 0444);
+MODULE_PARM_DESC(noacpi, "disable all acpi bios quirks");
+
 struct nvme_dev;
 struct nvme_queue;
 
@@ -2777,6 +2781,16 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	quirks |= check_vendor_combination_bug(pdev);
 
+	if (!noacpi && pci_acpi_storage_d3(pdev)) {
+		/*
+		 * Some systems use a bios work around to ask for D3 on
+		 * platforms that support kernel managed suspend.
+		 */
+		dev_info(&pdev->dev,
+			 "platform quirk: setting simple suspend\n");
+		quirks |= NVME_QUIRK_SIMPLE_SUSPEND;
+	}
+
 	/*
 	 * Double check that our mempool alloc size will cover the biggest
 	 * command we support.
-- 
2.20.1

