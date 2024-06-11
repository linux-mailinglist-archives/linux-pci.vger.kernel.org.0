Return-Path: <linux-pci+bounces-8593-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F066903FD0
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 17:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6D662819C0
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 15:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F562033E;
	Tue, 11 Jun 2024 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Y1vUCLIV"
X-Original-To: linux-pci@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2053.outbound.protection.outlook.com [40.92.99.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE5D208AF;
	Tue, 11 Jun 2024 15:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.99.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718118918; cv=fail; b=WzWIiPw6ra2LdQCH138dSH64Te/Si5W8/wz164RtBbLeR1l08+lz6lXsPHTPaaQ6IvhDMxjvgRI5KR6iHz5n/OrwozYh/y+5iSAtoqIWgh/OPTCAoDJqRpkMG6OHRCuqvzpkMLCLPUOwNrY7LlH16abYK9u0naJA2KaKIReHXus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718118918; c=relaxed/simple;
	bh=XjmCnlEmups1C/BK6ofmZnqRslE6x3og/15LRM/buuE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FKevJXCVz1Kmr4HO/0J0PRAE/UYlhM+vhmsdbxlqqL8TK/U957v4FOxNjIjtmdN/1of/V0Lb126iTEbWg/xBaKSPCAk6xbT+tIsjkuRYbVxikVmJ3xBwxLVyBPPbHcvTxuZCapvZ4v8Ydu4JT9Xi1wStup1R+eC0DQxXouuecY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Y1vUCLIV; arc=fail smtp.client-ip=40.92.99.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsxVqdwsIwK90ArAKVTmS1QX7rMaU5xQFpV+i023mh7oZQoBqSz3Oe9cJUjYAiyZ5KuCMX/VWm94d6HLqhOzXaHslyhMi7t6LGFkRx24U+xLl5a53ZyqSB2e53O/W190xhUiTRniybdAPGVI2bUjHZYWDOJuTPBzf91rCFGWmN8kKVwpoA50vYOAhSu6Y37BZvkUj819XYXz3KW1dbvC1lt7e7fZGn+PxOA4lc3dZzCDh1o7XUxTlhSm0J2KpH3pSeYjGt0M+jc7FrZKEiBHQ0aQ+60lttPz00iRavqRywb/rgsb/gb2RKhQHwcg+mzQLzVXALq7bhgEjcNZC5Z+Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kp6Y5ufRUTb+7MfPkPn++q/ZCsZ7nIaUf11ZPO5EhaM=;
 b=Dw1FMFvzHYBQtQy7qyJlyNOOix38VFms0NCELvER7q3DHy+sfj17EAXOq3i076ZQMFnfCRNu3XE0rJtCBHMAGDys7/ia2fvICpXNFQS0SqUpFwXLLlyHGdE4vey/twLF2eQmcYH5HO9EccbmDVrqI9lNSVTH6m67XKOZJMGk4ySF5g5zvP1STPok+F5mS9S+lsAzZlkPb7kC003Jyr/qrIz7u7NM4JD9EILDLbpA+em5A7OEhxVmQpffTiozH8uOoXK+702JDUkr42aQhQb08VdHPs8+4mdSLXzovs7pWcZK+zn+qwJElayyvBNi86LmfGs7Qw6xpJmGGlP/N/RVaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kp6Y5ufRUTb+7MfPkPn++q/ZCsZ7nIaUf11ZPO5EhaM=;
 b=Y1vUCLIVSWoo5//ounJPQF7EQRN/X49iDv16RBZ5SGEPOLDE5J76kn9rG1mXki1CHgPUJT+d97F7KcUCCaOc4gSo2KKqD8BnCwTSxZHxCU6/wqYkWZXK7PXJpiBH0oAqZN9GUiQ1p97RoaPWF0r8lond/AmWXfzKEVqYk8fGtvmrcd8pDUY+a5GJkaZEcgyIwDyirXI7HcbNrnQsF7LtC4k0Ib9BlKAWKS0wqZPn6AUG+Z38lI69QtZeUTyKosOBnxEVK6+CW7MLFcFkXE1uv/wiUPYBDQhy1BfMpkheMKhU4971rfFiKMv05yswuoF3vHccROPBMn3fkN7nZLzZxQ==
Received: from TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:256::8)
 by TYWP286MB2793.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 15:15:14 +0000
