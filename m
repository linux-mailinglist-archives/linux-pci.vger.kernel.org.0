Return-Path: <linux-pci+bounces-22517-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B342A47482
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 05:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42E3E1657FB
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 04:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC1217A5A4;
	Thu, 27 Feb 2025 04:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="ROSlxnOJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EaJvNtK4"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B1C28F3;
	Thu, 27 Feb 2025 04:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740630860; cv=none; b=RM+wrUlUtA9LIsWKZLVi50VTwFMOcrNsvccBD9qE3go1Lc7e/W2zIy6renHRZK2KqipfNgnWbkAti2Hd7PuskO6QMWtjLPhk5z3bksXrRTAx8Q1xmHbRIVVft/fbGWEDtsSBRSIf7KB66DCzSEwMPWvDYVawqRsZzceBx/nXRNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740630860; c=relaxed/simple;
	bh=+MtIwxydvxgofa6JYOGsHBJxr5soQtNztqvhVko4FFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BwfAwgOqwCyhkzq+e3N0pQvgmixndFBjsv2/0IocoVImdJazrEAOfwDBhy9FWHdBEiU3B/ONxHEBt2HjQPLXGLYKpUKwVsxu/F6K+K/qjPNqGvixUg8IXi7KBK3s1OoNcnfp6Hgf4EWALETLOm1xpf1WZG7HvsNN9zk31BOZVGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=ROSlxnOJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EaJvNtK4; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 88CFB2540213;
	Wed, 26 Feb 2025 23:34:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 26 Feb 2025 23:34:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1740630856; x=1740717256; bh=sKUCIn6qQH
	Nri4RbB2Jma8/fBIr55FJhTkS6CHOoafQ=; b=ROSlxnOJl0U6RtVbmnVnFJeZcM
	98ba+v78uLlGcsorqAbIoA5iDoOzNxqGv9T5brvJAG413iyDfxfj32tYfh6ufEbc
	POA14TPcKS9PZH8GHVGCHi2LBPmbeDEKgBYN4zx+oO0uHei+YO4kwcGeQu9a3Yj7
	71aVk00yKK/KTQWND2jXN8RD5MP5p1VnBzfb46MYeq2hsL618P+WewF4JwA/jwuY
	oxmR+FAEzfTPHSGOWqcf/DNkoLBUCEyDPD7QakubZulDbwKj/21hibVYufg/2Mgz
	LjuX/loJVj24gpyUMRFCKtyo480X6JuhrS2cqBOa0MzooolF6fQKK/8smgDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740630856; x=1740717256; bh=sKUCIn6qQHNri4RbB2Jma8/fBIr55FJhTkS
	6CHOoafQ=; b=EaJvNtK48M3lrneMRe38tidhFBduywJLmZJSHl2qQevdi7L9v80
	piLZbcA4orxArGRHZgaUlA4kyAyoadQkhPoyIOsmOkAAMHdwj/G/s7kt8FoymryO
	H2PtHPko1QVGKxYh4lXirSKfvKTz3iuHrKc3qEFTmRzjIzRfl0EYwKg5lHYfSHN1
	yVMiY4LHoyHUemb1RmzJR0wjt73UUQpd5W0LOdH+Nokai5RMMmMjt8t2JJymW7rb
	4ggI27blszoG3NN3SSXsQQ6g935Fz1JZjrrgGGztZL7pDEZh7p6Y0SsgskcAcLXK
	8u06dvHorj5PUVlfMtjyOZSOkNgBVJ91F+w==
X-ME-Sender: <xms:R-u_Z5_TVlolvBL_2CbAJ5dlm4wh3bLwANfuoVReL6Tv5uWsaLeLpA>
    <xme:R-u_Z9sQo7mtGAsu1wvxlYKGsyGEbgcFgPZ8CfhLgb6OQs2XIrK9ahv9OYC34J4HB
    bqt4__7X6bBe0-DnOY>
X-ME-Received: <xmr:R-u_Z3BH1_ZD82C_pnDgKT0iwyUejsh3lKb4YKX_J8mLgsQP0zX5aPi5bNgZB8P_nz8dGSZ_anM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekieehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgggfestdekredtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgt
    ihhsuceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtth
    gvrhhnpeegheejueehgeekjeffjeehhfejieelfeduudfhgeetieegueehvdeftefhgffh
    tdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlh
    hishhtrghirhesrghlihhsthgrihhrvdefrdhmvgdpnhgspghrtghpthhtohepudegpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrd
    gtohhmpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehjohhnrghthhgrnhdrtggrmhgvrhhonheshhhurgifvghirdgtoh
    hmpdhrtghpthhtoheplhhukhgrshesfihunhhnvghrrdguvgdprhgtphhtthhopegrlhgv
    gidrfihilhhlihgrmhhsohhnsehrvgguhhgrthdrtghomhdprhgtphhtthhopegthhhrih
    hsthhirghnrdhkohgvnhhighesrghmugdrtghomhdprhgtphhtthhopehktghhsehnvhhi
    ughirgdrtghomhdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtih
    honhdrohhrghdprhgtphhtthhopehlohhgrghnghesuggvlhhtrghtvggvrdgtohhm
