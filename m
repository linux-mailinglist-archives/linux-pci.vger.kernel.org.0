Return-Path: <linux-pci+bounces-14015-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 099A39959F9
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 00:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C014A2827B4
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 22:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2624A2178F0;
	Tue,  8 Oct 2024 22:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QoDa0OzB"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6E0216444;
	Tue,  8 Oct 2024 22:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728425940; cv=fail; b=BJA/EG5msZUWw7QdRV7FKtk1Bn2xAlYTnTfnrExYxZSe8eqj927kUqDw6+ZT8w0zB5Z9pT9ctMxn1XmCuDGFRzBoOaRpb5RuTUCxF3GMRVRMBD2EqfN7OyuybftN0FXatkWbycYnQrwSfWzdmr0CFX5VsngOrJ+UGa7/Zk7qKOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728425940; c=relaxed/simple;
	bh=n5mqW6CK7reIo+symxOB7Nj8fQWA3uZeEg0DoAwiUd0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JlMaj1LxSxXU4xuDqFUnIpsXjNeGrMS9Becbmg3n0MROdRRqa/jYThQXA/A219q9heMSclJQhabdNJL7+Sq5NNJ/e+hK7yLhhknW0cDeexI4OZVLa72fFlTbePoGxhfkf/k/Q/cIDJI3/BMInpAixrpc2bvjDvNPBHH5e/JXhBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QoDa0OzB; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FO7Z5XxBDkz1SziWX0b+bQe3v2HUHaBiM6EzXcDNT3d1Y175spPgRPwiEZpg7e6glVm1NncN44Kiq051U1HqB4n5bi0f1xXcm/kbpg3vIxEI8q/+XWdkywtxpKxp6nAH976rZvb06RFuWDvg5fMCTC2YYb4kK99zTztZEgXfvFgYUuefsxCRUKQavFylTXU+7BpuVZoZyehbHFqvFq3erzPnPw+P6lvRJiHxLB5j6dzi+SGZzbPNQTRm+4J/Hw4F+1rSNmDIHZYzOXkA29Gku2/RXkqVjhJdDzsyXd4+Tv8FJx/1eOXqHyuaxraxwy2T58+OkXwf50tIm7FpUTbuTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Sbn5U87PdCbAESrXUHWXyxwIM6nvnNs9Q/IwaG2h14=;
 b=FXg7SS7MrB56mzZkIBn8JGvNRw33emN3HPu2vONVspkEgj/FYoSGDGfB+H+27KXBGsGWqKVyn4hEn0jmmXwZIVKuz8M/+vFS9tPqzor8VGU1HPrfPCRHzgNMiShICAvxXja1SIK5gy/VqfLnZ6YWo+3r6AtusfepJR7yKFdvhV7OUf7cn/6Aew+8CB5owsA9FA6gWCbGlFiTOA+OinhGEQ5hW2CCCwwAws0iF6dLKTOdQuIAjMeUbH/ORxCbcr5BrGYPthaz1NLSXikJnuuIpmkaz4VO29A1B8OrBBCnmGdWkSMEbFKAmFPO1B28ZTxDIYXjmoYBiCiKuYT0sarnig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Sbn5U87PdCbAESrXUHWXyxwIM6nvnNs9Q/IwaG2h14=;
 b=QoDa0OzB2PYQntwEaIs6WD/zZKGaUih99Sho8AjEIDz2tsFPL2CqMwMckV7I+n2SMwgiomOf2LnLLNfs/J8SwUp+ZsSSOHKAn+kyD/yifPAt2/JVuA/PE1QUV/ydTGAFh4fy7JjpbPefWPyHsrAdQWmieO1aYmAcH+3RbYxrrJI=
