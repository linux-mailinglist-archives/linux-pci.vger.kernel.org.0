Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2BD5A0495
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 01:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiHXXY7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Aug 2022 19:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbiHXXY5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Aug 2022 19:24:57 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F01427B0F;
        Wed, 24 Aug 2022 16:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661383496; x=1692919496;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3ajrhKAlyLex9P+GmLBl7RTGdiFSwUZrPHfyulLogHQ=;
  b=Xw2CDCdwxJMuFn4W+WNAkx+pvRylI4f84WzXc429KDv3lKWvzRVd88Tt
   +QgPBVFVHlq4+Vodv8C/HVxJK1OdPHv1DEl5577jeBTfy33NuqHyKxHer
   6Y+90o99yvhyvScFNt9+OoQbW/ZXzWzY4EV/cqLmIUopUaDBQmG4HgaEz
   PFaOJ354MAldRktHwC3TFJzCtWmdbCfKuaSTAD9HULlIEUD20UF0OHNvk
   fNGiHvXmCXD5jBikPYkmNQimABJ53/zMn6DlcWIcmL1qqCNPRx053UNZg
   r3rtltGPF7rS9GV44WHr/QYK0gGodorx0bdnQgBNTJyVdAzPw/QsmvsEp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="273852622"
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="273852622"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 16:24:55 -0700
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="606199634"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.42.187])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 16:24:54 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH V2 2/2] cxl/doe: Request exclusive DOE access
Date:   Wed, 24 Aug 2022 16:24:50 -0700
Message-Id: <20220824232450.723179-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220824232450.723179-1-ira.weiny@intel.com>
References: <20220824232450.723179-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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
 drivers/cxl/pci.c             | 5 +++++
 include/uapi/linux/pci_regs.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index faeb5d9d7a7a..5b833eb91543 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -418,6 +418,11 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
 			continue;
 		}
 
+		if (!pci_request_config_region_exclusive(pdev, off,
+							 PCI_DOE_CAP_SIZE,
+							 dev_name(dev)))
+			pci_err(pdev, "Failed to exclude DOE registers\n");
+
 		if (xa_insert(&cxlds->doe_mbs, off, doe_mb, GFP_KERNEL)) {
 			dev_err(dev, "xa_insert failed to insert MB @ %x\n",
 				off);
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 57b8e2ffb1dd..f2396bcd09cc 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1119,6 +1119,7 @@
 #define  PCI_DOE_STATUS_DATA_OBJECT_READY	0x80000000  /* Data Object Ready */
 #define PCI_DOE_WRITE		0x10    /* DOE Write Data Mailbox Register */
 #define PCI_DOE_READ		0x14    /* DOE Read Data Mailbox Register */
+#define PCI_DOE_CAP_SIZE	(0x14 + 4)	/* Size of this register block */
 
 /* DOE Data Object - note not actually registers */
 #define PCI_DOE_DATA_OBJECT_HEADER_1_VID		0x0000ffff
-- 
2.37.2

