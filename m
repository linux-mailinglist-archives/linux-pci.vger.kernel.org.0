Return-Path: <linux-pci+bounces-37053-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 616DEBA1D7B
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 00:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB67E172CAA
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 22:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258DA323F5B;
	Thu, 25 Sep 2025 22:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ejH6F2W1"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011053.outbound.protection.outlook.com [40.107.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F655323F48;
	Thu, 25 Sep 2025 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758839905; cv=fail; b=HS7yFEPZ9AJX3D2W58+qzpkRDBhLkYO6ZYXUPNdqcsEzsuJsHuT5xgA0yoYJFSjAALGQ5/+SHwlZ7bm61btDsoeSOr9HKI7pGIqVCTdlG9GiPc5eu6d8bsQ7RhHRjC2/ernAAUiIoZJc739076BQb0OU4ZqsyEfd27JwYLvdmc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758839905; c=relaxed/simple;
	bh=vNzJai/a21P5El9R5EByPQhYcWFmRqv2vnAJFtiCNeY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=df+lL0cdNtnGSRcGvRfOi36k8MUxgefjDuSb+v7PobItFVEAtAf6GY3gEOAqjdlAGblY2Fj9bcTzxG0kgusIkAmwipkA3NOAn6e/zEgex5+uzEQZYUoV07r+41d3hiRfS31cjTGV1gf1AQWHShoox+N9DSI59sup4/fwduiS+9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ejH6F2W1; arc=fail smtp.client-ip=40.107.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BdfRb21/PLeXWTzIGqZW/VATeybeh/VTq29TSlkbOxH60Y8E/fVoYXNRk+xIsWqRC1zIkBirF+XNI9UmFcwEt+kqczQGlVyqLeESQfSnqcaaBaqBEx1IlwajWpJscZOrB+Mqrf/Gu92UK44BUwmdGO+XPnqY9N9c48R4RP6cE+J/ZuOLgA+/xFt6XBxJKFHIElrMer9YASSWUBFiWkFfSCCX1xU9islafJ+kz2948D7WgaoH8Ni29JFuPHWopIjFXSGv413utcAOx7pa46mM6d78WGUxiLVdqRqZVuyW6nFGCrECFQoB+PrUL3qzY32jl2o+Ul2XrCuOCFu5Ks1mgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoWogMTBG0p4ZG9MjN08jLPOmkVmsiPYzhFCp1kHpPI=;
 b=jNpJoe7Ugznxr8bi9WQ7fgOeg4O/XzoeUDdQHmemUjbhKyhw5AGK9Affe96W3MJCDTtIb9/39sxDTkw0Z9j79MJoz5S33loS4FekEDFUj+y8LuoJEVyuqy6WmQLu+RusVItzz70bpbxJNWZZ5RM2tKx1gwb9CX7rN4PaPVd9D0zwaIK0gU60F0H4W4jR/9uBLtr0IMLHQv3MY094fWTl5r6dOgeaL52YK3vxlu1zxTTL3gWrWR4raoBiTO03Ohj2kfZ+gV2c49L2qotoh+RoGBk7mL4xKi/U9HwofEXPilBlYte1aQIEU6ypKJXOHFkHpwbruzpCbXc0fnCV7Ig9aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoWogMTBG0p4ZG9MjN08jLPOmkVmsiPYzhFCp1kHpPI=;
 b=ejH6F2W16WyL68/RJS9ybK58iAdrl6A9N9GyqKavJnHJFb4gaagXwg3nuQqMcvminn0QWJiRhggns5K8BhK/5Z7VycuskAvo8s8KeTcSnnuDIURfy8+NOYhSxiBGM7GRLSIpzY78S4X2Cq47mIxnmM3ofGAwaNQIpMb6L892oB0=
