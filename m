Return-Path: <linux-pci+bounces-19429-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99709A042CF
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 15:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD738161D69
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 14:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E879A1F2C45;
	Tue,  7 Jan 2025 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LgwZ3wCr"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23981F2C28;
	Tue,  7 Jan 2025 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736260796; cv=fail; b=EuD8bDRED9hXTF3Lwg3N9rWWJwnmTRJHQW7My7PYfBw8tGke8tyWqi/OgZDjCzaQLQwC19tlOa3p4KzVNxTSnhPND86y60DCShhmKtjw/hbHUYkBLh+c9zr3xQcXCYkK6FsK7TfIFdf0sT8KX4PFSZU4WfbXgIOknVGdjuYx4Os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736260796; c=relaxed/simple;
	bh=tLmAflARc6UEKAVyG30cgmffMnDQdnbY/pcuUJlYRCs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lSNTWeaVvLX5OqNbp3CWyrajTrYywo8zkZ8qoiRY5oO5yr3m2YDdel8kzS0LR2xBKnpjmpVXxd4GaV9ANz5RkXD+CivdLkAs3SyWSbaA3AqvPCBkYf23UtX7kyTvT9q4arVoXnCcNFZSGgguBgLzlbLpB4Nx6TJBjripaoT4fy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LgwZ3wCr; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3U/9qg8iuHz8vDI4SLRQ1YZvonNqFZs/PCl6L1xQKphMpOJy4EnbslP+/iLvItDZGjzn92U4G1gBPZmm3KQY5ZUiL7D206bq0UYZxhoHiK57n/fQWUVOdjPTsH/MwN66jUBX6YqleN+l+0aftzqhCwoncRJq9fk9IxXnTxM+G1IcIeNCbVShqP49kW95OIlKFkLSIquvmyMpmWPJnvU7O625mePOV9t1IAzvY1NEhEWn71ccgbVLQrDPOhuyJcZmyZUC9mHGiSmFZc7xRUar2TCOzAJ3MMkVVEUeOvv68NLNrRf21c8YTpM8WbJ/g3wraUle1djFoReAMwbcLcvCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hca0CRVxQ/gSZZKnqGZy1RrV9p5XSwvDFNLGNZnN2pA=;
 b=JD7E9UhRJjcHxl2RIkUWMZUqk9dmMNTr/fkVvpGZY/sKqS8mvfkrkNaNLhTnFi1njRgw8wfwJu5fUcMaRnuZg43nLfm14gqdHldiIKwN8I7gsdFSpS+DJc3DdXba2E+26+sNbXBaM1xqehpEn1WOd819H3YkutPETTuCDM2waT8UgsAJsAu+ZfqMqXmSyAFixvVtHPt0kihAH17T0P/luSlUk+1+YU+B0LqJaGtcV9z0J+DnY6W+27Yw2PFgGYXV9N/daVNst1KhvaoZlWZwDqVBS43pUWcpecBOQuaRIlNucrNerjjGmDqmwSbQKObRGYg2LMgjaNYIo4JJkVhv5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hca0CRVxQ/gSZZKnqGZy1RrV9p5XSwvDFNLGNZnN2pA=;
 b=LgwZ3wCrxxk4QSvarvVVp0cODvFzOe6/kMI2aEmoRylzKsh1mgD/jcosFTg2aebOloDlIB5rxDNhaO+/iGslhaXz++d0OhODK8/8MroLbf56EomT8fjbSBcDE9UVjMLwpWJD+66gepVxaSTf/T5FKypDP41rJVzCV/+nBZnepDU=
