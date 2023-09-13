Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72C879E7F3
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 14:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240193AbjIMMaQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Sep 2023 08:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240453AbjIMMaP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 08:30:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CA919AD;
        Wed, 13 Sep 2023 05:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694608211; x=1726144211;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=22UJiVbzD5mU4/r1HpQLPiSWS/GQq8TIka+mKP6MSTY=;
  b=npRJ5LahwAQpKFnCzaih6KZHgSAx0YwmQ3Ep9etasmnlw1RCCEqjfNiZ
   gJsnpM1VA98WaMPoUmv4pXXohBHunqm5Fqz4HlrbT+WlYeUKT2Lc34FO3
   pWYB81CXnwkrB3uMSQSe69wf+zZnUHON0+S0vgdP5JeMr/WvWshGHwdUe
   E2qoQjvm5e2S5r53X2LCODvGxuf1SHYSAIpIAFr0ggiNq5JmN+JNkP/3q
   vpgxVe/59B0dUQmOIr9K3Ar91gYVPltnwZZiwMZ/Gl6ViEZBKFDUaI8dq
   yhw82jBb3o0KVH96BVD76iHVwZhs5DA3JRCNskXZvPAdTE9DjtRZV+5TD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="368912279"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="368912279"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 05:28:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="693836592"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="693836592"
Received: from pakurapo-mobl3.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.249.45.213])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 05:27:58 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 00/10] PCI/treewide: PCIe capability access cleanups
Date:   Wed, 13 Sep 2023 15:27:38 +0300
Message-Id: <20230913122748.29530-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Instead of custom code to extract the PCIe capabilities, make the code
more obvious using FIELD_GET/PREP().

Also cleanup some duplicated defines in e1000e.

I've only put Jonathan's Reviewed-by to patches I didn't modify
significantly.

This is just a step into the right direction, there's plenty of places
still to cleanup which will have to wait for another patch series.

v2:
- Remove extract_width() and use FIELD_GET() directly (IB/hfi1)
- Convert other fields beside Link Width ones
- Remove useless u8 casts (scsi: esas2r)
- e1000e:
        - Remove defines that duplicate pci_regs.h ones
        - Convert to pcie_capability_read_word()

Ilpo Järvinen (10):
  IB/hfi1: Use FIELD_GET() to extract Link Width
  media: cobalt: Use FIELD_GET() to extract Link Width
  igb: Use FIELD_GET() to extract Link Width
  PCI: tegra194: Use FIELD_GET()/FIELD_PREP() with Link Width fields
  PCI: mvebu: Use FIELD_PREP() with Link Width
  PCI: Use FIELD_GET() to extract Link Width
  scsi: esas2r: Use FIELD_GET() to extract PCIe capability fields
  scsi: qla2xxx: Use FIELD_GET() to extract PCIe capability fields
  e1000e: Use PCI_EXP_LNKSTA_NLW & FIELD_GET() instead of custom
    defines/code
  e1000e: Use pcie_capability_read_word() for reading LNKSTA

 drivers/infiniband/hw/hfi1/pcie.c           |  9 ++-------
 drivers/media/pci/cobalt/cobalt-driver.c    | 11 ++++++-----
 drivers/net/ethernet/intel/e1000e/defines.h |  3 ---
 drivers/net/ethernet/intel/e1000e/mac.c     | 17 ++++++++---------
 drivers/net/ethernet/intel/igb/e1000_mac.c  |  6 +++---
 drivers/pci/controller/dwc/pcie-tegra194.c  |  9 ++++-----
 drivers/pci/controller/pci-mvebu.c          |  2 +-
 drivers/pci/pci-sysfs.c                     |  5 ++---
 drivers/pci/pci.c                           |  6 +++---
 drivers/scsi/esas2r/esas2r_ioctl.c          | 16 ++++++----------
 drivers/scsi/qla2xxx/qla_os.c               |  5 +++--
 11 files changed, 38 insertions(+), 51 deletions(-)

-- 
2.30.2

