Return-Path: <linux-pci+bounces-21194-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC4FA3154E
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 20:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE8D33A8780
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 19:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4214F263885;
	Tue, 11 Feb 2025 19:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ADRjx3YA"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A097263893;
	Tue, 11 Feb 2025 19:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301932; cv=fail; b=ZVlelBlJdxGDnecxk7i53xuQ2rkKlcvwfD/mr6GI8/TxvvTvMs61Jdhxa/0VisSwI4Ni/kW8Qt9q99NH6aFHdxl/3xfKukMVK9DTyJEgE71mcXUrhSbdD2XK8LoocQO5mSipBC3JZyDlQ2wvLI0upz2DCGZ9ZhgAIkMEpv6DuyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301932; c=relaxed/simple;
	bh=gDzQyVZD9S0WeSv2ByDFryhWteexIGm01jhKt5nh+QU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qD2HF9Rk1wOJJa3aKC+wHtVDIOiDPRQsSmdtpUMY9lOSNWIfopFgCieHhe3IcQsn3Dp+bJGY2Rk0hGXeIpJE+OQnDPTnz53CvimfJOpYXBJLSF6Bh1tAEd3MrPHGvwNFQWRJkp+I5FbGe9z+ERNtl2AW6jla2rDfAvjbqBjz0cQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ADRjx3YA; arc=fail smtp.client-ip=40.107.102.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chM2Zh8VZlITebGb/n3aVXWCc58TEl30O02cWPQp7BiKgGS4ongikwUJsSnhkttEbPzMNE1GoEUk5EymkbIqm17bunZIMqDufXHe9rEjKAPanITosZnqLeNVm1vsLoQoQBx8NSdxi6wZn8b55rjWp8JqXkJJhv+72pdIsPSbkUcbVDEPsZuYIoZn9lRvaUfDwmfPMHZZ42a1epE8kW9yJvwf0XLZhT9NcDuuaD3Xy2/FeplXUF5H7sNKo+iqq0QKXgulB+GUISbbq8eDEt+7LXmGsVWGOBzZCKvc7luERoIKZwa2FBCHxK3JbqxYz1HwocyIQ30H42lr+xe+s+uhcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CiQ0rzXkTRvbk1XXyXh8I31TQPoSDgA0LUO+KThfmfc=;
 b=e7irowtDVGkNKBTFPC3jpzuZV9GoRWJLfvjHwUtPTFfiyAqrl35iZLrNyufudn7FwFiKjy9W7OmBEaq2wVOHlO7SegAERpwHniPHYYfkqu4lKus4p4g6zYjlPlWwHNAu5CyNPYX8E4uWBiNiEZp5WqwhWkdikoWV7ytkqFdfFPYjhxZ22NYI+bDwwK83IsOvR4TilX4Rjtm0Rc9O6wul1c+4LK8h09dWiI3rE6Tl5KwAH069XJxU1DQiLrqCXjpoZgMgcCsLELAcIUHmZDtRlYxWjGpGg4kc+XOpi7BcljiKvNs+ZGWWu+Ok5OsSiuDGzv7zJohRPgg4/C9ygyXZPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiQ0rzXkTRvbk1XXyXh8I31TQPoSDgA0LUO+KThfmfc=;
 b=ADRjx3YAmW/inRukwXvJuhrWmxcGgxgeiEaGfPSBUIlFyUgBx6eBKqpjCwejT2IAw3BhiMfRUgngqhAxj47q+1wmeVLrhoefl8S9MT08qZ6oAc5IRC1J4vH2Vz2H36hqZ83srY5IjP+InXloD3k79oZzbk6plUDXtk6WMvzfl6g=
