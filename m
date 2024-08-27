Return-Path: <linux-pci+bounces-12310-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F70D9617FC
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 21:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A5B2855F0
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 19:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422861D2F51;
	Tue, 27 Aug 2024 19:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="UVnSOxMA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF4377117
	for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 19:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724786927; cv=none; b=my1laPKNJp3epm0LVjJBmV1c94EJZe8Z2pQNi+PWoVpuuXOY9uCDykBxAD1SL25rEspAcxTz4GQFE9a5RooEmsCJ+XBddFdYmtFw+cuUuYoYAI3y5h+KY/SZ8u+gipSk/m+hdEBZSTuKjy4XIwsbdOXxRZWz1PvFE8kNIAzQzYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724786927; c=relaxed/simple;
	bh=E/+qtStYpXpXCDrSVIHwjtv5rEAN0n5iq+3C1UWmc9g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DxKopLF9GJxvyweJcHXaeww3ctXmBN2B+oDITXNicDFli0kGrs6wGIlgq6qcUGuG85UP1+06snTBdlEYWgK6Tkm7ZdaRVr7IzTBM/KmSQSNmq2ELOwu6pXGHzAH+hsSBBEtUu6cr62VcKdQWrVUdmk0RAFF6jVwqu2VMJcnpSv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=UVnSOxMA; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 47RFt2T1007760
	for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 12:28:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=DDxZ4ogSCd5XQxO5J8cTxC2SVOCKfOWZBaBLDzSX5Cc=; b=
	UVnSOxMAtWMy0Sec3114qlqDl3beYToEjJJ7wZfkg0HK5WQnUcvbNPYoGceRCFLt
	BMsDMrxmbxjNQGjjh4itlLT3JjbZESw7cTTPT9pZaCP5qS55stdLuGuXxvq3kPqk
	kKi7lEEGHcsASjtTBdBmDmIXbQA6MhJSk6kdne0w/K9C1Q+0o2mehPWPucuXhEey
	xsfDZLE3jJnP2hAO8gwWkXKVkIVCNqjBAE2F2oY7CYY/rpFGEGxv6M0+9C9dyXdN
	tSLx/lteAogxBjvm9wLe7tTWPoAB/d44ykKHL/TQdMaRQWBTA+TeP0UfZfQ1yqDh
	dY/Zxw4AJhQ8eC/Mg6Uxdw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 419hv0spkq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 12:28:44 -0700 (PDT)
Received: from twshared12613.02.ash9.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 27 Aug 2024 19:28:42 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 7396A124FD701; Tue, 27 Aug 2024 12:28:27 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>
CC: Keith Busch <kbusch@kernel.org>,
        Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCHv2 3/5] pci: move the walk bus lock to where its needed
Date: Tue, 27 Aug 2024 12:28:24 -0700
Message-ID: <20240827192826.710031-4-kbusch@meta.com>
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
X-Proofpoint-GUID: QpTHNjuKcVZZ-NbstagAGRVSBhF3Ni3Z
X-Proofpoint-ORIG-GUID: QpTHNjuKcVZZ-NbstagAGRVSBhF3Ni3Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_10,2024-08-27_01,2024-05-17_01

From: Keith Busch <kbusch@kernel.org>

Simplify the common function by removing an unnecessary parameter that
can be more easily handled in the only caller that wants it.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/bus.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index e41dfece0d969..7c07a141e8772 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -390,7 +390,7 @@ void pci_bus_add_devices(const struct pci_bus *bus)
 EXPORT_SYMBOL(pci_bus_add_devices);
=20
 static void __pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev=
 *, void *),
-			   void *userdata, bool locked)
+			   void *userdata)
 {
 	struct pci_dev *dev;
 	struct pci_bus *bus;
@@ -398,8 +398,6 @@ static void __pci_walk_bus(struct pci_bus *top, int (=
*cb)(struct pci_dev *, void
 	int retval;
=20
 	bus =3D top;
-	if (!locked)
-		down_read(&pci_bus_sem);
 	next =3D top->devices.next;
 	for (;;) {
 		if (next =3D=3D &bus->devices) {
@@ -422,8 +420,6 @@ static void __pci_walk_bus(struct pci_bus *top, int (=
*cb)(struct pci_dev *, void
 		if (retval)
 			break;
 	}
-	if (!locked)
-		up_read(&pci_bus_sem);
 }
=20
 /**
@@ -441,7 +437,9 @@ static void __pci_walk_bus(struct pci_bus *top, int (=
*cb)(struct pci_dev *, void
  */
 void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void =
*), void *userdata)
 {
-	__pci_walk_bus(top, cb, userdata, false);
+	down_read(&pci_bus_sem);
+	__pci_walk_bus(top, cb, userdata);
+	up_read(&pci_bus_sem);
 }
 EXPORT_SYMBOL_GPL(pci_walk_bus);
=20
@@ -449,7 +447,7 @@ void pci_walk_bus_locked(struct pci_bus *top, int (*c=
b)(struct pci_dev *, void *
 {
 	lockdep_assert_held(&pci_bus_sem);
=20
-	__pci_walk_bus(top, cb, userdata, true);
+	__pci_walk_bus(top, cb, userdata);
 }
 EXPORT_SYMBOL_GPL(pci_walk_bus_locked);
=20
--=20
2.43.5


