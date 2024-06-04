Return-Path: <linux-pci+bounces-8235-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1863B8FB407
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 15:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABCF31F22043
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 13:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9D01482F5;
	Tue,  4 Jun 2024 13:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fs2vc81L"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFF8146D6E;
	Tue,  4 Jun 2024 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717508343; cv=none; b=gEB+riawlYxeYDjq44v5fvHciYkUFuRykDnTc4bmP9IM+J1ujlTX2CtkJFODS+DM/zsbZt65khTU+iN9r7TxLOPv3PSmgp7eSCCGvYMXpPK+7PtKpMjuxcj3YG8QugBoNj8gEhKkOejp+d1gtfkH2prPpPtKgwc4g9h4SwZ23rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717508343; c=relaxed/simple;
	bh=O+deWQNt5OanYzNos3NVHzpWd15SU72v0FwzQLeeXhQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lC7rBcd9Rfs3PFeovWhXQKb2nDF7ULH3qxvjkqFFg4Vgv2AyTiShvI66bx9vjGXhcRloRzTCcnqZq3g16xXjQMMWbFs6Vu/tV1KX6zvxSfA9juOUvUfKov+T251NicMpZwBQuMT1NzYpjCOe90ZRomnwfBEG0Xypc+aKs1iE8BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fs2vc81L; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454Cutm2013955;
	Tue, 4 Jun 2024 13:38:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=pp1;
 bh=QPSi69NKkDl86Z+DG7MVLpzqXo+cHpFb4T+eUjHO5Lw=;
 b=fs2vc81LNN1x5QMsRWFDQr6LPDLUIa8fomWBAwTpow+hZzRWzxMMtT9K8uyfHN1PT0LD
 e/9Oj/klzlph6LP2WpG5bAms7037wKSk+mvH0RGCoIi2yTHh1MConH2MOJa8vxLHhBf5
 0KC1ONiiM4aG+vCkItHrAUz/7YLO5USpZ31RRiSx5igZofb7lN9fqarC0h+UWZ3CI0h0
 ovDXz9KpFgGNcC5wPCaq9Tsgr/zq1VhKWJt+4GC6Rp3RaWQXpVNRD7AajaVz+E7Eo6wM
 d0Bnx70o4t2ZC7YQlHVZajL/WSKIvCWKo2CKI3d6ZoWl6OCY9LEOQeviRXOiJr8i1MKs Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yj2x9g81j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 13:38:57 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 454DcvZg013875;
	Tue, 4 Jun 2024 13:38:57 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yj2x9g81g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 13:38:57 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 454Cg95i008517;
	Tue, 4 Jun 2024 13:38:56 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ygec0pf6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 13:38:56 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 454DcreF27788000
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Jun 2024 13:38:55 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3D5958054;
	Tue,  4 Jun 2024 13:38:53 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E46358050;
	Tue,  4 Jun 2024 13:38:52 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Jun 2024 13:38:52 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Tue, 04 Jun 2024 15:38:39 +0200
Subject: [PATCH] PCI: Add missing lockdep assertion in
 pci_cfg_access_trylock()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240604-pci_cfg_lockdep-v1-1-00da1706c9fd@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAN4YX2YC/x3MQQqAIBBA0avErBNsEKOuEiGlUw1FikIE4t2Tl
 m/xf4ZEkSnB2GSI9HBif1d0bQP2WO6dBLtqQIlKaqlEsGzstpvL29NREKseOkUaXY8aahUibfz
 +x2ku5QOsVV36YQAAAA==
To: Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1128;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=O+deWQNt5OanYzNos3NVHzpWd15SU72v0FwzQLeeXhQ=;
 b=owGbwMvMwCH2Wz534YHOJ2GMp9WSGNLiJZ6lPt98Y4W/68uv8/vXbdyyujR2FZOM8L09Z3O+P
 Jwio7tIvaOUhUGMg0FWTJFlUZez37qCKaZ7gvo7YOawMoEMYeDiFICJ/GVm+GfCuKWy7HnktKuf
 s+YsLXRcviXy1ZcFZhP/+S+UW6o57dMWRoY/x728lyVJrku70ptxusIzfNHhpH/GXXY1h2MYGla
 938sAAA==
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EuWyve0ZBFGSziGMKYKH3OoHm_EqeriT
X-Proofpoint-ORIG-GUID: TkuItEXU7KJSJI0OxFDg8G5dTJXOPHt_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_05,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 clxscore=1011 mlxscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406040109

In commit 7e89efc6e9e4 ("PCI: Lock upstream bridge for
pci_reset_function()") it was missed that pci_cfg_access_trylock() needs
the same lockdep assertion as pci_cfg_access_lock(). This leads to false
positive lockdep splats for users of pci_cfg_access_trylock(). Add the
missing assertion when the lock was successfully acquired.

Fixes: 7e89efc6e9e4 ("PCI: Lock upstream bridge for pci_reset_function()")
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/pci/access.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 30f031de9cfe..5b6620da30d7 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -319,6 +319,8 @@ bool pci_cfg_access_trylock(struct pci_dev *dev)
 		dev->block_cfg_access = 1;
 	raw_spin_unlock_irqrestore(&pci_lock, flags);
 
+	if (locked)
+		lock_map_acquire(&dev->cfg_access_lock);
 	return locked;
 }
 EXPORT_SYMBOL_GPL(pci_cfg_access_trylock);

---
base-commit: c3f38fa61af77b49866b006939479069cd451173
change-id: 20240604-pci_cfg_lockdep-b6914e62d726

Best regards,
-- 
Niklas Schnelle


