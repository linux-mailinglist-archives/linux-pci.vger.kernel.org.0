Return-Path: <linux-pci+bounces-14011-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B44A29959F0
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 00:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D87D31C21D62
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 22:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728232139A8;
	Tue,  8 Oct 2024 22:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3iHEssXJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97A22C859;
	Tue,  8 Oct 2024 22:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728425896; cv=fail; b=e2em9O/gtMA29ao90h5LGnF6W0rdkmvyfwCnej0Q2G2SqnN4DH7ABdzlmaqwes8oL1PiY6Pm+JfnZgyh4JLEw9LRLVoBTgsijZn21vMs5xTN5nyPVhclBJLNphpRXsH3rvTWITUu1QWMfp8xq22T5oPYdTD56B1pM2HIoWJJ+KA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728425896; c=relaxed/simple;
	bh=oSF/mO9ozQg+8p1WxFakCsc6TjWo/KZyLNz/4smXDDk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ViLl4gO+m+MI2oL28gGqfgduFfZp8JgKPAfkf6at6e1xJuQi0kBQp/W7UaRK5V1NKG3c1BGSHHeaxRl95ajgGCpN1pH+TzUFu+HpPQ+jx3DHTpAv+JfeHDuNIjQin5oIXiauxSMhXeJJ7HYieGOtJc/728KAHIKGPheWNNSKxSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3iHEssXJ; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkfBy+E2wAav+3jK52t5EJw1EGrPoyy57TALPyvLnGJmmgaZu0wqkirh5StSdDIxUAVfs3gUA4xXP/aYseERkGlToyZOntV3TBA287L3oDDD9eXazekXDx/I2l/BmH41RB5zt5Q1re/yG16eoqFebhPprAWidpcllejimqsj6G6kMUb9/yHmIPrVIC2GMRkTw6kiFPnmh3UzWKj0eAmJ5rUGOZJRdmZufTYaNhtAZQvQbM0L1ljoWcXPhxBK2C026txpxQzpYDSiImSITritCuG3J8ZjzAtIwdHhE1RJ5h43Drbti0V/KIEXwwuJu6Z1Boild64KiSeLTNu+UJCfxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fh3w6rWrpDOlzXz+HhUx6VpM4tEKXEvGv4KWMNEaqQA=;
 b=HYOix/uMT5sKIyBdZiKRifN+jHtQrMyNKQAG5uFo8GoDGj7T8KCXwWgpe4NuJQJ23ONcftpyS3K3jTKVpKYKnxikq9MMDfl6/MnfpGzE4mlEJLnpcJ3v21Ea6Msuo4YKbwB8HXMevCay8IlhHbeDYP8fwzGR3zd6rxQsJYX/M4XBJrpfPnPWY97aIqvthyD5lncwtxvUdUyPJc+HEN1p7t9nH51j0Gdr10M4Bcnq1XkUE37OL5JZuFSqoF1JHf9NdOYshxbAqapS7Xr/SxcizdEG6cBj9A/WO+9XPjYJwNdWfqvAmy84O6tHwPhZbSor46k2IuwAVHoQXsZsioSFXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fh3w6rWrpDOlzXz+HhUx6VpM4tEKXEvGv4KWMNEaqQA=;
 b=3iHEssXJwwgYEW338qx4GNlk9v7TkTwwJRuYE1A3UxPeP5TqyXsQIFXx1fdqCUbJ0iyCDF67wXgcKNsL20S6wjR0x/RGxYORiaN5lE64iwDacG98sbYSTMe2+CGokOqbgaZUlNiUbpAkR6bIvPJx1pR4fCXZrKdcXZHybljY6cI=
