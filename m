Return-Path: <linux-pci+bounces-16465-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 645D09C4483
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 19:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 168111F21262
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 18:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEB41AA1C4;
	Mon, 11 Nov 2024 18:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="gFtGfheu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C24450EE
	for <linux-pci@vger.kernel.org>; Mon, 11 Nov 2024 18:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731348448; cv=none; b=oOCJ4HzoBlJcPVRAhcX4snabYQvrm7AQMwTbe1MDpUJQEQz/W2aW5DbsfaQMu6KsQXjHYru2/Fj3cIXh70R3/fefo9SAtnouFk9md/jFETSl1shBmB3DBSsp+yBHQdK4ivlM/ePfPVUjICcxm+PMabp+aNHYmP+6kC5HJzO/n2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731348448; c=relaxed/simple;
	bh=CHXnW63tws+Yx37RARb8JkIwmy12TFoiDXykAP11ruc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g6aYMGxeL/XOWxlINygIapXcjd1YiZX3T2fWPu8O1CwaChmHp5jehg2AvMA86SKHioJOQAPmGpB8qLH4TmNBlHuJDzd2zFRJzHPSEFA1BRB6nNvMNU5Nc0c4g0AR/XtkEmaYQ1+Y0W6R+veddaH7CpHQwo+tAZFYJuq/DX2euSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=gFtGfheu; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABH6qgW027452
	for <linux-pci@vger.kernel.org>; Mon, 11 Nov 2024 10:07:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=g0noDQeFZhrCGq5GFm
	3bK63PtumRcvz04MlUlza7x+o=; b=gFtGfheuytV//m94RpTIFZ7eANNZvMqJds
	iXLeDCVEGPBaw1Z9gpxAGntApMjhPO3Uv1nBrckvvuDs22l4Un5yHsuX2FJfvhlO
	3RSt4eNKShuo6usXoHzXQTQUYf2gBffWddgHLOkOCCXievO2mxyOuabQesB2HDf8
	weiI2R/Taasu35C5WagSGW8AISnMMeOUy+KBA9VNCFexb+urDgkIupQPL47nWWYV
	Pmtx3oywX9DvNB+Tq9FMS6Ja8+kaK9t8cuDJdV0aJukVHmF6vnw8CuLyY33iOaiz
	KYDJk8loRI9s/A946VELuhN9DWSK4ZvoPIUcZSFP2GD8QFmZDqww==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42unf30sag-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 11 Nov 2024 10:07:25 -0800 (PST)
Received: from twshared10900.35.frc1.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Mon, 11 Nov 2024 18:07:23 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 551B714FA0AC5; Mon, 11 Nov 2024 10:07:07 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>
CC: <bhelgaas@google.com>, <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH] pci: always clear pme on stop
Date: Mon, 11 Nov 2024 10:06:59 -0800
Message-ID: <20241111180659.3321671-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: LjqPiFy6I5xvOo8JSHRRYrYdJEW38QdN
X-Proofpoint-GUID: LjqPiFy6I5xvOo8JSHRRYrYdJEW38QdN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

From: Keith Busch <kbusch@kernel.org>

This used to be called unconditionally, but was inadvertently changed to
call it only once. Restore the previously existing behavior.

Fixes: 6d6d962a8dc2 ("pci: make pci_stop_dev concurrent safe")
Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/remove.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 2e940101ce1bf..36467558c0144 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -31,10 +31,10 @@ static int pci_pwrctl_unregister(struct device *dev, =
void *data)
=20
 static void pci_stop_dev(struct pci_dev *dev)
 {
+	pci_pme_active(dev, false);
+
 	if (!pci_dev_test_and_clear_added(dev))
 		return;
-
-	pci_pme_active(dev, false);
 	device_for_each_child(dev->dev.parent, dev_of_node(&dev->dev),
 			      pci_pwrctl_unregister);
 	device_release_driver(&dev->dev);
--=20
2.43.5


