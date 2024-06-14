Return-Path: <linux-pci+bounces-8776-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1748E908010
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 02:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74AE128433E
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 00:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D9A19D882;
	Fri, 14 Jun 2024 00:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNXpSe3m"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99432107;
	Fri, 14 Jun 2024 00:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718323998; cv=none; b=Jee80PBk5Fp5TW94x/yrFbfkyeUq3Ik7hkIrTLxT2fz44N5YBDsZxidMg7IYAhUA0qjr6Ug6Sl08lMZiSik78GuHb82KHJV5ExDHDJWbD2WOPorQDLU6fPubAuMrS5YI7xJPDEBll2HPxwFsPIJP1fR6k7HsF8qhRF0HfiFOo2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718323998; c=relaxed/simple;
	bh=l0t2nAYjDQKcGwx87bX+R4XDBVmsDN3scYRi2nuqF8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSMtlbNZuDBEToLd5QGRQnBOaGulcdoOLSKNYqOUwzTmPcGh9xs0IRyAOpF1RdOPxKRB/3+orGoBA9fNCJb0QLewf56rvGP1eIfpEuPn3MZAocH4ENfjWtnA1uHZvsqVOQ/1okjtYFxWVy8YtkTPVk8qtHAs/HS2zUr3+ILy7Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNXpSe3m; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f6a837e9a3so11335615ad.1;
        Thu, 13 Jun 2024 17:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718323996; x=1718928796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=034J/8K4kQDI7Hva6PiHGORUE+CeYWcGsXlS0Co1EgI=;
        b=PNXpSe3mPCT6VGGXThOx8dERMVD3TYXhdKjkiq+AMZbgxNfJrPJZNcrAPjSCZTipnO
         pwE+XtzWZ5yMl8HrwMFT6I9smHioeO2+Vx8kowGtoxvWCgCameLlEbvrPo3hNMQw1QpX
         Ex+v67EgK7HG9Kx7tmNEBciWKxabdOVwQddxUuUDagr1QcmZ5h4rZH2bLbbESA/E1SeP
         u9KLRZx3v8eqUGNkOjaZ5mnnKQE45NNMJIrSTg/2kOyxO8mDzUQMc1ai/8RtPybctY3J
         0WQCX/zS6Bm3iJTeaodZXPpwggUPd3iHBntYxP/m0cqG+paZLRyiWim6NNK2Iv/hRMvL
         i0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718323996; x=1718928796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=034J/8K4kQDI7Hva6PiHGORUE+CeYWcGsXlS0Co1EgI=;
        b=Smzo+YVneXFw22rbDuDLgohfBQ/NuuzOw/0olkYPu0159bK1Yo2H303yDOZksAhae6
         aJWK6DBHqpivdwUAP/RYz//Cpi8e9JaXWOefKvBSHS/nGjaNffnwTNjXoE8IhC2Vz8/L
         9pFE/cEpUp1LvaAu5Zv6lK29WGnThaJzTYWKyIbHTJ+0GTHi4nEJnDQT6PuWqdep/732
         P/N6XdwPBrIaUf4TsZtXd02djvNOFWd0S/0RpblQ49l23qbTVf1fIMiOtuq9RJAxb92M
         3VUQLPRVpKEOPlVDqkYcD4LWipesDq6RrduKO4FjDXb4JkXln0RNs6SXCq0BsFYXeqw7
         IKpw==
X-Forwarded-Encrypted: i=1; AJvYcCUU7fFhHx6pBsTASguuZwecrNxu+GLxXioG+8p7n8LIB9sxF3cgB5NR1/nrSIGjp5Fym9T3Q7Ufosu6BGXRS5/MAWoEbnZA/8QpTemXnO2hKy4pV3kZbaYw9Xvx7VQc0cjMFjjI4Y16
X-Gm-Message-State: AOJu0Yxp8mtzyqAL1nZgxDdTH1L2ybSnrOorIJ9EX3qPQPd9kTG947kS
	Z6o5tbAQvcoPamPcAwAJ66YLv2ETjjh/A4wd5LQiemvLLiBdjgmD
X-Google-Smtp-Source: AGHT+IHpFwFX2vvgMlkQJzbb7MMIrzMPoKiPSXQgrkaBJUKSCLjCoYjdpvG1vxR0hO1m+rPq+c6+rg==
X-Received: by 2002:a17:902:d2d1:b0:1f7:124:b820 with SMTP id d9443c01a7336-1f862900664mr12760895ad.50.1718323995934;
        Thu, 13 Jun 2024 17:13:15 -0700 (PDT)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55decsm20181815ad.40.2024.06.13.17.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 17:13:15 -0700 (PDT)
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
Subject: [PATCH v11 2/4] PCI/DOE: Rename Discovery Response Data Object Contents to type
Date: Fri, 14 Jun 2024 10:12:42 +1000
Message-ID: <20240614001244.925401-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240614001244.925401-1-alistair.francis@wdc.com>
References: <20240614001244.925401-1-alistair.francis@wdc.com>
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
index 94c00996e633..ca692a3e1e5e 100644
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
+#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
+
 /* Compute Express Link (CXL r3.1, sec 8.1.5) */
 #define PCI_DVSEC_CXL_PORT				3
 #define PCI_DVSEC_CXL_PORT_CTL				0x0c
-- 
2.45.2