Received: from SJ0PR03CA0163.namprd03.prod.outlook.com (2603:10b6:a03:338::18)
 by PH7PR12MB7331.namprd12.prod.outlook.com (2603:10b6:510:20e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 19:25:25 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::b) by SJ0PR03CA0163.outlook.office365.com
 (2603:10b6:a03:338::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 19:25:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 19:25:25 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 13:25:23 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>
Subject: [PATCH v7 03/17] CXL/PCI: Introduce PCIe helper functions pcie_is_cxl() and pcie_is_cxl_port()
Date: Tue, 11 Feb 2025 13:24:30 -0600
Message-ID: <20250211192444.2292833-4-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211192444.2292833-1-terry.bowman@amd.com>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|PH7PR12MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: b15b9ae8-f625-4e7f-1836-08dd4ad1d612
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G2PBZbPh/fRIz3Zrk9Fto4AwD0k8gW1teSAHLDAMqJNZAsjCUldgcSvBt3l2?=
 =?us-ascii?Q?Xg+zOMPDN54eI4P9OG2mdh1l4lbe2tf3RazCEXD/NlWalG6t9fC8myT3e75w?=
 =?us-ascii?Q?HilNeRCHTG5QHMG0duIAuEE6TWg31bzP1nagjIp/D+5e7EFG3GoEseqIPTAM?=
 =?us-ascii?Q?bOE5+UUEe5my55YqYrVhVt1m4+7GmMCkSBsy+/ddtdCcl5yjQ47QSCnxoVRQ?=
 =?us-ascii?Q?HDOihHG/f4XqoVqSnbyxfOn6S0nP57goqMg0b1LNFjWwTBS15Ibax5rBxWhJ?=
 =?us-ascii?Q?fRLqkEIteKHAscTl+a2eIW3oRUehc+9N/vhkvHMxsh6gtSWnrJsdiCazR8LP?=
 =?us-ascii?Q?2e4NzJVu4fmE1oEwocCZZjEo9UZ0Ea5XHP8tsTkDeF/66XTEJTCJuPvcBHHX?=
 =?us-ascii?Q?EuUmaP8TBGfVcm1Wlllcgjd1xQttPbSy/V2SUug2IlCxaUHtgu8cw1kXVab6?=
 =?us-ascii?Q?r+EoU9g/3Xnd9hFX7rq8M7y9IfyNWsLuPLrAlHy8wsjB5wloZDcI6aR/MNYp?=
 =?us-ascii?Q?Ly3h4n3EbCM4bjIF89oVgEgHqGrJd3wFD/5AbB7Sen8VhLyq5wL/IWsEvnL5?=
 =?us-ascii?Q?e22cFmcBs2EOiaxYJeAVTfmXWbYtiARpny0LQHZ6+W43BRjvANmmk9RcV5g5?=
 =?us-ascii?Q?F1LEOPYWaH+IsKOk2I56qqkYoY1EqE8eVOLkFrViPBKwpiLVrb1/rpVZCjyz?=
 =?us-ascii?Q?ed2zhJGYNjyi6yiNJjXoc/dl7rxlxUSzaKI6DQMZ2HIriTo7S1qIlDYjR3Zd?=
 =?us-ascii?Q?QNWBk8pf+FAOVoxQkCdSOMc8E8Sj45T8n1P7Wx5xz+owRZqnyXb8p9+QSAdg?=
 =?us-ascii?Q?0bpRt+qh6h1CctsRb2Dqotn6huu42EaaYPqOykN1U0hgQ2KP0rV7JauBnuvC?=
 =?us-ascii?Q?lsVA6L57yGnO8Kn+Dv0/BJO3RTeX7yx9ARGp6p6nKlu9upv5uAemKfz+ovIj?=
 =?us-ascii?Q?Z1m2TU8tfKizBWSgT1K0kd9BdaQLDaT9R3TB+tvZzzZphib8iulmY599speJ?=
 =?us-ascii?Q?RiWQ4b+xQBKNotkbUUkmZghO3DuHnXaF+KvkKqE877HqW46KyvbSLi/WQcR+?=
 =?us-ascii?Q?0G3sxCBpfr7qS9/1Wj+fTdd9vbyCebT2yJn6xodQVGrU8ymfd2AEzl+nvpY0?=
 =?us-ascii?Q?w25b86uFnA1eETidShHRftN+xxi9fFrGSvCitFYqze7A4yLsitKe/9vmVNSf?=
 =?us-ascii?Q?OdK8sy/oWfHx0GmEoV7MCATP55HKhxkzF5WbtY9Xilv1F0fD8ZNOJo4Ltyfr?=
 =?us-ascii?Q?jb5NDUqtvTlV/iMH1OT6Z/WB3rTYG8Cw01G1R9wi+WJ5N6BqXk1uZgJdz1BX?=
 =?us-ascii?Q?EJnUy508c8UhCsBzeCo5Z01K9QK7g5HiE3Dhbn+7lGpgIPvF3AlXalQ5ZG8U?=
 =?us-ascii?Q?gCodyf6I/SZbVu2wcsaaioXkShy4VZ/6c7kwN7wvPyTWFmF+nLX5NoeWQgqC?=
 =?us-ascii?Q?HlykQrhDfUdh0KWids//LUdCJ8Wzkf4iUwktlrOwHijH958PHWKxIbuli4mL?=
 =?us-ascii?Q?2pJtMf3+w5cQERg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:25:25.4890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b15b9ae8-f625-4e7f-1836-08dd4ad1d612
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7331

CXL and AER drivers need the ability to identify CXL devices and CXL port
devices.

First, add set_pcie_cxl() with logic checking for CXL Flexbus DVSEC
presence. The CXL Flexbus DVSEC presence is used because it is required
for all the CXL PCIe devices.[1]

Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
Flexbus presence.

Add pcie_is_cxl() as a macro to return 'struct pci_dev::is_cxl'.

Add pcie_is_cxl_port() to check if a device is a CXL Root Port, CXL
Upstream Switch Port, or CXL Downstream Switch Port. Also, verify the
CXL Extensions DVSEC for Ports is present.[1]

[1] CXL 3.1 Spec, 8.1.1 PCIe Designated Vendor-Specific Extended
    Capability (DVSEC) ID Assignment, Table 8-2

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
---
 drivers/pci/pci.c             | 13 +++++++++++++
 drivers/pci/probe.c           | 10 ++++++++++
 include/linux/pci.h           |  5 +++++
 include/uapi/linux/pci_regs.h |  3 ++-
 4 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 869d204a70a3..a2d8b41dd043 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5032,6 +5032,19 @@ static u16 cxl_port_dvsec(struct pci_dev *dev)
 					 PCI_DVSEC_CXL_PORT);
 }
 
