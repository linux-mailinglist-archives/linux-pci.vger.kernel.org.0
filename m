Return-Path: <linux-pci+bounces-2906-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D817845121
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 07:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC9E31F21755
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 06:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4351279DAF;
	Thu,  1 Feb 2024 06:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XzTimBLe"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766CF3B7AA;
	Thu,  1 Feb 2024 06:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706767424; cv=fail; b=UFN+1MQ/E0K3D/2Lt8lypjgraYXF/dD1RBmq9thWMerN4iu4b/RqTQD+mVFL7cb1txL+ppXtAP+FibHzhlcvrrbR98YUGkofyN2v8UusDiQ/YbUoZaPDn4q/mkz/WtU5ow4G6jejfPQuc3/TcucAcJtWEHMqAsnymPPu6ID0AeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706767424; c=relaxed/simple;
	bh=nmkbU6j9etEgM8KswWjXV+8AQ1NOcFNCMpXHt/4+5Hc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hpuWTobI6ONbXQ1So4cLcx5F0EufPdPNaKkkK+8PrgZ8XYBb4OCpN9IcOLa+S99zjn12gLKRoAqG9w1eVSsZC0PrYgV3PeSaGbTM20iRIdGChmvVlfRaWR1VGX4/wJz4A8oUOP0yQ5n26zbmyEdSzOePaNpD/QE5KkxPSDyJ9lY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XzTimBLe; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVDw6ZQ1md93byl/IxUgcH3ny8Fm2E8pJ+zMiflhMTfaMI/Gz9l1XZZ1RKOqf1lzj/EjRsw535xMzTD5T7qTCkTEmdQSLH+5T3KxXBUP/nIvakIQ7N/hUyRzHFFVvI8NCM17mA5M03O45cH5+G0aXHNIxQbtEi92od/R5L+tNfNM7BRBbdhks00z0UzGrD3pDSJjKf+96pJKo1rBaMMsrMEeh+htJX+g8tPKa8mu36iFxOa+GUGKYL5fmVd6lCWdR3y9d1iHM12u8h7WdKUfnq2qY1570FwmzVKjXuqp+M5a1MngXTRAMqdEyXmx66Mp9iI/H/3aJJCYSM4wxKhtUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxTTmHAn3n4M08VnrVUM59cmjxQi+aeaUOc6rJRVuEc=;
 b=b9VfwonbEAztd9gpO8pE2j+gnMOAxOLGwRT+TF82RXfqkty9SK8q4tPMFnGCxwa29YI1nBc4Li/a118gU82PCMwPqlnl9KlomF0ZLqkVQBPG2sa53g9N0Ns9I8QrouJQytLEhVHfxZAJN3t+Ltav+6HuwJ/hqDUSMSG+dNf7X9dHsYrASS2DZNmugD4y8lS7x01Y8y+zAgTCMxhRVKDruItMj1yMskPoouyE+wDjHZwgWPRf8GWTrIZ/SCwII6NRUSBLlny2zLARGm1bfOREYGg9nlkoUV6WHAASteGZxW5mNJDDQVK/yNDQgApzmYW4AGeXBP5uLPE5Y7cECdo46Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxTTmHAn3n4M08VnrVUM59cmjxQi+aeaUOc6rJRVuEc=;
 b=XzTimBLeT2ccd3uj8CG4iLLi5Wn6MeZw1so7pohyOBXS+QioePIR0zHH3lhhhCbTRO7q9lE4tS951DHfqHNMTBj6MV1QJ7reGItsBaiLXi9nRMu3wrpQvT4jjIbtO/Md0o29SCKWlZUk4EeBXPZ3B7pqWoqoUJgecTEoecbm6WQ=
