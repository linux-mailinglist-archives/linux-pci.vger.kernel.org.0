Return-Path: <linux-pci+bounces-15069-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 039929AB99B
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 00:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88491B222AB
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 22:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03BE1CDFA4;
	Tue, 22 Oct 2024 22:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="eTFP0kd4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA731CDA24
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 22:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729637351; cv=none; b=J9oGUu+/jQQ/pLzc+w+DOqUcNZnBuJvsJ8vQdPLGtc+haPwRIc8PxTjvMHoyN4B5BrHDaGlu7pSU4sq6MwPW6HckXMnHtzIoZEb5ye+AZJWSNsUN79wKeU9GQwuFTg2kUpakf/chcR5yeU+n/1QyEWOBn4jGwJFXykAUSqQgf5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729637351; c=relaxed/simple;
	bh=rgeVw793e2iRFZ8msLe+UDwAExH7L41enKwaLiEzpFA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o5F2K84kXveOeK2C7b+yM2Y1JPkQBg218wRSYY+wQpWS8C7G9tvGk+IhroeqJSwueLR3XfN81XnmeAiudZg8Zi5VlQhJ6Ry2tMuj1Hrb1SnB6+EJhDCalaI4C5olDitEHE1oWn50Fv7iEmw0M4mG+DpFs+QBOIk87mx8pJfeTMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=eTFP0kd4; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MLYUai013198
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 15:49:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=cRndAYK402/XjUPXTH7hpV73wtq9J/dnq5zNXuazwO0=; b=eTFP0kd4FydN
	xKKWUh1bfj6bP9p5buMOYa6vKvJ/WBkAJYhsqGR8mKumjCoGXevQv9KaKvxKpjwo
	Ak1CIU7SFBG2UqrVztzem8nPvQ/YaFXEqSkgNnvqXUteXCTIoo3BJkWeFcjq2ci+
	gVbTRQRx+3JtJ4Wh2qISPlJyBLrdpjbbM2TndoQsDZJNbiNv3dImtUejzQqbF9yf
	A3TymsgOmVvROJ9l1BAJvZOPRXndeJUMFe7FilirFGXfQviz0OCAhR63Gbpj8WzO
	SUZhy/oop1APfkDgcc1QN8VeU095j+tfJXtwzuTSuVhWeVQ3FEaST8+1RUY7QY2P
	pjTFtEVD1A==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42em38ge1u-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 15:49:09 -0700 (PDT)
Received: from twshared4872.05.ash9.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 22 Oct 2024 22:49:08 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 943B814610C9A; Tue, 22 Oct 2024 15:48:53 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>
CC: <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>,
        Jonathan Cameron
	<Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCHv3 3/5] pci: move the walk bus lock to where its needed
Date: Tue, 22 Oct 2024 15:48:49 -0700
Message-ID: <20241022224851.340648-4-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241022224851.340648-1-kbusch@meta.com>
References: <20241022224851.340648-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Proofpoint-GUID: STtuJrBsLNhIDri_v78kSMdzxYGM5oP6
X-Proofpoint-ORIG-GUID: STtuJrBsLNhIDri_v78kSMdzxYGM5oP6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

From: Keith Busch <kbusch@kernel.org>

Simplify the common function by removing an unnecessary parameter that
can be more easily handled in the only caller that wants it.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/bus.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index aec08e81abff7..b863b8bdd6ee6 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -400,7 +400,7 @@ void pci_bus_add_devices(const struct pci_bus *bus)
 EXPORT_SYMBOL(pci_bus_add_devices);
=20
 static void __pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev=
 *, void *),
-			   void *userdata, bool locked)
+			   void *userdata)
 {
 	struct pci_dev *dev;
 	struct pci_bus *bus;
@@ -408,8 +408,6 @@ static void __pci_walk_bus(struct pci_bus *top, int (=
*cb)(struct pci_dev *, void
 	int retval;
=20
 	bus =3D top;
-	if (!locked)
-		down_read(&pci_bus_sem);
 	next =3D top->devices.next;
 	for (;;) {
 		if (next =3D=3D &bus->devices) {
@@ -432,8 +430,6 @@ static void __pci_walk_bus(struct pci_bus *top, int (=
*cb)(struct pci_dev *, void
 		if (retval)
 			break;
 	}
-	if (!locked)
-		up_read(&pci_bus_sem);
 }
=20
 /**
@@ -451,7 +447,9 @@ static void __pci_walk_bus(struct pci_bus *top, int (=
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
@@ -459,7 +457,7 @@ void pci_walk_bus_locked(struct pci_bus *top, int (*c=
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


