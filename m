Return-Path: <linux-pci+bounces-15355-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F58D9B1150
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 23:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99389B23D80
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 21:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B772C1FF04A;
	Fri, 25 Oct 2024 21:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1C+RKVvN"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820A517B4E2;
	Fri, 25 Oct 2024 21:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890241; cv=fail; b=GO8MNvwr80AiCsFjr+zt+07zwCebUaRQD6q5qmuCz3p7PTNuFbrVJXfOTiancVhWwQHcttb+wToedXax5S99zjyR1LLxxwkJYQ1e3GPLNG0GWH5JLLaCACiCq1jk1o2UPNvfEzDRuvpP0sTOqlNq2PRg8wddyvz61tF/vZR0DfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890241; c=relaxed/simple;
	bh=nrFfd+HiD6Cm4JfvDVKJZ+FZXMnIS3ckYJOdL5s8zck=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o4LBZldsK2bhUr1juPOY5Kf8imsNX1m2kYxNaFIPKb0KS90KjH5hxVZyu/YVIusZZKqmzcIJ17XAeSkPBn90lugYOh+L8P/yf1nNCKqAqH4uapAkNfxrgfbplLLb/Bz4XDRhCKi0RBrfGJWXV23DAT9AMskiRbgskiPuaF2vfA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1C+RKVvN; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vISGJ87Jg7mak9wjbOjWltt9r0eCfWwg07SBVaRH2d5u4rp1Novshph2c4RLEheJV7JXRBGpZWy2WDcVK18fL/mo+TBOW5K1sKKj+Lg+UAkpDUGLWdBpiChQ47J5lGHzuu8wP0+2oIUMIv1hPbcKwrCX8/Qyh+fNRZTGfnIcn3s2JztdJduD2YhapTZxBSICfrcYFYqlrKE2jMp7wxFTd3vYDfmkZozBXOOBXj0FdWi6K6heHZitg+N5BBtDY8K0fu1FxNwqSFuglZqyaSFEbOLylonXd+CjMsQcJrQiBGbPlttuCbIyRGx6s3OM0IyeFInMvK6NdLScfJTxGyTa3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/Mm9/AHwA6oFbwvuuIcPE+b34Z7Bpr+IbqMYM3pOzY=;
 b=R7r+2wov+ZXFv6IDxfD5Q4UYsNCOOCLzS2LfmOQFsbpXj/5Io+eJRsnGT6IkrRZV98cv8IgWlWYqQ3Q9obt3XrQAVsYLBgqnF6PSrZY1vT9dHo3OK4SJ5cvTXkgXW6z2i7TkmvgwyzcAiRWPgobBOp6cxsKhWPzjtO9Hta7DZj7AaIQLpccnkQVyeRhSolkzOQtlayeHJFbIhFmKnM1SuXQ2KJ4Nmm/mNM37iA2VpAeTR1Mv3SIzCwnjnI54vPQsNGsRHcok+q0Ge+DXlFiTn219S6iuURNbVUaVUBvimDfmbsRZX3U4SG82i0YI9G4qx8pJNfsFrKFEJBJevhmEOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/Mm9/AHwA6oFbwvuuIcPE+b34Z7Bpr+IbqMYM3pOzY=;
 b=1C+RKVvNkxcvw9ccl3e6tAF5odgtZWoe0nryItCeeBCypRLD3igaTQ+oVbFEcuJqXgroXoYlxs2W9H5XuMvFa+CplftxEK9phyTLHvvgBc7qrRsdtJoTE5Gp1DP57hFOrEcybRmiyirvjzvzVXVE9FmkM/idVkejfzhkLkkhMbs=
Received: from SJ0PR05CA0112.namprd05.prod.outlook.com (2603:10b6:a03:334::27)
 by CYYPR12MB8656.namprd12.prod.outlook.com (2603:10b6:930:c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Fri, 25 Oct
 2024 21:03:56 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:a03:334:cafe::75) by SJ0PR05CA0112.outlook.office365.com
 (2603:10b6:a03:334::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.5 via Frontend
 Transport; Fri, 25 Oct 2024 21:03:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.0 via Frontend Transport; Fri, 25 Oct 2024 21:03:55 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 16:03:54 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v2 04/14] PCI/AER: Modify AER driver logging to report CXL or PCIe bus error type
