Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C2B7A63F8
	for <lists+linux-pci@lfdr.de>; Tue, 19 Sep 2023 14:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjISM5J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Sep 2023 08:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjISM5I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Sep 2023 08:57:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982F8F9;
        Tue, 19 Sep 2023 05:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695128220; x=1726664220;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZyCbh6VtZ67nU62IXv6rMJQvPb0CAx1pQpLxDA4Wy9k=;
  b=KloNKfNd2+7IY/TlMzBZy5JZKU5HWMvtteGQmdzXkAOBQZP8g2YcWXIR
   sqs0WB84jg87qhABEwF/RjFsI/2J1EfWF9u0ObygpbaliC6JjzdFUHFAh
   rfIwWoefgZuqbz3VvdlEqAJoltHtZPiB0wZhCQK3QSqFceVhPL9zkm6ZL
   y+K76yANSEVgkGCDeoY63VlCpXajTTK/ODSO8pe62MtfNLWB0YQQoqhtv
   yPZIzAAEUknUkVRcLhi0zLu0zfNVebR3yzwYamiaLMc6c7MrlD23SgEeu
   csJGRybTCIWoR+7++tHo4aFr5VUNyziv9GUTd1u+dhAin4SVKESrC/m8n
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="359324589"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="359324589"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 05:57:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="746228669"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="746228669"
Received: from vdesserx-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.249.32.31])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 05:56:57 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 0/8] PCI/treewide: PCIe capability access cleanups
Date:   Tue, 19 Sep 2023 15:56:40 +0300
Message-Id: <20230919125648.1920-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Instead of custom code to extract the PCIe capabilities, make the code
more obvious using FIELD_GET/PREP().

Also cleanup some duplicated defines in e1000e.

This is just a step into the right direction, there's plenty of places
still to cleanup which will have to wait for another patch series.

v3:
- Remove applied patches (scsi)
- Use pci_pcie_cap() and tweak local variable (e1000e)
- Use the correct prefix for RDMA/hfi1

v2:
- Remove extract_width() and use FIELD_GET() directly (IB/hfi1)
- Convert other fields beside Link Width ones
- Remove useless u8 casts (scsi: esas2r)
- e1000e:
        - Remove defines that duplicate pci_regs.h ones
        - Convert to pcie_capability_read_word()


Ilpo Järvinen (8):
  RDMA/hfi1: Use FIELD_GET() to extract Link Width
  media: cobalt: Use FIELD_GET() to extract Link Width
  igb: Use FIELD_GET() to extract Link Width
  PCI: tegra194: Use FIELD_GET()/FIELD_PREP() with Link Width fields
  PCI: mvebu: Use FIELD_PREP() with Link Width
  PCI: Use FIELD_GET() to extract Link Width
  e1000e: Use PCI_EXP_LNKSTA_NLW & FIELD_GET() instead of custom
    defines/code
  e1000e: Use pcie_capability_read_word() for reading LNKSTA

 drivers/infiniband/hw/hfi1/pcie.c           |  9 ++-------
 drivers/media/pci/cobalt/cobalt-driver.c    | 11 ++++++-----
 drivers/net/ethernet/intel/e1000e/defines.h |  3 ---
 drivers/net/ethernet/intel/e1000e/mac.c     | 18 ++++++++----------
 drivers/net/ethernet/intel/igb/e1000_mac.c  |  6 +++---
 drivers/pci/controller/dwc/pcie-tegra194.c  |  9 ++++-----
 drivers/pci/controller/pci-mvebu.c          |  2 +-
 drivers/pci/pci-sysfs.c                     |  5 ++---
 drivers/pci/pci.c                           |  6 +++---
 9 files changed, 29 insertions(+), 40 deletions(-)

-- 
2.30.2

