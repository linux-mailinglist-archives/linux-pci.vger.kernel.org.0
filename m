Return-Path: <linux-pci+bounces-9501-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D17D591D953
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 09:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2CAA1C21ABE
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 07:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D2E76EEA;
	Mon,  1 Jul 2024 07:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T3PuyQYd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428BFC144;
	Mon,  1 Jul 2024 07:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719819966; cv=none; b=Kw1G8GpEzdnaK4xNw1tc8dz+SWGOKARSMpo7UMXisVa7chXYwwZ/yY6Uka1thPZbmS4vCK8ydsoR1ORkYewt7+9D/ON+pmkH9RDukagy2v/DpH36YEDvIcaKqBhvXWkhGfV/pgzc5XH1dHR4t2clDDl5YERsL4bllvD+wUQzh7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719819966; c=relaxed/simple;
	bh=eu+1hRloBkCtTsdD3c7EpT7vZuoZchofbkb1YLuh0Os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBtCrUR3TRWyEiP1hhzZGJ/1KaLIsW+JvOBqCPa+3WYD/UgBSVCI6dIREAtZEOa/xSO3rVbJl8iPLBT7zJ0zD0W1Pyf6umagTn83UCa3VlKHk1OJFu+0tOA6Qh4lEsYLvzqpMyoI+xBvxfp6nA9CZvw586fj78VWY1ylVw19Cac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T3PuyQYd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4616vKvY025560;
	Mon, 1 Jul 2024 07:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=/qWCb0RrNPuPW
	4UHecWAZj4MlZnWK893nVlQRpserAE=; b=T3PuyQYd7JyaAdKWu5Awb2qzGeULg
	zV/NIwZBi9JJeMuk/Zb8recslKhawKLuqTXE0LeWcT91B0S99ctMTqBefJ/ZNQUV
	UpRsQnN5mjR1D5/AYiu/+b1iPoU4AUuw4uqAO/1HJG/+XChq+qqNdFpAqUomVq9W
	hHrEyskf8zmKUJg/HqQIQXewhu0A6k68pmsjwHBLAKJ/M5Gkfpl5BeShyiSBggP2
	6YVVgldKm6V1FQj49r1Qz/KUasI33JPOLNG7qtVAn3uYg6mYmV+NqtOjQzsXzKjo
	VJ8NeID0BBeq0nEvI7tvqLX51jSS39mLsCroPuvmCPD4KP6aYO5RVtSOA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 403pb98auk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 07:45:50 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4617jnfU005813;
	Mon, 1 Jul 2024 07:45:49 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 403pb98auf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 07:45:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46151S8h030022;
	Mon, 1 Jul 2024 07:45:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 402x3mnxud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 07:45:48 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4617jhCF55771470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jul 2024 07:45:45 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 329982004B;
	Mon,  1 Jul 2024 07:45:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 073DD20040;
	Mon,  1 Jul 2024 07:45:40 +0000 (GMT)
Received: from li-a50b8fcc-3415-11b2-a85c-f1daa4f09788.in.ibm.com (unknown [9.109.241.85])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jul 2024 07:45:39 +0000 (GMT)
From: Krishna Kumar <krishnak@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, brking@linux.vnet.ibm.com,
        gbatra@linux.ibm.com, aneesh.kumar@kernel.org,
        christophe.leroy@csgroup.eu, nathanl@linux.ibm.com,
        bhelgaas@google.com, oohall@gmail.com, tpearson@raptorengineering.com,
        Krishna Kumar <krishnak@linux.ibm.com>,
        Shawn Anastasio <sanastasio@raptorengineering.com>
Subject: [PATCH v4 2/2] powerpc: hotplug driver bridge support
Date: Mon,  1 Jul 2024 13:15:07 +0530
Message-ID: <20240701074513.94873-3-krishnak@linux.ibm.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240701074513.94873-1-krishnak@linux.ibm.com>
References: <20240701074513.94873-1-krishnak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -uKa2DmjEIygamUOQFeGQEff9bnWi5xw
X-Proofpoint-ORIG-GUID: Eh40lHwqZYgl-C9qUFuzFyouUf-dJovG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_05,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010051

There is an issue with the hotplug operation when it's done on the
bridge/switch slot. The bridge-port and devices behind the bridge, which
become offline by hot-unplug operation, don't get hot-plugged/enabled by
doing hot-plug operation on that slot. Only the first port of the bridge
gets enabled and the remaining port/devices remain unplugged. The hot
plug/unplug operation is done by the hotplug driver
(drivers/pci/hotplug/pnv_php.c).

