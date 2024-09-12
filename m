Return-Path: <linux-pci+bounces-13074-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E19C97656B
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 11:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5116D1C21499
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 09:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D984019C562;
	Thu, 12 Sep 2024 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VXhxCrW5"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113EF1925A8;
	Thu, 12 Sep 2024 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726133069; cv=fail; b=HAIeeLaC8vg94o9cZbtDIci7O7hwx0yiiZIxCy3NqsbZotzYUjHGcHJtRM07JCDqrL6K1Uj4SWi9zXmS4UOKojIv91AUU43Shvaf6uqqg0uhKXM4U3Odl6xBvJKhhC9MxlHDqj4Fje9jN/mxkiE865Pox0jzrj9FV51fEsRLNNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726133069; c=relaxed/simple;
	bh=vHFGLD3BkgenzlngIHwCJ9L+K+PnrbLpO5R4DV1dRnk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e25gbQxVyGSVT1R2mcyRcGoIK228wjEJFzveM89jIsIAdPaTdUEiel33BM89AFteXcnYp7Ri3RD37MVRcORE+ozqRyA2oAgCjuNKZMVXuckCQ9+10NCsCpwLtwVcVJ5xZyf8IJBWeJcmR7Kr9De54muh4lo4nNnmyFGqLkN6sCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VXhxCrW5; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IEFK4/MYIlMH1Dks/krt6KVpWrrMGH1mJPnxIWLWZ0ZU3W/kmlzsUURrvaa9LpSYF+w498cW8lEvbE7NDPRB/nPThJorTqNt0hrtzLoxmylEv2QwHmq1lMqrFcpT0FpSey+LJIO8csWVNWHilg22Il9+l6uXewlUOjOppUuEE32Vf2LAitoNtrC402xCa3EzGSARxBmEBB3mO/NQecvc16wQIbWieksd+N3fkLiWBZZGTHx5hX3M4WPeYdFwg4eVN+vTzQ8L2H2SM3E5Y6QyXNMIUUNMn/VOvw0g9D15C5BdUbfnFvYBLkNC7pgkRdZAGfiCYS+t7QQQantfuSC3dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/LBDOvtpcnz21DnY0VeKywIgWINhOaisJwaW9jtGw4=;
 b=vBAOUidjPneTj2FiCmSzwvGuoLjgFCWipI1YJhNQV/hfAtkD7V3DMuML8b69RPhR3VEhOdidCUFM04/nwr/dHry1HtUrXhiCL4Ga+vMWJNW0J39DNzNGqU7/2C2uu2/chf3al7PAFCVlH+ACrSXCWce/fRuC5X37J1cWAyBP1OCjddlP+c6hLrYl+vaFLWR5HAuLhWGJn1utwpxbUB5+SQ5/a5kIkV0iWUygroHU6W+5afRy0wmMWVydo2rAqB44sIT5nLatS0NinsGJnm75nesAEI99wtP6+x2Ii7KkzfaI1MKA3Lu+1YyOoY5g1IdmL8QKkPAttKXadgpWco2Ptw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/LBDOvtpcnz21DnY0VeKywIgWINhOaisJwaW9jtGw4=;
 b=VXhxCrW5THFYFmNNr/v6U5q9Sb4BpB7DQaTC8Ch9uE69AXHhidRGPRrVLaDBahFyJnf8hjdhhOxj/G1QbtJvVJxUQoVf8J8zwPrjASMb3xGM89QobdDLgePX5z0dDUPnFIW8XdpLGtoaGYlJAgt/BLNCWRjnY8nhc1eozPLYG2E=
