Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C01E62B0E4
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 02:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiKPB60 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 20:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiKPB60 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 20:58:26 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0B92B5
        for <linux-pci@vger.kernel.org>; Tue, 15 Nov 2022 17:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668563904; x=1700099904;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Dde9ruRVGwfH6oN3sEu1YcJJwj0h5BuDikf6r1Maino=;
  b=kMuvUax4Huz+KR6t5Xvx267eCelW/Q7XoJqZk9Mt4Qd0QN8BA7yPOHIc
   VGiMt1l/qZXU+WnVHHNUydHKEKCGbS9SrAWWLtjiH4MCjSF5RrveTDpNn
   qe8imQcnbH37sjxgey00eka66p+z6h831SF8T/NZyS3zFKwRxc1lwVWHQ
   3MHIsKmZ92HIR8DngWQR5Eag4J/WHNPokmJntys5+JEgaND+f2+oiVdq1
   Rt0PzOfKUw/hBXoTPUuU4K+J7ZDWoKTyxonsm9TrQiVSz0F2RxYE1dmg5
   I0nq1oCrUzW1fDV7mjCNDCzskbHCizrVCK6S8j4ses7rKIv7lkZVRTwsP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="312427175"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="312427175"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 17:58:24 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="968233648"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="968233648"
Received: from ming-desktop.sh.intel.com ([10.239.161.24])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 17:58:23 -0800
From:   Li Ming <ming4.li@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        ira.weiny@intel.com
Cc:     linux-pci@vger.kernel.org, Li Ming <ming4.li@intel.com>
Subject: [PATCH V2 1/1] PCI/DOE: Fix maximum data object length miscalculation
Date:   Wed, 16 Nov 2022 09:56:37 +0800
Message-Id: <20221116015637.3299664-1-ming4.li@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The value of data object length 0x0 indicates 2^18 dwords being
transferred. This patch adjusts the value of data object length for the
above case on both sending side and receiving side.

Besides, it is unnecessary to check whether length is greater than
SZ_1M while receiving a response data object, because length from LENGTH
field of data object header, max value is 2^18.

Signed-off-by: Li Ming <ming4.li@intel.com>
---
v1->v2:
 * Fix the value of PCI_DOE_MAX_LENGTH
 * Moving length checking closer to transferring process
 * Add a missing bracket
 * Adjust patch description
---
 drivers/pci/doe.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index e402f05068a5..66d9ab288646 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -29,6 +29,9 @@
 #define PCI_DOE_FLAG_CANCEL	0
 #define PCI_DOE_FLAG_DEAD	1
 
+/* Max data object length is 2^18 dwords */
+#define PCI_DOE_MAX_LENGTH	(1 << 18)
+
 /**
  * struct pci_doe_mb - State for a single DOE mailbox
  *
@@ -107,6 +110,7 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
 {
 	struct pci_dev *pdev = doe_mb->pdev;
 	int offset = doe_mb->cap_offset;
+	size_t length;
 	u32 val;
 	int i;
 
@@ -123,15 +127,20 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
 	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val))
 		return -EIO;
 
+	/* Length is 2 DW of header + length of payload in DW */
+	length = 2 + task->request_pl_sz / sizeof(u32);
+	if (length > PCI_DOE_MAX_LENGTH)
+		return -EIO;
+	if (length == PCI_DOE_MAX_LENGTH)
+		length = 0;
+
 	/* Write DOE Header */
 	val = FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_VID, task->prot.vid) |
 		FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, task->prot.type);
 	pci_write_config_dword(pdev, offset + PCI_DOE_WRITE, val);
-	/* Length is 2 DW of header + length of payload in DW */
 	pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
 			       FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH,
-					  2 + task->request_pl_sz /
-						sizeof(u32)));
+					  length));
 	for (i = 0; i < task->request_pl_sz / sizeof(u32); i++)
 		pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
 				       task->request_pl[i]);
@@ -178,7 +187,10 @@ static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *tas
 	pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
 
 	length = FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH, val);
-	if (length > SZ_1M || length < 2)
+	/* A value of 0x0 indicates max data object length */
+	if (!length)
+		length = PCI_DOE_MAX_LENGTH;
+	if (length < 2)
 		return -EIO;
 
 	/* First 2 dwords have already been read */
-- 
2.25.1

