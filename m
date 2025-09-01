Return-Path: <linux-pci+bounces-35252-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2A7B3DE49
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 11:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D524189F28A
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 09:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9D331A042;
	Mon,  1 Sep 2025 09:21:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022121.outbound.protection.outlook.com [52.101.126.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652DA30E84A;
	Mon,  1 Sep 2025 09:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718477; cv=fail; b=NOzDcuqUYkMWWDrDUJhuWLFBRsaCLtu2pcF19lH4mi6Ac5/tPxdMgiuAWBuHXqjlReQv16PSku4byK6gVt724NLaC0iWt3s/D7cWLb7bSvp5BM01jYCp3cwM0CDEbnKKfi/seraqzaHVh2Kp5ukypKYG4ZGAvgrZTscg4R+4d1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718477; c=relaxed/simple;
	bh=PEfL7HCtbDHPpTBBl3f0Mrujw2hf06qHECNWPb2kCDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ieE9/top1240riv5u3OLTdtojrV661Whn8x5aybv7Z3Hv2MkOSoh4rKi+8nVrNY4/ICOpAahhXl74H8IR4Nua7tk3sAPkL8YvqZ8324TcEpvHTkqzl2wZTlaOF1led3S27M7srHwHoIe4O3jni7AFrVhvFalF8KeS35VnnEsesQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gz3KqjSomrARQyVI5yQgUHc9ICatrLlGwkauHpKyXwJzirOwlRud0ZqaEqJLPAr+oCOLuBP+3f5EcTbxBeKpFxRiMeRi7jp4eaXnbxS6+C6QtVFyEb4Tl93WW8s/znJ5UvYxGyKEByqRebA16ipDIwR3A6hJeIjLlBcH6BMbOiDarejZN3uRbMxxnoHQMFDh4Y1Sr5pI8DCmgcmUE4842cEDkfdTSqpOk8fWfycGxguCDBZHNmuXimFomMRvnmy/fj2wNKLr7czj0QiCsvMgdGRw6YCk7Qjsi46ZCOzYh3/Jq6DjaneSKs0DpbS4OHGZ04LTPYpdqwgHp0lLEUdFsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aaqs6SUEhJOGWaN6/+rzZk9nGERm84PZqBOu5zbAoVQ=;
 b=jHWZ9+hTo3rJQ9WSJz2LjJboCmzyPWD9WO/lMqFAo9h4ksIARtm3X+WfgPG5l/NBsTD09/OW1+LX+H8pmswRQFINDmlyHizi2U/GUARqp4zesrjz1DrnnV2YDtTWgz8ru/N4Nen9iEbQSnHTL3d7RE+wKU7S9bAeyt8vz6UXxiPDki8xDHyGedfKH2pIp3ityty7kB8/SlTKGH/y4pOzUxKUYGUZtfTN06ZSyemD4eUnnggbggSr+cIpI5dTOskSVLKDCcQH/v2Gxp3nhbwI3rpoem8dyz0CODAoB5TfBwYxQ+NfGht4gMsHI8FpqkQ9etDTR/sVYXMasiJhhQdrwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SE2P216CA0067.KORP216.PROD.OUTLOOK.COM (2603:1096:101:118::9)
 by TY0PR06MB5780.apcprd06.prod.outlook.com (2603:1096:400:27f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.26; Mon, 1 Sep
 2025 09:21:10 +0000
Received: from OSA0EPF000000CC.apcprd02.prod.outlook.com
 (2603:1096:101:118:cafe::ef) by SE2P216CA0067.outlook.office365.com
 (2603:1096:101:118::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.26 via Frontend Transport; Mon,
 1 Sep 2025 09:21:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CC.mail.protection.outlook.com (10.167.240.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Mon, 1 Sep 2025 09:21:09 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 63C8341604EA;
	Mon,  1 Sep 2025 17:21:05 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	mani@kernel.org,
	robh@kernel.org,
	kwilczynski@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mpillai@cadence.com,
	fugang.duan@cixtech.com,
	guoyin.chen@cixtech.com,
	peter.chen@cixtech.com,
	cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: [PATCH v9 10/14] PCI: Add Cix Technology Vendor and Device ID
Date: Mon,  1 Sep 2025 17:20:48 +0800
Message-ID: <20250901092052.4051018-11-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250901092052.4051018-1-hans.zhang@cixtech.com>
References: <20250901092052.4051018-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CC:EE_|TY0PR06MB5780:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8659c5c6-b547-4ba6-07f0-08dde938e33c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y26l+lTuQ2GxVKY5kCcfeHU7FRN3YmmUONc5mHQYLVLpkzBZbgxx//73yD7j?=
 =?us-ascii?Q?gRF4RjybL2pdqeVe/6Y3aAu+oiamaAnKFMFPwp7FEL5uxRqgAx6fb2tFH/oo?=
 =?us-ascii?Q?qddLdJ+w5uKWowSs/BX/4SwFmOPOmpcFBunp9tDiCqC6NjgS3EAtzUNodpXw?=
 =?us-ascii?Q?jDjX0deyFSqyqQ1SYESqsAPzALIMXzmQxOeYjF9Rxikqba/DMgeNTg9Vh7Tq?=
 =?us-ascii?Q?XxBxESEf7vdukP4FhWZlRXefUUScarUlSQk8X0msrUgv8hN5tmiRXIHg9jN0?=
 =?us-ascii?Q?hYzuB5oeDIGRTSj4AHO6QSTMrpa+zRFqVKIkeO0lkRP+aILAQAcBK9bMa1KJ?=
 =?us-ascii?Q?fZYRp1lOqDsY7vhmdh/qGGQWyzGaETdrUrg6iIGB/CB0kBsgJS2EhrUD2jJU?=
 =?us-ascii?Q?1JJ+QDbRQVDrUCS1McRKqVrmw9aPZYI7/HPHQTN0pf/zRwoUooZbbXRYxHAa?=
 =?us-ascii?Q?HsvcdiLxM0ikqu68wuAOWbz65aQEIN+SEnJZPc6XCZfQCSTXgbZfT5mPISDd?=
 =?us-ascii?Q?R0MdWRZN2DfrKeu3QgGx0Y/nz/ieFKkTgTxI3QJ7czChgqpyPC6auy4DAkHS?=
 =?us-ascii?Q?+F91IneZhZXPpPBgt91TFeB5oE3L9/dmIjYC5SfuJARswAnv4851i2v2he50?=
 =?us-ascii?Q?9C4+BmFhmfvVdya1xH5Yp2O4Z+R0VtVmwSwzoYnN9jHItddcOvwNv82SA4zm?=
 =?us-ascii?Q?KibHuA+CA9xLJRW1o55EdUX1lMhIfOmBK7Bxwu4XeL3u7snCDKVT5TS+WexQ?=
 =?us-ascii?Q?k+49M1p3tKi3cEY8dG5PUWRtokIcvUiFTTZav1L1uyHz12N74NG1R4/cHsSc?=
 =?us-ascii?Q?Llvy0nCOA5JXWSDSxXYD/BmCiXnliT+AUGSvdzYiJQd1huZ+/GVpnMf6OXL3?=
 =?us-ascii?Q?E7Uh0XwXT2TmoF5I2UouygsM9Lm/cTVuHSIllxEWkUiKpYxI4NbcDI6dOTdm?=
 =?us-ascii?Q?xbj2x2XnnAx0CK7nfUdaex+LFARmWN0BcuGeLMRHQqtx5lMoBzFAxRILoqSP?=
 =?us-ascii?Q?nDler/U1edNKm4L7OF6TVasTYi41eSWK3OK418o6woG0g7+6VlkOCCYLd5Qe?=
 =?us-ascii?Q?R4LB21gyHCjInEkx8FCJ3idbiY2fEttWneEijL3eTkPP3pdU7MzEpqEXv8C1?=
 =?us-ascii?Q?HQHm6Nipl2EdFJ8LU2lc9wdt1plHn0d9W/CmNySSsAvUDckpqaBuk3XB8007?=
 =?us-ascii?Q?pDgbNWNSs6MpUtFDAmWTggb/ZJUqvxTOGL6g0ZdZ1ksq2CI9K5ddo2PyBUXo?=
 =?us-ascii?Q?IRNUkVR5SpxYrumrYmeGzxYDK1w56eCz+MpDY6tKam6PPeuYlWOe4vsa8Fk9?=
 =?us-ascii?Q?qzvykhQypvtCHdprtCoT/En8mMZ8SbcrsHpWkryFyXW0LqlRFt4/1esRdu5c?=
 =?us-ascii?Q?ruuckGo1ygdwrFqrhTD4YqsN6e69pjDi8I5umnt7hyggx1gubaouPWE7F1Mg?=
 =?us-ascii?Q?eH5F1bnhvbKQxdGofW3hEk60zMokwBZ7L5YlWwrFazgmA3Mc0bJ6E3s2RTlO?=
 =?us-ascii?Q?g6wr/p5gOchFgsrmzZGUhyh26n3KKN8V6Ncc?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 09:21:09.4022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8659c5c6-b547-4ba6-07f0-08dde938e33c
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000CC.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5780

From: Hans Zhang <hans.zhang@cixtech.com>

Add CIX P1 (internal name sky1) as a vendor and device ID for PCI
devices. This ID will be used by the CIX Sky1 PCIe host controller driver.

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
---
 include/linux/pci_ids.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 92ffc4373f6d..24b04d085920 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2631,6 +2631,9 @@
 
 #define PCI_VENDOR_ID_CXL		0x1e98
 
+#define PCI_VENDOR_ID_CIX		0x1f6c
+#define PCI_DEVICE_ID_CIX_SKY1		0x0001
+
 #define PCI_VENDOR_ID_TEHUTI		0x1fc9
 #define PCI_DEVICE_ID_TEHUTI_3009	0x3009
 #define PCI_DEVICE_ID_TEHUTI_3010	0x3010
-- 
2.49.0


