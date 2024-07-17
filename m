Return-Path: <linux-pci+bounces-10467-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A86793437A
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 22:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C98DF1F2254F
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 20:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC5C18C337;
	Wed, 17 Jul 2024 20:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GPUYWI2v"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879571891A8;
	Wed, 17 Jul 2024 20:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721249787; cv=fail; b=mQ+ImVyWU4Y8iRvEqaod+0IaHR0Md9UbtrEHBtP0Srhfc/Ja6bMAFeXCzbXqJGVpdTE6YICha98N+dF2ru11FDMlpbQIlkMcKqSGD+eMO/776UD8hLWVS2jw1A0yry401QqkLiRpk9FFuC4H1qqTqQz2WLyTGhRRvnyJDYbhM6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721249787; c=relaxed/simple;
	bh=1K3LCa5vocgYPoBSuiLhG29kLWujD7ZvMH7xd6nRyNI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kv9kZmEB5SWCRCXek5J3+fCL6lLfHWThfEYq2drL8a/WQb4PlklWG11DURUK0Uk8Hjgy1+oRIv8eErz+Xiez1Y912u77ICC9YNasY181KbXXu6vK5ufqOY/RJMtuztvT71Nn+c2Cb6O8wgKstiBM3DIjx7LJtxSxgT5UT0PtQsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GPUYWI2v; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAoEt4cTVE22+e6RYIUSBycrj6sfLQbR1dpdhA1eodp7fH5z/QU9fMH0LNxZK9b+JkaoSeEDjHkb7wriTASBJvA65n3Tua25MGv+tMFLtR5ZhC8fq4q6zw8S90w72mlyub96NO4Az0czUyXcv/H5fG/u5maRLPCtadFReqvjFFLlbQOE0nQ8f8kz9fhgN1f4CSV32gosVZXFx4GexCAomks08y2x5jBgBZQpgQcws3jR5Nm7IShAo+GDPhVrpMnFaUwfoevrTUnD7LXNUFmxX5vd/rGCueA2vJMCoNXGca9tSdMr7PWDmsF31NplFOMrrjkRbPGNXztM8nM5ruIHeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oso/H67eZTGGUdILBc4BPw64IgKfItSJH2s3crAnDrk=;
 b=S0kNWkuqrhfX5SUBPx5911LW3Uyw2qjYaunJcMtqgqoU4iQ2mFi6a8ZCA5HD6VU/RLakf9fH3fyCZpJ2WrpmYnIOj9zb+r0u4DwE+QgSQaDTl5qCAJ1+ymSpuSn0DrI+1WKzSGRdEUz0DXz7pwY/olIjqepIMYWccbpLwHHr7Gy5hSuCHCEQzO+paOqBcjN9j7FYw330wZJw0K0rbCxOKh12vM90MOuBFSZveZ0kHyaaVYk7l2W+frnkCZUsQPrvEYQHQaeU9usQ2iOLELFjlNsWJfV/CU1zXwqG0TRLqK83bfos2tok/616AvF0MSNE1O1YULuNY3Ac6nUyegUvcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oso/H67eZTGGUdILBc4BPw64IgKfItSJH2s3crAnDrk=;
 b=GPUYWI2vHzR4faZUe7Ff5emQYI3a3WaOfpOR7m6oMEeZ8/rMygGFgBAgDce3ioDPhFJuiOXqxivypNGqUBe9LF4DA9WotwjM+X+2Xd2+WynHJM3Bzfftl165Z8RXVs7nmannIoU2qY1m11hsVjjO0Gx4VPFKHhab9shRPQSGwdM=
