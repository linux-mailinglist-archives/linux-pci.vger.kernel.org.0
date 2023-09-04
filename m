Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9047C7910FB
	for <lists+linux-pci@lfdr.de>; Mon,  4 Sep 2023 07:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbjIDFoU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Sep 2023 01:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbjIDFoT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Sep 2023 01:44:19 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00E5B6;
        Sun,  3 Sep 2023 22:44:16 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1ccc0d2e697so905000fac.0;
        Sun, 03 Sep 2023 22:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693806256; x=1694411056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1IwLY7PwqnU/BZqP4BXU2O4lkxZsFI8ukfD/uIZIlRA=;
        b=EB8TqDvbSqw/BryAyWWoEG/2yiP8G8Cu6GDzt7LIYdpMbqYg2a226jYNLnk0xnEc6/
         7KCGzzQFbCP7lA7DpU1CNJyjwpJoYGoE54vdJjaYcMdpOCpTXZ2TkUDoJNaBlGM+h72q
         5atpFD5c9GbCq1derLWWJ8/waZabBEQNO+H5+aHd2LMOQa4vJ8vZpDzJootZ5VyppZaE
         KIlMuhQY/9nixXFH7SdbKZX/kSSLSGHdq4rtbc4lm9e02b6fL5kznmXcOui1JRvE8CiK
         8i1Q7oUf5QvNJHRHOIyCVFFgaJH78m9iHmouZtSybBTFdg/nNPvN5wPSOI5RSBkemYCW
         qmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693806256; x=1694411056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1IwLY7PwqnU/BZqP4BXU2O4lkxZsFI8ukfD/uIZIlRA=;
        b=hXSGWVdp1LXJhd6FxGX2gIJgloMYmC7XXuHoioLpaLprArjZGZqL+I7RESx4wZ1Euc
         YmTYfUJ59ecfC2wXL9Kbg5oUovDVzRXH0aleRnvX+vaYX7QegnD/59U/pguxkNz/GrcP
         fwnrUc/wvVL8IhZEKvcQYKCN4qJU1u4Y8apqlbC3M8HXXGFHOGRKeatpHnGWZBSvjxCe
         mfT3z18dQ1FAxZP6oM95JgSI0D7kN7pVHC2DHzl+0LUmuxAj2i+NC8zyWZ1EVy0pVB2s
         xO1to0mqS+ZfQ+zjyHRdV2io5XR3H7zD2VFt1TPccFbCNBIAqbZxb81wRVbgm9ZuU2wC
         T6gQ==
X-Gm-Message-State: AOJu0YzAReE07czFCpcokpr10OatEdjDxu+B0O+cU2YMzM3sUqIXAc3E
        CAbanLP041/KJpOiju6Lqpw=
X-Google-Smtp-Source: AGHT+IEiYHWgcB+SwzttYsf2eC7N10q5v9MKWKqhjHGpi9vGdZXx8Fx7DiNAcN3YgCuO2k2qezOLKw==
X-Received: by 2002:a05:6870:3921:b0:1bf:61e3:df1 with SMTP id b33-20020a056870392100b001bf61e30df1mr12800192oap.50.1693806255844;
        Sun, 03 Sep 2023 22:44:15 -0700 (PDT)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net. [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
        by smtp.gmail.com with ESMTPSA id h3-20020a63b003000000b0056c466b09a4sm6803450pgf.59.2023.09.03.22.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 22:44:15 -0700 (PDT)
From:   Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jonathan.Cameron@huawei.com, lukas@wunner.de
Cc:     alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, gregkh@linuxfoundation.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        chaitanyak@nvidia.com, rdunlap@infradead.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v7 1/3] PCI/DOE: Rename DOE protocol to feature
Date:   Mon,  4 Sep 2023 15:43:27 +1000
Message-ID: <20230904054329.865151-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DOE r1.1 replaced all occurrences of "protocol" with the term "feature"
or "Data Object Type".

PCIe r6.1 (which was published July 24) incorporated that change.

This patch renames the existing terms protocol with feature.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v7:
 - Initial patch

 drivers/pci/doe.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index e3aab5edaf70..047be8c9d191 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -43,7 +43,7 @@
  *
  * @pdev: PCI device this mailbox belongs to
  * @cap_offset: Capability offset
- * @prots: Array of protocols supported (encoded as long values)
+ * @prots: Array of features supported (encoded as long values)
  * @wq: Wait queue for work item
  * @work_queue: Queue of pci_doe_work items
  * @flags: Bit array of PCI_DOE_FLAG_* flags
@@ -58,7 +58,7 @@ struct pci_doe_mb {
 	unsigned long flags;
 };
 