Received: from PH1PEPF000132E4.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::24)
 by DS4PR12MB9771.namprd12.prod.outlook.com (2603:10b6:8:29b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 22:38:19 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2a01:111:f403:f912::2) by PH1PEPF000132E4.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Thu,
 25 Sep 2025 22:38:19 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 22:38:17 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 15:38:16 -0700
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v12 19/25] cxl: Introduce cxl_pci_drv_bound() to check for bound driver
Date: Thu, 25 Sep 2025 17:34:34 -0500
Message-ID: <20250925223440.3539069-20-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925223440.3539069-1-terry.bowman@amd.com>
References: <20250925223440.3539069-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DS4PR12MB9771:EE_
X-MS-Office365-Filtering-Correlation-Id: cdb78bba-5628-4df4-f2ff-08ddfc8438f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0cqMY5X0HIIDIWGPZNTzRxhCWf4jLN+mKkFTdBLm+mL/N9yqhpBiKzJw1uW1?=
 =?us-ascii?Q?JpDJqaFJ24yNIYlhz46NWoHin72lJWUlH7RxC7ckxE0GybSjlY5VmL0plnjr?=
 =?us-ascii?Q?1K93ZvXML+SY+udxQtKaQzAP08+NwnGGUQnuPzUEYWZnmLZjucqLKxiYpHS3?=
 =?us-ascii?Q?DJPdXPmybAruzV+KAQN9eJarLLVfG7d5oxuVsa0MqHXDvNd1vhRgyF0/7Kxf?=
 =?us-ascii?Q?Ft9usykIigme0y/fTt9hjq2EDsZgNGzuoT9IG2lOaEK6mrKlMYXYYRd3ZvhE?=
 =?us-ascii?Q?EH0tD0fhRDGeUkKeT5ugUL3IhekFaknAL2xfmurubh93zmCIAhlcaaD9q2Y1?=
 =?us-ascii?Q?SOpQVB1bi83nnPFqHqKsdQKuSMSgzK7Zw/dkgmRtGNLDtodMpVil+zoC4AaZ?=
 =?us-ascii?Q?Pqv3Hx14+e2FMi+Q5odDSuOupNh9lBu96EgGW11CHg0tFggl/zaf5Wy5MqmD?=
 =?us-ascii?Q?t6/UvNUnwdBqtCTaLMQUWNB6kLDCrlIhZiqWeAojoVqCiw4hhw5UFP71f9Fc?=
 =?us-ascii?Q?wIZuBnQMIc98CV2j4yaupw311bxmMP2YrhueJdm9WVtYXw4mTtVHDb8RY3eb?=
 =?us-ascii?Q?FdOcoq6pFAzUmXLF7Q6KBhFLwIw8LwgGvDMYiG8oyU5IGBQuJEDiqrITYUEi?=
 =?us-ascii?Q?52a5xt9mA5s8u/JN4+cCC8krA/TQirWJujl2Qmpm02Crc1BfbwTROxKdlQ4z?=
 =?us-ascii?Q?Nlof0Yr9ljPKtInms1YbWddGbUD/b8+J9KtbIavz8A8RdYLxe9guMxIcr3Dc?=
 =?us-ascii?Q?vvPCzRZtVNGm6ZsF9iHWq4aQ0mgAo7lhvwmtu1O1ryrc57tNI0dV7TOTypjc?=
 =?us-ascii?Q?pT/er1se4Pwa688inlqyQKFdLa/yF8pbK+T757tnXbWIZQNYJ7eGCsYOg1/t?=
 =?us-ascii?Q?rKRdUXTBUDmOFWrijStmgjCSuYXEg2Z1OkanrDcShBlbdX5kYuD3o4IWwlo3?=
 =?us-ascii?Q?30huE+c+4XNdKWg8HDg79EmxqmIXi6qxkD0nVyc+bsjK6Eqoe4XLD9sgd5ic?=
 =?us-ascii?Q?INs8Z1L89aa+/PEbRIE6dhdS6/OULeYhEmztK4TBHG1FtGlpvxos2tbvEw3e?=
 =?us-ascii?Q?F5FVP2MhFF7UFwLWrMNUKdegEc2I9ZPV7B9wy9G6IzC6XSIEsYU1EVE+ikrJ?=
 =?us-ascii?Q?Ww61/jltJUxdE9/OVxn8WXtrJQ2fMjEzPuxFL0/nRI7/LYLlrJopIArOlO4V?=
 =?us-ascii?Q?3LQHL4L3lpRLoRg00oO2MMlofX89/0tRhdnmcUmLO3XiREwMn3/++3Zxu3ds?=
 =?us-ascii?Q?ZP8DPYcoPlb/hsenwleqnYMFvWOiLI59LrioXPXdpZzpuGBTFF7nOU43WGKR?=
 =?us-ascii?Q?ZpTr2mSq6amdT0pplf7CzDtzLiaOpFylPQ6o1y0cSs19KeLgrKco4M2sfQLk?=
 =?us-ascii?Q?s+FbQwHrt5MHp779Ga7IpEZy+LjAzyYYJB/wQfM9wIj6RlaoEFXHWfs9XfQH?=
 =?us-ascii?Q?L41F1aH+tywiDCqxJrqnmwMVvW44hQE0A+Kqa5VgbeM9DNYIJuAa0FDITgTx?=
 =?us-ascii?Q?NN6Go/meVbkYHLRnAhBjfppAt1XGFxT6rza11IGhD/CJWOY5L1N+s/UA2Zkf?=
 =?us-ascii?Q?pCDJ0ZJrGZISipTeTYx4+Yr0Yqac7WNPh4Xcl1ab?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 22:38:17.7109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb78bba-5628-4df4-f2ff-08ddfc8438f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9771

