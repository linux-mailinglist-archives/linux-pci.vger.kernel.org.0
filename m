Return-Path: <linux-pci+bounces-7743-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F898CBF0C
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 12:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 953481C20D53
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 10:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F30823CE;
	Wed, 22 May 2024 10:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J11Z0P3i"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E976823B8;
	Wed, 22 May 2024 10:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716372738; cv=none; b=U5uzSIDUsEygTIlIcunMnZ+cbaVOojUv3gPYqoPiZtyrSIhgAo+PFXhEggoflGEczm40yn0FGtK7p1oL4hjmsBRo8WXFXCYqFnbk/3Hs607gGULCb/98M7MZJyWcF7QI0gWCPps5F0jQearMUGGjqyohlXcdsXN+7j8GSNcniD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716372738; c=relaxed/simple;
	bh=DcgxnZZfPbmTXFfPOnHAWOFVVkuSmBBGc9Af2SdPx8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xz/y23armc825TqUam47rTRsjaZGNu+d4fplHSOwMva7LuYXMql9vcrHa/699e/+L6hLyiguWbo4CQRI5GgS3NW1910IcZWXRfugjBZNT4ClQsbP2vTPitTQbKZD+5VihE5xikuxDQNca2dkGbQYONoC2Ie7QRHF+qrK2xNBYqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J11Z0P3i; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ee0132a6f3so7942755ad.0;
        Wed, 22 May 2024 03:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716372737; x=1716977537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLaCSlYUspOIKajj5rtpAF8UEfah+u43EYJKfRofbA4=;
        b=J11Z0P3iH6Cdg7w5gwjRFWofm31/5Vx6G0ESTiySuc1610fV2WF5lypqJIzBemp1h7
         bUWExCl/M0t6Mnqw+fABOjtLfEYlbF6gkahp8x9ZibY67aumkOTzcbkK5jeV7iE3u5oF
         L8N43RYaPpruweI17ToACzD1iJVyB/CFwM3jACFzJovOR/GP/gP2rg0kHZ+w9FXSpUfK
         H4/Mh7RUqiUijcYvvidBuxtSM6LkE0lNS+AyMBGfCJrZwnKO93scubkQvGltzKFdOj+h
         mrgLuS8o9ixm2dcUFONzz8EXSyOotuwGphjqkTzSgoBBNCubY0zF7GGftUm4ldPSWLGu
         F7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716372737; x=1716977537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLaCSlYUspOIKajj5rtpAF8UEfah+u43EYJKfRofbA4=;
        b=QGjuouI6tq1HiPqDmtXPxMTRxXp+wwOw//DE4seewa9ZFgF1KyGctfXhF4ggvGphlm
         frkOjQTTqWq1nfU0HUxQX8AHEdZLoC6RKa6rG9WbkgABbFbt0KaqgJnjbFvWHZL9lG1c
         PulJ7GHS6HNUpzTIj+eQ0v5K+q2ytHmZghr37pyoA8jXMzauHjlKxlW33hzMEhQN19pi
         XKE7IHSbanvj0uAC2PTf40yBV3pydiO0JP6fCQVBc6y4dEBJd/Ph/Z8Vj/G6oZp1R8t/
         TnfS7EzY8W7QRXSQCUATo+zPFW66bo6VGO7WtLM3Lf/3zItx1kRzDUASW6Br6BoqnUls
         TXZA==
X-Forwarded-Encrypted: i=1; AJvYcCXUQu0iO2MkRnFB0l5s4zbUwpnYU+gxB/rjVuq8FXwyNwy7RRurR6Y5MK/kBkjuoi21JyxOqUJl21x1qu4MGNyugnxteF3o+E/CLP7cvRLg3E0HfbrdnNNEasL/lVKUfye5+pQO5wqz
X-Gm-Message-State: AOJu0Yy7f3CC53PHKkvzE0i+6R1xbz18+6WGYSOcR+Ncm4UtVaZ7gT+/
	QA26C/bzp2XZ6bebnugntWU6spirCwkDTwc2xEjGirWoisP42MZP
X-Google-Smtp-Source: AGHT+IGk38+WbUeNcq/hj9Cja/aRFF3vfVYc7zzXv7ZRVqWkCLgYHo/DWwpmNoSRuTTelmU9mNRuYg==
X-Received: by 2002:a17:902:cf52:b0:1ec:5f1f:364f with SMTP id d9443c01a7336-1f31c9869d5mr11208155ad.26.1716372736696;
        Wed, 22 May 2024 03:12:16 -0700 (PDT)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-f22f-74ff-fe1e-41ce.ip6.aussiebb.net. [2403:580b:97e8:0:f22f:74ff:fe1e:41ce])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f3066594bdsm44593235ad.303.2024.05.22.03.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 03:12:16 -0700 (PDT)
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
Subject: [PATCH v10 2/4] PCI/DOE: Rename Discovery Response Data Object Contents to type
Date: Wed, 22 May 2024 20:11:40 +1000
Message-ID: <20240522101142.559733-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240522101142.559733-1-alistair.francis@wdc.com>
References: <20240522101142.559733-1-alistair.francis@wdc.com>
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
---
v10:
 - Split original patch into two
v9:
 - Rename two more DOE macros
v8:
 - Rename prot to feat as well
v7:
 - Initial patch

 drivers/pci/doe.c             | 18 +++++++++---------
 include/uapi/linux/pci_regs.h |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

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
index 94c00996e633..4fa1ec622177 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1146,7 +1146,7 @@
 #define PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX		0x000000ff
 #define PCI_DOE_DATA_OBJECT_DISC_REQ_3_VER		0x0000ff00
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID		0x0000ffff
-#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
+#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE		0x00ff0000
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
 
 /* Compute Express Link (CXL r3.1, sec 8.1.5) */
-- 
2.45.1


