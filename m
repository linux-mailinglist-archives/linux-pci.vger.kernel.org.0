Return-Path: <linux-pci+bounces-42422-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BF0C99518
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 23:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 56540342BDB
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 22:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BDA28DF2D;
	Mon,  1 Dec 2025 22:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="azf8Mzxu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E777D2882BE;
	Mon,  1 Dec 2025 22:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764626919; cv=none; b=TY1/2QeOAknsSsGPVEyvoFVaXDqIIlUt+g11sp8dgcz/WdbCJiIoxMuwK6HyIPWqOtZ3vWtuqRZV4AeHKDpElGpc3xoaVPKvmnZAP4axoTjMX+fT62r8s0dNOPfjYh/Ys7UUWQgn38JB23IRjkx0HSIj+2k8Bd/UlO0dsyMJNEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764626919; c=relaxed/simple;
	bh=3nwbGAKnGqNfTk39Rx6cOI9ineYjHoY9ryk2P3hpX6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PHat08C38Cq3Ak1OdcU7YGIGbwDheF6SUAL9ljgwTFKsYFWcIl17n96LbUaAZ7s9o+eMoy3w2588OJtV9lKN8nL4b95e/mTl/FRTcJLIkNbZTVdg8B2vc9gu6r3kJoutR2R2cEZUaMwx9/JxYE+nTKk34BojuIfWAUNBoMFjTMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=azf8Mzxu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1IH22U007926;
	Mon, 1 Dec 2025 22:08:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hLvPa03W62vqnh3po
	+PRpESk5lY7iL1C07VMwFJDQRE=; b=azf8MzxuhDntVDcTY6/MypTjAiGKZSZNK
	D04TIPl8o8q6MqJ5WuCl06YblH2FZ94/rNkN87O60ryMQiCyBASIIrFEUwOaZlzp
	H99GlZ78aFdwktq1fKc41m5WY5kpItfq4DAXlRLd3qbdKymc4C5SiU4sSFhh9mUf
	+VIAU0lbo9hFjmuqcMXMXzXl0FPya0VVvIWNyix4ingO5pAF5n+iN70GUoijcy4C
	uIkFYOcVS72SbhSi6tFLQZA+cX7M4bpdkgvFvLzE6jnkt081GeHZyDvgo/Zed6G+
	nN3tUgBpRiZHCbnR9QuzECBikanKzKME4im0MhfPCq0T1/C905LQw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqp8psppu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 22:08:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1K2Tkd003838;
	Mon, 1 Dec 2025 22:08:31 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ardcjgprm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 22:08:31 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B1M8Tvb16188062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Dec 2025 22:08:29 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 677A75803F;
	Mon,  1 Dec 2025 22:08:29 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6374D5805A;
	Mon,  1 Dec 2025 22:08:28 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.245.160])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Dec 2025 22:08:28 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, alifm@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH v6 4/9] PCI: Add additional checks for flr reset
Date: Mon,  1 Dec 2025 14:08:18 -0800
Message-ID: <20251201220823.3350-5-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251201220823.3350-1-alifm@linux.ibm.com>
References: <20251201220823.3350-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAwMCBTYWx0ZWRfX6IODzaq2C0m/
 UqhAW3nIXPCnS8uNHZEeu3yaryFDRS8RmGNfmgk2h7J/Hl7435G2LnVn0MiZvTQ0MQfsBudvopt
 dGSfvXEIK9XYpPiAUZdlLAWfi+n3vNyu/wDsEpKsvYBTNliO2+tvSnBPJ57FJKz8IS+Dd/vaT85
 iC3ItsO6AtzEMtjXgF+9lOjGBE9pnnx+e6KwR6AeZPKkg8Btt6DRC8cCmhKBIDdFyR4F4jZ42Ho
 sBxRqF2fYNNpboS3GFSIPisr6iadP2nuSXSYv2QXUSo/QviBKf4EOpnWMRtWGR/z58MxjEYF8mI
 pOG91TzTgTk5SDVzu2Up0G+BpSuvUPgLgn8k1mC2Fo7LokVrM+GZ6JMHYtkLwXKnchhXbnh8z+f
 N5ksVYIrvDDMRRvB2+MII4ekqy2BtA==
X-Authority-Analysis: v=2.4 cv=dIerWeZb c=1 sm=1 tr=0 ts=692e11e0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=VVjTqNMZqy_sFl6tnFEA:9
X-Proofpoint-ORIG-GUID: 2TSvhcTe-wwk-ouDBscS60rtImkDKRr-
X-Proofpoint-GUID: 2TSvhcTe-wwk-ouDBscS60rtImkDKRr-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290000

If a device is in an error state, then any reads of device registers can
return error value. Add addtional checks to validate if a device is in an
error state before doing an flr reset.

Cc: stable@vger.kernel.org
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/pci/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 28c6b9e7f526..0f3ca4ff27e8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4503,12 +4503,19 @@ EXPORT_SYMBOL_GPL(pcie_flr);
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


