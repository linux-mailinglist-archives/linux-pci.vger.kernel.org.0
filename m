Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C962E1CE3BA
	for <lists+linux-pci@lfdr.de>; Mon, 11 May 2020 21:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731199AbgEKTRV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 May 2020 15:17:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:10033 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729453AbgEKTRU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 May 2020 15:17:20 -0400
IronPort-SDR: FQ0D/lyzM4w1/1yc9qN6B46OGKvXo/6lUk3IN7zbREdACUSgesA0BFnFY7096iTo3rexCDoo98
 zRjkfb0rEJOg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 12:17:20 -0700
IronPort-SDR: WjpuYqEF+qzqXPuACAFjsM92dYFGRCCWz6fzDpq8PNm2nU+qrb85LhLrkwpl4oJJdMYaY82LTH
 gfm/J0thY/mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,381,1583222400"; 
   d="scan'208";a="463494234"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.74])
  by fmsmga006.fm.intel.com with ESMTP; 11 May 2020 12:17:19 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>, qemu-devel@nongnu.org
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        virtualization@lists.linux-foundation.org,
        Christoph Hellwig <hch@lst.de>,
        Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v2 0/2] VMD endpoint passthrough support
Date:   Mon, 11 May 2020 15:01:26 -0400
Message-Id: <20200511190129.9313-1-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This set contains 2 patches for Linux and 1 for QEMU. VMD device
8086:28C0 contains information in registers to assist with direct
assignment passthrough. Several other VMD devices don't have this
information, but can easily be emulated to offer this feature.

The existing VMD devices not supporting the feature cannot be changed to
offer the information, but also don't restrict the ability to offer this
information in emulation by the hypervisor. Future VMD devices will
offer the 28C0 mode natively.

The QEMU patch emulates the hardware assistance that the VMD 28C0 device
provides: a config space register claiming passthrough support, and the
shadow membar registers containing the host information for guest
address assignment in the VMD domain. These VMD devices have this config
space register set as reserved and will not conflict with the emulated
bit.

The Linux patch allows guest kernels to use the passthrough information
emulated by the QEMU patch, by matching the config space register
claiming passthrough support.

Changes from v1:
v1 changed the VMD Subsystem ID to QEMU's so that the guest driver could
match against it. This was unnecessary as the VMLOCK register and shadow
membar registers could be safely emulated. Future VMDs will be aligned
on these register bits.

Added the resource bit filtering patch that got lost in the mailserver.

v1: https://lore.kernel.org/linux-pci/20200422171444.10992-1-jonathan.derrick@intel.com/

Jon Derrick (2):
  PCI: vmd: Filter resource type bits from shadow register
  PCI: vmd: Use Shadow MEMBAR registers for QEMU/KVM guests

 drivers/pci/controller/vmd.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

-- 
2.18.1

