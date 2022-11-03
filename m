Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51DE617417
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 03:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiKCCSZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 22:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKCCSY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 22:18:24 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F35E81;
        Wed,  2 Nov 2022 19:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667441903; x=1698977903;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dRTGogFr6yFQWzAu44s2Shz3Tuu+kZ6YaOpo+8VRwtE=;
  b=DMcLu2BjDmudMN0UTyyA6FzOfZelhaQ8aXzibcjvThwM3TFZjGWBNUKD
   wD87ecQD9wgkVeT9M0zQMQHf/V4yToaol98pmgAsEtm240ZjfYRyDfQly
   +NXTn3/83rPUqYemS0WbI7mo8eLfSBqFbrU+1UlW3xI6xLFAjkgRLVzcD
   lmBHge6U5cuhjmdnCeRUWNDjVAsqPDdObXWhbzy9XAVtP9ErHwqBTLJIf
   36fdHDJUNSglpacZiiJMinGpULwMqK6jKiWcXilzqmkjsqPfVl2BYXgG5
   oPLGYSWzARxBuTWWDlcWEmjHb9o7CLwNLG1Z8LkoRGkou1I6HEtWgummX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="395875409"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="395875409"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 19:18:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="759771646"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="759771646"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 02 Nov 2022 19:18:22 -0700
Received: from debox1-desk4.intel.com (unknown [10.212.195.54])
        by linux.intel.com (Postfix) with ESMTP id 38146580D42;
        Wed,  2 Nov 2022 19:18:22 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, david.e.box@linux.intel.com,
        michael.a.bottini@intel.com, rafael@kernel.org, me@adhityamohan.in
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V8 0/4] PCI: vmd: Enable PCIe ASPM and LTR on select hardware
Date:   Wed,  2 Nov 2022 19:18:18 -0700
Message-Id: <20221103021822.308586-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

 drivers/pci/controller/vmd.c | 96 ++++++++++++++++++++++++++----------
 drivers/pci/pcie/aspm.c      | 54 ++++++++++++++++++++
 include/linux/pci.h          |  7 +++
 3 files changed, 131 insertions(+), 26 deletions(-)


base-commit: 247f34f7b80357943234f93f247a1ae6b6c3a740
-- 
2.25.1

