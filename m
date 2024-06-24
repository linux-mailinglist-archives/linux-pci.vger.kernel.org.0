Return-Path: <linux-pci+bounces-9175-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E1E914686
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 11:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64C291C21266
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 09:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3C740BE5;
	Mon, 24 Jun 2024 09:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mVmiUYE1"
X-Original-To: linux-pci@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2087.outbound.protection.outlook.com [40.92.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7CB79DE;
	Mon, 24 Jun 2024 09:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719221839; cv=fail; b=dROF/fiRrjEkrTgjgZO9g2xWNtbyqX7ygfBfriqhaism+SJRm9jY04JmkC0nN3PZUCtfYuFAZZVFnocRVqCjeKjBVO+zsE2iY2b+CcpYQjAVs1huwmr1w6kUPuspm3B3DP8FAaOsmxk1gdunDsJOhK/Y+G0VZEtKum95JRXML+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719221839; c=relaxed/simple;
	bh=zSBAFI5dKU/2uuWX0FiPoDZ1g0dzNNoA4tQLk5wSKaA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cHZq3JbDu9j7RxVjHlGTJQ9D8IsV2fiRtEAyfA9yVcgJhJyaYZfBnEGXcGpTBZw0qV/xOin3sSP+oa6Y8ViZboxs5WhOUIp/HDnCmuO8pNTTHwTv1BbGQ4jtMbkKBXcO3mfd8LDmy5Ce9GJFQrqdyYeaMiuxHctmhULRbAHFU2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mVmiUYE1; arc=fail smtp.client-ip=40.92.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSgRpe4ZN60qoNAXGJU6/WVF8TMtK79LTFXxH7CsXEW2QTD3uvEf0qF59nr4BSvctC4D74v4i6S4wPRs4+Ij2H3MoJpHkoWdeitPiv/AfCHiWBcsFgMhZNougkJvl3/4I5n/4Q0WlWDh1SqYnuWQlmPbh1lXHdAXGQKEcVc591KRY26zY4h3hWN1MLdQ4KfWUOkoBqkvxaZXDvWOqDKffa9FvHpcQ37xAIpZ+yLJmGKi5n2YZNjgbUZnxR6WPhL+2mFTphXn/erIze7Yl2doK7XZY5A2L+8uWim9nsSGswM8KkqznIR546bzM55eYGdCQJ4V6CS5UsF0AqSrujpcGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9CqO0+8fJUZ3zEaLwqbL03U4SYrArv8b5wXBprG1izQ=;
 b=ck6+1L5SDojTuixqENa0I0onCZXzV6BwTt1Mv6PdIi6DozcKnT+gt8GGQu6CIWp2s2ZrEw/BFcaXvhhI81DSAScsshYBICxBHofZNHj8kdypudFQnZVaQtpvDzYbMYGOFR6krcCQxrYvIommBi9I8K0QjoEOCrOM3yoWhXOm35BWItdTqfbm0gqWbe98tu596ZG8PVs8tAtAn+TsQOihGPoBybLzhvkp3g8agE7wWCCfnRhN2ZurHgmXe5Errqd0DNlml0Okie2z0vhlSZ4Zw3sO34db6lI3fMgCbDFzei1GEZg7FLjqZKftIXKLQtTA/tUrVNIfMznyq/C5hKUBOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CqO0+8fJUZ3zEaLwqbL03U4SYrArv8b5wXBprG1izQ=;
 b=mVmiUYE1INWuE0CzU1v42oG8byrFSV8OAd1FdSg3zKkdvQirkUJ/+3dPjVO9QhkoM3pGvZGzy/O6aPSH8ZOZ1cowoshC0tpH5zNgsTEk+UEhjE/xSki588Otqz1fZrwnlFdORwGHf1liN9+d+pwJ4pDoKx/SM1m+vJgzqzSOwoaVMln+d6oPu9EPjdMuU0VAgpAS3FoG+TaJlFbrtL5y02FkTqZoCktv3bnwzbWVdMdee92rYq1BZPjjFY1WhJLz1qPwpU5dGlfsoKM2ONVnRZDF02hXyBRpQqtS0i+Njlla7tv9JalG2D+8ji3Gs0hnspZe2SPhdqW4d3KAkNKbcw==
Received: from SEZPR01MB4527.apcprd01.prod.exchangelabs.com
 (2603:1096:101:76::5) by SEZPR01MB4112.apcprd01.prod.exchangelabs.com
 (2603:1096:101:48::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 09:37:12 +0000
Received: from SEZPR01MB4527.apcprd01.prod.exchangelabs.com
 ([fe80::653b:3492:9140:d2bf]) by SEZPR01MB4527.apcprd01.prod.exchangelabs.com
 ([fe80::653b:3492:9140:d2bf%5]) with mapi id 15.20.7698.024; Mon, 24 Jun 2024
 09:37:12 +0000
From: Jiwei Sun <sunjw10@outlook.com>
To: nirmal.patel@linux.intel.com,
	jonathan.derrick@linux.dev
Cc: paul.m.stillwell.jr@intel.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sunjw10@lenovo.com,
	ahuang12@lenovo.com,
	sunjw10@outlook.com
Subject: [PATCH v2] PCI: vmd: Use raw spinlock for cfg_lock
Date: Mon, 24 Jun 2024 17:37:00 +0800
Message-ID:
 <SEZPR01MB4527790242E852C3B6EECEC5A8D42@SEZPR01MB4527.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [YjN6812sfx6W7oFpko39jDHB2JHuxzCv]
X-ClientProxiedBy: SG2PR03CA0105.apcprd03.prod.outlook.com
 (2603:1096:4:7c::33) To SEZPR01MB4527.apcprd01.prod.exchangelabs.com
 (2603:1096:101:76::5)
X-Microsoft-Original-Message-ID: <20240624093700.3644-1-sunjw10@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR01MB4527:EE_|SEZPR01MB4112:EE_
X-MS-Office365-Filtering-Correlation-Id: 1148e159-deb0-4500-b8df-08dc943139bb
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199025|440099025|3412199022|3420499029|1710799023;
X-Microsoft-Antispam-Message-Info:
	6E8AYWGX9lc4IotGOFC8R5alHBa4pAr8v6e7X0V1ebAeNL+R5DVPCHL8OoziVwieay8I5XcdZLnGb24mXVt1FSiXWOdIEShbRiO358b7Nz4u2j3esas8TCs/5GRjHsDheRBVgMAmgDgoOQTLD2lBCpJRzFvjLeYdQI+U6EHfBn3mEWj/+Vl13bkTOaR/QhNe5O2zooAj9bgVaeDHkAZA42Br6Iqqq7P1AFhusiiECHlIVf6Ty6XIzj2bwo28UUb1/q6/c8cZ7NtbUuge0vg3x3hC9KbK/kPQGm79gl+sNNSNuWbpDT/3ToV820remBDZV+gIVofk+Si0nzal10zHYOW5TXBKSEbNGdolKJU4v6bYTtIHQbFiowL6/Kysac9PcDnnHKM0S1Q5A/H3SamyjlUYMSvB/QISUTA1pw4fNELbrvDQ1gcL3NGQRMVH2N8z/3G7x/2P0TZFR1IumGVMKDFupX9lHz3zJYxaSnqBfWbjDlbR014DkHzCSgTFtW42vArWYOFGDciWtDhzbctXrdhlmMdCJzaXcEtyqF66PeK+mEQde4XzQtEWOAyI8f5GN15LGuS8iH286qYL9MckTvqfj5oX2b4RbHHc1WYQ2t+ym9gEz0R9HcBU376kMdap
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hjjmxPgEVO/Amd8Zu5rvmATqnoqtxdwUcbZC2yJuTX6XNzpKRGkkFY2z/Kry?=
 =?us-ascii?Q?bRNCrc9wFZJZP3adGvQzoD81V6X39c3oiU5TF39Dqqlu8uU44i5KN1WLBJ00?=
 =?us-ascii?Q?gdOJJiehdwUFkA2L1wbmkA0z4bBpg1Ir1DnK99I5DIGa2bhed1VQHqQvvQhc?=
 =?us-ascii?Q?E/1JYe3BNC/v92AxDYYxnayi0YVCjf2nO5lfJg8iUva6MqUPzmrU3/MePHA6?=
 =?us-ascii?Q?emMYt98cVOXixSR1DdbvTGr0Cn+j8QtrQmyxSltqbpbcv1b/+LCbay6QuH3R?=
 =?us-ascii?Q?fDlxI1YYuHSTaD78nzud4KYz+ZagLaOORN860fxv6WZZy6ZmgtZ1jGVH1b3N?=
 =?us-ascii?Q?pGM9kpj4kJKGfAkxk8QLUxxO5C2MTNfYtEccmIFIZ5easXDteRCHYHFpUcwX?=
 =?us-ascii?Q?bMPDrOicBPE+S3O9BxQfQRJo9PABqcNIonY0QtFOV+8SSHM/b047kV4wknMY?=
 =?us-ascii?Q?+zPvAljRPVhJhPZCRcmq5XwTgN1k8D73MmsKsQ6SO7rRqoRebyGWmkx03lVp?=
 =?us-ascii?Q?mxfMMNaPFrEmRoXrf6OA5vgPY66rc65WJ23UTfMKIm9Gk3bf+XQCtSTBOv4u?=
 =?us-ascii?Q?cC7Gm1iubXttV+5sdjtDzgNnjf54GDsVgIslChv2g72wrLCREP859bf5k45N?=
 =?us-ascii?Q?v3qhzG5zOboGUPWk5Ejb4CGu2I30tWBAkia3t1vMSdJmdrozm1nfrX2hEy8f?=
 =?us-ascii?Q?uu/VxSJIywIT6a/Ua5yniCuPWTFy01S7cG5g+nA7TybWOpKKnWn+gkgHnCo0?=
 =?us-ascii?Q?X/ElzyBE6uOJE4Eue4r9oJ5r673Mi7i11ko46g4X4SoaF29ncqBmAVVtaUCr?=
 =?us-ascii?Q?P2g+dy6ty2/UDjRqCX278TCcr1sVj2wP6jcFMvr5V5+IKdNP8yEtQ5IkHUMW?=
 =?us-ascii?Q?zJre7zPJxEZnWoAI32/lofCef2DKI90dls9uPkIS+mGb9Us1W1WofXGMm7va?=
 =?us-ascii?Q?1ZgTbJKXCKhhCszKeiXSfMPQfMjWwUBqADe22zKq50/hO7IMWVwnP4pXoloa?=
 =?us-ascii?Q?uCzm8B5fQr20NFjFo3g9uogEZzJyLkUPDJmQvzQvqe7AxNwvL7XmoHcpidLG?=
 =?us-ascii?Q?xqSUh6HkXf3IJ8YkKBI1EbCG5UiGLz7yWMqljpjp534xHgCGCO8lYS3kknzU?=
 =?us-ascii?Q?sO422EfLIOSiyeD4OaW5UvwgudeblQzKIFCwNmUOAttNi8CVR8dwpnta+Yae?=
 =?us-ascii?Q?++77hybssKtTSrtcwT1SnYpNkt8TzVmoEKq4J5oCD/tZpo8ahaQlAWH0nbY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1148e159-deb0-4500-b8df-08dc943139bb
X-MS-Exchange-CrossTenant-AuthSource: SEZPR01MB4527.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 09:37:12.6997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4112

From: Jiwei Sun <sunjw10@lenovo.com>

If the kernel is built with the following configurations and booting
  CONFIG_VMD=y
  CONFIG_DEBUG_LOCKDEP=y
  CONFIG_DEBUG_SPINLOCK=y
  CONFIG_PROVE_LOCKING=y
  CONFIG_PROVE_RAW_LOCK_NESTING=y

The following log appears,

=============================
[ BUG: Invalid wait context ]
6.10.0-rc4 #80 Not tainted
-----------------------------
kworker/18:2/633 is trying to lock:
ffff888c474e5648 (&vmd->cfg_lock){....}-{3:3}, at: vmd_pci_write+0x185/0x2a0
other info that might help us debug this:
context-{5:5}
4 locks held by kworker/18:2/633:
 #0: ffff888100108958 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0xf78/0x1920
 #1: ffffc9000ae1fd90 ((work_completion)(&wfc.work)){+.+.}-{0:0}, at: process_one_work+0x7fe/0x1920
 #2: ffff888c483508a8 (&md->mutex){+.+.}-{4:4}, at: __pci_enable_msi_range+0x208/0x800
 #3: ffff888c48329bd8 (&dev->msi_lock){....}-{2:2}, at: pci_msi_update_mask+0x91/0x170
stack backtrace:
CPU: 18 PID: 633 Comm: kworker/18:2 Not tainted 6.10.0-rc4 #80 7c0f2526417bfbb7579e3c3442683c5961773c75
Hardware name: Lenovo ThinkSystem SR630/-[7X01RCZ000]-, BIOS IVEL60O-2.71 09/28/2020
Workqueue: events work_for_cpu_fn
Call Trace:
 <TASK>
 dump_stack_lvl+0x7c/0xc0
 __lock_acquire+0x9e5/0x1ed0
 lock_acquire+0x194/0x490
 _raw_spin_lock_irqsave+0x42/0x90
 vmd_pci_write+0x185/0x2a0
 pci_msi_update_mask+0x10c/0x170
 __pci_enable_msi_range+0x291/0x800
 pci_alloc_irq_vectors_affinity+0x13e/0x1d0
 pcie_portdrv_probe+0x570/0xe60
 local_pci_probe+0xdc/0x190
 work_for_cpu_fn+0x4e/0xa0
 process_one_work+0x86d/0x1920
 process_scheduled_works+0xd7/0x140
 worker_thread+0x3e9/0xb90
 kthread+0x2e9/0x3d0
 ret_from_fork+0x2d/0x60
 ret_from_fork_asm+0x1a/0x30
 </TASK>

If CONFIG_PREEMPT_RT is not set, the spinlock_t is based on
raw_spinlock, there is no any question in the above call trace. But if
CONFIG_PREEMPT_RT is set, the spinlock_t is based on rt_mutex, a task
will be scheduled when waiting for rt_mutex. For example, there are two
threads are trying to hold a rt_mutex lock, if A hold the lock firstly,
and B will be scheduled in rtlock_slowlock_locked() waiting for A to
release the lock. The raw_spinlock is a real spinning lock, which is
not allowed the task of the raw_spinlock owner is scheduled in its
critical region. In other words, we should not try to acquire rt_mutex
lock in the critical region of the raw_spinlock when CONFIG_PREEMPT_RT
is set.

CONFIG_PROVE_LOCKING and CONFIG_PROVE_RAW_LOCK_NESTING options are
used to detect the invalid lock nesting (the raw_spinlock vs. spinlock
nesting checks). Here is the call path:

  pci_msi_update_mask  ---> hold raw_spinlock dev->msi_lock
    pci_write_config_dword
     pci_bus_write_config_dword
       vmd_pci_write   ---> hold spinlock_t vmd->cfg_lock

The above call path is the invalid lock nesting becuase the vmd driver
tries to acquire the vmd->cfg_lock spinlock within the raw_spinlock
region (dev->msi_lock). That's why the message "BUG: Invalid wait contex"
is shown.

Signed-off-by: Jiwei Sun<sunjw10@lenovo.com>
Suggested-by: Adrian Huang <ahuang12@lenovo.com>
---
v2 changes:
 - Add more explanations regarding the root cause in the commit message

 drivers/pci/controller/vmd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 87b7856f375a..45d0ebf96adc 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -125,7 +125,7 @@ struct vmd_irq_list {
 struct vmd_dev {
 	struct pci_dev		*dev;
 
-	spinlock_t		cfg_lock;
+	raw_spinlock_t		cfg_lock;
 	void __iomem		*cfgbar;
 
 	int msix_count;
@@ -402,7 +402,7 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
 	if (!addr)
 		return -EFAULT;
 
-	spin_lock_irqsave(&vmd->cfg_lock, flags);
+	raw_spin_lock_irqsave(&vmd->cfg_lock, flags);
 	switch (len) {
 	case 1:
 		*value = readb(addr);
@@ -417,7 +417,7 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
 		ret = -EINVAL;
 		break;
 	}
-	spin_unlock_irqrestore(&vmd->cfg_lock, flags);
+	raw_spin_unlock_irqrestore(&vmd->cfg_lock, flags);
 	return ret;
 }
 
@@ -437,7 +437,7 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
 	if (!addr)
 		return -EFAULT;
 
-	spin_lock_irqsave(&vmd->cfg_lock, flags);
+	raw_spin_lock_irqsave(&vmd->cfg_lock, flags);
 	switch (len) {
 	case 1:
 		writeb(value, addr);
@@ -455,7 +455,7 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
 		ret = -EINVAL;
 		break;
 	}
-	spin_unlock_irqrestore(&vmd->cfg_lock, flags);
+	raw_spin_unlock_irqrestore(&vmd->cfg_lock, flags);
 	return ret;
 }
 
@@ -1015,7 +1015,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (features & VMD_FEAT_OFFSET_FIRST_VECTOR)
 		vmd->first_vec = 1;
 
-	spin_lock_init(&vmd->cfg_lock);
+	raw_spin_lock_init(&vmd->cfg_lock);
 	pci_set_drvdata(dev, vmd);
 	err = vmd_enable_domain(vmd, features);
 	if (err)
-- 
2.27.0


