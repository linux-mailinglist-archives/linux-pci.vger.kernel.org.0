Return-Path: <linux-pci+bounces-20995-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A93A2D22A
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 01:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B63A27A5D35
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 00:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39289DDAB;
	Sat,  8 Feb 2025 00:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C4TmHpoG"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3188BEC;
	Sat,  8 Feb 2025 00:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738974639; cv=fail; b=p4kbDZn4KO++RxvgRfBOUpi9fc6We3b/w1/Lu8N1aULqNt6nIN5oZa+Ar7OAM6AkyC704TvUdgh664w+VQ5JRLcRLg+lEnZeXbYSybXDuPn2Nynw+RpNe4QElJeu33lzJVTl7gwEYCcKlg4qp0mF3xszM3MpeYT1zFqiezKkdUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738974639; c=relaxed/simple;
	bh=iGN2PciLDJC3QtLkp/bPhcK+p2cCJu+4LQkh3JH4O0Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bwCPxFgvMrEKWmYtjZ6iWLUMLKcX6iBYnLYZvqP+sb8BzeUHT+zzWrBWqJDhOnJRuiaYlkvAFcJUEPeBzfxYuMyDMa0mXhjF82pdqZ7uqPhwFcR1wPPXpjnQps7e+6XDhD4aZAwM6f/hj6bJ1EMoQuz8vIgYd7u2kw1fMQ4M0QM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C4TmHpoG; arc=fail smtp.client-ip=40.107.102.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OS2cFz2oN4j+jSKY01MSAUVWCSpDNsLFDHkEd3ozWrgnQIs/KZKkqhBnNTj1ozYGmzPLMDIdpe/7lEoRlUVraS3lJNborwxj/C12e1Ohk8ZDiIQlHsLIUprssUrIa/RRrxiwG+Ya85nZQNtaBAnYKAazYBoiUONdAEG41HKqQ5PWz9NB9dhJ1IPaHXLE8OXrh6cJJg1pQcIO5N7mUy45Af/0+dRYIk3/DleH2ZQ7bFUkA1TCfNjxIAKuzchy7TxQz10GBhrHICNoCW7NCsFNV8dRYKogDjSI7TV7zNi9PEPDorDRNq3qSIp3eEPakMmFMrUoexeEUEc74uHML/NhUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvYIiDABzNQ6smzB5WjPLzaMmU1jHms4IeWWFbs5fnU=;
 b=bL+b/afTQksjipdP7tElbOtHiQ3SOkBi39wPo2b7/Ffz2P5qT1tfj1gbrSHAyj+7wxUJPxN7QjsNQ9CGbz4QjY/Iwx/CFm/g3HvKHqpHpJ4wWrfSa43k243LGJ4awyLUuE9e9DBLOP2BRBh2Ql/1XZT9IQWJ9zxbqjHAw4VuAP+nd/YZSt91FUI5hZsTJSg8LbbJchDxg6Gs/ExTEFvMh44VK6rW4XGRJuuf+qjXlqSj8hcmq8tWWoyOsdwokS7bBFSoXD9zJbQfL4Y84V98Q0NH/lXpR8K2WibRMgrRrsj81TH2KLnSKnaqP32ldIZlrwdMs1njRwdu1YsocsZUKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvYIiDABzNQ6smzB5WjPLzaMmU1jHms4IeWWFbs5fnU=;
 b=C4TmHpoGbcWrhd5JLlBKRmeXG6jZazCeHRs8A99vwv1ujAoTqJzDFPEp36zUKS5ooNLsv+PxcfPKqK+QZF/gIv3QFyqdqR4WorY65JLEB2dnenqmZYHf6S5i2qUTVVcAzinqAUWGBO+xni8mNDSx++1oyd54uzvHaLeb3/q0dV0=
