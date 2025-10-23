Return-Path: <linux-pci+bounces-39159-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAF2C02140
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 17:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A241889E55
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 15:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F80337BBF;
	Thu, 23 Oct 2025 15:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VKJYG3UB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA433321CC;
	Thu, 23 Oct 2025 15:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761232871; cv=none; b=TksUl8z7jr1B+3lD7BLregAjJ8NOtcNBVcnwepRUrWJciqhr4Zaj+leEvmde5BJjJ7X1kpZKDw//gMpF9vjeQUQ4Dpyv8rccqAKaOHttGA+HrfOGOFYCtpSiSKoHVZFzUSdKfgyp41xw0ZuaSHlCFFdy5aTUWyYSRrdXriz6EwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761232871; c=relaxed/simple;
	bh=U1FFRsKsi+MX3bGQTOayQ+pUqE77ZXXFvLTyz+YFqTo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cB3XzInOfwGHbNTne9nFumpqMCpivtObTLQCEE13uhpPtaLJ8Wbwyn0oawqbzXZRrKmyzWgGRcyWWW3Yb4JTZe9j5vAGSgtFsSNrFx3HsCC/GWkJbZ0UbxShGSpbcxNsMDD7j+7fJzL0GDxYOBzCRWvuQSIAFVbJleUkyO2puac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VKJYG3UB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NCBIPM030509;
	Thu, 23 Oct 2025 15:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aTc4li
	kKutKbla0OW76/bAnYA/hN7iPXA2pcn3gICZE=; b=VKJYG3UBXqxWYeoWBZAnTx
	lKVOAdvPXEUnlID1Yntg/k5V7JfesuOA/HY6AYtMs1P5VtbggCYt4tRgGHNUPbtn
	XWp4uZ0rxLgLeCi0ZhUpYqEpYZ6GcdnR+7Acowt9JrbIHjMoQt2CkNj2e5LXhDPD
	sEbg1n63EkIwaTqUVbnMcklcQ85yA0SkVNaTvYVVCQVnSnFsRcIgz33iE1rJZz32
	8vuUeJ18NeA4O6s21AibJQjqr7ZTZtveL4iomfjPR4mvcisPCvVVoH6M0rEPmgnS
	OcnC2IHyxM58n2fmQ0HY01CVpH8M0QqUmeBuF0e3JSKM7YpmFqWUt2Qi4zJYw5gg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30w1gbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 15:20:58 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59NF7PjK017127;
	Thu, 23 Oct 2025 15:20:57 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30w1gbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 15:20:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NDHGiG017067;
	Thu, 23 Oct 2025 15:20:57 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vnky6jyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 15:20:57 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59NFKtR920578872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 15:20:55 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF36258043;
	Thu, 23 Oct 2025 15:20:55 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D3B558059;
	Thu, 23 Oct 2025 15:20:53 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Oct 2025 15:20:53 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Thu, 23 Oct 2025 17:20:42 +0200
Subject: [PATCH v4 2/2] PCI: s390: Handle ARI on bus without associated
 struct pci_dev
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-ari_no_bus_dev-v4-2-8482e2ed10bd@linux.ibm.com>
References: <20251023-ari_no_bus_dev-v4-0-8482e2ed10bd@linux.ibm.com>
In-Reply-To: <20251023-ari_no_bus_dev-v4-0-8482e2ed10bd@linux.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Huacai Chen <chenhuacai@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>, loongarch@lists.linux.dev,
        Farhan Ali <alifm@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Tianrui Zhao <zhaotianrui@loongson.cn>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        jailhouse-dev@googlegroups.com,
        Niklas Schnelle <schnelle@linux.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5163;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=U1FFRsKsi+MX3bGQTOayQ+pUqE77ZXXFvLTyz+YFqTo=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDJ+uZ8v+3yWL+FCza5PpoEfg1Ycetu54ehJWWsdAYkTD
 6OmLd22sqOUhUGMi0FWTJFlUZez37qCKaZ7gvo7YOawMoEMYeDiFICJSD9kZNi8/eKXN1G28xe3
 pR5cylP28uj6yauWSv34nfC6grV2zbw/jAw39up++lRsrvSedevRpGWM9zPibTwbXvufTaqs2SW
 6fz8TAA==
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zfc1AFnTXtb1mUxCTW3et0wnEloSS0nf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXxu/tcgCEm5Xi
 /MfMfu1NOHgWUyc0cKH9hUVLtWEvnMM6R7QmhTCqMqLoLrq3MvO4DpwjLuEN3F9QcB3v39ZZuie
 +0pa/yUbdr/6EM3fykMRnrKYChMh4WTKLa762XbK/Tp0C3UPBNJbBBqGU06kwB5Pk2h3Qzy0KG6
 jBLbad/a8nzOVfvA5LkRTTxRAATGackADxLkXKW03ufEI6N3u88oPvAJRzYEelz3gr7f8kHORPZ
 Dttx8itFLpjgJgomchFIUnhqZLlEB6KrmNqr+9TXO3+zVDebdeJ1poy1hX9Y2pgLlJsM++6TYsX
 Wpy/qRYrXR8B8Y3iZVQ8hq3+JDbWwVgPuyq2cGMRTVAgvQwpe0z0RqbFZP5YOdasT63+mo+FRwd
 SD/YI2IaakIXl+Z82TU9ttpglNCbjA==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68fa47da cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=NZt1OnvTlnlKU9qwqt4A:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 3ZPRutJQ_P6E2ce5pkaA-v9HNpW7ILxR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

