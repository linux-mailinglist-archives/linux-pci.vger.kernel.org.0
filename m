Return-Path: <linux-pci+bounces-10612-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 781E39391A9
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 17:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D4B281B5A
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 15:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97B516D4EF;
	Mon, 22 Jul 2024 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="BHK+JEAM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A711428F1
	for <linux-pci@vger.kernel.org>; Mon, 22 Jul 2024 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721661631; cv=none; b=WeiTKo2wOS2OhTyoARccEU8qjIKcgxugblDVDfjVwxJe8JqHMxKnGk98zNhi9/fVeOtELiiH2WV30S7ywBE1wiZCbucxC4wD3j0dlJEHWkPM/Z9UReBBFj9/9JmOpcVFq+MV/Bh7at3J15aCmoI0Auuecrb/+JMr5GeL2YA2/Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721661631; c=relaxed/simple;
	bh=xMBNPdpQXetoCO/5zx2Yi2BJ12Uz6OpyM3OsVrd6jwk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oEVTU3aDWjwg1HIvCnEqFwzia0dkuHrjwpyIqvFxLeT2XcQIbnSoKg4OKqnZmXnSHL9XYjNIBEM7p1AeD9f8dCcje5L/UsQrcPvO8qfFr2RSlwahVmQSr/1BkEw6h5kz12KsFBo4fFOXhspzL+7JYhdUlwzr6tkD6ZUBHNNaj7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=BHK+JEAM; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MF5rFE016663
	for <linux-pci@vger.kernel.org>; Mon, 22 Jul 2024 08:20:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=MlDn5G65Hx6Q86MEHaryX1P7wFBbsIKsy8lbFggSxqo=; b=
	BHK+JEAM84YTk3HXnzXGxsyDRqZeffjjsE1HznIrAq47RExpgt6BdL6w1ezw1oQn
	osu9ehYGjRcVYOW6lIsy+JG80rLMcjFGALignZVONU0MBsjWO219boDXTPCiyITQ
	iWOitdMCtLy6qJVyKPrGrPZFutHNKPGm8c+sFMuKMRinvc+Dw+gg5R1wJ02h1lxl
	k34VjjtZkKrNZOxUNPsC9tWh5pqML8dEs/suiRJsYXKIHa2aB34F7VaAHvjtRyYn
	Kfiz/OiriZyW8eaC4sqH2g3Ofx1QmAZ8iq3R5Lcv5UuHrBGl/6kzcyHtAuRXXmcH
	yQ1KjUWAVlKkeZV89cs85A==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 40garwr95w-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 22 Jul 2024 08:20:28 -0700 (PDT)
Received: from twshared5319.37.frc1.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Mon, 22 Jul 2024 15:20:21 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 46D1E10DA2DA8; Mon, 22 Jul 2024 08:20:06 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>, <lukas@wunner.de>
CC: <mika.westerberg@linux.intel.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH RFC 6/8] pci: add helpers for stop and remove bus
Date: Mon, 22 Jul 2024 08:19:34 -0700
Message-ID: <20240722151936.1452299-7-kbusch@meta.com>
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
X-Proofpoint-GUID: PVUJz2zICqmxoUVSPhrjzlk7Kfs0x9bh
X-Proofpoint-ORIG-GUID: PVUJz2zICqmxoUVSPhrjzlk7Kfs0x9bh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_10,2024-07-22_01,2024-05-17_01

From: Keith Busch <kbusch@kernel.org>

There are repeated patterns of tearing down pci buses, so combine to
helper functions and use these.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/remove.c | 46 +++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 8284ab20949c9..288162a11ab19 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -4,6 +4,9 @@
 #include <linux/of_platform.h>
 #include "pci.h"
=20
+static void pci_stop_bus(struct pci_bus *bus);
+static void pci_remove_bus_device(struct pci_dev *dev);
+
 static void pci_free_resources(struct pci_dev *dev)
 {
 	struct resource *res;
@@ -45,8 +48,17 @@ static void pci_destroy_dev(struct pci_dev *dev)
 	put_device(&dev->dev);
 }
=20
+static void pci_clear_bus(struct pci_bus *bus)
+{
+	struct pci_dev *dev, *next;
+
+	list_for_each_entry_safe(dev, next, &bus->devices, bus_list)
+		pci_remove_bus_device(dev);
+}
+
 void pci_remove_bus(struct pci_bus *bus)
 {
+	pci_clear_bus(bus);
 	pci_proc_detach_bus(bus);
=20
 	down_write(&pci_bus_sem);
@@ -66,7 +78,15 @@ EXPORT_SYMBOL(pci_remove_bus);
 static void pci_stop_bus_device(struct pci_dev *dev)
 {
 	struct pci_bus *bus =3D dev->subordinate;
-	struct pci_dev *child, *tmp;
+
+	if (bus)
+		pci_stop_bus(bus);
+	pci_stop_dev(dev);
+}
+
+static void pci_stop_bus(struct pci_bus *bus)
+{
+	struct pci_dev *dev, *next;
=20
 	/*
 	 * Stopping an SR-IOV PF device removes all the associated VFs,
@@ -74,29 +94,18 @@ static void pci_stop_bus_device(struct pci_dev *dev)
 	 * iterator.  Therefore, iterate in reverse so we remove the VFs
 	 * first, then the PF.
 	 */
-	if (bus) {
-		list_for_each_entry_safe_reverse(child, tmp,
-						 &bus->devices, bus_list)
-			pci_stop_bus_device(child);
-	}
-
-	pci_stop_dev(dev);
+	list_for_each_entry_safe_reverse(dev, next, &bus->devices, bus_list)
+		pci_stop_bus_device(dev);
 }
=20
 static void pci_remove_bus_device(struct pci_dev *dev)
 {
 	struct pci_bus *bus =3D dev->subordinate;
-	struct pci_dev *child, *tmp;
=20
 	if (bus) {
-		list_for_each_entry_safe(child, tmp,
-					 &bus->devices, bus_list)
-			pci_remove_bus_device(child);
-
 		pci_remove_bus(bus);
 		dev->subordinate =3D NULL;
 	}
-
 	pci_destroy_dev(dev);
 }
=20
@@ -129,16 +138,13 @@ EXPORT_SYMBOL_GPL(pci_stop_and_remove_bus_device_lo=
cked);
=20
 void pci_stop_root_bus(struct pci_bus *bus)
 {
-	struct pci_dev *child, *tmp;
 	struct pci_host_bridge *host_bridge;
=20
 	if (!pci_is_root_bus(bus))
 		return;
=20
 	host_bridge =3D to_pci_host_bridge(bus->bridge);
-	list_for_each_entry_safe_reverse(child, tmp,
-					 &bus->devices, bus_list)
-		pci_stop_bus_device(child);
+	pci_stop_bus(bus);
=20
 	/* stop the host bridge */
 	device_release_driver(&host_bridge->dev);
@@ -147,16 +153,12 @@ EXPORT_SYMBOL_GPL(pci_stop_root_bus);
=20
 void pci_remove_root_bus(struct pci_bus *bus)
 {
-	struct pci_dev *child, *tmp;
 	struct pci_host_bridge *host_bridge;
=20
 	if (!pci_is_root_bus(bus))
 		return;
=20
 	host_bridge =3D to_pci_host_bridge(bus->bridge);
-	list_for_each_entry_safe(child, tmp,
-				 &bus->devices, bus_list)
-		pci_remove_bus_device(child);
=20
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
 	/* Release domain_nr if it was dynamically allocated */
--=20
2.43.0


