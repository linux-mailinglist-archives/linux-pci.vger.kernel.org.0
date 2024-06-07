Return-Path: <linux-pci+bounces-8432-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F688FFD8D
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 09:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EB962881A8
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 07:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734A115AAB8;
	Fri,  7 Jun 2024 07:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2G07Qca5"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8517215B0E4;
	Fri,  7 Jun 2024 07:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717746701; cv=fail; b=QR5pe8c0jKrBuRZ+0qF7dheBhr8alCDxXrIUIWhnFq5z7cf9lg5I86JJUXR+oe2sbZ2VPY9i4juh+co7Kp8yxeVCd9KbnYKv4LbqZ4R+6fMO1wdFJLljJeafWz2r8vzzffiv3c4oXUv5y++A8bhSuznn7V+quKhtboDMJtodqRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717746701; c=relaxed/simple;
	bh=T23VkWvshxlWVWCczPRlYV6OpBVSvNBTd9na8w0qgVM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BdNS0XzLQ1qRRUje43wwNvSx+ibkiV598PH8w1t3/SD42qti2AUc/TZYy+V0Y0GkA9QPStCXtdQ4NXd9ufHMvu+z1DCljxKWtGutVxTXb16inY7Q+7cgshjiRc1Fr9IQ2qIgkhNriq3+rrmuudi4oH+lG1OGj0JhOci5k4dI2wM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2G07Qca5; arc=fail smtp.client-ip=40.107.92.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PN8D4JTyF3+mf9JWWnT7I+aTgDsZQwjahjPtaYkaOeUx16pB0ixzCh4lTCD4X0tCUuO+0jc2TV/PwSc+D4wyKjZfjdaf2E5egV/met1TVuMzx1sHN2m7YpyfjiJZdOInOXiXtbv9gnKNIvWzWnhehxqHkoloOk5ov/pCZgH76UFXH1jo+rKJYJ9tqKZvI6Qs6PSUwqRGQgpBtURuAxUmwEj64arK7EFbE9EvXAYNTmKghJkwT7sDZokAqEIZeH8h0GQBYF+VT5OUMio8Z/bJNyXjwMSL3OcTROhcuvJ02umD6IzVTrAQbHFRwMY3u9xlIhV60FyOTjY7wC6dZFSH1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtwVEw1eqAZTxz5ZOltSmokorN9ksIbbFVkKSMPl8Yw=;
 b=FQK7f7aYZmxCjaxp5beBd9BOyzXmN/z7nbInaHAybKZraYOpQUQ6vAa8/S4Yhe7C77sgkBPuORfubel8QPXruS3CHzsQe6Hk3o+MKReOWc4iFB+Keo/ZGMEyI5MciuhIvX2nWwyfmzbU9a8Nj8GG4g/k+j80eamDQsaFc/TE2ZmK3+dghF8szPQfEnGCXwuHz7GGfzFAI+RnbtpEwKxwGKIrtGaGFvC5DG5pybh1TnOZ8mDXcn9ypTziOoDiIMhmH+QVaPtCgsLqxgM6fIkmksWztaMI1kBE8ECNVm2Tt6jBNEZnLTIPdkCgXh4n6BueMbN+0Vna5p4j4Odp5KZPrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtwVEw1eqAZTxz5ZOltSmokorN9ksIbbFVkKSMPl8Yw=;
 b=2G07Qca5v/z8aLxsjbak/bX9ggG0nDq3oW2L2nTngx9L37jEjFZ5WTKatNlYuP78km67+V7ws4zi1BsKtoGCkhS6JzXnGgafDUIgIhDpvizr7L8V14hH23KB4DQpuqmGAG+YOPFG2vMeZH1Wj5VC7IMze/MHus1zUyBxHjYcpb4=
