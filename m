Return-Path: <linux-pci+bounces-26097-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B7EA91D8C
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 15:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6556D461086
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 13:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE9B24503A;
	Thu, 17 Apr 2025 13:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cXek8yqo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D00E188734;
	Thu, 17 Apr 2025 13:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744895674; cv=none; b=CLbiPe5DKF/IhqtErvfNny8XQT9OYg/F6w/oltMXjowjmkjkrRrE0kLPeNYc68xna3r8RaxP1SF04baX6iVvrQ0BAN6nk4G33wkndMhZirijMv9HStCt15xeAzSWO0BH7WY6mymS9+x5miOmyxUk9fo7hN9P7eWP007t+4DocBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744895674; c=relaxed/simple;
	bh=40x2eLV3jcTqwrlXe8q5hHEYbXBwp+1NqmVFil0J82o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uDwyWhQhPhNn6+cp/p6fOes2eHS2PAVNlIi4ckBtGqcyVH15tHw8n86nh+AYfvPo//uE+SvKa9K+RnYS6Woh9hakamYPUBAxJor5NxKZHx7chp/WZyc74uA+iRPxDXeOzYwBD7CCqjF1e373BZxV7jLXnE+sFlorz4vW6A9tCG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cXek8yqo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H81oCs017994;
	Thu, 17 Apr 2025 13:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=H98eQpSOUYOYPXQrUldz2OVSdRKl
	NJX6iqkBh889lV0=; b=cXek8yqoMJbVPJ99a0GNtDf1QuhhIWUykbn87POu6M2b
	Nd0AjoEyumijxCMphA41NmUjmcdLDxAB2T/Wuo+i+7ykFIS9+ntqzF8TGtHaCUtz
	SiuSbbVhz3dnl1JDD+BtEmD0YvuFQjJf2uv7XftUWg1bmPbuDCpAYvVIhnstlMoI
	XQQ7hYYGrmOHDuD6rpkoQyHhc+uJFs01etB16pk9DkG1OajAeeIHkgJorxjfAtdO
	kwI6vdDNorRYAy0N0qwgiDxgUtAN+CIRb530wCmhAwbS2/tismMsw79q88MNO4pf
	KV+wNE7DjILbdd/ozhuhS6AMB6XcY8f7m04vn35/3g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462mhu3qv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 13:14:31 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53HDAPpO022405;
	Thu, 17 Apr 2025 13:14:30 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462mhu3qv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 13:14:30 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53HCqNPm024914;
	Thu, 17 Apr 2025 13:14:29 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4602gtp3eu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 13:14:29 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53HDESFd26477120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 13:14:29 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2CE15805C;
	Thu, 17 Apr 2025 13:14:28 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07AE358051;
	Thu, 17 Apr 2025 13:14:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Apr 2025 13:14:26 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Thu, 17 Apr 2025 15:14:17 +0200
Subject: [PATCH v3] PCI: s390: Handle ARI on bus without associated struct
 pci_dev
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-ari_no_bus_dev-v3-1-ba48f349aa47@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAKj+AGgC/2XMXQuCMBTG8a8Su26yHc25rvoeEeLLWR7IGVsOQ
 /zuTQkCu/w/8Pxm5tERenY+zMxhIE+DjZEeD6zpKntHTm1sBgIyoSDjlaPSDmU9+rLFwE9QQwX
 KpFmes3h6OjQ0beD1Frsj/xrce/ODXNcvlYo9FSSXXLUoVa5yow1eHmTHKaG6T5qhZysX4EdoW
 fwREIkibUyltRQFmD2xLMsHhOHjKfMAAAA=
X-Change-ID: 20240724-ari_no_bus_dev-52b2a27f3466
To: Bjorn Helgaas <bhelgaas@google.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Niklas Schnelle <schnelle@linux.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6135;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=40x2eLV3jcTqwrlXe8q5hHEYbXBwp+1NqmVFil0J82o=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDIY/q3mYVj3+bEzv0zwwRv5z70ZxO2C7zF1T7f5eOZMb
 W0Sh/vSjlIWBjEuBlkxRZZFXc5+6wqmmO4J6u+AmcPKBDKEgYtTACayUo6R4ardOc4pu4QVZrTo
 3YioF16yQHKTbpTG3LsyKQ+CX3GF2DD8M6r9d9T9w4nIXRO9/vNFfpX8xOLRWuBWnsJz40X3Tua
 rvAA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Hvd2G1TS c=1 sm=1 tr=0 ts=6800feb7 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=7lIdvI3MJxSJr0kkSecA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: XJhM3cgg2deettD8Jd7r6Ku03ja8O2o2
