Return-Path: <linux-pci+bounces-18196-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D609A9EDBD8
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 00:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D4642811B6
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 23:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A9F1F2C4D;
	Wed, 11 Dec 2024 23:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bx+m4BqY"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C07D17838C;
	Wed, 11 Dec 2024 23:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733960459; cv=fail; b=DHj7HttY8pSy6dJTJTZ3iD1B3rCty8Y4/O5CiOnYsoQRHniEkwrjIlmPfXpEp5WR0cb4UOLQdojhhRWAUvbtVSEUNQwanTReK4D1fE2KWtqyjEkBeTnl7rRuUiQ94kaboQhdjmwZVs7klj4wMPHDn52sybgU5qUnk6QQS9nPnBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733960459; c=relaxed/simple;
	bh=ZBuUM8SG5EdLQJ2R5ge9rgup/R7vP3IVYoZDdFBnqqI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tYhVTAH6VWO7oMUEMWFPfDbQX4D1P+C2uT20xXiMslkDy+H7LGFw07Im7eJJhEDYRD8D/G70synA5zHek7/gw2EkqchcRAAoYvaO/+z1LNAsWSSLWsqlsnBGbkWckiCaLhy21P3t9n86oZS2o09bLC3lPP3azr2XUlOfl4EKO8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bx+m4BqY; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ju/TVLuQtpzGprUNHdpOHChcn9u9PRCZi6AtY2LKfxs0pxtKGxgsZCZuFgghoIXpUoRhN34NM1LYWV8n5813Q0cj4iJVVG7cKaCS8HTu1NU39SF1ifWUGJh3iKWIQOwKhqo20hkaRcqhG9lyOdjQuuvLEZ96J2uIbg/cShCEmVT/DlxhCxxZmTiL2kVHZYFMYp5mB/T9k5f+WntPqJT86O2A9pCrjz7rPpAvn9mhWK4gHIJj+uZoGtsH2CgGIatWacnds1hmmOLZggJG4ptLb4mOyF053HmP4SA26Aa/z3zp00A6S3IdoxDGjsDX0xkBkZaDesaauPOoLBeeXD6z4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xABIalKPiUbSakFCC0gi1+YWxkSsqB+qdVXHkyN1Y7I=;
 b=w021Mj2Xfk/KxTSmESPIkZiCkmuqf2BQPpF0ujFR7VCLEnzGovejUx4i6U0UOMWilmeBRoYfZTGGaEJJWG/tfMC6VgmV6rYIyK7Yiky9h2T4+NsCz/eLhVBERDm/QAfhoFPrRtUKp+X+ADggOamdHkRzN4fid7v4oLIA8AslodTgGE51dLUehOXDcAbutk8zWgaqF5vwNZTdzOSXwIg56Ot2N1dFyMwjrWeUYpaIv3rRUgZ+sBS5AGqYQLw2rHc/0RwHTTJ9SBopPuyosIMcZ/mQW/B19bcpFoF6Gbacjd7DfZERsIDAEfNT5JaZuLqKtflNLZKVEkpVIn9nWzoPig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xABIalKPiUbSakFCC0gi1+YWxkSsqB+qdVXHkyN1Y7I=;
 b=bx+m4BqYL3utxb+Lqx9l7I4nnzEOXYgxiywwlRAmfyY6nB7fOdqvX+WKLSQUpzI9JW+Iflwg+4Z6EQ7vDaFyqV/sIsAjTJN1PcTOKGI+QcdioBdWbRwazPUhbwsWRhIUOmUXHwzuwGoGL+AR/fWw8gOVmN8r34tMsZIa1kTF1M0=
