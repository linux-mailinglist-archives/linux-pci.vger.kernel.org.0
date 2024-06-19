Return-Path: <linux-pci+bounces-8973-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0EA90E965
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 13:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD1F1F2445C
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 11:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A1412F5BF;
	Wed, 19 Jun 2024 11:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SYo4ZKmD"
X-Original-To: linux-pci@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2041.outbound.protection.outlook.com [40.92.52.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A1D8287C;
	Wed, 19 Jun 2024 11:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718796497; cv=fail; b=S8rIJV4wN/ScfJ9wli5PPJZwI+T2UYya1i94Sjo5o+LtM6BtvgZldu3pmuKg+/c4D2QrjnluISlJ8Wmc7QJe1DM930OncBNi3LWj+WzbHsW+U+fguKha+UitnlpThXYT38eHuwR15fVsT/qMBGNco87qwQuwB4kFHa+wDdNJiyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718796497; c=relaxed/simple;
	bh=9eq60OILjT6/X36lp9nfJH4UBxQE8dPnJVnGt9x6O8s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LKh191+gP7BUJcYx88m7Yqbg2dkNX3lfMdLfgA/VB326B2chdOYL/jznFoNvYwMJPmlgCPrHKDPR2fxW6IZsx2IJ3pbpiYi9Zi2t7CdFLVhu+PQgR2CddK4CKbFXUJGABSQbaewUZ7tuiQNSsWDPU8kYTmqUwfV06WEVT5EMs1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SYo4ZKmD; arc=fail smtp.client-ip=40.92.52.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JL5yiw8OfZFPwONXVusf0Et/z2RiN1fMGXrY/isvlVpvIUL5LhUXqvj+ofQf3BAreZCCrhinNHnJViwzV+4sc7Vn/pmDtqhD7QL64QL+QbuaCQ/jJH6tNHvI3tHs6/K+xwX/jiQc14H8Iq71fWn6OUO9bXdFpPWmKdB3OiwhZUvPziLjfkYdvMK/2+cZ/HzAeFZHgH+YEUal2vlnaix/aUN2KE3PKs37dpyIXM9g+HynwsOcrhrOopazcxafWS84Esdg0oBXfZF3SgWXqfGMUmbKtiv2w8T9kTqQyFU5SriPnLdtveRqE2iplMGnfNdCuZg9u88CHaTgRVC5jZi4dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0w5eLjTyHEmjoO1MZA19pr4veQdPhW3jSBEcnIrl5I=;
 b=nBa7GDHQy8QnAz7PeFqALfynyEzYBKeDlKhCPy2VRJSCmzNdyRVjXH+PXZFQ4QGAaRTfP8v6z2haQf+SYgfeP2Yo9prWZmAUKSasXrMcyz94pQmuaDivlqAVyE5+Dk7DEtO8y/V08TXpCXq8Qul3eBzGhEidb2HHnXoCX8mVqwUZblL6R5+1ys9RSKUHTyc/npLgABhvSrMSV2h0bc0ltUAdxE54jZwHzYyj0xzf7IBj5oCpvt+Nc0232dqN/AXB1QvQtmprIB8BoFKPDNNm2aSdpg8K4aeaKFbUHS459YSXEpqdSgxw4RrxM0fj61uD9bWKhIXC+wIRVsI/kVDdkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0w5eLjTyHEmjoO1MZA19pr4veQdPhW3jSBEcnIrl5I=;
 b=SYo4ZKmDpmzUUnquQcqlg/zghNpoD3PDGES+Sl63Tdls5rdu5REJ8xqXbW7xmLlFN4WJKd1ZA7s8EX/dja9WkI1fxbj8ZuC2rCwob2EzhtxYFt/Yzw50uaKeuvryrpCRQUBxPu7itk8xZ8n0u2BzPmQoon0geHOF1opAkqs99TEgtyUWuNitQbbZ6Z+fZPAeKnUVfzwqB8n0kFj1zUPkMpP/Yma73ZxV8FDHBh3Aw4An9DNOZtm4UoaEYZs8Fp4k5btWoWsxt0dymggi6uSLzXDSS09geY/y1fuPJXgdpA85/zS5r8VMVmTDyvOWQc6/NGoeW9hHIcjRbnmEoMIG0Q==
Received: from SEZPR01MB4527.apcprd01.prod.exchangelabs.com
 (2603:1096:101:76::5) by TYSPR01MB5495.apcprd01.prod.exchangelabs.com
 (2603:1096:400:40e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 11:28:11 +0000
Received: from SEZPR01MB4527.apcprd01.prod.exchangelabs.com
 ([fe80::653b:3492:9140:d2bf]) by SEZPR01MB4527.apcprd01.prod.exchangelabs.com
 ([fe80::653b:3492:9140:d2bf%2]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 11:28:11 +0000
From: Jiwei Sun <sunjw10@outlook.com>
To: nirmal.patel@linux.intel.com,
	jonathan.derrick@linux.dev
Cc: lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sunjw10@lenovo.com,
	ahuang12@lenovo.com,
	sunjw10@outlook.com
Subject: [PATCH] PCI: vmd: Use raw spinlock for cfg_lock
Date: Wed, 19 Jun 2024 19:27:59 +0800
Message-ID:
 <SEZPR01MB45274AF863D3BD2F028141D9A8CF2@SEZPR01MB4527.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [nMnsYiQfsh6KiNN29TXtq+apePChjqaZ]
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To SEZPR01MB4527.apcprd01.prod.exchangelabs.com
 (2603:1096:101:76::5)
X-Microsoft-Original-Message-ID: <20240619112759.9955-1-sunjw10@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR01MB4527:EE_|TYSPR01MB5495:EE_
X-MS-Office365-Filtering-Correlation-Id: d7b0f07a-24d4-4cc9-eba8-08dc9052e64b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199025|3412199022|440099025|3430499029|3420499029|1710799023;
X-Microsoft-Antispam-Message-Info:
	QWGapoApcSXqqBeqL5ALk3tvBkg2gLx++xsUfgkjvn18Aw4fwA1cS9XRbHZGq/IRVXi4jyPL6KmQeUXxyd5Cu2iwFQzesCvDcScMkDHN9/V0CDR7fm6tHHznRY/TF+HjyXGIV9XL0J2zHyoi3ka0G+Ap0tDCQuzV1BAHwzKc4l7bpPGfZl+xQGYW9wTe3h08lFDb3BkdMmmpM02dnXU9/nVD7o2DbEKIEfGf7S715xvEvPcPtV6/b1WgIBRoOcP2jKutoZuV0H2FxG4zfOp+jIqKrO94KObCFb++vje45Hgs+t7zjdig0KcATGCTqFxM+TYWWPjuPIR/Z55AOXEvPbhuk3aZxhW+2cFmpUsLLnTBsoFsdCsRmqFnKU1lTX+kNWTR0wHoVzY+J/x1XTxDr0mFmhcEnVANRUuzVkWCe7NFoBUJC2vUdcxFxLA81sn3Z7ruo4Y4PIh23hK6hZQWOM82H4oBwJgMSu1ggAAxuKbpMjTW1yI+0cuOoeEIg5S5CACu7q17g4x8vq4z/d1uS5D5EjEu7DvTLQ0eRaUWHardwsxjesTlljEgyx6bdIuyvwhJC3/dV70PnAh9dlM3kZdCQM2MrqyThDBUmcKwv2ecy5A24TIiy8F5b3Q5TIoR
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9od4xB69Ju/BKN6BPtZVdDM5THHKofdSqFpu+rtPjD+TzyJBgrzDtKe5kVJV?=
 =?us-ascii?Q?4foqwm+omDWJ9tITxIEd0Tan6GV9xKfDuAEf84QVZ+6nQ6JlFW/HDsHPloy+?=
 =?us-ascii?Q?HaQ10Slq8YS+2NM/UgdrsCUxlYL4gL5C83Gc8+OlGRurlqo+V4K0Eob1K+5b?=
 =?us-ascii?Q?IZOMmRnc8GkHf4ZKWWGKClQ7R7MmKZG7VnYqLLK44QR3TptfEPCiS4IzfVhD?=
 =?us-ascii?Q?osVySwdPGgQpjkXWEMM9qfbiKFVOrcuIAvN3CVoqCSaunSNfQmxWCkSVU0Hf?=
 =?us-ascii?Q?deuNJvLPyfPljIw3gzUf+p8FXRfMri4vmzs/HxQTy/viA8/uZ5ApQcBLhTRT?=
 =?us-ascii?Q?gb61qe6n/bDVnmSgETgVl4rBUssjYJYQ2P48rHraW5mQozlQEjFnMgQbGxmN?=
 =?us-ascii?Q?DqBNjIfqtOYx+n9jjxnebSdZwwi0smSU+D5TSM5Doi7HLATnNyNvRCgHVcnX?=
 =?us-ascii?Q?aNISPe2TLpm10eCaujw8Br+ugA961BNiOxGppI/ksgyF0nUQBR6b2SnMhPH4?=
 =?us-ascii?Q?PIu98CQkyu4msJouuZ75upgTRHJT0TreuyF7gU9d5FLXacCNe81j2OVzeC4D?=
 =?us-ascii?Q?fOYVzqqm4OvhrTUuWAxe5F1ZEZHrPyrLIDysjl3f0vOPIZXT/UCMpRS8upcl?=
 =?us-ascii?Q?ZDOtuKi6o50+JAyL7CrXEzfEQrW/SLNmJ2AgUPw7TwyosDz0yMTdWIfzZIsL?=
 =?us-ascii?Q?O1tTm5GaIguGt8oPR7TIblN0ezYRM/4n4CdVLuweu+ThNlAADmu9NKQIRH7F?=
 =?us-ascii?Q?7M+6L1wW3bzexFBjsSn/YD6mSecyTNxYTMOgn05GXUvEaJR1BMiiJ0+24C6y?=
 =?us-ascii?Q?YXVYK9zmK2hJcZ5hQfCn8+zRRiA0FeoCSNIBkxU3Qyt2+VHzkdP9/CVIFkLm?=
 =?us-ascii?Q?Gb5NJew+0ZTUPP7hgf95sYAhR269+Tfrg5Pguk9C3ozvNu8NMTjIHJ4eERz+?=
 =?us-ascii?Q?/sRe45LWEQ4/pMNHg4lEzAn7IQyQg6GaGnV/+0hVjv3PkyYDh+cfx5YR2nxa?=
 =?us-ascii?Q?TgsrxYKnCwJQVHMhbJVOm7GgIouSdr2Q2ya97XSza10/DTVq3+6UoQ8dN9vU?=
 =?us-ascii?Q?IMkdEEI/omYM6ul+tmhOmlzcsBuJyX9BxhBCCLbK7JtVn/Nk7qWje/Fc096j?=
 =?us-ascii?Q?oD114fMoB6kASMOblUOqmxSy/LC64tK46yEgI+WVk89eOPG3Q/hyFrOio9uF?=
 =?us-ascii?Q?YrOD1KQ6I4nAj9gac8ShngpgPhPMkvO5dR+2oc5DIMDsLm9SunZMDIsn0t4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b0f07a-24d4-4cc9-eba8-08dc9052e64b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR01MB4527.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 11:28:11.3869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR01MB5495

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

The root cause is that the dev->msi_lock is a raw spinlock, but
vmd->cfg_lock is a spinlock.

Signed-off-by: Jiwei Sun<sunjw10@lenovo.com>
Suggested-by: Adrian Huang <ahuang12@lenovo.com>
---
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


