Return-Path: <linux-pci+bounces-33171-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7825B15F39
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 13:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7275189EDDC
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 11:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C52625761;
	Wed, 30 Jul 2025 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YeINPCD5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0361F293C6C;
	Wed, 30 Jul 2025 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753874487; cv=none; b=o+oehWilKb+a12Jh/A3XQs/zJyg42zwksKo2WF0cywjPFJFNPO/rpuT0X/uqIy27rCNSNfBXr2YorYo8HoVEoXByTPyViyRocSfEYJw5fbiTtU0hR7ZCvspWTL6uY7K44UNKQQaQaKOjYcWhq8Pga0sey+3kpUrXlHM2AlFagcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753874487; c=relaxed/simple;
	bh=lFOsaGCqPFeMuSYl12T0qvZETcU/iSpEinVY4COc/Iw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SpIvyrDpzzifWEkc9Xa9SNRZfKgmZiIuanwrBNxGQAXIJfsIukFFMlhqrd29qGGEpeYCROQInU7yvW1DILeVoxMw2JKbTFu2QFOxBF5xwapHK+vID5KmwYBW7xot94t49QE7mny7G25q3sPsOTRoWKrZujNYbs0uVBJX1isAztM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YeINPCD5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56U1vf7v017098;
	Wed, 30 Jul 2025 11:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5obXgh
	oBDb03rk0VDSAZ7lFDc9v2p/DdlGM67CP3lvw=; b=YeINPCD5Zn7mxdOAOZz4X3
	sOWifwBVDfptouS6zG/lGjDm5xLelNZqh4y9K/Tn0RWntrLpAqERT1Smu96XsXm6
	dk+aR739qUAOajVEIawcQS23fSzKxrHisVha9fMbRPjVGPIvuZYDErjMr/3jEyuJ
	bx2yTdyXPACSNryIZGQe6RtyGV8EkOXMm/g0mj3HRlY0/51sMWiPbQ/XbCQt6gzT
	qTvme6SPrPXhnx8QQKL+Rfa9Cj1eafCdToWtmI8itdU2721wP7VWtE4/TIYMLT3K
	/rnmaUwYfWQXCZTdn/w08TNUdN9tLavitHldKx10oEc4KnGgRX8uWR4FoCGc946Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4864k7vt1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 11:21:17 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56UBJHiF000365;
	Wed, 30 Jul 2025 11:21:16 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4864k7vt1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 11:21:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56U6tlaO006252;
	Wed, 30 Jul 2025 11:21:15 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 485bjm6xuy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 11:21:15 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56UBL6dM6357748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 11:21:06 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9412D58051;
	Wed, 30 Jul 2025 11:21:13 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBA815805C;
	Wed, 30 Jul 2025 11:21:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Jul 2025 11:21:10 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Wed, 30 Jul 2025 13:20:57 +0200
Subject: [PATCH v3 1/2] PCI/AER: Fix missing uevent on recovery when a
 reset is requested
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-add_err_uevents-v3-1-540b158c070f@linux.ibm.com>
References: <20250730-add_err_uevents-v3-0-540b158c070f@linux.ibm.com>
In-Reply-To: <20250730-add_err_uevents-v3-0-540b158c070f@linux.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Linas Vepstas <linasvepstas@gmail.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>, Sinan Kaya <okaya@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Keith Busch <kbusch@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1194;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=lFOsaGCqPFeMuSYl12T0qvZETcU/iSpEinVY4COc/Iw=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDK6GJSk4jaJNjX7s/FWTOpfuz64bd+0bWGFfELFOh8vr
 ty2ZsvejlIWBjEuBlkxRZZFXc5+6wqmmO4J6u+AmcPKBDKEgYtTACbitpqR4cW8zzoSlcG3t01a
 zZu9jZHx0yydLpOP1U239ddzPLeadIuRoeV8y1E/tSDDPmY1aQ+Vdd4mzCv+FofNbp/Wd/8m35G
 nnAA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6MJwY2lVKJ9sB9BqXhPQys5sLr_GtI_0
X-Proofpoint-GUID: n-WJ77-aeipZPH3QSgiqjW3G6l4Vdl5y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA4MCBTYWx0ZWRfX6L0NDNj6R8IM
 ltSnttOoAB+UftZvh3fv7wlkUsputRSD8wGW1PUMVzPFBX7rbGs6Aj4rHSBOWzuA+SfZ0mO+S8w
 i+pQdfJLDFLKPCPidg8rnBbsfmy1rbiwlfgNZiV9x+qFzFLkKOsnluhAWbyn3UT/q37rh9YfKlW
 sfub98Zj5X9jmiQCRR9AtQItY0XzqDXR96btjFXXpmzB/utpdjT2v1YeCgpoGiyzt8LIm3Iw/jb
 5Bc7cTr9jAaWqhgUFJSqBQovftUm1pRHObCDNT/y1u3IakcXIOEFT+bFoVs6Y5eYu4wb7GnBvO3
 MhJhc+zg1GIpVSDdZPeqvXcEpcYtVAVqf+I7w882yzdbm9w2eHY6ucnQZglvZPU8YbvHFZI2TcZ
 fL6+PkPoKc0v3Okj69DdJxkV3ZPC7quQuIymcf8Hd6oPpjdykCG+K+xaNafj6XTUHFLK/O6q
X-Authority-Analysis: v=2.4 cv=ZoDtK87G c=1 sm=1 tr=0 ts=688a002d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Tbr2KL6GNvhcKcAIiBYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0 clxscore=1011
 adultscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300080

Since commit 7b42d97e99d3 ("PCI/ERR: Always report current recovery
status for udev") AER uses the result of error_detected() as parameter
to pci_uevent_ers(). As pci_uevent_ers() however does not handle
PCI_ERS_RESULT_NEED_RESET this results in a missing uevent for the
beginning of recovery if drivers request a reset. Fix this by treating
PCI_ERS_RESULT_NEED_RESET as beginning recovery.

Cc: stable@vger.kernel.org
Fixes: 7b42d97e99d3 ("PCI/ERR: Always report current recovery status for udev")
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/pci/pci-driver.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 67db34fd10ee7101baeeaae1bb9bec3b13e2fdeb..94ba6938b7c6271b557cc7f17ffb89631d83827e 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1592,6 +1592,7 @@ void pci_uevent_ers(struct pci_dev *pdev, enum pci_ers_result err_type)
 	switch (err_type) {
 	case PCI_ERS_RESULT_NONE:
 	case PCI_ERS_RESULT_CAN_RECOVER:
+	case PCI_ERS_RESULT_NEED_RESET:
 		envp[idx++] = "ERROR_EVENT=BEGIN_RECOVERY";
 		envp[idx++] = "DEVICE_ONLINE=0";
 		break;

-- 
2.48.1


