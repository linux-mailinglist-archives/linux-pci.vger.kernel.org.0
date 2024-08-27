Return-Path: <linux-pci+bounces-12309-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6352F9617FD
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 21:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06265B21FAA
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 19:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF6E1D2F57;
	Tue, 27 Aug 2024 19:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="dpalijuQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDF1132132
	for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 19:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724786923; cv=none; b=b7dwgW41aoOO8ZW/2SJ+kifC5zS8IOo4LRlKhlP8MWRGb+ZRDGxdFcmm+xfYmC/Vjc8gy00RaJpUl+d7JX5oxvNVWAz57xmhC2NUcU0M7WVwg63UmOPM5Qb3tG8E9Dg0ZeIFxF4QMNTsAGAoA9hzkdD9KlErUqU0Od+XZMD3W1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724786923; c=relaxed/simple;
	bh=a6NCCDdTnSSsJB5vWnt0siNlrk3CvqWYP7g4gDbh8RU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4npiq4N5SbOMGkbL312ikwyh+HhSFiUGI+WjlhbY18JL8HSxeQI1Iz7g6Lvj+XryJ5xufgRhVkIR46YE9L7JtIzC6Pv55hSMiP7jFHB5+r+WcZllWqffwlKlh+eeJBdAsQ1O2OMusMovPBME/etP9aDOUgZqrtAfL4JQTFYGww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=dpalijuQ; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RCZDOa032104
	for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 12:28:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=d858pWi/zFT9xDr3h2lbGxr8x/wj5Mm1d6pL7kZwpdE=; b=
	dpalijuQVqZ5FATIy4XZXFnrmAMwgcU1kKBUdTq6v4bOp8SNmoAaMBNhfG98CxoU
	cav3WDzQduzDMC0OZPyeR1YZD35et5YHkjflT54k2aH7YZKrai36xoyONxz2mhxI
	8V3ps2IMtaeYTZlao49wfU7KJH08f26EHqVsqeocoeZwTrzN/4UKHZqGR/Joi0wC
	ru87sfLxObE5O7FG47rAa1UODdGFuhl+pvvfxlft9MjhCj/l9Ck7clmk8mN0qkRa
	H7ugY/ZhqgwSjBj2++ovb0bI7motAwb9cCSmSgjwgTTUKPVxhYVMSAuxOCf62mLU
	006Kl4G/zRcp2HARn9fMwQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 419ex535tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 12:28:40 -0700 (PDT)
Received: from twshared48671.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 27 Aug 2024 19:28:39 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 6D802124FD6FD; Tue, 27 Aug 2024 12:28:27 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>
CC: Keith Busch <kbusch@kernel.org>,
        Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCHv2 2/5] pci: make pci_destroy_dev concurrent safe
Date: Tue, 27 Aug 2024 12:28:23 -0700
Message-ID: <20240827192826.710031-3-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240827192826.710031-1-kbusch@meta.com>
References: <20240827192826.710031-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 5dPYKMpvMS12Z3fwN1h1nUL9OHCYpoLf
X-Proofpoint-ORIG-GUID: 5dPYKMpvMS12Z3fwN1h1nUL9OHCYpoLf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_10,2024-08-27_01,2024-05-17_01

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
index 802f7eac53115..a11a53f67a0ce 100644
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
2.43.5