Received: from BLAP220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::33)
 by PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Tue, 8 Oct
 2024 22:18:55 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::ea) by BLAP220CA0028.outlook.office365.com
 (2603:10b6:208:32c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Tue, 8 Oct 2024 22:18:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 22:18:55 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 17:18:54 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <smita.koralahallichannabasappa@amd.com>,
	<terry.bowman@amd.com>
Subject: [PATCH 10/15] cxl/pci: Map CXL PCIe upstream port RAS registers
Date: Tue, 8 Oct 2024 17:16:52 -0500
Message-ID: <20241008221657.1130181-11-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008221657.1130181-1-terry.bowman@amd.com>
References: <20241008221657.1130181-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|PH8PR12MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: a757d139-0184-4cdc-8283-08dce7e7328b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NRsdfgPeU/+uDInpyGa+Wn/K/9wPfSjxmzuG3xLnHMERqTeTZNx30uzys4FC?=
 =?us-ascii?Q?cBCt/A4HYKiroACafEgdF3fSbs/rNpqyJiYuXyvIoPmsYETPbSbQNHHwYqBr?=
 =?us-ascii?Q?i8cjnMx1UmmHc09CPChRhl1YO890oJ6xFre9VAKo7PBRS4eu/tpRaccRl8x6?=
 =?us-ascii?Q?AEtwVEjzg8dcMvdBlwY9aSCdMuRrWdS92gN4Kl0MuhFvDfKH62GqvEfUhEz/?=
 =?us-ascii?Q?wJew5scpoEWLIO2JlxOujOk05sDtllbJ2zpMepmVqh9+koGpuxBe9hW5YAxf?=
 =?us-ascii?Q?ec8mb5ECI4iZAMGwSjGR98QwPWgHDLYDD4Sry1HB3CV6b9jliJqB2lLJeTbL?=
 =?us-ascii?Q?WyQyGj0HDojA4EFTca6eSG9RTeO6bpmwB35aS0Gu6U8fyADzGXHjCUX0TKFe?=
 =?us-ascii?Q?LYBa48COLtnjJ2nw107jSXpImi/TaL0BBbXCDeHySEg6uvXazNebiilNWUlN?=
 =?us-ascii?Q?l+6Q2r2WhYz74UKr5XTbt3wlsdzQOvbh5Bahe6A6SyC4zAwXyrBvhZQLMr02?=
 =?us-ascii?Q?xmKvZ5C/K3JHemKEN7nLDmoXHC4nw5hy1e1NHjgfnl3rCZBAQ+nKXzvS1Q4C?=
 =?us-ascii?Q?0KUldZmdEcGzych04NMbDW7kthLKvegOg+9hgC+YrjIJd24kj17EzaQdmZKR?=
 =?us-ascii?Q?aMkdU/voLmcDZ8ZI98dPCjV2xs5YlZ3M5A0H/Q10AWRH59hH6MiBjLOP3k/F?=
 =?us-ascii?Q?pURdrkde9/+L3761qx20k/LXLGGs8xgnN20WgeXLOTtNvh6YnnaUWS8YoD/J?=
 =?us-ascii?Q?svFXtqHmC+oyBhC7NO7UqQxl+NqSvicT2G4FShSvl2RQdkFnsyEviH1f9K4q?=
 =?us-ascii?Q?uk+bj8FNJtUyztsgw2Rmr4EhXrsePj83u2ZRyZMU7pTAdgL+HjO2QC6msB8T?=
 =?us-ascii?Q?QBFXlP/FFDzZwbLTV6ps6UU31xOSILAsscHKaZQ9O45GBX/kLwh5Bc0s/8E1?=
 =?us-ascii?Q?5Ce6j0npnJuh1y5qRR9Fay2sMcGYPY0lJdORNUnC0X7svqhAqHK6IhQx494S?=
 =?us-ascii?Q?Lh3DzfQLEG1BpIR9xF0DFEYlnXIM0kr0mJlhUanN0akRcqR8Es/DKNfoEUBf?=
 =?us-ascii?Q?rgRvm1WbOLZhq4InGBROrvp1SRI1MOXbsE4RX3VgFLn69qqZaCPfEmw614bW?=
 =?us-ascii?Q?gv0P7i2StjkVV7ereJVm7WMjS2rFrjImrfZutmnlxobmYC26Xuk9H7Rr7yf1?=
 =?us-ascii?Q?C3GoUr80tXEcF8FOx/0vp7hPo/Rnz75bP0is0Y9gAclH/xfCeRIZQ0U4b0oj?=
 =?us-ascii?Q?yoijMc0w1jhK4Tp6411eMtwqRvMILE1gXSNgqhZmf9QP5zR7/C8lnQ5F2Rhu?=
 =?us-ascii?Q?nkiois7M3yvwLxj42V7XiAMOmokyWf5ELYEn0CtXf7xmcLGgoIhlM9kReCH7?=
 =?us-ascii?Q?eYd3NEUkR1NVSJbGMO1lTZyKvfL0?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 22:18:55.0608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a757d139-0184-4cdc-8283-08dce7e7328b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7277

RAS registers are mapped for CXL root ports and CXL downstream but
not for CXL upstream switch ports. CXL upstream switch ports' mapped
RAS registers are required for handling and logging protocol errors.

Introduce 'struct cxl_regs' member into 'struct cxl_port' to store a
pointer to the upstream port's mapped RAS registers.

Map the the CXL upstream switch port's RAS register block.

The upstream port may be have multiple downstream endpoints. Before
mapping AER registers check if the registers are already mapped.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 17 +++++++++++++++++
 drivers/cxl/cxl.h      |  2 ++
 drivers/cxl/mem.c      |  3 +++
 3 files changed, 22 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 6f7bcdb389bf..be181358a775 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -816,6 +816,23 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
 	}
 }
 
+void cxl_uport_init_aer(struct cxl_port *port)
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
+EXPORT_SYMBOL_NS_GPL(cxl_uport_init_aer, CXL);
+
 void cxl_dport_init_aer(struct cxl_dport *dport)
 {
 	struct device *dport_dev = dport->dport_dev;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index cb9e05e2912b..7a5f2c33223e 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -764,8 +764,10 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 
 #ifdef CONFIG_PCIEAER_CXL
 void cxl_dport_init_aer(struct cxl_dport *dport);
+void cxl_uport_init_aer(struct cxl_port *port);
 #else
 static inline void cxl_dport_init_aer(struct cxl_dport *dport) { }
+static inline void cxl_uport_init_aer(struct cxl_port *port) { }
 #endif
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index b7204f010785..82b1383fb6f3 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -67,6 +67,9 @@ static void cxl_init_ep_ports_aer(struct cxl_ep *ep)
 	if (dev_is_cxl_pci(dport->dport_dev, PCI_EXP_TYPE_DOWNSTREAM) ||
 	    dev_is_cxl_pci(dport->dport_dev, PCI_EXP_TYPE_ROOT_PORT))
 		cxl_dport_init_aer(dport);
+
+	if (dev_is_cxl_pci(dport->port->uport_dev, PCI_EXP_TYPE_UPSTREAM))
+		cxl_uport_init_aer(dport->port);
 }
 
 static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
-- 
2.34.1


