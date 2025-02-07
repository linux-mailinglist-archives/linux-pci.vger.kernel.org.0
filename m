Return-Path: <linux-pci+bounces-20956-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 728A5A2CE64
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 21:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C45D3AB247
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 20:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52661B4F15;
	Fri,  7 Feb 2025 20:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="cFou6mXp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BF91ACEB7
	for <linux-pci@vger.kernel.org>; Fri,  7 Feb 2025 20:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738961004; cv=none; b=W0xNZUK1wVNpq+dv6TDWc/cdVC6whtTI/+46LeecKzRsLh47zn9dUbTu45Zz4sO6JCf+2hJn50lmBPwfac0SKNLr1PqwGzhhjTXbvLG9JhL12DaHF3mVE2zzPqm86LW6I5o2VgwzIAOPU1nT8i+3GPnk9J+fsKOShK+8WEym/aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738961004; c=relaxed/simple;
	bh=z0+n2F/GnBBk1WcmrYwhGwA6iB4IgjYuLUG2XO5N1uo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nSXhAf6DrBJfRmaTwbdLol3gbAy6SeeYeuJMgWawjX1MjHsUwDmo9COR5Sn5VhBDvfAnbZlk9unO3wR9uN6fKMMc97E8bYUecP56sVA/kaDPlObVIOpDZ3kW0xrn+/qWHZZNd7+MBUq2GnR0ktK8kw5dv3XOApFa4ECTibV6/gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=cFou6mXp; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517IbIhi007391
	for <linux-pci@vger.kernel.org>; Fri, 7 Feb 2025 12:43:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=cfctgHpA6cVD+Z+IaQ
	3W7mih4GF2EBtWvFPBHeZSd1c=; b=cFou6mXpMXeSq1rwFU4Bqe9rh43SaZUNSD
	iLByeLg9HJ/Qp89wITA8IEledc3cmBz+/kEx1DQiS64lRvaG5EKtnabbuQwZU0m0
	i/hSqNL4lRHqadXKTsv7nnHUqI+vu2CO6LoadKokc2vVTJ0S9KzF0yRUosbfEDNQ
	pmoaPa4UW3/CHPZAYngi6mwUrE7jzY8K2NjOVCZxTDTIfE1o87zY4wsADIxjU6JE
	lN/TFkpGxidrxss0pua5BcGYPBW9UrSxU2EzojqjrO4T/oZf4S8o8Mb24MakUhhL
	35+eI5LyPP/eFNIMU7BrkFNoFLtaNEpC3xM4nIilikIdPpeg0YzQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 44nqkwrxy0-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 07 Feb 2025 12:43:21 -0800 (PST)
Received: from twshared3815.08.ash9.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Fri, 7 Feb 2025 20:43:20 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id AAF6F17C4C446; Fri,  7 Feb 2025 12:43:13 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] pci: allow user specifiy a reset wait timeout
Date: Fri, 7 Feb 2025 12:43:10 -0800
Message-ID: <20250207204310.2546091-1-kbusch@meta.com>
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
X-Proofpoint-ORIG-GUID: hGmHq8Muergd_NgxFjzvGMjYFSKv-pkV
X-Proofpoint-GUID: hGmHq8Muergd_NgxFjzvGMjYFSKv-pkV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_09,2025-02-07_03,2024-11-22_01

From: Keith Busch <kbusch@kernel.org>

The spec does not provide any upper limit to how long a device may
return Request Retry Status. It just says "Some devices require a
lengthy self-initialization sequence to complete". The kernel
arbitrarily chose 60 seconds since that really ought to be enough. But
there are devices where this turns out not to be enough.

Since any timeout choice would be arbitrary, and 60 seconds is generally
more than enough for the majority of hardware, let's make this a
parameter so an admin can adjust it specifically to their needs if the
default timeout isn't appropriate.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 +++
 drivers/pci/pci.c                               | 6 +++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
index fb8752b42ec85..1aed555ef8b40 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4843,6 +4843,9 @@
=20
 				Note: this may remove isolation between devices
 				and may put more devices in an IOMMU group.
+		reset_wait=3Dnn	The number of milliseconds to wait after a
+				reset while seeing Request Retry Status.
+				Default is 60000 (1 minute).
 		force_floating	[S390] Force usage of floating interrupts.
 		nomio		[S390] Do not use MIO instructions.
 		norid		[S390] ignore the RID field and force use of
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 869d204a70a37..20817dd5ebba7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -75,7 +75,8 @@ struct pci_pme_device {
  * limit, but 60 sec ought to be enough for any device to become
  * responsive.
  */
-#define PCIE_RESET_READY_POLL_MS 60000 /* msec */
+#define PCIE_RESET_READY_POLL_MS pci_reset_ready_wait
+unsigned long pci_reset_ready_wait =3D 60000; /* msec */
=20
 static void pci_dev_d3_sleep(struct pci_dev *dev)
 {
@@ -6841,6 +6842,9 @@ static int __init pci_setup(char *str)
 				disable_acs_redir_param =3D str + 18;
 			} else if (!strncmp(str, "config_acs=3D", 11)) {
 				config_acs_param =3D str + 11;
+			} else if (!strncmp(str, "reset_wait=3D", 11)) {
+				pci_reset_ready_wait =3D
+					simple_strtoul(str + 11, &str, 0);
 			} else {
 				pr_err("PCI: Unknown option `%s'\n", str);
 			}
--=20
2.43.5


