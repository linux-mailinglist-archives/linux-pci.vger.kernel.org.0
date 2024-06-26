Return-Path: <linux-pci+bounces-9263-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A289177BD
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 07:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DBCCB21D07
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 05:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7069914036F;
	Wed, 26 Jun 2024 05:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwBLUuIO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1F11E880;
	Wed, 26 Jun 2024 05:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719378002; cv=none; b=s5jgJYgRLdS0fPwbvu84NleCHQ9rpecSIork9brh1zZ3HOxLUPa6/9dQgTVbUgRZJWZkkGqX9BlufJrunnMG4aPXyF7HhKLB9foGuTTa57ML5asfLh7eGX9DeeEY9s/aCf2UjK02+xMe6zCNt1+lw1swZUUfk3YNjhPjbwaeQrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719378002; c=relaxed/simple;
	bh=Fo8JFJJSt3x05UjWSweqNbTShqM8/z4BvW5IlHWLFAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iT3PzklhblP3Z7Zf87spZTrzPkCpgl3TyaVa5cRu0DwoyZiq9ZNRrmgTIdKI1Mm9RjOKkdq/it/1GIqY1y/FtglgEHLwGlG7+mYD2cNzZ1DiBb/bAXpmjJaRBqjj3Ecrjtalk1lXUsscvFqlq0rVRW1K7/ln/Wlth2RS3JFCT3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwBLUuIO; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d561d685e7so115301b6e.1;
        Tue, 25 Jun 2024 22:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719377999; x=1719982799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HHGgmDVwDtOiHN4gxpkhdfULytrcXnUCvjpu4f7JjWE=;
        b=SwBLUuIOjWHESlx2VsSp95lEWofRn73BBaUd1pttlMozQtup+Y98cM+otCyobwizni
         Wt5bCX7fMoF6TXG6syJ+osU6WCczhPkBh6dlGh4U+ayL9P/Mq2Lh/LE8ufW5r72aUN/u
         TCB0SEllF1h3X6m+I58s/VWDFxCyrPmd1MbJmWi6WILwEKV3tp3vcX3IwDZ+ILPEUaGg
         JkGtIigEuwG40l/cYqSSzo21OBxQyc0fZckj4BsrDFOYxSvThG19H2fdZK2fU5BTNj7/
         wthjw+n9yvF6ojBteGtdhTj2ekJDsFjGeojCV8yCd8TZtOB47uKujAbvJpi5Q5+Iigq3
         67mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719377999; x=1719982799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHGgmDVwDtOiHN4gxpkhdfULytrcXnUCvjpu4f7JjWE=;
        b=uEfvGFN8+sgZrnMppqv9CIocUmWUkjy01EnTViWG2nIFR8GpUi6egA68npFXZ8sDM6
         iCMIUzid23uuSqaG1W9OOqQyWwCuxuFl20elKDToY5u0WZe0rCFddF2Imo1w9FqEGewS
         dHFH8qHV9oQmuypj4xoe6TPyFczur1Qv749/jzocIMqqoJltSOILWDYfNBNPoS0MVD+X
         Srsxvw3VLNt3k1odz17i+miHx+j0WtJAlAxRSqlqNNNzvhLOYaRUaPzEsbWhC4MWOoaP
         9bGeYlR8ZXG6fD8GS6iv8AFntVJeY4a3W5yY9ToC7s5KYqCae5uvKMOqlQgj53zAHU0B
         s5WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUo14RJBWW6FLPZX58v0gfaTwFVLmg04OlgOjbAeu49W+rvz4d97/DXzDFqp7ZN6r71mZCnlp8yVExgDk3HWpm6jls2u4ASBvOwyUknPxc/ZSAkN85ZbRBkGuQFeiAMV78P6acukwom
X-Gm-Message-State: AOJu0YyvAMS/HmOPvk3PORObK03vejZqg5c9ycLS9SD3L9oiw5MlZEy7
	cJ8O8kyZ3gEHiadRXbdLyHs2TWmHsj3k+B6CSjA9O2jKr887Idgl
