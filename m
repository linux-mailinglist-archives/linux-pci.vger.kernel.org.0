Return-Path: <linux-pci+bounces-10609-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096D89391A6
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 17:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF5FE280F45
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 15:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DA61428F1;
	Mon, 22 Jul 2024 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="hc7UUFfI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A3C16D9AD
	for <linux-pci@vger.kernel.org>; Mon, 22 Jul 2024 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721661626; cv=none; b=KjYUX8LkObbr+KHOSVPda13mu1J9Sfl2lRDUBJpIJP1gnvY2AoHwUsEU6CuTqkQpbmB3rn7ukNoq/90nRX9BtHKzohLAjWRO8iy6Mz9EsyiRMxt1+Gzyp+pVhvh2U39jGu3pbOm2L1bV9FtjzKUMVkbzsN6MtXo2obYroyLx4Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721661626; c=relaxed/simple;
	bh=zWh/KCd15+IVzcMSx7MgWFW/r4pPgXRqoMG51vAFC0U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qTrKXrDHf5zfte/4pz8VCbqXT9obXMaDTdbcfl7pALi+Tjwf8eK/8tEbH06Q8MdN98B+nZ7XDZaOuK+gHqUR6tELnjW24Evlqo0Zl4QeJcy3UlkLygSzmUdamGN0SMygjccfBfIHMVUNYDtkixaO/t5PbibbOsgcA0/I5hss5ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=hc7UUFfI; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MF6Xxo028485
	for <linux-pci@vger.kernel.org>; Mon, 22 Jul 2024 08:20:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=xiVNsKFQgQWQybXMA8QD6cDtetvdN2dRhFAgNSIcZqk=; b=
	hc7UUFfIM+IWE028TUUAjNhihbJIGDKUONdod5fBuhk8tH4EhlFRkQmTh3XZ+NCO
	cg6qbXeqZAxplbXC2lm8Uc0YR8qYRuF8J2gA687RasgTBmGGStXVUpbP0dUUYOTY
	QF7gsBNep2Um9hp4QZJs+ZXic71VKnNJH0aYA/zlCsQVcLWMv23h4MUX6SnvPUyq
	knBkCvFPzOX9hllsnMjCCo7K3ypnPbhJVk8/Z9m3HcCKt18oJYYkViR1zvVFtHfc
	87fEpzE5q7ujbTaaTWCvy9IKAUEnHgwZSju4Kurbu5Y3V6ACLN9XHxsycf8A4XIX
	UHHLpI10U8RZoeds4bXoSw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 40gb2y09ys-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 22 Jul 2024 08:20:23 -0700 (PDT)
Received: from twshared5319.37.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Mon, 22 Jul 2024 15:20:21 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 18E2110DA2D9C; Mon, 22 Jul 2024 08:20:06 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>, <lukas@wunner.de>
CC: <mika.westerberg@linux.intel.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH RFC 1/8] pci: make pci_stop_dev concurrent safe
Date: Mon, 22 Jul 2024 08:19:29 -0700
Message-ID: <20240722151936.1452299-2-kbusch@meta.com>
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
X-Proofpoint-GUID: WCex4mV7J3n1kKFYMVrm0SWjvNRSriyJ
X-Proofpoint-ORIG-GUID: WCex4mV7J3n1kKFYMVrm0SWjvNRSriyJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_10,2024-07-22_01,2024-05-17_01

From: Keith Busch <kbusch@kernel.org>

Use the atomic ADDED flag to safely ensure concurrent callers can't
attempt to stop the device multiple times.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/bus.c    |  2 +-
 drivers/pci/pci.h    |  9 +++++++--
 drivers/pci/remove.c | 18 ++++++++----------
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 55c8536860518..e41dfece0d969 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -348,7 +348,7 @@ void pci_bus_add_device(struct pci_dev *dev)
 	if (retval < 0 && retval !=3D -EPROBE_DEFER)
 		pci_warn(dev, "device attach failed (%d)\n", retval);
=20
-	pci_dev_assign_added(dev, true);
+	pci_dev_assign_added(dev);
=20
 	if (dev_of_node(&dev->dev) && pci_is_bridge(dev)) {
 		retval =3D of_platform_populate(dev_of_node(&dev->dev), NULL, NULL,
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 79c8398f39384..171dfd6f14e6e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -444,9 +444,14 @@ static inline int pci_dev_set_disconnected(struct pc=
i_dev *dev, void *unused)
 #define PCI_DPC_RECOVERED 1
 #define PCI_DPC_RECOVERING 2
=20
-static inline void pci_dev_assign_added(struct pci_dev *dev, bool added)
+static inline void pci_dev_assign_added(struct pci_dev *dev)
 {
-	assign_bit(PCI_DEV_ADDED, &dev->priv_flags, added);
+	set_bit(PCI_DEV_ADDED, &dev->priv_flags);
+}
+
+static inline bool pci_dev_test_and_clear_added(struct pci_dev *dev)
+{
+	return test_and_clear_bit(PCI_DEV_ADDED, &dev->priv_flags);
 }
=20
 static inline bool pci_dev_is_added(const struct pci_dev *dev)
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 910387e5bdbf9..ec3064a115bf8 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -16,17 +16,15 @@ static void pci_free_resources(struct pci_dev *dev)
=20
 static void pci_stop_dev(struct pci_dev *dev)
 {
-	pci_pme_active(dev, false);
-
-	if (pci_dev_is_added(dev)) {
-		of_platform_depopulate(&dev->dev);
-		device_release_driver(&dev->dev);
-		pci_proc_detach_device(dev);
-		pci_remove_sysfs_dev_files(dev);
-		of_pci_remove_node(dev);
+	if (!pci_dev_test_and_clear_added(dev))
+		return;
=20
-		pci_dev_assign_added(dev, false);
-	}
+	pci_pme_active(dev, false);
+	of_platform_depopulate(&dev->dev);
+	device_release_driver(&dev->dev);
+	pci_proc_detach_device(dev);
+	pci_remove_sysfs_dev_files(dev);
+	of_pci_remove_node(dev);
 }
=20
 static void pci_destroy_dev(struct pci_dev *dev)
--=20
2.43.0


