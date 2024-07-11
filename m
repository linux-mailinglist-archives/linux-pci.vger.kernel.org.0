Return-Path: <linux-pci+bounces-10181-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C59E92EFC2
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 21:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE8451C2249A
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 19:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DCA17A582;
	Thu, 11 Jul 2024 19:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Y3K9EfJn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999D017BB1C
	for <linux-pci@vger.kernel.org>; Thu, 11 Jul 2024 19:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720726621; cv=none; b=B6jWEQgTJZb4LC8vGBc3MrpUcZPPE42p6Gy56R+H8sgKDPDkm8YKPXOie8xFtONdOQYXJEEJNnuaOH8Yu/Y/9liDICdqysBQDwG6EPm1x0456sbbMbn0OP4cA6uOa/Cyci4qPKp8R0nFbEPhEeWTSNpNNEuiSWqg+2aw2S2zcPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720726621; c=relaxed/simple;
	bh=23QSvFlP9aV0gatCsjtf9AIcv3SomEtin5gNBlIsb/w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EL2Rmva8FQDQyVF0T9bnJQZkXTwH3DqmllJmx2QpBRv4A7QaCTot8rSCq8VB7JPdjO2GWo8U4B4/X3bQyaCIUReuzt7AeRnBOPOONtRef3YwZ+aaNLhWmUw6az1wd07EoGmh6cvvWIn4JNc45TnxtvgeqB2vTGKVtqgHZZsNdlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Y3K9EfJn; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BIHFwu010317
	for <linux-pci@vger.kernel.org>; Thu, 11 Jul 2024 12:36:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=itg
	hBYd0OCG28ly/dMNoSE3E/MWTzbMgHSpmpYlD1P0=; b=Y3K9EfJn2H2w1zuFHqk
	MtUfFIxu5hVdTIU5ReLVfiPiXGA0mBg2mifKfmm62DIkqJHcKOfwKK//64ZwdgjV
	jbGE53SHostriXCT/st1kKx07rIdWB2dLethbMwczRrtNw3Hga4ATFTBnP8iBjBr
	R7XtZuYUxyDexHjjs0MR+FlEOjurp8mvAM15KgPcmnggECu/nS/pr2t+j5DOKv5r
	q4dG/x0hkxa0I0wzJ6NVdqXhFectnphDgLWP+nLrpX9FcjrMSKM6k0bKDkN8nGnF
	I1972fxh2KOBKENFbiCz7CtyMSS7qtZpJwqqOwGteFBgGfEJI5F5ZHFgdwtCX0Hf
	klw==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 409uuhs4aa-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 11 Jul 2024 12:36:58 -0700 (PDT)
Received: from twshared53332.38.frc1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 11 Jul 2024 19:36:56 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 26B7F1073AD8F; Thu, 11 Jul 2024 12:36:51 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>
CC: <bhelgaas@google.com>, <kwilczynski@kernel.org>,
        Keith Busch
	<kbusch@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCHv2] PCI: fix recursive device locking
Date: Thu, 11 Jul 2024 12:36:50 -0700
Message-ID: <20240711193650.701834-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: RSrIl-g9p-XyDDcC5WVDer4zSwSGTeCr
X-Proofpoint-GUID: RSrIl-g9p-XyDDcC5WVDer4zSwSGTeCr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_14,2024-07-11_01,2024-05-17_01

From: Keith Busch <kbusch@kernel.org>

If one of the bus' devices has subordinates, the recursive call locks
itself, so no need to lock the device before the recursion or it will
surely deadlock.

Fixes: dbc5b5c0d268f87 ("PCI: Add missing bridge lock to pci_bus_lock()"
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
Changes from v1:

 Fixed the same recursive locking for pci_bus_trylock(),
 pci_slot_lock(), and pci_slot_trylock()

 drivers/pci/pci.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index df550953fa260..82b74d3f6bb1e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5488,9 +5488,10 @@ static void pci_bus_lock(struct pci_bus *bus)
=20
 	pci_dev_lock(bus->self);
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		pci_dev_lock(dev);
 		if (dev->subordinate)
 			pci_bus_lock(dev->subordinate);
+		else
+			pci_dev_lock(dev);
 	}
 }
=20
@@ -5502,7 +5503,8 @@ static void pci_bus_unlock(struct pci_bus *bus)
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		if (dev->subordinate)
 			pci_bus_unlock(dev->subordinate);
-		pci_dev_unlock(dev);
+		else
+			pci_dev_unlock(dev);
 	}
 	pci_dev_unlock(bus->self);
 }
@@ -5512,16 +5514,15 @@ static int pci_bus_trylock(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
=20
-	pci_dev_lock(bus->self);
+	if (!pci_dev_trylock(bus->self))
+		return 0;
+
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		if (!pci_dev_trylock(dev))
-			goto unlock;
 		if (dev->subordinate) {
-			if (!pci_bus_trylock(dev->subordinate)) {
-				pci_dev_unlock(dev);
+			if (!pci_bus_trylock(dev->subordinate))
 				goto unlock;
-			}
-		}
+		} else if (!pci_dev_trylock(dev))
+			goto unlock;
 	}
 	return 1;
=20
@@ -5529,7 +5530,8 @@ static int pci_bus_trylock(struct pci_bus *bus)
 	list_for_each_entry_continue_reverse(dev, &bus->devices, bus_list) {
 		if (dev->subordinate)
 			pci_bus_unlock(dev->subordinate);
-		pci_dev_unlock(dev);
+		else
+			pci_dev_unlock(dev);
 	}
 	pci_dev_unlock(bus->self);
 	return 0;
@@ -5563,9 +5565,10 @@ static void pci_slot_lock(struct pci_slot *slot)
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot !=3D slot)
 			continue;
-		pci_dev_lock(dev);
 		if (dev->subordinate)
 			pci_bus_lock(dev->subordinate);
+		else
+			pci_dev_lock(dev);
 	}
 }
=20
@@ -5591,14 +5594,13 @@ static int pci_slot_trylock(struct pci_slot *slot=
)
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot !=3D slot)
 			continue;
-		if (!pci_dev_trylock(dev))
-			goto unlock;
 		if (dev->subordinate) {
 			if (!pci_bus_trylock(dev->subordinate)) {
 				pci_dev_unlock(dev);
 				goto unlock;
 			}
-		}
+		} else if (!pci_dev_trylock(dev))
+			goto unlock;
 	}
 	return 1;
=20
@@ -5609,7 +5611,8 @@ static int pci_slot_trylock(struct pci_slot *slot)
 			continue;
 		if (dev->subordinate)
 			pci_bus_unlock(dev->subordinate);
-		pci_dev_unlock(dev);
+		else
+			pci_dev_unlock(dev);
 	}
 	return 0;
 }
--=20
2.43.0


