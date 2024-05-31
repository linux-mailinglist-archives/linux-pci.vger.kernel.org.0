Return-Path: <linux-pci+bounces-8146-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7A28D6BC3
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 23:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D24AE1C236F0
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 21:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A9E1DDD1;
	Fri, 31 May 2024 21:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zvi+4+jt"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A4D8249E;
	Fri, 31 May 2024 21:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717191598; cv=fail; b=jtbDSd4k2kt8/7QRwfUuTbSI271B3qv0ZHCwRUIci00zHIORBbiN9c+I5bqtaahVDkT1/LgVPyEOBMaD8G7Wsxf4yEad0OnM4/x++oUZFp9egLS96jB2/it0OQ1CAfS5LpSvHIUBvrqNffFlxbdUOhe6oxLO/O7+NRjMieQxvNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717191598; c=relaxed/simple;
	bh=ze5WfOe+D4ySVTHAEZS7qudi74rejujs48vqCgwz1aI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pGeAwhayI/DEuNsMed4erdRF86D2zHWAymcYIREYfi+JDKJoURvGsRIUqBflNJ+zESjEurSGrf00TUEXxX78em1cjeIn/r8tte8gXkc1vqH2REWkPYMiyXsboQvYh5LNnezbpjfBxi7nAlwq2mGwQk/ihRuli0Cz71YyJx5jSX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zvi+4+jt; arc=fail smtp.client-ip=40.107.102.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqpZK1loVVgxrwTCDdGuVHDLuE3hxIq9H5ehzHcdtZwYpOyfIVvZCHWNnHCO88IRnww3bjIXrcVoTbkvNmnY2Swy5iIUZYPnkRIodo7znyGU7od1fJrPrtRhtj28ePekPJcPHU1kYidpYHIeBTtEbxiLdn+1anzebDf04DiOBtycaBRrWTe5fvCZNv/fW3AQSo7VH1I3Rb377pZIbAhIhjbP/feqM6STz7Zut9xRty1s/Umlngkib/UEFRXX/2eV9HdwdIJThBTy+zqbYzy/Id3wT5hPfR2mvW+2NxWVudQAPiDbcdlfT7dI1kARSv/HX8bBiyiB3WazUvXqklLzsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOzRGb8DxJNJFzmxTVXHq+t764c0uTSA2LqkTrWP360=;
 b=Vk7338I2xATuYl8WMRDdavEo/yOimgabQ5yVd85fDcSsPSx2F+z3rN5Q++2lUk19i/jVnK0kXySj42vdWJjZ8Okjk2gsiiluoysJs9EdBzJBw4XIdwO8nc1Ohmhfaar+qZFlKWiVG7cW/y9ypy3nFaPxZx1B74U0qtn399SMw1+fKOUQRsaoIT1Xpb6jSJlTc/BeOyOw0gKpv6f2zMLJaI/+gFG79gYjrFpXGjRoBEXi+vTFR8+icZCBK3yAUl2hL+kWTTvvMebvBfjFYTToCcPKEUrlbhcrLZYpYMFUcJIqHol144pjRgEF/bgW+dsW+5KA3DllJtiJEE2dXW4tKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOzRGb8DxJNJFzmxTVXHq+t764c0uTSA2LqkTrWP360=;
 b=Zvi+4+jtKV9hyEDql2DY4ka6w9Zj3533HU6jZpY1o7sawMbnqzzQHUTUPYuoGomQNqCb7MxqryNAuhMNB546EBtlyWlgiKzBsT64o1goUDfCsvpsyIJlEy3GeWSI0ISTL0Tr6JUODETXnN4LGGJSIvzOFn8wagGIl89gFcGGbM8=
