Return-Path: <linux-pci+bounces-8560-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43724902B49
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 00:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CA77281E6C
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 22:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C607E12F5B6;
	Mon, 10 Jun 2024 22:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Li+mCgYS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0023837143
	for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 22:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718057027; cv=none; b=ebO2g9uwArfzGJVhZ/8x5YYZ6Bb7v3AcfFUeu6B/h0Q7C6DztvkZECY2gVWFZpQCh2RIxS40SHZcIbf5l5VTZD5N5Hdt0bvOWg2YJ2tb/u/TjT9Khga7myuKSB4VFirkS7PjMoc1mUFT0UIx0UfDFqRjReJIrFosXSWWOMKKfng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718057027; c=relaxed/simple;
	bh=L+zZKuCcGwI32IOPSDMsMsLvX5Gv5ZU2g6RQvbK5xNA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XONa08TGrdwGb/U9QOK/s3o00v75PWXuf5LXmZ+tohXudkODDCmyh5eaSoqkUlPcPWYvWpPvRAUJ2aGEgnc4JNZ9JtsHSNqwxG+zysgCgYOdhWyRv+rR3gxsBSKfhLyRR+Se+lI/k6Gb9i5U6kCvmqlbQISALgGYONMV6M88/e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Li+mCgYS; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 45AL1KG7013339
	for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 15:03:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=s2048-2021-q4;
 bh=nzEdwbAUCrgMS0glMB2xoeRxisYbMfVjm+Hv5a2Efdk=;
 b=Li+mCgYSntTQYUECs1Vh0xky2gKmKIt2z2eo74HWIToSJQE6BypJHd9w+0AX7HeYL3mg
 OWeAg09S+UcceWBLHWu2PzPjSf+athqdWu4PV0/rWmphTW+EffhrZYKlcbvEh1nwhBiW
 oGN7pQ9ZDf6MQYF7irPD8bofbDDSRihK9rRRJBb3EBEckJKhNWZud2s268vYXQKD0ILn
 3aBHq6umTXfQ+tbn7+icPa7NOEj34TEIc/OayWe0elN/yccewg9pO6zU7ybB44A1RxQP
 ouIUghe68tC0Z368VFrSXGENMyfGft9B+uapSkOThsJGDZVWYWAGfrnc3zyUXYxc6V5/ yg== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3ymjywc43c-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 15:03:44 -0700
Received: from twshared3549.07.ash9.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Mon, 10 Jun 2024 22:03:43 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id D88CDF4E2359; Mon, 10 Jun 2024 15:03:34 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <lukas@wunner.de>, <bhelgaas@google.com>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/2] PCI: err: ensure stable topology during handling
Date: Mon, 10 Jun 2024 15:03:03 -0700
Message-ID: <20240610220304.3162895-3-kbusch@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240610220304.3162895-1-kbusch@meta.com>
References: <20240610220304.3162895-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: deFEw8G4Jk-MwWdkfCfzEwRyG1avKw5f
X-Proofpoint-ORIG-GUID: deFEw8G4Jk-MwWdkfCfzEwRyG1avKw5f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_06,2024-06-10_01,2024-05-17_01

From: Keith Busch <kbusch@kernel.org>

DPC and AER handling access their subordinate bus devices. If pciehp shou=
ld
happen to also trigger during this handling, it will remove all the subor=
dinate
buses, then dereferecing any children may be a use-after-free. That may l=
ead to
kernel panics like the below.

 BUG: unable to handle page fault for address: 00000000091400c0
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 [#1] SMP
 CPU: 15 PID: 2464 Comm: irq/53-pcie-dpc Kdump: loaded Tainted: G        =
    E      6.9.0-0_fbk0_rc10_871_g4e98bf884071 #1
 RIP: 0010:pci_bus_read_config_dword+0x17/0x50
 Code: e9 0e 00 00 00 c7 01 ff ff ff ff b8 86 00 00 00 c3 cc cc 0f 1f 44 =
00 00 53 50 c7 44 24 04 00 00 00 00 f6 c2 03 75 27 48 89 cb <48> 8b 87 c0=
 00 00 00 4c 8d 44 24 04 b9 04 00 00 00 ff 50 18 85 c0
 RSP: 0018:ffffc90039113d60 EFLAGS: 00010246
 RAX: 0000000009140000 RBX: ffffc90039113d7c RCX: ffffc90039113d7c
 RDX: 0000000000000004 RSI: 0000000000000000 RDI: 0000000009140000
 RBP: 0000000000000100 R08: 0000000000000000 R09: 0000000000000001
 R10: 0000000000000000 R11: 0000001f975c6971 R12: 000000000000e9fc
 R13: ffff88811b5b4000 R14: ffffc90039113d7c R15: 0000000000000000
 FS:  0000000000000000(0000) GS:ffff899f7d3c0000(0000) knlGS:000000000000=
0000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00000000091400c0 CR3: 00000243fb00f002 CR4: 0000000000770ef0
 PKRU: 55555554
 Call Trace:
  <TASK>
  ? __die+0x78/0xc0
  ? page_fault_oops+0x2a8/0x3a0
  ? sched_clock+0x5/0x10
  ? psi_task_switch+0x39/0xc90
  ? __switch_to+0x131/0x530
  ? exc_page_fault+0x63/0x130
  ? asm_exc_page_fault+0x22/0x30
  ? pci_bus_read_config_dword+0x17/0x50
  pci_dev_wait+0x107/0x190
  ? dpc_completed+0x50/0x50
  dpc_reset_link+0x4e/0xd0
  pcie_do_recovery+0xb2/0x2d0
  ? irq_forced_thread_fn+0x60/0x60
  dpc_handler+0x107/0x130
  irq_thread_fn+0x19/0x40
  irq_thread+0x120/0x1e0
  ? irq_thread_fn+0x40/0x40
  ? irq_forced_secondary_handler+0x20/0x20
  kthread+0xae/0xe0
  ? file_tty_write+0x360/0x360
  ret_from_fork+0x2f/0x40
  ? file_tty_write+0x360/0x360
  ret_from_fork_asm+0x11/0x20
  </TASK>

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/pcie/err.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 31090770fffcc..5355fc0fbf910 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -192,7 +192,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev=
,
 		pci_channel_state_t state,
 		pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev))
 {
-	int type =3D pci_pcie_type(dev);
+	int type =3D pci_pcie_type(dev), ret;
 	struct pci_dev *bridge;
 	pci_ers_result_t status =3D PCI_ERS_RESULT_CAN_RECOVER;
 	struct pci_host_bridge *host =3D pci_find_host_bridge(dev->bus);
@@ -214,6 +214,10 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *de=
v,
 	else
 		bridge =3D pci_upstream_bridge(dev);
=20
+
+	ret =3D pci_trylock_rescan_remove(bridge);
+	if (!ret)
+		return PCI_ERS_RESULT_DISCONNECT;
 	pci_walk_bridge(bridge, pci_pm_runtime_get_sync, NULL);
=20
 	pci_dbg(bridge, "broadcast error_detected message\n");
@@ -262,12 +266,14 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *d=
ev,
 	}
=20
 	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
+	pci_unlock_rescan_remove();
=20
 	pci_info(bridge, "device recovery successful\n");
 	return status;
=20
 failed:
 	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
+	pci_unlock_rescan_remove();
=20
 	pci_uevent_ers(bridge, PCI_ERS_RESULT_DISCONNECT);
=20
--=20
2.43.0


