Return-Path: <linux-pci+bounces-34685-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D058B34E5A
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 23:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28E5F1A87BE4
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 21:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABEE23A9AE;
	Mon, 25 Aug 2025 21:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PPW2/S1l"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C501DAC95;
	Mon, 25 Aug 2025 21:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756158507; cv=fail; b=Ut6IpEV3h/HDLW7loZX2LkdR82cuSkO7Lk3YvYliNKgBNL2vJU685Fm7ky0Begb259mG2fRZjFPLVxhGDlu2A9PCahUO2KQ5YjDA/J28hifCySOnqihhC+O1wCsMeB/9mwUvq8UPMSDd6OpapwsBynOBZBDAHIt0hjdOWtzmGmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756158507; c=relaxed/simple;
	bh=4EdXee4xirRWerNYkSZ3kEZTKwZSj76kLF2WqBHgupo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nuwhXcKyyw4FJssnPSQX1XUS1IXXey5Rn/R7K2yrerEALbd+y9nEoSL4Aua3vhmA7Lp61f5H1HLXKjvM6HAEPx8K2dQn9+D0jqjMspIuIPk8Kj900hZY5eA3rGQlEDJBTcarRASmlWo2UZOI+oK3EylAnrClrjXyjfEuZRd9T8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PPW2/S1l; arc=fail smtp.client-ip=40.107.100.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agEUotijWqBW0djgzuQvdOi3rVTEKoqObCdT6JpdhVnzR+QgGKGjwSicXed89f8APjQzRLmpGsLbdiIHMSossB0/BQe9Mma4eT7omnnm+ulMDM6VRPG+o1IzKqp7XPYZ7GxfgqXWXqCmSRcEE/vIfl8rxEJGm/J4CA4oL9WCfuCHWA9/EQnxe6GDvgb10i5O/SgDWmS57dN9m3OUMgnFuQvfZP3kxzzG/iOoubLi2gDGvIKzkRXFfZyYK8lusiIfZxHaLl7qARYoM4mhuWv8mg10wmd6WoBt/1auirHIYOwJav9NklrkyrHDcwEE93I3IIOixRKXi/UDV0bjoYu3RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfkGQa4kNxkmKuOFVEVd297VQre0X0sWx8XS1JniY6M=;
 b=e8Ys8zwaCNpMIg9k/m76U3Bkf3+1/gDsvUv5sEbP/JzLQGUCRHqVIvhSiHMpe4uCK1J5uDbAn4D5PizzrwIgG4AfjHkvCNZxprej/lwDOLRTf+b1GCjJiEqlpUIU3SNvUb8BS1cDcn9gQLb2iT2ytIuK+PvSe0nKGuiceJHPFEIqmazsy1Wtvd3XIFuJFWTsMULxOFXzhb4xm7vvBuMEAfP5+TYjVxFZ4IO1ClRrat1UuvvObC1V0CRtc0bkc/Khf74xfZbOKsAL+4yaMd9a8KIBCnglojn1eUoi6vSEWJ9e9X3A1n1SKd69GmuwQ09Ug77HdmkQScPBqLWenzSsOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfkGQa4kNxkmKuOFVEVd297VQre0X0sWx8XS1JniY6M=;
 b=PPW2/S1lFdu9ZqMFvyeOG/uMoYDGAo3VANKqVyHnUdIhhclF6/Gb4FwCDPke45t1CVaSkB/oli8qoUEyqKuLpDfZY+iznkBVY90gokxjHIoancKUjnYcjCtEiK0F5IbzLqbOezefZySeLYeqyQZqqVb1y7rci5v0iBYI5hxdTjRamEPJIFuWpl7WcCsWBLRTE5YlQTwSdAjXk1pS5F3FzNKD4Gw9ylS5VAfaGHmYifxuhY2jDH0Eris094Hls2iG62mGrHrwjiZGe3taE9H8imISVko0uqG5MVDZrNYA21ADyE0naF7kSrcDAudP2q87/QmYzsREkKFmtDcNkuNGxQ==
