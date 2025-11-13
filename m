Return-Path: <linux-pci+bounces-41166-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9765C597FB
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 19:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8CB03A34B3
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 18:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CC431282C;
	Thu, 13 Nov 2025 18:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bOyRpcD/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97073126C3;
	Thu, 13 Nov 2025 18:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763058921; cv=none; b=NWd/crqFzn6yarDvz6v6Zxw16piWnF7vSg9cD8lQ+uzBbyFi3gpLYGLsQRplpCk4eTVGIcSmEXbfFV0xt9xd8IVeSjdKT2xfg2yIJUv3eYNUP1nMjL2VHO7DWEHs8PRnnb4/9CWyethWEXtmknIsuJuP/i+t/0RXOxgTvof4yaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763058921; c=relaxed/simple;
	bh=zZBPbp2ZZOrRWb91SI15MQiYFsj47IjA66DS6/Ee7PI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e7SmLl/osV44ofr4+AeyWqSmUWJeqNf3uSP5VCiS7h7YEZ0c4NterDn1F/XyUzCMVWL6R64RU5e1otwp/TTz5hH8WF5AQkB88zMB9ceNuvcCq10O+qYy3XQkT2edFm0sMxzmBCdq2uP+oDxBUUAqu6zvUOk1uU214jx3IBHWua0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bOyRpcD/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADGAJu7018111;
	Thu, 13 Nov 2025 18:35:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4kJCpqCEm8nHCEzhS
	aW5OnDcESvJl0HJbi1PWbkUb5c=; b=bOyRpcD/T8lfnvoC9u1iKT/IlrtGvkbPr
	4uY/oXg76NAlIbX6M9I4AUUi38K/5Q49iHcXt12OuE3oXpDeKKABdfgGGqoJ4ITj
	asIeRLQUlLAXjJz2a7Ttpm2wE+MXG0CiSfAKHBOY8rAlukfvl4GIV4dAMJ4XLyTb
	yy5FwaI1q99M6H2BNo4rTBLLCrC85I0dLE0kkFJmDryDJD32ryPmDl+0Bca+u1gk
	8GKTM0tXsFaXyTLYjklPHtnrDh1qSt3VcNZD44B0JkDnB1A9hplk+cuGNbWxskhe
	R2lMF1hqiCrQMYI7x36GW3VGKMFgRsHj6flpJUQgIJrDF32sUxSDA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5cjgj2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 18:35:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADGCT5I028880;
	Thu, 13 Nov 2025 18:35:12 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aag6sqkjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 18:35:12 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ADIZBOB30802654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 18:35:11 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74A1A58053;
	Thu, 13 Nov 2025 18:35:11 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F1485805F;
	Thu, 13 Nov 2025 18:35:10 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.243.9])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Nov 2025 18:35:10 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, alifm@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH v5 4/9] PCI: Add additional checks for flr reset
Date: Thu, 13 Nov 2025 10:34:57 -0800
Message-ID: <20251113183502.2388-5-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113183502.2388-1-alifm@linux.ibm.com>
References: <20251113183502.2388-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Ss+dKfO0 c=1 sm=1 tr=0 ts=691624e1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=GmWZ7bcXLGqOY80bcTIA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5NSBTYWx0ZWRfX3yhP+cKl5JSu
 1An9IPvkjNVj+yFdHElOA9M+pT3yzbBUAXHWq/JoFXz4yeO5gGPUxKSJuCZaH/UKu38xQAWs3Cp
 pJFSqOf5O2cqZWfCSqrq8Y4T2Urd+CzTFcW1GA1MHDXc1KMBldbsideg8bjKAJ3uLGlZoYpsYJo
 TMuf+bd5VDY+7kV7eMATQm27Rx/CK58HtkERDBxhNGNw7dcza/YMSky3/ztYA3DksTwRn2V+s8F
 YBSvcsUwmiF0fJNwBn5TkR+ZEzGjtENuB7Z6hf0rFEs3oEkVFz4+rlr4fXXdBLiTdFF21unUtf8
 fG+zrTKY15Iu6X7L+/P9C2ihBs37JwOyhWgfPIisrsZRAgnQ5PLm+ExutBZfP2m+yay6k1IksbD
 KpqROye6nHZVaaKUAbJp7DgAYBzqjQ==
X-Proofpoint-GUID: J9YU1oaYo4-d0eV39bG3upQIXQqsXsl4
X-Proofpoint-ORIG-GUID: J9YU1oaYo4-d0eV39bG3upQIXQqsXsl4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_03,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080095

If a device is in an error state, then any reads of device registers can
return error value. Add addtional checks to validate if a device is in an
error state before doing an flr reset.

Cc: <stable@vger.kernel.org>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/pci/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 3a9a283b5be9..4f03b1c730cf 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4525,12 +4525,19 @@ EXPORT_SYMBOL_GPL(pcie_flr);
  */
 int pcie_reset_flr(struct pci_dev *dev, bool probe)
 {
+	u32 reg;
+
 	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
 		return -ENOTTY;
 
 	if (!(dev->devcap & PCI_EXP_DEVCAP_FLR))
 		return -ENOTTY;
 
+	if (pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &reg)) {
+		pci_warn(dev, "Device unable to do an FLR\n");
+		return -ENOTTY;
+	}
+
 	if (probe)
 		return 0;
 
-- 
2.43.0


