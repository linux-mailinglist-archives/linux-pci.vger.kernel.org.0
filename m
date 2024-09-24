Return-Path: <linux-pci+bounces-13412-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87906983CD9
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 08:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99E8A1C22142
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 06:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B361824A0;
	Tue, 24 Sep 2024 06:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mOqTu7+E"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D8477107;
	Tue, 24 Sep 2024 06:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158512; cv=fail; b=ZWsZe9SVg8giAgYFdWQXdUsKFmGxtocBL9nbBwof5mKlKjVLf9+xwKP+62FaqJ4JZWTEMhSmKNXMnon6f2SfUa6xFEkRgfzP8hAZvEpuR8Ys2iW5OJr+nsBFSJ29kiu3YIV1nVwGZaZszGOppQumVoIbWheja5X3OvBj8eicp2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158512; c=relaxed/simple;
	bh=k2XuOh6FNa6rdhmNN4sRv5rwuPdMGFfmkfjytmMiueo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G66VIXWDoQUr3CN730NY6IV3yVsJiyKTeBZ1crmC/ok5ODgTfypMVotxQJTQd/9jkIcMi4XILhgmt4X+ZNweGUsPuTdZIf2I1NasovQzvDp1M9PIxMcgVYajRtgjoLvJQH+9+wWHKypJw52yUc7dBJmnnfhsVl7c9zy+Cps7590=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mOqTu7+E; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOelFoBmX2Hqj6mWgaGlucv8h/QD3AMP65t9MpVomIZ74KQe6X9ZdSJwaUaqvgkL1gBK8CsXneKbaCHGF7cmxxpOQJBlUk0T2Qxb9eNZsybb2iwgdOly6nbex2K7xS/npfCkQU9/tpaUPIuAn07v8pp3yMEH9ybCpx7trioIyFALyfBDEf04FdK2azinVliEiNKIn8V7W+HJQsOSIhH6xCCQBMQo5XZvelFQrbjT3tHhZ0ckanFsDJcheIcwcplYdan7t9Cuw4++0YGKaStSsSi+IXz2zVH33k+lRY9hxH75YTY+KBTWdQS3EYE6V6ceHU7wCpVC18FftRIc1WWvTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efQt5ORvGHzU35bP9vvvwV/vo9UOLI2rawP/9uug39E=;
 b=TPEJXoYbzO68NgQ2PNf2lhHx1QubNoCjXw7cpA4ThJ+IU54tL7WmLGiSEqi6nNqX/4wzFwKutJJgIyWvqZa/WmJHS6tahNvLUkaQ6kcTCK/fcicjt2PB9FXQ1lI70EhzYzim86N0KhVS/Enubbdjt2febvHgF8TculkW8GSHNkT11Wkn8jzeJnCLH05NFqqkocQP6Hooi63nDHFweF4qOT4t4cbYOHJNLy5VPDsMjLkfjZVh23TqKGvxykyUBABunOmsWdBs+loc8Bb8Mk9zuEd1DEVaFAPkqWpKTC435pClYHsl47XxI30NIQZo5jYXO68kWG33qQm2X0PGeA3n7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efQt5ORvGHzU35bP9vvvwV/vo9UOLI2rawP/9uug39E=;
 b=mOqTu7+EdJHzLDKc4sXKyITesStwMWKHipLzI36KxK5sUYHl5CtJTfAo+2b+9ZhbkSCK19BTL+Ufa6dU55J/Y+kLQyfVHSH5aoeBVOzEtkrW3mRS+Bc3PQS5bNmVLB1GgmFRevravKe/XovzBTgFVJ7YdSaE6DSrWvOehZWxm6U=
