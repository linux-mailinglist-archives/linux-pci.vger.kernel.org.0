Return-Path: <linux-pci+bounces-10608-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8719391A5
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 17:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3911C2157F
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 15:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9CA16DED9;
	Mon, 22 Jul 2024 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="T0OOWjHT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE3716E861
	for <linux-pci@vger.kernel.org>; Mon, 22 Jul 2024 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721661621; cv=none; b=Cb8TzDnQgkdMgoSKj6kbm2dDFpHxauDS5xBFjvTxbNJ4NLa++Wy/cnIz939Co2Td70roiTddnj1VpafLoxoTZDdrY21y9kDzTpc1YxhzjMrraU7wNJGXxv94y68YXQ4u+ruv6d/onBwvlB9Dy6CKa8ZAvtW+UF9C2InMtwstdKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721661621; c=relaxed/simple;
	bh=eX5ayP8mydF508ZeAhyCUCkBu2JsKBuSE7UVptZ9eKg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gQ4dlhxIgIbEd+9wz7lnPrbsoac1HhJWIq2ALsa0j1lfXc7E40P89tnCzJzCR2hU+SXanMIFVeK1vWaMUOtrPeKSisf30sq1lfYZ7GjFLg+T4f1wfJNuntm9i8WFgWjLcKZxv1M0TvRPwmmUQQdQZcpJkHSHl1AwHS9wKdeHYzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=T0OOWjHT; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MF5uMJ032160
	for <linux-pci@vger.kernel.org>; Mon, 22 Jul 2024 08:20:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=n6yJ78kesDD1jOhEOyxvWuy6+WcsIOgoNRY4IsazV5Q=; b=
	T0OOWjHTPIwxukW4EJFEooUpIvWMQQFvc4Ks+nEKw2/A8rdzRaZWrmC5cy2XpF/P
	CUip1xu/PmM0dEGfO4R8gvIYk0V0mdGSZ4MrwFQy1dbO886hixUHr6EJ4ohP8WLM
	En62B05dyxKGPWWmlhQO70xUw0QIexnLpwgnkoGRSuYBmOu5up5D3aavQEzPlmec
	jLBg+n8ai3zQ7/c2lvuGMWHtC+sBFuFjuYVnHv8BWuLwrmVVY+blP+HXJNCzDzG6
	gTKKi8LJNAGUsOmpHtipatuAAf2reps4UoklLvIthhkfBxRJ/iAKSRjwvbJWhQ1E
	IxrLS+R5wvTpUxaQwAXXqw==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 40gabsgd9d-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 22 Jul 2024 08:20:18 -0700 (PDT)
Received: from twshared19175.17.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Mon, 22 Jul 2024 15:20:15 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id C7E0910DA2DA4; Mon, 22 Jul 2024 08:20:06 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>, <lukas@wunner.de>
CC: <mika.westerberg@linux.intel.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH RFC 4/8] pci: walk bus recursively
Date: Mon, 22 Jul 2024 08:19:32 -0700
Message-ID: <20240722151936.1452299-5-kbusch@meta.com>
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
X-Proofpoint-ORIG-GUID: 9QaGUX8oL5Ukea9t8OQOoxMsiPGAVUuy
X-Proofpoint-GUID: 9QaGUX8oL5Ukea9t8OQOoxMsiPGAVUuy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_10,2024-07-22_01,2024-05-17_01

From: Keith Busch <kbusch@kernel.org>

The original implementation purposefully chose a non-recursive walk,
presumably as a precaution on stack use. We do recursive bus walking in
other places though. For example:

  pci_bus_resettable
  pci_stop_bus_device
  pci_remove_bus_device
  pci_bus_allocate_dev_resources

So, recursive pci bus walking is well tested and safe, and the
implementation is easier to follow. The motivation for changing it now
is to make it easier to introduce finer grain locking in the future.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/bus.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 7c07a141e8772..b7208e644c79f 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -389,37 +389,23 @@ void pci_bus_add_devices(const struct pci_bus *bus)
 }
 EXPORT_SYMBOL(pci_bus_add_devices);
=20
-static void __pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev=
 *, void *),
+static int __pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev =
*, void *),
 			   void *userdata)
 {
 	struct pci_dev *dev;
-	struct pci_bus *bus;
-	struct list_head *next;
-	int retval;
+	int ret =3D 0;
=20
-	bus =3D top;
-	next =3D top->devices.next;
-	for (;;) {
-		if (next =3D=3D &bus->devices) {
-			/* end of this bus, go up or finish */
-			if (bus =3D=3D top)
+	list_for_each_entry(dev, &top->devices, bus_list) {
+		ret =3D cb(dev, userdata);
+		if (ret)
+			break;
+		if (dev->subordinate) {
+			ret =3D __pci_walk_bus(dev->subordinate, cb, userdata);
+			if (ret)
 				break;
-			next =3D bus->self->bus_list.next;
-			bus =3D bus->self->bus;
-			continue;
 		}
-		dev =3D list_entry(next, struct pci_dev, bus_list);
-		if (dev->subordinate) {
-			/* this is a pci-pci bridge, do its devices next */
-			next =3D dev->subordinate->devices.next;
-			bus =3D dev->subordinate;
-		} else
-			next =3D dev->bus_list.next;
-
-		retval =3D cb(dev, userdata);
-		if (retval)
-			break;
 	}
+	return ret;
 }
=20
 /**
--=20
2.43.0


