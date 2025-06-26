Return-Path: <linux-pci+bounces-30686-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD9BAE9552
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 07:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAC3D18848C6
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 05:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB24222759B;
	Thu, 26 Jun 2025 05:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M3kWs/ZZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B7A2264B8;
	Thu, 26 Jun 2025 05:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750916963; cv=fail; b=H4WGAf5OPtUL1GJthJzTQlmIYpu5lMdS0wVqn9lvGWsAd6shnnxsYWvtfw7i3Es0Z3Q9M7JU15ocscCfCG698NeTb4bTE/UDnBzpI7Vo/nX2J3pYlAuea563weby9LBYQtoZJvayRcY1CHAPNMEnSvOynZ50QirFBi54tM1fUNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750916963; c=relaxed/simple;
	bh=Nibz70db83EvT5Mo6yXI7xpzSf5EWhzRoypeq7qnbFs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W9Q7MOI9TqOwoc40nyfaBf74/LzfOKWbodoagoqlWMBBhcLiSSMCQihiSqA30M8jhIbLzHhDODIvvTdzb6NyjChmvPU3IYo8gGj5juPCV5fUdHpR2JhAqbTZj7olYuU6EwmCsvW70jh6Xv01eGQrYakaRg55o9W+jMyhKpgzJOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M3kWs/ZZ; arc=fail smtp.client-ip=40.107.212.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9XVihZ604Jv/VV4S1pMHDGcEdq1n7tJe9lzjbtUJRJZq5C4MZL+2WIthkENZaCxFuPzZdFN4rRWNk9pWlmXAV+JNKc6CWC3itYsdKimpmzKtWU3VhfbPjWOjRTQB+EsW7TxU8RLfL4KdkpyEt0Mx/7BvL27frq8DoTfhWy9qLOvOuzKNFXC8zahAk5TTgtkVr9j/2uvIQgPasFLsd9NYrz3+QAO4Awd93HV4oj7SoK6KJjhJDD393a6svmHXxQBJFN1G9YTNrfo2+yaeVG3qKSDO/JSkjcMoofIsiIwJnFQZGQGsNk3jOJKKCWlbwQwdD7vTDuCvOL/x6quiR6tAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hy4Mp+ML9vX0kRNqxhUp0bD0OIaDlJfYKfyRuSBHtvo=;
 b=kuX3C0kPKyLbRT2FJ+sJcI8oDXixa9yoh7GkKHJ/rTC4gQ8v4hxT53Gb+MFOG0HtE+fRuV9SuR1ue8ztbef1GCv2sNL/T3sMpaweqpcguydqUCi8SbeYgvPQXzG9k+x2NA+SfvwaZnjMsFolTdQ3A2zkZQtVCR2UyMsJOVCkV5sztdaBle8J2zfgXPo8vBi+Ubacfu4ZTP1NY0bM2R9jkLiV1xKhsQdU3bvwe7lvhadCNgC5xp5/v9myZpzHBF4De1A9kodGaHpduzTkTicqPgscaZlD2moZEY/BIUBZYSlr5HSzRYOCUO+nQitdLf2MAlTEbvaKCEn8yClmhdpOWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hy4Mp+ML9vX0kRNqxhUp0bD0OIaDlJfYKfyRuSBHtvo=;
 b=M3kWs/ZZz8flUNHE8PyBEGOZj+i6/4E2UFS4wpiOF3OiMW9S2XR4EBSCkQ8S0F7zCK/+zgbaoHFMdlsv1I7f2otaIqJ0my5GRcncOrEaICopWmzRxec8igSNcSsdd+tiTxke6mVpO55DJHOE+FjW/5mNd/73YaVNrdPLlWVE2hI=
