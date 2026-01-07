Return-Path: <linux-pci+bounces-44220-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 089F5CFF77D
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 19:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9DFA300F187
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 18:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C533451CA;
	Wed,  7 Jan 2026 18:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B1eYX+q4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01F433D6E1;
	Wed,  7 Jan 2026 18:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767810758; cv=none; b=BiRS4/tBvpXIP8nVvEYT5nyhK7gPlYbSl0cmncyAu5NaXfjq7nqPaI3KyDRyhPlvPyAmewzUlWLgGHo1K/xPKSn3P3LijADLDjhESInE5PjBtlBzeuuwOU17pBIXL4RBJtDpLRXu7y9MCZhSLzQqj70pRiDIzVJwInesj8qkrRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767810758; c=relaxed/simple;
	bh=CdCmYfd0NQs2JTPzGnygnNoXeza7LEg13ac8BKIWOl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jdfR37+vrLRQqz9FY1XUjGItkGGQCo6BhTfv68UUZCmQO5yE1BmYtcqV8apLQxOP7L5Nlcm9JtUDiZwAJW+uWAEwg7c9ZYqE/PHReIXpttHbkUCqryICFlxpy2Lun/7s6YLKvgh9sTVk5Pteh1GAUjb3BtFNhhP2eBN5wvgShvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B1eYX+q4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6079P9ml028326;
	Wed, 7 Jan 2026 18:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5I7CWEe9ui4i+dWTe
	sHgvz4htRGY5EMHCPX0EJJWj0k=; b=B1eYX+q4/7IE+PMjh5RtBAidTLaWmF26z
	KccxEbUdffpO+wOX/ujVdxi2IB1qXPAc8hF4AX28zH8vCK7S+VFIpOMyXmUNx9hJ
	b0BDH7qrJ5zbBRGIrwlxo7KsBbrEcbyI0S6lvRrvtjzsteJmr/yekE2CVabh+S+w
	wBbpgLkdjN3lltlgUuvjxMWm7+JhLyP5YYgjCiC4WZm2fAf0hnXCQBC3kFXYCJuu
	tyRZUzKIhNolpVfox6BX6Ymfkgne1BqeE6jsH49Rou13jk+tgpD6l5Wy+158lti1
	GrYqhz2Q3c5zZdM1p97Rt1o0p9Gns96G1qifLb5FCS/WSRqfvh38Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrtsd2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 18:32:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 607I2RP0012590;
	Wed, 7 Jan 2026 18:32:24 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bffnjjhy7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 18:32:24 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 607IWNuO29098694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Jan 2026 18:32:23 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67EC25804B;
	Wed,  7 Jan 2026 18:32:23 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45EFF5805B;
	Wed,  7 Jan 2026 18:32:22 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.241.168])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Jan 2026 18:32:22 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, alifm@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com
Subject: [PATCH v7 3/9] PCI: Avoid saving config space state if inaccessible
Date: Wed,  7 Jan 2026 10:32:11 -0800
Message-ID: <20260107183217.1365-4-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107183217.1365-1-alifm@linux.ibm.com>
References: <20260107183217.1365-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=aaJsXBot c=1 sm=1 tr=0 ts=695ea6b9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=xdIN8Vsn6p_WiBCsET8A:9
X-Proofpoint-GUID: Ryxu08BogNnwKvoVUNPhQ-WgmvPatoPk
X-Proofpoint-ORIG-GUID: Ryxu08BogNnwKvoVUNPhQ-WgmvPatoPk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDE0NSBTYWx0ZWRfX/fff41IEVwBz
 kUDTjdHtKGtxKoVClrD/LUyDi52d04HoHwvgT4iCt6oNsZWDV1J3xvrutzT+Ra7gOlm0keNi9w9
 TCZyrAMXGqWrv0gbxCEnYthFHnFEI2WSOPiheLupE2meWmmBpbMSu3sKeJ0Fy0eqZZoTf9V7aFk
 YmF9PyulPz1Z0hi83ify9oczzSb1mo3CABIX+pWMMzhoF1WCKxttYc45JOmiFqXlrJUpoNU6U7q
 9aZrAVxjQsjWqrrF1Hj/EVNWYOpkiI20Ws0wnIq66Hnx6i6ZInjORHYP3J+GFTfKIMxpM2jTKdR
 oD5tgXb62M6KKAHcB5oXFaWAoa3dQ5FWbf5QuiN3AilLhYUzBzMzqFWHktOWfH9cYDa/z4uvqnu
 Vt5ho9J1UJK/cPLmVNbbNXnkGfAn2oVIgxDXgS4VYMid60FsA01ioGlg9rZljPGbQru6AVUhIML
 RPp8R6gVmpbG+Mz8h/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601070145

The current reset process saves the device's config space state before reset
and restores it afterward. However errors may occur unexpectedly and it may
then be impossible to save config space because the device may be inaccessible
(e.g. DPC) or config space may be corrupted. This results in saving corrupted
values that get written back to the device during state restoration.

With a reset we want to recover/restore the device into a functional
state. So avoid saving the state of the config space when the device config
space is inaccessible.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/pci/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c105e285cff8..74d21c97654d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4960,6 +4960,7 @@ EXPORT_SYMBOL_GPL(pci_dev_unlock);
 
 static void pci_dev_save_and_disable(struct pci_dev *dev)
 {
+	u32 val;
 	const struct pci_error_handlers *err_handler =
 			dev->driver ? dev->driver->err_handler : NULL;
 
@@ -4980,6 +4981,12 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
 	 */
 	pci_set_power_state(dev, PCI_D0);
 
+	pci_read_config_dword(dev, PCI_COMMAND, &val);
+	if (PCI_POSSIBLE_ERROR(val)) {
+		pci_warn(dev, "Device config space inaccessible\n");
+		return;
+	}
+
 	pci_save_state(dev);
 	/*
 	 * Disable the device by clearing the Command register, except for
-- 
2.43.0