Received: from DS7PR03CA0234.namprd03.prod.outlook.com (2603:10b6:5:3ba::29)
 by MW6PR12MB8705.namprd12.prod.outlook.com (2603:10b6:303:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Thu, 1 Feb
 2024 06:03:38 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:5:3ba:cafe::9e) by DS7PR03CA0234.outlook.office365.com
 (2603:10b6:5:3ba::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Thu, 1 Feb 2024 06:03:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Thu, 1 Feb 2024 06:03:37 +0000
Received: from aiemdee.2.ozlabs.ru (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 1 Feb
 2024 00:03:03 -0600
From: Alexey Kardashevskiy <aik@amd.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Lukas Wunner
	<lukas@wunner.de>, Alexey Kardashevskiy <aik@amd.com>
Subject: [PATCH kernel 1/4] pci/doe: Define protocol types and make those public
Date: Thu, 1 Feb 2024 17:02:25 +1100
Message-ID: <20240201060228.3070928-2-aik@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240201060228.3070928-1-aik@amd.com>
References: <20240201060228.3070928-1-aik@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|MW6PR12MB8705:EE_
X-MS-Office365-Filtering-Correlation-Id: 3837c16e-da6f-423a-db98-08dc22eb884c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	irh/Q4Dl7t4mH4r8bea0NKqyssJGwwB41vPg149N7rZXPH5nwnJhdqW8BnwclwM8IUgwefRRhmqbg7ei7ijOY27oK1GIbIVxvA+HZnXWbFXAv5wOz37UWakYP/WPEQAeJQBKmYM9tAeXVgYlFt6/neXMNAES3/ZhfPWaIeqy2Ro0IS+QfoX1rQgQxeTZqhzqdTrr7jsAFCsDKgwlAXmSVMcM33Zb4wF4aRlzKSAjvqj/R3N5MjcyCAMDx3j/6jXLeFDXHHg8fAhKT0mLzTu1bAqIKDnrttWfaDpE2ae35OZR9ZJkGIl4Cm8EnnOxHGl2Qq8BPv5p9WmbpGrP9rp01sxYsZr2pVG2deINH+ZmW60O7hy1gvnWsbz1Bk8JF7K1/2HVCs7KWU375UG2O5yMvftYS18AQxu2uInkGKmritxtf+ljpKIF9+IgYMkSLpI2kh7qFs406hLUKsQxhSLCn3t3FUP5mVi801jCCmYqOqBR8gXy/1bMeFFtS/25TUjsiW/ZhDRipTkm7NsWTivqAAsuFy+Yd58Oo6DyaKH8tH1Plc+nvSxJUa3SJKH9Pgbq/NVUv/Uwwn3Thoor4tXj5MGui1YPlLvQeM5NfuCNVsmZ/q6fiR9zAhhB0LXEGDwHZH8YTqymbDSlf9i1VCa2FtE1mDYilwywlRAcv5qiW83P8d3K67DDM32e1SSeXPbJQ8hl4jMkzQstLqGjk8unnGQYe0bX0Fo0TQoIUg0pR5vVlBL6dDzipLHOyY0yl3YZLRT3duPIGdy4l3oEugnojQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(82310400011)(64100799003)(1800799012)(186009)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(70586007)(2906002)(5660300002)(316002)(47076005)(8936002)(54906003)(70206006)(4326008)(6916009)(8676002)(356005)(81166007)(478600001)(26005)(36756003)(426003)(82740400003)(36860700001)(336012)(16526019)(6666004)(1076003)(2616005)(41300700001)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 06:03:37.8071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3837c16e-da6f-423a-db98-08dc22eb884c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8705

Already public pci_doe() takes a protocol type argument.
PCIe 6.0 defines three, define them in a header for use with pci_doe().

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
 include/linux/pci-doe.h | 4 ++++
 drivers/pci/doe.c       | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
index 1f14aed4354b..5c33f7dc978b 100644
--- a/include/linux/pci-doe.h
+++ b/include/linux/pci-doe.h
@@ -13,6 +13,10 @@
 #ifndef LINUX_PCI_DOE_H
 #define LINUX_PCI_DOE_H
 
+#define PCI_DOE_PROTOCOL_DISCOVERY		0
+#define PCI_DOE_PROTOCOL_CMA_SPDM		1
+#define PCI_DOE_PROTOCOL_SECURED_CMA_SPDM	2
+
 struct pci_doe_mb;
 
 struct pci_doe_mb *pci_find_doe_mailbox(struct pci_dev *pdev, u16 vendor,
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index e3aab5edaf70..61f0531d2b1d 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -22,8 +22,6 @@
 
 #include "pci.h"
 
-#define PCI_DOE_PROTOCOL_DISCOVERY 0
-
 /* Timeout of 1 second from 6.30.2 Operation, PCI Spec r6.0 */
 #define PCI_DOE_TIMEOUT HZ
 #define PCI_DOE_POLL_INTERVAL	(PCI_DOE_TIMEOUT / 128)
-- 
2.41.0


