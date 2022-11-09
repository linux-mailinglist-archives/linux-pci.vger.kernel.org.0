Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64EA6221E8
	for <lists+linux-pci@lfdr.de>; Wed,  9 Nov 2022 03:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiKICWj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Nov 2022 21:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKICWj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2022 21:22:39 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFEC68688
        for <linux-pci@vger.kernel.org>; Tue,  8 Nov 2022 18:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667960558; x=1699496558;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L/IstJTSjl9DQEvTwBje93JJ30xmcuthHsKzZRRBzB4=;
  b=b9/wUAC/Vgf608o76gkdHzbVMRgvhKpL32plQ2kzIlTKZU6EuY9/oENa
   BoBUW3lHDD7ZIhhnKTLh2oa5ttZ6RtMjG5TylqqbczeiG/hcV1DoT2sQj
   bXFJd+ib5J188tnWM9MXB0/9T0+cwkaDs5PdpP8RBYfGx/zu8MTNSmPyU
   BSEqHR9gs2ExVn3tBzBnSatqHMFebgJv1Q9RNb1U1cVEiY5cxIvqPnQpJ
   b8kwFabGUh+cxuatCouNftJvU3VqjGGmyDwxnurTzEOhGs5bp3GGkxsXj
   NwPZpv8H1PvO/m5MixPSig2em/h6ZP6dIEe7UgEBaBOaWexBnlnMgdhu6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="298386608"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="298386608"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 18:22:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="636564527"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="636564527"
Received: from ming-desktop.sh.intel.com ([10.239.161.24])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 18:22:35 -0800
From:   Li Ming <ming4.li@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        ira.weiny@intel.com
Cc:     linux-pci@vger.kernel.org, Li Ming <ming4.li@intel.com>
Subject: [PATCH 1/1] PCI/DOE: adjust data object length
Date:   Wed,  9 Nov 2022 10:20:44 +0800
Message-Id: <20221109022044.1827423-1-ming4.li@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The value of data object length 0x0 indicates 2^18 dwords being
transferred, it is introduced in PCIe r6.0,sec 6.30.1. This patch
adjusts the value of data object length for the above case on both
sending side and receiving side.

Besides, it is unnecessary to check whether length is greater than
SZ_1M while receiving a response data object, because length from LENGTH
field of data object header, max value is 2^18.

Signed-off-by: Li Ming <ming4.li@intel.com>
---
 drivers/pci/doe.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index e402f05068a5..204cbc570f63 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -29,6 +29,9 @@
 #define PCI_DOE_FLAG_CANCEL	0
 #define PCI_DOE_FLAG_DEAD	1
 
+/* Max data object length is 2^18 dwords */
+#define PCI_DOE_MAX_LENGTH	(2 << 18)
+
 /**
  * struct pci_doe_mb - State for a single DOE mailbox
  *
@@ -107,6 +110,7 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
 {
 	struct pci_dev *pdev = doe_mb->pdev;
 	int offset = doe_mb->cap_offset;
+	u32 length;
 	u32 val;
 	int i;
 
@@ -128,10 +132,12 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
 		FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, task->prot.type);
 	pci_write_config_dword(pdev, offset + PCI_DOE_WRITE, val);
 	/* Length is 2 DW of header + length of payload in DW */
+	length = 2 + task->request_pl_sz / sizeof(u32);
+	if (length == PCI_DOE_MAX_LENGTH)
+		length = 0;
 	pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
 			       FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH,
-					  2 + task->request_pl_sz /
-						sizeof(u32)));
+					  length);
 	for (i = 0; i < task->request_pl_sz / sizeof(u32); i++)
 		pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
 				       task->request_pl[i]);
@@ -178,7 +184,10 @@ static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *tas
 	pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
 
 	length = FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH, val);
-	if (length > SZ_1M || length < 2)
+	/* A value of 0x0 indicates max data object length */
+	if (!length)
+		length = PCI_DOE_MAX_LENGTH;
+	if (length < 2)
 		return -EIO;
 
 	/* First 2 dwords have already been read */
@@ -520,8 +529,12 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
 	/*
 	 * DOE requests must be a whole number of DW and the response needs to
 	 * be big enough for at least 1 DW
+	 *
+	 * Max data object length is 1MB, and data object header occupies 8B,
+	 * thus request_pl_sz should not be greater than 1MB - 8B.
 	 */
-	if (task->request_pl_sz % sizeof(u32) ||
+	if (task->request_pl_sz > SZ_1M - 8 ||
+	    task->request_pl_sz % sizeof(u32) ||
 	    task->response_pl_sz < sizeof(u32))
 		return -EINVAL;
 
-- 
2.25.1

