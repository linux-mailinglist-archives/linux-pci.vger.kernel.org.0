Return-Path: <linux-pci+bounces-12314-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27324961802
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 21:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A4581C235E3
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 19:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBE41CFEDC;
	Tue, 27 Aug 2024 19:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="aaGYMfky"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5AB1D2F57
	for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 19:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724786939; cv=none; b=meKHgDlE5u6KbpVjfkS3oxPKWGo5rTAhSqi5dtcUvh3RXL2uM0H49E2qr2L5n6nWV1AIVkv5IQlg503FVWEFEenc1KRiTgqwNEX8ch4ZJfkKDwCKQLf+/Drymy377sxOqN7rR9e1LYkPR1uxATm8b+/9YNpasJEk8AWX1t0YxvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724786939; c=relaxed/simple;
	bh=JDfE9CIsszTUANv/Le/pSmFyHBszZN8y5lRLIf6i61k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aG0dPnSfh8PoZsAK7zaoWnQprpW+0hkxjuklT4fUFIFiLVUU7gIxT9U95CM4YZ0n2U4LnP0Pehkbu9CpKrvQsYGg2MGfsZVWRtb7Ehm7XK2wbXUn0hoBQaT5F6ra+kbWgTMNZb0sefuMntxX0mEfXe3xWceEVto01BBztHCd4iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=aaGYMfky; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RDnVV2017853
	for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 12:28:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=pcChgNId+NSWU9SFBhOkY9Q04FHA7eNvEe/eAp23sCQ=; b=
	aaGYMfkyLkgo7MvoXwCyeu+5QU5XumVJCqv72Z8GjEt5mNJH9tpVvZ5rX7PrwwvI
	+RHOamohYhBCbcKsjqVoOwV6uznnZ8PJx6LFPJZ3ud49RHRKb3zYoDhmc+fwsTBL
	2Qxeit5nz6RewmPh69O56JcdPxrnUXxxpYokWMSlr9LGg9/Dlx9BAra67PiI3fUH
	MOe5ZwgGko8itYMPNmagDSEvHFVLAAwya7C+KukVH04NAVkfNlqcD2guvT6QJN6o
	EWLQJ4Vm3HqKmff0zIv/Z2bESA4Ehi0fWLXimXJVj9Aj87/NOdtgpnABjKWWPBNe
	okzOy0e8lOpENsoiGQuZGg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4193s562hh-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 12:28:57 -0700 (PDT)
Received: from twshared16760.32.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 27 Aug 2024 19:28:32 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 7DB68124FD703; Tue, 27 Aug 2024 12:28:27 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>
CC: Keith Busch <kbusch@kernel.org>,
        Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCHv2 4/5] pci: walk bus recursively
Date: Tue, 27 Aug 2024 12:28:25 -0700
Message-ID: <20240827192826.710031-5-kbusch@meta.com>
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
X-Proofpoint-GUID: ksnOr2nSpYOCeh8P_hfqQfpIyZ8DYBDO
X-Proofpoint-ORIG-GUID: ksnOr2nSpYOCeh8P_hfqQfpIyZ8DYBDO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_10,2024-08-27_01,2024-05-17_01

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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/bus.c | 36 +++++++++++-------------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 7c07a141e8772..8491e9c7f0586 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -389,37 +389,23 @@ void pci_bus_add_devices(const struct pci_bus *bus)
 }
 EXPORT_SYMBOL(pci_bus_add_devices);
=20
-static void __pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev=
 *, void *),
-			   void *userdata)
+static int __pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev =
*, void *),
+			  void *userdata)
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
2.43.5


