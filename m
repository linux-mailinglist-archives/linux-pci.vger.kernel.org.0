Return-Path: <linux-pci+bounces-39614-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E04C18E92
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 09:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B96681C83EA8
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 08:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1A731282C;
	Wed, 29 Oct 2025 08:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WtM+2WQw"
X-Original-To: linux-pci@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azhn15010052.outbound.protection.outlook.com [52.102.136.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6AE312817;
	Wed, 29 Oct 2025 08:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.136.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725166; cv=fail; b=sbGTl0nkDiioxvv08bcuk94NXuAYv0VgGxQCUrZBV2A/ydUD6/OftChfL4pYd6aYTTbCBKMp4UzTAQE96loTyuxTxWSGLDrkV3wWTM1ROpTd7uxo2Efm12MBcynWo3wXUKkDUVQonMQWveNuX42jHNZacABhdaRgNPlrx5oeIqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725166; c=relaxed/simple;
	bh=52HN+ugfCjbC2CiWl7lvwWzv5OCsEY8VycsyYaW3lG8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JO1nMThpI2MBMRdSBNkjd9bQbNY4trsJMZ9jT+Y6dP/Xkc0CyqVg7OC6qWXZsuq4INtCEyE0EhCs1Kn3sc7/LfAggTqTpbcuVeWdmKXKKwHzyou7FJa1gctEbdpdc8ozJKPQQSMyz4gsmnnPfKmmym6KXaVeh8XxseF2F2tfBIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WtM+2WQw; arc=fail smtp.client-ip=52.102.136.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JHL1OZSXEmSRqDVuP3Vij+GmNEgLlIVmfL9GPrx/5pFYhYfa+FuRYWpuTvN6zMjTb7jNdW+fGc1OFRGfVaC+QE23l1nJmwsuUNc++D/QE4NXxyzq6WK5QpAl/Esv8QlGweo4P6+Thwt4yns5Bc8sTM5Swhis//n0X551cQvnMbdHk7FpQdhRHJhPHmxpNUeTu87F9cGJC+254O6fKwNis+2cl1CRg4r26SjJnYBJjnhoGIU+9tjcqeTFlcYWL4+uzgNEq0Q0UNQw0WUjE9AHbjaPviVIpfFelw050z4iq7M1Cnvg1tYJPkDd8mE/Uiu1OVWWZyt+U9kM50UprqSP4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fl8d1QOixuFfqARh/pwDGdVGrkbcUy//38P9kmQip5I=;
 b=EzMlsZPXNPcZ6Qi0FxR0JpxgC/bC7uN9kdsoQMYnu6F2pEgoN24TKKTAwgHR1CGTIk35IGQwqlPm/E5/OeQJ6YQJOS/2/sMr21l7p+wxdisW0vF0dTyXPDYMgHJwU01uNE/fRGtIHj5y56xW9b13Gdn2SvewVVRLbV/b6awIyQnJMU0mn9Ce21HB/+LfF1Njh7TZ/TOsgacmWZ7ZUD1SW3xd+8UACdxWNlCq3vvrS18fEg3+UoAV9XkHIV3EIMkdSUJI143QMyuxPBBc6YbqFwUqGx5/e5bGBSHIb/S0uyOyg4lo7P2UZ8j8IDKvJMPnI3eIuzY1e7Pr7+xWdeaTsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fl8d1QOixuFfqARh/pwDGdVGrkbcUy//38P9kmQip5I=;
 b=WtM+2WQw1D+cbfaT3D6wr8xhFcZG7j7VGn/qCGxfxJ9HGABCfKzXqMmCSu/ghcyOvVCkMxh7Rs+s1beRd9VxU/ToiBgeMLDDfwpLoMvpjcL7m10HNO//kdqqebF5m+3igIuy9JijwPmBNHMqXIebEIEgbFKWYSSkpieyCfjQq+Y=
Received: from MW4PR03CA0239.namprd03.prod.outlook.com (2603:10b6:303:b9::34)
 by SN7PR10MB6498.namprd10.prod.outlook.com (2603:10b6:806:2a5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 08:05:59 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:303:b9:cafe::5b) by MW4PR03CA0239.outlook.office365.com
 (2603:10b6:303:b9::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Wed,
 29 Oct 2025 08:05:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 08:05:58 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 03:05:49 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 03:05:48 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 29 Oct 2025 03:05:48 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59T85aXf3704660;
	Wed, 29 Oct 2025 03:05:43 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<christian.bruel@foss.st.com>, <krishna.chundru@oss.qualcomm.com>,
	<qiang.yu@oss.qualcomm.com>, <shradha.t@samsung.com>,
	<thippeswamy.havalige@amd.com>, <inochiama@gmail.com>, <fan.ni@samsung.com>,
	<cassel@kernel.org>, <kishon@kernel.org>, <18255117159@163.com>,
	<rongqianfeng@vivo.com>, <jirislaby@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v5 1/4] PCI: Export pci_get_host_bridge_device() for use by pci-keystone
Date: Wed, 29 Oct 2025 13:34:49 +0530
Message-ID: <20251029080547.1253757-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029080547.1253757-1-s-vadapalli@ti.com>
References: <20251029080547.1253757-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|SN7PR10MB6498:EE_
X-MS-Office365-Filtering-Correlation-Id: f178eb3f-6722-4f43-374d-08de16c1fe73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|34020700016|82310400026|7416014|376014|921020|12100799066;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8dKQ5MT9J5XyqKrffKt0on9s2XRO3NSoahcn8CZUNtST1ymDGSIQozdwTPb2?=
 =?us-ascii?Q?GDEvkjKkx7ax4zb7pv33eHZdGHUZlqXQ5M5jocVkZ/SUMzacCQun7z0VCEid?=
 =?us-ascii?Q?9gfmjsSjcDiLmsYqwA9GArsDDT6Dx5PLzatObOhCAN1+hCkmbwjHGELpNhDE?=
 =?us-ascii?Q?3NjXD6fHIY4L6A3bU7uyIVe2AAxNC9tBKbbcj2tAXOyORbR7o0lz5tX9hSm5?=
 =?us-ascii?Q?uW4Il3TFTrrs9O8247ch0DXeYtEcDWMcktVGmZuVwfZBtc1nt3/nd1HNxXtU?=
 =?us-ascii?Q?9OFTRLMAD0jiy8zJX3OI6svAl6K8/w8n+iHa48GBW3Pho4KIRiTIgdzDTseg?=
 =?us-ascii?Q?S0knzinE3sCevn39Qcw1F9z+hQ7P7jccmv+DAbGKsr3VSWcEKGgjPW9jaXym?=
 =?us-ascii?Q?RNg3/0wTrU7oeut3Nao/s8n16ZZ4DA+nuCH5Djs8zEWaA8ti9NLc67BrG+33?=
 =?us-ascii?Q?2MHkAAzytfPbOy5NezkH8JpXuENiXeFXnjPZNpbOAc8ybJhi37ZYMbwVfUoe?=
 =?us-ascii?Q?Rrp0LJSEJGBM+XYn/5Ko1SbAVR1X8nTnfydi5zbb5WoebOWeETGqqZREeRGH?=
 =?us-ascii?Q?apQRTmILB8HhG8I1hRaFHPNpblDuePZrUEJ2eCDd+Qazesqj6k2omiyDoKyI?=
 =?us-ascii?Q?vgVnrZ/CTkbGmHfBTVgZ19Mjbdh2G30AUBqdGmGCflSdhwS+9nQHvL5ih1MT?=
 =?us-ascii?Q?9F5exgj4jtpgu2XXxC0G9PS7okGH0o1M1apHmNQgctoxEsvRwtsQ9iEITdnK?=
 =?us-ascii?Q?7U3+xR12p6ZEx4dNHywjyjWqEHd0r3v1ihjvQcVOyN+UUSJN5etjKsqb2IsD?=
 =?us-ascii?Q?VjC0yBF5a7zRCPIXrnLUSJIZzn6dMiJ0L+xUFcRKrubV9akqx0lRCy+1yxQj?=
 =?us-ascii?Q?q1xyXiFAN7LTFPzNt6eaPBY/gvDws1EIPkxJcKIZZtz85CFXN0UPTdNbSNDx?=
 =?us-ascii?Q?RXxVCi4a07ZIdxeV1hzanz3cjiZ0W7csPDNkzYOQ276OojAOosDADSj/gVen?=
 =?us-ascii?Q?mn8ms48z1D5UChOJrwRBA9QfR73nDVBRxanJJekRhQhJl8CqfrkZjT99jY9S?=
 =?us-ascii?Q?r1zkwCsIaCx6ZoJ+clXCX7TcKtAbW3bwUZ8OFT62giMKaTZxL9sRHTRT48Tp?=
 =?us-ascii?Q?ToSq7pXrrGWUzldHDG65HYWj7wHdtN3VYaEt0QPs4aNALm0L2qB0UOJPHvEq?=
 =?us-ascii?Q?N8KJx2lVpcjcfxcc3mDb4Vyj9fEMfFTe49RFROrGjaZyokbMPwrvXAPrMZQz?=
 =?us-ascii?Q?Sy3yNJKW1h3Gj/6SffjlKLBUPJnKJHwcdrVrHNnY/G1MSvSDi6dgAc4lWs2E?=
 =?us-ascii?Q?XVmxlr+6CqXmHbOgWPQduKEhbYFY9joA8CoMqRCiyzd5nUEU3vwvkN7swkEU?=
 =?us-ascii?Q?hFaqxjalrrLx1E/O2qgwQp9YTiob54i4QQJQKikxoZMRSNzmuqQ4oz1sgGzD?=
 =?us-ascii?Q?DipNW7C5jrn0JlW7VgUWgLzQ14WS8qXD3ykIpPx+GOkozsAlvT68GkU7HOiR?=
 =?us-ascii?Q?Tq7tcnCg2pldqqJyGEqrGybW5frNTjMt4ki4?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(34020700016)(82310400026)(7416014)(376014)(921020)(12100799066);DIR:OUT;SFP:1501;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:05:58.5824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f178eb3f-6722-4f43-374d-08de16c1fe73
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6498

The pci-keystone.c driver uses the 'pci_get_host_bridge_device()' helper.
In preparation for enabling the pci-keystone.c driver to be built as a
loadable module, export 'pci_get_host_bridge_device()'.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

v4:
https://lore.kernel.org/r/20251022095724.997218-2-s-vadapalli@ti.com/
No Changes since v4.

Regards,
Siddharth.

 drivers/pci/host-bridge.c | 1 +
 include/linux/pci.h       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index afa50b446567..be5ef6516cff 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -33,6 +33,7 @@ struct device *pci_get_host_bridge_device(struct pci_dev *dev)
 	kobject_get(&bridge->kobj);
 	return bridge;
 }
+EXPORT_SYMBOL_GPL(pci_get_host_bridge_device);
 
 void  pci_put_host_bridge_device(struct device *dev)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d1fdf81fbe1e..b253cbc27d36 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -646,6 +646,7 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv);
 struct pci_host_bridge *devm_pci_alloc_host_bridge(struct device *dev,
 						   size_t priv);
 void pci_free_host_bridge(struct pci_host_bridge *bridge);
+struct device *pci_get_host_bridge_device(struct pci_dev *dev);
 struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus);
 
 void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
-- 
2.51.0


