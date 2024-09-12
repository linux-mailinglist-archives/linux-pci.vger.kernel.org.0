Return-Path: <linux-pci+bounces-13076-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFADE976576
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 11:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8195B22D2B
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 09:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EBD19C54B;
	Thu, 12 Sep 2024 09:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yVLT5uIn"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B25D1990D2;
	Thu, 12 Sep 2024 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726133078; cv=fail; b=HTPk8PBB0HAaW3nnnwI5tf79zJL2Q9SmPLaftWbclN4baPwjWP0aE5FWCdtRnG77dEJly4hRLdV1J7xqEXhHmsxldXQ5tGZjDrVLkL4SsGVboOOkV2JYCIP9jvlRyvNBCssRoYSRMeEiKLK9MaxrSpx3uLJZFKWSCTGGi/RQFvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726133078; c=relaxed/simple;
	bh=Vf47C5/nuM60F/kxUOteB0MqPE8+5Ot0OO4xlama6Cs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F3R9fTvMD4ZntZ1diiH7A5bpS4P1QIods4KdXgsupVguXHj66hqiBJrBptCjUfFZlieuEqavj24xuW5t8T8O9FfcQGnHBgYXBxjpvmybYBOAwzfWYKasw6UC1QUNJkyNpbag+xFuBb534nT1xNtTgqBDv1losaRE5cPCEi5k070=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yVLT5uIn; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WnUDC0M70Z/MGHXClhtnA0uz1Lx7jsPnI2ayVK8xkLp5B7vBN3Tx1INCdp9S2WFDP2KHxdFynCn1Bp28SawWtw2fpHySwei5VMCSQYalnhE6V1L9Yt9DV3R7rXHsc+XVHYOc+YYVU9cOvCLOwNT6Lj0CLL628jroyqSKHHDOv030e4ryHi9f5uFWTqDRRQqpGo9GVdhLof3DZDCcEZY8bd3g1E4+oGtGtSoXfBAbsC4CM/C/n5qVYuF0WYF54O8p5yALmMCBKY/VI04kFgwinmtQTig4i+qn0naJKLC4zG1BejlWbisfT+l9sA74IJczWQjejjJVQ1PLpDapiqNQdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mku7qe9Kp1BSDdWMSj+vWw+ZdWEAPFHw4jIoXDID1VI=;
 b=YX0LsJHB0i3KLLS1KLbibaTJt4cfvfCauDdRGz404ih+R7XNlhcW4SfmxdWI/m/sN2ZawEf4qu6mE4ZcZdAeM4oNZh8viyz0fHAtcYpumBw8awded2obOt1miNmgKVckpMEw/xdVU9zTWEuuhtgPZbi8HTRiNuEW0Tmj/z5mHZm3zvxnvKZozxQuFGx61fBLfDucoZHYbKM322O8OkBvE/PHI8opssejJP1C6D2KkSKgCjBfO1HlxhkwVNObDexaA9HoyZmBUeCCl0r/ImrJorRH5I6idxLLFu9EecAl+srb2JjpIT0mKz2NxjPSjIM+DuwBUAjS7F6WSbgekzENNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mku7qe9Kp1BSDdWMSj+vWw+ZdWEAPFHw4jIoXDID1VI=;
 b=yVLT5uInvTHJkQ5L4Y3CCJ927uq0rvOjpwno+5Lmc0AOsTs1f+KODTtBUfvocXZCysuzK3qBL5eqZ82Ze5gvue27vVa8jFSbspPoF9dXqwhfn3SuuqxZi5ZV0zQ5x0ahbe4wlrubePVOiZnoGcH2BTl+oyNuGfXgLo1TqILGtIg=
