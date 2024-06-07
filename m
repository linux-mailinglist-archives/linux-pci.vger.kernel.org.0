Return-Path: <linux-pci+bounces-8430-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7909E8FFD86
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 09:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21711F234B2
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 07:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B4115AADA;
	Fri,  7 Jun 2024 07:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aqhcsn74"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221C415AAB8;
	Fri,  7 Jun 2024 07:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717746696; cv=fail; b=V8tslt6AO6FiEb8tHIcTrr+Z+bFB/lMCyaDEnPdTqnY/Fv45FbYL9pgGnVVRKE94dkhfRmcqPVYZfKE4gQLUEI2arAZeidrOOFdcxqwiaIVI2IRnv650YWrnVRPTSzuFQgCNjHk0Zo6GU2ldAWC0AkqD04kOGa8TPMzxs9OSWHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717746696; c=relaxed/simple;
	bh=F0kqJf8o/bMP+/mgZqXoRI+IzDwp7x2aNmLI/Fb5Sv0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XmWbGtSSFBGF+5d+QwaKKF58N/fv1T+K0dFOmiNKMyq+eqFM5pu+SlHxVwxkGuKa9H+ADbCuvTOeoD1UxS75svoLvHkpOIbjwHYRwv/PEQ3Ty1EH0gok22JB2qBh4hhD+3gkiW5/wTcRW7bYkagsXFMUBB+yKCZQolmov/DUIRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aqhcsn74; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDgmRs+DwoNK+hFVWn3gAycVUYaZkxSzX1eW9OEl7MfrbQJdzM5AirVDkogE9oZHn7JOi2pwiGHhjCmGgU4xs3LkI5nvefUBbaOMRQIKRxMspBjKlK10BT7KvY4qgD1POWWYswjxkv0i7YcrkvqaWXtZpMOkplBJYwOUCKwoy1Aei3ilKLXo1Nx1k1YgVxz7cTLTSW5A7e22pXu44xMc397yhRQprSgA4pF1me1TBNoNWOxDFl1vY/p15yM6uq1mbU7/I5V/yzzivbwI8qiCLQovAhrzfN7mHEeKfFuTdTZVBOp/QjaRqGurfO12aNOw2d9KFoC+klpY8es3AhDu8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMVm+w4rQYTQQvMoTBNiExOv9MjyQJmMuO42lSrvZo4=;
 b=crg7bY9F6lE/OZi42rQWup718r0jR3X+G2RWYNVAALk8fXQzgwyU508Vnq33n8eejNdmh5jmyvkMe63NaGZi7GF/ERcCVPZLFyGZyRUafqbaVYPet0XJJ8p6KhghNyhJLRUn7rYrZxF5cIqvVk+ql7RpxByNZklDgo2FENpw7z5kywCuDNa8SZ6+QlDxJ6TjSKIxA5sUe567VtCC7bB7AKMYqEYU+AkcC8ZyPTEWyIiZyDU91+1Y+dvrTce9LhfJo55gizxPz/m9ANIh04uOgWozJeTeppZf3U4Erzhmjrh7YN+ZKaz+QUKXb3dT9EoqCMgwZAFtWJpPEoBpRFcbvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMVm+w4rQYTQQvMoTBNiExOv9MjyQJmMuO42lSrvZo4=;
 b=aqhcsn74iopy32W1816q1grzVC8InoYsflSL8g48tKOxA77hkSUxAE2l1fcdYd9jtFoLCUmKl44oYpmGdNnDfU53exhyZh7SqO8Cm4Roj9aiVf4de8+kmBtT+4chWuSclNdmDFrExhC/cCCn8iHmNerJRCepLe+WVNSm4TZ/uxk=