Received: from MN2PR14CA0009.namprd14.prod.outlook.com (2603:10b6:208:23e::14)
 by SN7PR12MB7955.namprd12.prod.outlook.com (2603:10b6:806:34d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Wed, 11 Dec
 2024 23:40:53 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::bd) by MN2PR14CA0009.outlook.office365.com
 (2603:10b6:208:23e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.14 via Frontend Transport; Wed,
 11 Dec 2024 23:40:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 23:40:53 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 17:40:51 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <ming4.li@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: [PATCH v4 04/15] PCI/AER: Modify AER driver logging to report CXL or PCIe bus error type
Date: Wed, 11 Dec 2024 17:39:51 -0600
Message-ID: <20241211234002.3728674-5-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211234002.3728674-1-terry.bowman@amd.com>
References: <20241211234002.3728674-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|SN7PR12MB7955:EE_
X-MS-Office365-Filtering-Correlation-Id: f9c6d093-c8a5-46e1-02b9-08dd1a3d407f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jyvWh1NHSfpY6V/GOTq4qRo4uxOxloNlPaPhgSrRLwkYkgBOGYnc3asT5DDl?=
 =?us-ascii?Q?rS/al4O08i/TXvoMKzhVNDdg3aj+CfyoYgjUVFh8QlqN5axLwY0ay9HYMhZt?=
 =?us-ascii?Q?uC2AzNHMzhlNrM9Qr5t5CbiLFKeeC96DM43VFUsDrcPpYGvg7UZ5K2pLnPsI?=
 =?us-ascii?Q?tOMMWrGPLB9qpOpWf/+rp9lL38cUaepKOhjZoMn39qz7p8VOHP2i6ECwjub3?=
 =?us-ascii?Q?ah/cCIrBsbUHWWmUL9L9kQpx9p9kQ+0bfJ2ylD7FdzRwS6/UN3C7eh2+dfLA?=
 =?us-ascii?Q?kYGb0tiZDALEyIoPigd5XZH6kOZ1FYYpwmCTOvQx44x3Eo42DUh4IXKpaTp+?=
 =?us-ascii?Q?dkvC31Imv0apmimQjQ1FQPfoBAjrmtq4EzxebHtAKAYysLIaITcdoN8bdM0g?=
 =?us-ascii?Q?5PDYh1u/l6Q8T6zz6wxB09CgneFLx5zuLMAjsRkhiH8cnEsGJOO72DF8K30I?=
 =?us-ascii?Q?DRKTeIoFxuhr4NJ94iW1UlAT4w9Y696OdUfIYgpHpnoUOESW0kZnnBoER66H?=
 =?us-ascii?Q?ZktCScyusucB61N7shoJbZHlTlm0xIBW7lw5ZOj43/lOYra5LeXBlHPad7QB?=
 =?us-ascii?Q?wW1VRcKtcnq+9gaEHBOjRh0IIoBa1SkAmPJp9kd2JXFveFHWurGoG2eiVfhJ?=
 =?us-ascii?Q?ONk+0die8YqXywoMJv0/xQ5PMpHYb1FtCZ5JalbicFv4g2dqMtUPlK+q5IJi?=
 =?us-ascii?Q?5I651Q2E+LSTSkOSAiG+6RxmJX80ZRB4W14g9CtoUKLfy+hu0R7EdEOk85/A?=
 =?us-ascii?Q?WeWi0UvwTFIcN3fYo+vm50xLxyYHFEpV8RiGOF+rCphyF70g7uajbVVkyx4H?=
 =?us-ascii?Q?MJyF+9L8rYDSCPMUBpjHEjtPEpJBd9x2tnIkmSoSyozh9GYn1ho+VQfMdEJz?=
 =?us-ascii?Q?YuAgkn5HacDz/4roYUV2VVjvV11/v6VT5J9DJQIq7go/+XRxvzF3u72BpbuP?=
 =?us-ascii?Q?GfmoHPgLo0b8Z+WP69p4WCceiQwLrEeXmjHdyY8GLwSrPPbVXMJyi+0j6BNt?=
 =?us-ascii?Q?BZZsKYCabzhiOCalQCXUunGhdqA9hulBJB2szA1L/kKI08vexXlLIWJe8lej?=
 =?us-ascii?Q?nwWm/VDgu/eMx2z5yrB9ENcNmw6LOiKCVrdjMzPgd5M1H0DMbIcJLzIr4txe?=
 =?us-ascii?Q?sovPm5E57tf9C+CqtYjZPI/3Hg3IPd8eLumIFA+NQ85g7JGkH+YVTf7iYniU?=
 =?us-ascii?Q?F/wnriTdpKUDK+Rs7ZXgGV2fvsR9pNZYykCdkhAF+VsamGWGubBeP4jYTtNI?=
 =?us-ascii?Q?81oXYI7lDpA1ZhgzPYungqxbCzG13xFP6+l3DEVkmklsy8W6lboFzmonJtI1?=
 =?us-ascii?Q?v33VoYvex3ibI5FG0n1ZcH570z55KtPmwr8yc9kIjyx/5RYSihvIPEodVUWq?=
 =?us-ascii?Q?uOcFSsM1Kwqe1uXV2x2fA8MSdj8FSn84fxGqG3hkuHxW/RD+5ldliJEnmF0G?=
 =?us-ascii?Q?PfoP5pdXhkAAq9WSwg32vxufKPjd9QVLmSR/bRMzmoPZEuxTzpuDYA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 23:40:53.3246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c6d093-c8a5-46e1-02b9-08dd1a3d407f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7955

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
index fe6edf26279e..53e9a11f6c0f 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -699,13 +699,14 @@ static void __aer_print_error(struct pci_dev *dev,
 
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
 
@@ -714,8 +715,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 
 	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
 
-	pci_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
-		   aer_error_severity_string[info->severity],
+	pci_printk(level, dev, "%s Bus Error: severity=%s, type=%s, (%s)\n",
+		   bus_type, aer_error_severity_string[info->severity],
 		   aer_error_layer[layer], aer_agent_string[agent]);
 
 	pci_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
@@ -730,7 +731,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	if (info->id && info->error_dev_num > 1 && info->id == id)
 		pci_err(dev, "  Error of this Agent is reported first\n");
 
-	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
+	trace_aer_event(dev_name(&dev->dev), bus_type, (info->status & ~info->mask),
 			info->severity, info->tlp_header_valid, &info->tlp);
 }
 
@@ -764,6 +765,7 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		   struct aer_capability_regs *aer)
 {
+	const char *bus_type = pcie_is_cxl(dev) ? "CXL"  : "PCIe";
 	int layer, agent, tlp_header_valid = 0;
 	u32 status, mask;
 	struct aer_err_info info;
@@ -798,7 +800,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	if (tlp_header_valid)
 		__print_tlp_header(dev, &aer->header_log);
 
-	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
+	trace_aer_event(dev_name(&dev->dev), bus_type, (status & ~mask),
 			aer_severity, tlp_header_valid, &aer->header_log);
 }
 EXPORT_SYMBOL_NS_GPL(pci_print_aer, CXL);
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


