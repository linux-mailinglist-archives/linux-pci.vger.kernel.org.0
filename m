Return-Path: <linux-pci+bounces-12311-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F529617FF
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 21:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B58A1F24AAA
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 19:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4BB77117;
	Tue, 27 Aug 2024 19:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="cVrEs83y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DA61CFEDC
	for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 19:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724786928; cv=none; b=kmf/bUxEtNdxoWiYwPDDZ4txOur23WHQDnWUzkwR/TENenCchSfFMtHAj82andwjZ4CfFGup4Kw/q9J7y+Eq2XbYlXWu9XIOBTeZyUy0QTZuLOO6jTUanQEUutMsfDkCbZ/1oEb1hrtIlU6efLg3ZGjqidM/fnsqs5FTc0yjoSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724786928; c=relaxed/simple;
	bh=WtOPoHH3ojk9bNzE7wbXIg0IreFI7gitEnQygH1FEic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=czl+Xh6qWRXbtha5+8H1OX0W326JBRxiixeyH7OyfbtMy9BKNAzpVGBQRgSb984efCR44J6HNnaf7s/mfAckA54FMZNCMuZOwYpzQ4gKM2xRlTKDDRFxRGpwXj2X0Fxc89lvFOSw1Rhci817hgBodhGZ3eBFPS8i9OHXTB/4acA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=cVrEs83y; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 47RFt2T4007760
	for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 12:28:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=9VsB0PPrNZTkTmlsWbAcw57wmOrI4jSQmU95eVUSBl4=; b=
	cVrEs83yfZ31sli+wzx7H6JPjr8YOjGSPe3UjNO8FqXVsSDwlkSZi9okAEbb7pwD
	yYiMUXnlEG0Z+WCx3QzUZFn/TigwXFfHh9jadw52/4G6yW0OU8DuqEpx5T9Vg7at
	LfwnpE1AxmqZPjHYGAKPwW6ABdAvmC9gVqiHB7B7rzKPsqsDaQD3XYBoaHalWHGP
	WI0+D9SRIcbrOaco695Ax2xlH0D6jgBfwQy7G2CFVFXBcpTaOZoBS4dtX9ll3bJ7
	nzcL3xtC/2TJ/SgPMmYN/Egx/k/cNtxI76oWA7bELzwYS95n61Oyx1h5i7UPXks2
	eWTRCAvtbTOCHsN0QjEPsw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 419hv0spkq-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 12:28:45 -0700 (PDT)
Received: from twshared12613.02.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 27 Aug 2024 19:28:42 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 61516124FD6FB; Tue, 27 Aug 2024 12:28:27 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>
CC: Keith Busch <kbusch@kernel.org>,
        Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCHv2 1/5] pci: make pci_stop_dev concurrent safe
Date: Tue, 27 Aug 2024 12:28:22 -0700
Message-ID: <20240827192826.710031-2-kbusch@meta.com>
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
X-Proofpoint-GUID: dqN3zLU7dCgk-m1FlhkNgsrRrykEMlUL
X-Proofpoint-ORIG-GUID: dqN3zLU7dCgk-m1FlhkNgsrRrykEMlUL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_10,2024-08-27_01,2024-05-17_01

From: Keith Busch <kbusch@kernel.org>

Use the atomic ADDED bit flag to safely ensure concurrent callers can't
attempt to stop the device multiple times. Callers should currently be
holding the pci_rescan_remove_lock, so there shouldn't be fixing any
existing race. But that global lock can cause lock dependency issues, so
this is preparing to reduce reliance on that lock by using the existing
atomic bit ops.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
index 0e9b1c7b94a5a..802f7eac53115 100644
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
2.43.5