Received: from BYAPR05CA0104.namprd05.prod.outlook.com (2603:10b6:a03:e0::45)
 by SA1PR12MB6947.namprd12.prod.outlook.com (2603:10b6:806:24e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.33; Thu, 12 Sep
 2024 09:24:23 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:e0:cafe::a5) by BYAPR05CA0104.outlook.office365.com
 (2603:10b6:a03:e0::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 12 Sep 2024 09:24:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 09:24:22 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 04:24:18 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J .
 Wysocki" <rafael@kernel.org>
CC: <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>, Jiqian Chen
	<Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: [KERNEL PATCH v9 1/3] xen/pci: Add a function to reset device for xen
Date: Thu, 12 Sep 2024 17:23:49 +0800
Message-ID: <20240912092352.1602724-2-Jiqian.Chen@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|SA1PR12MB6947:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ff64c50-b8a6-42b4-b8ae-08dcd30cb04a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+0Q6Mxj8CLJadwy6YzjJ2CBU603BXSocKkdBsduqgSj4pSWWY34lqJajyS8U?=
 =?us-ascii?Q?pe/G0z66BItCIYCQvXiLz/PYbTqtH+2toN6c+UMhxnwPsfCCom+Nj8fGRXGE?=
 =?us-ascii?Q?pgosxU+e4LzxyJm3icBcI+HNZ1sJ4FVNgV7vJBwiHpFZcOVflS0FiztDmeXr?=
 =?us-ascii?Q?6MLgkAxe/CuKga46COrsxW3bLijRmFb/c/IXa27MaoAlG9DlTTbOXHyL9TkN?=
 =?us-ascii?Q?Xqv5Ntz/3leSmHXKQeikig7QHGoeb/HglrjdugDUlmc4g2vGoWED0FkxhEu4?=
 =?us-ascii?Q?tKQLKFlK8ya0hlp05oJkbq8wf1BrRYS7boYHSPcSECoStx8GV+D5Cb05DLVn?=
 =?us-ascii?Q?z0XBXG5UJRBKl+9MID7e2kQ9ib3Qqkp8IKGT3KHleteyKI332YgIOLfe3BaM?=
 =?us-ascii?Q?mNVABh82d0mLcG2EUn2EzsxIJITlEeLgb7iDJ6GZGSaeVhe7NTql0GZ1z2UX?=
 =?us-ascii?Q?ncrkoeUy+ymz+VzT+LNbdhSk6/VsGxTqyshe4hz6yOrqrsT0vh+Lmr5XaZjG?=
 =?us-ascii?Q?9ccP/cXcbadss8hOKtJ37DLeRjgob7ZH96AM+mwNrfPaYB6zq9jKJAc0inq4?=
 =?us-ascii?Q?34mp3K3Dm0eseJC5qWd8LSaDLUKbxhAQC4F6DsFxjzb1nmmPG3RYWpQwepdy?=
 =?us-ascii?Q?KyZVRHeM6D+7idHDxEQ1dk146T1b/ntNgF8lOMfo6OGJREKYVkNJ6QW5OvI9?=
 =?us-ascii?Q?57OzczWB/eaPN2U/I4Hlb3n+5XgD07AcsNODlM3gf9FXPABfe1H5r1ZSe0lV?=
 =?us-ascii?Q?MeEIjxhohQXWKZqFRFO+dOfyrjkc0ChDruoRpUcx6sBps3sloKBurLj3ExQf?=
 =?us-ascii?Q?UILlyoq++zVUDN7ZdSAPX8IiAWTL+5te86qLwQCo3yAcfZKmo15sXwBbEjCZ?=
 =?us-ascii?Q?Fjx/uZfFb5Jmnpxxoo4UBPFam5BxPlqYuNh8Q6LxpddfGNsFagaihKiuPJCI?=
 =?us-ascii?Q?Qb8GwUHauIdMDDtZgHxqW/jvT6KHtXL5rgi3DB3bl2aQ+/vDVVDpSPIJT8gd?=
 =?us-ascii?Q?bZJ3QnUv3wlfoBEb27TPe+7udDtF//8GhoKFEbSwIlRKVG2ci+Ofe1ewnA68?=
 =?us-ascii?Q?bKt1XCcy0hEO7F4/7VAwKoOeLWnHGU+lySOTd7hcaPtJ4hQDVF8Vk65+Ba41?=
 =?us-ascii?Q?mFo9niDNLM6hpJGhO/H5Xv2xuHtTnAkqYdF3+sWAo7teSr+kvVffesMOQVAE?=
 =?us-ascii?Q?kDZ0NmaJuUKlsp8I9FPK8eQVgiuQxhILu/PssRqKlTIUeSeLdhsLn1ePyzby?=
 =?us-ascii?Q?fRLKN0SkbtWQrbitY7rrx+oWy5y5WJsadBuYMIP9zjQGwvnYjRvoWPwghvK8?=
 =?us-ascii?Q?jY3FMUH4Cv0+eqqxWjN31wOTjh1ww6KyX8FowspvgoriTq0BifdWrsb6CWJi?=
 =?us-ascii?Q?diMvmKNPQLY4wl+klLlaS6dkkHrrbwK3hH/seF0H9pPPQggepx8ig70W3RBR?=
 =?us-ascii?Q?oPHqPAofVaqRXav5A8+GHshX/+ygrRQm?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 09:24:22.8804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff64c50-b8a6-42b4-b8ae-08dcd30cb04a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6947

When device on dom0 side has been reset, the vpci on Xen side
won't get notification, so that the cached state in vpci is
all out of date with the real device state.
To solve that problem, add a new function to clear all vpci
device state when device is reset on dom0 side.

And call that function in pcistub_init_device. Because when
using "pci-assignable-add" to assign a passthrough device in
Xen, it will reset passthrough device and the vpci state will
out of date, and then device will fail to restore bar state.

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
v8->v9 changes:
Due to the struct and name of the hypercall changed on Xen side, I did the corresponding changes, so removed the Reviewed-by of Stefano. But no function changes actually.

v5->v8 changes:
No.

v4->v5 changes:
Added Reviewed-by of Stefano.

v3->v4 changes:
Changed the code comment of PHYSDEVOP_pci_device_state_reset.
Used a new function pcistub_reset_device_state to wrap __pci_reset_function_locked and xen_reset_device_state, and called pcistub_reset_device_state in pci_stub.c.

v2->v3 changes:
Added condition to limit do xen_reset_device_state for no-pv domain in pcistub_init_device.

v1->v2 changes:
New patch to add a new function to call reset hypercall.
---
 drivers/xen/pci.c                  | 13 +++++++++++++
 drivers/xen/xen-pciback/pci_stub.c | 18 +++++++++++++++---
 include/xen/interface/physdev.h    | 17 +++++++++++++++++
 include/xen/pci.h                  |  6 ++++++
 4 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/pci.c b/drivers/xen/pci.c
index 72d4e3f193af..bb59524b8bbd 100644
--- a/drivers/xen/pci.c
+++ b/drivers/xen/pci.c
@@ -177,6 +177,19 @@ static int xen_remove_device(struct device *dev)
 	return r;
 }
 
