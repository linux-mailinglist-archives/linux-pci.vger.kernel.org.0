Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C093F7A97B3
	for <lists+linux-pci@lfdr.de>; Thu, 21 Sep 2023 19:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjIUR1J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Sep 2023 13:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjIUR0s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Sep 2023 13:26:48 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9065C35A1;
        Thu, 21 Sep 2023 10:03:16 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3ae0b0e9a68so368987b6e.0;
        Thu, 21 Sep 2023 10:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695315719; x=1695920519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ByKVtqUJEPBxmLb9T4BpOvxQKgM29af3ZdN5g2GbQ1I=;
        b=gc0h7mB4n3qqxjuA+c5Ann4FRuAvfXty1UmWmSuOgzGn9+I4YaQ0w0av4LzNNM33NO
         aJBabGgXbKzt3hW9Lu5p62DQ6JRA7uh5SJTO+2hhZoG66CsiFz0wr1mixgF6cfIaJHvV
         kOKkoDXHaS/TWEUsJLCfaT/v+G6cX8RkGl3JpLaKk7zpWEoXoJEkuKLx8BxLBwqtRFle
         n2zaAkn9CsuNI7wYYHVXmlMrhEYT682x/D8nTkM06E29T4oxsEFFYZ2dwNOWL7yOxbgT
         Zz5I621ZggTIpsm+CvsGEW/JIdEpiGw57mDqPEGsVriRBXAu1qIetEBaeGWxMnIzyvC+
         Mnww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315719; x=1695920519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ByKVtqUJEPBxmLb9T4BpOvxQKgM29af3ZdN5g2GbQ1I=;
        b=umnlNBNjlG4/lhtAy7maCTKp3AmBQju2+orb4Zo5iAoVoqjocfs+agyf2MLwQLFllD
         e/TAlRLjaz7cYump+mM53gbaYyeUcfFeHDbBrHJ7tIlYLKO3JESBzjMiDteiBUCzs1FV
         zjGEE/zj+/p63C/4IUPM1VQSG95KV3WtdrclZi8pOqXIda9hGDLyu3geKmWRggFzDhPK
         4uI+tbDfUHSOsrFpBv3WUEsCVPjDQt9GXN55587GMuEreXAjrc6GLoSbkCLc9kNb590v
         ovtV/U9/I2hmZQvLqBERLI5hZxCxhF0OfZsjG2fBR8Ux9TI7BZilfycoE7TqQTBYLj6z
         Z00Q==
X-Gm-Message-State: AOJu0YwDwqxYeiZveXngojQX9Ge8onR3lHAL7KQwJfHgFzgqL3mbCU95
        o2ZGt/aS1EchwzwK1x09xWFDiiccb9wbgHet
X-Google-Smtp-Source: AGHT+IGXrdoFdG68RUqDxGV7VidK+l0gZOEp2HsNGA87ZiME15dPxqRFNQ8j+4u7RkVol1rv3GUA6Q==
X-Received: by 2002:a17:902:ec83:b0:1c3:308b:ecb9 with SMTP id x3-20020a170902ec8300b001c3308becb9mr4793970plg.11.1695275765372;
        Wed, 20 Sep 2023 22:56:05 -0700 (PDT)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net. [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
        by smtp.gmail.com with ESMTPSA id jw18-20020a170903279200b001adf6b21c77sm502841plb.107.2023.09.20.22.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 22:56:04 -0700 (PDT)
From:   Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jonathan.Cameron@huawei.com, lukas@wunner.de
Cc:     alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, gregkh@linuxfoundation.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        chaitanyak@nvidia.com, rdunlap@infradead.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v8 1/3] PCI/DOE: Rename DOE protocol to feature
Date:   Thu, 21 Sep 2023 15:55:29 +1000
Message-ID: <20230921055531.2028834-1-alistair.francis@wdc.com>
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
v8:
 - Rename prot to feat as well
v7:
 - Initial patch

 drivers/pci/doe.c | 88 +++++++++++++++++++++++------------------------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index e3aab5edaf70..78ce79e031cd 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -43,7 +43,7 @@
  *
  * @pdev: PCI device this mailbox belongs to
  * @cap_offset: Capability offset
