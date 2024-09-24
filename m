Return-Path: <linux-pci+bounces-13414-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F066983CE2
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 08:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4136B1C219C2
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 06:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CE184E04;
	Tue, 24 Sep 2024 06:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yR0MM+2U"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DC374418;
	Tue, 24 Sep 2024 06:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158514; cv=fail; b=qUGHHBttynw492JpB+5nIrr40r83b5rRk1D0dDUOUV5nb/pvu/UVdcowGkghgOehYPLCX7SLYPGLoBQFqEVhO2/DazRgnLRctSxixA5N8eP0DYNHQ6CSCbwGkCm6BIYmW0qkXU3RDd7trK0KrRt+cARGr551tMRA/icvJgJ6WAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158514; c=relaxed/simple;
	bh=fCs00g/OPGmv5M8vWO3cFFWAM1ac7g4qnBUQ7cMs3YY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F7fYDS+5jBr+z3dLgC2k8DT+AcEWhWo8dEZwUR1fXaJ4+KSQQW5aRzn5F0uwBjMc1hQh+YuO2ZxGQJr/sey21fOHG4itiWEpbSgjiaKTIUfFxpkcxzrnzw4wxECSwSeLTMEIx0qklYgZGOhyFMLDLL2z/+aIaeP9e1t/H3HJgXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yR0MM+2U; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SeopoSFdUo5/BaEaq/9jRqvjLyS/AuQXkDCVsfg3zAl3m4UBbPpg1W0UFO3C00p2uk40KucBXOkBY/DKo7UHWp/v1J4bLY2usEUMhndTfs8hqbdI+C1YePbN482SPygBMS3SdG3JaiiOv9t/rqQs/6ZVzw5nJRiLtOJVVSazmFVvkaFnI81xLrcsQaC+qCfsADLHzFOVfm/2zaUbaqTuiWB8pMQ2IFHwFGAfQRlSlkohQ37yF2vDb1PtaU1DIfd7Wdqc8wumxh+ZXGALo4/JO1qHSbCpHH+XHpHhwaeE7vbyRRWcKmJ0XiU5MqcdCB3TtnYoEHmEotbwFEFYBDOeQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQNwTPlybOdd+7qQR+gLZeq3rDHFlzkK3+lUznWBPzE=;
 b=VLgESB59QYADodXyYj/iMBqSbU9rNS1rMKSDJgep5xMcXmZlxvYzg/I68fgovPMwqMrtVr2sGK/ARdI+nFHgh/aQkXEyb3E4diRCbcn5Bfzujjz1tkHK1J+r1AaeYF0kDKtt/QQMnOMDocZ+q3VzbKWPUW6xZNsnAIzPdItwcepzn8jZeDdQA1MMy5RLCWppzc1wqdYYDSzNBdN2wVL0KWfb0M1K18OkIiBdOrwoHRUZOZM9Qh23E6gAh/1sRQzoaaW8CC3G8e4JSgV3IpJ33auD/b+mu4a3y1qWjdHy94/P9HUHR5OWjo07QNQfMSRPuwXge8twQxOfMTuWHuKf2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQNwTPlybOdd+7qQR+gLZeq3rDHFlzkK3+lUznWBPzE=;
 b=yR0MM+2UKlC8oj4STQXe8J70DgQjvzKyYuuyRbd1j6J7q/b8SITuu7oD3lSOhkG6CZlV8W4aLAFgYgXTCx6olE1dc8o5c7WjRiUrj24TxIqsGa0eZ4yn6dQKMeJC6HtdSeZN+PQDShltaW7fClUUaUMF4JT4lTRw9alzE1nibpM=
