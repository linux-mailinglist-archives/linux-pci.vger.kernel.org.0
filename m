Return-Path: <linux-pci+bounces-30203-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F5BAE0AD4
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 17:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3F17169656
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 15:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846AE21CC6C;
	Thu, 19 Jun 2025 15:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s5BwCtuh"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D1C11712;
	Thu, 19 Jun 2025 15:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750347994; cv=fail; b=UtsJx7V7gG2K2FmLedxKf/TPc4soBoc55ofLcnHr9LyM3raOn9oacbGssIQDEYjrukFFAHuuNYw3byo+Gmt+/wwzxJaloTs4/3wPL40xpQIkNGFvKu6MQC3m7q5jwjpYg0hv5jj1X8++12jU00lNyvA2lTusDHptTqLez3dJLwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750347994; c=relaxed/simple;
	bh=S7pI0ii+bb7PmFQrKdKpcQOEQuv7e5dzQSNhlf2Khbo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ujx2fddDhit9WCSlGqNtQCDQNrJKxnDMvhfOcitF+PoKQZP9q/w6CsHt7sOihBDt+P7rqv9ilO5c7fDVeCGnEgG0zQN8yr/zJyHRsB/KsJEfJQ2YAAOpagAWCDQ0asp0iXytXyZFSGBCl+R2O+Uuu040AiKBMSPlpFeZPkXynOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s5BwCtuh; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7xoyqzV7W27Fiq/EbuWn89tOTQY9c54Hquqq9m4+H0qLxruKb+UyW29R1jCGp0C/gZF+mO8TvaYIjWXz51bDi3xqHZjgozWy5vWG9S9MUQOghtapxe1/9IBXKpzllOY6kaLTHMLh2+AweDHwhGBBHCdzYt2DK6lZPACEUHVSxe2OYOg7XpfiVpLxy+heFEP+ySByWxI0nkqBbDsVgGIeHwa7rlsFWPeKm4bEzno2WQR15aQjM592Jo5dqk4dhOle/o7ZRVdya99PL0tZHFcTv0qWVbdOiE7AEhLOYnc+1setnWkVujRB9+aPw6G/OaGYvyVjTua1OH3Nci4yMrH4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9qv+b5OebQDe2Rf2AwZhig3pUHz63b84JV4d8SqnXY=;
 b=b7McOTRNYAmvXJSiJG7xJoIOmbLZqNLlGoz6kMLYg3Yaf95sUbMxd5sGqYhGDJ8hLRkep342eA3D3lALk9eEt2Ya2f+YTJ4s91XxzfI3NkrXbal7J0d6YNA+JBixiYHnyPjbWHJhMh4fF6TeLjC1ZZvsW0gMLSXsr1p6giYZRGLDHoxa9JJ3DDaO4s2przHr6MX2NjbQt3ETm2FuxoIvKWyaH464PVVGNtfz/N+A+aRANXYjvksaZRxEmPLOP/2LUh4ndPRcP8fO8IOj9jthhmtK7ocsR5P18tBgIxIpBJjqnn90V29cTikLapKn6vh4fpsM3JWCOjJXVib3HfZD0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9qv+b5OebQDe2Rf2AwZhig3pUHz63b84JV4d8SqnXY=;
 b=s5BwCtuhTVB/t9op5OQ8kvR7NK8f3AFeXboaytHyqWgydqrz9Ky5is4HrDxlKN6sSSjqYJFVerT4ywdtf59Ju7WbsnRhwCUxvU7V6N8jGhcNtwbM5pIfGfX+QzTD/WX3GEzX5tzKxqlNV7mlvqHA+UhvDCQLR2cJAdIxzhItBDM=
