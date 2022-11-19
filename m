Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EE06309F4
	for <lists+linux-pci@lfdr.de>; Sat, 19 Nov 2022 03:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbiKSCVC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 21:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234785AbiKSCUP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 21:20:15 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416DBBFF75;
        Fri, 18 Nov 2022 18:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668824074; x=1700360074;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FPwCs4xHcQTXiVXND4z/V3aCDgSreh+hoUAN8m3BBv8=;
  b=GZbVq49r0zfpeKWivs0r1G59+H31p2Qw6y5fWLOU93ECPwKLvnS+eNHz
   C/SaWPbV2vMd5el6o9fDhPpCg9LI151s+7IiohSXown6OTlJRt9BlDsXI
   LJ3hn5D49CzKBmZc+9L3VCsVLAgU3O2qIF1DFkjdV4TOuPNttXcyi4Qyi
   tdNquZyEYk6RlbR03xS05gqmaKjeIqjKakoRU3Vh4+9PRcoSnSBRl1zkS
   K0KbcD/DBcRehKSXHpZ+XXoFmnCkCcZUylsh3Chsgk4Cuq/FGjJ4DiM+y
   dHyTI9EhL79AwaAxQw8Jm2wBeQfDf5Eky54pdweOjDilW57Getdn2RlIj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="314431166"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="314431166"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 18:14:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="640427290"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="640427290"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 18 Nov 2022 18:14:11 -0800
Received: from debox1-desk4.lan (unknown [10.252.138.169])
        by linux.intel.com (Postfix) with ESMTP id 7DADE580A6C;
        Fri, 18 Nov 2022 18:14:11 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, david.e.box@linux.intel.com,
        michael.a.bottini@intel.com, rafael@kernel.org, me@adhityamohan.in
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V8 RESEND 0/4] PCI: vmd: Enable PCIe ASPM and LTR on select
Date:   Fri, 18 Nov 2022 18:14:07 -0800
Message-Id: <20221119021411.1383248-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

 drivers/pci/controller/vmd.c | 96 ++++++++++++++++++++++++++----------
 drivers/pci/pcie/aspm.c      | 54 ++++++++++++++++++++
 include/linux/pci.h          |  7 +++
 3 files changed, 131 insertions(+), 26 deletions(-)


base-commit: 094226ad94f471a9f19e8f8e7140a09c2625abaa
-- 
2.34.1