Received: from CY8PR11CA0036.namprd11.prod.outlook.com (2603:10b6:930:4a::22)
 by SN7PR12MB7370.namprd12.prod.outlook.com (2603:10b6:806:299::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Fri, 31 May
 2024 21:39:54 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:4a:cafe::3c) by CY8PR11CA0036.outlook.office365.com
 (2603:10b6:930:4a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22 via Frontend
 Transport; Fri, 31 May 2024 21:39:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 21:39:53 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 16:39:52 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <bhelgaas@google.com>, <corbet@lwn.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<alex.williamson@redhat.com>, <gospo@broadcom.com>,
	<michael.chan@broadcom.com>, <ajit.khaparde@broadcom.com>,
	<somnath.kotur@broadcom.com>, <andrew.gospodarek@broadcom.com>,
	<manoj.panicker2@amd.com>, <Eric.VanTassell@amd.com>, <wei.huang2@amd.com>,
	<vadim.fedorenko@linux.dev>, <horms@kernel.org>, <bagasdotme@gmail.com>
Subject: [PATCH V2 4/9] PCI/TPH: Implement a command line option to force No ST Mode
Date: Fri, 31 May 2024 16:38:36 -0500
Message-ID: <20240531213841.3246055-5-wei.huang2@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240531213841.3246055-1-wei.huang2@amd.com>
References: <20240531213841.3246055-1-wei.huang2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|SN7PR12MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: c257b5a7-cd46-446b-8575-08dc81ba3548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|1800799015|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b7GJdae/2AMIeGdOE/YfdUUWdtgecdgt6+zuFBfRLkHUhPpBzlmZGnP9ikcU?=
 =?us-ascii?Q?BpAzFqNhQTVWbBZNVm32f9WOyzWNEGo2zE9K5NXV/O2tpT/Sa0l+S1L7b0T5?=
 =?us-ascii?Q?ttNaemC75PpmnuFQF9FQUhjGa69jaYoSuzwJPfUhYT2ppZRAErvA0y8o+SJr?=
 =?us-ascii?Q?MFUOOQ8s32spEg0i4X0c5JfO2/deHwVz+UQE2Da61tkgIwgFoTolsv1DApeW?=
 =?us-ascii?Q?mes60T4Zt4yCkyj4MLORMGxF5sGQnV/xWwoyunl9EJbm27rJWNwjscnCsxAj?=
 =?us-ascii?Q?eCGzPbheghDF3bTn6RNztMT9rXxonVBC02TPmZLee36MQDFMFWvaj1eEKdOL?=
 =?us-ascii?Q?g3aUXF/yDv7ubj508WhrOJJeMmvS3ROLlmmkdUKOc8L5cDPGks1rj8jk8bFb?=
 =?us-ascii?Q?Ts79uVrZmpLAKyA/HB2YgeEeh+IYUr8+f1kLLxsPgfnUK3gbaibla/9wNOmy?=
 =?us-ascii?Q?Vz9qUCiRfWA/9Mc+2p+apAJaVi0e2T4CgeOZkOAKIzPw3vk95DDpLlfnEyPz?=
 =?us-ascii?Q?DfjT1FRWDNebE871xHtVA12f4YBLom6xjuMk8b53TZ6uuhfcUja5/4him/db?=
 =?us-ascii?Q?7mdIo9cWYA0emyk2go7OG6x7GclVfu4UuzxZlPafsSH2R6MWHjB5JQSsl1FY?=
 =?us-ascii?Q?htjTPplSBPM6mGw21mvk9RetiW1SZcV9FQ/+TV+lGRvwpo1cNvLo+hgHS4GE?=
 =?us-ascii?Q?ZEz04lYMGEO1tsjZ0MD5iMaV359Q9HSuAe5ID36yOIB2Fia7ViLEKwKOVJUd?=
 =?us-ascii?Q?9nHpb7OYU8Xq72DEkP0cWj2OS4x/71S0rrguTO0v4uN5w6WY0FcaUR6p4BWJ?=
 =?us-ascii?Q?oqonyyXo4NH6CdgTn6VieTXlaa5e1TG6ufRuz998sqI/T46bEWR5FAcU10Gx?=
 =?us-ascii?Q?GpO7jKbJtU4PzJo2MP2SAVJxyHLHGGtETYvDSGvx0fSJD/l0GxGCrbVC3Fkg?=
 =?us-ascii?Q?peNB2kfmzYUAOtgjX71BJ76ku3wMB+VZmg/WOV3pP8XsYWU4aCFVkvBxxY0t?=
 =?us-ascii?Q?IgWrbTaweXAckeK/nXDMOYiinfSwGnQyUF3091yiSngV/bsvff33FTGz8Xnu?=
 =?us-ascii?Q?73jd1sAcBzYCxIx6/+QMhQzJwwX4nkig96E/nahv9RfYp1u+d46WcezE3Jkf?=
 =?us-ascii?Q?nG8tv/7j/t/VF9eFsj9FxzIpSR0mDQQSSiXXdZF58xfhccwRD9FfSDfeJaC0?=
 =?us-ascii?Q?RNshiOdPM/F8T+DgcrrE4xs3lozdBF6YsNnaxlNyKbhL5trnKkDsX6utEdrb?=
 =?us-ascii?Q?2S9MKm4h7p47dYwRB0fX72eIyDVqbTZk1U+9OsUrA8J5yJbBC4SQEo2t0n0e?=
 =?us-ascii?Q?jze73Bb95ClNhh1oTOeRB0kFyhPokVCdGeO9fx8RnVQImb09wWJHiGWPy5zd?=
 =?us-ascii?Q?+8N5ADVSU2dIohvoGDABymKVr51m?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 21:39:53.6519
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c257b5a7-cd46-446b-8575-08dc81ba3548
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7370

When "No ST mode" is enabled, end-point devices can generate TPH headers
but with all steering tags treated as zero. A steering tag of zero is
interpreted as "using the default policy" by the root complex. This is
essential to quantify the benefit of steering tags for some given
workloads.

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com> 
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
---
 .../admin-guide/kernel-parameters.txt         |  1 +
 drivers/pci/pci-driver.c                      |  7 ++++++-
 drivers/pci/pci.c                             | 12 +++++++++++
 drivers/pci/pcie/tph.c                        | 21 +++++++++++++++++++
 include/linux/pci-tph.h                       |  3 +++
 include/linux/pci.h                           |  1 +
 6 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fedcc69e35c1..e97a4a239563 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4624,6 +4624,7 @@
 		norid		[S390] ignore the RID field and force use of
 				one PCI domain per PCI function
 		notph		[PCIE] Do not use PCIe TPH
+		nostmode	[PCIE] Force TPH to use No ST Mode
 
 	pcie_aspm=	[PCIE] Forcibly enable or ignore PCIe Active State Power
 			Management.
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 9722d070c0ca..aa98843d9884 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -324,8 +324,13 @@ static long local_pci_probe(void *_ddi)
 	pci_dev->driver = pci_drv;
 	rc = pci_drv->probe(pci_dev, ddi->id);
 	if (!rc) {
-		if (pci_tph_disabled())
+		if (pci_tph_disabled()) {
 			pcie_tph_disable(pci_dev);
+			return rc;
+		}
+
+		if (pci_tph_nostmode())
+			tph_set_dev_nostmode(pci_dev);
 
 		return rc;
 	}
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 31c443504ce9..f3558a551bf2 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -160,6 +160,9 @@ static bool pcie_ats_disabled;
 /* If set, the PCIe TPH capability will not be used. */
 static bool pcie_tph_disabled;
 
+/* If TPH is enabled, "No ST Mode" will be enforced. */
+static bool pcie_tph_nostmode;
+
 /* If set, the PCI config space of each device is printed during boot. */
 bool pci_early_dump;
 
@@ -175,6 +178,12 @@ bool pci_tph_disabled(void)
 }
 EXPORT_SYMBOL_GPL(pci_tph_disabled);
 
