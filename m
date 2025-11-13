Return-Path: <linux-pci+bounces-41165-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB40C598AF
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 19:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B7A64EE950
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 18:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB086312803;
	Thu, 13 Nov 2025 18:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SxYJUTJE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D04B30EF72;
	Thu, 13 Nov 2025 18:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763058920; cv=none; b=jNC7S32dYXq8gNs6J5iBsAiyyOrobzeiOaLWQQ/UQ7jDUM22+ZlgZ+2ikZ9L5prXPc9yZ1O3PQWm7P5oPEea8D5Sr4rcMiwz8itv17Wp7XujuqYrSZU/movnsVCYPifsaR83FpbY7NN6KrnRj47mgcpVTL8Fh2WGq9KiIJrEShg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763058920; c=relaxed/simple;
	bh=OjwFJU4XEu+jjadcPnoLfpDolY/08vlGTJJBjBV/cZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBuXWkfkhgNU+aejqCSkcdyPaR8dFFHIj7aS8fP0OVqzB08QXB31yrk2l9y4DD+vfaLU+uSo8KxIt5DpHwxHFcCRK4GkuX3MpwP4TpV9xxr/XOldtpT0yvrOnnfH0cC9ACpfmOwxMI8PjSKY4lC/qsW1PNAEArG7Gx2giEg3Jsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SxYJUTJE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADFc3Fg026220;
	Thu, 13 Nov 2025 18:35:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Hfww6ReBeh0MLjIma
	pA4hgc/56oCtvgmuGsrWA+Q4oM=; b=SxYJUTJEqG5UAJOagdcsiQcWkLRJAjkqU
	GU7XPANWfmz4sBzMz3se21bhn/HGhrRC4CbI+nOyJz5+jemwQ/jPTR3aMumTHCPY
	RSfytLGGomOa9u11bQTAi58LMty83HwpcwN1YVXeNrkaA3I5lqLH23cRY3uray2h
	mgM0xjezRj3CszDfEumuMYuxSrSbLMatxM09YKAg6XLaR4t/2J8YRTXmDd40PxaR
	3Xn/YY+fmquwVqA2AHPjARVWGPEi2gZFPlzVA/bm+YzdQpJjChwHYkggQaESNzq/
	eg+G732JQzGU+J8bVicveMs41ZOgqd+EZkprhtBuo/HpvLRHVzwQQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wk8hrcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 18:35:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADGG7Xn004748;
	Thu, 13 Nov 2025 18:35:11 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aagjy7jg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 18:35:11 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ADIZAcp18809422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 18:35:10 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 031D458053;
	Thu, 13 Nov 2025 18:35:10 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD35258043;
	Thu, 13 Nov 2025 18:35:08 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.243.9])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Nov 2025 18:35:08 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, alifm@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com
Subject: [PATCH v5 3/9] PCI: Avoid saving error values for config space
Date: Thu, 13 Nov 2025 10:34:56 -0800
Message-ID: <20251113183502.2388-4-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113183502.2388-1-alifm@linux.ibm.com>
References: <20251113183502.2388-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfXzz4IbydCVeQe
 wXjZCB3gHd1nOw0Q1cOcsdsBS5aOhbf5cT3/GBBdr2eF23tGAVRPPRDWPYsPB9GE79AageC/vte
 kP3F1IZe3g3YzcYzhCbsbv8IFsYZo3Tnmk/jSrdJ1Cli0QaASBR6HCHFdpG3xSRq2wjHjnBJrFJ
 d8ZHVJarhIum4+c8cnoU5uUF385C+oqzHMxiKv2I6HuiKujMSjTnlTvvrofr2Dqs1B9caIvhmNl
 gYEwYAyak9ieAGdz92S0n80/4RkjqmXFzd3Dj7xmppAvynIBgZ1fIZ7cpgcxAja4mvm8427b27m
 sYl6HxDwWE5bEz0PUfy7BCz4/FsVBwgZC0JjBfrsYWV1FTz/R30l8W7TDg9vU86aaOZlF9eSO4l
 XfCGfYANNb6Ii+axBxfckOXBYleVvQ==
X-Authority-Analysis: v=2.4 cv=ZK3aWH7b c=1 sm=1 tr=0 ts=691624e1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=HJkUYhVlXSnv9HZcNckA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 8-fReZAzzpboQCGInUCuwfFQVnJQ1rHK
X-Proofpoint-GUID: 8-fReZAzzpboQCGInUCuwfFQVnJQ1rHK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_03,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022

The current reset process saves the device's config space state before
reset and restores it afterward. However, when a device is in an error
state before reset, config space reads may return error values instead of
valid data. This results in saving corrupted values that get written back
to the device during state restoration.

