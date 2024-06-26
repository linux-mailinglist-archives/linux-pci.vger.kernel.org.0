Return-Path: <linux-pci+bounces-9264-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B109177C0
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 07:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693D31F2235A
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 05:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B499528E7;
	Wed, 26 Jun 2024 05:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKj/ZoTT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4BF146A64;
	Wed, 26 Jun 2024 05:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719378006; cv=none; b=VFh+dUgM/PVBvekiaeUAY/339V8lEFznloV0ibkYkrv3A5WIkhksQgKjRAA8dJsAjH2H2iDCVMfGDnsU8FJByGkqOyAelM5zpffGprI2rCsuVb3ONdXzsf73F0mHcelDwY216nG0nh6rPJWSznaCCHL429RkBeLT+pdIOYNfh+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719378006; c=relaxed/simple;
	bh=Sth/LU1wSXBR2jwldg5kyrYhbRrHQzWFYPmCoSFgi+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRpmGq8+WhVtZ9ysqZlo7/WEQ5jpbWD/vzCzuzbn6R4T5hfRNv/WVGy8SHhFMX1CjdNyBo/+MdkzVJ9sTnooYwMch7rDhjQ9yEak5Ly2XV3xKM3+QSE7rH062l2WMlc6lX+ZgqxZsLgs6EWnJD/w62dU3YiFOoMDtCjEYKCqRMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKj/ZoTT; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3d55e2e0327so530310b6e.0;
        Tue, 25 Jun 2024 22:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719378004; x=1719982804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rvSFEud7zcqYRmVXbEv5ZUiNMPDlv8XZv7r7u1mw2o=;
        b=IKj/ZoTTjShgpAXr+FybXR8H/65LIaaNzEdarhobEqlXoPrlAsGM8QS1+WgPLo7MK4
         Y7JS6XkrDLSwdbTzw+tbyBq7f7U05DhdPc9miyBkRySRGYjOIwu2t4FX1498Btgh3o1x
         ep6WQJ6SC90kjdqgeJbAXyVyksRJXD8eQCkf08Q73QA0XQ4UyxYD1sL4JksPTahVEbQU
         cPnfka7Bcqot2lufVasiEnNrpe/kWsx7+50OoPBHgjbZcnRXGmHN16aQymvjDo2BJzXi
         cXlwBKrgMXnpYh1G6N/xrSjEbLA45SJ4mUsKFTqhiPGzm/3/Hj3uYLHguw/acvUn7ERI
         yiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719378004; x=1719982804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rvSFEud7zcqYRmVXbEv5ZUiNMPDlv8XZv7r7u1mw2o=;
        b=DMGT4Ew9Qxzm0eKSDaVIajB19cdwnKrJgh8ev/tNo1W6WwsE7wILHP5gzj/rJC3kMX
         nB+dPwisOhrre1VULBHvwyXyFfT6uzjQr/oggObV3yz66OoqGc1ASOc2fLnNUex5rXdu
         TxeXCDuSk5R4he3p2XJRfgb76G2euw4n7pV6jvqNHx/W513L9uvD4NjfM+/n7yNzEgTV
         if7WisUKEV0WZuOZQzxzkD6O9BGvN/GeSiurG7jaJuowq3hivZS7F4yuIAjOEwkr2gpV
         51il1zYArB7gy9gmoGTzmgY6+a7apMoChoGQnauCHMlh+LU2UPXsDFd5RX16MqxIiL/v
         wWVw==
X-Forwarded-Encrypted: i=1; AJvYcCU9gnJ14/JVNEYvtD8RHFySAWrdma8n8GUvQhvFl4ja51VfMcKgg6+nnIm9o4RdmkMdCI+M5vfoIKZInkHN0VMVErkT4AWSOtcVJfZx8RVeuND/upGFPO0XTfHcfg3S1AUhN3OzDP6x
X-Gm-Message-State: AOJu0Yy8zCTfpffUIr6lyeJ6zEq0tJdzGgCbCIRjuWv2AyyHFhlj+h2r
	GuMxNWUk6k90hX/XEhuW7xiIjCM5egX9enuo3QIZX2aH5SGli9sT
X-Google-Smtp-Source: AGHT+IFhEknC6pi/I5RrvVxcrix2J1yvlN14qQUX99u7YLEY25JDCOXHvLnK1VF/jkWjLVP1ha+R3Q==
X-Received: by 2002:a05:6808:1824:b0:3d5:1f50:188b with SMTP id 5614622812f47-3d543adb0e9mr12315851b6e.23.1719378004073;
        Tue, 25 Jun 2024 22:00:04 -0700 (PDT)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7066f30caa6sm6673382b3a.119.2024.06.25.21.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 22:00:03 -0700 (PDT)
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
Subject: [PATCH v12 2/4] PCI/DOE: Rename Discovery Response Data Object Contents to type
Date: Wed, 26 Jun 2024 14:59:24 +1000
Message-ID: <20240626045926.680380-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626045926.680380-1-alistair.francis@wdc.com>
References: <20240626045926.680380-1-alistair.francis@wdc.com>
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