+bool pci_tph_nostmode(void)
+{
+	return pcie_tph_nostmode;
+}
+EXPORT_SYMBOL_GPL(pci_tph_nostmode);
+
 /* Disable bridge_d3 for all PCIe ports */
 static bool pci_bridge_d3_disable;
 /* Force bridge_d3 for all PCIe ports */
@@ -6818,6 +6827,9 @@ static int __init pci_setup(char *str)
 			} else if (!strcmp(str, "notph")) {
 				pr_info("PCIe: TPH is disabled\n");
 				pcie_tph_disabled = true;
+			} else if (!strcmp(str, "nostmode")) {
+				pr_info("PCIe: TPH No ST Mode is enabled\n");
+				pcie_tph_nostmode = true;
 			} else if (!strncmp(str, "cbiosize=", 9)) {
 				pci_cardbus_io_size = memparse(str + 9, &str);
 			} else if (!strncmp(str, "cbmemsize=", 10)) {
diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
index 5dc533b89a33..d5f7309fdf52 100644
--- a/drivers/pci/pcie/tph.c
+++ b/drivers/pci/pcie/tph.c
@@ -43,6 +43,27 @@ static int tph_set_reg_field_u32(struct pci_dev *dev, u8 offset, u32 mask,
 	return ret;
 }
 
+int tph_set_dev_nostmode(struct pci_dev *dev)
+{
+	int ret;
+
+	/* set ST Mode Select to "No ST Mode" */
+	ret = tph_set_reg_field_u32(dev, PCI_TPH_CTRL,
+				    PCI_TPH_CTRL_MODE_SEL_MASK,
+				    PCI_TPH_CTRL_MODE_SEL_SHIFT,
+				    PCI_TPH_NO_ST_MODE);
+	if (ret)
+		return ret;
+
+	/* set "TPH Requester Enable" to "TPH only" */
+	ret = tph_set_reg_field_u32(dev, PCI_TPH_CTRL,
+				    PCI_TPH_CTRL_REQ_EN_MASK,
+				    PCI_TPH_CTRL_REQ_EN_SHIFT,
+				    PCI_TPH_REQ_TPH_ONLY);
+
+	return ret;
+}
+
 int pcie_tph_disable(struct pci_dev *dev)
 {
 	return  tph_set_reg_field_u32(dev, PCI_TPH_CTRL,
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index e187d7e89e8c..95269afc8b7d 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -11,9 +11,12 @@
 
 #ifdef CONFIG_PCIE_TPH
 int pcie_tph_disable(struct pci_dev *dev);
+int tph_set_dev_nostmode(struct pci_dev *dev);
 #else
 static inline int pcie_tph_disable(struct pci_dev *dev)
 { return -EOPNOTSUPP; }
+static inline int tph_set_dev_nostmode(struct pci_dev *dev)
+{ return -EOPNOTSUPP; }
 #endif
 
 #endif /* LINUX_PCI_TPH_H */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d88ebe87815a..5f520624d133 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1842,6 +1842,7 @@ static inline bool pci_aer_available(void) { return false; }
 
 bool pci_ats_disabled(void);
 bool pci_tph_disabled(void);
+bool pci_tph_nostmode(void);
 
 #ifdef CONFIG_PCIE_PTM
 int pci_enable_ptm(struct pci_dev *dev, u8 *granularity);
-- 
2.44.0