X-ME-Proxy: <xmx:R-u_Z9d2-8OMUbF592-z1MzaBrMxC7Wzd2ysPgPRaGBskgZrXBUalw>
    <xmx:R-u_Z-OHTptSdPNqV-RxGqAllJLQZ05-ZLMDjoSZjdO4skAi3HIA8A>
    <xmx:R-u_Z_lpsE4AkvuhsonIIftV3bNwuoaw2s8StUScn21ZEgY3eu5MCQ>
    <xmx:R-u_Z4tmfBIGfgCcbeC2kFn-9uWy2hPEHKP9cMs8Aj3K2jHUIEKmjQ>
    <xmx:SOu_Z1l6kDxhsujyD0cLNPmuu6n9Vr8DyDQzGlWazeCHgGCoWM6Y_bSd>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 23:34:11 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
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
	Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v16 1/4] PCI/DOE: Rename DOE protocol to feature
Date: Thu, 27 Feb 2025 14:34:00 +1000
Message-ID: <20250227043404.2452562-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.48.1
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

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
---
v16:
 - No changes
v15:
 - No changes
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
index 7bd7892c5222..2f36262e76f8 100644
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
@@ -183,8 +183,8 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
 		length = 0;
 
 	/* Write DOE Header */
-	val = FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_VID, task->prot.vid) |
-		FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, task->prot.type);
+	val = FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_VID, task->feat.vid) |
+		FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, task->feat.type);
 	pci_write_config_dword(pdev, offset + PCI_DOE_WRITE, val);
 	pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
 			       FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH,
@@ -229,12 +229,12 @@ static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *tas
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
@@ -396,7 +396,7 @@ static void pci_doe_task_complete(struct pci_doe_task *task)
 }
 
 static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 capver, u8 *index, u16 *vid,
-			     u8 *protocol)
+			     u8 *feature)
 {
 	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
 				    *index) |
@@ -407,7 +407,7 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 capver, u8 *index, u1
 	u32 response_pl;
 	int rc;
 
-	rc = pci_doe(doe_mb, PCI_VENDOR_ID_PCI_SIG, PCI_DOE_PROTOCOL_DISCOVERY,
+	rc = pci_doe(doe_mb, PCI_VENDOR_ID_PCI_SIG, PCI_DOE_FEATURE_DISCOVERY,
 		     &request_pl_le, sizeof(request_pl_le),
 		     &response_pl_le, sizeof(response_pl_le));
 	if (rc < 0)
@@ -418,7 +418,7 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 capver, u8 *index, u1
 
 	response_pl = le32_to_cpu(response_pl_le);
 	*vid = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID, response_pl);
-	*protocol = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL,
+	*feature = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL,
 			      response_pl);
 	*index = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX,
 			   response_pl);
@@ -426,12 +426,12 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 capver, u8 *index, u1
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
@@ -450,11 +450,11 @@ static int pci_doe_cache_protocols(struct pci_doe_mb *doe_mb)
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
@@ -478,7 +478,7 @@ static void pci_doe_cancel_tasks(struct pci_doe_mb *doe_mb)
  * @pdev: PCI device to create the DOE mailbox for
  * @cap_offset: Offset of the DOE mailbox
  *
- * Create a single mailbox object to manage the mailbox protocol at the
+ * Create a single mailbox object to manage the mailbox feature at the
  * cap_offset specified.
  *
  * RETURNS: created mailbox object on success
@@ -497,7 +497,7 @@ static struct pci_doe_mb *pci_doe_create_mb(struct pci_dev *pdev,
 	doe_mb->pdev = pdev;
 	doe_mb->cap_offset = cap_offset;
 	init_waitqueue_head(&doe_mb->wq);
-	xa_init(&doe_mb->prots);
+	xa_init(&doe_mb->feats);
 
 	doe_mb->work_queue = alloc_ordered_workqueue("%s %s DOE [%x]", 0,
 						dev_bus_name(&pdev->dev),
@@ -520,11 +520,11 @@ static struct pci_doe_mb *pci_doe_create_mb(struct pci_dev *pdev,
 
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
@@ -533,7 +533,7 @@ static struct pci_doe_mb *pci_doe_create_mb(struct pci_dev *pdev,
 
 err_cancel:
 	pci_doe_cancel_tasks(doe_mb);
-	xa_destroy(&doe_mb->prots);
+	xa_destroy(&doe_mb->feats);
 err_destroy_wq:
 	destroy_workqueue(doe_mb->work_queue);
 err_free:
@@ -551,31 +551,31 @@ static struct pci_doe_mb *pci_doe_create_mb(struct pci_dev *pdev,
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
@@ -603,7 +603,7 @@ static bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
 static int pci_doe_submit_task(struct pci_doe_mb *doe_mb,
 			       struct pci_doe_task *task)
 {
-	if (!pci_doe_supports_prot(doe_mb, task->prot.vid, task->prot.type))
+	if (!pci_doe_supports_feat(doe_mb, task->feat.vid, task->feat.type))
 		return -EINVAL;
 
 	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags))
@@ -649,8 +649,8 @@ int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8 type,
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
@@ -675,9 +675,9 @@ EXPORT_SYMBOL_GPL(pci_doe);
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
@@ -688,7 +688,7 @@ struct pci_doe_mb *pci_find_doe_mailbox(struct pci_dev *pdev, u16 vendor,
 	unsigned long index;
 
 	xa_for_each(&pdev->doe_mbs, index, doe_mb)
-		if (pci_doe_supports_prot(doe_mb, vendor, type))
+		if (pci_doe_supports_feat(doe_mb, vendor, type))
 			return doe_mb;
 
 	return NULL;
-- 
2.48.1


