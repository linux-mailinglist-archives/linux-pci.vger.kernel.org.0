Return-Path: <linux-pci+bounces-40246-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DECC323F0
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 18:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BE503A350C
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 17:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B216133C504;
	Tue,  4 Nov 2025 17:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iKsZ93W0"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011014.outbound.protection.outlook.com [52.101.62.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77F933B94A;
	Tue,  4 Nov 2025 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275953; cv=fail; b=KSORdL0Oif/NaeHaL2Y/hdOpKGwynV+a/9U9G9y2vu7FVZpJBpktl1CGbKpxcgVNuuiv8us6/LGP5rEU4ZlTvkh89FiBeoJ9AgoJzB5M6z9filmkO4v71RnjOGBGuyU1udojTdX/evcu5WDsf42r+nETb8wA2q471g5xzc0hja4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275953; c=relaxed/simple;
	bh=sjvVuNeULFwb8JJOq63rOZaHNRKSpT0PNuicYI1ujhA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tHW40V5HCxKFC2R6DVnE2+6tBUKcFDx0IsZpOAFzFu1dKjxm4WJoXXdAuE+OfbUAEv5/pXx4JvDPxvyQ84O3h0/+nSqvKs/Mc+St0ja30H0wpnUBHUIhz5i5tmFFhrZVZsqwbG5RMoh3oaDc9ybZSw3CSPrj5PTd1Oa/4jL+5ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iKsZ93W0; arc=fail smtp.client-ip=52.101.62.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYfcY/vq8wEKJmu4vAly+eOcsU0UqUT4iKaYCZe2bfuX2so/XXS0wkXTIayr1z79acmEBlXba+fp2p1aZiQdD+gK86H2xsnbUt3XNCWu1vFtJYgZOGyBk2hL3thAslyfFwydC3usmN3IyDJY2pZu/XCHS3OTMFD3YsI4lG+w1/zirbnpao1M4WmtO2Rfubsa5oD1inIne4XW3//7Epa3nhE1/cDPulq8AijjxWEJM7XlIRTVAxC4p+oBZGImLIorkxGE3II/oSWUO+AtyfZK0QteV/kpT9DBUSjOIw28f7NpGVyVPtjeHKB9ajmEMFxmxLwJ40fOz9Nw39kaxdOwiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjY718RXa/Xm+SEExjhcRwXihtyUqbihxDPWsLuthIY=;
 b=H0mrYA0FALStCmO4WXgTrlOStWAoAxwO1QngiRcXckojikt28bDm0Pw10MS1U7BkiiiYtyaTZt+kGHA06bJaZf9U6FeE5m7O06ZyUs/Tm5g10dbmJdFggLJhkxT1JbsmXi+i64q3xXVLyXKP2HgJtO2ZuYncJV759EzBqX3ODfIUprGR5LdoG9KUkD2V2iJ2weV8fKbqA4ADIQPkrfu5tA6PMRNU/mih8CCunrSog71sZKxj5CCEE98wPo5GyFcAGGDDMvbnE0HG3vlOPI7DaauUY4zVs2+Hl+joZsL08leF0BgINHAVse7MVOO6ZiEDRdlQ0DR0TGBWYRmzYTPL4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjY718RXa/Xm+SEExjhcRwXihtyUqbihxDPWsLuthIY=;
 b=iKsZ93W0RQatjDOx3rL1roOllob55hEM29z4z/z+Dzi+zJnI/Hue/gHSqIrtxXkbJT5ktodvi+zfIrkjdF+WaLorW5yYQ4+cyQthwgkljSEnMjj0T3OWHGZXyQHBvnvf6SCvUGkSUxqCk/YxkIVRuNE1aVpqjpX2JajGM3+PQeQ=