Received: from MW4PR04CA0111.namprd04.prod.outlook.com (2603:10b6:303:83::26)
 by SA1PR12MB6995.namprd12.prod.outlook.com (2603:10b6:806:24e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 06:15:05 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::4b) by MW4PR04CA0111.outlook.office365.com
 (2603:10b6:303:83::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25 via Frontend
 Transport; Tue, 24 Sep 2024 06:15:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 24 Sep 2024 06:15:04 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Sep
 2024 01:14:58 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J .
 Wysocki" <rafael@kernel.org>
CC: <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>, Jiqian Chen
	<Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: [KERNEL PATCH v10 1/3] xen/pci: Add a function to reset device for xen
Date: Tue, 24 Sep 2024 14:14:35 +0800
Message-ID: <20240924061437.2636766-2-Jiqian.Chen@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|SA1PR12MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ebbca4b-c29d-4a24-0b4b-08dcdc603b63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bGC/R5U5urt9W4I4drxA8ooX5MJKpFuD3aCpW71JhbTpa8le5bPWwKFA0dEU?=
 =?us-ascii?Q?faCj3RetJUi4jginZ6WJDUTOilV7g1t3gWLAm7lfQZJSf8L7sHO9VtF/sCwI?=
 =?us-ascii?Q?5dCAe2YjnO0I7UeEOiyIWaYHtQZmHr2/FIrF5zALvAQ7CXWPj6qCYLwjA/KW?=
 =?us-ascii?Q?/457HBxMZipRkqGwpTkNGmK+inctK2aMGEe1fiHEVKjMoCiTE5T6H/h9LNWE?=
 =?us-ascii?Q?IPBl+H5cXsAtAxu4axJ3B/FQbtWZsFjuPkrA0OoZU22/elxMUjJ2S9+xMa7l?=
 =?us-ascii?Q?lVvjFK8cEiA7pi60AK35UoHVfpdyxfNOHZUvJokle3lWLxc56W2ahJwmp80e?=
 =?us-ascii?Q?MzHelnKUDrSt0H7Gvb/AQRbtU0fQ6gAxFdp2bTtKLfk87NT8Wbl4pInOGhfs?=
 =?us-ascii?Q?1eFvmNVw0GAG7GR11UvhtiFI5I+fVNROWE+nhL+kE2gDw4C/WcADXdWDW8i3?=
 =?us-ascii?Q?FlpzcLhhK+8sFaYhhYS8ottDxnJHHM5zGwYcrF49d7LmncLavKQ2L8clAmn0?=
 =?us-ascii?Q?v9B0+WTQdiPbbxUfHEvIvLCohiNjo7jwb1sZs2mmax2S49edeX08DPuZR7S3?=
 =?us-ascii?Q?voY7oAYd4CrMkah+ViEXD0Wopr4N/72Tcu+ifjGWuo+W+hP6wG03c64uHqWc?=
 =?us-ascii?Q?5SbZqoL0bREXKzIEwWPii6DqUY1vFwXu06QxpcIQsGh9142BnCYJe4KxFEpR?=
 =?us-ascii?Q?k1ZdTAdLGnguSLD2XLbnXm86X3SJvAzyZLncDP1z7tPVk+gUIVca6ioxlUod?=
 =?us-ascii?Q?By4JvaPKc8pYp5dVHts3Gvqf6egA6nKBInML0M6h7uSiRGJk8/2+xIPLnIj9?=
 =?us-ascii?Q?vzIxL9MNuHCYZMVyTU4Fx1PWJDWMRRwhQnhh/FDmskFRmoDlwtwnLI4qGpso?=
 =?us-ascii?Q?eKGMMH2yfec+Au74OAioYsyjHiei3TOeY9v7jEvj356S8iGy3yEUmMaJ4f3g?=
 =?us-ascii?Q?HVMnbzSBfYptx3Yk8XIzkcwcNqKben+Fr7eJTQE71qpmEDp5i/KCOSSGBckm?=
 =?us-ascii?Q?SjzgyxGwuDauahqbMYQVHSimpT1Lp8lJ2l7tn1W6t+87n6/W/kGJhVjXI/XB?=
 =?us-ascii?Q?jMu9x+GRzEN3DVgjwUTfprY1AvWPWSqvkQ/qfJjtPr9tUkL2OeoqMUOv4w1P?=
 =?us-ascii?Q?bP73xpU/oo4SZLEdR/Rg/bI7ICPaM4k2XSv8SsAIC099LxpLJr7dD2gqg25N?=
 =?us-ascii?Q?LAfU7mSHQQtaE0wvkHdWrztYd2DmYJJuOpaOH09LBw/8B2zmo9wSR3hoa9/9?=
 =?us-ascii?Q?w5rS5zMqS40a4e4qmuRzGDuFTtnKbBWPYcbqOcHQIV8DBJvzYIH4pu+sRnn3?=
 =?us-ascii?Q?/XsD6mTPNL07aSztyA9/+706QRt/wq+SNKEkiMo0H5sIXH4IuJFD956ouMqx?=
 =?us-ascii?Q?B5PSpXRPPN2lZpNmwT6CWg8NUTqE6l/kin0D0BSW0atvF1U1XW4jXuCpq3Qo?=
 =?us-ascii?Q?eTRRjHCPiUMFoRQ9YfzbjzYjMIp3aWG1?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 06:15:04.9679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ebbca4b-c29d-4a24-0b4b-08dcdc603b63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6995

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
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
v9->v10 changes:
Added Reviewed-by of Stefano.

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
index a2facd8f7e51..416f231809cb 100644
--- a/drivers/xen/pci.c
+++ b/drivers/xen/pci.c
@@ -173,6 +173,19 @@ static int xen_remove_device(struct device *dev)
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


