Return-Path: <linux-pci+bounces-15361-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E949B1167
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 23:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AD601C21F38
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 21:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E6218BB90;
	Fri, 25 Oct 2024 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kOuBMm0s"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3578F16A94A;
	Fri, 25 Oct 2024 21:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890308; cv=fail; b=QETQedIYX+MosqRKHmhldQOOYapo5K/TMGq6rmtHZw4/ZiJrqIs6CFpBuebNu096y4a5TBrOkiQ0GpPzXVWT0xPc+9YT19qXxB3msv6+Jfrffslhp3uppZcihRozb57FVWo2BhjcB9KmkLUgn+W06J9UWkh3Onv2QOB1HNByFDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890308; c=relaxed/simple;
	bh=QcAf1BuZDyCbH2DcyHI+FTUG9FefRJtXIB7thywpjdg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bXH61nc+fGUqWcNVnfb18N1YuqIqSAwXXwj03/n8uRQB/QOl248pYAIiyX/FZx4+MD4aoRfjSwJQ9IsvzoA55eksG2jB0snNpngu4esjaxHuA0mPvzz6hkZCILBeeAtMcserbLHtw0J1kG7Kx06TYP04lbK28uLlpqGvFzmzcf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kOuBMm0s; arc=fail smtp.client-ip=40.107.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rWYXkXCedlFV7IZ+jkZwTDIMAdKAqxnPd/wG5HLs/nwCv2iywtkQwDm4AgPt3g+6Oq3LCj0AMKdsbK8im2KNqCCjgIrxOUCU2ZW9XuOSLGePCnDyOLCW/C9XgrFv/9S2VCrmTr8l3DqniTZ/9yntxX/7oPDbzTTCQrEFM6gdpBEk/myoL1KX84N1LUcUWhUlDp+ftv78aIA4LYXyBoHLy02hiCAP/UEfHzpXDmFv1c9Lo6rWBYzEyxlZhN+99U3poFBQesXFZGj++ExYFtMkw08+50Nz1WHxcc3ra66E5f1ODZ1oLbwDykpVniwe5RuccqvynARdjdnyCyHarI+mMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMJOrvYxRIkiKfVAxbiFRGklKeHAZiPzwITeMhLfk+0=;
 b=cS+/UVON5XP5D9+Qiid9lAyrg+odmymWUzUSYokC0eS+OeIiRuLItT0LcsBwgYNrJPIEZtbMH++NMJVtGTEoDMCUR3SP2sKQN4B4N6wgK2FblwnKtKZMMJSZtP/rZqX4ssgDdYDJ97OXvjE8VJ1pJ4f109slY6y6yXiEB7yX6utn4vA8UOP15+0UWHpFzoV1XDoVO/fvHyWZjIQ51bSYXIFXafoU06e/OOOV4gGqNYh5M/ZC9IabefNO1Q3my+XUldygoMom+iZiuI8xHi8E6rWrHXlnrn3eHWGr1s1gSKETP70d8Zqu26LWFvShN0gIjqDwEmQyEAjC+QbszEkBUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMJOrvYxRIkiKfVAxbiFRGklKeHAZiPzwITeMhLfk+0=;
 b=kOuBMm0sv+YHm34ugnuBHCYjFehBjCr0jZdCMvQIN7l/ANquTJooDNgyvAhtEP0tLEGdWScJBXZC0CesJ+oWrg+yy1qOXhbzKChWIzb6+3vsTwbpkZ4xSONrcJASNYrVMwjL0y0XeFw5z5xlKhvLBVu4HXg+Re629DRJwQ2qgI0=
Received: from MW4PR03CA0069.namprd03.prod.outlook.com (2603:10b6:303:b6::14)
 by SN7PR12MB7936.namprd12.prod.outlook.com (2603:10b6:806:347::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 21:05:02 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:b6:cafe::7) by MW4PR03CA0069.outlook.office365.com
 (2603:10b6:303:b6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Fri, 25 Oct 2024 21:05:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.0 via Frontend Transport; Fri, 25 Oct 2024 21:05:01 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 16:05:00 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v2 10/14] cxl/pci: Map CXL PCIe upstream switch port RAS registers
