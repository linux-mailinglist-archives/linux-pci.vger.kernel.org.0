Return-Path: <linux-pci+bounces-38702-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAB3BEF478
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 06:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15453188E983
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 04:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDCA2C0298;
	Mon, 20 Oct 2025 04:29:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022106.outbound.protection.outlook.com [52.101.126.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7FD2BDC3F;
	Mon, 20 Oct 2025 04:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760934547; cv=fail; b=GhLByKQlZXGdYvoeEOkkvEKb4pflWMTP9rfpmZ9fXs3lz08FIQHeDaGHrAxvViovP4UTUajPr3YdGqoUHyOdH2cVEkYTv7lH3Ano6ejJt6zmyAM8s6/QPKqA7Seogo4HSSiJZ0ZXKk0AfUx+t+E8zYJFOE2sCfUp6fS0afuhvQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760934547; c=relaxed/simple;
	bh=eyhL+fSPwmTe++iNb8HsTtH9385+eT8kPt1aAlgVywI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yt/vY7MlP6u4FBxrfYAZuqunFEhgSrE19XL9JigEo1t6p0/RdzZbx2oyge6opzgh2mr2m4/RVhrTycBqrL93a75YAcC20sO5YD49Z/19tFgXe6c1UelLPB2W67qvAxVkJU4OGIxcvVHsj6N7duVV9NxFoTmrWjC0VQdMv7bEKag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V22sZWbAPu2n9XZwI+cgnAJRCeqfuvBIyi4h8cCH86Gujl7B6a42iXeD0rOQbfCU0TlYvQNuNA+DIaeqfFWVHcCzestGjRGuBtnlnyt46mEes6Yroy+vGjxiQZG6imjfn6wDc7vSyTzF75nrEdmmlXhrw2Oe73OqedNGhF9sPIi3LtPG0ZJxuya9wH5+JYDQ9UsL7tOIys+tIj9blj16w9zL5gJ3GlgRU+JuZ73o1/j9MgNjDEp4TJ1Ap+bLpPnGunu1f7BsRPQOaGeA2pRSiLE3iz4pLSyU7oiZpQbqJnRkE1iY5gYkRMrnZOuszfe4rw/4fyOA4zdVY6OxbaoKSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vkhsb7CpPZoc/YIoPWpzh+eRWQpWdchuCjxg4i8yR9Y=;
 b=X2Qc8MJf+w4aocHoRCgGFeSRYCCMoNCg2kdXrIztJR7WGUefIflkYeha9GjEuvLhWEfaNHYEXsnpJJAjQpaXbNXC0DxmKNqRZ2l9zs3GVfew7czWkK3xTKBYVTwQO14glGYNbV0GdyR5CvvXhyui6TOy8//yE4FlglYB51EwaQn4ZqnliYWWsuXQi6tvRSXsVFZ/uMlcjJv+iqwKk9SZdK+nVscSsb9Q2Uw2Ye/OxVkaVrfH6L7hgs04/wlfCPo9vYA2LwfI9CSKVF0l1PACNoxHLKnee8nzj5i4R3qdjWbkackvYHOZYofqEPgDf7+kDu4xN+Hywt/8FtlXRxergQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI1PR02CA0002.apcprd02.prod.outlook.com (2603:1096:4:1f7::16)
 by PUZPR06MB5793.apcprd06.prod.outlook.com (2603:1096:301:f3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 04:29:02 +0000
Received: from SG1PEPF000082E3.apcprd02.prod.outlook.com
 (2603:1096:4:1f7:cafe::88) by SI1PR02CA0002.outlook.office365.com
 (2603:1096:4:1f7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 04:29:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E3.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 04:29:02 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 0CF3D410F608;
	Mon, 20 Oct 2025 12:28:58 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	helgaas@kernel.org,
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
Subject: [PATCH v10 08/10] MAINTAINERS: add entry for CIX Sky1 PCIe driver
Date: Mon, 20 Oct 2025 12:28:55 +0800
Message-ID: <20251020042857.706786-9-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251020042857.706786-1-hans.zhang@cixtech.com>
References: <20251020042857.706786-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E3:EE_|PUZPR06MB5793:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fe07320d-94d4-48f0-f801-08de0f913266
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hSecQjvdyY7whzgaTsABIiHC1LrRTat5a4dcMKVT/hSvGESYvnX7VCXOuEWW?=
 =?us-ascii?Q?OremX9WU5G11EEPWadaKygr9W0ZYYSLWJSljGZ+GeBpW/bMB0RPotWlt316I?=
 =?us-ascii?Q?QPWR+ey/B81MiDpaqSpNbkOgeDcH/+LASevIm+g7eRjt68SYS6H+LD2AkMAp?=
 =?us-ascii?Q?nDE/ESvaYa7myZ0e6uCqzGmLCtX3IXzuFKaiwmiBicPXsJuxEtcYwnb9XruN?=
 =?us-ascii?Q?AjFJ+F9WEIuCyDzrWE6VdkxEZtgLv8zu1YYZEvW6UU62WjUi0gux59j9BnOQ?=
 =?us-ascii?Q?fHggPra3As9uJICQLquBlQsjYd7t1Qm18vV3X6fqs1jRSvQY6gItUfGDIyp7?=
 =?us-ascii?Q?a+Fsm2fmEIwoglwOWJWqNdP6AVT/ADVLgpsf9udi3xnTxk/eqiLOSlIkIO1R?=
 =?us-ascii?Q?jhlwb7FvkToknkrihkbSYAnbjcM3TojCWEhAzOPFRBw3M884GzrmzHE5AXLq?=
 =?us-ascii?Q?edpvkGBwhshoMqIJnGuAWTXrel6dh08mJotWJ1O5JOkuMnUystABEx4H+llL?=
 =?us-ascii?Q?Ixak2ZqNHaitJ6tol5ybxFLl/ccCcrT65aLNi7dHmnW3e351HGluirS64oKI?=
 =?us-ascii?Q?+ZFMkuOAizJ2F5N3L/tuYd+1DpNMXgmj/ZZXju0uIcuH4BZpVUnPjoMyprDJ?=
 =?us-ascii?Q?ciJIy516SzaX2QiiW0PI76Ft08NWd2NcIpKPuFUlNqsZAxzl8BizYdZlSUQR?=
 =?us-ascii?Q?71T1hI9+yGoilRfZP0ey1vOqHgyyg86yHuIe+owPv0eiF136xyZXoXWfbks7?=
 =?us-ascii?Q?4xbzeqerXy+9/BgDT6gjq4rZUJ9NpyuF4KnicDZbnevvBychXcP/XfarNXcd?=
 =?us-ascii?Q?ESgRZ4GMKIkUd7XcKNEjU02wtZvP7PAyE8CUZpk8kNZkqUjqK4J2fNGoMzgT?=
 =?us-ascii?Q?W/WhgOgZLGPMHQ9zGJjVfbGPbr0zG3Mht8qOtxZksuu+uLXFtM+QeZ903g7n?=
 =?us-ascii?Q?Jt+y93HZSxCcZuZ9kZyk3OkYYYUdNDTfvMwb66v3saisvftAWiRWmPHc+2Nv?=
 =?us-ascii?Q?1XrfiHeKE/W0JMmxjEFhJK3Mx8D2jLTFQPGzCWFifjMaoCTE/0mKsIpinFx3?=
 =?us-ascii?Q?E8/f+1Py5l3RNLwxKLAzRCdYcSC1FJG126HSfM2Zm3e0DiU3i4Ym/RqWN3SB?=
 =?us-ascii?Q?iZ0i5gTd79khYNjlWUnBsoNmTNn4ViIVqDoU0DqkxHQr11Dv8uMFsm+SDRyL?=
 =?us-ascii?Q?jKWSOK8ikaIMOWCgkRxn9SlasHD4xZB9MmSDkUuNpXPhKMgBc50FkTArfl0Q?=
 =?us-ascii?Q?TuaKDnLVnL0N7vObA4gtXWTLarH7R5o5FTJc6ZECICLbIt3UJM0/FnBCkRK5?=
 =?us-ascii?Q?tgf8x2W5T6KcSScYbCAKSUhMQExif5I8ABld1cwRScbdU/wfMeMvcjbfUZKe?=
 =?us-ascii?Q?O9hVMx0WcUEL8Wu9wEXA5+Ow5gkdkPlmM1WGRgETnp+EVcxDPZW+8Nrv2jMc?=
 =?us-ascii?Q?PlbmJNc56lkQ0YFnnEvuDba00Hy2jVD8PYvc6dbJThKttBWqTktB+SOqEe3t?=
 =?us-ascii?Q?omWTAX3E0pICbb3RUu0hgd76czyv/ueYzhcouXY5u3bGqn9tqui3lVoAQW9A?=
 =?us-ascii?Q?cqOaSwL5mR+JO4Kk8i4=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 04:29:02.1641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe07320d-94d4-48f0-f801-08de0f913266
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E3.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5793

From: Hans Zhang <hans.zhang@cixtech.com>

Add myself as maintainer of Sky1 PCIe host driver

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 545a4776795e..32a2841d3b4f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19632,6 +19632,13 @@ S:	Orphan
 F:	Documentation/devicetree/bindings/pci/cdns,*
 F:	drivers/pci/controller/cadence/*cadence*
 
+PCI DRIVER FOR CIX Sky1
+M:	Hans Zhang <hans.zhang@cixtech.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/cix,sky1-pcie-*.yaml
+F:	drivers/pci/controller/cadence/*sky1*
+
 PCI DRIVER FOR FREESCALE LAYERSCAPE
 M:	Minghuan Lian <minghuan.Lian@nxp.com>
 M:	Mingkai Hu <mingkai.hu@nxp.com>
-- 
2.49.0