X-Google-Smtp-Source: AGHT+IHT2R2PGOjapRWXuk7JIxy5kf7/FQGTqEFI2ywU/10sqkb40hkkPaFhtuf6y0ow9ue4ZDhg0A==
X-Received: by 2002:a05:6808:17a1:b0:3d2:1839:a5bb with SMTP id 5614622812f47-3d54596456cmr11140288b6e.24.1719377998833;
        Tue, 25 Jun 2024 21:59:58 -0700 (PDT)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7066f30caa6sm6673382b3a.119.2024.06.25.21.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 21:59:58 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	lukas@wunner.de
Cc: alex.williamson@redhat.com,
	christian.koenig@amd.com,
	kch@nvidia.com,
	gregkh@linuxfoundation.org,
	logang@deltatee.com,
	linux-kernel@vger.kernel.org,
	alistair23@gmail.com,
	chaitanyak@nvidia.com,
	rdunlap@infradead.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v12 1/4] PCI/DOE: Rename DOE protocol to feature
Date: Wed, 26 Jun 2024 14:59:23 +1000
Message-ID: <20240626045926.680380-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DOE r1.1 replaced all occurrences of "protocol" with the term "feature"
or "Data Object Type".

PCIe r6.1 (which was published July 24) incorporated that change.

Rename the existing terms protocol with feature.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
---
v12:
 - No changes
v11:
 - No changes
v10:
 - Split original patch into two
v9:
 - Rename two more DOE macros
v8:
 - Rename prot to feat as well
v7:
 - Initial patch


 drivers/pci/doe.c | 88 +++++++++++++++++++++++------------------------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 652d63df9d22..f776f5304a3e 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -22,7 +22,7 @@
 
 #include "pci.h"
 
-#define PCI_DOE_PROTOCOL_DISCOVERY 0
+#define PCI_DOE_FEATURE_DISCOVERY 0
 
 /* Timeout of 1 second from 6.30.2 Operation, PCI Spec r6.0 */
 #define PCI_DOE_TIMEOUT HZ
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
 
 static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 capver, u8 *index, u16 *vid,
-			     u8 *protocol)
+			     u8 *feature)
 {
 	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
 				    *index) |
@@ -395,7 +395,7 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 capver, u8 *index, u1
 	u32 response_pl;
 	int rc;
 
-	rc = pci_doe(doe_mb, PCI_VENDOR_ID_PCI_SIG, PCI_DOE_PROTOCOL_DISCOVERY,
+	rc = pci_doe(doe_mb, PCI_VENDOR_ID_PCI_SIG, PCI_DOE_FEATURE_DISCOVERY,
 		     &request_pl_le, sizeof(request_pl_le),
 		     &response_pl_le, sizeof(response_pl_le));
 	if (rc < 0)
@@ -406,7 +406,7 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 capver, u8 *index, u1
 
 	response_pl = le32_to_cpu(response_pl_le);
 	*vid = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID, response_pl);
-	*protocol = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL,
+	*feature = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL,
 			      response_pl);
 	*index = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX,
 			   response_pl);
@@ -414,12 +414,12 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 capver, u8 *index, u1
 	return 0;
 }
 
-static void *pci_doe_xa_prot_entry(u16 vid, u8 prot)
+static void *pci_doe_xa_feat_entry(u16 vid, u8 prot)
 {
 	return xa_mk_value((vid << 8) | prot);
 }
 
-static int pci_doe_cache_protocols(struct pci_doe_mb *doe_mb)
+static int pci_doe_cache_features(struct pci_doe_mb *doe_mb)
 {
 	u8 index = 0;
 	u8 xa_idx = 0;
@@ -438,11 +438,11 @@ static int pci_doe_cache_protocols(struct pci_doe_mb *doe_mb)
 			return rc;
 
 		pci_dbg(doe_mb->pdev,
-			"[%x] Found protocol %d vid: %x prot: %x\n",
+			"[%x] Found feature %d vid: %x prot: %x\n",
 			doe_mb->cap_offset, xa_idx, vid, prot);
 
-		rc = xa_insert(&doe_mb->prots, xa_idx++,
-			       pci_doe_xa_prot_entry(vid, prot), GFP_KERNEL);
+		rc = xa_insert(&doe_mb->feats, xa_idx++,
+			       pci_doe_xa_feat_entry(vid, prot), GFP_KERNEL);
 		if (rc)
 			return rc;
 	} while (index);
