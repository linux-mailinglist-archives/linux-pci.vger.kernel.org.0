Return-Path: <linux-pci+bounces-44652-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0D5D1A8EE
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 18:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 490C93055E24
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 17:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410B734FF75;
	Tue, 13 Jan 2026 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h08WljrC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8589634D4E4;
	Tue, 13 Jan 2026 17:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768324539; cv=none; b=KXxOy/SNkerbdtgvQE+mWVIC7PM2uuUCiHa832ehuRImL/Lx1cJQWOlWDAHha0myiYVMkfluTrcWeJ/gA6KV0t+UzjJI9g6jAT6XYInnfCEnj2wdDvJ6VK5mH3nzWm/RwJjePMx7F05QTuq+EbiviAupa+EtQfb5E7XZZdXazV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768324539; c=relaxed/simple;
	bh=5kjRjbxM25SfBe8whMIszr5cqtDNMaDeUolxYSD4yVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sfg/grKTtUPc2Aew2U4fZAvpw+fRB7s8iCAGbFuHkJJeTHyIIZH4JGHGl73fZN6CpIOSqTPPYYrAGbq/m0wQgq78UVMKKkp/vMdaicusqL3hc00N3zcMXwtvRlutpZysHHfrJeMf33rSsMTxGxe23VNmdppKeFl0Gc/iMndWBA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h08WljrC; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60DG0llC2418953;
	Tue, 13 Jan 2026 17:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=sOwxc0j/K2KiweBK
	5bUMyb1biqk8k/OttlqbYvlZ54s=; b=h08WljrCG2lZ9eq1TGN3FIaBFiJpSOFV
	8pwufsyuUL5+S5laPSaefxikNMFbfxMWk23sikqbU53Op/N8Aiqhn+YRKNImsQlk
	59zoSgAeBaWw6gkASDV5FD2mu08zcde+CpjPV6PVYY043G6wE21Ai6o1TRXb4lH7
	FYz3CN93tJK+StHLwetGxy+JLQjAuhhQ6MxZBSMxKZ6Z3VTfvNkEzvSiye2yeudH
	jKd3X5x9U9F81HcjIyQ2d90d1cFLgRKZ7ekdygPrpVfsPsLKrwYkhcF9CSTulp9X
	wqiMplLggkQVjy7u8ScR9hVwrW5pNJhEGHYXGq744bEP4pvSoKKRbQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkre3uu04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 17:15:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60DFllRJ004522;
	Tue, 13 Jan 2026 17:15:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd78yfyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 17:15:26 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60DHFP0v033475;
	Tue, 13 Jan 2026 17:15:25 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4bkd78yfwd-1;
	Tue, 13 Jan 2026 17:15:25 +0000
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/ACPI: Confine program_hpx_type2 to the AER bits
Date: Tue, 13 Jan 2026 18:15:20 +0100
Message-ID: <20260113171522.3446407-1-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_04,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601130144
X-Proofpoint-ORIG-GUID: 6tYubRi1b2uYOr6BuduKNDOcCzX90x4P
X-Authority-Analysis: v=2.4 cv=YKOSCBGx c=1 sm=1 tr=0 ts=69667daf cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=4OF2stnPnCnJDZRIKM8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDE0MyBTYWx0ZWRfX67cRX88Et4Zi
 yNQeui5xGdmQsw+7lPvCWomV7Z3wGzkjF3JPAZoBDZ470sYg3lEUUDiR04LwphuReHdynWroVx0
 HWL81WYfPiO+WTUg/bLZ0iunPb/pNxIbY8OT7nmqEzUK10QuaP/+MkNuUAe3Oxcb1IZ6eUAPIeR
 hlo2FcLCHFdK6GrhwdhWuI64Wh7B7BSk4yOgzS7mtIDqonVad6feEzo6m/YjZlZtmgc0sNSnW1M
 6pSaPv0JnIPPZheXMhs6nGzPKEyfRNPfXsGPb+fiMeBPUP9bHnWVgWURBtRmhsJTjXkKOxEvGHh
 kdRYVHQcbFh3quAA50xEv+yJeP0/xQmrS4O0rb29BP39Dt9J6EYqnqHATAzsCtri2X5jSTkDOsj
 f6kYkSJNDVx2UexJFYdelIW61QJxXP2lSSw1UTgCe4tj1WVEWi+hRrnNFjXuYq0tqrRXiQ/19BD
 42I5PqR27sHkUeYoAPA==
X-Proofpoint-GUID: 6tYubRi1b2uYOr6BuduKNDOcCzX90x4P

program_hpx_type2() is today unconditionally called, despite the fact
that when the _HPX was added to the ACPI spec. v3.0, the description
stated:

 OSPM [1] will only evaluate _HPX with Setting Record – Type 2 if OSPM
 is not controlling the PCI Express Advanced Error Reporting
 capability.

Hence, we only call program_hpx_type2() when the OSPM owns the PCIe
hotplug capability but not the AER.

The Advanced Configuration and Power Interface (ACPI) Specification
version 6.6 has a provision that gives the OSPM the ability to control
the other PCIe Device Control bits any way. In a note in section
6.2.9, it is stated:

"OSPM may override the settings provided by the _HPX object's Type2
record (PCI Express Settings) or Type3 record (PCI Express Descriptor
Settings) when OSPM has assumed native control of the corresponding
feature."

