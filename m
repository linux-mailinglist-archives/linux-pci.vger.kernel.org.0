Return-Path: <linux-pci+bounces-10029-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD28F92C891
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 04:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C8C728406E
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 02:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8657763A5;
	Wed, 10 Jul 2024 02:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5Es5Aon"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C0D224DC;
	Wed, 10 Jul 2024 02:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720578821; cv=none; b=uNo4y/vUNGYLwjXhkw/5gw9qgdpVgZtnVrO/abPdM6zV62z0UsAAaH9BKdJeQcYdGEXNkLzqs7/07iv+kTk704TDad8nEYx/u8lqEmhfooZlNSyNOw1e2Y+UPiAW+w5LxEZbUYibKjqqOf8crRBrG+Q28dbS3awyyBCh8JL6wEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720578821; c=relaxed/simple;
	bh=oZLMb2ZUEpzZrCDNaU/hFZABiqinH3YQJrjAmBTdY/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HxJqqn3U+Vk6cjdvQlYOi7S5B2SKtZwZbwqmTho9Lwwxz64xwuynb0BQl85WuXLcYl6Q7d1d3CngvAlmMce1+cC+E/HC+mgK48ZIxhri5/otm3J18qm7F2hW9NS3qYcmqR9cI16Q97hDIAr+OH9NR7vqZ/zrWHKN//Ox7iPX0X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5Es5Aon; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-25dfb580d1fso2816764fac.2;
        Tue, 09 Jul 2024 19:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720578818; x=1721183618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HMbDc5NWyywmEjccyZ08I/QERAwcWCVtBkbsQsYPqlk=;
        b=U5Es5AonBx2CrubWsZj960leVwBOXe0vICB+EWRs72mHRig/HXerP3DzN30QRjTO9e
         iCQqLytgCrUmZ4gslOOrkfXzC8s65aEGw7LLB9krl33zaX//ubuZyhlalOtunXZfCUTk
         gGi7KEMOmnRn5BZNesNax9RXZJRhC/Te0DOTqugd+hrZ9ORQhfx/YrepfgblPRqj3xqy
         xc47V28L6YkB5cp4lseOyv1Yz3IMCS6mvy9hTaNxv3FSCGnm+4q1VXgMf1mG1fawFC58
         qXvObptZdxyg/yYIUbEgXiFaL6d22X02ugBuPn4uoT7WrKc0xV7cc4HlJezMZpH+pNSI
         V1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720578818; x=1721183618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HMbDc5NWyywmEjccyZ08I/QERAwcWCVtBkbsQsYPqlk=;
        b=tbmVj4y1QXS7t0vMMfcUnS2PSAqb71ATqxw/4Tiupzp0rZ1zhEsOSjgJxzT0BjOyb1
         N4V19KDATd++/n20ySz1T5iiPuaC/neu7qWYIHTSmDownQ2MskSZPHM1OQvHb+eHoGCe
         G5ujca6Rx+oE61vFPddI7r6KI1UpL8/xl6Lh/3E3k6yWSNSL3nxasigyt9QyS8e+8hF7
         4Pb0l0FvmG8SOrL7XpRbNWsEGZayNBs521VlDtUcF7FiSbKEl7E+MKS6oQNOTEkbbe+k
         JBHTrAHEl3BAEEBPinVhm0xAndpOUWdjPaiKte1IObhH0uq+8TKImpl7XfFX1MCmt1qk
         mzyg==
X-Forwarded-Encrypted: i=1; AJvYcCXrFnAjIJdg9oZi8vlbzhmtElApIxEvNqSoj0wQpkRcDoe4FMmo+Z9fRq+BObTMgKjLNFAyk5d/EqPgaKVrezpZotON0aRFtcFdD8XonssJcpowuXStBYLGONqD4NE6I1B6tMORhqWF
X-Gm-Message-State: AOJu0YxgnaTqIPSLVxxEVWE74KldCBwg+coen1vi2BIuninYtllc9i2P
	KLzxr6icF3zIYh0zDMVojs99gWEc6RnQ/5ItAlTtL56C0sGeft/k
X-Google-Smtp-Source: AGHT+IH3eW8MiEXIxV02WPXQV9FvW5OO1lCytvsgxsdL0+pRMSZxVQPqdc3P/ZqEPPTuulvt2ghJVA==
X-Received: by 2002:a05:6870:10cd:b0:254:9501:db82 with SMTP id 586e51a60fabf-25eaec601efmr2494278fac.52.1720578818539;
        Tue, 09 Jul 2024 19:33:38 -0700 (PDT)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b439b30b9sm2630992b3a.178.2024.07.09.19.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 19:33:38 -0700 (PDT)
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
Subject: [PATCH v14 1/4] PCI/DOE: Rename DOE protocol to feature
Date: Wed, 10 Jul 2024 12:33:07 +1000
Message-ID: <20240710023310.480713-1-alistair.francis@wdc.com>
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
v14:
 - No changes
v13:
 - No changes
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


