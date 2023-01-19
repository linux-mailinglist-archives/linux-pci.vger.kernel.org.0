Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D631A672E3B
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 02:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjASBbn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 20:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjASBaf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 20:30:35 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83AD69226;
        Wed, 18 Jan 2023 17:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674091682; x=1705627682;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rUQm7FI19gDBIKbtnQGMZFiWFojK97zHwqLozekea/E=;
  b=E/xzQeG+wG/5qjMl4t40HhaaXv308fO4UOTfSAAP1zghFbplWAelabOn
   mZgQZElbRU2JwmZgep1QqBdor2jGY3xGvbSNU40w8EUs42YmEQj0FRiN2
   EB8xPZCRGL+4EoM4va3Rqli36T6urxzPlJ+rH8vTBx+Cxi0+GQdneBw7p
   bqOB2SerU/o6yUhcwcw+QYR8NPb/1628uSWXziE0vB0I351ljHM0t011/
   qwpcmq0EzFO1p9GOnamHMIKpcotmm9VRRT3XBZDDU0dHVB2M6tZMCF9cG
   f/PIDBp2Aeaiu81p4WpLQGY66e6yYBXsGOg72bZzI4o8A3TRaMy2eN3rN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="322847412"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="322847412"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 17:28:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="767995605"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="767995605"
Received: from unknown (HELO fedora.sh.intel.com) ([10.238.175.104])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jan 2023 17:27:56 -0800
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-fpga@vger.kernel.org, lukas@wunner.de, kabel@kernel.org,
        mani@kernel.org, pali@kernel.org, mdf@kernel.org, hao.wu@intel.com,
        yilun.xu@intel.com, trix@redhat.com, jgg@ziepe.ca,
        ira.weiny@intel.com, andriy.shevchenko@linux.intel.com,
        dan.j.williams@intel.com, keescook@chromium.org, rafael@kernel.org,
        russell.h.weight@intel.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
        lee@kernel.org, gregkh@linuxfoundation.org,
        matthew.gerlach@linux.intel.com
Cc:     Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v1 00/12] add FPGA hotplug manager driver
Date:   Wed, 18 Jan 2023 20:35:50 -0500
Message-Id: <20230119013602.607466-1-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patchset introduces the FPGA hotplug manager (fpgahp) driver which 
has been verified on the Intel N3000 card.

When a PCIe-based FPGA card is reprogrammed, it temporarily disappears
from the PCIe bus. This needs to be managed to avoid PCIe errors and to
reprobe the device after reprogramming.

To change the FPGA image, the kernel burns a new image into the flash on
the card, and then triggers the card BMC to load the new image into FPGA.
A new FPGA hotplug manager driver is introduced that leverages the PCIe
hotplug framework to trigger and manage the update of the FPGA image,
including the disappearance and reappearance of the card on the PCIe bus.
The fpgahp driver uses APIs from the pciehp driver. Two new operation
callbacks are defined in hotplug_slot_ops:

  - available_images: Optional: available FPGA images
  - image_load: Optional: trigger the FPGA to load a new image


The process of reprogramming an FPGA card begins by removing all devices
associated with the card that are not required for the reprogramming of
the card. This includes PCIe devices (PFs and VFs) associated with the
card as well as any other types of devices (platform, etc.) defined within
the FPGA. The remaining devices are referred to here as "reserved" devices.
After triggering the update of the FPGA card, the reserved devices are also
removed.

The complete process for reprogramming the FPGA are:
    1. remove all PFs and VFs except for PF0 (reserved).
    2. remove all non-reserved devices of PF0.
    3. trigger FPGA card to do the image update.
    4. disable the link of the hotplug bridge.
    5. remove all reserved devices under hotplug bridge.
    6. wait for image reload done via BMC, e.g. 10s.
    7. re-enable the link of hotplug bridge
    8. enumerate PCI devices below the hotplug bridge

usage example:
[root@localhost]# cd /sys/bus/pci/slot/X-X/

Get the available images.
[root@localhost 2-1]# cat available_images
bmc_factory bmc_user retimer_fw

Load the request images for FPGA Card, for example load the BMC user image:
[root@localhost 2-1]# echo bmc_user > image_load

Tianfei Zhang (12):
  PCI: hotplug: add new callbacks on hotplug_slot_ops
  PCI: hotplug: expose APIs from pciehp driver
  PCI: hotplug: add and expose link disable API
  PCI: hotplug: add FPGA PCI hotplug manager driver
  fpga: dfl: register dfl-pci device into fpgahph driver
  driver core: expose device_is_ancestor() API
  PCI: hotplug: add register/unregister function for BMC device
  fpga: m10bmc-sec: register BMC device into fpgahp driver
  fpga: dfl: remove non-reserved devices
  PCI: hotplug: implement the hotplug_slot_ops callback for fpgahp
  fpga: m10bmc-sec: add m10bmc_sec_retimer_load callback
  Documentation: fpga: add description of fpgahp driver

 Documentation/ABI/testing/sysfs-driver-fpgahp |  21 +
 Documentation/fpga/fpgahp.rst                 |  29 +
 Documentation/fpga/index.rst                  |   1 +
 MAINTAINERS                                   |  10 +
 drivers/base/core.c                           |   3 +-
 drivers/fpga/Kconfig                          |   2 +
 drivers/fpga/dfl-pci.c                        |  95 +++-
 drivers/fpga/dfl.c                            |  58 ++
 drivers/fpga/dfl.h                            |   4 +
 drivers/fpga/intel-m10-bmc-sec-update.c       | 246 ++++++++
 drivers/pci/hotplug/Kconfig                   |  14 +
 drivers/pci/hotplug/Makefile                  |   1 +
 drivers/pci/hotplug/fpgahp.c                  | 526 ++++++++++++++++++
 drivers/pci/hotplug/pci_hotplug_core.c        |  88 +++
 drivers/pci/hotplug/pciehp.h                  |   3 +
 drivers/pci/hotplug/pciehp_hpc.c              |  11 +-
 drivers/pci/hotplug/pciehp_pci.c              |   2 +
 include/linux/device.h                        |   1 +
 include/linux/fpga/fpgahp_manager.h           | 100 ++++
 include/linux/mfd/intel-m10-bmc.h             |  31 ++
 include/linux/pci_hotplug.h                   |   5 +
 21 files changed, 1243 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-fpgahp
 create mode 100644 Documentation/fpga/fpgahp.rst
 create mode 100644 drivers/pci/hotplug/fpgahp.c
 create mode 100644 include/linux/fpga/fpgahp_manager.h


base-commit: 5dc4c995db9eb45f6373a956eb1f69460e69e6d4
-- 
2.38.1