@@ -466,7 +466,7 @@ static void pci_doe_cancel_tasks(struct pci_doe_mb *doe_mb)
  * @pdev: PCI device to create the DOE mailbox for
  * @cap_offset: Offset of the DOE mailbox
  *
- * Create a single mailbox object to manage the mailbox protocol at the
+ * Create a single mailbox object to manage the mailbox feature at the
  * cap_offset specified.
  *
  * RETURNS: created mailbox object on success
@@ -485,7 +485,7 @@ static struct pci_doe_mb *pci_doe_create_mb(struct pci_dev *pdev,
 	doe_mb->pdev = pdev;
 	doe_mb->cap_offset = cap_offset;
 	init_waitqueue_head(&doe_mb->wq);
-	xa_init(&doe_mb->prots);
+	xa_init(&doe_mb->feats);
 
 	doe_mb->work_queue = alloc_ordered_workqueue("%s %s DOE [%x]", 0,
 						dev_bus_name(&pdev->dev),
@@ -508,11 +508,11 @@ static struct pci_doe_mb *pci_doe_create_mb(struct pci_dev *pdev,
 
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
@@ -521,7 +521,7 @@ static struct pci_doe_mb *pci_doe_create_mb(struct pci_dev *pdev,
 
 err_cancel:
 	pci_doe_cancel_tasks(doe_mb);
-	xa_destroy(&doe_mb->prots);
+	xa_destroy(&doe_mb->feats);
 err_destroy_wq:
 	destroy_workqueue(doe_mb->work_queue);
 err_free:
@@ -539,31 +539,31 @@ static struct pci_doe_mb *pci_doe_create_mb(struct pci_dev *pdev,
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
-	if (vid == PCI_VENDOR_ID_PCI_SIG && type == PCI_DOE_PROTOCOL_DISCOVERY)
+	/* The discovery feature must always be supported */
+	if (vid == PCI_VENDOR_ID_PCI_SIG && type == PCI_DOE_FEATURE_DISCOVERY)
 		return true;
 
-	xa_for_each(&doe_mb->prots, index, entry)
-		if (entry == pci_doe_xa_prot_entry(vid, type))
+	xa_for_each(&doe_mb->feats, index, entry)
+		if (entry == pci_doe_xa_feat_entry(vid, type))
 			return true;
 
 	return false;
@@ -591,7 +591,7 @@ static bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
 static int pci_doe_submit_task(struct pci_doe_mb *doe_mb,
 			       struct pci_doe_task *task)
 {
-	if (!pci_doe_supports_prot(doe_mb, task->prot.vid, task->prot.type))
+	if (!pci_doe_supports_feat(doe_mb, task->feat.vid, task->feat.type))
 		return -EINVAL;
 
 	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags))
@@ -637,8 +637,8 @@ int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8 type,
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
@@ -663,9 +663,9 @@ EXPORT_SYMBOL_GPL(pci_doe);
  *
  * @pdev: PCI device
  * @vendor: Vendor ID
- * @type: Data Object Type
+ * @prot: Data Object Type
  *
- * Find first DOE mailbox of a PCI device which supports the given protocol.
+ * Find first DOE mailbox of a PCI device which supports the given feature.
  *
  * RETURNS: Pointer to the DOE mailbox or NULL if none was found.
  */
@@ -676,7 +676,7 @@ struct pci_doe_mb *pci_find_doe_mailbox(struct pci_dev *pdev, u16 vendor,
 	unsigned long index;
 
 	xa_for_each(&pdev->doe_mbs, index, doe_mb)
-		if (pci_doe_supports_prot(doe_mb, vendor, type))
+		if (pci_doe_supports_feat(doe_mb, vendor, type))
 			return doe_mb;
 
 	return NULL;
-- 
2.45.2