Received: from CH2PR05CA0056.namprd05.prod.outlook.com (2603:10b6:610:38::33)
 by DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Thu, 19 Jun 2025 15:46:28 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::3) by CH2PR05CA0056.outlook.office365.com
 (2603:10b6:610:38::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.8 via Frontend Transport; Thu,
 19 Jun 2025 15:46:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Thu, 19 Jun 2025 15:46:28 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Jun
 2025 10:46:26 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <lukas@wunner.de>, Raju Rangoju <Raju.Rangoju@amd.com>, Sanath S
	<Sanath.S@amd.com>
Subject: [PATCH] PCI: pciehp: fix circular lock dependency b/w pci_rescan_remove_lock and reset_lock
Date: Thu, 19 Jun 2025 21:16:10 +0530
Message-ID: <20250619154610.902892-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|DS0PR12MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: dbafb382-c2d6-40a0-426b-08ddaf4874c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YNncCpwYIAtNK2G4iXg1U2ns3YS+V4Fwrb7xnhyZTnFRw8Wehnneq+G94ci0?=
 =?us-ascii?Q?8f/CU4Fr03ioVWKTvxPj28249cQ4o8ZAiPwR5X+xsFcdont5EMMqGuDinewK?=
 =?us-ascii?Q?STitj26PnRtgORw0eHXe3AbmTPWTVOzbVrKI4/YhNixVKTr2aDy4W6wvIXFS?=
 =?us-ascii?Q?ezKOg0mADG1Cj5dGNMeHS61NUsVOY49n8C1IsFYhPH9Af8M4IpBO0o0kh39d?=
 =?us-ascii?Q?6RcBOCExZI4Ado3mYYM5rS90zO6/i09sbH9saGPEfYFJGvneZuxyRE3HxzwP?=
 =?us-ascii?Q?b0+76MXbWqstRhDxF9SAnoaGZrStJRqhMu09KHuIEE9S+0cuL9XECC+aLiPs?=
 =?us-ascii?Q?amZIUFhXpLScMSsU2qmJip4TBmOJw0VOgcWlVmMcOXvB3H1J7gSLcIdv45M6?=
 =?us-ascii?Q?rPJW1TFKhudMWwKq4YD1y6cHma2kvrni2IRp8+JRT9hDdVh5xUZUyrSX9SQK?=
 =?us-ascii?Q?QthG3Kmj2hw9Oc1zs8CiQPQglQ815yuF6PWKAP8qCAQpO7Q+i5GfDMRmhJn9?=
 =?us-ascii?Q?9jWyqBXDXzrnmesKxuPqTYV6CM5XJTemauENuPOJwdWOWQ/tPv3Ge6LG/DNO?=
 =?us-ascii?Q?Avi/nOV5VnIPIv573q1rGmGa6xA4V4jqi3tD7asSUaaEJ77N4o1cRnvBqY/X?=
 =?us-ascii?Q?+4iSdefXtNAQp+IjjYZ/My/I1dF09zvejt9ul7vKe+aOgA2KT6It0Py1993c?=
 =?us-ascii?Q?vkmIEJsgZVN+u3WFLgGwSNtI6k3h83EwfRZ+ftNt+VGJRAMql8Fdmtb00Qga?=
 =?us-ascii?Q?/qoO2m+3Oq/y8m+ym8vMnAR3kLvl6f4IqMbK19W+jk2jxKlpSgc+39Bn5wZX?=
 =?us-ascii?Q?wmLjtfweoPZJaiQtWbvM/CP0Z+diYWY2f6sY+yPKdvHbBDN7yjTrV8izvBMS?=
 =?us-ascii?Q?7KQ1Na6VhsNG395pgXjRQJ5v3HMCwelaZpB+4aUtwYsgnyZkZeHZ0v3UbGTg?=
 =?us-ascii?Q?sBagJNAxwxlKIZsrP7zMJSms9j8YOl320cbwlvY8JCOOKdYbNyZNQqkTt5vs?=
 =?us-ascii?Q?azD+TCjIuxDund/PEr9/nsUGqjZjrplolZZtWhzmhT9VoFtyFRwaFDia0UbM?=
 =?us-ascii?Q?0sLAoGByzDsRi/Mk3N19R1dkHdrqW1pQ1JUIWCrxxw6Zcn0bUCnGgeEkjYj/?=
 =?us-ascii?Q?jrJYxJaopv6glmAzts75tV3hq/p132E55ANr8BIhQ4Q/9y1A3SwGn5yMbbfN?=
 =?us-ascii?Q?FPEn8i9HoWm/5fcUfYlinYd2PjiVx6+gZIJH0wDHULtc5y3KUMK9HcWakr3s?=
 =?us-ascii?Q?PaZvED43SKeOJN+v9R89fTVIiADzOfsNFEsonVq+BJAbWns0GbVMVsb5Ug1h?=
 =?us-ascii?Q?SgyK5ZwdjgCi1eUNzhYm8agPKfdOadx+c/InzXTF5BSQWh686Zkt+HOR/2NX?=
 =?us-ascii?Q?0xjBuSsd9VJ25aa0nydVJiav79FZphxFZDo2XO2Eluq0TtlWEm8/qCh7LXMk?=
 =?us-ascii?Q?HG7MZ6zZYmLMcI2DSZ79bHE+TRakX8NwU6/DEJlYsx3BtbbxvZsS4P0eMDQn?=
 =?us-ascii?Q?1iM9pmDa9GuHKeI2URF7ambuGjfwEWPWlHwG?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 15:46:28.7658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbafb382-c2d6-40a0-426b-08ddaf4874c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6390

Resolves a circular locking dependency issue between
pci_rescan_remove_lock() and ctrl->reset_lock() in the PCI hotplug
subsystem, specifically in the pciehp_unconfigure_device() function.

Commit f5eff5591b8f ("PCI: pciehp: Fix AB-BA deadlock between reset_lock
 and device_lock") introduced a change in the locking order within
pciehp_unconfigure_device() to avoid an AB-BA deadlock between
ctrl->reset_lock and device_lock. However, this change inadvertently
introduced a new circular locking dependency between
pci_rescan_remove_lock and ctrl->reset_lock, as detected by lockdep.

The problematic sequence is as follows:
  1. pciehp_unconfigure_device() acquires ctrl->reset_lock (read lock).
  2. It then acquires pci_rescan_remove_lock.
  3. Within the device removal loop, it attempts to reacquire
     ctrl->reset_lock after releasing it for driver unbinding,
     while still holding pci_rescan_remove_lock.

This creates a potential for deadlock if another thread acquires the
locks in the opposite order, as illustrated by lockdep's report.

To resolve this, change the locking order in pciehp_unconfigure_device()
so that ctrl->reset_lock is released before acquiring
pci_rescan_remove_lock and before driver unbinding. This avoids
holding both locks at the same time and breaks the circular
dependency. After the critical section, ctrl->reset_lock is reacquired
as needed.

This ensures that the locking order is consistent and prevents the
circular dependency, addressing the lockdep warning and potential
deadlock.

[  120.615285] ======================================================
[  120.615289] WARNING: possible circular locking dependency detected
[  120.615293] 6.14.5-300.fc42.x86_64+debug #1 Not tainted
[  120.615297] ------------------------------------------------------
[  120.615300] irq/36-pciehp/136 is trying to acquire lock:
[  120.615303] ffff88810d247340 (&ctrl->reset_lock){.+.+}-{4:4}, at: pciehp_unconfigure_device+0x1d0/0x390
[  120.615323]
               but task is already holding lock:
[  120.615326] ffffffff9c13ce90 (pci_rescan_remove_lock){+.+.}-{4:4}, at: pciehp_unconfigure_device+0xe5/0x390
[  120.615337]
               which lock already depends on the new lock.

[  120.615340]
               the existing dependency chain (in reverse order) is:
[  120.615343]
               -> #1 (pci_rescan_remove_lock){+.+.}-{4:4}:
[  120.615351]        lock_acquire.part.0+0x133/0x390
[  120.615359]        __mutex_lock+0x1b3/0x1490
[  120.615366]        pciehp_unconfigure_device+0xe5/0x390
[  120.615370]        pciehp_disable_slot+0xfa/0x2f0
[  120.615376]        pciehp_handle_presence_or_link_change+0xc8/0x310
[  120.615381]        pciehp_ist+0x2d5/0x3e0
[  120.615386]        irq_thread_fn+0x88/0x160
[  120.615393]        irq_thread+0x21e/0x490
[  120.615399]        kthread+0x39d/0x760
[  120.615406]        ret_from_fork+0x31/0x70
[  120.615412]        ret_from_fork_asm+0x1a/0x30
[  120.615418]
               -> #0 (&ctrl->reset_lock){.+.+}-{4:4}:
[  120.615426]        check_prev_add+0x1ab/0x23b0
[  120.615431]        __lock_acquire+0x2311/0x2e10
[  120.615436]        lock_acquire.part.0+0x133/0x390
[  120.615441]        down_read_nested+0xa4/0x490
[  120.615445]        pciehp_unconfigure_device+0x1d0/0x390
[  120.615448]        pciehp_disable_slot+0xfa/0x2f0
[  120.615453]        pciehp_handle_presence_or_link_change+0xc8/0x310
[  120.615458]        pciehp_ist+0x2d5/0x3e0
[  120.615462]        irq_thread_fn+0x88/0x160
[  120.615465]        irq_thread+0x21e/0x490
[  120.615469]        kthread+0x39d/0x760
[  120.615474]        ret_from_fork+0x31/0x70
[  120.615478]        ret_from_fork_asm+0x1a/0x30
[  120.615483]
               other info that might help us debug this:

[  120.615485]  Possible unsafe locking scenario:

[  120.615488]        CPU0                    CPU1
[  120.615490]        ----                    ----
[  120.615492]   lock(pci_rescan_remove_lock);
[  120.615497]                                lock(&ctrl->reset_lock);
[  120.615502]                                lock(pci_rescan_remove_lock);
[  120.615506]   rlock(&ctrl->reset_lock);
[  120.615511]
                *** DEADLOCK ***

Fixes: f5eff5591b8f ("PCI: pciehp: Fix AB-BA deadlock between reset_lock and device_lock")
Co-developed-by: Sanath S <Sanath.S@amd.com>
Signed-off-by: Sanath S <Sanath.S@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/pci/hotplug/pciehp_pci.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index 65e50bee1a8c..08ba59d96f4a 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -104,6 +104,11 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
 	if (!presence)
 		pci_walk_bus(parent, pci_dev_set_disconnected, NULL);
 
+	/*
+	 * Release reset_lock before driver unbinding
+	 * to avoid AB-BA deadlock with device_lock.
+	 */
+	up_read(&ctrl->reset_lock);
 	pci_lock_rescan_remove();
 
 	/*
@@ -116,11 +121,6 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
 					 bus_list) {
 		pci_dev_get(dev);
 
-		/*
-		 * Release reset_lock during driver unbinding
-		 * to avoid AB-BA deadlock with device_lock.
-		 */
-		up_read(&ctrl->reset_lock);
 		pci_stop_and_remove_bus_device(dev);
 		down_read_nested(&ctrl->reset_lock, ctrl->depth);
 
@@ -134,8 +134,14 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
 			command |= PCI_COMMAND_INTX_DISABLE;
 			pci_write_config_word(dev, PCI_COMMAND, command);
 		}
+		/*
+		 * Release reset_lock before driver unbinding
+		 * to avoid AB-BA deadlock with device_lock.
+		 */
+		up_read(&ctrl->reset_lock);
 		pci_dev_put(dev);
 	}
 
+	down_read_nested(&ctrl->reset_lock, ctrl->depth);
 	pci_unlock_rescan_remove();
 }
-- 
2.34.1


