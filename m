Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BCD60C0CB
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 03:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiJYBSD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Oct 2022 21:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiJYBRt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Oct 2022 21:17:49 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C867DA2;
        Mon, 24 Oct 2022 17:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666658229; x=1698194229;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aIsDlS0Elz1Mcqzl683Iegm+ITd+1RVsEuG7flAObfI=;
  b=BqGbZjtWBeFlJ21qfcpgcT4E++qNm7mLMziBA8OZv0KMNfRmuBGEncXv
   bkc1J6C42W/wKlfkjTnh2yKugREtVDpz+bSkfAEsgoGH3RuE/QoW78J0S
   0Lf5FEcwn5CDL6CEg6hbNwdJXJFuwxJ5OmCfkAxynLHH5Rgjrc/08cbKT
   4Lul+HwbX4rz9UUU/kY2jGOZHw0TeUi+mUbOGD18ssf8cmQrZmLeWf5NS
   iwwM/uAl9oSdP0vJb3bCDPNRxbCStKVaeio1hOL9gAr5a/bFsjxOVVyDp
   0HXX41jbgZQ21ApKtj6MkwAK1vdE7c9ueDWpI0Yi5K0bub0rwsjrQadYW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="287951842"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="287951842"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 17:37:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="626246800"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="626246800"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 24 Oct 2022 17:37:08 -0700
Received: from debox1-desk4.intel.com (unknown [10.209.125.134])
        by linux.intel.com (Postfix) with ESMTP id 22482580897;
        Mon, 24 Oct 2022 17:37:08 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, david.e.box@linux.intel.com,
        michael.a.bottini@intel.com, rafael@kernel.org, me@adhityamohan.in
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V7 0/4] PCI: vmd: Enable PCIe ASPM and LTR on select hardware
Date:   Mon, 24 Oct 2022 17:37:03 -0700
Message-Id: <20221025003707.2909390-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
  PCI: vmd: Add vmd_device_data
  PCI: vmd: Add quirk to configure PCIe ASPM and LTR

Michael Bottini (1):
  PCI/ASPM: Add pci_enable_link_state()

 drivers/pci/controller/vmd.c | 158 +++++++++++++++++++++++++++--------
 drivers/pci/pcie/aspm.c      |  54 ++++++++++++
 include/linux/pci.h          |   7 ++
 3 files changed, 186 insertions(+), 33 deletions(-)


base-commit: 247f34f7b80357943234f93f247a1ae6b6c3a740
-- 
2.25.1

