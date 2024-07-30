Return-Path: <linux-pci+bounces-11028-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E0C9420B3
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 21:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D141F24A74
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 19:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D86EE573;
	Tue, 30 Jul 2024 19:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ApP33fVq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FD118C929;
	Tue, 30 Jul 2024 19:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722368263; cv=none; b=OmYqwS5xIRVDSrPz0xi9x+6bemfksHysOLEmye1zO1I4QPfUVf8gg5uv4ODuWgiM2XlPf9HFlb5vl2bGrnblJbDcZBf0Y1MRVku7KEKgca98Al4WHFDx0sUDEvlBsfGur2TLAhf6GpWwJJ08u6WUTX1Ulz/ed+yrI/E+7k6HBhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722368263; c=relaxed/simple;
	bh=AQv81VS2n0iUhhHV8iHEHEEgAw+UGN8rcvOnEWa3toE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NEa0l8JopndZETTYB7DOwdW19TSEA9WSXwPwhzizgk/WutPctPnR9UendOx7Z5Do/TFl+CebFicwmThPSyJXpTJBp2Z90mT7O2D0cCFLEQHXKLoj8CUYrH5heNuwHsFke/+splBBgu1OzjJM08QtH1JoyL4tUl8HJCmtQjP96WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ApP33fVq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46UJQ70E024213;
	Tue, 30 Jul 2024 19:37:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=pp1; bh=NVBgT24ES
	BEghOnA27nAQunnYxMgVrnzD4SwG2kB8kI=; b=ApP33fVqMI5OfydAnD9oRKJ1R
	9XiX1vvnAMlGJozsi5sfya4Bfi207LzxKNLCdw9rbwwMSwPbi+rWwwyWgb1jfuVb
	7s4CNp/TXcEJS9AMvCo9zVjXVmamfOpM/fu/tryjeaixwsoJYhMjUFkQ+Hkyg5Xn
	v6ixXDimIJVInL9Chr6k8YNeqMZA5vFvM5kwC74pRSjB8rhycMsMlRQNr/mDlyBC
	ca3sKVI5g2lA82jDLfFgLTMq1JdilTHqxQ1H4Z140GN5nkJH43P5GaiYMht1oVp8
	Z7TOngORvy7WoLIIOQFfQeigIcfT8lRtpzz+Meb7TWXGVCrzgJT80uyQmp7Tw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40q1398x07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 19:37:39 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46UJbcE2009880;
	Tue, 30 Jul 2024 19:37:38 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40q1398x05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 19:37:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46UHCtTx018770;
	Tue, 30 Jul 2024 19:37:37 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nc7ppsag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 19:37:37 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46UJbYE357278758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jul 2024 19:37:36 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 767455805B;
	Tue, 30 Jul 2024 19:37:34 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F71C58058;
	Tue, 30 Jul 2024 19:37:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jul 2024 19:37:32 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Tue, 30 Jul 2024 21:36:59 +0200
Subject: [PATCH] PCI: s390: Handle ARI on bus without associated struct
 pci_dev
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-ari_no_bus_dev-v1-1-7de17676f9fe@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIANpAqWYC/x3MQQqAIBBA0avErBNqMoOuEiFaY81GQ0mC8O5Jy
 7f4/4VEkSnB3LwQKXPi4Cv6toHtNP4gwXs1YIeym1AKE1n7oO2d9E5ZjGjR4OQGqRTU6Irk+Pm
 Hy1rKB6CrN/lgAAAA
To: Bjorn Helgaas <bhelgaas@google.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Niklas Schnelle <schnelle@linux.ibm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4985;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=AQv81VS2n0iUhhHV8iHEHEEgAw+UGN8rcvOnEWa3toE=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGNJWOnzttdxvfqU4cDdLUGn407/bf555K5ublW4c9cdUd
 3a6fw1bRykLgxgXg6yYIsuiLme/dQVTTPcE9XfAzGFlAhnCwMUpABMJK2T4px952kX44at7WbJS
 ert2Wl6yyPT47Xv+jPjf/oPCB1frSjAyfHm98orfTYcGhpt6EXxJJ65XhPwoOsfYeMpm3SSm3L9
 irAA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HodmME3nG9shiu-GQaj8KslF4aMa4WJk
X-Proofpoint-ORIG-GUID: E76WRegYJ5osJwOWLwstE0GOciLpSWad
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_15,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 clxscore=1011 suspectscore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407300134

