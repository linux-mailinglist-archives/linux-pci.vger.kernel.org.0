Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B131F7E31
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jun 2020 22:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgFLUsH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Jun 2020 16:48:07 -0400
Received: from mga03.intel.com ([134.134.136.65]:44482 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbgFLUsH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Jun 2020 16:48:07 -0400
IronPort-SDR: T7EW+TBF+4jkSITuM1sJRqvEMPMwoc5BeoBbSP7NiKovzhr0T1bzkpq2Ofz2pvO2K/iCn/46yh
 p7281TyMm5CQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2020 13:48:07 -0700
IronPort-SDR: LFgYyzHi1cf6/D4dh3wIX+ANgQ30imkG5tn9trlkftoohDgt4bJgNWyrwJyDfgLr3bATu/+5G8
 CdBnIvZrXwzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,504,1583222400"; 
   d="scan'208";a="307352135"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 12 Jun 2020 13:48:06 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id C7EDF5803C5;
        Fri, 12 Jun 2020 13:48:06 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     shyjumon.n@intel.com, rjw@rjwysocki.net, lenb@kernel.org,
        bhelgaas@google.com, dan.j.williams@intel.com, kbusch@kernel.org,
        axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH V2 0/2] nvme: Add support for ACPI StorageD3Enable property
Date:   Fri, 12 Jun 2020 13:48:18 -0700
Message-Id: <20200612204820.20111-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200428003214.3764-1-david.e.box@linux.intel.com>
References: <20200428003214.3764-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch set implements a solution for a BIOS hack used on some currently
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

Patch 1 provides a symbol in the PCI/ACPI layer to read the property.
Patch 2 uses the symbol in the NVMe driver to select D3 as a quirk if set.

Changes from V2:
	- Export the pci_acpi_storage_d3 function for use by drivers as
	  needed instead of modifying the pci header.
	- Add missing put on acpi device handle.
	- Add 'noacpi' module parameter to allow undoing this change.
	- Add info message that this is a platform quirk.

David E. Box (2):
  PCI: Add ACPI StorageD3Enable _DSD support
  drivers/nvme: Add support for ACPI StorageD3Enable property

 drivers/acpi/property.c |  3 +++
 drivers/nvme/host/pci.c | 14 ++++++++++
 drivers/pci/pci-acpi.c  | 59 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h     |  2 ++
 4 files changed, 78 insertions(+)

-- 
2.20.1