Root Cause Analysis: This behavior is due to missing code for the
switch/bridge. The existing driver depends on pci_hp_add_devices()
function for device enablement. This function calls pci_scan_slot() on
only one device-node/port of the bridge, not on all the siblings'
device-node/port.

The missing code needs to be added which will find all the sibling
device-nodes/bridge-ports and will run explicit pci_scan_slot() on
those.  A new function has been added for this purpose which gets
invoked from pci_hp_add_devices(). This new function
pci_traverse_sibling_nodes_and_scan_slot() gets all the sibling
bridge-ports by traversal and explicitly invokes pci_scan_slot on them.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gaurav Batra <gbatra@linux.ibm.com>
Cc: Nathan Lynch <nathanl@linux.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>

Tested-by: Shawn Anastasio <sanastasio@raptorengineering.com>
Signed-off-by: Krishna Kumar <krishnak@linux.ibm.com>
---
 arch/powerpc/include/asm/ppc-pci.h |  4 ++++
 arch/powerpc/kernel/pci-hotplug.c  |  5 ++---
 arch/powerpc/kernel/pci_dn.c       | 32 ++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index a8b7e8682f5b..83db8d0798ac 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -28,6 +28,10 @@ struct pci_dn;
 void *pci_traverse_device_nodes(struct device_node *start,
 				void *(*fn)(struct device_node *, void *),
 				void *data);
+
+void pci_traverse_sibling_nodes_and_scan_slot(struct device_node *start,
+					       struct pci_bus *bus);
+
 extern void pci_devs_phb_init_dynamic(struct pci_controller *phb);
 
 #if defined(CONFIG_IOMMU_API) && (defined(CONFIG_PPC_PSERIES) || \
diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index 0fe251c6ac2c..639a3d592fe2 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -106,7 +106,7 @@ EXPORT_SYMBOL_GPL(pci_hp_remove_devices);
  */
 void pci_hp_add_devices(struct pci_bus *bus)
 {
-	int slotno, mode, max;
+	int mode, max;
 	struct pci_dev *dev;
 	struct pci_controller *phb;
 	struct device_node *dn = pci_bus_to_OF_node(bus);
@@ -129,8 +129,7 @@ void pci_hp_add_devices(struct pci_bus *bus)
 		 * order for fully rescan all the way down to pick them up.
 		 * They can have been removed during partial hotplug.
 		 */
-		slotno = PCI_SLOT(PCI_DN(dn->child)->devfn);
-		pci_scan_slot(bus, PCI_DEVFN(slotno, 0));
+		pci_traverse_sibling_nodes_and_scan_slot(dn, bus);
 		max = bus->busn_res.start;
 		/*
 		 * Scan bridges that are already configured. We don't touch
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index 38561d6a2079..bea612759832 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -493,4 +493,36 @@ static void pci_dev_pdn_setup(struct pci_dev *pdev)
 	pdn = pci_get_pdn(pdev);
 	pdev->dev.archdata.pci_data = pdn;
 }
+
+void pci_traverse_sibling_nodes_and_scan_slot(struct device_node *start, struct pci_bus *bus)
+{
+	struct device_node *dn;
+	int slotno;
+
+	u32 class = 0;
+
+	if (!of_property_read_u32(start->child, "class-code", &class)) {
+		/* Call of pci_scan_slot for non-bridge/EP case */
+		if (!((class >> 8) == PCI_CLASS_BRIDGE_PCI)) {
+			slotno = PCI_SLOT(PCI_DN(start->child)->devfn);
+			pci_scan_slot(bus, PCI_DEVFN(slotno, 0));
+			return;
+		}
+	}
+
+	/* Iterate all siblings */
+	for_each_child_of_node(start, dn) {
+		class = 0;
+
+		if (!of_property_read_u32(start->child, "class-code", &class)) {
+			/* Call of pci_scan_slot on each sibling-nodes/bridge-ports */
+			if ((class >> 8) == PCI_CLASS_BRIDGE_PCI) {
+				slotno = PCI_SLOT(PCI_DN(dn)->devfn);
+				pci_scan_slot(bus, PCI_DEVFN(slotno, 0));
+			}
+		}
+	}
+
+}
+
 DECLARE_PCI_FIXUP_EARLY(PCI_ANY_ID, PCI_ANY_ID, pci_dev_pdn_setup);
-- 
2.45.0