Received: from SJ0PR05CA0003.namprd05.prod.outlook.com (2603:10b6:a03:33b::8)
 by BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Mon, 25 Aug
 2025 21:48:21 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::3f) by SJ0PR05CA0003.outlook.office365.com
 (2603:10b6:a03:33b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.13 via Frontend Transport; Mon,
 25 Aug 2025 21:48:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Mon, 25 Aug 2025 21:48:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 25 Aug
 2025 14:48:04 -0700
Received: from 9491a72-lcedt.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 25 Aug 2025 14:48:03 -0700
From: Nirmoy Das <nirmoyd@nvidia.com>
To: <linux-acpi@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, Vidya Sagar
	<vidyas@nvidia.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nirmoyd@nvidia.com>
Subject: [PATCH] ACPI/PCI: Fix memory leak fix in pci_acpi_preserve_config
Date: Mon, 25 Aug 2025 14:46:42 -0700
Message-ID: <20250825214642.142135-1-nirmoyd@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cf41892-43e8-43c1-37a3-08dde4211c0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oe4uEBJ1TtIHzsR5Q8XVP9SQNKfrFuwPrGBOgfkSZOPvhk6dEFiTSYquHP0K?=
 =?us-ascii?Q?XsKRQj7pAlNobSW0jaIyv2Od+9IP8VlSM5b8XE+20Jdwa/icKnb91sBScEIi?=
 =?us-ascii?Q?kZ7YZOJgEkUm/Louv2ZHJ5DBd0gMcVeRMXoMJiDO6Bkd+jh8TuUEAitnQSj/?=
 =?us-ascii?Q?N/cK+15OT4lT8wA31pHqdvKQrH1J0fZFCqxJVby7GBcuuXfRU+GzUqHqTKCt?=
 =?us-ascii?Q?74ZqvTxKsBJpgPZ9ryzNvrWGMZ/i5kQpD3daktHUwaSprHw+hQaHQCGbKFDu?=
 =?us-ascii?Q?qZ/AR7p5tPkAufEtOgtU2J+1cGjRbMJ5tjkey66AFHjCj9mJ6BtZEV9qCIbV?=
 =?us-ascii?Q?C6wY+nQIRKB+7Nnm7wKDpL8dzOR+va31TqsEpYvSlU7/6VsVz5v7PpxoPL1b?=
 =?us-ascii?Q?uxDZe4oflZBv/o38vCJ2mEjEdjYGcwiOMHdrYV4WnxNVFUDVDJ8ozAVHEXK4?=
 =?us-ascii?Q?Nvx8iDEEeWHkvxKKyf8S6qKHFU+0zO7VorFkkYZSi6rnqICmmPlYfLhIpaOg?=
 =?us-ascii?Q?eTGkhhFG5tS//u8VDPq+mYaIxGdf3cYjJ48pUTib+vBDKa107ZTTl7HW4qfr?=
 =?us-ascii?Q?YTh6nsZtiowVRDG86r8GjgPpAV4YHyCK9Rrzay/cMHfgEmg463xKZLdqfxFE?=
 =?us-ascii?Q?HzMb+Xz04EwWrCBgVM0OG9clMNDCUD6EhwlD07v+RN5PxNcdh+zOkavN+kEh?=
 =?us-ascii?Q?6jO9llGbhphZKL/H190NY3es9WYRsDiaU2YC2dZ5CbCpy91olrggIsNP5soo?=
 =?us-ascii?Q?3z1miV3uLVpAQCGDDjQqgxlHsufmZ6PfHcIsc+M/Mtw0v9VKLDVq9DyoeZ+4?=
 =?us-ascii?Q?hXgthw66boaSGv6H9wa2aIsUCW4DK+RdE86g3V1kP1r5FB7AFxNsiAEXNJ6e?=
 =?us-ascii?Q?nCPKx+FeZNNLiPK7cSDpLWM1oEq1Y2P0H/bWxAW0cpnJIMu4pWBEVrie+fHm?=
 =?us-ascii?Q?iqHV8TJdpYDNxIcf6WCHhW+SMCNxZXuwhTBtPaKmt1HF/I9hUVS1mmLj6EtU?=
 =?us-ascii?Q?uwuCY4YOf+kRhfddq5lND0+vIzMbFAG3m9mlCM6CfbUoaxVU4hZnT+aTPQNe?=
 =?us-ascii?Q?2426hsK1Tq/X6J/KPAa55YpwhWJnCQCyNZwRviLdeHSuyv3oL5YS0S3bJd3l?=
 =?us-ascii?Q?MwGsN4VSBviNfwXofKufH1v2RY+I6lXhaIrT3pGROtCFbN47cx9Lk9KCPTIr?=
 =?us-ascii?Q?4aR4WMRx1WQaOtqaMwoBFWIAunOXHVVmZmgQoNppwg7w6pRQ8WBVIgIeMP0e?=
 =?us-ascii?Q?MjGqg1uS81mIUk9vlA4sLwVDdHsYmzk/yF0gujmIxGcO0iVg8Aizl5FLdy4T?=
 =?us-ascii?Q?ZlYNbzs5seLkADrawz/28wNYEcDZlahOnrzffYOpYu+h53kAHBvEjmgEdeXs?=
 =?us-ascii?Q?nDrsXwZ19YzdlkjIRMAA7D4OjnFD/oDAoJ2O0gRyt83WWRny0UkeDp2xq533?=
 =?us-ascii?Q?mnOwg70UJ4Q24zRyIe0DWZOWvQfKI2kaqjXRsP1+U34itiCm2jiIXiU2wNJo?=
 =?us-ascii?Q?W4lNyE11TqlVfGlgXfvPDc447+icgbQ6968t?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 21:48:21.0949
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf41892-43e8-43c1-37a3-08dde4211c0f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132

The pci_acpi_preserve_config() function is leaking memory by returning
early without freeing the ACPI object on success. Fix that by always
freeing the obj which is not needed by the caller.

Fixes: 9d7d5db8e78e ("PCI: Move PRESERVE_BOOT_CONFIG _DSM evaluation to pci_register_host_bridge()")
Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
---
 drivers/pci/pci-acpi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index ddb25960ea47d..9369377725fa0 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -122,6 +122,8 @@ phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle)
 
 bool pci_acpi_preserve_config(struct pci_host_bridge *host_bridge)
 {
+	bool ret = false;
+
 	if (ACPI_HANDLE(&host_bridge->dev)) {
 		union acpi_object *obj;
 
@@ -135,11 +137,11 @@ bool pci_acpi_preserve_config(struct pci_host_bridge *host_bridge)
 					      1, DSM_PCI_PRESERVE_BOOT_CONFIG,
 					      NULL, ACPI_TYPE_INTEGER);
 		if (obj && obj->integer.value == 0)
-			return true;
+			ret = true;
 		ACPI_FREE(obj);
 	}
 
-	return false;
+	return ret;
 }
 
 /* _HPX PCI Setting Record (Type 0); same as _HPP */
-- 
2.43.0


