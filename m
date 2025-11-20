Return-Path: <linux-pci+bounces-41831-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D929C7631C
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 21:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E23B34E1160
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 20:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB67D272E6D;
	Thu, 20 Nov 2025 20:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Mt0HhuqZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A10841C63
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 20:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763670336; cv=none; b=Puy0bax2bDlhyXEqOc3TH7rgBpeWFhYvmbpNii2nF2rkwnOpRDJAgbEQqBvI68LOVVPptTefqYObZF1DkT9AyVPBa+8M8UGD2PbDiFNWCPePEbbA99vY1IJ302kkDjLN09GUb89t+jFeAx2WIKbZq6pGn6D89QpHY39yQaGLxrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763670336; c=relaxed/simple;
	bh=y7BsSt2GBr5Yvs6UdfYBOa/roX18fBmHaKKQS1jD1Yc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DyTG94wdftm1LA97+HCMDUQfJRz9lqK6SrhxRhdr/xYFU9BlfBRMVekWRRitgl1peXwR0Tk7gAVPy9oYDgkIMREcSom9BGNKlURB70G1FEj/fkeMB63M+ZGlhXPuNFK0079IHcD5w/cor137tqliJfxGRn1ftN52Nr9r5VpuXwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Mt0HhuqZ; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 5AKJgpib1644792
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 12:25:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=VMmYJW/buQWEddcd/C
	E+n7htO9ONJBqU5rkzrqbawLY=; b=Mt0HhuqZ3SjXhscW8zNHWH1vjaj3mJze1t
	UbglACKlPjqT6BTWbqvgbihpnu88J7ndSzXm5qYYUZGrCwoXb8cc451+3hJw0L5+
	py6NodwEBTcfbpHfiWOkz4YrLTQYdHEdIC2o7n8VGPYs8TazVelM+HaqZjwwHs8V
	kFgYzWTovcuRcjx4ybex/61QrIqJ7LfjUOUuGfbhezpi/XLuKhGK70ghekdSZdiZ
	rSE0fefkFypfVqb0QN9+RyPLg+/X4s4hEox6bTmPM9NZegSD7BXatjUct/AY0WzL
	aU59eQmTE0iEqT01/lRixoDSZ1KYIB1CcG/rxRdaULN4uboP3QUg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4aj9cx0es6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 12:25:33 -0800 (PST)
Received: from twshared125961.16.frc2.facebook.com (2620:10d:c085:208::7cb7)
 by mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 20 Nov 2025 20:25:32 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 44BE73FC745D; Thu, 20 Nov 2025 12:25:31 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: Keith Busch <kbusch@kernel.org>, Nikita Vetoshkin <nekto0n@meta.com>
Subject: [PATCH] pci: update reset methods for first device
Date: Thu, 20 Nov 2025 12:25:29 -0800
Message-ID: <20251120202530.3252938-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: nQYBeam7INFyD2Q_pSxJf73fvAhxswEe
X-Authority-Analysis: v=2.4 cv=TuHrRTXh c=1 sm=1 tr=0 ts=691f793d cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=lskHplyjSRLzAj1JeKcA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDE0MiBTYWx0ZWRfX0GrwIMUI2r9c
 M/zys0AC3aIUlh7pHWnV+6+F+zUM6/kqwAByBp4hQFz5/RneXoFP7Q+RHcpA0+1mvB+MGkjgiEP
 Msvx2Fl8L2603QHzw5aSpk4vPE/i7LK2fNYeRLRqO2ukyAjN2qkQVWRUM06LJCWhBMBn57QaP/c
 ULkleRZzF8qNueYMOtOdzfks9SwB3v9OaF2OgGt6yoIDI6gZXQqG+R8dc/mpS0DMaVyAH6FWqSm
 UEQQzaxoxraNkw+ZYHk2v8+n1LXZ0UZdXixSwHsfnbxDnJNqL47r+UZeSwO6s/Sbba0WXyQt22e
 3nBdfW33uUMLAgQUWFSfTfx5zHEHjD/RWOfrv5yXOy9wcsCuMUHrJE83kKpFNViO/Jgh6kJAJWE
 MaaKUhksFQT2b5pF6uMzotO/MQJOsg==
X-Proofpoint-GUID: nQYBeam7INFyD2Q_pSxJf73fvAhxswEe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_08,2025-11-20_01,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

The pci enumeration initializes the sysfs attributes as it scans
devices. The first device on a bus will successfully probe the "bus"
reset method, but if a second device is enumerated on that bus, that
reset method is invalid. Make sure to refresh the attribute values after
adding a second device to the bus's list.

Reported-by: Nikita Vetoshkin <nekto0n@meta.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/probe.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index f41128f91ca76..2f461c37a87b3 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2687,6 +2687,7 @@ static void pci_set_msi_domain(struct pci_dev *dev)
=20
 void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 {
+	struct pci_dev *sibling __free(pci_dev_put) =3D NULL;
 	int ret;
=20
 	pci_configure_device(dev);
@@ -2718,9 +2719,22 @@ void pci_device_add(struct pci_dev *dev, struct pc=
i_bus *bus)
 	 * and the bus list for fixup functions, etc.
 	 */
 	down_write(&pci_bus_sem);
+	if (list_is_singular(&bus->devices))
+		sibling =3D pci_dev_get(list_first_entry(&bus->devices,
+					     struct pci_dev, bus_list));
 	list_add_tail(&dev->bus_list, &bus->devices);
 	up_write(&pci_bus_sem);
=20
+	/*
+	 * The kernel doesn't allow the "bus" reset method for a device on a
+	 * bus with multiple functions, but the first device on the bus may
+	 * initialize with that since we haven't discovered other functions
+	 * yet. Re-initialize the methods if it was previously the only bus
+	 * device.
+	 */
+	if (sibling)
+		pci_init_reset_methods(sibling);
+
 	ret =3D pcibios_device_add(dev);
 	WARN_ON(ret < 0);
=20
--=20
2.47.3