Received: from TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM
 ([fe80::670b:45a6:4c30:d899]) by TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM
 ([fe80::670b:45a6:4c30:d899%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 15:15:14 +0000
From: Songyang Li <leesongyang@outlook.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	leesongyang@outlook.com
Subject: [PATCH]  PCI: Cancel compilation restrictions on function pcie_clear_device_status
Date: Tue, 11 Jun 2024 23:15:10 +0800
Message-ID:
 <TY3P286MB2754E7F2E61B266F610E8876B4C72@TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [M8xuqOfIJF+zDNOmnPgMpZ4aJB1JSCus]
X-ClientProxiedBy: TY2PR0101CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::14) To TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:256::8)
X-Microsoft-Original-Message-ID:
 <20240611151510.40927-1-leesongyang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2754:EE_|TYWP286MB2793:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f948171-3d21-4d0b-f47c-08dc8a294b22
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199020|440099020|3412199017|3430499026|1710799020;
X-Microsoft-Antispam-Message-Info:
	L+yVTZ0xO0VhKYXrEqd7Abe1yJTXowXpdU56Spt0Hm/xRbW2awHbZUrPV93SsgqxybBjfJIW/tx8c/O6bkm6oyFgj9jjkYlKSlhy2Ko0mudpNqM0mLh5ymXOJrusQi4tJsn+ilu1lgNbeqjP/KxdyK4guNNdf70zGkcrJZkFjneLLh6p5ubEjJZDzjTK+M33yaGerC7T+nsJLur4AP89vdj2CESqBBqVwhlaIyz5ctqbGrVorqj7Ve0i7WypGop00BiJtbrSYDcCC8/L2GYaqtep/HjlXrp2sfWd3ism2RajpwKrDc2Xs37XQ0kZVBMr5ngzcmco7wF2qsqY0ssZTqf+vAGT7Dvfauc5Z1uxgIOczA4bgAhnn5IQExQ8pyudPpo8Z401wO6oq+/ox2ZfEISLnwDESQ5tUPYDY8+bMl8q7g3uCIzUynrmSzWOLpWfjJAs4q8S/LvV887IqOHFWds5J4w+yS/HRdbS+b+fy21ljTm0MQQdsVuwdAnFrTqNBeYXK+gSoQqRjt4tzzwIDA8NJEsMWmFyM43mY1/iXm6E74kjcehHIQiGI4Y+84WQwTR6831M3dUtGAClFlQwcpSrKMiTS54AOgIRDwYdXkuNDlOHjNnzJV96wUcYj06l
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7K9dZxueJJZ2DGtccbVEl7iXgeVSrxjy2vfxgykM3OsHmp0ruGVY5x/dqPty?=
 =?us-ascii?Q?Y85vDS+am6BBCalvZwpuNKPSADXWpxLltTEMzDM1UM25e9VbRUlDSXqQRbba?=
 =?us-ascii?Q?taVUn8l1Ih7hP0SFqvzWL+WiUiPFOyJnhSeZanzN1jI0LSnPJPbfR22KlPQy?=
 =?us-ascii?Q?NHCcOMyDtnV5EU10Iepmc7TVtcRqjIWWAqeiuFdp8bHetMgwkzdiNAfA2ypU?=
 =?us-ascii?Q?duwfMElxc/1NOP2AssNY1HAbHJb3UHHqtBrlUCF/WQ1EwF1NnIDx4fKKokI4?=
 =?us-ascii?Q?CzwK6ekovvdAh4lO+hrtbOqSq3h/3JtISDANuwb8R3rhE/TU5q441H4J0yDs?=
 =?us-ascii?Q?uQk2kdkGN8nPISYVfJbFMF1sGd69qt6hnBxyNO2YzPzY5WxBS+1QFwHTK5Fn?=
 =?us-ascii?Q?90HF1XpipBC84PFw2vRig3yD0jTVXOyJPNrzGBEg0n7g3/kbFZ1AzBaF0Xe8?=
 =?us-ascii?Q?dNkQGL4FRUH9UgPni9KVAf5LhWuP8MXPn0j9MJAyn89vpKYI24KtBzVUR24D?=
 =?us-ascii?Q?3cw1O8zCKS/1+LXx99y4rT0i73fcXeBl9wkec20Eu1i9pFxfRFBi8XLeB6h5?=
 =?us-ascii?Q?M7AarrLNA808iQLN6BDArg+6xJQFwXibz/KQPtE0rwT0r/rc1/QJW/fDhwar?=
 =?us-ascii?Q?PPOd21ozMZdsGYVt1kOA6kMHxpBiZ3xOSCZXIezVYsapyLS6REWKqeCmRb6Q?=
 =?us-ascii?Q?VPoBNpuokTgz3blOXnpaghdRBk4DZ2cgL0FPWvfJAia8fH5SSk6u38ARGw/K?=
 =?us-ascii?Q?y0OQPk2vdgrJ4Rr2xu9M8/9yMEDXONTVf+1OzOsko1ZbbcYCSszy8B5gcryc?=
 =?us-ascii?Q?M5dYDA/AnvgW5pmLgsX383f/XE4R+2DZGInOaxIcwv1Maf1h22UFlcUFUmFE?=
 =?us-ascii?Q?waY5cnGObzfn/aIeKk0L1F0J6j2AfFSVW/S+fPeXp4jgz/JseGV6WZrVHeVs?=
 =?us-ascii?Q?ZIceKem55mZtI51iGTM1uN1ILpni/zaa4PgNUVh1FM9Udf/UEd4tJ8CrvETX?=
 =?us-ascii?Q?JAlXttH1iw2eAFNxAa5JbuVsGMzpupVFr0Jn6cllFyrcy7s0Oz9DehAVomyt?=
 =?us-ascii?Q?VcSB94YfkeaZhJBeMbWFpp9v3bYlrUm/FhLZMCoipqS4ap6lV1wK3ajnqG+S?=
 =?us-ascii?Q?W9ffkccxAYnT404VqmhGOVDfOYMqkkAPEjyfr/7d2himdt/YZsF4T+uvcMFk?=
 =?us-ascii?Q?5LeQL+kclX814PnGj6o935DoSGQ/ETdsVCAlRk1z5pVkttC3DD0BQv6u2OU?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f948171-3d21-4d0b-f47c-08dc8a294b22
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 15:15:14.0105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2793

    Some PCIe devices do not have AER capabilities, but they have device
    status registers.

    Signed-off-by: Songyang Li <leesongyang@outlook.com>
---
 drivers/pci/pci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)
 mode change 100644 => 100755 drivers/pci/pci.c

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
old mode 100644
new mode 100755
index 35fb1f17a589..e6de55be4c45
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2263,7 +2263,12 @@ int pci_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state)
 }
 EXPORT_SYMBOL_GPL(pci_set_pcie_reset_state);
 
-#ifdef CONFIG_PCIEAER
+/**
+ * pcie_clear_device_status - Clear device status.
+ * @dev: the PCI device.
+ *
+ * Clear the device status for the PCI device.
+ */
 void pcie_clear_device_status(struct pci_dev *dev)
 {
 	u16 sta;
@@ -2271,7 +2276,6 @@ void pcie_clear_device_status(struct pci_dev *dev)
 	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
 	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
 }
-#endif
 
 /**
  * pcie_clear_root_pme_status - Clear root port PME interrupt status.
-- 
2.34.1