On s390 PCI busses are virtualized and the downstream ports are
invisible to the OS and self in struct pci_bus is NULL. This associated
struct pci_dev is however relied upon in pci_ari_enabled() to check
whether ARI is enabled for the bus. ARI is therefor always detected as
disabled. At the same time, firmware on s390 always enables and relies
upon ARI thus causing a mismatch.

Despite simply being a mismatch this causes problems as some PCI devices
present a different SR-IOV topology depending on PCI_SRIOV_CTRL_ARI.

A similar mismatch may occur with SR-IOV when virtfn_add_bus() creates new
busses with no associated struct pci_dev. Here too pci_ari_enabled()
on these busses returns false even if ARI is actually used.

Prevent both mismatches by moving the ari_enabled flag from struct
pci_dev to struct pci_bus making it independent from self in struct
pci_bus. Let the bus inherit the ari_enabled state from its parent bus
when there is no bridge device such that busses added by virtfn_add_bus()
match their parent. For s390 set ari_enabled when the device supports
ARI in the awareness that all PCIe ports on s390 systems are ARI
capable.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/s390/pci/pci.c     |  7 +++++++
 arch/s390/pci/pci_bus.c | 10 ++++++++++
 drivers/pci/pci.c       |  4 ++--
 drivers/pci/probe.c     |  1 +
 include/linux/pci.h     |  4 ++--
 5 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index c82c577db2bcd2143476cb8189fd89b9a4dc9836..773c0cbfc313ea1a6419a44d6158397dd13f6e76 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -609,6 +609,13 @@ int pcibios_device_add(struct pci_dev *pdev)
 			continue;
 		pci_claim_resource(pdev, i);
 	}
+	/*
+	 * The below is the s390 equivalent of pci_configure_ari()
+	 * which we can't use directly because the bridge devices
+	 * are hidden in firmware.
+	 */
+	if (!pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ARI))
+		zdev->zbus->bus->ari_enabled = 0;
 
 	return 0;
 }
diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
index 45a1c36c5a54e3a841e61cc365d3f36e9a94ba50..c887e61eb384ca98ff27d4f8af69e58c715b5002 100644
--- a/arch/s390/pci/pci_bus.c
+++ b/arch/s390/pci/pci_bus.c
@@ -207,6 +207,16 @@ static int zpci_bus_create_pci_bus(struct zpci_bus *zbus, struct zpci_dev *fr, s
 		return -EFAULT;
 	}
 
+	/*
+	 * On s390 PCI busses are virtualized and the bridge
+	 * devices are invisible to the OS. Furthermore busses
+	 * may exist without a devfn 0 function. Thus the normal
+	 * ARI detection does not work. At the same time fw/hw
+	 * has always enabled ARI when possible. Reflect the actual
+	 * state by setting ari_enabled whenever a device on the bus
+	 * supports it.
+	 */
+	bus->ari_enabled = 1;
 	zbus->bus = bus;
 
 	return 0;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b14dd064006cca80ec5275e45a35d6dc2b4d0bbc..8ef3c68280a629449e0a2176d938bf987c68dddf 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3532,11 +3532,11 @@ void pci_configure_ari(struct pci_dev *dev)
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI)) {
 		pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
 					 PCI_EXP_DEVCTL2_ARI);
-		bridge->ari_enabled = 1;
+		dev->bus->ari_enabled = 1;
 	} else {
 		pcie_capability_clear_word(bridge, PCI_EXP_DEVCTL2,
 					   PCI_EXP_DEVCTL2_ARI);
-		bridge->ari_enabled = 0;
+		dev->bus->ari_enabled = 0;
 	}
 }
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 13495b12fbcfae4b890bbd4b2f913742adf6dfed..338bb7e6738d27865e3d50aa3094ca5ab29a6a47 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1216,6 +1216,7 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 
 	if (!bridge) {
 		child->dev.parent = parent->bridge;
+		child->ari_enabled = parent->ari_enabled;
 		goto add_dev;
 	}
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d1fdf81fbe1e427aecbc951fa3fdf65c20450b05..a9c3dbf17339e523362bd179ad3c7c8c91293cf0 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -445,7 +445,6 @@ struct pci_dev {
 	unsigned int	irq_reroute_variant:2;	/* Needs IRQ rerouting variant */
 	unsigned int	msi_enabled:1;
 	unsigned int	msix_enabled:1;
-	unsigned int	ari_enabled:1;		/* ARI forwarding */
 	unsigned int	ats_enabled:1;		/* Address Translation Svc */
 	unsigned int	pasid_enabled:1;	/* Process Address Space ID */
 	unsigned int	pri_enabled:1;		/* Page Request Interface */
@@ -691,6 +690,7 @@ struct pci_bus {
 	unsigned int		is_added:1;
 	unsigned int		unsafe_warn:1;	/* warned about RW1C config write */
 	unsigned int		flit_mode:1;	/* Link in Flit mode */
+	unsigned int		ari_enabled:1;	/* ARI forwarding enabled */
 };
 
 #define to_pci_bus(n)	container_of(n, struct pci_bus, dev)
@@ -2740,7 +2740,7 @@ static inline bool pci_is_dev_assigned(struct pci_dev *pdev)
  */
 static inline bool pci_ari_enabled(struct pci_bus *bus)
 {
-	return bus->self && bus->self->ari_enabled;
+	return bus->ari_enabled;
 }
 
 /**

-- 
2.48.1


