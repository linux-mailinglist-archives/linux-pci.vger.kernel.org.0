Return-Path: <linux-pci+bounces-9553-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 681EE91EEBD
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 08:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1AA1C2192D
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 06:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841547BAE5;
	Tue,  2 Jul 2024 06:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8wl5pjn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A53676F17;
	Tue,  2 Jul 2024 06:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719900299; cv=none; b=DVw8R1JauJEmX7+CTggha5kqYRris9h9mign79YbMw77PdGogzf1gV7f/c2nji5mxC8vswJF8quUxiUYF0dIeTkp2F+r95LvOFG28EDzmYejIMMpON/WQWfd9wWc84xnFirtuhnGENvr+9BL5mzmxRp3pTFx/sr5WpJzK2D+qY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719900299; c=relaxed/simple;
	bh=C1S9OhbpaG+umG8H8ub5Rz2NOuku6ZPmmSJhnUy0xn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLEHDcL8I6CUfQ5WmBfzQQfOdm6Pq3TuN3lFg+oBuRVFr4bWu+Ngm7OkJHUaw2GlRD8WbfyYiV+vp6rykNgxxvbNr4jQ9IKujuT//PvCl8cd28dCDrhPFL0HtNoc6kqn3/Hs8L4cKl2AWVvpQUmzDtwysdmUvMuHnYuY/G8tNmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8wl5pjn; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f64ecb1766so20358335ad.1;
        Mon, 01 Jul 2024 23:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719900297; x=1720505097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HmXWBZI2234C0SEXKItAogwfmQcb4GdnpH9BKghxlg=;
        b=V8wl5pjnS1tTTFm/HAgJ9n10aaVW1NLq8gWEShBE7dRvl5LfCWWDKjGYeVzpO71BWD
         Lm+hIAGxxsAtFsixSRAp0SDjcCZ6+LAU5YLR5ntT0flfpLYi+VFghzYClQwlxUaBk7nU
         dv4Z2/MXMFxrSUHeLjYnHCyiyNMi+X1CNv1fCSXW/qohhy/vUO3AXaKB7PlS7a70YM89
         1Z2zMbd1fC8bXqphTfOJV4iUwMTbd+1o374KSmpnO8LbJ3YYkdHDtCVu9imOx9TLDVNI
         fbx0rzQO9WcJXgtzjnoGta1hHxHFXYDlzlXYD6C0pHOdIPSGiko8Xjoo2w1dveaZpMGE
         809w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719900297; x=1720505097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HmXWBZI2234C0SEXKItAogwfmQcb4GdnpH9BKghxlg=;
        b=D1K1AQVs5Fx3ACI/TcShIb6+sqLvnQrKfUgOYKDGr1+Ag1+d5zjT9A+5ViHYv2R1Lj
         Yw1ActcRgMAg5Z7URYKVAV0pWMps9nDeBY8+7LIi3eYJlVeH1UiYVmTJ/iGLVZz9T9KP
         INRJeUcgjW0ZwxfE/VwRzb+/ykbbg5jxgswlkG8jHGmvn+WMxe9X8+vP9+nN4JiqPSrq
         FRKW2F6N0LQ51MjeA/i2vIvq2bIuhCub5sDwHgMc74eJZgYtVSSAJ23L2kV+N10qzdaq
         aBZFWJpWUKs3CGLPGJaXAhjvwpT++Aw72YJd1zsNMFmQ0H+Bq31vnFE0qwS4eoO5Hspl
         SjWg==
X-Forwarded-Encrypted: i=1; AJvYcCVbebP00wAhmXztyxmqstmeo9Ul5r9mMHfzmO14WYQB0YE2+M635Fc2/lS4EVogucX7PySvF71JnLtu6M9079xk6pFSpDYzhorBSuliH8lJJixa0BiTTgY86/RilLgxDUdb8Kp4c4Om
X-Gm-Message-State: AOJu0YxQ1HRmvpSK1WH4AKULAuZOBg33UG7L6QTqGMsCViI2OPdv3Zk2
	+l98xh6nmM+ExOrXZVlE8HmEDWZzVDkzjS8kg75Ufog/mVyclzpD
X-Google-Smtp-Source: AGHT+IGzQGIUI5rSwqaAGFu53Ui2dWXrVNhzn2xhMo8RR4wn7PB9VF0JhmARQ9iBln9WlGEG/yyfAg==
X-Received: by 2002:a17:902:d48d:b0:1fa:fc15:c528 with SMTP id d9443c01a7336-1fafc15d4fbmr2968865ad.37.1719900297162;
        Mon, 01 Jul 2024 23:04:57 -0700 (PDT)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10d23edsm75484225ad.58.2024.07.01.23.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 23:04:56 -0700 (PDT)
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
Subject: [PATCH v13 2/4] PCI/DOE: Rename Discovery Response Data Object Contents to type
Date: Tue,  2 Jul 2024 16:04:16 +1000
Message-ID: <20240702060418.387500-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702060418.387500-1-alistair.francis@wdc.com>
References: <20240702060418.387500-1-alistair.francis@wdc.com>
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