Date: Fri, 25 Oct 2024 16:02:55 -0500
Message-ID: <20241025210305.27499-5-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|CYYPR12MB8656:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d177634-f314-4e7c-0da0-08dcf53889f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eYXcCyCrqC9gZmTi1F9zHFNukoXGBAmCXP4wn/amrWUzgE225s7utaEjP10M?=
 =?us-ascii?Q?w1g/jIOB26m5y3yAyXI6doK65L8zpVwqXCkQegRRR2gYbR+Bl+cSFfYDNsxb?=
 =?us-ascii?Q?POSNZnLMFwgdeAjhsc+EOEWSVi7/j7CKLITn3xwN7rMfsdxvQyFQgURgLHUC?=
 =?us-ascii?Q?Z99Qn8nT4Bt0LOOfTqpDk+SWKJWwFH7yFAzcihJ7qvoLL5bkGtqzD8A5zDgg?=
 =?us-ascii?Q?pcvrq35K1PsCAo03qS5BAJH6ZgLXQQlG9FWssbdSweOxcL7ytBrp8h5NcuGS?=
 =?us-ascii?Q?tbQuh7FQpXP6545I7SgTzzF77MvHm4ft4L1KjgAvZMuqcuVRxBgjTQJWYy5U?=
 =?us-ascii?Q?3p+9HWLIf2nv5B+CJ0MIYyDQZGjBqrKn9lMiSZZ+C0QSCURoceMiQhfTxgmg?=
 =?us-ascii?Q?LERk9ETvGVy6D70jq9/kDF+YdiBLLWEURNC66EJzZfXMwMidK5O39NNe3qh/?=
 =?us-ascii?Q?i6GTTwW+lnVKUwByWRERlZN7E7Iq1mVLtcpxEKtcgu0EpbeNOjsHtENum+ZU?=
 =?us-ascii?Q?vq+c4U772BX7TdrFdb/FN+Zw+BynvOziNKdD8jikzL/LO6yA2is+CXfHgdAz?=
 =?us-ascii?Q?FQWsgp9dGOrPzcFgEg6WRAeAlFKHberF2gAB9r/Cbl2z7E3eqPak93eKclAI?=
 =?us-ascii?Q?FDvJ6ojKiz2+qWM+dyoGG4mm0UmHWx9I3itnVCI+TYi8f48fgLJuKCQE7f+P?=
 =?us-ascii?Q?PUcaqlIiKA9zfseVzzk2+ZsNPBEF3DQJxTibohN9sAsonqID7gZRxN3OdDA+?=
 =?us-ascii?Q?rBpZY/UJ/SJtzmGnRYKLTuTYQdsRUrqkA2hMwUNhnt0EuzB98Lvk0cvYBwF7?=
 =?us-ascii?Q?MmWlQnKgHAsVr+M8Q0TZY8BXZVxJE9HrUM2HFySydqhVd2S11mv+y3MVT/b3?=
 =?us-ascii?Q?kGL8vqQmw4d+5ija7pu55Gywm4B2Qbpn+z2ZVS+Byit8f0Dqse6bVTdPhHgY?=
 =?us-ascii?Q?E00qYrxurobKtRRAjNaq1a/yOGEw3nU80t49pxtzotkSqpKY1XPhzh2+SJ1A?=
 =?us-ascii?Q?Az7NpILLNOH5Gx4jxD4XrxQOd4v9l2ccuGnhszZf+7gYl4cSTICbsoGME7Ch?=
 =?us-ascii?Q?MWcOw1YArY78AumunaVrZGwmXUPaOG78gBchFsITxPrWqNDgEEoPJ3bAXZiV?=
 =?us-ascii?Q?rNMs6NFm0ZotP3B2Bz68moZGuk32jeSKo3b4bur2F16I0JS22qahiyl7GNEY?=
 =?us-ascii?Q?ukLxaqs29+FDV16uWZG1ZTUYqOzABU05NEecdIOLNNdlAToeNycXSu/9+exm?=
 =?us-ascii?Q?tn+NXDNCpxpK+uyKZsA9RpULQS0s+26mO0vOQCEGVuzQZ5T3wTbXWMCOqv3/?=
 =?us-ascii?Q?XlVL27xhGIObYETYqlDWvbLHeGtNGq4sxs+CNYeXOEGtNSay/cshCK7TLR38?=
 =?us-ascii?Q?aGFe922qgAIvpaHWFzT0A5mMOr1hzXVNk1TJzaKJUXhzJnWsQ6WGbFCtDs66?=
 =?us-ascii?Q?yVCBf3cv5vA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 21:03:55.9299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d177634-f314-4e7c-0da0-08dcf53889f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8656

The AER driver and aer_event tracing currently log 'PCIe Bus Type'
for all errors.

Update the driver and aer_event tracing to log 'CXL Bus Type' for CXL devices.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
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


