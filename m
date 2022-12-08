Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E05646717
	for <lists+linux-pci@lfdr.de>; Thu,  8 Dec 2022 03:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiLHCjp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Dec 2022 21:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiLHCjo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2022 21:39:44 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B43D2DA;
        Wed,  7 Dec 2022 18:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670467183; x=1702003183;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j/OZjpT5I1bUZcPYqREY0wKxXL/opIgkRp32Qo5ZKeo=;
  b=cmKSP3qhzX5bLMU20MwQIYW+Dc6+UM1j4FNz4dxdQNiaE84pJKmSfsoF
   GeAsU/vanfJsszBqqxICTeCreoB+4t9gUv9ZgrcYZEvnaACIkPLJ2b2nI
   m3a/47aXYlCNWcRWBiWygRhh4pn/ooymPLtpgRyjW3PQWlB5muZt5do/N
   chC7Pmyztl+ofGetiOKC4gmueNpP5KHfkA/3Oxrod4GK8RO+Bj4eGJ9da
   m6IoFXhQbmPYOkp7ZomNoqBBHVAZk2Bpf+Kvj5N6ZIlTrgYebc98AXALu
   06bL7hATiaHY/qNaI9f6sy956vJLHUSIM4WCcUP+xM9dlutCCPM4pO3qG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="297412053"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="297412053"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 18:39:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="789130126"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="789130126"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 07 Dec 2022 18:39:42 -0800
Received: from debox1-desk4.intel.com (unknown [10.212.164.201])
        by linux.intel.com (Postfix) with ESMTP id 7986D580C4C;
        Wed,  7 Dec 2022 18:39:42 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, michael.a.bottini@intel.com,
        rafael@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        me@adhityamohan.in
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V9 0/4] Enable PCIe ASPM and LTR on select hardware
Date:   Wed,  7 Dec 2022 18:39:38 -0800
Message-Id: <20221208023942.491721-1-david.e.box@linux.intel.com>
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


base-commit: 76dcd734eca23168cb008912c0f69ff408905235
-- 
2.34.1

