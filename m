Return-Path: <linux-pci+bounces-1963-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9828292A4
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 04:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 031C61C25447
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 03:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA001FA6;
	Wed, 10 Jan 2024 03:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BfFipuuz"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D566107;
	Wed, 10 Jan 2024 03:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXUBfyIQbe+4iOLB89h2y/XAKcD261YLDM1f9FuUIBExjk6NnoSCc5CCHgPDBlRne/v+exFbr6jsbBoMz+IWuoLMs+tHD8s9LGYzTfetBMrciACVSkHeL4dC0cbu5cSpN7Jw+oTGVnMRmEl8Gtyd76ga8P4m3v2e8b1Jc4Dc3uDtBSfSmFEZ6eIHlJyW2xtG33Z5ey0ZCX9kBBBr1OjGjTyc6+oYBFL1VWlGsywMapjp4VYyur6aQLvBicMlZiFMrkjYmodkrCWgJ/UXZ2qR5kn5XS+ZcG+ifks4izHD52kd/UB1JgRiAlDwp6AuuGQmDlrLTDoNTIxkGGmBHCDiAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u19KeWRYDRhSU5OqNEp1NCs81098tcS51WLzinJBC+E=;
 b=PHH676Gom91YeFmhHP7DKkQ+ZPgIbZMj8mHHQ+LY7aWpYZTZXaUQD+m2eyqPM9ZBToeILiAZnJl31hrp38xv+vaSJ6WybGHcHuhzV/bVFIBTyr1GK9pFUKRFWP0p3iGII6464jRAdGOltVgngNV9QuZl3sq139Si6FA951YJqEvlEY1o1xrg4M9bWVuSA4esAImXiLRFZvKmECq6c0yVS8o4BmsZC1WadPVg1A8Bf8gbGxTiB6AFt3LHEKUKTxUdW6+HmYm95lIi7tktoY2LZnn4BwylyPnQei3UteeHmK8Td2dZ/YnM7g/pPaTDVif4uTAQVyzUv6mWhQ61iELJ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u19KeWRYDRhSU5OqNEp1NCs81098tcS51WLzinJBC+E=;
 b=BfFipuuzQSjNYwM9QuZ+8Na62Vp3Sm6KO+RaZGtPXsF21EsLT+8KaiKVy5C8CtPsqrG1gVtOOBzuv+yF7Qoly9Y1waNLaoRnyA3XkliltpljFBj/yLQQhwiG1H1kOCriM6dVv4CXLWl4OxYTiKb+MgCcWUGzSOTDAUjPI/y+yQaVkMDLCTaoX+dpRDiZNjFcUpPXjoLcRG8yrf++bSnYPutA6geL63/Usa4hmYt7zbLbV82XZ3EsfU7RqJ4UahoxQ90CdqlU3WB2XhSN1AxmiRHUTKe31dcYvLDXdfU+jUyHM6WmU0JPAH2jYanDS/AKzutsJPbmbf8OcO65CgVBxg==
Received: from CH0PR04CA0011.namprd04.prod.outlook.com (2603:10b6:610:76::16)
 by BL3PR12MB6642.namprd12.prod.outlook.com (2603:10b6:208:38e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 03:07:56 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::68) by CH0PR04CA0011.outlook.office365.com
 (2603:10b6:610:76::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Wed, 10 Jan 2024 03:07:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 03:07:56 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Jan 2024
 19:07:39 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 9 Jan 2024 19:07:39 -0800
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 9 Jan 2024 19:07:35 -0800
From: Vidya Sagar <vidyas@nvidia.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
	<bhelgaas@google.com>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <will@kernel.org>, <frowand.list@gmail.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V2 1/2] dt-bindings: Add PCIe "preserve-boot-config" property
Date: Wed, 10 Jan 2024 08:37:24 +0530
Message-ID: <20240110030725.710547-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240110030725.710547-1-vidyas@nvidia.com>
References: <20240110030725.710547-1-vidyas@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|BL3PR12MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eb49b61-23b1-40eb-6b2f-08dc11895825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9RbD36VCUWwyoyO/scX0Qa4wUsBgfGYPTpc4RSRmfZ99Mi1FGmKZ74o3PazT9x2ej9Uv3NZRdg73m6HmSOOHnrR5znuLvTUGfkZf14G9YLOfq71iebqD3Ouai4Lx7G9VovmTmFal9PCQwQzhaIgNvZG5+EJQa6Zn2hBOC8Xl/YqXCm5Fb4LMVSuQpC/ucFKV6UV6rEqdqzWkmpzShVYhL8HllCcHr9rb5AA4VhAUoxSn4200BoxQQL+HMf30q7GPAyHltTyqeG5x8wJR38zY/AJkuLJHpqD5egCCJt8hq0UGft84RW2nDlAAp5FM0EDPGl8Q46jt7e90Ht/FqF88tgupnPQCBuueZQQ1gZqInalis4n9XeDsFrfwDVvNwJQHgnsxwOiUsGHnVpOMNOGjlhjxHoKszYDjCKRk+nOlIp4Wx0V2B87lNfGmlsZS3JpKS3LbcdF3DgV1x9e5LS0r8LSoH8Nv6YFsDfByHNXs8gF63nOlgd6A7/nMIUl7ruYd8tkfMt5mQ3Wzb4veFqTpqeYctKFnmseQrESq4rwRtl52rclF4FEoHh68eaemGbFqW35xMBsWIqLf02pDMBkM4n9E8DfA9xI+LPynR+St9JBm69taHqKdeg7H/q8YmYeVacDqLSJfsTtXR8kzBz/Pl8vqNn3HAquuY9MGuDm1WdSJh/3SZUSZgp8XkdYwJKn51uI+RlGrVI/BNVC5Rd9UbJzIuTSnzwDYbjxJPvSiza+0Ws3g0fh9omxqaaCb46X6
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(36840700001)(40470700004)(46966006)(2906002)(7416002)(5660300002)(41300700001)(478600001)(7636003)(82740400003)(2616005)(426003)(1076003)(26005)(40480700001)(336012)(40460700003)(356005)(6666004)(7696005)(47076005)(36860700001)(8676002)(8936002)(4326008)(36756003)(110136005)(70586007)(54906003)(86362001)(70206006)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 03:07:56.5556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb49b61-23b1-40eb-6b2f-08dc11895825
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6642

The existing "linux,pci-probe-only" property applies at a system level
and it is not possible to selectively convey individual host bridge's
requirement w.r.t preserving the boot configuration done by the platform
firmware to the kernel. "preserve-boot-config" addresses that concern
and can be used to preserve the boot configuration for host bridges
selectivey.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* None

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


