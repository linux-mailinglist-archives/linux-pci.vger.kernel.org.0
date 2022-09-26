Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D345EB3AD
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 23:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiIZV5Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 17:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiIZV5X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 17:57:23 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98596D1EA1;
        Mon, 26 Sep 2022 14:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664229442; x=1695765442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7mhGF9QNeYv3EmWFVfkw9VlFnNtzfRGpHZffuH3vsgY=;
  b=mmyZfrj+pb6XyazRf0pG/JwXTq+ytzxLJ0PfhViYZEfnC1zG+By23h41
   o0B336wp3IhRVLtRQbDvAQZxh8TbJc2M5hkmdUp2yqHo052zVQrEaUca0
   R/lw5vGHILEEySe0cghqRr1vYctxKvTFuqcQVKewvDuyrmp+7Dx1dArwR
   qf/oKM3yH9mSITSNSTogglu8L/hpSqTF/yc5x/IvowUl2oeCZZ19rLQEi
   mfdEJZbkLsmKLF2NBNdHRBby5IAUq12uiNIq1eMoasYk2uVjzcQWr4Flt
   j6YDGpG8kTJ6xqmnsm+ztrlMhZaJD2i0snWNwFbawvvptqZ6SXm8yUawi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="302057561"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="302057561"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 14:57:21 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="598911432"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="598911432"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.209.75.159])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 14:57:21 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH V3 2/2] cxl/doe: Request exclusive DOE access
Date:   Mon, 26 Sep 2022 14:57:11 -0700
Message-Id: <20220926215711.2893286-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220926215711.2893286-1-ira.weiny@intel.com>
References: <20220926215711.2893286-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The PCIE Data Object Exchange (DOE) mailbox is a protocol run over
configuration cycles.  It assumes one initiator at a time.  While the
kernel has control of the mailbox user space writes could interfere with
the kernel access.

Mark DOE mailbox config space exclusive when iterated by the CXL driver.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V2:
	Jonathan:
		s/PCI_DOE_CAP_SIZE/PCI_DOE_CAP_SIZEOF
		Set PCI_DOE_CAP_SIZEOF directly
---
 drivers/cxl/pci.c             | 5 +++++
 include/uapi/linux/pci_regs.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index faeb5d9d7a7a..621a0522b554 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -418,6 +418,11 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
 			continue;
 		}
 
+		if (!pci_request_config_region_exclusive(pdev, off,
+							 PCI_DOE_CAP_SIZEOF,
+							 dev_name(dev)))
+			pci_err(pdev, "Failed to exclude DOE registers\n");
+
 		if (xa_insert(&cxlds->doe_mbs, off, doe_mb, GFP_KERNEL)) {
 			dev_err(dev, "xa_insert failed to insert MB @ %x\n",
 				off);
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 57b8e2ffb1dd..82a03ea954af 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1119,6 +1119,7 @@
 #define  PCI_DOE_STATUS_DATA_OBJECT_READY	0x80000000  /* Data Object Ready */
 #define PCI_DOE_WRITE		0x10    /* DOE Write Data Mailbox Register */
 #define PCI_DOE_READ		0x14    /* DOE Read Data Mailbox Register */
+#define PCI_DOE_CAP_SIZEOF	0x18	/* Size of DOE register block */
 
 /* DOE Data Object - note not actually registers */
 #define PCI_DOE_DATA_OBJECT_HEADER_1_VID		0x0000ffff
-- 
2.37.2

