Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB31B79AD62
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 01:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350438AbjIKVi2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 17:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237204AbjIKMPP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 08:15:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54763198;
        Mon, 11 Sep 2023 05:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694434511; x=1725970511;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3dD4ERLPrydK12d07yl5BuAZY/vrO1N+CXctHyNn6JM=;
  b=Y5+QstJn4r9XqCWcFpDjPSHsguBzlg8ggZoju/QmUoRoWAfLAmKQfvXb
   zYy7tF6hl97uH61PJ8lYbROhxS4aJIB9OWqVrz2TrOI5H5pmcGIdAnEXO
   1Cx8IDDCooLvGnK91wkrQl1Wzazj71/C8wlLx8aEjv138VUJSz2kJCIYQ
   qD0z4CnV7Jg1WrCYRjBH/l/vEnlpX0vsRBGPAozSWnSHvikBx8UVhAOz4
   oc2mStr2gx6hKxaKngZ4fTJ3w3boAO3KvFa6ZSSoNKF3Ow7gSOBO9AIPL
   ssef+szktWpk50Kv1sR348GDuBg9tovUnMHnGC5gcz+Vmh1WZp59+Z+YU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="381863419"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="381863419"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 05:15:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="746383240"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="746383240"
Received: from mzarkov-mobl3.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.36.200])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 05:15:09 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/8] PCI/treewide: PCIe Link Width field access cleanup
Date:   Mon, 11 Sep 2023 15:14:53 +0300
Message-Id: <20230911121501.21910-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Instead of custom code to extract the PCIe Negotiated and Maximum Link
Width fields, make the code more obvious using FIELD_GET/PREP().

Ilpo Järvinen (8):
  IB/hfi1: Use FIELD_GET() to extract Link Width
  media: cobalt: Use FIELD_GET() to extract Link Width
  igb: Use FIELD_GET() to extract Link Width
  PCI: tegra194: Use FIELD_GET()/FIELD_PREP() with Link Width fields
  PCI: mvebu: Use FIELD_PREP() with Link Width
  PCI: Use FIELD_GET() to extract Link Width
  scsi: esas2r: Use FIELD_GET() to extract Link Width
  scsi: qla2xxx: Use FIELD_GET() to extract Link Width

 drivers/infiniband/hw/hfi1/pcie.c          |  5 +++--
 drivers/media/pci/cobalt/cobalt-driver.c   | 11 ++++++-----
 drivers/net/ethernet/intel/igb/e1000_mac.c |  6 +++---
 drivers/pci/controller/dwc/pcie-tegra194.c |  9 ++++-----
 drivers/pci/controller/pci-mvebu.c         |  2 +-
 drivers/pci/pci-sysfs.c                    |  5 ++---
 drivers/pci/pci.c                          |  6 +++---
 drivers/scsi/esas2r/esas2r_ioctl.c         |  8 ++++----
 drivers/scsi/qla2xxx/qla_os.c              |  3 ++-
 9 files changed, 28 insertions(+), 27 deletions(-)

-- 
2.30.2

