Return-Path: <linux-pci+bounces-44226-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D15E6CFFC18
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 20:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D70C3318AA14
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 18:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A86B349B0B;
	Wed,  7 Jan 2026 18:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sS0bXBDt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE76343D74;
	Wed,  7 Jan 2026 18:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767810767; cv=none; b=jvh3a5t+akyfdxf8cv1iyHXLbj1vwybMYpvWpBtbOELVFDxRKQ7eMT5zEtwp7ANjfSFQIWK3G1qBubG3kj2uRiWZZBzw8CiphcDeLrLqWkmBJJEyHNdaUzxmNfen8ui2qj7xTP9Gqa0vIf9iUXT5X9NgWZR+vmXiR7zf1hMdwfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767810767; c=relaxed/simple;
	bh=r84q0MdYMVDl8K675ATsNJMSYCWBGgPRCrHAN2+oYeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phQXR3wHttzfihl3lCqdzcTtHjvSuJdz3Q+0LTCEvlaCUlz9NWNyUA4DwZ76x8Bf/VFfhe82/OcSPp6gjzEQ8ShRiGPNR8OsqT2ur3iDHtnS/3t4KaFcmn8OoxMWCY5OBSz3qRQJU8TmjF3/oXjWIpcH0qYqt8BCbaZuBr0pBS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sS0bXBDt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 607AJKjX002444;
	Wed, 7 Jan 2026 18:32:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rRPDZNwhA5bZLVtt3
	hdn9/kei+AuLcUpYrSpAROO2k4=; b=sS0bXBDt3qMnU7gqKOjODDzlZEox+PhCa
	ZE6fmaaMmOqPHT9TwwdXFlbobNvccXM9E7Uba304Gey0ggAfGxWz018j3/G+PJMu
	hJAi56MSsXlrw34loPW3fgdeBKfnDM8Srd5C4Ri68pTTNyMGJzLViwtGOgAs0Fyv
	eIWCbrXmN1ghcCllV5cvqKbWgIIONcaqolaCk+Wh1VW1v0Tu8fM/mhM13TuvKKKa
	cth/pgcuTQlGbOTDaBxCUosOXZdzrnDP0SZjbrACkNYTMUajrYOlsm9fUQPGa81g
	anbH/88nGEvBRErtP63yxMjvQqxQigU3Ns0DmI+OyR0agM/W+uqGA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betsqaq0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 18:32:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 607H0X4p023511;
	Wed, 7 Jan 2026 18:32:31 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bg3rmfd86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 18:32:31 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 607IWU4I60424498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Jan 2026 18:32:30 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29BEF58059;
	Wed,  7 Jan 2026 18:32:30 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03C935804B;
	Wed,  7 Jan 2026 18:32:29 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.241.168])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Jan 2026 18:32:28 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, alifm@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com
Subject: [PATCH v7 8/9] vfio: Add a reset_done callback for vfio-pci driver
Date: Wed,  7 Jan 2026 10:32:16 -0800
Message-ID: <20260107183217.1365-9-alifm@linux.ibm.com>
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
X-Proofpoint-GUID: 1FsjHc5XVwjFemg93QdRzW4Nyug1Myg1
X-Authority-Analysis: v=2.4 cv=Jvf8bc4C c=1 sm=1 tr=0 ts=695ea6c0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=hcTHx3Z5Akp3fEzgVBYA:9
X-Proofpoint-ORIG-GUID: 1FsjHc5XVwjFemg93QdRzW4Nyug1Myg1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDE0NSBTYWx0ZWRfX3+Co5aFCDOqq
 sXAf1CT6/B/rO2zYo7uF5eK+vtK26/fArWaJj0AOfTqzosJxoNt0jfKBIaOrH572pZH659fAan4
 0YicT6TISLtQUOZz2LeTaTipTKCh75ADI0cJuufucDp94OMOv82mm6C4BqgvBijWbcq8tgSB03n
 GvM3h7uCPn/Qs6RfGL4WlGWBLEm0UfrxBsD6ULK3qCEos50C4FSZL72hiGdCJBG+JMOhPyLjtHn
 L8vteJZbkEHgdebQuopOX+iBFc6hWSoJhOp4HqZYbc6ecGr3OD3qYYUuWIiDBSVl7+nA31y4ERv
 hIO0Q3ugFXQHlhkOzyTm6p3TKSWWyuK8tQamhHzI++MnXG7Ju5UXv3lhjZuoV5t8h/0ghmkH1w7
 ihcmec2t5jN7XwP0lJMPoxSiD/yX2Cxczl5SQaDMfT4TQ6XfhOc1tny7TFeMDD1CifD2pAIs5Dw
 /GE3H8GOgWTrIeAjy6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601070145

On error recovery for a PCI device bound to vfio-pci driver, we want to
recover the state of the device to its last known saved state. The callback
restores the state of the device to its initial saved state.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index f677705921e6..c92c6c512b24 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2249,6 +2249,17 @@ pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_aer_err_detected);
 
+static void vfio_pci_core_aer_reset_done(struct pci_dev *pdev)
+{
+	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
+
+	if (!vdev->pci_saved_state)
+		return;
+
+	pci_load_saved_state(pdev, vdev->pci_saved_state);
+	pci_restore_state(pdev);
+}
+
 int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
 				  int nr_virtfn)
 {
@@ -2313,6 +2324,7 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_sriov_configure);
 
 const struct pci_error_handlers vfio_pci_core_err_handlers = {
 	.error_detected = vfio_pci_core_aer_err_detected,
+	.reset_done = vfio_pci_core_aer_reset_done,
 };
 EXPORT_SYMBOL_GPL(vfio_pci_core_err_handlers);
 
-- 
2.43.0