-struct pci_doe_protocol {
+struct pci_doe_feature {
 	u16 vid;
 	u8 type;
 };
@@ -66,7 +66,7 @@ struct pci_doe_protocol {
 /**
  * struct pci_doe_task - represents a single query/response
  *
- * @prot: DOE Protocol
+ * @prot: DOE Feature
  * @request_pl: The request payload
  * @request_pl_sz: Size of the request payload (bytes)
  * @response_pl: The response payload
@@ -78,7 +78,7 @@ struct pci_doe_protocol {
  * @doe_mb: Used internally by the mailbox
  */
 struct pci_doe_task {
-	struct pci_doe_protocol prot;
+	struct pci_doe_feature prot;
 	const __le32 *request_pl;
 	size_t request_pl_sz;
 	__le32 *response_pl;
@@ -217,11 +217,11 @@ static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *tas
 	int i = 0;
 	u32 val;
 
-	/* Read the first dword to get the protocol */
+	/* Read the first dword to get the feature */
 	pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
 	if ((FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, val) != task->prot.vid) ||
 	    (FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, val) != task->prot.type)) {
-		dev_err_ratelimited(&pdev->dev, "[%x] expected [VID, Protocol] = [%04x, %02x], got [%04x, %02x]\n",
+		dev_err_ratelimited(&pdev->dev, "[%x] expected [VID, Feature] = [%04x, %02x], got [%04x, %02x]\n",
 				    doe_mb->cap_offset, task->prot.vid, task->prot.type,
 				    FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, val),
 				    FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, val));
@@ -384,7 +384,7 @@ static void pci_doe_task_complete(struct pci_doe_task *task)
 }
 
 static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
-			     u8 *protocol)
+			     u8 *feature)
 {
 	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
 				    *index);
@@ -404,7 +404,7 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
 
 	response_pl = le32_to_cpu(response_pl_le);
 	*vid = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID, response_pl);
-	*protocol = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL,
+	*feature = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL,
 			      response_pl);
 	*index = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX,
 			   response_pl);
@@ -417,7 +417,7 @@ static void *pci_doe_xa_prot_entry(u16 vid, u8 prot)
 	return xa_mk_value((vid << 8) | prot);
 }
 
-static int pci_doe_cache_protocols(struct pci_doe_mb *doe_mb)
+static int pci_doe_cache_features(struct pci_doe_mb *doe_mb)
 {
 	u8 index = 0;
 	u8 xa_idx = 0;
@@ -432,7 +432,7 @@ static int pci_doe_cache_protocols(struct pci_doe_mb *doe_mb)
 			return rc;
 
 		pci_dbg(doe_mb->pdev,
-			"[%x] Found protocol %d vid: %x prot: %x\n",
+			"[%x] Found feature %d vid: %x prot: %x\n",
 			doe_mb->cap_offset, xa_idx, vid, prot);
 
 		rc = xa_insert(&doe_mb->prots, xa_idx++,
@@ -460,7 +460,7 @@ static void pci_doe_cancel_tasks(struct pci_doe_mb *doe_mb)
  * @pdev: PCI device to create the DOE mailbox for
  * @cap_offset: Offset of the DOE mailbox
  *
- * Create a single mailbox object to manage the mailbox protocol at the
+ * Create a single mailbox object to manage the mailbox feature at the
  * cap_offset specified.
  *
  * RETURNS: created mailbox object on success
@@ -502,11 +502,11 @@ static struct pci_doe_mb *pci_doe_create_mb(struct pci_dev *pdev,
 
 	/*
 	 * The state machine and the mailbox should be in sync now;
-	 * Use the mailbox to query protocols.
+	 * Use the mailbox to query features.
 	 */
-	rc = pci_doe_cache_protocols(doe_mb);
+	rc = pci_doe_cache_features(doe_mb);
 	if (rc) {
-		pci_err(pdev, "[%x] failed to cache protocols : %d\n",
+		pci_err(pdev, "[%x] failed to cache features : %d\n",
 			doe_mb->cap_offset, rc);
 		goto err_cancel;
 	}
@@ -540,19 +540,19 @@ static void pci_doe_destroy_mb(struct pci_doe_mb *doe_mb)
 
 /**
  * pci_doe_supports_prot() - Return if the DOE instance supports the given
- *			     protocol
+ *			     feature
  * @doe_mb: DOE mailbox capability to query
- * @vid: Protocol Vendor ID
- * @type: Protocol type
+ * @vid: Feature Vendor ID
+ * @type: Feature type
  *
- * RETURNS: True if the DOE mailbox supports the protocol specified
+ * RETURNS: True if the DOE mailbox supports the feature specified
  */
 static bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
 {
 	unsigned long index;
 	void *entry;
 
-	/* The discovery protocol must always be supported */
+	/* The discovery feature must always be supported */
 	if (vid == PCI_VENDOR_ID_PCI_SIG && type == PCI_DOE_PROTOCOL_DISCOVERY)
 		return true;
 
@@ -659,7 +659,7 @@ EXPORT_SYMBOL_GPL(pci_doe);
  * @vendor: Vendor ID
  * @type: Data Object Type
  *
- * Find first DOE mailbox of a PCI device which supports the given protocol.
+ * Find first DOE mailbox of a PCI device which supports the given feature.
  *
  * RETURNS: Pointer to the DOE mailbox or NULL if none was found.
  */
-- 
2.41.0