CXL devices handle protocol errors via driver-specific callbacks rather
than the generic pci_driver::err_handlers by default. The callbacks are
implemented in the cxl_pci driver and are not part of struct pci_driver, so
cxl_core must verify that a device is actually bound to the cxl_pci
module's driver before invoking the callbacks (the device could be bound
to another driver, e.g. VFIO).

However, cxl_core can not reference symbols in the cxl_pci module because
it creates a circular dependency. This prevents cxl_core from checking the
EP's bound driver and calling the callbacks.

To fix this, move drivers/cxl/pci.c into drivers/cxl/core/pci_drv.c and
build it as part of the cxl_core module. Compile into cxl_core using
CXL_PCI and CXL_CORE Kconfig dependencies. This removes the standalone cxl_pci
module, consolidates the cxl_pci driver code into cxl_core, and eliminates
the circular dependency so cxl_core can safely perform bound-driver checks
and invoke the CXL PCI callbacks.

Introduce cxl_pci_drv_bound() to return boolean depending on if the PCI EP
parameter is bound to a CXL driver instance. This will be used in future
patch when dequeuing work from the kfifo.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v11 -> v12:
- New patch
---
 drivers/cxl/Kconfig                   |  6 +++---
 drivers/cxl/Makefile                  |  2 --
 drivers/cxl/core/Makefile             |  1 +
 drivers/cxl/core/core.h               |  9 +++++++++
 drivers/cxl/{pci.c => core/pci_drv.c} | 16 ++++++++--------
 drivers/cxl/core/port.c               |  3 +++
 6 files changed, 24 insertions(+), 13 deletions(-)
 rename drivers/cxl/{pci.c => core/pci_drv.c} (99%)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 028201e24523..9ee76bae02d5 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -20,7 +20,7 @@ menuconfig CXL_BUS
 if CXL_BUS
 
 config CXL_PCI
-	tristate "PCI manageability"
+	bool "PCI manageability"
 	default CXL_BUS
 	help
 	  The CXL specification defines a "CXL memory device" sub-class in the
@@ -29,12 +29,12 @@ config CXL_PCI
 	  memory to be mapped into the system address map (Host-managed Device
 	  Memory (HDM)).
 
-	  Say 'y/m' to enable a driver that will attach to CXL memory expander
+	  Say 'y' to enable a driver that will attach to CXL memory expander
 	  devices enumerated by the memory device class code for configuration
 	  and management primarily via the mailbox interface. See Chapter 2.3
 	  Type 3 CXL Device in the CXL 2.0 specification for more details.
 
