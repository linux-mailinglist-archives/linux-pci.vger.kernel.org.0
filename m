Return-Path: <linux-pci+bounces-10610-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E68C09391A7
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 17:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912111F21CD8
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 15:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D159416D9AD;
	Mon, 22 Jul 2024 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="VuY98o2z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3795016DECF
	for <linux-pci@vger.kernel.org>; Mon, 22 Jul 2024 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721661627; cv=none; b=L0Vb/IlFITdVI4P7OuZpGsTjGek6nc3ScLnZsrSIiC1N5lbQ7Lm1swkTjsOFXdPEI5YLOTbcvQMxbOy8CZEqrDyp2nsbjennzmQn259a8VrrGKDrOl1NfrMr3kjC5KfrOEVkEtRvNaahZymGZ70rB66X+Y9MXnJxag7abjzGyWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721661627; c=relaxed/simple;
	bh=Q8upQJRiVw+LZzf0iiIMXKkGI4E0s59rz4nYoo6gbFM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FkXg1954/ZGtjTJoqOu0Sm8vIuuC4NsEJlEwzyioTgWXy1nH30aBhdtfCaKJiIiGYPyZlh1kC7JoK22AZnIFyJIJxQ7o/pxj61kg7fZHrJFch7Aii5h5EGSIcvPKZtCZQlbUYEc5hg68w5Prp2MUk/tiZjakZkRncarY0Veq3m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=VuY98o2z; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MF6Xxp028485
	for <linux-pci@vger.kernel.org>; Mon, 22 Jul 2024 08:20:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=X9PIEPlvbv7Lql+nxyevUr42IM75OwstLhHSvX2Euy4=; b=
	VuY98o2zgFRF9ZCsFD7ZZ9QnipKGZKTG7icoln6heVVYXbwUrmxOjpLMNfCwvUGy
	u90FMXARvhae7iLge/GtkpLP+uALRgg6bIVbElZrjLBuefP4za5Hg1DGmdBKsqvJ
	CerZ+gtRVHGAuuZcJ7Bkn7497TpMDK5T1SFTKiU7ZSzLseKJorFDREDNfm1xVG3A
	43GegmO04gmQgzCx42ln0BEq2TNEa175GN4zbpChFm3HvpphLt4LUSvDF/bY//qq
	4KAr5mB6VLGB5RVvButLGXBFDZ1Q4OxMCx68iz1bnkD38TpzoEvTjqj7gEk68mTO
	woCHPFNkrELoFfxiNAe/GQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 40gb2y09ys-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 22 Jul 2024 08:20:24 -0700 (PDT)
Received: from twshared5319.37.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Mon, 22 Jul 2024 15:20:21 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id BBFE010DA2DA2; Mon, 22 Jul 2024 08:20:06 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>, <lukas@wunner.de>
CC: <mika.westerberg@linux.intel.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH RFC 3/8] pci: move the walk bus lock to where its needed
Date: Mon, 22 Jul 2024 08:19:31 -0700
Message-ID: <20240722151936.1452299-4-kbusch@meta.com>
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
X-Proofpoint-GUID: TbRb7d_Yv5COmZt2O3zpDtI1udxqUdJ-
X-Proofpoint-ORIG-GUID: TbRb7d_Yv5COmZt2O3zpDtI1udxqUdJ-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_10,2024-07-22_01,2024-05-17_01

From: Keith Busch <kbusch@kernel.org>

Simplify the common function by removing an unnecessary parameter that
can be more easily handled in the only caller that wants it.

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
2.43.0