Received: from PH3PEPF000040A7.namprd05.prod.outlook.com (2603:10b6:518:1::49)
 by DM4PR12MB7719.namprd12.prod.outlook.com (2603:10b6:8:101::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 20:56:22 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2a01:111:f403:f913::) by PH3PEPF000040A7.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23 via Frontend
 Transport; Wed, 17 Jul 2024 20:56:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 20:56:21 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 15:56:20 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <Jonathan.Cameron@Huawei.com>, <helgaas@kernel.org>, <corbet@lwn.net>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <alex.williamson@redhat.com>, <gospo@broadcom.com>,
	<michael.chan@broadcom.com>, <ajit.khaparde@broadcom.com>,
	<somnath.kotur@broadcom.com>, <andrew.gospodarek@broadcom.com>,
	<manoj.panicker2@amd.com>, <Eric.VanTassell@amd.com>, <wei.huang2@amd.com>,
	<vadim.fedorenko@linux.dev>, <horms@kernel.org>, <bagasdotme@gmail.com>,
	<bhelgaas@google.com>
Subject: [PATCH V3 05/10] PCI/TPH: Introduce API to check interrupt vector mode support
Date: Wed, 17 Jul 2024 15:55:06 -0500
Message-ID: <20240717205511.2541693-6-wei.huang2@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240717205511.2541693-1-wei.huang2@amd.com>
References: <20240717205511.2541693-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|DM4PR12MB7719:EE_
X-MS-Office365-Filtering-Correlation-Id: be7c329f-4c54-4728-c56e-08dca6a2e9bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o+vmgHqHu8dtKSMwX9Tdod97LUuj7usckIqZIMjkZeaLJebEq4YmFEy/uvh9?=
 =?us-ascii?Q?/lB6u7VRGm2VHiKJMVqwE7EgiAq/SuHqfNjm5Dv+zVANiwDk/7vA6shFRqMA?=
 =?us-ascii?Q?mPUWBX08R+MghBP9tbKNEbSsFkKCofHs/bN90loGnvag92mIye1gjRhpHNFq?=
 =?us-ascii?Q?6N+LWgHObPagknnM25+72DbS7nVoViNbNxc8J4ZHjWuPVxmWRtpyWMirYrtd?=
 =?us-ascii?Q?D4N9Vvj48KSqpaWXeq6/yQS0Kx2C1Ow5csSH5LcV3KeGuFkUBdnjwJx43AiP?=
 =?us-ascii?Q?vGTsI2FK0kuyBqINBTrA6BwggUCEOMdqu2o9Q8WB374yR0H9EJ3E18sQOcjn?=
 =?us-ascii?Q?fGlP4igwOqBruQ1MwN6pgzqbLtzNE2Q5otfKgxJu5fE49U61UjAD3lVPc9Uy?=
 =?us-ascii?Q?H1wfn8kOfns7fOO1w5j08/e62L8dEU3S94eOJDn3T4VzED1FCZxxQk8MDbx4?=
 =?us-ascii?Q?3H0QxDLlXf8A6Csj0ftzBCRwkoaNTvRtmLVuFIf8+MIr5+b4xhfkgzsXznEB?=
 =?us-ascii?Q?l26IYxlOJpIQdBxpDOBXr5k0s4272QPPu5NW3H6e9odMsuMqTj6TmKOOFbNd?=
 =?us-ascii?Q?9m6TpJXYWNe3Pha7UXSLDcRh8icZIU/CmYmpy2FLvqF1u6kBQoiyVYbvOBnl?=
 =?us-ascii?Q?yMPgZsuvkYPNbw7X0ZWSAiz8m+/PFKp1Kx3+ihXK9YdoyvxPwwwzHGRZ0pDo?=
 =?us-ascii?Q?ObeHrGQqhsSqgWEhEdq8/ACcJxQ8oPeWWDfagv6cV6u5XSNitpRb+HFtWdo2?=
 =?us-ascii?Q?VfSoCJceWxbI8OThya9XbjXXCTDQ6eXSd33V28lvnFGibYsCsOqwRJS+ahtD?=
 =?us-ascii?Q?FP0WvRIc8mhTgKrObGU6xOthlq1pqZvc80IHoqOsHOVuG8UUEXs9bLPRvray?=
 =?us-ascii?Q?n/5c7wp7k283b5tsmokcz/d1jnlSJXYkNxRO+mcon2dK5sV+uWVAq4VZEUgR?=
 =?us-ascii?Q?c4XSbhndxXg6jmRD4odqpdoQShFULoFgA0FAR6BP7yGp9wwgcXSAonYhZyN4?=
 =?us-ascii?Q?M6sfLyF4pUf1wrL8bntDgMUIKZy7AiCee7fo5QVj6hE4IfUBcqz8ltM9lNB8?=
 =?us-ascii?Q?BFi19lm2R6bxv+TDf4SNZgqpfO4yeViQfY/tGKav36qzQkPMiUiZ/tZVFWGj?=
 =?us-ascii?Q?0SaT6kGvNCEYftMmAAQzKINsQDqJuN91DsNYJfCF6lQuIZa5naL0AjOaSZHI?=
 =?us-ascii?Q?KkfGy1WlpAPDdO6iuLebS4LVS+s0dGVgZYQEDS63DtuYCWSzUAMV5oFKTIn0?=
 =?us-ascii?Q?6olqzImV9lVV9xrl3Tz80J3mR42x7jV2h1Rmbpi6lYGwgRb0GYc5q9hag5QU?=
 =?us-ascii?Q?W8YiTMIks+V2o2k6dMxqgcHD0euidSoClChxGz0MXOxZ2AQnRkiEKXPL8aDl?=
 =?us-ascii?Q?nQG6VpSqk4oY8Ck6Vpu9327PjkVOAkeetzhUTPsCRJ5BNXGu+ZfDIY+Idkxf?=
 =?us-ascii?Q?sJavS+us8h05tdFm0S3M9N4VaAvLS5Qs?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:56:21.4646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be7c329f-4c54-4728-c56e-08dca6a2e9bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7719