- * @prots: Array of protocols supported (encoded as long values)
+ * @feats: Array of features supported (encoded as long values)
  * @wq: Wait queue for work item
  * @work_queue: Queue of pci_doe_work items
  * @flags: Bit array of PCI_DOE_FLAG_* flags
@@ -51,14 +51,14 @@
 struct pci_doe_mb {
 	struct pci_dev *pdev;
 	u16 cap_offset;
-	struct xarray prots;
+	struct xarray feats;
 
 	wait_queue_head_t wq;
 	struct workqueue_struct *work_queue;
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
+ * @feat: DOE Feature
  * @request_pl: The request payload
  * @request_pl_sz: Size of the request payload (bytes)
  * @response_pl: The response payload
@@ -78,7 +78,7 @@ struct pci_doe_protocol {
  * @doe_mb: Used internally by the mailbox
  */
 struct pci_doe_task {
-	struct pci_doe_protocol prot;
+	struct pci_doe_feature feat;
 	const __le32 *request_pl;
 	size_t request_pl_sz;
 	__le32 *response_pl;
@@ -171,8 +171,8 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
 		length = 0;
 
 	/* Write DOE Header */
-	val = FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_VID, task->prot.vid) |
-		FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, task->prot.type);
+	val = FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_VID, task->feat.vid) |
+		FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, task->feat.type);
 	pci_write_config_dword(pdev, offset + PCI_DOE_WRITE, val);
 	pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
 			       FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH,
@@ -217,12 +217,12 @@ static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *tas
 	int i = 0;
 	u32 val;
 
-	/* Read the first dword to get the protocol */
+	/* Read the first dword to get the feature */
 	pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
-	if ((FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, val) != task->prot.vid) ||
-	    (FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, val) != task->prot.type)) {
-		dev_err_ratelimited(&pdev->dev, "[%x] expected [VID, Protocol] = [%04x, %02x], got [%04x, %02x]\n",
-				    doe_mb->cap_offset, task->prot.vid, task->prot.type,
+	if ((FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, val) != task->feat.vid) ||
+	    (FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, val) != task->feat.type)) {
+		dev_err_ratelimited(&pdev->dev, "[%x] expected [VID, Feature] = [%04x, %02x], got [%04x, %02x]\n",
+				    doe_mb->cap_offset, task->feat.vid, task->feat.type,
 				    FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, val),
 				    FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, val));
 		return -EIO;
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
@@ -412,12 +412,12 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
 	return 0;
 }
 
-static void *pci_doe_xa_prot_entry(u16 vid, u8 prot)
+static void *pci_doe_xa_feat_entry(u16 vid, u8 type)
 {
-	return xa_mk_value((vid << 8) | prot);
+	return xa_mk_value((vid << 8) | type);
 }
 
-static int pci_doe_cache_protocols(struct pci_doe_mb *doe_mb)
+static int pci_doe_cache_features(struct pci_doe_mb *doe_mb)
 {
 	u8 index = 0;
 	u8 xa_idx = 0;
@@ -425,18 +425,18 @@ static int pci_doe_cache_protocols(struct pci_doe_mb *doe_mb)
 	do {
 		int rc;
 		u16 vid;
-		u8 prot;
+		u8 type;
 
-		rc = pci_doe_discovery(doe_mb, &index, &vid, &prot);
+		rc = pci_doe_discovery(doe_mb, &index, &vid, &type);
 		if (rc)
 			return rc;
 
 		pci_dbg(doe_mb->pdev,
-			"[%x] Found protocol %d vid: %x prot: %x\n",
-			doe_mb->cap_offset, xa_idx, vid, prot);
+			"[%x] Found feature %d vid: %x type: %x\n",
+			doe_mb->cap_offset, xa_idx, vid, type);
 
-		rc = xa_insert(&doe_mb->prots, xa_idx++,
-			       pci_doe_xa_prot_entry(vid, prot), GFP_KERNEL);
+		rc = xa_insert(&doe_mb->feats, xa_idx++,
+			       pci_doe_xa_feat_entry(vid, type), GFP_KERNEL);
 		if (rc)
 			return rc;
 	} while (index);
@@ -460,7 +460,7 @@ static void pci_doe_cancel_tasks(struct pci_doe_mb *doe_mb)
  * @pdev: PCI device to create the DOE mailbox for
  * @cap_offset: Offset of the DOE mailbox
  *
