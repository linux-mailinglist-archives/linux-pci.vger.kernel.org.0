Return-Path: <linux-pci+bounces-39625-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47914C1979F
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 10:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99A0A461265
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 09:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E06C330B18;
	Wed, 29 Oct 2025 09:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tsFNGwgP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBF6330D27;
	Wed, 29 Oct 2025 09:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730939; cv=none; b=b9JMyAk5EjgXP/Vhe/fh7cxIQByuCBzb98H64NwClR6JCecEBUxVOMRDtZ2FjCa2g/OclsKJvTMVtlwh4dvPm30tVgBkRJRFJVGh+NMmnW0jPPqaDexHEYQ853s7nXe67+YnKJ4oOTmei1ncTTzMb52gWBevfWE7GlkC4MyKaJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730939; c=relaxed/simple;
	bh=ei4AVSTiMTWOo2764Fe34I0FDbcBcV7ctbcxvqyHbiM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ue5g3R1v9Afukp+8ybuJyORK/F31J6amxngHHE26qb62XZtDhbMgmOHh7Jl8zVXam2VrIXRbkEpH54zcCfF8poDl6N9SgGAmLmGQitNaqLtdPgF0A4onA5RtxTAyfS+VLzJgifL+AZVqWQTli/YVlu5eZyo+3xMYaWqETPS+RJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tsFNGwgP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SJmKa3019586;
	Wed, 29 Oct 2025 09:41:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=51F1KP
	X2GaNeDDDtEnKMSmu/zB48xYsKZ7OyK4P3FQY=; b=tsFNGwgPUaWkd957rNSR/u
	+JYSd/XvQMv9FnZInqtDgREwmubpyFc5tRSXD+tnh0DH39Ny9/sBuEWxujf6H38L
	F28E51ALCa0LMGSavm46nm4c2a4jFkQnGZ+1BG/OIgYCkHtrwWr0+wkIfcKm52vA
	DKgh5c0GahAkYTOVr8DdiAvqewCJ9XW8WDwQJLfm0gufR7LDMvgpeesDEWhs0zkd
	3ki6265KvHlP76gce5WkGeA5wEVe+vbja+drHpkd5qqHKjbzg1pa5cqT6L1urijl
	wnqabhIxS+37071n66qQk0Tba0xAF4qtTRByZkL0Ol7LPS9KwOkRaTf+2LaFzw6g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34agjdyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 09:41:56 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59T9W7YP002955;
	Wed, 29 Oct 2025 09:41:55 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34agjdy9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 09:41:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59T5E6iu027495;
	Wed, 29 Oct 2025 09:41:54 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a33w2jkqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 09:41:54 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59T9frV631916732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 09:41:53 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E0AE58052;
	Wed, 29 Oct 2025 09:41:53 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A21658056;
	Wed, 29 Oct 2025 09:41:51 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Oct 2025 09:41:51 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Wed, 29 Oct 2025 10:41:32 +0100
Subject: [PATCH v5 2/2] PCI: s390: Handle ARI on bus without associated
 struct pci_dev
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-ari_no_bus_dev-v5-2-d9a5eab67ed0@linux.ibm.com>
References: <20251029-ari_no_bus_dev-v5-0-d9a5eab67ed0@linux.ibm.com>
In-Reply-To: <20251029-ari_no_bus_dev-v5-0-d9a5eab67ed0@linux.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Huacai Chen <chenhuacai@kernel.org>,
        Bibo Mao <maobibo@loongson.cn>,
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
        Niklas Schnelle <schnelle@linux.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5163;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=ei4AVSTiMTWOo2764Fe34I0FDbcBcV7ctbcxvqyHbiM=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDIZH0aeO/jzV/sb4y2zrPVuFspx7P7ZtfZ6AMvBs2+EH
 VLMOoR3dpSyMIhxMciKKbIs6nL2W1cwxXRPUH8HzBxWJpAhDFycAjCRqdYMf4XTX+i2bJT8UlG3
 TnxNzLl4wcNBOUpnv584eDijqnLxkz+MDG1VXTrH115deajq5x2O/Tr34wO/9N950r/7VnGg3qt
 FR9kB
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=K+gv3iWI c=1 sm=1 tr=0 ts=6901e164 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=NZt1OnvTlnlKU9qwqt4A:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: F81w5a-q_A82GzZG431alqBGvXqZe0Wb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX7nX5f9EiYWlK
 7T3M6ZmYpaMXdGyr0oXSmdTJQ881Cgjci9HNY1WcC3l7moDqZgu1KZCN006tqEgl6h6eu5bJR3u
 ANCSANjFZvRj7gxvvMNOs+QM3XWJXeZ+5g6yUUYdcHCU/1ZyslhpqJEH7xL+YWAd95UODeloX6T
 QEOgip/ipSVbBP4YLPsM0AoKNtaoU8101QUdB6qfuDCzO5nEsg2yCKf0aAvdqsSUOoinSIhBRgu
 uyX06su+wXgMwJTwW6lJiMz8nlGAH71SwGDSBGB3iL7lFfDudU5nS6QN4TYSNR2YxeK76znHePR
 z2o5YBvXwukQj5fgyqeaP+KtR6uK09sa7SORarmlYDgI58XeDIHmwbyWeOuSG4eQqQvDQUA22Jz
 6zumN4tTDjHBoCumV51houpzWGHACg==
X-Proofpoint-GUID: SydpWizy2eNmQYSkNRnQjAuU8oeOREV5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166

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
index 41dd1a339a994956a6bc7e1fea0fe0d55452a963..6fc03328a62f54f33f47309f8300516e8f52b5eb 100644
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


