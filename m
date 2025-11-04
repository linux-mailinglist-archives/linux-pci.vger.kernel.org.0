Return-Path: <linux-pci+bounces-40170-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 30215C2E8AB
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 01:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 452904F69A9
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 00:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21861AE877;
	Tue,  4 Nov 2025 00:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MwUMBm/F"
X-Original-To: linux-pci@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013009.outbound.protection.outlook.com [40.93.196.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E8052F88;
	Tue,  4 Nov 2025 00:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215168; cv=fail; b=X36alLMCcEjF/te9HhYzGHev6KrFpgQjWDNi9mh5RWsVXNrKYFfjcCaFpVm/8VCu9ctEhjeBUhmFy4fPvvZALlQ/u2qsnD5ge68zgx5t2X3KuikCjGUTO+BiMsE61utUKpJPtR2wvpMV5IM+AuuzKErMy60+CuM96bVKVmsnUj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215168; c=relaxed/simple;
	bh=sjvVuNeULFwb8JJOq63rOZaHNRKSpT0PNuicYI1ujhA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aYHntr21nBc0+DGk+03DXYtOWMGITGkPdNzIhPtWcm6m/VcRvwcLasgxtg05RPfbPB2xwolWQs7xq3gc88mNvutlN2y/Iu6CPAhM8182Rj8GY8bvhcwUvk3p9ZVjOM25fzPeAoijD/Rb48fdBi0BVHLi2PkMMYA3qi/ZRJMsdls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MwUMBm/F; arc=fail smtp.client-ip=40.93.196.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ty5Wn/cu9upeDUunTFhci5Ux6SvJsjfwJ8HAcJAz6gNOxo+glupN1+PBbqTp9fx97OW1unBes/t83TEAjVxQZTv4yKhpyc42SCAamFB2c3cxOyI3Z2Q4YoiFUlXCx4ACvmdbhjfPtk5ZEFiq5sroppjQ6Of4okn+126vjoWy0XgZTGituqDVpm/FW0ctCYHce0FTJOo0bbhA8Ir0hJ0i9EsS5/sDgTZbrSRYW/oo1t8jpRquP9RLCTFoQHLfUop9H5pxOIF5GLHSxR1kNOLI7z5ItyNMigtKeLt5eAE5TgRBE04GERHghe21ZkJoSE26cWsL9m3U25USodOosbGuvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjY718RXa/Xm+SEExjhcRwXihtyUqbihxDPWsLuthIY=;
 b=R8doOGY1U+N28X30ELlZH+eJrmEsP+FXOjtVkid6Y6TZJjG+GFTALVXEN6042JB79xpa0QbMBQ3V+ye3j4FRFQbI2WwmMCvOD7e8Q5AAJns/Lwgvop4GSA9QXyqhZD3/X9HF8JUSuxBlWhdWSH9hWG/CagIMcQ8FgiccivwPT2DQQhdOXP+j510a+9NX+5kufTKAptEkrY1KJ3ciL44nEbORLG+g9FdbUXIb1yPTymKNmBkAfZY6WGv/7gc/tN4P+gnqwLsP0W4S5kT8N0Q+uFq6CImIb2VEUwaLByPafEEfwucig8UiPaKcAKmmheTgIIeSwwU81U+fZu5LREz1Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjY718RXa/Xm+SEExjhcRwXihtyUqbihxDPWsLuthIY=;
 b=MwUMBm/FvE1T1qlJbf66bilgAzK/U2F+bEouaiB+/rD8BQqR2tVPXAUNcsoCda5K37dK0B2nmtXFIayuSeIFKeEe6zUBPLD++GbxigAldfDFmoYcMaEenZf/IusjcQVzuGN6bVhHuJM8uapdiBO41Z3YwNv84doeipF4hfH92KM=
Received: from CH2PR08CA0001.namprd08.prod.outlook.com (2603:10b6:610:5a::11)
 by SA1PR12MB8117.namprd12.prod.outlook.com (2603:10b6:806:334::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 00:12:43 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::c1) by CH2PR08CA0001.outlook.office365.com
 (2603:10b6:610:5a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 00:12:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 00:12:43 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 16:12:42 -0800
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
Subject: [PATCH v13 14/25] cxl/pci: Map CXL Endpoint Port and CXL Switch Port RAS registers
Date: Mon, 3 Nov 2025 18:09:50 -0600
Message-ID: <20251104001001.3833651-15-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104001001.3833651-1-terry.bowman@amd.com>
References: <20251104001001.3833651-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|SA1PR12MB8117:EE_
X-MS-Office365-Filtering-Correlation-Id: c41cc548-8011-48e6-872a-08de1b36e011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/iRPOJh0pYpkw2/sTpBUfzjXWTH4CFMToUYIu1M2zJ0EBC1uVmvo9J3rq+Ef?=
 =?us-ascii?Q?wJ68pwOT2nYQtrpUAdxO0MG2MBOIof6pEQWlMxJzn4t/F60oZjeA9rmdJxE+?=
 =?us-ascii?Q?2qmF4kQ85Lko6r0hGMlW0lcv8KBCJGVPHwvEtA9qwZyplYNsagmmbQafglKD?=
 =?us-ascii?Q?zDJ8xlMSUjBp6QOf1pj1ID2A6fzBbIQaFcWD+H4jrpeoyzMnKnf9dfAtclnc?=
 =?us-ascii?Q?K97UQYdQxcFd/RNq4M7F6Na4hRwonk1d/wyI4pg4JUJqH/FBzM5Kb8ypiQkY?=
 =?us-ascii?Q?a9atD05LkzBAqwbdbjTDZdRw71+8NORCFIrdkDG4GbcDLWLjfAoywxCmKv8m?=
 =?us-ascii?Q?/tQEsJlJ8cOy9YfzpoiK8BXauje7B/OcYGvkfI3PeH4I/stlzafMgMfseiPa?=
 =?us-ascii?Q?BCjMUhylvdd63pOUFRwkge1inocFmSmOgZiwXzq4Yqu/m2dLowFvVG7yobjw?=
 =?us-ascii?Q?/DX9RbryiLuhCoTJIRwKwg0pTctJWIcC7po6/bldkg90NmPsW9Mk6alQxXo7?=
 =?us-ascii?Q?wyreaTTdOPZLFYGdRuxni1G0ix/vsMuK++9gFOJJEcTvWpMtp9flV3VIBuq8?=
 =?us-ascii?Q?GjJ/PcS9QlLZcx8NGdiHGde9Ygy4ZUBIb71KyqvSFfoytH6HgjAJ0wtNrlPF?=
 =?us-ascii?Q?M8XmB9q4xsk9dvqEY7CjaeejNphEeVuQ8NnfPTdK6PIt06U5VF22Fn8Ggtos?=
 =?us-ascii?Q?QROiWU982l+0Xr6uVuXWQcVEoyY3BCaQhV9ZqCo3ODvoGpPWwN138lvFwgVr?=
 =?us-ascii?Q?IEwdKKSAEnqIypo+jyniElNMj5oRFpksPHB6QD+TgvS7JFHUHRgGESiJyuVc?=
 =?us-ascii?Q?NibHEyBBRd0vDhv7uOsU0VJP4r8nDiVfQj7q70WJNCOgP7vEMbAGWeDemPPa?=
 =?us-ascii?Q?ajVsrS/4mq5fi7DJqMm7h1lwtKlgWjc21x4/gfkuifpUpksOzsyI4Ovti+kB?=
 =?us-ascii?Q?RvX3/reQEMex9wItfY3VvYWm1V/ZScXuvr/NO1Dt+JVJv7zRIR1wux9g/YLM?=
 =?us-ascii?Q?IzpR41my2v9C0hR/rBDH5a7J/jsDjwtBqFn+YXQAz+W1QmexVoLdTMSwTpa8?=
 =?us-ascii?Q?YjPVaT9dX0toBWPGQJ03lUB331ChsB1rHRsOWU4gBwR3XKkfDVC/RfKzFMbU?=
 =?us-ascii?Q?44KHZz55LVanqodD8qcsg919I8FmoquyuB8EXVT2iTVcQbOF6F6fwQS+msHN?=
 =?us-ascii?Q?xTgABIFLmSmzc2Do4YELF8APgeA0cfgGrHo5BfY9V0o5emNTmeNVYDYP4JFJ?=
 =?us-ascii?Q?TU8cXbqv04irprbA+BQNsHlVHusyjOlt0bTQ7W4hV+XXc1jjDdcX+Qy+4W+D?=
 =?us-ascii?Q?Esy/gwgaAQejUoPIPf4jtwjF/RXX+M+MammZDuFQUwZgBRn7UMnmOE1to0Qy?=
 =?us-ascii?Q?+mNHrgyGxyjK/Yy9Ie+u6RWDqMc2NH6FkbSK2EB/O/OnmRO+ZKFwTheW7n5D?=
 =?us-ascii?Q?GWmV+Ik5OtcrGB8BS4co3sHxpfgCpKzdV+ciAD03fwTGppwyNrDambd6LZLp?=
 =?us-ascii?Q?eRFu6hyG+9wjC32zMJ8TLkKcMgDY1X5IUjUViNBw0hWxRwtZl0mVPyeAHDmI?=
 =?us-ascii?Q?j2yPGJXzJE5TYmimA4pFrRVI2LIziQvF82xUrXR9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 00:12:43.4079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c41cc548-8011-48e6-872a-08de1b36e011
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8117

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


