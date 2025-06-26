Return-Path: <linux-pci+bounces-30689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC0DAE960B
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 08:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2CD73A6DB6
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 06:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5F3218EB1;
	Thu, 26 Jun 2025 06:20:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D7A84D08;
	Thu, 26 Jun 2025 06:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750918816; cv=none; b=JNh0DnImmmvOuZvP/V32LF0zkXs1mpLiTD2G6qbg0KLJ5Qbg+sSQM4mzGU8G7ut77UD5e9mv6Xa3SQAnFMRbYcFfs+WiV7LSAlY0sGyKnXyo9jDSLmzHh3YnzVcdqrbuSnepsVd90hxUaQB/Jel9N+Hvre38SxOYtFeFUrgJevg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750918816; c=relaxed/simple;
	bh=KnM6er54bHfD4X2upb/uVRwqsSdEHhnUqCtBq+J5Wi4=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=BVD74SS5ARwSq7keqdtKcQgmqxnsNftpsxG5qFhJc5OWhFGWR0tmi23myv1suutszGdXj+pDFbQlmHKpXnYyJ75oo90RbTJz4WNPbmA38O/AY/QpGdQfC7VxtOM8MLHvzAd9PBjig8mno/7U0gw1FJxVBbQ+AI4QjNvEo4BdGsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4bST7Q3Vl7z4xPSS;
	Thu, 26 Jun 2025 14:20:02 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 55Q6JgPM016081;
	Thu, 26 Jun 2025 14:19:42 +0800 (+08)
	(envelope-from liu.xuemei1@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 26 Jun 2025 14:19:44 +0800 (CST)
Date: Thu, 26 Jun 2025 14:19:44 +0800 (CST)
X-Zmail-TransId: 2afc685ce680ffffffffa0f-dfcd2
X-Mailer: Zmail v1.0
Message-ID: <202506261419447422wtZgdMsDQuN-09S7w3Ae@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <liu.xuemei1@zte.com.cn>
To: <mani@kernel.org>, <kwilczynski@kernel.org>, <kishon@kernel.org>,
        <bhelgaas@google.com>, <lpieralisi@kernel.org>
Cc: <liu.song13@zte.com.cn>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBQQ0k6IGVuZHBvaW50OiBBdm9pZCBjcmVhdGluZyBzdWItZ3JvdXBzIGFzeW5jaHJvbm91c2x5?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 55Q6JgPM016081
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 685CE692.001/4bST7Q3Vl7z4xPSS

From: Liu Song <liu.song13@zte.com.cn>

The asynchronous creation of sub-groups by a delayed work could lead to an
null-pointer-dereference exception when the driver directory gets
removed before the work completes.

The crash can be easily reproduced with the following commands.

 # mkdir test && rmdir test

Fixes this by using configfs_add_default_group() which does not have the
deadlock problem as configfs_register_group().

Backtraces of the crash:
 BUG: kernel NULL pointer dereference, address: 0000000000000088
 #PF: supervisor write access in kernel mode
 #PF: error_code(0x0002) - not-present page
 PGD 0
 Oops: Oops: 0002 [#1] SMP NOPTI
 CPU: 4 UID: 0 PID: 371 Comm: kworker/4:1 Kdump: loaded Tainted: G            E       6.16.0-rc3 #2 PREEMPT(lazy)
 Tainted: [E]=UNSIGNED_MODULE
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
 Workqueue: events pci_epf_cfs_work
 RIP: 0010:mutex_lock+0x1c/0x30
 Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 53 48 89 fb 2e 2e 2e 31 c0 65 48 8b 15 5e 4c 29 02 31 c0 <f0> 48 0f b1 13 75 06 5b e9 97 8a 00 00 48 89 df 5b eb b1 90 90 90
 RSP: 0018:ff64babb4111fdf0 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: 0000000000000088 RCX: 0000000000000000
 RDX: ff2de9c80f5d3080 RSI: ffffffffb9e58559 RDI: 0000000000000088
 RBP: ff2de9c8269df9c0 R08: 0000000000000040 R09: 0000000000000000
 R10: ff64babb4111fdf0 R11: 00000000ffffffff R12: ff2de9c80f753e88
 R13: ff2de9c80f753e00 R14: 0000000000000000 R15: ff2de9c80f753f98
 FS:  0000000000000000(0000) GS:ff2de9d78069f000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000088 CR3: 0000000ac782c003 CR4: 0000000000773ef0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554
 Call Trace:
  <TASK>
  configfs_register_group+0x3d/0x190
  pci_epf_cfs_work+0x41/0x110
  process_one_work+0x18f/0x350
  worker_thread+0x25a/0x3a0
  ? __pfx_worker_thread+0x10/0x10
  kthread+0xfc/0x240
  ? __pfx_kthread+0x10/0x10
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x14f/0x180
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 Modules linked in: pci_epf_test(E) nft_fib_inet(E) nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E) nf_reject_ipv4(E) nf_reject_ipv6(E) nft_reject(E) nft_ct(E) nft_chain_nat(E) nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) rfkill(E) ip_set(E) nf_tables(E) intel_rapl_msr(E) intel_rapl_common(E) intel_uncore_frequency_common(E) qrtr(E) isst_if_common(E) skx_edac_common(E) nfit(E) libnvdimm(E) sunrpc(E) kvm_intel(E) vfat(E) fat(E) kvm(E) irqbypass(E) rapl(E) iTCO_wdt(E) 8139too(E) intel_pmc_bxt(E) iTCO_vendor_support(E) 8139cp(E) virtio_gpu(E) mii(E) virtio_input(E) virtio_dma_buf(E) i2c_i801(E) pcspkr(E) lpc_ich(E) i2c_smbus(E) virtio_balloon(E) joydev(E) loop(E) dm_multipath(E) nfnetlink(E) vsock_loopback(E) vmw_vsock_virtio_transport_common(E) vmw_vsock_vmci_transport(E) vsock(E) zram(E) lz4hc_compress(E) vmw_vmci(E) lz4_compress(E) xfs(E) polyval_clmulni(E) ghash_clmulni_intel(E) sha512_ssse3(E) sha1_ssse3(E) serio_raw(E) scsi_dh_rdac(E) scsi_dh_emc(E) 
 scsi_dh_alua(E) fuse(E)
  qemu_fw_cfg(E)
 Unloaded tainted modules: intel_uncore_frequency(E):1 i10nm_edac(E):1 intel_cstate(E):1 intel_uncore(E):1 hv_vmbus(E):1
 CR2: 0000000000000088
 ---[ end trace 0000000000000000 ]---

