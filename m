Return-Path: <linux-pci+bounces-15068-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F54C9AB99A
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 00:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FFD41C22FFB
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 22:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D951CCEDB;
	Tue, 22 Oct 2024 22:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="GrCrj5pA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFE61C8FCF
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 22:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729637350; cv=none; b=u1FandBt4hLcvIGZXxDhD/vFYWIqzAXO+rqLeeL3vyU235P6aqKVZdqEZIMiyvQeKgCPgL6RD1/zk6xWejfmMImUSYEVHysilcVxZu+JxydeX1QOSfgciG1j4z4Kbwpfaz6cm3WMpDaWBNOPiYmcxg4Kahug4CYqciVsWUUCQPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729637350; c=relaxed/simple;
	bh=a15521MOGeqZ1cJ69vj9iYsK5ut2rHJLwjyWRShlC5k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q3+L+Lq2i4U7E9mCsrwhOTp4qEekIH2KjHC+AabKjuFJD+PPOBnaatYW8wQRJpZZSHOASjyOL4gyhgbuWtOaQZXzJg9OzMVGFf1nT3ImivbiZS8hhLZxcqtFoFzziyddlFOqYY/7e/VTOVxNtMA7hVnxpLnvLIkKCTW91jM5fd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=GrCrj5pA; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MLYUaf013198
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 15:49:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=JliJt//HLigc9llM64OOEVUe6/OfzydkWpVzE1gpEC0=; b=GrCrj5pA6zlQ
	sO6uEr21khIIyMqAJ6wdV0KRV2UHtkJaHf4WfHrE89jXj9HZytg0Fe8pDbJMWb34
	emqtQ8/C4T1o6JohY4o/5oS2m4WS004tv2uv1cVYRsDDM8ZE5U93v419m3EaxXGG
	ADl1OGyohJrLIDb7hg8F7XmjZ1gCIDhfbdGBkAWPZAdYyTsqZccm80VJJMK4fRyL
	7xddR6cVav3SJ8jPQaYBxVdJ3tJds0Bd01zInzKVh2RMY7nOD+KjMFX39squkSQT
	bliwoI8b2mMC711V9Ct9dRvbtM0ZNdgBHu1VDSM3oIoI93h1J3GvgXVbrj70+XSr
	kbOl4HiRnQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42em38ge1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 15:49:07 -0700 (PDT)
Received: from twshared11284.02.ash9.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 22 Oct 2024 22:49:06 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 8E25F14610C98; Tue, 22 Oct 2024 15:48:53 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>
CC: <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>,
        Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCHv3 2/5] pci: make pci_destroy_dev concurrent safe
Date: Tue, 22 Oct 2024 15:48:48 -0700
Message-ID: <20241022224851.340648-3-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241022224851.340648-1-kbusch@meta.com>
References: <20241022224851.340648-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: VUl-_-60KvDO1KcBOpkebdueZ54on7K0
X-Proofpoint-ORIG-GUID: VUl-_-60KvDO1KcBOpkebdueZ54on7K0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

From: Keith Busch <kbusch@kernel.org>

Use an atomic flag instead of the racey check against the device's kobj
parent. We shouldn't be poking into device implementation details at
this level anyway.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/pci.h    | 6 ++++++
 drivers/pci/remove.c | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c4cceec006d0d..cae4f55d5a4be 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -469,6 +469,7 @@ static inline int pci_dev_set_disconnected(struct pci=
_dev *dev, void *unused)
 #define PCI_DEV_ADDED 0
 #define PCI_DPC_RECOVERED 1
 #define PCI_DPC_RECOVERING 2
+#define PCI_DEV_REMOVED 3
=20
 static inline void pci_dev_assign_added(struct pci_dev *dev)
 {
@@ -487,6 +488,11 @@ static inline bool pci_dev_is_added(const struct pci=
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
index e0d4402ec3391..2e940101ce1bf 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -45,7 +45,7 @@ static void pci_stop_dev(struct pci_dev *dev)
=20
 static void pci_destroy_dev(struct pci_dev *dev)
 {
-	if (!dev->dev.kobj.parent)
+	if (pci_dev_test_and_set_removed(dev))
 		return;
=20
 	pci_npem_remove(dev);
--=20
2.43.5