Received: from MW4PR04CA0311.namprd04.prod.outlook.com (2603:10b6:303:82::16)
 by BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Sat, 8 Feb
 2025 00:30:34 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:303:82:cafe::8f) by MW4PR04CA0311.outlook.office365.com
 (2603:10b6:303:82::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.19 via Frontend Transport; Sat,
 8 Feb 2025 00:30:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Sat, 8 Feb 2025 00:30:33 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 18:30:31 -0600
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
Subject: [PATCH v6 04/17] PCI/AER: Modify AER driver logging to report CXL or PCIe bus error type
Date: Fri, 7 Feb 2025 18:29:28 -0600
Message-ID: <20250208002941.4135321-5-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250208002941.4135321-1-terry.bowman@amd.com>
References: <20250208002941.4135321-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|BL3PR12MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b2b89a-e96a-4ef4-85f2-08dd47d7ccea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?isFNcFEcsBeVnUf0xXsohH7APbnUXuDhut1gFKMD49ZBgNvDBtaq5uyGUfvU?=
 =?us-ascii?Q?V/T1hszTo/Rn6MCUFwHhGZ3R6TLgAbLQZpGQQBs+TQd430gp3bXM7wmliql2?=
 =?us-ascii?Q?B1yj+yB8+rCxpBOjnwPEdYWnxsz10VrR8CPySBJYPYkgTkPM1o3eFr+reuDL?=
 =?us-ascii?Q?g8fYnWGbTKF6I26ONrADSv39lWGHTAJa4MsnQ9Ex1djJFQEialipjznRJbar?=
 =?us-ascii?Q?QrZgLCUr9t5sKAvLsqRFEUUzy2Nnxwg+bql5bYQwIDqA1Oxt3R0AwuD5zp40?=
 =?us-ascii?Q?R69HvXrpXqYVyxTvGCxHZ+S0vNnBXzuo6ZIZg6COEc/5oLj0q+7dpAcg0TuA?=
 =?us-ascii?Q?mFRnHmNUgDIKnS/mwgmvS33LwlQU2+O5TN/tvyDBqZ+X5Aamef26wOaDRyUd?=
 =?us-ascii?Q?tYY7ShPEUrUaJq2//TpB7dEm5qJev3H6KL2WoMZK7Mnl/F+PwfAcvdHHomb6?=
 =?us-ascii?Q?vpVbDrtXP5bfJ3ERC5M/qTmgJ3OsE7IQwAeKdjMvmG8hpik+rNrhPzRUMuJj?=
 =?us-ascii?Q?AX4dpL8hjgHGUgCOk7Pzh5xfXtgpPCWsWDkSGEQwaqT0gfRiRyCVhcsE2eJa?=
 =?us-ascii?Q?uteAbMKfMJ3xV/noTld0IA47HULdiP8YsJYwj3IlWsIvYIUa7gfrXtDejbOP?=
 =?us-ascii?Q?jFxMx1jn0iLcRQqt/QnoFqcP7aNK1KfPhlrBGGz58JGFLO147r03LwWodsnB?=
 =?us-ascii?Q?jckBmjl1b45XlaWVDv+SuUktOOKzRVCCxIFTOUYL9Ph4q67IGiF0mho5rF8l?=
 =?us-ascii?Q?XUEqSjV4yukn6Gw3J0PDX8qYp+epUeX/zRj0mebBiLFpeZJnefIhzuJWrqcY?=
 =?us-ascii?Q?CfyF4lcQor2H4QkAnjkWrQN3lIKb9V/HsjhKIIgEzWVhOaJp3z3NkX0bkWAg?=
 =?us-ascii?Q?gjGWY1LLaI1mcfSAyV0TS7CqHqxr6GZmYXZeSs93zscsbgLnVcU2q4gWdEHf?=
 =?us-ascii?Q?GTXvsMCGNp+u+M0v0U4zXU+bf8tSfwID/dF0Q5Hm2HZNBgjRtth+MiXt40H6?=
 =?us-ascii?Q?X3/ur+pXMRwVNRpEHG5mYwyUTRodzf1M56pRvpiANUnQkbbDOzIeVZG2Wa7i?=
 =?us-ascii?Q?xPjyxhphRp2kV6VC1ReEVKbeHq4Dzqyc32o/51yqHi+sEeXdHOyWdiEjIyHb?=
 =?us-ascii?Q?GuzcsYJN5d+XhjgJTsdC9vAGVDhg+zB0mMiabImD5vLKvNHeIcLftGHpx+YR?=
 =?us-ascii?Q?TBSgnz8J3NMIHfb+6GUkGp8mGMPLNjYpKHe3F2B6KgdIW8MtYFH8a7rE6yuy?=
 =?us-ascii?Q?Mm5LsL9uAjIeTXXWNtohjj8r+5vzae0BFm4O4lyH8guGqa8PaqlSsQ6RWrbp?=
 =?us-ascii?Q?SAQoa70IbBWIWqC8+HS6emjmD/JbMOFYUC6h0Sb9gWolitc6Bk8+Naqde+i6?=
 =?us-ascii?Q?QO0RCXUf9RxvJw7hapZwugRS012Ps43Mc5oZiQrxXeEv2NRtQdCYxkEr/IQ4?=
 =?us-ascii?Q?icdeGO2ZHDqQXGqqgolmqCi1CRUZxlGWjnsB+dTEs0yfNQyv3LroqjCumlkD?=
 =?us-ascii?Q?qvnzPBXY7p2aFhtvtgEFHrwBuhlIoCIlMyZ6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 00:30:33.6380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b2b89a-e96a-4ef4-85f2-08dd47d7ccea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6450

The AER driver and aer_event tracing currently log 'PCIe Bus Type'
for all errors.

Update the driver and aer_event tracing to log 'CXL Bus Type' for CXL
device errors.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
---
 drivers/pci/pcie/aer.c  | 14 ++++++++------
 include/ras/ras_event.h |  9 ++++++---
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 6e8de77d0fc4..f99a1c6fb274 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -694,13 +694,14 @@ static void __aer_print_error(struct pci_dev *dev,
 
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 {
+	const char *bus_type = pcie_is_cxl(dev) ? "CXL"  : "PCIe";
 	int layer, agent;
 	int id = pci_dev_id(dev);
 	const char *level;
 
 	if (!info->status) {
-		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
-			aer_error_severity_string[info->severity]);
+		pci_err(dev, "%s Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
+			bus_type, aer_error_severity_string[info->severity]);
 		goto out;
 	}
 
@@ -709,8 +710,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 
 	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
 
-	pci_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
-		   aer_error_severity_string[info->severity],
+	pci_printk(level, dev, "%s Bus Error: severity=%s, type=%s, (%s)\n",
+		   bus_type, aer_error_severity_string[info->severity],
 		   aer_error_layer[layer], aer_agent_string[agent]);
 
 	pci_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
@@ -725,7 +726,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	if (info->id && info->error_dev_num > 1 && info->id == id)
 		pci_err(dev, "  Error of this Agent is reported first\n");
 
-	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
+	trace_aer_event(dev_name(&dev->dev), bus_type, (info->status & ~info->mask),
 			info->severity, info->tlp_header_valid, &info->tlp);
 }
 
@@ -759,6 +760,7 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		   struct aer_capability_regs *aer)
 {
+	const char *bus_type = pcie_is_cxl(dev) ? "CXL"  : "PCIe";
 	int layer, agent, tlp_header_valid = 0;
 	u32 status, mask;
 	struct aer_err_info info;
@@ -793,7 +795,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	if (tlp_header_valid)
 		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
 
-	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
+	trace_aer_event(dev_name(&dev->dev), bus_type, (status & ~mask),
 			aer_severity, tlp_header_valid, &aer->header_log);
 }
 EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index e5f7ee0864e7..1bf8e7050ba8 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -297,15 +297,17 @@ TRACE_EVENT(non_standard_event,
 
 TRACE_EVENT(aer_event,
 	TP_PROTO(const char *dev_name,
+		 const char *bus_type,
 		 const u32 status,
 		 const u8 severity,
 		 const u8 tlp_header_valid,
 		 struct pcie_tlp_log *tlp),
 
-	TP_ARGS(dev_name, status, severity, tlp_header_valid, tlp),
+	TP_ARGS(dev_name, bus_type, status, severity, tlp_header_valid, tlp),
 
 	TP_STRUCT__entry(
 		__string(	dev_name,	dev_name	)
+		__string(	bus_type,	bus_type	)
 		__field(	u32,		status		)
 		__field(	u8,		severity	)
 		__field(	u8, 		tlp_header_valid)
@@ -314,6 +316,7 @@ TRACE_EVENT(aer_event,
 
 	TP_fast_assign(
 		__assign_str(dev_name);
+		__assign_str(bus_type);
 		__entry->status		= status;
 		__entry->severity	= severity;
 		__entry->tlp_header_valid = tlp_header_valid;
@@ -325,8 +328,8 @@ TRACE_EVENT(aer_event,
 		}
 	),
 
-	TP_printk("%s PCIe Bus Error: severity=%s, %s, TLP Header=%s\n",
-		__get_str(dev_name),
+	TP_printk("%s %s Bus Error: severity=%s, %s, TLP Header=%s\n",
+		__get_str(dev_name), __get_str(bus_type),
 		__entry->severity == AER_CORRECTABLE ? "Corrected" :
 			__entry->severity == AER_FATAL ?
 			"Fatal" : "Uncorrected, non-fatal",
-- 
2.34.1