Received: from SN6PR16CA0054.namprd16.prod.outlook.com (2603:10b6:805:ca::31)
 by MW4PR12MB6976.namprd12.prod.outlook.com (2603:10b6:303:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 07:51:37 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:805:ca:cafe::89) by SN6PR16CA0054.outlook.office365.com
 (2603:10b6:805:ca::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Fri, 7 Jun 2024 07:51:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 7 Jun 2024 07:51:36 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 7 Jun
 2024 02:51:33 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J .
 Wysocki" <rafael@kernel.org>, =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?=
	<roger.pau@citrix.com>
CC: <xen-devel@lists.xenproject.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>, Huang Rui
	<Ray.Huang@amd.com>, Jiqian Chen <Jiqian.Chen@amd.com>, Huang Rui
	<ray.huang@amd.com>
Subject: [RFC KERNEL PATCH v8 3/3] xen/privcmd: Add new syscall to get gsi from dev
Date: Fri, 7 Jun 2024 15:51:09 +0800
Message-ID: <20240607075109.126277-4-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607075109.126277-1-Jiqian.Chen@amd.com>
References: <20240607075109.126277-1-Jiqian.Chen@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|MW4PR12MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cd1c8d0-2273-4bef-1fff-08dc86c6a86e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W10QbVwI0ESCViUv3Ii94tlHOF04G1t1XaKMzDJwvWIei6ZRoBVVQsF8DHAS?=
 =?us-ascii?Q?jp5FNXJaXFMzBhfZcHJGyRl1yikEpoq7gliavCNdHNnjwOircVWumM121L5Q?=
 =?us-ascii?Q?Physf5TpaOKbm2oeFPsZavDUg9h/3afwvxbam4yytxGhZ8QdJFUpZHB8z9pX?=
 =?us-ascii?Q?nhhfVxxg4vpTadv2z8gB0EqYRVgYzMrsggqrNPiOY+2Ntdg7ZtGNDGWgOAVC?=
 =?us-ascii?Q?sYQ8g5LXYH+sBY6p/uy+tbMEeGB0wYgRc830CKDP2aCXLN/HhHdSEZRQsWsE?=
 =?us-ascii?Q?PayNlfB+lOOsuynANnsRlQ6Rdpt0dhkxlvAZKg8cQLaBNANce1W4Xfcs15QU?=
 =?us-ascii?Q?xjtbZnIdO36Ge9gJODvIiKjkm1tooUvKBcOrkrBWyaz1FIXzYzLihYhzQ+J3?=
 =?us-ascii?Q?Z3oJO1altQfC36CJ/lCmISTICSJ3FFLcKKnxJiK/jXhdJe9ssO6gy/WJ9Jg7?=
 =?us-ascii?Q?KqBIlH5vmIRNnaEyqsIBToXKLVwJXaP2XgClBgledru+H3/bp8cZXt9yTuy8?=
 =?us-ascii?Q?GebOGnTV9EIOr+7Xbp5ObYLJs+DQlthjyKyDH5OqQDZky/ly9SjBLSds/7hl?=
 =?us-ascii?Q?rhxpyroXOC6GMJptQHQruVNLxvS/UNcT2N4qGcWekx8sCX4nGTcoMTmXDPwt?=
 =?us-ascii?Q?PhCMOoBDIkuD9Std0a5Vy2TR9i8ouzEytPplvPNEKQ+MXXCGc4XxM/oyf4k0?=
 =?us-ascii?Q?axz0/x6PY5sIs2BECmR0bqqfMMozOhGXfoIl2aQuBUIDirGR5rCm7WzIt5XK?=
 =?us-ascii?Q?LgX2KEJCtNbFcljF81HH6L+bOOTfXR6fk4ITjizWBkB84Nqwr9DIqXaps2qP?=
 =?us-ascii?Q?HNqZ3nnT4heeXylWF50repNLWCkKjI9Lm0GmCEtlvTsvUv3/rraF8ZplnKSG?=
 =?us-ascii?Q?Pf4IO94dCXU2YMsVntBzLBVt4mAE1pMr00N555AduSnOcDq7kL01Aw8gM1rj?=
 =?us-ascii?Q?cYGJjOW1sxGjLmeHNhOvKz4TXrigE7GmorktKb9JXIA05gcinta2qUSNIqWZ?=
 =?us-ascii?Q?yyKFSxOJV3r2KZgKlPKzrlg1gweGIkJzZfFmRdH21SwaoL5bNkeVKJv1q+Ns?=
 =?us-ascii?Q?KU16n3D3MaO69HiuG+GlTbqnDc5izn1prO2nAejwg+IcwoyeSF44GgdTBwOr?=
 =?us-ascii?Q?XSlyREjTFGrY26vzBYYBCppR7jF7VYu5P6S5h5tLwNqqEDaDdqfjtMdOPRLj?=
 =?us-ascii?Q?uChFoN1gcNpnXw7/7m+++VbgFd5H5N0DdId5lRdAwqc6xt+yiXe4/z5u+TF0?=
 =?us-ascii?Q?zNltBnHBMdbqabf1TNDt3/QLlJLx9T8j6FEteEzv/MhHkmjhH3fTDyO39zbY?=
 =?us-ascii?Q?uFVJj7PjT6Gpr1+0K3Spls/w6KuQ+MnHKh+V+Jz2LJrOYXSnMvh0kqnA3a+j?=
 =?us-ascii?Q?PpShbrfV2QFmDmPzyT+RMvSfv5mkfJpU+tizNim9u4zQ2ZzvnA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 07:51:36.6266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd1c8d0-2273-4bef-1fff-08dc86c6a86e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6976

In PVH dom0, it uses the linux local interrupt mechanism,
when it allocs irq for a gsi, it is dynamic, and follow
the principle of applying first, distributing first. And
the irq number is alloced from small to large, but the
applying gsi number is not, may gsi 38 comes before gsi 28,
it causes the irq number is not equal with the gsi number.
And when passthrough a device, QEMU will use device's gsi
number to do pirq mapping, but the gsi number is got from
file /sys/bus/pci/devices/<sbdf>/irq, irq!= gsi, so it will
fail when mapping.
And in current linux codes, there is no method to get gsi
for userspace.

For above purpose, record gsi of pcistub devices when init
pcistub and add a new syscall into privcmd to let userspace
can get gsi when they have a need.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
RFC: it need review and need to wait for previous patch of this series to be merged.
---
 drivers/xen/privcmd.c              | 28 ++++++++++++++++++++++
 drivers/xen/xen-pciback/pci_stub.c | 38 +++++++++++++++++++++++++++---
 include/uapi/xen/privcmd.h         |  7 ++++++
 include/xen/acpi.h                 |  9 +++++++
 4 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 67dfa4778864..5809b3168f25 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -45,6 +45,9 @@
 #include <xen/page.h>
 #include <xen/xen-ops.h>
 #include <xen/balloon.h>
+#ifdef CONFIG_XEN_ACPI
+#include <xen/acpi.h>
+#endif
 
 #include "privcmd.h"
 
@@ -842,6 +845,27 @@ static long privcmd_ioctl_mmap_resource(struct file *file,
 	return rc;
 }
 
+static long privcmd_ioctl_gsi_from_dev(struct file *file, void __user *udata)
+{
+#ifdef CONFIG_XEN_ACPI
+	struct privcmd_gsi_from_dev kdata;
+
+	if (copy_from_user(&kdata, udata, sizeof(kdata)))
+		return -EFAULT;
+
+	kdata.gsi = pcistub_get_gsi_from_sbdf(kdata.sbdf);
+	if (kdata.gsi == -1)
+		return -EINVAL;
+
+	if (copy_to_user(udata, &kdata, sizeof(kdata)))
+		return -EFAULT;
+
+	return 0;
+#else
+	return -EINVAL;
+#endif
+}
+
 #ifdef CONFIG_XEN_PRIVCMD_EVENTFD
 /* Irqfd support */
 static struct workqueue_struct *irqfd_cleanup_wq;
@@ -1529,6 +1553,10 @@ static long privcmd_ioctl(struct file *file,
 		ret = privcmd_ioctl_ioeventfd(file, udata);
 		break;
 
+	case IOCTL_PRIVCMD_GSI_FROM_DEV:
+		ret = privcmd_ioctl_gsi_from_dev(file, udata);
+		break;
+
 	default:
 		break;
 	}
diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index 6b22e45188f5..9d791d7a8098 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -56,6 +56,9 @@ struct pcistub_device {
 
 	struct pci_dev *dev;
 	struct xen_pcibk_device *pdev;/* non-NULL if struct pci_dev is in use */
+#ifdef CONFIG_XEN_ACPI
+	int gsi;
+#endif
 };
 
 /* Access to pcistub_devices & seized_devices lists and the initialize_devices
@@ -88,6 +91,9 @@ static struct pcistub_device *pcistub_device_alloc(struct pci_dev *dev)
 
 	kref_init(&psdev->kref);
 	spin_lock_init(&psdev->lock);
+#ifdef CONFIG_XEN_ACPI
+	psdev->gsi = -1;
+#endif
 
 	return psdev;
 }
@@ -220,6 +226,25 @@ static struct pci_dev *pcistub_device_get_pci_dev(struct xen_pcibk_device *pdev,
 	return pci_dev;
 }
 
+#ifdef CONFIG_XEN_ACPI
+int pcistub_get_gsi_from_sbdf(unsigned int sbdf)
+{
+	struct pcistub_device *psdev;
+	int domain = (sbdf >> 16) & 0xffff;
+	int bus = PCI_BUS_NUM(sbdf);
+	int slot = PCI_SLOT(sbdf);
+	int func = PCI_FUNC(sbdf);
+
+	psdev = pcistub_device_find(domain, bus, slot, func);
+
+	if (!psdev)
+		return -1;
+
+	return psdev->gsi;
+}
+EXPORT_SYMBOL_GPL(pcistub_get_gsi_from_sbdf);
+#endif
+
 struct pci_dev *pcistub_get_pci_dev_by_slot(struct xen_pcibk_device *pdev,
 					    int domain, int bus,
 					    int slot, int func)
@@ -367,14 +392,20 @@ static int pcistub_match(struct pci_dev *dev)
 	return found;
 }
 
-static int pcistub_init_device(struct pci_dev *dev)
+static int pcistub_init_device(struct pcistub_device *psdev)
 {
 	struct xen_pcibk_dev_data *dev_data;
+	struct pci_dev *dev;
 #ifdef CONFIG_XEN_ACPI
 	int gsi, trigger, polarity;
 #endif
 	int err = 0;
 
+	if (!psdev)
+		return -EINVAL;
+
+	dev = psdev->dev;
+
 	dev_dbg(&dev->dev, "initializing...\n");
 
 	/* The PCI backend is not intended to be a module (or to work with
@@ -448,6 +479,7 @@ static int pcistub_init_device(struct pci_dev *dev)
 		dev_err(&dev->dev, "Fail to get gsi info!\n");
 		goto config_release;
 	}
+	psdev->gsi = gsi;
 
 	if (xen_initial_domain() && xen_pvh_domain()) {
 		err = xen_pvh_setup_gsi(gsi, trigger, polarity);
@@ -495,7 +527,7 @@ static int __init pcistub_init_devices_late(void)
 
 		spin_unlock_irqrestore(&pcistub_devices_lock, flags);
 
-		err = pcistub_init_device(psdev->dev);
+		err = pcistub_init_device(psdev);
 		if (err) {
 			dev_err(&psdev->dev->dev,
 				"error %d initializing device\n", err);
@@ -565,7 +597,7 @@ static int pcistub_seize(struct pci_dev *dev,
 		spin_unlock_irqrestore(&pcistub_devices_lock, flags);
 
 		/* don't want irqs disabled when calling pcistub_init_device */
-		err = pcistub_init_device(psdev->dev);
+		err = pcistub_init_device(psdev);
 
 		spin_lock_irqsave(&pcistub_devices_lock, flags);
 
diff --git a/include/uapi/xen/privcmd.h b/include/uapi/xen/privcmd.h
index 8b8c5d1420fe..220e7670a113 100644
--- a/include/uapi/xen/privcmd.h
+++ b/include/uapi/xen/privcmd.h
@@ -126,6 +126,11 @@ struct privcmd_ioeventfd {
 	__u8 pad[2];
 };
 
+struct privcmd_gsi_from_dev {
+	__u32 sbdf;
+	int gsi;
+};
+
 /*
  * @cmd: IOCTL_PRIVCMD_HYPERCALL
  * @arg: &privcmd_hypercall_t
@@ -157,5 +162,7 @@ struct privcmd_ioeventfd {
 	_IOW('P', 8, struct privcmd_irqfd)
 #define IOCTL_PRIVCMD_IOEVENTFD					\
 	_IOW('P', 9, struct privcmd_ioeventfd)
+#define IOCTL_PRIVCMD_GSI_FROM_DEV				\
+	_IOC(_IOC_NONE, 'P', 10, sizeof(struct privcmd_gsi_from_dev))
 
 #endif /* __LINUX_PUBLIC_PRIVCMD_H__ */
diff --git a/include/xen/acpi.h b/include/xen/acpi.h
index 9b50027113f3..d6315fd559a9 100644
--- a/include/xen/acpi.h
+++ b/include/xen/acpi.h
@@ -83,4 +83,13 @@ int xen_acpi_get_gsi_info(struct pci_dev *dev,
 						  int *gsi_out,
 						  int *trigger_out,
 						  int *polarity_out);
+
+#ifdef CONFIG_XEN_PCI_STUB
+int pcistub_get_gsi_from_sbdf(unsigned int sbdf);
+#else
+static inline int pcistub_get_gsi_from_sbdf(unsigned int sbdf)
+{
+	return -1;
+}
+#endif
 #endif	/* _XEN_ACPI_H */
-- 
2.34.1