+inline bool pcie_is_cxl(struct pci_dev *pci_dev)
+{
+	return pci_dev->is_cxl;
+}
+
+bool pcie_is_cxl_port(struct pci_dev *dev)
+{
+	if (!pcie_is_cxl(dev))
+		return false;
+
+	return (cxl_port_dvsec(dev) > 0);
+}
+
 static bool cxl_sbr_masked(struct pci_dev *dev)
 {
 	u16 dvsec, reg;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b6536ed599c3..7737b9ce7a83 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1676,6 +1676,14 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
 		dev->is_thunderbolt = 1;
 }
 
+static void set_pcie_cxl(struct pci_dev *dev)
+{
+	u16 dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
+					      PCI_DVSEC_CXL_FLEXBUS);
+	if (dvsec)
+		dev->is_cxl = 1;
+}
+
 static void set_pcie_untrusted(struct pci_dev *dev)
 {
 	struct pci_dev *parent = pci_upstream_bridge(dev);
@@ -2006,6 +2014,8 @@ int pci_setup_device(struct pci_dev *dev)
 	/* Need to have dev->cfg_size ready */
 	set_pcie_thunderbolt(dev);
 
+	set_pcie_cxl(dev);
+
 	set_pcie_untrusted(dev);
 
 	if (pci_is_pcie(dev))
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1d62e785ae1f..82a0401c58d3 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -452,6 +452,7 @@ struct pci_dev {
 	unsigned int	is_hotplug_bridge:1;
 	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
 	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
+	unsigned int	is_cxl:1;               /* Compute Express Link (CXL) */
 	/*
 	 * Devices marked being untrusted are the ones that can potentially
 	 * execute DMA attacks and similar. They are typically connected
@@ -741,6 +742,10 @@ static inline bool pci_is_vga(struct pci_dev *pdev)
 	return false;
 }
 
+bool pcie_is_cxl(struct pci_dev *pci_dev);
+
+bool pcie_is_cxl_port(struct pci_dev *dev);
+
 #define for_each_pci_bridge(dev, bus)				\
 	list_for_each_entry(dev, &bus->devices, bus_list)	\
 		if (!pci_is_bridge(dev)) {} else
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 3445c4970e4d..dbc0f23d8c82 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1208,9 +1208,10 @@
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
 
-/* Compute Express Link (CXL r3.1, sec 8.1.5) */
+/* Compute Express Link (CXL r3.1, sec 8.1) */
 #define PCI_DVSEC_CXL_PORT				3
 #define PCI_DVSEC_CXL_PORT_CTL				0x0c
 #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
+#define PCI_DVSEC_CXL_FLEXBUS				7
 
 #endif /* LINUX_PCI_REGS_H */
-- 
2.34.1


