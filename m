Return-Path: <linux-pci+bounces-10030-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 407BB92C895
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 04:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DA86B2142E
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 02:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC5936124;
	Wed, 10 Jul 2024 02:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcZKUYwR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E402C1BA;
	Wed, 10 Jul 2024 02:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720578826; cv=none; b=gA9OSECDvNI751r1duOocm70A30VteDSbJu2uKSHR1F3VhQQfdYRtJSdepcs3AbXMAvFaXIto2rWADgifua1/YhlTrcuJruVtTMtDlvUtiiqsrBOuw7jK1WeFg8rtSjin0mlF8sNOXgG/WmkpVrY9Soyc1NMgk+GV7s4tNlSli0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720578826; c=relaxed/simple;
	bh=eOgmxtB/x7JT6a1/AmJiXWxPHEcNVP+bI9sGnWp1yXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CuaKUTp8QkJIaJ2Y7WCqnny/kfLMVbmqaGXlkawiKJP9yvLC5U73XxuLCAdis+noC95705SXMUcze2dRiej+XUBTByfTPD1nYvoPXKVxTfv0BbkrGzCQ0fkJRmf3mfj+1Vd7vgNu9Z70uHCWsWrfoCpNbNceh8eNbcVWPXTQZXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcZKUYwR; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5b9778bb7c8so3138981eaf.3;
        Tue, 09 Jul 2024 19:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720578824; x=1721183624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIvx7f/E46Io7lL1f2KBTCaQJpNKOTzfIoHw4smzaV0=;
        b=WcZKUYwR0JR+wzj7OWoLdcjeEBT6PdPloxKiRcs9ZApyeWi6kEygGUVgzGtJGpL5CI
         +U4IVVT3b/qRXkIveH4A4rEoI05/y8cAh0Px9RaYnmAKuPLc3vWEZxsiG4PkmMYHkKhn
         Z67dmZ1b6If9Ekq3tNYkIEEIv5Q9J1FrQ/PS/4BfRdh7CmrUfzpxqNamO7Sxe3Xd0vIU
         2XETHkB3vkSqA8I+vj4QntJwbuO5BTBnLbW3/AycYOhxIw0nTKILQlA0jfOevrcXWCsb
         ZLsagHw9vOBpHSBZ5a1/XYlG4GWrEZPkwkjal9niTmFeMSJhvxF+RQkwZ2ZnR3IdT/+E
         3GFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720578824; x=1721183624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wIvx7f/E46Io7lL1f2KBTCaQJpNKOTzfIoHw4smzaV0=;
        b=iDBmES3InvEniO9IlR8+YcUcQWXF5XVqsQmz7QNqIvlR0vBgrWYu17Uox3EYkOeOwC
         B8b/F3cQ4ImvYhJHwFALhshiErCnHo9DhuLkTIB0TSM3IR34ZBYiRB8W+OHywWxmpPJh
         1437FGB61j6KxiWEcz2MlG0vK7lpwyfTFu1dhp9uWQ7VnusiNyG2EEXIWXLG0gNLlzZq
         JcM/5m0QU/C199+mFhZPb8lOr1cynOxrPj7R6iPLAbGkXEdvpmly1LAxTmbCy2gb3Ena
         JLivI3QnPdaw7iYgpiyRceSdO/uirhXHzpncWXcMQF66BvEvMuXoez/mz+Bzn2KKAd7Q
         tOxA==
X-Forwarded-Encrypted: i=1; AJvYcCWGiHdqVrkuah0q41Pf/72juO7ituEqhoqmsfeSL80ZS0KWG3cfmchOl55lIQ+8Mp8fLr9Jw2rWYioAfTVS8z3JlJCpRY2cRxcw5VabmC8SN3l2vA5q6igxCF7Vnp7n5iI5V5PDUSxt
X-Gm-Message-State: AOJu0YwiF4qTKQbssGUUKphG3yGu8lwZ69JBPIU+krWZNFEput/Dmqro
	T5KpfgFE8zrPKEoKTS5yML3KF2eJ7Tge+17vw9y7pE/b/I76iBoT
X-Google-Smtp-Source: AGHT+IHZPEEoCpaQaBIN4vpOnluNcKcuAVs7tfe5M53e8bu5YsaKB9/ePHDHIyZYpFJ+XBjpwQReTQ==
X-Received: by 2002:a05:6871:580b:b0:259:8420:8e3b with SMTP id 586e51a60fabf-25eae7f55f8mr3090954fac.21.1720578823894;
        Tue, 09 Jul 2024 19:33:43 -0700 (PDT)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b439b30b9sm2630992b3a.178.2024.07.09.19.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 19:33:43 -0700 (PDT)
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
Subject: [PATCH v14 2/4] PCI/DOE: Rename Discovery Response Data Object Contents to type
Date: Wed, 10 Jul 2024 12:33:08 +1000
Message-ID: <20240710023310.480713-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710023310.480713-1-alistair.francis@wdc.com>
References: <20240710023310.480713-1-alistair.francis@wdc.com>
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


