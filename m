Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1DB6749D5
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jan 2023 04:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjATDPa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Jan 2023 22:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjATDP1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2023 22:15:27 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB30146B5;
        Thu, 19 Jan 2023 19:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674184523; x=1705720523;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4jDmbEZOq20imEpmSNigsxyKvHJRHXqj30rz4w/7Fss=;
  b=FKFLa4Q8nHR/4cIBB8XOWkYacBBEXzHpK5Qp5Y1CHu62RqH9Z67S3jiQ
   3IyRuDrNNhZZd/sD1GrQPwM/ZdyALM5kdnUV0A0ynmsovZPueEp8BtHaz
   eS3OdokIiISQyjSAnimVa9P/EpbcE5+NoyTPenK8WstFq1PfWcBfOSdfC
   z500O6sp6SBRICbkLTR9bq1wBXVIpKVKcfW0YkeTqLmB/5rW/EzaFII5H
   xGDPDFwgvs+WtSx3YHJpn6oOtHbpyPEKHLao0FKZuAYWbNeYWuKA5M7xJ
   lsvofcCFFvHY1rwPUPBWD0daXG64J+rATBHx8pXkyEvGPqSW3yGnFI9F4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="390012670"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="390012670"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 19:15:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="638009303"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="638009303"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 19 Jan 2023 19:15:22 -0800
Received: from debox1-desk4.intel.com (unknown [10.212.255.207])
        by linux.intel.com (Postfix) with ESMTP id 9F35B580AFF;
        Thu, 19 Jan 2023 19:15:22 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     david.e.box@linux.intel.com, nirmal.patel@linux.intel.com,
        jonathan.derrick@linux.dev, lorenzo.pieralisi@arm.com,
        hch@infradead.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, michael.a.bottini@intel.com,
        rafael@kernel.org, me@adhityamohan.in
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V10 0/4] Enable PCIe ASPM and LTR on select hardware
Date:   Thu, 19 Jan 2023 19:15:18 -0800
Message-Id: <20230120031522.2304439-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series adds a work around for enabling PCIe ASPM and for setting PCIe
LTR values on VMD reserved root ports on select platforms. While
configuration of these capabilities is usually done by BIOS, on these
platforms these capabilities will not be configured because the ports are
not visible to BIOS. This was part of an initial design that expected the
driver to completely handle the ports, including power management. However
on Linux those ports are still managed by the PCIe core, which has the
expectation that they adhere to device standards including BIOS
configuration, leading to this problem.

The target platforms are Tiger Lake, Alder Lake, and Raptor Lake though the
latter has already implemented support for configuring the LTR values.
Meteor Lake is expected add BIOS ASPM support, eliminating the future need
for this work around.

Note, the driver programs the LTRs because BIOS would also normally do this
for devices that do not set them by default. Without this, SoC power
management would be blocked on those platform. This SoC specific value is
the maximum latency required to allow the SoC to enter the deepest power
state.

This patch addresses the following open bugzillas on VMD enabled laptops
that cannot enter low power states.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=212355
Link: https://bugzilla.kernel.org/show_bug.cgi?id=215063
Link: https://bugzilla.kernel.org/show_bug.cgi?id=213717

David E. Box (3):
  PCI: vmd: Use PCI_VDEVICE in device list
  PCI: vmd: Create feature grouping for client products
  PCI: vmd: Add quirk to configure PCIe ASPM and LTR

Michael Bottini (1):
  PCI/ASPM: Add pci_enable_link_state()

 drivers/pci/controller/vmd.c | 97 ++++++++++++++++++++++++++----------
 drivers/pci/pcie/aspm.c      | 54 ++++++++++++++++++++
 include/linux/pci.h          |  7 +++
 3 files changed, 132 insertions(+), 26 deletions(-)


base-commit: 5dc4c995db9eb45f6373a956eb1f69460e69e6d4
-- 
2.34.1