+int xen_reset_device(const struct pci_dev *dev)
+{
+	struct pci_device_reset device = {
+		.dev.seg = pci_domain_nr(dev->bus),
+		.dev.bus = dev->bus->number,
+		.dev.devfn = dev->devfn,
+		.flags = PCI_DEVICE_RESET_FLR,
+	};
+
+	return HYPERVISOR_physdev_op(PHYSDEVOP_pci_device_reset, &device);
+}
+EXPORT_SYMBOL_GPL(xen_reset_device);
+
 static int xen_pci_notifier(struct notifier_block *nb,
 			    unsigned long action, void *data)
 {
diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index 4faebbb84999..3e162c1753e2 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -89,6 +89,16 @@ static struct pcistub_device *pcistub_device_alloc(struct pci_dev *dev)
 	return psdev;
 }
 
+static int pcistub_reset_device_state(struct pci_dev *dev)
+{
+	__pci_reset_function_locked(dev);
+
+	if (!xen_pv_domain())
+		return xen_reset_device(dev);
+	else
+		return 0;
+}
+
 /* Don't call this directly as it's called by pcistub_device_put */
 static void pcistub_device_release(struct kref *kref)
 {
@@ -107,7 +117,7 @@ static void pcistub_device_release(struct kref *kref)
 	/* Call the reset function which does not take lock as this
 	 * is called from "unbind" which takes a device_lock mutex.
 	 */
-	__pci_reset_function_locked(dev);
+	pcistub_reset_device_state(dev);
 	if (dev_data &&
 	    pci_load_and_free_saved_state(dev, &dev_data->pci_saved_state))
 		dev_info(&dev->dev, "Could not reload PCI state\n");
@@ -284,7 +294,7 @@ void pcistub_put_pci_dev(struct pci_dev *dev)
 	 * (so it's ready for the next domain)
 	 */
 	device_lock_assert(&dev->dev);
-	__pci_reset_function_locked(dev);
+	pcistub_reset_device_state(dev);
 
 	dev_data = pci_get_drvdata(dev);
 	ret = pci_load_saved_state(dev, dev_data->pci_saved_state);
@@ -420,7 +430,9 @@ static int pcistub_init_device(struct pci_dev *dev)
 		dev_err(&dev->dev, "Could not store PCI conf saved state!\n");
 	else {
 		dev_dbg(&dev->dev, "resetting (FLR, D3, etc) the device\n");
-		__pci_reset_function_locked(dev);
+		err = pcistub_reset_device_state(dev);
+		if (err)
+			goto config_release;
 		pci_restore_state(dev);
 	}
 	/* Now disable the device (this also ensures some private device
diff --git a/include/xen/interface/physdev.h b/include/xen/interface/physdev.h
index a237af867873..df74e65a884b 100644
--- a/include/xen/interface/physdev.h
+++ b/include/xen/interface/physdev.h
@@ -256,6 +256,13 @@ struct physdev_pci_device_add {
  */
 #define PHYSDEVOP_prepare_msix          30
 #define PHYSDEVOP_release_msix          31
+/*
+ * Notify the hypervisor that a PCI device has been reset, so that any
+ * internally cached state is regenerated.  Should be called after any
+ * device reset performed by the hardware domain.
+ */
+#define PHYSDEVOP_pci_device_reset      32
+
 struct physdev_pci_device {
     /* IN */
     uint16_t seg;
@@ -263,6 +270,16 @@ struct physdev_pci_device {
     uint8_t devfn;
 };
 
+struct pci_device_reset {
+    struct physdev_pci_device dev;
+#define PCI_DEVICE_RESET_COLD 0x0
+#define PCI_DEVICE_RESET_WARM 0x1
+#define PCI_DEVICE_RESET_HOT  0x2
+#define PCI_DEVICE_RESET_FLR  0x3
+#define PCI_DEVICE_RESET_MASK 0x3
+    uint32_t flags;
+};
+
 #define PHYSDEVOP_DBGP_RESET_PREPARE    1
 #define PHYSDEVOP_DBGP_RESET_DONE       2
 
diff --git a/include/xen/pci.h b/include/xen/pci.h
index b8337cf85fd1..424b8ea89ca8 100644
--- a/include/xen/pci.h
+++ b/include/xen/pci.h
@@ -4,10 +4,16 @@
 #define __XEN_PCI_H__
 
 #if defined(CONFIG_XEN_DOM0)
+int xen_reset_device(const struct pci_dev *dev);
 int xen_find_device_domain_owner(struct pci_dev *dev);
 int xen_register_device_domain_owner(struct pci_dev *dev, uint16_t domain);
 int xen_unregister_device_domain_owner(struct pci_dev *dev);
 #else
+static inline int xen_reset_device(const struct pci_dev *dev)
+{
+	return -1;
+}
+
 static inline int xen_find_device_domain_owner(struct pci_dev *dev)
 {
 	return -1;
-- 
2.34.1


