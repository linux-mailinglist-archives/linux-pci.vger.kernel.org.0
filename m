Return-Path: <linux-pci+bounces-1962-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAC98292A1
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 04:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422E328908C
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 03:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7118E1FA6;
	Wed, 10 Jan 2024 03:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X+n90wPi"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F456107;
	Wed, 10 Jan 2024 03:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I52n9vFY2w1nLYISY7ukZpDlTDultrU9N8jx7zY6vSpA67ocUXSeTMzhx0/2aezCZUXboib+4UW1tnHGRNrFHPFQnVZsKbCyBhbTcO+xsCERY7LUjIn8fZLYuoiqIbQDiKBBf+YnELchIEUgWVdB40sv//eNjxXa58Op23phqAspG0azxRONhcAATkd+uzPm/KFOthydix9HeSe4NpqHzqcQuEbg0k5AURG9XSw4BZYj5Qic80sb1tDrGr0HrD3uaYj0FkIJi3e2IUeM5BAsrBHrRultvpyo9fWWByhLAHA5IqrTKiz8NIENUdmrGy4uKgIGwTinJxMYHS9WZvJHaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YemQ/+hHIzt9VIbsAiazc1kPHx6Gwab+tXjpgpLAl4=;
 b=T+ADdqR9LJ2jr2rkHnzEStHR+9kszo9QZ2ywcXgIMrSyCN6OE6cFMIEime4Tm8YxAN3v3N5R7qeuc3V/KrfRMC3BDVpnS/aPz8fBZGsNTici56ctzkNXv20cKjC63wk7kgKLoYTgSC6ZI5gIknBC2wvVpauYrZ/g+S7Bw8sYqUt4abRW1L4Qjrr8h1bxwSvaDIhzYPhDE3Q1fMO33iyi0+HbXSvVEDLSNp0d/NhFBOZr7Cyxze/poK1DiXi9khN2rZO47Q7V1gUT1ZIfQSFiygrPLJLkoTaUfGRP9ZeO1EDRVVRW4xaW9v3SuuR1+IEgHx4BbWzt4GozwRuap8rONA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YemQ/+hHIzt9VIbsAiazc1kPHx6Gwab+tXjpgpLAl4=;
 b=X+n90wPiOyNKflT2VzHECjSrOV8XwaELCgJXk2HGWY//H/JsgvkYwpKzQIai0UaQDNNuIXW0jAbXs3cGswfq8fH/po0d+1XfauH2wQwHCDtlJqx7OaxsBhD2f4/nJi6aKn5g9C4aXVI54QLd+pNTDiF0gCoIaBHjhjXIuPbQYjDNJdpWpiNTA97/zNXhfEZqVmvWdl4aWVgaH9+KxJgdfcbrI4t1djOowXMxb5382pa2FQAv83yb0My/b3x0TeRgs3bfKZL1I7hX7E0CoxIgtGCym6m2GS4M0NcmWIrIjPbWxBijpfwgOr/w6rw3IgqifbbD6q1Zz9IjO+qKDk+wfw==
Received: from DM6PR04CA0013.namprd04.prod.outlook.com (2603:10b6:5:334::18)
 by DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 03:07:46 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:5:334:cafe::e4) by DM6PR04CA0013.outlook.office365.com
 (2603:10b6:5:334::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Wed, 10 Jan 2024 03:07:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 03:07:46 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Jan 2024
 19:07:33 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 9 Jan 2024 19:07:32 -0800
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 9 Jan 2024 19:07:28 -0800
From: Vidya Sagar <vidyas@nvidia.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
	<bhelgaas@google.com>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <will@kernel.org>, <frowand.list@gmail.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V2 0/2] Add support to preserve boot config in the DT flow
Date: Wed, 10 Jan 2024 08:37:23 +0530
Message-ID: <20240110030725.710547-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|DM4PR12MB5149:EE_
X-MS-Office365-Filtering-Correlation-Id: e1196278-e039-4c89-ca9d-08dc1189521a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W96fggc0fakjyuX9wRLCH9JxEmBu5i0El+tGjEohuxfoPhzk7Qw2BsZJK1N2lQFEuNaaraeFhOOOBTDsBBpNJHx8KdqKH1qbgFpzjZnmr5cGhP7saoDHWWRJPKRji5Y88aNBUBaQXa7RZrDLZptrso/A7XpNnxH1du1IF7U1EgM4X5mG9NuhiLeN0VmPlOEIJnS+qBAjThP6C/GTfFfqWzJqCHEGOFhn1zdWf1Equ2s3zYZEmFshHR1dOwVztr6bsSfFA18UDheqLi2tkwJl2RPWIKaevyPYUSZgrtGhH5xiZvIs3AhHz1aDTS28IBEXPWn9dcw1+1RDfdgYUG7JRhh/S4IndvZhJSNfKgJaX4IBLi0YYH/s73coBbf0YKVqcof/Y6zDbwuyclhS4GOqJ7qT0Fh16SqgwxqrtlVV8CnKJQFEjygVET2zY8mqbAhiKrKJbjPIO2YD8rDlXCJaSPoVjBsO1/TFl60W6IJruyIkhV48K2vwR6QssSKabopLOLUWFQpfwhEoZ1NGF0NwGXFXZ9K+VN5OPgt1gA/DZQmNhtG3muum5BrLKvZiCZqKJpExX5cn3nBoJHI5MEcN9UZ0mVbf81bku3lEYqpZNaIOQqHVQyDiQAcgCrqZIvrGfHDiqwhA7lBPOl/weg72b7uGkI+S3H7JqQzYFC0yfqxFw7msNZOQhbz+OmO41e09DAUN3Q6n2bAwoGqfrIOTW9JZ8qBIH3vSbl6/ZSO7ywlCdlVTbgNX5zwFBC5mgh9s
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(186009)(82310400011)(451199024)(1800799012)(64100799003)(46966006)(40470700004)(36840700001)(316002)(54906003)(336012)(426003)(110136005)(36860700001)(8936002)(8676002)(47076005)(36756003)(6666004)(7696005)(83380400001)(40460700003)(4326008)(40480700001)(70206006)(70586007)(26005)(2616005)(1076003)(478600001)(7416002)(4744005)(2906002)(5660300002)(82740400003)(41300700001)(86362001)(7636003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 03:07:46.4040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1196278-e039-4c89-ca9d-08dc1189521a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5149

Add support to preserve the boot configuration of the PCIe bridges per
host bridge basis based on the presence of the DT flag "preserve-boot-config"
in the respective host bridge node. The existing "linux,pci-probe-only" works
at a system level and can't be used at a single host bridge granularity.
Also, the support for preserving the boot configuration per host bridge basis
is already present for the ACPI based boot flow and this patch series extends
that support for the DT based boot flow.

V2:
* Addressed issues reported by kernel test robot <lkp@intel.com>

Vidya Sagar (2):
  dt-bindings: Add PCIe "preserve-boot-config" property
  PCI: Add support for "preserve-boot-config" property

 Documentation/devicetree/bindings/pci/pci.txt |  4 ++++
 drivers/pci/controller/pci-host-common.c      |  5 ++++-
 drivers/pci/of.c                              | 18 ++++++++++++++++++
 drivers/pci/probe.c                           |  2 +-
 include/linux/of_pci.h                        |  6 ++++++
 5 files changed, 33 insertions(+), 2 deletions(-)

-- 
2.25.1


