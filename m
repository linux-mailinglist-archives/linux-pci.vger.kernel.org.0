Return-Path: <linux-pci+bounces-7254-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEA38C0366
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 19:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEFC01C21E70
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 17:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819C81E529;
	Wed,  8 May 2024 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YocjhnZd"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBC612A17D;
	Wed,  8 May 2024 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715190132; cv=fail; b=FLCqrAGDdVD2gpDJLijnrY3vwknwoRtCI9kMuZKVaMIu6unSYkvz9V86cXob8graudt9f5yKjgRHp+sqY/HMNoNlrcc5b+Ue5pQFSejpCSpQovOE7HTr/PWzY5Z+ddhh8dE0uOVLx0IphPlfYuGRV+TnWTjcQSZhm/VLk1Vd6mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715190132; c=relaxed/simple;
	bh=ADjAz42TNw1FvPi8VO9jRgSVhs/AwY8g1NJCWVhcjGU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D7En+ALZChoMDktAm+3BuR95nHHA1VPbAAcCb44zQvSKlIqjHyU4SMCzctSOzI2FsFa3ubtlFZh+Vohf2E0Q2eZg9zEH0Krkp+ZqwSTfAjcgSaVC0cn26mNsIQwgG4d5iAtsDk2OCMqT2u541ZIlKgW93XItLa84W82KWbVsGbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YocjhnZd; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyyShvuPn9D6Tb2VUyVu2pHzUQsXc3V2XrtSJUQTCz563DiMyBZUXY+50GqMBu1WGAEdEAKiQXVIxaRPbaGVQhSa6Mcombar9JJvdleJya/lj8CjyXXDDsGmvwPJrzaD060SIp7QIpVQtnGSdnsGFG1YPtPmw/uzMtBP9+nvDRq8DTak9gxY5mGkP+IyUvcI4D8nKXbR7RzQG602OVG3QMpa6OSsFTl7S7AwQoSm5BZuhHXze4HM8fiAq+t62PO/J/l9yH6Czi7TkzB71blDStP82pI9PkDn3+i4hu9tpaehjdJHg5zq5hHHxY2onLb2qawlrcF3mWidMPLTeA6YJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKJQiOLkfEh9HpwgRAIE1i5CG4HNSgWc0XmqRclezfs=;
 b=FzPvy2RgFikm3HG8EXJUYwMuSINUdQFWO0CTi0jvTyn54VuizQF68D3LrF8qRaEM8sOGa8MFJXMewxGUlTp2d9ntceOHMOUzCakBUsnQVoyuByTyR1da5QbvB3RRs2IKj2xAXpmTY8zklmgcdMMTLfSvA99y47tC8RNrvmkq55NNIqEGrjQlHXgvWtEqri/mPnq/w8pFlZexzDqjnQoX/sTzu0gzTaDM7yRJMb8XvkdXRTytRMiEkDQn8aXbV2k1tQZVtFhYNlC67bz6lYQO0CNljYmIwWrk5DDYmpQ7MOkOMiZ6Es/VChBz7amCtC6x+JjQnm/fQIjbCJIqS9r1gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKJQiOLkfEh9HpwgRAIE1i5CG4HNSgWc0XmqRclezfs=;
 b=YocjhnZd78F85usa7fvEevFhUXK4NpmAiH/YbNC2JhIIxtRjna1kNDllfioJ+HrTI1qUoZbppXrBMCPVeddNor6+QK2CaiEF6bdnAfc9elMIIxEPqgaPfXMag6Zhfa1EeJIA/TYZxC1KAvbbOaNwuU3fIlxcCCtuTtRRHVI0o3CDJ51b16nmHxjZ1SLVgf+DgfEe0J0PlkMnef3xzOM8j+KVAc8yKUExZuML2tkPjEH5/+WA03ZWmPD4DpHfSKj3zd0DY3h3jLr8xsY9orsQrxZMH9z1BUgtuT6UKDGq8ZXe2Ox2s3QFyPMci1EizaLXWU2H6bhESHRQy4j5LPggjw==
