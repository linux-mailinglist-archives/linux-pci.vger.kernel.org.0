Return-Path: <linux-pci+bounces-15073-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CCB9AB9A3
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 00:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0EFB2847BD
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 22:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E2F1CF2BB;
	Tue, 22 Oct 2024 22:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="b6AIl4fV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15EC1CDFAE
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 22:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729637359; cv=none; b=NWkdm8qgmZBYDqggwJ1saOQO/yTHOjPPans92n+skawx202FtiCPY+pxVarBdRNyKm2I/CUxTH1M8azTRU1rRgmGxuel0ZjsCqLUuhcDzy6cVIyYH2iC77oQhOQelCOrF8AN//4RFaOYszgImoW0sWc81tAwKHSZT2YjwVnmYqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729637359; c=relaxed/simple;
	bh=viiuCp8o8xe/WgY+254iES/RD5a7szdU4pB3fCcKt5Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lTGWJJDSx/60eUn0/56N9cKqbJ+TGWIrFAv2VLnBQouTUJrxWZrlFu0hfGwBL8zHb/d4i/s2t4kEkfWWk1iOeUHnWDnR6xjWt/3N0UFUimd0DzraeECKRUuFgsIQM6Qi2D3ugTzHCo2RNIGo0ZfOqRj5LL5hyvbuCPGTpY2lfY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=b6AIl4fV; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MLZgaY000394
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 15:49:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=s5DkJC0dpxojjbkkf8DNyHozhv8fkFdulB2c6JVTBlw=; b=b6AIl4fV3oPL
	ZRVFJYRkG0bl9sYUREjryVlmeWNie2LlTaAE+yAN+JgsT2icbcLEPARrghP+0rbT
	rgvZTaxmALeaAmBYECxWi6mav+lvDhenERbZuJQ/fd10Et8CJIoV4RqWfvZBIQMC
	WdezCAJJGytijzAwa2dT+2MB7Y3e8Chn53dx4wMBXzvHTXuJmZ+heH/TaB8V9CL9
	p9ppgJdZGaklb10grm02DN/LyDG0G4U52wYuTi6aaosOXpihTSGuriglFHWN0Y+0
	7BphSwp2NqherMfmo7c4f9Xfq4ypSKOTSvRr7Eb8jAwMaLEHKn/1Kk0LKELel4sd
	KbyJ+pLcZw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42em3h0dsm-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 15:49:16 -0700 (PDT)
Received: from twshared4872.05.ash9.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 22 Oct 2024 22:49:08 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 8600414610C96; Tue, 22 Oct 2024 15:48:53 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>
CC: <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>,
        Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCHv3 1/5] pci: make pci_stop_dev concurrent safe
Date: Tue, 22 Oct 2024 15:48:47 -0700
Message-ID: <20241022224851.340648-2-kbusch@meta.com>
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
X-Proofpoint-GUID: _5JMbL-jI-cdjh5Ra0ektapL2jD1-yhL
X-Proofpoint-ORIG-GUID: _5JMbL-jI-cdjh5Ra0ektapL2jD1-yhL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01

From: Keith Busch <kbusch@kernel.org>

Use the atomic ADDED flag to safely ensure concurrent callers can't
attempt to stop the device multiple times. Callers should currently all
be holding the pci_rescan_remove_lock, so there shouldn't be an existing
race. But that global lock can cause lock dependency issues, so this is
preparing to reduce reliance on that lock by using the existing existing
atomic bit ops.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/bus.c    |  2 +-
 drivers/pci/pci.h    | 11 +++++++++--
 drivers/pci/remove.c | 20 +++++++++-----------
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index e0a2441be6d32..aec08e81abff7 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -358,7 +358,7 @@ void pci_bus_add_device(struct pci_dev *dev)
 	if (retval < 0 && retval !=3D -EPROBE_DEFER)
 		pci_warn(dev, "device attach failed (%d)\n", retval);
=20
-	pci_dev_assign_added(dev, true);
+	pci_dev_assign_added(dev);
=20
 	if (dev_of_node(&dev->dev) && pci_is_bridge(dev)) {
 		retval =3D of_platform_populate(dev_of_node(&dev->dev), NULL, NULL,
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index d89fdbf04f363..c4cceec006d0d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -470,9 +470,16 @@ static inline int pci_dev_set_disconnected(struct pc=
i_dev *dev, void *unused)
 #define PCI_DPC_RECOVERED 1
 #define PCI_DPC_RECOVERING 2
=20
-static inline void pci_dev_assign_added(struct pci_dev *dev, bool added)
+static inline void pci_dev_assign_added(struct pci_dev *dev)
 {
-	assign_bit(PCI_DEV_ADDED, &dev->priv_flags, added);
+	smp_mb__before_atomic();
+	set_bit(PCI_DEV_ADDED, &dev->priv_flags);
+	smp_mb__after_atomic();
+}
+
+static inline bool pci_dev_test_and_clear_added(struct pci_dev *dev)
+{
+	return test_and_clear_bit(PCI_DEV_ADDED, &dev->priv_flags);
 }
=20
 static inline bool pci_dev_is_added(const struct pci_dev *dev)
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index e4ce1145aa3ee..e0d4402ec3391 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -31,18 +31,16 @@ static int pci_pwrctl_unregister(struct device *dev, =
void *data)
=20
 static void pci_stop_dev(struct pci_dev *dev)
 {
-	pci_pme_active(dev, false);
-
-	if (pci_dev_is_added(dev)) {
-		device_for_each_child(dev->dev.parent, dev_of_node(&dev->dev),
-				      pci_pwrctl_unregister);
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
+	device_for_each_child(dev->dev.parent, dev_of_node(&dev->dev),
+			      pci_pwrctl_unregister);
+	device_release_driver(&dev->dev);
+	pci_proc_detach_device(dev);
+	pci_remove_sysfs_dev_files(dev);
+	of_pci_remove_node(dev);
 }
=20
 static void pci_destroy_dev(struct pci_dev *dev)
--=20
2.43.5


