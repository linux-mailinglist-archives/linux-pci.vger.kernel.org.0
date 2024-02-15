Return-Path: <linux-pci+bounces-3543-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE0F856DED
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 20:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1F411C215FD
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 19:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5EA41A81;
	Thu, 15 Feb 2024 19:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uioI07RQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98FC4369A;
	Thu, 15 Feb 2024 19:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708026110; cv=fail; b=onBt6OGUGJa+aJvphmC7Wm3qF70C4A0xFSXgwDoweHJ5q3jZDGlEhyPBfS7aJsm83qw4pp2MOmMx7uxnSzCLs7B+CrmGBT4AFfJ4ifIELFmSfSPhT8VYxpSkBVZK8x9J44YUUYC7bAIKM56XZ3VF0kT0Fju0x7dkEtnviPXhPUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708026110; c=relaxed/simple;
	bh=kJf7OCqsn00EBL85qqVc6dg2ZX/QnanrxhbR2VUdE+Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uOZK6TZ2L00GBT3ILDzA6OQopQmJJbpt79mZF5Tu6lC3nOy92GqLR9Kx74GaHEtVoh7bxf53SYEfaLZzvCCItkiQ6kWdr4eYs2+ZHLLDQ2J8+6RhIrHiLtwnq9Bzg6qIu4od21z9UugVcT+/sZyGzcpA6BfvMgPd59apgjybKJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uioI07RQ; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJw1ydgQz2ssJi9SDe2/fDRo+fuW3E0Me1OB4K6gjMnHVuu/ovHd1v8KlELTTV/8Pc17dC+EGuzDj+GpmMP0DGeqzR0PdYp7S1sp1oSRobaTIBE99C3D4+PtMC3w1ZXu1XP9b/pr38b/ULNXg95s6Od9tuFGJxVkFihh3oCvv75+WEUzm+vlL3RC5mNWhldvj/flUo3RIIt21MdHGvloXwZSqfgjEyh8rWYOUwJnj+c8dHb90P3UEmPasGNqtsEHvxIeqB003pKhwpJK1voiQ/7TKAIjjOZ7IKk3y38qQx/GAS2keAhaXUsfxYETpfTfLSU4NoHVk1Ixm8LR4nmGOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RI2rl1tXxsY5+6H4RhhH/SbKm9qbk7z1wKe50jcZOyA=;
 b=YCc6FUlyoTjwao9BJ64k9lZcz/AKX8LFM46jDV9Th+hWzunjH/SHpKVq0FOHqu2msube0ZCNXRWsA9Ip3cNyh2//R9DIkLN+F8GjzRAoMYKJpU5KdfgAWPsjGAKP0tMe4f/1ParRX6NrFBXmHBx4tuYWZKcQMJTGzOCnpbDT3HjyxDyr2+mUV5eVmZrQCJV3xfFyS5IXmTNkPDzLxCBStM5Uo2zhS/lcpj1XcjVwq6sSjVkEl8mvBNEezzu4eGId9i7/XcDLZ9otW0ZnDJ05wxcObPsl9Qu+ifBsfI0+N1wwrGAVd0hTN70TWo+NXRSBirhDYXYGxjL+xSNjaGfFaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RI2rl1tXxsY5+6H4RhhH/SbKm9qbk7z1wKe50jcZOyA=;
 b=uioI07RQPlqMH5OizPhRgWc6HnHuRbZedOs41m1XL1qFEtviaaTiq0Tig9i1kMPNSE2D83d8AvZyT7+RPzcn8yHdjYn7d/TfYdL1BnxJwwEShkelbqQUp0naDZGvHjpakAzZmb26szne2eBZWmDRXB+Q3nduSuUhljgIRDRa8jU=