Received: from BYAPR04CA0005.namprd04.prod.outlook.com (2603:10b6:a03:40::18)
 by MW4PR12MB6681.namprd12.prod.outlook.com (2603:10b6:303:1e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Wed, 8 May
 2024 17:42:07 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:40:cafe::c8) by BYAPR04CA0005.outlook.office365.com
 (2603:10b6:a03:40::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Wed, 8 May 2024 17:42:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 17:42:06 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 May 2024
 10:41:48 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 May 2024
 10:41:47 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 8 May 2024 10:41:42 -0700
From: Vidya Sagar <vidyas@nvidia.com>
To: <bhelgaas@google.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<will@kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <frowand.list@gmail.com>
CC: <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <treding@nvidia.com>, <jonathanh@nvidia.com>,
	<kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
	<sagar.tv@gmail.com>
Subject: [PATCH V7 0/4] PCI: Add support for preserving boot configuration
Date: Wed, 8 May 2024 23:11:34 +0530
Message-ID: <20240508174138.3630283-1-vidyas@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|MW4PR12MB6681:EE_
X-MS-Office365-Filtering-Correlation-Id: 30344116-f510-45de-90d2-08dc6f862e12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|7416005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sbhMhLEAwLZsvlhH8UPOvpWz0gW0WYJGgdPZU6MOUolMPBe2GViHlTH39hFz?=
 =?us-ascii?Q?5ab2+/TO6oQxBUFNUeFzotdSUBf3K4Ai6CIaX86HEEaOsb1Ae0bCGCN3JxIm?=
 =?us-ascii?Q?tizayIGaFrgjdgZ8GuDVZuCv4BtRDUzKiSMv5miCLgW7Xrmsp3fPkQRtwVgc?=
 =?us-ascii?Q?Swa6x0XSwJw/dM9/Yc21vkCiA8mJn0u25kMtbMPqtiWJnJO6+8KWarOKi+2y?=
 =?us-ascii?Q?ibPkptbgSE7TMm2yFUYHOkHb/OjwCr20Vul3c2x15ANMZc5f//gq1hctymmp?=
 =?us-ascii?Q?pQuxdBWlV4BNht9GGDjVt+TLFuQasdnxNVLiy9ApEOuDY2XjPjT5gIhVq7TH?=
 =?us-ascii?Q?ri+p3qmJD1VXWeGtc+SDMhU96zF2RQnqa59LBV1mzmIutcD2pljMvmh9a9gf?=
 =?us-ascii?Q?BpeIBPVsYDQTGQlqUK4LCfe5nWNcxttmv7I9bRms4jjV2ADqfE50kVQXEExO?=
 =?us-ascii?Q?+ayjk3rjsgojV7mWWCO3HDJCKX7+yq+WeRPpAiZQLwog3QHLsvdu34iEI3GH?=
 =?us-ascii?Q?cBw9FnTrAzyHrw89Ucn3SB2ceXZcyklWNyJU8OwoeUK5oz5EmM+z+OGn9Rm8?=
 =?us-ascii?Q?DRkfKThxmD0/sj8wmhbPXbJIen+6qP74A8PFmGmIRYG2DEY5KaW/CuMaFR7I?=
 =?us-ascii?Q?l1d2nrQF7RCN2tuOFQMDziWSWzPFs3flJZD2lcqVtcdleDlPFWo3tRglAjvL?=
 =?us-ascii?Q?kloq1fJ3D1uHWhFMSq6l5OWW57sJPR4pVL6+lZawLvjz8zFxWuJUBoyrQ4E2?=
 =?us-ascii?Q?9+eySZ44Te6fluoIArHIv8QK+TDee26nw0Yov/d5ccSYLAMKludKBY0WFJQO?=
 =?us-ascii?Q?Xaku9NSsSamVw3QNMI8/iEno9DSZDJXnBlLaNU8PdmgwTLehJjjw3AdZZB2D?=
 =?us-ascii?Q?NcEGZYWHTM4ENz/B8MAmheYbX+Sx6JgkgYiglraKX7zGth9l3wVbWXFXwr4N?=
 =?us-ascii?Q?e+ktNKZJ8x9y0ii5cuC1o05X28vnZSevtjKhVxxQufV3ykYYUMG2cO2On6vC?=
 =?us-ascii?Q?GGqGm8sB3DXAfGBJ1YOGX2hq/9UcmLNec3+Ym3+XnT79/967GpwN+balYE+x?=
 =?us-ascii?Q?CbJ2+8zUXrgLbwZI6xhCzXGFYdx+C1fD5YDmO7mJuDRRiLrA2bqOTbMnaaZN?=
 =?us-ascii?Q?gHFMHCJ/flBf+MIjfVPobG0Zbik6i8C/jNo2fFT4K0jaubRCOz5BGU6aqQyT?=
 =?us-ascii?Q?vnc5gyHFhmcx2UV8afLOeXyL16VoCpaW46OnTlA8YKFQPy9GZno7JPIstsd8?=
 =?us-ascii?Q?s8rgpr5xz49auRhkUukH/87W59UzNiyanGA18YzBlUn7sjGcPtLKcw6rYC1I?=
 =?us-ascii?Q?cObfKBsDURn/EJxoH5reeocYMsaS83lFGqAENzRenhxkO6QdNfQ7xuK+GlmM?=
 =?us-ascii?Q?2BhCe/F6ygyIaT5tyTUEWaQIKD/Z?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(7416005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 17:42:06.8099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30344116-f510-45de-90d2-08dc6f862e12
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6681

Add support for preserving the boot configuration done by the
platform firmware per host bridge basis, based on the presence of
'linux,pci-probe-only' property in the respective PCI host bridge
device-tree node. It also unifies the ACPI and DT based boot flows
in this regard.

This patch series is a complete version of the incomplete series
( https://lore.kernel.org/linux-pci/20240421190914.374399-1-helgaas@kernel.org/ )
posted by Bjorn which in turn was an attempted split work of the single V6 patch
( https://lore.kernel.org/linux-pci/20240418174043.3750240-1-vidyas@nvidia.com/ )
posted by me.

Vidya Sagar (4):
  PCI: Move PRESERVE_BOOT_CONFIG _DSM evaluation to
    pci_register_host_bridge()
  PCI: of: Add of_pci_preserve_config() for per-host bridge support
  PCI: Unify ACPI and DT 'preserve config' support
  PCI: Use preserve_config in place of pci_flags

 drivers/acpi/pci_root.c                  | 12 ------
 drivers/pci/controller/pci-host-common.c |  4 --
 drivers/pci/of.c                         | 54 +++++++++++++++++++-----
 drivers/pci/pci-acpi.c                   | 22 ++++++++++
 drivers/pci/pci.h                        | 12 ++++++
 drivers/pci/probe.c                      | 34 ++++++++++-----
 6 files changed, 101 insertions(+), 37 deletions(-)

-- 
2.25.1


