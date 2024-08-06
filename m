Return-Path: <linux-pci+bounces-11399-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE294949BBE
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 01:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 857C228844E
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 23:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963CE176227;
	Tue,  6 Aug 2024 23:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/c2XThn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9DF17556B;
	Tue,  6 Aug 2024 23:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722985306; cv=none; b=lOzeVWQOsH8N+zY5F1BDpbOb34fFgWr03vLEjtMMKfF48Y5F6yJYsb1Hox4YZ+fpH2KbE4j89DNS2dYQE84IUZZP3mtQgup7y2w1LbZf1T+RRQSU8+jaEDI3EcHb6wvxyrtsNf687OHsX8dARo6j/6hFWSK8wOMwir2At2/Uc/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722985306; c=relaxed/simple;
	bh=HtsBKDBMijTjd1okJzxrq2oHGtLd5WEmbJKrG9xXqW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SjEhqaiMjCN158ynINE/IhdWm14xqcqIeA8tPX9dK1Now7f21yioZ1CbsvJj40RI7Uu0lOjAbzzmp22nGsiw+vqjvxzYu7OSz2AITC2ihKRDMKizsjUZBk0sPrBpiwAEXTUgOXrsqIrmhRbw+Wkf4JM2FrGXksrD7VpZ29vmb3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/c2XThn; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fec34f94abso11468845ad.2;
        Tue, 06 Aug 2024 16:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722985304; x=1723590104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwZ+ccC34/aW915VxJFlGcLKeYK2TBqhEN1WMQ3EwR8=;
        b=C/c2XThnHH3akkour/7kkM5blFiPv7SnlMevjfin8F/OMLjMseulL/W9z0JMWp/Fii
         8zg/ILtDOGY7jNycePzH9GegSq90eMCSReDm4PQYzu/y3dr8DKmNGwOfEWnQpYb+9dbC
         srDJaNasZaaDvR4eKdQtW3oXll/QJZVxd+3xUxjBkPynIbLHT4JgtjOvGI/055kAb8Uh
         mz16a2dEmrhtuuOu/cEqwF1n6DYLYToYoqNCBVjyYn2o6sdlQiXCTxzzKPepGlu/5vW/
         2VjmkpKrz+uvRn0MKalzcfb3A/xlUXxIqgr7JUbBxiRDVF0n2nb4/DCvr/hj2h8zn2YU
         03/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722985304; x=1723590104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwZ+ccC34/aW915VxJFlGcLKeYK2TBqhEN1WMQ3EwR8=;
        b=OxIeuA9whKwaZYu6g7id+Hdv1Rw9G4/GwUhssRa8ZpXl7/J2uRoVz+cHl5GD/78sdQ
         E03uC/2pWBhnr8b2UhWncJ9Qe+npLGhzZ0aqMP4sT9yVzVy5Hieg3V1DpGuxdqocSjOU
         L2XZqBLpWGL77k0WGVTJP/MCxFxOVTxtGxAV0IURCRE8Pe9MG/s/Y/3E+QasKCF6Plun
         1xuP8iA7jE3K8esqF1k/CRhRx1owoTGdg67enSwJCkoqaVuvtBIGFVXsglwKYuVSvrjn
         wcEwFJaYgDe3NWmtNs7UjerbIprM39Yn2U3ylw8NC08dyC3AJ8hSI66978ZreP46hGW1
         O5Mg==
X-Forwarded-Encrypted: i=1; AJvYcCXQVl3Y3em7p+pzq0CjrjnKA6mdB4yiDuVYYBzhgRUioGVo8Cg6Efj64rIy/ISuS2MXHfma354a9/kh1aKFJK/LqAYqAJ42Jllj/l3gBNswAUlhS1ivtHRakXhDuRu40aW0nHUcM6h1
X-Gm-Message-State: AOJu0Yze+0gNr3H8hQhkvhAfL2GQb5g7Wyfu+Qrk+m2ohcqCvwG3oeBM
	KaqwA3dzMr4KSfAK9qEv93ymOLclsYTv/vn+XxTGx5bwDz1qgxbm