Received: from SN6PR16CA0067.namprd16.prod.outlook.com (2603:10b6:805:ca::44)
 by LV8PR12MB9155.namprd12.prod.outlook.com (2603:10b6:408:183::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 07:51:31 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:805:ca:cafe::75) by SN6PR16CA0067.outlook.office365.com
 (2603:10b6:805:ca::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Fri, 7 Jun 2024 07:51:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 7 Jun 2024 07:51:30 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 7 Jun
 2024 02:51:26 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J .
 Wysocki" <rafael@kernel.org>, =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?=
	<roger.pau@citrix.com>
CC: <xen-devel@lists.xenproject.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>, Huang Rui
	<Ray.Huang@amd.com>, Jiqian Chen <Jiqian.Chen@amd.com>, Huang Rui
	<ray.huang@amd.com>
Subject: [RFC KERNEL PATCH v8 1/3] xen/pci: Add xen_reset_device_function_state
Date: Fri, 7 Jun 2024 15:51:07 +0800
Message-ID: <20240607075109.126277-2-Jiqian.Chen@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|LV8PR12MB9155:EE_
X-MS-Office365-Filtering-Correlation-Id: 928a9cb5-6ea4-4008-bf46-08dc86c6a4e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aDjIB9rY12E5p5u8juaALLAd34EcSmifUvcr68eOpQVKMmmiKwoSxNLjDsIb?=
 =?us-ascii?Q?u/QBvcl+fEDlb06aqQl4lfDXZjZ9JM3tHbOD/CCyvMCp4YrIoDoAGPW2SUAH?=
 =?us-ascii?Q?fQLRhZf9iLIqbWgnthHBUaY0JJr/dOOpdaEq89p9ie7hIoR7/GG3I946Mgfz?=
 =?us-ascii?Q?6rZk1XaA1HY5fLAl5HA/vqxDB/1lCTvre4/BVBHGQHobpFqotzQftuBe7AQt?=
 =?us-ascii?Q?OWYL+boxKovPF9mjtApGNens/9JbGVT9/tfIg5I8Jmocv1sBTRe7GOWNtED1?=
 =?us-ascii?Q?fe5bc80GGYiW6f22tmiVHVAMpxpwEfVSTptXf+xVJv/po3pvAdiWpgS2qCt9?=
 =?us-ascii?Q?fnqNd14i9HmrJxKQK3huKuWRBE8rr1cwulPhQYpmZq4nsIWYpGlbiHe8Eryx?=
 =?us-ascii?Q?NllzLoQ++CxV3FbmNgcQXLy3uG/4IZ5VjoCoqh8aNIEXTrejDbPgp4ww9lHw?=
 =?us-ascii?Q?mj7sdFIjk2CkGAkWq9rFZ7hqMNkC9Em1AUvKJwu+TdFcJLohGkOcZ+xNslCa?=
 =?us-ascii?Q?hIQtzmHHqnHemuA5aQ7MMXP38nnQtSS6ZfBqD7ZMANyk4263eZQAG/0i9DZv?=
 =?us-ascii?Q?2ouOisTNZJCkQ4uQkAu+vuDS/2ftOzdALxa0KcUqZx6H0U7WBirpm1TnE32y?=
 =?us-ascii?Q?sAGsj698pattta0MpUUzgjZuuLAgynya7Nob+cleKzJJ0EeP4auwsy1R38qE?=
 =?us-ascii?Q?0NVHyxB8KLTJgy06PBl1snOC34THdt4+5nXbkYYeGtrZrWysTHV9DPI+55n5?=
 =?us-ascii?Q?mRZnuwDtwECofsH9F+BPeRtF3z8PSKMtqZfcwJjCKblEQr6QQWLqPwikg02e?=
 =?us-ascii?Q?uKsYgVzeePA1pQXqq54kCtRsBu6ZudRuOiGkgxiom6+EQCZRdOV6b+2mtkxR?=
 =?us-ascii?Q?qAVsNCQzXktyAH32L2WUjo4ajHDDt2TNycaxJqKgjEX9xXxdjxpFtMq56p1o?=
 =?us-ascii?Q?+ApDlCFH3TcV7ZwqDVLf7xo5brRK95UYG/MqYj3gdyDNmwsFhYf21bJipeIU?=
 =?us-ascii?Q?uYnOs2xvD0gNEZDJo2g3INUbzC2QoMZF/gkmA1aVoCSJbk6e6IV+ZVIHVLP3?=
 =?us-ascii?Q?WWndboiRZ2Zv7TYXjjF8kQh3P8iPYfq7fp2poNZZ1umhOVLK8zRIBzOGK41o?=
 =?us-ascii?Q?zxhiTF5jX4lyjHwe2H/ZtfZ7NoQ6vapxyyEUmvmWrhpefOImuXoTna0bddcH?=
 =?us-ascii?Q?rY2th1iZGHwd5LZk8c+y97imJxhMPxuoRl1Kq9onQVd8rXVXF9zXDYNZSqVp?=
 =?us-ascii?Q?qeBISLhFhHJf5bUYKsO+xiC9E2yQidxpoesApHmPu5MzV/qbPLMSc2F33e4y?=
 =?us-ascii?Q?ZDKuKnFSHDoD70GyDfi82EMqJvLH6ty3wTpSaORarwIUESs3doqGA6f6lQzS?=
 =?us-ascii?Q?VTJuk9THDunQ5f2nReJd6WkgAE0ctvoDpWS5oGjQ72cL6AMjXQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 07:51:30.6734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 928a9cb5-6ea4-4008-bf46-08dc86c6a4e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9155

When device on dom0 side has been reset, the vpci on Xen side
won't get notification, so that the cached state in vpci is
all out of date with the real device state.
To solve that problem, add a new function to clear all vpci
device state when device is reset on dom0 side.

And call that function in pcistub_init_device. Because when
using "pci-assignable-add" to assign a passthrough device in
Xen, it will reset passthrough device and the vpci state will
out of date, and then device will fail to restore bar state.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
RFC: it need to wait for the corresponding first patch on xen side to be merged.
---
 drivers/xen/pci.c                  | 25 +++++++++++++++++++++++++
 drivers/xen/xen-pciback/pci_stub.c | 18 +++++++++++++++---
 include/xen/interface/physdev.h    |  7 +++++++
 include/xen/pci.h                  |  6 ++++++
 4 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/pci.c b/drivers/xen/pci.c
index 72d4e3f193af..57093e395982 100644
--- a/drivers/xen/pci.c
+++ b/drivers/xen/pci.c
@@ -177,6 +177,31 @@ static int xen_remove_device(struct device *dev)
 	return r;
 }
 