Avoid saving the state of the config space when the device is in error.
While restoring we only restore the state that can be restored through
kernel data such as BARs or doesn't depend on the saved state.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/pci/pci.c      | 25 ++++++++++++++++++++++---
 drivers/pci/pcie/aer.c |  3 +++
 drivers/pci/pcie/dpc.c |  3 +++
 drivers/pci/pcie/ptm.c |  3 +++
 drivers/pci/tph.c      |  3 +++
 drivers/pci/vc.c       |  3 +++
 6 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 36ee38e0d817..3a9a283b5be9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1669,6 +1669,9 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
 	struct pci_cap_saved_state *save_state;
 	u16 *cap;
 
+	if (!dev->state_saved)
+		return;
+
 	/*
 	 * Restore max latencies (in the LTR capability) before enabling
 	 * LTR itself in PCI_EXP_DEVCTL2.
@@ -1724,6 +1727,9 @@ static void pci_restore_pcix_state(struct pci_dev *dev)
 	struct pci_cap_saved_state *save_state;
 	u16 *cap;
 
+	if (!dev->state_saved)
+		return;
+
 	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_PCIX);
 	pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
 	if (!save_state || !pos)
@@ -1741,6 +1747,14 @@ static void pci_restore_pcix_state(struct pci_dev *dev)
 int pci_save_state(struct pci_dev *dev)
 {
 	int i;
+	u32 val;
+
+	pci_read_config_dword(dev, PCI_COMMAND, &val);
+	if (PCI_POSSIBLE_ERROR(val)) {
+		pci_warn(dev, "Device config space inaccessible, will only be partially restored\n");
+		return -EIO;
+	}
+
 	/* XXX: 100% dword access ok here? */
 	for (i = 0; i < 16; i++) {
 		pci_read_config_dword(dev, i * 4, &dev->saved_config_space[i]);
@@ -1803,6 +1817,14 @@ static void pci_restore_config_space_range(struct pci_dev *pdev,
 
 static void pci_restore_config_space(struct pci_dev *pdev)
 {
+	if (!pdev->state_saved) {
+		pci_warn(pdev, "No saved config space, restoring BARs\n");
+		pci_restore_bars(pdev);
+		pci_write_config_word(pdev, PCI_COMMAND,
+				PCI_COMMAND_MEMORY | PCI_COMMAND_IO);
+		return;
+	}
+
 	if (pdev->hdr_type == PCI_HEADER_TYPE_NORMAL) {
 		pci_restore_config_space_range(pdev, 10, 15, 0, false);
 		/* Restore BARs before the command register. */
@@ -1855,9 +1877,6 @@ static void pci_restore_rebar_state(struct pci_dev *pdev)
  */
 void pci_restore_state(struct pci_dev *dev)
 {
-	if (!dev->state_saved)
-		return;
-
 	pci_restore_pcie_state(dev);
 	pci_restore_pasid_state(dev);
 	pci_restore_pri_state(dev);
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 0b5ed4722ac3..9a898089f984 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -371,6 +371,9 @@ void pci_restore_aer_state(struct pci_dev *dev)
 	if (!aer)
 		return;
 
+	if (!dev->state_saved)
+		return;
+
 	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ERR);
 	if (!save_state)
 		return;
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index fc18349614d7..e0d7034c2cd8 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -67,6 +67,9 @@ void pci_restore_dpc_state(struct pci_dev *dev)
 	if (!pci_is_pcie(dev))
 		return;
 
+	if (!dev->state_saved)
+		return;
+
 	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_DPC);
 	if (!save_state)
 		return;
diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 65e4b008be00..78613000acfb 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -112,6 +112,9 @@ void pci_restore_ptm_state(struct pci_dev *dev)
 	if (!ptm)
 		return;
 
+	if (!dev->state_saved)
+		return;
+
 	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_PTM);
 	if (!save_state)
 		return;
diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index cc64f93709a4..c0fa1b9a7a78 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -435,6 +435,9 @@ void pci_restore_tph_state(struct pci_dev *pdev)
 	if (!pdev->tph_enabled)
 		return;
 
+	if (!pdev->state_saved)
+		return;
+
 	save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_TPH);
 	if (!save_state)
 		return;
diff --git a/drivers/pci/vc.c b/drivers/pci/vc.c
index a4ff7f5f66dd..00609c7e032a 100644
--- a/drivers/pci/vc.c
+++ b/drivers/pci/vc.c
@@ -391,6 +391,9 @@ void pci_restore_vc_state(struct pci_dev *dev)
 {
 	int i;
 
+	if (!dev->state_saved)
+		return;
+
 	for (i = 0; i < ARRAY_SIZE(vc_caps); i++) {
 		int pos;
 		struct pci_cap_saved_state *save_state;
-- 
2.43.0