Date: Fri, 25 Oct 2024 16:03:01 -0500
Message-ID: <20241025210305.27499-11-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025210305.27499-1-terry.bowman@amd.com>
References: <20241025210305.27499-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|SN7PR12MB7936:EE_
X-MS-Office365-Filtering-Correlation-Id: c9018107-609b-4da9-fee8-08dcf538b152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2USQINZotCBu9o2ZCzbKEveNx5jGk6M+2coMuL81hZpV1b6WmTFH8t1uqcyA?=
 =?us-ascii?Q?Cyi3XJZH234Yv2y1Vxy2W0kGov3SNuuc78/I8NpGgLx7EVS2SycJIl0dkFAs?=
 =?us-ascii?Q?kxNUOC0KVGke9siftP4IglwR7/eRLNPBpCKLyovE5hiFf2Q1AmxlGo4+d2CP?=
 =?us-ascii?Q?O+oNLHHupoFJxS0nB7ALPDOmQw+S61VYGjIZ2A4+vYzkI5449qAD4SRBnSKb?=
 =?us-ascii?Q?jZXrg2DG9xcRTWXEslsfDovqyx0Ydp1quIf3HH/3apokG7SrD9BBxJCpPCoD?=
 =?us-ascii?Q?rlEfVghNxy1pEfEePRPntiUrow2r/iSJoUdnyjtPb1IIP67Q5Yv8DrGWyibl?=
 =?us-ascii?Q?uRERtOHyvY+JOr3sIByUgiAO00lj9qaifabvu1ULEBS40GGsAINazU2Drjaz?=
 =?us-ascii?Q?FPPGrinz5gvDmO6HYK6xYvWjwJVjrNFI38ux49kvh3RO+Z1/V+dDovkP6SSM?=
 =?us-ascii?Q?49/d0fXTfm9B2XBGJJBBIQ7kx2CKtfK8VlI/TwKjkxNmb1+Dsr764uF9oXFt?=
 =?us-ascii?Q?rSPGHaRLnpC/Z9+ulNh/68xCNB1r6+D2YlpryI2YFPKpHJKBVsyy0BQohJc8?=
 =?us-ascii?Q?djCwe3x1t6TBgVPfVXhowDtPCxFSyAhEqfp9W4eCw6zK2USH9o5Qt34BS5jj?=
 =?us-ascii?Q?Np54AVo4xCzO6Lbc9g5tiAvOKGSTQe9m7flJR1BrTV+ojvBWKEprgvclEyFT?=
 =?us-ascii?Q?lKHE3RoZh/dpooDJv+6DIY5QVudq1zGqjwi8CvMoxjHG0FYb4XbA4vpmS7oD?=
 =?us-ascii?Q?LIag/4DV6ZfF3WzIIIcl9LdlNINcp2STiHPDwd4s1CbWxfmORy3mzbxERwGq?=
 =?us-ascii?Q?U4Na7hWv+4pqqpzOSf25G8BxBU8CBYE38r1+67Iz7RpgXsPX6zWwRlTfa9I+?=
 =?us-ascii?Q?WYZqZqTnHC4YZTv6boZs0vno5y1AkP3x6HYqVweSdYSuXUgZ6pq3uHzOv3al?=
 =?us-ascii?Q?xnUYV1j/QRXcCOyebcc9g4W3hcdTuXZi17THFzl2cxO4By2C17Mkxaxd8MXt?=
 =?us-ascii?Q?vLkPVsL/Q9YtA5I9UazfmwuMfyJdf+N6k9IxPNhKQH4oNzDOAcsRiEIXi4xi?=
 =?us-ascii?Q?AldHllUnHMeKBFD0IVUSEu6yCoBqpdUIjW4cJz7Yo2CfRqUyoENLh/mmnquQ?=
 =?us-ascii?Q?GLbeFh2XPkb4TLnHUcetBJlKkMpdrWE0mYLj234NkHmUMiv3KV/jVkmaaXbq?=
 =?us-ascii?Q?vjjS15G1zDQrJepD+uzRqz8cK0b6bt/GOAn6E8BYjEXUGfmXuaPpOFeGJV29?=
 =?us-ascii?Q?SezZt8fbkI9qS/IOpkowpaOm57JH3vRlzkqGcNKHwU+/YhYx9hN7IRX1Fp3F?=
 =?us-ascii?Q?siaCHCcytIeF6ehFpm4l6GMPX5czzhXuU10WVsL+UZNvxO8/sYlzwkzoiUQ9?=
 =?us-ascii?Q?Wo09WrHsXVL4CT+GwDGHnJHSg/tt?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 21:05:01.9872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9018107-609b-4da9-fee8-08dcf538b152
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7936