Received: from BN9PR03CA0990.namprd03.prod.outlook.com (2603:10b6:408:109::35)
 by MW6PR12MB8835.namprd12.prod.outlook.com (2603:10b6:303:240::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 4 Nov
 2025 17:05:48 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:408:109:cafe::85) by BN9PR03CA0990.outlook.office365.com
 (2603:10b6:408:109::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 17:05:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 17:05:48 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 09:05:46 -0800
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
Subject: [RESEND v13 14/25] cxl/pci: Map CXL Endpoint Port and CXL Switch Port RAS registers
Date: Tue, 4 Nov 2025 11:02:54 -0600
Message-ID: <20251104170305.4163840-15-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104170305.4163840-1-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|MW6PR12MB8835:EE_
X-MS-Office365-Filtering-Correlation-Id: 5db1c65e-0b8e-4c05-ea75-08de1bc4669b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?di7UJZAXAxIfvN8QbbqbkcoMdGwdmZ4v1Nqhxg5EvbDUVtIf82xMMV/q8Gg0?=
 =?us-ascii?Q?KjVH14+K1aahm2/WsS9zniFMZWJyX4RDFHsEZjQMIteXaNdwWkQTKLmPPzoE?=
 =?us-ascii?Q?b8kgip1RyAj/JOLUW+Hi8C1Xv6t/I04vgKklRkpB2yO7UoCyYXSRTd+vr+ln?=
 =?us-ascii?Q?xCtrvRGaCa/endDaq+2hLUX1QVIlAXA0rqBO2mLjjESV4cuwezEfbAJ8bvVy?=
 =?us-ascii?Q?d/AUZwioMukAYAnGG6xCXkDrupgVCtEXQMREo3Rd1BaymU/5oi4lU8zIPUT2?=
 =?us-ascii?Q?I7rHCSc2VvuWul/oUXr5huybDljJCKVrxUosThfYt6or7WA9fmuk7+8j2jko?=
 =?us-ascii?Q?+u5sQjaE2HUsToVB/tCiinU0azcKKmds1tTRa+K6m6iBytSpjqYbrw3gIs4P?=
 =?us-ascii?Q?qGPKhmHSgKgjz08YDfNdo8rp5ClDU+3moroJBKHH/cgOBWytTHwBBtYF8GEY?=
 =?us-ascii?Q?pCBM0BaC28YYVzf1lZD6PVEScumiBYva3fyGIyyIjraCqDsrDeniefGskxZ7?=
 =?us-ascii?Q?VCaE2BSFGLhbw3IXP03fY5RgZ5493mO8cgHwpt2cOPKTI1GnrYHXTmFEP5sW?=
 =?us-ascii?Q?7NEqskLJeJTjsqiUIZcgLZ6E8GKstRgqBgvyqDtE8JkMD2vasVwUn261hym1?=
 =?us-ascii?Q?h4Ktg9lb7WXKKN2jiWclirI95l8DIBd9HWsnh0G042ulhLrT3gENphHeP8Ah?=
 =?us-ascii?Q?+++f0y5eDs5S7tjYu+tQR7rK8iwRXcET9zynk0nWrQytxb1/tzDvyIUo0Ms4?=
 =?us-ascii?Q?CfAK0c6vTkO5d+1766tLlCt1wXllKU0UMlWrLr0rpUfMziL6aui0NIl3FRbV?=
 =?us-ascii?Q?Jjf29Hf81vKa38bdlYFd97gOTYdTqfK3wYyqVneiBqrO+tWkMLvg7FOhoZ6P?=
 =?us-ascii?Q?jcLj2LmzNWAN9QbB2ltWM9ZZgNYaXVHXT3L10Kx6V09Dnic8xN4bIISGXQwj?=
 =?us-ascii?Q?IAzoR0DgU2u29H9yQy9HhmaZRDwLZzfjEtOEU4cI3wW+rzrV5wGRcipoQUCE?=
 =?us-ascii?Q?klWIdYp/GkjTKsJyyNvnmyiP97Tmw5LUfKsGePVJgk3dS/CvL7tYFqFIJOMX?=
 =?us-ascii?Q?ULz9gsOBwUmAZEycw+EnXYtne0/tzsiRqzdXHyOJQdU0YZtFawSB+QsMXOHz?=
 =?us-ascii?Q?8t/oAxxOgLzlBYXDi8K3FyjNCCepU1dY/gdMSWNbmawRz5EKue4Bk+XFWM5k?=
 =?us-ascii?Q?C0V+AKia+j4PtosZhUw9ZoySt4WDT62GCUUwYKSiFllitggADCqJLTs+pXvY?=
 =?us-ascii?Q?Os4SOWqsYwdbzvTKZ5euXg87O3dWO6qflxDUCuG37OYpoHM5V4j/HKXw00uH?=
 =?us-ascii?Q?sOi1vfdZnIdFNXn+V2EhKjwZhXqkZx+TlVpufFc11zc3Qt1nJSHov7DHKQbH?=
 =?us-ascii?Q?+cTeFpX/i684+o4WuVaL65Mf59u5URCFZQI2gClz5FO2dUUBVB3LajEOguSv?=
 =?us-ascii?Q?cl3gHOOs5vxz5xs8LMk3qzEftofr26ZP8xBJf7BQAnOA8cCfamTWqFJ/lMt+?=
 =?us-ascii?Q?0Dty6e9J3TArXF2nSrgm/OZPg7i8+wYkaAq/qOLVexzGU7U/0N707H1lnKPg?=
 =?us-ascii?Q?WLvMQ49xdLD87iTt5EtFaJPzgA6C13KEplMWvoJP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:05:48.1783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db1c65e-0b8e-4c05-ea75-08de1bc4669b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8835

CXL Endpoint (EP) Ports may include Root Ports (RP) or Downstream Switch
Ports (DSP). CXL RPs and DSPs contain RAS registers that require memory
mapping to enable RAS logging. This initialization is currently missing and
must be added for CXL RPs and DSPs.

Update cxl_dport_init_ras_reporting() to support RP and DSP RAS mapping.
Add alongside the existing Restricted CXL Host Downstream Port RAS mapping.

Update cxl_endpoint_port_probe() to invoke cxl_dport_init_ras_reporting().
This will initiate the RAS mapping for CXL RPs and DSPs when each CXL EP is
created and added to the EP port.

Make a call to cxl_port_setup_regs() in cxl_port_add(). This will probe the
Upstream Port's CXL capabilities' physical location to be used in mapping
the RAS registers.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v12->v13:
- Change as result of dport delay fix. No longer need switchport and
endport approach. (Terry)

Changes in v11->v12:
- Add check for dport_parent->rch before calling cxl_dport_init_ras_reporting().
RCH dports are initialized from cxl_dport_init_ras_reporting cxl_mem_probe().

Changes in v10->v11:
- Use local pointer for readability in cxl_switch_port_init_ras() (Jonathan Cameron)
- Rename port to be ep in cxl_endpoint_port_init_ras() (Dave Jiang)
- Rename dport to be parent_dport in cxl_endpoint_port_init_ras()
  and cxl_switch_port_init_ras() (Dave Jiang)
- Port helper changes were in cxl/port.c, now in core/ras.c (Dave Jiang)
---
 drivers/cxl/core/port.c |  4 ++++
 drivers/cxl/core/ras.c  | 12 ++++++++++++
 drivers/cxl/cxl.h       |  2 ++
 drivers/cxl/cxlpci.h    |  4 ++++
 drivers/cxl/mem.c       |  3 ++-
 5 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 8128fd2b5b31..48f6a1492544 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1194,6 +1194,8 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 			return ERR_PTR(rc);
 		}
 		port->component_reg_phys = CXL_RESOURCE_NONE;
