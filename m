Return-Path: <linux-pci+bounces-1870-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F75827E0E
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 06:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35B861C23573
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 05:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088536D6DF;
	Tue,  9 Jan 2024 05:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aV+sjSTx"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8873B6126;
	Tue,  9 Jan 2024 05:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lX2ZGkn4U5PNVERFKSjjQKc5jcZfh6gk7pHsJR6uAm8ZQhqQUdcVfmONR+OD0GuyCmT4TaIRJ+ykxtaf3LuwDpKEB2+uwoKzceRRvoK8HCEcYUKAqZg6cswBE36dnZY7zfflfqSj20csDyqKkOijUQAJ+wEqpf7JaqEgvn6kucxTFuiNvdKBTu1Iv6zhZ37ii5pQvddHg0wZgetUVnBNaL+dg0lXjhFUi/eEZP8m7Xzg7mOc4N8hgh9VcZ+yQmjD/ZkiC3kG36GB2Dm3tK12TukyO6ELQaQRsM3qKWHgTkReZM+/E0VLfDBTsih0mR3wg9fBSfgndgTIUBIk4sIGbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3cGwq/FHtmzGRJ8/T6FdLsDtcd2nrqjXK8ayyisOnY=;
 b=ADrv0qDOm7Kq687U4RNf49GrQ1IvbIHDB1xanqaJ1WAaBtMKnjiAHOcCELZoDmPK52Fp0RgWWPk6MOSiePTNhBq6tnr3R0PmXSaLqGaHLVSP3XHhmPPWb0zxqny3WgkvIyoEeD9Km8BkBdbw4GAGOQWKFEKkoRwyGpcikLFqPYJ6x3UzVR0RGApedufD41oirRKN8pKGfjKCseupG88YsuyduIF2zTv/hei8wCBeJehPM1m/CqDW/vnR1F7L1W1h7ZR2U36j4Q4lubUV4M+GqRG63Tg/3216FNyID9NkXaJPRW0rZYW6OIFRHtYllTpOD7ti70d5H67rTs4CjXwOag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3cGwq/FHtmzGRJ8/T6FdLsDtcd2nrqjXK8ayyisOnY=;
 b=aV+sjSTxx4sddj70PFtf1ZNq9TDnpT5nRP4g3JSvHJM/+5I0k1Y01VnonUes8IrEikAtaHWZEALgaf1GXvZVHsTq64hCM0GyWqF8oHX+UKP567PLzEjqxQYb+enMBKodjJod6fUZPsrllF/MZFwlUKHy3UXviFWx0ngsgnLfT1gj/RkjycBI4beR7yS0i8sMTxSrQ4wWqC44N1b0HwH5/24GU/d8vR/g6YnPjOTznr6VVu1l2HP7JHcW4PioEW1zb8Iir9V++bIvvoIb9eZWGx1ZagAmFlA7gYCki9Gk9vHJ2K9EKrRySJZYruKfgqqnHnitHXtlsVbGeXFvWKBe/A==
Received: from CY5PR13CA0087.namprd13.prod.outlook.com (2603:10b6:930:a::10)
 by BN9PR12MB5082.namprd12.prod.outlook.com (2603:10b6:408:133::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 05:07:17 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:a:cafe::25) by CY5PR13CA0087.outlook.office365.com
 (2603:10b6:930:a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.14 via Frontend
 Transport; Tue, 9 Jan 2024 05:07:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.12 via Frontend Transport; Tue, 9 Jan 2024 05:07:17 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 8 Jan 2024
 21:07:05 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 8 Jan 2024 21:07:05 -0800
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 8 Jan 2024 21:07:01 -0800
From: Vidya Sagar <vidyas@nvidia.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
	<bhelgaas@google.com>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <will@kernel.org>, <frowand.list@gmail.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V1 1/2] dt-bindings: Add PCIe "preserve-boot-config" property
Date: Tue, 9 Jan 2024 10:36:47 +0530
Message-ID: <20240109050648.1347255-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240109050648.1347255-1-vidyas@nvidia.com>
References: <20240109050648.1347255-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|BN9PR12MB5082:EE_
X-MS-Office365-Filtering-Correlation-Id: 92a9a06d-304a-4e69-bb0a-08dc10d0d9b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RImdDc+6nj/6jBnzqgrPF8W8i76LbC0r7oxCpII5+qcTlKWhZz3MjDIdsVnwPo+n6FyJOK6p9UApKjmeWIiLRw17f7RWnx7A8aa+ZRN4KMw8xNPUTWPBDE+4FUGdjYGKkqLWvpyCDCLGa3LfE7epSp+y+74t2Vo8rQS4hZ3L8wI7Uw4fhMvgams1AdYIpEPIst32P7TCLcadANrv6PINLPd+Gb53N4Qck7J5jLHNFDFQc7EBP/Bo56h+5sTUAqT3ZvzCX3EwK3cno/IIumgoMqKSJ6PA61kEl4d9/lUnG+XqRriHK/ei1pivA2muTTgYJU0iL5zps9TYcbbq1A/sIugTSkuHEReWhG+B7mGUEdbmjqtalmc4Utk/tXrEPpKJUmc3VEog73vD10pYEAb41AwJ8lQtqKMLSMfQOtk+To8k7CnngKJviw0x76KJivhZC6npt3Exw/D4vYJ1TbvBmOq62efNAWkWXtG9t2lM7NvKR8pH7zoIiWNyGdHxLbhvFDXtWaUNaLV81WBmwwFiRm0Uw+FwMIYw7PQuAWDjGEnLsJpQNAekQEIbNy0PKgH4EaaC9VpVcFAGBVB3FtV6qkIJCqVbGzk1gNbeD0uePUNgHiFEOCHiY9esszG2/w49TSRcD8hdRiUrqYkM+0KW3frE+9Ej53SPdnJrDZVoO/+737Sni4ba/CtATLPIAgjaBl9hifLPY2bqKYL2lTcH0L7SPrkvux7XS/fmsjZ56unXdsGBdGW8aJsEtJDI8XoE
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(82310400011)(186009)(64100799003)(1800799012)(451199024)(36840700001)(40470700004)(46966006)(316002)(70206006)(110136005)(70586007)(54906003)(8676002)(8936002)(478600001)(6666004)(86362001)(2906002)(7416002)(36756003)(41300700001)(4326008)(5660300002)(426003)(40460700003)(47076005)(40480700001)(26005)(36860700001)(1076003)(336012)(356005)(7636003)(82740400003)(7696005)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 05:07:17.0219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a9a06d-304a-4e69-bb0a-08dc10d0d9b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5082

The existing "linux,pci-probe-only" property applies at a system level
and it is not possible to selectively convey individual host bridge's
requirement w.r.t preserving the boot configuration done by the platform
firmware to the kernel. "preserve-boot-config" addresses that concern
and can be used to preserve the boot configuration for host bridges
selectivey.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 Documentation/devicetree/bindings/pci/pci.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
index 6a8f2874a24d..0a5ff998cbe8 100644
--- a/Documentation/devicetree/bindings/pci/pci.txt
+++ b/Documentation/devicetree/bindings/pci/pci.txt
@@ -32,6 +32,10 @@ driver implementation may support the following properties:
    root port to downstream device and host bridge drivers can do programming
    which depends on CLKREQ signal existence. For example, programming root port
    not to advertise ASPM L1 Sub-States support if there is no CLKREQ signal.
+- preserve-boot-config:
+   If present this property specifies that this host bridge is already
+   configured by the platform firmware and the OS doesn't need to reconfigure
+   it again.
 
 PCI-PCI Bridge properties
 -------------------------
-- 
2.25.1