Fixes: e85a2d783762 ("PCI: endpoint: Add support in configfs to associate two EPCs with EPF")
Signed-off-by: Liu Song <liu.song13@zte.com.cn>
---
 drivers/pci/endpoint/pci-ep-cfs.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index d712c7a866d2..e6f25f9f5c64 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -23,7 +23,6 @@ struct pci_epf_group {
 	struct config_group group;
 	struct config_group primary_epc_group;
 	struct config_group secondary_epc_group;
-	struct delayed_work cfs_work;
 	struct pci_epf *epf;
 	int index;
 };
@@ -103,7 +102,7 @@ static struct config_group
 	secondary_epc_group = &epf_group->secondary_epc_group;
 	config_group_init_type_name(secondary_epc_group, "secondary",
 				    &pci_secondary_epc_type);
-	configfs_register_group(&epf_group->group, secondary_epc_group);
+	configfs_add_default_group(secondary_epc_group, &epf_group->group);

 	return secondary_epc_group;
 }
@@ -166,7 +165,7 @@ static struct config_group

 	config_group_init_type_name(primary_epc_group, "primary",
 				    &pci_primary_epc_type);
-	configfs_register_group(&epf_group->group, primary_epc_group);
+	configfs_add_default_group(primary_epc_group, &epf_group->group);

 	return primary_epc_group;
 }
@@ -570,15 +569,13 @@ static void pci_ep_cfs_add_type_group(struct pci_epf_group *epf_group)
 		return;
 	}

-	configfs_register_group(&epf_group->group, group);
+	configfs_add_default_group(group, &epf_group->group);
 }

-static void pci_epf_cfs_work(struct work_struct *work)
+static void pci_epf_cfs_add_sub_groups(struct pci_epf_group *epf_group)
 {
-	struct pci_epf_group *epf_group;
 	struct config_group *group;

-	epf_group = container_of(work, struct pci_epf_group, cfs_work.work);
 	group = pci_ep_cfs_add_primary_group(epf_group);
 	if (IS_ERR(group)) {
 		pr_err("failed to create 'primary' EPC interface\n");
@@ -637,9 +634,7 @@ static struct config_group *pci_epf_make(struct config_group *group,

 	kfree(epf_name);

-	INIT_DELAYED_WORK(&epf_group->cfs_work, pci_epf_cfs_work);
-	queue_delayed_work(system_wq, &epf_group->cfs_work,
-			   msecs_to_jiffies(1));
+	pci_epf_cfs_add_sub_groups(epf_group);

 	return &epf_group->group;

-- 
2.27.0

