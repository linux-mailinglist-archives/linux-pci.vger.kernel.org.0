Return-Path: <linux-pci+bounces-42421-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A194AC99509
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 23:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 15FF6342C0D
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 22:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F193228A3FA;
	Mon,  1 Dec 2025 22:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Iau891Lo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B175287265;
	Mon,  1 Dec 2025 22:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764626918; cv=none; b=PoBk3Fyag97Tq3VuEvyFcgSz+SJAiqbpIfDz7gC/i8V8aYI1AiH9lQ05r95wa5p9u45vsBA5nEvlnw4vUzzdXcGr6PIKlJptmw5ra/oMCvrEbkBu1+T0NMowoZIl4gqCOKiPkhGDJau/oI0LgBVe3ivNFUT1R917IoDJ4SYzItM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764626918; c=relaxed/simple;
	bh=xXjCfOl8mCz9Ao6oB5HO6Ndgo/RdyqYF4b0kF5z9oyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOnyg6kAbcqy3OvIAN3dd4gnDiq08lmb0TBAshdwFg+ux68AIA95lDwIL0cZD2nGCJHqHoiQyYhRwKSGBy6J5a6anB6OeRnKL6oRz5XOX7M/9MDGaM6W66uEIBW97aQSMo8yGF4VNVUBK9+LFMpmw1A+m0cnSKh1uDWhb+qsuwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Iau891Lo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1C0tCQ007984;
	Mon, 1 Dec 2025 22:08:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=M9uqm4tzqYPLWDjht
	nabhshHmalbNhFrhY1VTlktrAI=; b=Iau891LoEU34ck/87cXIiVOmXrJ2dzSVM
	+jLOTZ29hKiUqIMfZ5mtEczkB3+nQyj9HCmbwU+N/nhCIm5pS9dZiySXGInxR5mf
	QzEp7vGbsbkLMyddRTkAewWRPe7adLPu6HTkq/oTrgvxPKG+wJXpdrq2ra9hCOBx
	xWc/z0+6JWjP9DjaMQsEbCf8uGkjVmbHJjMfDzWy0GXtUERo20rpsKUmgSr+yqfu
	suzYaELHf7SWQ4gKcE8x8pufvhOBxTnq+kfNzaQIupWI3zembXzvz3szTP0k9pfV
	dBYe4QXAEyIo4w/ndMl79G/9NYf7LTVZQJp71EE6JmBpS8iGiYIwg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqp8psppt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 22:08:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1M1Z0A024111;
	Mon, 1 Dec 2025 22:08:30 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4arb5s93bt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 22:08:30 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B1M8SDj27919048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Dec 2025 22:08:28 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4191058056;
	Mon,  1 Dec 2025 22:08:28 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 590A958060;
	Mon,  1 Dec 2025 22:08:27 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.245.160])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Dec 2025 22:08:27 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, alifm@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com
Subject: [PATCH v6 3/9] PCI: Avoid saving config space state if inaccessible
Date: Mon,  1 Dec 2025 14:08:17 -0800
Message-ID: <20251201220823.3350-4-alifm@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAwMCBTYWx0ZWRfX45If4Wllwxfg
 vNeDC2JZk2Lgsi3lTomvfowL1rvMGg4moN2LoNcEOTTsucMYaiRcPoJPV4lB0qs5ANxNIfcfTDy
 BXdxAdU491sdO6iDWqHf1oiyXAFmfBm3T5NgljRT9oYUtECRsH8ry4AhWC7Cy+jtXc78TCGijpP
 DoSosHAsXtsexMsOb8BVstGmsV21MRWeemu2DtUdGtipBnk8YhUX5kMHSbCdVELbpXmS3KIOfBa
 p719cI7lPUl8Geuim456jBtB/KDB9QdsYw5RQ/pwnEGa/pd7+z7CbwIY2RC0PG/wmmuMkea3DH1
 H0snb6ESPu8Oa3dKw71gQyQy8npwU9SEL3VwDx+ASIvm1aL1e9MNzpV1eGwg2gn/ZZTaGV0VbJk
 odh+QUjBBYe7GtaySf64dBkm2Comng==
X-Authority-Analysis: v=2.4 cv=dIerWeZb c=1 sm=1 tr=0 ts=692e11df cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=xdIN8Vsn6p_WiBCsET8A:9
X-Proofpoint-ORIG-GUID: OJ60zyjtw2YeAR-q5kLVN7iUBcm8PpO5
X-Proofpoint-GUID: OJ60zyjtw2YeAR-q5kLVN7iUBcm8PpO5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290000

The current reset process saves the device's config space state before
reset and restores it afterward. However, errors may occur unexpectedly,
and the device may become inaccessible or the config space itself may
be corrupted. This results in saving corrupted values that get
written back to the device during state restoration.

With a reset we want to recover/restore the device into a functional
state. So avoid saving the state of the config space when the
device config space is inaccessible/corrupted.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/pci/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 608d64900fee..28c6b9e7f526 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5105,6 +5105,7 @@ EXPORT_SYMBOL_GPL(pci_dev_unlock);
 
 static void pci_dev_save_and_disable(struct pci_dev *dev)
 {
+	u32 val;
 	const struct pci_error_handlers *err_handler =
 			dev->driver ? dev->driver->err_handler : NULL;
 
@@ -5125,6 +5126,12 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
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