-	  If unsure say 'm'.
+	  If unsure say 'y'.
 
 config CXL_MEM_RAW_COMMANDS
 	bool "RAW Command Interface for Memory Devices"
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index 2caa90fa4bf2..ff6add88b6ae 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -12,10 +12,8 @@ obj-$(CONFIG_CXL_PORT) += cxl_port.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
 obj-$(CONFIG_CXL_MEM) += cxl_mem.o
-obj-$(CONFIG_CXL_PCI) += cxl_pci.o
 
 cxl_port-y := port.o
 cxl_acpi-y := acpi.o
 cxl_pmem-y := pmem.o security.o
 cxl_mem-y := mem.o
-cxl_pci-y := pci.o
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index b2930cc54f8b..91f43c3f2292 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -20,3 +20,4 @@ cxl_core-$(CONFIG_CXL_MCE) += mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
 cxl_core-$(CONFIG_CXL_RAS) += ras.o
+cxl_core-$(CONFIG_CXL_PCI) += pci_drv.o
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 74c64d458f12..9ceff8acf844 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -202,4 +202,13 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		    u16 *return_code);
 #endif
 
+#ifdef CONFIG_CXL_PCI
+bool cxl_pci_drv_bound(struct pci_dev *pdev);
+int cxl_pci_driver_init(void);
+void cxl_pci_driver_exit(void);
+#else
+static inline bool cxl_pci_drv_bound(struct pci_dev *pdev) { return false; };
+static inline int cxl_pci_driver_init(void) { return 0; }
+static inline void cxl_pci_driver_exit(void) { }
+#endif
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/core/pci_drv.c
similarity index 99%
rename from drivers/cxl/pci.c
rename to drivers/cxl/core/pci_drv.c
index 71fb8709081e..746b5017d336 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/core/pci_drv.c
@@ -1132,6 +1132,12 @@ static struct pci_driver cxl_pci_driver = {
 	},
 };
 
+bool cxl_pci_drv_bound(struct pci_dev *pdev)
+{
+	return (pdev->driver == &cxl_pci_driver);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_pci_drv_bound, "CXL");
+
 #define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
 static void cxl_handle_cper_event(enum cxl_event_type ev_type,
 				  struct cxl_cper_event_rec *rec)
@@ -1178,7 +1184,7 @@ static void cxl_cper_work_fn(struct work_struct *work)
 }
 static DECLARE_WORK(cxl_cper_work, cxl_cper_work_fn);
 
-static int __init cxl_pci_driver_init(void)
+int __init cxl_pci_driver_init(void)
 {
 	int rc;
 
@@ -1193,15 +1199,9 @@ static int __init cxl_pci_driver_init(void)
 	return rc;
 }
 
-static void __exit cxl_pci_driver_exit(void)
+void cxl_pci_driver_exit(void)
 {
 	cxl_cper_unregister_work(&cxl_cper_work);
 	cancel_work_sync(&cxl_cper_work);
 	pci_unregister_driver(&cxl_pci_driver);
 }
-
-module_init(cxl_pci_driver_init);
-module_exit(cxl_pci_driver_exit);
-MODULE_DESCRIPTION("CXL: PCI manageability");
-MODULE_LICENSE("GPL v2");
-MODULE_IMPORT_NS("CXL");
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index bd4be046888a..56fa4ac33e8b 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2502,6 +2502,8 @@ static __init int cxl_core_init(void)
 	if (rc)
 		goto err_ras;
 
+	cxl_pci_driver_init();
+
 	return 0;
 
 err_ras:
@@ -2517,6 +2519,7 @@ static __init int cxl_core_init(void)
 
 static void cxl_core_exit(void)
 {
+	cxl_pci_driver_exit();
 	cxl_ras_exit();
 	cxl_region_exit();
 	bus_unregister(&cxl_bus_type);
-- 
2.34.1