X-Google-Smtp-Source: AGHT+IEKDuAubKC927Eq3xY4Mh5Y8/8FdLj0XWW9ehxWNGWjFVBRn6KHCtFmlHjpQmwT4tp621oKzQ==
X-Received: by 2002:a17:902:dac4:b0:1fb:90e1:c8c5 with SMTP id d9443c01a7336-1ff572c487fmr162715205ad.33.1722985304104;
        Tue, 06 Aug 2024 16:01:44 -0700 (PDT)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff592b3997sm92780755ad.294.2024.08.06.16.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 16:01:43 -0700 (PDT)
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
Subject: [PATCH v15 2/4] PCI/DOE: Rename Discovery Response Data Object Contents to type
Date: Wed,  7 Aug 2024 09:01:16 +1000
Message-ID: <20240806230118.1332763-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806230118.1332763-1-alistair.francis@wdc.com>
References: <20240806230118.1332763-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCIe r6.1 (which was published July 24) describes a "Vendor ID", a
"Data Object Type" and "Next Index" as the fields in the DOE
Discovery Response Data Object. The DOE driver currently uses
both the terms type and prot for the second element.

This patch renames all uses of the DOE Discovery Response Data Object
to use type as the second element of the object header, instead of
type/prot as it currently is.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v15:
 - No changes
v14
 - No changes
v13
 - No changes
v12:
 - Use PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE for PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL
v11:
 - Avoid breaking changes to userspace header
v10:
 - Split original patch into two
v9:
 - Rename two more DOE macros
v8:
 - Rename prot to feat as well
v7:
 - Initial patch

 drivers/pci/doe.c             | 18 +++++++++---------
 include/uapi/linux/pci_regs.h |  5 ++++-
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index f776f5304a3e..defc4be81bd4 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -406,7 +406,7 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 capver, u8 *index, u1
 
 	response_pl = le32_to_cpu(response_pl_le);
 	*vid = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID, response_pl);
-	*feature = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL,
+	*feature = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE,
 			      response_pl);
 	*index = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX,
 			   response_pl);
@@ -414,9 +414,9 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 capver, u8 *index, u1
 	return 0;
 }
 
-static void *pci_doe_xa_feat_entry(u16 vid, u8 prot)
+static void *pci_doe_xa_feat_entry(u16 vid, u8 type)
 {
-	return xa_mk_value((vid << 8) | prot);
+	return xa_mk_value((vid << 8) | type);
 }
 
 static int pci_doe_cache_features(struct pci_doe_mb *doe_mb)
@@ -430,19 +430,19 @@ static int pci_doe_cache_features(struct pci_doe_mb *doe_mb)
 	do {
 		int rc;
 		u16 vid;
-		u8 prot;
+		u8 type;
 
 		rc = pci_doe_discovery(doe_mb, PCI_EXT_CAP_VER(hdr), &index,
-				       &vid, &prot);
+				       &vid, &type);
 		if (rc)
 			return rc;
 
 		pci_dbg(doe_mb->pdev,
-			"[%x] Found feature %d vid: %x prot: %x\n",
-			doe_mb->cap_offset, xa_idx, vid, prot);
+			"[%x] Found feature %d vid: %x type: %x\n",
+			doe_mb->cap_offset, xa_idx, vid, type);
 
 		rc = xa_insert(&doe_mb->feats, xa_idx++,
-			       pci_doe_xa_feat_entry(vid, prot), GFP_KERNEL);
+			       pci_doe_xa_feat_entry(vid, type), GFP_KERNEL);
 		if (rc)
 			return rc;
 	} while (index);
@@ -663,7 +663,7 @@ EXPORT_SYMBOL_GPL(pci_doe);
  *
  * @pdev: PCI device
  * @vendor: Vendor ID
- * @prot: Data Object Type
+ * @type: Data Object Type
  *
  * Find first DOE mailbox of a PCI device which supports the given feature.
  *
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 94c00996e633..795e49304ae4 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1146,9 +1146,12 @@
 #define PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX		0x000000ff
 #define PCI_DOE_DATA_OBJECT_DISC_REQ_3_VER		0x0000ff00
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID		0x0000ffff
-#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
+#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE		0x00ff0000
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
 
+/* Deprecated old name, replaced with PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE */
+#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE
+
 /* Compute Express Link (CXL r3.1, sec 8.1.5) */
 #define PCI_DVSEC_CXL_PORT				3
 #define PCI_DVSEC_CXL_PORT_CTL				0x0c
-- 
2.45.2