+enum pci_device_state_reset_type {
+	DEVICE_RESET_FLR,
+	DEVICE_RESET_COLD,
+	DEVICE_RESET_WARM,
+	DEVICE_RESET_HOT,
+};
+
+struct pci_device_state_reset {
+	struct physdev_pci_device dev;
+	enum pci_device_state_reset_type reset_type;
+};
+
+int xen_reset_device_function_state(const struct pci_dev *dev)
+{
+	struct pci_device_state_reset device = {
+		.dev.seg = pci_domain_nr(dev->bus),
+		.dev.bus = dev->bus->number,
+		.dev.devfn = dev->devfn,
+		.reset_type = DEVICE_RESET_FLR,
+	};
+
+	return HYPERVISOR_physdev_op(PHYSDEVOP_pci_device_state_reset, &device);
+}
+EXPORT_SYMBOL_GPL(xen_reset_device_function_state);
+
 static int xen_pci_notifier(struct notifier_block *nb,
 			    unsigned long action, void *data)
 {
diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index e34b623e4b41..73062e531c34 100644
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
+		return xen_reset_device_function_state(dev);
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
index a237af867873..b50646c993dd 100644
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
+#define PHYSDEVOP_pci_device_state_reset 32
+
 struct physdev_pci_device {
     /* IN */
     uint16_t seg;
diff --git a/include/xen/pci.h b/include/xen/pci.h
index b8337cf85fd1..7941809ab729 100644
--- a/include/xen/pci.h
+++ b/include/xen/pci.h
@@ -4,10 +4,16 @@
 #define __XEN_PCI_H__
 
 #if defined(CONFIG_XEN_DOM0)
+int xen_reset_device_function_state(const struct pci_dev *dev);
 int xen_find_device_domain_owner(struct pci_dev *dev);
 int xen_register_device_domain_owner(struct pci_dev *dev, uint16_t domain);
 int xen_unregister_device_domain_owner(struct pci_dev *dev);
 #else
+static inline int xen_reset_device_function_state(const struct pci_dev *dev)
+{
+	return -1;
+}
+
 static inline int xen_find_device_domain_owner(struct pci_dev *dev)
 {
 	return -1;
-- 
2.34.1


