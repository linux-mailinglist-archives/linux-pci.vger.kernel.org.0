Return-Path: <linux-pci+bounces-44225-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C99CFFC09
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 20:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3645317D153
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 18:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27EB34A3B0;
	Wed,  7 Jan 2026 18:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tWb2uM9N"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B9E3451CB;
	Wed,  7 Jan 2026 18:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767810765; cv=none; b=ZdVfGKF9HGG/J7T0P0vaTB7Nxjr0S4eyA5S5T7wGlvJskyxyKs/Ky15Wuht+x52FqaLl+05re7gVX1AUnzqCPETrroIHzm/K2NAIvskOa5+kX5sbFncIARMzqEsH4GjhxVEjbPE29YyfjIe5nLiCpz3xEjxU1ueI0OjUEMAmolA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767810765; c=relaxed/simple;
	bh=+y6rEm8/oRhfI7Kp8yP0XCDL+hm6dnx7rbVNEh3gPB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1ZmgPrLAJcuNgznCC/zixd8GpKFn0WE88BgHZFMTAIVd7k5mgyHuwfTPNIqZiq4U9vnK7yFyLwxjHUPYO7zsBD9Aec1vgNMvFlsWHJuJDInGfQfKdA6wk+BEiOXZfFRquQuSo3be6L8P7lRaSKnkfAyS2X3bygj8ZVNXIj9Asw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tWb2uM9N; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 607ERq12012459;
	Wed, 7 Jan 2026 18:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bZTMUysJ4paDGO4bd
	8/h4k3MsAVwuOXg+ANlYhOopDg=; b=tWb2uM9NldvVzOdQKQmB1MCbaZjviNJcu
	m16Vnob249u9PO98nZpyDHWERIA9Ha9XMtzvfsnuyOqV4dGF7oh0s+OBKoPBNzNt
	EW8Xpk18tfP+cFcEMKQd9LzRNvXUjQe65DTi6W62bouiSMvaEfYhNb3aNL45GSSJ
	EzXP4k4yH8lq8/sNxPtozw+kAJ99boWjNC6AO7fV/61KyR07Yk6ifU+6NXU2l5kk
	/HYYytZS6ugO5obayBzQZnGFzT562dfJPY/6CCH3LI93tDqSJdgvfugFLASUaPD1
	sWoAY1VH592wpS77nqq5jBNewQu4/6h8tBaRX5wPY3w4cthhO7lWA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4beshf1g97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 18:32:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 607FrSjq019154;
	Wed, 7 Jan 2026 18:32:33 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bfg51af0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 18:32:33 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 607IWViX15008350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Jan 2026 18:32:31 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DF5D58059;
	Wed,  7 Jan 2026 18:32:31 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53A2758055;
	Wed,  7 Jan 2026 18:32:30 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.241.168])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Jan 2026 18:32:30 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, alifm@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com
Subject: [PATCH v7 9/9] vfio: Remove the pcie check for VFIO_PCI_ERR_IRQ_INDEX
Date: Wed,  7 Jan 2026 10:32:17 -0800
Message-ID: <20260107183217.1365-10-alifm@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDE0NSBTYWx0ZWRfX+EX87GBRMozu
 r1hMJNym/m2Ppm+J9ufLzI8LYlIq/LW5inO5JUz52bHLWY897vieijz65XFGO6RzijibeuP2j1a
 RaAASlP0oj6TqMwpz+u/T+b+1X9LBefoKO+0KaQXOmk9HGwnuoZ0gYR31SetznfEofb7Orgp5n3
 MTid0c5BOdohIezYzEHpXH6Ulx0chnkOADt/TnL5dHL53WJkkjDAYj2sODzB0zC94ZgPAzm0d3d
 nXd3+tvg1EgxA0QY+AB/yE1hlPKVxqSCJWZHvOIrq8YH9MFBcmvAL+sSiTXPrNOp8v/pQO9fl90
 rzLZF/LYZOOAnEHnfsFbvneYi8b1vlD9j//Bc9k5ydCgl25HRLWBsFKM4gkOkkV5eBcBEpND06X
 jZPTGMGCkUw3InphEdm/J4+RhZjflTs/XCamGjOZRk9dUXy6deNA1HW6K79pEWhJuAGCIaxUSon
 kEEdv/qKG6wR7FrxBiQ==
X-Proofpoint-GUID: nl5jpJu6QUAP-sqM34qIgurpe3FMZ5bY
X-Proofpoint-ORIG-GUID: nl5jpJu6QUAP-sqM34qIgurpe3FMZ5bY
X-Authority-Analysis: v=2.4 cv=AOkvhdoa c=1 sm=1 tr=0 ts=695ea6c2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=9wliL4UQvNVLrYCoNVcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601070145

We are configuring the error signaling on the vast majority of devices and
it's extremely rare that it fires anyway. This allows userspace to be
notified on errors for legacy PCI devices. The Internal Shared Memory (ISM)
device on s390x is one such device. For PCI devices on IBM s390x error
recovery involves platform firmware and notification to operating system
is done by architecture specific way. So the ISM device can still be
recovered when notified of an error.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/vfio/pci/vfio_pci_core.c  | 6 ++----
 drivers/vfio/pci/vfio_pci_intrs.c | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index c92c6c512b24..0fdce5234914 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -778,8 +778,7 @@ static int vfio_pci_get_irq_count(struct vfio_pci_core_device *vdev, int irq_typ
 			return (flags & PCI_MSIX_FLAGS_QSIZE) + 1;
 		}
 	} else if (irq_type == VFIO_PCI_ERR_IRQ_INDEX) {
-		if (pci_is_pcie(vdev->pdev))
-			return 1;
+		return 1;
 	} else if (irq_type == VFIO_PCI_REQ_IRQ_INDEX) {
 		return 1;
 	}
@@ -1157,8 +1156,7 @@ static int vfio_pci_ioctl_get_irq_info(struct vfio_pci_core_device *vdev,
 	case VFIO_PCI_REQ_IRQ_INDEX:
 		break;
 	case VFIO_PCI_ERR_IRQ_INDEX:
-		if (pci_is_pcie(vdev->pdev))
-			break;
+		break;
 		fallthrough;
 	default:
 		return -EINVAL;
diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index c76e753b3cec..b6cedaf0bcca 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -859,8 +859,7 @@ int vfio_pci_set_irqs_ioctl(struct vfio_pci_core_device *vdev, uint32_t flags,
 	case VFIO_PCI_ERR_IRQ_INDEX:
 		switch (flags & VFIO_IRQ_SET_ACTION_TYPE_MASK) {
 		case VFIO_IRQ_SET_ACTION_TRIGGER:
-			if (pci_is_pcie(vdev->pdev))
-				func = vfio_pci_set_err_trigger;
+			func = vfio_pci_set_err_trigger;
 			break;
 		}
 		break;
-- 
2.43.0