Received: from BN0PR10CA0002.namprd10.prod.outlook.com (2603:10b6:408:143::16)
 by MN2PR12MB4565.namprd12.prod.outlook.com (2603:10b6:208:26b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Thu, 15 Feb
 2024 19:41:46 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:143:cafe::99) by BN0PR10CA0002.outlook.office365.com
 (2603:10b6:408:143::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Thu, 15 Feb 2024 19:41:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 15 Feb 2024 19:41:46 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 13:41:42 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>,
	<benjamin.cheatham@amd.com>
Subject: [RFC PATCH 3/6] pcie/cxl_timeout: Add CXL.mem timeout range programming
Date: Thu, 15 Feb 2024 13:40:45 -0600
Message-ID: <20240215194048.141411-4-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215194048.141411-1-Benjamin.Cheatham@amd.com>
References: <20240215194048.141411-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|MN2PR12MB4565:EE_
X-MS-Office365-Filtering-Correlation-Id: e15fccc8-062f-480f-3955-08dc2e5e252e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mkEkJBkGWzfMLP1Hw9NzBXBWbO6Y+OsRigdSMjN8K4++8kmWJilre6oZ9/o2Ap2ivlYy7WDBs644efNOC9nekvO8sWNne7brqQzfXjXIkGCB/zn2M/p7flsuDqjWnUM7Brsdxq3UgX7PAKeF48zVM6gOgDoNy7IY7Trt3k8hgCGsuOErr+6hyNpuRMXwFEUSdn8wPi4Gu9oQjnp4ExONUG1VD4lwFHvyr8fymryNB8OsJjq7kiPmjyVvn4XGb2au7n4CQ5tFEUAZQnh3NP+mvilHQDrlDjO2bKL/CUvxxDH/tltrUlPOwWSX6HHWrGT1sT3KSuwsMM5tsGjLRb1ACo66p/nfrEunSuKlbWKM2JY6SzbTWh6U644sXbAtdqgFHYL2ZFlXUcgJ1TYab/h24qq9ZgWRYsrOGSrpF48RrXkB0jrPEquHFjcIL98g90cqovsqyyRkoQOrkFX71epl3VpXD2u7qjqI+uxj1dKS2PsDxcdWvv0WR29wUP2XHtiDhNI09CC8FxDc3b0ldfDHennm07u3n4D0iGdxZPcUhbGmCULMNyWSpBla//N4BWUjuyFMOKBJHWVE7SbmTNcdUMMf2iyCPepuTITSTy2Uct/rHfnIenFfXuGr2x23jcA7qUhbJjtqKo9Es0ZWmZgPVBXv1uMtghAigdLEaLaNR+E=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(186009)(82310400011)(1800799012)(64100799003)(36860700004)(451199024)(40470700004)(46966006)(4326008)(8936002)(2906002)(7416002)(86362001)(5660300002)(336012)(426003)(83380400001)(26005)(356005)(82740400003)(36756003)(16526019)(1076003)(7696005)(2616005)(110136005)(54906003)(70206006)(70586007)(81166007)(316002)(8676002)(478600001)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 19:41:46.5045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e15fccc8-062f-480f-3955-08dc2e5e252e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4565

Add programming of CXL.mem transaction timeout range (CXL 3.0 8.2.4.23.1
bits 4 & 11:8) through sysfs. To program the device, read the ranges
supported from "available_timeout_ranges" in the PCIe service device
directory, then write the desired value to "timeout_range". The current
value can be found by reading from "timeout_range".

Example for CXL-enabled PCIe port 0000:0c:00.0, with CXL timeout
service as 020:
 # cd /sys/bus/pci_express/devices/0000:0c:00.0:pcie020
 # cat available_timeout_ranges
 0x0	Default range (50us-10ms)
 0x1	Range A (50us-100us)
 0x2	Range A (1ms-10ms)
 # cat timeout_range
 0
 # echo 0x2 > timeout_range
 # cat timeout_range
 2

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/cxl.h              |  13 +++
 drivers/pci/pcie/cxl_timeout.c | 185 +++++++++++++++++++++++++++++++++
 2 files changed, 198 insertions(+)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 0c65f4ec7aae..4aa5fecc43bd 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -129,11 +129,24 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 
 /* CXL 3.0 8.2.4.23 CXL Timeout and Isolation Capability Structure */
 #define CXL_TIMEOUT_CAPABILITY_OFFSET 0x0
+#define   CXL_TIMEOUT_CAP_MEM_TIMEOUT_MASK GENMASK(3, 0)
 #define   CXL_TIMEOUT_CAP_MEM_TIMEOUT_SUPP BIT(4)
 #define CXL_TIMEOUT_CONTROL_OFFSET 0x8
+#define   CXL_TIMEOUT_CONTROL_MEM_TIMEOUT_MASK GENMASK(3, 0)
 #define   CXL_TIMEOUT_CONTROL_MEM_TIMEOUT_ENABLE BIT(4)
 #define CXL_TIMEOUT_CAPABILITY_LENGTH 0x10
 
+/* CXL 3.0 8.2.4.23.2 CXL Timeout and Isolation Control Register, bits 3:0 */
+#define CXL_TIMEOUT_TIMEOUT_RANGE_DEFAULT 0x0
+#define CXL_TIMEOUT_TIMEOUT_RANGE_A1 0x1
+#define CXL_TIMEOUT_TIMEOUT_RANGE_A2 0x2
+#define CXL_TIMEOUT_TIMEOUT_RANGE_B1 0x5
+#define CXL_TIMEOUT_TIMEOUT_RANGE_B2 0x6
+#define CXL_TIMEOUT_TIMEOUT_RANGE_C1 0x9
+#define CXL_TIMEOUT_TIMEOUT_RANGE_C2 0xA
+#define CXL_TIMEOUT_TIMEOUT_RANGE_D1 0xD
+#define CXL_TIMEOUT_TIMEOUT_RANGE_D2 0xE
+
 /* RAS Registers CXL 2.0 8.2.5.9 CXL RAS Capability Structure */
 #define CXL_RAS_UNCORRECTABLE_STATUS_OFFSET 0x0
 #define   CXL_RAS_UNCORRECTABLE_STATUS_MASK (GENMASK(16, 14) | GENMASK(11, 0))
diff --git a/drivers/pci/pcie/cxl_timeout.c b/drivers/pci/pcie/cxl_timeout.c
index 84f2df0e0397..916dbaf2bb58 100644
--- a/drivers/pci/pcie/cxl_timeout.c
+++ b/drivers/pci/pcie/cxl_timeout.c
@@ -20,6 +20,8 @@
 #include "../../cxl/cxlpci.h"
 #include "portdrv.h"
 
+#define NUM_CXL_TIMEOUT_RANGES 9
+
 struct cxl_timeout {
 	struct pcie_device *dev;
 	void __iomem *regs;
@@ -130,6 +132,57 @@ static struct pcie_cxlt_data *cxlt_create_pdata(struct pcie_device *dev)
 	return data;
 }
 
+static bool cxl_validate_timeout_range(struct cxl_timeout *cxlt, u8 range)
+{
+	u8 timeout_ranges = FIELD_GET(CXL_TIMEOUT_CAP_MEM_TIMEOUT_MASK,
+				      cxlt->cap);
+
+	if (!timeout_ranges)
+		return false;
+
+	switch (range) {
+	case CXL_TIMEOUT_TIMEOUT_RANGE_DEFAULT:
+		return true;
+	case CXL_TIMEOUT_TIMEOUT_RANGE_A1:
+	case CXL_TIMEOUT_TIMEOUT_RANGE_A2:
+		return timeout_ranges & BIT(0);
+	case CXL_TIMEOUT_TIMEOUT_RANGE_B1:
+	case CXL_TIMEOUT_TIMEOUT_RANGE_B2:
+		return timeout_ranges & BIT(1);
+	case CXL_TIMEOUT_TIMEOUT_RANGE_C1:
+	case CXL_TIMEOUT_TIMEOUT_RANGE_C2:
+		return timeout_ranges & BIT(2);
+	case CXL_TIMEOUT_TIMEOUT_RANGE_D1:
+	case CXL_TIMEOUT_TIMEOUT_RANGE_D2:
+		return timeout_ranges & BIT(3);
+	default:
+		pci_info(cxlt->dev->port, "Invalid timeout range: %d\n",
+			 range);
+		return false;
+	}
+}
+
+static int cxl_set_mem_timeout_range(struct cxl_timeout *cxlt, u8 range)
+{
+	u32 cntrl;
+
+	if (!cxlt)
+		return -ENXIO;
+
+	if (!FIELD_GET(CXL_TIMEOUT_CAP_MEM_TIMEOUT_MASK, cxlt->cap)
+	    || !cxl_validate_timeout_range(cxlt, range))
+		return -ENXIO;
+
+	cntrl = readl(cxlt->regs + CXL_TIMEOUT_CONTROL_OFFSET);
+	cntrl &= ~CXL_TIMEOUT_CONTROL_MEM_TIMEOUT_MASK;
+	cntrl |= CXL_TIMEOUT_CONTROL_MEM_TIMEOUT_MASK & range;
+	writel(cntrl, cxlt->regs + CXL_TIMEOUT_CONTROL_OFFSET);
+
+	pci_dbg(cxlt->dev->port,
+		 "Timeout & isolation timeout set to range 0x%x\n", range);
+	return 0;
+}
+
 static void cxl_disable_timeout(void *data)
 {
 	struct cxl_timeout *cxlt = data;
@@ -154,6 +207,135 @@ static int cxl_enable_timeout(struct pcie_device *dev, struct cxl_timeout *cxlt)
 					cxlt);
 }
 