+		if (!is_cxl_endpoint(port) && dev_is_pci(port->uport_dev))
+			cxl_uport_init_ras_reporting(port, &port->dev);
 	}
 
 	get_device(dport_dev);
@@ -1623,6 +1625,8 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
 
 	cxl_switch_parse_cdat(new_dport);
 
+	cxl_dport_init_ras_reporting(new_dport, &port->dev);
+
 	if (ida_is_empty(&port->decoder_ida)) {
 		rc = devm_cxl_switch_port_decoders_setup(port);
 		if (rc)
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 246dfe56617a..19d9ffe885bf 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -162,6 +162,18 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 
+void cxl_uport_init_ras_reporting(struct cxl_port *port,
+				  struct device *host)
+{
+	struct cxl_register_map *map = &port->reg_map;
+
+	map->host = host;
+	if (cxl_map_component_regs(map, &port->uport_regs,
+				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
+		dev_dbg(&port->dev, "Failed to map RAS capability\n");
+}
+EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, "CXL");
+
 void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 {
 	void __iomem *addr;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 259ed4b676e1..b7654d40dc9e 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -599,6 +599,7 @@ struct cxl_dax_region {
  * @parent_dport: dport that points to this port in the parent
  * @decoder_ida: allocator for decoder ids
  * @reg_map: component and ras register mapping parameters
+ * @uport_regs: mapped component registers
  * @nr_dports: number of entries in @dports
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @commit_end: cursor to track highest committed decoder for commit ordering
@@ -620,6 +621,7 @@ struct cxl_port {
 	struct cxl_dport *parent_dport;
 	struct ida decoder_ida;
 	struct cxl_register_map reg_map;
+	struct cxl_component_regs uport_regs;
 	int nr_dports;
 	int hdm_end;
 	int commit_end;
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 0c8b6ee7b6de..a0a491e7b5b9 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -83,6 +83,8 @@ void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
 void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
+void cxl_uport_init_ras_reporting(struct cxl_port *port,
+				  struct device *host);
 #else
 static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
 
@@ -94,6 +96,8 @@ static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 
 static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
 						struct device *host) { }
+static inline void cxl_uport_init_ras_reporting(struct cxl_port *port,
+						struct device *host) { }
 #endif
 
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 6e6777b7bafb..d2155f45240d 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -166,7 +166,8 @@ static int cxl_mem_probe(struct device *dev)
 	else
 		endpoint_parent = &parent_port->dev;
 
-	cxl_dport_init_ras_reporting(dport, dev);
+	if (dport->rch)
+		cxl_dport_init_ras_reporting(dport, dev);
 
 	scoped_guard(device, endpoint_parent) {
 		if (!endpoint_parent->driver) {
-- 
2.34.1