Received: from BN1PR14CA0022.namprd14.prod.outlook.com (2603:10b6:408:e3::27)
 by LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Thu, 26 Jun
 2025 05:49:17 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:e3:cafe::6b) by BN1PR14CA0022.outlook.office365.com
 (2603:10b6:408:e3::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Thu,
 26 Jun 2025 05:49:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.1 via Frontend Transport; Thu, 26 Jun 2025 05:49:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 00:49:15 -0500
Received: from xhdlc201964.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 26 Jun 2025 00:49:11 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <lkp@intel.com>, <linux-pci@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>,
	<thippeswamy.havalige@amd.com>, <sai.krishna.musham@amd.com>
Subject: [PATCH v4 1/2] dt-bindings: PCI: amd-mdb: Add example usage of reset-gpios for PCIe RP PERST#
Date: Thu, 26 Jun 2025 11:19:05 +0530
Message-ID: <20250626054906.3277029-2-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20250626054906.3277029-1-sai.krishna.musham@amd.com>
References: <20250626054906.3277029-1-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: sai.krishna.musham@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|LV8PR12MB9407:EE_
X-MS-Office365-Filtering-Correlation-Id: 6097a701-3186-4848-cd1f-08ddb47530b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/1aWn7m1kVBRemm4HEU7YPGcSEi7qCKaYk7L0X0+2La9+Bpbbj3upDcBKVAh?=
 =?us-ascii?Q?GIDIuqiJr5tmAM0bDfJZfFCdS8FxAv9MwXE+8txw9WEwolw8zPZTbCGseR6+?=
 =?us-ascii?Q?GyY4DgcWZDDW2/iXIWswkdV2tnANRfnhXQsTj3Te3gwYnvfJ3Xv6cYZZrR5i?=
 =?us-ascii?Q?m8o/OAdm7XAVZIcMvM0Lt+TdKikjje7mtB+vQgQF1XsriewWmr54/hjfyn/4?=
 =?us-ascii?Q?R2WMBsZShlpLu9h667BWHdzKNyalvqfTTqd6gMmumn/U0iHVO+uwd//fAQ9J?=
 =?us-ascii?Q?cyMrf3aKFiYlzUHYU4/LASY9EWsvcxHWJCDi167bT5NHnffFAROlCxgqVOdl?=
 =?us-ascii?Q?excGMe6z14sPjLOlyU1ynzhslLnZU/31+YRjPFXPIltkn1VYKfYbr3fvW2KO?=
 =?us-ascii?Q?N32DHkVVRN2aeT8gO5Jizp8zRnZe6cO4jNEKy9V386Z64ETJkStiNqITU3bZ?=
 =?us-ascii?Q?PHqENfeEfxAjY1SUauM+jB4uEZdxGUTyuOObpJllweXob2VM8o702Rt9Beko?=
 =?us-ascii?Q?KZkPupJkE9JUXM8rZfVMA9Uf64Tw10lFW08sUiaQf628rcyWoQ5INyzj7hwi?=
 =?us-ascii?Q?swNbMDQqS9oGiDL1hDtGJbyhmeptts4xp8DYA5ompfPwicXuDwVJz7qThDUx?=
 =?us-ascii?Q?6Zcehg8zkn88VNBa7cZ2G+w4J6uo7PXB/NmffuYVWYG8hWYykn0pCI1kK70g?=
 =?us-ascii?Q?KXGZIuUrhIHUyo4vRDyLqc4xGiFIN91kXQXAWBWp8RfcvtdCz+zqZLs5FlqJ?=
 =?us-ascii?Q?Wq/znEPeVB71kANp1KypqgG2zEdx7s/2FbLFghZI0CqxuYef8vQi6J2L+L8C?=
 =?us-ascii?Q?/INg1ZERnULnyO8utuJWi6XeZ+zRvo0+W2hObX/mPdj6rQnWopawGBjz9Qvg?=
 =?us-ascii?Q?IaybeDc2vmtCfwk+8eYtafDrWubCGu3T6P14nWmecSNzahYDCDqChpsv3qDZ?=
 =?us-ascii?Q?OushnlfenYAxeMpGSFODwj5pJAnbAVmUzmKmBd8UjTNLx6Yz4QVfA7OHVgci?=
 =?us-ascii?Q?rWninqCLcDZyDTMbzNrD2TEHOWN+oXn7VcvNpM9dYGbBrDW1bC16yFPKR4lb?=
 =?us-ascii?Q?2QegNjen6a2un1PuBFT9DccwUndWWrP6RSxTjlm9k87TqC3HsMEM/Yjty3xy?=
 =?us-ascii?Q?sqUPJHHXWW0IkTXsHt9W5Hg2iYqQqeIcKxykbh+RiJBr6JL+j4Rh4L0E1Uoe?=
 =?us-ascii?Q?6+AGd3gUY77mUFhI3SNuE5Eo6dFxApxHg3E7LMe/AUTWwRASr2mQfwpq7WfP?=
 =?us-ascii?Q?ObAGR2ri129Ag1sSkvrJl6kO9wXkzqT9mdBsCPZNBiouZWQ2S3O3D1arwxa2?=
 =?us-ascii?Q?h8nQFP7kEzhnNaItUx0A/a30HWbnlFgvaDSKH5Woarb2OM+Qb14xLGAb1xK6?=
 =?us-ascii?Q?ax8ZB6DxuBoVnt8khOnKjyYnU4Jh1HxrrjVCMsQeQjsUpgHemyCj8SCrilIq?=
 =?us-ascii?Q?7NNaD8s93Ge9yGfoZazMnaw7KCRashP2lbZ2/8HnOBvveonXU6RLKDCZNaJu?=
 =?us-ascii?Q?XA8S6vB17CNNT87giazJ8zqeyw48yZiguidWaFDP8wUtMgItK+6SIU+cJg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 05:49:17.7254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6097a701-3186-4848-cd1f-08ddb47530b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9407

Update the device tree binding example to include usage of the
`reset-gpios` property in PCIe Root Port (RP) bridge node for PERST#
signal handling.

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
---
Changes in v4:
- Remove reset-gpios define as it is already part of pci-bus-common.yaml.

Changes in v3:
- Move reset-gpios to PCI bridge node.

Changes in v2:
- Update commit message

v3 https://lore.kernel.org/r/20250618080931.2472366-1-sai.krishna.musham@amd.com/
v2 https://lore.kernel.org/r/20250429090046.1512000-1-sai.krishna.musham@amd.com/
v1 https://lore.kernel.org/r/20250326041507.98232-1-sai.krishna.musham@amd.com/
---
 .../bindings/pci/amd,versal2-mdb-host.yaml    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
index 43dc2585c237..421e1116ae7e 100644
--- a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
+++ b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
@@ -71,6 +71,17 @@ properties:
       - "#address-cells"
       - "#interrupt-cells"
 
+patternProperties:
+  '^pcie@[0-2],0$':
+    type: object
+    $ref: /schemas/pci/pci-pci-bridge.yaml#
+
+    properties:
+      reg:
+        maxItems: 1
+
+    unevaluatedProperties: false
+
 required:
   - reg
   - reg-names
@@ -87,6 +98,7 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
 
     soc {
         #address-cells = <2>;
@@ -112,6 +124,16 @@ examples:
             #size-cells = <2>;
             #interrupt-cells = <1>;
             device_type = "pci";
+
+            pcie@0,0 {
+                device_type = "pci";
+                reg = <0x0 0x0 0x0 0x0 0x0>;
+                reset-gpios = <&tca6416_u37 7 GPIO_ACTIVE_LOW>;
+                #address-cells = <3>;
+                #size-cells = <2>;
+                ranges;
+            };
+
             pcie_intc_0: interrupt-controller {
                 #address-cells = <0>;
                 #interrupt-cells = <1>;
-- 
2.44.1


