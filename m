Return-Path: <linux-pci+bounces-10606-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BC89391A3
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 17:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4405C281B04
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 15:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450F616DEDA;
	Mon, 22 Jul 2024 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="OZxbqRBM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13631428F1
	for <linux-pci@vger.kernel.org>; Mon, 22 Jul 2024 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721661619; cv=none; b=oZDg2tMvFxuJZBCglhADdhOTRfhF3gd2uhmptg1a1le7Vjdm2RK9FOhUM/r1jn02uUfZ60uGs8tuzyZRQzGH8frmJ6WLeLaSVjLLHV0qxyOgvyRe4KSgemJGCy8dwGYa3D+NYgr1Wc/+vAuEO5TNxEaj1xaXCkhJ8GTcvFA+xxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721661619; c=relaxed/simple;
	bh=tr+sd15CCmd14CRZVH3x0xeH8QeazRn86Fu7MGfrr70=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZPoS32Jb+eiOJwFxS3+y4vbJ1BlH6Mi3RL5ZJ9GffhYHakw4t3ba0Hsab4sVnL4mfVMDTaokZM/bQFc7FFOcXC3YWb5meB+xz05AOScPbodtb6nIf7lEUsPpZUuPUVLgzyw5cLSlWTvH6bOFtYzauQzxD+Rata8lkXVPOiL34QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=OZxbqRBM; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MF775Z003181
	for <linux-pci@vger.kernel.org>; Mon, 22 Jul 2024 08:20:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=psj5xqMgUZAmZn4fEDGlNxkA/jse+rQe6TK7u+4Spnk=; b=
	OZxbqRBMtCc81j/vHeet/vdqkDD0K2BFPr8noNX5gnuztnJ96DioW6nR2kLq7358
	3cWhcDMnCXW4kRk9htFgAVELaxlsfQmQWfng5phJlzjGIjp4JJb2sBKYq4f6mc33
	s/BH2NWR4urH95okMCJ6J8mmDU790C+Z54VDU7Ze/ZKOkQ7o7KOwGttSGGQuz8nG
	RStICFqH1CMohB7L6xICuBA4dXPnU7f4aseGSliQ72ZQTbWRNggN2zOzI5cpjNmp
	JIwGfXLsgdeti9xVyukJ3RmP+It+gAefxGm4bRJL3Xpowv2ogAOAc5Tnc4ZoEnod
	9AlfDEcemUx11A5JeFIHJA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 40gaxggamj-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 22 Jul 2024 08:20:17 -0700 (PDT)
Received: from twshared53332.38.frc1.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Mon, 22 Jul 2024 15:20:15 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 7681F10DA2D9E; Mon, 22 Jul 2024 08:20:06 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>, <lukas@wunner.de>
CC: <mika.westerberg@linux.intel.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH RFC 2/8] pci: make pci_destroy_dev concurrent safe
Date: Mon, 22 Jul 2024 08:19:30 -0700
Message-ID: <20240722151936.1452299-3-kbusch@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240722151936.1452299-1-kbusch@meta.com>
References: <20240722151936.1452299-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 600UgNzdmKWJu71xEglozI6D5AIP5tSo
X-Proofpoint-ORIG-GUID: 600UgNzdmKWJu71xEglozI6D5AIP5tSo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_10,2024-07-22_01,2024-05-17_01

From: Keith Busch <kbusch@kernel.org>

Use an atomic flag instead of the racey check against the device's kobj
parent. We shouldn't be poking into device implementation details at
this level anyway.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/pci.h    | 6 ++++++
 drivers/pci/remove.c | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 171dfd6f14e6e..19cbf18743a96 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -443,6 +443,7 @@ static inline int pci_dev_set_disconnected(struct pci=
_dev *dev, void *unused)
 #define PCI_DEV_ADDED 0
 #define PCI_DPC_RECOVERED 1
 #define PCI_DPC_RECOVERING 2
+#define PCI_DEV_REMOVED 3
=20
 static inline void pci_dev_assign_added(struct pci_dev *dev)
 {
@@ -459,6 +460,11 @@ static inline bool pci_dev_is_added(const struct pci=
_dev *dev)
 	return test_bit(PCI_DEV_ADDED, &dev->priv_flags);
 }
=20
+static inline bool pci_dev_test_and_set_removed(struct pci_dev *dev)
+{
+	return test_and_set_bit(PCI_DEV_REMOVED, &dev->priv_flags);
+}
+
 #ifdef CONFIG_PCIEAER
 #include <linux/aer.h>
=20
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index ec3064a115bf8..8284ab20949c9 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -29,7 +29,7 @@ static void pci_stop_dev(struct pci_dev *dev)
=20
 static void pci_destroy_dev(struct pci_dev *dev)
 {
-	if (!dev->dev.kobj.parent)
+	if (pci_dev_test_and_set_removed(dev))
 		return;
=20
 	device_del(&dev->dev);
--=20
2.43.0


