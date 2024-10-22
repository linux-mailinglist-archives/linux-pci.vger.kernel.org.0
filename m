Return-Path: <linux-pci+bounces-15071-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8949AB99E
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 00:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F22D284799
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 22:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7141CEAC8;
	Tue, 22 Oct 2024 22:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="fxNzG7oZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28461CDFD9
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 22:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729637355; cv=none; b=WD29xii+PmzmPmVBi2AkB3O8w6axjY7cA/MZPVLQBmecDgLQP5jBEiyaplsOF6n313416h0C3YTByCDRfyF/mdxwGcxVsoF5EiP18GzFk6jA736RSh8zXZYCg5+hMXWSNVRFgLC3pfMHuWeH5X8TtItsTUi6KcLsEzKcEg4gGVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729637355; c=relaxed/simple;
	bh=aLZQPUQb09q56DLxFDOZeH+/4+VV7u/2RuEYaZhTCjg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gcavJBe5nSG5nYgFzm3RH6C8zqUndX7v6SHCDZZu+Cw9TrDZnC221aBiJ8EeulWEG5fJBu15IkbbTZY+mMZB9D4fR+WBXgQImXvZIb1CKLySORW7kHyPTxRn+xnBxpRKYBKHxT07m1a8lmtnvXp0zr4jaFzfw7KaSb9nDgCW1Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=fxNzG7oZ; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MLZgaS000394
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 15:49:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=4aFkJROKKdtf7LdW6qIzOXM5lLno41es/F0fnRTRHE4=; b=fxNzG7oZRPTz
	gQAAKXYFPcMsSh7SxkOLXmpDGKxNC2+BIWq5ggE99hI0YktiefcLwcpHzCh4hZ+l
	V1nD7JaF9XtZOjsuVXzW+jZnxAaYQMgxhNEo4eN4rzmjFFDfLuu4UKsA4q1R9jjg
	gw8qe9wi0yD8Z4d5t7fDnc0Uwb09FjdvK/oqgAls7n4btYo8bk06vNZ7lUFX+72H
	N026OqoJbZNEo8Z5o2sSCYICoqm+Y1UnITnJyBkaqRRHtiRylcKCsxQ6JztBajgy
	WYnc8XukdoTewX+kuZcbFlpanTlvf30cag72lE38vYTX9btfhzmsSA7TZKiq42oP
	MLX9LLpUMA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42em3h0dsm-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 15:49:12 -0700 (PDT)
Received: from twshared4872.05.ash9.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 22 Oct 2024 22:49:08 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id A473414610C9C; Tue, 22 Oct 2024 15:48:53 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>
CC: <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>,
        Jonathan Cameron
	<Jonathan.Cameron@huawei.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
Subject: [PATCHv3 4/5] pci: walk bus recursively
Date: Tue, 22 Oct 2024 15:48:50 -0700
Message-ID: <20241022224851.340648-5-kbusch@meta.com>
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
X-Proofpoint-GUID: mftasU6mblYLGDYhSmGYxKVfbdDB7_lt
X-Proofpoint-ORIG-GUID: mftasU6mblYLGDYhSmGYxKVfbdDB7_lt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01

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
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/bus.c | 36 +++++++++++-------------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index b863b8bdd6ee6..9c552396241e0 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -399,37 +399,23 @@ void pci_bus_add_devices(const struct pci_bus *bus)
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


