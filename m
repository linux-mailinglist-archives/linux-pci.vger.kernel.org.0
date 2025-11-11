Return-Path: <linux-pci+bounces-40908-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C38EC4E191
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 14:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E58CC3ACE90
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 13:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA67328256;
	Tue, 11 Nov 2025 13:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LF62p4jW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2568A3AA195;
	Tue, 11 Nov 2025 13:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762867489; cv=none; b=JHBIzCFtYnP6cb07M8ULe9WDhPuUbhLwmy1voneP4+/aclC51hMPh+ln/0kU1vI+fM/rZKq0+GjpEypOHjvazkzw/4lLnxw94SZYVE7oUx8iR9KRjNCtARdVk4LZAduPCr7vJWG/KOPCtRRTdJ2zUZBbOwxrjB4XxqBBiDTMm1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762867489; c=relaxed/simple;
	bh=+g1uK21001nOzYIJ7ry6HKSrTlukMfqwQbtcT3JfBv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fuxOGuHpZIjLkEMoxkUJKXZ1tIui5qcVie5zPOhslnzC/ytz/DykOyRLAmGWoWwh3f6yHSGeDa8CYzC0hpmOios3mFLuZFs21SUZSSM/T14vEa9zmrMj0794NRz6piiQgfGAlGn+9GNmNAG8xkHoUnnzJ2fNGYXN32wva3RiWe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LF62p4jW; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABDAYXF009868;
	Tue, 11 Nov 2025 13:24:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=5LKeLHsesFfV72BE
	nO+/XhOB8h3NN0zZCEKrYrjE1vo=; b=LF62p4jWONTZhqMkK3Zjl9waOu2IPW7k
	azq0jqZIBkk0J1F+c7Q/LKZicNkOuEQ4g6oORbrQKHP6MzEE50saBzR4oFV804mx
	Yoe0v5OYM/6Mu9dbsaoiF2hFLg2XH7SkWdiTNruNmuQlUJHywzZzxygn34Klqlf/
	SAoNqRHZtScd7heIcL9TDeRFD5/TNgQbU2D+wuHPTh45A5b5ZvvSqVcQGWCNdt9m
	BAw9NCiB4lqLl0Ksd2edSJkbb60GS1gFKzpilVXT84P4Pvow0AS3zhsQL4z1SHQI
	5mYjc13YAObxbEEmmnRGfYSU/OMeeKqA0i/lRIs9Q6FZizTWR8ldUA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ac5st00q5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 13:24:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABD9pqo007604;
	Tue, 11 Nov 2025 13:24:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaa1636-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 13:24:05 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ABDO5RL015951;
	Tue, 11 Nov 2025 13:24:05 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vaa162f-1;
	Tue, 11 Nov 2025 13:24:04 +0000
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Sinan Kaya <okaya@codeaurora.org>
Cc: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Do not attempt to set ExtTag for VFs
Date: Tue, 11 Nov 2025 14:24:00 +0100
Message-ID: <20251111132401.1827922-1-haakon.bugge@oracle.com>
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
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511110107
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDEwNSBTYWx0ZWRfX973FRm71HbbN
 gwAUqa/nlpwFJhvNajUOLxftGLEaYNF4OwvN+jmWQqGmvhYIoeDUXRmypW2eLiY93bqrXkcLaKv
 0oFAeN54GmezrVo8eoElvGR5Httd7hVeYPJeDcu63exHXVKUP7q7k+3nSepmMGcIoG5hC68y4Hr
 6nD65rndWCRgXD32poMOfR85q1VleD86Xs4zkxOxAgRW7ghBp8dsSgjkZ4mwlJjlbsLYJdf+hkj
 Dgku8pa9yEyALpWXpARkBxLHIe7JdH+6/saoTCFA782nqnA70pU/Dwtpl2R3hwz+ocIHMTnIwzM
 oWM5Nh2h+j+0y0933q6qOzulaX0/NjXCyucTq2dtiAKoJfHFHY8lslW5V5g/l57WH5M6MJI8ZAC
 xb+KYCjSD97R1+35jCBqInFOyQsR4g==
X-Authority-Analysis: v=2.4 cv=V+pwEOni c=1 sm=1 tr=0 ts=691338f7 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=mxn1B8OEhiiVPjgrDlIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: arz4ei6-gQN8Livd0iVQ6HxWi54ZOtY-
X-Proofpoint-ORIG-GUID: arz4ei6-gQN8Livd0iVQ6HxWi54ZOtY-

The bit for enabling extended tags is Reserved and Preserved (RsvdP)
for VFs. Hence, bail out early from pci_configure_extended_tags() if
the device is a VF.

Otherwise, we may see incorrect log messages such as:

	   kernel: pci 0000:af:00.2: enabling Extended Tags

(af:00.2 is a VF)

Fixes: 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
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