So, in order to preserve the non-AER bits in PCIe Device Control, in
particular the performance sensitive ExtTag and RO, we make sure
program_hpx_type2() if called, doesn't modify any non-AER bits.

Also, when program_hpx_type2() is called, and any bits in the PCIe
Link Control register is set, we log a warning.

[1] Operating System-directed configuration and Power Management

Fixes: 40abb96c51bb ("[PATCH] pciehp: Fix programming hotplug parameters")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 drivers/pci/pci-acpi.c | 71 ++++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 9369377725fa0..f36b51f6721a6 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -271,21 +271,6 @@ static acpi_status decode_type1_hpx_record(union acpi_object *record,
 	return AE_OK;
 }
 
-static bool pcie_root_rcb_set(struct pci_dev *dev)
-{
-	struct pci_dev *rp = pcie_find_root_port(dev);
-	u16 lnkctl;
-
-	if (!rp)
-		return false;
-
-	pcie_capability_read_word(rp, PCI_EXP_LNKCTL, &lnkctl);
-	if (lnkctl & PCI_EXP_LNKCTL_RCB)
-		return true;
-
-	return false;
-}
-
 /* _HPX PCI Express Setting Record (Type 2) */
 struct hpx_type2 {
 	u32 revision;
@@ -311,6 +296,7 @@ static void program_hpx_type2(struct pci_dev *dev, struct hpx_type2 *hpx)
 {
 	int pos;
 	u32 reg32;
+	const struct pci_host_bridge *host;
 
 	if (!hpx)
 		return;
@@ -318,40 +304,57 @@ static void program_hpx_type2(struct pci_dev *dev, struct hpx_type2 *hpx)
 	if (!pci_is_pcie(dev))
 		return;
 
+	host = pci_find_host_bridge(dev->bus);
+
+	/* We only do the HP programming if we own the PCIe native
+	 * hotplug and not the AER ownership
+	 */
+	if (!host->native_pcie_hotplug || host->native_aer)
+		return;
+
 	if (hpx->revision > 1) {
 		pci_warn(dev, "PCIe settings rev %d not supported\n",
 			 hpx->revision);
 		return;
 	}
 
-	/*
-	 * Don't allow _HPX to change MPS or MRRS settings.  We manage
-	 * those to make sure they're consistent with the rest of the
+	/* We only allow _HPX to program the AER registers, namely
+	 * PCI_EXP_DEVCTL_CERE, PCI_EXP_DEVCTL_NFERE,
+	 * PCI_EXP_DEVCTL_FERE, and PCI_EXP_DEVCTL_URRE.
+	 *
+	 * The other settings in PCIe DEVCTL are managed by OS in
+	 * order to make sure they're consistent with the rest of the
 	 * platform.
 	 */
-	hpx->pci_exp_devctl_and |= PCI_EXP_DEVCTL_PAYLOAD |
-				    PCI_EXP_DEVCTL_READRQ;
-	hpx->pci_exp_devctl_or &= ~(PCI_EXP_DEVCTL_PAYLOAD |
-				    PCI_EXP_DEVCTL_READRQ);
+	hpx->pci_exp_devctl_and |= PCI_EXP_DEVCTL_RELAX_EN   |
+				   PCI_EXP_DEVCTL_PAYLOAD    |
+				   PCI_EXP_DEVCTL_EXT_TAG    |
+				   PCI_EXP_DEVCTL_PHANTOM    |
+				   PCI_EXP_DEVCTL_AUX_PME    |
+				   PCI_EXP_DEVCTL_NOSNOOP_EN |
+				   PCI_EXP_DEVCTL_READRQ     |
+				   PCI_EXP_DEVCTL_BCR_FLR;
+	hpx->pci_exp_devctl_or &= ~(PCI_EXP_DEVCTL_RELAX_EN   |
+				    PCI_EXP_DEVCTL_PAYLOAD    |
+				    PCI_EXP_DEVCTL_EXT_TAG    |
+				    PCI_EXP_DEVCTL_PHANTOM    |
+				    PCI_EXP_DEVCTL_AUX_PME    |
+				    PCI_EXP_DEVCTL_NOSNOOP_EN |
+				    PCI_EXP_DEVCTL_READRQ     |
+				    PCI_EXP_DEVCTL_BCR_FLR);
 
 	/* Initialize Device Control Register */
 	pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
 			~hpx->pci_exp_devctl_and, hpx->pci_exp_devctl_or);
 
-	/* Initialize Link Control Register */
+	/* Log the Link Control Register if any bits are set */
 	if (pcie_cap_has_lnkctl(dev)) {
+		u16 lnkctl;
 
-		/*
-		 * If the Root Port supports Read Completion Boundary of
-		 * 128, set RCB to 128.  Otherwise, clear it.
-		 */
-		hpx->pci_exp_lnkctl_and |= PCI_EXP_LNKCTL_RCB;
-		hpx->pci_exp_lnkctl_or &= ~PCI_EXP_LNKCTL_RCB;
-		if (pcie_root_rcb_set(dev))
-			hpx->pci_exp_lnkctl_or |= PCI_EXP_LNKCTL_RCB;
-
-		pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
-			~hpx->pci_exp_lnkctl_and, hpx->pci_exp_lnkctl_or);
+		pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnkctl);
+		if (lnkctl)
+			pci_warn(dev, "Some bits in PCIe Link Control are set: 0x%04x\n",
+				 lnkctl);
 	}
 
 	/* Find Advanced Error Reporting Enhanced Capability */
-- 
2.43.5