Add an API function to allow endpoint device drivers to check
if the interrupt vector mode is allowed. If allowed, drivers
can proceed with updating ST tags.

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
---
 drivers/pci/pcie/tph.c  | 29 +++++++++++++++++++++++++++++
 include/linux/pci-tph.h |  3 +++
 2 files changed, 32 insertions(+)

diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
index fb8e2f920712..7183370b0977 100644
--- a/drivers/pci/pcie/tph.c
+++ b/drivers/pci/pcie/tph.c
@@ -39,6 +39,17 @@ static void set_ctrl_reg_req_en(struct pci_dev *pdev, u8 req_type)
 	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, reg_val);
 }
 
+static bool int_vec_mode_supported(struct pci_dev *pdev)
+{
+	u32 reg_val;
+	u8 mode;
+
+	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg_val);
+	mode = FIELD_GET(PCI_TPH_CAP_INT_VEC, reg_val);
+
+	return !!mode;
+}
+
 void pcie_tph_set_nostmode(struct pci_dev *pdev)
 {
 	if (!pdev->tph_cap)
@@ -60,3 +71,21 @@ void pcie_tph_init(struct pci_dev *pdev)
 {
 	pdev->tph_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_TPH);
 }
+
+/**
+ * pcie_tph_intr_vec_supported() - Check if interrupt vector mode supported for dev
+ * @pdev: pci device
+ *
+ * Return:
+ *        true : intr vector mode supported
+ *        false: intr vector mode not supported
+ */
+bool pcie_tph_intr_vec_supported(struct pci_dev *pdev)
+{
+	if (!pdev->tph_cap || pci_tph_disabled() || !pdev->msix_enabled ||
+	    !int_vec_mode_supported(pdev))
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL(pcie_tph_intr_vec_supported);
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index 8fce3969277c..854677651d81 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -12,9 +12,12 @@
 #ifdef CONFIG_PCIE_TPH
 void pcie_tph_disable(struct pci_dev *dev);
 void pcie_tph_set_nostmode(struct pci_dev *dev);
+bool pcie_tph_intr_vec_supported(struct pci_dev *dev);
 #else
 static inline void pcie_tph_disable(struct pci_dev *dev) {}
 static inline void pcie_tph_set_nostmode(struct pci_dev *dev) {}
+static inline bool pcie_tph_intr_vec_supported(struct pci_dev *dev)
+{ return false; }
 #endif
 
 #endif /* LINUX_PCI_TPH_H */
-- 
2.45.1


