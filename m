Return-Path: <linux-pci+bounces-40976-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E53FC517FA
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 10:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7611881FF4
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 09:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCD9217F36;
	Wed, 12 Nov 2025 09:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VR1sSncF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970042FF15A;
	Wed, 12 Nov 2025 09:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762941321; cv=none; b=f/OAerXxwq/pboA8USMOOUKGMiw6szCC/A+QsUuefeLgRIfCkQTUMpH0OYRbJbhEifJO/33Nwzzu48WUdhjkjtOfnNaxvpxlo798Pp5QWQ+Z3GlJ6BG9s/hOzu6tKqwSLg7h2aO5RVSFUbsuNe4zxj4UJ53/aEb+BBmoiJjvWVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762941321; c=relaxed/simple;
	bh=SFI9MM3tuC+Bivwx7QPVbtLlk+ybwULToKZLNrhJT38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rly784UDLHEabmbabTkfaNZNy1QWaVJj+2l9PvSsBi1D91qFuw7emLdPUnG/SjHwZ+pcf0GCXhd5lSsZpqx8dGt/JhxQM39djUFDjiFKSoNtSTH5+fsh+FWQtUPt6S8dcAHsbrfpw6xCQTvKv45ev32ijrq1NvLZd4Se/7AHpas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VR1sSncF; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC8cWMe025757;
	Wed, 12 Nov 2025 09:54:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=dmkHiVLSvORdYgKy
	1/Um6NDsCxamLB7VRZ94gczACkY=; b=VR1sSncF/Dfu2KPGNwCsEvp190ta9FpI
	zz5TlnRH8vPBUs6VJiDEOGqEZOM5aexxdYQ2BC/h2pc9J4HW+ZewBmJIErXz59kK
	eNhoHdleaDCEKyId6GaGpdP7n8mTBR7+rmzrEcToVa2CezwHYs75FpR4jJdxkhJX
	CW2NvIT5nx8EuHG0jCno9MTSM1x6gk+LhJp/7Ss1oYTiXWOGfJlCYp5ky9uq9O/e
	Ctx4HEcfY7TTwYLBHjxlTvSERiho5OC0u87DveUI+2JLn1rnfVWpqGEK283nL4fs
	In50tcvllS69GJUzh4TW2eymptQ/FxoaKMuzZ6gz2qVoeQjiABTYtA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acpg686e8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 09:54:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC7ml82021018;
	Wed, 12 Nov 2025 09:54:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaagc8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 09:54:45 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AC9siwH015703;
	Wed, 12 Nov 2025 09:54:44 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vaagc7r-1;
	Wed, 12 Nov 2025 09:54:44 +0000
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Sinan Kaya <okaya@codeaurora.org>
Cc: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: Do not attempt to set ExtTag for VFs
Date: Wed, 12 Nov 2025 10:54:40 +0100
Message-ID: <20251112095442.1913258-1-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511120079
X-Authority-Analysis: v=2.4 cv=FK8WBuos c=1 sm=1 tr=0 ts=69145966 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=mnBHqYny2I4Dg18uI9AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: L1_0lufocTbI3epD7E9WtsQPQKPhC-CN
X-Proofpoint-ORIG-GUID: L1_0lufocTbI3epD7E9WtsQPQKPhC-CN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA2NCBTYWx0ZWRfXymYuhkNsVWbg
 VsJwo+Mhg+9EBcSgHO14/inP4aE0Q7LVoPBfP/+/0cMn+vMsrViJB3iyZrSJ9NB23uS29mTnbJT
 bD5g2Ls+RatisXbx2H/p520zLP4qVcg1HdXNRyCJlwu6lhRHQaIAbcnS7ES7BmNsxHYw3OiL0OT
 PrFYLR8phOC1cSgZFMO/cNpux4caipIvyAQKWhqB+A1RxE7V1QNgRMXe3RNvt6/shkN6JPXNIPP
 Lg4H0v5jqiUjXvMKdDoRwHhwxZgbkRbEEXsZfTCeg4SIFeZHuc91XG90FMK3kCThv3/3C5d81RJ
 5hnWHBum5bpRQedlmecYN2yopx3X666yaid0giFtka4WsDoXt+/guRVTbST1dkWdeR8Of5jmEgC
 UpW81Lfn4+tD4eHhzoliznByvBVWFw==

The bit for enabling extended tags is Reserved and Preserved (RsvdP)
for VFs, according to PCIe r7.0 section 7.5.3.4 table 7.21.  Hence,
bail out early from pci_configure_extended_tags() if the device is a
VF.

Otherwise, we may see incorrect log messages such as:

	   kernel: pci 0000:af:00.2: enabling Extended Tags

(af:00.2 is a VF)

Fixes: 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>

---

v1 -> v2: Added ref to PCIe spec
---
 drivers/pci/probe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0ce98e18b5a87..014017e15bcc8 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2244,7 +2244,8 @@ int pci_configure_extended_tags(struct pci_dev *dev, void *ign)
 	u16 ctl;
 	int ret;
 
-	if (!pci_is_pcie(dev))
+	/* PCI_EXP_DEVCTL_EXT_TAG is RsvdP in VFs */
+	if (!pci_is_pcie(dev) || dev->is_virtfn)
 		return 0;
 
 	ret = pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
-- 
2.43.5