Received: from MW4PR04CA0098.namprd04.prod.outlook.com (2603:10b6:303:83::13)
 by MN2PR12MB4286.namprd12.prod.outlook.com (2603:10b6:208:199::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 06:15:08 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::3a) by MW4PR04CA0098.outlook.office365.com
 (2603:10b6:303:83::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.26 via Frontend
 Transport; Tue, 24 Sep 2024 06:15:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 24 Sep 2024 06:15:07 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Sep
 2024 01:15:04 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J .
 Wysocki" <rafael@kernel.org>
CC: <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>, Jiqian Chen
	<Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: [KERNEL PATCH v10 3/3] xen/privcmd: Add new syscall to get gsi from dev
Date: Tue, 24 Sep 2024 14:14:37 +0800
Message-ID: <20240924061437.2636766-4-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240924061437.2636766-1-Jiqian.Chen@amd.com>
References: <20240924061437.2636766-1-Jiqian.Chen@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|MN2PR12MB4286:EE_
X-MS-Office365-Filtering-Correlation-Id: 77fee85f-7e44-45de-e3b8-08dcdc603d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ixM6jeVTiwxlEVTMAgxabglyEbjXRsZlycuOYaCDZlpAuLGv+yqPkxY0JaSt?=
 =?us-ascii?Q?/UoCQmg+wk6JCiNK2qq06v1RLJJQY+cyFhT0+RfMgp3tYJYt4+LUKYlb3kzx?=
 =?us-ascii?Q?CkRYcal3yjvI6DS7KDfPxsFjKoANlJelVXN44uf+xJBQS5LSS1NGuL/MIFrb?=
 =?us-ascii?Q?eq0S3PjRuhM+CYrgoix25DK3npesjzC4FxI9vdSOt2h+6xn+zIOgs+qJJyok?=
 =?us-ascii?Q?e+dB8ZHtWi6DMJe5agD/deGgGbG2zD6nBwlG2BTcfIp/bV++MZ/jU9jAEY8K?=
 =?us-ascii?Q?EAoGCd/cAvTsoYx7/7mrtRFq6GkDgPv0ayMbCXPgOadeHZNb/Nk/6nj2x33e?=
 =?us-ascii?Q?zwx+A6bvyrPZjGrMSDKLTEJ/6dxwFNysUBDgAfYfN0WGKcA/OVuT1egOZQMQ?=
 =?us-ascii?Q?3ZqIfpqC+ix1u4YiD7CZ9pnDzW9zbKDtcnL3ypu7GenHTCKswoJCgIW2qHJ1?=
 =?us-ascii?Q?1PWMBNSZK3kNV7lAKYqvhITgPn13Nz/RgwJK5OlNWLrCvhNV84Tsam8KvFR9?=
 =?us-ascii?Q?juYz+2dBTah9okbIK3Aa0mUTApZ7YYfu3b7AkY5HNLIY5rSRFI2GEPT2IM2e?=
 =?us-ascii?Q?HuE1C33BChftr8mMEId2rdxEkHLlwCH5dPPw64ID/rX+dxbedIffhw5wmOrN?=
 =?us-ascii?Q?mWdACmNutkWAu1pDNFl18iDHRmBlYB1BVkYWShzBD5xC/PF/sdTKjDEc9r0I?=
 =?us-ascii?Q?aYbHxLI4LUfoxlMY+uyJhTQIDXYxNZZHvaWjzGraighlwtcqS0Lfg5Yt9MP+?=
 =?us-ascii?Q?hwqlRK1zMOj6b0sSeVwdyVzqf31jZns9JJfvCKiJbBLV6OrKnfT9icIFGc6+?=
 =?us-ascii?Q?2kxTLx8Gn8Gd1dULtinqbrO6EWCj5QCjQ7wgIZC1GcjE4d7klxjLdlOtoe7q?=
 =?us-ascii?Q?gIJdrTrEvpco6DYioDoI04Irt7PVu8+7Hm40xNN0spbuof8/9Jxe6PRJHkcR?=
 =?us-ascii?Q?NOKr8KzDnSq0dUS3rI5G94c2ba+l9RZW0hLM9Cs/g2jRa0H3Lso0/FtslEfE?=
 =?us-ascii?Q?K103EK3gZBVVcI2rO1cLq31x9s+9vW5tLPuqXAZbVnAjfwtczOLFjqY1p42X?=
 =?us-ascii?Q?temVqIHfGWklgOtqLdMXTYP/8SkU9pN6yiHmZ2uFMD6UmUJ4eVDehCv/D/ZL?=
 =?us-ascii?Q?MwUfz9QpTJSzH3GmSK+fAXlVq0Hurqv3IxA1Kb9P+wZSysM4ZiVblyBH0agG?=
 =?us-ascii?Q?emY/HWX/l898ZXi3AC+gIOmSfIEv8rwt7MEedLKM/pdCsUrN85XWSDjz3SxK?=
 =?us-ascii?Q?+mGe+/AbYfv+3fEtYXiQAbHxPiYVLK7zTXKLm565iUVFMRmpybbgBjU4HpxF?=
 =?us-ascii?Q?wRsw3d9VPLNxj6jZz+hsk8MWaEHN9OQKtF1wjxEmKLAbDiY4QGuojgWsbBMC?=
 =?us-ascii?Q?MN73rBX24On0NhgHrHrQk7Gizf1l/W4nNtWp6FgwQBiBjlwcxFdM4FyzbTVw?=
 =?us-ascii?Q?TB1mrC12euvMKjujav2DoTdcrsTp+w4W?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 06:15:07.6866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77fee85f-7e44-45de-e3b8-08dcdc603d01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4286

On PVH dom0, when passthrough a device to domU, QEMU and xl tools
want to use gsi number to do pirq mapping, see QEMU code
xen_pt_realize->xc_physdev_map_pirq, and xl code
pci_add_dm_done->xc_physdev_map_pirq, but in current codes, the gsi
number is got from file /sys/bus/pci/devices/<sbdf>/irq, that is
wrong, because irq is not equal with gsi, they are in different
spaces, so pirq mapping fails.
And in current linux codes, there is no method to get gsi
for userspace.

For above purpose, record gsi of pcistub devices when init
pcistub and add a new syscall into privcmd to let userspace
can get gsi when they have a need.

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
v9->v10 changes:
Changed the macro wrapping "pcistub_get_gsi_from_sbdf" from "CONFIG_XEN_PCIDEV_BACKEND" to "CONFIG_XEN_ACPI".
Added "imply CONFIG_XEN_PCIDEV_BACKEND" for CONFIG_XEN_PRIVCMD Kconfig definition.
Added check "if (IS_REACHABLE(CONFIG_XEN_PCIDEV_BACKEND))" before calling pcistub_get_gsi_from_sbdf.

v8->v9 changes:
Changed the syscall name from "IOCTL_PRIVCMD_GSI_FROM_DEV" to "IOCTL_PRIVCMD_PCIDEV_GET_GSI". Also changed the other functions name.
Changed the macro wrapping "pcistub_get_gsi_from_sbdf" from "CONFIG_XEN_ACPI" to "CONFIG_XEN_PCIDEV_BACKEND" to fix compile errors reported by CI robot.
Changed the parameter gsi of struct privcmd_pcidev_get_gsi from int to u32.

v7->v8 changes:
In function privcmd_ioctl_gsi_from_dev, return -EINVAL when not confige CONFIG_XEN_ACPI.
Used PCI_BUS_NUM PCI_SLOT PCI_FUNC instead of open coding.

v6->v7 changes:
Changed implementation to add a new parameter "gsi" to struct pcistub_device and set gsi when pcistub initialize device. Then when userspace wants to get gsi and pass sbdf, we can return that gsi.

v5->v6 changes:
Changed implementation to add a new syscall to translate irq to gsi, instead adding a new gsi sysfs node, because the pci Maintainer didn't allow to add that sysfs node.

v3->v5 changes:
No.

v2->v3 changes:
Suggested by Roger: Abandoned previous implementations that added new syscall to get gsi from irq and changed to add a new sysfs node for gsi, then userspace can get gsi number from sysfs node.
---
 drivers/xen/Kconfig                |  1 +
 drivers/xen/privcmd.c              | 32 +++++++++++++++++++++++++
 drivers/xen/xen-pciback/pci_stub.c | 38 +++++++++++++++++++++++++++---
 include/uapi/xen/privcmd.h         |  7 ++++++
 include/xen/acpi.h                 |  9 +++++++
 5 files changed, 84 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index d5989871dd5d..fd83d51df2f4 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -261,6 +261,7 @@ config XEN_SCSI_BACKEND
 config XEN_PRIVCMD
 	tristate "Xen hypercall passthrough driver"
 	depends on XEN
+	imply CONFIG_XEN_PCIDEV_BACKEND
 	default m
 	help
 	  The hypercall passthrough driver allows privileged user programs to
diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 9563650dfbaf..588f99a2b8df 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -46,6 +46,9 @@
 #include <xen/page.h>
 #include <xen/xen-ops.h>
 #include <xen/balloon.h>
+#ifdef CONFIG_XEN_ACPI
+#include <xen/acpi.h>
+#endif
 
 #include "privcmd.h"
 
@@ -844,6 +847,31 @@ static long privcmd_ioctl_mmap_resource(struct file *file,
 	return rc;
 }
 
+static long privcmd_ioctl_pcidev_get_gsi(struct file *file, void __user *udata)
+{
+#if defined(CONFIG_XEN_ACPI)
+	int rc = -EINVAL;
+	struct privcmd_pcidev_get_gsi kdata;
+
+	if (copy_from_user(&kdata, udata, sizeof(kdata)))
+		return -EFAULT;
+
+	if (IS_REACHABLE(CONFIG_XEN_PCIDEV_BACKEND))
+		rc = pcistub_get_gsi_from_sbdf(kdata.sbdf);
+
+	if (rc < 0)
+		return rc;
+
+	kdata.gsi = rc;
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
@@ -1543,6 +1571,10 @@ static long privcmd_ioctl(struct file *file,
 		ret = privcmd_ioctl_ioeventfd(file, udata);
 		break;
 
+	case IOCTL_PRIVCMD_PCIDEV_GET_GSI:
+		ret = privcmd_ioctl_pcidev_get_gsi(file, udata);
+		break;
+
 	default:
 		break;
 	}
diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index 8ce27333f54b..d003402ce66b 100644
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
+		return -ENODEV;
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
@@ -452,6 +483,7 @@ static int pcistub_init_device(struct pci_dev *dev)
 		err = xen_pvh_setup_gsi(gsi, trigger, polarity);
 		if (err)
 			goto config_release;
+		psdev->gsi = gsi;
 	}
 #endif
 
@@ -494,7 +526,7 @@ static int __init pcistub_init_devices_late(void)
 
 		spin_unlock_irqrestore(&pcistub_devices_lock, flags);
 
-		err = pcistub_init_device(psdev->dev);
+		err = pcistub_init_device(psdev);
 		if (err) {
 			dev_err(&psdev->dev->dev,
 				"error %d initializing device\n", err);
@@ -564,7 +596,7 @@ static int pcistub_seize(struct pci_dev *dev,
 		spin_unlock_irqrestore(&pcistub_devices_lock, flags);
 
 		/* don't want irqs disabled when calling pcistub_init_device */
-		err = pcistub_init_device(psdev->dev);
+		err = pcistub_init_device(psdev);
 
 		spin_lock_irqsave(&pcistub_devices_lock, flags);
 
diff --git a/include/uapi/xen/privcmd.h b/include/uapi/xen/privcmd.h
index 8b8c5d1420fe..8e2c8fd44764 100644
--- a/include/uapi/xen/privcmd.h
+++ b/include/uapi/xen/privcmd.h
@@ -126,6 +126,11 @@ struct privcmd_ioeventfd {
 	__u8 pad[2];
 };
 
+struct privcmd_pcidev_get_gsi {
+	__u32 sbdf;
+	__u32 gsi;
+};
+
 /*
  * @cmd: IOCTL_PRIVCMD_HYPERCALL
  * @arg: &privcmd_hypercall_t
@@ -157,5 +162,7 @@ struct privcmd_ioeventfd {
 	_IOW('P', 8, struct privcmd_irqfd)
 #define IOCTL_PRIVCMD_IOEVENTFD					\
 	_IOW('P', 9, struct privcmd_ioeventfd)
+#define IOCTL_PRIVCMD_PCIDEV_GET_GSI				\
+	_IOC(_IOC_NONE, 'P', 10, sizeof(struct privcmd_pcidev_get_gsi))
 
 #endif /* __LINUX_PUBLIC_PRIVCMD_H__ */
diff --git a/include/xen/acpi.h b/include/xen/acpi.h
index 3bcfe82d9078..daa96a22d257 100644
--- a/include/xen/acpi.h
+++ b/include/xen/acpi.h
@@ -91,4 +91,13 @@ static inline int xen_acpi_get_gsi_info(struct pci_dev *dev,
 }
 #endif
 
+#ifdef CONFIG_XEN_PCI_STUB
+int pcistub_get_gsi_from_sbdf(unsigned int sbdf);
+#else
+static inline int pcistub_get_gsi_from_sbdf(unsigned int sbdf)
+{
+	return -1;
+}
+#endif
+
 #endif	/* _XEN_ACPI_H */
-- 
2.34.1