Received: from BN9PR03CA0604.namprd03.prod.outlook.com (2603:10b6:408:106::9)
 by DM4PR12MB5986.namprd12.prod.outlook.com (2603:10b6:8:69::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 22:18:11 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:106:cafe::9f) by BN9PR03CA0604.outlook.office365.com
 (2603:10b6:408:106::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Tue, 8 Oct 2024 22:18:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 22:18:10 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 17:18:09 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <smita.koralahallichannabasappa@amd.com>,
	<terry.bowman@amd.com>
Subject: [PATCH 06/15] cxl/aer/pci: Introduce PCI_ERS_RESULT_PANIC to pci_ers_result type
Date: Tue, 8 Oct 2024 17:16:48 -0500
Message-ID: <20241008221657.1130181-7-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|DM4PR12MB5986:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e317adf-bcf2-40e7-be25-08dce7e717e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yim4jDO0NDqNypTDyB4mW4ZJa+6icWidsJd3+Lw2eDO4szcqSsmOvEqWKfOf?=
 =?us-ascii?Q?A+sEi+MSGjkGGe3fHu0gweca10qmAShDUBulBq1tP0kT5aPXSCKTB7EKS2KV?=
 =?us-ascii?Q?eDyAMFsFZBbxFVWB3dEjGLoJbcujTvo87mrkstN6PUKmVNWdLHBxEObFUvMe?=
 =?us-ascii?Q?hlZInOLMCYXOcR4CMrZd5jaPsrkkcYiVJfoReWAl02hnLpwlxRdXrrsXFnEO?=
 =?us-ascii?Q?Q+283+cbF1FQcHw3o5xsLQDNpunhWiwMyM37YJU2uh0RATn7MBV+UXbhfvsf?=
 =?us-ascii?Q?bqjOuXd0N7xdvN24+o0Do3YQcBXJRE1EDH90qhflO1l5Pu8kmFvzvM7F1ufP?=
 =?us-ascii?Q?9xIqhNX1wq9N0dsxiIJUXqOTljg8g7q14mrKHoYxNWifSu3lXstbgIjgnDJo?=
 =?us-ascii?Q?HUOeHVUnFiSJ2kWrhuAP8kjvHZxTfuYveHqLN48ac2wFyaynYHv34Qu7L2Q6?=
 =?us-ascii?Q?iAqB9M3k1AhS1TT0Vx0VaG8+DUbK9u8l/SZzYFY+Owh0RATSQBPcRPd/WJwV?=
 =?us-ascii?Q?bdd5UdACANJDax8xpSCP3T9uYAaM9b1SmkRvCklNsbHMxkS5ZRqQWWmqfLKE?=
 =?us-ascii?Q?aX46lw0iM269jbtz3ptrMOlXHfwPZDLeVcrj+KrvNDGf61yonGnC2Avcao06?=
 =?us-ascii?Q?qvlxG921l4yUAAqR4h2EOo8hw0nOns1QoWx9QesbtyzjQBNKDoaJp9o0TTjS?=
 =?us-ascii?Q?PsJBAfhGR7+E4VhA9kn9pM27eZa1AQW+LupBS5Tjt1YdrpR6dymNM+obiBzY?=
 =?us-ascii?Q?HJvB0B1n2kxqCEFM0g0msR9bnGeg+Pv+rOZeokXS2U9ZEJDA9VjJNOBxjVRH?=
 =?us-ascii?Q?OynYLYmxMF4N4fzuSq61lLsSQGoFcPEBlt66D1c6RKX+06NPX9vK86pSb/5x?=
 =?us-ascii?Q?nlWkPo4Es7KVThDpZ3w1I7dr8eiy1cqyv/GbkxitDYycRfboM/n2dx8IonjW?=
 =?us-ascii?Q?SMXZPjRvnNsYs+z+bKQVVA41OJi+Z4gydfLH7RM3AI53DUdqkWLESTbB4qcZ?=
 =?us-ascii?Q?Ds9a0jYvf3v+E7q1avM9nsdfBbdeAR5M9wEHbks+C2VdqJh8YR+++pYCMRSc?=
 =?us-ascii?Q?1/FiJfXxdeL7vRzbp8FP+EwbW8u79+NtX5quHMtmGOeqo4XMQyoiJXwt2awr?=
 =?us-ascii?Q?l+CQ8RAGsjsNkIALvSgtqGDYW6OFI+8DouwiLg/EW9cahTw15H06u2BXO6/W?=
 =?us-ascii?Q?+TrbxA4sw69XMejE2FuZzm3Ztk5nh1X+NjbrVtJRElJA1HPbQEUqfiRE9iqJ?=
 =?us-ascii?Q?1eXJOqpm1StYs/k4rtL+NNi+nETzmXBK8OwmOeWZnOLzVD5SMCuAPlANi15Q?=
 =?us-ascii?Q?K9Qr2lWxrM5NtAgpxK7nhumy8UkkKdC9yJmEYZzLrLrlIf6Wk4OCU+VlUloU?=
 =?us-ascii?Q?8NKqMJllZ712pz/rkj3jZ/qNRnpT?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 22:18:10.3733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e317adf-bcf2-40e7-be25-08dce7e717e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5986

The CXL AER service will be updated to support CXL PCIe port error
handling in the future. These devices will use a system panic during
recovery handling.

Add PCI_ERS_RESULT_PANIC enumeration to pci_ers_result type.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 include/linux/pci.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4cf89a4b4cbc..6f7e7371161d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -857,6 +857,9 @@ enum pci_ers_result {
 
 	/* No AER capabilities registered for the driver */
 	PCI_ERS_RESULT_NO_AER_DRIVER = (__force pci_ers_result_t) 6,
+
+	/* Device state requires system panic */
+	PCI_ERS_RESULT_PANIC = (__force pci_ers_result_t) 7,
 };
 
 /* PCI bus error event callbacks */
-- 
2.34.1


