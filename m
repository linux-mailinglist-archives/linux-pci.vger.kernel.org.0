Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F4A63D45E
	for <lists+linux-pci@lfdr.de>; Wed, 30 Nov 2022 12:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbiK3LXN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Nov 2022 06:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbiK3LWE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Nov 2022 06:22:04 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933432AE05
        for <linux-pci@vger.kernel.org>; Wed, 30 Nov 2022 03:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669807318; x=1701343318;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6wL2fZ94Yi89GYE7S/P4NfsopHnhJvd3xsjwGgfovoE=;
  b=ECBZlOKFbEcTN/PGLln/tp4zkVeKkz+5fEP1dh8HMaHEYBC9spiMR+cm
   y+UBQY4dX0z0vClcHtEo59F6HVuLqvWCMqcJGLO6vjZLMtmT6dNnXF+YR
   iXyWNGmONbR8a6QRSyV3wmaKrm4FL1EOCd4Ip+bKt3AvcNA2ik+yOhB8m
   TrRfHDrIA65wrbcnxH3Nn13hvqU+e47JgmOWTK6RmFXe4dVahdv2iNTwV
   +S7p6joL6PPUT/mq5TQzqF3wI/LItvH/Hj1IomR/Tpg+ED9Xe+7VLy6wE
   o90B3TJpJiSwsd66RQuMPkO2lp8rDqwOixDprtp5d5VSStO0WzZ7crDok
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="342291724"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="342291724"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 03:21:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="676790607"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="676790607"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 30 Nov 2022 03:21:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 98F5E184; Wed, 30 Nov 2022 13:22:21 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v3 0/2] PCI: Distribute resources for root buses
Date:   Wed, 30 Nov 2022 13:22:19 +0200
Message-Id: <20221130112221.66612-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

This is third iteration of the patch series trying to solve the problem
reported by Chris Chiu [1]. In summary the current resource
distribution code does not cover the initial device enumeration so if we
find unconfigured bridges they get the bare minimum.

This one tries to be slightly more generic and deal with PCI devices in
addition to PCIe. I've tried this on a system with Maple Ridge
Thunderbolt controller (the same as in the orignal bug report), on QEMU
with similar PCI topology using following parameters:

	-device pcie-pci-bridge,id=br1					\
	-device e1000,bus=br1,addr=2					\
	-device pci-bridge,chassis_nr=1,bus=br1,shpc=off,id=br2,addr=3	\
	-device e1000,bus=br1,addr=4					\
	-device e1000,bus=br2

Then on a QEMU similar to what Jonathan used when he found out the
regression with multifunction devices:

	-device pcie-root-port,port=0,id=root_port13,chassis=0,slot=2	\
	-device x3130-upstream,id=sw1,bus=root_port13,multifunction=on	\
	-device e1000,bus=root_port13,addr=0.1				\
	-device xio3130-downstream,id=fun1,bus=sw1,chassis=0,slot=3	\
	-device e1000,bus=fun1

The previous versions of the series can be found:

v2: https://lore.kernel.org/linux-pci/20221114115953.40236-1-mika.westerberg@linux.intel.com/
v1: https://lore.kernel.org/linux-pci/20221103103254.30497-1-mika.westerberg@linux.intel.com/

Changes from v2:
  * Make both patches to work with PCI devices too (do not expect that
    the bridge is always first device on the bus).
  * Allow distribution with bridges that do not have all resource
    windows programmed (thereofore the pathch 2/2 is not revert anymore)
  * I did not add the tags from Rafael and Jonathan because the code is
    not exactly the same anymore so was not sure if they still apply.

Changes from v1:
  * Re-worded the commit message to hopefully explain the problem better
  * Added Link: to the bug report
  * Update the comment according to Bjorn's suggestion
  * Dropped the ->multifunction check
  * Use %#llx in log format.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=216000

Mika Westerberg (2):
  PCI: Take other bus devices into account when distributing resources
  PCI: Distribute available resources for root buses too

 drivers/pci/setup-bus.c | 122 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 117 insertions(+), 5 deletions(-)

-- 
2.35.1