On s390 PCI busses are virtualized and the downstream ports are
invisible to the OS and struct pci_bus::self is NULL. This associated
struct pci_dev is however relied upon in pci_ari_enabled() to check
whether ARI is enabled for the bus. ARI is therefor always detected as
disabled.

At the same time firmware on s390 always enables and relies upon ARI
thus causing a mismatch. Moreover with per-PCI function pass-through
there may exist busses with no function with devfn 0. For example
a SR-IOV capable device with two PFs may have separate function
dependency link chains for each of the PFs and their child VFs. In this
case the OS may only see the second PF and its child VFs on a bus
without a devfn 0 function. A situation which is also not supported by
the common pci_configure_ari() code.

Dispite simply being a mismatch this causes problems as some PCI devices
present a different SR-IOV topology depending on PCI_SRIOV_CTRL_ARI.

A similar mismatch may occur with SR-IOV when virtfn_add_bus() creates new
busses with no associated struct pci_dev. Here too pci_ari_enabled()
on these busses would return false even if ARI is actually used.

Prevent both mismatches by moving the ari_enabled flag from struct
pci_dev to struct pci_bus making it independent from struct pci_bus::
self. Let the bus inherit the ari_enabled state from its parent bus when
there is no bridge device such that busses added by virtfn_add_bus()
match their parent. For s390 set ari_enabled when the device supports
ARI in the awareness that all PCIe ports on s390 systems are ARI
capable.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/s390/pci/pci_bus.c | 12 ++++++++++++
 drivers/pci/pci.c       |  4 ++--
 drivers/pci/probe.c     |  1 +
 include/linux/pci.h     |  4 ++--
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
index daa5d7450c7d..021319438dad 100644
--- a/arch/s390/pci/pci_bus.c
+++ b/arch/s390/pci/pci_bus.c
@@ -278,6 +278,18 @@ void pcibios_bus_add_device(struct pci_dev *pdev)
 {
 	struct zpci_dev *zdev = to_zpci(pdev);
 
+	/*
+	 * On s390 PCI busses are virtualized and the bridge
+	 * devices are invisible to the OS. Furthermore busses
+	 * may exist without a devfn 0 function. Thus the normal
+	 * ARI detection does not work. At the same time fw/hw
+	 * has always enabled ARI when possible. Reflect the actual
+	 * state by setting ari_enabled whenever a device on the bus
+	 * supports it.
+	 */
+	if (pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ARI))
+		zdev->zbus->bus->ari_enabled = 1;
+
 	/*
 	 * With pdev->no_vf_scan the common PCI probing code does not
 	 * perform PF/VF linking.
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e3a49f66982d..2a362d26e3e5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3537,11 +3537,11 @@ void pci_configure_ari(struct pci_dev *dev)
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
index b14b9876c030..c318929438c1 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1143,6 +1143,7 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 
 	if (!bridge) {
 		child->dev.parent = parent->bridge;
+		child->ari_enabled = parent->ari_enabled;
 		goto add_dev;
 	}
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4cf89a4b4cbc..3d1f4a392dd6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -429,7 +429,6 @@ struct pci_dev {
 	unsigned int	irq_reroute_variant:2;	/* Needs IRQ rerouting variant */
 	unsigned int	msi_enabled:1;
 	unsigned int	msix_enabled:1;
-	unsigned int	ari_enabled:1;		/* ARI forwarding */
 	unsigned int	ats_enabled:1;		/* Address Translation Svc */
 	unsigned int	pasid_enabled:1;	/* Process Address Space ID */
 	unsigned int	pri_enabled:1;		/* Page Request Interface */
@@ -679,6 +678,7 @@ struct pci_bus {
 	struct bin_attribute	*legacy_mem;	/* Legacy mem */
 	unsigned int		is_added:1;
 	unsigned int		unsafe_warn:1;	/* warned about RW1C config write */
+	unsigned int		ari_enabled:1;	/* ARI forwarding enabled */
 };
 
 #define to_pci_bus(n)	container_of(n, struct pci_bus, dev)
@@ -2637,7 +2637,7 @@ static inline bool pci_is_dev_assigned(struct pci_dev *pdev)
  */
 static inline bool pci_ari_enabled(struct pci_bus *bus)
 {
-	return bus->self && bus->self->ari_enabled;
+	return bus->ari_enabled;
 }
 
 /**

---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240724-ari_no_bus_dev-52b2a27f3466

Best regards,
-- 
Niklas Schnelle