- * Create a single mailbox object to manage the mailbox protocol at the
+ * Create a single mailbox object to manage the mailbox feature at the
  * cap_offset specified.
  *
  * RETURNS: created mailbox object on success
@@ -479,7 +479,7 @@ static struct pci_doe_mb *pci_doe_create_mb(struct pci_dev *pdev,
 	doe_mb->pdev = pdev;
 	doe_mb->cap_offset = cap_offset;
 	init_waitqueue_head(&doe_mb->wq);
-	xa_init(&doe_mb->prots);
+	xa_init(&doe_mb->feats);
 
 	doe_mb->work_queue = alloc_ordered_workqueue("%s %s DOE [%x]", 0,
 						dev_bus_name(&pdev->dev),
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
@@ -515,7 +515,7 @@ static struct pci_doe_mb *pci_doe_create_mb(struct pci_dev *pdev,
 
 err_cancel:
 	pci_doe_cancel_tasks(doe_mb);
-	xa_destroy(&doe_mb->prots);
+	xa_destroy(&doe_mb->feats);
 err_destroy_wq:
 	destroy_workqueue(doe_mb->work_queue);
 err_free:
@@ -533,31 +533,31 @@ static struct pci_doe_mb *pci_doe_create_mb(struct pci_dev *pdev,
 static void pci_doe_destroy_mb(struct pci_doe_mb *doe_mb)
 {
 	pci_doe_cancel_tasks(doe_mb);
-	xa_destroy(&doe_mb->prots);
+	xa_destroy(&doe_mb->feats);
 	destroy_workqueue(doe_mb->work_queue);
 	kfree(doe_mb);
 }
 
 /**
- * pci_doe_supports_prot() - Return if the DOE instance supports the given
- *			     protocol
+ * pci_doe_supports_feat() - Return if the DOE instance supports the given
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
-static bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
+static bool pci_doe_supports_feat(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
 {
 	unsigned long index;
 	void *entry;
 
-	/* The discovery protocol must always be supported */
+	/* The discovery feature must always be supported */
 	if (vid == PCI_VENDOR_ID_PCI_SIG && type == PCI_DOE_PROTOCOL_DISCOVERY)
 		return true;
 
-	xa_for_each(&doe_mb->prots, index, entry)
-		if (entry == pci_doe_xa_prot_entry(vid, type))
+	xa_for_each(&doe_mb->feats, index, entry)
+		if (entry == pci_doe_xa_feat_entry(vid, type))
 			return true;
 
 	return false;
@@ -585,7 +585,7 @@ static bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
 static int pci_doe_submit_task(struct pci_doe_mb *doe_mb,
 			       struct pci_doe_task *task)
 {
-	if (!pci_doe_supports_prot(doe_mb, task->prot.vid, task->prot.type))
+	if (!pci_doe_supports_feat(doe_mb, task->feat.vid, task->feat.type))
 		return -EINVAL;
 
 	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags))
@@ -631,8 +631,8 @@ int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8 type,
 {
 	DECLARE_COMPLETION_ONSTACK(c);
 	struct pci_doe_task task = {
-		.prot.vid = vendor,
-		.prot.type = type,
+		.feat.vid = vendor,
+		.feat.type = type,
 		.request_pl = request,
 		.request_pl_sz = request_sz,
 		.response_pl = response,
@@ -659,7 +659,7 @@ EXPORT_SYMBOL_GPL(pci_doe);
  * @vendor: Vendor ID
  * @type: Data Object Type
  *
- * Find first DOE mailbox of a PCI device which supports the given protocol.
+ * Find first DOE mailbox of a PCI device which supports the given feature.
  *
  * RETURNS: Pointer to the DOE mailbox or NULL if none was found.
  */
@@ -670,7 +670,7 @@ struct pci_doe_mb *pci_find_doe_mailbox(struct pci_dev *pdev, u16 vendor,
 	unsigned long index;
 
 	xa_for_each(&pdev->doe_mbs, index, doe_mb)
-		if (pci_doe_supports_prot(doe_mb, vendor, type))
+		if (pci_doe_supports_feat(doe_mb, vendor, type))
 			return doe_mb;
 
 	return NULL;
-- 
2.41.0