+static ssize_t timeout_range_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	struct pcie_device *pdev = to_pcie_device(dev);
+	struct pcie_cxlt_data *pdata = get_service_data(pdev);
+	u32 cntrl, range;
+
+	if (!pdata || !pdata->cxlt)
+		return -ENXIO;
+
+	cntrl = readl(pdata->cxlt->regs + CXL_TIMEOUT_CONTROL_OFFSET);
+
+	range = FIELD_GET(CXL_TIMEOUT_CONTROL_MEM_TIMEOUT_MASK, cntrl);
+	return sysfs_emit(buf, "%u\n", range);
+}
+
+static ssize_t timeout_range_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct pcie_device *pdev = to_pcie_device(dev);
+	struct pcie_cxlt_data *pdata = get_service_data(pdev);
+	u8 range;
+	int rc;
+
+	if (kstrtou8(buf, 16, &range) < 0)
+		return -EINVAL;
+
+	if (!pdata || !pdata->cxlt)
+		return -ENXIO;
+
+	rc = cxl_set_mem_timeout_range(pdata->cxlt, range);
+	if (rc)
+		return rc;
+
+	return count;
+}
+static DEVICE_ATTR_RW(timeout_range);
+
+const struct cxl_timeout_range {
+	const char *str;
+	u8 range_val;
+} cxl_timeout_ranges[NUM_CXL_TIMEOUT_RANGES] = {
+		{ "Default range (50us-10ms)",
+			CXL_TIMEOUT_TIMEOUT_RANGE_DEFAULT },
+		{ "Range A (50us-100us)",
+			CXL_TIMEOUT_TIMEOUT_RANGE_A1 },
+		{ "Range A (1ms-10ms)",
+			CXL_TIMEOUT_TIMEOUT_RANGE_A2 },
+		{ "Range B (16ms-55ms)",
+			CXL_TIMEOUT_TIMEOUT_RANGE_B1 },
+		{ "Range B (65ms-210ms)",
+			CXL_TIMEOUT_TIMEOUT_RANGE_B2 },
+		{ "Range C (260ms-900ms)",
+			CXL_TIMEOUT_TIMEOUT_RANGE_C1 },
+		{ "Range C (1s-3.5s)",
+			CXL_TIMEOUT_TIMEOUT_RANGE_C2 },
+		{ "Range D (4s-13s)",
+			CXL_TIMEOUT_TIMEOUT_RANGE_D1 },
+		{ "Range D (17s-64s)",
+			CXL_TIMEOUT_TIMEOUT_RANGE_D2 },
+};
+
+static ssize_t available_timeout_ranges_show(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
+{
+	struct pcie_device *pdev = to_pcie_device(dev);
+	struct pcie_cxlt_data *pdata = get_service_data(pdev);
+	ssize_t count = 0;
+	u8 range;
+
+	if (!pdata || !pdata->cxlt)
+		return -ENXIO;
+
+	for (int i = 0; i < ARRAY_SIZE(cxl_timeout_ranges); i++) {
+		range = cxl_timeout_ranges[i].range_val;
+
+		if (cxl_validate_timeout_range(pdata->cxlt, range)) {
+			count += sysfs_emit_at(buf, count, "0x%x\t%s\n",
+					       cxl_timeout_ranges[i].range_val,
+					       cxl_timeout_ranges[i].str);
+		}
+	}
+
+	return count;
+}
+static DEVICE_ATTR_RO(available_timeout_ranges);
+
+static umode_t cxl_timeout_is_visible(struct kobject *kobj,
+				       struct attribute *attr, int val)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct pcie_device *pdev = to_pcie_device(dev);
+	struct pcie_cxlt_data *pdata = get_service_data(pdev);
+	u32 cap;
+
+	if (!pdata || !pdata->cxlt)
+		return 0;
+
+	cap = pdata->cxlt->cap;
+
+	if ((attr == &dev_attr_timeout_range.attr) &&
+	    cap & CXL_TIMEOUT_CAP_MEM_TIMEOUT_SUPP)
+		return attr->mode;
+
+	if ((attr == &dev_attr_available_timeout_ranges.attr) &&
+	    (FIELD_GET(CXL_TIMEOUT_CAP_MEM_TIMEOUT_MASK, cap)))
+		return attr->mode;
+
+	return 0;
+}
+static struct attribute *cxl_timeout_timeout_attributes[] = {
+	&dev_attr_timeout_range.attr,
+	&dev_attr_available_timeout_ranges.attr,
+	NULL,
+};
+
+static struct attribute_group cxl_timeout_timeout_group = {
+	.attrs = cxl_timeout_timeout_attributes,
+	.is_visible = cxl_timeout_is_visible,
+};
+
+static const struct attribute_group *cxl_timeout_attribute_groups[] = {
+	&cxl_timeout_timeout_group,
+	NULL,
+};
+
 static int cxl_timeout_probe(struct pcie_device *dev)
 {
 	struct pci_dev *port = dev->port;
@@ -187,6 +369,9 @@ static struct pcie_port_service_driver cxltdriver = {
 	.service	= PCIE_PORT_SERVICE_CXLT,
 
 	.probe		= cxl_timeout_probe,
+	.driver		= {
+		.dev_groups = cxl_timeout_attribute_groups,
+	},
 };
 
 int __init pcie_cxlt_init(void)
-- 
2.34.1