Add logic to map CXL PCIe upstream switch port (USP) RAS registers.

Introduce 'struct cxl_regs' member into 'struct cxl_port' to store a
pointer to the upstream port's mapped RAS registers.

The upstream port may have multiple downstream endpoints. Before
mapping AER registers check if the registers are already mapped.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 17 +++++++++++++++++
 drivers/cxl/cxl.h      |  4 ++++
 drivers/cxl/mem.c      |  3 +++
 3 files changed, 24 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 0bb61e39cf8f..53ca773557f3 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -773,6 +773,23 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
 	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
 }
 
+void cxl_uport_init_ras_reporting(struct cxl_port *port)
+{
+	/* uport may have more than 1 downstream EP. Check if already mapped. */
+	if (port->uport_regs.ras) {
+		dev_warn(&port->dev, "RAS is already mapped\n");
+		return;
+	}
+
+	port->reg_map.host = &port->dev;
+	if (cxl_map_component_regs(&port->reg_map, &port->uport_regs,
+				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
+		dev_err(&port->dev, "Failed to map RAS capability.\n");
+		return;
+	}
+}
+EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, CXL);
+
 /**
  * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
  * @dport: the cxl_dport that needs to be initialized
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 787688e81602..ded6a343c05e 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -592,6 +592,7 @@ struct cxl_dax_region {
  * @parent_dport: dport that points to this port in the parent
  * @decoder_ida: allocator for decoder ids
  * @reg_map: component and ras register mapping parameters
+ * @uport_regs: mapped component registers
  * @nr_dports: number of entries in @dports
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @commit_end: cursor to track highest committed decoder for commit ordering
@@ -612,6 +613,7 @@ struct cxl_port {
 	struct cxl_dport *parent_dport;
 	struct ida decoder_ida;
 	struct cxl_register_map reg_map;
+	struct cxl_component_regs uport_regs;
 	int nr_dports;
 	int hdm_end;
 	int commit_end;
@@ -763,8 +765,10 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 
 #ifdef CONFIG_PCIEAER_CXL
 void cxl_dport_init_ras_reporting(struct cxl_dport *dport);
+void cxl_uport_init_ras_reporting(struct cxl_port *port);
 #else
 static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport) { }
+static inline void cxl_uport_init_ras_reporting(struct cxl_port *port) { }
 #endif
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 240d54b22a8c..067fd6389562 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -66,6 +66,9 @@ static void cxl_init_ep_ports_aer(struct cxl_ep *ep)
 	if (dev_is_cxl_pci(dport->dport_dev, PCI_EXP_TYPE_DOWNSTREAM) ||
 	    dev_is_cxl_pci(dport->dport_dev, PCI_EXP_TYPE_ROOT_PORT))
 		cxl_dport_init_ras_reporting(dport);
+
+	if (dev_is_cxl_pci(dport->port->uport_dev, PCI_EXP_TYPE_UPSTREAM))
+		cxl_uport_init_ras_reporting(dport->port);
 }
 
 static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
-- 
2.34.1