Received: from MW4PR03CA0160.namprd03.prod.outlook.com (2603:10b6:303:8d::15)
 by SJ0PR12MB7036.namprd12.prod.outlook.com (2603:10b6:a03:483::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Thu, 12 Sep
 2024 09:24:28 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::df) by MW4PR03CA0160.outlook.office365.com
 (2603:10b6:303:8d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 12 Sep 2024 09:24:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 09:24:28 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 04:24:24 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J .
 Wysocki" <rafael@kernel.org>
CC: <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>, Jiqian Chen
	<Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: [KERNEL PATCH v9 3/3] xen/privcmd: Add new syscall to get gsi from dev
Date: Thu, 12 Sep 2024 17:23:51 +0800
Message-ID: <20240912092352.1602724-4-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912092352.1602724-1-Jiqian.Chen@amd.com>
References: <20240912092352.1602724-1-Jiqian.Chen@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|SJ0PR12MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: d65e261d-e99c-4ebe-75c0-08dcd30cb37e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qDRus6H+BxtgcAJRwcQmtzYlphPBWdk2FWQ35sQ9mu8307oF/GrGEg6OCd+N?=
 =?us-ascii?Q?0Tg+LiQIqAKkes5zL4ZlEbBZBlrlkVmhFuGMzdmCmrxjbVGSlA5D+iywwacU?=
 =?us-ascii?Q?LJ24agM8xGH9cbbJ0AIDS/ltUmKuwHpNbxegGB4VZs0IW00mU1O5F/SNZRow?=
 =?us-ascii?Q?PtPDzIGP42CevjEgDSrzMU+VyAWehBc5GIyGmKxplE5IkYIsiLJvpBGxZ7pr?=
 =?us-ascii?Q?mBTUyE8TjfK1luMaQVmZU40weoUhiIvqHG4vn607n9wzMs4c6rNdyvo1O5qX?=
 =?us-ascii?Q?jPclOtW3KEcCuWTGWV8A099E/RIPxQoTMPso3aQuktkmB+Rjq3N5TPqjyGVr?=
 =?us-ascii?Q?RaRVt1yJYCIQsU+frO2IUIAzOXcnAv0OtGV3lekyuAQoKz9d+Y2TlRxCcL0E?=
 =?us-ascii?Q?+xsov6lLZu0qC2B9TH4EpRVyXCHqVU5VKGGUT3AjdAPA9cShQEyrfk9zUBPb?=
 =?us-ascii?Q?qqfvVvTftWu3hr9NHtB0D1kWXD3A58nue71OTSRjFdRdU7+Bd22wlCCqp9iw?=
 =?us-ascii?Q?Oc6/7Asfvubh5Vn3ARCGXGMbf0VM3fB4Svs8fUO/apinqWZOZ/+KnrJpvFG5?=
 =?us-ascii?Q?myPcqGGTWMzhLyW+/wHszAx4ZOrg3OvxJlDslIdLOhm3gUg/VDVO6sokBsv3?=
 =?us-ascii?Q?EmdauI6ueZ2Gx78FpftidX5EI2DG/lExBrP5u28ACsuFBWEZtU5VMRNshuBC?=
 =?us-ascii?Q?MFXL4nXGIBF0pJ6c6sgIFftdYKInzS6KclicpGJH0Qc8+N5QoQCArFEyx4tx?=
 =?us-ascii?Q?FxXYtNJJfv7rw4VW2ImbwWevxnMTTSu8sLRja8KgCtjgwFgtoK9sbHdo7iWF?=
 =?us-ascii?Q?rPK67M6wYx6EX7WshV3A0y2iVx9JGPyB5wn2XFyu1sGraSt1gTsAiRvX+pYg?=
 =?us-ascii?Q?oELO5D246wkvH94rrkJdNmoaWuz3kSgg4uE0GFB2F9mo0zJEdzrQ49GbxMhT?=
 =?us-ascii?Q?i/6zgc84Chtz4dobJkmBTKCuvHNZnsHtFzue1i5Efmdyrxv2TTobEfcundn2?=
 =?us-ascii?Q?OkPvmX+H283QwnoQQk2K64Siz1xcwU+4MEu+EyLTEBZoOL3y32AtVFVenBXY?=
 =?us-ascii?Q?Ze+/CaBkNDDYssd6wz4TQ07ddY5JdtB2aEH8JBsxwWA9/7+RTWbuiCmwJvei?=
 =?us-ascii?Q?+AAQuOTPrwzXAogTtXIoRkSghy/G3jbOtxfDcKAmlBo+YRDLY5OSdS7UJfvU?=
 =?us-ascii?Q?4l2diUK2Oy4hlKy13XET2b3VEUrq7ZZgdAzbgg+O+xhdXAsZUkphMvlMk9Ep?=
 =?us-ascii?Q?W5uLB4NciDBUG4NwmbcRY3xhg/mNnY/nZixOKLsNvMs6Unb1vkNAL+4/Db+9?=
 =?us-ascii?Q?FNYtlUg3eYkoCe384SH1qhi3gIFiPMRhm6fBPA/IFyqvJglLPS3tkmwqvaBM?=
 =?us-ascii?Q?YBGIxF/wO/jl9P63156xKIgOrNpeR8xjJkh11J5iZZWuGFRib9uBKu+inxsR?=
 =?us-ascii?Q?HeshSZn9o5Jq9KqlQTpGylBprjJPQBC3SNfKcmX5L/3wAjWbb+0tcw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 09:24:28.2370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d65e261d-e99c-4ebe-75c0-08dcd30cb37e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7036

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
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406090826.whl6Cb7R-lkp@intel.com/
---
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405171113.T431PC8O-lkp@intel.com/
---
 drivers/xen/privcmd.c              | 30 +++++++++++++++++++++++
 drivers/xen/xen-pciback/pci_stub.c | 38 +++++++++++++++++++++++++++---
 include/uapi/xen/privcmd.h         |  7 ++++++
 include/xen/acpi.h                 |  9 +++++++
 4 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 9563650dfbaf..1ed612d21543 100644
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
 
@@ -844,6 +847,29 @@ static long privcmd_ioctl_mmap_resource(struct file *file,
 	return rc;
 }
 
+static long privcmd_ioctl_pcidev_get_gsi(struct file *file, void __user *udata)
+{
+#ifdef CONFIG_XEN_ACPI
+	int rc;
+	struct privcmd_pcidev_get_gsi kdata;
+
+	if (copy_from_user(&kdata, udata, sizeof(kdata)))
+		return -EFAULT;
+
+	rc = pcistub_get_gsi_from_sbdf(kdata.sbdf);
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
@@ -1543,6 +1569,10 @@ static long privcmd_ioctl(struct file *file,
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
index 8ce27333f54b..2ea8e4075adc 100644
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
 
+#ifdef CONFIG_XEN_PCIDEV_BACKEND
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
index 3bcfe82d9078..393a73bfda24 100644
--- a/include/xen/acpi.h
+++ b/include/xen/acpi.h
@@ -91,4 +91,13 @@ static inline int xen_acpi_get_gsi_info(struct pci_dev *dev,
 }
 #endif
 
+#ifdef CONFIG_XEN_PCIDEV_BACKEND
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


