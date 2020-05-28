Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E4F1E547C
	for <lists+linux-pci@lfdr.de>; Thu, 28 May 2020 05:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgE1DTE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 May 2020 23:19:04 -0400
Received: from mga07.intel.com ([134.134.136.100]:13839 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbgE1DTE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 May 2020 23:19:04 -0400
IronPort-SDR: BiumzsRk203bOGW10LASkNvJDu19AHmrsUazcmhzqH5XABeOFM7+ucJpbEq19JgFhrrLKTTpf5
 BVRVxvS9rD6w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 20:19:03 -0700
IronPort-SDR: t+LtGEXeARTMZ2Shl4OcySXEvKYq1dxLLhGLiO4TWavy2Cle9hP4FaSwFvPcQ/YYbh8NtNj14I
 J73oamybp/Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,443,1583222400"; 
   d="scan'208";a="310775941"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.74])
  by FMSMGA003.fm.intel.com with ESMTP; 27 May 2020 20:19:03 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>, qemu-devel@nongnu.org
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        virtualization@lists.linux-foundation.org,
        Christoph Hellwig <hch@lst.de>,
        Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v3 0/2] VMD endpoint passthrough support
Date:   Wed, 27 May 2020 23:02:37 -0400
Message-Id: <20200528030240.16024-1-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This set contains 2 patches for Linux and 1 for QEMU. VMD device
8086:28C0 contains information in registers to assist with direct
assignment passthrough. Several other VMD devices don't have this
information, but hypervisors can easily provide the guest with this
information through various means.

The QEMU patch provides the information in an emulated vendor-specific
PCI capability. Existing VMD devices don't conflict with the offset
chosen for the capability.

The Linux patch allows guest kernels to use the passthrough information
emulated by the QEMU patch, by matching against the vendor-specific PCI
capability if it exists.

V2 Ref:
https://lore.kernel.org/linux-pci/20200511190129.9313-1-jonathan.derrick@intel.com/

Changes from v2:
Uses vendor-specific PCI capability rather than emulating the 28C0
MEMBAR/VMLOCK modes.

Changes from v1:
v1 changed the VMD Subsystem ID to QEMU's so that the guest driver could
match against it. This was unnecessary as the VMLOCK register and shadow
membar registers could be safely emulated. Future VMDs will be aligned
on these register bits.

Jon Derrick (2):
  PCI: vmd: Filter resource type bits from shadow register
  PCI: vmd: Use Shadow MEMBAR registers for QEMU/KVM guests

 drivers/pci/controller/vmd.c | 50 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 8 deletions(-)

-- 
1.8.3.1