Received: from MN2PR03CA0003.namprd03.prod.outlook.com (2603:10b6:208:23a::8)
 by DS0PR12MB8765.namprd12.prod.outlook.com (2603:10b6:8:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 14:39:43 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:208:23a::4) by MN2PR03CA0003.outlook.office365.com
 (2603:10b6:208:23a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.18 via Frontend Transport; Tue,
 7 Jan 2025 14:39:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.0 via Frontend Transport; Tue, 7 Jan 2025 14:39:42 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:39:41 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>,
	<alucerop@amd.com>
Subject: [PATCH v5 04/16] PCI/AER: Modify AER driver logging to report CXL or PCIe bus error type
Date: Tue, 7 Jan 2025 08:38:40 -0600
Message-ID: <20250107143852.3692571-5-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107143852.3692571-1-terry.bowman@amd.com>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|DS0PR12MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: bc41699e-eb5c-481c-6427-08dd2f291fae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HWdMJpQ4BdSlFMDv1r1O5pHxyqEv6ikwlPLVcemZq6u/mexZnbnsfhgYsZkE?=
 =?us-ascii?Q?m1NVKVXE+BdEiqR5DkkvW8WkpLKpgOLFGbc/sX2RXa9JgLuVET4FrZYnb6b8?=
 =?us-ascii?Q?IFMfRyGsqVukkjvkWRAY8QcdaxF+Eo0cdxUFPAK/4bHWjK14V9dkgPPUANOT?=
 =?us-ascii?Q?J6cGqQjTh2TvjADGeqDtv9RIojy8HSloY9i9KmNw5/OsbL7dqZp87darJQDG?=
 =?us-ascii?Q?AH4Ypj+BW7CPcfxuFERo5qdOYcVWpJjxD8zUMTkOsV23neqM8tLbhUuoMABI?=
 =?us-ascii?Q?eDw/O+zGE/sA7JINGwtp8nGYy5do90jHKebzp03sltQ8/JLIjdfyfiE46KXN?=
 =?us-ascii?Q?8m5iYXjZsyfse1ek6lRnyUCNxJ6DSo/hxso4Tes+v5R1ASGXE5aO47GhLikW?=
 =?us-ascii?Q?VG5V9hiU5WA8P56qAn+zdV8yRUWsVwEYpJusjUU1bZig6IAtHoGzEhzBEHTV?=
 =?us-ascii?Q?Phwppob0El0Kwt/K9nZfNLdZvCCclv1dVy2ihWwraIL1TnE/8P7OK71dUo7L?=
 =?us-ascii?Q?jBVR0NocLgEi6TnNRM2tQzrJA5l2U73LxbOv3IK6X6//sC3WTeghrKLfmhII?=
 =?us-ascii?Q?PHfLQK9xhkLZ04O8ZS2+wHlLJER/mhmCOQktwXDq1aazlKkqDvhdkTqufo6m?=
 =?us-ascii?Q?QQgKnvO1qsFEQCA+4zDYdhTJVy0vyBgm2W58/kg3v+3//q5/ExXQaJewQhRw?=
 =?us-ascii?Q?bKAnYyisjs9jo+x2PhfZsAaX1plm5QVRtj3+SXJeQ0Zr+1ZbIYmdmCRh0mJO?=
 =?us-ascii?Q?8JsDdUXLZeGjdSoeCWD694nATeuxfvA2l9tfarfPqfkpveEvo5dWSbCZkUGX?=
 =?us-ascii?Q?PZ2KSkh1ZSli/GhSODcgTM2uVtFHtyw2emHpDbGVoVQhJp7u8XjzzkymdZPe?=
 =?us-ascii?Q?OyiW6Eu3ab66PyvpkRnmkxANafTP08CO5v++uY/O1unF952yBQjbyvrOuO2Y?=
 =?us-ascii?Q?cyj6PTWI18H0AtkxRM28V4wvxN1I073Y3/z0Lz2E1ikedKOFIsAMB7YtKeoC?=
 =?us-ascii?Q?HpO524nDDYywkJuuhtULj4j+Cm4t4u/AROQ9hu6AtZGCEeXoaBtM9oGd1sUZ?=
 =?us-ascii?Q?/RzapmgU9HTQ9pufQ5PWHMIws6nIHOppaEJWAzwp5JHz33wX7cjmVFnuQcnp?=
 =?us-ascii?Q?tG83Lx7/ESYe+BtpH1lUZJ4he4Ds7nfHnA0aWDcjBlOm9R4Ho15VdJDQ0xMH?=
 =?us-ascii?Q?kCdnUdRYgFOabOJqTPELJGydqSV5aWdTheD67xMZT8sIILAIlI/q3u9ac9vH?=
 =?us-ascii?Q?i+KiA6ITl6c4+zDz6CwnIri3do05zBqf3MlDD2FGyx3uAj7sw7OaVgFSYJdB?=
 =?us-ascii?Q?fglKE3ivOpNwubsAqktbtX6x323I1TtY+zO299h09SoSOnaJy2IHwafUyFeW?=
 =?us-ascii?Q?xVztl0EtnBR7hCS4Zt0Kqjj5b/n0lnjYc92KczDtoxg3K51KSR5K8VpW2xBZ?=
 =?us-ascii?Q?PYRG8s5yr8tB0FChAhBz6FI7INjRzmpzZqKOg8VWHVYmzs4XEkGHrp40nAK7?=
 =?us-ascii?Q?oEGZ3L5yEQAOQhnJ2TbltqNSSnvDcEJsWnbe?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:39:42.7540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc41699e-eb5c-481c-6427-08dd2f291fae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8765

The AER driver and aer_event tracing currently log 'PCIe Bus Type'
for all errors.

Update the driver and aer_event tracing to log 'CXL Bus Type' for CXL
device errors.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
---
 drivers/pci/pcie/aer.c  | 14 ++++++++------
 include/ras/ras_event.h |  9 ++++++---
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 0e2478f4fca2..f8b3350fcbb4 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -700,13 +700,14 @@ static void __aer_print_error(struct pci_dev *dev,
 
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
 
@@ -715,8 +716,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 
 	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
 
-	pci_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
-		   aer_error_severity_string[info->severity],
+	pci_printk(level, dev, "%s Bus Error: severity=%s, type=%s, (%s)\n",
+		   bus_type, aer_error_severity_string[info->severity],
 		   aer_error_layer[layer], aer_agent_string[agent]);
 
 	pci_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
@@ -731,7 +732,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	if (info->id && info->error_dev_num > 1 && info->id == id)
 		pci_err(dev, "  Error of this Agent is reported first\n");
 
-	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
+	trace_aer_event(dev_name(&dev->dev), bus_type, (info->status & ~info->mask),
 			info->severity, info->tlp_header_valid, &info->tlp);
 }
 
@@ -765,6 +766,7 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		   struct aer_capability_regs *aer)
 {
+	const char *bus_type = pcie_is_cxl(dev) ? "CXL"  : "PCIe";
 	int layer, agent, tlp_header_valid = 0;
 	u32 status, mask;
 	struct aer_err_info info;
@@ -799,7 +801,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	if (tlp_header_valid)
 		__print_tlp_header(dev, &aer->header_log);
 
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


