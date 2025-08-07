Return-Path: <linux-pci+bounces-33557-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B734B1D981
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 15:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB683B338F
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 13:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B648263C9E;
	Thu,  7 Aug 2025 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CyXgfXXv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F91262FEC;
	Thu,  7 Aug 2025 13:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754574965; cv=none; b=KY5lp2QmRJQEurqkof5ad3iNJ0Dfy1/1MufjGsaGuRRSZOpuqy2P/nBiepXe1T4W81QIzW1WNy8vGGU2T3sRbv2U+zkH5MB8x59p9E3dL6hqB2SFJd9U+wmhX8LcMa8VhU6eIhIExKUdpAVmhqwEAv2UC43MwGNbIhdBOMgyf4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754574965; c=relaxed/simple;
	bh=mOG87tayZw5x3IBqjx1AAyFnN9RUxt9soJwUnbs0X6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tx/89AyaT9tVzwQo9rGuzk8XPrTKCwa+WJQ9MxdHCMJ3x731oPUnCgLLwdFGxzmcE6J6ciP+UV9vuo7dLazhAbSJHsKd+RPJFNAuOGvK7fajSlqD6W8AeqemdEYuteBcHRtfEatjpLrSDseSUeKUETla8sXI6x8jQ8y+TL2mvwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CyXgfXXv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5773uSAH019831;
	Thu, 7 Aug 2025 13:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=P6h6pE
	ygabob+MKMluPz2iaWqjq/rfYE+mrRUjaz2zM=; b=CyXgfXXvrSI39MIxCFgnqr
	vh4FTQ+YxOF5MUP1J+j/xiEAyN+3/7Pr2jXYx/qn5q36gi+DHr1Q6ONcIM0f/PDd
	D1SZYwNW6fJsEcaBZcXXLKH4P3f+nR+fjbchS8QlH9jbXWcgSjzaLJYFB+RK+rTj
	WOwXZsOLRSkHXnzOR4GxvdcMcw8bbAUITKeARKj2c7aprDnFbompLyiS/koy8Ppk
	nj9UqVirTMswX16qblRxiLxmSf4qM5GgGPoWSdPzKEJp3sGOOMVdAynXAVX8rlS2
	bUbF5zYj9tPnm2qMFjIm6JUHkB+r8PG8FMWYdESbhkkoQ11Cc7O6Es+fE8BsNQow
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48c26tyv47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 13:55:57 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 577DZujP010443;
	Thu, 7 Aug 2025 13:55:57 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48c26tyv43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 13:55:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 577DRW5u022640;
	Thu, 7 Aug 2025 13:55:55 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwqgw40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 13:55:55 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 577Dts6B11666480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Aug 2025 13:55:54 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54D7D5805A;
	Thu,  7 Aug 2025 13:55:54 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8993D58052;
	Thu,  7 Aug 2025 13:55:51 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Aug 2025 13:55:51 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Thu, 07 Aug 2025 15:55:40 +0200
Subject: [PATCH v5 3/3] powerpc/eeh: Use result of error_detected() in
 uevent
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-add_err_uevents-v5-3-adf85b0620b0@linux.ibm.com>
References: <20250807-add_err_uevents-v5-0-adf85b0620b0@linux.ibm.com>
In-Reply-To: <20250807-add_err_uevents-v5-0-adf85b0620b0@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1301;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=mOG87tayZw5x3IBqjx1AAyFnN9RUxt9soJwUnbs0X6I=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDKmbIh1Xf15eSUry3F3oxLJStUlDkL2l8OCwo2dwqT5j
 vJquLN2lLIwiHExyIopsizqcvZbVzDFdE9QfwfMHFYmkCEMXJwCMJEbgQz/6182btbxe8CgHMrm
 svNxf9hE1RIp7ezuFTkGn5kLNi7PZGS41y4REPRnm/urK8UFQXaf72ye+/rza99An+6v4Y95Wxw
 ZAA==
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YH0b8-6YXjdsqzw7jV_FMU1BENykmw9c
X-Authority-Analysis: v=2.4 cv=F/xXdrhN c=1 sm=1 tr=0 ts=6894b06d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=USTt9hxsF4_VS_TezIQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: fQbQG1xr9EhhieZp8D-XY0qjJ3wzijgZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDExMiBTYWx0ZWRfX/XXI7Fr1FvJY
 FOXThBrUUHzXjsk98nkr2a80J2h7wW/6Z7XWUTlp0cEOL4j+Zy49UU65Jrb+mXZoIo4m5p/8xxO
 Nrm7OlcUW3ahqemn/ryOEdRhyUV+1VxGMB2WWOzaba4A/V/UBtDzBVzijlu8Vi8IcWJcHUYfExE
 an9a156D2a+5kusq+clnieK9jxfWZD9Npe0SFNhvyEU/kS0++D4T1o4Od95b+b9sJPflrzd9Kkr
 vA9XYjtzjiTF+aeKxWHw6Lxc7Ntl+UUmCGdCZK6vFzd2FOWT3TEBmHUm8nuai3JAxa4K4PrEdzP
 6GvPnjYFnA/4tJ2G0SN505iiY58F3y5QFBHEQ9DI+QRn6JHjpNKmbzLPIZUuNwl0I260Gy7QwLd
 k5FhPacQt+sqjS1y3GoGU6e1mkF2q7jx33J+4XZ+/o+0N9uHDBxfR1zfPSv+/EMui4d7kW2k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508070112

Ever since uevent support was added for AER and EEH with commit
856e1eb9bdd4 ("PCI/AER: Add uevents in AER and EEH error/resume"), it
reported PCI_ERS_RESULT_NONE as uevent when recovery begins.

Commit 7b42d97e99d3 ("PCI/ERR: Always report current recovery status for
udev") subsequently amended AER to report the actual return value of
error_detected().

Make the same change to EEH to align it with AER and s390.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Link: https://lore.kernel.org/linux-pci/aIp6LiKJor9KLVpv@wunner.de/
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/powerpc/kernel/eeh_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 7efe04c68f0fe3fb1c3c13d97d58e79e47cf103b..20ed9685da8b7e6d419a4b02f715b52acfe715d3 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -334,7 +334,7 @@ static enum pci_ers_result eeh_report_error(struct eeh_dev *edev,
 	rc = driver->err_handler->error_detected(pdev, pci_channel_io_frozen);
 
 	edev->in_error = true;
-	pci_uevent_ers(pdev, PCI_ERS_RESULT_NONE);
+	pci_uevent_ers(pdev, rc);
 	return rc;
 }
 

-- 
2.48.1


