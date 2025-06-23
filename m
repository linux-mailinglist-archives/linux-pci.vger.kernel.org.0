Return-Path: <linux-pci+bounces-30351-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4C2AE38BC
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 10:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D723A6280
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 08:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E3A22F77F;
	Mon, 23 Jun 2025 08:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q1b0mnCx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3003E22F164;
	Mon, 23 Jun 2025 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750668120; cv=none; b=Ga0yGBFDoD34PQ44CGXkePXxzxbAiVV4lYNljMyapjMm0Q7UD+lvAPZH82fj935mz8YY9Ba0HfJ+5xixS12m5GNW23DHMfhS7CHCUYywBfOTxLwNIpI4Z45yEmU6wctZJwPxYaubQfnuSpepNlvh6leEaGLJfSrlAM7i8IARDV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750668120; c=relaxed/simple;
	bh=lFOsaGCqPFeMuSYl12T0qvZETcU/iSpEinVY4COc/Iw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cuMScYS5/pDGvSFt7ygmglD8yWTPXKtjR7mUjbe9w4KXsDGKPsEY82/nWgtHsz0JawdoRKyFn666pkPUswxQsDj/9Ft945INFM2a9x2a9H0DC7vCuGB1lEVZDXhJFP+0jUr1BQONooPfOblM5LfQ7ks1HA2Y9bxBphRsZiQv1ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q1b0mnCx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N6Z6la029925;
	Mon, 23 Jun 2025 08:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5obXgh
	oBDb03rk0VDSAZ7lFDc9v2p/DdlGM67CP3lvw=; b=q1b0mnCxxQj0pd0wOKCHgX
	u5dy9v112CHHd45qYQVb09ggsDbUbo8IoXU/oJGT4Mki0sLpJr/fNTiXpLg6rYvw
	8dKlFibz7UyycStrvOlEH5DNpSD/QFbzzxugFxUqZx2K82ZCFM2PtrCnaAnx6v2i
	Ozkk5FA5PFQQQdbMX6oy6bI6UixuxtVK93iPqpNAJraJPNX4EWRHFop+gasIEfu2
	L6//7i/pe7yWWAdjL8Sszc2DT+nPFLLvEZAmkkxM6Fad4EI90sZcQDN51Uv0C2TR
	wJNs/uCTkdHg8OWODVX6ny0aJD8E7fx9q3mkT8psqJw4ZzwfgU/+N0wYhzLLVZkQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmf2r4ag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 08:41:49 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55N8ZmV1001372;
	Mon, 23 Jun 2025 08:41:49 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmf2r4ac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 08:41:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55N8WLDN006408;
	Mon, 23 Jun 2025 08:41:48 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e82nwamv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 08:41:48 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55N8fgWF27591398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 08:41:42 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D4A258055;
	Mon, 23 Jun 2025 08:41:47 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E74E58043;
	Mon, 23 Jun 2025 08:41:44 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Jun 2025 08:41:44 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Mon, 23 Jun 2025 10:41:32 +0200
Subject: [PATCH v2 1/2] PCI/AER: Fix missing uevent on recovery when a
 reset is requested
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-add_err_uevents-v2-1-a3a2cf8e711d@linux.ibm.com>
References: <20250623-add_err_uevents-v2-0-a3a2cf8e711d@linux.ibm.com>
In-Reply-To: <20250623-add_err_uevents-v2-0-a3a2cf8e711d@linux.ibm.com>
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>, Sinan Kaya <okaya@kernel.org>,
        Keith Busch <kbusch@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1194;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=lFOsaGCqPFeMuSYl12T0qvZETcU/iSpEinVY4COc/Iw=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDIihZ0L9tQHiOzWFMp9HGV9i+dA0Is/VxsPiK90rDttv
 2WRsM6BjlIWBjEuBlkxRZZFXc5+6wqmmO4J6u+AmcPKBDKEgYtTACYiuZORof9p4S6uZI9LjxQS
 jS9w6HB9dq2R/StyW40nupc5ag//CUaGCxfvpl3/43iiJ+Chu4nJ9KiOHZGmTTrv7FizL0ins05
 jAQA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5FNKzws c=1 sm=1 tr=0 ts=6859134d cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=Tbr2KL6GNvhcKcAIiBYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA0OCBTYWx0ZWRfX6txSpMkyW0f/ VnS7fj5OsNE4T8/wk5ZvmPBOUl4xxbRTY1AUq/SPXa50t5/LuVqbofk1McGx6cWEYddHdBq6sxB zkzSpep8rWxE8+b2YHFRsP6qHtZIMi1qPiIhUjX09lqQ9RFJrfY5GqkqUDtr4iKY8GxhRaX2gtm
 S5tgWvJeJb4BA5vC6ZUhpcZ1rhxK6Gh8s9nNn2KHDf8pImENJXWEaDcn3d/R3pxxR3lC+WlL9YC 8qIlew6aFh4cWJ7mfKRxvZwjV7FeMkQc9+qyH2GHk4u+aNX85WiVl3MQEsK3GChAubyXUm+pHsH DtgprLLK0CogkDFg3bw1R5B1MEJd6Nsbif0r+G+BqHCNGMaacMmiNCFJtUqnCM353oc2PVHkzal
 e+bF6ogYAfLm8IYDPdtLLhfzOhH/b1C1jfHHxdjpRWYeDRMd3bOy1FpLzf9lc2uQvzyiH9Yn
X-Proofpoint-GUID: bPqn5dHKhfiQjAf65v4BgnWqDYI6NhUQ
X-Proofpoint-ORIG-GUID: Bs7pqGMJuxme9N2FCAkiGL3_FjDPUWKA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_02,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1011 adultscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230048

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