X-Proofpoint-GUID: kSsc2fac62z1fCFX02jkkdMK9DjSVu5f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_03,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170097

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
Changes in v3:
- Move setting of ari_enabled on s390 to bus creation and clear it in
  pcibios_add_device() if the capability is not available.
- Rebase on v6.15-rc2
- Link to v2: https://lore.kernel.org/r/20240918-ari_no_bus_dev-v2-1-83cfa991082f@linux.ibm.com

Changes in v2:
- Rebased on v6.11
- Link to v1: https://lore.kernel.org/r/20240730-ari_no_bus_dev-v1-1-7de17676f9fe@linux.ibm.com
---
 arch/s390/pci/pci.c     |  7 +++++++
 arch/s390/pci/pci_bus.c | 10 ++++++++++
 drivers/pci/pci.c       |  4 ++--
 drivers/pci/probe.c     |  1 +
 include/linux/pci.h     |  4 ++--
 5 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 5bbdc4190b8b8277c6aaea34274238c54988dbd5..959a021797c5944e1ff7b9ff761b285507935901 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -599,6 +599,13 @@ int pcibios_device_add(struct pci_dev *pdev)
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
index 81bdb54ad5e380eb65096066e5d7f87f5953d69c..33e78335c24c30e2ecc35b9df212fd139de1d048 100644
--- a/arch/s390/pci/pci_bus.c
+++ b/arch/s390/pci/pci_bus.c
@@ -208,6 +208,16 @@ static int zpci_bus_create_pci_bus(struct zpci_bus *zbus, struct zpci_dev *fr, s
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
index 4d7c9f64ea24ec754a135a2585c99489cfa641a9..179017423cfa23a7799cb02a46a42dd30684b8ef 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3571,11 +3571,11 @@ void pci_configure_ari(struct pci_dev *dev)
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
index 364fa2a514f8a68fb18bded3259c6847d3932f8b..58d0e420e2878153e50006321678f48b8ed23d4c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1198,6 +1198,7 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 
 	if (!bridge) {
 		child->dev.parent = parent->bridge;
+		child->ari_enabled = parent->ari_enabled;
 		goto add_dev;
 	}
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0e8e3fd77e96713054388bdc82f439e51023c1bf..6c1ac1715253fccc67ee2fcb1159ecf688e45ac7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -439,7 +439,6 @@ struct pci_dev {
 	unsigned int	irq_reroute_variant:2;	/* Needs IRQ rerouting variant */
 	unsigned int	msi_enabled:1;
 	unsigned int	msix_enabled:1;
-	unsigned int	ari_enabled:1;		/* ARI forwarding */
 	unsigned int	ats_enabled:1;		/* Address Translation Svc */
 	unsigned int	pasid_enabled:1;	/* Process Address Space ID */
 	unsigned int	pri_enabled:1;		/* Page Request Interface */
@@ -684,6 +683,7 @@ struct pci_bus {
 	unsigned int		is_added:1;
 	unsigned int		unsafe_warn:1;	/* warned about RW1C config write */
 	unsigned int		flit_mode:1;	/* Link in Flit mode */
+	unsigned int		ari_enabled:1;	/* ARI forwarding enabled */
 };
 
 #define to_pci_bus(n)	container_of(n, struct pci_bus, dev)
@@ -2663,7 +2663,7 @@ static inline bool pci_is_dev_assigned(struct pci_dev *pdev)
  */
 static inline bool pci_ari_enabled(struct pci_bus *bus)
 {
-	return bus->self && bus->self->ari_enabled;
+	return bus->ari_enabled;
 }
 
 /**

---
base-commit: 8ffd015db85fea3e15a77027fda6c02ced4d2444
change-id: 20240724-ari_no_bus_dev-52b2a27f3466

Best regards,
-- 
Niklas Schnelle


